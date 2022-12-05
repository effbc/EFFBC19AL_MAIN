codeunit 60011 "MaterialIssueOrde-Post Receipt"
{
    // version MI1.0,DIM1.0

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // Rev01   : B2B Revisions to resolve the issues of Efftronics 2013 Database
    // UPGREV2.0: Code changed in Function CommaRemoval and commented in following functions Issues_Post, OnRun, Issues_Post_Auto_Scheduled.
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13             -> Added New Code Into the On Run() Trigger While Posting The Material
    //                                                                 Issue The Dimension Set ID Should carry to The Posted Material Issue
    //                                                              -> Code Commented into the on Run () Trigger For Dimesion Management Does not Exists
    //                                                                 Function called MoveOneDocDimToPostedDocDim().

    Permissions = TableData "Item Ledger Entry" = rm,
                  TableData "Item Entry Relation" = rm;
    TableNo = "Material Issues Header";

    trigger OnRun();
    var
        Item: Record Item;
        SourceCodeSetup: Record "Source Code Setup";
        InvtSetup: Record "Inventory Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemApplnEntry: Record "Item Application Entry";
        ItemReg: Record "Item Register";
        GenPostingSetup: Record "General Posting Setup";
        NoSeriesMgt: Codeunit 396;
        UpdateAnalysisView: Codeunit "Update Analysis View";
        LineCount: Integer;
        Window: Dialog;
        //ThirdPartyInvoice: Record "Third Party Invoices";
        PostedMaterialIssueLine2: Record "Posted Material Issues Line";
        LineNo: Integer;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        FileDirectory: Text;
        filname: Text;
        username: Text;
        RequistionNo: Text[50];
    begin
        //Deleted Local Var (TempJnlLineDimRecordTable356,TempJnlLineDim2RecordTable356), Global var (DocDimRecordTable357,TempDocDimRecordTable357),(TempJnlLineDim2RecordTable356)


        /*IF ("Transfer-from Code"<>'R&D STR') AND ("Transfer-from Code"<>'CS STR') AND ("Transfer-from Code"<>'SITE') AND
           ("Transfer-from Code"<>'H-OFF')THEN
        ERROR('Posting is Not Allowed');
        */
        IF NOT (USERID IN ['EFFTRONICS\NAGANAVEEN', 'EFFTRONICS\NVVRAO', 'EFFTRONICS\SUDHAKARREDDY', 'EFFTRONICS\RABBANI', 'EFFTRONICS\MADHAVIP', 'EFFTRONICS\HARIK', 'EFFTRONICS\BHARGAV',
                      'EFFTRONICS\TIRUPATAIAH', 'EFFTRONICS\VARAPRASAD', 'EFFTRONICS\PRAVEENA', 'EFFTRONICS\TNMRAO', 'EFFTRONICS\BHASKAR', 'EFFTRONICS\SRIKANTH', 'EFFTRONICS\SURESHPNV', 'EFFTRONICS\PRADEEPS']) THEN BEGIN
            IF ((Rec."Transfer-from Code" = 'OLD STOCK') AND (Rec."Transfer-to Code" = 'SITE')) OR ((Rec."Transfer-from Code" = 'SITE') AND (Rec."Transfer-to Code" = 'OLD STOCK')) THEN
                ERROR('U Dont have permissions');
        END;
        RequistionNo := Rec."No.";
        IF NOT ((Rec."Transfer-to Code" = 'SITE') AND (Rec."Transfer-from Code" <> 'CS')) THEN BEGIN
            /*
             FileDirectory := '\\erpserver\ErpAttachments\Store Prints\';
             filname:="No."+ '.pdf';
             Rec.SETRANGE("No.","No.");
             REPORT.RUN(50010,FALSE,FALSE,Rec);
             REPORT.SAVEASPDF(50010,FileDirectory+filname,Rec);

             USER.RESET;
                  USER.SETRANGE(USER."User Name",USERID);
                  IF USER.FINDFIRST THEN
                    username:= USER."Full Name";

            */
        END;
        //added on 26-FEB-2018 to restrict site material postings

        IF NOT (USERID IN ['EFFTRONICS\RAMADEVI', 'EFFTRONICS\BHAVANIP', 'EFFTRONICS\SRIVALLI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\MPUJITHA', 'EFFTRONICS\SUVARCHALADEVI']) THEN BEGIN
            IF ((Rec."Transfer-from Code" = 'SITE') AND (Rec."Transfer-to Code" = 'CS')) OR ((Rec."Transfer-from Code" = 'CS') AND (Rec."Transfer-to Code" = 'SITE')) THEN
                ERROR('You Dont have permissions to post SITE Materials');
        END;


        GL.GET;
        IF (GL."Restrict Store Material Issues") THEN
            //IF "Transfer-from Code"='STR' THEN
            ERROR('STR Material Requests will not Post until completion of "Product wise Issues"');

        IF Rec."Transfer-to Code" = 'CS' THEN
            Rec.TESTFIELD("Shortcut Dimension 2 Code");

        Rec.TESTFIELD(Status, Rec.Status::Released);
        IF Rec."Prod. Order No." = '' THEN
            Rec.TESTFIELD("Reason Code");
        IF BulkPosting = FALSE THEN BEGIN
            IF NOT CONFIRM(Text009, FALSE, Rec."No.") THEN
                EXIT;
        END;

        IF MaterialIssueHeader."Posting Date" < MaterialIssueHeader."Released Date" THEN
            ERROR('Posting Date is Less than Released Date');

        MaterialIssueHeader := Rec;
        MaterialIssueHeader.SetHideValidationDialog(HideValidationDialog);

        MaterialIssueHeader.TESTFIELD("Transfer-from Code");
        MaterialIssueHeader.TESTFIELD("Transfer-to Code");
        IF (MaterialIssueHeader."Transfer-from Code" <> '') AND
           (MaterialIssueHeader."Transfer-from Code" = MaterialIssueHeader."Transfer-to Code")
        THEN
            ERROR
              (Text000,
              Rec."No.", Rec.FIELDCAPTION("Transfer-from Code"), MaterialIssueHeader.FIELDCAPTION("Transfer-to Code"));
        MaterialIssueHeader.TESTFIELD(Status, MaterialIssueHeader.Status::Released);
        MaterialIssueHeader.TESTFIELD("Posting Date");

        MaterialIssueLine.RESET;
        MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        MaterialIssueLine.SETFILTER(Quantity, '<>0');
        MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
        IF NOT MaterialIssueLine.FINDFIRST THEN BEGIN
            ERROR(Text001);
        END ELSE BEGIN
            TrackingSpecification.RESET;
            TrackingSpecification.SETRANGE(TrackingSpecification."Order No.", Rec."No.");
            IF NOT TrackingSpecification.FINDSET THEN
                ERROR(Text001);
        END;


        IF (FORMAT(MaterialIssueHeader."BOM Type") IN ['Mechanical', 'Wiring', 'Testing', 'Packing']) THEN BEGIN
            MaterialIssueLine.RESET;
            MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
            MaterialIssueLine.SETFILTER(Quantity, '<>0');
            MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
            IF MaterialIssueLine.FINDFIRST THEN
                REPEAT
                    TrackingSpecification.RESET;
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order No.", MaterialIssueLine."Document No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order Line No.", MaterialIssueLine."Line No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Item No.", MaterialIssueLine."Item No.");
                    IF TrackingSpecification.FINDSET THEN
                        REPEAT
                            "Mech&Wiring_Items".RESET;
                            "Mech&Wiring_Items".SETRANGE("Production Order No.", TrackingSpecification."Prod. Order No.");
                            "Mech&Wiring_Items".SETRANGE("Production Order Line No.", TrackingSpecification."Prod. Order Line No.");
                            "Mech&Wiring_Items".SETRANGE("Item No.", TrackingSpecification."Item No.");
                            "Mech&Wiring_Items".SETRANGE("Lot No.", TrackingSpecification."Lot No.");
                            "Mech&Wiring_Items".SETFILTER("Mech&Wiring_Items"."BOM Type", FORMAT(MaterialIssueHeader."BOM Type"));
                            IF NOT "Mech&Wiring_Items".FINDFIRST THEN BEGIN
                                "Mech&Wiring_Items".INIT;
                                "Mech&Wiring_Items"."Production Order No." := TrackingSpecification."Prod. Order No.";
                                "Mech&Wiring_Items"."Production Order Line No." := TrackingSpecification."Prod. Order Line No.";
                                "Mech&Wiring_Items"."Item No." := TrackingSpecification."Item No.";
                                "Mech&Wiring_Items".Description := TrackingSpecification.Description;
                                "Mech&Wiring_Items"."Lot No." := TrackingSpecification."Lot No.";
                                "Mech&Wiring_Items".Quantity := TrackingSpecification.Quantity;
                                "Mech&Wiring_Items"."BOM Type" := FORMAT(MaterialIssueHeader."BOM Type");
                                "Mech&Wiring_Items"."Request No." := MaterialIssueHeader."No.";
                                "Mech&Wiring_Items".INSERT;
                            END ELSE BEGIN
                                "Mech&Wiring_Items".Quantity += TrackingSpecification.Quantity;
                                "Mech&Wiring_Items".MODIFY;
                            END;

                        UNTIL TrackingSpecification.NEXT = 0;
                UNTIL MaterialIssueLine.NEXT = 0;
        END;
        CopyAndCheckDocDimToTempDocDim;

        Window.OPEN(
          '#1#################################\\' +
          Text003);

        Window.UPDATE(1, STRSUBSTNO(Text004, MaterialIssueHeader."No."));

        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup.Transfer;
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Posted Material Issue Nos.");
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-from Code");
        InventoryPostingSetup.FINDFIRST;
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-to Code");
        InventoryPostingSetup.FINDFIRST;

        //UPGREV2.0>>
        /*
        IF RECORDLEVELLOCKING THEN BEGIN
          NoSeriesLine.LOCKTABLE;
          IF NoSeriesLine.FINDLAST THEN;
          IF InvtSetup."Automatic Cost Posting" THEN  BEGIN
            GLEntry.LOCKTABLE;
            IF GLEntry.FINDLAST THEN;
          END;
        END;
        */
        //UPGREV2.0>>
        // Insert receipt header
        PostedMaterialIssueHeader.LOCKTABLE;
        PostedMaterialIssueHeader.INIT;
        PostedMaterialIssueHeader."Auto Post" := MaterialIssueHeader."Auto Post";
        PostedMaterialIssueHeader."Issued DateTime" := CURRENTDATETIME;//B2B1.0
        PostedMaterialIssueHeader."Transfer-from Code" := MaterialIssueHeader."Transfer-from Code";
        PostedMaterialIssueHeader."Transfer-from Name" := MaterialIssueHeader."Transfer-from Name";
        PostedMaterialIssueHeader."Transfer-from Name 2" := MaterialIssueHeader."Transfer-from Name 2";
        PostedMaterialIssueHeader."Transfer-from Address" := MaterialIssueHeader."Transfer-from Address";
        PostedMaterialIssueHeader."Transfer-from Address 2" := MaterialIssueHeader."Transfer-from Address 2";
        PostedMaterialIssueHeader."Transfer-from Post Code" := MaterialIssueHeader."Transfer-from Post Code";
        PostedMaterialIssueHeader."Transfer-from City" := MaterialIssueHeader."Transfer-from City";
        PostedMaterialIssueHeader."Transfer-from County" := MaterialIssueHeader."Transfer-from County";
        PostedMaterialIssueHeader."Transfer-from Country Code" := MaterialIssueHeader."Transfer-from Country Code";
        PostedMaterialIssueHeader."Transfer-from Contact" := MaterialIssueHeader."Transfer-from Contact";
        PostedMaterialIssueHeader."Transfer-to Code" := MaterialIssueHeader."Transfer-to Code";
        PostedMaterialIssueHeader."Transfer-to Name" := MaterialIssueHeader."Transfer-to Name";
        PostedMaterialIssueHeader."Transfer-to Name 2" := MaterialIssueHeader."Transfer-to Name 2";
        PostedMaterialIssueHeader."Transfer-to Address" := MaterialIssueHeader."Transfer-to Address";
        PostedMaterialIssueHeader."Transfer-to Address 2" := MaterialIssueHeader."Transfer-to Address 2";
        PostedMaterialIssueHeader."Transfer-to Post Code" := MaterialIssueHeader."Transfer-to Post Code";
        PostedMaterialIssueHeader."Transfer-to City" := MaterialIssueHeader."Transfer-to City";
        PostedMaterialIssueHeader."Transfer-to County" := MaterialIssueHeader."Transfer-to County";
        PostedMaterialIssueHeader."Transfer-to Country Code" := MaterialIssueHeader."Transfer-to Country Code";
        PostedMaterialIssueHeader."Transfer-to Contact" := MaterialIssueHeader."Transfer-to Contact";
        PostedMaterialIssueHeader."Posting Date" := MaterialIssueHeader."Posting Date";
        PostedMaterialIssueHeader."Receipt Date" := MaterialIssueHeader."Receipt Date";
        PostedMaterialIssueHeader."Posted By" := USERID;
        PostedMaterialIssueHeader."Shortcut Dimension 1 Code" := MaterialIssueHeader."Shortcut Dimension 1 Code";
        PostedMaterialIssueHeader."Shortcut Dimension 2 Code" := MaterialIssueHeader."Shortcut Dimension 2 Code";
        //DIM1.0
        PostedMaterialIssueHeader."Dimension Set ID" := MaterialIssueHeader."Dimension Set ID";
        //DIM1.0
        PostedMaterialIssueHeader."Material Issue No." := MaterialIssueHeader."No.";
        PostedMaterialIssueHeader."External Document No." := MaterialIssueHeader."External Document No.";
        PostedMaterialIssueHeader."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
        PostedMaterialIssueHeader."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
        PostedMaterialIssueHeader."Prod. BOM No." := MaterialIssueHeader."Prod. BOM No.";
        PostedMaterialIssueHeader."Sales Order No." := MaterialIssueHeader."Sales Order No.";
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Resource Name" := MaterialIssueHeader."Resource Name";
        PostedMaterialIssueHeader."User ID" := MaterialIssueHeader."User ID";
        PostedMaterialIssueHeader."Required Date" := MaterialIssueHeader."Required Date";
        PostedMaterialIssueHeader."Released Date" := MaterialIssueHeader."Released Date";
        PostedMaterialIssueHeader."Released Time" := MaterialIssueHeader."Released Time";
        PostedMaterialIssueHeader."Released By" := MaterialIssueHeader."Released By";
        PostedMaterialIssueHeader."Reason Code" := MaterialIssueHeader."Reason Code";
        PostedMaterialIssueHeader.Remarks := MaterialIssueHeader.Remarks;
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Service Item" := MaterialIssueHeader."Service Item";
        PostedMaterialIssueHeader."Service Item Serial No." := MaterialIssueHeader."Service Item Serial No.";
        PostedMaterialIssueHeader."Service Item Description" := MaterialIssueHeader."Service Item Description";
        PostedMaterialIssueHeader."No. Series" := InvtSetup."Posted Transfer Rcpt. Nos.";
        PostedMaterialIssueHeader."No." :=
            NoSeriesMgt.GetNextNo(
              InvtSetup."Posted Material Issue Nos.", MaterialIssueHeader."Posting Date", TRUE);
        // pranavi
        PMI_No := PostedMaterialIssueHeader."No.";
        ToCode := PostedMaterialIssueHeader."Transfer-to Code";
        FromCode := PostedMaterialIssueHeader."Transfer-from Code";
        //pranavi
        PostedMaterialIssueHeader."Transaction ID" := MaterialIssueHeader."Transaction ID";
        PostedMaterialIssueHeader."Customer No" := MaterialIssueHeader."Customer No"; // Added by Pranavi on 27-Jan-2016 for LED Cards process
        PostedMaterialIssueHeader.INSERT;

        //DIM1.0 Start Since Function doesn't exist in Nav 2013
        //Code Commented
        /*
        DimMgt.MoveOneDocDimToPostedDocDim(
          TempDocDim,DATABASE::"Material Issues Header",TempDocDim."Document Type"::"","No.",0,
          DATABASE::"Posted Material Issues Header",PostedMaterialIssueHeader."No.");
        */
        //DIM1.0 End
        CopyCommentLines(4, 5, MaterialIssueHeader."No.", PostedMaterialIssueHeader."No.");

        // Insert receipt lines
        LineCount := 0;
        PostedMaterialIssueLine.LOCKTABLE;
        //MaterialIssueLine.SETRANGE("Document No.","No.");
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF MaterialIssueLine.FINDSET THEN BEGIN
            REPEAT
                TrackingSpecification.RESET;//Added by vijaya on 24-01-2018
                TrackingSpecification.SETRANGE("Order No.", MaterialIssueLine."Document No.");
                TrackingSpecification.SETRANGE("Order Line No.", MaterialIssueLine."Line No.");
                IF TrackingSpecification.FINDSET THEN BEGIN
                    LineCount := LineCount + 1;
                    Window.UPDATE(2, LineCount);
                    IF MaterialIssueLine."Item No." <> '' THEN BEGIN
                        Item.GET(MaterialIssueLine."Item No.");
                        // Condition added by Pranavi on 12-Jan-2016 for allowing blocked items if transfer is b/w CS and SITE
                        IF NOT (((MaterialIssueLine."Transfer-from Code" = 'SITE') AND (MaterialIssueLine."Transfer-to Code" = 'CS')) OR
                            ((MaterialIssueLine."Transfer-from Code" = 'CS') AND (MaterialIssueLine."Transfer-to Code" = 'SITE'))) THEN
                            Item.TESTFIELD(Blocked, FALSE);
                    END;
                    PostedMaterialIssueLine.INIT;
                    PostedMaterialIssueLine."Document No." := PostedMaterialIssueHeader."No.";
                    PostedMaterialIssueLine2.SETRANGE("Document No.", PostedMaterialIssueHeader."No.");
                    IF PostedMaterialIssueLine2.FINDLAST THEN
                        LineNo := PostedMaterialIssueLine2."Line No." + 10000
                    ELSE
                        LineNo := 10000;
                    PostedMaterialIssueLine."Line No." := LineNo;
                    PostedMaterialIssueLine."Item No." := MaterialIssueLine."Item No.";
                    // PostedMaterialIssueLine."Unit Cost":=MaterialIssueLine."Unit Cost";
                    PostedMaterialIssueLine.Description := MaterialIssueLine.Description;
                    PostedMaterialIssueLine.Quantity := MaterialIssueLine."Qty. to Receive";
                    PostedMaterialIssueLine."Unit of Measure" := MaterialIssueLine."Unit of Measure";
                    PostedMaterialIssueLine."Shortcut Dimension 1 Code" := MaterialIssueLine."Shortcut Dimension 1 Code";
                    PostedMaterialIssueLine."Shortcut Dimension 2 Code" := MaterialIssueLine."Shortcut Dimension 2 Code";
                    //DIM1.0
                    PostedMaterialIssueLine."Dimension Set ID" := MaterialIssueLine."Dimension Set ID";
                    //DIM1.0
                    PostedMaterialIssueLine."Quantity (Base)" := MaterialIssueLine."Qty. to Receive (Base)";
                    PostedMaterialIssueLine."Qty. per Unit of Measure" := MaterialIssueLine."Qty. per Unit of Measure";
                    PostedMaterialIssueLine."Unit of Measure Code" := MaterialIssueLine."Unit of Measure Code";
                    PostedMaterialIssueLine."Gross Weight" := MaterialIssueLine."Gross Weight";
                    PostedMaterialIssueLine."Net Weight" := MaterialIssueLine."Net Weight";
                    PostedMaterialIssueLine."Unit Volume" := MaterialIssueLine."Unit Volume";
                    PostedMaterialIssueLine."Variant Code" := MaterialIssueLine."Variant Code";
                    PostedMaterialIssueLine."Units per Parcel" := MaterialIssueLine."Units per Parcel";
                    PostedMaterialIssueLine.Station := MaterialIssueLine.Station;
                    PostedMaterialIssueLine."Station Name" := MaterialIssueLine."Station Name";
                    PostedMaterialIssueLine."Description 2" := MaterialIssueLine."Description 2";
                    PostedMaterialIssueLine."Material Issue No." := MaterialIssueLine."Document No.";
                    PostedMaterialIssueLine."Material Issue Line No." := MaterialIssueLine."Line No.";
                    PostedMaterialIssueLine."Receipt Date" := MaterialIssueLine."Receipt Date";
                    PostedMaterialIssueLine."Transfer-from Code" := MaterialIssueLine."Transfer-from Code";
                    PostedMaterialIssueLine."Transfer-to Code" := MaterialIssueLine."Transfer-to Code";
                    PostedMaterialIssueLine."Item Category Code" := MaterialIssueLine."Item Category Code";
                    PostedMaterialIssueLine."Product Group Code" := MaterialIssueLine."Product Group Code";
                    PostedMaterialIssueLine."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
                    PostedMaterialIssueLine."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
                    PostedMaterialIssueLine.Saleorderno := MaterialIssueHeader."Sales Order No.";
                    PostedMaterialIssueLine."Prod. Order Comp. Line No." := MaterialIssueLine."Prod. Order Comp. Line No.";//b2bsbk
                    PostedMaterialIssueLine."Issued DateTime" := PostedMaterialIssueHeader."Issued DateTime";
                    PostedMaterialIssueLine."Production BOM No." := MaterialIssueLine."Production BOM No.";
                    PostedMaterialIssueLine."Unit Cost" := MaterialIssueLine."Unit Cost";
                    PostedMaterialIssueLine."Avg. unit cost" := MaterialIssueLine."Avg. unit cost";
                    PostedMaterialIssueLine.Remarks := MaterialIssueLine.Remarks;
                    PostedMaterialIssueLine."Non-Returnable" := MaterialIssueLine."Non-Returnable";
                    /*
                    //added by pranavi on 09-05-2015
                    IF "Transfer-to Code"='PROD' THEN
                    BEGIN
                      PostedMaterialIssueLine."Operation No.":=MaterialIssueLine."Operation No.";
                      PostedMaterialIssueLine.Dept:=MaterialIssueLine.Dept;
                      PostedMaterialIssueLine."Material Requisition Date":=TODAY;
                    END;
                    //end by pranavi
                    */
                    IF MaterialIssueLine."Item No." = 'ECICSDI00427' THEN
                        PostedMaterialIssueLine."Monitor Problem" := MaterialIssueLine."Monitor Problem";
                    /* IF (MaterialIssueHeader."Transfer-to Code" = 'STR') AND
                        ((MaterialIssueHeader."Transfer-from Code"<>'R&D STR') OR (MaterialIssueHeader."Transfer-from Code"<>'CS STR')) THEN
                     BEGIN
                       Mail_Subject:='Return materials';
                       Mail_Body:='Material is Returned Correposnding to '+MaterialIssueHeader."No.";
                       "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                       IF "Mail-Id".FINDFIRST THEN
                          "from Mail":="Mail-Id".MailID;
                       "to mail":='dmadhavi@efftronics.com,mary@efftronics.com';
                     END;     */
                    PostedMaterialIssueLine.INSERT;

                    IF MaterialIssueLine."Qty. to Receive" > 0 THEN BEGIN
                        MaterialIssueLine.VALIDATE("Quantity Received",
                                  MaterialIssueLine."Quantity Received" + MaterialIssueLine."Qty. to Receive");

                        MaterialIssueLine.VALIDATE("Qty. to Receive",
                                  (MaterialIssueLine.Quantity - MaterialIssueLine."Quantity Received"));
                        OriginalQuantity := MaterialIssueLine."Qty. to Receive";
                        OriginalQuantityBase := MaterialIssueLine."Qty. to Receive (Base)";
                        //Rev01 Start
                        //Code Commented
                        /*
                        PostItemJnlLine(MaterialIssueLine,PostedMaterialIssueHeader,PostedMaterialIssueLine);
                        */
                        PostItemJnlLine2013(MaterialIssueLine, PostedMaterialIssueHeader, PostedMaterialIssueLine);
                        //Rev01 End
                        PostedMaterialIssueLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(PostedMaterialIssueLine);
                        PostedMaterialIssueLine.MODIFY;
                        MaterialIssueLine.MODIFY;
                    END;
                    DataDumptoPicking(PostedMaterialIssueLine, PostedMaterialIssueHeader);
                    //DIM1.0 Start Since Function doesn't exist in Nav 2013
                    /*
                    DimMgt.MoveOneDocDimToPostedDocDim(
                      DocDim,DATABASE::"Material Issues Line",DocDim."Document Type"::" ","No.",MaterialIssueLine."Line No.",
                      DATABASE::"Posted Material Issues Line",PostedMaterialIssueLine."Document No.");
                    */
                    //DIM1.0 End
                    //Delete Tracking Specification
                    TrackingSpecification.RESET;//anil added in 21-oct-10
                    TrackingSpecification.SETRANGE("Order No.", MaterialIssueLine."Document No.");
                    TrackingSpecification.SETRANGE("Order Line No.", MaterialIssueLine."Line No.");
                    IF TrackingSpecification.FINDSET THEN
                        REPEAT
                            TrackingSpecification.DELETE;
                        UNTIL TrackingSpecification.NEXT = 0;
                END;
            UNTIL MaterialIssueLine.NEXT = 0;

        END;
        // Code For Mail Sending
        /*   IF ( "from Mail"<>'') AND ("to mail" <>'')  THEN
           BEGIN
            // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
             SMTP_MAIL.CreateMessage('ERP',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
             SMTP_MAIL.Send;
           END;  */


        TempItemJnlLine.SETRANGE("Entry Type", TempItemJnlLine."Entry Type"::Transfer);
        TempItemJnlLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        IF TempItemJnlLine.FINDSET THEN
            REPEAT
                //      ItemJnlPostLine.RunWithCheck(TempItemJnlLine,TempJnlLineDim2);
                ItemJnlPostLine.RunWithCheck(TempItemJnlLine);//B2B
            UNTIL TempItemJnlLine.NEXT = 0;
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETRANGE("Qty. to Receive");
        HeaderDeleted := MaterialIssueHeader.DeleteOrder(MaterialIssueHeader, MaterialIssueLine);


        UpdateAnalysisView.UpdateAll(0, TRUE);
        Rec := MaterialIssueHeader;

        // >> Pranavi
        //PostedMaterialIssuesHeader.SETRANGE("No.","No.");
        IF (PMI_No <> '') AND (ToCode = 'SITE') AND (FromCode <> 'CS') THEN BEGIN
            COMMIT;
            PMIGRec.RESET;
            PMIGRec.SETRANGE("No.", PMI_No);
            IF PMIGRec.FINDFIRST THEN
                //IF PMIGRec.GET(PMI_No) THEN
                REPORT.RUN(50053, TRUE, FALSE, PMIGRec);

            /*
             FileDirectory := '\\erpserver\ErpAttachments\Store Prints\';
             filname:=+ '.pdf';
             Rec.SETRANGE("No.","No.");
             REPORT.RUN(50053,FALSE,FALSE,PMIGRec);
             REPORT.SAVEASPDF(50053,FileDirectory+filname,PMIGRec);*/

            //MatReqPage.Set_Posted_PMI_No(PostedMaterialIssueHeader."No.");
            // << Pranavi
        END;

    end;

    var
        Text000: Label 'Transfer order %2 cannot be posted because %3 and %4 are the same.';
        Text001: Label 'There is nothing to post.';
        Text002: TextConst ENU = 'Warehouse handling is required for Transfer order = %1, %2 = %3.';
        Text003: Label 'Posting transfer lines     #2######';
        Text004: Label 'Transfer Order %1';
        Text005: Label 'The combination of dimensions used in transfer order %1 is blocked. %2';
        Text006: Label 'The combination of dimensions used in transfer order %1, line no. %2 is blocked. %3';
        Text007: Label 'The dimensions used in transfer order %1, line no. %2 are invalid. %3';
        Text008: Label 'Base Qty. to Receive must be 0.';
        PostedMaterialIssueHeader: Record "Posted Material Issues Header";
        PostedMaterialIssueLine: Record "Posted Material Issues Line";
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        ItemJnlLine: Record "Item Journal Line";
        Location: Record Location;
        NewLocation: Record Location;
        TempItemEntryRelation2: Record "Item Entry Relation" temporary;
        NoSeriesLine: Record "No. Series Line";
        GLEntry: Record "G/L Entry";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        DimMgt: Codeunit DimensionManagement;
        InvtAdjmt: Codeunit "Inventory Adjustment";
        SourceCode: Code[10];
        HideValidationDialog: Boolean;
        OriginalQuantity: Decimal;
        OriginalQuantityBase: Decimal;
        TempItemJnlLine: Record "Item Journal Line";
        GenJnlLine: Record "Gen. Journal Line";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        TempItemJnlLine1: Record "Item Journal Line";
        HeaderDeleted: Boolean;
        // mail: Codeunit 397;
        "Mail-Id": Record User;
        "from Mail": Text[50];
        "to mail": Text[250];
        Mail_Subject: Text[250];
        Mail_Body: Text[250];
        Window: Dialog;
        SourceCodeSetup: Record "Source Code Setup";
        InvtSetup: Record "Inventory Setup";
        InventoryPostingSetup: Record "Inventory Posting Setup";
        NoSeriesMgt: Codeunit 396;
        LineCount: Integer;
        Item: Record Item;
        PostedMaterialIssueLine2: Record "Posted Material Issues Line";
        LineNo: Integer;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        UpdateAnalysisView: Codeunit "Update Analysis View";
        Text13700: Label 'Transfer - %1';
        Text009: Label 'Do you want to Post the Material Issue %1?';
        // SMTP_MAIL: Codeunit "SMTP Mail";
        GL: Record "General Ledger Setup";
        "Mech&Wiring_Items": Record "Mech & Wirning Items";
        "-Rev01-": Integer;
        MatIssueTrackSpecGRec: Record "Mat.Issue Track. Specification";
        PMI_No: Code[30];
        PMIGRec: Record "Posted Material Issues Header";
        ToCode: Code[20];
        FromCode: Code[20];
        BulkPosting: Boolean;


    local procedure PostItemJnlLine(var MaterialIssueLine3: Record "Material Issues Line"; PostedMaterialIssuesHeader2: Record "Posted Material Issues Header"; PostedMaterialIssuesLine2: Record "Posted Material Issues Line");
    var
        ReservationEntry: Record "Reservation Entry";
        MatIssueTrackSpec: Record "Mat.Issue Track. Specification";
        ItemRec: Record Item;
        LineNo: Integer;
    begin
        //Deleted Var(TempJnlLineDimRecordTable356)

        ItemJnlLine.INIT;
        TempItemJnlLine1.SETRANGE("Journal Template Name", 'RECLASS');
        TempItemJnlLine1.SETRANGE("Journal Batch Name", 'DEFAULT');
        IF TempItemJnlLine1.FINDLAST THEN
            LineNo := TempItemJnlLine1."Line No."
        ELSE
            LineNo := 0;
        ItemJnlLine."Journal Template Name" := 'RECLASS';
        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJnlLine."Line No." := LineNo + 10000;
        ItemJnlLine."Posting Date" := PostedMaterialIssuesHeader2."Posting Date";
        ItemJnlLine."Document Date" := PostedMaterialIssuesHeader2."Posting Date";
        ItemJnlLine."Document No." := PostedMaterialIssuesHeader2."No.";
        //ItemJnlLine."Transfer Order No." := PostedMaterialIssuesHeader2."Material Issue No.";//B2B
        ItemJnlLine."External Document No." := PostedMaterialIssuesHeader2."External Document No.";
        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        ItemJnlLine.VALIDATE("Item No.", PostedMaterialIssuesLine2."Item No.");
        ItemJnlLine.Description := PostedMaterialIssuesLine2.Description;
        ItemJnlLine."Location Code" := PostedMaterialIssuesHeader2."Transfer-from Code";
        ItemJnlLine."New Location Code" := PostedMaterialIssuesHeader2."Transfer-to Code";
        ItemJnlLine.VALIDATE(Quantity, PostedMaterialIssuesLine2.Quantity);
        ItemJnlLine."Source Code" := SourceCode;
        ItemJnlLine."Issued Date Time" := PostedMaterialIssuesLine2."Issued DateTime";
        //KPK
        ItemJnlLine."Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
        ItemJnlLine."New Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
        ItemJnlLine."Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
        ItemJnlLine."New Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
        //KPK

        ItemJnlLine."Unit of Measure Code" := PostedMaterialIssuesLine2."Unit of Measure Code";
        ItemJnlLine."Qty. per Unit of Measure" := PostedMaterialIssuesLine2."Qty. per Unit of Measure";
        ItemJnlLine."Variant Code" := PostedMaterialIssuesLine2."Variant Code";
        ItemJnlLine."Product Group Code Cust" := MaterialIssueLine."Product Group Code";
        ItemJnlLine."Item Category Code" := MaterialIssueLine."Item Category Code";
        ItemJnlLine.VALIDATE("ITL Doc No.", PostedMaterialIssuesLine2."Prod. Order No.");
        ItemJnlLine.VALIDATE("ITL Doc Line No.", PostedMaterialIssuesLine2."Prod. Order Line No.");
        ItemJnlLine.VALIDATE("ITL Doc Ref Line No.", PostedMaterialIssuesLine2."Prod. Order Comp. Line No.");
        ItemJnlLine."Transfer Type" := 1;
        ItemJnlLine.Description := STRSUBSTNO(Text13700, PostedMaterialIssuesHeader2."No.");

        //Dim1.0 Start
        ItemJnlLine.VALIDATE("Dimension Set ID", PostedMaterialIssueLine2."Dimension Set ID");
        ItemJnlLine.VALIDATE("New Dimension Set ID", MaterialIssueLine3."Dimension Set ID");
        //Dim1.0 End

        //DIM1.0 Start
        //Code Commented
        /*
        TempDocDim.RESET;
        TempDocDim.SETRANGE("Table ID",DATABASE::"Material Issues Line");
        TempDocDim.SETRANGE("Line No.",MaterialIssueLine3."Line No.");
        DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
        IF TempJnlLineDim.FINDSET THEN
          REPEAT
             TempJnlLineDim."New Dimension Value Code" := TempJnlLineDim."Dimension Value Code";
             TempJnlLineDim.MODIFY;
          UNTIL TempJnlLineDim.NEXT = 0;
        */
        //DIM1.0 End

        ItemRec.GET(MaterialIssueLine3."Item No.");
        IF ItemRec."Item Tracking Code" <> '' THEN
            "UpdateRes.Entry"(ItemJnlLine, MaterialIssueLine3);
        //DIM1.0 Start
        //Code Commented
        /*
        //ItemJnlPostLine.RunWithCheck(ItemJnlLine,TempJnlLineDim);
        */
        ItemJnlPostLine.RunWithCheck(ItemJnlLine);
        //DIM1.0 End

    end;


    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]);
    var
        InvtCommentLine: Record "Inventory Comment Line";
        InvtCommentLine2: Record "Inventory Comment Line";
    begin
        InvtCommentLine.SETRANGE("Document Type", FromDocumentType);
        InvtCommentLine.SETRANGE("No.", FromNumber);
        IF InvtCommentLine.FINDSET THEN
            REPEAT
                InvtCommentLine2 := InvtCommentLine;
                InvtCommentLine2."Document Type" := "Inventory Comment Document Type".FromInteger(ToDocumentType);
                InvtCommentLine2."No." := ToNumber;
                InvtCommentLine2.INSERT;
            UNTIL InvtCommentLine.NEXT = 0;
    end;


    local procedure CopyAndCheckDocDimToTempDocDim();
    var
        CurrLineNo: Integer;
    begin
        /*
        TempDocDim.RESET;
        TempDocDim.DELETEALL;
        DocDim.SETFILTER("Table ID",'%1|%2',DATABASE::"Material Issues Header",DATABASE::"Material Issues Line");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::" ");
        DocDim.SETRANGE("Document No.",MaterialIssueHeader."No.");
        IF DocDim.FINDFIRST THEN BEGIN
          CurrLineNo := DocDim."Line No.";
          REPEAT
            IF CurrLineNo <> DocDim."Line No." THEN BEGIN
              TempDocDim.SETRANGE("Line No.",CurrLineNo);
              CheckDimComb(CurrLineNo);
              CheckDimValuePosting(CurrLineNo);
              CurrLineNo := DocDim."Line No.";
            END;
            TempDocDim.INIT;
            TempDocDim := DocDim;
            TempDocDim.INSERT;
          UNTIL DocDim.NEXT = 0;
          TempDocDim.SETRANGE("Line No.",CurrLineNo);
          CheckDimComb(CurrLineNo);
          CheckDimValuePosting(CurrLineNo);
        END;
        TempDocDim.RESET;
        *///B2B

    end;


    local procedure CheckDimComb(LineNo: Integer);
    begin
        //DIM1.0 Start
        //IF NOT DimMgt.CheckDocDimComb(TempDocDim) THEN
        IF NOT DimMgt.CheckDimIDComb(MaterialIssueHeader."Dimension Set ID") THEN
            //DIM1.0 End
            IF LineNo = 0 THEN
                ERROR(
                  Text005,
                  MaterialIssueHeader."No.", DimMgt.GetDimCombErr)
            ELSE
                ERROR(
                  Text006,
                  MaterialIssueHeader."No.", LineNo, DimMgt.GetDimCombErr);
    end;


    local procedure CheckDimValuePosting(LineNo: Integer);
    var
        TheTransLine: Record "Transfer Line";
        TableIDArr: array[10] of Integer;
        NumberArr: array[10] of Code[20];
    begin
        //DIM1.0 Start
        //Code Commented
        /*
        IF TheTransLine.GET(MaterialIssueHeader."No.",LineNo) THEN BEGIN
          TableIDArr[1] := DATABASE::Item;
          NumberArr[1] := TheTransLine."Item No.";
          IF NOT DimMgt.CheckDocDimValuePosting(TempDocDim,TableIDArr,NumberArr) THEN
            ERROR(
              Text007,
              MaterialIssueHeader."No.",LineNo,DimMgt.GetDimValuePostingErr);
        END;
        */

        IF TheTransLine.GET(MaterialIssueHeader."No.", LineNo) THEN BEGIN
            TableIDArr[1] := DATABASE::Item;
            NumberArr[1] := TheTransLine."Item No.";
            IF NOT DimMgt.CheckDimValuePosting(TableIDArr, NumberArr, MaterialIssueHeader."Dimension Set ID") THEN
                ERROR(
                  Text007,
                  MaterialIssueHeader."No.", LineNo, DimMgt.GetDimValuePostingErr);
        END;

        //DIM1.0 End

    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    local procedure InsertRcptEntryRelation(var PostedMaterialIssuesLine: Record "Posted Material Issues Line"): Integer;
    var
        ItemEntryRelation: Record "Item Entry Relation";
        TempItemEntryRelation: Record "Item Entry Relation" temporary;
    begin
        TempItemEntryRelation2.RESET;
        TempItemEntryRelation2.DELETEALL;

        IF ItemJnlPostLine.CollectItemEntryRelation(TempItemEntryRelation) THEN BEGIN
            IF TempItemEntryRelation.FINDSET THEN BEGIN
                REPEAT
                    ItemEntryRelation := TempItemEntryRelation;
                    ItemEntryRelation."TransferFieldsMat.IssueLine"(PostedMaterialIssuesLine);
                    ItemEntryRelation.INSERT;
                    TempItemEntryRelation2 := TempItemEntryRelation;
                    TempItemEntryRelation2.INSERT;
                UNTIL TempItemEntryRelation.NEXT = 0;
                EXIT(0);
            END;
        END ELSE
            EXIT(ItemJnlLine."Item Shpt. Entry No.");
    end;


    local procedure GetLocation(LocationCode: Code[10]);
    begin
        IF LocationCode = '' THEN
            Location.GetLocationSetup(LocationCode, Location)
        ELSE
            IF Location.Code <> LocationCode THEN
                Location.GET(LocationCode);
    end;


    procedure "UpdateRes.Entry"(var ItemJournalLine: Record "Item Journal Line"; var MatrialIssueLine: Record "Material Issues Line");
    var
        ReservationEntry: Record "Reservation Entry";
        MatIssueTrackSpec: Record "Mat.Issue Track. Specification";
        TempReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
    begin
        MatIssueTrackSpec.SETRANGE("Order No.", MatrialIssueLine."Document No.");
        MatIssueTrackSpec.SETRANGE("Order Line No.", MatrialIssueLine."Line No.");
        IF MatIssueTrackSpec.FINDSET THEN
            REPEAT
                IF TempReservationEntry.FINDLAST THEN
                    EntryNo := TempReservationEntry."Entry No."
                ELSE
                    EntryNo := 0;
                ReservationEntry."Entry No." := EntryNo + 1;
                ReservationEntry.VALIDATE(Positive, FALSE);
                ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
                ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
                ReservationEntry.VALIDATE("Quantity (Base)", -MatIssueTrackSpec.Quantity);
                ReservationEntry.VALIDATE(Quantity, -MatIssueTrackSpec.Quantity);
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Creation Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
                ReservationEntry.VALIDATE("Source Subtype", 4);
                ReservationEntry.VALIDATE("Source ID", ItemJnlLine."Journal Template Name");
                ReservationEntry.VALIDATE("Source Batch Name", ItemJnlLine."Journal Batch Name");
                ReservationEntry.VALIDATE("Source Ref. No.", ItemJnlLine."Line No.");
                ReservationEntry.VALIDATE("Appl.-to Item Entry", MatIssueTrackSpec."Appl.-to Item Entry");
                ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Serial No.", MatIssueTrackSpec."Serial No.");
                //ReservationEntry.VALIDATE("Created By");
                //ReservationEntry.VALIDATE("Changed By");
                ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                ReservationEntry.VALIDATE("Warranty Date", MatIssueTrackSpec."Warranty date");
                ReservationEntry.VALIDATE("Expiration Date", MatIssueTrackSpec."Expiration Date");
                ReservationEntry.VALIDATE("Lot No.", MatIssueTrackSpec."Lot No.");
                ReservationEntry.VALIDATE(ReservationEntry."New Lot No.", MatIssueTrackSpec."Lot No.");
                ReservationEntry.VALIDATE(ReservationEntry."New Serial No.", MatIssueTrackSpec."Serial No.");
                ReservationEntry.VALIDATE(Correction, FALSE);
                ReservationEntry.INSERT;
            UNTIL MatIssueTrackSpec.NEXT = 0
    end;


    procedure Issues_Post(REc: Record "Material Issues Header");
    begin
        MaterialIssueHeader := REc;
        MaterialIssueHeader.SetHideValidationDialog(HideValidationDialog);
        /*GL.GET;
        IF (GL."Restrict Store Material Issues") THEN
          //IF "Transfer-from Code"='STR' THEN
             ERROR('STR Material Requests will not Post until completion of "Product wise Issues"');*/
        MaterialIssueHeader.TESTFIELD("Transfer-from Code");
        MaterialIssueHeader.TESTFIELD("Transfer-to Code");
        IF (MaterialIssueHeader."Transfer-from Code" <> '') AND
           (MaterialIssueHeader."Transfer-from Code" = MaterialIssueHeader."Transfer-to Code")
        THEN
            ERROR
              (Text000,
              MaterialIssueHeader."No.", MaterialIssueHeader.FIELDCAPTION("Transfer-from Code"), MaterialIssueHeader.FIELDCAPTION("Transfer-to Code"));
        MaterialIssueHeader.TESTFIELD(Status, MaterialIssueHeader.Status::Released);
        MaterialIssueHeader.TESTFIELD("Posting Date");

        MaterialIssueLine.RESET;
        MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        MaterialIssueLine.SETFILTER(Quantity, '<>0');
        MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
        // IF NOT MaterialIssueLine.findfirst THEN
        //   ERROR(Text001);
        IF (FORMAT(MaterialIssueHeader."BOM Type") IN ['Mechanical', 'Wiring', 'Testing', 'Packing']) THEN BEGIN
            MaterialIssueLine.RESET;
            MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
            MaterialIssueLine.SETFILTER(Quantity, '<>0');
            MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
            IF MaterialIssueLine.FINDFIRST THEN
                REPEAT
                    TrackingSpecification.RESET;
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order No.", MaterialIssueLine."Document No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order Line No.", MaterialIssueLine."Line No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Item No.", MaterialIssueLine."Item No.");
                    IF TrackingSpecification.FINDSET THEN
                        REPEAT
                            "Mech&Wiring_Items".RESET;
                            "Mech&Wiring_Items".SETRANGE("Production Order No.", TrackingSpecification."Prod. Order No.");
                            "Mech&Wiring_Items".SETRANGE("Production Order Line No.", TrackingSpecification."Prod. Order Line No.");
                            "Mech&Wiring_Items".SETRANGE("Item No.", TrackingSpecification."Item No.");
                            "Mech&Wiring_Items".SETRANGE("Lot No.", TrackingSpecification."Lot No.");
                            "Mech&Wiring_Items".SETFILTER("Mech&Wiring_Items"."BOM Type", FORMAT(MaterialIssueHeader."BOM Type"));
                            IF NOT "Mech&Wiring_Items".FINDFIRST THEN BEGIN
                                "Mech&Wiring_Items".INIT;
                                "Mech&Wiring_Items"."Production Order No." := TrackingSpecification."Prod. Order No.";
                                "Mech&Wiring_Items"."Production Order Line No." := TrackingSpecification."Prod. Order Line No.";
                                "Mech&Wiring_Items"."Item No." := TrackingSpecification."Item No.";
                                "Mech&Wiring_Items".Description := TrackingSpecification.Description;
                                "Mech&Wiring_Items"."Lot No." := TrackingSpecification."Lot No.";
                                "Mech&Wiring_Items".Quantity := TrackingSpecification.Quantity;
                                "Mech&Wiring_Items"."BOM Type" := FORMAT(MaterialIssueHeader."BOM Type");
                                "Mech&Wiring_Items"."Request No." := MaterialIssueHeader."No.";
                                "Mech&Wiring_Items".INSERT;
                            END ELSE BEGIN
                                "Mech&Wiring_Items".Quantity += TrackingSpecification.Quantity;
                                "Mech&Wiring_Items".MODIFY;
                            END;

                        UNTIL TrackingSpecification.NEXT = 0;
                UNTIL MaterialIssueLine.NEXT = 0;
        END;

        TrackingSpecification.RESET;
        CopyAndCheckDocDimToTempDocDim;

        Window.OPEN(
          '#1#################################\\' +
          Text003);

        Window.UPDATE(1, STRSUBSTNO(Text004, MaterialIssueHeader."No."));

        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup.Transfer;
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Posted Material Issue Nos.");
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-from Code");
        InventoryPostingSetup.FINDFIRST;
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-to Code");
        InventoryPostingSetup.FINDFIRST;
        //UPGREV2.0>>
        /*
        IF RECORDLEVELLOCKING THEN BEGIN
          NoSeriesLine.LOCKTABLE;
          IF NoSeriesLine.FINDLAST THEN;
          IF InvtSetup."Automatic Cost Posting" THEN  BEGIN
            GLEntry.LOCKTABLE;
            IF GLEntry.FINDLAST THEN;
          END;
        END;
        */
        //UPGREV2.0<<
        // Insert receipt header
        PostedMaterialIssueHeader.LOCKTABLE;
        PostedMaterialIssueHeader.INIT;
        PostedMaterialIssueHeader."Issued DateTime" := CURRENTDATETIME;//B2B1.0
        PostedMaterialIssueHeader."Transfer-from Code" := MaterialIssueHeader."Transfer-from Code";
        PostedMaterialIssueHeader."Transfer-from Name" := MaterialIssueHeader."Transfer-from Name";
        PostedMaterialIssueHeader."Transfer-from Name 2" := MaterialIssueHeader."Transfer-from Name 2";
        PostedMaterialIssueHeader."Transfer-from Address" := MaterialIssueHeader."Transfer-from Address";
        PostedMaterialIssueHeader."Transfer-from Address 2" := MaterialIssueHeader."Transfer-from Address 2";
        PostedMaterialIssueHeader."Transfer-from Post Code" := MaterialIssueHeader."Transfer-from Post Code";
        PostedMaterialIssueHeader."Transfer-from City" := MaterialIssueHeader."Transfer-from City";
        PostedMaterialIssueHeader."Transfer-from County" := MaterialIssueHeader."Transfer-from County";
        PostedMaterialIssueHeader."Transfer-from Country Code" := MaterialIssueHeader."Transfer-from Country Code";
        PostedMaterialIssueHeader."Transfer-from Contact" := MaterialIssueHeader."Transfer-from Contact";
        PostedMaterialIssueHeader."Transfer-to Code" := MaterialIssueHeader."Transfer-to Code";
        PostedMaterialIssueHeader."Transfer-to Name" := MaterialIssueHeader."Transfer-to Name";
        PostedMaterialIssueHeader."Transfer-to Name 2" := MaterialIssueHeader."Transfer-to Name 2";
        PostedMaterialIssueHeader."Transfer-to Address" := MaterialIssueHeader."Transfer-to Address";
        PostedMaterialIssueHeader."Transfer-to Address 2" := MaterialIssueHeader."Transfer-to Address 2";
        PostedMaterialIssueHeader."Transfer-to Post Code" := MaterialIssueHeader."Transfer-to Post Code";
        PostedMaterialIssueHeader."Transfer-to City" := MaterialIssueHeader."Transfer-to City";
        PostedMaterialIssueHeader."Transfer-to County" := MaterialIssueHeader."Transfer-to County";
        PostedMaterialIssueHeader."Transfer-to Country Code" := MaterialIssueHeader."Transfer-to Country Code";
        PostedMaterialIssueHeader."Transfer-to Contact" := MaterialIssueHeader."Transfer-to Contact";
        PostedMaterialIssueHeader."Posting Date" := MaterialIssueHeader."Posting Date";
        PostedMaterialIssueHeader."Receipt Date" := MaterialIssueHeader."Receipt Date";
        PostedMaterialIssueHeader."Posted By" := USERID;
        PostedMaterialIssueHeader."Shortcut Dimension 1 Code" := MaterialIssueHeader."Shortcut Dimension 1 Code";
        PostedMaterialIssueHeader."Shortcut Dimension 2 Code" := MaterialIssueHeader."Shortcut Dimension 2 Code";
        PostedMaterialIssueHeader."Dimension Set ID" := MaterialIssueHeader."Dimension Set ID"; //DIM1.0
        PostedMaterialIssueHeader."Material Issue No." := MaterialIssueHeader."No.";
        PostedMaterialIssueHeader."External Document No." := MaterialIssueHeader."External Document No.";
        PostedMaterialIssueHeader."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
        PostedMaterialIssueHeader."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
        PostedMaterialIssueHeader."Prod. BOM No." := MaterialIssueHeader."Prod. BOM No.";
        PostedMaterialIssueHeader."Sales Order No." := MaterialIssueHeader."Sales Order No.";
        PostedMaterialIssueHeader."Auto Post" := MaterialIssueHeader."Auto Post";
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Resource Name" := MaterialIssueHeader."Resource Name";
        PostedMaterialIssueHeader."User ID" := MaterialIssueHeader."User ID";
        PostedMaterialIssueHeader."Required Date" := MaterialIssueHeader."Required Date";
        PostedMaterialIssueHeader."Released Date" := MaterialIssueHeader."Released Date";
        PostedMaterialIssueHeader."Released By" := MaterialIssueHeader."Released By";
        PostedMaterialIssueHeader."Released Time" := MaterialIssueHeader."Released Time";
        PostedMaterialIssueHeader."Reason Code" := MaterialIssueHeader."Reason Code";
        PostedMaterialIssueHeader.Remarks := MaterialIssueHeader.Remarks;
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Service Item" := MaterialIssueHeader."Service Item";
        PostedMaterialIssueHeader."Service Item Serial No." := MaterialIssueHeader."Service Item Serial No.";
        PostedMaterialIssueHeader."Service Item Description" := MaterialIssueHeader."Service Item Description";
        PostedMaterialIssueHeader."No. Series" := InvtSetup."Posted Transfer Rcpt. Nos.";
        PostedMaterialIssueHeader."No." :=
            NoSeriesMgt.GetNextNo(
              InvtSetup."Posted Material Issue Nos.", MaterialIssueHeader."Posting Date", TRUE);
        PostedMaterialIssueHeader.INSERT;
        //DIM1.0 Start
        //Code Commneted
        /*
        DimMgt.MoveOneDocDimToPostedDocDim(
          TempDocDim,DATABASE::"Material Issues Header",TempDocDim."Document Type"::" ","No.",0,
          DATABASE::"Posted Material Issues Header",PostedMaterialIssueHeader."No.");
        */
        //DIM1.0 End
        CopyCommentLines(4, 5, MaterialIssueHeader."No.", PostedMaterialIssueHeader."No.");

        // Insert receipt lines
        LineCount := 0;
        PostedMaterialIssueLine.LOCKTABLE;
        //MaterialIssueLine.SETRANGE("Document No.","No.");
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF MaterialIssueLine.FINDSET THEN BEGIN
            REPEAT
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);
                IF MaterialIssueLine."Item No." <> '' THEN BEGIN
                    Item.GET(MaterialIssueLine."Item No.");
                    Item.TESTFIELD(Blocked, FALSE);
                END;
                PostedMaterialIssueLine.INIT;
                PostedMaterialIssueLine."Document No." := PostedMaterialIssueHeader."No.";
                PostedMaterialIssueLine2.SETRANGE("Document No.", PostedMaterialIssueHeader."No.");
                IF PostedMaterialIssueLine2.FINDLAST THEN
                    LineNo := PostedMaterialIssueLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                PostedMaterialIssueLine."Line No." := LineNo;
                PostedMaterialIssueLine."Item No." := MaterialIssueLine."Item No.";
                // PostedMaterialIssueLine."Unit Cost":=MaterialIssueLine."Unit Cost";
                PostedMaterialIssueLine.Description := MaterialIssueLine.Description;
                PostedMaterialIssueLine.Quantity := MaterialIssueLine."Qty. to Receive";
                PostedMaterialIssueLine."Unit of Measure" := MaterialIssueLine."Unit of Measure";
                PostedMaterialIssueLine."Shortcut Dimension 1 Code" := MaterialIssueLine."Shortcut Dimension 1 Code";
                PostedMaterialIssueLine."Shortcut Dimension 2 Code" := MaterialIssueLine."Shortcut Dimension 2 Code";
                PostedMaterialIssueLine."Dimension Set ID" := MaterialIssueLine."Dimension Set ID"; //DIM1.0
                PostedMaterialIssueLine."Quantity (Base)" := MaterialIssueLine."Qty. to Receive (Base)";
                PostedMaterialIssueLine."Qty. per Unit of Measure" := MaterialIssueLine."Qty. per Unit of Measure";
                PostedMaterialIssueLine."Unit of Measure Code" := MaterialIssueLine."Unit of Measure Code";
                PostedMaterialIssueLine."Gross Weight" := MaterialIssueLine."Gross Weight";
                PostedMaterialIssueLine."Net Weight" := MaterialIssueLine."Net Weight";
                PostedMaterialIssueLine."Unit Volume" := MaterialIssueLine."Unit Volume";
                PostedMaterialIssueLine."Variant Code" := MaterialIssueLine."Variant Code";
                PostedMaterialIssueLine."Units per Parcel" := MaterialIssueLine."Units per Parcel";
                PostedMaterialIssueLine."Description 2" := MaterialIssueLine."Description 2";
                PostedMaterialIssueLine."Material Issue No." := MaterialIssueLine."Document No.";
                PostedMaterialIssueLine."Material Issue Line No." := MaterialIssueLine."Line No.";
                PostedMaterialIssueLine."Receipt Date" := MaterialIssueLine."Receipt Date";
                PostedMaterialIssueLine."Transfer-from Code" := MaterialIssueLine."Transfer-from Code";
                PostedMaterialIssueLine."Transfer-to Code" := MaterialIssueLine."Transfer-to Code";
                PostedMaterialIssueLine."Item Category Code" := MaterialIssueLine."Item Category Code";
                PostedMaterialIssueLine."Product Group Code" := MaterialIssueLine."Product Group Code";
                PostedMaterialIssueLine."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
                PostedMaterialIssueLine."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
                PostedMaterialIssueLine."Prod. Order Comp. Line No." := MaterialIssueLine."Prod. Order Comp. Line No.";//b2bsbk
                PostedMaterialIssueLine.Saleorderno := MaterialIssueHeader."Sales Order No.";
                PostedMaterialIssueLine."Production BOM No." := MaterialIssueLine."Production BOM No.";
                PostedMaterialIssueLine."Issued DateTime" := PostedMaterialIssueHeader."Issued DateTime";
                PostedMaterialIssueLine."Unit Cost" := MaterialIssueLine."Unit Cost";
                PostedMaterialIssueLine."Avg. unit cost" := MaterialIssueLine."Avg. unit cost";
                PostedMaterialIssueLine.Remarks := MaterialIssueLine.Remarks;
                //added by pranavi on 08-05-2015
                PostedMaterialIssueLine."Operation No." := MaterialIssueLine."Operation No.";
                PostedMaterialIssueLine.Dept := MaterialIssueLine.Dept;
                PostedMaterialIssueLine."Material Requisition Date" := MaterialIssueLine."Material Requisition Date";
                //end by pranavi


                /* IF (MaterialIssueHeader."Transfer-to Code" = 'STR') AND
                  ((MaterialIssueHeader."Transfer-from Code"<>'R&D STR') OR (MaterialIssueHeader."Transfer-from Code"<>'CS STR')) THEN
                 BEGIN
                  Mail_Subject:='Return materials';
                   Mail_Body:='Material is Returned Correposnding to '+MaterialIssueHeader."No.";
                 "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                 IF "Mail-Id".FINDFIRST THEN
                  "from Mail":="Mail-Id".MailID;
                  "to mail":='dmadhavi@efftronics.com,mary@efftronics.com';
                  END;*/

                PostedMaterialIssueLine.INSERT;

                IF MaterialIssueLine."Qty. to Receive" > 0 THEN BEGIN
                    MaterialIssueLine.VALIDATE("Quantity Received",
                              MaterialIssueLine."Quantity Received" + MaterialIssueLine."Qty. to Receive");

                    MaterialIssueLine.VALIDATE("Qty. to Receive",
                              (MaterialIssueLine.Quantity - MaterialIssueLine."Quantity Received"));
                    OriginalQuantity := MaterialIssueLine."Qty. to Receive";
                    OriginalQuantityBase := MaterialIssueLine."Qty. to Receive (Base)";
                    //Rev01 Start
                    //Code Commented
                    /*
                     PostItemJnlLine(MaterialIssueLine,PostedMaterialIssueHeader,PostedMaterialIssueLine);
                    */
                    //Rev01 End
                    //Code Commented
                    PostItemJnlLine2013(MaterialIssueLine, PostedMaterialIssueHeader, PostedMaterialIssueLine);
                    PostedMaterialIssueLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(PostedMaterialIssueLine);
                    PostedMaterialIssueLine.MODIFY;
                    MaterialIssueLine.MODIFY;
                END;
                DataDumptoPicking(PostedMaterialIssueLine, PostedMaterialIssueHeader);
                //DIM1.0 Start
                /*
                DimMgt.MoveOneDocDimToPostedDocDim(
                  DocDim,DATABASE::"Material Issues Line",DocDim."Document Type"::" ","No.",MaterialIssueLine."Line No.",
                  DATABASE::"Posted Material Issues Line",PostedMaterialIssueLine."Document No.");
                */
                //DIM1.0 End

                //Delete Tracking Specification
                TrackingSpecification.SETRANGE("Order No.", MaterialIssueLine."Document No.");
                TrackingSpecification.SETRANGE("Order Line No.", MaterialIssueLine."Line No.");
                IF TrackingSpecification.FINDFIRST THEN
                    REPEAT
                        TrackingSpecification.DELETE;
                    UNTIL TrackingSpecification.NEXT = 0;
            UNTIL MaterialIssueLine.NEXT = 0;
        END;
        // Code For Mail Sending
        /*  IF ( "from Mail"<>'') AND ("to mail" <>'')  THEN
           mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');*/



        TempItemJnlLine.SETRANGE("Entry Type", TempItemJnlLine."Entry Type"::Transfer);
        TempItemJnlLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        IF TempItemJnlLine.FINDSET THEN
            REPEAT
                //      ItemJnlPostLine.RunWithCheck(TempItemJnlLine,TempJnlLineDim2);
                ItemJnlPostLine.RunWithCheck(TempItemJnlLine);//B2B
            UNTIL TempItemJnlLine.NEXT = 0;
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETRANGE("Qty. to Receive");
        Window.CLOSE;
        HeaderDeleted := DeleteOrder_Local(MaterialIssueHeader, MaterialIssueLine);


        UpdateAnalysisView.UpdateAll(0, TRUE);
        REc := MaterialIssueHeader;

    end;


    procedure DeleteOrder_Local(var MaterialIssuesHeader2: Record "Material Issues Header"; var MaterialIssuesLine2: Record "Material Issues Line"): Boolean;
    var
        InvtCommentLine: Record "Inventory Comment Line";
        No: Code[20];
        DoNotDelete: Boolean;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
    begin
        No := MaterialIssuesHeader2."No.";
        IF MaterialIssuesLine2.FINDFIRST THEN BEGIN
            REPEAT
                IF (MaterialIssuesLine2.Quantity <> MaterialIssuesLine2."Quantity Received") OR
                   (MaterialIssuesLine2."Quantity (Base)" <> MaterialIssuesLine2."Qty. Received (Base)")
                THEN
                    DoNotDelete := TRUE;
            UNTIL MaterialIssuesLine2.NEXT = 0;
        END;

        IF NOT DoNotDelete THEN BEGIN
            InvtCommentLine.SETRANGE("Document Type", InvtCommentLine."Document Type"::"Material Issues");
            InvtCommentLine.SETRANGE("No.", No);
            InvtCommentLine.DELETEALL;

            IF MaterialIssuesLine2.FINDFIRST THEN BEGIN
                REPEAT
                    /*DimMgt.DeleteDocDim(DATABASE::"Material Issues Line",DocDim."Document Type"::" ",No,MaterialIssuesLine2."Line No.");*///B2B
                    TrackingSpecification.SETRANGE("Order No.", MaterialIssuesLine2."Document No.");
                    TrackingSpecification.SETRANGE("Order Line No.", MaterialIssuesLine2."Line No.");
                    IF TrackingSpecification.FINDFIRST THEN
                        REPEAT
                            TrackingSpecification.DELETE;
                        UNTIL TrackingSpecification.NEXT = 0;
                    MaterialIssuesLine2.DELETE;
                UNTIL MaterialIssuesLine2.NEXT = 0;
            END;
            //DIM1.0 Start
            //DimMgt.DeleteDocDim(DATABASE::"Material Issues Header",DocDim."Document Type"::" ",No,0);
            //DIM1.0 End
            MaterialIssuesHeader2.DELETE;
            // MESSAGE(Text003,No);
            EXIT(TRUE);
        END;
        EXIT(FALSE);

    end;


    procedure "---Rev01---"();
    begin
    end;


    local procedure PostItemJnlLine2013(var MaterialIssueLine3: Record "Material Issues Line"; PostedMaterialIssuesHeader2: Record "Posted Material Issues Header"; PostedMaterialIssuesLine2: Record "Posted Material Issues Line");
    var
        ReservationEntry: Record "Reservation Entry";
        MatIssueTrackSpec: Record "Mat.Issue Track. Specification";
        ItemRec: Record Item;
        LineNo: Integer;
        "-Rev01-": Integer;
        TotalTrackedQtyLVar: Decimal;
        UOMMgmtLCU: Codeunit "Unit of Measure Management";
        MatIssLineQtyPerLVar: Decimal;
        MatIssueQtyBaseLVar: Decimal;

        Text50000: Label 'Quantity(Base) %1 defined in the tracking specification is not equal to Material Issue %2  Line %3 posting quantity(Base) %4.';
    begin
        CLEAR(TotalTrackedQtyLVar);
        CLEAR(MatIssLineQtyPerLVar);
        CLEAR(MatIssueQtyBaseLVar);

        MatIssueTrackSpecGRec.RESET;
        MatIssueTrackSpecGRec.SETRANGE("Order No.", MaterialIssueLine3."Document No.");
        MatIssueTrackSpecGRec.SETRANGE("Order Line No.", MaterialIssueLine3."Line No.");
        IF MatIssueTrackSpecGRec.FINDSET THEN
            REPEAT
                TotalTrackedQtyLVar += MatIssueTrackSpecGRec.Quantity;
            UNTIL MatIssueTrackSpecGRec.NEXT = 0;

        ItemRec.GET(PostedMaterialIssuesLine2."Item No.");
        MatIssLineQtyPerLVar := UOMMgmtLCU.GetQtyPerUnitOfMeasure(ItemRec, PostedMaterialIssuesLine2."Unit of Measure Code");
        MatIssueQtyBaseLVar := (PostedMaterialIssuesLine2.Quantity * MatIssLineQtyPerLVar);


        IF TotalTrackedQtyLVar < MatIssueQtyBaseLVar THEN
            ERROR(Text50000, TotalTrackedQtyLVar, MaterialIssueLine3."Document No.", MaterialIssueLine3."Line No.", MatIssueQtyBaseLVar);


        //Deleted Var(TempJnlLineDimRecordTable356)
        MatIssueTrackSpecGRec.RESET;
        MatIssueTrackSpecGRec.SETRANGE("Order No.", MaterialIssueLine3."Document No.");
        MatIssueTrackSpecGRec.SETRANGE("Order Line No.", MaterialIssueLine3."Line No.");
        IF MatIssueTrackSpecGRec.FINDSET THEN BEGIN
            REPEAT

                ItemRec.GET(MaterialIssueLine3."Item No.");

                TempItemJnlLine1.SETRANGE("Journal Template Name", 'RECLASS');
                TempItemJnlLine1.SETRANGE("Journal Batch Name", 'DEFAULT');
                IF TempItemJnlLine1.FINDLAST THEN
                    LineNo := TempItemJnlLine1."Line No."
                ELSE
                    LineNo := 0;

                ItemJnlLine.INIT;
                ItemJnlLine."Journal Template Name" := 'RECLASS';
                ItemJnlLine."Journal Batch Name" := 'DEFAULT';
                ItemJnlLine."Line No." := LineNo + 10000;
                ItemJnlLine."Posting Date" := PostedMaterialIssuesHeader2."Posting Date";
                ItemJnlLine."Document Date" := PostedMaterialIssuesHeader2."Posting Date";
                ItemJnlLine."Document No." := PostedMaterialIssuesHeader2."No.";
                //ItemJnlLine."Transfer Order No." := PostedMaterialIssuesHeader2."Material Issue No.";//B2B
                ItemJnlLine."External Document No." := PostedMaterialIssuesHeader2."External Document No.";
                ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Transfer);
                ItemJnlLine.VALIDATE("Item No.", PostedMaterialIssuesLine2."Item No.");
                ItemJnlLine.Description := PostedMaterialIssuesLine2.Description;
                ItemJnlLine."Location Code" := PostedMaterialIssuesHeader2."Transfer-from Code";
                ItemJnlLine."New Location Code" := PostedMaterialIssuesHeader2."Transfer-to Code";

                IF ItemRec."Item Tracking Code" <> '' THEN
                    ItemJnlLine.VALIDATE(Quantity, MatIssueTrackSpecGRec.Quantity)
                ELSE
                    ItemJnlLine.VALIDATE(Quantity, PostedMaterialIssuesLine2.Quantity);

                ItemJnlLine."Source Code" := SourceCode;
                ItemJnlLine."Issued Date Time" := PostedMaterialIssuesLine2."Issued DateTime";
                ItemJnlLine."Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
                ItemJnlLine."New Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
                ItemJnlLine."Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
                ItemJnlLine."New Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
                ItemJnlLine."Unit of Measure Code" := PostedMaterialIssuesLine2."Unit of Measure Code";
                ItemJnlLine."Qty. per Unit of Measure" := PostedMaterialIssuesLine2."Qty. per Unit of Measure";
                ItemJnlLine."Variant Code" := PostedMaterialIssuesLine2."Variant Code";
                ItemJnlLine."Product Group Code Cust" := MaterialIssueLine."Product Group Code";
                ItemJnlLine."Item Category Code" := MaterialIssueLine."Item Category Code";
                ItemJnlLine.VALIDATE("ITL Doc No.", PostedMaterialIssuesLine2."Prod. Order No.");
                ItemJnlLine.VALIDATE("ITL Doc Line No.", PostedMaterialIssuesLine2."Prod. Order Line No.");
                ItemJnlLine.VALIDATE("ITL Doc Ref Line No.", PostedMaterialIssuesLine2."Prod. Order Comp. Line No.");
                ItemJnlLine."Transfer Type" := 1;
                ItemJnlLine.Description := STRSUBSTNO(Text13700, PostedMaterialIssuesHeader2."No.");

                ItemJnlLine.VALIDATE("Dimension Set ID", PostedMaterialIssuesLine2."Dimension Set ID");
                ItemJnlLine.VALIDATE("New Dimension Set ID", MaterialIssueLine3."Dimension Set ID");


                IF ItemRec."Item Tracking Code" <> '' THEN BEGIN
                    UpdateResEntry2013(ItemJnlLine, MaterialIssueLine3, MatIssueTrackSpecGRec);

                END;

                ItemJnlPostLine.RunWithCheck(ItemJnlLine);

            UNTIL MatIssueTrackSpecGRec.NEXT = 0;
        END ELSE BEGIN

            ItemRec.GET(MaterialIssueLine3."Item No.");

            TempItemJnlLine1.SETRANGE("Journal Template Name", 'RECLASS');
            TempItemJnlLine1.SETRANGE("Journal Batch Name", 'DEFAULT');
            IF TempItemJnlLine1.FINDLAST THEN
                LineNo := TempItemJnlLine1."Line No."
            ELSE
                LineNo := 0;

            ItemJnlLine.INIT;
            ItemJnlLine."Journal Template Name" := 'RECLASS';
            ItemJnlLine."Journal Batch Name" := 'DEFAULT';
            ItemJnlLine."Line No." := LineNo + 10000;
            ItemJnlLine."Posting Date" := PostedMaterialIssuesHeader2."Posting Date";
            ItemJnlLine."Document Date" := PostedMaterialIssuesHeader2."Posting Date";
            ItemJnlLine."Document No." := PostedMaterialIssuesHeader2."No.";
            //ItemJnlLine."Transfer Order No." := PostedMaterialIssuesHeader2."Material Issue No.";//B2B
            ItemJnlLine."External Document No." := PostedMaterialIssuesHeader2."External Document No.";
            ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Transfer);
            ItemJnlLine.VALIDATE("Item No.", PostedMaterialIssuesLine2."Item No.");
            ItemJnlLine.Description := PostedMaterialIssuesLine2.Description;
            ItemJnlLine."Location Code" := PostedMaterialIssuesHeader2."Transfer-from Code";
            ItemJnlLine."New Location Code" := PostedMaterialIssuesHeader2."Transfer-to Code";

            ItemJnlLine.VALIDATE(Quantity, PostedMaterialIssuesLine2.Quantity);

            ItemJnlLine."Source Code" := SourceCode;
            ItemJnlLine."Issued Date Time" := PostedMaterialIssuesLine2."Issued DateTime";
            ItemJnlLine."Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
            ItemJnlLine."New Shortcut Dimension 1 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 1 Code";
            ItemJnlLine."Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
            ItemJnlLine."New Shortcut Dimension 2 Code" := PostedMaterialIssuesLine2."Shortcut Dimension 2 Code";
            ItemJnlLine."Unit of Measure Code" := PostedMaterialIssuesLine2."Unit of Measure Code";
            ItemJnlLine."Qty. per Unit of Measure" := PostedMaterialIssuesLine2."Qty. per Unit of Measure";
            ItemJnlLine."Variant Code" := PostedMaterialIssuesLine2."Variant Code";
            ItemJnlLine."Product Group Code Cust" := MaterialIssueLine."Product Group Code";
            ItemJnlLine."Item Category Code" := MaterialIssueLine."Item Category Code";
            ItemJnlLine.VALIDATE("ITL Doc No.", PostedMaterialIssuesLine2."Prod. Order No.");
            ItemJnlLine.VALIDATE("ITL Doc Line No.", PostedMaterialIssuesLine2."Prod. Order Line No.");
            ItemJnlLine.VALIDATE("ITL Doc Ref Line No.", PostedMaterialIssuesLine2."Prod. Order Comp. Line No.");
            ItemJnlLine."Transfer Type" := 1;
            ItemJnlLine.Description := STRSUBSTNO(Text13700, PostedMaterialIssuesHeader2."No.");

            ItemJnlLine.VALIDATE("Dimension Set ID", PostedMaterialIssuesLine2."Dimension Set ID");
            ItemJnlLine.VALIDATE("New Dimension Set ID", MaterialIssueLine3."Dimension Set ID");

            IF ItemRec."Item Tracking Code" <> '' THEN
                UpdateResEntry2013(ItemJnlLine, MaterialIssueLine3, MatIssueTrackSpecGRec);

            ItemJnlPostLine.RunWithCheck(ItemJnlLine);
        END;
    end;


    procedure UpdateResEntry2013(var ItemJournalLine: Record "Item Journal Line"; var MatrialIssueLine: Record "Material Issues Line"; var MatIssueTrackSpecRecPar: Record "Mat.Issue Track. Specification");
    var
        ReservationEntry: Record "Reservation Entry";
        MatIssueTrackSpec: Record "Mat.Issue Track. Specification";
        TempReservationEntry: Record "Reservation Entry";
        EntryNo: Integer;
    begin

        TempReservationEntry.LOCKTABLE;
        ReservationEntry.LOCKTABLE;  // added on march-08 for reservation entry locking issues in Auto postings
        MatIssueTrackSpec.RESET;
        MatIssueTrackSpec.SETRANGE("Order No.", MatrialIssueLine."Document No.");
        MatIssueTrackSpec.SETRANGE("Order Line No.", MatrialIssueLine."Line No.");
        MatIssueTrackSpec.SETRANGE("Item No.", MatIssueTrackSpecRecPar."Item No.");
        MatIssueTrackSpec.SETRANGE("Location Code", MatIssueTrackSpecRecPar."Location Code");
        MatIssueTrackSpec.SETFILTER("Lot No.", MatIssueTrackSpecRecPar."Lot No.");
        MatIssueTrackSpec.SETFILTER("Serial No.", MatIssueTrackSpecRecPar."Serial No.");
        MatIssueTrackSpec.SETRANGE("Appl.-to Item Entry", MatIssueTrackSpecRecPar."Appl.-to Item Entry");
        IF MatIssueTrackSpec.FINDSET THEN
            REPEAT
                IF TempReservationEntry.FINDLAST THEN
                    EntryNo := TempReservationEntry."Entry No."
                ELSE
                    EntryNo := 0;
                ReservationEntry."Entry No." := EntryNo + 1;
                ReservationEntry.VALIDATE(Positive, FALSE);
                ReservationEntry.VALIDATE("Item No.", ItemJournalLine."Item No.");
                ReservationEntry.VALIDATE("Location Code", ItemJournalLine."Location Code");
                ReservationEntry.VALIDATE("Quantity (Base)", -MatIssueTrackSpec.Quantity);
                ReservationEntry.VALIDATE(Quantity, -MatIssueTrackSpec.Quantity);
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Creation Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
                ReservationEntry.VALIDATE("Source Subtype", 4);
                ReservationEntry.VALIDATE("Source ID", ItemJnlLine."Journal Template Name");
                ReservationEntry.VALIDATE("Source Batch Name", ItemJnlLine."Journal Batch Name");
                ReservationEntry.VALIDATE("Source Ref. No.", ItemJnlLine."Line No.");
                ReservationEntry.VALIDATE("Appl.-to Item Entry", MatIssueTrackSpec."Appl.-to Item Entry");
                ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine."Posting Date");
                ReservationEntry.VALIDATE("Serial No.", MatIssueTrackSpec."Serial No.");
                //ReservationEntry.VALIDATE("Created By");
                //ReservationEntry.VALIDATE("Changed By");
                ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                ReservationEntry.VALIDATE("Warranty Date", MatIssueTrackSpec."Warranty date");
                ReservationEntry.VALIDATE("Expiration Date", MatIssueTrackSpec."Expiration Date");
                ReservationEntry.VALIDATE("Lot No.", MatIssueTrackSpec."Lot No.");
                ReservationEntry.VALIDATE(ReservationEntry."New Lot No.", MatIssueTrackSpec."Lot No.");
                ReservationEntry.VALIDATE(ReservationEntry."New Serial No.", MatIssueTrackSpec."Serial No.");
                ReservationEntry.VALIDATE(Correction, FALSE);
                ReservationEntry.INSERT;

                //>>Added by Pranavi on 22-05-2017 for MSL Process
                IF MatIssueTrackSpec."Location Code" IN ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR', 'MCH', 'PROD'] THEN
                    UpdateMBBOpenCloseTimes(MatIssueTrackSpec, MatrialIssueLine, FALSE)
                ELSE
                    UpdateMBBOpenCloseTimes(MatIssueTrackSpec, MatrialIssueLine, TRUE);
            //<<Added by Pranavi on 22-05-2017 for MSL Process

            UNTIL MatIssueTrackSpec.NEXT = 0;
    end;


    procedure Issues_Post_Auto_Scheduled(REc: Record "Material Issues Header");
    begin
        MaterialIssueHeader := REc;
        MaterialIssueHeader.SetHideValidationDialog(HideValidationDialog);

        MaterialIssueHeader.TESTFIELD("Transfer-from Code");
        MaterialIssueHeader.TESTFIELD("Transfer-to Code");
        IF (MaterialIssueHeader."Transfer-from Code" <> '') AND
           (MaterialIssueHeader."Transfer-from Code" = MaterialIssueHeader."Transfer-to Code")
        THEN
            ERROR
              (Text000,
              MaterialIssueHeader."No.", MaterialIssueHeader.FIELDCAPTION("Transfer-from Code"), MaterialIssueHeader.FIELDCAPTION("Transfer-to Code"));
        MaterialIssueHeader.TESTFIELD(Status, MaterialIssueHeader.Status::Released);
        MaterialIssueHeader.TESTFIELD("Posting Date");

        MaterialIssueLine.RESET;
        MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        MaterialIssueLine.SETFILTER(Quantity, '<>0');
        MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
        // IF NOT MaterialIssueLine.findfirst THEN
        //   ERROR(Text001);
        IF (FORMAT(MaterialIssueHeader."BOM Type") IN ['Mechanical', 'Wiring', 'Testing', 'Packing']) THEN BEGIN
            MaterialIssueLine.RESET;
            MaterialIssueLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
            MaterialIssueLine.SETFILTER(Quantity, '<>0');
            MaterialIssueLine.SETFILTER("Qty. to Receive", '<>0');
            IF MaterialIssueLine.FINDFIRST THEN
                REPEAT
                    TrackingSpecification.RESET;
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order No.", MaterialIssueLine."Document No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Order Line No.", MaterialIssueLine."Line No.");
                    TrackingSpecification.SETRANGE(TrackingSpecification."Item No.", MaterialIssueLine."Item No.");
                    IF TrackingSpecification.FINDSET THEN
                        REPEAT
                            "Mech&Wiring_Items".RESET;
                            "Mech&Wiring_Items".SETRANGE("Production Order No.", TrackingSpecification."Prod. Order No.");
                            "Mech&Wiring_Items".SETRANGE("Production Order Line No.", TrackingSpecification."Prod. Order Line No.");
                            "Mech&Wiring_Items".SETRANGE("Item No.", TrackingSpecification."Item No.");
                            "Mech&Wiring_Items".SETRANGE("Lot No.", TrackingSpecification."Lot No.");
                            "Mech&Wiring_Items".SETFILTER("Mech&Wiring_Items"."BOM Type", FORMAT(MaterialIssueHeader."BOM Type"));
                            IF NOT "Mech&Wiring_Items".FINDFIRST THEN BEGIN
                                "Mech&Wiring_Items".INIT;
                                "Mech&Wiring_Items"."Production Order No." := TrackingSpecification."Prod. Order No.";
                                "Mech&Wiring_Items"."Production Order Line No." := TrackingSpecification."Prod. Order Line No.";
                                "Mech&Wiring_Items"."Item No." := TrackingSpecification."Item No.";
                                "Mech&Wiring_Items".Description := TrackingSpecification.Description;
                                "Mech&Wiring_Items"."Lot No." := TrackingSpecification."Lot No.";
                                "Mech&Wiring_Items".Quantity := TrackingSpecification.Quantity;
                                "Mech&Wiring_Items"."BOM Type" := FORMAT(MaterialIssueHeader."BOM Type");
                                "Mech&Wiring_Items"."Request No." := MaterialIssueHeader."No.";
                                "Mech&Wiring_Items".INSERT;
                            END ELSE BEGIN
                                "Mech&Wiring_Items".Quantity += TrackingSpecification.Quantity;
                                "Mech&Wiring_Items".MODIFY;
                            END;

                        UNTIL TrackingSpecification.NEXT = 0;
                UNTIL MaterialIssueLine.NEXT = 0;
        END;

        TrackingSpecification.RESET;
        CopyAndCheckDocDimToTempDocDim;
        /*
          Window.OPEN(
            '#1#################################\\' +
            Text003);

          Window.UPDATE(1,STRSUBSTNO(Text004,"No."));
        */
        SourceCodeSetup.GET;
        SourceCode := SourceCodeSetup.Transfer;
        InvtSetup.GET;
        InvtSetup.TESTFIELD(InvtSetup."Posted Material Issue Nos.");
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-from Code");
        InventoryPostingSetup.FINDFIRST;
        InventoryPostingSetup.SETRANGE("Location Code", MaterialIssueHeader."Transfer-to Code");
        InventoryPostingSetup.FINDFIRST;
        //UPGREV2.0>>
        /*
        IF RECORDLEVELLOCKING THEN BEGIN
          NoSeriesLine.LOCKTABLE;
          IF NoSeriesLine.FINDLAST THEN;
          IF InvtSetup."Automatic Cost Posting" THEN  BEGIN
            GLEntry.LOCKTABLE;
            IF GLEntry.FINDLAST THEN;
          END;
        END;
        */
        //UPGREV2.0<<
        // Insert receipt header
        PostedMaterialIssueHeader.LOCKTABLE;
        PostedMaterialIssueHeader.INIT;
        PostedMaterialIssueHeader."Issued DateTime" := CURRENTDATETIME;//B2B1.0
        PostedMaterialIssueHeader."Transfer-from Code" := MaterialIssueHeader."Transfer-from Code";
        PostedMaterialIssueHeader."Transfer-from Name" := MaterialIssueHeader."Transfer-from Name";
        PostedMaterialIssueHeader."Transfer-from Name 2" := MaterialIssueHeader."Transfer-from Name 2";
        PostedMaterialIssueHeader."Transfer-from Address" := MaterialIssueHeader."Transfer-from Address";
        PostedMaterialIssueHeader."Transfer-from Address 2" := MaterialIssueHeader."Transfer-from Address 2";
        PostedMaterialIssueHeader."Transfer-from Post Code" := MaterialIssueHeader."Transfer-from Post Code";
        PostedMaterialIssueHeader."Transfer-from City" := MaterialIssueHeader."Transfer-from City";
        PostedMaterialIssueHeader."Transfer-from County" := MaterialIssueHeader."Transfer-from County";
        PostedMaterialIssueHeader."Transfer-from Country Code" := MaterialIssueHeader."Transfer-from Country Code";
        PostedMaterialIssueHeader."Transfer-from Contact" := MaterialIssueHeader."Transfer-from Contact";
        PostedMaterialIssueHeader."Transfer-to Code" := MaterialIssueHeader."Transfer-to Code";
        PostedMaterialIssueHeader."Transfer-to Name" := MaterialIssueHeader."Transfer-to Name";
        PostedMaterialIssueHeader."Transfer-to Name 2" := MaterialIssueHeader."Transfer-to Name 2";
        PostedMaterialIssueHeader."Transfer-to Address" := MaterialIssueHeader."Transfer-to Address";
        PostedMaterialIssueHeader."Transfer-to Address 2" := MaterialIssueHeader."Transfer-to Address 2";
        PostedMaterialIssueHeader."Transfer-to Post Code" := MaterialIssueHeader."Transfer-to Post Code";
        PostedMaterialIssueHeader."Transfer-to City" := MaterialIssueHeader."Transfer-to City";
        PostedMaterialIssueHeader."Transfer-to County" := MaterialIssueHeader."Transfer-to County";
        PostedMaterialIssueHeader."Transfer-to Country Code" := MaterialIssueHeader."Transfer-to Country Code";
        PostedMaterialIssueHeader."Transfer-to Contact" := MaterialIssueHeader."Transfer-to Contact";
        PostedMaterialIssueHeader."Posting Date" := MaterialIssueHeader."Posting Date";
        PostedMaterialIssueHeader."Receipt Date" := MaterialIssueHeader."Receipt Date";
        PostedMaterialIssueHeader."Posted By" := USERID;
        PostedMaterialIssueHeader."Shortcut Dimension 1 Code" := MaterialIssueHeader."Shortcut Dimension 1 Code";
        PostedMaterialIssueHeader."Shortcut Dimension 2 Code" := MaterialIssueHeader."Shortcut Dimension 2 Code";
        PostedMaterialIssueHeader."Dimension Set ID" := MaterialIssueHeader."Dimension Set ID"; //DIM1.0
        PostedMaterialIssueHeader."Material Issue No." := MaterialIssueHeader."No.";
        PostedMaterialIssueHeader."External Document No." := MaterialIssueHeader."External Document No.";
        PostedMaterialIssueHeader."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
        PostedMaterialIssueHeader."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
        PostedMaterialIssueHeader."Prod. BOM No." := MaterialIssueHeader."Prod. BOM No.";
        PostedMaterialIssueHeader."Sales Order No." := MaterialIssueHeader."Sales Order No.";
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Resource Name" := MaterialIssueHeader."Resource Name";
        PostedMaterialIssueHeader."User ID" := MaterialIssueHeader."User ID";
        PostedMaterialIssueHeader."Required Date" := MaterialIssueHeader."Required Date";
        PostedMaterialIssueHeader."Released Date" := MaterialIssueHeader."Released Date";
        PostedMaterialIssueHeader."Released By" := MaterialIssueHeader."Released By";
        PostedMaterialIssueHeader."Released Time" := MaterialIssueHeader."Released Time";
        PostedMaterialIssueHeader."Reason Code" := MaterialIssueHeader."Reason Code";
        PostedMaterialIssueHeader.Remarks := MaterialIssueHeader.Remarks;
        PostedMaterialIssueHeader."Service Order No." := MaterialIssueHeader."Service Order No.";
        PostedMaterialIssueHeader."Service Item" := MaterialIssueHeader."Service Item";
        PostedMaterialIssueHeader."Service Item Serial No." := MaterialIssueHeader."Service Item Serial No.";
        PostedMaterialIssueHeader."Service Item Description" := MaterialIssueHeader."Service Item Description";
        PostedMaterialIssueHeader."No. Series" := InvtSetup."Posted Transfer Rcpt. Nos.";
        PostedMaterialIssueHeader."No." :=
            NoSeriesMgt.GetNextNo(
              InvtSetup."Posted Material Issue Nos.", MaterialIssueHeader."Posting Date", TRUE);
        PostedMaterialIssueHeader.INSERT;
        //DIM1.0 Start
        //Code Commneted
        /*
        DimMgt.MoveOneDocDimToPostedDocDim(
          TempDocDim,DATABASE::"Material Issues Header",TempDocDim."Document Type"::" ","No.",0,
          DATABASE::"Posted Material Issues Header",PostedMaterialIssueHeader."No.");
        */
        //DIM1.0 End
        CopyCommentLines(4, 5, MaterialIssueHeader."No.", PostedMaterialIssueHeader."No.");

        // Insert receipt lines
        LineCount := 0;
        PostedMaterialIssueLine.LOCKTABLE;
        //MaterialIssueLine.SETRANGE("Document No.","No.");
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETFILTER("Qty. to Receive", '>%1', 0);
        IF MaterialIssueLine.FINDSET THEN BEGIN
            REPEAT
                LineCount := LineCount + 1;
                //      Window.UPDATE(2,LineCount);
                IF MaterialIssueLine."Item No." <> '' THEN BEGIN
                    Item.GET(MaterialIssueLine."Item No.");
                    Item.TESTFIELD(Blocked, FALSE);
                END;
                PostedMaterialIssueLine.INIT;
                PostedMaterialIssueLine."Document No." := PostedMaterialIssueHeader."No.";
                PostedMaterialIssueLine2.SETRANGE("Document No.", PostedMaterialIssueHeader."No.");
                IF PostedMaterialIssueLine2.FINDLAST THEN
                    LineNo := PostedMaterialIssueLine2."Line No." + 10000
                ELSE
                    LineNo := 10000;
                PostedMaterialIssueLine."Line No." := LineNo;
                PostedMaterialIssueLine."Item No." := MaterialIssueLine."Item No.";
                // PostedMaterialIssueLine."Unit Cost":=MaterialIssueLine."Unit Cost";
                PostedMaterialIssueLine.Description := MaterialIssueLine.Description;
                PostedMaterialIssueLine.Quantity := MaterialIssueLine."Qty. to Receive";
                PostedMaterialIssueLine."Unit of Measure" := MaterialIssueLine."Unit of Measure";
                PostedMaterialIssueLine."Shortcut Dimension 1 Code" := MaterialIssueLine."Shortcut Dimension 1 Code";
                PostedMaterialIssueLine."Shortcut Dimension 2 Code" := MaterialIssueLine."Shortcut Dimension 2 Code";
                PostedMaterialIssueLine."Dimension Set ID" := MaterialIssueLine."Dimension Set ID"; //DIM1.0
                PostedMaterialIssueLine."Quantity (Base)" := MaterialIssueLine."Qty. to Receive (Base)";
                PostedMaterialIssueLine."Qty. per Unit of Measure" := MaterialIssueLine."Qty. per Unit of Measure";
                PostedMaterialIssueLine."Unit of Measure Code" := MaterialIssueLine."Unit of Measure Code";
                PostedMaterialIssueLine."Gross Weight" := MaterialIssueLine."Gross Weight";
                PostedMaterialIssueLine."Net Weight" := MaterialIssueLine."Net Weight";
                PostedMaterialIssueLine."Unit Volume" := MaterialIssueLine."Unit Volume";
                PostedMaterialIssueLine."Variant Code" := MaterialIssueLine."Variant Code";
                PostedMaterialIssueLine."Units per Parcel" := MaterialIssueLine."Units per Parcel";
                PostedMaterialIssueLine."Description 2" := MaterialIssueLine."Description 2";
                PostedMaterialIssueLine."Material Issue No." := MaterialIssueLine."Document No.";
                PostedMaterialIssueLine."Material Issue Line No." := MaterialIssueLine."Line No.";
                PostedMaterialIssueLine."Receipt Date" := MaterialIssueLine."Receipt Date";
                PostedMaterialIssueLine."Transfer-from Code" := MaterialIssueLine."Transfer-from Code";
                PostedMaterialIssueLine."Transfer-to Code" := MaterialIssueLine."Transfer-to Code";
                PostedMaterialIssueLine."Item Category Code" := MaterialIssueLine."Item Category Code";
                PostedMaterialIssueLine."Product Group Code" := MaterialIssueLine."Product Group Code";
                PostedMaterialIssueLine."Prod. Order No." := MaterialIssueHeader."Prod. Order No.";
                PostedMaterialIssueLine."Prod. Order Line No." := MaterialIssueHeader."Prod. Order Line No.";
                PostedMaterialIssueLine."Prod. Order Comp. Line No." := MaterialIssueLine."Prod. Order Comp. Line No.";//b2bsbk
                PostedMaterialIssueLine.Saleorderno := MaterialIssueHeader."Sales Order No.";
                PostedMaterialIssueLine."Production BOM No." := MaterialIssueLine."Production BOM No.";
                PostedMaterialIssueLine."Issued DateTime" := PostedMaterialIssueHeader."Issued DateTime";
                PostedMaterialIssueLine."Unit Cost" := MaterialIssueLine."Unit Cost";
                PostedMaterialIssueLine."Avg. unit cost" := MaterialIssueLine."Avg. unit cost";
                PostedMaterialIssueLine.Remarks := MaterialIssueLine.Remarks;
                //added by pranavi on 08-05-2015
                PostedMaterialIssueLine."Operation No." := MaterialIssueLine."Operation No.";
                PostedMaterialIssueLine.Dept := MaterialIssueLine.Dept;
                PostedMaterialIssueLine."Material Requisition Date" := MaterialIssueLine."Material Requisition Date";
                //end by pranavi


                /* IF (MaterialIssueHeader."Transfer-to Code" = 'STR') AND
                  ((MaterialIssueHeader."Transfer-from Code"<>'R&D STR') OR (MaterialIssueHeader."Transfer-from Code"<>'CS STR')) THEN
                 BEGIN
                  Mail_Subject:='Return materials';
                   Mail_Body:='Material is Returned Correposnding to '+MaterialIssueHeader."No.";
                 "Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                 IF "Mail-Id".FINDFIRST THEN
                  "from Mail":="Mail-Id".MailID;
                  "to mail":='dmadhavi@efftronics.com,mary@efftronics.com';
                  END;*/

                PostedMaterialIssueLine.INSERT;

                IF MaterialIssueLine."Qty. to Receive" > 0 THEN BEGIN
                    MaterialIssueLine.VALIDATE("Quantity Received",
                              MaterialIssueLine."Quantity Received" + MaterialIssueLine."Qty. to Receive");

                    MaterialIssueLine.VALIDATE("Qty. to Receive",
                              (MaterialIssueLine.Quantity - MaterialIssueLine."Quantity Received"));
                    OriginalQuantity := MaterialIssueLine."Qty. to Receive";
                    OriginalQuantityBase := MaterialIssueLine."Qty. to Receive (Base)";
                    //Rev01 Start
                    //Code Commented
                    /*
                     PostItemJnlLine(MaterialIssueLine,PostedMaterialIssueHeader,PostedMaterialIssueLine);
                    */
                    //Rev01 End
                    //Code Commented
                    PostItemJnlLine2013(MaterialIssueLine, PostedMaterialIssueHeader, PostedMaterialIssueLine);
                    PostedMaterialIssueLine."Item Rcpt. Entry No." := InsertRcptEntryRelation(PostedMaterialIssueLine);
                    PostedMaterialIssueLine.MODIFY;
                    MaterialIssueLine.MODIFY;
                END;

                //DIM1.0 Start
                /*
                DimMgt.MoveOneDocDimToPostedDocDim(
                  DocDim,DATABASE::"Material Issues Line",DocDim."Document Type"::" ","No.",MaterialIssueLine."Line No.",
                  DATABASE::"Posted Material Issues Line",PostedMaterialIssueLine."Document No.");
                */
                //DIM1.0 End

                //Delete Tracking Specification
                TrackingSpecification.SETRANGE("Order No.", MaterialIssueLine."Document No.");
                TrackingSpecification.SETRANGE("Order Line No.", MaterialIssueLine."Line No.");
                IF TrackingSpecification.FINDFIRST THEN
                    REPEAT
                        TrackingSpecification.DELETE;
                    UNTIL TrackingSpecification.NEXT = 0;
            UNTIL MaterialIssueLine.NEXT = 0;
        END;
        // Code For Mail Sending
        /*  IF ( "from Mail"<>'') AND ("to mail" <>'')  THEN
           mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');*/



        TempItemJnlLine.SETRANGE("Entry Type", TempItemJnlLine."Entry Type"::Transfer);
        TempItemJnlLine.SETRANGE("Document No.", MaterialIssueHeader."No.");
        IF TempItemJnlLine.FINDSET THEN
            REPEAT
                //      ItemJnlPostLine.RunWithCheck(TempItemJnlLine,TempJnlLineDim2);
                ItemJnlPostLine.RunWithCheck(TempItemJnlLine);//B2B
            UNTIL TempItemJnlLine.NEXT = 0;
        MaterialIssueLine.SETRANGE(Quantity);
        MaterialIssueLine.SETRANGE("Qty. to Receive");
        //  Window.CLOSE;
        HeaderDeleted := DeleteOrder_Local(MaterialIssueHeader, MaterialIssueLine);


        UpdateAnalysisView.UpdateAll(0, TRUE);
        REc := MaterialIssueHeader;

    end;


    local procedure UpdateMBBOpenCloseTimes(MITS: Record "Mat.Issue Track. Specification"; MILine: Record "Material Issues Line"; Returned: Boolean);
    var
        Itm: Record Item;
        MSL_ILE: Record "Item Ledger Entry";
        // DateAndTime2: DotNet DateAndTimeD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        DayofWeekInput: DotNet DayofWeekInputD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        WeekofYearInput: DotNet WeekofYearInputD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        ItemLedgEntry: Record "Item Ledger Entry";
        MIHdr: Record "Material Issues Header";
        PMI: Record "Posted Material Issues Header";
        UsrId: Code[30];

    begin
        IF Returned THEN BEGIN
            IF Itm.GET(MILine."Item No.") AND (Itm.MSL <> 0) AND NOT (Itm."Floor Life at 25 C 40% RH" IN ['', 'INFINITE']) THEN BEGIN
                MSL_ILE.RESET;
                MSL_ILE.SETCURRENTKEY("Item No.", "Entry Type");
                MSL_ILE.SETRANGE("Item No.", MILine."Item No.");
                MSL_ILE.SETRANGE("Entry Type", MSL_ILE."Entry Type"::Purchase);
                MSL_ILE.SETRANGE("Document Type", MSL_ILE."Document Type"::"Purchase Receipt");
                MSL_ILE.SETRANGE("Lot No.", MITS."Lot No.");
                IF MSL_ILE.FINDFIRST THEN BEGIN
                    ItemLedgEntry.RESET;
                    ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
                    ItemLedgEntry.SETRANGE("Item No.", MITS."Item No.");
                    ItemLedgEntry.SETRANGE("Variant Code", MITS."Variant Code");
                    ItemLedgEntry.SETRANGE("Location Code", MITS."Location Code");
                    ItemLedgEntry.SETRANGE(Open, TRUE);
                    IF (MITS."Location Code" = 'SITE') OR (MITS."Location Code" = 'OLD STOCK') THEN BEGIN
                        MIHdr.RESET;
                        MIHdr.SETRANGE(MIHdr."No.", MITS."Order No.");
                        IF MIHdr.FINDFIRST THEN BEGIN
                            ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", MIHdr."Shortcut Dimension 2 Code");
                        END;
                    END ELSE
                        IF MITS."Location Code" = 'CS' THEN BEGIN
                            ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", 'H-OFF');
                        END;
                    ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                    ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');
                    IF ItemLedgEntry.FINDSET THEN BEGIN
                        IF ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Transfer THEN BEGIN
                            PMI.RESET;
                            PMI.SETRANGE(PMI."No.", ItemLedgEntry."Document No.");
                            IF PMI.FINDFIRST THEN BEGIN
                                // MSL_ILE."Floor Life" += DateAndTimeCust.DateDiff('H', PMI."Issued DateTime", CURRENTDATETIME, DayofWeekInput, WeekofYearInput);//EFFUPG
                                V1 := PMI."Issued DateTime";
                                V2 := CURRENTDATETIME;
                                D1 := V1;
                                D2 := V2;
                                /*
                                OutPutD := DateAndTimeCust.DateDiff('H', D1, D2, DayofWeekInput, WeekofYearInput);//EFFUPG
                                OutPutVariant := OutPutD;
                                OutPutInt := OutPutVariant;
                                 MSL_ILE."Floor Life" += OutPutInt;
                                MSL_ILE.MODIFY;
                                */
                            END;
                        END;
                    END;
                END;
            END;
        END ELSE BEGIN
            IF Itm.GET(MILine."Item No.") AND (Itm.MSL <> 0) AND NOT (Itm."Floor Life at 25 C 40% RH" IN ['', 'INFINITE']) THEN BEGIN
                MSL_ILE.RESET;
                MSL_ILE.SETCURRENTKEY("Item No.", "Entry Type");
                MSL_ILE.SETRANGE("Item No.", MILine."Item No.");
                MSL_ILE.SETRANGE("Entry Type", MSL_ILE."Entry Type"::Purchase);
                MSL_ILE.SETRANGE("Document Type", MSL_ILE."Document Type"::"Purchase Receipt");
                MSL_ILE.SETRANGE("Lot No.", MITS."Lot No.");
                IF MSL_ILE.FINDFIRST THEN BEGIN
                    MSL_ILE."MBB Packet Open DateTime" := MILine."MBB Packet Open DateTime";
                    MSL_ILE."MBB Packet Close DateTime" := MILine."MBB Packet Close DateTime";
                    //EFFUPG>>
                    // IF (DateAndTimeCust.DateDiff('N', MILine."MBB Packet Open DateTime", MILine."MBB Packet Close DateTime", DayofWeekInput, WeekofYearInput)) > 15 THEN BEGIN
                    //  MSL_ILE."Floor Life" += ROUND((DateAndTimeCust.DateDiff('N', MILine."MBB Packet Open DateTime", MILine."MBB Packet Close DateTime", DayofWeekInput, WeekofYearInput)) / 60, 0.01);
                    V1 := MILine."MBB Packet Open DateTime";
                    V2 := MILine."MBB Packet Close DateTime";
                    D1 := V1;
                    D2 := V2;
                    /*
                     IF (DateAndTimeCust.DateDiff('N', D1, D2, DayofWeekInput, WeekofYearInput)) > 15 THEN BEGIN
                         MSL_ILE."Floor Life" += ROUND((DateAndTimeCust.DateDiff('N', D1, D2, DayofWeekInput, WeekofYearInput)) / 60, 0.01);
                         //EFFUPG<<

                         MSL_ILE.MODIFY;
                     END;
                     */
                END;
            END;
        END;
    end;


    procedure DataDumptoPicking(IssuesLine: Record "Posted Material Issues Line"; IssuesHeader: Record "Posted Material Issues Header");
    var
        "Count": Integer;
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        SQLQuery: Text[1000];

        RowCount: Integer;
        DocumentNo: Text;
        TotAmt: Decimal;
        Amt: Decimal;
        StartDt: Date;
        EndDt: Date;
        SysDate: Text;
        SysDate1: Text;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Autopost: Integer;
        QTY: Text;
        descbuff: Text[200];
        i: Integer;
    begin
        /* IF ISCLEAR(SQLConnection) THEN
             CREATE(SQLConnection, FALSE, TRUE);
         IF ISCLEAR(RecordSet) THEN
             CREATE(RecordSet, FALSE, TRUE);*/
        //>> ORACLE UPG
        /*  SQLConnection.ConnectionString := 'DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER:=erpserver;providerName=System.Data.SqlClient;';
         SQLConnection.Open; */
        //<< ORACLE UPG
        IF IssuesHeader."Auto Post" = TRUE THEN
            Autopost := 1
        ELSE
            Autopost := 0;
        QTY := FORMAT(IssuesLine.Quantity);
        //added by vishnu priya on 16-09-2019
        descbuff := '';
        FOR i := 1 TO STRLEN(IssuesLine.Description) DO BEGIN
            IF COPYSTR(IssuesLine.Description, i, 1) <> '''' THEN
                descbuff += COPYSTR(IssuesLine.Description, i, 1);
        END;

        //end by vishnu priya on 16-09-2019
        /*SQLQuery:= 'INSERT INTO STORE_MAPD(PMI_NO, MATERIAL_REQUEST_NO, ITEM_NO, ITEM_DESCRIPTION, QUANTITY, UOM, REQUESTED_PERSON, ' +
                    'POSTING_DATE, TRANSFER_FROM_LOCATION, TRANSFER_TO_LOCATION, AUTO_POST) VALUES ('''+
                     IssuesHeader."No." +''','''+ IssuesHeader."Material Issue No." +''','''+ IssuesLine."Item No."+''','''+
                      IssuesLine.Description+''','+ CommaRemoval(QTY)+','''+ IssuesLine."Unit of Measure"+''','''+
                      IssuesHeader."User ID"+''',GETDATE(),'''+ IssuesHeader."Transfer-from Code"+''','''+
                      IssuesHeader."Transfer-to Code"+''','+ FORMAT(Autopost)+')';
                      */
        SQLQuery := 'INSERT INTO STORE_MAPD(PMI_NO, MATERIAL_REQUEST_NO, ITEM_NO, ITEM_DESCRIPTION, QUANTITY, UOM, REQUESTED_PERSON, ' +
                    'POSTING_DATE, TRANSFER_FROM_LOCATION, TRANSFER_TO_LOCATION, AUTO_POST) VALUES (''' +
                     IssuesHeader."No." + ''',''' + IssuesHeader."Material Issue No." + ''',''' + IssuesLine."Item No." + ''',''' +
                      descbuff + ''',' + CommaRemoval(QTY) + ',''' + IssuesLine."Unit of Measure" + ''',''' +
                      IssuesHeader."User ID" + ''',GETDATE(),''' + IssuesHeader."Transfer-from Code" + ''',''' +
                      IssuesHeader."Transfer-to Code" + ''',' + FORMAT(Autopost) + ')';


        //IF USERID = 'EFFTRONICS\VIJAYA' THEN
        // MESSAGE(SQLQuery);
        //>> ORACLE UPG
        /* IF SQLQuery <> '' THEN
            SQLConnection.Execute(SQLQuery); */
        //<< ORACLE UPG

        /*SQLQuery := 'INSERT INTO STORE_MAPD(PMI_NO, MATERIAL_REQUEST_NO, ITEM_NO, ITEM_DESCRIPTION, QUANTITY, UOM, REQUESTED_PERSON,'+
                'POSTING_DATE, TRANSFER_FROM_LOCATION, TRANSFER_TO_LOCATION, AUTO_POST) VALUES (''';*/

    end;


    local procedure CommaRemoval(Base: Text[30]) Converted: Text;
    var
        i: Integer;
    begin
        //UPGRev2.0>>
        /*
        FOR i:=1 TO STRLEN(Base) DO
        BEGIN
          IF COPYSTR(Base,i,1)<>',' THEN
            Converted+=COPYSTR(Base,i,1);
        END;
        EXIT(Converted);
        */


        Converted := DELCHR(Base, '=', ',');
        EXIT(Converted);
        //UPGRev2.0<<

    end;


    procedure BulkPostingStatusUpdate();
    begin
        BulkPosting := TRUE;
    end;

    Var
        DateAndTimeCust: DotNet DateAndTime;
        V1: Variant;
        V2: Variant;
        D1: DotNet DateTime;
        D2: DotNet DateTime;
        OutPutD: DotNet Int32;
        OutPutInt: Integer;
        OutPutVariant: Variant;

}

