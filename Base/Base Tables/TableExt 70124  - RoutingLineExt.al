tableextension 70124 RoutingLineExt extends "Routing Line"
{
    LookupPageId = "Routing Lines List";
    DrillDownPageId = "Routing Lines List";
    fields
    {
        field(60001; "Operation Description"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "QAS/MPR"; Enum "QAS MPR")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Man Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60004; Day; Enum Day)
        {
            Description = 'Added by sujani on 23-10-19 for Activities start day tracking';
            DataClassification = CustomerContent;

        }
        field(60005; Start_Day; DateFormula)
        {
            Description = 'Added by sujani on 24-10-19 for Activities start day tracking';
            DataClassification = CustomerContent;
        }
        field(60006; "Main Group"; Enum "Main Group")
        {
            Description = 'Added By Vishnu Priya on 01-08-2020 for the benchmarks collection';
            DataClassification = CustomerContent;

        }
        field(60007; "Sub Group"; Enum "Sub Group")
        {
            Description = 'Added By Vishnu Priya on 01-08-2020 for the benchmarks collection';
            DataClassification = CustomerContent;
        }
        field(60008; "Operation Number"; Integer)
        {
            Description = 'Added By Vishnu Priya on 01-08-2020 for the benchmarks collection';
            DataClassification = CustomerContent;
        }
        field(33000250; "Sub Assembly"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Subassembly: Record "Sub Assembly";
            begin
                if "Sub Assembly" = '' then begin
                    "Sub Assembly Unit of Meas.Code" := '';
                    "Spec Id" := '';
                    "QC Enabled" := false;
                    "Qty. Produced" := 0;
                end else begin
                    Subassembly.Get("Sub Assembly");
                    "Sub Assembly Unit of Meas.Code" := Subassembly."Unit Of Measure Code";
                    "Spec Id" := Subassembly."Spec Id";
                    "QC Enabled" := Subassembly."QC Enabled";
                    "Sub Assembly Description" := Subassembly.Description;
                end;
            end;
        }
        field(33000251; "Qty. Produced"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
            end;
        }
        field(33000252; "Sub Assembly Unit of Meas.Code"; Code[10])
        {
            TableRelation = "Sub Assembly Unit of Measure".Code WHERE("Sub Assembly No." = FIELD("Sub Assembly"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
            end;
        }
        field(33000253; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
                if "Spec Id" = '' then
                    "QC Enabled" := false;
            end;
        }
        field(33000254; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Sub Assembly");
                TestField("Spec Id");
            end;
        }
        field(33000255; "Sub Assembly Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    fieldgroups
    {
        /* fieldgroup(DropDown; "Routing No.", "Operation No.", "No.", "Operation Description", Type)
        {
        } */

    }
}

