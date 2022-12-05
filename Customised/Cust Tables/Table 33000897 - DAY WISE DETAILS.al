table 33000897 "DAY WISE DETAILS"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "POSTING DATE"; Date)
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "STR STOCK VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(3; "R&D STR STOCK VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "CS STR STOCK VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "STR_DAMAGE VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(6; "R&D DAMAGE VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "CS DAMAGE VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "BMU STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "DL STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "EP STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "IPIS STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "PMU STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "PROTOCAL CONVERTER STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "RTU STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "SIGNAL LAMP STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "SSIDL STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "REMAINING STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "DEAD STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; "DAY WISE ISSUES VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(20; "DAY WISE INWARD VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; "DAY WISE ADJUSTMENT VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "PRODUCT WISE ISSUES POSTED"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(23; PLANNED_PROD_UNITS; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "PRD STR STOCK VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "PRD DAMAGE VALUE"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; "LED LAMPS STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(27; "LC GATE STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; "MLRI STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(29; "BI STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; "WTLC STOCK"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "POSTING DATE")
        {
        }
    }

    fieldgroups
    {
    }
}

