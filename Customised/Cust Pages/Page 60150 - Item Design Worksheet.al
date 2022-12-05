page 60150 "Item Design Worksheet"
{
    // version DWS1.0

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Item Design Worksheet Line";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
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
                field("No.of SMD Points"; Rec."No.of SMD Points")
                {
                    ApplicationArea = All;
                }
                field("No.of DIP Points"; Rec."No.of DIP Points")
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
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Total time in Hours"; Rec."Total time in Hours")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    procedure CopyBOmComponentsPage();
    begin
        Rec.CopyBomComponents2;
    end;

}

