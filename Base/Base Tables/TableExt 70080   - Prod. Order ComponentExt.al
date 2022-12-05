tableextension 70080 ProdOrderComponentExt extends "Prod. Order Component"
{
    fields
    {

        field(50001; "Qty. in Material Issues"; Decimal)
        {
            CalcFormula = Sum("Material Issues Line"."Qty. to Receive" WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                              "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                                              "Prod. Order Comp. Line No." = FIELD("Line No.")));
            Description = 'MI1.0';
            FieldClass = FlowField;
        }
        field(50002; "Qty. in Posted Material Issues"; Decimal)
        {
            CalcFormula = Sum("Posted Material Issues Line".Quantity WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                            "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                                            "Item No." = FIELD("Item No.")));
            Description = 'MI1.0';
            FieldClass = FlowField;
        }
        field(60001; "Position 4"; Code[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Source No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60003; "BOM Type"; Enum BOMType)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60006; "Type of Solder"; Enum TypeofSolder)
        {
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60007; "Production Plan Date"; Date)
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                //B2B1.0 Start
                MESSAGE('HI2');
                IF "Material Required Day" = 0 THEN
                  "Material Requisition Date" := 0D
                ELSE IF "Material Required Day" = 1 THEN
                  "Material Requisition Date" :=  "Production Plan Date"
                ELSE
                  "Material Requisition Date" := CALCDATE(FORMAT("Material Required Day" - 1) +'D',"Production Plan Date");
                  MODIFY;
                //B2B1.0 END
                */

            end;
        }
        field(60008; "Material Required Day"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60009; "Don't Consider"; Boolean)
        {
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
        field(60100; Copy1; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60101; "Qty Copied"; Decimal)
        {
            CalcFormula = Sum("Item Journal Line".Quantity WHERE("ITL Doc No." = FIELD("Prod. Order No."),
                                                                  "ITL Doc Line No." = FIELD("Prod. Order Line No."),
                                                                  "ITL Doc Ref Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
        }
        field(60102; "Qty Posted"; Decimal)
        {
            CalcFormula = Sum("Material Issue Line"."Received Quantity" WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                               "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                                               "Prod. Order Comp. Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
        }
        field(60103; "Qty in To"; Decimal)
        {
            CalcFormula = Sum("Transfer Line".Quantity WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                              "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                              "Prod. Order Comp. Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
        }
        field(60104; "Qty Shipped in To"; Decimal)
        {
            CalcFormula = Sum("Transfer Shipment Line".Quantity WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                       "Prod. Order Line No." = FIELD("Prod. Order Line No."),
                                                                       "Prod. Order Comp. Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
        }
        field(60105; "BOM Qty"; Decimal)
        {
            Description = 'B2B    For Getting The Actual Qty of the BOM';
            DataClassification = CustomerContent;
        }
        field(60106; PCB; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60107; "AVG Unit cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60108; "Product Group Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Product Group Code Cust" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(60109; "Type of Solder2"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(60111; "Material Requisition Date"; Date)
        {
            Description = 'B2B1.0';
            DataClassification = CustomerContent;
        }
        field(60112; "Operation No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60113; Dept; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60114; Position1; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60115; "Position 21"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60116; "Position 31"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60117; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key12; "Item No.", "Prod. Order No.", "Prod. Order Line No.", "Line No.", Status)
        {
        }
        key(Key13; "Item No.")
        {
        }
        key(Key14; "Item No.", "Location Code")
        {
        }
        /* key(Key15; "Prod. Order No.", "Item No.", "Material Required Day")
        {
        }
        key(Key16; "Production Plan Date", "Item No.", "Prod. Order No.")
        {
            SumIndexFields = "Expected Quantity";
        } */
    }
}

