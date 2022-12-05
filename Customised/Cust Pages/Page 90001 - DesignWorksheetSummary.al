page 90001 "Design Worksheet Summary"
{
    AutoSplitKey = true;
    PageType = Card;
    SourceTable = "Design Worksheet Summary";

    layout
    {
        area(content)
        {
            field("Material Direct Cost"; "Material Direct Cost")
            {
                Caption = 'Material Cost';
                ApplicationArea = All;
            }
            field("Labour Direct Cost"; "Labour Direct Cost")
            {
                Caption = 'Labour Cost';
                ApplicationArea = All;
            }
            field("Other Direct Cost"; "Other Direct Cost")
            {
                Caption = 'Other Cost';
                ApplicationArea = All;
            }
            field("Totals Direct Cost"; "Totals Direct Cost")
            {
                ApplicationArea = All;
            }
            field("Material Indirect Cost"; "Material Indirect Cost")
            {
                Caption = 'Material Cost';
                ApplicationArea = All;
            }
            field("Labour Indirect Cost"; "Labour Indirect Cost")
            {
                Caption = 'Labour Cost';
                ApplicationArea = All;
            }
            field("Other Indirect Cost"; "Other Indirect Cost")
            {
                Caption = 'Other Cost';
                ApplicationArea = All;
            }
            field("Total Indirect Cost"; "Total Indirect Cost")
            {
                Caption = 'Total Indirect Cost';
                ApplicationArea = All;
            }
            label(Control1102152028)
            {
                CaptionClass = Text19062819;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            label(Control1102152012)
            {
                CaptionClass = Text19039083;
                ShowCaption = false;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        Text19039083: Label 'InDirect Cost';
        Text19062819: Label 'Profit %';
}

