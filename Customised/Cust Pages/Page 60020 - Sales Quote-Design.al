page 60020 "Sales Quote-Design"
{
    // version B2B1.0,Rev01

    Caption = 'Sales Quote';
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    SourceTableView = WHERE("Document Type" = FILTER(Quote));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Enabled = "Sell-to Customer No.Enable";
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SelltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Template Code"; "Sell-to Customer Template Code")
                {
                    Enabled = SelltoCustomerTemplateCodeEnab;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        SelltoCustomerTemplateCodeOnAf;
                    end;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                /*field("Free Supply";"Free Supply")
                {
                }*/
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                /* field("LC No.";"LC No.")
                 {
                 }
                 field(Structure;Structure)
                 {
                 }*/
            }
            part(SalesLines; "Sales Quote Subform-Design")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                Editable = false;
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Enabled = "Bill-to Customer No.Enable";
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer Template Code"; "Bill-to Customer Template Code")
                {
                    Enabled = BilltoCustomerTemplateCodeEnab;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        BilltoCustomerTemplateCodeOnAf;
                    end;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        CurrPage.SAVERECORD;
                        COMMIT;
                        SalesHeaderArchive.SETRANGE("Document Type", "Document Type"::Quote);
                        SalesHeaderArchive.SETRANGE("No.", "No.");
                        SalesHeaderArchive.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
                        IF SalesHeaderArchive.GET("Document Type"::Quote, "No.", "Doc. No. Occurrence", "No. of Archived Versions") THEN;
                        PAGE.RUNMODAL(PAGE::"Sales List Archive", SalesHeaderArchive);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                Editable = false;
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                Editable = false;
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", WORKDATE);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    ApplicationArea = All;
                }
            }
            group(" Others")
            {
                Caption = '" Others"';
                Editable = false;
                field("Type of Enquiry"; "Type of Enquiry")
                {
                    ApplicationArea = All;
                }
                field("Type of Product"; "Type of Product")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; "Document Position")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Release To Sales")
                {
                    Caption = 'Release To Sales';
                    Image = ReleaseDoc;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Text01: Label 'Do You want to Send the Document to Sale?';
                    begin
                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Design);
                        "Document Position" := "Document Position"::Sales;
                        MODIFY;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ActivateFields;

        ActivateFields;

        OnAfterGetCurrRecord;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit();
    begin
        "Bill-to Customer No.Enable" := TRUE;
        "Sell-to Customer No.Enable" := TRUE;
        SelltoCustomerTemplateCodeEnab := TRUE;
        BilltoCustomerTemplateCodeEnab := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        CheckCreditMaxBeforeInsert;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            FILTERGROUP(0);
        END;

        ActivateFields;
    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        SalesSetup: Record "Sales & Receivables Setup";
        CopySalesDoc: Report 292;
        DocPrint: Codeunit 229;
        UserMgt: Codeunit 5700;
        ArchiveManagement: Codeunit 5063;
        SalesHeaderArchive: Record "Sales Header Archive";
        "--NAVIN": Integer;

        Text13000: Label 'No Setup exists for this Amount.';
        Text13001: Label 'Do you want to send the Quote for Authorization?';
        Text13002: Label 'The Quote Is Authorized, You Cannot Resend For Authorization';
        Text13003: Label 'You Cannot Resend For Authorization';
        Text13004: Label 'This Quote Has been Rejected. Please Create A New Quote.';
        MLTransactionType: Option Purchase,Sale;
        [InDataSet]
        BilltoCustomerTemplateCodeEnab: Boolean;
        [InDataSet]
        SelltoCustomerTemplateCodeEnab: Boolean;
        [InDataSet]
        "Sell-to Customer No.Enable": Boolean;
        [InDataSet]
        "Bill-to Customer No.Enable": Boolean;
        ChangeExchangeRate: Page 511;


    procedure UpdateAllowed(): Boolean;
    begin
        IF CurrPage.EDITABLE = FALSE THEN BEGIN
            MESSAGE(Text000);
            EXIT(FALSE);
        END ELSE
            EXIT(TRUE);
    end;


    procedure ActivateFields();
    begin
        BilltoCustomerTemplateCodeEnab := "Bill-to Customer No." = '';
        SelltoCustomerTemplateCodeEnab := "Sell-to Customer No." = '';
        "Sell-to Customer No.Enable" := "Sell-to Customer Template Code" = '';
        "Bill-to Customer No.Enable" := "Bill-to Customer Template Code" = '';
    end;


    local procedure SelltoCustomerNoOnAfterValidat();
    begin
        ActivateFields;
        CurrPage.UPDATE;
    end;


    local procedure SelltoCustomerTemplateCodeOnAf();
    begin
        ActivateFields;
        CurrPage.UPDATE;
    end;


    local procedure BilltoCustomerNoOnAfterValidat();
    begin
        ActivateFields;
        CurrPage.UPDATE;
    end;


    local procedure ShortcutDimension1CodeOnAfterV();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;


    local procedure ShortcutDimension2CodeOnAfterV();
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;


    local procedure BilltoCustomerTemplateCodeOnAf();
    begin
        ActivateFields;
        CurrPage.UPDATE;
    end;


    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        ActivateFields;
    end;
}

