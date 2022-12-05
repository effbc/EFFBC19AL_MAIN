page 60304 "Bank ledger entries"
{
    PageType = List;
    Permissions = TableData "Bank Account Ledger Entry" = rimd;
    SourceTable = "Bank Account Ledger Entry";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("=rimdO"; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Bank Acc. Posting Group"; Rec."Bank Acc. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Our Contact Code"; Rec."Our Contact Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = All;
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                }
                field("Closed by Entry No."; Rec."Closed by Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Closed at Date"; Rec."Closed at Date")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Statement Status"; Rec."Statement Status")
                {
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
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = All;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Check Ledger Entries"; Rec."Check Ledger Entries")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                /* field("Location Code"; "Location Code")
                 {
                     ApplicationArea = All;
                 }
                 field("Cheque No."; "Cheque No.")
                 {
                     ApplicationArea = All;
                 }
                 field("Cheque Date"; "Cheque Date")
                 {
                     ApplicationArea = All;
                 }
                 field("Stale Cheque"; "Stale Cheque")
                 {
                     ApplicationArea = All;
                 }
                 field("Stale Cheque Expiry Date"; "Stale Cheque Expiry Date")
                 {
                     ApplicationArea = All;
                 }
                 field("Cheque Stale Date"; "Cheque Stale Date")
                 {
                     ApplicationArea = All;
                 }*/
                field("customer ord no"; Rec."customer ord no")
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field("DD/FDR No."; Rec."DD/FDR No.")
                {
                    ApplicationArea = All;
                }
                field("Payment Through"; Rec."Payment Through")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {

        area(creation)
        {
            action(set)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    /*Rec.RESET;
                    Rec.SETFILTER("Posting Date",'<%1',010418D);
                    IF Rec.FINDSET THEN
                    REPEAT
                      Rec.Open := FALSE;
                      Rec.MODIFY;
                    UNTIL Rec.NEXT =0;
                    MESSAGE('updated');*/

                end;
            }
        }

    }
}

