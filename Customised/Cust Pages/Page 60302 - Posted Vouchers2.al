page 60302 "Posted Vouchers2"
{
    // version NAVIN3.70.00.03

    Editable = false;
    PageType = List;
    SourceTable = "G/L Entry";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1280000)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("System Date"; Rec."System Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("customer Ord No"; Rec."customer Ord No")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
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
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ApplicationArea = All;
                }
                action("G/L Dimension Overview")
                {
                    Caption = 'G/L Dimension Overview';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        GLEntriesDimOverview: Page "G/L Entries Dimension Overview";
                    begin
                        IF RunOnTempRec THEN BEGIN
                            GLEntriesDimOverview.SetTempGLEntry(TempGLEntry);
                            GLEntriesDimOverview.RUN;
                        END ELSE
                            PAGE.RUN(PAGE::"G/L Entries Dimension Overview", Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    "G/LEntry": Record "G/L Entry";
                begin
                    /*
                    "G/LEntry".SETRANGE("Document No.","Document No.");
                    "G/LEntry".SETRANGE("Posting Date","Posting Date");
                    "G/LEntry".SETRANGE("Document Type","Document Type");
                    IF "G/LEntry".FINDFIRST THEN
                      REPORT.RUNMODAL(13772,TRUE,TRUE,"G/LEntry");
                    */
                    "G/LEntry".SETRANGE("Document No.", Rec."Document No.");
                    "G/LEntry".SETRANGE("Posting Date", Rec."Posting Date");
                    "G/LEntry".SETRANGE("Document Type", Rec."Document Type");
                    "G/LEntry".SETRANGE("Payment Type", Rec."Payment Type");
                    IF "G/LEntry".FINDFIRST THEN
                        REPORT.RUNMODAL(60002, TRUE, TRUE, "G/LEntry");

                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
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

    trigger OnInit();
    begin
        Rec.RESET
    end;

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Posting Date", (DMY2Date(04, 01, 08)), (DMY2Date(03, 31, 2035)));      //srinivas
    end;

    var
        GLAcc: Record "G/L Account";
        TempGLEntry: Record "G/L Entry" temporary;
        AnalysisViewEntry: Record "Analysis View Entry";
        RunOnTempRec: Boolean;
        //ReportPrint: Codeunit "Test Report-Print";
        Navigate: Page Navigate;


    procedure SetAnalysisViewEntry(var NewAnalysisViewEntry: Record "Analysis View Entry");
    var
        AnalysisViewEntryToGLEntries: Codeunit AnalysisViewEntryToGLEntries;
    begin
        AnalysisViewEntry := NewAnalysisViewEntry;
        RunOnTempRec := TRUE;
        AnalysisViewEntryToGLEntries.GetGLEntries(AnalysisViewEntry, TempGLEntry);
    end;


    local procedure GetCaption(): Text[250];
    begin
        IF GLAcc."No." <> Rec."G/L Account No." THEN
            IF NOT GLAcc.GET(Rec."G/L Account No.") THEN
                IF Rec.GETFILTER("G/L Account No.") <> '' THEN
                    IF GLAcc.GET(Rec.GETRANGEMIN("G/L Account No.")) THEN;
        EXIT(STRSUBSTNO('%1 %2', GLAcc."No.", GLAcc.Name))
    end;
}

