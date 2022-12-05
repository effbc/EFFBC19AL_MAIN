page 60001 "TDS Certificate Details"
{
    // version B2B1.0

    Editable = false;
    PageType = List;
    SourceTable = "TDS Certificate Details";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Customer Acc.No."; Rec."Customer Acc.No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("TDS / Work Tax Amount"; Rec."TDS / Work Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("TDS Certificate No."; Rec."TDS Certificate No.")
                {
                    ApplicationArea = All;
                }
                field("Certificate Date"; Rec."Certificate Date")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
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

