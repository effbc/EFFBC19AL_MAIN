table 50015 City
{
    LookupPageID = City;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "City Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "District Code"; Code[10])
        {
            TableRelation = "Item Wise Requirement1"."Item No.";
            DataClassification = CustomerContent;
        }
        field(3; "City Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "City Code")
        {
        }
    }

    fieldgroups
    {
    }
}

