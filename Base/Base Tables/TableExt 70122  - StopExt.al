tableextension 70122 StopExt extends Stop
{
    fields
    {
        field(60001; Department; Code[10])
        {
            DataClassification = CustomerContent;
            //TableRelation = Location WHERE("Use As In-Transit" = CONST(false),"Subcontracting Location" = CONST(false));
        }
        field(60002; Code1; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
}

