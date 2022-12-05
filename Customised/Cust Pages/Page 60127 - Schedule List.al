page 60127 "Schedule List"
{
    PageType = List;
    SourceTable = Schedule2;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("M/S Item"; Rec."M/S Item")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("RDSO Required"; Rec."RDSO Required")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Insp. Letter Sent"; Rec."Insp. Letter Sent")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Tender Schedule"; Rec."Tender Schedule")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sales Description"; Rec."Sales Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Design Conclusions1"; Rec."Design Conclusions1")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field(SetSelection; Rec.SetSelection)
                {
                    ApplicationArea = All;
                }
                field("Source Document Line No."; Rec."Source Document Line No.")
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

    trigger OnOpenPage();
    begin
        Rec.SETCURRENTKEY("M/S Item");
    end;
}

