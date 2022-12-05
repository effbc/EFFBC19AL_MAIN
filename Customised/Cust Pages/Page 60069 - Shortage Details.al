page 60069 "Shortage Details"
{
    // version B2B1.0

    Editable = false;
    PageType = List;
    SourceTable = "Item Lot Numbers";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Shortage; Rec.Shortage)
                {
                    ApplicationArea = All;
                }
                field(Authorisation; Rec.Authorisation)
                {
                    ApplicationArea = All;
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Possible Procured Date"; Rec."Possible Procured Date")
                {
                    ApplicationArea = All;
                }
                field("Indent No."; Rec."Indent No.")
                {
                    ApplicationArea = All;
                }
                field("Within Buffer"; Rec."Within Buffer")
                {
                    ApplicationArea = All;
                }
                field("Possible Production Plan Date"; Rec."Possible Production Plan Date")
                {
                    ApplicationArea = All;
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                }
                field(Product; Rec.Product)
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Planned Purchase Date"; Rec."Planned Purchase Date")
                {
                    ApplicationArea = All;
                }
                field("Material Required Date"; Rec."Material Required Date")
                {
                    ApplicationArea = All;
                }
                field("Planned Date"; Rec."Planned Date")
                {
                    ApplicationArea = All;
                }
                field("Material Required Day"; Rec."Material Required Day")
                {
                    ApplicationArea = All;
                }
                field("Alternated Item"; Rec."Alternated Item")
                {
                    ApplicationArea = All;
                }
            }
            field("COUNT"; Rec.COUNT)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }
}

