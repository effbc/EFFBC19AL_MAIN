page 60048 "Except Rcpt. Date Tracking"
{
    // version B2B1.0

    PageType = List;
    SourceTable = "Excepted Rcpt.Date Tracking";
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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field("Excepted Receipt Old Date"; Rec."Excepted Receipt Old Date")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Excepted Receipt New Date"; Rec."Excepted Receipt New Date")
                {
                    ApplicationArea = All;
                }
                field("Modified Date"; Rec."Modified Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        IF (Rec.Reason = '') AND (Rec."Item No." <> '') THEN
            ERROR('Plz Enter the Reason of the Excepted Receipt Date change');
    end;
}

