page 60030 "Service Quote Archive"
{
    // version B2B1.0,Rev01

    Caption = 'Service Quote Archive';
    Editable = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Service Header Archive";
    SourceTableView = WHERE("Document Type" = FILTER(Quote));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CustomerNoOnAfterValidate;
                    end;
                }
                field("Contact No."; "Contact No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    Caption = 'Post Code/City';
                    ApplicationArea = All;
                }
                field("Contact Name"; "Contact Name")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; "Phone No.")
                {
                    Caption = 'Phone No./Phone No. 2';
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Phone No. 2"; "Phone No. 2")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Notify Customer"; "Notify Customer")
                {
                    ApplicationArea = All;
                }
                field("Service Order Type"; "Service Order Type")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;
                }
                field("Response Date"; "Response Date")
                {
                    ApplicationArea = All;
                }
                field("Response Time"; "Response Time")
                {
                    ApplicationArea = All;
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    ApplicationArea = All;
                }
            }
            part(ServItemLine; "Service Quote Archive Subform")
            {
                Editable = false;
                SubPageLink = "Document No." = FIELD("No."), "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"), "Version No." = FIELD("Version No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
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
                field("Your Reference"; "Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    Caption = 'Job No.';
                    ApplicationArea = All;
                }
                field("Max. Labor Unit Price"; "Max. Labor Unit Price")
                {
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShiptoCodeOnAfterValidate;
                    end;
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
                field("Ship-to Phone"; "Ship-to Phone")
                {
                    Caption = 'Ship-to Phone/Phone 2';
                    ApplicationArea = All;
                }
                field("Ship-to Phone 2"; "Ship-to Phone 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to E-Mail"; "Ship-to E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group(Details)
            {
                Caption = 'Details';
                field("Warning Status"; "Warning Status")
                {
                    ApplicationArea = All;
                }
                field("Link Service to Service Item"; "Link Service to Service Item")
                {
                    ApplicationArea = All;
                }
                field("Allocated Hours"; "Allocated Hours")
                {
                    ApplicationArea = All;
                }
                field("No. of Allocations"; "No. of Allocations")
                {
                    ApplicationArea = All;
                }
                field("No. of Unallocated Items"; "No. of Unallocated Items")
                {
                    ApplicationArea = All;
                }
                field("Service Zone Code"; "Service Zone Code")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    ApplicationArea = All;
                }
                field("Order Time"; "Order Time")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; "Starting Time")
                {
                    ApplicationArea = All;
                }
                field("Actual Response Time (Hours)"; "Actual Response Time (Hours)")
                {
                    ApplicationArea = All;
                }
                field("Finishing Date"; "Finishing Date")
                {
                    ApplicationArea = All;
                }
                field("Finishing Time"; "Finishing Time")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FinishingTimeOnAfterValidate;
                    end;
                }
            }
            group(" Foreign Trade")
            {
                Caption = '" Foreign Trade"';
                field("Currency Code"; "Currency Code")
                {
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
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Restore")
            {
                Caption = '&Restore';
                Ellipsis = true;
                Image = Restore;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ArchiveManagement: Codeunit "Custom Events";
                begin
                    ArchiveManagement.RestoreServiceDocument(Rec);
                end;
            }
        }
    }

    var
        Text004: Label 'You cannot open the form because %1 is %2 in the %3 table.';
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItemLine: Record "Service Item Line";
        RepairStatus: Record "Repair Status";
        ServOrderMgt: Codeunit ServOrderManagement;
        ServLogMgt: Codeunit ServLogManagement;
        //Mail: Codeunit Mail;
        ServItemMgt: Codeunit ServItemManagement;
        UserMgt: Codeunit "User Setup Management";
        CreateServiceOrder: Codeunit "Serv-Quote to Order (Yes/No)";
        ChangeExchangeRate: Page 511;
        FaultResolutionRelation: Page "Fault/Resol. Cod. Relationship";

    local procedure CustomerNoOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;

    local procedure BilltoCustomerNoOnAfterValidat();
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShiptoCodeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;

    local procedure FinishingTimeOnAfterValidate();
    begin
        CurrPage.UPDATE(TRUE);
    end;
}

