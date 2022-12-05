tableextension 70118 BinTypeExt extends "Bin Type"
{
    fields
    {
        modify(Code)
        {
            TableRelation = "Production BOM Header";
        }
        field(60001; "Item No"; Code[30])
        {
            TableRelation = Item."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ITEM_REC.Get("Item No") then
                    Description := ITEM_REC.Description;
            end;
        }
        field(60002; QTY; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(60003; "Material Required Day"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60004; "Code1"; code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        ITEM_REC: Record Item;
}

