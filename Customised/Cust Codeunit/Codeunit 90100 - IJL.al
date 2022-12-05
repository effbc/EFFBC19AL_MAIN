codeunit 90100 IJL
{

    trigger OnRun();
    begin
        //Deleted Var(ItemDimensionRecordTable356)//B2B

        Window.OPEN('#1#################');
        IF SharavanData.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN1');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData.NEXT = 0;

        //*****************************************************

        IF SharavanData1.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData1."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData1."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN2');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData1."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData1.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData1.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData1.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData1.NEXT = 0;


        //*****************************************************

        IF SharavanData2.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData2."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData2."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN3');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData2."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData2.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData2.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData2.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData2.NEXT = 0;


        //*****************************************************

        IF SharavanData3.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData3."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData3."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN4');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData3."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData3.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData3.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData3.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData3.NEXT = 0;

        //*****************************************************

        IF SharavanData4.FINDFIRST THEN;
        Line := 10000;
        REPEAT
            IF Item.GET(SharavanData4."No.") THEN
                IF Item."Item Tracking Code" <> '' THEN BEGIN
                    Window.UPDATE(1, SharavanData4."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Template Name", 'ITEM');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Journal Batch Name", 'IJNL-OPN5');
                    ItemJournalLine."Line No." := Line;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Posting Date", WORKDATE);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Document No.", 'OPIJN-00001');
                    ItemJournalLine.VALIDATE(ItemJournalLine."Item No.", SharavanData4."No.");
                    ItemJournalLine.VALIDATE(ItemJournalLine."Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.");
                    //getlocation;
                    ItemJournalLine.VALIDATE(ItemJournalLine."Location Code", 'STR');
                    ItemJournalLine.VALIDATE(ItemJournalLine.Quantity, SharavanData4.Quantity);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Amount", SharavanData4.Rate);
                    ItemJournalLine.VALIDATE(ItemJournalLine."Unit Cost", SharavanData4.Rate);
                    IF ItemJournalLine."Item No." <> '' THEN
                        ItemJournalLine.INSERT(TRUE);
                END;
            Line := Line + 10000;
        UNTIL SharavanData4.NEXT = 0;

        //*****************************************************
    end;

    var
        ItemJournalLine: Record "Item Journal Line";
        SharavanData: Record "IJL Table";
        Item: Record Item;
        Window: Dialog;
        Line: Integer;
        SharavanData1: Record "IJL Table1";
        SharavanData2: Record "IJL Table2";
        SharavanData3: Record "IJL Table3";
        SharavanData4: Record "IJL Table4";
}

