table 50006 "Mat.Issue Entry Summary"
{
    // version MI1.0

    Caption = 'Entry Summary';
    DrillDownPageID = "MaterialIssues Entry Summary";
    LookupPageID = "MaterialIssues Entry Summary";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = CustomerContent;
        }
        field(3; "Summary Type"; Text[80])
        {
            Caption = 'Summary Type';
            DataClassification = CustomerContent;
        }
        field(4; "Total Quantity"; Decimal)
        {
            Caption = 'Total Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5; "Total Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Mat.Issue Track. Specification".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                               "Location Code" = FIELD("Location Code"),
                                                                               "Lot No." = FIELD("Lot No."),
                                                                               "Serial No." = FIELD("Serial No."),
                                                                               "Appl.-to Item Entry" = FIELD("Entry No.")));
            Caption = 'Total Reserved Quantity';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(6; "Total Available Quantity"; Decimal)
        {
            Caption = 'Total Available Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Source Subtype"; Integer)
        {
            Caption = 'Source Subtype';
            DataClassification = CustomerContent;
        }
        field(9; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6504; "Total Requested Quantity"; Decimal)
        {
            Caption = 'Total Requested Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(6505; USERID; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Lot No.", "Serial No.")
        {
        }
        key(Key3; "Expiration Date")
        {
        }
        key(Key4; "Expiration Date", "Item No.", "Location Code", "Posting Date")
        {
        }
        key(Key5; "Item No.", "Location Code", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }
}

