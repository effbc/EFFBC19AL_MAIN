table 14125601 "Quote LookUp Type"
{
    // version B2BQTO

    DrillDownPageID = "Quote LookUp Types";
    LookupPageID = "Quote LookUp Types";
    DataClassification = CustomerContent;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; Name; Code[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "System Defined"; Boolean)
        {
            Caption = 'System Defined';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if "System Defined" then
            Error(Text000);
    end;

    trigger OnModify();
    begin
        if "System Defined" then
            Error(Text000);
    end;

    trigger OnRename();
    begin
        if "System Defined" then
            Error(Text000);
    end;

    var
        Text000: Label 'You cannot modify or delete the system defined records.';
}

