table 60116 Capacity_Dummy
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Test; Decimal)
        {
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Capacity Ledger Entry No." = FIELD(No)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }
}

