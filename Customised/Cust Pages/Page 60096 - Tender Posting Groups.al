page 60096 "Tender Posting Groups"
{
    // version B2B1.0

    PageType = Worksheet;
    SourceTable = "Tender Posting Groups";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Tender/Quote Expenses A/c"; Rec."Tender/Quote Expenses A/c")
                {
                    ApplicationArea = All;
                }
                field("EMD Recoverable A/c"; Rec."EMD Recoverable A/c")
                {
                    ApplicationArea = All;
                }
                field("Fixed Deposit A/c"; Rec."Fixed Deposit A/c")
                {
                    ApplicationArea = All;
                }
                field("Tender (FDR) Control A/c"; Rec."Tender (FDR) Control A/c")
                {
                    ApplicationArea = All;
                }
                field("General Exp. A/c"; Rec."General Exp. A/c")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit A/c"; Rec."Security Deposit A/c")
                {
                    ApplicationArea = All;
                }
                field("B.G Margin Money A/c"; Rec."B.G Margin Money A/c")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit Payable A/c"; Rec."Security Deposit Payable A/c")
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

