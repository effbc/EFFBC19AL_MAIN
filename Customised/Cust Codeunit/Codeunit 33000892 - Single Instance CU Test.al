codeunit 33000892 "Single Instance CU Test"
{
    // version MOD01

    SingleInstance = true;

    trigger OnRun();
    begin
        IF NOT StoreToTemp THEN BEGIN
            StoreToTemp := TRUE;
        END ELSE
            PAGE.RUNMODAL(0, TempGLEntry);
    end;

    var
        TempGLEntry: Record "G/L Entry" temporary;
        StoreToTemp: Boolean;


    procedure InsertGL(GLEntry: Record "G/L Entry");
    begin
        IF StoreToTemp THEN BEGIN
            TempGLEntry := GLEntry;
            IF NOT TempGLEntry.INSERT THEN BEGIN
                TempGLEntry.DELETEALL;
                TempGLEntry.INSERT;
            END;
        END;
    end;
}

