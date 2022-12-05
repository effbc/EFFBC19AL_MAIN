table 33000902 "QC Rejection Master"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "S.No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Rejection Category"; Option)
        {
            OptionMembers = ,Functional,"Item Wrong","Manufacturer Defect","Physical Damage","Non-Preferable Item","Quality Problem";
            DataClassification = CustomerContent;
        }
        field(3; "Rejection Reason"; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "S.No")
        {
        }
    }

    fieldgroups
    {
    }
}

