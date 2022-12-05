table 50016 Place
{
    LookupPageID = Place;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Place Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "City Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Place Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Place status"; Option)
        {
            OptionMembers = " ",Up,Down;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Updation date time" := CurrentDateTime;
            end;
        }
        field(5; "Updation date time"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Place Code")
        {
        }
    }

    fieldgroups
    {
    }
}

