table 33000891 "Product Group Cust"
{
    Caption = 'Product Group';
    LookupPageID = "Product Groups Cust";

    fields
    {
        field(1; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            NotBlank = true;
            TableRelation = "Item Category".Code;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(7300; "Warehouse Class Code"; Code[10])
        {
            Caption = 'Warehouse Class Code';
            TableRelation = "Warehouse Class";
        }
    }

    keys
    {
        key(Key1; "Item Category Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        TESTFIELD("Item Category Code");
        TESTFIELD(Code);
    end;
}

