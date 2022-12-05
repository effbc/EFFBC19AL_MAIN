page 60061 "RGP Type Ledger Entries"
{
    Editable = false;
    PageType = List;
    SourceTable = "RGP Ledger Entries";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; "Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field(Consignee; Consignee)
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; "Consignee No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    ApplicationArea = All;
                }
                field(Control1000000001; "Applies To")
                {
                    ApplicationArea = All;
                }
                field("Applied To Entry"; "Applied To Entry")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Open; Open)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Applies To")
                {
                    Caption = 'Applies To';
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        IF "Applies To" <> '' THEN BEGIN
                            RGPApplied.SETRANGE("Applied To Entry", "Entry No.");
                            RGPApplied.DELETEALL;

                            GET("Entry No.");
                            "Applies To" := '';
                            MODIFY;

                            TempRGPLedEntry.SETRANGE("Line No.", 1);
                            IF TempRGPLedEntry.FIND('-') THEN BEGIN
                                TempRGPLedEntry.Quantity := TempRGPLedEntry."Quantity to Recieve";
                                TempRGPLedEntry.MODIFY;
                            END;

                            EXIT;
                            //ERROR(Text001);
                        END;
                        TempRGPLedEntry.GET(1);

                        IF TempRGPLedEntry.Quantity = 0 THEN
                            ERROR(Text002);

                        IF TempRGPLedEntry.Quantity > "Remaining Quantity" THEN BEGIN
                            PostingQty := "Remaining Quantity";
                            RemainingQty := 0;
                            BalanceQty := (TempRGPLedEntry.Quantity - "Remaining Quantity");
                        END;

                        IF "Remaining Quantity" > TempRGPLedEntry.Quantity THEN BEGIN
                            PostingQty := TempRGPLedEntry.Quantity;
                            RemainingQty := "Remaining Quantity" - TempRGPLedEntry.Quantity;
                            BalanceQty := 0;
                        END;

                        RGPApplied.LOCKTABLE;
                        IF RGPApplied.FIND('+') THEN
                            NextEntryNo := RGPApplied."Entry No."
                        ELSE
                            NextEntryNo := 0;

                        RGPApplied.INIT;
                        NextEntryNo := NextEntryNo + 1;
                        RGPApplied."Entry No." := NextEntryNo;
                        RGPApplied."Entry Date" := TODAY;
                        RGPApplied."Document No." := TempRGPLedEntry."RGP In No.";
                        RGPApplied."Document Line No." := TempRGPLedEntry."RGP Line No.";
                        RGPApplied."Document Date" := TempRGPLedEntry."RGP Document Date";
                        RGPApplied."Document Type" := RGPLedEntries."Document Type"::"In";
                        RGPApplied.Consignee := TempRGPLedEntry.Consignee;
                        RGPApplied."Consignee No." := TempRGPLedEntry."Consignee No.";
                        RGPApplied.Quantity := PostingQty;
                        RGPApplied."Remaining Quantity" := RemainingQty;
                        IF RemainingQty <> 0 THEN BEGIN
                            RGPApplied.Open := TRUE;
                        END ELSE BEGIN
                            RGPApplied.Open := FALSE;
                        END;
                        RGPApplied."Applied To Entry" := "Entry No.";
                        RGPApplied.Type := TempRGPLedEntry.Type;
                        RGPApplied."No." := TempRGPLedEntry."No.";
                        RGPApplied.INSERT;

                        TempRGPLedEntry.Quantity := BalanceQty;
                        TempRGPLedEntry.MODIFY;

                        "Applies To" := 'Applied';
                        MODIFY;
                    end;
                }
            }
        }
    }

    var
        TempRGPLedEntry: Record "Temp. RGP Ledger Entry";
        RGPLedEntries: Record "RGP Ledger Entries";
        NextEntryNo: Integer;
        BalanceQty: Decimal;
        RGPInLine: Record "RGP In Line";
        RGPInHeader: Record "RGP In Header";
        RGPApplied: Record "Temp. Applied RGPs";
        PostingQty: Decimal;
        RemainingQty: Decimal;
        Text001: Label 'There is nothing to apply';
        Text002: Label 'No more quantity to apply';
}

