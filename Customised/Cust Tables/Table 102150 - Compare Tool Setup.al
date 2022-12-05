table 102150 "Compare Tool Setup"
{
    // version W11.20,Rev01

    /*     DrillDownPageID = 102152;
        LookupPageID = 102152; */
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(2; "Open File Command"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "OS Command"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Combined File Name"; Text[50])
        {
            InitValue = '%1\1.TXT';
            DataClassification = CustomerContent;
        }
        field(5; "List File Name"; Text[50])
        {
            InitValue = '%1\2.TXT';
            DataClassification = CustomerContent;
        }
        field(6; "Log File Name"; Text[50])
        {
            InitValue = 'LOG.TXT';
            DataClassification = CustomerContent;
        }
        field(7; "Source Folder"; Text[50])
        {
            InitValue = '%1\SOURCE';
            DataClassification = CustomerContent;
        }
        field(8; "Target Folder"; Text[50])
        {
            InitValue = '%1\TARGET';
            DataClassification = CustomerContent;
        }
        field(10; "Show Only Differences"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Delete Unmodified Files"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Reversed Compare"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; "No. of Matching Lines"; Integer)
        {
            InitValue = 2;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "User ID" <> '' then
            if FileSetup.Get then begin
                FileSetup."User ID" := "User ID";
                Rec := FileSetup;
            end;
    end;

    var
        FileSetup: Record "Compare Tool Setup";


    procedure MakeRecord();
    begin
        if not Get(UserId) then
            if not Get then begin
                Init;
                Insert;
                Commit;
            end;
    end;
}

