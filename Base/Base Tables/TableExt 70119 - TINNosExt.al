//table 13701 "T.I.N. Nos."
/*Tableextension 70119 TINNosExt extends "T.I.N. Nos."
{
    // version NAVIN7.00

    CaptionML = ENU = 'T.I.N. Nos.',
                ENN = 'T.I.N. Nos.';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = 13720;
    LookupPageID = 13720;

    fields
    {
        field(1; "Code"; Code[30])
        {
            CaptionML = ENU = 'Code',
                        ENN = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if StrLen(Code) < 11 then
                    Error(Text16500);
            end;
        }
        field(2; Description; Text[30])
        {
            CaptionML = ENU = 'Description',
                        ENN = 'Description';
            DataClassification = CustomerContent;
        }
        field(50000; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50001; Group; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Code1"; code[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Group, "Code", Description, "Effective Date")
        {
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Code", Description)
        {
        }
    }

    var
        Text16500: Label 'T.I.N. No. should not be less then 11 characters.,T.I.N. No. should not be less then 11 characters.';
}*/

