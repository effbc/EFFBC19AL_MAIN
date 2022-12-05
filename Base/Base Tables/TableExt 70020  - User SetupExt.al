tableextension 70020 UserSetupExt extends "User Setup"
{
    fields
    {
        modify("Allow Posting To")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(60001; "Transfer- From Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50000; "Variant Code1"; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60002; "Transfer- To Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60003; "Production Order"; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60050; "Current UserId"; Code[20])
        {
            Description = 'UserId';
            DataClassification = CustomerContent;
        }
        field(60051; Executed; Boolean)
        {
            Description = 'UserId';
            DataClassification = CustomerContent;
        }
        field(60052; "Edit Posted Ledger Entries"; Boolean)
        {
            Description = 'sundar';
            DataClassification = CustomerContent;
        }
        field(60100; Dept; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60101; MailID; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(60102; levels; boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60103; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60104; Dimension; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60105; EmployeeID; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60106; Tams_Dept; Code[20])
        {
            DataClassification = CustomerContent;
        }

    }
    keys
    {
    }
}

