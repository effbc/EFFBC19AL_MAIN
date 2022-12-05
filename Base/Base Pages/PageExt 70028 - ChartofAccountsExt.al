pageextension 70028 ChartofAccountsExt extends 16
{
    Editable = true;
    layout
    {
        addafter("Account Type")
        {
            field("PL Head"; Rec."PL Head")
            {
                ApplicationArea = All;
            }
            field(Reflected_in_pl_userid; Rec.Reflected_in_pl_userid)
            {
                ApplicationArea = All;
            }
            field(Reflected_in_pl_datetime; Rec.Reflected_in_pl_datetime)
            {
                ApplicationArea = All;
            }
        }

        addafter(Totaling)
        {
            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = All;
            }
            field("Budget Filter"; Rec."Budget Filter")
            {
                ApplicationArea = All;
            }
        }
        addafter(Balance)
        {
            field("Cash Account"; Rec."Cash Account")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("TDS Account"; Rec."TDS Account")
            {
                Visible = false;
                ApplicationArea = All;
            }
            field("Work Tax Account"; Rec."Work Tax Account")
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("A&ccount")
        {
            action(Card)
            {
                ShortCutKey = 'Shift+F5';
                Caption = 'Card';
                RunObject = Page "G/L Account Card";
                RunPageLink = "No." = field("No."),
                 "Date Filter" = FIELD("Date Filter"),
                  "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                  "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                  "Budget Filter" = FIELD("Budget Filter"),
                   "Business Unit Filter" = FIELD("Business Unit Filter");
                ApplicationArea = All;
            }
        }
        addafter("Receivables-Payables")
        {
            action("&MSPT Receivables-Payables")
            {
                Caption = '&MSPT Receivables-Payables';
                RunObject = Page "MSPT Receivables-Payables";
                ApplicationArea = All;
            }
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify("G/L Register")
        {
            Promoted = true;
        }
        modify(IndentChartOfAccounts)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Close Income Statement")
        {
            Promoted = true;
            PromotedIsBig = true;
        }

        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance by Period")
        {
            Promoted = false;
        }
        modify(Action1900210206)
        {
            Promoted = true;
        }

    }

}

