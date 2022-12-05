page 33000258 "Inspection Data Sheet Subform"
{
    // version QC1.0

    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SaveValues = true;
    SourceTable = "Inspection Datasheet Line";

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
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sampling Plan Code"; Rec."Sampling Plan Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Rework Reason Code"; Rec."Rework Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bench Mark Time(In Min.)"; Rec."Bench Mark Time(In Min.)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Taken(In Min.)"; Rec."Time Taken(In Min.)")
                {
                    ApplicationArea = All;
                }
                field(Qualitative; Rec.Qualitative)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Normal Value (Num)"; Rec."Normal Value (Num)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Min. Value (Num)"; Rec."Min. Value (Num)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
                {
                    ApplicationArea = All;
                }
                field("Max. Value (Num)"; Rec."Max. Value (Num)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Value (Num)"; Rec."Actual Value (Num)")
                {
                    ApplicationArea = All;
                }
                field("Normal Value (Text)"; Rec."Normal Value (Text)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Min. Value (Text)"; Rec."Min. Value (Text)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Max. Value (Text)"; Rec."Max. Value (Text)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Inspection Persons"; Rec."Inspection Persons")
                {
                    ApplicationArea = All;
                }
                field("Actual  Value (Text)"; Rec."Actual  Value (Text)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Defects)
                {
                    Caption = 'Defects';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #33000257. Unsupported part was commented. Please check it.
                        /*CurrPage.subPage.Page.*/
                        ShowDefects;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        DescriptionIndent := 0;
        CharacterCodeOnFormat;
        DescriptionOnFormat;
    end;

    var
        DefectTracking: Record "Defect Tracking Details";
        InspectionDataSheets: Codeunit "Inspection Data Sheets";
        InspectionDatasheetHeader: Record "Inspection Datasheet Header";
        ProdOrdNo: Code[20];
        [InDataSet]
        "Character CodeEmphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;


    procedure ShowDefects();
    begin
        DefectTracking.SETRANGE("IDS No.", Rec."Document No.");
        DefectTracking.SETRANGE("IDS Line No.", Rec."Line No.");
        PAGE.RUN(60075, DefectTracking);
    end;

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

