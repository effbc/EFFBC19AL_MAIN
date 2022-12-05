tableextension 70128 ProductionBOMVersionExt extends "Production BOM Version"
{
    fields
    {
        field(60001; "Description 2"; Text[30])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Modified User ID"; Code[50])
        {
            Description = 'Pranavi';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
    }
}

