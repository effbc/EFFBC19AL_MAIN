table 33000900 "Period wise Item Cost"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Month; Code[5])
        {
            DataClassification = CustomerContent;
        }
        field(4; Cost; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", Month)
        {
        }
    }

    fieldgroups
    {
    }
}

