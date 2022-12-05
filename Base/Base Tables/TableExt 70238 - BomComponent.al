tableextension 70238 BOMComponentExt extends "BOM Component"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Variant Code1"; code[30])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}