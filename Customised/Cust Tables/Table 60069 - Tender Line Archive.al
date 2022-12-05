table 60069 "Tender Line Archive"
{
    DataClassification = CustomerContent;
    // version B2B1.0,SH1.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            OptionMembers = " ",Item,Resource,"G/L Account";
            DataClassification = CustomerContent;
        }
        field(4; "No."; Code[20])
        {
            Description = 'Look up';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ProductionBOMHeader: Record "Production BOM Header";
                VersionMgt: Codeunit 99000756;
            begin
            end;
        }
        field(5; Description; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(6; UOM; Code[10])
        {
            Description = 'Look up';
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Design Cost"; Decimal)
        {
            Description = 'Flow fields';
            DataClassification = CustomerContent;
        }
        field(10; "CRM Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Estimated Unit Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Header"."Total Cost" WHERE("Document No." = FIELD("Document No."),
                                                                            "Document Type" = CONST(Tender),
                                                                            "Document Line No." = FIELD("Line No.")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Estimated Total Unit Cost"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(23; "Cust. Estimated Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Cust.Estimated Total Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Production Bom No."; Code[20])
        {
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;
        }
        field(26; "Production Bom Version No."; Code[20])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production Bom No."));
            DataClassification = CustomerContent;
        }
        field(201; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(202; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Editable = false;
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(50001; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60112; "Type of Item"; Option)
        {
            OptionMembers = " ","Only Supply","Supply & Inst","Supply & Laying","Only Inst";
            DataClassification = CustomerContent;
        }
        field(60113; "Schedule No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "L1 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60115; "L2 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60116; "L3 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60117; "L4 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60118; "L5 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", "Version No.")
        {
        }
    }

    fieldgroups
    {
    }
}

