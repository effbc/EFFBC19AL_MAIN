table 60044 "Temp. Applied RGPs"
{
    DataClassification = CustomerContent;
    // version B2B1.0,Cal1.0


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Document Type"; Option)
        {
            OptionCaption = 'In,Out';
            OptionMembers = "In",Out;
            DataClassification = CustomerContent;
        }
        field(7; Consignee; Option)
        {
            OptionCaption = 'Customer,Vendor,Party';
            OptionMembers = Customer,Vendor,Party;
            DataClassification = CustomerContent;
        }
        field(8; "Consignee No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Remaining Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Applied To Entry"; Integer)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(12; Open; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; Type; Option)
        {
            OptionCaption = '" ,Item,Fixed Asset,Calibration"';
            OptionMembers = " ",Item,"Fixed Asset",Calibration;
            DataClassification = CustomerContent;
        }
        field(14; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Applies To"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

