table 60022 Status
{
    // version B2B1.0

    LookupPageID = Status;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Option)
        {
            OptionMembers = Purchase,Sale,Service,Jobs,Budgets;
            DataClassification = CustomerContent;
        }
        field(4; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Status Parameters".Code WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                StatusParameters.SetRange(Code, Code);
                if StatusParameters.Find('-') then begin
                    Description := StatusParameters.Description;
                    "Status Sequence" := StatusParameters."Status Sequence";
                end;
            end;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Status Sequence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Status Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Status Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.", "Document Type", "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Status Date" := WorkDate;
    end;

    var
        StatusParameters: Record "Status Parameters";
}

