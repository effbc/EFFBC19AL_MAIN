table 60009 "Archived DesignWorksheet"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Editable = false;
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            Editable = false;
            OptionCaption = '" ,Tender,Quote,Order,Blanket Order"';
            OptionMembers = " ",Tender,Quote,"Order","Blanket Order";
            DataClassification = CustomerContent;
        }
        field(3; "Document Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; "Item No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Components Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Line".Amount WHERE(Type = CONST(Item),
                                                                    "Document No." = FIELD("Document No."),
                                                                    "Document Type" = FIELD("Document Type"),
                                                                    "Document Line No." = FIELD("Document Line No.")));
            Description = 'Editable=No';
            FieldClass = FlowField;
        }
        field(9; "Manufacturing Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Line"."Manufacturing Cost" WHERE("Document No." = FIELD("Document No."),
                                                                                  "Document Type" = FIELD("Document Type"),
                                                                                  "Document Line No." = FIELD("Document Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Soldering Time for SMD"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Soldering time for DIP"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Total time in Hours"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Soldering Cost Perhour"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Resource Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                    "Document Type" = FIELD("Document Type"),
                                                                    "Document Line No." = FIELD("Document Line No."),
                                                                    Type = CONST("Production BOM")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Development Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Development Time in hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Development cost per hour"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Installation Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Line".Amount WHERE(Type = CONST(Resource),
                                                                    "Document No." = FIELD("Document No."),
                                                                    "Document Type" = FIELD("Document Type")));
            Description = 'Editable=No';
            FieldClass = FlowField;
        }
        field(21; "Additional Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Total Cost (From Line)"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Line".Amount WHERE("Document No." = FIELD("Document No."),
                                                                    "Document Type" = FIELD("Document Type"),
                                                                    "Document Line No." = FIELD("Document Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Production Bom No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(24; "Production Bom Version No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(100; "Total Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(201; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(202; "No. of Archived Versions"; Integer)
        {
            Caption = 'No. of Archived Versions';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(203; "Main Item Manu Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(204; "Total Manu Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(205; "Archived By."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(206; "Date of Archive"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(207; "Time of Archive"; Time)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Version No.", "Document Type", "Document Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

