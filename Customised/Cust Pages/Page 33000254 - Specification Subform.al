page 33000254 "Specification Subform"
{
    // version QC1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Specification Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field("Character Code"; Rec."Character Code")
                {
                    ApplicationArea = All;
                }
                field("Character Type"; Rec."Character Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Lookup = true;
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    ApplicationArea = All;
                }
                field("Sampling Code"; Rec."Sampling Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Inspection Time(In Min.)"; Rec."Inspection Time(In Min.)")
                {
                    ApplicationArea = All;
                }
                field("Normal Value (Num)"; Rec."Normal Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Min. Value (Num)"; Rec."Min. Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Max. Value (Num)"; Rec."Max. Value (Num)")
                {
                    ApplicationArea = All;
                }
                field(Qualitative; Rec.Qualitative)
                {
                    ApplicationArea = All;
                }
                field("Normal Value (Char)"; Rec."Normal Value (Char)")
                {
                    ApplicationArea = All;
                }
                field("Min. Value (Char)"; Rec."Min. Value (Char)")
                {
                    ApplicationArea = All;
                }
                field("Max. Value (Char)"; Rec."Max. Value (Char)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        DescriptionIndent := 0;
        CharacterCodeOnFormat;
        DescriptionOnFormat;
    end;

    var
        [InDataSet]
        "Character CodeEmphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;


    local procedure CharacterCodeOnFormat();
    begin
        "Character CodeEmphasize" := Rec."Character Type" <> Rec."Character Type"::Standard;
    end;


    local procedure DescriptionOnFormat();
    begin
        DescriptionEmphasize := Rec."Character Type" <> Rec."Character Type"::Standard;
        DescriptionIndent := Rec.Indentation;
    end;
}

