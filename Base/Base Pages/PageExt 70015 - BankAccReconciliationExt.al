pageextension 70015 BankAccReconciliationExt extends "Bank Acc. Reconciliation"
{
    layout
    {
        /* modify(Control8)
        {
            ShowCaption = false;
        } */

    }
    actions
    {
        modify(SuggestLines)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Transfer to General Journal")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(ImportBankStatement)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(MatchAutomatically)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(MatchManually)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            begin
                //BRS1.0>>
                IF NOT IsStandardMatchAllowed THEN
                    ERROR(StandardMatchErr);
                //BRS1.0<<
            end;
        }
        modify(RemoveMatch)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            begin
                //BRS1.0>>
                IF NOT IsStandardMatchAllowed THEN
                    ERROR(StandardMatchErr);
                //BRS1.0<<
            end;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PostAndPrint)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        addafter(NotMatched)
        {
            action(MatchManuallyRev)
            {
                Caption = 'MatchManuallyRev';
                ApplicationArea = All;

                trigger OnAction();
                var
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    MatchBankRecLines1: Codeunit "Custom Events";
                begin
                    IF NOT IsMatchReverseAllowed THEN
                        ERROR(StandardMatchErr);
                    CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                    CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                    //MatchBankRecLines.MatchManuallyREverse(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                    MatchBankRecLines1.MatchManuallyREverse(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);

                end;
            }
            action(RemoveMatchRev)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    MatchBankRecLines1: Codeunit "Custom Events";
                begin
                    IF NOT IsMatchReverseAllowed THEN
                        ERROR(StandardMatchErr);
                    CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                    CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                    //MatchBankRecLines.RemoveMatchReverse(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                    MatchBankRecLines1.RemoveMatchReverse(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                end;
            }
            action(RemoveMatchRevSingle)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    TempBankAccReconciliationLine: Record "Bank Acc. Reconciliation Line" temporary;
                    TempBankAccountLedgerEntry: Record "Bank Account Ledger Entry" temporary;
                    MatchBankRecLines: Codeunit "Match Bank Rec. Lines";
                    MatchBankRecLines1: Codeunit "Custom Events";
                begin
                    IF NOT IsMatchReverseAllowed THEN
                        ERROR(StandardMatchErr);
                    CurrPage.StmtLine.PAGE.GetSelectedRecords(TempBankAccReconciliationLine);
                    CurrPage.ApplyBankLedgerEntries.PAGE.GetSelectedRecords(TempBankAccountLedgerEntry);
                    //MatchBankRecLines.RemoveMatchReverseSingle(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                    MatchBankRecLines1.RemoveMatchReverseSingle(TempBankAccReconciliationLine, TempBankAccountLedgerEntry);
                end;
            }
        }
    }




    var
        StandardMatchErr: Label 'Reverse Match was used already, you cann''t use Match Manually here.';
        ReverseMatchErr: Label 'Match Manually was used already, you cann''t use Reverse Match here.';


    local procedure IsStandardMatchAllowed(): Boolean;
    var
        BankAccReconLine: Record "Bank Acc. Reconciliation Line";
    begin
        BankAccReconLine.RESET;
        BankAccReconLine.SETRANGE("Bank Account No.", Rec."Bank Account No.");
        BankAccReconLine.SETRANGE("Statement No.", Rec."Statement No.");
        BankAccReconLine.SETRANGE("Statement Type", BankAccReconLine."Statement Type"::"Bank Reconciliation");
        BankAccReconLine.SETFILTER("Bank Acc LE", '<>%1', 0);
        EXIT(BankAccReconLine.ISEMPTY);
    end;


    local procedure IsMatchReverseAllowed(): Boolean;
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
    begin
        BankAccLedgEntry.RESET;
        BankAccLedgEntry.SETRANGE("Bank Account No.", Rec."Bank Account No.");
        BankAccLedgEntry.SETRANGE("Statement No.", Rec."Statement No.");
        BankAccLedgEntry.SETRANGE(Open, TRUE);
        BankAccLedgEntry.SETRANGE("Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
        BankAccLedgEntry.SETFILTER("Statement Line No.", '<>%1', 0);
        EXIT(BankAccLedgEntry.ISEMPTY);
    end;
}

