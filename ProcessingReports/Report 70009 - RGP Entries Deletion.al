report 70009 "RGP Entries Deletion"
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

                    PostedMaterialIssuesHeader.RESET;
                    PostedMaterialIssuesHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF PostedMaterialIssuesHeader.FINDSET THEN BEGIN
                        REPEAT
                            PostedMaterialIssuesLine.RESET;
                            PostedMaterialIssuesLine.SETFILTER("Document No.", PostedMaterialIssuesHeader."No.");
                            IF PostedMaterialIssuesLine.FINDSET THEN
                                PostedMaterialIssuesLine.DELETEALL;

                            PostedMaterialIssuesHeader.DELETE;
                        UNTIL PostedMaterialIssuesHeader.NEXT = 0;
                    END;



                    RGPOutHeader.RESET;
                    RGPOutHeader.SETFILTER("RGP Date", '<%1', EndDate);
                    IF RGPOutHeader.FINDSET THEN BEGIN
                        REPEAT
                            RGPOutLine.RESET;
                            RGPOutLine.SETFILTER("Document No.", RGPOutHeader."RGP Out No.");
                            IF RGPOutLine.FINDSET THEN
                                RGPOutLine.DELETEALL;

                            RGPOutHeader.DELETE;
                        UNTIL RGPOutHeader.NEXT = 0;
                    END;


                    RGPInHeader.RESET;
                    RGPInHeader.SETFILTER("RGP In Date", '<%1', EndDate);
                    IF RGPInHeader.FINDSET THEN BEGIN
                        REPEAT
                            RGPInLine.RESET;
                            RGPInLine.SETFILTER("Document No.", RGPInHeader."RGP In No.");
                            IF RGPInLine.FINDSET THEN
                                RGPInLine.DELETEALL;

                            RGPInHeader.DELETE;
                        UNTIL RGPInHeader.NEXT = 0;
                    END;

                    RGPLedgerEntries.RESET;
                    RGPLedgerEntries.SETFILTER("Entry Date", '<%1', EndDate);
                    IF RGPLedgerEntries.FINDSET THEN
                        RGPLedgerEntries.DELETEALL;


                    PostedInspectDatasheetHeader.RESET;
                    PostedInspectDatasheetHeader.SETFILTER("Posting Date", '<%1', EndDate);
                    IF PostedInspectDatasheetHeader.FINDSET THEN BEGIN
                        REPEAT
                            PostedInspectDatasheetLine.RESET;
                            PostedInspectDatasheetLine.SETFILTER("Document No.", PostedInspectDatasheetHeader."No.");
                            IF PostedInspectDatasheetLine.FINDSET THEN
                                PostedInspectDatasheetLine.DELETEALL;

                            PostedInspectDatasheetHeader.DELETE;
                        UNTIL PostedInspectDatasheetHeader.NEXT = 0;
                    END;

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
        PostedMaterialIssuesHeader: Record 50003;
        PostedMaterialIssuesLine: Record 50004;
        RGPOutHeader: Record 60038;
        RGPOutLine: Record 60039;
        RGPInHeader: Record 60040;
        RGPInLine: Record 60041;
        RGPLedgerEntries: Record 60042;
        PostedInspectDatasheetHeader: Record 33000263;
        PostedInspectDatasheetLine: Record 33000264;
}

