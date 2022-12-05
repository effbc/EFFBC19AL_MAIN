page 60275 "Customer/Contact Archive  List"
{
    // version B2BQTO

    PageType = List;
    SourceTable = "Customer/Contact Data Archive";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Quote No."; Rec."Sales Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Customer\Contact"; Rec."Customer\Contact")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Email Id"; Rec."Email Id")
                {
                    ApplicationArea = All;
                }
                field("Mail Send"; Rec."Mail Send")
                {
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
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

