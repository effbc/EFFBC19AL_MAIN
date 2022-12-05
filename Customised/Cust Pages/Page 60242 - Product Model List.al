page 60242 "Product Model List"
{
    PageType = List;
    SourceTable = "Product Model";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("CS IGC"; Rec."CS IGC")
                {
                    ApplicationArea = All;
                }
                field(Module; Rec.Module)
                {
                    ApplicationArea = All;
                }
                field("Sub-Module"; Rec."Sub-Module")
                {
                    ApplicationArea = All;
                }
                field(Module1; Rec.Module1)
                {
                    ApplicationArea = All;
                }
                field("Sub-Module1"; Rec."Sub-Module1")
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

