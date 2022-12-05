table 33000252 "Sampling Plan Header"
{
    // version QC1.1

    LookupPageID = "Sampling Plan List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Standard Reference"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "AQL Percentage"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = New,"Under Development",Certified;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Certified then begin
                    case "Sampling Type" of
                        "Sampling Type"::"Fixed Quantity":
                            TestField("Fixed Quantity");
                        "Sampling Type"::"Percentage Lot":
                            TestField("Lot Percentage");
                        "Sampling Type"::"Variable Quantity":
                            begin
                                SamplingPlanLine.SetRange("Sampling Code", Code);
                                PreviousSampLineSampleSize := 0;
                                if SamplingPlanLine.Find('-') then begin
                                    repeat
                                        if PreviousSampLineSampleSize > SamplingPlanLine."Sampling Size" then
                                            Error('Sample line %1 Sample size is less than the previous sample line', SamplingPlanLine."Line No.");
                                        PreviousSampLineSampleSize := SamplingPlanLine."Sampling Size";
                                    until SamplingPlanLine.Next = 0;
                                end else
                                    Error('No sampling Plan lines exists');
                            end;
                    end;
                end;
            end;
        }
        field(6; "Created Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Last Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Sampling Type"; Option)
        {
            OptionCaption = 'Variable Quantity,Fixed Quantity,Percentage Lot,Complete Lot';
            OptionMembers = "Variable Quantity","Fixed Quantity","Percentage Lot","Complete Lot";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Certified then
                    FieldError(Status);
            end;
        }
        field(9; "Fixed Quantity"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Sampling Type");
                TestField("Sampling Type", "Sampling Type"::"Fixed Quantity");
            end;
        }
        field(10; "Lot Percentage"; Decimal)
        {
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Sampling Type");
                TestField("Sampling Type", "Sampling Type"::"Percentage Lot");
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        SamplingPlanLine.SetRange("Sampling Code", Code);
        SamplingPlanLine.DeleteAll;
    end;

    trigger OnInsert();
    begin
        "Created Date" := Today;
    end;

    trigger OnModify();
    begin
        "Last Modified Date" := Today;
    end;

    var
        SamplingPlanLine: Record "Sampling Plan Line";
        PreviousSampLineSampleSize: Integer;
}

