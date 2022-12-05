tableextension 70240 SubOrderComponentListExt extends "Sub Order Component List"
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
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE ("Dimension Set ID"=FIELD("OLD Dim Set ID"));
        }
    }

    var
        myInt: Integer;
}