table 60014 "Product Competitor's Details"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Competitor's Master";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ProductCompetitors: Record "Competitor's Master";
            begin
                TestField(Code);
                if ProductCompetitors.Get(Code) then
                    "Competitor's Name" := ProductCompetitors."Competitor's Name";
            end;
        }
        field(2; "Competitor's Name"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; Price; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; Features; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Tender No."; Code[20])
        {
            TableRelation = "Tender Header";
            DataClassification = CustomerContent;
        }
        field(6; "Position No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Service Details"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Product Code"; Code[20])
        {
            TableRelation = Products;
            DataClassification = CustomerContent;
        }
        field(10; Specifications; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Product Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }


    procedure Attachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.Reset;
        Attachment.SetRange("Table ID", DATABASE::"Product Competitor's Details");
        Attachment.SetRange("Document No.", Code);
        Attachment.SetRange("Document Line No.", "Line No.");
        //Attachment.SETRANGE("Document Type","Product Type");

        PAGE.Run(PAGE::"ESPL Attachments", Attachment);
    end;
}

