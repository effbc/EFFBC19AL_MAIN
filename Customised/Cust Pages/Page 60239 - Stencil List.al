page 60239 "Stencil List"
{
    CardPageID = "Stencil Card";
    PageType = List;
    SourceTable = Stencil;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Fixed Asset no"; Rec."Fixed Asset no")
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

