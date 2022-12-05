codeunit 80001 "Item Op Balance"
{

    trigger OnRun();
    begin
        IF NOT CONFIRM('Do you want to insert the item journal lines?', FALSE) THEN
            EXIT;
        Window.OPEN('#1###############');

        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
        ReservationEntry.SETRANGE("Source ID", 'RECLASS');
        ReservationEntry.SETRANGE("Source Batch Name", 'DEFAULT');
        ReservationEntry.DELETEALL;

        ReservationEntry.RESET;
        IF ReservationEntry.FINDLAST THEN
            LastReservEntryNo := ReservationEntry."Entry No." + 1
        ELSE
            LastReservEntryNo := 1;

        IJL.RESET;
        IJL.SETRANGE(IJL."Journal Template Name", 'RECLASS');
        IJL.SETRANGE(IJL."Journal Batch Name", 'DEFAULT');
        IJL.DELETEALL;

        /*

        NIJL.FIND('-');
        REPEAT
            CLEAR(SkipLoop);
            CLEAR(ErrorText);
            Window.UPDATE(1, NIJL."Line No");
            IF NOT ItemGRec.GET(NIJL."No.") THEN BEGIN
                ErrorText += 'Item No.,';
                SkipLoop := TRUE;
            END;
            IF NOT ItemUOM.GET(NIJL."No.", NIJL.UOM) THEN BEGIN
                ErrorText += 'Item UOM,';
                SkipLoop := TRUE;
            END;
            IF NOT LocationGRec.GET(NIJL.Location) THEN BEGIN
                ErrorText += 'Location,';
                SkipLoop := TRUE;
            END;

            IF NOT SkipLoop THEN BEGIN
                IJL.INIT;
                IJL.VALIDATE(IJL."Journal Template Name", 'RECLASS');
                IJL.VALIDATE(IJL."Journal Batch Name", 'DEFAULT');
                IJL.VALIDATE(IJL."Line No.", NIJL."Line No");
                IJL.INSERT(TRUE);

                IJL.VALIDATE(IJL."Posting Date", NIJL."Posting Date");
                IJL.VALIDATE(IJL."Document Date", NIJL."Document Date");
                IJL.VALIDATE("Entry Type", NIJL."Entry Type");
                IJL.VALIDATE(IJL."Document No.", NIJL."Document No.");
                IJL.VALIDATE(IJL."Item No.", NIJL."No.");
                IJL.VALIDATE("Entry Type", IJL."Entry Type"::Transfer);
                IJL.VALIDATE(IJL."Location Code", NIJL.Location);
                //IJL.VALIDATE(IJL."Inventory Posting Group",NIJL.IPG);
                //IJL.VALIDATE(IJL."Gen. Prod. Posting Group",NIJL.GPPG);
                IJL.VALIDATE(IJL."Unit of Measure Code", NIJL.UOM);
                IJL.VALIDATE(IJL."Location Code", NIJL.Location);
                IJL.VALIDATE(IJL.Quantity, NIJL.Quantity);
                EntryNoGVar := 0;
                IJL.VALIDATE(IJL."Unit Cost", NIJL."Unit Cost");
                IJL.VALIDATE("Unit Amount", NIJL."Unit Cost");
                IJL.VALIDATE("New Location Code", NIJL."New Location");
                IJL.MODIFY(TRUE);

                ItemGRec2.GET(NIJL."No.");
                IF ItemGRec2."Item Tracking Code" <> '' THEN BEGIN
                    ReservationEntry.INIT;
                    ReservationEntry."Entry No." := LastReservEntryNo;
                    // ReservationEntry.VALIDATE(Positive,TRUE);
                    ReservationEntry.INSERT(TRUE);
                    ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                    ReservationEntry."Source Type" := DATABASE::"Item Journal Line";
                    ReservationEntry."Source Subtype" := 4;
                    ReservationEntry."Source ID" := 'RECLASS';
                    ReservationEntry."Source Batch Name" := 'DEFAULT';
                    ReservationEntry."Source Ref. No." := IJL."Line No.";
                    ReservationEntry.VALIDATE("Item No.", NIJL."No.");
                    ReservationEntry.Description := 'Item Reclassfication';
                    ReservationEntry.VALIDATE("Location Code", NIJL.Location);
                    ReservationEntry.VALIDATE("Lot No.", NIJL."Lot No.");
                    ReservationEntry.VALIDATE("Serial No.", NIJL."Serial No.");
                    ReservationEntry.VALIDATE("New Lot No.", NIJL."Lot No.");
                    ReservationEntry.VALIDATE("New Serial No.", NIJL."Serial No.");
                    ReservationEntry.VALIDATE("Quantity (Base)", -NIJL.Quantity);
                    ReservationEntry.MODIFY(TRUE);
                    LastReservEntryNo += 1;
                END;
                // IJL.VALIDATE("Shortcut Dimension 1 Code",NIJL."Shortcut Dimension 1 Code");
                NIJL.Inserted := TRUE;

            END;
            NIJL."Error Text" := ErrorText;
            NIJL.MODIFY;
        UNTIL NIJL.NEXT = 0;
        */
    end;

    var
        IJL: Record "Item Journal Line";
        // NIJL: Record 80004;
        Window: Dialog;
        Item: Record Item;
        ItemGRec: Record Item;
        SkipLoop: Boolean;
        ErrorText: Text[250];
        ItemUOM: Record "Item Unit of Measure";
        LocationGRec: Record Location;
        EntryNoGVar: Integer;
        ReservationEntry: Record "Reservation Entry";
        LastReservEntryNo: Integer;
        ItemGRec2: Record Item;
}

