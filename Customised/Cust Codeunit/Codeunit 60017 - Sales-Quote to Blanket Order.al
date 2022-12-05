codeunit 60017 "Sales-Quote to Blanket Order"
{
    // version B2B,SH1.0,DIM1.0

    // Project : EFFTRONICS
    // *************************************************************************************************************************
    // SIGN Name
    // ************************************************************************************************************************
    // DIM : Resolution of Dimension Issues after Upgarding.
    // ***********************************************************************************************************************
    // Version  sign     Date       USERID    Description
    // *************************************************************************************************************************
    // 1.0      DIM      28-May-13  SAIRAM    New Code has been added for the dimensions updation after upgarding.

    TableNo = "Sales Header";

    trigger OnRun();
    var
        OldSalesCommentLine: Record "Sales Comment Line";
        Opp: Record Opportunity;
        OpportunityEntry: Record "Opportunity Entry";
        TempOpportunityEntry: Record "Opportunity Entry" temporary;
        Cust: Record Customer;
    begin
        Rec.TESTFIELD("Document Type", Rec."Document Type"::Quote);
        Cust.GET(Rec."Sell-to Customer No.");
        Cust.CheckBlockedCustOnDocs(Cust, Rec."Document Type"::"Blanket Order", TRUE, FALSE);
        Rec.CALCFIELDS("Amount Including VAT");
        SalesOrderHeader := Rec;
        IF GUIALLOWED AND NOT HideValidationDialog THEN
            CustCheckCreditLimit.SalesHeaderCheck(SalesOrderHeader);
        SalesOrderHeader."Document Type" := SalesOrderHeader."Document Type"::"Blanket Order";

        SalesQuoteLine.SETRANGE("Document Type", Rec."Document Type");
        SalesQuoteLine.SETRANGE("Document No.", Rec."No.");
        SalesQuoteLine.SETRANGE(Type, SalesQuoteLine.Type::Item);
        SalesQuoteLine.SETFILTER("No.", '<>%1', '');
        IF SalesQuoteLine.FINDSET THEN
            REPEAT
                    IF (SalesQuoteLine."Outstanding Quantity" > 0) THEN BEGIN
                        SalesLine := SalesQuoteLine;
                        SalesLine.VALIDATE("Reserved Qty. (Base)", 0);
                        SalesLine."Line No." := 0;
                        IF GUIALLOWED AND NOT HideValidationDialog THEN
                            ItemCheckAvail.SalesLineCheck(SalesLine);
                    END;
            UNTIL SalesQuoteLine.NEXT = 0;

        Opp.RESET;
        Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
        Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
        Opp.SETRANGE("Sales Document No.", Rec."No.");
        Opp.SETRANGE(Status, Opp.Status::"In Progress");
        IF Opp.FINDFIRST THEN
            IF CONFIRM(Text000 + Text001 + Text002, TRUE) THEN BEGIN
                TempOpportunityEntry.DELETEALL;
                TempOpportunityEntry.INIT;
                TempOpportunityEntry.VALIDATE("Opportunity No.", Opp."No.");
                TempOpportunityEntry."Sales Cycle Code" := Opp."Sales Cycle Code";
                TempOpportunityEntry."Contact No." := Opp."Contact No.";
                TempOpportunityEntry."Contact Company No." := Opp."Contact Company No.";
                TempOpportunityEntry."Salesperson Code" := Opp."Salesperson Code";
                TempOpportunityEntry."Campaign No." := Opp."Campaign No.";
                TempOpportunityEntry."Action Taken" := TempOpportunityEntry."Action Taken"::Won;
                TempOpportunityEntry.INSERT;
                TempOpportunityEntry.SETRANGE("Action Taken", TempOpportunityEntry."Action Taken"::Won);
                PAGE.RUNMODAL(PAGE::"Close Opportunity", TempOpportunityEntry);
                Opp.RESET;
                Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
                Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Quote);
                Opp.SETRANGE("Sales Document No.", Rec."No.");
                Opp.SETRANGE(Status, Opp.Status::"In Progress");
                IF Opp.FINDFIRST THEN
                    ERROR(Text003)
                ELSE BEGIN
                    COMMIT;
                    Rec.GET(Rec."Document Type", Rec."No.");
                END;
            END ELSE
                ERROR(Text004);

        SalesOrderHeader."No. Printed" := 0;
        //SalesOrderHeader."Base PLan Comp. Date" := "No."; //B2b1.0
        SalesOrderHeader.Status := SalesOrderHeader.Status::Open;
        // NAVIN
        //SalesOrderHeader.Authorized := FALSE; //b2b1.0
        //SalesOrderHeader."Sent for Authorization" := FALSE; //B2b1.0
        // NAVIN

        SalesOrderHeader."No." := '';

        SalesOrderLine.LOCKTABLE;
        SalesOrderHeader.INSERT(TRUE);

        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Sales Header");
        FromDocDim.SETRANGE("Document Type","Document Type");
        FromDocDim.SETRANGE("Document No.","No.");
        
        ToDocDim.SETRANGE("Table ID",DATABASE::"Sales Header");
        ToDocDim.SETRANGE("Document Type",SalesOrderHeader."Document Type");
        ToDocDim.SETRANGE("Document No.",SalesOrderHeader."No.");
        ToDocDim.DELETEALL;
        
        DocDim.MoveDocDimToDocDim(
          FromDocDim,
          DATABASE::"Sales Header",
          SalesOrderHeader."No.",
          SalesOrderHeader."Document Type",
          0);
        */
        //DIM1.0 End

        SalesOrderHeader."Order Date" := Rec."Order Date";
        IF Rec."Posting Date" <> 0D THEN
            SalesOrderHeader."Posting Date" := Rec."Posting Date";
        SalesOrderHeader."Document Date" := Rec."Document Date";
        SalesOrderHeader."Shipment Date" := Rec."Shipment Date";
        SalesOrderHeader."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
        SalesOrderHeader."Shortcut Dimension 2 Code" := Rec."Shortcut Dimension 2 Code";
        SalesOrderHeader."Dimension Set ID" := Rec."Dimension Set ID"; //DIM1.0
        //SalesOrderHeader."Date Sent" := 0D; //B2b1.0
        //SalesOrderHeader."Time Sent" := 0T; //B2b1.0
        SalesOrderHeader.MODIFY;

        SalesQuoteLine.RESET;
        SalesQuoteLine.SETRANGE("Document Type", Rec."Document Type");
        SalesQuoteLine.SETRANGE("Document No.", Rec."No.");

        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
        ToDocDim.SETRANGE("Table ID",DATABASE::"Sales Line");
        */
        //DIM1.0 End

        IF SalesQuoteLine.FINDSET THEN
                REPEAT
                    SalesOrderLine := SalesQuoteLine;
                    SalesOrderLine."Document Type" := SalesOrderHeader."Document Type";
                    SalesOrderLine."Document No." := SalesOrderHeader."No.";
                    ReserveSalesLine.TransferSaleLineToSalesLine(
                      SalesQuoteLine, SalesOrderLine, SalesQuoteLine."Outstanding Qty. (Base)");
                    SalesOrderLine."Shortcut Dimension 1 Code" := SalesQuoteLine."Shortcut Dimension 1 Code";
                    SalesOrderLine."Shortcut Dimension 2 Code" := SalesQuoteLine."Shortcut Dimension 2 Code";
                    SalesOrderLine."Dimension Set ID" := SalesQuoteLine."Dimension Set ID"; //DIM1.0
                    SalesOrderLine.INSERT;

                    IF SalesOrderLine.Reserve = SalesOrderLine.Reserve::Always THEN BEGIN
                        SalesOrderLine.AutoReserve;
                    END;
                    //SH1.0
                    Schedule.RESET;
                    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Quote);
                    Schedule.SETRANGE("Document No.", SalesQuoteLine."Document No.");
                    Schedule.SETRANGE("Document Line No.", SalesQuoteLine."Line No.");
                    IF Schedule.FINDSET THEN
                        REPEAT
                                Schedule2.INIT;
                            Schedule2.TRANSFERFIELDS(Schedule);
                            Schedule2."Document Type" := Schedule2."Document Type"::"Blanket Order";
                            Schedule2."Document No." := SalesQuoteLine."Document No.";
                            Schedule2."Document Line No." := SalesQuoteLine."Line No.";
                            Schedule2.INSERT;
                            Schedule.DELETE;
                        UNTIL Schedule.NEXT = 0;
                //SH1.0

                //DIM1.0 Start
                //Code Commented
                /*
                FromDocDim.SETRANGE("Line No.",SalesQuoteLine."Line No.");

                ToDocDim.SETRANGE("Line No.",SalesOrderLine."Line No.");
                ToDocDim.DELETEALL;
                DocDim.MoveDocDimToDocDim(
                  FromDocDim,
                  DATABASE::"Sales Line",
                  SalesOrderHeader."No.",
                  SalesOrderHeader."Document Type",
                  SalesOrderLine."Line No.");
                */
                //DIM1.0 End
                UNTIL SalesQuoteLine.NEXT = 0;

        SalesCommentLine.SETRANGE("Document Type", Rec."Document Type");
        SalesCommentLine.SETRANGE("No.", Rec."No.");
        IF NOT SalesCommentLine.ISEMPTY THEN BEGIN
            SalesCommentLine.LOCKTABLE;
            IF SalesCommentLine.FINDSET THEN
                REPEAT
                        OldSalesCommentLine := SalesCommentLine;
                    SalesCommentLine.DELETE;
                    SalesCommentLine."Document Type" := SalesOrderHeader."Document Type";
                    SalesCommentLine."No." := SalesOrderHeader."No.";
                    SalesCommentLine.INSERT;
                    SalesCommentLine := OldSalesCommentLine;
                UNTIL SalesCommentLine.NEXT = 0;
        END;

        // NAVIN
        /* StrOrderHeader.SETRANGE(Type, StrOrderHeader.Type::Sale);
         StrOrderHeader.SETRANGE(Rec."Document Type", Rec."Document Type");
         StrOrderHeader.SETRANGE("Document No.", Rec."No.");
         //  StrOrderHeader.SETRANGE("Structure Code", Structure);
         IF StrOrderHeader.FINDFIRST THEN BEGIN
             StrOrderHeader.LOCKTABLE;
             IF StrOrderHeader.FINDSET THEN
                 REPEAT
                     OldStrOrderHeader := StrOrderHeader;
                     StrOrderHeader.DELETE;
                     StrOrderHeader."Document Type" := SalesOrderHeader."Document Type";
                     StrOrderHeader."Document No." := SalesOrderHeader."No.";
                     //  StrOrderHeader."Structure Code" := SalesOrderHeader.Structure;
                     StrOrderHeader.INSERT;
                     StrOrderHeader := OldStrOrderHeader;
                 UNTIL StrOrderHeader.NEXT = 0;
         END;
         StrOrderLine.SETRANGE(Type, StrOrderLine.Type::Sale);
         StrOrderLine.SETRANGE(Rec."Document Type", Rec."Document Type");
         StrOrderLine.SETRANGE("Document No.", Rec."No.");
         // StrOrderLine.SETRANGE("Structure Code", Structure);
         IF StrOrderLine.FINDFIRST THEN BEGIN
             StrOrderLine.LOCKTABLE;
             IF StrOrderLine.FINDSET THEN
                 REPEAT
                     OldStrOrderLine := StrOrderLine;
                     StrOrderLine.DELETE;
                     StrOrderLine."Document Type" := SalesOrderHeader."Document Type";
                     StrOrderLine."Document No." := SalesOrderHeader."No.";
                     //  StrOrderLine."Structure Code" := SalesOrderHeader.Structure;
                     StrOrderLine.INSERT;
                     StrOrderLine := OldStrOrderLine;
                 UNTIL StrOrderLine.NEXT = 0;
         END;*/
        // NAVIN

        ItemChargeAssgntSales.RESET;
        ItemChargeAssgntSales.SETRANGE("Document Type", Rec."Document Type");
        ItemChargeAssgntSales.SETRANGE("Document No.", Rec."No.");
        WHILE ItemChargeAssgntSales.FINDFIRST DO BEGIN
            ItemChargeAssgntSales.DELETE;
            ItemChargeAssgntSales."Document Type" := SalesOrderHeader."Document Type";
            ItemChargeAssgntSales."Document No." := SalesOrderHeader."No.";
            IF NOT (ItemChargeAssgntSales."Applies-to Doc. Type" IN
                    [ItemChargeAssgntSales."Applies-to Doc. Type"::Shipment,
                     ItemChargeAssgntSales."Applies-to Doc. Type"::"Return Receipt"])
            THEN BEGIN
                ItemChargeAssgntSales."Applies-to Doc. Type" := SalesOrderHeader."Document Type";
                ItemChargeAssgntSales."Applies-to Doc. No." := SalesOrderHeader."No.";
            END;
            ItemChargeAssgntSales.INSERT;
        END;
        /*Commented
        Opp.RESET;
        Opp.SETCURRENTKEY("Sales Document Type","Sales Document No.");
        Opp.SETRANGE("Sales Document Type",Opp."Sales Document Type"::Quote);
        Opp.SETRANGE("Sales Document No.","No.");
        IF Opp.FINDFIRST THEN BEGIN
          IF Opp.Status = Opp.Status::Won THEN BEGIN
            Opp."Sales Document Type" := Opp."Sales Document Type"::b;
            Opp."Sales Document No." := SalesOrderHeader."No.";
            Opp.MODIFY;
            OpportunityEntry.RESET;
            OpportunityEntry.SETCURRENTKEY(Active,"Opportunity No.");
            OpportunityEntry.SETRANGE(Active,TRUE);
            OpportunityEntry.SETRANGE("Opportunity No.",Opp."No.");
            IF OpportunityEntry.FINDFIRST THEN BEGIN
              OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesOrderHeader);
              OpportunityEntry.MODIFY;
            END;
          END ELSE IF Opp.Status = Opp.Status::Lost THEN BEGIN
            Opp."Sales Document Type" := Opp."Sales Document Type"::" ";
            Opp."Sales Document No." := '';
            Opp.MODIFY;
          END;
        END;
        */
        //B2B
        SalesDesignQuotetoOrder(Rec);
        //B2B
        /*IF WebSite.FINDFIRST THEN
          SynchMgt.DeleteSalesHeader(Rec);*///B2b1.0
                                            //copy the attachments
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Sales Header");
        Attach.SETRANGE("Document No.", Rec."No.");
        IF Attach.FINDSET THEN
            REPEAT
                    PostAttach.INIT;
                Attach.CALCFIELDS(Attach.FileAttachment);
                PostAttach.TRANSFERFIELDS(Attach);
                PostAttach."Table ID" := DATABASE::"Sales Header";
                PostAttach."Document No." := SalesOrderHeader."No.";
                //PostAttach."Document Type" := PostAttach."Document Type"::"blanket";
                PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
        //NSS 100907

        Rec.DELETE;

        SalesQuoteLine.DELETEALL;
        //DIM1.0 Start
        //Code Commented
        /*
        FromDocDim.SETFILTER("Table ID",'%1|%2',DATABASE::"Sales Header",DATABASE::"Sales Line");
        FromDocDim.SETRANGE("Line No.");
        FromDocDim.DELETEALL;
        */
        //DIM1.0 End


        COMMIT;
        CLEAR(CustCheckCreditLimit);
        CLEAR(ItemCheckAvail);

    end;

    var
        Text000: Label 'An Open Opportunity is linked to this quote.\';
        Text001: Label 'It has to be closed before an Blanket Order can be made.\';
        Text002: Label 'Do you wish to close this Opportunity now?';
        Text003: Label 'Wizard Aborted';
        SalesQuoteLine: Record "Sales Line";
        SalesLine: Record "Sales Line";
        SalesOrderHeader: Record "Sales Header";
        SalesOrderLine: Record "Sales Line";
        SalesCommentLine: Record "Sales Comment Line";
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        CustCheckCreditLimit: Codeunit "Cust-Check Cr. Limit";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveSalesLine: Codeunit 99000832;
        DocDim: Codeunit DimensionManagement;
        HideValidationDialog: Boolean;
        Text004: Label 'The Opportunity has not been closed. The program has aborted making the Blanket Order.';
        "--NAVIN--": Integer;
        // StrOrderHeader: Record "Structure Order Details";
        //  OldStrOrderHeader: Record "Structure Order Details";
        // StrOrderLine: Record "Structure Order Line Details";
        // OldStrOrderLine: Record "Structure Order Line Details";
        "--SH1.0--": Integer;
        Schedule: Record Schedule2;
        Schedule2: Record Schedule2;
        Attach: Record Attachments;
        PostAttach: Record Attachments;


    procedure GetSalesOrderHeader(var SalesHeader2: Record "Sales Header");
    begin
        SalesHeader2 := SalesOrderHeader;
    end;


    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean);
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;


    procedure SalesDesignQuotetoOrder(var Rec: Record "Sales Header");
    var
        SalesLineDesign: Record "Sales Line";
        DesignWorkSheetQuaote: Record "Design Worksheet Header";
        DesignWorkSheetLineQuote: Record "Design Worksheet Line";
        DesignWorksheetHeader: Record "Design Worksheet Header";
        DesignWorksheetLine: Record "Design Worksheet Line";
    begin
        SalesLineDesign.SETRANGE("Document Type", Rec."Document Type");
        SalesLineDesign.SETRANGE("Document No.", Rec."No.");
        IF SalesLineDesign.FINDSET THEN
                REPEAT
                    DesignWorkSheetQuaote.SETRANGE("Document Type", DesignWorkSheetQuaote."Document Type"::Quote);
                    DesignWorkSheetQuaote.SETRANGE("Document No.", SalesLineDesign."Document No.");
                    DesignWorkSheetQuaote.SETRANGE("Document Line No.", SalesLineDesign."Line No.");
                    IF DesignWorkSheetQuaote.FINDFIRST THEN BEGIN
                        DesignWorksheetHeader.INIT;
                        DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::"Blanket Order";
                        DesignWorksheetHeader."Document No." := SalesOrderLine."Document No.";
                        DesignWorksheetHeader."Document Line No." := SalesOrderLine."Line No.";
                        DesignWorksheetHeader."Item No." := DesignWorkSheetQuaote."Item No.";
                        DesignWorksheetHeader.Description := DesignWorkSheetQuaote.Description;
                        DesignWorksheetHeader.Quantity := DesignWorkSheetQuaote.Quantity;
                        DesignWorksheetHeader."Unit of Measure" := DesignWorkSheetQuaote."Unit of Measure";
                        DesignWorksheetHeader."Soldering Time for SMD" := DesignWorkSheetQuaote."Soldering Time for SMD";
                        DesignWorksheetHeader."Soldering time for DIP" := DesignWorkSheetQuaote."Soldering time for DIP";
                        DesignWorksheetHeader."Total time in Hours" := DesignWorkSheetQuaote."Total time in Hours";
                        DesignWorksheetHeader."Soldering Cost Perhour" := DesignWorkSheetQuaote."Soldering Cost Perhour";
                        DesignWorksheetHeader."Development Cost" := DesignWorkSheetQuaote."Development Cost";
                        DesignWorksheetHeader."Development Time in hours" := DesignWorkSheetQuaote."Development Time in hours";
                        DesignWorksheetHeader."Development Cost per hour" := DesignWorkSheetQuaote."Development Cost per hour";
                        DesignWorksheetHeader."Additional Cost" := DesignWorkSheetQuaote."Additional Cost";
                        DesignWorksheetHeader."Production Bom No." := DesignWorkSheetQuaote."Production Bom No.";
                        DesignWorksheetHeader."Production Bom Version No." := DesignWorkSheetQuaote."Production Bom Version No.";
                        DesignWorksheetHeader."Total Cost" := DesignWorkSheetQuaote."Total Cost";
                        DesignWorkSheetQuaote.CALCFIELDS(DesignWorkSheetQuaote."Components Cost", DesignWorkSheetQuaote."Manufacturing Cost",
                              DesignWorkSheetQuaote."Resource Cost", DesignWorkSheetQuaote."Installation Cost");
                        DesignWorksheetHeader."Components Cost" := DesignWorkSheetQuaote."Components Cost";
                        DesignWorksheetHeader."Manufacturing Cost" := DesignWorkSheetQuaote."Manufacturing Cost";
                        DesignWorksheetHeader."Resource Cost" := DesignWorkSheetQuaote."Resource Cost";
                        DesignWorksheetHeader."Installation Cost" := DesignWorkSheetQuaote."Installation Cost";
                        DesignWorksheetHeader."Total Cost (From Line)" := DesignWorkSheetQuaote."Total Cost (From Line)";
                        IF DesignWorksheetHeader."Document No." <> '' THEN
                            DesignWorksheetHeader.INSERT;
                        DesignWorkSheetLineQuote.SETRANGE("Document Type", DesignWorkSheetLineQuote."Document Type"::Quote);
                        DesignWorkSheetLineQuote.SETRANGE("Document No.", DesignWorkSheetQuaote."Document No.");
                        DesignWorkSheetLineQuote.SETRANGE("Document Line No.", DesignWorkSheetQuaote."Document Line No.");
                        IF DesignWorkSheetLineQuote.FINDSET THEN
                                REPEAT
                                    DesignWorksheetLine."Document No." := DesignWorksheetHeader."Document No.";
                                    DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::"Blanket Order";
                                    DesignWorksheetLine."Document Line No." := DesignWorksheetHeader."Document Line No.";
                                    DesignWorksheetLine."Line No." := DesignWorkSheetLineQuote."Line No.";
                                    DesignWorksheetLine."Line No." := DesignWorksheetLine."Line No." + 10000;
                                    DesignWorksheetLine.Type := DesignWorkSheetLineQuote.Type;
                                    DesignWorksheetLine."No." := DesignWorkSheetLineQuote."No.";
                                    DesignWorksheetLine.Description := DesignWorkSheetLineQuote.Description;
                                    DesignWorksheetLine."Description 2" := DesignWorkSheetLineQuote."Description 2";
                                    DesignWorksheetLine."No.of SMD Points" := DesignWorkSheetLineQuote."No.of SMD Points";
                                    DesignWorksheetLine."No.of DIP Points" := DesignWorkSheetLineQuote."No.of DIP Points";
                                    DesignWorksheetLine."Unit of Measure" := DesignWorkSheetLineQuote."Unit of Measure";
                                    DesignWorksheetLine.Quantity := DesignWorkSheetLineQuote.Quantity;
                                    DesignWorksheetLine."Unit Cost" := DesignWorkSheetLineQuote."Unit Cost";
                                    DesignWorksheetLine.Amount := DesignWorkSheetLineQuote.Amount;
                                    DesignWorksheetLine."Total time in Hours" := DesignWorkSheetLineQuote."Total time in Hours";
                                    DesignWorksheetLine."Manufacturing Cost" := DesignWorkSheetLineQuote."Manufacturing Cost";
                                    DesignWorksheetLine.INSERT;
                                UNTIL DesignWorkSheetLineQuote.NEXT = 0;
                    END;
                UNTIL SalesLineDesign.NEXT = 0;
    end;
}

