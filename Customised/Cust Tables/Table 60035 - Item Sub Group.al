table 60035 "Item Sub Group"
{
    // version B2B1.0

    LookupPageID = "Item Sub Group";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Product Group Code"; Code[20])
        {
            TableRelation = "Product Group Cust".Code;
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; Product_Avb; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Incharge id"; Code[7])
        {
            Description = 'added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(50002; Vertical; Text[40])
        {
            Description = 'added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(50003; "Product Family"; Text[40])
        {
            Description = 'added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(50004; "RDSO/Not"; Boolean)
        {
            Description = 'added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(50005; "Railwats/Other"; Option)
        {
            Description = 'added by Vishnu Priya';
            OptionMembers = " ",Railways,Private,Other,Both;
            DataClassification = CustomerContent;
        }
        Field(50006; "Cycle Time"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'added by Suvarchala';
        }
    }

    keys
    {
        key(Key1; "Product Group Code", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

