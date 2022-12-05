report 50248 "Sales Document - Test2"
{
    // <changelog>
    //   <change id="IN0090" dev="AUGMENTUM" date="2008-05-28" area="Sales"
    //    baseversion="IN6.00" releaseversion="IN6.00" feature="NAVCORS20355">
    //     Report transformation.  </change>
    //   <add id="PS36451" dev="Vineet" date="2008-08-07" area="VAT" releaseversion="IN6.00" feature="36451"
    //    > Code are added to show warning for Tax Type</add>
    // <add id="PS39773" dev="Anup" date="2008-11-15" area="STAPPL" releaseversion="IN6.00.01" feature="39773"
    // >Functions FilterAppliedEntries,FindAmtForAppln,CheckCalcPmtDisc,RoundServiceTaxPrecision,CheckAppliedInvHasServTax,
    // CheckRefundApplicationOnline,CheckRoundingParameters,CheckAppliedCustPayment,CheckApplofSTpureAgntOnline added</add>
    //  <change id="PS42498" dev="suneethg" date="2009-10-15" area="Sales Tax" releaseversion="IN7.00" feature="NAVCORS42498">
    //  Incorrect Tax Amount in Sales Document Report Corrected</change>
    // </changelog>
    DefaultLayout = RDLC;
    RDLCLayout = './SalesDocumentTest.rdl';

    Caption = 'Sales Document - Test';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = WHERE("Document Type" = FILTER('<>Quote'));
            RequestFilterFields = "Document Type", "No.";
            RequestFilterHeading = 'Sales Document';
            column(Round_Loop_S_No; S_NoCaptionLbl)
            {
            }
            column(Round_Loop_Description_of_Goods; Description_of_GoodsCaptionLbl)
            {
            }
            column(Round_Loop_QtyCaption; QtyCaptionLbl)
            {
            }
            column(Round_Loop_Unit_PriceCaption; Unit_PriceCaptionLbl)
            {
            }
            column(Round_Loop_AmountCaption; AmountCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(SalesHeader_Ship_to_Name_; SalesHeader."Ship-to Name")
                {
                }
                column(SalesHeader_Ship_to_Address; SalesHeader."Ship-to Address")
                {
                }
                column(SalesHeader__Ship_to_Address_2_; SalesHeader."Ship-to Address 2")
                {
                }
                column(Sold_toCaption; Sold_toCaptionLbl)
                {
                }
                column(Dear_Sir_Caption; Dear_Sir_CaptionLbl)
                {
                }
                column(ConsigneeCaption; ConsigneeCaptionLbl)
                {
                }
                column(DataItem1102152047; With_Ref_to_the_above)
                {
                }
                column(SalesHeader_Sell_to_Customer_Name; SalesHeader."Sell-to Customer Name")
                {
                }
                column(TOCaptionLbl; TOCaptionLbl)
                {
                }
                column(SalesHeader_Sell_to_City; SalesHeader."Sell-to City")
                {
                }
                column(Page_Counter_SalesHeader_CustomerOrderDate_0_4; FORMAT("Sales Header"."Customer Order Date", 0, 4))
                {
                }
                column(Page_Counter_Sales_Header_No; SalesHeader."Customer OrderNo.")
                {
                }
                column(Dt_Caption; Dt_CaptionLbl)
                {
                }
                column(Order_No_Caption; Order_No_CaptionLbl)
                {
                }
                column(TIN_NO__28350166764Caption; TIN_NO__28350166764CaptionLbl)
                {
                }
                column(CST_NO__28350166764Caption; CST_NO__28350166764CaptionLbl)
                {
                }
                column(DT_Caption_Control1000000014; DT_Caption_Control1000000014Lbl)
                {
                }
                column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                {
                }
                column(Customer_GST_RegistrationNo; Cust."GST Registration No.")
                {
                }
                column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                {
                }
                column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(USERID; USERID)
                {
                }
                column(STRSUBSTNO_Text014_SalesHeaderFilter_; STRSUBSTNO(Text014, SalesHeaderFilter))
                {
                }
                column(SalesHeaderFilter; SalesHeaderFilter)
                {
                }
                column(ShipInvText; ShipInvText)
                {
                }
                column(ReceiveInvText; ReceiveInvText)
                {
                }
                column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                {
                }
                column(ShipToAddr_8_; ShipToAddr[8])
                {
                }
                column(ShipToAddr_7_; ShipToAddr[7])
                {
                }
                column(ShipToAddr_6_; ShipToAddr[6])
                {
                }
                column(ShipToAddr_5_; ShipToAddr[5])
                {
                }
                column(ShipToAddr_4_; ShipToAddr[4])
                {
                }
                column(ShipToAddr_3_; ShipToAddr[3])
                {
                }
                column(ShipToAddr_2_; ShipToAddr[2])
                {
                }
                column(ShipToAddr_1_; ShipToAddr[1])
                {
                }
                column(SellToAddr_8_; SellToAddr[8])
                {
                }
                column(SellToAddr_7_; SellToAddr[7])
                {
                }
                column(SellToAddr_6_; SellToAddr[6])
                {
                }
                column(SellToAddr_5_; SellToAddr[5])
                {
                }
                column(SellToAddr_4_; SellToAddr[4])
                {
                }
                column(SellToAddr_3_; SellToAddr[3])
                {
                }
                column(SellToAddr_2_; SellToAddr[2])
                {
                }
                column(SellToAddr_1_; SellToAddr[1])
                {
                }
                column(Sales_Header___Ship_to_Code_; "Sales Header"."Ship-to Code")
                {
                }
                column(FORMAT__Sales_Header___Document_Type____________Sales_Header___No__; FORMAT("Sales Header"."Document Type") + ' ' + "Sales Header"."No.")
                {
                }
                column(ShipReceiveOnNextPostReq; ShipReceiveOnNextPostReq)
                {
                }
                column(ShowCostAssignment; ShowCostAssignment)
                {
                }
                column(InvOnNextPostReq; InvOnNextPostReq)
                {
                }
                column(Sales_Header___VAT_Base_Discount___; "Sales Header"."VAT Base Discount %")
                {
                }
                column(SalesDocumentType; FORMAT("Sales Header"."Document Type", 0, 2))
                {
                }
                column(BillToAddr_8_; BillToAddr[8])
                {
                }
                column(BillToAddr_7_; BillToAddr[7])
                {
                }
                column(BillToAddr_6_; BillToAddr[6])
                {
                }
                column(BillToAddr_5_; BillToAddr[5])
                {
                }
                column(BillToAddr_4_; BillToAddr[4])
                {
                }
                column(BillToAddr_3_; BillToAddr[3])
                {
                }
                column(BillToAddr_2_; BillToAddr[2])
                {
                }
                column(BillToAddr_1_; BillToAddr[1])
                {
                }
                column(Sales_Header___Bill_to_Customer_No__; "Sales Header"."Bill-to Customer No.")
                {
                }
                column(Sales_Header___Salesperson_Code_; "Sales Header"."Salesperson Code")
                {
                }
                column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                {
                }
                column(Sales_Header___Customer_Posting_Group_; "Sales Header"."Customer Posting Group")
                {
                }
                column(Sales_Header___Posting_Date_; FORMAT("Sales Header"."Posting Date", 0, 4))
                {
                }
                column(Sales_Header___Document_Date_; FORMAT("Sales Header"."Document Date"))
                {
                }
                column(Sales_Header___Prices_Including_VAT_; "Sales Header"."Prices Including VAT")
                {
                }
                column(SalesHdrPricesIncludingVATFmt; FORMAT("Sales Header"."Prices Including VAT"))
                {
                }
                column(Sales_Header___Payment_Terms_Code_; "Sales Header"."Payment Terms Code")
                {
                }
                column(Sales_Header___Payment_Discount___; "Sales Header"."Payment Discount %")
                {
                }
                column(Sales_Header___Due_Date_; FORMAT("Sales Header"."Due Date"))
                {
                }
                column(Sales_Header___Customer_Disc__Group_; "Sales Header"."Customer Disc. Group")
                {
                }
                column(Sales_Header___Pmt__Discount_Date_; FORMAT("Sales Header"."Pmt. Discount Date"))
                {
                }
                column(Sales_Header___Invoice_Disc__Code_; "Sales Header"."Invoice Disc. Code")
                {
                }
                column(Sales_Header___Shipment_Method_Code_; "Sales Header"."Shipment Method Code")
                {
                }
                column(Sales_Header___Payment_Method_Code_; "Sales Header"."Payment Method Code")
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control104; "Sales Header"."Customer Posting Group")
                {
                }
                column(Sales_Header___Posting_Date__Control105; FORMAT("Sales Header"."Posting Date"))
                {
                }
                column(Sales_Header___Document_Date__Control106; FORMAT("Sales Header"."Document Date"))
                {
                }
                column(Sales_Header___Order_Date_; FORMAT("Sales Header"."Order Date"))
                {
                }
                column(Sales_Header___Shipment_Date_; FORMAT("Sales Header"."Shipment Date"))
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control194; "Sales Header"."Prices Including VAT")
                {
                }
                column(Sales_Header___Payment_Terms_Code__Control18; "Sales Header"."Payment Terms Code")
                {
                }
                column(Sales_Header___Due_Date__Control19; FORMAT("Sales Header"."Due Date"))
                {
                }
                column(Sales_Header___Pmt__Discount_Date__Control22; FORMAT("Sales Header"."Pmt. Discount Date"))
                {
                }
                column(Sales_Header___Payment_Discount____Control23; "Sales Header"."Payment Discount %")
                {
                }
                column(Sales_Header___Payment_Method_Code__Control26; "Sales Header"."Payment Method Code")
                {
                }
                column(Sales_Header___Shipment_Method_Code__Control37; "Sales Header"."Shipment Method Code")
                {
                }
                column(Sales_Header___Customer_Disc__Group__Control100; "Sales Header"."Customer Disc. Group")
                {
                }
                column(Sales_Header___Invoice_Disc__Code__Control102; "Sales Header"."Invoice Disc. Code")
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control130; "Sales Header"."Customer Posting Group")
                {
                }
                column(Sales_Header___Posting_Date__Control131; FORMAT("Sales Header"."Posting Date"))
                {
                }
                column(Sales_Header___Document_Date__Control132; FORMAT("Sales Header"."Document Date"))
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control196; "Sales Header"."Prices Including VAT")
                {
                }
                column(Sales_Header___Applies_to_Doc__Type_; "Sales Header"."Applies-to Doc. Type")
                {
                }
                column(Sales_Header___Applies_to_Doc__No__; "Sales Header"."Applies-to Doc. No.")
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control136; "Sales Header"."Customer Posting Group")
                {
                }
                column(Sales_Header___Posting_Date__Control137; FORMAT("Sales Header"."Posting Date"))
                {
                }
                column(Sales_Header___Document_Date__Control138; FORMAT("Sales Header"."Document Date"))
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control198; "Sales Header"."Prices Including VAT")
                {
                }
                column(PageCounter_Number; Number)
                {
                }
                column(Sales_Document___TestCaption; Sales_Document___TestCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Sales_Header___Sell_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                {
                }
                column(Ship_toCaption; Ship_toCaptionLbl)
                {
                }
                column(Sell_toCaption; Sell_toCaptionLbl)
                {
                }
                column(Sales_Header___Ship_to_Code_Caption; "Sales Header".FIELDCAPTION("Ship-to Code"))
                {
                }
                column(Bill_toCaption; Bill_toCaptionLbl)
                {
                }
                column(Sales_Header___Bill_to_Customer_No__Caption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                {
                }
                column(Sales_Header___Salesperson_Code_Caption; "Sales Header".FIELDCAPTION("Salesperson Code"))
                {
                }
                column(Sales_Header___Your_Reference_Caption; "Sales Header".FIELDCAPTION("Your Reference"))
                {
                }
                column(Sales_Header___Customer_Posting_Group_Caption; "Sales Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Sales_Header___Posting_Date_Caption; Sales_Header___Posting_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Document_Date_Caption; Sales_Header___Document_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Prices_Including_VAT_Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Sales_Header___Payment_Terms_Code_Caption; "Sales Header".FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Sales_Header___Payment_Discount___Caption; "Sales Header".FIELDCAPTION("Payment Discount %"))
                {
                }
                column(Sales_Header___Due_Date_Caption; Sales_Header___Due_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Customer_Disc__Group_Caption; "Sales Header".FIELDCAPTION("Customer Disc. Group"))
                {
                }
                column(Sales_Header___Pmt__Discount_Date_Caption; Sales_Header___Pmt__Discount_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Invoice_Disc__Code_Caption; "Sales Header".FIELDCAPTION("Invoice Disc. Code"))
                {
                }
                column(Sales_Header___Shipment_Method_Code_Caption; "Sales Header".FIELDCAPTION("Shipment Method Code"))
                {
                }
                column(Sales_Header___Payment_Method_Code_Caption; "Sales Header".FIELDCAPTION("Payment Method Code"))
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control104Caption; "Sales Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Sales_Header___Posting_Date__Control105Caption; Sales_Header___Posting_Date__Control105CaptionLbl)
                {
                }
                column(Sales_Header___Document_Date__Control106Caption; Sales_Header___Document_Date__Control106CaptionLbl)
                {
                }
                column(Sales_Header___Order_Date_Caption; Sales_Header___Order_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Shipment_Date_Caption; Sales_Header___Shipment_Date_CaptionLbl)
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control194Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Sales_Header___Payment_Terms_Code__Control18Caption; "Sales Header".FIELDCAPTION("Payment Terms Code"))
                {
                }
                column(Sales_Header___Payment_Discount____Control23Caption; "Sales Header".FIELDCAPTION("Payment Discount %"))
                {
                }
                column(Sales_Header___Due_Date__Control19Caption; Sales_Header___Due_Date__Control19CaptionLbl)
                {
                }
                column(Sales_Header___Pmt__Discount_Date__Control22Caption; Sales_Header___Pmt__Discount_Date__Control22CaptionLbl)
                {
                }
                column(Sales_Header___Shipment_Method_Code__Control37Caption; "Sales Header".FIELDCAPTION("Shipment Method Code"))
                {
                }
                column(Sales_Header___Payment_Method_Code__Control26Caption; "Sales Header".FIELDCAPTION("Payment Method Code"))
                {
                }
                column(Sales_Header___Customer_Disc__Group__Control100Caption; "Sales Header".FIELDCAPTION("Customer Disc. Group"))
                {
                }
                column(Sales_Header___Invoice_Disc__Code__Control102Caption; "Sales Header".FIELDCAPTION("Invoice Disc. Code"))
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control130Caption; "Sales Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Sales_Header___Posting_Date__Control131Caption; Sales_Header___Posting_Date__Control131CaptionLbl)
                {
                }
                column(Sales_Header___Document_Date__Control132Caption; Sales_Header___Document_Date__Control132CaptionLbl)
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control196Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                column(Sales_Header___Applies_to_Doc__Type_Caption; "Sales Header".FIELDCAPTION("Applies-to Doc. Type"))
                {
                }
                column(Sales_Header___Applies_to_Doc__No__Caption; "Sales Header".FIELDCAPTION("Applies-to Doc. No."))
                {
                }
                column(Sales_Header___Customer_Posting_Group__Control136Caption; "Sales Header".FIELDCAPTION("Customer Posting Group"))
                {
                }
                column(Sales_Header___Posting_Date__Control137Caption; Sales_Header___Posting_Date__Control137CaptionLbl)
                {
                }
                column(Sales_Header___Document_Date__Control138Caption; Sales_Header___Document_Date__Control138CaptionLbl)
                {
                }
                column(TCSAmount; TCSAmount)
                {
                }
                column(Sales_Header___Prices_Including_VAT__Control198Caption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                {
                }
                dataitem(DimensionLoop1; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(DimensionLoop1_Number; Number)
                    {
                    }
                    column(DimText_Control162; DimText)
                    {
                    }
                    column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number = 1 THEN BEGIN
                            IF NOT DimSetEntry1.FINDSET THEN
                                CurrReport.BREAK;
                        END ELSE
                            IF NOT Continue THEN
                                CurrReport.BREAK;

                        DimText := '';
                        Continue := FALSE;
                        REPEAT
                            OldDimText := DimText;
                            IF DimText = '' THEN
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                            ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                            IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                DimText := OldDimText;
                                Continue := TRUE;
                                EXIT;
                            END;
                        UNTIL DimSetEntry1.NEXT = 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF NOT ShowDim THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem(HeaderErrorCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(ErrorText_Number_; ErrorText[Number])
                    {
                    }
                    column(HeaderErrorCounter_Number; Number)
                    {
                    }
                    column(ErrorText_Number_Caption; ErrorText_Number_CaptionLbl)
                    {
                    }

                    trigger OnPostDataItem()
                    begin
                        ErrorCounter := 0;
                    end;

                    trigger OnPreDataItem()
                    begin
                        SETRANGE(Number, 1, ErrorCounter);
                    end;
                }
                dataitem(CopyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(Copy_Loop_Number; Number)
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(Sales_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Sales_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Line_Line_No_; "Line No.")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF "Qty. to Ship" > 0 THEN BEGIN
                                //Dutycap:='Excise(8.24%)';
                                //Dutycap := 'Excise' + FORMAT(SalesLine."Excise Effective Rate");//B2BUpg
                                MESSAGE(FORMAT(GetTCSAmt("Sales Header", "Sales Line")));
                                //dutyper:=FORMAT("Sales Line"."BED %"); bed need to gather from excise posting group
                                //TCSAmount += "Sales Line"."TDS/TCS Amount";
                                // MESSAGE(FORMAT(TCSAmount));
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            s := 0;
                            IF FIND('+') THEN
                                OrigMaxLineNo := "Line No.";
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineTaxAmt; SalesLineTaxAmt)
                        {
                        }
                        column(ExciseVar; ExciseVar)
                        {
                        }
                        column(LineAmountVar; ROUND(LineAmountVar, 1))
                        {
                        }
                        column(Round_Loop_Sales_Line___Line_Amount_; ROUND("Sales Line"."Line Amount", 1))
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(C_form; C_form_Lbl)
                        {
                        }
                        column(NOTE; NOTE_Lbl)
                        {
                        }
                        column(Note1; Note1_Lbl)
                        {
                        }
                        column(Note2; Note2_Lbl)
                        {
                        }
                        column(Round_Loop_Round_Loop_Number; Number)
                        {
                        }
                        column(ROUND_TempSalesLine__Line_Amount__1_; TempSalesLine."Line Amount")
                        {
                        }
                        column(Round_Loop_n; n)
                        {
                        }
                        column(GSTComponentCode1; GSTComponentCode[1] + ' Amount')
                        {
                        }
                        column(GSTComponentCode2; GSTComponentCode[2] + ' Amount')
                        {
                        }
                        column(GSTComponentCode3; GSTComponentCode[3] + ' Amount')
                        {
                        }
                        column(GSTComponentCode4; GSTComponentCode[4] + 'Amount')
                        {
                        }
                        column(GSTCompAmount1; ABS(GSTCompAmount[1]))
                        {
                        }
                        column(GSTCompAmount2; ABS(GSTCompAmount[2]))
                        {
                        }
                        column(GSTCompAmount3; ABS(GSTCompAmount[3]))
                        {
                        }
                        column(GSTCompAmount4; ABS(GSTCompAmount[4]))
                        {
                        }
                        column(QtyToHandleCaption; QtyToHandleCaption)
                        {
                        }
                        column(Sales_Line__Type; "Sales Line".Type)
                        {
                        }
                        column(Sales_Line___No__; "Sales Line"."No.")
                        {
                        }
                        column(Round_Loop_Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(QtyToHandle; QtyToHandle)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Sales_Line___Qty__to_Invoice_; "Sales Line"."Qty. to Invoice")
                        {
                        }
                        column(Round_Loop_Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Round_Loop_TempSalesLine_Qty_to_Ship; TempSalesLine."Qty. to Ship")
                        {
                        }
                        column(Round_Loop_SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(Round_Loop_Dutycap; Dutycap)
                        {
                        }
                        column(Round_Loop_taxcap; taxcap)
                        {
                        }
                        column(Round_Loop_desc; desc)
                        {
                        }
                        column(Round_Loop_vatcap; vatcap)
                        {
                        }
                        column(Round_Loop_RDSO_ChargesCaption; RDSO_ChargesCaptionLbl)
                        {
                        }
                        column(Round_Loop_AdvanceCaption; AdvanceCaptionLbl)
                        {
                        }
                        column(Round_Loop_dutyper; dutyper)
                        {
                        }
                        column(Round_Loop_s1; s1)
                        {
                        }
                        column(Round_Loop_s2; s2)
                        {
                        }
                        /* column(Round_Loop_TempSalesLine_ExciseAmount_TempSalesLine_ServiceTaxAmount; ROUND(TempSalesLine."Excise Amount", 1) + ROUND(TempSalesLine."Service Tax Amount", 1))
                         {
                         }
                        column(Round_Loop_TempSalesLine_ServiceTaxeCessAmountTempSalesLine_TaxAmount_TempSalesLine_ServiceTaxeCessAmount; ROUND(TempSalesLine."Service Tax eCess Amount", 1) + ROUND(TempSalesLine."Tax Amount", 1) + ROUND(TempSalesLine."Service Tax eCess Amount" / 2, 1))
                        {
                        }*/
                        column(Sales_Line___Line_Discount___; "Sales Line"."Line Discount %")
                        {
                        }
                        column(Round_Loop_TempSalesLine_RDSOCharges; ROUND(TempSalesLine."RDSO Charges", 1))
                        {
                        }
                        column(Round_Loop_advance; advance)
                        {
                        }
                        column(Round_Loop_s_advance; ROUND(s - advance, 1))
                        {
                        }
                        column(Round_Loop_Grand_TotalCaption; Grand_TotalCaptionLbl)
                        {
                        }
                        column(Round_Loop_In_words_Caption; In_words_CaptionLbl)
                        {
                        }
                        column(Round_Loop_DescriptionLine_1; DescriptionLine[1])
                        {
                        }
                        column(Round_Loop_for_EFFTRONICS_SYSTEMS_PVT__LTD__Caption; for_EFFTRONICS_SYSTEMS_PVT__LTD__CaptionLbl)
                        {
                        }
                        column(Round_Loop_AUTHORISED_SIGNATORYCaption; AUTHORISED_SIGNATORYCaptionLbl)
                        {
                        }
                        column(Round_Loop_NOTE; NOTE_Lbl)
                        {
                        }
                        column(Sales_Line___Allow_Invoice_Disc__; "Sales Line"."Allow Invoice Disc.")
                        {
                        }
                        column(Sales_Line___Line_Discount_Amount_; "Sales Line"."Line Discount Amount")
                        {
                        }
                        column(SalesLineAllowInvoiceDiscFmt; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(RoundLoop_RoundLoop_Number; Number)
                        {
                        }
                        column(Sales_Line___Inv__Discount_Amount_; "Sales Line"."Inv. Discount Amount")
                        {
                        }
                        column(TempSalesLine__Inv__Discount_Amount_; -TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempSalesLine__Line_Amount_; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumLineAmount; SumLineAmount)
                        {
                        }
                        column(SumInvDiscountAmount; SumInvDiscountAmount)
                        {
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(TempSalesLine__Line_Amount_____Sales_Line___Inv__Discount_Amount_; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                        }
                        /*
                        column(TempSalesLine__Excise_Amount_; TempSalesLine."Excise Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TempSalesLine__Tax_Amount_; TempSalesLine."Tax Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }*/
                        column(ServiceTaxAmt; ServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxECessAmt; ServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        /*column(SalesLine__Total_TDS_TCS_Incl__SHE_CESS_; TempSalesLine."Total TDS/TCS Incl. SHE CESS")
                        {
                        }*/
                        column(TCSAmountApplied; TCSAmountApplied)
                        {
                        }
                        column(AppliedServiceTaxAmt; AppliedServiceTaxAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxECessAmt; AppliedServiceTaxECessAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ServiceTaxSHECessAmt; ServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AppliedServiceTaxSHECessAmt; AppliedServiceTaxSHECessAmt)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control1500007; TotalInclVATText)
                        {
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SumSalesLineGSTAmount; SumSalesLineGSTAmount)
                        {
                        }
                        column(SumSalesLineExciseAmount; SumSalesLineExciseAmount)
                        {
                        }
                        column(SumSalesLineTaxAmount; SumSalesLineTaxAmount)
                        {
                        }
                        column(SumLineServiceTaxAmount; SumLineServiceTaxAmount)
                        {
                        }
                        column(SumLineServiceTaxECessAmount; SumLineServiceTaxECessAmount)
                        {
                        }
                        column(SumLineServiceTaxSHECessAmount; SumLineServiceTaxSHECessAmount)
                        {
                        }
                        column(SumSalesLineAmountToCusTomer; SumSalesLineAmountToCusTomer)
                        {
                        }
                        column(SumTotalTDSTCSInclSHECESS; SumTotalTDSTCSInclSHECESS)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control191; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control189; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATBaseAmount___VATAmount; VATBaseAmount + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control188; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control186; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___No__Caption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Sales_Line__DescriptionCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Sales_Line___Qty__to_Invoice_Caption; "Sales Line".FIELDCAPTION("Qty. to Invoice"))
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Sales_Line___Line_Discount___Caption; Sales_Line___Line_Discount___CaptionLbl)
                        {
                        }
                        column(Sales_Line___Allow_Invoice_Disc__Caption; "Sales Line".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(Sales_Line___Line_Discount_Amount_Caption; Sales_Line___Line_Discount_Amount_CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Sales_Line__TypeCaption; "Sales Line".FIELDCAPTION(Type))
                        {
                        }
                        column(Sales_Line__QuantityCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(TempSalesLine__Inv__Discount_Amount_Caption; TempSalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(TempSalesLine__Excise_Amount_Caption; TempSalesLine__Excise_Amount_CaptionLbl)
                        {
                        }
                        column(TempSalesLine__Tax_Amount_Caption; TempSalesLine__Tax_Amount_CaptionLbl)
                        {
                        }
                        column(ServiceTaxAmtCaption; ServiceTaxAmtCaptionLbl)
                        {
                        }
                        column(Charges_AmountCaption; Charges_AmountCaptionLbl)
                        {
                        }
                        column(Other_Taxes_AmountCaption; Other_Taxes_AmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxECessAmtCaption; ServiceTaxECessAmtCaptionLbl)
                        {
                        }
                        column(TCS_AmountCaption; TCS_AmountCaptionLbl)
                        {
                        }
                        column(TCS_Amount__Applied_Caption; TCS_Amount__Applied_CaptionLbl)
                        {
                        }
                        column(Svc_Tax_Amt__Applied_Caption; Svc_Tax_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(Svc_Tax_eCess_Amt__Applied_Caption; Svc_Tax_eCess_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(ServiceTaxSHECessAmtCaption; ServiceTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SHECess_Amt_Applied_Caption; Svc_Tax_SHECess_Amt_Applied_CaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
                        {
                        }
                        column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
                        {
                        }
                        column(SumSvcTaxSBCAmount; SumSvcTaxSBCAmount)
                        {
                        }
                        column(ServiceTaxSBCAmtCaption; ServiceTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(Svc_Tax_SBC_Amt__Applied_Caption; Svc_Tax_SBC_Amt__Applied_CaptionLbl)
                        {
                        }
                        column(KKCessAmt; KKCessAmt)
                        {
                        }
                        column(AppliedKKCessAmt; AppliedKKCessAmt)
                        {
                        }
                        column(SumKKCessAmount; SumKKCessAmount)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KK_Cess_Amt__Applied_Caption; KK_Cess_Amt__Applied_CaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_Control159; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(DimText_Control161; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                DimText := '';
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPostDataItem()
                            begin
                                SumLineAmount := SumLineAmount + TempSalesLine."Line Amount";
                                SumInvDiscountAmount := SumInvDiscountAmount + TempSalesLine."Inv. Discount Amount";

                                //IN0090.BEGIN
                                //SumSalesLineExciseAmount := SumSalesLineExciseAmount + TempSalesLine."Excise Amount";
                                //SumSalesLineTaxAmount := SumSalesLineTaxAmount + TempSalesLine."Tax Amount";
                                //SumLineServiceTaxAmount := SumLineServiceTaxAmount + TempSalesLine."Service Tax Amount";
                                //SumLineServiceTaxECessAmount := SumLineServiceTaxECessAmount + TempSalesLine."Service Tax eCess Amount";
                                //SumLineServiceTaxSHECessAmount := SumLineServiceTaxSHECessAmount + TempSalesLine."Service Tax SHE Cess Amount";
                                SumTotalTDSTCSInclSHECESS := SumTotalTDSTCSInclSHECESS + GetTCSAmt("Sales Header", TempSalesLine);
                                //SumSvcTaxSBCAmount := SumSvcTaxSBCAmount + TempSalesLine."Service Tax SBC Amount";
                                SumSalesLineGSTAmount += GetSalesGSTLineWise(TempSalesLine);
                                //SumKKCessAmount := SumKKCessAmount + TempSalesLine."KK Cess Amount";
                                SumSalesLineAmountToCusTomer := SumSalesLineAmountToCusTomer + TempSalesLine."Amount To Customer";
                                TotalAmount := SumLineAmount - SumInvDiscountAmount + SumSalesLineExciseAmount +
                                  SumSalesLineTaxAmount + ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + OtherTaxesAmount +
                                  ChargesAmount + SumTotalTDSTCSInclSHECESS + AppliedServiceTaxAmt + AppliedServiceTaxECessAmt +
                                  AppliedServiceTaxSHECessAmt +
                                  ServiceTaxSBCAmt + AppliedServiceTaxSBCAmt +
                                  KKCessAmt + AppliedKKCessAmt + SumSalesLineGSTAmount;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowDim THEN
                                    CurrReport.BREAK;
                            end;
                        }
                        dataitem(LineErrorCounter; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(ErrorText_Number__Control97; ErrorText[Number])
                            {
                            }
                            column(LineErrorCounter_Number; Number)
                            {
                            }
                            column(ErrorText_Number__Control97Caption; ErrorText_Number__Control97CaptionLbl)
                            {
                            }

                            trigger OnPostDataItem()
                            begin
                                ErrorCounter := 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, ErrorCounter);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TableID: array[10] of Integer;
                            No: array[10] of Code[20];
                        begin

                            IF Number = 1 THEN
                                TempSalesLine.FIND('-')
                            ELSE
                                TempSalesLine.NEXT;
                            "Sales Line" := TempSalesLine;

                            IF NOT "Sales Header"."Prices Including VAT" AND
   ("Sales Line"."VAT Calculation Type" = "Sales Line"."VAT Calculation Type"::"Full VAT")
THEN
                                TempSalesLine."Line Amount" := 0;

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            // PS39773.begin
                            FilterAppliedEntries;
                            //IF "Sales Header"."Transaction No. Serv. Tax" <> 0 THEN BEGIN
                            //  ServiceTaxEntry.RESET;
                            //  ServiceTaxEntry.SETCURRENTKEY("Transaction No.");
                            //  ServiceTaxEntry.SETRANGE("Transaction No.","Sales Header"."Transaction No. Serv. Tax");
                            //  IF ServiceTaxEntry.FINDFIRST THEN BEGIN
                            //    IF (ServiceTaxEntry."Service Tax Group Code" <> "Service Tax Group") THEN
                            //      AddError(Text16503);
                            //    IF (ServiceTaxEntry."Service Tax Registration No." <> "Service Tax Registration No.") THEN
                            //      AddError(Text16502);
                            //
                            //    IF "Sales Header"."Currency Code" <> '' THEN BEGIN
                            //     ServiceTaxEntry."Remaining Serv. Tax Amt" :=
                            //       ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Header"."Posting Date","Sales Header"."Currency Code",
                            //         ServiceTaxEntry."Remaining Serv. Tax Amt","Sales Header"."Currency Factor"));
                            //     ServiceTaxEntry."Remaining Serv. Tax eCess Amt" :=
                            //       ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Header"."Posting Date","Sales Header"."Currency Code",
                            //         ServiceTaxEntry."Remaining Serv. Tax eCess Amt","Sales Header"."Currency Factor"));
                            //     ServiceTaxEntry."Remaining Serv Tax SHECess Amt" :=
                            //       ROUND(CurrExchRate.ExchangeAmtLCYToFCY(
                            //         "Sales Header"."Posting Date","Sales Header"."Currency Code",
                            //         ServiceTaxEntry."Remaining Serv Tax SHECess Amt","Sales Header"."Currency Factor"));
                            //    END;
                            //    //IF ABS(ServiceTaxEntry."Remaining Serv. Tax Amt") <= TempSalesLine."Service Tax Amount" THEN BEGIN
                            //    //  ServiceTaxAmt := ABS(TempSalesLine."Service Tax Amount" - ABS(ServiceTaxEntry."Remaining Serv. Tax Amt"));
                            //    //  ServiceTaxECessAmt := ABS(TempSalesLine."Service Tax eCess Amount" -
                            //    //    ABS(ServiceTaxEntry."Remaining Serv. Tax eCess Amt"));
                            //    //  ServiceTaxSHECessAmt := ABS(TempSalesLine."Service Tax SHE Cess Amount" -
                            //    //    ABS(ServiceTaxEntry."Remaining Serv Tax SHECess Amt"));
                            //    //  AppliedServiceTaxAmt := ABS(ServiceTaxEntry."Remaining Serv. Tax Amt");
                            //    //  AppliedServiceTaxECessAmt := ABS(ServiceTaxEntry."Remaining Serv. Tax eCess Amt");
                            //    //  AppliedServiceTaxSHECessAmt := ABS(ServiceTaxEntry."Remaining Serv Tax SHECess Amt");
                            //    //END ELSE BEGIN
                            //    //  AppliedServiceTaxAmt := TempSalesLine."Service Tax Amount";
                            //    //  AppliedServiceTaxECessAmt := TempSalesLine."Service Tax eCess Amount";
                            //    //  AppliedServiceTaxSHECessAmt := TempSalesLine."Service Tax SHE Cess Amount";
                            //    //END;
                            //    NetTotal := TempSalesLine."Amount To Customer" - TempSalesLine."Service Tax Amount" -
                            //      TempSalesLine."Service Tax eCess Amount" - TempSalesLine."Service Tax SHE Cess Amount" +
                            //      ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + AppliedServiceTaxAmt +
                            //      AppliedServiceTaxECessAmt + AppliedServiceTaxSHECessAmt;
                            //  END;
                            //END;
                            //END ELSE BEGIN
                            //  ServiceTaxAmt := TempSalesLine."Service Tax Amount";
                            //  ServiceTaxECessAmt := TempSalesLine."Service Tax eCess Amount";
                            //  ServiceTaxSHECessAmt := TempSalesLine."Service Tax SHE Cess Amount";
                            //  NetTotal := TempSalesLine."Amount To Customer";
                            //END;
                            // PS39773.end

                            /*IF (NOT "Sales Header".Trading) AND ("CIF Amount" + "BCD Amount" = 0) AND CVD THEN
                                AddError(Text16504);*/

                            IF "Sales Line"."Document Type" IN ["Sales Line"."Document Type"::"Return Order", "Sales Line"."Document Type"::"Credit Memo"]
                            THEN BEGIN
                                IF "Sales Line"."Document Type" = "Sales Line"."Document Type"::"Credit Memo" THEN BEGIN
                                    IF ("Sales Line"."Return Qty. to Receive" <> "Sales Line".Quantity) AND ("Sales Line"."Return Receipt No." = '') THEN
                                        AddError(STRSUBSTNO(Text015, "Sales Line".FIELDCAPTION("Return Qty. to Receive"), "Sales Line".Quantity));
                                    IF "Sales Line"."Qty. to Invoice" <> "Sales Line".Quantity THEN
                                        AddError(STRSUBSTNO(Text015, "Sales Line".FIELDCAPTION("Qty. to Invoice"), "Sales Line".Quantity));
                                END;
                                IF "Sales Line"."Qty. to Ship" <> 0 THEN
                                    AddError(STRSUBSTNO(Text043, "Sales Line".FIELDCAPTION("Qty. to Ship")));
                            END ELSE BEGIN
                                IF "Sales Line"."Document Type" = "Sales Line"."Document Type"::Invoice THEN BEGIN
                                    IF ("Sales Line"."Qty. to Ship" <> "Sales Line".Quantity) AND ("Sales Line"."Shipment No." = '') THEN
                                        AddError(STRSUBSTNO(Text015, "Sales Line".FIELDCAPTION("Qty. to Ship"), "Sales Line".Quantity));
                                    IF "Sales Line"."Qty. to Invoice" <> "Sales Line".Quantity THEN
                                        AddError(STRSUBSTNO(Text015, "Sales Line".FIELDCAPTION("Qty. to Invoice"), "Sales Line".Quantity));
                                END;
                                IF "Sales Line"."Return Qty. to Receive" <> 0 THEN
                                    AddError(STRSUBSTNO(Text043, "Sales Line".FIELDCAPTION("Return Qty. to Receive")));
                            END;

                            IF NOT "Sales Header".Ship THEN
                                "Sales Line"."Qty. to Ship" := 0;
                            IF NOT "Sales Header".Receive THEN
                                "Sales Line"."Return Qty. to Receive" := 0;

                            IF ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Invoice) AND ("Sales Line"."Shipment No." <> '') THEN BEGIN
                                "Sales Line"."Quantity Shipped" := "Sales Line".Quantity;
                                "Sales Line"."Qty. to Ship" := 0;
                            END;

                            IF ("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Credit Memo") AND ("Sales Line"."Return Receipt No." <> '') THEN BEGIN
                                "Sales Line"."Return Qty. Received" := "Sales Line".Quantity;
                                "Sales Line"."Return Qty. to Receive" := 0;
                            END;

                            IF "Sales Header".Invoice THEN BEGIN
                                IF "Sales Line"."Document Type" IN ["Sales Line"."Document Type"::"Return Order", "Sales Line"."Document Type"::"Credit Memo"] THEN
                                    MaxQtyToBeInvoiced := "Sales Line"."Return Qty. to Receive" + "Sales Line"."Return Qty. Received" - "Sales Line"."Quantity Invoiced"
                                ELSE
                                    MaxQtyToBeInvoiced := "Sales Line"."Qty. to Ship" + "Sales Line"."Quantity Shipped" - "Sales Line"."Quantity Invoiced";
                                IF ABS("Sales Line"."Qty. to Invoice") > ABS(MaxQtyToBeInvoiced) THEN
                                    "Sales Line"."Qty. to Invoice" := MaxQtyToBeInvoiced;
                            END ELSE
                                "Sales Line"."Qty. to Invoice" := 0;

                            IF "Sales Line"."Gen. Prod. Posting Group" <> '' THEN BEGIN
                                IF ("Sales Header"."Document Type" IN
                                     ["Sales Header"."Document Type"::"Return Order",
                                      "Sales Header"."Document Type"::"Credit Memo"]) AND
                                   ("Sales Header"."Applies-to Doc. Type" = "Sales Header"."Applies-to Doc. Type"::Invoice) AND
                                   ("Sales Header"."Applies-to Doc. No." <> '')
                                THEN BEGIN
                                    CustLedgEntry.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
                                    CustLedgEntry.SETRANGE("Customer No.", "Sales Header"."Bill-to Customer No.");
                                    CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
                                    CustLedgEntry.SETRANGE("Document No.", "Sales Header"."Applies-to Doc. No.");
                                    IF (NOT CustLedgEntry.FINDLAST) AND (NOT ApplNoError) THEN BEGIN
                                        ApplNoError := TRUE;
                                        AddError(
                                          STRSUBSTNO(
                                            Text016,
                                            "Sales Header".FIELDCAPTION("Applies-to Doc. No."), "Sales Header"."Applies-to Doc. No."));
                                    END;
                                    VATDate := CustLedgEntry."Posting Date";
                                END ELSE
                                    VATDate := "Sales Header"."Posting Date";

                                /*
                                    IF NOT VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") THEN
                                      AddError(
                                        STRSUBSTNO(
                                          Text017,
                                          VATPostingSetup.TABLECAPTION,"VAT Bus. Posting Group","VAT Prod. Posting Group"));
                                    IF VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" THEN
                                      IF ("Sales Header"."VAT Registration No." = '') AND (NOT VATNoError) THEN BEGIN
                                        VATNoError := TRUE;
                                        AddError(
                                          STRSUBSTNO(
                                            Text035,"Sales Header".FIELDCAPTION("VAT Registration No.")));
                                      END;
                                */
                            END;

                            IF "Sales Line".Quantity <> 0 THEN BEGIN
                                IF "Sales Line"."No." = '' THEN
                                    AddError(STRSUBSTNO(Text019, "Sales Line".Type, "Sales Line".FIELDCAPTION("No.")));
                                IF "Sales Line".Type = 0 THEN
                                    AddError(STRSUBSTNO(Text006, "Sales Line".FIELDCAPTION(Type)));
                            END ELSE
                                IF "Sales Line".Amount <> 0 THEN
                                    AddError(
                                      STRSUBSTNO(Text020, "Sales Line".FIELDCAPTION(Amount), "Sales Line".FIELDCAPTION(Quantity)));

                            IF "Sales Line"."Drop Shipment" THEN BEGIN
                                IF "Sales Line".Type <> "Sales Line".Type::Item THEN
                                    AddError(Text021);
                                IF ("Sales Line"."Qty. to Ship" <> 0) AND ("Sales Line"."Purch. Order Line No." = 0) THEN BEGIN
                                    AddError(STRSUBSTNO(Text022, "Sales Line"."Line No."));
                                    AddError(Text023);
                                END;
                            END;

                            SalesLine := "Sales Line";
                            IF NOT ("Sales Line"."Document Type" IN
                                     ["Sales Line"."Document Type"::"Return Order", "Sales Line"."Document Type"::"Credit Memo"]) THEN BEGIN
                                SalesLine."Qty. to Ship" := -SalesLine."Qty. to Ship";
                                SalesLine."Qty. to Invoice" := -SalesLine."Qty. to Invoice";
                            END;

                            RemQtyToBeInvoiced := SalesLine."Qty. to Invoice";

                            CASE "Sales Line"."Document Type" OF
                                "Sales Line"."Document Type"::"Return Order", "Sales Line"."Document Type"::"Credit Memo":
                                    CheckRcptLines("Sales Line");
                                "Sales Line"."Document Type"::Order, "Sales Line"."Document Type"::Invoice:
                                    CheckShptLines("Sales Line");
                            END;

                            IF ("Sales Line".Type >= "Sales Line".Type::"G/L Account") AND ("Sales Line"."Qty. to Invoice" <> 0) THEN BEGIN
                                IF NOT GenPostingSetup.GET("Sales Line"."Gen. Bus. Posting Group", "Sales Line"."Gen. Prod. Posting Group") THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text017,
                                        GenPostingSetup.TABLECAPTION, "Sales Line"."Gen. Bus. Posting Group", "Sales Line"."Gen. Prod. Posting Group"));
                                /*    IF NOT VATPostingSetup.GET("VAT Bus. Posting Group","VAT Prod. Posting Group") THEN
                                      AddError(
                                        STRSUBSTNO(
                                          Text017,
                                          VATPostingSetup.TABLECAPTION,"VAT Bus. Posting Group","VAT Prod. Posting Group"));
                                */
                            END;
                            CASE "Sales Line".Type OF
                                "Sales Line".Type::"G/L Account":
                                    BEGIN
                                        IF ("Sales Line"."No." = '') AND ("Sales Line".Amount = 0) THEN
                                            EXIT;

                                        IF "Sales Line"."No." <> '' THEN
                                            IF GLAcc.GET("Sales Line"."No.") THEN BEGIN
                                                IF GLAcc.Blocked THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        GLAcc.FIELDCAPTION(Blocked), FALSE, GLAcc.TABLECAPTION, "Sales Line"."No."));
                                                IF NOT GLAcc."Direct Posting" AND ("Sales Line"."Line No." <= OrigMaxLineNo) THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        GLAcc.FIELDCAPTION("Direct Posting"), TRUE, GLAcc.TABLECAPTION, "Sales Line"."No."));
                                            END ELSE
                                                AddError(
                                                  STRSUBSTNO(
                                                    Text008,
                                                    GLAcc.TABLECAPTION, "Sales Line"."No."));
                                    END;
                                "Sales Line".Type::Item:
                                    BEGIN
                                        IF ("Sales Line"."No." = '') AND ("Sales Line".Quantity = 0) THEN
                                            EXIT;

                                        IF "Sales Line"."No." <> '' THEN
                                            IF Item.GET("Sales Line"."No.") THEN BEGIN
                                                IF Item.Blocked THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        Item.FIELDCAPTION(Blocked), FALSE, Item.TABLECAPTION, "Sales Line"."No."));
                                                IF Item.Reserve = Item.Reserve::Always THEN BEGIN
                                                    "Sales Line".CALCFIELDS("Reserved Quantity");
                                                    IF "Sales Line"."Document Type" IN ["Sales Line"."Document Type"::"Return Order", "Sales Line"."Document Type"::"Credit Memo"] THEN BEGIN
                                                        IF ("Sales Line".SignedXX("Sales Line".Quantity) < 0) AND (ABS("Sales Line"."Reserved Quantity") < ABS("Sales Line"."Return Qty. to Receive")) THEN
                                                            AddError(
                                                              STRSUBSTNO(
                                                                Text015,
                                                                "Sales Line".FIELDCAPTION("Reserved Quantity"), "Sales Line".SignedXX("Sales Line"."Return Qty. to Receive")));
                                                    END ELSE
                                                        IF ("Sales Line".SignedXX("Sales Line".Quantity) < 0) AND (ABS("Sales Line"."Reserved Quantity") < ABS("Sales Line"."Qty. to Ship")) THEN
                                                            AddError(
                                                              STRSUBSTNO(
                                                                Text015,
                                                                "Sales Line".FIELDCAPTION("Reserved Quantity"), "Sales Line".SignedXX("Sales Line"."Qty. to Ship")));
                                                END
                                            END ELSE
                                                AddError(
                                                  STRSUBSTNO(
                                                    Text008,
                                                    Item.TABLECAPTION, "Sales Line"."No."));
                                    END;
                                "Sales Line".Type::Resource:
                                    BEGIN
                                        IF ("Sales Line"."No." = '') AND ("Sales Line".Quantity = 0) THEN
                                            EXIT;

                                        IF "Sales Line"."No." <> '' THEN
                                            IF Res.GET("Sales Line"."No.") THEN BEGIN
                                                IF Res.Blocked THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        Res.FIELDCAPTION(Blocked), FALSE, Res.TABLECAPTION, "Sales Line"."No."));
                                            END ELSE
                                                AddError(
                                                  STRSUBSTNO(
                                                    Text008,
                                                    Res.TABLECAPTION, "Sales Line"."No."));
                                    END;
                                "Sales Line".Type::"Fixed Asset":
                                    BEGIN
                                        IF ("Sales Line"."No." = '') AND ("Sales Line".Quantity = 0) THEN
                                            EXIT;
                                        IF "Sales Line"."No." <> '' THEN
                                            IF FA.GET("Sales Line"."No.") THEN BEGIN
                                                IF FA.Blocked THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        FA.FIELDCAPTION(Blocked), FALSE, FA.TABLECAPTION, "Sales Line"."No."));
                                                IF FA.Inactive THEN
                                                    AddError(
                                                      STRSUBSTNO(
                                                        Text007,
                                                        FA.FIELDCAPTION(Inactive), FALSE, FA.TABLECAPTION, "Sales Line"."No."));
                                                IF "Sales Line"."Depreciation Book Code" = '' THEN
                                                    AddError(STRSUBSTNO(Text006, "Sales Line".FIELDCAPTION("Depreciation Book Code")))
                                                ELSE
                                                    IF NOT FADeprBook.GET("Sales Line"."No.", "Sales Line"."Depreciation Book Code") THEN
                                                        AddError(
                                                          STRSUBSTNO(
                                                          Text017,
                                                          FADeprBook.TABLECAPTION, "Sales Line"."No.", "Sales Line"."Depreciation Book Code"));
                                            END ELSE
                                                AddError(
                                                  STRSUBSTNO(
                                                    Text008,
                                                    FA.TABLECAPTION, "Sales Line"."No."));
                                    END;
                            END;
                            IF NOT DimMgt.CheckDimIDComb("Sales Line"."Dimension Set ID") THEN
                                AddError(DimMgt.GetDimCombErr);
                            IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Sales Line"."Dimension Set ID") THEN
                                AddError(DimMgt.GetDimValuePostingErr)
                            ELSE BEGIN
                                IF NOT DimMgt.CheckDimIDComb("Sales Line"."Dimension Set ID") THEN
                                    AddError(DimMgt.GetDimCombErr);

                                TableID[1] := DimMgt.TypeToTableID3("Sales Line".Type);
                                No[1] := "Sales Line"."No.";
                                TableID[2] := DATABASE::Job;
                                No[2] := "Sales Line"."Job No.";
                                IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Sales Line"."Dimension Set ID") THEN
                                    AddError(DimMgt.GetDimValuePostingErr);
                                IF "Sales Line"."Line No." > OrigMaxLineNo THEN BEGIN
                                    "Sales Line"."No." := '';
                                    "Sales Line".Type := "Sales Line".Type::" ";
                                END;
                            END;

                            // NAVIN
                            /*  StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                              StructureLineDetails.SETRANGE("Document Type", "Sales Line"."Document Type");
                              StructureLineDetails.SETRANGE("Document No.", "Sales Line"."Document No.");
                              StructureLineDetails.SETRANGE("Item No.", "Sales Line"."No.");
                              StructureLineDetails.SETRANGE("Line No.", "Sales Line"."Line No.");
                            IF StructureLineDetails.FIND('-') THEN
                                REPEAT
                                    IF NOT StructureLineDetails."Payable to Third Party" THEN BEGIN
                                        IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                            ChargesAmount := ChargesAmount + StructureLineDetails.Amount;
                                        IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                            OtherTaxesAmount := OtherTaxesAmount + StructureLineDetails.Amount;
                                    END;
                                UNTIL StructureLineDetails.NEXT = 0;*/ //B2BUPG
                            // NAVIN

                            //Rev01 Start

                            //RoundLoop, Footer (4) - OnPreSection()
                            //CurrReport.SHOWOUTPUT("Sales Line"."Inv. Discount Amount" <> 0);
                            tax := 0;

                            //IF "Sales Header".Structure <> 'SERVICE' THEN BEGIN
                            /*
                             IF SalesLine."Qty. to Ship">0 THEN BEGIN
                              IF SalesLine."BED %"<>0 THEN
                                dutyper:='12.3%'
                              ELSE
                                dutyper:='';
                             END;
                            */

                            //Dutycap := 'Central Excise';
                            //dutyper := '12.5%';
                            //dutyper:='12.3%';
                            //taxcap:='CST';
                            //vatcap := '';
                            //IF (SalesLine."Tax Group Code" = 'MPBIVAT') OR (SalesLine."Tax Group Code" = 'MPBI') THEN
                            //dutyper := '12.5%';

                            //SL.RESET;
                            //SL.SETRANGE(SL."Document No.", "Sales Header"."No.");
                            //SL.SETFILTER(SL."No.", '<>%1', '');
                            //IF SL.FINDFIRST THEN BEGIN
                            //IF SL."Tax Area Code" = 'SALES VAT' THEN
                            //taxcap := 'VAT'
                            //ELSE
                            // IF SL."Tax Area Code" = 'SALES CST' THEN
                            //taxcap := 'CST';
                            //s1 := FORMAT(SL."Tax %") + '%';
                            //END;
                            /*IF "Sales Header"."Form Code" = 'C' THEN
                                s1 := '2%'

                            ELSE
                                s1 := '5%';*/

                            //END ELSE BEGIN
                            //Dutycap := 'ServiceTax';
                            /*
                            dutyper:='12%';
                            s1:='3%';
                            taxcap:='ECESS';
                            */
                            //SL.RESET;
                            //SL.SETRANGE(SL."Document No.", "Sales Header"."No.");
                            //SL.SETFILTER(SL."No.", '<>%1', '');
                            //SL.SETFILTER(SL."Service Tax Group", '<>%1', '');//B2BUpg
                            //B2BUpg
                            /*
                            IF SL.FINDFIRST THEN BEGIN
                                vatcap := '';
                                STS.RESET;
                                //STS.SETRANGE(STS.Code, SL."Service Tax Group");//B2BUpg
                                IF "Sales Header"."Posting Date" <> 0D THEN
                                    STS.SETRANGE(STS."From Date", 0D, "Sales Header"."Posting Date")
                                ELSE
                                    STS.SETRANGE(STS."From Date", 0D, WORKDATE);
                                IF STS.FINDLAST THEN BEGIN
                                    dutyper := FORMAT(STS."Service Tax %") + ' %';
                                    IF STS."SB Cess%" <> 0 THEN BEGIN
                                        taxcap := 'SBCess';
                                        s1 := FORMAT(STS."SB Cess%") + ' %';
                                    END
                                    ELSE BEGIN
                                        taxcap := 'ECess';
                                        s1 := FORMAT(STS."eCess %") + ' %';
                                    END;
                                    IF STS."KK Cess%" <> 0 THEN BEGIN
                                        vatcap := 'KKCess';
                                        s2 := FORMAT(STS."KK Cess%") + ' %';
                                    END
                                    ELSE BEGIN
                                        taxcap += ' & S.H.E Cess';
                                        s1 := FORMAT(STS."eCess %" + STS."SHE Cess %") + ' %';
                                    END;
                                END;
                            END;*///B2BUpg

                            //END;

                            //RoundLoop, Footer (4) - OnPreSection()

                            //ADSK
                            LineAmountVar += TempSalesLine."Line Amount";

                            /* ExciseVar += ROUND(TempSalesLine."Excise Amount", 1) + ROUND(TempSalesLine."Service Tax Amount", 1);
                             IF TempSalesLine."Service Tax SBC Amount" > 0 THEN
                                 SalesLineTaxAmt += ROUND(TempSalesLine."Service Tax SBC Amount", 1)
                             ELSE
                                 SalesLineTaxAmt += ROUND(TempSalesLine."Service Tax eCess Amount", 1) + ROUND(TempSalesLine."Tax Amount", 1) + ROUND(TempSalesLine."Service Tax eCess Amount" / 2, 1);
                             IF TempSalesLine."KK Cess Amount" > 0 THEN
                                 KKCessAmt += ROUND(TempSalesLine."KK Cess Amount", 1);*/

                            //Rev01 End
                            CalculateGSTCompAmount();

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATNoError := FALSE;
                            ApplNoError := FALSE;
                            //CurrReport.CREATETOTALS(TempSalesLine."KK Cess Amount");//B2BUpg
                            MoreLines := TempSalesLine.FIND('+');
                            WHILE MoreLines AND (TempSalesLine.Description = '') AND (TempSalesLine."Description 2" = '') AND
                                  (TempSalesLine."No." = '') AND (TempSalesLine.Quantity = 0) AND
                                  (TempSalesLine.Amount = 0)
                            DO
                                MoreLines := TempSalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            TempSalesLine.SETRANGE("Line No.", 0, TempSalesLine."Line No.");
                            SETRANGE(Number, 1, TempSalesLine.COUNT);

                            SumLineAmount := 0;
                            SumInvDiscountAmount := 0;
                            SumSalesLineExciseAmount := 0;
                            SumSalesLineTaxAmount := 0;
                            SumLineServiceTaxAmount := 0;
                            SumLineServiceTaxECessAmount := 0;
                            SumLineServiceTaxSHECessAmount := 0;
                            SumTotalTDSTCSInclSHECESS := 0;
                            SumSalesLineAmountToCusTomer := 0;
                            SumSvcTaxSBCAmount := 0;
                            SumKKCessAmount := 0;
                            SumSalesLineGSTAmount := 0;
                            // NAVIN
                            /*CurrReport.CREATETOTALS(TempSalesLine."Service Tax Amount", TempSalesLine."Service Tax eCess Amount");
                            CurrReport.CREATETOTALS(TempSalesLine."Line Amount", TempSalesLine."Excise Base Amount", TempSalesLine."Excise Amount",
                                                     TempSalesLine."Amount Including Excise", TempSalesLine."Tax Base Amount", TempSalesLine."Amount Including Tax",
                                                     TempSalesLine.Amount, TempSalesLine."Tax Amount", TempSalesLine."RDSO Charges");*/

                            // NAVIN
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control150; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control151; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control173; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control171; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control169; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control175; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control176; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control177; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control178; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control179; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control181; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control182; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control183; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control184; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control185; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control150Caption; VATAmountLine__VAT_Amount__Control150CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control151Caption; VATAmountLine__VAT_Base__Control151CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control173Caption; VATAmountLine__Invoice_Discount_Amount__Control173CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control171Caption; VATAmountLine__Inv__Disc__Base_Amount__Control171CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control169Caption; VATAmountLine__Line_Amount__Control169CaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control155; ContinuedCaption_Control155Lbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."VAT Base", VATAmountLine."VAT Amount", VATAmountLine."Amount Including VAT",
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control88; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control165; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control167; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control241; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control242; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control243; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control245; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control246; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control88Caption; VALVATAmountLCY_Control88CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control165Caption; VALVATBaseLCY_Control165CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control167Caption; VATAmountLine__VAT____Control167CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control241Caption; VATAmountLine__VAT_Identifier__Control241CaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control87; ContinuedCaption_Control87Lbl)
                        {
                        }
                        column(ContinuedCaption_Control244; ContinuedCaption_Control244Lbl)
                        {
                        }
                        column(TotalCaption_Control247; TotalCaption_Control247Lbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                               VATAmountLine."VAT Base", "Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Posting Date", "Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount", "Sales Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text050 + Text051
                            ELSE
                                VALSpecLCYHeader := Text050 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text052, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem("Item Charge Assignment (Sales)"; "Item Charge Assignment (Sales)")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("Document No.");
                        DataItemLinkReference = "Sales Line";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Document Line No.", "Line No.");
                        column(Item_Charge_Assignment__Sales___Qty__to_Assign_; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Amount_to_Assign_; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Item_Charge_No__; "Item Charge No.")
                        {
                        }
                        column(SalesLine2_Description; SalesLine2.Description)
                        {
                        }
                        column(SalesLine2_Quantity; SalesLine2.Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(Item_Charge_Assignment__Sales___Item_No__; "Item No.")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Qty__to_Assign__Control209; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Unit_Cost_; "Unit Cost")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Amount_to_Assign__Control216; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Qty__to_Assign__Control221; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Amount_to_Assign__Control222; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Qty__to_Assign__Control224; "Qty. to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Amount_to_Assign__Control225; "Amount to Assign")
                        {
                        }
                        column(Item_Charge_Assignment__Sales__Document_Type; "Document Type")
                        {
                        }
                        column(Item_Charge_Assignment__Sales__Document_No_; "Document No.")
                        {
                        }
                        column(Item_Charge_Assignment__Sales__Document_Line_No_; "Document Line No.")
                        {
                        }
                        column(Item_Charge_Assignment__Sales__Line_No_; "Line No.")
                        {
                        }
                        column(Item_Charge_SpecificationCaption; Item_Charge_SpecificationCaptionLbl)
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Item_Charge_No__Caption; FIELDCAPTION("Item Charge No."))
                        {
                        }
                        column(SalesLine2_DescriptionCaption; SalesLine2_DescriptionCaptionLbl)
                        {
                        }
                        column(SalesLine2_QuantityCaption; SalesLine2_QuantityCaptionLbl)
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Item_No__Caption; FIELDCAPTION("Item No."))
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Qty__to_Assign__Control209Caption; FIELDCAPTION("Qty. to Assign"))
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                        {
                        }
                        column(Item_Charge_Assignment__Sales___Amount_to_Assign__Control216Caption; FIELDCAPTION("Amount to Assign"))
                        {
                        }
                        column(ContinuedCaption_Control210; ContinuedCaption_Control210Lbl)
                        {
                        }
                        column(TotalCaption_Control220; TotalCaption_Control220Lbl)
                        {
                        }
                        column(ContinuedCaption_Control223; ContinuedCaption_Control223Lbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF SalesLine2.GET("Document Type", "Document No.", "Document Line No.") THEN;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCostAssignment THEN
                                CurrReport.BREAK;
                            CurrReport.CREATETOTALS("Amount to Assign", "Qty. to Assign");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CLEAR(TempSalesLine);
                        CLEAR(SalesPost);
                        VATAmountLine.DELETEALL;
                        TempSalesLine.DELETEALL;
                        SalesPost.GetSalesLines("Sales Header", TempSalesLine, 1);
                        TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, VATAmountLine);
                        TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, VATAmountLine);
                        VATAmount := VATAmountLine.GetTotalVATAmount;
                        VATBaseAmount := VATAmountLine.GetTotalVATBase;
                        VATDiscountAmount :=
                          VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                        TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                        AppliedServiceTaxSBCAmt := 0;
                        AppliedKKCessAmt := 0;
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                TableID: array[10] of Integer;
                No: array[10] of Code[20];
                STBaseAmt: Decimal;
            begin
                //IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);//B2BUpg
                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.SalesHeaderSellTo(SellToAddr, "Sales Header");
                FormatAddr.SalesHeaderBillTo(BillToAddr, "Sales Header");
                FormatAddr.SalesHeaderShipTo(ShipToAddr, ShipToAddr, "Sales Header");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text004, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text033, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text005, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text004, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text033, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text005, "Currency Code");
                END;

                Invoice := InvOnNextPostReq;
                Ship := ShipReceiveOnNextPostReq;
                Receive := ShipReceiveOnNextPostReq;

                VerifySellToCust("Sales Header");
                VerifyBillToCust("Sales Header");

                SalesSetup.GET;

                VerifyPostingDate("Sales Header");

                IF "Document Date" <> 0D THEN
                    IF "Document Date" <> NORMALDATE("Document Date") THEN
                        AddError(STRSUBSTNO(Text009, FIELDCAPTION("Document Date")));

                CASE "Document Type" OF
                    "Document Type"::Order:
                        Receive := FALSE;
                    "Document Type"::Invoice:
                        BEGIN
                            Ship := TRUE;
                            Invoice := TRUE;
                            Receive := FALSE;
                        END;
                    "Document Type"::"Return Order":
                        Ship := FALSE;
                    "Document Type"::"Credit Memo":
                        BEGIN
                            Ship := FALSE;
                            Invoice := TRUE;
                            Receive := TRUE;
                        END;
                END;

                IF NOT (Ship OR Invoice OR Receive) THEN
                    AddError(
                      STRSUBSTNO(
                        Text034,
                        FIELDCAPTION(Ship), FIELDCAPTION(Invoice), FIELDCAPTION(Receive)));

                IF Invoice THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "No.");
                    SalesLine.SETFILTER(Quantity, '<>0');
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        SalesLine.SETFILTER("Qty. to Invoice", '<>0');
                    Invoice := SalesLine.FINDFIRST;
                    IF Invoice AND (NOT Ship) AND ("Document Type" = "Document Type"::Order) THEN BEGIN
                        Invoice := FALSE;
                        REPEAT
                            Invoice := (SalesLine."Quantity Shipped" - SalesLine."Quantity Invoiced") <> 0;
                        UNTIL Invoice OR (SalesLine.NEXT = 0);
                    END ELSE
                        IF Invoice AND (NOT Receive) AND ("Document Type" = "Document Type"::"Return Order") THEN BEGIN
                            Invoice := FALSE;
                            REPEAT
                                Invoice := (SalesLine."Return Qty. Received" - SalesLine."Quantity Invoiced") <> 0;
                            UNTIL Invoice OR (SalesLine.NEXT = 0);
                        END;
                END;

                IF Ship THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "No.");
                    SalesLine.SETFILTER(Quantity, '<>0');
                    IF "Document Type" = "Document Type"::Order THEN
                        SalesLine.SETFILTER("Qty. to Ship", '<>0');
                    SalesLine.SETRANGE("Shipment No.", '');
                    Ship := SalesLine.FIND('-');
                END;
                IF Receive THEN BEGIN
                    SalesLine.RESET;
                    SalesLine.SETRANGE("Document Type", "Document Type");
                    SalesLine.SETRANGE("Document No.", "No.");
                    SalesLine.SETFILTER(Quantity, '<>0');
                    IF "Document Type" = "Document Type"::"Return Order" THEN
                        SalesLine.SETFILTER("Return Qty. to Receive", '<>0');
                    SalesLine.SETRANGE("Return Receipt No.", '');
                    Receive := SalesLine.FIND('-');
                END;

                IF NOT (Ship OR Invoice OR Receive) THEN
                    AddError(Text012);

                IF Invoice THEN
                    IF NOT ("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) THEN
                        IF "Due Date" = 0D THEN
                            AddError(STRSUBSTNO(Text006, FIELDCAPTION("Due Date")));

                IF Ship AND ("Shipping No." = '') THEN // Order,Invoice
                    IF ("Document Type" = "Document Type"::Order) OR
                       (("Document Type" = "Document Type"::Invoice) AND SalesSetup."Shipment on Invoice")
                    THEN
                        IF "Shipping No. Series" = '' THEN
                            AddError(
                              STRSUBSTNO(
                                Text006,
                                FIELDCAPTION("Shipping No. Series")));

                IF Receive AND ("Return Receipt No." = '') THEN // Return Order,Credit Memo
                    IF ("Document Type" = "Document Type"::"Return Order") OR
                       (("Document Type" = "Document Type"::"Credit Memo") AND SalesSetup."Return Receipt on Credit Memo")
                    THEN
                        IF "Return Receipt No. Series" = '' THEN
                            AddError(
                              STRSUBSTNO(
                                Text006,
                                FIELDCAPTION("Return Receipt No. Series")));

                IF Invoice AND ("Posting No." = '') THEN
                    IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                        IF "Posting No. Series" = '' THEN
                            AddError(
                              STRSUBSTNO(
                                Text006,
                                FIELDCAPTION("Posting No. Series")));

                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                SalesLine.SETFILTER("Purch. Order Line No.", '<>0');
                IF SalesLine.FIND('-') THEN BEGIN
                    DropShipOrder := TRUE;
                    IF Ship THEN
                        REPEAT
                            IF PurchOrderHeader."No." <> SalesLine."Purchase Order No." THEN BEGIN
                                PurchOrderHeader.GET(PurchOrderHeader."Document Type"::Order, SalesLine."Purchase Order No.");
                                IF PurchOrderHeader."Pay-to Vendor No." = '' THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text013,
                                        PurchOrderHeader.FIELDCAPTION("Pay-to Vendor No.")));
                                IF PurchOrderHeader."Receiving No." = '' THEN
                                    IF PurchOrderHeader."Receiving No. Series" = '' THEN
                                        AddError(
                                          STRSUBSTNO(
                                            Text013,
                                            PurchOrderHeader.FIELDCAPTION("Receiving No. Series")));
                            END;
                        UNTIL SalesLine.NEXT = 0;
                END;

                IF "Document Type" IN ["Document Type"::Order, "Document Type"::Invoice] THEN
                    IF SalesSetup."Ext. Doc. No. Mandatory" AND ("External Document No." = '') THEN
                        AddError(STRSUBSTNO(Text006, FIELDCAPTION("External Document No.")));

                IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                    AddError(DimMgt.GetDimCombErr);

                TableID[1] := DATABASE::Customer;
                No[1] := "Bill-to Customer No.";
                //TableID[2] := DATABASE::Job;
                //No[2] := "Job No.";
                TableID[3] := DATABASE::"Salesperson/Purchaser";
                No[3] := "Salesperson Code";
                TableID[4] := DATABASE::Campaign;
                No[4] := "Campaign No.";
                TableID[5] := DATABASE::"Responsibility Center";
                No[5] := "Responsibility Center";
                IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") THEN
                    AddError(DimMgt.GetDimValuePostingErr);

                ServiceTaxAmt := 0;
                ServiceTaxECessAmt := 0;
                ServiceTaxSHECessAmt := 0;
                ServiceTaxSBCAmt := 0;
                KKCessAmt := 0;
                SalesLine.RESET;
                SalesLine.SETRANGE("Document Type", "Document Type");
                SalesLine.SETRANGE("Document No.", "No.");
                IF SalesLine.FIND('-') THEN
                    REPEAT
                    //B2BUpg>>
                    /*
                        IF SalesLine."Direct Debit To PLA / RG" THEN BEGIN
                            GenJnlLine.RESET;
                            GenJnlLine.SETRANGE("Journal Template Name", '');
                            GenJnlLine.SETRANGE("Journal Batch Name", '');
                            GenJnlLine.SETRANGE("Document No.", "No.");
                            IF NOT GenJnlLine.FINDFIRST THEN
                                AddError(Text16500)
                            ELSE
                                CheckTotalExciseAmount;
                        END;

                    IF SalesLine.Quantity <> 0 THEN BEGIN
                        ServiceTaxAmt += ROUND(SalesLine."Service Tax Amount" * SalesLine."Qty. to Invoice" / SalesLine.Quantity);
                        ServiceTaxECessAmt += ROUND(SalesLine."Service Tax eCess Amount" * SalesLine."Qty. to Invoice" / SalesLine.Quantity);
                        ServiceTaxSHECessAmt += ROUND(SalesLine."Service Tax SHE Cess Amount" * SalesLine."Qty. to Invoice" / SalesLine.Quantity);
                        ServiceTaxSBCAmt += ROUND(SalesLine."Service Tax SBC Amount" * SalesLine."Qty. to Invoice" / SalesLine.Quantity);
                        KKCessAmt += ROUND(SalesLine."KK Cess Amount" * SalesLine."Qty. to Invoice" / SalesLine.Quantity);
                        STBaseAmt += SalesLine."Service Tax Base";
                        ServiceTaxExists := ((ServiceTaxAmt + ServiceTaxECessAmt + ServiceTaxSHECessAmt + STBaseAmt +
                                              ServiceTaxSBCAmt + KKCessAmt) <> 0) OR "ST Pure Agent";
                    END;
                    */
                    //B2BUpg<<
                    UNTIL SalesLine.NEXT = 0;

                TCSAmountApplied := 0;
                TCSEntry.RESET;
                TCSEntry.SETCURRENTKEY("Document No.", "Posting Date");
                TCSEntry.SETRANGE("Document Type", SalesHeader."Applies-to Doc. Type");
                TCSEntry.SETRANGE("Document No.", SalesHeader."Applies-to Doc. No.");
                IF TCSEntry.FINDFIRST THEN
                    REPEAT
                        TCSAmountApplied += TCSEntry."TCS Amount" + TCSEntry."Surcharge Amount" +
                          TCSEntry."eCESS Amount" + TCSEntry."SHE Cess Amount";
                    UNTIL (TCSEntry.NEXT = 0);


                // added by vishnu
                SalesLine2.RESET;
                SalesLine2.SETFILTER("Document No.", "Sales Header"."No.");
                SalesLine2.SETFILTER("Qty. to Ship", '>0');
                IF SalesLine2.FINDSET THEN
                    REPEAT
                    BEGIN
                        //Dutycap:='Excise(8.24%)';
                        //Dutycap:='Excise'+FORMAT(SalesLine."Excise Effective Rate");
                        MESSAGE(FORMAT(GetTCSAmt("Sales Header", SalesLine2)));
                        //dutyper:=FORMAT("Sales Line"."BED %"); bed need to gather from excise posting group
                        TCSAmount += GetTCSAmt("Sales Header", SalesLine2);
                        //MESSAGE(FORMAT(TCSAmount));
                    END;
                    UNTIL SalesLine2.NEXT = 0;

                // Added by Vishnu
            end;

            trigger OnPreDataItem()
            begin
                tax := 0;
                TCSAmount := 0;
                SalesHeader.COPY("Sales Header");
                SalesHeader.FILTERGROUP := 2;
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
                IF SalesHeader.FINDFIRST THEN BEGIN
                    CASE TRUE OF
                        ShipReceiveOnNextPostReq AND InvOnNextPostReq:
                            ShipInvText := Text000;
                        ShipReceiveOnNextPostReq:
                            ShipInvText := Text001;
                        InvOnNextPostReq:
                            ShipInvText := Text002;
                    END;
                    ShipInvText := STRSUBSTNO(Text003, ShipInvText);
                END;
                SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::"Return Order");
                IF SalesHeader.FINDFIRST THEN BEGIN
                    CASE TRUE OF
                        ShipReceiveOnNextPostReq AND InvOnNextPostReq:
                            ReceiveInvText := Text018;
                        ShipReceiveOnNextPostReq:
                            ReceiveInvText := Text031;
                        InvOnNextPostReq:
                            ReceiveInvText := Text002;
                    END;
                    ReceiveInvText := STRSUBSTNO(Text032, ReceiveInvText);
                END;
                //TempSvcTaxAppllBuffer.DELETEALL;
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
                    group("Order/Return Order Posting")
                    {
                        Caption = 'Order/Return Order Posting';
                    }
                    field("Ship/Receive"; ShipReceiveOnNextPostReq)
                    {
                        Caption = 'Ship/Receive';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            //Rev01 Start
                            IF NOT ShipReceiveOnNextPostReq THEN
                                InvOnNextPostReq := TRUE;
                            //Rev01 End
                        end;
                    }
                    field(Invoice; InvOnNextPostReq)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            //Rev01 Start
                            IF NOT InvOnNextPostReq THEN
                                ShipReceiveOnNextPostReq := TRUE;
                            //Rev01 End
                        end;
                    }
                    field("Show Dimensions"; ShowDim)
                    {
                        ApplicationArea = All;
                    }
                    field("Show Item Charge Assgnt."; ShowCostAssignment)
                    {
                        ApplicationArea = All;
                    }
                    field("Description Enable or Not"; descrienable)
                    {
                        ApplicationArea = All;
                    }
                    field(Advance; advance)
                    {
                        ApplicationArea = All;
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

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
    end;

    trigger OnPreReport()
    begin
        SalesHeaderFilter := "Sales Header".GETFILTERS;
    end;

    var
        Text000: Label 'Ship and Invoice';
        Text001: Label 'Ship';
        Text002: Label 'Invoice';
        Text003: Label 'Order Posting: %1';
        Text004: Label 'Total %1';
        Text005: Label 'Total %1 Incl. VAT';
        Text006: Label '%1 must be specified.';
        Text007: Label '%1 must be %2 for %3 %4.';
        Text008: Label '%1 %2 does not exist.';
        Text009: Label '%1 must not be a closing date.';
        Text010: Label '%1 is not within your allowed range of posting dates.';
        Text012: Label 'There is nothing to post.';
        Text013: Label '%1 must be entered on the purchase order header.';
        Text014: Label 'Sales Document: %1';
        Text015: Label '%1 must be %2.';
        Text016: Label '%1 %2 does not exist on customer entries.';
        Text017: Label '%1 %2 %3 does not exist.';
        Text018: Label 'Receive and Credit Memo';
        Text019: Label '%1 %2 must be specified.';
        Text020: Label '%1 must be 0 when %2 is 0.';
        Text021: Label 'Drop shipments are only possible for items.';
        Text022: Label 'You cannot ship sales order line %1 because the line is marked';
        Text023: Label 'as a drop shipment and is not yet associated with a purchase order.';
        Text024: Label 'The %1 on the shipment is not the same as the %1 on the sales header.';
        Text025: Label 'Line %1 of the return receipt %2, which you are attempting to invoice, has already been invoiced.';
        Text026: Label 'Line %1 of the shipment %2, which you are attempting to invoice, has already been invoiced.';
        Text027: Label '%1 must have the same sign as the shipments.';
        Text031: Label 'Receive';
        Text032: Label 'Return Order Posting: %1';
        Text033: Label 'Total %1 Excl. VAT';
        Text034: Label 'Enter "Yes" in %1 and/or %2 and/or %3.';
        Text035: Label 'You must enter the customer''s %1.';
        Text036: Label 'The quantity you are attempting to invoice is greater than the quantity in shipment %1.';
        Text037: Label 'The quantity you are attempting to invoice is greater than the quantity in return receipt %1.';
        Text038: Label 'The %1 on the return receipt is not the same as the %1 on the sales header.';
        Text039: Label '%1 must have the same sign as the return receipt.';
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        Cust: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesLine2: Record "Sales Line";
        TempSalesLine: Record "Sales Line" temporary;
        GLAcc: Record "G/L Account";
        Item: Record Item;
        Res: Record Resource;
        SaleShptLine: Record "Sales Shipment Line";
        ReturnRcptLine: Record "Return Receipt Line";
        PurchOrderHeader: Record "Purchase Header";
        GenPostingSetup: Record "General Posting Setup";
        VATPostingSetup: Record "VAT Posting Setup";
        CustLedgEntry: Record "Cust. Ledger Entry";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        FA: Record "Fixed Asset";
        FADeprBook: Record "FA Depreciation Book";
        CurrExchRate: Record "Currency Exchange Rate";
        InvtPeriod: Record "Inventory Period";
        //GSTComponent: Record "GST Component";//B2BUpg
        DetailedGSTEntryBuffer: Record "Detailed GST Entry Buffer";
        //GSTManagement: Codeunit "GST Management";//B2BUpg
        FormatAddr: Codeunit "Format Address";

        DimMgt: Codeunit DimensionManagement;
        SalesPost: Codeunit "Sales-Post";
        GSTComponentCode: array[20] of Code[10];
        SalesHeaderFilter: Text;
        SellToAddr: array[8] of Text[50];
        BillToAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        ShipInvText: Text[50];
        ReceiveInvText: Text[50];
        DimText: Text[120];
        OldDimText: Text[75];
        ErrorText: array[99] of Text[250];
        QtyToHandleCaption: Text[30];
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        VATDate: Date;
        MaxQtyToBeInvoiced: Decimal;
        RemQtyToBeInvoiced: Decimal;
        QtyToBeInvoiced: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        QtyToHandle: Decimal;
        ErrorCounter: Integer;
        OrigMaxLineNo: Integer;
        DropShipOrder: Boolean;
        InvOnNextPostReq: Boolean;
        ShipReceiveOnNextPostReq: Boolean;
        VATNoError: Boolean;
        ApplNoError: Boolean;
        ShowDim: Boolean;
        Continue: Boolean;
        ShowCostAssignment: Boolean;
        Text043: Label '%1 must be zero.';
        Text045: Label '%1 must not be %2 for %3 %4.';
        MoreLines: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text046: Label '%1 must be completely preinvoiced before you can ship or invoice the line.';
        Text050: Label 'VAT Amount Specification in ';
        Text051: Label 'Local Currency';
        Text052: Label 'Exchange rate: %1/%2';
        Text053: Label '%1 can at most be %2.';
        Text054: Label '%1 must be at least %2.';
        SumLineAmount: Decimal;
        SumInvDiscountAmount: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        ThirdPartyAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        GenJnlLine: Record "Gen. Journal Line";
        Text16500: Label 'Excise Cenvat Claim Form not filled.';
        Text16501: Label 'Please Check The Total of PLA , RG 23 A and RG 23 C with Excise Amount.';
        TCSAmountApplied: Decimal;
        TCSEntry: Record "TCS Entry";
        TotalAmount: Decimal;
        //ServiceTaxEntry: Record "Service Tax Entry";//B2BUpg
        Text16504: Label 'Sum of CIF Amount and BCD Amount should not be 0 for CVD Calculation.';
        ServiceTaxAmt: Decimal;
        ServiceTaxECessAmt: Decimal;
        AppliedServiceTaxAmt: Decimal;
        AppliedServiceTaxECessAmt: Decimal;
        ServiceTaxSHECessAmt: Decimal;
        AppliedServiceTaxSHECessAmt: Decimal;
        Text16505: Label 'Line Amount should not be %1 in Document Type = %2 Document No. = %3 Line No. = %4.';
        Text16506: Label 'CVD must be No in Structure Details Code = %1 Calculation Order = %2 Type = %3 Tax/Charge Group = %4 Tax/Charge Code = %5.';
        Text16507: Label 'One of the Structure detail should have Include PIT Calculation = Yes for Document Type = %1,  Document No. = %2,  Line No. = %3 for Price Inclusive of Tax = Yes.';
        Text16508: Label 'Fixed asset or capital item must not be used in trading transaction in Document Type=%1,Document No.=%2,Line No.=%3.';
        SumSalesLineExciseAmount: Decimal;
        SumSalesLineTaxAmount: Decimal;
        SumLineServiceTaxAmount: Decimal;
        SumLineServiceTaxECessAmount: Decimal;
        SumLineServiceTaxSHECessAmount: Decimal;
        SumSalesLineAmountToCusTomer: Decimal;
        SumTotalTDSTCSInclSHECESS: Decimal;
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        TaxType: Text[30];
        Text16509: Label 'Tax Type must be %1 for Tax Jurisdiction in Tax Area Line %2';
        //TempSvcTaxAppllBuffer: Record "Service Tax Application Buffer" temporary;//B2BUpg
        ServiceTaxExists: Boolean;
        Text16523: Label 'The Applied Payment Document %1 should not have amount to apply greater than %2.';
        Text16524: Label 'Service Tax Advance Payment Document/s cannot be applied with non Service Tax Invoice/s.';
        Text16526: Label 'Document Type %1 should not be applied against a Refund document %2 having service tax on advance payment.';
        Text16527: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Rounding Precision/Type.';
        Text16528: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Group Codes.';
        Text16529: Label 'Invoice/s and Payment/s documents cannot be applied as both have different Service Tax Registration Nos.';
        Text16530: Label 'Payment Document with ST Pure Agent and Service Tax on Advance Payment should be applied with invoice having check mark on ST Pure Agent.';
        Sales_Document___TestCaptionLbl: Label 'PROFORMA INVOICE';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Ship_toCaptionLbl: Label 'Ship-to';
        Sell_toCaptionLbl: Label 'Sell-to';
        Bill_toCaptionLbl: Label 'Bill-to';
        Sales_Header___Posting_Date_CaptionLbl: Label 'Posting Date';
        Sales_Header___Document_Date_CaptionLbl: Label 'Document Date';
        Sales_Header___Due_Date_CaptionLbl: Label 'Due Date';
        Sales_Header___Pmt__Discount_Date_CaptionLbl: Label 'Pmt. Discount Date';
        Sales_Header___Posting_Date__Control105CaptionLbl: Label 'Posting Date';
        Sales_Header___Document_Date__Control106CaptionLbl: Label 'Document Date';
        Sales_Header___Order_Date_CaptionLbl: Label 'Order Date';
        Sales_Header___Shipment_Date_CaptionLbl: Label 'Shipment Date';
        Sales_Header___Due_Date__Control19CaptionLbl: Label 'Due Date';
        Sales_Header___Pmt__Discount_Date__Control22CaptionLbl: Label 'Pmt. Discount Date';
        Sales_Header___Posting_Date__Control131CaptionLbl: Label 'Posting Date';
        Sales_Header___Document_Date__Control132CaptionLbl: Label 'Document Date';
        Sales_Header___Posting_Date__Control137CaptionLbl: Label 'Posting Date';
        Sales_Header___Document_Date__Control138CaptionLbl: Label 'Document Date';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        ErrorText_Number_CaptionLbl: Label 'Warning!';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        Sales_Line___Line_Discount___CaptionLbl: Label 'Line Disc. %';
        Sales_Line___Line_Discount_Amount_CaptionLbl: Label 'Line Discount Amount';
        AmountCaptionLbl: Label 'Amount';
        TempSalesLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        TempSalesLine__Excise_Amount_CaptionLbl: Label 'Excise Amount';
        TempSalesLine__Tax_Amount_CaptionLbl: Label 'Tax Amount';
        ServiceTaxAmtCaptionLbl: Label 'Service Tax Amount';
        Charges_AmountCaptionLbl: Label 'Charges Amount';
        Other_Taxes_AmountCaptionLbl: Label 'Other Taxes Amount';
        ServiceTaxECessAmtCaptionLbl: Label 'Service TaxeCess Amount';
        TCS_AmountCaptionLbl: Label 'TCS Amount';
        TCS_Amount__Applied_CaptionLbl: Label 'TCS Amount (Applied)';
        Svc_Tax_Amt__Applied_CaptionLbl: Label 'Svc Tax Amt (Applied)';
        Svc_Tax_eCess_Amt__Applied_CaptionLbl: Label 'Svc Tax eCess Amt (Applied)';
        ServiceTaxSHECessAmtCaptionLbl: Label 'Service Tax SHECess Amt';
        Svc_Tax_SHECess_Amt_Applied_CaptionLbl: Label 'Svc Tax SHECess Amt(Applied)';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        ErrorText_Number__Control97CaptionLbl: Label 'Warning!';
        VATAmountLine__VAT_Amount__Control150CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control151CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__Invoice_Discount_Amount__Control173CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control171CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Line_Amount__Control169CaptionLbl: Label 'Line Amount';
        ContinuedCaptionLbl: Label 'Continued';
        ContinuedCaption_Control155Lbl: Label 'Continued';
        TotalCaptionLbl: Label 'Total';
        VALVATAmountLCY_Control88CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control165CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT____Control167CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Identifier__Control241CaptionLbl: Label 'VAT Identifier';
        ContinuedCaption_Control87Lbl: Label 'Continued';
        ContinuedCaption_Control244Lbl: Label 'Continued';
        TotalCaption_Control247Lbl: Label 'Total';
        Item_Charge_SpecificationCaptionLbl: Label 'Item Charge Specification';
        SalesLine2_DescriptionCaptionLbl: Label 'Description';
        SalesLine2_QuantityCaptionLbl: Label 'Assignable Qty';
        ContinuedCaption_Control210Lbl: Label 'Continued';
        TotalCaption_Control220Lbl: Label 'Total';
        ContinuedCaption_Control223Lbl: Label 'Continued';
        //StructureLineDetails: Record "Structure Order Line Details";//B2BUpg
        check: Report Check;
        s: Decimal;
        DescriptionLine: array[2] of Text[132];
        s1: Text[30];
        desc: Text[30];
        s2: Text[30];
        n: Integer;
        c: Integer;
        tax: Decimal;
        taxamt: Decimal;
        advance: Decimal;
        Dutycap: Text[30];
        dutyper: Text[30];
        taxcap: Text[30];
        vatcap: Text[30];
        descrienable: Boolean;
        ConsigneeCaptionLbl: Label 'Consignee';
        Sold_toCaptionLbl: Label 'Sold-to';
        With_Ref_to_the_above: Label 'With Reference to the above purchase order ,we here by inform that RDSO inspection is completed/ will be completed in ____ days. Hence We request to kindly Release the payment at the earliest';
        Dear_Sir_CaptionLbl: Label 'Dear Sir,';
        Order_No_CaptionLbl: Label 'Order No.';
        Dt_CaptionLbl: Label 'Dt:';
        TIN_NO__28350166764CaptionLbl: Label 'TIN NO: 37350166764';
        CST_NO__28350166764CaptionLbl: Label 'CST NO: 37350166764(CENTRAL)';
        TOCaptionLbl: Label 'TO';
        DT_Caption_Control1000000014Lbl: Label 'DT:';
        PROFORMA_INVOICECaptionLbl: Label 'PROFORMA INVOICE';
        QtyCaptionLbl: Label 'Qty';
        S_NoCaptionLbl: Label 'S.No';
        Description_of_GoodsCaptionLbl: Label 'Description of Goods';
        RDSO_ChargesCaptionLbl: Label 'RDSO Charges';
        Grand_TotalCaptionLbl: Label 'Grand Total';
        for_EFFTRONICS_SYSTEMS_PVT__LTD__CaptionLbl: Label 'for EFFTRONICS SYSTEMS PVT. LTD.,';
        AUTHORISED_SIGNATORYCaptionLbl: Label 'AUTHORISED SIGNATORY';
        In_words_CaptionLbl: Label '(In words)';
        AdvanceCaptionLbl: Label 'Advance';
        NOTE_Lbl: Label 'NOTE :   ';
        Note1_Lbl: Label '1.SALES TAX CHARGED IN THE ABOVE INVOICE AT 2% AGAINST ''C'' FORM,  IN CASE ';
        C_form_Lbl: Label '''C'' FORM NOT PROVIDED, REMAINING 3% SALES TAX WILL BE CHARGED EXTRA.';
        Note2_Lbl: Label '2. TRANSPORTATION EXTRA AT ACTUALS OR TO PAY.';
        LineAmountVar: Decimal;
        ExciseVar: Decimal;
        SalesLineTaxAmt: Decimal;
        AppliedServiceTaxSBCAmount: Decimal;
        AppliedServiceTaxSBCAmt: Decimal;
        ServiceTaxSBCAmt: Decimal;
        SumSvcTaxSBCAmount: Decimal;
        ServiceTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        Svc_Tax_SBC_Amt__Applied_CaptionLbl: Label 'Svc Tax SBC Amt (Applied)';
        AppliedKKCessAmount: Decimal;
        AppliedKKCessAmt: Decimal;
        KKCessAmt: Decimal;
        SumKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        KK_Cess_Amt__Applied_CaptionLbl: Label 'KK Cess Amt (Applied)';
        //STS: Record "Service Tax Setup";//B2BUpg
        SL: Record "Sales Line";
        SumSalesLineGSTAmount: Decimal;
        GSTCompAmount: array[20] of Decimal;
        IsGSTApplicable: Boolean;
        j: Integer;
        CompanyRegistrationLbl: Label 'Company Registration No.';
        CustomerRegistrationLbl: Label 'Customer GST Reg No.';
        TCSAmount: Decimal;
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        CessAmt: Decimal;
        TCSAmt: Decimal;

    local procedure GetSalesGSTAmount(SalesInvoiceHeader: Record "Sales Invoice Header";
SalesInvoiceLine: Record "Sales Invoice Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    local procedure GetSalesGSTPercent(SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindFirst() then
            exit(DetailedGSTLedgerEntry."GST %");

    end;

    local procedure GetSalesGSTLineWise(SalesInvoiceLine: Record "Sales Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindFirst() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            exit(DetailedGSTLedgerEntry."GST Amount");

        end;
    end;

    local procedure GetTCSAmt(SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line"): Decimal
    var
        TCSEntry: Record "TCS Entry";
    begin
        Clear(TCSAmt);
        TCSEntry.Reset();
        TCSEntry.SetRange("Document No.", SalesLine."Document No.");
        if TCSEntry.FindSet() then
            repeat
                if SalesHeader."Currency Code" <> '' then
                    TCSAmt += SalesHeader."Currency Factor" * TCSEntry."Total TCS Including SHE CESS"
                else
                    TCSAmt += TCSEntry."Total TCS Including SHE CESS";
                TCSAmt := Round(TCSAmt, 1);
            until TCSEntry.Next() = 0;
    end;

    local procedure GetTCSAmtLineWise(SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
    var
        TCSEntry: Record "TCS Entry";
        TCSAmt: decimal;
    begin
        Clear(TCSAmt);
        TCSEntry.Reset();
        TCSEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        TCSEntry.SetRange("TCS Nature of Collection", SalesInvoiceLine."TCS Nature of Collection");
        if TCSEntry.FindSet() then
            repeat
                if TCSEntry."Currency Code" <> '' then
                    TCSAmt += TCSEntry."Currency Factor" * TCSEntry."Total TCS Including SHE CESS"
                else
                    TCSAmt += TCSEntry."Total TCS Including SHE CESS";
                TCSAmt := Round(TCSAmt, 1);
            until TCSEntry.Next() = 0;
    end;

    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter := ErrorCounter + 1;
        ErrorText[ErrorCounter] := Text;
    end;

    local procedure CheckShptLines(SalesLine2: Record "Sales Line")
    var
        TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        IF ABS(RemQtyToBeInvoiced) > ABS(SalesLine2."Qty. to Ship") THEN BEGIN
            SaleShptLine.RESET;
            CASE SalesLine2."Document Type" OF
                SalesLine2."Document Type"::Order:
                    BEGIN
                        SaleShptLine.SETCURRENTKEY("Order No.", "Order Line No.");
                        SaleShptLine.SETRANGE("Order No.", SalesLine2."Document No.");
                        SaleShptLine.SETRANGE("Order Line No.", SalesLine2."Line No.");
                    END;
                SalesLine2."Document Type"::Invoice:
                    BEGIN
                        SaleShptLine.SETRANGE("Document No.", SalesLine2."Shipment No.");
                        SaleShptLine.SETRANGE("Line No.", SalesLine2."Shipment Line No.");
                    END;
            END;

            SaleShptLine.SETFILTER("Qty. Shipped Not Invoiced", '<>0');
            IF SaleShptLine.FIND('-') THEN
                REPEAT
                    DimMgt.GetDimensionSet(TempPostedDimSetEntry, SaleShptLine."Dimension Set ID");
                    IF NOT DimMgt.CheckDimIDConsistency(
                         TempDimSetEntry, TempPostedDimSetEntry, DATABASE::"Sales Line", DATABASE::"Sales Shipment Line")
                    THEN
                        AddError(DimMgt.GetDocDimConsistencyErr);
                    IF SaleShptLine."Sell-to Customer No." <> SalesLine2."Sell-to Customer No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("Sell-to Customer No.")));
                    IF SaleShptLine.Type <> SalesLine2.Type THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION(Type)));
                    IF SaleShptLine."No." <> SalesLine2."No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("No.")));
                    IF SaleShptLine."Gen. Bus. Posting Group" <> SalesLine2."Gen. Bus. Posting Group" THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("Gen. Bus. Posting Group")));
                    IF SaleShptLine."Gen. Prod. Posting Group" <> SalesLine2."Gen. Prod. Posting Group" THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("Gen. Prod. Posting Group")));
                    IF SaleShptLine."Location Code" <> SalesLine2."Location Code" THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("Location Code")));
                    IF SaleShptLine."Job No." <> SalesLine2."Job No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text024,
                            SalesLine2.FIELDCAPTION("Job No.")));

                    IF -SalesLine."Qty. to Invoice" * SaleShptLine.Quantity < 0 THEN
                        AddError(
                          STRSUBSTNO(
                            Text027, SalesLine2.FIELDCAPTION("Qty. to Invoice")));

                    QtyToBeInvoiced := RemQtyToBeInvoiced - SalesLine."Qty. to Ship";
                    IF ABS(QtyToBeInvoiced) > ABS(SaleShptLine.Quantity - SaleShptLine."Quantity Invoiced") THEN
                        QtyToBeInvoiced := -(SaleShptLine.Quantity - SaleShptLine."Quantity Invoiced");
                    RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                    SaleShptLine."Quantity Invoiced" := SaleShptLine."Quantity Invoiced" - QtyToBeInvoiced;
                    SaleShptLine."Qty. Shipped Not Invoiced" :=
                      SaleShptLine.Quantity - SaleShptLine."Quantity Invoiced"
                UNTIL (SaleShptLine.NEXT = 0) OR (ABS(RemQtyToBeInvoiced) <= ABS(SalesLine2."Qty. to Ship"))
            ELSE
                AddError(
                  STRSUBSTNO(
                    Text026,
                    SalesLine2."Shipment Line No.",
                    SalesLine2."Shipment No."));
        END;

        IF ABS(RemQtyToBeInvoiced) > ABS(SalesLine2."Qty. to Ship") THEN
            IF SalesLine2."Document Type" = SalesLine2."Document Type"::Invoice THEN
                AddError(
                  STRSUBSTNO(
                    Text036,
                    SalesLine2."Shipment No."));
    end;

    local procedure CheckRcptLines(SalesLine2: Record "Sales Line")
    var
        TempPostedDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        IF ABS(RemQtyToBeInvoiced) > ABS(SalesLine2."Return Qty. to Receive") THEN BEGIN
            ReturnRcptLine.RESET;
            CASE SalesLine2."Document Type" OF
                SalesLine2."Document Type"::"Return Order":
                    BEGIN
                        ReturnRcptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
                        ReturnRcptLine.SETRANGE("Return Order No.", SalesLine2."Document No.");
                        ReturnRcptLine.SETRANGE("Return Order Line No.", SalesLine2."Line No.");
                    END;
                SalesLine2."Document Type"::"Credit Memo":
                    BEGIN
                        ReturnRcptLine.SETRANGE("Document No.", SalesLine2."Return Receipt No.");
                        ReturnRcptLine.SETRANGE("Line No.", SalesLine2."Return Receipt Line No.");
                    END;
            END;

            ReturnRcptLine.SETFILTER("Return Qty. Rcd. Not Invd.", '<>0');
            IF ReturnRcptLine.FIND('-') THEN
                REPEAT
                    DimMgt.GetDimensionSet(TempPostedDimSetEntry, ReturnRcptLine."Dimension Set ID");
                    IF NOT DimMgt.CheckDimIDConsistency(
                         TempDimSetEntry, TempPostedDimSetEntry, DATABASE::"Sales Line", DATABASE::"Return Receipt Line")
                    THEN
                        AddError(DimMgt.GetDocDimConsistencyErr);
                    IF ReturnRcptLine."Sell-to Customer No." <> SalesLine2."Sell-to Customer No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("Sell-to Customer No.")));
                    IF ReturnRcptLine.Type <> SalesLine2.Type THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION(Type)));
                    IF ReturnRcptLine."No." <> SalesLine2."No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("No.")));
                    IF ReturnRcptLine."Gen. Bus. Posting Group" <> SalesLine2."Gen. Bus. Posting Group" THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("Gen. Bus. Posting Group")));
                    IF ReturnRcptLine."Gen. Prod. Posting Group" <> SalesLine2."Gen. Prod. Posting Group" THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("Gen. Prod. Posting Group")));
                    IF ReturnRcptLine."Location Code" <> SalesLine2."Location Code" THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("Location Code")));
                    IF ReturnRcptLine."Job No." <> SalesLine2."Job No." THEN
                        AddError(
                          STRSUBSTNO(
                            Text038,
                            SalesLine2.FIELDCAPTION("Job No.")));

                    IF SalesLine."Qty. to Invoice" * ReturnRcptLine.Quantity < 0 THEN
                        AddError(
                          STRSUBSTNO(
                            Text039, SalesLine2.FIELDCAPTION("Qty. to Invoice")));
                    QtyToBeInvoiced := RemQtyToBeInvoiced - SalesLine."Return Qty. to Receive";
                    IF ABS(QtyToBeInvoiced) > ABS(ReturnRcptLine.Quantity - ReturnRcptLine."Quantity Invoiced") THEN
                        QtyToBeInvoiced := ReturnRcptLine.Quantity - ReturnRcptLine."Quantity Invoiced";
                    RemQtyToBeInvoiced := RemQtyToBeInvoiced - QtyToBeInvoiced;
                    ReturnRcptLine."Quantity Invoiced" := ReturnRcptLine."Quantity Invoiced" + QtyToBeInvoiced;
                    ReturnRcptLine."Return Qty. Rcd. Not Invd." :=
                      ReturnRcptLine.Quantity - ReturnRcptLine."Quantity Invoiced";
                UNTIL (ReturnRcptLine.NEXT = 0) OR (ABS(RemQtyToBeInvoiced) <= ABS(SalesLine2."Return Qty. to Receive"))
            ELSE
                AddError(
                  STRSUBSTNO(
                    Text025,
                    SalesLine2."Return Receipt Line No.",
                    SalesLine2."Return Receipt No."));
        END;

        IF ABS(RemQtyToBeInvoiced) > ABS(SalesLine2."Return Qty. to Receive") THEN
            IF SalesLine2."Document Type" = SalesLine2."Document Type"::"Credit Memo" THEN
                AddError(
                  STRSUBSTNO(
                    Text037,
                    SalesLine2."Return Receipt No."));
    end;

    local procedure IsInvtPosting(): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SETRANGE("Document Type", "Sales Header"."Document Type");
        SalesLine.SETRANGE("Document No.", "Sales Header"."No.");
        SalesLine.SETFILTER(Type, '%1|%2', SalesLine.Type::Item, SalesLine.Type::"Charge (Item)");
        IF SalesLine.ISEMPTY THEN
            EXIT(FALSE);
        IF "Sales Header".Ship THEN BEGIN
            SalesLine.SETFILTER("Qty. to Ship", '<>%1', 0);
            IF NOT SalesLine.ISEMPTY THEN
                EXIT(TRUE);
        END;
        IF "Sales Header".Receive THEN BEGIN
            SalesLine.SETFILTER("Return Qty. to Receive", '<>%1', 0);
            IF NOT SalesLine.ISEMPTY THEN
                EXIT(TRUE);
        END;
        IF "Sales Header".Invoice THEN BEGIN
            SalesLine.SETFILTER("Qty. to Invoice", '<>%1', 0);
            IF NOT SalesLine.ISEMPTY THEN
                EXIT(TRUE);
        END;
    end;


    procedure AddDimToTempLine(SalesLine: Record "Sales Line")
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.GET;

        TableID[1] := DimMgt.TypeToTableID3(SalesLine.Type);
        No[1] := SalesLine."No.";
        TableID[2] := DATABASE::Job;
        No[2] := SalesLine."Job No.";
        TableID[3] := DATABASE::"Responsibility Center";
        No[3] := SalesLine."Responsibility Center";

        SalesLine."Shortcut Dimension 1 Code" := '';
        SalesLine."Shortcut Dimension 2 Code" := '';
        SalesLine."Dimension Set ID" :=
          DimMgt.GetDefaultDimID(TableID, No, SourceCodeSetup.Sales, SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code",
            SalesLine."Dimension Set ID", DATABASE::Customer);
    end;

    local procedure CheckType(SalesLine2: Record "Sales Line")
    begin
        CASE SalesLine2.Type OF
            SalesLine2.Type::"G/L Account":
                BEGIN
                    IF (SalesLine2."No." = '') AND (SalesLine2.Amount = 0) THEN
                        EXIT;

                    IF SalesLine2."No." <> '' THEN
                        IF GLAcc.GET(SalesLine2."No.") THEN BEGIN
                            IF GLAcc.Blocked THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007,
                                    GLAcc.FIELDCAPTION(Blocked), FALSE, GLAcc.TABLECAPTION, SalesLine2."No."));
                            IF NOT GLAcc."Direct Posting" AND (SalesLine2."Line No." <= OrigMaxLineNo) THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007,
                                    GLAcc.FIELDCAPTION("Direct Posting"), TRUE, GLAcc.TABLECAPTION, SalesLine2."No."));
                        END ELSE
                            AddError(
                              STRSUBSTNO(
                                Text008,
                                GLAcc.TABLECAPTION, SalesLine2."No."));
                END;
            SalesLine2.Type::Item:
                BEGIN
                    IF (SalesLine2."No." = '') AND (SalesLine2.Quantity = 0) THEN
                        EXIT;

                    IF SalesLine2."No." <> '' THEN
                        IF Item.GET(SalesLine2."No.") THEN BEGIN
                            IF Item.Blocked THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007,
                                    Item.FIELDCAPTION(Blocked), FALSE, Item.TABLECAPTION, SalesLine2."No."));
                            IF Item.Reserve = Item.Reserve::Always THEN BEGIN
                                SalesLine2.CALCFIELDS("Reserved Quantity");
                                IF SalesLine2."Document Type" IN [SalesLine2."Document Type"::"Return Order", SalesLine2."Document Type"::"Credit Memo"] THEN BEGIN
                                    IF (SalesLine2.SignedXX(SalesLine2.Quantity) < 0) AND (ABS(SalesLine2."Reserved Quantity") < ABS(SalesLine2."Return Qty. to Receive")) THEN
                                        AddError(
                                          STRSUBSTNO(
                                            Text015,
                                            SalesLine2.FIELDCAPTION("Reserved Quantity"), SalesLine2.SignedXX(SalesLine2."Return Qty. to Receive")));
                                END ELSE
                                    IF (SalesLine2.SignedXX(SalesLine2.Quantity) < 0) AND (ABS(SalesLine2."Reserved Quantity") < ABS(SalesLine2."Qty. to Ship")) THEN
                                        AddError(
                                          STRSUBSTNO(
                                            Text015,
                                            SalesLine2.FIELDCAPTION("Reserved Quantity"), SalesLine2.SignedXX(SalesLine2."Qty. to Ship")));
                            END
                        END ELSE
                            AddError(
                              STRSUBSTNO(
                                Text008,
                                Item.TABLECAPTION, SalesLine2."No."));
                END;
            SalesLine2.Type::Resource:
                BEGIN
                    IF (SalesLine2."No." = '') AND (SalesLine2.Quantity = 0) THEN
                        EXIT;

                    IF Res.GET(SalesLine2."No.") THEN BEGIN
                        IF Res."Privacy Blocked" THEN
                            AddError(
                              STRSUBSTNO(
                                Text007,
                                Res.FIELDCAPTION("Privacy Blocked"), FALSE, Res.TABLECAPTION, SalesLine2."No."));
                        IF Res.Blocked THEN
                            AddError(
                              STRSUBSTNO(
                                Text007,
                                Res.FIELDCAPTION(Blocked), FALSE, Res.TABLECAPTION, SalesLine2."No."));
                    END ELSE
                        AddError(
                          STRSUBSTNO(
                            Text008,
                            Res.TABLECAPTION, SalesLine2."No."));
                END;
            SalesLine2.Type::"Fixed Asset":
                BEGIN
                    IF (SalesLine2."No." = '') AND (SalesLine2.Quantity = 0) THEN
                        EXIT;
                    IF SalesLine2."No." <> '' THEN
                        IF FA.GET(SalesLine2."No.") THEN BEGIN
                            IF FA.Blocked THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007,
                                    FA.FIELDCAPTION(Blocked), FALSE, FA.TABLECAPTION, SalesLine2."No."));
                            IF FA.Inactive THEN
                                AddError(
                                  STRSUBSTNO(
                                    Text007,
                                    FA.FIELDCAPTION(Inactive), FALSE, FA.TABLECAPTION, SalesLine2."No."));
                            IF SalesLine2."Depreciation Book Code" = '' THEN
                                AddError(STRSUBSTNO(Text006, SalesLine2.FIELDCAPTION("Depreciation Book Code")))
                            ELSE
                                IF NOT FADeprBook.GET(SalesLine2."No.", SalesLine2."Depreciation Book Code") THEN
                                    AddError(
                                      STRSUBSTNO(
                                        Text017,
                                        FADeprBook.TABLECAPTION, SalesLine2."No.", SalesLine2."Depreciation Book Code"));
                        END ELSE
                            AddError(
                              STRSUBSTNO(
                                Text008,
                                FA.TABLECAPTION, SalesLine2."No."));
                END;
        END;
    end;

    local procedure VerifySellToCust(SalesHeader: Record "Sales Header")
    var
        ShipQtyExist: Boolean;
    begin
        IF SalesHeader."Sell-to Customer No." = '' THEN
            AddError(STRSUBSTNO(Text006, SalesHeader.FIELDCAPTION("Sell-to Customer No.")))
        ELSE
            IF Cust.GET(SalesHeader."Sell-to Customer No.") THEN BEGIN
                IF (Cust.Blocked = Cust.Blocked::Ship) AND SalesHeader.Ship THEN BEGIN
                    SalesLine2.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine2.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine2.SETFILTER("Qty. to Ship", '>0');
                    IF SalesLine2.FINDFIRST THEN
                        ShipQtyExist := TRUE;
                END;
                IF Cust."Privacy Blocked" THEN
                    AddError(Cust.GetPrivacyBlockedGenericErrorText(Cust));
                IF (Cust.Blocked = Cust.Blocked::All) OR
                   ((Cust.Blocked = Cust.Blocked::Invoice) AND
                    (NOT (SalesHeader."Document Type" IN
                          [SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::"Return Order"]))) OR
                   ShipQtyExist
                THEN
                    AddError(
                      STRSUBSTNO(
                        Text045,
                        Cust.FIELDCAPTION(Blocked), Cust.Blocked, Cust.TABLECAPTION, SalesHeader."Sell-to Customer No."))
            END ELSE
                AddError(
                  STRSUBSTNO(
                    Text008,
                    Cust.TABLECAPTION, SalesHeader."Sell-to Customer No."));
    end;

    local procedure VerifyBillToCust(SalesHeader: Record "Sales Header")
    begin
        IF SalesHeader."Bill-to Customer No." = '' THEN
            AddError(STRSUBSTNO(Text006, SalesHeader.FIELDCAPTION("Bill-to Customer No.")))
        ELSE BEGIN
            IF SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." THEN
                IF Cust.GET(SalesHeader."Bill-to Customer No.") THEN BEGIN
                    IF Cust."Privacy Blocked" THEN
                        AddError(Cust.GetPrivacyBlockedGenericErrorText(Cust));
                    IF (Cust.Blocked = Cust.Blocked::All) OR
                       ((Cust.Blocked = Cust.Blocked::Invoice) AND
                        (SalesHeader."Document Type" IN
                         [SalesHeader."Document Type"::"Credit Memo", SalesHeader."Document Type"::"Return Order"]))
                    THEN
                        AddError(
                          STRSUBSTNO(
                            Text045,
                            Cust.FIELDCAPTION(Blocked), FALSE, Cust.TABLECAPTION, SalesHeader."Bill-to Customer No."));
                END ELSE
                    AddError(
                      STRSUBSTNO(
                        Text008,
                        Cust.TABLECAPTION, SalesHeader."Bill-to Customer No."));
        END;
    end;

    local procedure VerifyPostingDate(SalesHeader: Record "Sales Header")
    var
        InvtPeriodEndDate: Date;
    begin
        IF SalesHeader."Posting Date" = 0D THEN
            AddError(STRSUBSTNO(Text006, SalesHeader.FIELDCAPTION("Posting Date")))
        ELSE
            IF SalesHeader."Posting Date" <> NORMALDATE(SalesHeader."Posting Date") THEN
                AddError(STRSUBSTNO(Text009, SalesHeader.FIELDCAPTION("Posting Date")))
            ELSE BEGIN
                IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                    IF USERID <> '' THEN
                        IF UserSetup.GET(USERID) THEN BEGIN
                            AllowPostingFrom := UserSetup."Allow Posting From";
                            AllowPostingTo := UserSetup."Allow Posting To";
                        END;
                    IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                        AllowPostingFrom := GLSetup."Allow Posting From";
                        AllowPostingTo := GLSetup."Allow Posting To";
                    END;
                    IF AllowPostingTo = 0D THEN
                        AllowPostingTo := DMY2DATE(31, 12, 9999);
                END;
                IF (SalesHeader."Posting Date" < AllowPostingFrom) OR (SalesHeader."Posting Date" > AllowPostingTo) THEN
                    AddError(
                      STRSUBSTNO(
                        Text010, SalesHeader.FIELDCAPTION("Posting Date")))
                ELSE
                    IF IsInvtPosting THEN BEGIN
                        InvtPeriodEndDate := SalesHeader."Posting Date";
                        IF NOT InvtPeriod.IsValidDate(InvtPeriodEndDate) THEN
                            AddError(
                              STRSUBSTNO(Text010, FORMAT(SalesHeader."Posting Date")))
                    END;
            END;
    end;


    procedure CheckTotalExciseAmount()
    var
    // ExciseCenvatClaim: Record "Excise Cenvat Claim";// EFFUPG>>
    begin
        // EFFUPG<<
        /*
        ExciseCenvatClaim.RESET;
        ExciseCenvatClaim.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
        ExciseCenvatClaim.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
        ExciseCenvatClaim.SETRANGE("Line No.", GenJnlLine."Line No.");
        ExciseCenvatClaim.SETRANGE("Document No.", GenJnlLine."Document No.");
        IF ExciseCenvatClaim.FINDFIRST THEN BEGIN

            IF (ExciseCenvatClaim."BED Amount" <> ExciseCenvatClaim."PLA BED Amount") OR
               (ExciseCenvatClaim."AED(GSI) Amount" <> ExciseCenvatClaim."PLA AED(GSI) Amount") OR
               (ExciseCenvatClaim."AED(TTA) Amount" <> ExciseCenvatClaim."PLA AED(TTA) Amount") OR
               (ExciseCenvatClaim."SED Amount" <> ExciseCenvatClaim."PLA SED Amount") OR
               (ExciseCenvatClaim."SAED Amount" <> ExciseCenvatClaim."PLA SAED Amount") OR
               (ExciseCenvatClaim."CESS Amount" <> ExciseCenvatClaim."PLA CESS Amount") OR
               (ExciseCenvatClaim."NCCD Amount" <> ExciseCenvatClaim."PLA NCCD Amount") OR
               (ExciseCenvatClaim."eCess Amount" <> ExciseCenvatClaim."PLA eCess Amount") OR
               (ExciseCenvatClaim."SHE Cess Amount" <> ExciseCenvatClaim."PLA SHE Cess Amount") OR
               (ExciseCenvatClaim."ADET Amount" <> ExciseCenvatClaim."PLA ADET Amount") OR
               (ExciseCenvatClaim."ADE Amount" <> ExciseCenvatClaim."PLA ADE Amount") OR
               (ExciseCenvatClaim."Excise Charge Amount" <> ExciseCenvatClaim."PLA Excise Charge Amount") THEN
                AddError(Text16501);
        END;
        */ // EFFUPG>>
    end;


    procedure FilterAppliedEntries()
    var
        OldCustLedgEntry: Record "Cust. Ledger Entry";
        //ServiceTaxEntry: Record "Service Tax Entry";//B2BUpg
        Cust: Record Customer;
        Currency: Record Currency;
        GenLedgSetup: Record "General Ledger Setup";
        SalesLine3: Record "Sales Line";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        ApplyingDate: Date;
        AccType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        AmountforAppl: Decimal;
        AppliedAmount: Decimal;
        AppliedAmountLCY: Decimal;
        RemainingAmount: Decimal;
        AmountToBeApplied: Decimal;
        AppliedServiceTaxAmount: Decimal;
        AppliedServiceTaxEcessAmount: Decimal;
        AppliedServiceTaxSHEcessAmount: Decimal;
    begin
        AmountforAppl := TempSalesLine."Amount To Customer";
        ApplyingDate := "Sales Header"."Posting Date";
        Cust.GET("Sales Header"."Bill-to Customer No.");
        IF "Sales Header"."Applies-to Doc. No." <> '' THEN BEGIN
            OldCustLedgEntry.RESET;
            OldCustLedgEntry.SETCURRENTKEY("Document No.");
            OldCustLedgEntry.SETRANGE("Document No.", "Sales Header"."Applies-to Doc. No.");
            OldCustLedgEntry.SETRANGE("Document Type", "Sales Header"."Applies-to Doc. Type");
            OldCustLedgEntry.SETRANGE("Customer No.", "Sales Header"."Bill-to Customer No.");
            OldCustLedgEntry.SETRANGE(Open, TRUE);
            OldCustLedgEntry.FINDFIRST;
            /*IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                EXIT;*///B2BUpg
            IF OldCustLedgEntry."Posting Date" > ApplyingDate THEN
                ApplyingDate := OldCustLedgEntry."Posting Date";
            GenJnlApply.CheckAgainstApplnCurrency("Sales Header"."Currency Code", OldCustLedgEntry."Currency Code", AccType::Vendor, TRUE);
            OldCustLedgEntry.CALCFIELDS("Remaining Amount");
            IF "Sales Header"."Currency Code" <> '' THEN BEGIN
                Currency.GET("Sales Header"."Currency Code");
                FindAmtForAppln(OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                  OldCustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision", AmountforAppl);
            END ELSE BEGIN
                GenLedgSetup.GET;
                FindAmtForAppln(OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                  OldCustLedgEntry."Remaining Amount", GenLedgSetup."Amount Rounding Precision", AmountforAppl);
            END;

            AppliedAmountLCY := ABS(AppliedAmountLCY);
            //B2BUpg
            /*CheckAppliedInvHasServTax(OldCustLedgEntry);
            CheckRoundingParameters(OldCustLedgEntry);
            CheckRefundApplicationOnline(OldCustLedgEntry);
            CheckApplofSTpureAgntOnline(OldCustLedgEntry);*/

            //B2BUpg<<
            //B2BUpg>>
            /*
                        IF TempSalesLine."Service Tax Amount" <> 0 THEN BEGIN
                            ServiceTaxEntry.RESET;
                            ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                            ServiceTaxEntry.SETRANGE("Service Tax Group Code", "Sales Line"."Service Tax Group");
                            ServiceTaxEntry.SETRANGE("Service Tax Registration No.", "Sales Line"."Service Tax Registration No.");
                            ServiceTaxEntry.SETRANGE("ST Pure Agent", FALSE);
                            IF ServiceTaxEntry.FINDSET THEN
                                REPEAT
                                    RemainingAmount := 0;
                                    AmountToBeApplied := 0;
                                    RemainingAmount := ABS(ServiceTaxEntry."Amount Including Service Tax" - ServiceTaxEntry."Amount Received/Paid");
                                    IF RemainingAmount > 0 THEN BEGIN
                                        IF RemainingAmount >= ABS(AppliedAmountLCY) THEN
                                            AmountToBeApplied := ABS(AppliedAmountLCY)
                                        ELSE
                                            AmountToBeApplied := RemainingAmount;
                                    END;
                                    AppliedAmountLCY := AppliedAmountLCY - AmountToBeApplied;
                                    CheckAppliedCustPayment(OldCustLedgEntry, AmountToBeApplied, AmountforAppl);
                                    AmountforAppl := AmountforAppl - AmountToBeApplied;
                                    AppliedServiceTaxAmount :=
                                      ((AmountToBeApplied / ServiceTaxEntry."Amount Including Service Tax") *
                                        (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                          ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                           ServiceTaxEntry."KK Cess Amount"));
                                    AppliedServiceTaxEcessAmount :=
                                      ((AppliedServiceTaxAmount * ServiceTaxEntry."eCess Amount") /
                                        (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                          ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                           ServiceTaxEntry."KK Cess Amount"));
                                    AppliedServiceTaxSHEcessAmount :=
                                      ((AppliedServiceTaxAmount * ServiceTaxEntry."SHE Cess Amount") /
                                        (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                          ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                           ServiceTaxEntry."KK Cess Amount"));
                                    AppliedServiceTaxSBCAmount :=
                                      ((AppliedServiceTaxAmount * ServiceTaxEntry."Service Tax SBC Amount") /
                                        (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                          ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                           ServiceTaxEntry."KK Cess Amount"));
                                    AppliedKKCessAmount :=
                                      ((AppliedServiceTaxAmount * ServiceTaxEntry."KK Cess Amount") /
                                        (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                          ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                           ServiceTaxEntry."KK Cess Amount"));
                                    AppliedServiceTaxSHEcessAmount := ROUND(AppliedServiceTaxSHEcessAmount);
                                    AppliedServiceTaxEcessAmount := ROUND(AppliedServiceTaxEcessAmount);
                                    AppliedServiceTaxSBCAmount := ROUND(AppliedServiceTaxSBCAmount);
                                    AppliedKKCessAmount := ROUND(AppliedKKCessAmount);
                                    AppliedServiceTaxAmount := ROUND(AppliedServiceTaxAmount - AppliedServiceTaxEcessAmount -
                                     AppliedServiceTaxSHEcessAmount - AppliedServiceTaxSBCAmount - AppliedKKCessAmount);

                                    AppliedServiceTaxSHECessAmt += AppliedServiceTaxSHEcessAmount;
                                    AppliedServiceTaxECessAmt += AppliedServiceTaxEcessAmount;
                                    AppliedServiceTaxAmt += AppliedServiceTaxAmount;
                                    AppliedServiceTaxSBCAmt += AppliedServiceTaxSBCAmount;
                                    AppliedKKCessAmt += AppliedKKCessAmount;
                                UNTIL (ServiceTaxEntry.NEXT = 0) OR (AppliedAmountLCY = 0);
                        END;*/
        END ELSE
            IF "Sales Header"."Applies-to ID" <> '' THEN BEGIN
                // Find the first old entry (Invoice) which the new entry (Payment) should apply to
                OldCustLedgEntry.RESET;
                OldCustLedgEntry.SETCURRENTKEY("Customer No.", "Applies-to ID", Open, Positive, "Due Date");
                OldCustLedgEntry.SETRANGE("Customer No.", "Sales Header"."Bill-to Customer No.");
                OldCustLedgEntry.SETRANGE("Applies-to ID", "Sales Header"."Applies-to ID");
                OldCustLedgEntry.SETRANGE(Open, TRUE);
                IF NOT (Cust."Application Method" = Cust."Application Method"::"Apply to Oldest") THEN
                    OldCustLedgEntry.SETFILTER("Amount to Apply", '<>%1', 0);
                IF Cust."Application Method" = Cust."Application Method"::"Apply to Oldest" THEN
                    OldCustLedgEntry.SETFILTER("Posting Date", '..%1', GenJnlLine."Posting Date");

                // Check Cust Ledger Entry and add to Temp.
                IF SalesSetup."Appln. between Currencies" = SalesSetup."Appln. between Currencies"::None THEN
                    OldCustLedgEntry.SETRANGE("Currency Code", "Sales Header"."Currency Code");

                IF OldCustLedgEntry.FINDSET(FALSE, FALSE) THEN BEGIN
                    REPEAT
                    /*IF OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                        IF GenJnlApply.CheckAgainstApplnCurrency(
                          "Sales Header"."Currency Code", OldCustLedgEntry."Currency Code", AccType::Vendor, FALSE)
                        THEN BEGIN
                            IF (OldCustLedgEntry."Posting Date" > ApplyingDate) AND (OldCustLedgEntry."Applies-to ID" <> '') THEN
                                ApplyingDate := OldCustLedgEntry."Posting Date";
                            OldCustLedgEntry.CALCFIELDS("Remaining Amount");
                            IF "Sales Header"."Currency Code" <> '' THEN BEGIN
                                Currency.GET("Sales Header"."Currency Code");
                                FindAmtForAppln(OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                                  OldCustLedgEntry."Remaining Amount", Currency."Amount Rounding Precision", AmountforAppl);
                            END ELSE BEGIN
                                GenLedgSetup.GET;
                                FindAmtForAppln(OldCustLedgEntry, AppliedAmount, AppliedAmountLCY,
                                OldCustLedgEntry."Remaining Amount", GenLedgSetup."Amount Rounding Precision", AmountforAppl);
                            END;

                            AppliedAmountLCY := ABS(AppliedAmountLCY);*/
                    //B2BUpg
                    /*CheckAppliedInvHasServTax(OldCustLedgEntry);
                    CheckRoundingParameters(OldCustLedgEntry);
                    CheckRefundApplicationOnline(OldCustLedgEntry);
                    CheckApplofSTpureAgntOnline(OldCustLedgEntry);*/
                    //B2BUpg<<
                    /*
                    IF TempSalesLine."Service Tax Amount" <> 0 THEN BEGIN
                        ServiceTaxEntry.RESET;
                        ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                        ServiceTaxEntry.SETRANGE("Service Tax Group Code", "Sales Line"."Service Tax Group");
                        ServiceTaxEntry.SETRANGE("Service Tax Registration No.", "Sales Line"."Service Tax Registration No.");
                        ServiceTaxEntry.SETRANGE("ST Pure Agent", FALSE);
                        IF ServiceTaxEntry.FINDSET THEN
                            REPEAT
                                RemainingAmount := 0;
                                AmountToBeApplied := 0;
                                RemainingAmount := ABS(ServiceTaxEntry."Amount Including Service Tax" - ServiceTaxEntry."Amount Received/Paid");
                                IF RemainingAmount > 0 THEN BEGIN
                                    IF RemainingAmount >= ABS(AppliedAmountLCY) THEN
                                        AmountToBeApplied := ABS(AppliedAmountLCY)
                                    ELSE
                                        AmountToBeApplied := RemainingAmount;
                                END;
                                AppliedAmountLCY := AppliedAmountLCY - AmountToBeApplied;
                                CheckAppliedCustPayment(OldCustLedgEntry, AmountToBeApplied, AmountforAppl);
                                AmountforAppl := AmountforAppl - AmountToBeApplied;
                                AppliedServiceTaxAmount :=
                                  ((AmountToBeApplied / ServiceTaxEntry."Amount Including Service Tax") *
                                    (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                    ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                        ServiceTaxEntry."KK Cess Amount"));
                                AppliedServiceTaxEcessAmount :=
                                  ((AppliedServiceTaxAmount * ServiceTaxEntry."eCess Amount") /
                                    (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                    ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                        ServiceTaxEntry."KK Cess Amount"));
                                AppliedServiceTaxSHEcessAmount :=
                                  ((AppliedServiceTaxAmount * ServiceTaxEntry."SHE Cess Amount") /
                                    (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                    ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                        ServiceTaxEntry."KK Cess Amount"));
                                AppliedServiceTaxSBCAmount :=
                                  ((AppliedServiceTaxAmount * ServiceTaxEntry."Service Tax SBC Amount") /
                                    (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                    ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                        ServiceTaxEntry."KK Cess Amount"));
                                AppliedKKCessAmount :=
                                  ((AppliedServiceTaxAmount * ServiceTaxEntry."KK Cess Amount") /
                                    (ServiceTaxEntry."Service Tax Amount" + ServiceTaxEntry."eCess Amount" +
                                    ServiceTaxEntry."SHE Cess Amount" + ServiceTaxEntry."Service Tax SBC Amount" +
                                        ServiceTaxEntry."KK Cess Amount"));

                                AppliedServiceTaxSHEcessAmount := ROUND(AppliedServiceTaxSHEcessAmount);
                                AppliedServiceTaxEcessAmount := ROUND(AppliedServiceTaxEcessAmount);
                                AppliedServiceTaxSBCAmount := ROUND(AppliedServiceTaxSBCAmount);
                                AppliedKKCessAmount := ROUND(AppliedKKCessAmount);
                                AppliedServiceTaxAmount :=
                                  ROUND(AppliedServiceTaxAmount - AppliedServiceTaxEcessAmount - AppliedServiceTaxSHEcessAmount -
                                    AppliedServiceTaxSBCAmount - AppliedKKCessAmount);

                                AppliedServiceTaxSHECessAmt += AppliedServiceTaxSHEcessAmount;
                                AppliedServiceTaxECessAmt += AppliedServiceTaxEcessAmount;
                                AppliedServiceTaxAmt += AppliedServiceTaxAmount;
                                AppliedServiceTaxSBCAmt += AppliedServiceTaxSBCAmount;
                                AppliedKKCessAmt += AppliedKKCessAmount;
                            UNTIL (ServiceTaxEntry.NEXT = 0) OR (AppliedAmountLCY = 0);
                    END;*/
                    //END;
                    UNTIL OldCustLedgEntry.NEXT = 0;
                END;
            END;
        SalesLine3.COPYFILTERS("Sales Line");
        SalesLine3 := "Sales Line";
        IF SalesLine3.NEXT = 0 THEN BEGIN
            //B2BUpg>>
            /*AppliedServiceTaxSHECessAmt := RoundServiceTaxPrecision(AppliedServiceTaxSHECessAmt);
            AppliedServiceTaxECessAmt := RoundServiceTaxPrecision(AppliedServiceTaxECessAmt);
            AppliedServiceTaxAmt := RoundServiceTaxPrecision(AppliedServiceTaxAmt);
            AppliedServiceTaxSBCAmt := RoundServiceTaxPrecision(AppliedServiceTaxSBCAmt);
            AppliedKKCessAmt := RoundServiceTaxPrecision(AppliedKKCessAmt);*///B2BUpg<<

            ServiceTaxAmt -= ROUND(AppliedServiceTaxAmt);
            ServiceTaxECessAmt -= ROUND(AppliedServiceTaxECessAmt);
            ServiceTaxSHECessAmt -= ROUND(AppliedServiceTaxSHECessAmt);
            ServiceTaxSBCAmt -= ROUND(AppliedServiceTaxSBCAmt);
            KKCessAmt -= ROUND(AppliedKKCessAmt);
            //B2BUpg
            /*ServiceTaxAmt := RoundServiceTaxPrecision(ServiceTaxAmt);
            ServiceTaxECessAmt := RoundServiceTaxPrecision(ServiceTaxECessAmt);
            ServiceTaxSHECessAmt := RoundServiceTaxPrecision(ServiceTaxSHECessAmt);
            ServiceTaxSBCAmt := RoundServiceTaxPrecision(ServiceTaxSBCAmt);
            KKCessAmt := RoundServiceTaxPrecision(KKCessAmt);*///B2BUpg>>
        END;
        IF ServiceTaxSHECessAmt < 0 THEN
            ServiceTaxSHECessAmt := 0;
        IF ServiceTaxECessAmt < 0 THEN
            ServiceTaxECessAmt := 0;
        IF ServiceTaxAmt < 0 THEN
            ServiceTaxAmt := 0;
        IF ServiceTaxSBCAmt < 0 THEN
            ServiceTaxSBCAmt := 0;
        IF KKCessAmt < 0 THEN
            KKCessAmt := 0;
    end;

    local procedure FindAmtForAppln(OldCustLedgEntry: Record "Cust. Ledger Entry"; var AppliedAmount: Decimal; var AppliedAmountLCY: Decimal; OldRemainingAmtBeforeAppln: Decimal; ApplnRoundingPrecision: Decimal; AmountforAppl: Decimal)
    var
        OldAppliedAmount: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        IF OldCustLedgEntry.GETFILTER(Positive) <> '' THEN BEGIN
            IF OldCustLedgEntry."Amount to Apply" <> 0 THEN
                AppliedAmount := -OldCustLedgEntry."Amount to Apply"
            ELSE
                AppliedAmount := -OldCustLedgEntry."Remaining Amount";
        END ELSE BEGIN
            IF OldCustLedgEntry."Amount to Apply" <> 0 THEN BEGIN
                IF (CheckCalcPmtDisc(OldCustLedgEntry, ApplnRoundingPrecision, FALSE, FALSE, AmountforAppl) AND
                  (ABS(OldCustLedgEntry."Amount to Apply") >=
                  ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible")) AND
                  (ABS(AmountforAppl) >=
                     ABS(OldCustLedgEntry."Amount to Apply" - OldCustLedgEntry."Remaining Pmt. Disc. Possible"))) OR
                   OldCustLedgEntry."Accepted Pmt. Disc. Tolerance"
                THEN BEGIN
                    AppliedAmount := -OldCustLedgEntry."Remaining Amount";
                    OldCustLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                END ELSE BEGIN
                    IF ABS(AmountforAppl) <= ABS(OldCustLedgEntry."Amount to Apply") THEN
                        AppliedAmount := AmountforAppl
                    ELSE
                        AppliedAmount := -OldCustLedgEntry."Amount to Apply";
                END;
            END ELSE
                IF ABS(AmountforAppl) < ABS(OldCustLedgEntry."Remaining Amount") THEN
                    AppliedAmount := AmountforAppl
                ELSE
                    AppliedAmount := -OldCustLedgEntry."Remaining Amount";
        END;

        IF SalesHeader."Currency Code" = OldCustLedgEntry."Currency Code" THEN BEGIN
            AppliedAmountLCY := ROUND(AppliedAmount / OldCustLedgEntry."Original Currency Factor");
            OldAppliedAmount := AppliedAmount;
        END ELSE BEGIN
            // Management of posting in multiple currencies
            IF AppliedAmount = -OldCustLedgEntry."Remaining Amount" THEN
                OldAppliedAmount := -OldCustLedgEntry."Remaining Amount"
            ELSE
                OldAppliedAmount :=
                  CurrExchRate.ExchangeAmount(
                    AppliedAmount, SalesHeader."Currency Code",
                    OldCustLedgEntry."Currency Code", SalesHeader."Posting Date");

            IF SalesHeader."Currency Code" <> '' THEN
                AppliedAmountLCY := ROUND(OldAppliedAmount / OldCustLedgEntry."Original Currency Factor")
            ELSE
                AppliedAmountLCY := ROUND(AppliedAmount / SalesHeader."Currency Factor");
        END;
    end;

    local procedure CheckCalcPmtDisc(var OldCustLedgEntry: Record "Cust. Ledger Entry"; ApplnRoundingPrecision: Decimal; CheckFilter: Boolean; CheckAmount: Boolean; AmountforAppl: Decimal): Boolean
    begin
        IF ((OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Invoice) AND
          (SalesHeader."Posting Date" <= OldCustLedgEntry."Pmt. Discount Date"))
        THEN BEGIN
            IF CheckFilter THEN BEGIN
                IF CheckAmount THEN BEGIN
                    IF (OldCustLedgEntry.GETFILTER(Positive) <> '') OR
                      (ABS(AmountforAppl) + ApplnRoundingPrecision >=
                      ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible"))
                    THEN
                        EXIT(TRUE);
                END ELSE BEGIN
                    IF (OldCustLedgEntry.GETFILTER(Positive) <> '')
                    THEN
                        EXIT(TRUE);
                END;
            END ELSE BEGIN
                IF CheckAmount THEN BEGIN
                    IF (ABS(AmountforAppl) + ApplnRoundingPrecision >=
                      ABS(OldCustLedgEntry."Remaining Amount" - OldCustLedgEntry."Remaining Pmt. Disc. Possible"))
                    THEN
                        EXIT(TRUE);
                END ELSE
                    EXIT(TRUE);
            END;
            EXIT(TRUE);
        END;
    end;

    //B2BUpg>>
    /*
procedure RoundServiceTaxPrecision(ServiceTaxAmount: Decimal): Decimal
var
    ServiceTaxRoundingDirection: Text[1];
    ServiceTaxRoundingPrecision: Decimal;
begin

    CASE "Sales Header"."Service Tax Rounding Type" OF
        "Sales Header"."Service Tax Rounding Type"::Nearest:
            ServiceTaxRoundingDirection := '=';
        "Sales Header"."Service Tax Rounding Type"::Up:
            ServiceTaxRoundingDirection := '>';
        "Sales Header"."Service Tax Rounding Type"::Down:
            ServiceTaxRoundingDirection := '<';
    END;
    IF "Sales Header"."Service Tax Rounding Precision" <> 0 THEN
        ServiceTaxRoundingPrecision := "Sales Header"."Service Tax Rounding Precision"
    ELSE
        ServiceTaxRoundingPrecision := 0.01;
    EXIT(ROUND(ServiceTaxAmount, ServiceTaxRoundingPrecision, ServiceTaxRoundingDirection));

end;
//B2BUpg>>
/*
    procedure CheckAppliedInvHasServTax(OldCustLedgEntry: Record "Cust. Ledger Entry")
    var
        SvcTaxEntry: Record "Service Tax Entry";
        SalesLine3: Record "Sales Line";
    begin
        IF OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Payment THEN BEGIN
            IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
                EXIT;
            IF NOT ServiceTaxExists THEN BEGIN
                ServiceTaxEntry.RESET;
                ServiceTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                IF ServiceTaxEntry.FINDFIRST THEN
                    AddError(Text16524);
            END;

            IF ServiceTaxExists THEN BEGIN
                SvcTaxEntry.RESET;
                SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                IF SvcTaxEntry.FINDFIRST THEN BEGIN
                    SalesLine3.RESET;
                    SalesLine3.SETRANGE("Document Type", "Sales Line"."Document Type");
                    SalesLine3.SETRANGE("Document No.", "Sales Line"."Document No.");
                    SalesLine3.SETRANGE("Service Tax Group", SvcTaxEntry."Service Tax Group Code");
                    IF NOT SalesLine3.FINDFIRST THEN
                        AddError(Text16528);
                    SalesLine3.SETRANGE("Service Tax Group");
                    SalesLine3.SETRANGE("Service Tax Registration No.", SvcTaxEntry."Service Tax Registration No.");
                    IF NOT SalesLine3.FINDFIRST THEN
                        AddError(Text16529);
                END;
            END;
        END;
    end;

    procedure CheckRefundApplicationOnline(OldCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        IF OldCustLedgEntry."Serv. Tax on Advance Payment" AND
          (OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Refund)
        THEN
            AddError(STRSUBSTNO(Text16526, "Sales Header"."Document Type", OldCustLedgEntry."Document No."));
    end;


    procedure CheckRoundingParameters(OldCustLedgEntry: Record "Cust. Ledger Entry")
    var
        SvcTaxEntry: Record "Service Tax Entry";
    begin
        IF TempSalesLine."Service Tax Amount" = 0 THEN
            EXIT;
        SvcTaxEntry.RESET;
        SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
        IF NOT SvcTaxEntry.FINDFIRST THEN
            EXIT;
        IF (SvcTaxEntry."Service Tax Amount" + SvcTaxEntry."eCess Amount" + SvcTaxEntry."SHE Cess Amount" +
          SvcTaxEntry."Service Tax SBC Amount" + SvcTaxEntry."KK Cess Amount") = 0 THEN
            EXIT;
        IF ("Sales Header"."Service Tax Rounding Precision" <> SvcTaxEntry."Service Tax Rounding Precision") OR
          ("Sales Header"."Service Tax Rounding Type" <> SvcTaxEntry."Service Tax Rounding Type")
        THEN
            AddError(Text16527);
    end;
    


    procedure CheckAppliedCustPayment(OldCustLedgEntry: Record "Cust. Ledger Entry"; AmountToBeApplied: Decimal; AmountToBeComparedWith: Decimal)
    var
        SvcTaxEntry: Record "Service Tax Entry";
        EntryInserted: Boolean;
    begin
        IF NOT OldCustLedgEntry."Serv. Tax on Advance Payment" THEN
            EXIT;
        SvcTaxEntry.RESET;
        SvcTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
        SvcTaxEntry.SETRANGE("Service Tax Group Code", "Sales Line"."Service Tax Group");
        SvcTaxEntry.SETRANGE("Service Tax Registration No.", "Sales Line"."Service Tax Registration No.");
        IF SvcTaxEntry.FINDFIRST THEN BEGIN
            TempSvcTaxAppllBuffer.Type := TempSvcTaxAppllBuffer.Type::Sale;
            TempSvcTaxAppllBuffer."Document No." := OldCustLedgEntry."Document No.";
            TempSvcTaxAppllBuffer."Service Tax Group Code" := SvcTaxEntry."Service Tax Group Code";
            TempSvcTaxAppllBuffer."Service Tax Registration No." := SvcTaxEntry."Service Tax Registration No.";
            TempSvcTaxAppllBuffer."Transaction No." := OldCustLedgEntry."Transaction No.";
            TempSvcTaxAppllBuffer."Amount to Apply (LCY)" := AmountToBeComparedWith;
            EntryInserted := TempSvcTaxAppllBuffer.INSERT;

            IF TempSvcTaxAppllBuffer."Amount to Apply (LCY)" < ABS(OldCustLedgEntry."Amount to Apply") THEN
                AddError(STRSUBSTNO(Text16523, OldCustLedgEntry."Document No.", -TempSvcTaxAppllBuffer."Amount to Apply (LCY)"));
            TempSvcTaxAppllBuffer."Amount to Apply (LCY)" -= AmountToBeApplied;
            TempSvcTaxAppllBuffer.MODIFY;
        END;
    end;


    procedure CheckApplofSTpureAgntOnline(OldCustLedgEntry: Record "Cust. Ledger Entry")
    var
        ServTaxEntry: Record "Service Tax Entry";
    begin
        IF OldCustLedgEntry."Document Type" = OldCustLedgEntry."Document Type"::Payment THEN
            IF OldCustLedgEntry."Serv. Tax on Advance Payment" THEN BEGIN
                ServTaxEntry.RESET;
                ServTaxEntry.SETRANGE("Transaction No.", OldCustLedgEntry."Transaction No.");
                IF ServTaxEntry.FINDFIRST THEN
                    IF ServTaxEntry."ST Pure Agent" <> "Sales Header"."ST Pure Agent" THEN
                        AddError(Text16530);
            END;
    end;
    */
    //B2BUpg<<


    procedure InitializeRequest(NewShipReceiveOnNextPostReq: Boolean; NewInvOnNextPostReq: Boolean; NewShowDim: Boolean; NewShowCostAssignment: Boolean)
    begin
        ShipReceiveOnNextPostReq := NewShipReceiveOnNextPostReq;
        InvOnNextPostReq := NewInvOnNextPostReq;
        ShowDim := NewShowDim;
        ShowCostAssignment := NewShowCostAssignment;
    end;

    local procedure CalculateGSTCompAmount()
    begin
        IF IsGSTApplicable AND ("Sales Line".Type <> "Sales Line".Type::" ") AND ("Sales Line"."Qty. to Ship (Base)" > 0) THEN BEGIN // Qty to Ship is  added by Vishnu Priya
            j := 1;
            // GSTComponent.RESET;
            //GSTComponent.SETRANGE("GST Jurisdiction Type", SalesLine."GST Jurisdiction Type");
            // IF GSTComponent.FINDSET THEN
            //REPEAT
            //GSTComponentCode[j] := GSTComponent.Code;
            DetailedGSTEntryBuffer.RESET;
            DetailedGSTEntryBuffer.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Line No.");
            DetailedGSTEntryBuffer.SETRANGE("Transaction Type", DetailedGSTEntryBuffer."Transaction Type"::Sales);
            //DetailedGSTEntryBuffer.SETRANGE("Document Type", "Sales Line"."Document Type");
            DetailedGSTEntryBuffer.SETRANGE("Document No.", "Sales Line"."Document No.");
            DetailedGSTEntryBuffer.SETRANGE("Line No.", "Sales Line"."Line No.");
            // DetailedGSTEntryBuffer.SETRANGE("GST Component Code", GSTComponentCode[j]);
            IF DetailedGSTEntryBuffer.FINDSET THEN BEGIN
                REPEAT
                    GSTCompAmount[j] += DetailedGSTEntryBuffer."GST Amount";
                UNTIL DetailedGSTEntryBuffer.NEXT = 0;
                j += 1;
            END;
            //UNTIL GSTComponent.NEXT = 0;
        END;
    end;
    //B2BUpg>>
    /*
        local procedure CalculateTax(var StructureOrderLineDetails: Record "Structure Order Line Details")
        begin
            StructureOrderLineDetails.RESET;
            StructureOrderLineDetails.SETRANGE(Type, StructureOrderLineDetails.Type::Sale);
            StructureOrderLineDetails.SETRANGE("Document Type", "Sales Line"."Document Type");
            StructureOrderLineDetails.SETRANGE("Document No.", "Sales Line"."Document No.");
            StructureOrderLineDetails.SETRANGE("Item No.", "Sales Line"."No.");
            StructureOrderLineDetails.SETRANGE("Line No.", "Sales Line"."Line No.");
            IF StructureOrderLineDetails.FIND('-') THEN
                REPEAT
                    IF NOT StructureOrderLineDetails."Payable to Third Party" THEN BEGIN
                        IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::Charges THEN
                            ChargesAmount := ChargesAmount + ROUND(StructureOrderLineDetails.Amount);
                        IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                            OtherTaxesAmount := OtherTaxesAmount + ROUND(StructureOrderLineDetails.Amount);
                    END ELSE
                        IF StructureOrderLineDetails."Tax/Charge Type" IN
                           [StructureOrderLineDetails."Tax/Charge Type"::Charges, StructureOrderLineDetails."Tax/Charge Type"::"Other Taxes"]
                        THEN
                            ThirdPartyAmount := ThirdPartyAmount + StructureOrderLineDetails.Amount;
                UNTIL StructureOrderLineDetails.NEXT = 0;
            TaxAreaLine.RESET;
            TaxAreaLine.SETCURRENTKEY("Tax Area", "Calculation Order");
            TaxAreaLine.SETRANGE("Tax Area", "Sales Line"."Tax Area Code");
            IF TaxAreaLine.FINDFIRST THEN
                REPEAT
                    TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code");
                    IF TaxType = '' THEN
                        TaxType := FORMAT(TaxJurisdiction."Tax Type")
                    ELSE
                        IF TaxType <> FORMAT(TaxJurisdiction."Tax Type") THEN
                            AddError(STRSUBSTNO(Text16509, TaxType, TaxAreaLine."Tax Jurisdiction Code"));
                UNTIL TaxAreaLine.NEXT = 0;
        end;*/
    //B2BUpg<<
}

