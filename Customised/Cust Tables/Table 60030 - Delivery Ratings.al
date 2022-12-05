table 60030 "Delivery Ratings"
{
    // version POAU

    LookupPageID = "CS Stock Adjustment Card";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Minumum Value"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Maximum Value"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; Rating; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Minumum Value", "Maximum Value", Rating)
        {
        }
    }

    fieldgroups
    {
    }
}

