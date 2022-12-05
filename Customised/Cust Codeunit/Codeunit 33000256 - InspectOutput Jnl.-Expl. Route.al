codeunit 33000256 "InspectOutput Jnl.-Expl. Route"
{
    // version WIP1.0,RQC1.0

    Permissions = TableData "Item Journal Line" = imd,
                  TableData "Prod. Order Line" = r,
                  TableData "Prod. Order Routing Line" = r;
    TableNo = "Item Journal Line";

    trigger OnRun();
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRtngLine: Record "Ins Prod. Order Routing Line";
        ItemJnlLine: Record "Item Journal Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        NextLineNo: Integer;
        LineSpacing: Integer;
        BaseQtyToPost: Decimal;
    begin
        IF "Order No." = '' THEN
            EXIT;

        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SETRANGE("Prod. Order No.", "Order No.");
        IF "Order Line No." <> 0 THEN
            ProdOrderLine.SETRANGE("Line No.", "Order Line No.");
        IF "Item No." <> '' THEN
            ProdOrderLine.SETRANGE("Item No.", "Item No.");
        IF "Routing Reference No." <> 0 THEN
            ProdOrderLine.SETRANGE("Routing Reference No.", "Routing Reference No.");
        IF "Routing No." <> '' THEN
            ProdOrderLine.SETRANGE("Routing No.", "Routing No.");

        ProdOrderRtngLine.SETRANGE(Status, ProdOrderRtngLine.Status::Released);
        ProdOrderRtngLine.SETRANGE("Prod. Order No.", "Order No.");
        IF "Operation No." <> '' THEN
            ProdOrderRtngLine.SETRANGE("Operation No.", "Operation No.");
        ProdOrderRtngLine.SETFILTER("Routing Status", '<> %1', ProdOrderRtngLine."Routing Status"::Finished);

        // Clear fields in xRec to ensure that validation code regarding dimensions is executed:
        "Order Line No." := 0;
        "Item No." := '';
        "Routing Reference No." := 0;
        "Routing No." := '';

        ItemJnlLine := Rec;

        ItemJnlLine.SETRANGE(
          "Journal Template Name", "Journal Template Name");
        ItemJnlLine.SETRANGE(
          "Journal Batch Name", "Journal Batch Name");

        IF ItemJnlLine.FIND('>') THEN BEGIN
            LineSpacing :=
              (ItemJnlLine."Line No." - "Line No.") DIV
              (1 + ProdOrderLine.COUNT * ProdOrderRtngLine.COUNT);
            IF LineSpacing = 0 THEN
                ERROR(Text000);
        END ELSE
            LineSpacing := 10000;

        NextLineNo := "Line No.";

        IF NOT ProdOrderLine.FINDFIRST THEN
            ERROR(Text001);

        REPEAT
            ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
            ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
            IF ProdOrderRtngLine.FINDFIRST THEN BEGIN
                REPEAT
                    InsertOutputJnlLine(
                      Rec, NextLineNo, LineSpacing,
                      ProdOrderLine."Line No.",
                      ProdOrderLine."Item No.",
                      ProdOrderLine."Variant Code",
                      ProdOrderLine."Location Code",
                      ProdOrderLine."Bin Code",
                      ProdOrderLine."Routing No.", ProdOrderLine."Routing Reference No.",
                      ProdOrderRtngLine."Operation No.",
                      ProdOrderLine."Unit of Measure Code",
                      BaseQtyToPost / ProdOrderLine."Qty. per Unit of Measure", ProdOrderRtngLine."Inspection Receipt No.");
                UNTIL ProdOrderRtngLine.NEXT = 0;

            END ELSE
                IF ProdOrderLine."Remaining Quantity" > 0 THEN BEGIN
                    InsertOutputJnlLine(
                      Rec, NextLineNo, LineSpacing,
                      ProdOrderLine."Line No.",
                      ProdOrderLine."Item No.",
                      ProdOrderLine."Variant Code",
                      ProdOrderLine."Location Code",
                      ProdOrderLine."Bin Code",
                      ProdOrderLine."Routing No.", ProdOrderLine."Routing Reference No.", '',
                      ProdOrderLine."Unit of Measure Code",
                      ProdOrderLine."Remaining Quantity", ProdOrderRtngLine."Inspection Receipt No.");
                END;
        UNTIL ProdOrderLine.NEXT = 0;

        DELETE;
    end;

    var
        Text000: Label 'There are not enough free line numbers to explode the route.';
        Text001: Label 'There is nothing to explode.';
        LastItemJnlLine: Record "Item Journal Line";


    procedure InsertOutputJnlLine(ItemJnlLine: Record "Item Journal Line"; var NextLineNo: Integer; var LineSpacing: Integer; ProdOrderLineNo: Integer; ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; BinCode: Code[20]; RoutingNo: Code[20]; RoutingRefNo: Integer; OperationNo: Code[10]; UnitOfMeasureCode: Code[10]; QtyToPost: Decimal; InspectReceiptNo: Code[20]);
    var
        InspectionReceiptHeader: Record "Inspection Receipt Header";
    begin
        NextLineNo := NextLineNo + LineSpacing;

        ItemJnlLine."Line No." := NextLineNo;
        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Output);
        ItemJnlLine.VALIDATE("Order Line No.", ProdOrderLineNo);
        ItemJnlLine.VALIDATE("Item No.", ItemNo);
        ItemJnlLine.VALIDATE("Variant Code", VariantCode);
        ItemJnlLine.VALIDATE("Location Code", LocationCode);
        IF BinCode <> '' THEN
            ItemJnlLine.VALIDATE("Bin Code", BinCode);
        ItemJnlLine.VALIDATE("Routing No.", RoutingNo);
        ItemJnlLine.VALIDATE("Routing Reference No.", RoutingRefNo);
        ItemJnlLine.VALIDATE("Operation No.", OperationNo);
        ItemJnlLine.VALIDATE("Unit of Measure Code", UnitOfMeasureCode);
        ItemJnlLine.VALIDATE("Setup Time", 0);
        ItemJnlLine.VALIDATE("Run Time", 0);
        ItemJnlLine.VALIDATE("Output Quantity", 0);
        ItemJnlLine."After Inspection" := TRUE;
        ItemJnlLine."Inspectin Receipt No." := InspectReceiptNo;
        InspectionReceiptHeader.RESET;
        InspectionReceiptHeader.SETRANGE("No.", InspectReceiptNo);
        InspectionReceiptHeader.SETRANGE(Status, true);//InspectionReceiptHeader.Status::"1");//EFFUPG
        IF InspectionReceiptHeader.FINDFIRST THEN
            ItemJnlLine."Output Jr Serial No." := InspectionReceiptHeader."OutPut Jr Serial No.";
        ItemJnlLine.INSERT;

        LastItemJnlLine := ItemJnlLine;
    end;
}

