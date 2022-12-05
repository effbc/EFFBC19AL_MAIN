page 60216 "PCB Cost Details List"
{
    CardPageID = "PCB Cost Details Card";
    PageType = List;
    SourceTable = "PCB Cost Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102156000)
            {
                ShowCaption = false;
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("PCB Thickness"; Rec."PCB Thickness")
                {
                    ApplicationArea = All;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    ApplicationArea = All;
                }
                field("Min.Quantity"; Rec."Min.Quantity")
                {
                    ApplicationArea = All;
                }
                field("Max.Quantity"; Rec."Max.Quantity")
                {
                    ApplicationArea = All;
                }
                field("Min.Area"; Rec."Min.Area")
                {
                    ApplicationArea = All;
                }
                field("Max.Area"; Rec."Max.Area")
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("PCB TYPE"; Rec."PCB TYPE")
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

