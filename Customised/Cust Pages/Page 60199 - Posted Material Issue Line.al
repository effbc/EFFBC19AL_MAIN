page 60199 "Posted Material Issue Line"
{
    // version MI1.0,Rev01

    Editable = false;
    PageType = List;
    SourceTable = "Posted Material Issues Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
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
            group("&Line")
            {
                Caption = '&Line';
                action("Show Document")
                {
                    Caption = 'Show Document';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PostedMaterialIssueHeader: Record "Posted Material Issues Header";
                    begin
                        PostedMaterialIssueHeader.GET(Rec."Document No.");
                        PAGE.RUN(PAGE::"Posted Material Issue", PostedMaterialIssueHeader);
                    end;
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
    }
}

