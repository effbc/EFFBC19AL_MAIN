codeunit 90008 "IJL Table Total"
{

    trigger OnRun();
    begin
        window.OPEN('#1######################');
        Amt := 0;
        IJL.FINDFIRST;
        REPEAT
            window.UPDATE(1, Amt);
            Amt := Amt + IJL.amount;
        UNTIL IJL.NEXT = 0;
        MESSAGE('%1', Amt);

        Amt1 := 0;
        IJL1.FINDFIRST;
        REPEAT
            window.UPDATE(1, Amt2);
            Amt1 := Amt1 + IJL1.amount;
        UNTIL IJL1.NEXT = 0;
        MESSAGE('%1', Amt1);

        Amt2 := 0;
        IJL2.FINDFIRST;
        REPEAT
            window.UPDATE(1, Amt2);
            Amt2 := Amt2 + IJL2.amount;
        UNTIL IJL2.NEXT = 0;
        MESSAGE('%1', Amt2);

        Amt3 := 0;
        IJL3.FINDFIRST;
        REPEAT
            window.UPDATE(1, Amt3);
            Amt3 := Amt3 + IJL3.amount;
        UNTIL IJL3.NEXT = 0;
        MESSAGE('%1', Amt3);

        amt4 := 0;
        IJL4.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt4);
            amt4 := amt4 + IJL4.amount;
        UNTIL IJL4.NEXT = 0;
        MESSAGE('%1', amt4);

        amt5 := 0;
        IJL5.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt5);
            amt5 := amt5 + IJL5.amount;
        UNTIL IJL5.NEXT = 0;
        MESSAGE('%1', amt5);

        amt6 := 0;
        IJL6.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt6);
            amt6 := amt6 + IJL6.amount;
        UNTIL IJL6.NEXT = 0;
        MESSAGE('%1', amt6);

        amt7 := 0;
        IJL7.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt7);
            amt7 := amt7 + IJL7.amount;
        UNTIL IJL7.NEXT = 0;
        MESSAGE('%1', amt7);

        amt8 := 0;
        IJL8.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt8);
            amt8 := amt8 + IJL8.amount;
        UNTIL IJL8.NEXT = 0;
        MESSAGE('%1', amt8);

        amt9 := 0;
        IJL9.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt9);
            amt9 := amt9 + IJL9.amount;
        UNTIL IJL9.NEXT = 0;
        MESSAGE('%1', amt9);

        amt10 := 0;
        ijl10.FINDFIRST;
        REPEAT
            window.UPDATE(1, amt10);
            amt10 := amt10 + ijl10.amount;
        UNTIL ijl10.NEXT = 0;
        MESSAGE('%1', amt10);
        MESSAGE('firsttot,%1', Amt + Amt1 + Amt2 + Amt3 + amt4 + amt5 + amt6);
        MESSAGE('Lasttot,%1', amt7 + amt8 + amt9 + amt10);
        MESSAGE('%1', Amt + Amt1 + Amt2 + Amt3 + amt4 + amt5 + amt6 + amt7 + amt8 + amt9 + amt10);
    end;

    var
        window: Dialog;
        Amt: Decimal;
        IJL: Record "IJL Table";
        IJL1: Record "IJL Table1";
        IJL2: Record "IJL Table2";
        IJL3: Record "IJL Table3";
        IJL4: Record "IJL Table4";
        IJL5: Record "IJL Table5";
        IJL6: Record "IJL Table6";
        IJL7: Record "IJL Table7";
        IJL8: Record "IJL Table8";
        IJL9: Record "IJL Table9";
        ijl10: Record "IJL Table10";
        Amt1: Decimal;
        Amt2: Decimal;
        Amt3: Decimal;
        amt4: Decimal;
        amt5: Decimal;
        amt6: Decimal;
        amt7: Decimal;
        amt8: Decimal;
        amt9: Decimal;
        amt10: Decimal;
}

