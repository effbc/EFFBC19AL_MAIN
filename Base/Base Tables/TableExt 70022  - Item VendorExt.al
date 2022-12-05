tableextension 70022 ItemVendorExt extends "Item Vendor"
{
    fields
    {
        field(60019; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Sampling Plan Code"; Code[20])
        {
            Description = 'B2B';
            //TableRelation = "Item Variant".Make;
        }
        field(60002; "Total Qty. Supplied"; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line".Quantity WHERE(Type = CONST(Item),
                                                                  "Buy-from Vendor No." = FIELD("Vendor No."),
                                                                  "No." = FIELD("Item No.")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "Qty. Supplied With in DueDate"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; Approved; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //NSS1.0 >> BEGIN
                if Approved = true then
                    "Refernce Number" := true
                else
                    "Refernce Number" := false;
                //NSS1.0 << END
            end;
        }
        field(60005; "Refernce Number"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
        field(60006; "Delivery Rating"; Decimal)
        {
            CalcFormula = Sum("Purch. Rcpt. Line"."Delivery Rating" WHERE("Buy-from Vendor No." = FIELD("Vendor No."),
                                                                           Type = FILTER(Item),
                                                                           "No." = FIELD("Item No.")));
            Description = 'POAU';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60007; "Avg. Delivery Rating"; Decimal)
        {
            Description = 'POAU';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60008; "Avg. Quality Rating"; Decimal)
        {
            Description = 'POAU';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60015; "Quality Rating"; Decimal)
        {
            Description = 'POAU';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60016; Description; Text[30])
        {
            Caption = 'Description';
            TableRelation = Item.Description WHERE("No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(60017; Priority; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Minimum Order Quantity"; Decimal)
        {
            Caption = 'Variant Code';
            DataClassification = CustomerContent;
        }
    }
}



