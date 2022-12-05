codeunit 60100 "Base Events"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", 'OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters', '', false, false)]
    local procedure OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingCustLedgerEntry: Record "Cust. Ledger Entry" temporary; var IsHandled: Boolean);
    begin
        // Added by Pranavi on 13-Jan-2017 for not allowing to apply to other departments code entries
        IF COPYSTR(ApplyingCustLedgerEntry."Global Dimension 1 Code", 1, 3) = 'CUS' THEN
            CustLedgerEntry.SETFILTER(CustLedgerEntry."Global Dimension 1 Code", '%1', 'CUS*')
        ELSE
            CustLedgerEntry.SETFILTER(CustLedgerEntry."Global Dimension 1 Code", '%1', 'PRD*');
        // end by Pranavi on 13-Jan-2017
    end;

    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnRunOnBeforeSetStatusReleased', '', false, false)]
    local procedure OnRunOnBeforeSetStatusReleased(var TransferHeader: Record "Transfer Header")
    begin
        //B2B
        IF (TransferHeader."Released Date" = 0D) AND (TransferHeader.Status = TransferHeader.Status::Released) THEN BEGIN
            TransferHeader."Released Date" := WORKDATE;
            TransferHeader."Released By" := USERID;
            TransferHeader."Released Time" := TIME;
        END;
        //B2B
    end;
}