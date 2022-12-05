table 60005 "Shortage Management Audit Data"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Week; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Sale Order"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; Customer; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Product; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; Qty; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Order Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Lead Value"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(0));
        }
        field(9; "2 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(10; "4 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(11; "7 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(12; "15 Dyas"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(13; "21 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(14; "25 Dyas"; Text[30])
        {
            Caption = '25 Days';
            DataClassification = CustomerContent;
        }
        field(15; "30 Dyas"; Text[30])
        {
            Caption = '30 Days';
            DataClassification = CustomerContent;
        }
        field(16; "45 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(17; "60 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(18; "90 Days"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Customer Type"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Order Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Customer Requested Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Production Plan"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(23; Sale_Order; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(24; "2 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(25; "4 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(26; "7 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(27; "15 Dyas_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(28; "21 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(29; "25 Dyas_S"; Text[10])
        {
            Caption = '25 Days';
            DataClassification = CustomerContent;
        }
        field(30; "30 Dyas_S"; Text[10])
        {
            Caption = '30 Days';
            DataClassification = CustomerContent;
        }
        field(31; "45 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(32; "60 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(33; "90 Days_S"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(34; "No. Of Units"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35; Prod; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; Config; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Prod Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(38; "Prod Final Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Week, "Sale Order", Product)
        {
        }
    }

    fieldgroups
    {
    }
}

