page 60104 "MSPT Subform"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Subform

    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "MSPT Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Calculation Period"; Rec."Calculation Period")
                {
                    NotBlank = true;
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
    }

    var
        MSPTHeader: Record "MSPT Header";
        TotalPercentage: Decimal;
        TEXT001: Label 'Total percentage should be equal to 100%';
        MSPTLine: Record "MSPT Line";
}

