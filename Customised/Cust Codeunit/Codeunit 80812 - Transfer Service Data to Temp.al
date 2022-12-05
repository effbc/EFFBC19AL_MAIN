codeunit 80812 "Transfer Service Data to Temp"
{
    // version B2Bupg


    trigger OnRun();
    begin
        UpdateTempServHead;
        UpdateTempServItemLine;
        UpdateTempServLine;
        MESSAGE('finished.');
    end;

    var
        TempServHead: Record "Temp Service Header";
        TempServItemLine: Record "Temp Service Item Line";
        TempServLine: Record "Temp Service Line";
        ServHead: Record "Service Header";
        ServItemLine: Record "Service Item Line";
        ServLine: Record "Service Line";


    procedure UpdateTempServHead();
    begin
        ServHead.RESET;
        IF ServHead.FINDFIRST THEN
            REPEAT
                TempServHead.INIT;
                TempServHead.TRANSFERFIELDS(ServHead);
                TempServHead.INSERT;
            UNTIL ServHead.NEXT = 0;
    end;


    procedure UpdateTempServItemLine();
    begin
        ServItemLine.RESET;
        IF ServItemLine.FINDFIRST THEN
            REPEAT
                TempServItemLine.INIT;
                TempServItemLine.TRANSFERFIELDS(ServItemLine);
                TempServItemLine.INSERT;
            UNTIL ServItemLine.NEXT = 0;
    end;


    procedure UpdateTempServLine();
    begin
        ServLine.RESET;
        IF ServLine.FINDFIRST THEN
            REPEAT
                TempServLine.INIT;
                TempServLine.TRANSFERFIELDS(ServLine);
                TempServLine.INSERT;
            UNTIL ServLine.NEXT = 0;
    end;
}

