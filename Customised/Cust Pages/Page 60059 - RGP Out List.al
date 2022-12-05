page 60059 "RGP Out List"
{
    // version B2B1.0,Cal1.0

    CardPageID = "Posted RGP Out";
    Editable = false;
    PageType = List;
    SourceTable = "RGP Out Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;
                }
                field("RGP Date"; Rec."RGP Date")
                {
                    ApplicationArea = All;
                }
                field("RGP Posting Date"; Rec."RGP Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Consignee; Rec.Consignee)
                {
                    ApplicationArea = All;
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field("Equipment No"; Rec."Equipment No")
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
                action(Card)
                {
                    Caption = 'Card';
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        PAGE.RUN(PAGE::"Posted RGP Out", Rec);
                    end;
                }
            }
        }
    }
}

