tableextension 70152 DetailedVendoLedgEntryExt extends "Detailed Vendor Ledg. Entry"
{

    fields
    {

    }
    keys
    {
        key(Key12; "Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }
    }

    trigger OnModify()
    begin
        /* if UserSetupGRec.Get(UserId) then begin
            if not UserSetupGRec."Edit Posted Ledger Entries" then
                Error('You Dont have Permissions');
        end else
            Error('User Setup not found. contact ERP Team'); */

        //modified by durga on 09-08-2021
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            IF (NOT (USER.Tams_Dept IN ['ERP']) AND (USER."User ID" <> 'EFFTRONICS\VHARIPRASAD')) THEN//modified by durga on 09-08-2021
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    end;

    trigger OnDelete()
    begin
        //modified by durga on 09-08-2021
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            IF NOT (USER.Tams_Dept IN ['ERP']) THEN//modified by durga on 09-08-2021
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
        Body := '****  Auto Mail Generated From ERP  ****';
        Mail_From := 'erp@efftronics.net';
        Mail_To := 'anilkumar@efftronics.net,santhoshk@efftronics.net,swarupa@efftronics.net,sreenu@efftronics.net,phani@efftronics.net';
        // Mail_To:='santhoshk@efftronics.net';
        //USER.SETRANGE(USER."User Security ID" ,USERID);// Changed User."User Id" to User."User Security ID" B2B//UPGREV2.0
        USER.SetRange("User ID", UserId);//UPGREV2.0
        if USER.Find('-') then
            Subject := USER."User ID" + '  is trying to Delete Detailed Vendor Ledger Entry Records';// Changed User."Name" to User."User Name" B2B
        //Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, '');
        Error('U Dont Have Permissions to Delete');
    end;

    var
        //UserSetupGRec: Record "User Setup";
        USER: Record "User Setup";
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        Subject: Text[250];
    //Mail: Codeunit Mail;
}

