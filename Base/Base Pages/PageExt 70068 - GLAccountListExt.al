pageextension 70068 GLAccountListExt extends "G/L Account List"
{
    layout
    {
        addafter("Income/Balance")
        {
            field("Search Name"; Rec."Search Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("Default Deferral Template Code")
        {
            field("Cash Account"; Rec."Cash Account")
            {
                ApplicationArea = All;
            }
            field("TDS Account"; Rec."TDS Account")
            {
                ApplicationArea = All;
            }
            field("Work Tax Account"; Rec."Work Tax Account")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("G/L &Account Balance")
        {
            Promoted = true;
        }
        modify("G/L &Balance")
        {
            Promoted = true;
        }
        modify("G/L Balance by &Dimension")
        {
            Promoted = true;
        }

        modify("Trial Balance")
        {
            Promoted = true;
        }
        modify("Trial Balance by Period")
        {
            Promoted = true;
        }
        modify("Detail Trial Balance")
        {
            Promoted = true;
        }
    }
}

