table 33000280 "Quality Comment Line"
{
    Caption = 'Quality Comment Line';
    DrillDownPageID = "Specificatinn Version";
    LookupPageID = "Specificatinn Version";

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Inspection Data Sheets,Posted Inspection Data Sheets,Inspection Receipt,Specification,Assay,Calibration';
            OptionMembers = "Inspection Data Sheets","Posted Inspection Data Sheets","Inspection Receipt",Specification,Assay,Calibration;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            TableRelation = IF (Type = CONST("Inspection Data Sheets")) "Inspection Datasheet Header"."No." ELSE
            IF (Type = CONST("Posted Inspection Data Sheets")) "Posted Inspect DatasheetHeader"."No." ELSE
            IF (Type = CONST("Inspection Receipt")) "Inspection Receipt Header"."No." ELSE
            IF (Type = CONST(Calibration)) "Calibration Header"."No.";
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

   
    procedure SetUpNewLine()
    var
        QualityCommentLine: Record "Quality Comment Line";
    begin
        QualityCommentLine.SETRANGE(Type, Type);
        QualityCommentLine.SETRANGE("No.", "No.");
        IF NOT QualityCommentLine.FIND('-') THEN
            Date := WORKDATE;
    end;
}

