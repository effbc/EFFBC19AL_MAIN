report 2000003 "Del Item LedgEnt With LotTrack"
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
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin

                WindowDia.UPDATE(1, Item."No.");

                Location.RESET;
                IF Location.FINDSET THEN BEGIN
                    REPEAT
                        CLEAR(PrevLotNum);
                        ItemLedgerEntry.RESET;
                        ItemLedgerEntry.SETCURRENTKEY("Item No.", "Location Code", "Lot No.");
                        ItemLedgerEntry.SETRANGE("Item No.", Item."No.");
                        ItemLedgerEntry.SETRANGE("Location Code", Location.Code);
                        ItemLedgerEntry.SETFILTER("Posting Date", '<=%1', EndingDate);
                        ItemLedgerEntry.SETFILTER("Serial No.", '%1', '');
                        ItemLedgerEntry.SETFILTER("Lot No.", '<>%1', '');
                        IF ItemLedgerEntry.FINDSET THEN BEGIN
                            REPEAT

                                IF PrevLotNum <> ItemLedgerEntry."Lot No." THEN BEGIN
                                    CLEAR(ILEQty);
                                    CLEAR(ApplicationQty);
                                    CLEAR(ILERemQty);
                                    PrevLotNum := ItemLedgerEntry."Lot No.";
                                    ILERec.RESET;
                                    ILERec.SETCURRENTKEY("Item No.", "Location Code", "Lot No.");
                                    ILERec.SETRANGE("Item No.", Item."No.");
                                    ILERec.SETRANGE("Location Code", Location.Code);
                                    ILERec.SETFILTER("Posting Date", '<=%1', EndingDate);
                                    ILERec.SETFILTER("Serial No.", '%1', '');
                                    ILERec.SETFILTER("Lot No.", '%1', PrevLotNum);
                                    IF ILERec.FINDSET THEN BEGIN
                                        ILERec.CALCSUMS(Quantity, "Remaining Quantity");
                                        ILEQty := ILERec.Quantity;
                                        ILERemQty := ILERec."Remaining Quantity";
                                    END;
                                END;
                                IF ItemLedgerEntry.Quantity > 0 THEN BEGIN
                                    IF ILEQty > 0 THEN BEGIN
                                        ItemLedgerEntry.Quantity := ILEQty;
                                        ItemLedgerEntry."Remaining Quantity" := ILERemQty;
                                        ItemLedgerEntry."Invoiced Quantity" := ILERemQty;
                                        IF ILERemQty = 0 THEN
                                            ItemLedgerEntry.Open := FALSE
                                        ELSE
                                            ItemLedgerEntry.Open := TRUE;
                                        ItemLedgerEntry.MODIFY;

                                        ApplicationQty := ILEQty;
                                        ILEQty := 0;
                                        CurrILENum := ItemLedgerEntry."Entry No.";
                                        IF ItemLedgerEntry.Positive THEN BEGIN
                                            ItemApplicationEntry3.SETCURRENTKEY("Inbound Item Entry No.");
                                            ItemApplicationEntry3.SETRANGE("Inbound Item Entry No.", ItemLedgerEntry."Entry No.");
                                            //ItemApplicationEntry3.SETFILTER("Outbound Item Entry No.",'%1',0);
                                            //ItemApplicationEntry3.SETFILTER("Item Ledger Entry No.",'<>%1',ItemLedgerEntry."Entry No.");
                                            IF ItemApplicationEntry3.FINDFIRST THEN BEGIN
                                                ItemApplicationEntry3.Quantity := ApplicationQty;
                                                ItemApplicationEntry3."Outbound Item Entry No." := 0;
                                                ItemApplicationEntry3.MODIFY;
                                            END;
                                        END;


                                        // LotILEUpdated := TRUE;
                                    END;
                                END ELSE BEGIN
                                    IF ILEQty < 0 THEN BEGIN
                                        ItemLedgerEntry.Quantity := ILEQty;
                                        ItemLedgerEntry."Remaining Quantity" := 0;
                                        ItemLedgerEntry.Open := FALSE;
                                        ItemLedgerEntry."Invoiced Quantity" := ILEQty;
                                        ItemLedgerEntry.MODIFY;

                                        ApplicationQty := ILEQty;
                                        ILEQty := 0;
                                        CurrILENum := ItemLedgerEntry."Entry No.";
                                        //LotILEUpdated := TRUE;
                                    END;
                                END;
                                IF CurrILENum <> ItemLedgerEntry."Entry No." THEN BEGIN
                                    DeleteEntries(ItemLedgerEntry, CurrILENum, ApplicationQty);
                                END ELSE BEGIN
                                    ValueEntry.RESET;
                                    ValueEntry.SETRANGE("Item Ledger Entry No.", CurrILENum);
                                    IF ValueEntry.FINDFIRST THEN BEGIN
                                        ValueEntry."Item Ledger Entry Quantity" := ApplicationQty;
                                        ValueEntry."Valued Quantity" := ApplicationQty;
                                        ValueEntry."Invoiced Quantity" := ApplicationQty;
                                        ValueEntry.MODIFY;
                                        ValueEntry2.RESET;
                                        ValueEntry2.SETRANGE("Item Ledger Entry No.", CurrILENum);
                                        ValueEntry2.SETFILTER("Entry No.", '<>%1', ValueEntry."Entry No.");
                                        IF ValueEntry2.FINDSET THEN
                                            ValueEntry2.DELETEALL;

                                    END;
                                END;

                            UNTIL ItemLedgerEntry.NEXT = 0;
                        END;

                    UNTIL Location.NEXT = 0;
                END;
                Deleted := TRUE;
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
        PrevLotNum: Code[20];
        LotILEUpdated: Boolean;
        ApplicationQty: Decimal;
        CurrILENum: Integer;
        QualityItemLedgerEntry: Record 33000262;
        ValueEntry2: Record 5802;
        ILERemQty: Decimal;
        ItemApplicationEntry3: Record 339;

    local procedure DeleteEntries(ItemLedgerEntryRecPar: Record 32; CurrILENumPar: Integer; var ApplyQtyPar: Decimal)
    begin
        ValueEntry.RESET;
        ValueEntry.SETRANGE("Item Ledger Entry No.", ItemLedgerEntryRecPar."Entry No.");
        IF ValueEntry.FINDSET THEN
            ValueEntry.DELETEALL;
        // delete Item Application entries >>

        ItemApplicationEntry.RESET;
        ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '%1', ItemLedgerEntryRecPar."Entry No.");
        IF ItemApplicationEntry.FINDSET THEN BEGIN
            ItemApplicationEntry.DELETEALL;


            IF (ApplyQtyPar > 0) AND (CurrILENumPar <> 0) THEN BEGIN
                IF ItemLedgerEntryRecPar.Positive THEN BEGIN  //Inbound ILEAganist Applied Entries >>
                    ItemApplicationEntry.SETCURRENTKEY("Inbound Item Entry No.");
                    ItemApplicationEntry.SETRANGE("Inbound Item Entry No.", ItemLedgerEntryRecPar."Entry No.");
                    ItemApplicationEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                    ItemApplicationEntry.SETFILTER("Posting Date", '<=%1', EndingDate);
                    IF ItemApplicationEntry.FINDSET THEN
                        ItemApplicationEntry.DELETEALL;

                    ItemApplicationEntry.SETCURRENTKEY("Inbound Item Entry No.");
                    ItemApplicationEntry.SETRANGE("Inbound Item Entry No.", ItemLedgerEntryRecPar."Entry No.");
                    ItemApplicationEntry.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
                    ItemApplicationEntry.SETFILTER("Posting Date", '>%1', EndingDate);
                    IF ItemApplicationEntry.FINDSET THEN
                        REPEAT
                            ItemApplicationEntry."Inbound Item Entry No." := CurrILENumPar;
                            IF ApplyQtyPar <= ABS(ItemApplicationEntry.Quantity) THEN BEGIN
                                ItemApplicationEntry.Quantity := -ApplyQtyPar;
                                ApplyQtyPar := 0;
                            END ELSE BEGIN
                                ItemApplicationEntry.Quantity := ItemApplicationEntry.Quantity;
                                ApplyQtyPar += ItemApplicationEntry.Quantity;
                            END;
                            ItemApplicationEntry.MODIFY;
                        UNTIL (ItemApplicationEntry.NEXT = 0) OR (ApplyQtyPar = 0);

                END;
                //Inbound ILEAganist Applied Entries <<

            END ELSE
                IF (ApplyQtyPar < 0) AND (CurrILENumPar <> 0) THEN BEGIN
                    //Out Bound Entry Ile applied entries >>
                    IF NOT (ItemLedgerEntryRecPar.Positive) THEN BEGIN
                        ItemApplicationEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                        ItemApplicationEntry.SETRANGE("Outbound Item Entry No.", ItemLedgerEntryRecPar."Entry No.");
                        ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '%1', ItemLedgerEntryRecPar."Entry No.");
                        ItemApplicationEntry.SETFILTER("Posting Date", '<=%1', EndingDate);
                        IF ItemApplicationEntry.FINDSET THEN
                            ItemApplicationEntry.DELETEALL;

                        ItemApplicationEntry.SETCURRENTKEY("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                        ItemApplicationEntry.SETRANGE("Outbound Item Entry No.", ItemLedgerEntryRecPar."Entry No.");
                        ItemApplicationEntry.SETFILTER("Item Ledger Entry No.", '%1', ItemLedgerEntryRecPar."Entry No.");
                        ItemApplicationEntry.SETFILTER("Posting Date", '>%1', EndingDate);
                        IF ItemApplicationEntry.FINDSET THEN
                            REPEAT
                                ItemApplicationEntry."Outbound Item Entry No." := CurrILENumPar;
                                ItemApplicationEntry."Item Ledger Entry No." := CurrILENumPar;

                                IF ABS(ApplyQtyPar) <= ABS(ItemApplicationEntry.Quantity) THEN BEGIN

                                    ItemApplicationEntry.Quantity := -ApplyQtyPar;
                                    ApplyQtyPar := 0;
                                END ELSE BEGIN
                                    ItemApplicationEntry.Quantity := -ABS(ItemApplicationEntry.Quantity);
                                    ApplyQtyPar += ABS(ItemApplicationEntry.Quantity);
                                END;
                                ItemApplicationEntry.MODIFY;
                            UNTIL (ItemApplicationEntry.NEXT = 0) OR (ApplyQtyPar = 0);

                        //Out Bound Entry Ile applied entries <<
                    END;
                END;
        END;

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

