table 33000933 "Temp User"
{
    DataClassification = CustomerContent;
    Caption = 'Temp User';

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            DataClassification = CustomerContent;
            Enabled = true;

        }
        field(2; "User Name"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Full Name"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(4; State; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(5; "Expiry Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Windows Security ID"; Text[119])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Change Password"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "License Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Full User,Limited User,Device Only User,Windows Group,External User';
            OptionMembers = "Full User","Limited User","Device Only User","Windows Group","External User";
        }
        field(11; "Authentication Email"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Contact Email"; Text[250])
        {
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
        field(60102; Levels; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60103; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60104; Dimension; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60105; EmployeeID; Code[20])
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
        key(pk; "User Security ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}