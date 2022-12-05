tableextension 70024 SalesShipmentLineExt extends "Sales Shipment Line"
{
    // version NAVW19.00.00.51685,NAVIN9.00.00.51685,TFS225680,B2B1.0

    fields
    {
        field(80016; "Description21"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(60001; "Production BOM No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60002; "Production Bom Version No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));
            DataClassification = CustomerContent;
        }
        field(60003; "Estimated Unit Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Header"."Total Cost" WHERE("Document No." = FIELD("Document No."),
                                                                            "Document Type" = CONST(Order),
                                                                            "Document Line No." = FIELD("Line No.")));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60004; "Estimated Total Unit Cost"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "RDSO Unit Charges"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60006; "LD Starting Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "LD Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60008; "RDSO Charges Paid By"; Enum "Sales Shipment Line Enum2")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60009; "RDSO Inspection Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60010; "RDSO Inspection By"; Enum "Sales Shipment Line Enum1")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60011; "RDSO Charges"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }

        field(60012; "Schedule Type"; Enum "Sales Shipment Line Enum3")
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
        field(60110; "Supply Portion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60111; "Retention Portion"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60112; "Type of Item"; Enum "Sales Shipment Line Enum4")
        {
            DataClassification = CustomerContent;

        }
        field(60113; "Schedule No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "Unitcost(LOA)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(95402; "Description 21"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Transport Method1"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95401; "Description 1"; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }




}

