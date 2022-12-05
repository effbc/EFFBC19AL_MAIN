table 50017 "MAILID LIST"
{

    LinkedObject = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; USERID; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "USER NAME"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; DEPT; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(4; "MAIL ID"; Text[40])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; USERID)
        {
        }
    }

    fieldgroups
    {
    }
}

