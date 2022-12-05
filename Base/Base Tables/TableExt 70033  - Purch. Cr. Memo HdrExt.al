tableextension 70033 PurchCrMemoHdrExt extends "Purch. Cr. Memo Hdr."
{


    fields
    {
        field(60000; "Amount to Vendor"; Decimal)
        {

            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Cr. Memo Line"."Amount To Vendor" WHERE("Document No." = FIELD("No.")));
        }
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
        field(60104; "Excise Claimed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Tarrif Heading No"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

}

