page 60060 "Posted RGP Out"
{
    // version B2B1.0,Cal1.0

    Editable = false;
    PageType = Document;
    SourceTable = "RGP Out Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;
                }
                field(Consignee; Rec.Consignee)
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                }
                field("FD Remarks"; Rec."FD Remarks")
                {
                    ApplicationArea = All;
                }
                field("RGP Date"; Rec."RGP Date")
                {
                    ApplicationArea = All;
                }
                field("RGP Posting Date"; Rec."RGP Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000022; "RGP Out Lines")
            {
                SubPageLink = "Document No." = FIELD("RGP Out No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("R&GP")
            {
                Caption = 'R&GP';
                action("RGP Ledger Entries")
                {
                    Caption = 'RGP Ledger Entries';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(RGPLedgerEntryForm);
                        RGPLedgerEntry.SETRANGE("Document No.", Rec."RGP Out No.");
                        RGPLedgerEntry.SETRANGE("Document Type", RGPLedgerEntry."Document Type"::Out);
                        RGPLedgerEntryForm.SETTABLEVIEW(RGPLedgerEntry);
                        RGPLedgerEntryForm.RUNMODAL;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    RGPOutHead.SETRANGE(RGPOutHead."RGP Out No.", Rec."RGP Out No.");
                    REPORT.RUN(50053, TRUE, FALSE, RGPOutHead);
                    RGPOutHead.SETRANGE("RGP Out No.");
                end;
            }
        }
    }

    var
        RGPLedgerEntry: Record "RGP Ledger Entries";
        RGPOutHead: Record "RGP Out Header";
        RGPLedgerEntryForm: Page "RGP Type Ledger Entries";
}

