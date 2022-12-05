page 60003 "Assign Form No's"
{
    // version B2B1.0

    PageType = List;
    SourceTable = "Form Tracking";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor / Customer No."; Rec."Vendor / Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice Base Amount"; Rec."Invoice Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Tax Base Amount"; Rec."Sales Tax Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Sales Tax Amount"; Rec."Sales Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Assign Form No."; Rec."Assign Form No.")
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

