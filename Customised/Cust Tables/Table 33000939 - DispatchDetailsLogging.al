table 33000939 "Dispatch Details Logging"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line  Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Schedule Line Number"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item Number"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Outstanding Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Quantity to Ship"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(10; Make; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Serial No."; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Lot No."; Code[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Packet; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Date; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(15; UOM; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "By Mode"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line  Number", "Schedule Line Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

