table 60037 "RGP Party"
{
    LookupPageID = "RGP Party List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[30])
        {
            Caption = 'Search Name';
        }
        field(4; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
        }
        field(5; Address; Text[30])
        {
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
        }
        field(8; Contact; Text[30])
        {
            Caption = 'Contact';
        }
        field(9; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
        }
        field(10; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

