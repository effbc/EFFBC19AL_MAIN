tableextension 70037 JobLedgerEntryExt extends "Job Ledger Entry"
{

    fields
    {


        field(60001; "End Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Start Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
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
        field(60092; "Description1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60093; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

}

