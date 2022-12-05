tableextension 70088 TransferShipmentHeaderExt extends "Transfer Shipment Header"
{
    fields
    {

        field(60092; "Transport Method1"; Code[20])
        {
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
        field(60003; "Service Item No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Item"."No.";
            DataClassification = CustomerContent;
        }
        field(60004; "Customer No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(60005; "Prod. BOM No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;
        }
        field(60006; "Machine Center No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Machine Center"."No.";
            DataClassification = CustomerContent;
        }
        field(60007; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60008; "Required Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "Operation No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
            begin
            end;
        }
        field(60010; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60011; "Released Date"; Date)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60012; "Released By"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60013; "Sales Order No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                                                        Status = FILTER(Released));
            DataClassification = CustomerContent;
        }
        field(60014; "Service Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60015; "Resource Name"; Text[50])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                IF PAGE.RUNMODAL(5201,Employee) = ACTION::LookupOK THEN
                  "Resource Name" := Employee."First Name";
                */

            end;
        }
        field(60016; "Way Bill No."; Code[30])
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
    keys
    {
        key(Key3; "External Document No.")
        {
        }
    }
}

