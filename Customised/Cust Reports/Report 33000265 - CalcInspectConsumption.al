report 33000265 "Calc.Inspect Consumption"
{
    Caption = 'Calc. Consumption';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.") WHERE(Status = CONST(Released));
            RequestFilterFields = "No.";
            dataitem("Prod. Order Inspect Component"; "Prod. Order Inspect Component")
            {
                DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("No.");
                RequestFilterFields = "Item No.";

                trigger OnAfterGetRecord()
                var
                    NeededQty: Decimal;
                begin
                    Window.UPDATE(2, "Item No.");

                    CLEAR(ItemJnlLine);
                    Item.GET("Item No.");
                    UnitOfMeasConv := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                    ProdOrderLine.GET(Status, "Prod. Order No.", "Prod. Order Line No.");

                    NeededQty := "Prod. Order Inspect Component"."Expected Quantity";

                    IF NeededQty <> 0 THEN BEGIN
                        IF LocationCode <> '' THEN
                            CreateConsumpJnlLine(LocationCode, '', NeededQty)
                        ELSE
                            CreateConsumpJnlLine("Location Code", "Bin Code", NeededQty);
                        LastItemJnlLine := ItemJnlLine;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    //SETFILTER("Flushing Method",'<>%1&<>%2',"Flushing Method"::Backward,"Flushing Method"::"Pick + Backward");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Window.UPDATE(1, "No.");
            end;

            trigger OnPreDataItem()
            begin
                ItemJnlLine.SETRANGE("Journal Template Name", ToTemplateName);
                ItemJnlLine.SETRANGE("Journal Batch Name", ToBatchName);
                IF ItemJnlLine.FIND('+') THEN
                    NextConsumpJnlLineNo := ItemJnlLine."Line No." + 10000
                ELSE
                    NextConsumpJnlLineNo := 10000;

                Window.OPEN(
                  Text000 +
                  Text001 +
                  Text002 +
                  Text003);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text000: Label 'Calculating consumption...\\';
        Text001: Label 'Prod. Order No.   #1##########\';
        Text002: Label 'Item No.          #2##########\';
        Text003: Label 'Quantity          #3##########';
        Item: Record Item;
        ProdOrderLine: Record "Prod. Order Line";
        ItemJnlLine: Record "Item Journal Line";
        LastItemJnlLine: Record "Item Journal Line";
        UOMMgt: Codeunit "Unit of Measure Management";
        Window: Dialog;
        PostingDate: Date;
        CalcBasedOn: Option "Actual Output","Expected Output";
        UnitOfMeasConv: Decimal;
        LocationCode: Code[10];
        ToTemplateName: Code[10];
        ToBatchName: Code[10];
        NextConsumpJnlLineNo: Integer;


    procedure InitializeRequest(NewPostingDate: Date; NewCalcBasedOn: Option)
    begin
        PostingDate := NewPostingDate;
        CalcBasedOn := NewCalcBasedOn;
    end;

    local procedure CreateConsumpJnlLine(LocationCode: Code[10]; BinCode: Code[20]; QtyToPost: Decimal)
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        Window.UPDATE(3, QtyToPost);

        IF (ItemJnlLine."Item No." = "Prod. Order Inspect Component"."Item No.") AND
           (LocationCode = ItemJnlLine."Location Code") AND
           (BinCode = ItemJnlLine."Bin Code")
        THEN BEGIN
            IF Item."Rounding Precision" > 0 THEN
                ItemJnlLine.VALIDATE(Quantity, ItemJnlLine.Quantity + ROUND(QtyToPost, Item."Rounding Precision", '>'))
            ELSE
                ItemJnlLine.VALIDATE(Quantity, ItemJnlLine.Quantity + ROUND(QtyToPost, 0.00001));
            ItemJnlLine."After Inspection" := TRUE;
            ItemJnlLine.MODIFY;
        END ELSE BEGIN
            ItemJnlLine.INIT;
            ItemJnlLine."Journal Template Name" := ToTemplateName;
            ItemJnlLine."Journal Batch Name" := ToBatchName;
            ItemJnlLine.SetUpNewLine(LastItemJnlLine);
            ItemJnlLine."Line No." := NextConsumpJnlLineNo;

            ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Consumption);
            ItemJnlLine.VALIDATE("Order No.", "Prod. Order Inspect Component"."Prod. Order No.");
            ItemJnlLine.VALIDATE("Source No.", ProdOrderLine."Item No.");
            ItemJnlLine.VALIDATE("Posting Date", PostingDate);
            ItemJnlLine.VALIDATE("Item No.", "Prod. Order Inspect Component"."Item No.");
            ItemJnlLine.VALIDATE("Unit of Measure Code", "Prod. Order Inspect Component"."Unit of Measure Code");
            ItemJnlLine.Description := "Prod. Order Inspect Component".Description;
            IF Item."Rounding Precision" > 0 THEN
                ItemJnlLine.VALIDATE(Quantity, ROUND(QtyToPost, Item."Rounding Precision", '>'))
            ELSE
                ItemJnlLine.VALIDATE(Quantity, ROUND(QtyToPost, 0.00001));
            ItemJnlLine.VALIDATE("Location Code", LocationCode);
            IF BinCode <> '' THEN
                ItemJnlLine.VALIDATE("Bin Code", BinCode);
            ItemJnlLine."Variant Code" := "Prod. Order Inspect Component"."Variant Code";
            ItemJnlLine."Order Line No." :=
              "Prod. Order Inspect Component"."Prod. Order Line No.";
            ItemJnlLine.VALIDATE("Prod. Order Comp. Line No.", "Prod. Order Inspect Component"."Line No.");
            ItemJnlLine."After Inspection" := TRUE;
            ItemJnlLine."Inspectin Receipt No." := "Prod. Order Inspect Component"."Inspection Receipt No.";
            ItemJnlLine.INSERT;
        END;

        NextConsumpJnlLineNo := NextConsumpJnlLineNo + 10000;
    end;

    procedure SetTemplateAndBatchName(TemplateName: Code[10]; BatchName: Code[10])
    begin
        ToTemplateName := TemplateName;
        ToBatchName := BatchName;
    end;
}

