table 33000924 "Item Op Balance"
{
    //Permissions = TableData TableData80004 = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Location; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; UOM; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Entry Type"; Option)
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
            DataClassification = CustomerContent;
        }
        field(16; "New Location"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(17; "New Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; "New Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Error Text"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

