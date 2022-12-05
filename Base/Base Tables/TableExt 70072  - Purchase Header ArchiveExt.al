tableextension 70072 PurchaseHeaderArchiveExt extends "Purchase Header Archive"
{
    fields
    {
        field(60001; "Vendor Excise Invoice No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Vend. Excise Inv. Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Cancel / Short Close"; Enum CancelShortClose)
        {
            DataClassification = CustomerContent;

        }
        field(60004; "RFQ No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Create Indents"."Item No.";
            DataClassification = CustomerContent;
        }
        field(60009; "ICN No."; Code[20])
        {
            Description = 'PH1.0';
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
        field(60092; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}

