report 2000002 "Del Item LedgEnt With Trackin"
{
    Permissions = TableData 32 = rd,
                  TableData 339 = rd,
                  TableData 5802 = rd,
                  TableData 6507 = rd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Applied Entry to Adjust", "Item No.", "Location Code", "Variant Code", "Posting Date")
                                WHERE("Applied Entry to Adjust" = CONST(false),
                                      Open = CONST(false),
                                      "Completely Invoiced" = CONST(true));
            RequestFilterFields = "Item No.";

            trigger OnAfterGetRecord()
            begin
                //MESSAGE('%1',ItemEntryAdjusted("Item Ledger Entry"));
                IF NOT "Completely Invoiced" OR NOT ItemEntryAdjusted("Item Ledger Entry") THEN
                    CurrReport.SKIP;
                IF NOT (("Item Ledger Entry"."Lot No." <> '') OR ("Item Ledger Entry"."Serial No." <> '')) THEN
                    CurrReport.SKIP;

                WindowDia.UPDATE(1, "Item Ledger Entry"."Entry No.");


                Deleted := TRUE;
                // delete value entries >>
                ValueEntry.RESET;
                ValueEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                IF ValueEntry.FINDSET THEN
                    ValueEntry.DELETEALL;
                // delete value entries <<


                // delete Item Application entries >>
                /*
                ItemApplicationEntry.RESET;
                ItemApplicationEntry.SETRANGE("Item Ledger Entry No.","Item Ledger Entry"."Entry No.");
                IF ItemApplicationEntry.FINDSET THEN
                  ItemApplicationEntry.DELETEALL;
                */
                IF "Item Ledger Entry".Positive THEN BEGIN
                    ItemApplicationEntry.SETCURRENTKEY("Inbound Item Entry No.");
                    ItemApplicationEntry.SETRANGE("Inbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                    ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '<>%1', "Item Ledger Entry"."Entry No.");
                    IF ItemApplicationEntry.FINDSET THEN
                        ItemApplicationEntry.DELETEALL;
                END ELSE BEGIN
                    ItemApplicationEntry.RESET;
                    ItemApplicationEntry.SETCURRENTKEY(
                      "Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application", "Transferred-from Entry No.");
                    ItemApplicationEntry.SETRANGE("Item Ledger Entry No.", "Item Ledger Entry"."Entry No.");
                    ItemApplicationEntry.SETRANGE("Outbound Item Entry No.", "Item Ledger Entry"."Entry No.");
                    IF ItemApplicationEntry.FINDSET THEN
                        ItemApplicationEntry.DELETEALL;
                END;

                // delete Item Application entries <<

                // delete Item Entry Relation entries >>
                ItemEntryRelation.RESET;
                ItemEntryRelation.SETRANGE("Item Entry No.", "Item Ledger Entry"."Entry No.");
                IF ItemEntryRelation.FINDSET THEN
                    ItemEntryRelation.DELETEALL;
                // delete Item Entry Relation  entries <<

                // Delete Capacity Ledger entries >>
                IF "Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Output THEN BEGIN
                    CapacityLedgerEntry.RESET;
                    CapacityLedgerEntry.SETRANGE("Order Type", "Item Ledger Entry"."Order Type");
                    CapacityLedgerEntry.SETRANGE("Order No.", "Item Ledger Entry"."Order No.");
                    CapacityLedgerEntry.SETRANGE("Order Line No.", "Item Ledger Entry"."Order Line No.");
                    IF CapacityLedgerEntry.FINDFIRST THEN BEGIN
                        REPEAT
                            // Deleting Capacity Ledger entries aganist Value entries >>
                            ValueEntryCap.RESET;
                            ValueEntryCap.SETRANGE("Capacity Ledger Entry No.", CapacityLedgerEntry."Entry No.");
                            IF ValueEntryCap.FINDSET THEN
                                ValueEntryCap.DELETEALL;
                            // Deleting Capacity Ledger entries aganist Value entries <<
                            CapacityLedgerEntry.DELETE;
                        UNTIL CapacityLedgerEntry.NEXT = 0;
                    END;
                END;
                // Delete Capacity Ledger entries <<
                "Item Ledger Entry".DELETE;

            end;

            trigger OnPostDataItem()
            begin
                WindowDia.CLOSE;

                IF Deleted THEN
                    MESSAGE(Text003, EndingDate)
                ELSE
                    MESSAGE(Text004)
            end;

            trigger OnPreDataItem()
            begin
                CLEAR(Deleted);
                IF EndingDate = 0D THEN
                    ERROR(Text002);

                WindowDia.OPEN(Text001);

                IF NOT CONFIRM(Text000, FALSE) THEN
                    EXIT;


                SETFILTER("Posting Date", '<=%1', EndingDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filter)
                {
                    field(EndingDate; EndingDate)
                    {
                        Caption = 'Ending Date';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        InvtSetup: Record 313;
        Text000: Label 'Do you want proceed delete item ledger entries ?';
        Text001: Label 'Item ledger entries delete ... Entry No.  #1##########';
        WindowDia: Dialog;
        EndingDate: Date;
        Text002: Label 'Enter the date value in Request filter.';
        ValueEntry: Record 5802;
        ItemApplicationEntry: Record 339;
        Deleted: Boolean;
        Text003: Label 'Process completed and Item ledger entries deleted before and equal  Date %1 .';
        Text004: Label 'There is nothing to delete entries .';
        ItemEntryRelation: Record 6507;
        Item: Record 27;
        CapacityLedgerEntry: Record 5832;
        ValueEntryCap: Record 5802;

    local procedure ItemEntryAdjusted(ItemLedgEntry: Record 32): Boolean
    var
        ItemLedgEntry2: Record 32;
        AvgCostAdjmt: Record 5804;
    begin
        WITH ItemLedgEntry DO BEGIN
            ItemLedgEntry2.SETCURRENTKEY("Applied Entry to Adjust", "Item No.", "Location Code", "Variant Code");
            ItemLedgEntry2.SETRANGE("Applied Entry to Adjust", TRUE);
            ItemLedgEntry2.SETRANGE("Item No.", "Item No.");
            ItemLedgEntry2.SETRANGE("Location Code", "Location Code");
            ItemLedgEntry2.SETRANGE("Variant Code", "Variant Code");
            IF ItemLedgEntry."Lot No." <> '' THEN
                ItemLedgEntry2.SETRANGE("Lot No.", "Lot No.");
            IF ItemLedgEntry."Serial No." <> '' THEN
                ItemLedgEntry2.SETRANGE("Serial No.", "Serial No.");
            IF ItemLedgEntry2.FINDFIRST THEN
                EXIT(FALSE);

            AvgCostAdjmt.SETRANGE("Item No.", "Item No.");
            AvgCostAdjmt.SETRANGE("Cost Is Adjusted", FALSE);
            IF InvtSetup."Average Cost Calc. Type" =
               InvtSetup."Average Cost Calc. Type"::"Item & Location & Variant"
            THEN BEGIN
                AvgCostAdjmt.SETRANGE("Variant Code", "Variant Code");
                AvgCostAdjmt.SETRANGE("Location Code", "Location Code");
            END;
            IF AvgCostAdjmt.FINDFIRST THEN
                EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;
}

