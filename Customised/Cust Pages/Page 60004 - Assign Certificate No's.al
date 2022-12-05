page 60004 "Assign Certificate No's"
{
    // version B2B1.0

    PageType = List;
    SourceTable = "TDS Certificate Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Acc.No."; Rec."Customer Acc.No.")
                {
                    ApplicationArea = All;
                }
                field("TDS / Work Tax Amount"; Rec."TDS / Work Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Assign; Rec.Assign)
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

