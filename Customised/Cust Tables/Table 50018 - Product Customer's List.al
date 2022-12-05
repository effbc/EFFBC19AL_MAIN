table 50018 "Product Customer's List"
{
    // version B2B1.0

    LookupPageID = "Product Competitors Details";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Product Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = Products;
            DataClassification = CustomerContent;
        }
        field(2; "Customer Code"; Code[20])
        {
            Editable = false;
            NotBlank = true;
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Customer: Record Customer;
            begin
                /*IF Customer.GET("SMTP Port No") THEN BEGIN
                  "E-Mail From" := Customer.Name;
                   Address := Customer.Address;
                END;
                */

            end;
        }
        field(3; "Customer Name"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Address; Text[70])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Installed Year"; Text[10])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Product Code", "Customer Code")
        {
        }
    }

    fieldgroups
    {
    }
}

