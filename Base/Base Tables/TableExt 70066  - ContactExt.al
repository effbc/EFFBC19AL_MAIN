tableextension 70066 ContactExt extends Contact
{

    fields
    {

        field(60001; "Contact Status"; Code[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Status: Record Status;
            begin
                if xRec."Contact Status" <> "Contact Status" then begin
                    Status.SetRange(Code, xRec."Contact Status");
                    if Status.Find('-') then begin
                        Status."Status Modified Date" := WorkDate;
                        Status.Modify;
                    end;
                end;
            end;
        }
        field(60002; "Initiated By"; Enum Contact)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60003; Territory; Code[10])
        {
            Description = 'B2B';
            TableRelation = Territory;
            DataClassification = CustomerContent;
        }
        field(60004; "Enquiry Type"; Enum Contact2)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60005; "Govt./Private"; Enum Contact3)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60006; "Domestic/Foreign"; Enum Contact4)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60007; "Product Type"; Enum Contact5)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60008; "Product Category Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Product Category Code" = '' then
                    "Product Code" := '';
            end;
        }
        field(60009; "Product Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = Item WHERE("Item Category Code" = FIELD("Product Category Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Item: Record Item;
            begin
            end;
        }
        field(60020; "Make A Quote"; Boolean)
        {
            Description = 'B2BQTO';
            DataClassification = CustomerContent;
        }
        field(60021; "E-Mail1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60022; "Search E-Mail1"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60023; "E-Mail 21"; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

}

