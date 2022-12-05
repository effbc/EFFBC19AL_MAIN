codeunit 80813 "Transfer Led. Entry Desc"
{

    trigger OnRun();
    begin
        Window.OPEN('Table Name#1######################');
        UpdateGLEntry;
        UpdateCustLedgEntry;
        UpdateVendLedgEntry;
        UpdateBankLedgEntry;
        MESSAGE('Finished.');
    end;

    var
        TempGLEntry: Record "Temp GL Entry Desc";
        TempCustLedgEntry: Record "Temp Cust Ledg. Entry Desc";
        TempVendLedgEntry: Record "Temp Vend Ledg. Entry Desc";
        TempBankLedgEntry: Record "Temp Bank Ledg. Entry Desc";
        GLEntry: Record "G/L Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        Window: Dialog;


    procedure UpdateGLEntry();
    begin
        Window.UPDATE(1, 'G/L Entry');
        TempGLEntry.RESET;
        IF TempGLEntry.FINDSET THEN
            REPEAT
                IF GLEntry.GET(TempGLEntry."Entry No.") THEN BEGIN
                    GLEntry.Description := TempGLEntry.Description;
                    GLEntry.MODIFY;
                END;
            UNTIL TempGLEntry.NEXT = 0;
    end;


    procedure UpdateCustLedgEntry();
    begin
        Window.UPDATE(1, 'Cust. Ledger Entry');
        TempCustLedgEntry.RESET;
        IF TempCustLedgEntry.FINDSET THEN
            REPEAT
                IF CustLedgEntry.GET(TempCustLedgEntry."Entry No.") THEN BEGIN
                    CustLedgEntry.Description := TempCustLedgEntry.Description;
                    CustLedgEntry.MODIFY;
                END;
            UNTIL TempCustLedgEntry.NEXT = 0;
    end;


    procedure UpdateVendLedgEntry();
    begin
        Window.UPDATE(1, 'Vend. Ledg Entry');
        TempVendLedgEntry.RESET;
        IF TempVendLedgEntry.FINDSET THEN
            REPEAT
                IF VendLedgEntry.GET(TempVendLedgEntry."Entry No.") THEN BEGIN
                    VendLedgEntry.Description := TempVendLedgEntry.Description;
                    VendLedgEntry.MODIFY;
                END;
            UNTIL TempVendLedgEntry.NEXT = 0;
    end;


    procedure UpdateBankLedgEntry();
    begin
        Window.UPDATE(1, 'Bank A Entry');
        TempBankLedgEntry.RESET;
        IF TempBankLedgEntry.FINDSET THEN
            REPEAT
                IF BankAccLedgEntry.GET(TempBankLedgEntry."Entry No.") THEN BEGIN
                    BankAccLedgEntry.Description := TempBankLedgEntry.Description;
                    BankAccLedgEntry.MODIFY;
                END;
            UNTIL TempBankLedgEntry.NEXT = 0;
    end;
}

