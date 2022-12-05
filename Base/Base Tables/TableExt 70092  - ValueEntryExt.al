tableextension 70092 ValueEntryExt extends "Value Entry"
{
    fields
    {
        field(60092; "Variant Code1"; Code[30])
        {
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
    }
    keys
    {
        key(Key19; "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code", "Partial Revaluation")
        {
        }
        key(Key20; "Item No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code", "Entry Type")
        {
        }
        key(Key21; "Item No.", "Entry No.", "Expected Cost", "Valuation Date", "Location Code", "Variant Code")
        {
        }
        key(Key22; "Valuation Date")
        {
        }
        key(Key23; "Item Ledger Entry No.")
        {
        }
    }


    trigger OnModify()
    begin
        if UserSetupGRec.Get(UserId) then begin
            if not UserSetupGRec."Edit Posted Ledger Entries" then
                Error('You Dont have Permissions');
        end else
            Error('User Setup not found. contact ERP Team');
    end;

    trigger OnDelete()
    begin
        if not (UserId in ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then begin
            Body := '****  Auto Mail Generated From ERP  ****';
            Mail_From := 'erp@efftronics.net';
            Mail_To := 'anilkumar@efftronics.net,santhoshk@efftronics.net,swarupa@efftronics.net,sreenu@efftronics.net,phani@efftronics.net';
            //Mail_To:='santhoshk@efftronics.net';
            USER.SetRange(USER."User Name", UserId);// Changed User."User Id" to User."User Security ID" B2B
            if USER.Find('-') then
                Subject := USER."Full Name" + '  is trying to Delete Value Entry Records';// Changed User."Name" to User."User Name" B2B
            //Mail.NewCDOMessage(Mail_From, Mail_To, Subject, Body, '');
            Error('U Dont Have Permissions to Delete');
        end;
    end;

    var
        USER: Record User;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit Mail;
        Subject: Text[250];
        UserSetupGRec: Record "User Setup";
}

