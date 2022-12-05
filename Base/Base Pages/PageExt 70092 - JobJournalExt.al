pageextension 70092 JobJournalExt extends "Job Journal"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control73)
        {
            ShowCaption = false;
        }
        modify(Control1902114901)
        { 
            ShowCaption = false;
        } */
        addafter("Job Planning Line No.")
        {
            field("Start Date"; Rec."Start Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("End Date"; Rec."End Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(AccName)
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify(CalcRemainingUsage)
        {
            Promoted = true;
        }
        modify(SuggestLinesFromTimeSheets)
        {
            Promoted = true;
        }
        modify("P&ost")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
    }



    var
        "--B2B--": Integer;
        JobJnlLine: Record "Job Journal Line";
        //NoSeriesMgt: Codeunit 396;
        JobJourBatch: Record "Job Journal Batch";
        //ReserveItemJnlLine: Codeunit 99000835;
        //ReservePurchLine: Codeunit "99000834";
        Text19053959: Label 'Job Description';


    procedure CopyJobBudgetLine();
    begin
        /*
        JobJnlLine.INIT;
        JobJnlLine."Journal Template Name" := "Journal Template Name";
        JobJnlLine."Journal Batch Name" := "Journal Batch Name";
        JobJnlLine.VALIDATE("Job No.",JobBudgetLine."Job No.");
        JobJnlLine.SETRANGE("Job No.",JobBudgetLine."Job No.");
        IF NOT JobJnlLine.FINDFIRST THEN
          JobJnlLine."Line No." := 10000
        ELSE BEGIN
          JobJnlLine.FINDLAST;
          JobJnlLine."Line No." += 10000;
        END;
        JobJnlLine."Document No." :="Document No.";
        //JobJnlLine."Phase Code" := "Phase Code";
        JobJnlLine."Posting Date" := WORKDATE;
        JobJnlLine."End Date" := JobBudgetLine."Ending Date";
        JobJnlLine."Start Date" := JobBudgetLine."Starting Date";
        JobJnlLine.Type := JobBudgetLine.Type;
        JobJnlLine."No." :=JobBudgetLine."No.";
        JobJnlLine.VALIDATE("No.");
        JobJnlLine.VALIDATE("Shortcut Dimension 2 Code",JobBudgetLine."Shortcut Dimension 2 Code");
        JobJnlLine.Description := Description;
        JobBudgetLine.CALCFIELDS(Quantity);
        JobJnlLine.VALIDATE(Quantity,JobBudgetLine.Quantity);
        JobJnlLine."Unit Price" := JobBudgetLine."Unit Price";
        JobJnlLine.VALIDATE("Location Code",JobBudgetLine."Location Code");
        JobJnlLine.INSERT;  */// code commented & function Description had changed due to Navision Upgradation

    end;
}

