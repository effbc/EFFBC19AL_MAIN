page 60219 "Sale orders-CUS"
{
    Editable = true;
    PageType = List;
    SourceTable = "Sales Invoice-Dummy";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Customer OrderNo."; Rec."Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; Rec."Customer Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

