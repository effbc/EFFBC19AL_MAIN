table 33000930 "Sales Orders Temp"
{
    DataClassification = CustomerContent;
    // version UPG1.3

    // No. sign   Description
    // ---------------------------------------------------
    // 1.3 UPG    BOM Replacement process created this object.


    fields
    {
        field(1; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sales Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

