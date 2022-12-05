tableextension 70129 WhereUsedLineExt extends "Where-Used Line"
{
    fields
    {


        field(60001; Status; Enum Status1)
        {
            CalcFormula = Lookup("Production BOM Header".Status WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(50001; Description1; Text[60])
        {
            DataClassification = CustomerContent;
        }
    }
}

