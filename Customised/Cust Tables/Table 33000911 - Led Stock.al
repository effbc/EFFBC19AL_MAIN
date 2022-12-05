table 33000911 "Led Stock"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            TableRelation = Item."No." WHERE("Product Group Code Cust" = FILTER('FPRODUCT'), "Item Sub Group Code" = FILTER('LED LIGHT'),
                                              Blocked = FILTER(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                item.Reset;
                item.SetFilter(item."No.", "Item No");
                if item.FindFirst then begin
                    Desc := item.Description;
                end
            end;
        }
        field(2; Desc; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Stock at Prod"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Stock at LMD"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        item: Record Item;
}

