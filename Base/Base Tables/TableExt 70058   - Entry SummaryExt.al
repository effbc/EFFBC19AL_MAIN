tableextension 70058 EntrySummaryExt extends "Entry Summary"
{

    fields
    {
        field(60001; "Set Selection"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60002; "Item Entry No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "External Dcument.no"; Code[20])
        {
            CalcFormula = Lookup("Quality Item Ledger Entry"."External Document No." WHERE("Lot No." = FIELD("Lot No."),
                                                                                            Quantity = FIELD("Total Quantity")));
            FieldClass = FlowField;
        }
    }
}

