page 60016 "Archived Design Worksheet"
{
    // version B2B1.0

    Editable = false;
    PageType = Document;
    SourceTable = "Archived DesignWorksheet";

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
            part(DesignWorksheetLines; "Archived Designsheet Subform")
            {
                SubPageLink = "Document No." = FIELD("Document No."), "Document Type" = FIELD("Document Type"), "Document Line No." = FIELD("Document Line No."), "Version No." = FIELD("Version No.");
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
                field("Development cost per hour"; "Development cost per hour")
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
            group(Version)
            {
                Caption = 'Version';

                field("Main Item Manu Cost"; "Main Item Manu Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Manu Cost"; "Total Manu Cost")
                {
                    ApplicationArea = All;
                }
                field("Archived By."; "Archived By.")
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
        SalesLine: Record "Sales Line";
        ManufacturingSetup: Record "Manufacturing Setup";
        TenderLine: Record "Tender Line";

    procedure CalculateTotalCost();
    begin
    end;
}

