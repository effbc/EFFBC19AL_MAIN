codeunit 90099 "IJL Total Amount"
{

    trigger OnRun();
    begin
        window.OPEN('#1######################');
        Amt := 0;
        IJL.FINDFIRST;
        REPEAT
            window.UPDATE(1, Amt);
            Amt := Amt + IJL.Amount;
        UNTIL IJL.NEXT = 0;
        MESSAGE('%1', Amt);
    end;

    var
        IJL: Record "Item Journal Line";
        Amt: Decimal;
        window: Dialog;
}

