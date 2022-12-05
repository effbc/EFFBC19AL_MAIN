table 14125604 "Sales Quote Specification"
{
    DataClassification = CustomerContent;
    // version B2BQTO


    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Sales Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Lookup Code"; Code[20])
        {
            Caption = 'Lookup Code';
            DataClassification = CustomerContent;
        }
        field(5; "Lookup Type ID"; Integer)
        {
            Caption = 'Lookup Type ID';
            TableRelation = "Quote LookUp Type".ID;
            DataClassification = CustomerContent;
        }
        field(6; "Lookup Type Name"; Code[50])
        {
            CalcFormula = Lookup("Quote LookUp Type".Name WHERE(ID = FIELD("Lookup Type ID")));
            Caption = 'Lookup Type Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; FieldNo1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; FieldNo2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; FieldNo3; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; FieldNo4; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; FieldNo5; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; FieldNo6; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; Qty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; Rate; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Terms LookUp"; Option)
        {
            OptionCaption = '" ,Others,Financial"';
            OptionMembers = " ",Others,Financial;
            DataClassification = CustomerContent;
        }
        field(21; "Schedule LookUp"; Option)
        {
            OptionCaption = '" ,Supply items,Installation"';
            OptionMembers = " ","Supply items",Installation;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Sales Quote No.")
        {
        }
    }

    fieldgroups
    {
    }
}

