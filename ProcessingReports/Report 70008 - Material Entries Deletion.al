report 70008 "Material Entries Deletion"
{
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

                    MatIssueTrackSpecification.RESET;
                    MatIssueTrackSpecification.SETFILTER("Creation Date", '<%1', EndDate);
                    IF MatIssueTrackSpecification.FINDSET THEN
                        MatIssueTrackSpecification.DELETEALL;


                    MatIssueEntrySummary.RESET;
                    MatIssueEntrySummary.SETFILTER("Posting Date", '<%1', EndDate);
                    IF MatIssueEntrySummary.FINDSET THEN
                        MatIssueEntrySummary.DELETEALL;



                    MatIssueTrackSpec2.RESET;
                    MatIssueTrackSpec2.SETFILTER("Creation Date", '<%1', EndDate);
                    IF MatIssueTrackSpec2.FINDSET THEN
                        MatIssueTrackSpec2.DELETEALL;


                    QualityLedgerEntry.RESET;
                    QualityLedgerEntry.SETFILTER("Posting Date", '<%1', EndDate);
                    IF QualityLedgerEntry.FINDSET THEN
                        QualityLedgerEntry.DELETEALL;

                    QualityItemLedgerEntrydele.RESET;
                    QualityItemLedgerEntrydele.SETFILTER("Posting Date", '<%1', EndDate);
                    IF QualityItemLedgerEntrydele.FINDSET THEN
                        QualityItemLedgerEntrydele.DELETEALL;

                    QualityItemLedgerEntrydel2.RESET;
                    QualityItemLedgerEntrydel2.SETFILTER("Posting Date", '<%1', EndDate);
                    IF QualityItemLedgerEntrydel2.FINDSET THEN
                        QualityItemLedgerEntrydel2.DELETEALL;

                    BatchandSerialNos.RESET;
                    BatchandSerialNos.SETFILTER("Posting Date", '<%1', EndDate);
                    IF BatchandSerialNos.FINDSET THEN
                        BatchandSerialNos.DELETEALL;

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
        MatIssueTrackSpecification: Record 50005;
        MatIssueEntrySummary: Record 50006;
        MatIssueTrackSpec2: Record 50008;
        BatchandSerialNos: Record 50007;
        QualityLedgerEntry: Record 33000261;
        QualityItemLedgerEntrydele: Record 50090;
        QualityItemLedgerEntrydel2: Record 50091;
}

