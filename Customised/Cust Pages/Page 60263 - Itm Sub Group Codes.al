page 60263 "Itm Sub Group Codes"
{
    Editable = false;
    PageType = List;
    SourceTable = "Item Sub Group";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

