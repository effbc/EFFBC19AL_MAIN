page 60079 "RGP In List"
{
    // version B2B1.0,Cal1.0

    CardPageID = "RGP In";
    PageType = List;
    SourceTable = "RGP In Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("RGP In No."; Rec."RGP In No.")
                {
                    ApplicationArea = All;
                }
                field("RGP In Date"; Rec."RGP In Date")
                {
                    ApplicationArea = All;
                }
                field("RGP In Posting Date"; Rec."RGP In Posting Date")
                {
                    ApplicationArea = All;
                }
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;
                }
                field("RGP Out Date"; Rec."RGP Out Date")
                {
                    ApplicationArea = All;
                }
                field("RGP Out Posting Date"; Rec."RGP Out Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Consignee; Rec.Consignee)
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

