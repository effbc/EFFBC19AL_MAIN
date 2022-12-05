codeunit 88881 "updating missing wc in mc"
{

    trigger OnRun();
    begin
        MacCentGrec.RESET;
        MacCentGrec.SETFILTER("Work Center No.", '=%1', '');
        IF MacCentGrec.FINDSET THEN
            REPEAT
                MacCentGrec."Work Center No." := 'TEST-UPG';
                MacCentGrec.MODIFY;

            UNTIL MacCentGrec.NEXT = 0;
    end;

    var
        MacCentGrec: Record "Machine Center";
}

