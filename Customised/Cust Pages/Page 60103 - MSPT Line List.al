page 60103 "MSPT Line List"
{
    // version MSPT1.0,Rev01

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Line List

    Editable = false;
    PageType = List;
    SourceTable = "MSPT Line";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("MSPT Header Code"; Rec."MSPT Header Code")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
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
        area(navigation)
        {
            group(Line)
            {
                Caption = '&Line';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Mile Stone Payments";
                    RunPageLink = Code = FIELD("MSPT Header Code");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }
}

