page 60100 "FDR List"
{
    // version B2B1.0

    CardPageID = "FDR Card";
    Editable = false;
    PageType = List;
    SourceTable = "FDR Master";
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
                field("FDR Document No."; Rec."FDR Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("FDR Value"; Rec."FDR Value")
                {
                    ApplicationArea = All;
                }
                field("FDR Surrended to Bank"; Rec."FDR Surrended to Bank")
                {
                    ApplicationArea = All;
                }
                field("FDR Surrended Date"; Rec."FDR Surrended Date")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field(Extended; Rec.Extended)
                {
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
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

