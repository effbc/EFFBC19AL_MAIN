tableextension 70093 CapacityLedgerEntryExt extends "Capacity Ledger Entry"
{
    fields
    {

        modify(Quantity)
        {
            Caption = 'Actual Run Time';
        }


        field(60001; "Operation Description"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Planed Setup Time"; Decimal)
        {
            Caption = 'Planed Setup Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60003; "Planed Run Time"; Decimal)
        {
            Caption = 'Planed Run Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60004; "Planed Wait Time"; Decimal)
        {
            Caption = 'Planed Wait Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60005; "Planed Move Time"; Decimal)
        {
            Caption = 'Planed Move Time';
            DecimalPlaces = 0 : 5;
            Description = 'B2B';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60006; "Internal Rework"; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60007; "QC Rework"; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60008; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(60009; Remarks; Text[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60010; "Reworked User Id"; Code[15])
        {
            TableRelation = "Machine Center";
            DataClassification = CustomerContent;
        }
        field(60011; "Work Center Unit Cost"; Decimal)
        {
            CalcFormula = Lookup("Work Center"."Unit Cost" WHERE("No." = FIELD("Work Center No.")));
            FieldClass = FlowField;
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
        field(33000250; "After Inspection"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key6; "No.", "Work Center No.", "Order No.")
        {
        }
        key(Key7; "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.", "Operation No.", "Last Output Line")
        {
            //SumIndexFields = "Actual Run Time", "Output Quantity";
        }
    }


}

