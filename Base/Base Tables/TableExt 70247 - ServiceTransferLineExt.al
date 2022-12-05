tableextension 70247 ServiceTransferLineExt extends "Service Transfer Line"
{
    fields
    {
        field(60090; "Dimension Corrected"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            Editable = false;
        }
    }

    var
        myInt: Integer;
}