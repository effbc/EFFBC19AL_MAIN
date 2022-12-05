table 88878 "Prod. Routing Lines Tmp"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Prod. Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Prod. Comp. Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";
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

