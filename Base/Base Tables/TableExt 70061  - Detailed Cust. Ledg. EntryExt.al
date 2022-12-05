tableextension 70061 DetailedCustLedgEntryExt extends "Detailed Cust. Ledg. Entry"
{

    fields
    {
        field(60063; "Customer Ord No"; Code[65])
        {
            DataClassification = CustomerContent;
        }
        field(60064; "Payment Type"; Enum "Detailed Cust. Ledg. Entry")
        {
            DataClassification = CustomerContent;

        }
    }
    keys
    {
        key(Key15; "Customer No.", "Posting Date", "Initial Entry Global Dim. 1", "Entry Type")
        {
            SumIndexFields = Amount, "Amount (LCY)", "Debit Amount", "Credit Amount", "Debit Amount (LCY)", "Credit Amount (LCY)";
        }
    }

    trigger OnModify()
    begin
        /* IF UserSetupGRec.GET(USERID) THEN BEGIN
            IF NOT UserSetupGRec."Edit Posted Ledger Entries" THEN
                ERROR('You Dont have Permissions');
        END ELSE
            ERROR('User Setup not found. contact ERP Team'); */

        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (USER.Tams_Dept IN ['ERP']) AND (USER."User ID" <> 'EFFTRONICS\VHARIPRASAD')) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    end;

    trigger OnDelete()
    begin
        /* Body := '****  Auto Mail Generated From ERP  ****';
        Mail_From := 'erp@efftronics.net';
        Mail_To := 'anilkumar@efftronics.com';
        // Mail_To:='santhoshk@efftronics.net';
        USER.SETRANGE(USER."User Security ID", USERID);// Changed User."User Id" to User."User Security ID" B2B
        IF USER.FIND('-') THEN
            Subject := USER."User Name" + '  is trying to Delete Detailed Cust. Ledger Entry Records';// Changed User."Name" to User."User Name" B2B
        Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, '');
        ERROR('U Dont Have Permissions to Delete'); */

        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (USER.Tams_Dept IN ['ERP'])) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    end;

    var
        //UserSetupGRec: Record "User Setup";
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        USER: Record "User Setup";
        Subject: Text[250];
    //Mail: Codeunit Mail;

}

