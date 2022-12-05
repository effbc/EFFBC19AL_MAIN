page 60063 "RGP In Lines"
{
    // version B2B1.0,Cal1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "RGP In Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        RGPInLine: Record "RGP In Line";
                    begin
                        IF (xRec.Type <> Rec.Type::" ") THEN BEGIN
                            IF (xRec.Type <> Rec.Type) THEN BEGIN
                                Rec."No." := '';
                                Rec.Description := '';
                                Rec.Quantity := 0;
                                Rec.UOM := '';
                            END;
                        END;
                        TypeOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Production Order Line No."; Rec."Production Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Production Order"; Rec."Production Order")
                {
                    ApplicationArea = All;
                }
                field("Drawing No."; Rec."Drawing No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("MRIR No."; Rec."MRIR No.")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Material Group"; Rec."Material Group")
                {
                    ApplicationArea = All;
                }
                field("S.L.No."; Rec."S.L.No.")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Submited TO (dept)"; Rec."Submited TO (dept)")
                {
                    ApplicationArea = All;
                }
                field("Submition Date"; Rec."Submition Date")
                {
                    ApplicationArea = All;
                }
                field("Exp. Date"; Rec."Exp. Date")
                {
                    ApplicationArea = All;
                }
                field("Exp.Incurred"; Rec."Exp.Incurred")
                {
                    ApplicationArea = All;
                }
                field("RET/NRET"; Rec."RET/NRET")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (xRec.Quantity <> Rec.Quantity) THEN BEGIN
                            RGPApplied.SETRANGE("Document No.", Rec."Document No.");
                            RGPApplied.SETRANGE("Document Line No.", Rec."Line No.");
                            IF RGPApplied.FINDSET THEN BEGIN
                                REPEAT
                                    EntryNo := RGPApplied."Applied To Entry";
                                    RGPLedgerEntry.SETRANGE("Entry No.", EntryNo);
                                    IF RGPLedgerEntry.FINDFIRST THEN BEGIN
                                        RGPLedgerEntry."Applies To" := '';
                                        RGPLedgerEntry.MODIFY;
                                    END;
                                UNTIL RGPApplied.NEXT = 0;
                            END;

                            RGPApplied.DELETEALL;

                            TempLedgerEntry.DELETEALL;

                        END;
                    end;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Quantity to Recieve"; Rec."Quantity to Recieve")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        RGPApplied: Record "Temp. Applied RGPs";
        EntryNo: Integer;
        RGPLedgerEntry: Record "RGP Ledger Entries";
        TempLedgerEntry: Record "Temp. RGP Ledger Entry";

    
    procedure RGPEntries(var RGPInHeader: Record "RGP In Header"; var RGPInLine: Record "RGP In Line");
    var
        TempLedgerEntry: Record "Temp. RGP Ledger Entry";
    begin
        TempLedgerEntry.SETRANGE("Line No.", 1);
        IF NOT TempLedgerEntry.FINDFIRST THEN BEGIN
            TempLedgerEntry."Line No." := 1;
            TempLedgerEntry.Consignee := RGPInHeader.Consignee;
            TempLedgerEntry."Consignee No." := RGPInHeader."Consignee No.";
            TempLedgerEntry.Type := RGPInLine.Type;
            TempLedgerEntry."No." := RGPInLine."No.";
            TempLedgerEntry.Quantity := RGPInLine.Quantity;
            TempLedgerEntry."Quantity to Recieve" := RGPInLine.Quantity;
            TempLedgerEntry."RGP In No." := RGPInLine."Document No.";
            TempLedgerEntry."RGP Line No." := RGPInLine."Line No.";
            TempLedgerEntry."RGP Document Date" := RGPInHeader."RGP In Date";
            TempLedgerEntry.INSERT;
            COMMIT;
            //END ELSE BEGIN
            //  TempLedgerEntry.Quantity:=RGPInLine.Quantity;
            //  TempLedgerEntry.MODIFY;
        END;
        //COMMIT;
    end;

    
    procedure showEntries(var RGPHeader: Record "RGP In Header");
    var
        RGPLedgerEntry: Record "RGP Ledger Entries";
        Text001: Label 'Line No. %1 is copied from RGP Out No. %2,You cannot apply entries to this line.';
        RGPLedgerEntryForm: Page "RGP Type Ledger Entries";
    begin
        IF Rec."Quantity to Recieve" <> 0 THEN
            ERROR(Text001, Rec."Line No.", Rec."RGP Out Document No.");

        RGPEntries(RGPHeader, Rec);

        CLEAR(RGPLedgerEntryForm);

        RGPLedgerEntry.SETRANGE(Consignee, RGPHeader.Consignee);
        RGPLedgerEntry.SETRANGE("Consignee No.", RGPHeader."Consignee No.");
        RGPLedgerEntry.SETRANGE(Type, Rec.Type);
        RGPLedgerEntry.SETRANGE("No.", Rec."No.");
        RGPLedgerEntry.SETRANGE("Document Type", RGPLedgerEntry."Document Type"::Out);
        RGPLedgerEntry.SETRANGE(Open, TRUE);
        RGPLedgerEntryForm.SETTABLEVIEW(RGPLedgerEntry);
        RGPLedgerEntryForm.RUNMODAL;
    end;

    
    local procedure TypeOnAfterValidate();
    begin
        CurrPage.UPDATE;
    end;
}

