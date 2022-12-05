codeunit 88877 "Temp Dim Values"
{

    trigger OnRun();
    begin
        //This table depreicated in Nav2016
        /*
        DocdimGRec.RESET;
        DocdimGRec.SETRANGE("Dimension Code", 'DEPARTMENTS');
        IF DocdimGRec.FINDSET THEN
            REPEAT
                DimValGRec.RESET;
                DimValGRec.SETRANGE("Dimension Code", DocdimGRec."Dimension Code");
                DimValGRec.SETRANGE(Code, DocdimGRec."Dimension Value Code");
                IF NOT DimValGRec.FINDFIRST THEN BEGIN
                    EntryNo += 1;
                    TempDimValGRec.INIT;
                    TempDimValGRec."Entry No." := EntryNo;
                    TempDimValGRec."Dimension Code" := DocdimGRec."Dimension Code";
                    TempDimValGRec."Dimension Value" := DocdimGRec."Dimension Value Code";
                    TempDimValGRec."Document No." := DocdimGRec."Document No.";
                    TempDimValGRec.INSERT;
                END;
            UNTIL DocdimGRec.NEXT = 0;
            */
    end;

    var
        //  DocdimGRec: Record Table357;
        DimValGRec: Record "Dimension Value";
        EntryNo: Integer;
        TempDimValGRec: Record "Temp Dim Values";
}

