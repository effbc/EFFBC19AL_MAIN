table 60032 "QCS Line"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Quote No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Item No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Qty1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Rate1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; Amount1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Total Basic Value1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; Discount1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "P&F1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Excise Duty1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Sales Tax1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Freight1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; Insurence1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Total Amount1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Payment Terms1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Delivery Date1"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; Qty2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; Rate2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; Amount2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Total Basic Value2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; Discount2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; "P&F2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Excise Duty2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Sales Tax2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(29; Freight2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; Insurence2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Total Amount2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Payment Terms2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33; "Delivery Date2"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(41; Qty3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(42; Rate3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(43; Amount3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(44; "Total Basic Value3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(45; Discount3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(46; "P&F3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(47; "Excise Duty3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(48; "Sales Tax3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(49; Freight3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50; Insurence3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Total Amount3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(52; "Payment Terms3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Delivery Date3"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(54; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(55; "RFQ No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(56; VAT1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(57; VAT2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(58; VAT3; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "RFQ No.", "Quote No", "Line No.", "Item No")
        {
        }
    }

    fieldgroups
    {
    }
}

