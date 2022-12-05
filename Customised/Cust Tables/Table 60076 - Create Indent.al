table 60076 "Create Indent"
{
    DataClassification = CustomerContent;
    // version POAU


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Indent No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Indent Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Indent Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Indent,Enquiry,Offer,Order,Cancel,Closed';
            OptionMembers = Indent,Enquiry,Offer,"Order",Cancel,Closed;
            DataClassification = CustomerContent;
        }
        field(7; "Accept Action Message"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Release Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Cancel,Closed;
            DataClassification = CustomerContent;
        }
        field(9; "Due Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(11; "ICN No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Indent No.", "Indent Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

