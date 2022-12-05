table 33000906 "PCB Vendor Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Vedor No."; Code[10])
        {
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(2; "Delivery Mode"; Option)
        {
            OptionMembers = Normal,Fast,"Super Fast";
            DataClassification = CustomerContent;
        }
        field(3; "Lead Time"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Price Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Vedor No.", "Delivery Mode")
        {
        }
    }

    fieldgroups
    {
    }
}

