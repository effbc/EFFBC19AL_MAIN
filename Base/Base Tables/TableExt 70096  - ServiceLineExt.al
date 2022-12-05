tableextension 70096 ServiceLineExt extends "Service Line"
{
    fields
    {
        field(60092; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60093; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50054; "Product Group Code Cust"; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";
        }


        modify("Fault Area Code")
        {
            trigger OnAfterValidate()
            begin
                if "Fault Area Code" = '' then
                    "Fault Area Description" := ''
                else begin
                    FaultArea.Get("Fault Area Code");
                    "Fault Area Description" := FaultArea.Description;
                end;
            end;
        }
        modify("Symptom Code")
        {
            trigger OnAfterValidate()
            begin
                if "Symptom Code" = '' then
                    "Symptom Description" := ''
                else begin
                    Symptom.Get("Symptom Code");
                    "Symptom Description" := Symptom.Description;
                end;
            end;
        }
        modify("Fault Code")
        {
            trigger OnBeforeValidate()
            begin
                if "Fault Code" = '' then
                    "Fault Code Description" := ''
                else begin
                    FaultCode.Reset;
                    FaultCode.SetFilter(FaultCode.Code, "Fault Code");
                    if FaultCode.FindFirst then
                        "Fault Code Description" := FaultCode.Description;
                end;
            end;
        }
        modify("Resolution Code")
        {
            trigger OnBeforeValidate()
            begin
                if "Resolution Code" = '' then
                    "Resolution Description" := ''
                else begin
                    ResolutionCode.Get("Resolution Code");
                    "Resolution Description" := ResolutionCode.Description;
                end;
            end;
        }
        modify("Fault Reason Code")
        {
            trigger OnAfterValidate()
            begin
                if "Fault Reason Code" = '' then
                    "Fault Reason Description" := ''
                else begin
                    FaultReasonCode.Get("Fault Reason Code");
                    "Fault Reason Description" := FaultReasonCode.Description;
                end;
            end;
        }

        field(60003; "Resolution Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60004; "Fault Code Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60005; "Fault Area Description"; Text[30])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60006; "Symptom Description"; Text[80])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60009; "To Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'));
            DataClassification = CustomerContent;
        }
        field(60011; "From Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'));
            DataClassification = CustomerContent;
        }
        field(60012; Account; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Sent date time" := CurrentDateTime;
            end;
        }
        field(60013; "WK.ST.Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60014; "WK.FH.Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60015; Levels; Enum Levels)
        {
            DataClassification = CustomerContent;

        }
        field(60016; Status; Code[10])
        {
            TableRelation = "Repair Status".Code;
            DataClassification = CustomerContent;
        }
        field(60017; "Sub Service Item No."; Code[30])
        {
            TableRelation = "Service Item"."No." WHERE("Customer No." = FIELD("Customer No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ServItem.SetRange(ServItem."No.", "Sub Service Item No.");
                if ServItem.Find('-') then
                    // "Sub Service Item Serial No.":=ServItem."Serial No.";
                    "No." := ServItem."Item No.";
                //Unitcost:=Item."Avg Unit Cost";
                Description := ServItem.Description;
                "Unit of Measure Code" := ServItem."Unit of Measure Code";
            end;
        }
        field(60018; "Service item Lot No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60019; Zone; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60020; Division; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60021; Station; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60022; "Sent date time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60023; Unitcost; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "Sub Service item serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60025; Observations; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60026; "Component Legending"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60027; "Fault Reason Description"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(60028; "Sub Module Code"; Code[20])
        {
            TableRelation = "Troubleshooting Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Sub Module Code" = '' then
                    "Sub Module Descrption" := ''
                else begin
                    TSH.Get("Sub Module Code");
                    "Sub Module Descrption" := TSH.Description;
                end;
            end;
        }
        field(60029; "Sub Module Descrption"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60030; "Material Issue No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60031; "Material Issue Line No"; Integer)
        {
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
    }
    var
        FaultArea: Record "Fault Area";
        FaultCode: Record "Fault Code";
        ResolutionCode: Record "Resolution Code";
        Symptom: Record "Symptom Code";
        TSH: Record "Troubleshooting Header";
        ServItem2: Record "Service Item";
        ServItem: Record "Service Item";
        FaultReasonCode: Record "Fault Reason Code";
}

