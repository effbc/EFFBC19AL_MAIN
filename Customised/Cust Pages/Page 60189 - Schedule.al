page 60189 Schedule
{
    // version SH1.0

    AutoSplitKey = true;
    DelayedInsert = true;
    Editable = false;
    PageType = List;
    SourceTable = Schedule2;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("M/S Item"; Rec."M/S Item")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Qty. Per"; Rec."Qty. Per")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. Shipped"; Rec."Qty. Shipped")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty."; Rec."Outstanding Qty.")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Cost"; Rec."Estimated Total Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Estimated Unit Price"; Rec."Estimated Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Estimated Total Unit Price"; Rec."Estimated Total Unit Price")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Calcaulated Amont"; Rec."Calcaulated Amont")
                {
                    ApplicationArea = All;
                }
                field("RDSO Required"; Rec."RDSO Required")
                {
                    ApplicationArea = All;
                }
                field("Insp. Letter Sent"; Rec."Insp. Letter Sent")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("RPO Completion Date"; Rec."RPO Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Tender Schedule"; Rec."Tender Schedule")
                {
                    ApplicationArea = All;
                }
                field("Sales Description"; Rec."Sales Description")
                {
                    ApplicationArea = All;
                }
                field("Design Conclusions1"; Rec."Design Conclusions1")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Dispatched; Rec.Dispatched)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(SetSelection; Rec.SetSelection)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Visible = true;
                action(CopyBomSc)
                {
                    Caption = 'CopyBomSc';
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyScheduleItems;
                    end;
                }
                action(Test)
                {
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        MESSAGE('Hi');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnClosePage();
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Tender);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Document Line No.");
        IF Schedule.FINDSET THEN
            REPEAT
                TotAmt += Schedule."Calcaulated Amont";
            UNTIL Schedule.NEXT = 0;
        TenderLine.RESET;
        TenderLine.SETRANGE("Document No.", Rec."Document No.");
        TenderLine.SETRANGE("Line No.", Rec."Document Line No.");
        IF TenderLine.FINDFIRST THEN BEGIN
            TenderLine."Total Amount" := TotAmt;
            TenderLine.MODIFY;
        END;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        //Quantity := 0;
        Rec.SETCURRENTKEY("M/S Item");
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        //RESET;
        Rec.SETCURRENTKEY("M/S Item");
    end;

    var
        TenderLine: Record "Tender Line";
        TotAmt: Decimal;
        Schedule: Record Schedule2;


    procedure CopyScheduleItems();
    var
        Schedule: Record Schedule2;
        Schedule2: Record Schedule2;
        Schedule3: Record Schedule2;
        ProdBOMLine: Record "Production BOM Line";
        Item: Record Item;
    begin
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order);
        Schedule.SETRANGE("Document No.", Rec."Document No.");
        Schedule.SETRANGE("Document Line No.", Rec."Document Line No.");
        Schedule.SETRANGE(Type, Schedule.Type::"G/l Account");
        IF Schedule.FINDSET THEN
            REPEAT
                IF Item.GET(Schedule."No.") THEN;
                ProdBOMLine.RESET;
                ProdBOMLine.SETRANGE("Production BOM No.", Item."Production BOM No.");
                ProdBOMLine.SETRANGE(ProdBOMLine.Type, ProdBOMLine.Type::Item);
                IF ProdBOMLine.FINDSET THEN
                    REPEAT
                        IF Item.GET(ProdBOMLine."No.") THEN BEGIN//(AND Item."User ID"
                            Schedule2.RESET;
                            Schedule2.SETRANGE("Document Type", Schedule2."Document Type"::Order);
                            Schedule2.SETRANGE("Document No.", Rec."Document No.");
                            Schedule2.SETRANGE("Document Line No.", Rec."Document Line No.");
                            IF Schedule2.FINDLAST THEN BEGIN
                                Schedule3.INIT;
                                Schedule3."Document Type" := Schedule3."Document Type"::Order;
                                Schedule3."Document No." := Rec."Document No.";
                                Schedule3."Document Line No." := Rec."Document Line No.";
                                Schedule3."Line No." := Schedule2."Line No." + 10000;
                                Schedule3.Type := Schedule3.Type::"G/l Account";
                                Schedule3.VALIDATE("No.", Item."No.");
                                Schedule3.INSERT;
                            END;
                        END;
                    UNTIL ProdBOMLine.NEXT = 0;
            UNTIL Schedule.NEXT = 0;
    end;


    local procedure OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        Rec.SETCURRENTKEY("M/S Item");
    end;
}

