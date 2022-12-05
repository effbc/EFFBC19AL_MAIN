report 50115 "Summary Aging of Customers"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SummaryAgingofCustomers.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING(Name);
            RequestFilterFields = "No.", "Customer Posting Group";
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustBalanceDueLCY; CustBalanceDueLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY1; CustBalanceDueLCY1)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY2; CustBalanceDueLCY2)
            {
                AutoFormatType = 1;
            }
            column(custbalance; custbalance)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY1_Control1102154002; CustBalanceDueLCY1)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_Control1102154009; CustBalanceDueLCY)
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY2_Control1102154014; CustBalanceDueLCY2)
            {
                AutoFormatType = 1;
            }
            column(custbalance_Control1102154015; custbalance)
            {
                AutoFormatType = 1;
            }
            column(Summary_Aging_of_DebtorsCaption; Summary_Aging_of_DebtorsCaptionLbl)
            {
            }
            column(Customer_No_Caption; Customer_No_CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Less_than_90_DaysCaption; Less_than_90_DaysCaptionLbl)
            {
            }
            column(Less_than_270_DaysCaption; Less_than_270_DaysCaptionLbl)
            {
            }
            column(Above_270_days_debtorsCaption; Above_270_days_debtorsCaptionLbl)
            {
            }
            column(Total_BalanceCaption; Total_BalanceCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrintCust := FALSE;
                //FOR i := 1 TO 5 DO BEGIN
                IF StartDate = 0D THEN
                    ERROR('You Need to Provide the End Date');
                DtldCustLedgEntry.RESET;
                DtldCustLedgEntry."Debit Amount" := 0;
                DtldCustLedgEntry."Amount (LCY)" := 0;
                custbalance := 0;
                DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                DtldCustLedgEntry.SETRANGE("Posting Date", (DMY2Date(04, 01, 08)), StartDate);
                DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                custbalance := DtldCustLedgEntry."Amount (LCY)";
                IF custbalance > 100 THEN BEGIN
                    IF (Customer."Customer Posting Group" = 'PRIVATE') OR (Customer."Customer Posting Group" = 'OTHERS') THEN BEGIN
                        PeriodStartDate := StartDate - 90;
                        // DtldCustLedgEntry.SETRANGE("Initial Entry Due Date",PeriodStartDate,StartDate);
                        DtldCustLedgEntry.SETRANGE("Posting Date", PeriodStartDate, StartDate);
                        DtldCustLedgEntry.CALCSUMS("Debit Amount");
                        CustBalanceDueLCY := DtldCustLedgEntry."Debit Amount";
                        IF CustBalanceDueLCY = 0 THEN
                            CustBalanceDueLCY2 := custbalance;
                    END;
                    IF Customer."Customer Posting Group" = 'RAILWAYS' THEN BEGIN
                        PeriodStartDate := StartDate - 270;
                        IF PeriodStartDate < (DMY2Date(04, 01, 08)) THEN
                            PeriodStartDate := (DMY2Date(04, 01, 08));
                        // DtldCustLedgEntry.SETRANGE("Initial Entry Due Date",PeriodStartDate,StartDate);
                        DtldCustLedgEntry.SETRANGE("Posting Date", PeriodStartDate, StartDate);
                        DtldCustLedgEntry.CALCSUMS("Debit Amount");
                        CustBalanceDueLCY1 := DtldCustLedgEntry."Debit Amount";
                        IF CustBalanceDueLCY1 = 0 THEN
                            CustBalanceDueLCY2 := custbalance;
                        IF CustBalanceDueLCY1 = custbalance THEN BEGIN
                            //CustBalanceDueLCY1:=0;
                            //CustBalanceDueLCY2:=custbalance;
                            CustBalanceDueLCY2 := 0;
                            CustBalanceDueLCY1 := custbalance;
                        END;
                    END;
                    IF (Customer."Customer Posting Group" = 'RAILWAYS') AND (CustBalanceDueLCY1 < custbalance) THEN BEGIN
                        CustBalanceDueLCY2 := custbalance - CustBalanceDueLCY1;
                    END;
                    IF ((Customer."Customer Posting Group" = 'PRIVATE') OR ((Customer."Customer Posting Group" = 'OTHERS'))
                    AND (CustBalanceDueLCY1 < custbalance)) THEN BEGIN
                        CustBalanceDueLCY2 := custbalance - CustBalanceDueLCY;
                    END;

                    IF (CustBalanceDueLCY <> 0) OR (CustBalanceDueLCY1 <> 0) OR (CustBalanceDueLCY2 <> 0) THEN
                        PrintCust := TRUE;
                END;
                IF NOT PrintCust THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);
                row := 0;

                CurrReport.CREATETOTALS(CustBalanceDueLCY, CustBalanceDueLCY1, CustBalanceDueLCY2, custbalance);
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

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        //PeriodStartDate[5] := StartDate;
        //PeriodStartDate[6] := 12319999D;
        //FOR i := 4 DOWNTO 2 DO
        // begin
        // PeriodStartDate[i] := CALCDATE('<-90D>',PeriodStartDate[i + 1]);
        //  PeriodStartDate[i] := CALCDATE('<-270D>',PeriodStartDate[i + 1]);
        // end;
        IF Excel THEN BEGIN
            TempExcelBuffer.CreateBook('', '');//B2B //EFFUPG
                                               //TempExcelBuffer.CreateSheet('test excel','',COMPANYNAME,'');//B2B
                                               //TempExcelBuffer.GiveUserControl;
        END
    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustBalanceDueLCY: Decimal;
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: Date;
        PrintCust: Boolean;
        i: Integer;
        Cuscode: Code[15];
        j: Integer;
        CustBalanceDueLCY1: Decimal;
        CustBalanceDueLCY2: Decimal;
        custbalance: Decimal;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        row: Integer;
        Excel: Boolean;
        Summary_Aging_of_DebtorsCaptionLbl: Label 'Summary Aging of Debtors';
        Customer_No_CaptionLbl: Label 'Customer No.';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Less_than_90_DaysCaptionLbl: Label 'Less than 90 Days';
        Less_than_270_DaysCaptionLbl: Label 'Less than 270 Days';
        Above_270_days_debtorsCaptionLbl: Label 'Above 270 days debtors';
        Total_BalanceCaptionLbl: Label 'Total Balance';
        TotalsCaptionLbl: Label 'Totals';


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.INSERT;
    end;
}

