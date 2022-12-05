table 50010 "Location of service item"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Station No"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Station name"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Station No")
        {
        }
    }

    fieldgroups
    {
    }
}

