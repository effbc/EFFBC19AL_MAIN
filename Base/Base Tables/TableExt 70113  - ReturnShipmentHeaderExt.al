tableextension 70113 ReturnShipmentHeaderExt extends "Return Shipment Header"
{
    fields
    {

        modify("User ID")
        {
            TableRelation = User."User Name";
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33000250; "Inspect. Receipt No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60093; "Transport Method1"; code[20])
        {
            DataClassification = CustomerContent;
        }
    }

}

