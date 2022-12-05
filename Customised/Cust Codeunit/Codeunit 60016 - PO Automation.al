codeunit 60016 "PO Automation"
{
    // version POAU,PO1.0


    trigger OnRun();
    begin
    end;

    var
        Text001: Label 'Do you want to create Indent for Template %1?';
        Text002: Label 'Indent %1 Created';
        Text003: Label 'Do you want to create Enquiries?';
        Text004: Label 'Do you want to create Quotations?';
        Text005: Label '" Rating of payment term code  ''%1'' must not be zero "';
        Text008: Label '%1 Vendor is not approved for Item %2, Do you want to continue?';
        Text006: Label 'The update has been interrupted to respect the warning';
        Item: Record Item;
        Text007: Label 'Default Vendor is not Mentioned In the Vendor Item Catalog For  Item No ''%1''';
        "Purch Line": Record "Purchase Line";
        purchInvLine: Record "Purch. Inv. Line";
        PL: Record "Purchase Line";
        PH: Record "Purchase Header";
        Qty: Decimal;
        OutStndQty: Decimal;
        PaymentTerms: Record "Payment Terms";
        ItemVar: Record Item;


    procedure CreateIndents(TemplateName: Code[20]; "Jnl.BatchName": Code[20]);
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        ReqLine: Record "Requisition Line";
        PPSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
    begin
        IF NOT CONFIRM(Text001, FALSE, TemplateName) THEN
            EXIT;

        ReqLine.SETRANGE("Worksheet Template Name", TemplateName);
        ReqLine.SETRANGE("Journal Batch Name", "Jnl.BatchName");
        IF ReqLine.FINDFIRST THEN BEGIN
            IndentHeader.INIT;
            PPSetup.GET;
            IndentHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Purchase Indent Nos.", WORKDATE, TRUE);
            IndentHeader."Due Date" := ReqLine."Due Date";
            IndentHeader."Document Date" := WORKDATE;
            IndentHeader."Creation Date" := WORKDATE;
            IndentHeader."User Id" := USERID;
            IndentHeader."Delivery Location" := ReqLine."Location Code";
            IndentHeader."Indent Status" := IndentHeader."Indent Status"::Indent;
            IndentHeader.INSERT;
            REPEAT
                IndentLine.INIT;
                IndentLine."Line No." := IndentLine."Line No." + 10000;
                IndentLine."Document No." := IndentHeader."No.";
                IndentLine."No." := ReqLine."No.";
                IndentLine.VALIDATE("No.");
                IndentLine.Quantity := ReqLine.Quantity;
                IndentLine."Unit of Measure" := ReqLine."Unit of Measure Code";
                IndentLine.VALIDATE(Quantity);
                //IndentLine."Due Date" := ReqLine."Due Date";
                IndentLine."Delivery Location" := ReqLine."Location Code";
                IndentLine."Indent Status" := IndentLine."Indent Status"::Indent;
                IndentLine.INSERT;
            UNTIL ReqLine.NEXT = 0;
        END;
        MESSAGE(Text002, IndentHeader."No.");
        ReqLine.DELETEALL;
    end;


    procedure GetIndentLines();
    var
        CreateIndents: Record "Create Indents";
        IndentLine: Record "Indent Line";
        IndentHeader: Record "Indent Header";
    begin
        CreateIndents.RESET;
        CreateIndents.DELETEALL;
        IndentLine.RESET;
        IndentLine.SETRANGE("Indent Status", IndentLine."Indent Status"::Indent);
        IndentLine.SETRANGE("Release Status", IndentLine."Release Status"::Released);
        //IndentLine.SETFILTER(IndentLine."Document No.",'<>%1','P-IND-12-13-01359'); //sundar
        IF IndentLine.FINDSET THEN
            REPEAT
                "Purch Line".SETCURRENTKEY("Purch Line"."ICN No.", "Purch Line"."No.");
                "Purch Line".SETRANGE("Purch Line"."ICN No.", IndentLine."ICN No.");
                "Purch Line".SETRANGE("Purch Line"."Indent No.", IndentLine."Document No.");
                "Purch Line".SETRANGE("Purch Line"."No.", IndentLine."No.");
                "Purch Line".SETRANGE("Purch Line"."Indent Line No.", IndentLine."Line No."); // added at the GLs and Fixed assets time.
                                                                                              //"Purch Line".SETRANGE("Purch Line"."Line No.",IndentLine."Line No.");
                                                                                              //  "Purch Line".SETRANGE("Purch Line"."Location Code",'STR');
                IF NOT ("Purch Line".FINDFIRST) THEN BEGIN
                    CreateIndents.RESET;
                    CreateIndents.SETRANGE("Item No.", IndentLine."No.");
                    CreateIndents.SETRANGE("ICN No.", IndentLine."ICN No.");
                    CreateIndents.SETRANGE(Description, IndentLine.Description);//B2B-180108
                    CreateIndents.SETRANGE("Location Code", IndentLine."Delivery Location");
                    IF CreateIndents.FINDLAST THEN BEGIN
                        CreateIndents.Quantity += IndentLine.Quantity;
                        CreateIndents.MODIFY;
                        //added by vishnu priya to track the base Indent Number
                        IndentLine."Base Indent Number" := CreateIndents."Indent No.";
                        IndentLine."Base Indent Line Number" := CreateIndents."Indent Line No.";
                        IndentLine.MODIFY;
                        //end by vishnu priya to track the base Indent Number
                    END ELSE BEGIN
                        CreateIndents.INIT;
                        CreateIndents."Item No." := IndentLine."No.";
                        CreateIndents.Type := IndentLine.Type;
                        //CommentedCreateIndents."Unit of Measure" := IndentLine."Base Unit of Measure Code";
                        CreateIndents."Unit of Measure" := IndentLine."Unit of Measure";
                        CreateIndents."Indent No." := IndentLine."Document No.";
                        CreateIndents."Indent Line No." := IndentLine."Line No.";
                        CreateIndents.Description := IndentLine.Description;
                        CreateIndents.Quantity := IndentLine.Quantity;
                        CreateIndents."Indent Status" := IndentLine."Indent Status";
                        CreateIndents."Release Status" := IndentLine."Release Status";
                        CreateIndents."Due Date" := IndentLine."Due Date";
                        CreateIndents."Location Code" := IndentLine."Delivery Location";
                        CreateIndents."ICN No." := IndentLine."ICN No.";
                        CreateIndents."Project Description" := IndentLine."Project Description";
                        CreateIndents."Production Order Description" := IndentLine."Production Order Description";
                        CreateIndents."Production Start date" := IndentLine."Production Start date";
                        CreateIndents.VALIDATE(CreateIndents."Suitable Vendor", IndentLine."Suitable Vendor");
                        CreateIndents."Suitable Vendor" := IndentLine."Suitable Vendor";
                        CreateIndents."Unit Cost" := IndentLine."Unit Cost";
                        CreateIndents."Part Number" := IndentLine."Part Number"; // added by Vishnu Priya on 13-11-2020
                        IndentHeader.RESET;
                        IndentHeader.SETFILTER("No.", IndentLine."Document No.");
                        IF IndentHeader.FINDFIRST THEN BEGIN
                            CreateIndents.Department := IndentHeader.Department;
                        END;
                        CreateIndents.INSERT;
                        //added by vishnu priya to track the base Indent Number
                        IndentLine."Base Indent Number" := CreateIndents."Indent No.";
                        IndentLine."Base Indent Line Number" := CreateIndents."Indent Line No.";
                        IndentLine.MODIFY;
                        //end by vishnu priya to track the base Indent Number
                    END;
                END ELSE BEGIN
                    IndentLine."Indent Status" := IndentLine."Indent Status"::Order;
                    IndentLine.MODIFY;
                END;
            UNTIL IndentLine.NEXT = 0;
        //sundar
        /*
        IndentLine.RESET;
        IndentLine.SETRANGE("Indent Status",IndentLine."Indent Status"::Indent);
        IndentLine.SETRANGE(IndentLine."Release Status",IndentLine."Release Status"::Released);
        IndentLine.SETFILTER(IndentLine."Document No.",'P-IND-12-13-01359');
        IF IndentLine.FINDSET THEN
        REPEAT
                CreateIndents.INIT;
                CreateIndents."Item No." := IndentLine."No.";
                //CommentedCreateIndents."Unit of Measure" := IndentLine."Base Unit of Measure Code";
                CreateIndents."Unit of Measure" := IndentLine."Unit of Measure";
                CreateIndents."Indent No." := IndentLine."Document No.";
                CreateIndents."Indent Line No." := IndentLine."Line No.";
                CreateIndents.Description := IndentLine.Description;
                CreateIndents.Quantity := IndentLine.Quantity;
                CreateIndents."Indent Status" := IndentLine."Indent Status";
                CreateIndents."Release Status" := IndentLine."Release Status";
                CreateIndents."Due Date" := IndentLine."Due Date";
                CreateIndents."Location Code" := IndentLine."Delivery Location";
                CreateIndents."ICN No." := IndentLine."ICN No.";
                CreateIndents."Project Description":=IndentLine."Project Description";
                CreateIndents."Production Order Description":=IndentLine."Production Order Description";
                CreateIndents."Production Start date":=IndentLine."Production Start date";
                CreateIndents.VALIDATE(CreateIndents."Suitable Vendor",IndentLine."Suitable Vendor");
                CreateIndents."Suitable Vendor":=IndentLine."Suitable Vendor";
                CreateIndents."Unit Cost":=IndentLine."Unit Cost";
                CreateIndents.INSERT;
        
        UNTIL IndentLine.NEXT = 0;*/ //sundar
        CreateIndents.RESET;

    end;


    procedure CreateEnquiries();
    var
        IndentVendorItems: Record "Indent Vendor Items";
        IndentVendorEnquiry: Record "Indent Vendor Items";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NoSeriesMgt: Codeunit 396;
        PPSetup: Record "Purchases & Payables Setup";
        CreateIndents2: Record "Create Indents";
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
        Text000: Label 'Enquires created successfully';
        ItemVendor: Record "Item Vendor";
        Text001: Label '%1 Vendor is not approved for Item %2, Do you want to continue?';
        Text002: Label 'The update has been interrupted to respect the warning';
    begin
        IF NOT CONFIRM(Text003, FALSE) THEN
            EXIT;
        InsertIndentItemvendor;
        IndentVendorItems.RESET;
        IndentVendorItems.SETRANGE(Check, FALSE);
        IF IndentVendorItems.FINDSET THEN
            REPEAT
                IndentVendorEnquiry.SETRANGE("Vendor No.", IndentVendorItems."Vendor No.");
                IndentVendorEnquiry.SETRANGE("Location Code", IndentVendorItems."Location Code");
                IndentVendorEnquiry.SETRANGE("ICN No.", IndentVendorItems."ICN No.");
                IF IndentVendorEnquiry.FINDSET THEN BEGIN
                    PurchaseHeader.INIT;
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Enquiry;
                    PPSetup.GET;
                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Enquiry Nos.", WORKDATE, TRUE);
                    PurchaseHeader."Buy-from Vendor No." := IndentVendorEnquiry."Vendor No.";
                    PurchaseHeader.VALIDATE("Document Date", WORKDATE);
                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                    PurchaseHeader."Due Date" := IndentVendorEnquiry."Due Date";
                    PurchaseHeader.VALIDATE("Due Date");
                    PurchaseHeader."ICN No." := IndentVendorEnquiry."ICN No.";
                    PurchaseHeader."Location Code" := IndentVendorEnquiry."Location Code";
                    PurchaseHeader.VALIDATE("Location Code");
                    PurchaseHeader.INSERT;
                    REPEAT
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Enquiry;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                        PurchaseLine.Type := PurchaseLine.Type::Item;
                        PurchaseLine."No." := IndentVendorEnquiry."Item No.";
                        PurchaseLine.VALIDATE(PurchaseLine."No.");
                        PurchaseLine.Quantity := IndentVendorEnquiry.Quantity;
                        PurchaseLine."Unit of Measure" := IndentVendorEnquiry."Unit of Measure";
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                        PurchaseLine."Indent No." := IndentVendorEnquiry."Indent No.";
                        PurchaseLine."Indent Line No." := IndentVendorEnquiry."Indent Line No.";
                        PurchaseLine."ICN No." := IndentVendorEnquiry."ICN No."; //ReachSSR
                        PurchaseLine."Location Code" := IndentVendorEnquiry."Location Code";
                        PurchaseLine.VALIDATE("Location Code");
                        PurchaseLine.INSERT;
                        IndentVendorEnquiry.Check := TRUE;
                        IndentVendorEnquiry.MODIFY;
                    UNTIL IndentVendorEnquiry.NEXT = 0;
                END;
            UNTIL IndentVendorItems.NEXT = 0;
        CreateIndents2.RESET;
        IF CreateIndents2.FINDSET THEN
            REPEAT
                IndentLine.SETRANGE("Delivery Location", CreateIndents2."Location Code");
                IndentLine.SETRANGE("No.", CreateIndents2."Item No.");
                IndentLine.SETRANGE("ICN No.", CreateIndents2."ICN No.");
                IndentLine.SETRANGE(IndentLine."Indent Status", IndentLine."Indent Status"::Indent);
                //    IndentLine.SETRANGE(IndentLine."Release Status",IndentLine."Release Status"::"1");
                /*
                IndentLine.SETRANGE("Document No.",CreateIndents."Indent No.");
                IndentLine.SETRANGE("Line No.",CreateIndents."Indent Line No.");
                */
                IF IndentLine.FINDSET THEN
                    REPEAT
                        IndentLine."Indent Status" := IndentLine."Indent Status"::Enquiry;
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            UNTIL CreateIndents2.NEXT = 0;

        CreateIndents2.DELETEALL;
        MESSAGE(Text000);

    end;


    procedure InsertIndentItemvendor();
    var
        IndentVendorItems: Record "Indent Vendor Items";
        ItemVendor: Record "Item Vendor";
        CreateIndents: Record "Create Indents";
    begin
        IndentVendorItems.DELETEALL;
        IF CreateIndents.FINDSET THEN
            REPEAT
                IndentVendorItems.INIT;
                IndentVendorItems."Item No." := CreateIndents."Item No.";
                IndentVendorItems.Quantity := CreateIndents.Quantity;
                IndentVendorItems."Unit of Measure" := CreateIndents."Unit of Measure";
                IndentVendorItems."Indent No." := CreateIndents."Indent No.";
                IndentVendorItems."Indent Line No." := CreateIndents."Indent Line No.";
                IndentVendorItems."ICN No." := CreateIndents."ICN No.";//ReachSSR
                                                                       //NSS1.0 >> BEGIN
                IndentVendorItems."Manufacturer Code" := CreateIndents."Manufacturer Code";
                //NSS1.0 << END
                IndentVendorItems."Due Date" := CreateIndents."Due Date";
                IndentVendorItems.Check := FALSE;
                IndentVendorItems."Location Code" := CreateIndents."Location Code";
                ItemVendor.SETRANGE("Item No.", IndentVendorItems."Item No.");
                IF NOT (ItemVendor.FINDFIRST) THEN
                    ERROR(Text007, IndentVendorItems."Item No.")
                ELSE
                    REPEAT
                        IndentVendorItems."Vendor No." := ItemVendor."Vendor No.";
                        IndentVendorItems.Approved := ItemVendor.Approved; //KPK
                        IndentVendorItems.INSERT;
                    UNTIL ItemVendor.NEXT = 0;
            UNTIL CreateIndents.NEXT = 0;
    end;


    procedure CreateQuotes();
    var
        IndentVendorItems: Record "Indent Vendor Items";
        IndentVendorEnquiry: Record "Indent Vendor Items";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PPSetup: Record "Purchases & Payables Setup";
        CreateIndents2: Record "Create Indents";
        IndentLine: Record "Indent Line";
        text000: Label 'Quotes created successfully';
    begin
        IF NOT CONFIRM(Text004, FALSE) THEN
            EXIT;
        InsertIndentItemvendor;
        IndentVendorItems.RESET;
        IndentVendorItems.SETRANGE(Check, FALSE);
        IF IndentVendorItems.FINDSET THEN
            REPEAT
                IndentVendorEnquiry.SETRANGE("Vendor No.", IndentVendorItems."Vendor No.");
                IndentVendorEnquiry.SETRANGE("Location Code", IndentVendorItems."Location Code");//Reach SSR
                IndentVendorEnquiry.SETRANGE("ICN No.", IndentVendorItems."ICN No.");  //reach ssr
                IF IndentVendorEnquiry.FINDSET THEN BEGIN
                    PurchaseHeader.INIT;
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
                    PPSetup.GET;
                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Quote Nos.", WORKDATE, TRUE);
                    PurchaseHeader."Buy-from Vendor No." := IndentVendorEnquiry."Vendor No.";
                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                    PurchaseHeader."Location Code" := IndentVendorEnquiry."Location Code";
                    PurchaseHeader.VALIDATE("Location Code");
                    PurchaseHeader."ICN No." := IndentVendorEnquiry."ICN No.";
                    PurchaseHeader.INSERT;
                    REPEAT
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Quote;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                        PurchaseLine.Type := PurchaseLine.Type::Item;
                        PurchaseLine."No." := IndentVendorEnquiry."Item No.";
                        PurchaseLine.VALIDATE(PurchaseLine."No.");
                        PurchaseLine.Quantity := IndentVendorEnquiry.Quantity;
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                        PurchaseLine."Indent No." := IndentVendorEnquiry."Indent No.";
                        PurchaseLine."Indent Line No." := IndentVendorEnquiry."Indent Line No.";
                        PurchaseLine."ICN No." := IndentVendorEnquiry."ICN No."; //ReachSSR
                                                                                 //NSS1.0 >> BEGIN
                                                                                 //NSS1.0 << END
                        PurchaseLine."Location Code" := IndentVendorEnquiry."Location Code";
                        PurchaseLine.VALIDATE("Location Code");
                        PurchaseLine.INSERT;
                        IndentVendorEnquiry.Check := TRUE;
                        IndentVendorEnquiry.MODIFY;
                    UNTIL IndentVendorEnquiry.NEXT = 0;
                END;
            UNTIL IndentVendorItems.NEXT = 0;

        CreateIndents2.RESET;
        IF CreateIndents2.FINDSET THEN
            REPEAT
                IndentLine.SETRANGE("Delivery Location", CreateIndents2."Location Code");
                IndentLine.SETRANGE("No.", CreateIndents2."Item No.");
                IndentLine.SETRANGE("ICN No.", CreateIndents2."ICN No.");
                IndentLine.SETRANGE(IndentLine."Indent Status", IndentLine."Indent Status"::Indent);
                //    IndentLine.SETRANGE(IndentLine."Release Status",IndentLine."Release Status"::"1");
                /*
                IndentLine.SETRANGE("Document No.",CreateIndents."Indent No.");
                IndentLine.SETRANGE("Line No.",CreateIndents."Indent Line No.");
                */
                IF IndentLine.FINDSET THEN
                    REPEAT
                        IndentLine."Indent Status" := IndentLine."Indent Status"::Offer;
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            UNTIL CreateIndents2.NEXT = 0;

        CreateIndents2.DELETEALL;
        MESSAGE(text000);

    end;


    procedure InsertQuotationLines(var RFQNumber: Code[20]);
    var
        PurchaseHeader: Record "Purchase Header";
        QuoteCompare: Record "Quotation Comparision";
        PurchaseLine: Record "Purchase Line";
        //Structure: Record "Structure Order Line Details";
        Amount: Decimal;
        QuoteCompareAmount: Record "Quotation Comparision";
        MinimumBid: Record "Quotation Comparision";
        PreviousItem: Code[20];
        LeastLineAmount: Decimal;
        QuoteCompare1: Record "Quotation Comparision";
        PurchaseSetup: Record "Purchases & Payables Setup";
        MaxDelWeightage: Decimal;
        MaxQualityWeightage: Decimal;
        TotalWeightage: Decimal;
        PaymentTerms: Record "Payment Terms";
        QuoteCompare2: Record "Quotation Comparision";
        MaxPayment: Decimal;
        Text0010: Label 'Amount Is not Mentioned In Purchase Quote %1';
    begin
        QuoteCompare.DELETEALL;
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Quote);
        PurchaseHeader.SETRANGE("RFQ No.", RFQNumber);
        IF PurchaseHeader.FINDSET THEN
            REPEAT
                QuoteCompare.INIT;
                QuoteCompare."RFQ No." := PurchaseHeader."RFQ No.";
                QuoteCompare."Quote No." := PurchaseHeader."No.";
                QuoteCompare."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                QuoteCompare."Vendor Name" := PurchaseHeader."Buy-from Vendor Name";
                QuoteCompare."Item No." := '';
                QuoteCompare.Description := PurchaseHeader."Buy-from Vendor Name";
                QuoteCompare.Quantity := 0;
                QuoteCompare.Rate := 0;
                QuoteCompare.Amount := 0;
                QuoteCompare."Payment Term Code" := '';
                QuoteCompare."Parent Quote No." := '';
                QuoteCompare."Line Amount" := 0;
                QuoteCompare."Delivery Date" := 0D;
                QuoteCompare.Level := 0;
                QuoteCompare."Line No." := QuoteCompare."Line No." + 10000;
                //  QuoteCompare.Structure := PurchaseHeader.Structure;
                QuoteCompare."Location Code" := PurchaseHeader."Location Code";
                QuoteCompare.INSERT;
                Amount := 0;
                PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchaseHeader."Document Type");
                PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
                IF PurchaseLine.FINDSET THEN
                    REPEAT
                        QuoteCompare."RFQ No." := PurchaseHeader."RFQ No.";
                        QuoteCompare."Quote No." := '';
                        QuoteCompare."Vendor No." := '';
                        QuoteCompare."Vendor Name" := '';
                        QuoteCompare."Item No." := PurchaseLine."No.";
                        QuoteCompare.Description := PurchaseLine.Description;
                        QuoteCompare.Quantity := PurchaseLine.Quantity;
                        QuoteCompare.Rate := PurchaseLine."Direct Unit Cost";
                        IF PurchaseLine."Direct Unit Cost" = 0 THEN
                            ERROR(Text0010, PurchaseLine."Document No.");
                        QuoteCompare.Amount := PurchaseLine."Direct Unit Cost" * PurchaseLine.Quantity;
                        QuoteCompare."Payment Term Code" := PurchaseHeader."Payment Terms Code";
                        //Reach SSR start sankar modified if payment term code not mentioned
                        IF PaymentTerms.GET(QuoteCompare."Payment Term Code") THEN BEGIN
                            PurchaseSetup.GET;
                            QuoteCompare.Rating := PaymentTerms.Rating;
                            IF QuoteCompare.Rating = 0 THEN
                                ERROR(Text005, QuoteCompare."Payment Term Code");
                            //         QuoteCompare."Payment Terms" := ROUND((PaymentTerms.Rating * PurchaseSetup."Payment Terms Weightage")/100);
                        END;
                        //Reach ssr end
                        //QuoteCompare."Delivery Date" := PurchaseLine."Promised Receipt Date";
                        QuoteCompare."Delivery Date" := PurchaseHeader."Due Date";//Reach-SSR
                        QuoteCompare."Indent No." := PurchaseLine."Indent No.";
                        QuoteCompare."Indent Line No." := PurchaseLine."Indent Line No.";
                        QuoteCompare."ICN No." := PurchaseLine."ICN No.";//Reach SSR
                        QuoteCompare."Location Code" := PurchaseLine."Location Code";
                        QuoteCompare."Line No." := QuoteCompare."Line No." + 10000;
                        QuoteCompare."Document Date" := PurchaseHeader."Document Date";
                        QuoteCompare."Due Date" := PurchaseHeader."Due Date";
                        QuoteCompare."Requested Receipt Date" := PurchaseHeader."Requested Receipt Date";
                        QuoteCompare."Parent Vendor" := PurchaseHeader."Buy-from Vendor No.";
                        //QuoteCompare.Delivery := CalculateDelivery(QuoteCompare."Parent Vendor",QuoteCompare."Item No.");
                        QuoteCompare.Delivery := CalculateDelivery(PurchaseLine."Buy-from Vendor No.", PurchaseLine."No.", PurchaseHeader."RFQ No.");


                        //QuoteCompare.Quality := CalculateQuality(QuoteCompare."Parent Vendor",QuoteCompare."Item No.");
                        QuoteCompare.Quality := CalculateQuality(PurchaseLine."Buy-from Vendor No.", PurchaseLine."No.", PurchaseHeader."RFQ No.");
                        QuoteCompare.Structure := '';
                        QuoteCompare."Line Amount" := 0;
                        QuoteCompare.Level := 1;
                        QuoteCompare."Parent Quote No." := PurchaseLine."Document No.";
                        //sankar start   for amounts calculation
                        // QuoteCompare."P & F" := PurchaseLine."Amount Added to Inventory";//EFFUPG
                        Item.GET(PurchaseLine."No.");
                        //EFFUPG>>
                        /*
                         IF Item."Excise Accounting Type" = Item."Excise Accounting Type"::"With CENVAT" THEN
                             QuoteCompare."Excise Duty" := 0
                         ELSE
                             QuoteCompare."Excise Duty" := PurchaseLine."Excise Amount";
                         QuoteCompare."Sales Tax" := PurchaseLine."Tax Amount";
*/  //EFFUPG<<
                        QuoteCompare.Discount := (PurchaseLine."Line Discount Amount" + PurchaseLine."Inv. Discount Amount");
                        QuoteCompare.Amount := (PurchaseLine.Quantity * PurchaseLine."Direct Unit Cost") + QuoteCompare."P & F" +
                         // PurchaseLine."Tax Amount"
                         -QuoteCompare.Discount;
                        //sankar end

                        /* Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::Excise);
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::"Others ");
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare."Excise Duty" := Structure.Amount;
                             UNTIL Structure.NEXT = 0;

                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::"Sales Tax");
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::"Others ");
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare."Sales Tax" := Structure.Amount
                             UNTIL Structure.NEXT = 0;

                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::"Other Taxes");
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::Insurance);

                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare.Insurance := Structure.Amount;
                             UNTIL Structure.NEXT = 0;

                         QuoteCompare.Freight := 0;
                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::Charges);
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::Freight);
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare.Freight := QuoteCompare.Freight + Structure.Amount;
                             UNTIL Structure.NEXT = 0;

                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", Structure."Document Type"::Quote);
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::Charges);
                         //Structure.SETRANGE("Expense Charge Type",Structure."Expense Charge Type"::Packing);
                         Structure.SETRANGE("Tax/Charge Group", 'PACKING');
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare."P & F" := Structure.Amount;
                             UNTIL Structure.NEXT = 0;

                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::Charges);
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::"Others ");
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare."P & F" := Structure.Amount;
                             UNTIL Structure.NEXT = 0;


                         Structure.RESET;
                         Structure.SETRANGE(Type, Structure.Type::Purchase);
                         Structure.SETRANGE("Document Type", PurchaseLine."Document Type"::Quote);
                         Structure.SETRANGE("Document No.", PurchaseHeader."No.");
                         Structure.SETRANGE("Line No.", PurchaseLine."Line No.");
                         Structure.SETRANGE("Tax/Charge Type", Structure."Tax/Charge Type"::"Sales Tax");
                         Structure.SETRANGE("Expense Charge Type", Structure."Expense Charge Type"::"Others ");
                         IF Structure.FINDSET THEN
                             REPEAT
                                 QuoteCompare.VAT := Structure.Amount;
                             UNTIL Structure.NEXT = 0;*/


                        Amount := Amount + QuoteCompare.Amount;
                        //+ QuoteCompare."Excise Duty" + QuoteCompare."Sales Tax" +
                        /*
                                  QuoteCompare."P & F" +
                                  QuoteCompare.VAT;

                        QuoteCompare."Amt. including Tax" := (QuoteCompare.Amount + QuoteCompare."Excise Duty" + QuoteCompare."Sales Tax" +
                                                              QuoteCompare."P & F" +

                                                                                              QuoteCompare.VAT) / QuoteCompare.Quantity; //SSR


                        IF PurchaseHeader.Structure <> '' THEN
                          QuoteCompare.Amount := QuoteCompare."Amt. including Tax" * PurchaseLine.Quantity;
                         */

                        QuoteCompareAmount.SETRANGE("RFQ No.", QuoteCompare."RFQ No.");
                        QuoteCompareAmount.SETRANGE("Quote No.", PurchaseLine."Document No.");
                        QuoteCompareAmount.SETRANGE(QuoteCompareAmount.Level, 0);
                        IF QuoteCompareAmount.FINDFIRST THEN BEGIN
                            QuoteCompareAmount."Total Amount" := Amount;
                            QuoteCompareAmount.MODIFY;
                        END;
                        QuoteCompare.INSERT;
                    UNTIL PurchaseLine.NEXT = 0;
            UNTIL PurchaseHeader.NEXT = 0;
        //REPORT.RUN(60001);
        //Phani kumar-FOR Calculating the Purchase Weightage
        PurchaseSetup.GET;
        QuoteCompare.RESET;
        QuoteCompare.SETRANGE("RFQ No.", RFQNumber);
        QuoteCompare.SETFILTER("Item No.", '<>%1', '');
        QuoteCompare.SETCURRENTKEY("Item No.");
        IF QuoteCompare.FINDSET THEN
            REPEAT
                IF PreviousItem <> QuoteCompare."Item No." THEN BEGIN
                    LeastLineAmount := 0;
                    QuoteCompare1.RESET;
                    QuoteCompare1.SETRANGE("RFQ No.", RFQNumber);
                    QuoteCompare1.SETFILTER("Item No.", '<>%1', '');
                    QuoteCompare1.SETRANGE("Item No.", QuoteCompare."Item No.");
                    IF QuoteCompare1.FINDSET THEN BEGIN
                        LeastLineAmount := QuoteCompare1.Amount;
                        REPEAT
                            IF LeastLineAmount > QuoteCompare1.Amount THEN
                                LeastLineAmount := QuoteCompare1.Amount;
                        UNTIL QuoteCompare1.NEXT = 0;
                        IF QuoteCompare1.FINDSET THEN
                            REPEAT
                                QuoteCompare1.Price := (LeastLineAmount / QuoteCompare1.Amount * 100) * PurchaseSetup."Price Weightage" / 100;
                                QuoteCompare1.MODIFY;
                            UNTIL QuoteCompare1.NEXT = 0;
                    END;
                END ELSE
                    PreviousItem := QuoteCompare."Item No.";
            UNTIL QuoteCompare.NEXT = 0;
        /*
        //B2BSSR1.1 -FOR Calculating the Payment terms Weightage
        PurchaseSetup.GET;
        QuoteCompare.RESET;
        QuoteCompare.SETRANGE("RFQ No.",RFQNumber);
        QuoteCompare.SETFILTER("Item No.",'<>%1','');
        QuoteCompare.SETCURRENTKEY("Item No.");
        IF QuoteCompare.FINDSET THEN
        REPEAT
          IF PreviousItem <> QuoteCompare."Item No." THEN BEGIN
             LeastLineAmount := 0;
             QuoteCompare1.RESET;
             QuoteCompare1.SETRANGE("RFQ No.",RFQNumber);
             QuoteCompare1.SETFILTER("Item No.",'<>%1','');
             QuoteCompare1.SETRANGE("Item No.",QuoteCompare."Item No.");
             IF QuoteCompare1.FINDSET THEN BEGIN
                MaxPayment := QuoteCompare1.Rating;
                REPEAT
                  IF MaxPayment < QuoteCompare1.Rating THEN
                    MaxPayment := QuoteCompare1.Rating;
                UNTIL QuoteCompare1.NEXT = 0;
                IF QuoteCompare1.FINDSET THEN
                 REPEAT
                   QuoteCompare1."Payment Terms" := (QuoteCompare1.Rating /MaxPayment *100)* PurchaseSetup."Payment Terms Weightage"/100;
                   QuoteCompare1.MODIFY;
                 UNTIL QuoteCompare1.NEXT = 0;
             END;
          END ELSE
             PreviousItem:=QuoteCompare."Item No." ;
        UNTIL QuoteCompare.NEXT = 0;
        */

        //For Total weightage calculation
        QuoteCompare.RESET;
        QuoteCompare.SETRANGE("RFQ No.", RFQNumber);
        QuoteCompare.SETFILTER("Item No.", '<>%1', '');
        QuoteCompare.SETCURRENTKEY("Item No.");
        IF QuoteCompare.FINDSET THEN
            REPEAT
                QuoteCompare."Total Weightage" := QuoteCompare.Price + QuoteCompare.Delivery +
                                                  QuoteCompare.Quality + QuoteCompare."Payment Terms";//REach SSR
                QuoteCompare.MODIFY;
            UNTIL QuoteCompare.NEXT = 0;


        //For Selecting the best vendor
        PreviousItem := '';
        QuoteCompare.RESET;
        QuoteCompare.SETCURRENTKEY("RFQ No.", "Item No.");
        QuoteCompare.SETRANGE("RFQ No.", RFQNumber);
        QuoteCompare.SETFILTER("Item No.", '<>%1', '');
        IF QuoteCompare.FINDSET THEN
            REPEAT
                IF PreviousItem <> QuoteCompare."Item No." THEN BEGIN
                    PreviousItem := QuoteCompare."Item No.";
                    QuoteCompare1.RESET;
                    QuoteCompare1.SETRANGE("RFQ No.", RFQNumber);
                    QuoteCompare1.SETRANGE("Item No.", QuoteCompare."Item No.");
                    IF QuoteCompare1.FINDSET THEN BEGIN
                        TotalWeightage := QuoteCompare1."Total Weightage";
                        REPEAT
                            IF TotalWeightage < QuoteCompare1."Total Weightage" THEN
                                TotalWeightage := QuoteCompare1."Total Weightage";
                        UNTIL QuoteCompare1.NEXT = 0;
                    END;
                    QuoteCompare2.RESET;
                    QuoteCompare2.SETRANGE("RFQ No.", RFQNumber);
                    QuoteCompare2.SETRANGE("Item No.", QuoteCompare."Item No.");
                    QuoteCompare2.SETRANGE("Total Weightage", TotalWeightage);
                    IF QuoteCompare2.FINDFIRST THEN BEGIN
                        QuoteCompare2."Carry Out Action" := TRUE;
                        QuoteCompare2.MODIFY;
                    END;
                END;
            UNTIL QuoteCompare.NEXT = 0;

    end;


    procedure CalculateDelivery("VendorNo.": Code[20]; "ItemNo.": Code[20]; RFQNo: Code[20]) Delvery: Decimal;
    var
        PPSetup: Record "Purchases & Payables Setup";
        ItemVendor: Record "Item Vendor";
        ItemVendor2: Record "Item Vendor";
        MaxDeliveryPoints: Decimal;
        TempDeliveryRating: Decimal;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //sankar delivery
        MaxDeliveryPoints := 0;
        ItemVendor2.RESET;
        PPSetup.GET;
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE(PurchaseHeader."RFQ No.", RFQNo);
        IF PurchaseHeader.FINDSET THEN
            REPEAT
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("No.", "ItemNo.");
                IF PurchaseLine.FINDSET THEN
                    REPEAT
                        ItemVendor2.SETRANGE("Vendor No.", PurchaseLine."Buy-from Vendor No.");
                        ItemVendor2.SETRANGE("Item No.", "ItemNo.");
                        IF ItemVendor2.FINDSET THEN BEGIN
                            REPEAT
                                //commentedItemVendor2.CALCFIELDS("Delivery Rating","Total Qty. Supplied");
                                ItemVendor2.CALCFIELDS("Total Qty. Supplied");
                                //Ramu
                                IF (ItemVendor2."Total Qty. Supplied" <> 0) AND (ItemVendor2."Delivery Rating" <> 0) THEN BEGIN
                                    ItemVendor2."Avg. Delivery Rating" := ItemVendor2."Delivery Rating" / ItemVendor2."Total Qty. Supplied";
                                    ItemVendor2.MODIFY;
                                    IF MaxDeliveryPoints < ItemVendor2."Avg. Delivery Rating" THEN
                                        MaxDeliveryPoints := ItemVendor2."Avg. Delivery Rating";
                                END ELSE BEGIN
                                    PPSetup.GET;
                                    IF PPSetup."Default Delivery Rating" > MaxDeliveryPoints THEN
                                        MaxDeliveryPoints := PPSetup."Default Delivery Rating";
                                END;
                            UNTIL ItemVendor2.NEXT = 0
                        END ELSE BEGIN
                            PPSetup.GET;
                            IF PPSetup."Default Delivery Rating" > MaxDeliveryPoints THEN
                                MaxDeliveryPoints := PPSetup."Default Delivery Rating";
                        END;
                    UNTIL PurchaseLine.NEXT = 0;
            UNTIL PurchaseHeader.NEXT = 0;


        ItemVendor.SETRANGE("Vendor No.", "VendorNo.");
        ItemVendor.SETRANGE("Item No.", "ItemNo.");
        IF ItemVendor.FINDFIRST THEN BEGIN
            //ItemVendor.CALCFIELDS("Total Qty. Supplied","Delivery Rating");
            ItemVendor.CALCFIELDS("Total Qty. Supplied");
            IF ItemVendor."Delivery Rating" = 0 THEN BEGIN //Reach SSr
                EXIT(((PPSetup."Default Delivery Rating" / MaxDeliveryPoints)) * PPSetup."Delivery Weightage")
            END ELSE
                IF (ItemVendor."Total Qty. Supplied" <> 0) AND (ItemVendor."Delivery Rating" <> 0) THEN BEGIN
                    EXIT(((ItemVendor."Avg. Delivery Rating" / MaxDeliveryPoints)) * PPSetup."Delivery Weightage");
                END;
        END ELSE
            EXIT((PPSetup."Default Delivery Rating" / MaxDeliveryPoints) * PPSetup."Delivery Weightage");


        /*
        MaxDeliveryPoints := 0;
        ItemVendor2.RESET;
        PPSetup.GET;
        ItemVendor2.SETRANGE("Item No.","ItemNo.");
        IF ItemVendor2.FINDSET THEN BEGIN
         REPEAT
           ItemVendor2.CALCFIELDS("Delivery Rating","Total Qty. Supplied");
           IF (ItemVendor2."Total Qty. Supplied" <> 100) AND (ItemVendor2."Total Qty. Supplied" <> 0) THEN BEGIN
             ItemVendor2."Avg. Delivery Rating":= (100 * ItemVendor2."Delivery Rating")/ItemVendor2."Total Qty. Supplied";
             ItemVendor2.MODIFY;
             IF MaxDeliveryPoints <  ItemVendor2."Avg. Delivery Rating" THEN
                MaxDeliveryPoints :=   ItemVendor2."Avg. Delivery Rating";
           END ELSE BEGIN
             ItemVendor2."Avg. Delivery Rating":= ItemVendor2."Delivery Rating";
            IF MaxDeliveryPoints < ItemVendor2."Delivery Rating" THEN
              MaxDeliveryPoints := ItemVendor2."Delivery Rating";
           END;
         UNTIL ItemVendor2.NEXT=0;
        END;
        //B2BPO1.2 SSR Start
        IF MaxDeliveryPoints = 0 THEN
          MaxDeliveryPoints := PPSetup."Default Delivery Rating";
        //B2BPO1.2 SSR End;
        
        ItemVendor.SETRANGE("Vendor No.","VendorNo.");
        ItemVendor.SETRANGE("Item No.","ItemNo.");
        IF ItemVendor.FINDFIRST THEN BEGIN
          //ItemVendor.CALCFIELDS("Total Qty. Supplied","Delivery Rating");
          ItemVendor.CALCFIELDS("Total Qty. Supplied");
          IF ItemVendor."Delivery Rating" = 0 THEN   //Reach SSr
             //EXIT(PPSetup."Default Delivery Rating") //Reach SSR
             EXIT(((PPSetup."Default Delivery Rating" / MaxDeliveryPoints)*100) * PPSetup."Delivery Weightage"/100)
          ELSE
          IF (ItemVendor."Total Qty. Supplied" <> 0) AND (ItemVendor."Delivery Rating" <> 0) THEN BEGIN
             EXIT(((ItemVendor."Avg. Delivery Rating" / MaxDeliveryPoints)*100) * PPSetup."Delivery Weightage"/100);
          END;
        END;
        */

    end;


    procedure CalculateQuality("VendorNo.": Code[20]; "ItemNo.": Code[20]; RFQNo: Code[20]) Quality: Decimal;
    var
        PPSetup: Record "Purchases & Payables Setup";
        ItemVendor: Record "Item Vendor";
        ItemVendor2: Record "Item Vendor";
        MaxQualityPoints: Decimal;
        TempQualityRating: Decimal;
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        //sankar modified quality points
        MaxQualityPoints := 0;
        ItemVendor2.RESET;
        PPSetup.GET;
        PurchaseHeader.RESET;
        PurchaseHeader.SETRANGE(PurchaseHeader."RFQ No.", RFQNo);
        IF PurchaseHeader.FINDSET THEN
            REPEAT
                PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                PurchaseLine.SETRANGE("No.", "ItemNo.");
                IF PurchaseLine.FINDSET THEN
                    REPEAT
                        ItemVendor2.SETRANGE("Vendor No.", PurchaseLine."Buy-from Vendor No.");
                        ItemVendor2.SETRANGE("Item No.", "ItemNo.");
                        IF ItemVendor2.FINDSET THEN BEGIN
                            REPEAT
                                //ItemVendor2.CALCFIELDS("Quality Rating","Total Qty. Supplied");
                                ItemVendor2.CALCFIELDS("Total Qty. Supplied");
                                //Ramu
                                IF (ItemVendor2."Total Qty. Supplied" <> 0) AND (ItemVendor2."Quality Rating" <> 0) THEN BEGIN
                                    ItemVendor2."Avg. Quality Rating" := (ItemVendor2."Quality Rating") / ItemVendor2."Total Qty. Supplied";
                                    ItemVendor2.MODIFY;
                                    IF MaxQualityPoints < ItemVendor2."Avg. Quality Rating" THEN
                                        MaxQualityPoints := ItemVendor2."Avg. Quality Rating";
                                END ELSE BEGIN
                                    PPSetup.GET;
                                    //error
                                    IF PPSetup."Default Quality Rating" > MaxQualityPoints THEN
                                        MaxQualityPoints := PPSetup."Default Quality Rating";
                                END;
                            UNTIL ItemVendor2.NEXT = 0;
                        END ELSE BEGIN
                            PPSetup.GET;
                            IF PPSetup."Default Quality Rating" > MaxQualityPoints THEN
                                MaxQualityPoints := PPSetup."Default Quality Rating";
                        END;
                    UNTIL PurchaseLine.NEXT = 0;
            UNTIL PurchaseHeader.NEXT = 0;

        ItemVendor.SETRANGE("Vendor No.", "VendorNo.");
        ItemVendor.SETRANGE("Item No.", "ItemNo.");
        IF ItemVendor.FINDFIRST THEN BEGIN
            //ItemVendor.CALCFIELDS("Total Qty. Supplied","Quality Rating");
            ItemVendor.CALCFIELDS("Total Qty. Supplied");
            IF ItemVendor."Quality Rating" = 0 THEN
                EXIT(((PPSetup."Default Quality Rating" / MaxQualityPoints)) * PPSetup."Quality Weightage")
            ELSE
                IF (ItemVendor."Total Qty. Supplied" <> 0) AND (ItemVendor."Quality Rating" <> 0) THEN
                    EXIT(((ItemVendor."Avg. Quality Rating" / MaxQualityPoints) * PPSetup."Quality Weightage"));
        END ELSE
            EXIT((PPSetup."Default Quality Rating" / MaxQualityPoints) * PPSetup."Quality Weightage");

        /*
        MaxQualityPoints := 0;
        ItemVendor2.RESET;
        PPSetup.GET;
        ItemVendor2.SETRANGE("Item No.","ItemNo.");
        IF ItemVendor2.FINDSET THEN BEGIN
         REPEAT
           ItemVendor2.CALCFIELDS("Quality Rating","Total Qty. Supplied");
           IF (ItemVendor2."Total Qty. Supplied" <> 100) AND (ItemVendor2."Total Qty. Supplied" <> 0)THEN BEGIN
             ItemVendor2."Avg. Quality Rating" := (100 * ItemVendor2."Quality Rating")/ItemVendor2."Total Qty. Supplied";
             ItemVendor2.MODIFY;
             IF MaxQualityPoints <  ItemVendor2."Avg. Quality Rating"  THEN
                MaxQualityPoints :=  ItemVendor2."Avg. Quality Rating";
           END ELSE BEGIN
              ItemVendor2."Avg. Quality Rating" := ItemVendor2."Quality Rating";
               ItemVendor2.MODIFY;
             IF MaxQualityPoints < ItemVendor2."Quality Rating" THEN
                MaxQualityPoints := ItemVendor2."Quality Rating";
           END;
         UNTIL ItemVendor2.NEXT=0;
        END;
        //B2BPO1.2 SSR Start
        IF MaxQualityPoints = 0 THEN
          MaxQualityPoints := PPSetup."Default Quality Rating";
        //B2BPO1.2 SSR End;
        ItemVendor.SETRANGE("Vendor No.","VendorNo.");
        ItemVendor.SETRANGE("Item No.","ItemNo.");
        IF ItemVendor.FINDFIRST THEN BEGIN
          ItemVendor.CALCFIELDS("Total Qty. Supplied","Quality Rating");
          IF ItemVendor."Quality Rating" = 0 THEN  //Reach SSR
              //EXIT(PPSetup."Default Quality Rating") //Reach SSR
              EXIT(((PPSetup."Default Quality Rating" /MaxQualityPoints)*100) * PPSetup."Quality Weightage"/100)
          ELSE
          IF (ItemVendor."Total Qty. Supplied" <> 0) AND (ItemVendor."Quality Rating" <> 0) THEN
            EXIT(((ItemVendor."Avg. Quality Rating" /MaxQualityPoints)*100) * PPSetup."Quality Weightage"/100);
        END;
         */

    end;


    procedure ConvertEnquirytoQuote(var Rec: Record "Purchase Header");
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
        PurchaseLineQuote: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        Text001: Label 'Enquiry number %1 has been Converted to Quote number %2';
        IndentLine: Record "Indent Line";
        ItemVendor: Record "Item Vendor";
    begin
        PurchaseHeader.INIT;
        PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Quote;
        PurchaseSetup.GET;
        PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PurchaseSetup."Quote Nos.", WORKDATE, TRUE);
        PurchaseHeader."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
        PurchaseHeader."Requested Receipt Date" := Rec."Requested Receipt Date";
        PurchaseHeader.VALIDATE("Buy-from Vendor No.");
        PurchaseHeader."Order Date" := WORKDATE;
        PurchaseHeader."Due Date" := Rec."Due Date";
        PurchaseHeader."Document Date" := WORKDATE;
        PurchaseHeader."Requested Receipt Date" := Rec."Requested Receipt Date";
        //Reach-SSR for subcontracign quote
        IF Rec.Subcontracting THEN
            PurchaseHeader.Subcontracting := Rec.Subcontracting;
        PurchaseHeader."Location Code" := Rec."Location Code";//REach SSR
        PurchaseHeader.VALIDATE("Location Code");
        PurchaseHeader."ICN No." := Rec."ICN No.";
        PurchaseHeader.INSERT;
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Enquiry);
        PurchaseLine.SETRANGE("Document No.", Rec."No.");
        IF PurchaseLine.FINDSET THEN
            REPEAT
                PurchaseLineQuote.INIT;
                PurchaseLineQuote."Document Type" := PurchaseLineQuote."Document Type"::Quote;
                PurchaseLineQuote."Document No." := PurchaseHeader."No.";
                PurchaseLineQuote."Buy-from Vendor No." := Rec."Buy-from Vendor No.";
                PurchaseLineQuote."Line No." := PurchaseLineQuote."Line No." + 10000;
                IF PurchaseLine.Type = PurchaseLine.Type::Item THEN BEGIN
                    PurchaseLineQuote.Type := PurchaseLineQuote.Type::Item;
                    PurchaseLineQuote."No." := PurchaseLine."No.";
                    //NSS1.0 >> BEGIN
                    ItemVendor.SETRANGE("Vendor No.", PurchaseLineQuote."Buy-from Vendor No.");
                    ItemVendor.SETRANGE("Item No.", PurchaseLineQuote."No.");
                    IF ItemVendor.FINDSET THEN
                        REPEAT
                            ItemVendor.Approved := TRUE;
                            ItemVendor.MODIFY
                        UNTIL ItemVendor.NEXT = 0;
                    //NSS1.0 >> END
                    PurchaseLineQuote.VALIDATE("No.");
                    PurchaseLineQuote.Quantity := PurchaseLine.Quantity;
                    PurchaseLineQuote.VALIDATE(Quantity);
                    PurchaseLineQuote."Unit of Measure" := PurchaseLine."Unit of Measure";
                    PurchaseLineQuote."Indent No." := PurchaseLine."Indent No.";
                    PurchaseLineQuote."Indent Line No." := PurchaseLine."Indent Line No.";
                    PurchaseLineQuote."ICN No." := PurchaseLine."ICN No.";//Reach SSR
                END ELSE BEGIN
                    PurchaseLineQuote.Type := PurchaseLineQuote.Type::" ";
                    PurchaseLineQuote.Description := PurchaseLine.Description;
                END;
                PurchaseLineQuote."Location Code" := PurchaseLine."Location Code";
                PurchaseLineQuote.VALIDATE("Location Code");
                IF NOT Rec.Subcontracting THEN BEGIN //Reach SSR for subcon
                    IndentLine.SETRANGE("Document No.", PurchaseLine."Indent No.");
                    IndentLine.SETRANGE("Line No.", PurchaseLine."Indent Line No.");
                    IF IndentLine.FINDFIRST THEN BEGIN
                        IndentLine."Indent Status" := IndentLine."Indent Status"::Offer;
                        IndentLine.MODIFY;
                    END;
                END; //Reach SSR for subcon
                PurchaseLineQuote.INSERT;
            UNTIL PurchaseLine.NEXT = 0;

        MESSAGE(Text001, Rec."No.", PurchaseLineQuote."Document No.");
        //NSS1.0 >> BEGIN
        ItemVendor.SETRANGE("Vendor No.", PurchaseLineQuote."Buy-from Vendor No.");
        ItemVendor.SETRANGE("Item No.", PurchaseLineQuote."No.");
        IF ItemVendor.FINDSET THEN
            REPEAT
                IF ItemVendor."Refernce Number" = FALSE THEN BEGIN
                    ItemVendor.Approved := FALSE;
                    ItemVendor.MODIFY
                END;
            UNTIL ItemVendor.NEXT = 0;
        //NSS1.0 << END

        Rec.DELETE;
    end;


    procedure CreateSubEnquiries(RequisitionLine: Record "Requisition Line");
    var
        IndentVendorItems: Record "Indent Vendor Items";
        IndentVendorEnquiry: Record "Indent Vendor Items";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NoSeriesMgt: Codeunit 396;
        PPSetup: Record "Purchases & Payables Setup";
        CreateIndents: Record "Create Indents";
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
    begin
        InsertSubIndentItemvendor(RequisitionLine);
        IndentVendorItems.RESET;
        IndentVendorItems.SETRANGE(Check, FALSE);
        IndentVendorItems.SETRANGE(Subcontracting, TRUE);
        IF IndentVendorItems.FINDSET THEN
            REPEAT
                IndentVendorEnquiry.SETRANGE("Vendor No.", IndentVendorItems."Vendor No.");
                IndentVendorEnquiry.SETRANGE("Location Code", IndentVendorItems."Location Code");//Reach SSR
                IndentVendorEnquiry.SETRANGE(Check, FALSE);//Reach SSR Testing
                IF IndentVendorEnquiry.FINDFIRST THEN BEGIN
                    PurchaseHeader.INIT;
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Enquiry;
                    PPSetup.GET;
                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Enquiry Nos.", WORKDATE, TRUE);
                    PurchaseHeader."Buy-from Vendor No." := IndentVendorEnquiry."Vendor No.";
                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                    PurchaseHeader."Location Code" := IndentVendorEnquiry."Location Code";
                    PurchaseHeader.VALIDATE("Location Code");
                    PurchaseHeader.Subcontracting := TRUE;
                    PurchaseHeader."Due Date" := IndentVendorEnquiry."Due Date";
                    PurchaseHeader."Expected Receipt Date" := IndentVendorEnquiry."Due Date";
                    PurchaseHeader.VALIDATE("Due Date");
                    PurchaseHeader.INSERT;
                    REPEAT
                        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Enquiry);
                        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
                        PurchaseLine.SETRANGE("No.", IndentVendorEnquiry."Item No.");
                        IF PurchaseLine.FINDFIRST THEN BEGIN
                            PurchaseLine.Quantity := PurchaseLine.Quantity + IndentVendorEnquiry.Quantity;
                            PurchaseLine.MODIFY;
                        END ELSE BEGIN
                            PurchaseLine.INIT;
                            PurchaseLine."Document Type" := PurchaseLine."Document Type"::Enquiry;
                            PurchaseLine."Document No." := PurchaseHeader."No.";
                            PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                            PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                            PurchaseLine.Type := PurchaseLine.Type::Item;
                            PurchaseLine."No." := IndentVendorEnquiry."Item No.";
                            PurchaseLine.VALIDATE(PurchaseLine."No.");
                            PurchaseLine.Quantity := IndentVendorEnquiry.Quantity;
                            PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                            PurchaseLine."Location Code" := IndentVendorEnquiry."Location Code";
                            PurchaseLine.VALIDATE("Location Code");
                            // PurchaseLine."Indent No." := IndentVendorEnquiry."Indent No.";
                            // PurchaseLine."Indent Line No." := IndentVendorEnquiry."Indent Line No.";
                            // PurchaseLine."ICN No." := IndentVendorEnquiry."ICN No."; //ReachSSR
                            PurchaseLine."Unit of Measure Code" := RequisitionLine."Unit of Measure Code";
                            PurchaseLine."Unit of Measure" := RequisitionLine."Unit of Measure Code";
                            PurchaseLine."Expected Receipt Date" := IndentVendorEnquiry."Due Date";
                            PurchaseLine.INSERT;
                        END;
                        IndentVendorEnquiry.Check := TRUE;
                        IndentVendorEnquiry.MODIFY;
                    UNTIL IndentVendorEnquiry.NEXT = 0;
                END;
            UNTIL IndentVendorItems.NEXT = 0;
    end;


    procedure InsertSubIndentItemvendor(ReqLine: Record "Requisition Line");
    var
        IndentVendorItems: Record "Indent Vendor Items";
        ItemVendor: Record "Item Vendor";
        CreateIndents: Record "Create Indents";
        RequisitionLine: Record "Requisition Line";
    begin
        IndentVendorItems.DELETEALL;
        ReqLine.SETRANGE("Worksheet Template Name", 'FOR. LABOR');
        IF ReqLine.FINDSET THEN BEGIN
            REPEAT
                IndentVendorItems.INIT;
                IndentVendorItems."Item No." := ReqLine."No.";
                IndentVendorItems.Quantity := ReqLine.Quantity;

                IndentVendorItems."Due Date" := ReqLine."Due Date";
                IndentVendorItems.Check := FALSE;
                IndentVendorItems.Subcontracting := TRUE;
                IndentVendorItems."Indent Line No." := ReqLine."Line No.";
                IndentVendorItems."Location Code" := ReqLine."Location Code";
                ItemVendor.SETRANGE("Item No.", IndentVendorItems."Item No.");
                IF ItemVendor.FINDSET THEN
                    REPEAT
                        IndentVendorItems."Vendor No." := ItemVendor."Vendor No.";
                        IndentVendorItems.INSERT;
                    UNTIL ItemVendor.NEXT = 0;
                ReqLine."Enquiry Created" := TRUE;
                ReqLine.MODIFY;
            UNTIL ReqLine.NEXT = 0;
        END;
    end;


    procedure "--PO1.0---"();
    begin
    end;


    procedure InsertOrderItemvendor(var Vendor: Record Vendor; var CreateIndentsLocal: Record "Create Indents");
    var
        IndentVendorItems: Record "Indent Vendor Items";
        ItemVendor: Record "Item Vendor";
        CreateIndents: Record "Create Indents";
        MOQ_Temp: Decimal;
    begin
        IndentVendorItems.DELETEALL;
        CreateIndents.COPYFILTERS(CreateIndentsLocal);
        IF CreateIndents.FINDSET THEN
            REPEAT
                IndentVendorItems.INIT;
                IndentVendorItems.Type := CreateIndents.Type; // added by Vishnu Priya on 09-11-2020
                IndentVendorItems."Item No." := CreateIndents."Item No.";
                IndentVendorItems.Description := CreateIndents.Description;
                IndentVendorItems."Part Number" := CreateIndents."Part Number"; // added by Vishnu Priya on 13-11-2020
                Item.RESET;
                Item.SETFILTER(Item."No.", CreateIndents."Item No.");
                IF Item.FINDFIRST THEN BEGIN
                    IndentVendorItems."Lead Time" := FORMAT(Item."Safety Lead Time");
                    IF CreateIndents."Location Code" = 'STR' THEN BEGIN
                        IF Item.EFF_MOQ > 0 THEN
                            MOQ_Temp := Item.EFF_MOQ
                        ELSE
                            MOQ_Temp := Item."Minimum Order Quantity";
                        IF MOQ_Temp > CreateIndents.Quantity THEN
                            IndentVendorItems.Quantity := MOQ_Temp
                        ELSE
                            IndentVendorItems.Quantity := CreateIndents.Quantity;
                    END
                    ELSE
                        IndentVendorItems.Quantity := CreateIndents.Quantity;
                END
                ELSE BEGIN
                    IndentVendorItems.Quantity := CreateIndents.Quantity;
                    IndentVendorItems."Lead Time" := '0D';
                END;

                IndentVendorItems.Quantity := CreateIndents.Quantity;
                IndentVendorItems."Unit of Measure" := CreateIndents."Unit of Measure";
                IndentVendorItems."Indent No." := CreateIndents."Indent No.";
                IndentVendorItems."Indent Line No." := CreateIndents."Indent Line No.";
                IndentVendorItems."ICN No." := CreateIndents."ICN No.";//ReachSSR
                                                                       //NSS1.0 >> BEGIN
                IndentVendorItems."Manufacturer Code" := CreateIndents."Manufacturer Code";
                //NSS1.0 << END
                IndentVendorItems."Due Date" := CreateIndents."Due Date";
                IndentVendorItems.Check := FALSE;
                IndentVendorItems."Location Code" := CreateIndents."Location Code";
                IF NOT Vendor.FINDSET THEN
                    ERROR('First Select Vendor')
                ELSE BEGIN
                    REPEAT
                        IndentVendorItems."Vendor No." := Vendor."No.";
                        //IndentVendorItems.Approved := ItemVendor.Approved; //KPK
                        IndentVendorItems.INSERT;
                    UNTIL Vendor.NEXT = 0;
                END;
            UNTIL CreateIndents.NEXT = 0;
    end;


    procedure CreateOrder(var Vendor: Record Vendor; var CreateIndentsLocal: Record "Create Indents");
    var
        IndentVendorItems: Record "Indent Vendor Items";
        IndentVendorEnquiry: Record "Indent Vendor Items";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NoSeriesMgt: Codeunit 396;
        PPSetup: Record "Purchases & Payables Setup";
        CreateIndents2: Record "Create Indents";
        IndentLine: Record "Indent Line";
        text000: Label 'Orders created successfully';
    begin
        //IF NOT CONFIRM(Text011,FALSE) THEN
        //  EXIT;
        InsertOrderItemvendor(Vendor, CreateIndentsLocal);
        IndentVendorItems.RESET;
        IndentVendorItems.SETRANGE(Check, FALSE);
        IF IndentVendorItems.FINDSET THEN
            REPEAT
                IndentVendorEnquiry.RESET;
                IndentVendorEnquiry.SETRANGE("Vendor No.", IndentVendorItems."Vendor No.");
                IndentVendorEnquiry.SETRANGE("Location Code", IndentVendorItems."Location Code");//Reach SSR
                                                                                                 //IndentVendorEnquiry.SETRANGE(IndentVendorEnquiry."Lead Time",IndentVendorItems."Lead Time");
                                                                                                 // IndentVendorEnquiry.SETRANGE("ICN No.",IndentVendorItems."ICN No.");  //reach ssr
                IF IndentVendorEnquiry.FINDFIRST THEN BEGIN
                    PurchaseHeader.INIT;
                    PurchaseHeader."Document Type" := PurchaseHeader."Document Type"::Order;
                    PPSetup.GET;
                    PurchaseHeader."No." := NoSeriesMgt.GetNextNo(PPSetup."Order Nos.", WORKDATE, TRUE);
                    MESSAGE('purchase order no %1', PurchaseHeader."No.");
                    PurchaseHeader."Buy-from Vendor No." := IndentVendorEnquiry."Vendor No.";
                    PurchaseHeader.VALIDATE(PurchaseHeader."Buy-from Vendor No.");
                    PurchaseHeader."Order Date" := TODAY;
                    PurchaseHeader."Posting Date" := TODAY;
                    PurchaseHeader."Location Code" := IndentVendorEnquiry."Location Code";
                    PurchaseHeader.VALIDATE("Location Code");
                    PurchaseHeader."ICN No." := IndentVendorEnquiry."ICN No.";
                    PurchaseHeader."Document Date" := TODAY;  //Added by Vishnu Priya on 04-02-2020
                    PurchaseHeader."Packing Type" := 'STANDARD PACKING';
                    IF IndentVendorEnquiry."Location Code" IN ['STR', 'PROD'] THEN
                        PurchaseHeader."Shortcut Dimension 1 Code" := 'PRD-0010'
                    ELSE
                        IF IndentVendorEnquiry."Location Code" = 'CS STR' THEN
                            PurchaseHeader."Shortcut Dimension 1 Code" := 'CUS-005'
                        ELSE
                            IF IndentVendorEnquiry."Location Code" = 'R&D STR' THEN
                                PurchaseHeader."Shortcut Dimension 1 Code" := 'RD-000';
                    //PurchaseHeader."Shortcut Dimension 1 Code":='PRD-0010';
                    PurchaseHeader.INSERT;
                    //PurchaseHeader.VALIDATE("Payment Terms Code");
                    //added  by Vishnu Priya on 05-02-2020
                    IF (PurchaseHeader."Payment Terms Code" <> '') AND (PurchaseHeader."Document Date" <> 0D) THEN BEGIN
                        PaymentTerms.GET(PurchaseHeader."Payment Terms Code");
                        BEGIN
                            PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."Document Date");
                            PurchaseHeader."Pmt. Discount Date" := CALCDATE(PaymentTerms."Discount Date Calculation", PurchaseHeader."Document Date");
                            PurchaseHeader.MODIFY;
                        END
                    END;
                    //added  by Vishnu Priya on 05-02-2020
                    REPEAT
                        PurchaseLine.INIT;
                        PurchaseLine."Document Type" := PurchaseLine."Document Type"::Order;
                        PurchaseLine."Document No." := PurchaseHeader."No.";
                        PurchaseLine."Line No." := PurchaseLine."Line No." + 10000;
                        PurchaseLine."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
                        //PurchaseLine.Type := PurchaseLine.Type :: Item; // commented by Vishnu Priya  on 09-11-2020 for the G/L Accounts process
                        // added by Vishnu Priya on 09-11-2020
                        IF IndentVendorEnquiry.Type = IndentVendorEnquiry.Type::"G/L Account" THEN
                            PurchaseLine.Type := PurchaseLine.Type::"G/L Account"
                        ELSE
                            IF IndentVendorEnquiry.Type = IndentVendorEnquiry.Type::Item THEN
                                PurchaseLine.Type := PurchaseLine.Type::Item
                            ELSE
                                IF IndentVendorEnquiry.Type = IndentVendorEnquiry.Type::"Fixed Asset" THEN
                                    PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset";
                        //PurchaseLine.Type := IndentVendorEnquiry.Type; // added by Vishnu Priya on 09-11-2020
                        PurchaseLine."No." := IndentVendorEnquiry."Item No.";
                        PurchaseLine.VALIDATE(PurchaseLine."No.");
                        PurchaseLine.Description := IndentVendorEnquiry.Description;// added by Vishnu Priya on 11-11-2020
                        PurchaseLine.Quantity := IndentVendorEnquiry.Quantity;
                        PurchaseLine.VALIDATE(PurchaseLine.Quantity);
                        PurchaseLine."Indent No." := IndentVendorEnquiry."Indent No.";
                        PurchaseLine."Indent Line No." := IndentVendorEnquiry."Indent Line No.";
                        PurchaseLine."Document Date" := TODAY; //Added by Vishnu Priya on 04-02-2020
                                                               //PurchaseLine."Part Number" := IndentVendorEnquiry."Part Number";
                                                               // added by Vishnu Priya on 13-11-2020
                        ItemVar.RESET;
                        IF ItemVar.GET(IndentVendorEnquiry."Item No.") THEN
                            PurchaseLine."Part Number" := ItemVar."Part Number";

                        PurchaseLine."ICN No." := IndentVendorEnquiry."ICN No."; //ReachSSR
                                                                                 //NSS1.0 >> BEGIN
                                                                                 //NSS1.0 << END
                        PurchaseLine."Location Code" := IndentVendorEnquiry."Location Code";
                        PurchaseLine.VALIDATE("Location Code");

                        purchInvLine.RESET;
                        purchInvLine.SETFILTER(purchInvLine."No.", IndentVendorEnquiry."Item No.");
                        purchInvLine.SETCURRENTKEY(Type, "No.", "Variant Code", "Invoice Date");
                        IF purchInvLine.FINDLAST THEN
                            PurchaseLine."Direct Unit Cost" := purchInvLine."Direct Unit Cost";




                        PurchaseLine.INSERT;
                        IndentVendorEnquiry.Check := TRUE;
                        IndentVendorEnquiry.MODIFY;
                    UNTIL IndentVendorEnquiry.NEXT = 0;
                END;
            UNTIL IndentVendorItems.NEXT = 0;

        CreateIndents2.RESET;
        CreateIndents2.SETRANGE("Accept Action Message", TRUE);
        IF CreateIndents2.FINDSET THEN
            REPEAT
                IndentLine.SETRANGE("Delivery Location", CreateIndents2."Location Code");
                IndentLine.SETRANGE("No.", CreateIndents2."Item No.");
                IndentLine.SETRANGE("ICN No.", CreateIndents2."ICN No.");
                IndentLine.SETRANGE(Description, CreateIndents2.Description); //ADDED AFTER THE GL ANF FIXED ASSETS ADDING
                IndentLine.SETRANGE(IndentLine."Indent Status", IndentLine."Indent Status"::Indent);
                //    IndentLine.SETRANGE(IndentLine."Release Status",IndentLine."Release Status"::"1");
                /*
                IndentLine.SETRANGE("Document No.",CreateIndents."Indent No.");
                IndentLine.SETRANGE("Line No.",CreateIndents."Indent Line No.");
                */
                IF IndentLine.FINDSET THEN
                    REPEAT
                        IndentLine."Indent Status" := IndentLine."Indent Status"::Order;
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            UNTIL CreateIndents2.NEXT = 0;
        CreateIndents2.SETRANGE("Accept Action Message", TRUE);
        CreateIndents2.DELETEALL;

    end;


    procedure Get_BOI_Lines();
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Item: Record Item;
        Sch: Record Schedule2;
        SHA: Record "Sales Header Archive";
        ReleasedFlag: Boolean;
        BOITable: Record "Sales Bought Out Material List";
        BOITble: Record "Sales Bought Out Material List";
        PostdMatIssHedrGRec: Record "Posted Material Issues Header";
        PostedMatIssLinGRec: Record "Posted Material Issues Line";
        PMIQty: Decimal;
    begin
        // Added by Pranavi on 29-Nov-2016
        ReleasedFlag := FALSE;
        BOITable.DELETEALL;
        BOITable.RESET;
        SH.RESET;
        //SH.SETRANGE(SH."No.",'EFF/SAL/17-18/0001');
        SH.SETRANGE(SH."Document Type", SH."Document Type"::Order);
        SH.SETFILTER("Order Status", '<>%1', 8); //added by Vishnu Priya  on 21-Nov-2019
        IF SH.FINDFIRST THEN
            REPEAT
                ReleasedFlag := FALSE;
                IF SH.Status = SH.Status::Released THEN
                    ReleasedFlag := TRUE
                ELSE BEGIN
                    SHA.RESET;
                    SHA.SETRANGE(SHA."No.", SH."No.");
                    IF SHA.FINDFIRST THEN
                        ReleasedFlag := TRUE;
                END;
                IF ReleasedFlag = TRUE THEN BEGIN
                    SL.RESET;
                    SL.SETRANGE(SL."Document No.", SH."No.");
                    SL.SETFILTER(SL.Quantity, '>%1', 0);
                    SL.SETFILTER(SL."No.", '<>%1', '');
                    SL.SETRANGE(SL."Pending By", SL."Pending By"::" ");
                    SL.SETFILTER(SL."Outstanding Quantity", '>%1', 0);
                    IF SL.FINDSET THEN
                        REPEAT
                            //BOITable.RESET;
                            IF (SL."Gen. Prod. Posting Group" IN ['BOI', 'RAW-MAT']) AND (SL."Outstanding Quantity" > 0) /*AND NOT (SL."No." IN ['ECBOUBT00004','BOICHAR00014'])*/ THEN BEGIN
                                BOITable.INIT;
                                BOITable."Document Type" := BOITable."Document Type"::Order;
                                BOITable."Document No" := SH."No.";
                                BOITable."Line No" := SL."Line No.";
                                BOITable."Schedule Line No" := 0;
                                BOITable.Type := SL.Type;
                                BOITable.No := SL."No.";
                                BOITable.Description := SL.Description;
                                BOITable."Description 2" := SL."Description 2";
                                BOITable.Quanity := SL.Quantity;
                                BOITable."Qty Shipped" := SL."Quantity Shipped";
                                BOITable."To Be Shipped Qty" := SL."Outstanding Quantity";
                                BOITable."Sell To Customer No" := SH."Sell-to Customer No.";
                                BOITable."Sell To Customer Name" := SH."Sell-to Customer Name";
                                BOITable."Planned Dispatch Date" := SL."Planned Dispatch Date";
                                BOITable."Purchase Remarks" := SL."Purchase Remarks";
                                BOITable."RDSO Inspection Required" := SL."RDSO Inspection Required";
                                BOITable."Pending By" := SL."Pending By";
                                BOITable."Posting Group" := SL."Gen. Prod. Posting Group";
                                Item.RESET;
                                Item.SETRANGE(Item."No.", SL."No.");
                                IF Item.FINDFIRST THEN BEGIN
                                    BOITable."Item Lead Time" := Item."Safety Lead Time";
                                    IF SL."Unit of Measure Code" <> '' THEN
                                        BOITable."Unit Of Measure" := SL."Unit of Measure Code"
                                    ELSE
                                        BOITable."Unit Of Measure" := Item."Base Unit of Measure";
                                END;

                                PMIQty := 0;
                                PostdMatIssHedrGRec.RESET;
                                PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", SL."Document No.");
                                //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                                PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                                IF PostdMatIssHedrGRec.FINDSET THEN
                                    REPEAT
                                        PostedMatIssLinGRec.RESET;
                                        PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                        PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", SL."No.");
                                        PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                        IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                            PMIQty += PostedMatIssLinGRec.Quantity;
                                        END;
                                    UNTIL PostdMatIssHedrGRec.NEXT = 0;
                                BOITable."Issued Material Qty" := PMIQty;
                                //Added  by Vishnu on 21-11-2019
                                PH.RESET;
                                PH.SETFILTER("Sale Order No", SH."No.");
                                Qty := 0;
                                OutStndQty := 0;
                                IF PH.FINDSET THEN
                                    REPEAT
                                    BEGIN
                                        PL.RESET;
                                        PL.SETCURRENTKEY("Document Type", Type, "No.");
                                        PL.SETFILTER("Document No.", PH."No.");
                                        PL.SETFILTER("No.", '%1', SL."No.");
                                        PL.SETFILTER(Quantity, '>%1', 0);
                                        IF PL.FINDSET THEN
                                            REPEAT
                                            BEGIN
                                                BOITable."Purchase Order  Number" := PH."No.";
                                                BOITable."Vendor Name" := PH."Buy-from Vendor Name";
                                                Qty += PL.Quantity;
                                                OutStndQty += PL."Outstanding Quantity"
                                            END;
                                            BOITable."Ordered Qty" := Qty;
                                            BOITable."To Be Rec Qty" := OutStndQty;
                                            UNTIL PL.NEXT = 0;
                                    END;
                                    UNTIL PH.NEXT = 0;
                                //end by Vishnu on 21-11-2019

                                BOITble.RESET;
                                BOITble.SETRANGE(BOITble."Document Type", BOITable."Document Type");
                                BOITble.SETRANGE(BOITble."Document No", BOITable."Document No");
                                BOITble.SETRANGE(BOITble."Line No", BOITable."Line No");
                                BOITble.SETRANGE(BOITble."Schedule Line No", BOITable."Schedule Line No");
                                IF NOT BOITble.FINDFIRST THEN
                                    BOITable.INSERT;
                            END;
                            Sch.RESET;
                            Sch.SETRANGE(Sch."Document No.", SL."Document No.");
                            Sch.SETRANGE(Sch."Document Line No.", SL."Line No.");
                            Sch.SETFILTER(Sch."Posting Group", '%1|%2', 'RAW-MAT', 'BOI');
                            Sch.SETFILTER(Sch.Quantity, '>%1', 0);
                            Sch.SETFILTER(Sch."No.", '<>%1', '');
                            Sch.SETFILTER(Sch."Outstanding Qty.", '>%1', 0);
                            IF Sch.FINDSET THEN
                                REPEAT
                                    IF (Sch."Document Line No." <> Sch."Line No.") OR ((Sch."No." <> SL."No.") AND (Sch."Document Line No." = Sch."Line No.")) /*AND NOT (Sch."No." IN ['ECBOUBT00004','BOICHAR00014'])*/ THEN BEGIN
                                        //BOITable.RESET;
                                        BOITable.INIT;
                                        BOITable."Document Type" := BOITable."Document Type"::Order;
                                        BOITable."Document No" := SH."No.";
                                        BOITable."Line No" := SL."Line No.";
                                        BOITable."Schedule Line No" := Sch."Line No.";
                                        CASE Sch.Type OF
                                            Sch.Type::Item:
                                                BOITable.Type := BOITable.Type::Item;
                                            Sch.Type::"G/l Account":
                                                BOITable.Type := BOITable.Type::"G/L Account";
                                            Sch.Type::" ":
                                                BOITable.Type := BOITable.Type::" ";
                                        END;
                                        BOITable.No := Sch."No.";
                                        BOITable.Description := Sch.Description;
                                        BOITable.Quanity := Sch.Quantity;
                                        BOITable."Qty Shipped" := Sch."Qty. Shipped";
                                        BOITable."To Be Shipped Qty" := Sch."Outstanding Qty.";
                                        BOITable."Sell To Customer No" := SH."Sell-to Customer No.";
                                        BOITable."Sell To Customer Name" := SH."Sell-to Customer Name";
                                        BOITable."Planned Dispatch Date" := Sch."Planned Dispatch Date";
                                        BOITable."Purchase Remarks" := Sch."Purchase Remarks";
                                        BOITable."RDSO Inspection Required" := Sch."RDSO Required";
                                        BOITable."Pending By" := SL."Pending By";
                                        BOITable."Posting Group" := Sch."Posting Group";
                                        Item.RESET;
                                        Item.SETRANGE(Item."No.", Sch."No.");
                                        IF Item.FINDFIRST THEN BEGIN
                                            BOITable."Item Lead Time" := Item."Safety Lead Time";
                                            IF Sch."Unit of Measure Code" <> '' THEN
                                                BOITable."Unit Of Measure" := Sch."Unit of Measure Code"
                                            ELSE
                                                BOITable."Unit Of Measure" := Item."Base Unit of Measure";
                                        END;

                                        PMIQty := 0;
                                        PostdMatIssHedrGRec.RESET;
                                        PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", Sch."Document No.");
                                        //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                                        PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                                        IF PostdMatIssHedrGRec.FINDSET THEN
                                            REPEAT
                                                PostedMatIssLinGRec.RESET;
                                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", Sch."No.");
                                                PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                                IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                                    PMIQty += PostedMatIssLinGRec.Quantity;
                                                END;
                                            UNTIL PostdMatIssHedrGRec.NEXT = 0;
                                        BOITable."Issued Material Qty" := PMIQty;
                                        //Added  by Vishnu on 21-11-2019
                                        PH.RESET;
                                        PH.SETFILTER("Sale Order No", SH."No.");
                                        Qty := 0;
                                        OutStndQty := 0;
                                        IF PH.FINDSET THEN
                                            REPEAT
                                            BEGIN
                                                PL.RESET;
                                                PL.SETCURRENTKEY("Document Type", Type, "No.");
                                                PL.SETFILTER("Document No.", PH."No.");
                                                PL.SETFILTER("No.", '%1', Sch."No.");
                                                PL.SETFILTER(Quantity, '>%1', 0);
                                                IF PL.FINDSET THEN
                                                    REPEAT
                                                    BEGIN
                                                        BOITable."Purchase Order  Number" := PH."No.";
                                                        BOITable."Vendor Name" := PH."Buy-from Vendor Name";
                                                        Qty += PL.Quantity;
                                                        OutStndQty += PL."Outstanding Quantity"
                                                    END;
                                                    BOITable."Ordered Qty" := Qty;
                                                    BOITable."To Be Rec Qty" := OutStndQty;
                                                    UNTIL PL.NEXT = 0;
                                            END;
                                            UNTIL PH.NEXT = 0;
                                        //end by Vishnu on 21-11-2019

                                        BOITble.RESET;
                                        BOITble.SETRANGE(BOITble."Document Type", BOITable."Document Type");
                                        BOITble.SETRANGE(BOITble."Document No", BOITable."Document No");
                                        BOITble.SETRANGE(BOITble."Line No", BOITable."Line No");
                                        BOITble.SETRANGE(BOITble."Schedule Line No", BOITable."Schedule Line No");
                                        IF NOT BOITble.FINDFIRST THEN
                                            BOITable.INSERT;
                                    END;
                                UNTIL Sch.NEXT = 0;
                        UNTIL SL.NEXT = 0;
                END;
            UNTIL SH.NEXT = 0;
        BOITable.RESET;
        // End--Pranavi

    end;
}

