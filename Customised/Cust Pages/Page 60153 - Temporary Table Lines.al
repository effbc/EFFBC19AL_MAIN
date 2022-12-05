page 60153 "Temporary Table Lines"
{
    PageType = List;
    SourceTable = "Item Op Balance";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(UOM; Rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("New Location"; Rec."New Location")
                {
                    ApplicationArea = All;
                }
                field("New Lot No."; Rec."New Lot No.")
                {
                    ApplicationArea = All;
                }
                field("New Serial No."; Rec."New Serial No.")
                {
                    ApplicationArea = All;
                }
                field(Inserted; Rec.Inserted)
                {
                    ApplicationArea = All;
                }
                field("Error Text"; Rec."Error Text")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {

            action("Generate Item Reclass. Entries")
            {
                Caption = 'Generate Item Reclass. Entries';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    OMSDumping_ItemReclass.ItemReclass;
                end;
            }
        }
    }

    var
        OMSDumping_ItemReclass: Codeunit OMSDumping;
}

