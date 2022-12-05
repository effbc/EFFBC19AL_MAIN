page 60023 "Product Competitors Details"
{
    // version B2B1.0,Rev01

    PageType = Worksheet;
    SourceTable = "Product Competitor's Details";

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
                field("Competitor's Name"; Rec."Competitor's Name")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field(Specifications; Rec.Specifications)
                {
                    ApplicationArea = All;
                }
                field("Position No."; Rec."Position No.")
                {
                    ApplicationArea = All;
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                }
                field("Service Details"; Rec."Service Details")
                {
                    ApplicationArea = All;
                }
                field(Features; Rec.Features)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.Attachments;
                    end;
                }
                separator(Action1102152022)
                {
                }
                action("&Comments")
                {
                    Caption = '&Comments';
                    Image = Comment;
                    RunObject = Page 5072;
                    RunPageLink = "Table Name" = CONST("Product Competitor's Details"), "No." = FIELD(Code), "Line No." = FIELD("Line No.");
                    ApplicationArea = All;
                }
            }
        }
    }
}

