table 50020 "Temp User Table"
{
    DataClassification = CustomerContent;
    // version UserId


    fields
    {
        field(1; "Current UserID/Emp ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Windows UserID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Mail Id"; Text[120])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Current UserID/Emp ID")
        {
        }
        key(Key2; "Windows UserID")
        {
        }
        key(Key3; "Mail Id")
        {
        }
    }

    fieldgroups
    {
    }
}

