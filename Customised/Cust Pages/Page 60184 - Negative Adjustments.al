page 60184 "Negative Adjustments"
{
    // version NAVW13.70,NAVIN3.70.00.04,Rev01

    AutoSplitKey = true;
    Caption = 'Negative Adjustments';
    DataCaptionFields = "Journal Batch Name";
    DelayedInsert = true;
    Editable = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Item Journal Line";

    layout
    {
        area(content)
        {
            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';
                Lookup = true;
                ApplicationArea = All;

                trigger OnLookup(Var Text: Text): Boolean;
                begin
                    CurrPage.SAVERECORD;
                    ItemJnlMgt.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);
                end;

                trigger OnValidate();
                begin
                    ItemJnlMgt.CheckName(CurrentJnlBatchName, Rec);
                    CurrentJnlBatchNameOnAfterVali;
                end;
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                        Rec.ShowShortcutDimCode(ShortcutDimCode);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = true;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Amount"; Rec."Unit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Entry"; Rec."Applies-to Entry")
                {
                    ApplicationArea = All;
                }
            }
            group(Control22)
            {
                ShowCaption = false;
                field(ItemDescription; ItemDescription)
                {
                    Caption = 'Item Description';
                    Editable = false;
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
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines(FALSE);
                    end;
                }
                action("Bin Contents")
                {
                    Caption = 'Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Bin Contents List";
                    RunPageLink = "Location Code" = FIELD("Location Code"), "Item No." = FIELD("Item No."), "Variant Code" = FIELD("Variant Code");
                    RunPageView = SORTING("Location Code", "Item No.", "Variant Code");
                    ApplicationArea = All;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Item Card";
                    RunPageLink = "No." = FIELD("Item No.");
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    Image = LedgerEntries;
                    RunObject = Page "Item Ledger Entries";
                    RunPageLink = "Item No." = FIELD("Item No.");
                    RunPageView = SORTING("Item No.");
                    ShortCutKey = 'Ctrl+F5';
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("E&xplode BOM")
                {
                    Caption = 'E&xplode BOM';
                    Image = ExplodeBOM;
                    RunObject = Codeunit "Item Jnl.-Explode BOM";
                    Visible = false;
                    ApplicationArea = All;
                }
                action("&Calculate Whse. Adjustment")
                {
                    Caption = '&Calculate Whse. Adjustment';
                    Ellipsis = true;
                    Image = CalculateWarehouseAdjustment;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CalcWhseAdjmt.SetItemJnlLine(Rec);
                        CalcWhseAdjmt.RUNMODAL;
                        CLEAR(CalcWhseAdjmt);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("Test Report")
                {
                    Caption = 'Test Report';
                    Ellipsis = true;
                    Image = TestReport;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction();
                    begin
                        ReportPrint.PrintItemJnlLine(Rec);
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        /*
                        //B2BKPK
                        NegAdjItemJnlLine.SETRANGE("Journal Template Name","Journal Template Name");
                        NegAdjItemJnlLine.SETRANGE("Journal Batch Name","Journal Batch Name");
                        IF NegAdjItemJnlLine.FINDSET THEN
                          REPEAT
                            IF NegAdjItemJnlLine."Shortcut Dimension 2 Code" = '' THEN
                              ERROR('No inventory in this location');
                              EXIT;
                          UNTIL NegAdjItemJnlLine.NEXT = 0;
                        //B2BKPK
                         */
                        IF (USERID = '08CM002') OR (USERID = 'EFFTRONICS\PHANI') OR (USERID = 'EFFTRONICS\NAYOMI') THEN
                            CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Image = PostPrint;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                        CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ItemJnlLine: Record "Item Journal Line";
                begin
                    ItemJnlLine.COPY(Rec);
                    ItemJnlLine.SETRANGE("Journal Template Name", "Journal Template Name");
                    ItemJnlLine.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    REPORT.RUNMODAL(REPORT::"Inventory Movement", TRUE, TRUE, ItemJnlLine);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ShowShortcutDimCode(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        IF "Entry Type" > "Entry Type"::"Negative Adjmt." THEN
            ERROR(Text000, "Entry Type");
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SetUpNewLine(xRec);
        VALIDATE("Entry Type", "Entry Type"::"Negative Adjmt.");
        CLEAR(ShortcutDimCode);
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        ItemJnlMgt.OpenJnl(CurrentJnlBatchName, Rec);
    end;

    var
        Text000: Label 'You cannot use entry type %1 in this journal.';
        ItemJnlMgt: Codeunit ItemJnlManagement;
        ReportPrint: Codeunit "Test Report-Print";
        CalcWhseAdjmt: Report "Calculate Whse. Adjustment";

        CurrentJnlBatchName: Code[10];
        ItemDescription: Text[50];
        ShortcutDimCode: array[8] of Code[20];
        "---B2B------": Integer;
        NegAdjItemJnlLine: Record "Item Journal Line";
        item: Record Item;


    local procedure CurrentJnlBatchNameOnAfterVali();
    begin
        CurrPage.SAVERECORD;
        ItemJnlMgt.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;


    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        ItemJnlMgt.GetItem("Item No.", ItemDescription);
    end;
}

