page 60129 "Design Schedule"
{
    PageType = ListPart;
    SourceTable = Schedule2;

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
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Tender Schedule"; Rec."Tender Schedule")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Sales Description"; Rec."Sales Description")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Design Conclusions1"; Rec."Design Conclusions1")
                {
                    ApplicationArea = All;
                }
                field("Design Conclusion2"; Rec."Design Conclusion2")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("RDSO Required"; Rec."RDSO Required")
                {
                    ApplicationArea = All;
                }
                field("Insp. Letter Sent"; Rec."Insp. Letter Sent")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
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

