page 60029 "Service List Archive"
{
    // version B2B1.0

    PageType = List;
    SourceTable = "Service Header Archive";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = All;
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ApplicationArea = All;
                }
                field("Archived by"; Rec."Archived by")
                {
                    ApplicationArea = All;
                }
                field("Interaction Exist"; Rec."Interaction Exist")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Service Order Type"; Rec."Service Order Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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

