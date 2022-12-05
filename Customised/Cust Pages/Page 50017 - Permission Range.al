page 50017 "Permission Range"
{
    PageType = List;
    SourceTable = "Permission Range";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                }
                field(Index; Rec.Index)
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field("Read Permission"; Rec."Read Permission")
                {
                    ApplicationArea = All;
                }
                field("Insert Permission"; Rec."Insert Permission")
                {
                    ApplicationArea = All;
                }
                field("Modify Permission"; Rec."Modify Permission")
                {
                    ApplicationArea = All;
                }
                field("Delete Permission"; Rec."Delete Permission")
                {
                    ApplicationArea = All;
                }
                field("Execute Permission"; Rec."Execute Permission")
                {
                    ApplicationArea = All;
                }
                field("Limited Usage Permission"; Rec."Limited Usage Permission")
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

