page 60236 "Issue Track Document List"
{
    // version TRACK

    CardPageID = "Issue Track Document";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Issue Track Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152001)
            {
                ShowCaption = false;
                field("Issue Id"; Rec."Issue Id")
                {
                    ApplicationArea = All;
                }
                field("Issue Logged By"; Rec."Issue Logged By")
                {
                    ApplicationArea = All;
                }
                field("Issued Logged Date"; Rec."Issued Logged Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Handled By"; Rec."Handled By")
                {
                    Editable = MakeHandleEditable;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Handled Date Time"; Rec."Handled Date Time")
                {
                    Editable = MakeHandleEditable;
                    ApplicationArea = All;
                }
                field("EFF. Attachment"; Rec."EFF. Attachment")
                {
                    ApplicationArea = All;
                }
                field("Reason for Reopen"; Rec."Reason for Reopen")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Project; Rec.Project)
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
            group(Details)
            {
                Caption = 'Details';
                /* action("More Details")
                 {
                     Image = AllLines;
                     Promoted = true;
                     PromotedCategory = New;
                     PromotedIsBig = true;
                     RunObject = Page 96001;
                     RunPageLink = Field1=FIELD(Issue Id)
                     RunPageView = SORTING(Field1, Field2) ORDER(Ascending);
                     ApplicationArea = All;
                 }*/
            }
            action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    attachments.RESET;
                    //attachments.SETRANGE("Table ID", DATABASE::96000);//EFFUPG
                    attachments.SETRANGE("Document No.", FORMAT(Rec."Issue Id"));
                    PAGE.RUN(PAGE::"ESPL Attachments", attachments);
                end;
            }
        }
        area(processing)
        {
            group("Actions")
            {
                Caption = 'Actions';
                action(Release)
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ReleaseIssue;
                    end;
                }
                action(Completed)
                {
                    Image = Completed;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = SetCompletedVisible;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CompleteIssue;
                    end;
                }
                action(Close)
                {
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CloseIssue;
                    end;
                }
                action("Re Open")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ReOpenIssue;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

        IF Rec.IsAdministrator THEN BEGIN
            SetCompletedVisible := TRUE;
            MakeHandleEditable := TRUE;
        END ELSE BEGIN
            SetCompletedVisible := FALSE;
            MakeHandleEditable := FALSE;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        IF Rec.IsAdministrator THEN BEGIN
            SetCompletedVisible := TRUE;
            MakeHandleEditable := TRUE;
        END ELSE BEGIN
            SetCompletedVisible := FALSE;
            MakeHandleEditable := FALSE;
        END;

        IssueTrackHeader.RESET;
        IF IssueTrackHeader.FINDLAST THEN BEGIN
            Rec."Issue Id" := INCSTR(IssueTrackHeader."Issue Id");
        END ELSE
            Rec."Issue Id" := '000001';
    end;

    trigger OnOpenPage();
    begin
        IF Rec.IsAdministrator THEN BEGIN
            SetCompletedVisible := TRUE;
            MakeHandleEditable := TRUE;
        END ELSE BEGIN
            SetCompletedVisible := FALSE;
            MakeHandleEditable := FALSE;
            Rec.FILTERGROUP(2);
            Rec.SETFILTER("Issue Logged By", USERID);
            Rec.FILTERGROUP(0);
        END;
    end;

    var
        [InDataSet]
        SetCompletedVisible: Boolean;
        [InDataSet]
        MakeHandleEditable: Boolean;
        attachments: Record Attachments;
        IssueTrackHeader: Record "Issue Track Header";
        IssueTrackerLine: Record "Issue Tracker Line";
}

