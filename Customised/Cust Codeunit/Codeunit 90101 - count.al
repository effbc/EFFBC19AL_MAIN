codeunit 90101 "count"
{

    trigger OnRun();
    begin


        MESSAGE('%1', "1".COUNT);
        MESSAGE('%1', "2".COUNT);
        MESSAGE('%1', "3".COUNT);
        MESSAGE('%1', "4".COUNT);
        MESSAGE('%1', "5".COUNT);
        MESSAGE('%1', "6".COUNT);
        MESSAGE('%1', "7".COUNT);
    end;

    var
        "1": Record "IJL Table";
        "2": Record "IJL Table1";
        "3": Record "IJL Table2";
        "4": Record "IJL Table3";
        "5": Record "IJL Table4";
        "6": Record "IJL Table5";
        "7": Record "IJL Table6";
}

