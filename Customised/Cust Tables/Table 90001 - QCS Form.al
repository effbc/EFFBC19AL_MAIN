table 90001 "QCS Form"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "RFQ No."; Code[20])
        {
            TableRelation = "Alternate Items";
            DataClassification = CustomerContent;
        }
        field(2; "RFQ Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Vendor Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "PD Comment"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; Desicription; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; Rate; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Total Basic Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "P & F"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Excise Duty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Sales Tax"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; Freight; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; Insurance; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; Discount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Payment Terms"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Delivery Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; VAT; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(100; "Accept Action Message"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "RFQ No.")
        {
        }
    }

    fieldgroups
    {
    }
}

