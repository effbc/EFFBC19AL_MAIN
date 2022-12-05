table 90003 "Quality Problem"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Purch.Rcpt No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Qty.Accepted"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Qty Rejected"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Purch.Rcpt No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

