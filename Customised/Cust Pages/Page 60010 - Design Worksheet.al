page 60010 "Design Worksheet"
{
    // version B2B1.0,Rev01

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(DesignWorksheetLines; "Design Worksheet Subform")
            {
                SubPageLink = "Document No." = FIELD("Document No."), "Document Type" = FIELD("Document Type"), "Document Line No." = FIELD("Document Line No.");
                ApplicationArea = All;
            }
            group(Costing)
            {
                Caption = 'Costing';
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
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Release")
                {
                    Caption = '&Release';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Codeunit "Designwork Sheet";
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReopenWorkSheet: Codeunit "Designwork Sheet";
                    begin
                        ReopenWorkSheet.Reopen(Rec);
                    end;
                }
                separator(Action1102152027)
                {
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        DesignWorkSheetAttachments;
                    end;
                }
                separator(Action1102152030)
                {
                }
                action("Copy &Design Worksheet")
                {
                    Caption = 'Copy &Design Worksheet';
                    Image = CopyWorksheet;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyItemDesignWorkSheet;
                    end;
                }
                separator(Action1102152023)
                {
                }
                action("Update Total Cost")
                {
                    Caption = 'Update Total Cost';
                    Image = Totals;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CalculateTotalCost;
                    end;
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

    trigger OnOpenPage();
    begin
        OnActivateForm;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        CASE "Document Type" OF
            "Document Type"::Order:
                BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Document Line No.");
                    IF SalesLine.FINDFIRST THEN BEGIN
                        SalesLine."Estimated Total Unit Cost" := "Total Cost" * Quantity;
                        SalesLine.MODIFY;
                    END;
                END;
            "Document Type"::Tender:
                BEGIN
                    TenderLine.RESET;
                    TenderLine.SETRANGE("Document No.", "Document No.");
                    TenderLine.SETRANGE("Line No.", "Document Line No.");
                    IF TenderLine.FINDFIRST THEN BEGIN
                        TenderLine."Estimated Total Unit Cost" := "Total Cost" * Quantity;
                        TenderLine.MODIFY;
                    END;
                END;
        END;
        //CalculateTotalCost();
    end;

    var
        SalesLine: Record "Sales Line";
        ManufacturingSetup: Record "Manufacturing Setup";
        TenderLine: Record "Tender Line";


    procedure CalculateTotalCost();
    begin
        VALIDATE("Item No.");
        CALCFIELDS("Manufacturing Cost", "Components Cost", "Resource Cost", "Installation Cost");
        "Total Manu Cost" := "Main Item Manu Cost" + "Manufacturing Cost";
        "Total Cost" := "Development Cost" + "Additional Cost" + "Components Cost" + "Total Manu Cost" + "Resource Cost" +
                            "Installation Cost";
        MODIFY;
    end;


    local procedure OnActivateForm();
    begin
        ManufacturingSetup.GET;
        "Development Cost per hour" := ManufacturingSetup."Development Cost Per Hour";
        CASE "Document Type" OF
            "Document Type"::Order:
                BEGIN
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Document Line No.");
                    IF SalesLine.FINDFIRST THEN BEGIN
                        "Item No." := SalesLine."No.";
                        Description := SalesLine.Description;
                        Quantity := SalesLine.Quantity;
                        "Unit of Measure" := SalesLine."Unit of Measure Code";
                        "Production Bom No." := SalesLine."Production BOM No.";
                        "Production Bom Version No." := SalesLine."Production Bom Version No.";
                    END;
                END;
            "Document Type"::Quote:
                BEGIN
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Quote);
                    SalesLine.SETRANGE("Document No.", "Document No.");
                    SalesLine.SETRANGE("Line No.", "Document Line No.");
                    IF SalesLine.FINDFIRST THEN BEGIN
                        "Item No." := SalesLine."No.";
                        Description := SalesLine.Description;
                        Quantity := SalesLine.Quantity;
                        "Unit of Measure" := SalesLine."Unit of Measure Code";
                        "Production Bom No." := SalesLine."Production BOM No.";
                        "Production Bom Version No." := SalesLine."Production Bom Version No.";
                    END;
                END;
            "Document Type"::Tender:
                BEGIN
                    TenderLine.SETRANGE("Document No.", "Document No.");
                    TenderLine.SETRANGE("Line No.", "Document Line No.");
                    IF TenderLine.FINDFIRST THEN BEGIN
                        "Item No." := TenderLine."No.";
                        Description := TenderLine.Description;
                        Quantity := TenderLine.Quantity;
                        "Unit of Measure" := TenderLine.UOM;
                        "Production Bom No." := TenderLine."Production Bom No.";
                        "Production Bom Version No." := TenderLine."Production Bom Version No.";
                    END;
                END;
        END;
    end;
}

