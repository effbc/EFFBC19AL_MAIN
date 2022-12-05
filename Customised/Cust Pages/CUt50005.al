codeunit 50005 MyCodeunit5
{
    trigger OnRun()
    begin
        V1 := CurrentDateTime;
        V2 := CurrentDateTime;
        d1 := v1;
        D2 := v2;
        myInt := ROUND((DateTime2.DateDiff('N', D1, D2, DayofWeekInput, WeekofYearInput)) / 60, 0.01);
        //myInt := ROUND((DateTime2.DateDiff('N', CurrentDateTime, CurrentDateTime, DayofWeekInput, WeekofYearInput)) / 60, 0.01);


    end;

    var
        myInt: BigInteger;
        D1: DotNet DateAndTime;
        D2: DotNet DateAndTime;
        V1: Variant;
        V2: Variant;
        DateTime2: DotNet DateAndTime;
        DayofWeekInput: DotNet DayofWeekInputD;
        WeekofYearInput: DotNet WeekofYearInputD;

}