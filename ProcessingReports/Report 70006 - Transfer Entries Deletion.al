report 70006 "Transfer Entries Deletion"
{
    Permissions = TableData 5740 = rd,
                  TableData 5741 = rd,
                  TableData 5744 = rd,
                  TableData 5745 = rd,
                  TableData 5746 = rd,
                  TableData 5747 = rd;
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

                    TransferHeader.RESET;
                    TransferHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF TransferHeader.FINDSET THEN
                        REPEAT

                            TransferLine.RESET;
                            TransferLine.SETFILTER("Document No.", TransferHeader."No.");
                            IF TransferLine.FINDSET THEN
                                TransferLine.DELETEALL;

                            TransferHeader.DELETE;
                        UNTIL TransferHeader.NEXT = 0;

                    TransferShipmentHeader.RESET;
                    TransferShipmentHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF TransferShipmentHeader.FINDSET THEN
                        REPEAT

                            TransferShipmentLine.RESET;
                            TransferShipmentLine.SETFILTER("Document No.", TransferShipmentHeader."No.");
                            IF TransferShipmentLine.FINDSET THEN
                                TransferShipmentLine.DELETEALL;

                            TransferShipmentHeader.DELETE;
                        UNTIL TransferShipmentHeader.NEXT = 0;


                    TransferReceiptHeader.RESET;
                    TransferReceiptHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF TransferReceiptHeader.FINDSET THEN
                        REPEAT

                            TransferReceiptLine.RESET;
                            TransferReceiptLine.SETFILTER("Document No.", TransferReceiptHeader."No.");
                            IF TransferReceiptLine.FINDSET THEN
                                TransferReceiptLine.DELETEALL;

                            TransferReceiptHeader.DELETE;
                        UNTIL TransferReceiptHeader.NEXT = 0;




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
        TransferHeader: Record 5740;
        TransferLine: Record 5741;
        TransferShipmentHeader: Record 5744;
        TransferShipmentLine: Record 5745;
        TransferReceiptHeader: Record 5746;
        TransferReceiptLine: Record 5747;
}

