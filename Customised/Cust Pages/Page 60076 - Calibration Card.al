page 60076 "Calibration Card"
{
    // version B2B1.0,Rev01

    PageType = Card;
    SourceTable = "Calibration Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Calibration Next Due Date"; Rec."Calibration Next Due Date")
                {
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Usage Type"; Rec."Usage Type")
                {
                    ApplicationArea = All;
                }
                field("Least Count"; Rec."Least Count")
                {
                    ApplicationArea = All;
                }
                field("Current Status"; Rec."Current Status")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Inspection Party"; Rec."Inspection Party")
                {
                    ApplicationArea = All;
                }
                field(Agency; Rec.Agency)
                {
                    ApplicationArea = All;
                }
                field("Purpose of Instrument"; Rec."Purpose of Instrument")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Calibration")
            {
                Caption = '&Calibration';
                action("&List")
                {
                    Caption = '&List';
                    Image = List;
                    RunObject = Page "Calibration List";
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                }
                separator(Action1102152032)
                {
                }
                action("&Comments")
                {
                    Caption = '&Comments';
                    RunObject = Page "Quality Comment Sheet";
                    RunPageLink = Type = CONST(Calibration), "No." = FIELD("No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                separator(Action1102152034)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TenderAttachments;
                    end;
                }
            }
        }
        area(processing)
        {
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Quality Comment Sheet";
                RunPageLink = Type = CONST(Calibration), "No." = FIELD("No.");

                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }
}

