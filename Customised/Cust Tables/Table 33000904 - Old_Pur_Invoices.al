table 33000904 Old_Pur_Invoices
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Descrption; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Vendor Code"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(6; "Receipt/Invoice"; Option)
        {
            OptionMembers = Old,Receipt,Invoice;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Lot No.")
        {
        }
    }

    fieldgroups
    {
    }
}

