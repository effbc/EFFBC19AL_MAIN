page 60012 "Design Worksheet List"
{
    // version B2B1.0

    CardPageID = "Design Worksheet";
    PageType = List;
    SourceTable = "Design Worksheet Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
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
                field("Components Cost"; Rec."Components Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Resource Cost"; Rec."Resource Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Development Cost"; Rec."Development Cost")
                {
                    ApplicationArea = All;
                }
                field("Installation Cost"; Rec."Installation Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Additional Cost"; Rec."Additional Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

