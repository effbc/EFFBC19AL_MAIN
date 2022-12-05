page 60254 "Item Wise Min Req at Loc List"
{
    CardPageID = "Item Wise Min. Req. Qty at Loc";
    Editable = false;
    PageType = List;
    SourceTable = "Item Wise Min. Req. Qty at Loc";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Descirption; Rec.Descirption)
                {
                    ApplicationArea = All;
                }
                field("Minimum Stock Quantity"; Rec."Minimum Stock Quantity")
                {
                    ApplicationArea = All;
                }
                field("Location Name"; Rec."Location Name")
                {
                    ApplicationArea = All;
                }
                field("Actual Qty"; Rec."Actual Qty")
                {
                    ApplicationArea = All;
                }
                field("AMC Qty"; Rec."AMC Qty")
                {
                    ApplicationArea = All;
                }
                field("Warranty Qty"; Rec."Warranty Qty")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Type Of Module"; Rec."Type Of Module")
                {
                    ApplicationArea = All;
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Old Stock"; Rec."Old Stock")
                {
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Base Location"; Rec."Base Location")
                {
                    ApplicationArea = All;
                }
                field("Non-Working Cards"; Rec."Non-Working Cards")
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

