pageextension 70016 BankAccountCardExt extends "Bank Account Card"
{
    layout
    {
        modify(Balance)
        {
            trigger OnDrillDown()
            begin
                Rec.DrillDownBankBalance; //Rev01
            end;
        }
        modify("Balance (LCY)")
        {
            trigger OnDrillDown()
            begin
                Rec.DrillDownBankBalanceLCY; //Rev01
            end;
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }

        modify(Statements)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(BankAccountReconciliations)
        {
            Promoted = true;
        }
        modify("Receivables-Payables")
        {
            Promoted = true;
        }

        modify("Cash Receipt Journals")
        {
            Promoted = true;
        }
        modify("Payment Journals")
        {
            Promoted = true;
        }
        modify(PagePosPayExport)
        {
            Promoted = true;
        }
        modify(List)
        {
            Promoted = true;
        }
        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
        modify(Action1906306806)
        {
            Promoted = false;
        }
        modify("Check Details")
        {
            Promoted = true;
        }
    }
}

