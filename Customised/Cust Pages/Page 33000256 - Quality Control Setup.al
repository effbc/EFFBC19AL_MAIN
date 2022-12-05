page 33000256 "Quality Control Setup"
{
    // version QC1.1,Cal1.0

    PageType = Card;
    SourceTable = "Quality Control Setup";
    ApplicationArea = all;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Sampling Rounding"; Rec."Sampling Rounding")
                {
                    ApplicationArea = All;
                }
                field("Quality Before Receipt"; Rec."Quality Before Receipt")
                {
                    ApplicationArea = All;
                }
                field("Posted IDS. No. Is IDS No."; Rec."Posted IDS. No. Is IDS No.")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Specification Nos."; Rec."Specification Nos.")
                {
                    ApplicationArea = All;
                }
                field("Sub Assembly Nos."; Rec."Sub Assembly Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Datasheet Nos."; Rec."Inspection Datasheet Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Inspect. Datasheet Nos."; Rec."Posted Inspect. Datasheet Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Receipt Nos."; Rec."Inspection Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Production Batch No."; Rec."Production Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Consignment No."; Rec."Purchase Consignment No.")
                {
                    ApplicationArea = All;
                }
                field("Assay Nos."; Rec."Assay Nos.")
                {
                    ApplicationArea = All;
                }
                field("Equipment No."; Rec."Equipment No.")
                {
                    ApplicationArea = All;
                }
                field("Calibration Procedure No."; Rec."Calibration Procedure No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Vendor Rating")
            {
                Caption = 'Vendor Rating';
                field("Rating Per Accepted Qty."; Rec."Rating Per Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rating Per Accepted UD Qty."; Rec."Rating Per Accepted UD Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rating Per Rework Qty."; Rec."Rating Per Rework Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rating Per Rejected Qty."; Rec."Rating Per Rejected Qty.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var

    begin

        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;
}

