page 60099 "Tender Ledger Entries"
{
    // version B2B1.0,Rev01

    PageType = List;
    SourceTable = "Tender Ledger Entries";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(SelectionFilter; SelectionFilter)
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    SelectionFilterOnAfterValidate;
                end;
            }
            repeater(Control1102152000)
            {
                Editable = false;
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Mode of Receipt / Payment"; Rec."Mode of Receipt / Payment")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
            field(Control1102152002; '')
            {
                CaptionClass = Text19012325;
                ShowCaption = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SelectionFilter := SelectionFilter::All;
        CurrPage.UPDATE(FALSE);
    end;

    var
        SelectionFilter: Option All,Payment,Receipt,Adjustment,"Write off";
        TendLedgEntry: Record "Tender Ledger Entries";
        Text19012325: Label 'Seclection Filter';
        Navigate: Page Navigate;


    procedure CurrentNo(SelectionFilter: Option All,Payment,Receipt,Adjustment,"Write off");
    begin
        CASE SelectionFilter OF
            SelectionFilter::Payment:
                BEGIN
                    Rec.SETRANGE("Transaction Type", Rec."Transaction Type"::Payment);
                    CurrPage.UPDATE(FALSE);
                END;
            SelectionFilter::Receipt:
                BEGIN
                    Rec.SETRANGE("Transaction Type", Rec."Transaction Type"::Receipt);
                    CurrPage.UPDATE(FALSE);
                END;
            SelectionFilter::Adjustment:
                BEGIN
                    Rec.SETRANGE("Transaction Type", Rec."Transaction Type"::Adjustment);
                    CurrPage.UPDATE(FALSE);
                END;
            SelectionFilter::"Write off":
                BEGIN
                    Rec.SETRANGE("Transaction Type", Rec."Transaction Type"::"Write off");
                    CurrPage.UPDATE(FALSE);
                END;
            SelectionFilter::All:
                BEGIN
                    CurrPage.UPDATE(FALSE);
                END;

        END;
    end;


    local procedure SelectionFilterOnAfterValidate();
    begin
        CurrentNo(SelectionFilter);
    end;
}

