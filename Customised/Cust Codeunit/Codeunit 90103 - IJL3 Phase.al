codeunit 90103 "IJL3 Phase"
{

    trigger OnRun();
    begin
        //Deleted Var(ItemDimensionRecordTable356)//B2B

        Window.OPEN('#1#################');
        IF SharavanData7.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData7."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData7."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN8');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData7."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData7.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData7.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData7.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData7.NEXT = 0;

        //*****************************************************

        IF SharavanData8.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData8."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData8."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN9');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData8."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData8.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData8.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData8.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData8.NEXT = 0;

        //******************************************************

        IF SharavanData9.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData9."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData9."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN10');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData9."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData9.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData9.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData9.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData9.NEXT = 0;

        //*****************************************************

        IF SharavanData10.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData10."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData10."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN11');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData10."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData10.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData10.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData10.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData10.NEXT = 0;
    end;

    var
        ItemJournalLine: Record "Item Journal Line";
        Item: Record Item;
        Window: Dialog;
        Line: Integer;
        SharavanData7: Record "IJL Table7";
        SharavanData8: Record "IJL Table8";
        SharavanData9: Record "IJL Table9";
        SharavanData10: Record "IJL Table10";
}

