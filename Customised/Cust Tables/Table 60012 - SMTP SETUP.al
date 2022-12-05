table 60012 "SMTP SETUP"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "SMTP Server name"; Code[25])
        {
            DataClassification = CustomerContent;
        }
        field(2; "SMTP Port No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "E-Mail From"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "SMTP Server name")
        {
        }
    }

    fieldgroups
    {
    }
}

