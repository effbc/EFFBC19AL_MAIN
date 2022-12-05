page 60064 "Posted RGP In"
{
    // version B2B1.0,Cal1.0

    Editable = false;
    PageType = Document;
    SourceTable = "RGP In Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("RGP In No."; Rec."RGP In No.")
                {
                    ApplicationArea = All;
                }
                field(Consignee; Rec.Consignee)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        Text050: Label 'By changing consignee,all line will be be deleted,do you wish to proceed?';
                    begin
                        IF (xRec.Consignee <> Rec.Consignee) THEN BEGIN
                            RGPInLine.SETRANGE("Document No.", Rec."RGP In No.");
                            IF RGPInLine.FINDFIRST THEN BEGIN
                                IF CONFIRM(Text050, FALSE) THEN BEGIN
                                    Rec."Consignee No." := '';
                                    Rec."Consignee Name" := '';
                                    Rec.Address := '';
                                    Rec."Consignee City" := '';
                                    Rec."Consignee Contact" := '';
                                    Rec."Phone No." := '';
                                    Rec."Telex No." := '';
                                    RGPInLine.DELETEALL;
                                END ELSE BEGIN
                                    Rec.Consignee := xRec.Consignee;
                                END;
                            END ELSE BEGIN
                                Rec."Consignee No." := '';
                                Rec."Consignee Name" := '';
                                Rec.Address := '';
                                Rec."Consignee City" := '';
                                Rec."Consignee Contact" := '';
                                Rec."Phone No." := '';
                                Rec."Telex No." := '';
                            END;
                        END;
                        ConsigneeOnAfterValidate;
                    end;
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
                field("RGP In Date"; Rec."RGP In Date")
                {
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
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
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
            part(RGPLines; "RGP In Lines")
            {
                SubPageLink = "Document No." = FIELD("RGP In No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(RGP)
            {
                Caption = 'RGP';
                action("RGP Ledger Entries")
                {
                    Caption = 'RGP Ledger Entries';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(RGPLedgerEntryForm);
                        RGPLedgerEntry.SETRANGE("Document No.", Rec."RGP In No.");
                        RGPLedgerEntry.SETRANGE("Document Type", RGPLedgerEntry."Document Type"::"In");
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
                    RGPInHead.SETRANGE(RGPInHead."RGP In No.", Rec."RGP In No.");
                    REPORT.RUN(50054, TRUE, FALSE, RGPInHead);
                    RGPInHead.SETRANGE("RGP In No.");
                end;
            }
        }
    }

    trigger OnClosePage();
    begin
        RGPApplied.SETRANGE("Consignee No.", Rec."Consignee No.");
        RGPApplied.DELETEALL;
    end;

    var
        RGPOut: Record "RGP Out Header";
        RGPOutLine: Record "RGP Out Line";
        RGPInLine: Record "RGP In Line";
        RGPInLineNo: Integer;
        RGPLedgerEntry: Record "RGP Ledger Entries";
        TempLedgerEntry: Record "Temp. RGP Ledger Entry";
        RGPApplied: Record "Temp. Applied RGPs";
        NextEntryNo: Integer;
        Text001: Label 'There are no applied entries for Line No. %1';
        RGPLedgerEntry1: Record "RGP Ledger Entries";
        RemainingQty: Decimal;
        Text002: Label 'Do you want to post the Document No. %1?';
        RGPOutEntryNo: Integer;
        RGPInHead: Record "RGP In Header";
        RGPLedgerEntryForm: Page "RGP Type Ledger Entries";

   
    procedure TempLedgerEntrySave(var RGPInHeader: Record "RGP In Header"; var RGPInLine: Record "RGP In Line");
    begin
        TempLedgerEntry.SETRANGE("Line No.", 1);
        IF NOT TempLedgerEntry.FINDFIRST THEN BEGIN
            TempLedgerEntry."Line No." := 1;
            TempLedgerEntry.Consignee := RGPInHeader.Consignee;
            TempLedgerEntry."Consignee No." := RGPInHeader."Consignee No.";
            TempLedgerEntry.Type := RGPInLine.Type;
            TempLedgerEntry."No." := RGPInLine."No.";
            TempLedgerEntry.Quantity := RGPInLine.Quantity;
            TempLedgerEntry."RGP In No." := RGPInLine."Document No.";
            TempLedgerEntry."RGP Line No." := RGPInLine."Line No.";
            TempLedgerEntry."RGP Document Date" := RGPInHeader."RGP In Date";
            TempLedgerEntry.INSERT;
            COMMIT;
        END;
    end;

   
    local procedure ConsigneeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

