page 60193 "Posted Material Issue"
{
    // version MI1.0,Rev01

    Editable = true;
    PageType = Document;
    SourceTable = "Posted Material Issues Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Released Date"; Rec."Released Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Time"; Rec."Released Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;
                }
                field("Issued DateTime"; Rec."Issued DateTime")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Material Issue No."; Rec."Material Issue No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. BOM No."; Rec."Prod. BOM No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Item Description"; Rec."Service Item Description")
                {
                    ApplicationArea = All;
                }
                field("Service Item Serial No."; Rec."Service Item Serial No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Material Picked"; Rec."Material Picked")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Material Picked Date"; Rec."Material Picked Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Auto Post"; Rec."Auto Post")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
            }
            part(MaterialIssueLines; "Posted Material Issue Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group("Issue-from")
            {
                Caption = 'Issue-from';
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Name 2"; Rec."Transfer-from Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address"; Rec."Transfer-from Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Address 2"; Rec."Transfer-from Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Post Code"; Rec."Transfer-from Post Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from City"; Rec."Transfer-from City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from County"; Rec."Transfer-from County")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Contact"; Rec."Transfer-from Contact")
                {
                    ApplicationArea = All;
                }
                field(Stores; Rec.Stores)
                {
                    ApplicationArea = All;
                }
            }
            group("Issue-to")
            {
                Caption = 'Issue-to';
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Name 2"; Rec."Transfer-to Name 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address"; Rec."Transfer-to Address")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Address 2"; Rec."Transfer-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Post Code"; Rec."Transfer-to Post Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to City"; Rec."Transfer-to City")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to County"; Rec."Transfer-to County")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Country Code"; Rec."Transfer-to Country Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Contact"; Rec."Transfer-to Contact")
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
            group("&Receipt")
            {
                Caption = '&Receipt';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5750;
                    RunPageLink = "Document Type" = CONST("Posted Material Issues"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Material Issue Statistics";
                    ShortCutKey = 'F9';
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Navigate;
                end;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                ApplicationArea = All;

                trigger OnAction();
                var
                    PostedMaterialIssuesHeader: Record "Posted Material Issues Header";
                begin
                    PostedMaterialIssuesHeader.SETRANGE("No.", "No.");
                    REPORT.RUN(50053, TRUE, FALSE, PostedMaterialIssuesHeader);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA']) THEN
            CurrPage.EDITABLE := FALSE;
    end;
}

