table 60124 TEST_CS
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; ITEM; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Serial No"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; Location; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Working status"; Option)
        {
            OptionMembers = ,WORKING,"NON WORKING";
            DataClassification = CustomerContent;
        }
        field(5; Updated; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; ITEM)
        {
        }
    }

    fieldgroups
    {
    }
}

