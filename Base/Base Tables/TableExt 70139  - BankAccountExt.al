tableextension 70139 BankAccountExts extends "Bank Account"
{
    fields
    {


    }

    PROCEDURE "---Rev01---"();
    BEGIN
    END;


    PROCEDURE DrillDownBankBalance();
    VAR
        BankAccLedgEntriesFormLVar: Page "Bank Account Ledger Entries";
        BankAccLedgEntryLRec: Record "Bank Account Ledger Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20080401D;
        EndDateLVar := 20350331D;

        BankAccLedgEntryLRec.Reset;
        BankAccLedgEntryLRec.SetCurrentKey("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
        BankAccLedgEntryLRec.SetRange("Bank Account No.", "No.");
        if "Global Dimension 1 Filter" <> '' then
            BankAccLedgEntryLRec.SetFilter("Global Dimension 1 Code", "Global Dimension 1 Filter");
        if "Global Dimension 2 Filter" <> '' then
            BankAccLedgEntryLRec.SetRange("Global Dimension 2 Code", "Global Dimension 2 Filter");
        BankAccLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if BankAccLedgEntryLRec.FindFirst then begin
            Clear(BankAccLedgEntriesFormLVar);
            BankAccLedgEntriesFormLVar.SetTableView(BankAccLedgEntryLRec);
            BankAccLedgEntriesFormLVar.RunModal;
        end;
    END;


    PROCEDURE DrillDownBankBalanceLCY();
    VAR
        BankAccLedgEntriesFormLVar: Page "Bank Account Ledger Entries";
        BankAccLedgEntryLRec: Record "Bank Account Ledger Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20080401D;
        EndDateLVar := 20350331D;

        BankAccLedgEntryLRec.Reset;
        BankAccLedgEntryLRec.SetCurrentKey("Bank Account No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Posting Date");
        BankAccLedgEntryLRec.SetRange("Bank Account No.", "No.");
        if "Global Dimension 1 Filter" <> '' then
            BankAccLedgEntryLRec.SetFilter("Global Dimension 1 Code", "Global Dimension 1 Filter");
        if "Global Dimension 2 Filter" <> '' then
            BankAccLedgEntryLRec.SetRange("Global Dimension 2 Code", "Global Dimension 2 Filter");
        BankAccLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if BankAccLedgEntryLRec.FindFirst then begin
            Clear(BankAccLedgEntriesFormLVar);
            BankAccLedgEntriesFormLVar.SetTableView(BankAccLedgEntryLRec);
            BankAccLedgEntriesFormLVar.RunModal;
        end;
    END;

}

