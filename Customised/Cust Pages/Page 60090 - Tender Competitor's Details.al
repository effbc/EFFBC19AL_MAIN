page 60090 "Tender Competitor's Details"
{
    // version B2B1.0

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Tender Competitor's Details";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Competitor's Code"; Rec."Competitor's Code")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Name"; Rec."Competitor's Name")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Technical Details"; Rec."Technical Details")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Schedule A Percentage"; Rec."Schedule A Percentage")
                {
                    ApplicationArea = All;
                }
                field("Schedule B Percentage"; Rec."Schedule B Percentage")
                {
                    ApplicationArea = All;
                }
                field("Schedule C Percentage"; Rec."Schedule C Percentage")
                {
                    ApplicationArea = All;
                }
                field(structure; Rec.structure)
                {
                    ApplicationArea = All;
                }
                field("Other Details"; Rec."Other Details")
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field("BID Status"; Rec."BID Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
        TC: Record "Tender Competitor's Details";
}

