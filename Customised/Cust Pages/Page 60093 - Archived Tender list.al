page 60093 "Archived Tender list"
{
    // version B2B1.0

    CardPageID = "Archived Tender";
    Editable = false;
    PageType = List;
    SourceTable = "Tender Header Archive";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Description"; Rec."Tender Description")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Bid Amount"; Rec."Minimum Bid Amount")
                {
                    ApplicationArea = All;
                }
                field("Customer Tender No."; Rec."Customer Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Dated"; Rec."Tender Dated")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue From"; Rec."Tender doc Issue From")
                {
                    ApplicationArea = All;
                }
                field("Tender doc Issue To"; Rec."Tender doc Issue To")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ApplicationArea = All;
                }
                field("Submission Due Time"; Rec."Submission Due Time")
                {
                    ApplicationArea = All;
                }
                field("Tech. Bid Opening Date"; Rec."Tech. Bid Opening Date")
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

