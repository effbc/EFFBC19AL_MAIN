table 88880 "Routing Values"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";
            DataClassification = CustomerContent;
        }
        field(10; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

