page 33000270 "Inpection Receipt Line"
{
    // version C1.0,Rev01

    DelayedInsert = true;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Inspection Receipt Line";

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
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Sampling Plan Code"; Rec."Sampling Plan Code")
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
                field("Max. Value (Num)"; Rec."Max. Value (Num)")
                {
                    Editable = false;
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
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot Size - Min"; Rec."Lot Size - Min")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot Size - Max"; Rec."Lot Size - Max")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Allowable Defects - Max"; Rec."Allowable Defects - Max")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Accepted Qty"; Rec."Accepted Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rejected Qty"; Rec."Rejected Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
                {
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
                field("Inspection Persons"; Rec."Inspection Persons")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
            group("&Receipt")
            {
                Caption = '&Receipt';
                action("&Defects")
                {
                    Caption = '&Defects';
                    Image = PrevErrorMessage;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #33000268. Unsupported part was commented. Please check it.
                        /*CurrPage.InpectionReceiptLine.Page.*/
                        ShowDefectsPage;

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
        [InDataSet]
        "Character CodeEmphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;


    procedure ShowDefectsPage();
    begin
        DefectTracking.SETRANGE("IDS No.", Rec."IDS No.");
        DefectTracking.SETRANGE("IDS Line No.", Rec."IDS Line No.");
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

