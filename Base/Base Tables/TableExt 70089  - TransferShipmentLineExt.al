tableextension 70089 TransferShipmentLineExt extends "Transfer Shipment Line"
{
    fields
    {
        field(60092; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Position Reference No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60003; "Allow Excess Qty."; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Shelf No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Transfer Order Line No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60006; "Type of Material"; Enum TypeofMaterial)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "Reason Code"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60008; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            Description = 'B2B';
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
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
        field(33000250; "Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000252; "Quantity Rejected"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = CONST(Reject)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                TestStatusOpen;
                TESTFIELD(Type,Type :: Item);
                IF "QC Enabled" THEN
                  TESTFIELD("Spec ID");
                IF NOT "QC Enabled" THEN
                  IF "Quality Before Receipt" THEN
                    VALIDATE("Quality Before Receipt",FALSE);
                */

            end;
        }
        field(33000256; "Qty. Sending To Quality"; Decimal)
        {
            Description = 'QC1.0';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000257; "Qty. Sent To Quality"; Decimal)
        {
            Description = 'QC1.0';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000258; "Qty. Sending To Quality(R)"; Decimal)
        {
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key3; "Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.")
        {
            //SumIndexFields = Quantity;
        }
    }


}

