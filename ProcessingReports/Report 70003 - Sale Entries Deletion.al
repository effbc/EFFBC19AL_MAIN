report 70003 "Sale Entries Deletion"
{
    Permissions = TableData 110 = rd,
                  TableData 111 = rd,
                  TableData 112 = rd,
                  TableData 113 = rd,
                  TableData 114 = rd,
                  TableData 115 = rd;
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

                    SalesShipmentHeader.RESET;
                    SalesShipmentHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF SalesShipmentHeader.FINDSET THEN
                        REPEAT

                            SalesShipmentLine.RESET;
                            SalesShipmentLine.SETFILTER("Document No.", SalesShipmentHeader."No.");
                            IF SalesShipmentLine.FINDSET THEN
                                SalesShipmentLine.DELETEALL;

                            SalesShipmentHeader.DELETE;
                        UNTIL SalesShipmentHeader.NEXT = 0;

                    SalesInvoiceHeader.RESET;
                    SalesInvoiceHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF SalesInvoiceHeader.FINDSET THEN
                        REPEAT

                            SalesInvoiceLine.RESET;
                            SalesInvoiceLine.SETFILTER("Document No.", SalesInvoiceHeader."No.");
                            IF SalesInvoiceLine.FINDSET THEN
                                SalesInvoiceLine.DELETEALL;

                            SalesInvoiceHeader.DELETE;
                        UNTIL SalesInvoiceHeader.NEXT = 0;


                    SalesCrMemoHeader.RESET;
                    SalesCrMemoHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF SalesCrMemoHeader.FINDSET THEN
                        REPEAT

                            SalesCrMemoLine.RESET;
                            SalesCrMemoLine.SETFILTER("Document No.", SalesCrMemoHeader."No.");
                            IF SalesCrMemoLine.FINDSET THEN
                                SalesCrMemoLine.DELETEALL;

                            SalesCrMemoHeader.DELETE;
                        UNTIL SalesCrMemoHeader.NEXT = 0;




                    Updated := TRUE;
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
        Text000: Label 'Do you want delete the data below end date ?';
        Text001: Label 'Please select the End date.';
        Updated: Boolean;
        Text002: Label 'Data deleted sucessfully.';
        SalesShipmentHeader: Record 110;
        SalesShipmentLine: Record 111;
        SalesInvoiceHeader: Record 112;
        SalesInvoiceLine: Record 113;
        SalesCrMemoHeader: Record 114;
        SalesCrMemoLine: Record 115;
}

