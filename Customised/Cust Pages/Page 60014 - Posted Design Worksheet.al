page 60014 "Posted Design Worksheet"
{
    // version B2B1.0,Rev01

    Editable = false;
    PageType = Document;
    SourceTable = "Design Worksheet Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Production Bom No."; Rec."Production Bom No.")
                {
                    ApplicationArea = All;
                }
                field("Production Bom Version No."; Rec."Production Bom Version No.")
                {
                    ApplicationArea = All;
                }
            }
            part(DesignWorksheetLines; "Posted DesignWorksheet Subform")
            {
                SubPageLink = "Document No." =
FIELD("Document No."), "Document Type" = FIELD("Document Type"), "Document Line No." = FIELD("Document Line No.");
                ApplicationArea = All;
            }
            group(Costings)
            {
                Caption = 'Costings';
                field("Components Cost"; "Components Cost")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; "Manufacturing Cost")
                {
                    ApplicationArea = All;
                }
                field("Resource Cost"; "Resource Cost")
                {
                    ApplicationArea = All;
                }
                field("Development Time in hours"; "Development Time in hours")
                {
                    ApplicationArea = All;
                }
                field("Development Cost per hour"; "Development Cost per hour")
                {
                    ApplicationArea = All;
                }
                field("Development Cost"; "Development Cost")
                {
                    ApplicationArea = All;
                }
                field("Installation Cost"; "Installation Cost")
                {
                    ApplicationArea = All;
                }
                field("Additional Cost"; "Additional Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
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
            group("&Functions")
            {
                Caption = '&Functions';
                action("Copy &Bom Components")
                {
                    Caption = 'Copy &Bom Components';
                    Image = CopyBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyBomComponents;
                    end;
                }
                separator(Action1102152023)
                {
                }
                action("&Summary Sheet")
                {
                    Caption = '&Summary Sheet';
                    Image = Worksheet2;
                    RunObject = Page "Design Worksheet Summary";
                    RunPageLink = "Document No." = FIELD("Document No."), "Document Type" = CONST(Order), "Document Line No." = FIELD("Document Line No.");
                    ApplicationArea = All;
                }
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 67;
                RunPageLink = "Document Type" = FILTER(10), "No." = FIELD("Document No.");
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }

    var
        SalesLine: Record "Sales Line";
        ManufacturingSetup: Record "Manufacturing Setup";
        TenderLine: Record "Tender Line";

    procedure CalculateTotalCost();
    begin
        CALCFIELDS("Manufacturing Cost", "Components Cost", "Resource Cost", "Installation Cost");
        "Total Cost" := "Development Cost" + "Additional Cost" + "Components Cost" + "Manufacturing Cost" + "Resource Cost" +
                            "Installation Cost";
    end;
}

