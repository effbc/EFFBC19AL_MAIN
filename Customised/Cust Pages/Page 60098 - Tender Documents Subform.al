page 60098 "Tender Documents Subform"
{
    // version B2B1.0

    AutoSplitKey = true;
    Editable = false;
    PageType = List;
    SourceTable = "Tender Documents";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Payment/Receipt/Adjusted Date"; Rec."Payment/Receipt/Adjusted Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Received / Adjusted"; Rec."Received / Adjusted")
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

