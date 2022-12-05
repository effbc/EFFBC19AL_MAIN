page 60034 "Inst. PreSite Check List"
{
    // version B2B1.0,Rev01

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Inst. PreSite Check List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Pre Site Parameter"; Rec."Pre Site Parameter")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
                action("&Comments")
                {
                    Caption = '&Comments';
                    Image = Comment;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST("IC Partner"), "No." = FIELD("Sales Order No."), "Line No." = FIELD("Line No.");
                    ApplicationArea = All;

                }
                separator(Action1102152003)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Attachments;
                    end;
                }
                separator(Action1102152014)
                {
                }
                action("Copy &Presite")
                {
                    Caption = 'Copy &Presite';
                    Image = CopyItem;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyPresite(Rec);
                    end;
                }
            }
        }
    }
}

