report 70000 "Prod. Entries Deletion"
{
    Permissions = TableData 5832 = rd;
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem1102152000; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                CLEAR(Updated);
                IF CONFIRM(Text000, FALSE) THEN BEGIN

                    Updated := TRUE;


                    ProductionOrder.RESET;
                    ProductionOrder.SETFILTER("Starting Date", '<%1', EndDate);

                    IF ProductionOrder.FINDSET THEN BEGIN
                        REPEAT

                            ProdOrderComment.SETRANGE(Status, ProductionOrder.Status);
                            ProdOrderComment.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                            ProdOrderComment.DELETEALL;



                            ProdOrderLine.SETRANGE(Status, ProductionOrder.Status);
                            ProdOrderLine.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                            ProdOrderLine.DELETEALL(TRUE);

                            ProdOrderComponent.RESET;
                            ProdOrderComponent.SETRANGE(Status, ProductionOrder.Status);
                            ProdOrderComponent.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                            ProdOrderComponent.DELETEALL(TRUE);

                            ProdOrderRoutingLine.RESET;
                            ProdOrderRoutingLine.SETRANGE(Status, ProductionOrder.Status);
                            ProdOrderRoutingLine.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                            ProdOrderRoutingLine.DELETEALL;

                            WhseRequest.SETRANGE("Document Type", WhseRequest."Document Type"::Production);
                            WhseRequest.SETRANGE("Document Subtype", ProductionOrder.Status);
                            WhseRequest.SETRANGE("Document No.", ProductionOrder."No.");
                            WhseRequest.DELETEALL(TRUE);

                            CapacityLedgerEntry.RESET;
                            CapacityLedgerEntry.SETRANGE("Order No.", ProductionOrder."No.");
                            CapacityLedgerEntry.DELETEALL;

                            ItemTrackingMgt.DeleteWhseItemTrkgLines(
                              DATABASE::"Prod. Order Component", ProductionOrder.Status, ProductionOrder."No.", '', 0, 0, '', FALSE);

                            ProdRoutingLinesTmp.RESET;
                            ProdRoutingLinesTmp.SETRANGE("Prod. Order No.", ProductionOrder."No.");
                            ProdRoutingLinesTmp.DELETEALL;

                            ProductionOrder.DELETE;

                        UNTIL ProductionOrder.NEXT = 0;


                        CapacityLedgerEntry.RESET;
                        CapacityLedgerEntry.SETFILTER("Posting Date", '<%1', EndDate);
                        CapacityLedgerEntry.DELETEALL;


                    END;








                END;
            end;

            trigger OnPostDataItem()
            begin
                IF Updated THEN
                    MESSAGE(Text002);
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
                    field("End Date"; EndDate)
                    {
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
        IF EndDate = 0D THEN
            ERROR(Text001);
    end;

    var
        EndDate: Date;
        ProdOrderRoutingLine: Record 5409;
        Text000: Label 'Do you want delete the data below end date ?';
        Text001: Label 'Please select the End date.';
        Updated: Boolean;
        Text002: Label 'Data deleted sucessfully.';
        ProdOrderLine: Record 5406;
        ProductionOrder: Record 5405;
        ProdOrderComponent: Record 5407;
        ItemTrackingMgt: Codeunit 6500;
        ProdOrderComment: Record 5414;
        WhseRequest: Record 7325;
        CapacityLedgerEntry: Record 5832;

        ProdRoutingLinesTmp: Record 88878;
}

