pageextension 70017 BankAccountListExt extends 371
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter(Name)
        {
            field(Control1000000000; Rec.Balance)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    Rec.DrillDownBankBalance; //Rev01
                end;
            }
            field("Balance (LCY)"; Rec."Balance (LCY)")
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    Rec.DrillDownBankBalanceLCY; //Rev01
                end;
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(PositivePayExport)
        {
            Promoted = true;
        }
        modify(Balance)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
        modify("Check Details")
        {
            Promoted = false;
        }
        modify("Trial Balance by Period")
        {
            Promoted = true;
        }
        modify("Trial Balance")
        {
            Promoted = false;
        }
        /* modify("Bank Book")
        {
            Promoted = true;
        } */
    }
}

