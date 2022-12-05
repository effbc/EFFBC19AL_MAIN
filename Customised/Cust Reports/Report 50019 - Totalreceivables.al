report 50019 "Total receivables"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Totalreceivables.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Amount (LCY)" = FILTER(< 0));
            RequestFilterFields = "Posting Date";
            column(formataddress_ChangeCurrency_ABS__Amount__LCY____; formataddress.ChangeCurrency(ABS("Amount (LCY)")))
            {
            }
            column(custname; custname)
            {
            }
            column(Cust__Ledger_Entry_Description; Description)
            {
            }
            column(formataddress_ChangeCurrency_ABS_totalreceivedamts__; formataddress.ChangeCurrency(ABS(totalreceivedamts)))
            {
            }
            column(Receipts_detailsCaption; Receipts_detailsCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Total_Received_AmountCaption; Total_Received_AmountCaptionLbl)
            {
            }
            column(Cust__Ledger_Entry_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                "Cust. Ledger Entry".CALCFIELDS("Cust. Ledger Entry"."Amount (LCY)");
                totalreceivedamts := totalreceivedamts + "Cust. Ledger Entry"."Amount (LCY)";

                cust.SETRANGE(cust."No.", "Cust. Ledger Entry"."Customer No.");
                IF cust.FIND('-') THEN
                    custname := cust.Name;
            end;

            trigger OnPreDataItem()
            begin
                totalreceivedamts := 0;
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
        totalreceivedamts: Decimal;
        custname: Text[60];
        cust: Record Customer;
        formataddress: Codeunit "Correct Dimension Values Cust";
        Receipts_detailsCaptionLbl: Label 'Receipts details';
        Customer_NameCaptionLbl: Label 'Customer Name';
        DescriptionCaptionLbl: Label 'Description';
        AmountCaptionLbl: Label 'Amount';
        Total_Received_AmountCaptionLbl: Label 'Total Received Amount';
}

