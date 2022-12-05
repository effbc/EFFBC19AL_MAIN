tableextension 70044 BankAccountLedgerEntryExt extends "Bank Account Ledger Entry"
{

    fields
    {
        modify("Document Date")
        {
            ClosingDates = true;
        }

        field(60063; "customer ord no"; Code[65])
        {
            DataClassification = CustomerContent;
        }
        field(60064; "Payment Type"; Enum "CustPayment Type")
        {
            DataClassification = CustomerContent;

        }
        field(60073; "DD/FDR No."; Code[20])
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60074; "Payment Through"; Enum "Payment Through")
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key9; "Posting Date")
        {

        }
    }
    trigger OnModify()
    begin
        /* if UserSetupGRec.Get(UserId) then begin
            if not UserSetupGRec."Edit Posted Ledger Entries" then
                Error('You Dont have Permissions');
        end else
            Error('User Setup not found. contact ERP Team'); */

        User.RESET;
        User.SETFILTER("User ID", USERID);
        IF User.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (User.Tams_Dept IN ['ERP']) AND (User."User ID" <> 'EFFTRONICS\VHARIPRASAD')) THEN //modified by priyanka to remove edit permissions
                ERROR('You do not have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');

    end;

    trigger OnDelete()
    begin
        User.RESET;
        User.SETFILTER("User ID", USERID);
        IF User.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (User.Tams_Dept IN ['ERP'])) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    end;




    var
        //UserSetupGRec: Record "User Setup";
        User: Record "User Setup";
}

