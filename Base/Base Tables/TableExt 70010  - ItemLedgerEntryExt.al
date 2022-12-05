tableextension 70010 ItemLedgerEntryExt extends "Item Ledger Entry"
{

    fields
    {
        field(60001; "ITL Doc No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "ITL Doc Line No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "ITL Doc Ref Line No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Reason Code22"; Code[10])
        {
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(60012; "Job No.2"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60013; "Job budget Line No."; Integer)
        {
            Description = 'B2B';
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
        field(60105; "User ID"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60106; "Sales Order No"; Code[20])
        {
            Description = 'SH1.0';
            DataClassification = CustomerContent;
        }
        field(60107; "Sales Order Line No"; Integer)
        {
            Description = 'SH1.0';
            DataClassification = CustomerContent;
        }
        field(60108; "Schedule Line No"; Integer)
        {
            Description = 'SH1.0';
            DataClassification = CustomerContent;
        }
        field(60109; "Issued Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "DC Check"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60111; "MBB Packed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60112; "MFD Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60113; "Recharge Cycles"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "Floor Life"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60115; "MBB Packet Open DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60116; "MBB Packet Close DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60117; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60118; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(33000260; "Purch.Rcpt Line"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(33000261; "QC Check"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        /*{IF USERID<>'ANIL' THEN
               BEGIN
                Body:='****  Auto Mail Generated From ERP  ****';
                Mail_From:='erp@efftronics.net';
                 Mail_To:='anilkumar@efftronics.net,phani@efftronics.net';
               // Mail_To:='santhoshk@efftronics.net';
                USER.SETRANGE(USER."User ID",USERID);
                IF USER.FIND('-') THEN
                Subject:=USER.Name+'  is trying to Delete Item Ledger Entry Records';
                Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
                 ERROR('U Dont Have Permissions to Delete');
               END;
                }*/
        //ERROR('U Dont Have Permissions to Delete');
    end;

    var
        USER: Record User;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit 8901;
        Subject: Text[250];
        editable: Boolean;
}

