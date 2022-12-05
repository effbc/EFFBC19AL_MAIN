page 60183 "Purchase Order-Inventory"
{
    // version NAVW13.70,NAVIN3.70.01.13,QC1.0,DIM1.0,Rev01

    // PROJECT : Efftronics
    // ********************************************************************************************************************************************
    // SIGN
    // ********************************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // ********************************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                          DESCRIPTION
    // ********************************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13            -> Code has been commented in ConvertOrdertoExportOrder() For Document Dimensions
    //                                                                Tables are does not exist in the NAV 2013 and added new Code to Modify the
    //                                                                Dimension Set ID in SalesExportOrderHeader and insert the Dimension Set ID in SalesExportorderLine

    Caption = 'Purchase Order-Inventory';
    PageType = Document;
    RefreshOnActivate = true;
    SaveValues = true;
     DeleteAllowed=false;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Order), Subcontracting = CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BuyfromVendorNoOnAfterValidate;
                    end;
                }
                field("Buy-from Contact No."; "Buy-from Contact No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from City"; "Buy-from City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sale Order No"; "Sale Order No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /*  field(Control1280004; Structure)
                  {
                      Editable = true;
                  }*/
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin

                        IF USERID <> 'SUPER' THEN BEGIN
                            IF "Location Code" <> 'SITE' THEN BEGIN
                                PurchLine.RESET;
                                PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                                PurchLine.SETFILTER(PurchLine."Qty. to Receive", '>%1', 0);
                                IF PurchLine.FINDSET THEN
                                    REPEAT
                                        IF (PurchLine."Deviated Receipt Date" < "Posting Date") AND (USERID <> 'EFFTRONICS\CHOWDARY') THEN
                                            ERROR('Posting Date Should Be Matched With the Items "Deviated Receipt Date"');
                                    UNTIL PurchLine.NEXT = 0;
                                IF NOT (("Posting Date" >= (TODAY - 4)) OR ("Posting Date" < TODAY + 1)) THEN
                                    ERROR('Please Enter the Corrct Date');  //anil
                            END;
                        END;

                        // this is commented by santhosh for old orders purpose
                    end;
                }
                field("Vendor Shipment No."; "Vendor Shipment No.")
                {
                    Caption = 'DC NO';
                    ApplicationArea = All;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "Vendor Order No." := "Vendor Invoice No.";
                    end;
                }
                field("Vendor Invoice Date"; "Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Excise Invoice No."; "Vendor Excise Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Vend. Excise Inv. Date"; "Vend. Excise Inv. Date")
                {
                    ApplicationArea = All;
                }
                field("Duplicate For Transporter"; "Duplicate For Transporter")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Bill Received"; "Bill Received")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry No."; "Bill of Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry Date"; "Bill of Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Bill of Entry Value"; "Bill of Entry Value")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchLines; "Purchase Order Subfom-Inventry")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        PaytoVendorNoOnAfterValidate;
                    end;
                }
                field("Pay-to Contact No."; "Pay-to Contact No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Name"; "Pay-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address"; "Pay-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Address 2"; "Pay-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Post Code"; "Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to City"; "Pay-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pay-to Contact"; "Pay-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("C Form"; "C Form")
                 {
                     Editable = false;
                 }
                 field("Form Code"; "Form Code")
                 {
                     Editable = false;
                 }
                 field("Form No."; "Form No.")
                 {
                     Editable = false;
                 }*/ //B2BUPG
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("On Hold"; "On Hold")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("LC No."; "LC No.")
                 {
                     Editable = false;
                 }*/
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Name"; "Ship-to Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                /* field("Transit Document"; "Transit Document")
                 {
                     Editable = false;
                 }*/
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; "Inbound Whse. Handling Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; "Lead Time Calculation")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; "Promised Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Ship-to Code"; "Ship-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Entry Point"; "Entry Point")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Date"; "MSPT Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("MSPT Code"; "MSPT Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("E - Commerce")
            {
                Caption = 'E - Commerce';
                field("Receiving No."; "Receiving No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting No."; "Posting No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receiving No. Series"; "Receiving No. Series")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Stores)
            {
                Caption = 'Stores';
                field("<Vendor Shipment No2.>"; "Vendor Shipment No.")
                {
                    Caption = 'DC NO';
                    ApplicationArea = All;
                }
                field("<Vendor Invoice No2.>"; "Vendor Invoice No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "Vendor Order No." := "Vendor Invoice No.";
                    end;
                }
                field("<Vendor Invoice Date2>"; "Vendor Invoice Date")
                {
                    ApplicationArea = All;
                }
                field("<Vendor Excise Invoice No2.>"; "Vendor Excise Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("<Vend. Excise Inv. Date2>"; "Vend. Excise Inv. Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Order No."; "Vendor Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        PurchSetup.GET;
                        IF PurchSetup."Calc. Inv. Discount" THEN BEGIN
                            CurrPage.PurchLines.PAGE.CalcInvDisc;
                            COMMIT;
                        END;
                        PAGE.RUNMODAL(PAGE::"Purchase Order Statistics", Rec);
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Vendor;
                    RunObject = Page "Vendor Card";
                    RunPageLink = "No." = FIELD("Buy-from Vendor No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Receipts)
                {
                    Caption = 'Receipts';
                    Image = Receipt;
                    RunObject = Page "Posted Purchase Receipts";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Purchase Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                separator(Action181)
                {
                }
                action("Whse. Receipt Lines")
                {
                    Caption = 'Whse. Receipt Lines';
                    Image = NewWarehouseReceipt;
                    RunObject = Page "Whse. Receipt Lines";
                    RunPageLink = "Source Type" = CONST(39), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PutawayLines;
                    RunObject = Page 5774;
                    RunPageLink = "Source Document" = CONST("Purchase Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    ApplicationArea = All;
                }
                separator(Action182)
                {
                }
                group("Dr&op Shipment")
                {
                    Caption = 'Dr&op Shipment';
                    Image = Shipment;
                    action("Get &Sales Order")
                    {
                        Caption = 'Get &Sales Order';
                        Image = GetOrder;
                        RunObject = Codeunit "Purch.-Get Drop Shpt.";
                        ApplicationArea = All;
                    }
                }
                group("Speci&al Order")
                {
                    Caption = 'Speci&al Order';
                    Image = "Order";
                    action(Action187)
                    {
                        Caption = 'Get &Sales Order';
                        Image = GetOrder;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            DistIntegration: Codeunit "Dist. Integration";
                            PurchHeader: Record "Purchase Header";
                        begin
                            PurchHeader.COPY(Rec);
                            DistIntegration.GetSpecialOrders(PurchHeader);
                            Rec := PurchHeader;
                        end;
                    }
                }
                separator(Action1280000)
                {
                }
                /*action("Transit Documents")
                {
                    Caption = 'Transit Documents';
                    Image = Documents;
                    RunObject = Page "Transit Document Order Details";
                    RunPageLink = Type = CONST(Purchase), "PO / SO No." = FIELD("No."), "Vendor / Customer Ref." = FIELD("Buy-from Vendor No.");
                }*/  //B2BUPG
                /*action(Structure)
                {
                    Caption = 'Structure';
                    Image = CollectedTax;
                    RunObject = Page "Structure Order Details";
                    RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                }*/ //B2BUPG
                action("Authorization Information")
                {
                    Caption = 'Authorization Information';
                    Image = Approval;
                    ApplicationArea = All;
                    /* RunObject = Page "VAT Opening Detail";
                    RunPageLink = "Transaction Type" = CONST(Purchase), "Document Type" = CONST(Order), "Document No." = FIELD("No."); */ //B2B UPG
                }
                separator(Action1102152034)
                {
                }
                action("MSPT Order Details")
                {
                    Caption = 'MSPT Order Details';
                    Image = BlanketOrder;
                    RunObject = Page "MSPT Order Details";
                    RunPageLink = Type = CONST(Purchase), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                separator(Action190)
                {
                }
                action("Get St&d. Vend. Purchase Codes")
                {
                    Caption = 'Get St&d. Vend. Purchase Codes';
                    Ellipsis = true;
                    Image = ImportCodes;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        StdVendPurchCode: Record "Standard Vendor Purchase Code";
                    begin
                        StdVendPurchCode.InsertPurchLines(Rec);
                    end;
                }
                separator(Action75)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyPurchDoc.SetPurchHeader(Rec);
                        CopyPurchDoc.RUNMODAL;
                        CLEAR(CopyPurchDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ArchiveManagement.ArchivePurchDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(MoveNegPurchLines);
                        MoveNegPurchLines.SetPurchHeader(Rec);
                        MoveNegPurchLines.RUNMODAL;
                        MoveNegPurchLines.ShowDocument;
                    end;
                }
                separator(Action189)
                {
                }
                action("Short Close Order")
                {
                    Caption = 'Short Close Order';
                    Image = CloseDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderStatusValue: Text[50];
                        Text050: Label 'Do you want to Short Close the Order No. %1';
                    begin
                        IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Close';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                action("Cancel Order")
                {
                    Caption = 'Cancel Order';
                    Image = CancelLine;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        OrderStatusValue: Text[50];
                        Text051: Label 'Do you want to Cancel the Order No. %1';
                    begin
                        IF CONFIRM(Text051, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Cancel';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                separator(Action1102152017)
                {
                }
                action("Create &Whse. Receipt")
                {
                    Caption = 'Create &Whse. Receipt';
                    Image = CalculateWarehouseAdjustment;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    begin
                        GetSourceDocInbound.CreateFromPurchOrder(Rec);
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = InventoryCalculation;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CreateInvtPutAwayPick;
                    end;
                }
                separator(Action74)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    RunObject = Codeunit "Release Purchase Document";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.Reopen(Rec);
                    end;
                }
                separator(Action73)
                {
                }
                action("&Send BizTalk Purchase Order")
                {
                    Caption = '&Send BizTalk Purchase Order';
                    Image = SendAsPDF;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //B2b1.0>>Since BizTalkManagement CU doesn't exist in Nav 2013
                        //BizTalkManagement.SendPurchaseOrder(Rec);
                        //B2b1.0<<
                    end;
                }
                separator(Action1280032)
                {
                }
                action("Make Import Order")
                {
                    Caption = 'Make Import Order';
                    Image = Import;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ConvertOrdertoImportOrder(Rec); // NAVIN
                    end;
                }
                action(BARCODEPRINT)
                {
                    Caption = 'BARCODEPRINT';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        PurchLine.RESET;
                        PurchLine.SETFILTER("Document No.", Rec."No.");
                        PurchLine.SETFILTER(Quantity, '>%1', 0);
                        IF PurchLine.FINDSET THEN BEGIN
                            //REPEAT
                            FileDirectory := '\\erpserver\ErpAttachments\BARCODE_INWARDS\';
                            TRACK.RESET;
                            TRACK.SETCURRENTKEY("Source ID", "Item No.");
                            TRACK.SETRANGE("Source Type", 39);
                            TRACK.SETFILTER("Source ID", PurchLine."Document No.");
                            TRACK.SETFILTER("Item No.", PurchLine."No.");
                            TRACK.FINDFIRST;
                            FileName_rej := PurchLine."No." + '-' + FORMAT(TODAY) + '-' + FORMAT(TRACK."Lot No.") + '.pdf';
                            REPORT.RUNMODAL(32000003, TRUE, TRUE, PurchLine);
                            REPORT.SAVEASPDF(32000003, FileDirectory + FileName_rej, PurchLine);
                            //UNTIL PurchLine.NEXT = 0;
                        END
                        ELSE
                            MESSAGE('Out of Loop');
                    end;
                }
                action("Calculate Structure Values")
                {
                    Caption = 'Calculate Structure Values';
                    Image = CalculateVAT;
                    ApplicationArea = All;

                    /*trigger OnAction();
                    begin
                        // NAVIN
                        PurchLine.CalculateStructures(Rec);
                        PurchLine.AdjustStructureAmounts(Rec);
                        PurchLine.UpdatePurchLines(Rec);
                        // NAVIN
                    end;*/
                }

                /*
                action("Calculate TDS")
                {
                    Caption = 'Calculate TDS';
                    Image = CalculateDepreciation;

                    trigger OnAction();
                    begin
                        PurchLine.CalculateTDS(Rec); // GS
                    end;
                }
                */ // EFFUPG
                separator(Action1280031)
                {
                }
                action("Copy Indent")
                {
                    Caption = 'Copy Indent';
                    Image = Indent;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyIndent;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ReportPrint.PrintPurchHeader(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Txt13000: Label 'Structures not calculated. Do you want to calculate structure Values?';
                    begin
                        // NAVIN
                        /*
                        IF (Structure <> '') AND  THEN BEGIN
                          PurchLine.CalculateStructures(Rec);
                          PurchLine.AdjustStructureAmounts(Rec);
                          PurchLine.UpdatePurchLines(Rec);
                          COMMIT;
                        END;
                             */

                        TESTFIELD(Status, Status::Released);

                        //Added by Vishnu Priya on 30-01-2020
                        //B2B UPG >>>
                        /* IF Rec."Posting Date" < Rec."Order Date" THEN BEGIN
                            Subject := 'Reg: Wrong Inwards with Postings Dates' + FORMAT(Rec."No.");
                            SMTP_MAIL.CreateMessage('erp', 'erp@efftronics.com', 'erp@efftronics.com', Subject, Body, TRUE);
                            SMTP_MAIL.AppendBody('<html><head><style> divone{background-color: white; width: 1500px; padding:3px; border-style:solid ; border-color:#12239E;  margin: 8px;} </style></head>');
                            SMTP_MAIL.AppendBody('<body><div style="border-color:#7B92BC;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1400px;">');
                            SMTP_MAIL.AppendBody('<label><font size="6">WRONG INWARDS</font></label>');
                            SMTP_MAIL.AppendBody('<hr style=solid; color= #E044A7 >');
                            SMTP_MAIL.AppendBody('<h>HI' + ' ,</h><br>');
                            SMTP_MAIL.AppendBody('<P>        Below are the QC Flagged Items which need to take proper action </P>');
                            SMTP_MAIL.AppendBody('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
                            SMTP_MAIL.AppendBody('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
                            SMTP_MAIL.AppendBody('<th> PO Order date </th>');
                            SMTP_MAIL.AppendBody('<th> PO Posting date </th>');
                            SMTP_MAIL.AppendBody('<tr style = "border: 2px solid black">');
                            SMTP_MAIL.AppendBody('<td>' + ' ' + FORMAT(Rec."Order Date") + '</td>');
                            SMTP_MAIL.AppendBody('<td>' + ' ' + FORMAT(Rec."Posting Date") + '</td>');
                            SMTP_MAIL.AppendBody('</table><br>');
                            SMTP_MAIL.AppendBody('<br>Regards,<br>');
                            SMTP_MAIL.AppendBody('ERP.');
                            SMTP_MAIL.AppendBody('<br>');
                            SMTP_MAIL.AppendBody('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                        END; */ //B2B >>>

                        IF Rec."Posting Date" < Rec."Order Date" THEN BEGIN
                            Subject := 'Reg: Wrong Inwards with Postings Dates' + FORMAT(Rec."No.");
                            Body += ('<html><head><style> divone{background-color: white; width: 1500px; padding:3px; border-style:solid ; border-color:#12239E;  margin: 8px;} </style></head>');
                            Body += ('<body><div style="border-color:#7B92BC;  margin: 8px; border-width:10px;   border-style:solid; padding: 8px; width: 1400px;">');
                            Body += ('<label><font size="6">WRONG INWARDS</font></label>');
                            Body += ('<hr style=solid; color= #E044A7 >');
                            Body += ('<h>HI' + ' ,</h><br>');
                            Body += ('<P>        Below are the QC Flagged Items which need to take proper action </P>');
                            Body += ('<table border = "1" style="border-collapse:collapse; width:100%; fond-size:5pt;border: 3px solid black">');
                            Body += ('<tr style ="border: 2px solid black" bgcolor="#7B92BC">');
                            Body += ('<th> PO Order date </th>');
                            Body += ('<th> PO Posting date </th>');
                            Body += ('<tr style = "border: 2px solid black">');
                            Body += ('<td>' + ' ' + FORMAT(Rec."Order Date") + '</td>');
                            Body += ('<td>' + ' ' + FORMAT(Rec."Posting Date") + '</td>');
                            Body += ('</table><br>');
                            Body += ('<br>Regards,<br>');
                            Body += ('ERP.');
                            Body += ('<br>');
                            Body += ('<div style="Background-color:#7B92BC; color:#F0F1F5; "><p align= "center"> *****AUTO GENERATED MAIL FROM ERP**** </div><br/></div>');
                            Recipients.Add('erp@efftronics.com');
                            EmailMessage.Create(Recipients, Subject, Body, true);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        END;
                        IF Rec."Posting Date" < Rec."Order Date" THEN
                            ERROR('You Can''t inward this order because, the inward date is earlier than than the order date');
                        //end by Vishnu Priya on 30-01-2020

                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                        PurchLine.SETFILTER(PurchLine."Qty. to Receive", '>%1', 0);
                        PurchLine.SETFILTER(PurchLine.Make, '%1', '');
                        IF PurchLine.FINDFIRST THEN BEGIN
                            ERROR(' There is No Make For the ' + PurchLine.Description);
                            IF PurchLine.Type = PurchLine.Type::"Fixed Asset" THEN BEGIN
                                IF PurchLine.Quantity > 1 THEN
                                    ERROR('FOR FIXED ASSTES QTY NOT ALLOWED MORE THAN 1');
                            END;
                        END;
                        CODEUNIT.RUN(91, Rec);
                        CODEUNIT.RUN(60019);

                        PurchLine.RESET;
                        PurchLine.SETRANGE(PurchLine."Document No.", "No.");
                        PurchLine.SETFILTER(PurchLine."Qty. to Receive", '>%1', 0);
                        PurchLine.SETRANGE(PurchLine."Product Group Code Cust", 'PCB');
                        PurchLine.SETCURRENTKEY("Document Type", Type, "No.");
                        IF PurchLine.FINDSET THEN
                            REPEAT
                                IF PurchLine."No." = Purch_Line_Itm_No THEN BEGIN
                                END
                                ELSE BEGIN
                                    Purch_Line_Itm_No := PurchLine."No.";
                                    Stencil_Alert.Stenicil_Alerts(PurchLine."No.", 1);
                                END
                            UNTIL PurchLine.NEXT = 0;

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // NAVIN
                        /* IF Structure <> '' THEN BEGIN
                             PurchLine.CalculateStructures(Rec);
                             PurchLine.AdjustStructureAmounts(Rec);
                             PurchLine.UpdatePurchLines(Rec);
                             COMMIT;
                         END;*/

                        CODEUNIT.RUN(92, Rec);
                        // NAVIN
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Purchase Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    DocPrint.PrintPurchHeader(Rec);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Responsibility Center" := UserMgt.GetPurchasesFilter();
    end;

    trigger OnOpenPage();
    begin
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetPurchasesFilter());
            FILTERGROUP(0);
        END;
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        ChangeExchangeRate: Page 511;
        CopyPurchDoc: Report "Copy Purchase Document";
        MoveNegPurchLines: Report "Move Negative Purchase Lines";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit 229;
        UserMgt: Codeunit "User Setup Management";
        ArchiveManagement: Codeunit ArchiveManagement;
        "-NAVIN-": Integer;
        PurchLine: Record "Purchase Line";
        OK: Boolean;
        //"--NAVIN--": ;
        Text000: Label 'Do you want to convert the Order to an Import order?';
        Text001: Label 'Order number %1 has been converted to Import order number %2.';
        "-- NAVIN": Integer;
        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the order for Authorization?';
        Text13002: Label 'The Order Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Order Has been Rejected. Please Create A New Order.';
        MLTransactionType: Option Purchase,Sale;
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';
        Stencil_Alert: Codeunit SQLIntegration;
        Purch_Line_Itm_No: Text[50];
        FileDirectory: Text[200];
        FileName_rej: Text[200];
        TRACK: Record "Tracking Specification";
        Body: Text;
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];


    procedure "---NAVIN---"();
    begin
    end;


    procedure ConvertOrdertoImportOrder(var Rec: Record "Purchase Header");
    var
        OldPurchCommentLine: Record "Purch. Comment Line";
        PurchImportOrderHeader: Record "Purchase Header";
        PurchImportOrderLine: Record "Purchase Line";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        PurchOrderLine: Record "Purchase Line";
    begin
        IF NOT CONFIRM(Text000, FALSE) THEN
            EXIT;

        PurchImportOrderHeader := Rec;
        PurchImportOrderHeader."Document Type" := PurchImportOrderHeader."Document Type"::Order;
        //PurchImportOrderHeader."Import Document" := TRUE;
        PurchImportOrderHeader."No. Printed" := 0;
        PurchImportOrderHeader.Status := PurchImportOrderHeader.Status::Open;
        PurchImportOrderHeader."No." := '';

        PurchImportOrderLine.LOCKTABLE;
        PurchImportOrderHeader.INSERT(TRUE);
        //DIM 1.0 Start
        ////Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        FromDocDim.SETRANGE("Document Type","Document Type");
        FromDocDim.SETRANGE("Document No.","No.");
        
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Header");
        ToDocDim.SETRANGE("Document Type",PurchImportOrderHeader."Document Type");
        ToDocDim.SETRANGE("Document No.",PurchImportOrderHeader."No.");
        ToDocDim.DELETEALL;
        
        IF FromDocDim.FINDSET THEN BEGIN
          REPEAT
            ToDocDim.INIT;
            ToDocDim."Table ID" := DATABASE::"Purchase Header";
            ToDocDim."Document Type" := PurchImportOrderHeader."Document Type";
            ToDocDim."Document No." := PurchImportOrderHeader."No.";
            ToDocDim."Line No." := 0;
            ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
            ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
            ToDocDim.INSERT;
          UNTIL FromDocDim.NEXT = 0;
        END;
        */
        //DIM1.0  End

        PurchImportOrderHeader."Order Date" := "Order Date";
        PurchImportOrderHeader."Posting Date" := "Posting Date";
        PurchImportOrderHeader."Document Date" := "Document Date";
        PurchImportOrderHeader."Expected Receipt Date" := "Expected Receipt Date";
        PurchImportOrderHeader."Shortcut Dimension 1 Code" := "Shortcut Dimension 1 Code";
        PurchImportOrderHeader."Shortcut Dimension 2 Code" := "Shortcut Dimension 2 Code";
        //DIM 1.0
        PurchImportOrderHeader."Dimension Set ID" := "Dimension Set ID";
        //DIM 1.0
        //PurchImportOrderHeader."Date Received" := 0D; //B2b1.0
        //PurchImportOrderHeader."Time Received" := 0T; //B2b1.0
        //PurchImportOrderHeader."Date Sent" := 0D; //B2b1.0
        //PurchImportOrderHeader."Time Sent" := 0T; //B2b1.0
        PurchImportOrderHeader.MODIFY;

        PurchOrderLine.SETRANGE("Document Type", "Document Type");
        PurchOrderLine.SETRANGE("Document No.", "No.");

        //DIM 1.0 Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        ToDocDim.SETRANGE("Table ID",DATABASE::"Purchase Line");
        */
        //DIM1.0 End

        IF PurchOrderLine.FINDSET THEN
            REPEAT
                PurchImportOrderLine := PurchOrderLine;
                PurchImportOrderLine."Document Type" := PurchImportOrderHeader."Document Type";
                PurchImportOrderLine."Document No." := PurchImportOrderHeader."No.";
                PurchImportOrderLine."Expected Receipt Date" := PurchImportOrderHeader."Expected Receipt Date";
                PurchOrderLine.CALCFIELDS("Reserved Qty. (Base)");  // SK
                ReservePurchLine.TransferPurchLineToPurchLine(
                  PurchOrderLine, PurchImportOrderLine, PurchOrderLine."Reserved Qty. (Base)");
                PurchImportOrderLine."Shortcut Dimension 1 Code" := PurchOrderLine."Shortcut Dimension 1 Code";
                PurchImportOrderLine."Shortcut Dimension 2 Code" := PurchOrderLine."Shortcut Dimension 2 Code";
                //DIM 1.0
                PurchImportOrderLine."Dimension Set ID" := PurchOrderLine."Dimension Set ID";
                //DIM 1.0
                PurchImportOrderLine.INSERT;
            //DIM 1.0 Start
            //Code Commented
            /*
            FromDocDim.SETRANGE("Line No.",PurchOrderLine."Line No.");


            ToDocDim.SETRANGE("Line No.",PurchImportOrderLine."Line No.");
            ToDocDim.DELETEALL;

            IF FromDocDim.FINDSET THEN BEGIN
              REPEAT
                ToDocDim.INIT;
                ToDocDim."Table ID" := DATABASE::"Purchase Line";
                ToDocDim."Document Type" := PurchImportOrderHeader."Document Type";
                ToDocDim."Document No." := PurchImportOrderHeader."No.";
                ToDocDim."Line No." := PurchImportOrderLine."Line No.";
                ToDocDim."Dimension Code" := FromDocDim."Dimension Code";
                ToDocDim."Dimension Value Code" := FromDocDim."Dimension Value Code";
                ToDocDim.INSERT;
              UNTIL FromDocDim.NEXT = 0;
            END;
            */
            //DIM 1.0 End
            UNTIL PurchOrderLine.NEXT = 0;

        PurchCommentLine.SETRANGE("Document Type", "Document Type");
        PurchCommentLine.SETRANGE("No.", "No.");
        IF NOT PurchCommentLine.ISEMPTY THEN BEGIN
            PurchCommentLine.LOCKTABLE;
            IF PurchCommentLine.FINDSET THEN
                REPEAT
                    OldPurchCommentLine := PurchCommentLine;
                    PurchCommentLine.DELETE;
                    PurchCommentLine."Document Type" := PurchImportOrderHeader."Document Type";
                    PurchCommentLine."No." := PurchImportOrderHeader."No.";
                    PurchCommentLine.INSERT;
                    PurchCommentLine := OldPurchCommentLine;
                UNTIL PurchCommentLine.NEXT = 0;
        END;

        ItemChargeAssgntPurch.RESET;
        ItemChargeAssgntPurch.SETRANGE("Document Type", "Document Type");
        ItemChargeAssgntPurch.SETRANGE("Document No.", "No.");

        WHILE ItemChargeAssgntPurch.FINDFIRST DO BEGIN
            ItemChargeAssgntPurch.DELETE;
            ItemChargeAssgntPurch."Document Type" := PurchImportOrderHeader."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchImportOrderHeader."No.";
            IF NOT (ItemChargeAssgntPurch."Applies-to Doc. Type" IN
              [ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt,
               ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment"])
            THEN BEGIN
                ItemChargeAssgntPurch."Applies-to Doc. Type" := PurchImportOrderHeader."Document Type";
                ItemChargeAssgntPurch."Applies-to Doc. No." := PurchImportOrderHeader."No.";
            END;
            ItemChargeAssgntPurch.INSERT;
        END;

        DELETE;
        PurchOrderLine.DELETEALL;
        //DIM  Start
        //Code Commented
        /*
        FromDocDim.SETRANGE("Line No.");
        FromDocDim.DELETEALL;
        */
        //DIM1.0 End

        COMMIT;
        MESSAGE(
          Text001,
          "No.", PurchImportOrderHeader."No.");

    end;


    local procedure BuyfromVendorNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure PaytoVendorNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;


    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;


    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.PurchLines.PAGE.UpdateForm(TRUE);
    end;
}

