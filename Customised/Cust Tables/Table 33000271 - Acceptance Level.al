table 33000271 "Acceptance Level"
{
    // version QC1.0

    LookupPageID = "Acceptance Levels";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Reason Code"; Code[20])
        {
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(4; "Vendor Rating"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionCaption = 'Accepted,Accepted Under Deviation,Rework,Rejected';
            OptionMembers = Accepted,"Accepted Under Deviation",Rework,Rejected;
            DataClassification = CustomerContent;
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

