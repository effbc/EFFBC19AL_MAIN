page 60149 "Item DesignWorkSheet HeadeList"
{
    // version DWS1.0

    Caption = 'Item DesignWorkSheet Header List';
    PageType = List;
    SourceTable = "Item Design Worksheet Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Components Cost"; Rec."Components Cost")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost (From Line)"; Rec."Total Cost (From Line)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

