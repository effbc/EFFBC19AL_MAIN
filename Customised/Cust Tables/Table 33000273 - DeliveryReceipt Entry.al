table 33000273 "Delivery/Receipt Entry"
{
    // version QC1.0

    Caption = 'Delivery Chanlan';
    DrillDownPageID = "Delivery/Receipt Entries";
    LookupPageID = "Delivery/Receipt Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            Description = 'Purchase Receipt numberr or Production Order number';
            DataClassification = CustomerContent;
        }
        field(6; "Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'Inspection Receipt number';
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(11; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(12; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            DataClassification = CustomerContent;
        }
        field(13; Open; Boolean)
        {
            Caption = 'Open';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(14; Positive; Boolean)
        {
            Caption = 'Positive';
            DataClassification = CustomerContent;
        }
        field(15; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = 'In bound,WIP';
            OptionMembers = "In bound",WIP;
            DataClassification = CustomerContent;
        }
        field(16; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Applies-To- Entry"; Integer)
        {
            TableRelation = "Quality Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(20; "Item Ledger Entry No."; Integer)
        {
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(21; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(22; "Item ledger Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            DataClassification = CustomerContent;
        }
        field(23; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            DataClassification = CustomerContent;
        }
        field(24; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(25; "Rework Level"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(26; "New Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(27; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(28; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(29; "In bound Item Ledger Entry No."; Integer)
        {
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(30; "Sub Assembly Code"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;
        }
        field(40; "Document Type"; Option)
        {
            OptionMembers = "Out bound","In Bound";
            DataClassification = CustomerContent;
        }
        field(41; "Out Bound Entry"; Integer)
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

