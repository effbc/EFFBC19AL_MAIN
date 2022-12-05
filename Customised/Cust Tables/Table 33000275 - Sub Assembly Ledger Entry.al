table 33000275 "Sub Assembly Ledger Entry"
{
    DataClassification = CustomerContent;
    // version WIP1.0


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Sub Assembly"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Remaining Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Invoiced Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Prod. Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Prod. Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Unit Of Measure Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Variant Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Entry Type"; Option)
        {
            OptionCaption = '" ,Consumption,Output,Transfer"';
            OptionMembers = " ",Consumption,Output,Transfer;
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

