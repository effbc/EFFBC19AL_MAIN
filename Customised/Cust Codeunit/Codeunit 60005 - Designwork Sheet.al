codeunit 60005 "Designwork Sheet"
{
    TableNo = "Design Worksheet Header";

    trigger OnRun();
    var
        Text001: Label 'Do you want to Release the DesignWork Sheet?';
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        TESTFIELD(Status, Status::Open);
        Status := Status::Release;
        MODIFY;
    end;


    procedure Reopen(DesignWorksheetHeader: Record "Design Worksheet Header");
    var
        Text001: Label 'Do you want to Reopen the DesignWork Sheet?';
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        DesignWorksheetHeader.TESTFIELD(Status, DesignWorksheetHeader.Status::Release);
        DesignWorksheetHeader.Status := DesignWorksheetHeader.Status::Open;
        DesignWorksheetHeader.MODIFY;
    end;
}

