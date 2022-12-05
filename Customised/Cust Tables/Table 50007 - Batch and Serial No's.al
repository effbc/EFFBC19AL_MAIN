table 50007 "Batch and Serial No's"
{
    DataClassification = CustomerContent;
    // version MI1.0


    fields
    {
        field(1; "Entry Type"; Option)
        {
            OptionMembers = "Material Issues",Transfer,Consumption;
            DataClassification = CustomerContent;
        }
        field(2; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "ItemLedg Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            DataClassification = CustomerContent;
        }
        field(11; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(12; "Mfg. Date"; Date)
        {
            Caption = 'Manufacturing Date';
            DataClassification = CustomerContent;
        }
        field(13; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Assay Equalent Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Assigned Qty."; Decimal)
        {
            CalcFormula = Sum("Mat.Issue Track. Specification".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                               "Lot No." = FIELD("Lot No."),
                                                                               "Location Code" = FIELD("Location Code"),
                                                                               "Appl.-to Item Entry" = FIELD("ItemLedg Entry No.")));
            FieldClass = FlowField;
        }
        field(21; "Prod. Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Prod. Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Prod. Comp. Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry Type", "Entry No.")
        {
        }
        key(Key2; "Expiration Date", "Item No.", "Location Code", "Posting Date")
        {
        }
        key(Key3; "Item No.", "Location Code", "Posting Date")
        {
        }
        key(Key4; "Expiration Date", "Item No.", "Location Code", "Lot No.", "Serial No.")
        {
        }
    }

    fieldgroups
    {
    }
}

