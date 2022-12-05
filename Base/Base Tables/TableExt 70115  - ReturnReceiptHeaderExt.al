tableextension 70115 ReturnReceiptHeaderExt extends "Return Receipt Header"
{
    fields
    {

        modify("User ID")
        {
            TableRelation = User."User Name";
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

}

