codeunit 80012 "mfg policy modification"
{
    //   for changing mfg policy from make to stock to make to order


    trigger OnRun();
    begin
        /*
        item.FINDFIRST;
        REPEAT
        item."Manufacturing Policy":=item."Manufacturing Policy"::"Make-to-Order";
        item.MODIFY(TRUE);
        UNTIL item.NEXT=0;
        */
        IJL.SETRANGE(IJL."Journal Template Name", 'ITEM');
        IJL.SETRANGE(IJL."Journal Batch Name", 'open002');

        IJL.FINDFIRST;
        REPEAT
            IJL.VALIDATE("Unit Amount");
            //UnitAmount1:=IJL."Unit Amount";
            //MESSAGE('%1',UnitAmount1);
            //MESSAGE('%1',IJL.Quantity);
            //IJL."Unit Amount":=UnitAmount1/IJL.Quantity;
            IJL.MODIFY(TRUE);
        UNTIL IJL.NEXT = 0;
        /*
        ItemJournalLine."Unit Amount" := UnitAmount;
        ItemJournalLine.VALIDATE("Unit Amount");
        */

    end;

    var
        item: Record Item;
        IJL: Record "Item Journal Line";
        UnitAmount1: Decimal;
}

