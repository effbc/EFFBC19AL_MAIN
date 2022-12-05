table 60066 "Check List"
{
    // version B2B1.0

    LookupPageID = "Check List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Document  Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Option)
        {
            OptionMembers = Purchase,Sales,Tender,Service;
            DataClassification = CustomerContent;
        }
        field(4; Parameter; Code[20])
        {
            TableRelation = "Checklist Parameters".Parameter WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ChecklistParameters.Get("Document Type", Parameter) then begin
                    Parameter := ChecklistParameters.Parameter;
                    Description := ChecklistParameters.Description;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; Status; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document  Line No.", "Document Type", Parameter)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ChecklistParameters: Record "Checklist Parameters";
}

