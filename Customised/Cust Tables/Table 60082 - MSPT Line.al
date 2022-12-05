table 60082 "MSPT Line"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Line

    DrillDownPageID = "MSPT Line List";
    LookupPageID = "MSPT Line List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "MSPT Header Code"; Code[20])
        {
            TableRelation = "MSPT Header".Code;
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MSPTTestField;
            end;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            Editable = false;
            Enabled = false;
            OptionMembers = Percentage,"Fixed Value";
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[80])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MSPTTestField;
            end;
        }
        field(6; Percentage; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*MSPTHeader.SETRANGE(Code,"MSPT Header Code");
                IF MSPTHeader.FIND('-') THEN BEGIN
                  MSPTHeader.VALIDATE(MSPTHeader.Type);
                  MSPTHeader.TESTFIELD(MSPTHeader.Type,MSPTHeader.Type::Percentage);
                END;
                */
                MSPTTestField;
                if Percentage < 0 then
                    Error(Text001);

            end;
        }
        field(7; Amount; Decimal)
        {
            Enabled = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*MSPTHeader.SETRANGE(Code,"MSPT Header Code");
                IF MSPTHeader.FIND('-') THEN BEGIN
                  MSPTHeader.VALIDATE(MSPTHeader.Type);
                  MSPTHeader.TESTFIELD(MSPTHeader.Type,MSPTHeader.Type::"Fixed Value");
                END;
                */

            end;
        }
        field(8; "Calculation Period"; DateFormula)
        {
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MSPTTestField;
            end;
        }
        field(9; Remarks; Text[80])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                MSPTTestField;
            end;
        }
    }

    keys
    {
        key(Key1; "Code", "MSPT Header Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        MSPTTestField;
    end;

    trigger OnInsert();
    begin
        MSPTTestField;
    end;

    trigger OnModify();
    begin
        MSPTTestField;
    end;

    trigger OnRename();
    begin
        MSPTTestField;
    end;

    var
        MSPTHeader: Record "MSPT Header";
        TotalPercentage: Decimal;
        MSPTLine: Record "MSPT Line";
        Text001: Label 'Percentage Must Be Positive Value';


    procedure MSPTTestField();
    begin
        MSPTHeader.SetRange(Code, "MSPT Header Code");
        if MSPTHeader.Find('-') then begin
            MSPTHeader.TestField(Status, MSPTHeader.Status::Open);
        end;
    end;
}

