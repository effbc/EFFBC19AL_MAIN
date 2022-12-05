table 50021 "Access Control Temp"
{
    // version UserId

    CaptionML = ENU = 'Access Control',
                ENN = 'Access Control';
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            CaptionML = ENU = 'User Security ID',
                        ENN = 'User Security ID';
            DataClassification = CustomerContent;
        }
        field(2; "Role ID"; Code[20])
        {
            CaptionML = ENU = 'Role ID',
                        ENN = 'Role ID';
            DataClassification = CustomerContent;
        }
        field(3; "Company Name"; Text[30])
        {
            CaptionML = ENU = 'Company Name',
                        ENN = 'Company Name';
            DataClassification = CustomerContent;
        }
        field(5; "User Name"; Code[50])
        {
            CaptionML = ENU = 'User Name',
                        ENN = 'User Name';
            DataClassification = CustomerContent;
        }
        field(7; "Role Name"; Text[30])
        {
            CaptionML = ENU = 'Role Name',
                        ENN = 'Role Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "User Security ID", "Role ID", "Company Name")
        {
        }
        key(Key2; "Role ID")
        {
        }
    }

    fieldgroups
    {
    }
}

