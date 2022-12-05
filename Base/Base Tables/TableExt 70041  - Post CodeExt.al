tableextension 70041 PostCodeExt extends "Post Code"
{
    fields
    {
        field(60010; State; Code[10])
        {
            TableRelation = State.Code WHERE(Code = FIELD(Code));
            DataClassification = CustomerContent;
        }
    }
}

