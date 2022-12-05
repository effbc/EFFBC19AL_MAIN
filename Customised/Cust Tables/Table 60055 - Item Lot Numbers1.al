table 60055 "Item Lot Numbers1"
{
    // version B2B1.0

    LookupPageID = "Deveation Master";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Location; Code[10])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No", "Lot No.", Location)
        {
        }
    }

    fieldgroups
    {
    }

    var
        DeveationParameters: Record "Shortage Temp";
}

