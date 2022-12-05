tableextension 70239 "TDS EntryExt" extends "TDS Entry"
{
    fields
    {
        field(50000; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}