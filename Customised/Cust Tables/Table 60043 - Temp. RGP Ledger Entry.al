table 60043 "Temp. RGP Ledger Entry"
{
    DataClassification = CustomerContent;
    // version B2B1.0,Cal1.0


    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Consignee; Option)
        {
            OptionCaption = 'Customer,Vendor,Party';
            OptionMembers = Customer,Vendor,Party;
            DataClassification = CustomerContent;
        }
        field(3; "Consignee No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionCaption = '" ,Item,Fixed Asset"';
            OptionMembers = " ",Item,"Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Quantity to Recieve"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "RGP In No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; "RGP Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "RGP Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "RGP Out No."; Code[20])
        {
            Description = 'B2B(For Reverse Functionality)';
            DataClassification = CustomerContent;
        }
        field(12; "RGP Out Line No."; Integer)
        {
            Description = 'B2B(For Reverse Functionality)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

