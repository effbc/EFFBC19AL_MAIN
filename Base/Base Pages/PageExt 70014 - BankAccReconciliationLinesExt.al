pageextension 70014 BankAccReconciliationLinesExt extends "Bank Acc. Reconciliation Lines"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control16)
        {
            ShowCaption = false;
        } */
        modify(Control13)
        {
            ShowCaption = false;
        }
        addafter(Difference)
        {
            field("Cheque No."; Rec."Cheque No.")
            {
                ApplicationArea = All;
            }
            field("Cheque Date"; Rec."Cheque Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Additional Transaction Info")
        {
            field("Bank Acc LE"; Rec."Bank Acc LE")
            {
                ApplicationArea = All;
            }
            field("Transfer to Gen. Jnl"; Rec."Transfer to Gen. Jnl")
            {
                Description = 'B2BN1.0 11Dec2018';
                Enabled = TransferToGenJnlEnable;
                ApplicationArea = All;
            }
            field("Statement No."; Rec."Statement No.")
            {
                ApplicationArea = All;
            }
            field("Statement Line No."; Rec."Statement Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(ApplyEntries)
        {
            action(SelectAll)
            {
                Caption = 'Select All';
                Description = 'B2BN1.0 11Dec2018';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.SelectOrUnselectAll(TRUE);
                end;
            }
            action(UnselectAll)
            {
                Caption = 'Unselect All';
                Description = 'B2BN1.0 11Dec2018';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.SelectOrUnselectAll(FALSE);
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Rec.SelectOrUnselectAll(FALSE);//B2BN1.0 11Dec2018
    end;

    var
        TransferToGenJnlEnable: Boolean;
}

