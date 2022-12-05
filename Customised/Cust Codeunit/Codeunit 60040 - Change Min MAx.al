codeunit 60040 "Change Min MAx"
{

    trigger OnRun();
    begin
        ItemGRec.RESET;
        ItemGRec.SETFILTER(Make, 'MINMAX');
        MESSAGE('%', ItemGRec.COUNT);
    end;

    var
        ItemGRec: Record Item;
}

