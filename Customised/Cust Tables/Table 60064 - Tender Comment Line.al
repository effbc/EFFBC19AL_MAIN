table 60064 "Tender Comment Line"
{
    // version B2B1.0

    LookupPageID = "Tender Comment List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; Comment; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }


    procedure SetUpNewLine();
    var
        TenderCommentLine: Record "Tender Comment Line";
    begin
        TenderCommentLine.SetRange("No.", "No.");
        if not TenderCommentLine.Find('-') then
            Date := WorkDate;
    end;
}

