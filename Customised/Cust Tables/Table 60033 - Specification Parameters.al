table 60033 "Specification Parameters"
{
    // version B2B1.0,Rev01

    // 2.0      UPGREV                        Code Reviewed and Field User id TableRelation Changed.

    LookupPageID = "Specification Parameters";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60090; "User Id"; Code[50])
        {
            Description = 'b2b,Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

