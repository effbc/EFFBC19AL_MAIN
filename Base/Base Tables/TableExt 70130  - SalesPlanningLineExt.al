tableextension 70130 SalesPlanningLineExt extends "Sales Planning Line"
{
    fields
    {
        field(50000; "Schedule Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50001; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }
}

