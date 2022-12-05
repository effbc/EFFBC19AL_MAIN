table 60065 "Checklist Parameters"
{
    // version B2B1.0

    LookupPageID = "To Be Released Indents";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = Purchase,Sales,Tender,Service;
            DataClassification = CustomerContent;
        }
        field(2; Parameter; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", Parameter)
        {
        }
    }

    fieldgroups
    {
    }
}

