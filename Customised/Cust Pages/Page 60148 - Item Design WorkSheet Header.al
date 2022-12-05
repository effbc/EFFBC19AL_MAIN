page 60148 "Item Design WorkSheet Header"
{
    // version DWS1.0,Rev01

    PageType = Document;
    SourceTable = "Item Design Worksheet Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
            }
            part("Item Design Worksheet"; "Item Design Worksheet")
            {
                SubPageLink = "Item No" = FIELD("Item No.");
                ApplicationArea = All;
            }
            group(Costing)
            {
                Caption = 'Costing';
                field("Components Cost"; Rec."Components Cost")
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    ApplicationArea = All;
                }
                field("Resource Cost"; Rec."Resource Cost")
                {
                    ApplicationArea = All;
                }
                field("Development Cost"; Rec."Development Cost")
                {
                    ApplicationArea = All;
                }
                field("Development Time in hours"; Rec."Development Time in hours")
                {
                    ApplicationArea = All;
                }
                field("Development Cost per hour"; Rec."Development Cost per hour")
                {
                    ApplicationArea = All;
                }
                field("Installation Cost"; Rec."Installation Cost")
                {
                    ApplicationArea = All;
                }
                field("Additional Cost"; Rec."Additional Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost (From Line)"; Rec."Total Cost (From Line)")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
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
                action("Copy BOM Components")
                {
                    Caption = 'Copy BOM Components';
                    Image = CopyBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CurrPage."Item Design Worksheet".PAGE.CopyBOmComponentsPage;//EFFUPG1.2
                        //CurrPage."Item Design Worksheet".PAGE.CopyBOmComponents;//EFFUPG1.2
                    end;
                }
                separator(Action1000000034)
                {
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.DesignWorkSheetAttachments;
                    end;
                }
                separator(Action1000000033)
                {
                }
                action("Update Total Cost")
                {
                    Caption = 'Update Total Cost';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CalculateTotalCost;
                    end;
                }
            }
        }
    }


    procedure CalculateTotalCost();
    begin
        VALIDATE("Item No.");
        CALCFIELDS("Manufacturing Cost", "Components Cost", "Resource Cost", "Installation Cost");
        "Total Manu Cost" := "Main Item Manu Cost" + "Manufacturing Cost";
        "Total Cost" := "Development Cost" + "Additional Cost" + "Components Cost" + "Total Manu Cost" + "Resource Cost" +
                            "Installation Cost";
        MODIFY;
    end;
}

