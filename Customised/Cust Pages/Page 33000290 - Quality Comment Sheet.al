page 33000290 "Quality Comment Sheet"
{
    // version QC1.1

    AutoSplitKey = true;
    Caption = 'Quality Comment Sheet';
    DelayedInsert = true;
    MultipleNewLines = true;
    PageType = Worksheet;
    SourceTable = "Quality Comment Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SetUpNewLine;
    end;

    var
        Text000: Label 'untitled';
        Text001: Label 'Fin. Charge Memo';


    procedure Caption(FinChrgCommentLine: Record "Fin. Charge Comment Line"): Text[110];
    begin
        IF FinChrgCommentLine."No." = '' THEN
            EXIT(Text000);
        EXIT(Text001 + ' ' + FinChrgCommentLine."No." + ' ');
    end;
}

