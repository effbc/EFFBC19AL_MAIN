table 60010 "Archived DesignWorksheet Line"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = '" ,Tender,Quote,Order,Blanket Order"';
            OptionMembers = " ",Tender,Quote,"Order","Blanket Order";
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Item,"Production BOM",JOB,Resource;
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(JOB)) Job
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Production BOM")) "Production BOM Header";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                JobCost: Decimal;
            begin
            end;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "No.of SMD Points"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "No.of DIP Points"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(11; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Total time in Hours"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Manufacturing Cost"; Decimal)
        {
            DecimalPlaces = 2 : 2;
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
    }

    keys
    {
        key(Key1; "Document No.", "Version No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

