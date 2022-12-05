table 33000893 Station
{
    LookupPageID = Station;
    Permissions = TableData Station = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Station Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Division code"; Code[10])
        {
            TableRelation = "Employee Statistics Group".Code;
            DataClassification = CustomerContent;
        }
        field(3; "Station Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Station Status"; Option)
        {
            Editable = true;
            OptionMembers = " ",Up,Down;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Updation date time" := CurrentDateTime
            end;
        }
        field(5; "Updation date time"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; Zone; Code[10])
        {
            TableRelation = "Cause of Inactivity".Code;
            DataClassification = CustomerContent;
        }
        field(7; "SMS Mapped Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Cumilative Division1"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Station Code", Zone, "Division code", "Cumilative Division1")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(KEYFIELDA; "Station Name", "Station Code", "Division code", Zone)
        {
        }
    }
}

