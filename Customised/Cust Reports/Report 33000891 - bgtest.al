report 33000891 bgtest
{
    // version Rev01,Eff02

    DefaultLayout = RDLC;
    RDLCLayout = './bgtest.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'bgtest';

    dataset
    {
        dataitem("Bank Guarantee"; "Bank Guarantee")
        {
            column(Bank_Guarantee__Claim_Date_; "Claim Date")
            {
            }
            column(Bank_Guarantee__Expiry_Date_; "Expiry Date")
            {
            }
            column(formataddress_ChangeCurrency__BG_Value__; formataddress.ChangeCurrency("BG Value"))
            {

            }
            column(Bank_Guarantee__Customer_Order_No__; "Customer Order No.")
            {
            }
            column(Bank_Guarantee__BG_No__; "BG No.")
            {
            }
            column(NameOfCustome; NameOfCustome)
            {
            }
            column(formataddress_ChangeCurrency_totalbg_; formataddress.ChangeCurrency(totalbg))
            {

            }
            column(Extension_DateCaption; Extension_DateCaptionLbl)
            {
            }
            column(Expire_DateCaption; Expire_DateCaptionLbl)
            {
            }
            column(BG_ValueCaption; BG_ValueCaptionLbl)
            {
            }
            column(Customer_Ord_NoCaption; Customer_Ord_NoCaptionLbl)
            {
            }
            column(BG_NumberCaption; BG_NumberCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Total_BG_ValueCaption; Total_BG_ValueCaptionLbl)
            {
            }
            column(DEPT; Dept)
            {
            }
            column(Dept_Caption; Dept_CaptionLbl)
            {
            }
            column(Sale_Order_No; "Doc No.")
            {
            }
            column(OrderNo_Caption; OrderNo_CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF STRPOS("Bank Guarantee"."BG No.", 'F') = 1 THEN
                    CurrReport.SKIP;

                //Rev01 copied from //Bank Guarantee, Body (2) - OnPreSection()

                /*
                IF "Bank Guarantee"."Claim Date">0D THEN
                CurrReport.SHOWOUTPUT:=FALSE
                ELSE
                CurrReport.SHOWOUTPUT:=TRUE;
                */
                //message(format("Bank Guarantee"."Issued to/Received from"));
                IF customer.GET("Bank Guarantee"."Issued to/Received from") THEN BEGIN
                    totalbg := totalbg + "Bank Guarantee"."BG Value";
                    NameOfCustome := customer.Name;
                END ELSE BEGIN
                    totalbg := totalbg + "Bank Guarantee"."BG Value";
                    NameOfCustome := '';
                END;
                Dept := '';
                IF COPYSTR("Bank Guarantee"."Doc No.", 5, 3) = 'SAL' THEN
                    Dept := 'SALES'
                ELSE
                    IF COPYSTR("Bank Guarantee"."Doc No.", 5, 3) = 'AMC' THEN
                        Dept := 'CS';
                //Rev01 copied from //Bank Guarantee, Body (2) - OnPreSection()

            end;

            trigger OnPreDataItem();
            begin
                totalbg := 0;
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
        totalbg: Decimal;
        customer: Record Customer;
        saleordnumber: Code[20];
        NameOfCustome: Text[50];
        formataddress: Codeunit 50000;
        Extension_DateCaptionLbl: Label 'Extension Date';
        Expire_DateCaptionLbl: Label 'Expire Date';
        BG_ValueCaptionLbl: Label 'BG Value';
        Customer_Ord_NoCaptionLbl: Label 'Customer Ord.No';
        BG_NumberCaptionLbl: Label 'BG Number';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Total_BG_ValueCaptionLbl: Label 'Total BG Value';
        Dept: Code[10];
        Dept_CaptionLbl: Label 'Department';
        OrderNo_CaptionLbl: Label 'Order No';
}

