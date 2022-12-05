table 60004 "CA Number"
{
    // version B2B1.0

    LookupPageID = "CA Number";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

