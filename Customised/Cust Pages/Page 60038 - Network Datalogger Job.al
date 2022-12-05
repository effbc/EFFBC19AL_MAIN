page 60038 "Network Datalogger Job"
{
    // version B2B1.0

    PageType = List;
    SourceTable = "Item Wise Min. Req. Qty at Loc";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Type Of Module"; Rec."Type Of Module")
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Quantity"; Rec."Minimum Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Old Stock"; Rec."Old Stock")
                {
                    ApplicationArea = All;
                }
                field("Actual Qty"; Rec."Actual Qty")
                {
                    ApplicationArea = All;
                }
                field("Warranty Qty"; Rec."Warranty Qty")
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

