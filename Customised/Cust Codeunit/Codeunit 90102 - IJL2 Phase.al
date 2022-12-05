codeunit 90102 "IJL2 Phase"
{

    trigger OnRun();
    begin
        //Deleted Var(ItemDimensionRecordTable356)//B2B

        Window.OPEN('#1#################');
        IF SharavanData5.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData5."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData5."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN6');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData5."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData5.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData5.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData5.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData5.NEXT = 0;

        //*****************************************************

        IF SharavanData6.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData6."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData6."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN7');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData6."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData6.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData6.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData6.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData6.NEXT = 0;
    end;

    var
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        Window: Dialog;
        Line: Integer;
        SharavanData5: Record "IJL Table5";
        SharavanData6: Record "IJL Table6";
}

