table 60077 "Indent Vendor Items"
{
    DataClassification = CustomerContent;
    // version POAU

    // Project : B2B Pharma
    // Sign    : NSS - N.S.S.V.PRASAD
    // 
    // S.L.No.  Date      Sign  Description
    // ------------------------------------------
    // 1.0      13/12/06  NSS    New Field "Manufacturer Code"(11) is Added


    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Indent No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Indent Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; Check; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(9; "ICN No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; Subcontracting; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Manufacturer Code"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(12; Approved; Boolean)
        {
            Description = 'NSS';
            DataClassification = CustomerContent;
        }
        field(15; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(16; "Lead Time"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(17; Type; Option)
        {
            DataClassification = CustomerContent;
            Description = 'aaded by Vishnu Priya on 09-11-2020';
            OptionCaption = 'Item,Miscellaneous,Description, ,G/L Account,Fixed Asset';
            OptionMembers = Item,Miscellaneous,Description," ","G/L Account","Fixed Asset";
        }
        field(18; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Description = 'aaded by Vishnu Priya on 11-11-2020';
        }
        field(19; "Part Number"; Code[30])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya on 13-11-2020';
        }
    }

    keys
    {
        key(Key1; "Vendor No.", "Item No.", "Indent No.", "Indent Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

