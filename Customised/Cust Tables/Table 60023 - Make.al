table 60023 Make
{
    LookupPageID = Make;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Make; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Entry Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(4; Blocked; Boolean)
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;
        }
        field(5; "Vendors Link"; Text[250])
        {
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(50001; "Make Origin Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Description = 'Durgamaheswari';
            TableRelation = State.Code;
            trigger OnValidate()
            begin
                IF state.GET("Make Origin Code") THEN BEGIN
                    "Make Origin Name" := state.Description
                END;
            end;
        }
        field(50002; "Make Origin Name"; Text[30])
        {
            DataClassification = CustomerContent;
            Description = 'Durgamaheswari';
        }
    }

    keys
    {
        key(Key1; Make)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Created By" := UserId;
        "Entry Date Time" := CurrentDateTime;
    end;

    var
        state: Record State;
}

