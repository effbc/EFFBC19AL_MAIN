table 60026 "Mech & Wirning Items"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(2; "Production Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            TableRelation = Item WHERE("Product Group Code Cust" = FILTER(<> 'FPRODUCT' & <> 'CPCB'),
                                        Blocked = CONST(false));
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "BOM Type"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Request No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Production Order No.", "Production Order Line No.", "BOM Type", "Item No.", "Lot No.")
        {
        }
        key(Key2; "Item No.", "Lot No.", "Production Order No.")
        {
        }
    }

    fieldgroups
    {
    }
}

