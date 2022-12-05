report 32000000 "Update Sales/ Schedule Item11"
{
    // No. sign   Description
    // ---------------------------------------------------
    // 1.3 UPG    BOM Replacement process created this object.

    ProcessingOnly = true;
    TransactionType = Update;

    dataset
    {
        dataitem(SalesLine; "Sales Line")
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") WHERE("Document Type" = CONST(Order), Type = CONST(Item));

            trigger OnAfterGetRecord()
            begin
                SalesHeader.GET(SalesLine."Document Type", SalesLine."Document No.");
                IF SalesHeader.Status <> SalesHeader.Status::Open THEN
                    CurrReport.SKIP;

                IF CheckIfMaterialIssueExist("Document No.", "Line No.", 0) THEN
                    CurrReport.SKIP;

                OldItemNo := SalesLine."No.";

                IF OldItemNo = NewItemNo THEN
                    CurrReport.SKIP;

                SalesLine.VALIDATE("No.", NewItemNo);
                SalesLine.MODIFY;

                UpdateProdOrder("Document No.", "Line No.", 0, "No.");
            end;

            trigger OnPreDataItem()
            begin
                IF ScheduleLineNo <> 0 THEN
                    CurrReport.BREAK;

                SalesLine.SETRANGE("Document No.", OrderNo);
                SalesLine.SETRANGE("Line No.", OrderLineNo);
            end;
        }
        dataitem(Schedule2; Schedule2)
        {
            DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.") WHERE(Type = CONST(Item), "Document Type" = CONST(Order));

            trigger OnAfterGetRecord()
            begin
                SalesHeader.GET(Schedule2."Document Type", Schedule2."Document No.");
                IF SalesHeader.Status <> SalesHeader.Status::Open THEN
                    CurrReport.SKIP;

                IF CheckIfMaterialIssueExist("Document No.", "Document Line No.", "Line No.") THEN
                    CurrReport.SKIP;

                OldItemNo := Schedule2."No.";

                IF OldItemNo = NewItemNo THEN
                    CurrReport.SKIP;

                Schedule2.VALIDATE("No.", NewItemNo);
                Schedule2.MODIFY;

                UpdateProdOrder("Document No.", "Document Line No.", "Line No.", "No.");
            end;

            trigger OnPreDataItem()
            begin
                IF ScheduleLineNo = 0 THEN
                    CurrReport.BREAK;

                Schedule2.SETRANGE("Document No.", OrderNo);
                Schedule2.SETRANGE("Document Line No.", OrderLineNo);
                Schedule2.SETRANGE("Line No.", ScheduleLineNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("New Item No."; NewItemNo)
                    {
                        ShowMandatory = true;
                        TableRelation = Item WHERE(Blocked = CONST(false));
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        IF NewItemNo = '' THEN
            ERROR(NewItemNoErr);
    end;

    var
        OrderNo: Code[20];
        OrderLineNo: Integer;
        ScheduleLineNo: Integer;
        NewItemNo: Code[20];
        NewItemNoErr: Label 'Select Item No. to update';
        OldItemNo: Code[20];
        SalesHeader: Record "Sales Header";


    procedure SetValues(OrderNoP: Code[20]; OrderLineNoP: Integer; ScheduleLineNoP: Integer)
    begin
        OrderNo := OrderNoP;
        OrderLineNo := OrderLineNoP;
        ScheduleLineNo := ScheduleLineNoP;
    end;

    local procedure CheckIfMaterialIssueExist(OrderNoP: Code[20]; OrderLineNoP: Integer; ScheduleLineNoP: Integer): Boolean
    var
        ProductionOrder: Record "Production Order";
        MaterialIssuesHeader: Record "Material Issues Header";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE("Sales Order No.", OrderNoP);
        ProductionOrder.SETRANGE("Sales Order Line No.", OrderLineNoP);
        ProductionOrder.SETRANGE("Schedule Line No.", ScheduleLineNoP);
        IF ProductionOrder.FINDSET THEN
            REPEAT
                MaterialIssuesHeader.RESET;
                MaterialIssuesHeader.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                IF MaterialIssuesHeader.FINDFIRST THEN
                    EXIT(TRUE);

                ProdOrderLine.RESET;
                ProdOrderLine.SETRANGE(Status, ProductionOrder.Status);
                ProdOrderLine.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                ProdOrderLine.SETFILTER("Finished Quantity", '<>%1', 0);
                IF ProdOrderLine.FINDFIRST THEN
                    EXIT(TRUE);
            UNTIL ProductionOrder.NEXT = 0;

        EXIT(FALSE);
    end;

    local procedure UpdateProdOrder(OrderNoP: Code[20]; OrderLineNoP: Integer; ScheduleLineNoP: Integer; NewItemNoP: Code[20])
    var
        ProductionOrder: Record "Production Order";
        RefreshProdOrder: Report "Refresh Production Order";
    begin
        ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Released);
        ProductionOrder.SETRANGE("Sales Order No.", OrderNoP);
        ProductionOrder.SETRANGE("Sales Order Line No.", OrderLineNoP);
        ProductionOrder.SETRANGE("Schedule Line No.", ScheduleLineNoP);
        IF ProductionOrder.FINDSET THEN
            REPEAT
                ProductionOrder.VALIDATE("Source No.", NewItemNoP);
                ProductionOrder.MODIFY;

                //Refresh
                CLEAR(RefreshProdOrder);
                RefreshProdOrder.USEREQUESTPAGE(FALSE);
                RefreshProdOrder.SETTABLEVIEW(ProductionOrder);
                RefreshProdOrder.RUN;

                UpdateChangeLog(
                  ProductionOrder."Sales Order No.",
                  ProductionOrder."Sales Order Line No.",
                  ProductionOrder."Schedule Line No.",
                  ProductionOrder."No.",
                  OldItemNo,
                  NewItemNo);
            UNTIL ProductionOrder.NEXT = 0
        ELSE
            UpdateChangeLog(
              OrderNoP,
              OrderLineNoP,
              ScheduleLineNoP,
              '',
              OldItemNo,
              NewItemNo);

        COMMIT;
    end;

    local procedure UpdateChangeLog(OrderNoP: Code[20]; OrderLineNoP: Integer; ScheduleLineNoP: Integer; ProdOrderNo: Code[20]; OldItemNoP: Code[20]; NewItemNoP: Code[20])
    var
        SaleScheduleItemChangeLog: Record "Sale/ Schedule Item Change Log";
    begin
        WITH SaleScheduleItemChangeLog DO BEGIN
            INIT;
            "Sales Order No." := OrderNoP;
            "Sales Order Line No." := OrderLineNoP;
            "Schedule Line No." := ScheduleLineNoP;
            "RPO No." := ProdOrderNo;
            "Old Item No." := OldItemNoP;
            "New Item No." := NewItemNoP;
            INSERT(TRUE);
        END;
    end;
}

