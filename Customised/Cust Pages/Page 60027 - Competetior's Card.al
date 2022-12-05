page 60027 "Competetior's Card"
{
    // version B2B1.0,Rev01

    PageType = Card;
    SourceTable = "Competitor's Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Competitor's Name"; Rec."Competitor's Name")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Name 2"; Rec."Competitor's Name 2")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Address"; Rec."Competitor's Address")
                {
                    ApplicationArea = All;
                }
                field("Competitor's Address 2"; Rec."Competitor's Address 2")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    Caption = 'City / Post Code';
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    Caption = 'County Code / Country';
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("Competitor's Contact"; Rec."Competitor's Contact")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                }
                field("Fax No."; Rec."Fax No.")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
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
                        Rec.OpenAttachments;
                    end;
                }
                action("&Comments")
                {
                    Caption = '&Comments';
                    Image = Comment;
                    RunObject = Page 5072;
                    RunPageLink = "Table Name" = CONST("Competitor's Master"), "No." = FIELD(Code);
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5072;
                RunPageLink = "Table Name" = CONST(Products), "No." = FIELD(Code);
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }
}

