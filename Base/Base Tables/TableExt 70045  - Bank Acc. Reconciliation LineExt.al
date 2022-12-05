tableextension 70045 BankAccReconciliationLineExt extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        field(50000; "Cheque No."; Code[10])
        {
            CaptionML = ENU = 'Cheque No.',
                        ENN = 'Cheque No.';
            Description = 'Rev01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque Date"; Date)
        {
            CaptionML = ENU = 'Cheque Date',
                        ENN = 'Cheque Date';
            Description = 'Rev01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "Transfer to Gen. Jnl"; Boolean)
        {
            Caption = 'Transfer to Gen. Jnl';
            Description = 'B2BN1.0 11Dec2018';
            DataClassification = CustomerContent;
        }
        field(50060; "Bank Acc LE"; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50061; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    PROCEDURE SelectOrUnselectAll(Select: Boolean);
    VAR
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
    BEGIN
        //>>B2BN1.0 11Dec2018
        BankAccReconLine.SetRange("Statement Type", "Statement Type");
        BankAccReconLine.SetRange("Bank Account No.", "Bank Account No.");
        BankAccReconLine.SetRange("Statement No.", "Statement No.");
        BankAccReconLine.SetRange("Applied Entries", 0);
        BankAccReconLine.ModifyAll("Transfer to Gen. Jnl", Select);
        //<<B2BN1.0 11Dec2018
    END;
}

