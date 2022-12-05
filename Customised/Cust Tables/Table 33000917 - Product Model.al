table 33000917 "Product Model"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Product; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Model; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "CS IGC"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Module; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Sub-Module"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Module1; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Sub-Module1"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Item Number"; Code[50])
        {
            Description = 'added by Vishnu for analysis purpose on 01-11-2019';
            DataClassification = CustomerContent;
        }
        field(9; Active; Boolean)
        {
            Description = 'added by Vishnu for analysis purpose on 01-11-2019';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Product, Model, "CS IGC", Module, "Sub-Module", "Item Number")
        {
        }
    }

    fieldgroups
    {
    }
}

