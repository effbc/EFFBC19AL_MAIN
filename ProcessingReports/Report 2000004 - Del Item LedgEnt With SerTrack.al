report 2000004 "Del Item LedgEnt With SerTrack"
{
    Permissions = TableData 32 = rmd,
                  TableData 339 = rmd,
                  TableData 5802 = rmd,
                  TableData 6507 = rd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; 27)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                WindowDia.UPDATE(1, Item."No.");

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY("Item No.", "Location Code", "Lot No.");
                ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                ItemLedgerEntry.SETFILTER("Posting Date", '<=%1', EndingDate);
                ItemLedgerEntry.SETFILTER("Serial No.", '<>%1', '');
                ItemLedgerEntry.SETRANGE(Open, FALSE);
                IF ItemLedgerEntry.FINDSET THEN BEGIN
                    REPEAT
                        DeleteEntries(ItemLedgerEntry);
                    UNTIL ItemLedgerEntry.NEXT = 0;
                END;

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
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(FilterCust)
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
        ItemRec: Record 27;
        CapacityLedgerEntry: Record 5832;
        ValueEntryCap: Record 5802;
        Location: Record 14;
        ItemLedgerEntry: Record 32;
        ILEQty: Decimal;
        ILERec: Record 32;
        LotILEUpdated: Boolean;
        ApplicationQty: Decimal;
        CurrILENum: Integer;
        QualityItemLedgerEntry: Record 33000262;
        ValueEntry2: Record 5802;
        ILERemQty: Decimal;
        ItemApplicationEntry3: Record 339;

    local procedure DeleteEntries(ItemLedgerEntryRecPar: Record "Item Ledger Entry")
    begin
        Deleted := TRUE;
        ValueEntry.RESET;
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryRecPar."Entry No.");
        IF ValueEntry.FINDSET THEN
            ValueEntry.DELETEALL;
        // delete Item Application entries >>

        ItemApplicationEntry.RESET;
        ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '%1', ItemLedgerEntryRecPar."Entry No.");
        IF ItemApplicationEntry.FINDSET THEN
            ItemApplicationEntry.DELETEALL;



        // delete Item Application entries <<

        // delete Item Entry Relation entries >>
        ItemEntryRelation.RESET;
        ItemEntryRelation.SETRANGE("Item Entry No.", ItemLedgerEntryRecPar."Entry No.");
        IF ItemEntryRelation.FINDSET THEN
            ItemEntryRelation.DELETEALL;


        // delete Item Entry Relation  entries <<

        // Delete Capacity Ledger entries >>
        IF ItemLedgerEntryRecPar."Entry Type" = ItemLedgerEntryRecPar."Entry Type"::Output THEN BEGIN
            CapacityLedgerEntry.RESET;
            CapacityLedgerEntry.SETRANGE("Order Type", ItemLedgerEntryRecPar."Order Type");
            CapacityLedgerEntry.SETRANGE("Order No.", ItemLedgerEntryRecPar."Order No.");
            CapacityLedgerEntry.SETRANGE("Order Line No.", ItemLedgerEntryRecPar."Order Line No.");
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

        // delete quality ledger entries >>
        QualityItemLedgerEntry.RESET;
        QualityItemLedgerEntry.SETRANGE("Entry No.", ItemLedgerEntryRecPar."Entry No.");
        IF QualityItemLedgerEntry.FINDSET THEN
            QualityItemLedgerEntry.DELETEALL;


        // delete quality ledger entries <<
        ItemLedgerEntryRecPar.DELETE;
    end;
}

