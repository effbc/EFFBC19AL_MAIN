table 90010 "Test - Mi"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

