table 60021 "Status Parameters"
{
    // version B2B1.0

    LookupPageID = "Status Parameters";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Purchase,Sale,Service,Jobs,Budgets;
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Status Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

