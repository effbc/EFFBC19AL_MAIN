table 14125605 "Customer/Contact Data"
{
    // version B2BQTO

    Caption = 'Customer/Contact Data';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Sales Quote No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Customer\Contact"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Phone No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Mail Send"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(6; Name; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; Degisnation; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; Place; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; Zone; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Email Id"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(12; Type; Option)
        {
            OptionCaption = 'Customer,Contact';
            OptionMembers = Customer,Contact;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Sales Quote No.", "Customer\Contact")
        {
        }
    }

    fieldgroups
    {
    }
}

