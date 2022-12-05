report 70004 "Purchase Entries Deletion"
{
    Permissions = TableData 120 = rd,
                  TableData 121 = rd,
                  TableData 122 = rd,
                  TableData 123 = rd,
                  TableData 124 = rd,
                  TableData 125 = rd;
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

                    PurchRcptHeader.RESET;
                    PurchRcptHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF PurchRcptHeader.FINDSET THEN
                        REPEAT

                            PurchRcptLine.RESET;
                            PurchRcptLine.SETFILTER("Document No.", PurchRcptHeader."No.");
                            IF PurchRcptLine.FINDSET THEN
                                PurchRcptLine.DELETEALL;

                            PurchRcptHeader.DELETE;
                        UNTIL PurchRcptHeader.NEXT = 0;

                    PurchInvHeader.RESET;
                    PurchInvHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF PurchInvHeader.FINDSET THEN
                        REPEAT

                            PurchInvLine.RESET;
                            PurchInvLine.SETFILTER("Document No.", PurchInvHeader."No.");
                            IF PurchInvLine.FINDSET THEN
                                PurchInvLine.DELETEALL;

                            PurchInvHeader.DELETE;
                        UNTIL PurchInvHeader.NEXT = 0;


                    PurchCrMemoHdr.RESET;
                    PurchCrMemoHdr.SETFILTER("Posting Date", '<%1', EndDate);
                    IF PurchCrMemoHdr.FINDSET THEN
                        REPEAT

                            PurchCrMemoLine.RESET;
                            PurchCrMemoLine.SETFILTER("Document No.", PurchCrMemoHdr."No.");
                            IF PurchCrMemoLine.FINDSET THEN
                                PurchCrMemoLine.DELETEALL;

                            PurchCrMemoHdr.DELETE;
                        UNTIL PurchCrMemoHdr.NEXT = 0;




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
        PurchRcptHeader: Record 120;
        PurchRcptLine: Record 121;
        PurchInvHeader: Record 122;
        PurchInvLine: Record 123;
        PurchCrMemoHdr: Record 124;
        PurchCrMemoLine: Record 125;
}

