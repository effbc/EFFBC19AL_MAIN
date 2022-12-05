pageextension 70284 BankAccountLedgerEntriesExt extends "Bank Account Ledger Entries"
{
    Editable = true;
    layout
    {
        addafter("Bal. Account No.")
        {
            field("External Document No."; Rec."External Document No.")
            {
                ApplicationArea = All;

            }
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

            }
        }
        addafter(Description)
        {
            /*field("Cheque No."; "Cheque No.")
            {
                ApplicationArea = All;

            }
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;

            }*/
        }
        addbefore("Global Dimension 1 Code")
        {
            field("DD/FDR No."; Rec."DD/FDR No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Payment Through"; Rec."Payment Through")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
       
        addafter(Control1)
        {   
          
            group(Control1102152016)
            {
                ShowCaption = false;
                field(OpeningBal; OpeningBal)
                {
                    Caption = 'Opening Balance';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }


            group(Control1102152014)
            {
                ShowCaption = false;
                field(TotalCredit; TotalCredit)
                {
                    Caption = 'Credit';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }

            }

            group(Control1102152012)
            {
                ShowCaption = false;
                field(TotalDebit; TotalDebit)
                {
                    Caption = 'Debit';
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }

            }
            group(Control1102152010)
            {
                ShowCaption = false;
                field(ClosingBal; ClosingBal)
                {
                    Caption = 'Closing Balance';
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        IF USERID IN ['EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\MNRAJU',
                     'EFFTRONICS\PURNACHAND', 'EFFTRONICS\RAJANI', 'EFFTRONICS\VIJAYA'] THEN BEGIN
            Totals_Visible := TRUE;
            TotalCredit := 0;
            TotalDebit := 0;
            OpeningBal := 0;
            ClosingBal := 0;
        END;
    end;


    var
        LastRecFilter: Text;
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        ClosingBal: Decimal;
        Totals_Visible: Boolean;
        OpeningBal: Decimal;
}