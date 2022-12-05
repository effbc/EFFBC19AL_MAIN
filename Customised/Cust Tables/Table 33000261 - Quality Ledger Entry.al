table 33000261 "Quality Ledger Entry"
{
    // version QC1.1,QCB2B1.2,QC1.0,QC1.2

    Caption = 'Quality Ledger Entry';
    DrillDownPageID = "Quality Ledger Entries";
    LookupPageID = "Quality Ledger Entries";
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
        field(4; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            OptionCaption = 'Accepted,Rework,Reject';
            OptionMembers = Accepted,Rework,Reject,Reworked;
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
        field(17; "Applies-To- QLE- Entry"; Integer)
        {
            TableRelation = "Quality Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(18; "Accepted Under Dev. Reason"; Code[150])
        {
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(19; "Reason Description"; Text[150])
        {
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
            Editable = true;
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
        field(37; "Rework Reference No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
        field(38; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(39; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(81; "Customer No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(82; "Customer Name"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(83; "Customer Name 2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(84; "Customer Address"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(85; "Customer Address2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(86; "Sales Line No"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(100; "Sample Inspection Line No."; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(101; "Sample Inspection"; Boolean)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(50000; "Operation No."; Code[10])
        {
            Description = 'QCB2B1.2';
            DataClassification = CustomerContent;
        }
        field(50001; "DC Inbound Ledger Entry No."; Integer)
        {
            Description = 'QCB2B1.2';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Order No.", "Order Line No.", "Entry Type", "Sample Inspection")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key3; "Order No.", "Order Line No.", "Source Type", "Entry Type", Open)
        {
            SumIndexFields = "Remaining Quantity";
        }
        key(Key4; "Item No.", "Source Type", "Order No.", "Order Line No.", "Entry Type")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key5; "Entry Type", "Sales Line No", "Order No.")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key6; "Order No.", "Order Line No.", "Sample Inspection Line No.", "Entry Type")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key7; "Item No.", "Source No.", "Document No.", "Item Ledger Entry No.")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key8; "Source No.", "Posting Date")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key9; "Operation No.", "Entry Type", "Order Line No.", "Order No.", "Source Type")
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }
}

