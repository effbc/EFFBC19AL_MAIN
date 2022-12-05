page 60072 "Sample Lot Inspection"
{
    // version B2B1.0,Rev01

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Sample Lot Inspection";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Line No."; Rec."Purchase Line No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Sample Qty."; Rec."Sample Qty.")
                {
                    ApplicationArea = All;
                }
                field("Accepted Qty."; Rec."Accepted Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rejected Qty."; Rec."Rejected Qty.")
                {
                    ApplicationArea = All;
                }
                field("Rework Qty."; Rec."Rework Qty.")
                {
                    ApplicationArea = All;
                }
                field(Accept; Rec.Accept)
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
                group(Inspection)
                {
                    Caption = 'Inspection';
                    Image = InsertAccount;
                    action("Inspection Data Sheets")
                    {
                        Caption = 'Inspection Data Sheets';
                        Image = WorkSheet;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            InspectDataSheet.SETRANGE("Order No.", Rec."Purchase Order No.");
                            InspectDataSheet.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                            InspectDataSheet.SETRANGE("Sample Inspection Line No.", Rec."Line No.");
                            InspectDataSheet.SETRANGE("Source Type", InspectDataSheet."Source Type"::"In Bound");
                            PAGE.RUN(PAGE::"Inspection Data Sheet List", InspectDataSheet);
                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = PostedTimeSheet;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
                        begin
                            PostInspectDataSheet.SETRANGE("Order No.", Rec."Purchase Order No.");
                            PostInspectDataSheet.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                            PostInspectDataSheet.SETRANGE("Sample Inspection Line No.", Rec."Line No.");
                            PostInspectDataSheet.SETRANGE("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
                            PAGE.RUN(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
                        end;
                    }
                    action("Inspection &Receipts")
                    {
                        Caption = 'Inspection &Receipts';
                        Image = Receipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            InspectionReceipt: Record "Inspection Receipt Header";
                        begin
                            InspectionReceipt.SETRANGE("Order No.", Rec."Purchase Order No.");
                            InspectionReceipt.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                            InspectionReceipt.SETRANGE("Sample Inspection Line No.", Rec."Line No.");
                            InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::"In Bound");
                            InspectionReceipt.SETRANGE(Status, FALSE);
                            PAGE.RUN(PAGE::"Inspection Receipt List", InspectionReceipt);
                        end;
                    }
                    action("Posted I&nspection Receipts")
                    {
                        Caption = 'Posted I&nspection Receipts';
                        Image = PostedReceipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            InspectionReceipt: Record "Inspection Receipt Header";
                        begin
                            InspectionReceipt.SETRANGE("Order No.", Rec."Purchase Order No.");
                            InspectionReceipt.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                            InspectionReceipt.SETRANGE("Sample Inspection Line No.", Rec."Line No.");
                            InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::"In Bound");
                            InspectionReceipt.SETRANGE(Status, TRUE);
                            PAGE.RUN(PAGE::"Inspection Receipt List", InspectionReceipt);
                        end;
                    }
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = NewTimesheet;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        PurchaseLine.SETRANGE("Document No.", Rec."Purchase Order No.");
                        PurchaseLine.SETRANGE("Line No.", Rec."Purchase Line No.");
                        IF PurchaseLine.FINDFIRST THEN
                            PurchaseLine.TESTFIELD(PurchaseLine."Quality Before Receipt");
                        Rec.TESTFIELD("Sample Qty.");
                        //InspectDataSheets.CreateSampleLotIDS(Rec);
                    end;
                }
                separator(Action1102152030)
                {
                }
                action("Accept total Qty.")
                {
                    Caption = 'Accept total Qty.';
                    Image = UntrackedQuantity;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT CONFIRM(Text000, FALSE) THEN
                            EXIT;
                        InspectionDataSheetHeader.SETRANGE("Order No.", Rec."Purchase Order No.");
                        InspectionDataSheetHeader.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                        IF InspectionDataSheetHeader.FINDFIRST THEN
                            ERROR(Text001);

                        InspectionReceiptHeader.SETRANGE("Order No.", Rec."Purchase Order No.");
                        InspectionReceiptHeader.SETRANGE("Purch Line No", Rec."Purchase Line No.");
                        InspectionReceiptHeader.SETFILTER(Status, 'NO');
                        IF InspectionReceiptHeader.FINDFIRST THEN
                            ERROR(Text001);

                        Rec.TESTFIELD("Accepted Qty.");
                        Rec.Accept := TRUE;
                        Rec.MODIFY;

                        PurchaseLine.SETRANGE("Document No.", Rec."Purchase Order No.");
                        PurchaseLine.SETRANGE("Line No.", Rec."Purchase Line No.");
                        IF PurchaseLine.FINDFIRST THEN BEGIN
                            PurchaseLine."Quality Before Receipt" := FALSE;
                            //PurchaseLine.VALIDATE("Quality Before Receipt");
                            PurchaseLine.MODIFY;
                        END;
                    end;
                }
            }
        }
    }

    var
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        InspectDataSheet: Record "Inspection Datasheet Header";
        Text000: Label 'Do you want to Accept Total Qty.?';
        PurchaseLine: Record "Purchase Line";
        InspectionDataSheetHeader: Record "Inspection Datasheet Header";
        InspectionReceiptHeader: Record "Inspection Receipt Header";
        Text001: Label 'All the Inspection Data Sheets / Inspection Receipts are not Posted.';
}

