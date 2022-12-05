tableextension 70013 PurhaseheaderExt extends "Purchase Header"
{
    fields
    {
        modify("Order Date")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                PurchLine: Record "Purchase Line";
            begin
                PurchLine.SETFILTER(PurchLine."Document No.", "No.");
                IF PurchLine.FindFirst() then
                    REPEAT
                        PurchLine."Order Date" := "Order Date";
                        PurchLine.MODIFY;
                    UNTIL PurchLine.NEXT = 0;

                GLSetup.GET;

                IF NOT (("Order Date" >= GLSetup."Allow Posting From") AND
                       ("Order Date" >= GLSetup."Allow Posting To")) then
                    ;
                //ERROR('ORDER DATE IS NOT IN SYSTEM RANGE , ONCE CHECK THE ORDER DATE');
            end;
        }
        modify("Payment Terms Code")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                GLSetup.GET;
                IF GLSetup."Active ERP-CF Connection" THEN
                    Cashflow_Modification; // GST
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin

                //added by mnraju
                IF "Location Code" = 'STR' THEN
                    "Shortcut Dimension 1 Code" := 'PRD-0010'
                ELSE
                    IF "Location Code" = 'R&D STR' THEN
                        "Shortcut Dimension 1 Code" := 'RD-000'
                    ELSE
                        IF "Location Code" = 'CS STR' THEN
                            "Shortcut Dimension 1 Code" := 'CUS-005';

                //added by mnraju

            end;
        }
        /* field(70003; "Buy-from Address 21"; Text[100])
        {
            DataClassification = CustomerContent;
        } */
        modify("No.")
        {
            CaptionML = ENU = 'Purchase Order No', ENN = 'Purchase Order No';
        }
        modify("Pay-to Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', ENN = 'Vendor No.';
        }
        modify("Vendor Cr. Memo No.")
        {
            CaptionML = ENU = 'Debit Note No.', ENN = 'Debit Note No.';
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            begin
                //B2BUPG>>
                // Added by Pranavi on 22-Jul-2016 for TIN No of vendor checking
                /*  IF "Document Type" = "Document Type"::Order THEN BEGIN
                     Vndr.RESET;
                     Vndr.SETRANGE(Vndr."No.", PurchHeader."Buy-from Vendor No.");
                     IF Vndr.FINDFIRST THEN
                         IF Vndr."Gen. Bus. Posting Group" <> 'FOREIGN' THEN
                             IF (Vndr."T.I.N. No." = '') AND (Vndr."T.I.N Status" IN [Vndr."T.I.N Status"::" ", Vndr."T.I.N Status"::TINAPPLIED]) THEN
                                 ERROR('Please enter T.I.N Number in Vendor Card in Tax Information Tab!\IF TIN Not Applicable update TIN Status to TIN Invalid!');
                 END;
                 // end by pranavi */
                //B2BUPG<<
            end;
        }
        field(50000; "MSPT Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Status, Status::Open);

                MSPTOrderDetails.SetRange(Type, MSPTOrderDetails.Type::Purchase);
                MSPTOrderDetails.SetRange("Document Type", "Document Type");
                MSPTOrderDetails.SetRange("Document No.", "No.");
                if MSPTOrderDetails.FindFirst then begin
                    repeat
                        MSPTOrderDetails."Due Date" := CalcDate(MSPTOrderDetails."Calculation Period", Rec."MSPT Date");
                        MSPTOrderDetails.Modify;
                    until MSPTOrderDetails.Next = 0;
                end;
            end;
        }
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT1.0';
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                MSPTHeader: Record "MSPT Header";
                "MSPT Details": Record "MSPT Line";
            begin
                TestField(Status, Status::Open);

                MSPTOrderDetails.SetRange(Type, MSPTOrderDetails.Type::Purchase);
                MSPTOrderDetails.SetRange("Document Type", "Document Type");
                MSPTOrderDetails.SetRange("Document No.", "No.");
                MSPTOrderDetails.DeleteAll;

                MSPTHeader.SetRange(MSPTHeader.Code, "MSPT Code");
                if MSPTHeader.FindFirst then begin
                    "MSPT Details".SetRange("MSPT Details"."MSPT Header Code", "MSPT Code");
                    if "MSPT Details".FindFirst then begin
                        repeat
                            MSPTOrderDetails.Type := MSPTOrderDetails.Type::Purchase;
                            MSPTOrderDetails."Document Type" := "Document Type";
                            MSPTOrderDetails."Document No." := "No.";
                            MSPTOrderDetails."Party Type" := MSPTOrderDetails."Party Type"::Vendor;
                            MSPTOrderDetails."Party No." := "Buy-from Vendor No.";
                            MSPTOrderDetails."MSPT Header Code" := "MSPT Code";
                            //MSPTOrderDetails."Calculation Type" := MSPTHeader.Type;
                            MSPTOrderDetails."MSPT Code" := "MSPT Details".Code;
                            MSPTOrderDetails."MSPT Line No." := "MSPT Details"."Line No.";
                            MSPTOrderDetails.Percentage := "MSPT Details".Percentage;
                            //MSPTOrderDetails.Amount:="MSPT Details".Amount;
                            MSPTOrderDetails.Description := "MSPT Details".Description;
                            MSPTOrderDetails."Calculation Period" := "MSPT Details"."Calculation Period";
                            MSPTOrderDetails.Remarks := "MSPT Details".Remarks;
                            PurchHeader.Get(MSPTOrderDetails."Document Type", MSPTOrderDetails."Document No.");
                            MSPTOrderDetails."Due Date" := CalcDate(MSPTOrderDetails."Calculation Period", "MSPT Date");
                            MSPTOrderDetails.Insert;
                        until "MSPT Details".Next = 0;
                    end;
                end;
            end;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT1.0';
            DataClassification = CustomerContent;
        }
        field(60000; "Amount to Vendor"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Amount To Vendor" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(60001; "Vendor Excise Invoice No."; Code[10])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Vend. Excise Inv. Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Cancel Short Close"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Cancelled,Short Closed"';
            OptionMembers = " ",Cancelled,"Short Closed";
            DataClassification = CustomerContent;
        }
        field(60004; "RFQ No."; Code[10])
        {
            Description = 'B2B';
            TableRelation = "Mech & Wirning Items"."Production Order No.";
            DataClassification = CustomerContent;
        }
        field(60005; Make; Text[50])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60006; "Packing Type"; Text[25])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; Verification; Text[50])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60008; "Quotation No."; Code[30])
        {
            Description = 'PH1.0';
            DataClassification = CustomerContent;
        }
        field(60009; "ICN No."; Code[10])
        {
            Description = 'PH1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60010; "Release Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60011; "Tender No"; Code[20])
        {
            TableRelation = "Tender Header"."Tender No.";
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(60012; "Sale Order No"; Code[30])
        {
            TableRelation = "Sales Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60013; "Bill Received"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60014; "Duplicate For Transporter"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Quotation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60020; "Purchase Journal"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60021; "Calculate Tax Structure"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60079; "Order (Digits)"; Code[10])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60090; "Buy-from Address 3"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60095; "Actual Invoiced Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60096; "Additional Duty Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60097; "Type of Supplier"; Option)
        {
            OptionCaption = '" ,Manufacturer,First Stage Dealer,Importer"';
            OptionMembers = " ",Manufacturer,"First Stage Dealer",Importer;
            DataClassification = CustomerContent;
        }
        field(60098; "Inclusive of All Taxes"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60100; "Vehicle Number"; Text[12])
        {
            DataClassification = CustomerContent;
        }
        field(60101; "Transporter Name"; Text[20])
        {
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(60102; "C-Form Number"; Code[20])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60103; "C-Form Issue Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }

        field(60111; "Buy From Address2 New"; Text[100])
        {

            DataClassification = CustomerContent;

        }
        field(60115; "OrderCreated by"; Code[35])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60116; "Released By"; Code[35])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60117; Mail_Sent; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60118; "Way bill"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60119; Mail_count; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60120; "Acknowledge Given by"; Text[15])
        {
            DataClassification = CustomerContent;
        }
        field(60121; "Acknowledged Dt"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Tarrif Heading No"; Code[35])
        {
            DataClassification = CustomerContent;
            Enabled = false;
        }
        field(60123; QA_Auth_Status; Option)
        {
            OptionMembers = " ","Sent For Auth",Authorized,Rejected;
            DataClassification = CustomerContent;
        }
        field(60124; QA_Auth_Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60125; "First Release DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60126; "First Release By"; Code[35])
        {
            DataClassification = CustomerContent;
        }
        field(60128; "USER ID"; Code[35])
        {
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60129; "Do not Consider GST"; Boolean)
        {
            Description = 'Do not Consider GST in cashflow or not';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Payment Terms Code" <> 'TOTADV' then
                    Error('This is only applicable for TOTAL ADVANCE payment terms');
            end;
        }
        field(70000; "Sales Order Ref No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                PrevDocNo: Code[30];
            begin
                /*
                IF "USER ID" IN['EFFTRONICS\SUSMITHAL','EFFTRONICS\YESU','EFFTRONICS\PADJAMAM','EFFTRONICS\B2BOTS'] THEN BEGIN
                  CLEAR(SalesListArchive);
                  PrevDocNo := '';
                  SalesHeaderArchive.RESET;
                  SalesHeaderArchive.SETCURRENTKEY("Date Archived","Time Archived");
                  //SalesHeaderArchive.ASCENDING(FALSE);
                  SalesHeaderArchive.SETRANGE("Document Type",SalesHeaderArchive."Document Type"::Order);
                  IF SalesHeaderArchive.FINDSET THEN
                    REPEAT
                      IF PrevDocNo <> SalesHeaderArchive."No." THEN BEGIN
                        SalesHeaderArchive.MARK(TRUE);
                        PrevDocNo := SalesHeaderArchive."No.";
                      END;
                    UNTIL SalesHeaderArchive.NEXT = 0;
                  SalesHeaderArchive.MARKEDONLY(TRUE);
                  SalesListArchive.SETRECORD(SalesHeaderArchive);
                  SalesListArchive.SETTABLEVIEW(SalesHeaderArchive);
                  SalesListArchive.LOOKUPMODE(TRUE);
                  IF SalesListArchive.RUNMODAL =ACTION::LookupOK THEN BEGIN
                    SalesListArchive.GETRECORD(SalesHeaderArchive);
                    "Sales Order Ref No." := SalesHeaderArchive."No.";
                  END;
                END;
                */

            end;
        }
        //B2BPGOn15Nov2022>>>
        field(70004; "Vendor Shipment No.1"; Code[98])
        {
            DataClassification = CustomerContent;
        } //B2BPGOn15Nov2022>>>                                           

        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95402; "Buy-from Address1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Buy-from Address21"; Text[100])
        {
            DataClassification = CustomerContent;
        }


    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        //B2B-MSPT1.0
        IF "Document Type" = "Document Type"::Order THEN
            "MSPT Date" := "Posting Date"
        ELSE
            IF "Document Type" = "Document Type"::Quote THEN
                "MSPT Date" := "Document Date";
        //B2B-MSPT1.0
        "Bill Received" := TRUE;
        "Packing Type" := 'Standard Packing';
        "Shortcut Dimension 1 Code" := 'PRD-0010';
        "USER ID" := USERID;
    END;



    trigger OnModify()
    var
        myInt: Integer;
    begin
        // Cashflow_Modification;
        "USER ID" := USERID;
    end;

    trigger OnBeforeDelete()
    var
        PurchLine: Record "Purchase Line";
    begin
        /*  {IF NOT (USERID IN['EFFTRONICS\PRANAVI','EFFTRONICS\ANILKUMAR','EFFTRONICS\ANVESH','EFFTRONICS\SPURTHI','EFFTRONICS\VIJAYA']) THEN    //Added by Pranavi on 03-Dec-2015
                 ERROR('You Do Not Have Rights to Delete!');}*/

        // added on 18-SEP-2017 To provide the provision of deleting empty purchase order lines for the Purchase Department
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'])
        THEN BEGIN
            UserDetails.RESET;
            UserDetails.SETRANGE("User Name", USERID);
            IF UserDetails.FINDSET THEN BEGIN
                //IF UserDetails.Dept IN ['CR ROOM', 'F&A'] THEN BEGIN//B2BESGOn18Jun2022
                PurchLine.RESET;
                PurchLine.SETRANGE("Document No.", "No.");
                IF PurchLine.FINDFIRST
                  THEN
                    ERROR('You Don''t Have Rights to Delete Purchase Order(Empty Line)');
                //B2BESGOn18Jun2022 ++      
                /*END ELSE
                    ERROR('You Don''t Have Rights to Delete Purchase Order');*/
                //B2BESGOn18Jun2022 --
            END
            ELSE
                ERROR('You Don''t Have Rights to Delete Purchase Order');
        END;

        //--------------------------------------------------------------

        //  Cashflow_Modification;
        //EFFUPG Start
        /* {
         IF Status = Status:: Released THEN
           ERROR(Text043,"No.");
         }*/
        //EFFUPG End
    end;



    PROCEDURE CreateReturnOrder();
    BEGIN
        InspectJnlLine.CreateReturnOrder(Rec, 0);
    END;


    PROCEDURE CreateCreditmemo();
    BEGIN
        InspectJnlLine.CreateCreditMemo(Rec, 0);
    END;



    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR PurchaseHeader: Record "Purchase Header");
    VAR
        Text050: Label 'ENU=You cannot Canel/Short Close the order,Invoice is pending for Line No. %1 and Order No. %2';
        Text051: Label 'ENU=You cannot Canel/Short Close the order,Return Qty. Invoice is pending for Line No. %1 and Order No. %2';
        PurchLine: Record "Purchase Line";
    BEGIN
        //Rev01
        IF (OrderStatus = 'Cancel') OR (OrderStatus = 'Close') THEN BEGIN
            Cashflow_Modification;

            /* IF ISCLEAR(SQLConnection) THEN
                 CREATE(SQLConnection, FALSE, TRUE); //Rev01
             IF ISCLEAR(RecordSet) THEN
                 CREATE(RecordSet, FALSE, TRUE); //Rev01*/

            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;
            "G|l".GET;
            //>> ORACLE UPG

            /*  SQLConnection.ConnectionString := "G|l"."Sql Connection String";
             SQLConnection.Open;

             SQLConnection.BeginTrans; */
            //<< ORACLE UPG

        END;

        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        IF PurchLine.FINDFIRST THEN BEGIN
            REPEAT
                IF PurchLine."Qty. Rcd. Not Invoiced" <> 0 THEN
                    ERROR(Text050, PurchLine."Line No.", PurchaseHeader."No.");
                IF PurchLine."Return Qty. Shipped Not Invd." <> 0 THEN
                    ERROR(Text051, PurchLine."Line No.", PurchaseHeader."No.");
                SQLQuery := 'UPDATE PURCHASE_LINE SET SHORT_CLOSE_QTY=''' + CommaRemoval(FORMAT(ROUND(PurchLine."Qty. to Receive", 0.01))) + '''' +
                           ' WHERE ORDERNO=''' + PurchLine."Document No." + '''' +
                           'AND ORDER_LINE_NO=''' + FORMAT(PurchLine."Line No.") + '''';


            // RecordSet := SQLConnection.Execute(SQLQuery);//B2B //>> ORACLE UPG

            UNTIL PurchLine.NEXT = 0;
        END;

        IF OrderStatus = 'Close' THEN BEGIN
            "Cancel Short Close" := "Cancel Short Close"::"Short Closed";
            MODIFY;
        END;
        IF OrderStatus = 'Cancel' THEN BEGIN
            "Cancel Short Close" := "Cancel Short Close"::Cancelled;
            MODIFY;
        END;
        ArchiveManagement.ArchivePurchDocument(PurchaseHeader);

        PurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchLine.DELETEALL;

        PurchaseHeader.DELETE;
        //>> ORACLE UPG
        /*  SQLConnection.CommitTrans;
         SQLConnection.Close; */
        //<< ORACLE UPG
        //Rev01
    END;


    PROCEDURE CopyIndent();
    VAR
        Text60000: label 'ENU=&Indent,Indent &Lines';
    BEGIN
        Selection := STRMENU(Text60000, 1);
        IF Selection = 0 THEN
            EXIT;
        IF Selection = 1 THEN BEGIN
            IndentHeader.SETRANGE("Released Status", IndentHeader."Released Status"::Released);
            IndentHeader.SETRANGE(IndentHeader."Indent Status", IndentHeader."Indent Status"::Indent);
            IF PAGE.RUNMODAL(PAGE::"Indent List", IndentHeader) = ACTION::LookupOK THEN BEGIN
                TransferIndentToDoc;
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                    IndentHeader."Indent Status" := IndentHeader."Indent Status"::Order;
                    IndentHeader.MODIFY;
                END;
                IF "Document Type" = "Document Type"::Quote THEN BEGIN
                    IndentHeader."Indent Status" := IndentHeader."Indent Status"::Offer;
                    IndentHeader.MODIFY;
                END;
            END;
        END ELSE BEGIN
            IndentLine.RESET;
            IndentLine.SETRANGE("Release Status", IndentLine."Release Status"::Released);
            IndentLine.SETRANGE("Indent Status", IndentLine."Indent Status"::Indent);
            IF PAGE.RUNMODAL(PAGE::"Indent Line", IndentLine) = ACTION::LookupOK THEN BEGIN
                IndentLine.LOCKTABLE;
                IndentLine.SETRANGE(IndentLine."Set Selection", TRUE);
                IF IndentLine.FINDFIRST THEN
                    PurchLine1.SETRANGE("Document Type", "Document Type");
                PurchLine1.SETRANGE("Document No.", "No.");
                IF PurchLine1.FINDLAST THEN
                    PurchLineNo := PurchLine1."Line No."
                ELSE
                    PurchLineNo := 0;
                REPEAT
                    CopyIndentLineToQuote(IndentLine);
                UNTIL IndentLine.NEXT = 0;
                IndentLine.MODIFYALL("Set Selection", FALSE);
            END;
            IndentLine.SETRANGE(IndentLine."Set Selection", TRUE);
            IndentLine.MODIFYALL("Set Selection", FALSE);
        END;
    END;


    PROCEDURE TransferIndentToDoc();
    VAR
        PLine: Record "Purchase Line";
        IndLine: Record "SMTP SETUP";
    BEGIN
        IndentLine.RESET;
        IndentLine.LOCKTABLE;
        IndentLine.SETRANGE("Document No.", IndentHeader."No.");

        IF IndentLine.FINDFIRST THEN
            REPEAT
                CopyIndentLineToQuote(IndentLine);
            UNTIL IndentLine.NEXT = 0;
    END;


    PROCEDURE CopyIndentLineToQuote(VAR IndentLine2: Record "Indent Line");
    VAR
        BUFFER: Code[10];
        ITEM: Record Item;
        Temp: Integer;
        PLine: Record "Purchase Line";
    BEGIN
        PurchLine1.INIT;
        PurchLine1."Document Type" := "Document Type";
        PurchLine1."Document No." := "No.";
        PurchLineNo := PurchLineNo + 10000;
        PurchLine1."Line No." := PurchLineNo;
        PurchLine1."Buy-from Vendor No." := "Buy-from Vendor No.";

        IF IndentLine2.Type = IndentLine2.Type::Item THEN BEGIN
            PurchLine1.Type := PurchLine1.Type::Item;
            PurchLine1.VALIDATE("No.", IndentLine2."No.");
            //PurchLine1."Production Order" := IndentLine2."Production Order";
            //PurchLine1."Production Order Line No." := IndentLine2."Production Order Line No.";
            //PurchLine1."Drawing No." := IndentLine2."Drawing No.";
            //PurchLine1."Sub Operation No." := IndentLine2."Operation No.";
            //PurchLine1."Sub Routing No." := IndentLine2."Routing No.";
            PurchLine1.VALIDATE(Quantity, IndentLine2.Quantity);
            PurchLine1.VALIDATE("Unit of Measure", IndentLine2."Unit of Measure");
            PurchLine1.VALIDATE("Direct Unit Cost", IndentLine2."Unit Cost");
            PurchLine1.VALIDATE(PurchLine1."Location Code", IndentLine2."Delivery Location");
        END ELSE
            IF IndentLine2.Type = IndentLine2.Type::Miscellaneous THEN BEGIN
                PurchLine1.Type := PurchLine1.Type::"G/L Account";
                PurchLine1.VALIDATE("No.", IndentLine2."G/L Account");
                PurchLine1.VALIDATE(Quantity, IndentLine2.Quantity);
                PurchLine1.VALIDATE("Description 2", IndentLine2."No.");
                PurchLine1.VALIDATE("Unit of Measure", IndentLine2."Unit of Measure");
                PurchLine1.VALIDATE("Direct Unit Cost", IndentLine2."Unit Cost");
            END;

        PurchLine1.Description := IndentLine2.Description;
        PurchLine1."Indent No." := IndentLine2."Document No.";
        PurchLine1."Indent Line No." := IndentLine2."Line No.";
        PurchLine1."ICN No." := IndentLine2."ICN No.";
        //PurchLine1."Indent Due Date" := IndentLine2."Due Date";
        //PurchLine1."Promised Receipt Date" := IndentLine2."Due Date";
        //PurchLine1."Indent Reference" := IndentLine2."Indent Reference";

        // Added by Pranavi on 11-Feb-2017
        BUFFER := '+0';
        Temp := 0;
        PurchLine1."Requested Receipt Date" := "Requested Receipt Date";
        PurchLine1."Expected Receipt Date" := "Expected Receipt Date";
        PurchLine1."Deviated Receipt Date" := "Expected Receipt Date";
        IF ITEM.GET(PurchLine1."No.") THEN BEGIN
            IF NOT (FORMAT(ITEM."Safety Lead Time") IN ['', ' ']) THEN BEGIN
                BUFFER := '+' + FORMAT(ITEM."Safety Lead Time");
                EVALUATE(Temp, COPYSTR(FORMAT(ITEM."Safety Lead Time"), 1, STRLEN(FORMAT(ITEM."Safety Lead Time")) - 1));
                PurchLine1."Expected Receipt Date" := CALCDATE(BUFFER, TODAY);
                PurchLine1."Deviated Receipt Date" := CALCDATE(BUFFER, TODAY);
                IF TODAY + Temp > "Expected Receipt Date" THEN BEGIN
                    "Expected Receipt Date" := TODAY + Temp;
                END;
                IF TODAY + (Temp - 3) < "Requested Receipt Date" THEN BEGIN
                    // Start--Added by Pranavi on 11-Feb-2017 for correcting Dev & Exp Recp Dates Calc
                    PLine.RESET;
                    PLine.SETRANGE(PLine."Document Type", PLine."Document Type"::Order);
                    PLine.SETRANGE(PLine."Document No.", "No.");
                    PLine.SETFILTER(PLine."No.", '<>%1', '');
                    PLine.SETFILTER(PLine.Quantity, '>%1', 0);
                    IF PLine.FINDSET THEN
                        REPEAT
                            IF PLine."Requested Receipt Date" = "Requested Receipt Date" THEN BEGIN
                                PLine."Requested Receipt Date" := TODAY + (Temp - 3);
                                PLine.MODIFY;
                            END;
                        UNTIL PLine.NEXT = 0;
                    // End--Added by Pranavi on 11-Feb-2017 for correcting Dev & Exp Recp Dates Calc
                    "Requested Receipt Date" := TODAY + (Temp - 3);
                    PurchLine1."Requested Receipt Date" := "Requested Receipt Date";
                END;
            END;
        END;
        // End by pranavi on 11-Feb-2017

        PurchLine1.INSERT;


        IF "Document Type" = "Document Type"::Quote THEN BEGIN
            IF IndentLine2."Indent Status" < IndentLine2."Indent Status"::Offer THEN
                IndentLine2."Indent Status" := IndentLine2."Indent Status"::Offer;
        END ELSE
            IndentLine2."Indent Status" := IndentLine2."Indent Status"::Order;
        IndentLine2.MODIFY;
    END;


    PROCEDURE CommaRemoval(Base: Text[30]) Converted: Text[30];
    VAR
        i: Integer;
    BEGIN
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    END;


    PROCEDURE Cashflow_Modification();
    BEGIN

        /* //Rev01{
         GLSetup.GET;
         IF GLSetup."Active ERP-CF Connection" THEN BEGIN
             IF ISCLEAR(SQLConnection) THEN
                 CREATE(SQLConnection, FALSE, TRUE); //Rev01
             IF ISCLEAR(RecordSet) THEN
                 CREATE(RecordSet, FALSE, TRUE); //Rev01
             WebRecStatus := Quotes + Text50001 + Quotes;
             OldWebStatus := Quotes + Text50002 + Quotes;
             //SQLConnection.ConnectionString :=GLSetup."Sql Connection String";
             SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
             SQLConnection.Open;
             SQLConnection.BeginTrans;

             SQLQuery := 'select orderno from PURCHASE_ORDER_STATUS where orderno=''' + "No." + ''' and (authorisation=1 or status=''Y'') and '
                       + 'payment_type in (''Advance'',''COD'',''Billed'')';
             RecordSet := SQLConnection.Execute(SQLQuery);
             SQLConnection.CommitTrans;

             IF NOT (USERID IN ['EFFTRONICS\20TE099', 'EFFTRONICS\VISHNUPRIYA']) // added on 07-MAY-18  ,'EFFTRONICS\VISHNUPRIYA'
             THEN BEGIN
                 IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                     SQLConnection.Close;
                     ERROR('PAYMENT COMPLETED, SO YOU MUST NOT SHORT CLOSE (OR) CANCEL THE ORDER');

                 END;
                 SQLConnection.Close;
             END
             ELSE
                 SQLConnection.Close; // added by vishnu on 02-12-2020 for the  testings
         END;




         */
        //Rev01}
    END;

    PROCEDURE ExtenalDocNo(InvoiceNos: Option " ",ExciseInv,ServiceInv,TradingInv,InstInv; PostingDate: Date);
    VAR
        temp: Integer;
        SalesHeadLRec: Record "Sales Header";
        Fyear: Integer;
        POSTEDINVOICE: Record "Sales Invoice Header";
        y: Text;
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchHdr: Record "Purchase Header";
        StrPosOfSlace: Integer;
        Fyear_New: Code[10];
    BEGIN
        // Added by Pranavi on 05-Dec-2016 for Vendor Debit Note No.Series Generation
        temp := 0;
        StrPosOfSlace := 0;

        IF DATE2DMY(PostingDate, 2) <= 3 THEN
            Fyear := DATE2DMY(PostingDate, 3) - 1
        ELSE
            Fyear := DATE2DMY(PostingDate, 3);

        Fyear_New := '\' + FORMAT(Fyear) + '-' + COPYSTR(FORMAT(Fyear + 1), 3, 2);

        /*{
        PurchHdr.RESET;
        PurchHdr.SETFILTER(PurchHdr."Document Type",'Credit Memo');
        PurchHdr.SETFILTER(PurchHdr."Vendor Cr. Memo No.",'<>%1','');
        IF PurchHdr.FINDSET THEN
        REPEAT
          PurchHdr."Vendor Cr. Memo No.":='';
          PurchHdr.MODIFY;
        UNTIL PurchHdr.NEXT=0;

        PurchHdr.SETFILTER(PurchHdr."Document Type",'Credit Memo');
        PurchHdr.SETFILTER(PurchHdr."Vendor Cr. Memo No.",'<>%1','');
        IF PurchHdr.COUNT>0 THEN
        IF PurchHdr.FINDSET THEN
        REPEAT
          ERROR(PurchHdr."No."+'  Debit Note Have the Invoice Number');
        UNTIL SalesHeadLRec.NEXT=0;
        }*/

        CASE InvoiceNos OF
            0:
                BEGIN
                    "Vendor Cr. Memo No." := '';
                    MODIFY;
                END;
            1:
                BEGIN
                    PurchCrMemoHdr.RESET;
                    PurchCrMemoHdr.SETCURRENTKEY("Vendor Cr. Memo No.", "Posting Date");
                    PurchCrMemoHdr.ASCENDING;
                    PurchCrMemoHdr.SETRANGE(PurchCrMemoHdr."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));  // Added by Rakesh
                                                                                                                               //PurchCrMemoHdr.SETFILTER(POSTEDINVOICE."External Document No.",'0..9999');
                    IF PurchCrMemoHdr.FINDLAST THEN BEGIN
                        y := '0';
                        StrPosOfSlace := STRPOS(PurchCrMemoHdr."Vendor Cr. Memo No.", '\');
                        IF StrPosOfSlace > 0 THEN
                            y := COPYSTR(PurchCrMemoHdr."Vendor Cr. Memo No.", 1, StrPosOfSlace - 1)
                        ELSE
                            y := PurchCrMemoHdr."Vendor Cr. Memo No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "Vendor Cr. Memo No." := '0001' + Fyear_New
                    ELSE
                        "Vendor Cr. Memo No." := INCSTR(y) + Fyear_New;
                    MODIFY;
                END;
        END;
        // End--Pranavi
    END;

    var
        "--QC--": Integer;
        "---Indent---": Integer;
        PurchHeader: Record "Purchase Header";
        PurchHeader1: Record "Purchase Header";
        Selection: Integer;
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        PurchLine1: Record "Purchase Line";
        PurchLineNo: Integer;
        //TaxFormsDetails: Record "Tax Forms Details";
        "---MPST---": Integer;
        MSPTOrderDetails: Record "MSPT Order Details";
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        "G|l": Record "General Ledger Setup";
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';

        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        Vndr: Record Vendor;
        ArchiveManagement: Codeunit 5063;
        UserDetails: Record User;
        SalesHeaderArchive: Record "Sales Header Archive";
        SalesListArchive: Page "Sales List Archive";
        GLSetup: Record "General Ledger Setup";
        InspectJnlLine: Codeunit "Inspection Jnl.-Post Line";
}

