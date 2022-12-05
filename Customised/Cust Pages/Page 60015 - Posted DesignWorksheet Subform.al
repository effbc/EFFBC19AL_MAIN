page 60015 "Posted DesignWorksheet Subform"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Design Worksheet Line";

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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("No.of SMD Points"; Rec."No.of SMD Points")
                {
                    ApplicationArea = All;
                }
                field("No.of DIP Points"; Rec."No.of DIP Points")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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

