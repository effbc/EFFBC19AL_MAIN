tableextension 70102 ServiceZoneExt extends "Service Zone"
{

    fields
    {
        field(50001; "Project Manager"; Code[50])
        {
            TableRelation = Employee."No.";
            DataClassification = CustomerContent;
        }
    }

}

