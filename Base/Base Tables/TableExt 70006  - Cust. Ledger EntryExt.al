tableextension 70006 CustLedgerEntryExt extends "Cust. Ledger Entry"
{
    fields
    {
        field(60061; "Sale Order no"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60062; "Customer ord No"; Code[65])
        {
            DataClassification = CustomerContent;
        }
        field(60064; "Payment Type"; Option)
        {
            OptionCaption = ',Supply Payment,AMC Amount,Final Payment,Inst.Payment,Advance,Payment Agst non-issue of C-form,SD,Retention Money,Excess';
            OptionMembers = ,"Supply Payment","AMC Amount","Final Payment","Inst.Payment",Advance,"Payment Agst non-issue of C-form",SD,"Retention Money",Excess;
            DataClassification = CustomerContent;
        }
        field(60065; "Sale Invoice No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60066; "invoice no"; Code[10])
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
        field(60092; "Description1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
    trigger OnModify()
    var
        myInt: Integer;
    begin
        // Commented by Vishnu Priya on 31-10-2020
        /* {IF UserSetupGRec.GET(USERID) THEN
         BEGIN
           IF NOT UserSetupGRec."Edit Posted Ledger Entries" THEN
             ERROR('You Dont have Permissions');
         END ELSE
           ERROR('User Setup not found. contact ERP Team');
           }*/
        // Commented by Vishnu Priya on 31-10-2020
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            // IF (NOT (USER.Tams_Dept IN ['SAL', 'ERP', 'F&A'])) AND (NOT (USER."User Name" IN ['EFFTRONICS\YESU', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\SSIRISHA'])) THEN

            IF (NOT (USER.Tams_Dept IN ['ERP', 'SAL', 'F&A'])) AND (NOT (USER."User ID" IN ['EFFTRONICS\SSIRISHA', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\RISHIANVESH', 'EFFTRONICS\GANURADHA'])) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
        //end;

    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (USER.Tams_Dept IN ['ERP']) AND (USER."User ID" <> 'EFFTRONICS\VHARIPRASAD')) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
        Body := '****  Auto Mail Generated From ERP  ****';
        Mail_From := 'erp@efftronics.net';
        Mail_To := 'anilkumar@efftronics.net,santhoshk@efftronics.net,swarupa@efftronics.net,sreenu@efftronics.net,phani@efftronics.net';
        // Mail_To:='santhoshk@efftronics.net';
        USER.SETRANGE(USER."User ID", USERID);// Changed User."User Id" to User."User Security ID" B2B
        IF USER.FIND('-') THEN
            Subject := USER."User ID" + '  is trying to Delete Customer Ledger Entry Records';// Changed User."Name" to User."User Name" B2B
                                                                                              // Email.NewCDOMessage(Mail_From, Mail_To, Subject, Body, '');
        ERROR('U Dont Have Permissions to Delete');
    end;







    var
        USER: Record "User Setup";
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Email: Codeunit 8901;
        Subject: Text[250];
        UserSetupGRec: Record "User Setup";



}

