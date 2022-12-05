report 33000274 AMC_SAL_INVOICE
{
    DefaultLayout = RDLC;
    RDLCLayout = './AMCSALINVOICE.rdl';
    Caption = 'Sales - Invoice';
    EnableExternalImages = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(LBT_No; LBT_No)
            {
            }

            column(Sales_Invoice_Header_Structure; '')
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(CopyLoop_Number; CopyLoop.Number)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                    {
                    }
                    column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                    {
                    }
                    column(Pic; CompanyInfo.Picture)
                    {
                    }
                    column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
                    {
                    }
                    column(Con_GSTReg_No; Con_GSTReg_No)
                    {
                    }
                    column(Con_State; Con_State)
                    {
                    }
                    column(Con_State_Code; Con_State_Code)
                    {
                    }
                    column(ModeOfTransport; "Sales Invoice Header"."Mode of Transport")//EFFUPG1.9
                    {
                    }
                    column(CopyText_New; CopyText)
                    {
                    }
                    column(UserName; UserName)
                    {
                    }
                    column(GSTINLbl; GSTINLbl)
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
                    column(GSTCompAmount1; ROUND(ABS(GSTCompAmount[1]), 1))
                    {
                    }
                    column(GSTCompAmount2; ROUND(ABS(GSTCompAmount[2]), 1))
                    {
                    }
                    column(GSTCompAmount3; ROUND(ABS(GSTCompAmount[3]), 1))
                    {
                    }
                    column(GSTCompAmount4; ROUND(ABS(GSTCompAmount[4]), 1))
                    {
                    }
                    column(Tot_GST_Amount; ROUND(ABS(Tot_GST_Amount), 1))
                    {
                    }
                    column(IsGSTApplicable; IsGSTApplicable)
                    {
                    }
                    column(Reverse_Charge_Lbl; Reverse_Charge_Lbl)
                    {
                    }
                    column(IsReverseCharge; IsReverseCharge)
                    {
                    }
                    column(Reverse_Charge_Amount; Reverse_Charge_Amount)
                    {
                    }
                    column(Sup_State_Code; Sup_State_Code)
                    {
                    }
                    column(Rec_State_Code; Rec_State_Code)
                    {
                    }
                    column(Sup_State; Sup_State)
                    {
                    }
                    column(Rec_State; Rec_State)
                    {
                    }
                    column(LinesCount; LinesCount)
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_Customer_Name_; "Sales Invoice Header"."Sell-to Customer Name")
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_City_; "Sales Invoice Header"."Sell-to City")
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_Addrss_; "Sales Invoice Header"."Sell-to Address")
                    {
                    }
                    column(Sales_Invoice_Header___Sell_to_Addrss_2_; "Sales Invoice Header"."Sell-to Address 2")
                    {
                    }
                    column(Vehicle_No; "Sales Invoice Header"."Vehicle No.")
                    {
                    }
                    column(Customer_PAN_No; "Sales Invoice Header".Customer_PAN_No)
                    {
                    }
                    column(Location_PAN_No; "Sales Invoice Header".Location_PAN_No)
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(TinNo; TNo)
                    {
                    }
                    column(CSTNo; CSTNo)
                    {
                    }
                    column(FORMAT__Sales_Invoice_Header___Posting_Date__0_4_; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(Sales_Invoice_Header__Order_No__; LedOrder)
                    {
                    }
                    column(Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
                    {
                    }
                    column(Sales_Invoice_Header___Customer_OrderNo__; "Sales Invoice Header"."Customer OrderNo.")
                    {
                    }
                    column(FORMAT__Sales_Invoice_Header___Customer_Order_Date__0_4_; FORMAT("Sales Invoice Header"."Customer Order Date", 0, 4))
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_Address_; "Sales Invoice Header"."Ship-to Address")
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_City_; "Sales Invoice Header"."Ship-to City")
                    {
                    }
                    column(cap; cap)
                    {
                    }
                    column(TIME; TIME)
                    {
                    }
                    column(Sales_Invoice_Header__WayBillNo; "Sales Invoice Header".WayBillNo)
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_Address_2_; "Sales Invoice Header"."Ship-to Address 2")
                    {
                    }
                    column(Sales_Invoice_Header___Ship_to_Name_; "Sales Invoice Header"."Ship-to Name")
                    {
                    }
                    column(Exemptd_Vide_Not_No_; "Sales Invoice Header"."Exempted Vide Notification No.")
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(INVOICE_NO_Caption; INVOICE_NO_CaptionLbl)
                    {
                    }
                    column(DATE__Caption; DATE__CaptionLbl)
                    {
                    }
                    column(Tin_No__28350166764Caption; Tin_No__28350166764CaptionLbl)
                    {
                    }
                    column(CST_No__VJ2_07_1_1976_02_05_1988Caption; CST_No__VJ2_07_1_1976_02_05_1988CaptionLbl)
                    {
                    }
                    column(Consignee_Name___AddressCaption; Consignee_Name___AddressCaptionLbl)
                    {
                    }
                    column(Your_Order_No_Caption; Your_Order_No_CaptionLbl)
                    {
                    }
                    column(Dt__Caption; Dt__CaptionLbl)
                    {
                    }
                    column(TIME_OF_ISSUE_OF_INVOICECaption; TIME_OF_ISSUE_OF_INVOICECaptionLbl)
                    {
                    }
                    column(WAY_BILL_NO_Caption; WAY_BILL_NO_CaptionLbl)
                    {
                    }
                    column(Regd__Office___Factory__Caption; Regd__Office___Factory__CaptionLbl)
                    {
                    }
                    column(EmptyStringCaption; EmptyStringCaptionLbl)
                    {
                    }

                    column(QRCODE; '')
                    {
                    }

                    column(PageLoop_Number; Number)
                    {
                    }
                    column(STRSUBSTNO_CopyText_; STRSUBSTNO(CopyText))
                    {
                    }
                    column(MRP; MRP)
                    {
                    }
                    column(Discount_Percnt; Discount_Percnt)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = SORTING("Document No.", "Line No.") WHERE(Quantity = FILTER(> 0));
                        column(SalesInvFooter4; SalesInvFooter4)
                        {
                        }
                        column(tot_1__1_; tot[1] [1])
                        {
                        }
                        column(d1_1_; d1[1])
                        {
                        }
                        column(tot_1__2_; tot[1] [2])
                        {
                        }
                        column(tot_1__3_; tot[1] [3])
                        {
                        }
                        column(tot_1__4_; tot[1] [4])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(tot_1__5_; tot[1] [5])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(tot_2__1_; tot[2] [1])
                        {
                        }
                        column(d1_2_; d1[2])
                        {
                        }
                        column(tot_2__2_; tot[2] [2])
                        {
                        }
                        column(tot_2__3_; tot[2] [3])
                        {
                        }
                        column(tot_2__4_; tot[2] [4])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(tot_2__5_; tot[2] [5])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(tot_3__1_; tot[3] [1])
                        {
                        }
                        column(d1_3_; d1[3])
                        {
                        }
                        column(tot_3__2_; tot[3] [2])
                        {
                        }
                        column(tot_3__3_; tot[3] [3])
                        {
                        }
                        column(tot_3__5_; tot[3] [5])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(tot_3__4_; tot[3] [4])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(tot_4__1_; tot[4] [1])
                        {
                        }
                        column(d1_4_; d1[4])
                        {
                        }
                        column(tot_4__2_; tot[4] [2])
                        {
                        }
                        column(tot_4__3_; tot[4] [3])
                        {
                        }
                        column(tot_4__4_; tot[4] [4])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(tot_4__5_; tot[4] [5])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(tot_5__1_; tot[5] [1])
                        {
                        }
                        column(d1_5_; d1[5])
                        {
                        }
                        column(tot_5__2_; tot[5] [2])
                        {
                        }
                        column(tot_5__3_; tot[5] [3])
                        {
                        }
                        column(tot_5__4_; tot[5] [4])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(tot_5__5_; tot[5] [5])
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(tot_1__6_; tot[1] [6])
                        {
                        }
                        column(tot_2__6_; tot[2] [6])
                        {
                        }
                        column(tot_3__6_; tot[3] [6])
                        {
                        }
                        column(tot_4__6_; tot[4] [6])
                        {
                        }
                        column(tot_5__6_; tot[5] [6])
                        {
                        }
                        column(tot_1__7_; tot[1] [7])
                        {
                        }
                        column(tot_2__7_; tot[2] [7])
                        {
                        }
                        column(tot_3__7_; tot[3] [7])
                        {
                        }
                        column(tot_4__7_; tot[4] [7])
                        {
                        }
                        column(tot_5__7_; tot[5] [7])
                        {
                        }
                        column(tot_1__8_; tot[1] [8])
                        {
                        }
                        column(tot_2__8_; tot[2] [8])
                        {
                        }
                        column(tot_3__8_; tot[3] [8])
                        {
                        }
                        column(tot_4__8_; tot[4] [8])
                        {
                        }
                        column(tot_5__8_; tot[5] [8])
                        {
                        }
                        column(tot_1__9_; tot[1] [9])
                        {
                        }
                        column(tot_2__9_; tot[2] [9])
                        {
                        }
                        column(tot_3__9_; tot[3] [9])
                        {
                        }
                        column(tot_4__9_; tot[4] [9])
                        {
                        }
                        column(tot_5__9_; tot[5] [9])
                        {
                        }
                        column(tot_1__10_; tot[1] [10])
                        {
                        }
                        column(tot_2__10_; tot[2] [10])
                        {
                        }
                        column(tot_3__10_; tot[3] [10])
                        {
                        }
                        column(tot_4__10_; tot[4] [10])
                        {
                        }
                        column(tot_5__10_; tot[5] [10])
                        {
                        }
                        column(tot_1__11_; tot[1] [11])
                        {
                        }
                        column(tot_2__11_; tot[2] [11])
                        {
                        }
                        column(tot_3__11_; tot[3] [11])
                        {
                        }
                        column(tot_4__11_; tot[4] [11])
                        {
                        }
                        column(tot_5__11_; tot[5] [11])
                        {
                        }
                        column(tot_1__12_; tot[1] [12])
                        {
                        }
                        column(tot_2__12_; tot[2] [12])
                        {
                        }
                        column(tot_3__12_; tot[3] [12])
                        {
                        }
                        column(tot_4__12_; tot[4] [12])
                        {
                        }
                        column(tot_5__12_; tot[5] [12])
                        {
                        }
                        column(tot_1__13_; tot[1] [13])
                        {
                        }
                        column(tot_2__13_; tot[2] [13])
                        {
                        }
                        column(tot_3__13_; tot[3] [13])
                        {
                        }
                        column(tot_4__13_; tot[4] [13])
                        {
                        }
                        column(tot_5__13_; tot[5] [13])
                        {
                        }
                        column(Totals_1__; Totals_Txt[1])
                        {
                        }
                        column(Totals_2__; Totals_Txt[2])
                        {
                        }
                        column(Totals_3__; Totals_Txt[3])
                        {
                        }
                        column(Totals_4__; Totals_Txt[4])
                        {
                        }
                        column(Totals_5__; Totals_Txt[5])
                        {
                        }
                        column(Totals_6__; Totals_Txt[6])
                        {
                        }
                        column(Totals_7__; Totals_Txt[7])
                        {
                        }
                        column(Totals_8__; Totals_Txt[8])
                        {
                        }
                        column(Capt12; Capt12)
                        {
                        }
                        column(d1_Text; d1_Text)
                        {
                        }
                        column(Tot_1_1; Tot_1_1)
                        {
                        }
                        column(Tot_1_2; Tot_1_2)
                        {
                        }
                        column(Tot_1_3; Tot_1_3)
                        {
                        }
                        column(Tot_1_4; Tot_1_4)
                        {
                        }
                        column(Tot_1_5; Tot_1_5)
                        {
                        }
                        column(Tot_1_6; Tot_1_6)
                        {
                        }
                        column(Tot_1_7; Tot_1_7)
                        {
                        }
                        column(Tot_1_8; Tot_1_8)
                        {
                        }
                        column(Tot_1_9; Tot_1_9)
                        {
                        }
                        column(Tot_1_10; Tot_1_10)
                        {
                        }
                        column(Tot_1_11; Tot_1_11)
                        {
                        }
                        column(Tot_1_12; Tot_1_12)
                        {
                        }
                        column(Tot_1_13; Tot_1_13)
                        {
                        }
                        column(formatadress_ChangeCurrency_ROUND_bedamt_1_____00_; FormatadressNew.ChangeCurrency(ROUND(bedamt, 1)) + '.00')
                        {
                        }
                        column(FORMAT_formatadress_ChangeCurrency_ROUND_LineAmt_1______00_; ROUND(LineAmt, 1))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DataItem1280017; FormatadressNew.ChangeCurrency(ROUND(LineAmt + bedamt + cessamt + ecessamt + roundoff + 1)) + '.00')
                        {
                        }
                        column(s; s)
                        {
                        }
                        column(forwarding; forwarding)
                        {
                        }
                        column(formatadress_ChangeCurrency__ROUND_LineAmt__Sales_Invoice_Line___Charges_To_Customer__1__ROUND_bedamt_1______00_; FormatadressNew.ChangeCurrency((ROUND(LineAmt + 1) + ROUND(bedamt, 1))) + '.00')
                        {
                        }
                        column(ROUND_cessamt_1_; ROUND(cessamt, 1))
                        {
                        }
                        column(ROUND_ecessamt_1_; ROUND(ecessamt, 1))
                        {
                        }
                        column(DataItem1000000065; FormatadressNew.ChangeCurrency(ROUND((ROUND(LineAmt, 1) + ROUND(bedamt, 1)) + cessamt + ecessamt + 1)) + '.00')
                        {
                        }
                        column(FORMAT__Sales_Invoice_Header___Posting_Date__0_4__Control1000000038; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                        {
                        }
                        column(Sales_Invoice_Header___Transport_Method___Sales_Invoice_Header___Vehicle_No__; "Sales Invoice Header"."Transport Method" + "Sales Invoice Header"."Vehicle No.")
                        {
                        }
                        column(descri1_1__descri1_2_; descri1[1] + descri1[2])
                        {
                        }
                        column(TIME_3600000; TIME + 3600000)
                        {
                        }
                        column(caplabel; caplabel)
                        {
                        }
                        column(ROUND_taxamt_1_; ROUND(taxamt, 1))
                        {
                        }
                        column(caplabel1; caplabel1)
                        {
                        }
                        column(round1; round1)
                        {
                        }
                        column(bedcap____; bedcap + '%')
                        {
                        }
                        column(packing; packing)
                        {
                        }
                        column(ROUND__packing__Sales_Invoice_Line___Line_Amount___100_0_01_; AmountGrec)
                        {
                        }
                        column(ROUND__forwarding__Sales_Invoice_Line___Line_Amount___100_0_001_; ROUND((forwarding / "Sales Invoice Line"."Line Amount") * 100, 0.001))
                        {
                        }
                        column(formatadress_ChangeCurrency_ROUND_vatamt_1_____00_; ROUND(vatamt, 1))
                        {
                        }
                        column(capt; capt)
                        {
                        }
                        column(S_noCaption; S_noCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Amount_type_symbol_caption; Amount_type_symbol)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(DiscountedPriceCaption; DiscountedPriceCaptionLbl)
                        {
                        }
                        column(MRPCaption; MRPCaptionLbl)
                        {
                        }
                        column(ServiceTaxSBCAmt; ServiceTaxSBCAmt)
                        {
                        }
                        column(AppliedServiceTaxSBCAmt; AppliedServiceTaxSBCAmt)
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(SvcTaxSBCAmtAppliedCaption; SvcTaxSBCAmtAppliedCaptionLbl)
                        {
                        }
                        column(KKCessAmt; KKCessAmt)
                        {
                        }
                        column(AppliedKKCessAmt; AppliedKKCessAmt)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }
                        column(KKCessAmtAppliedCaption; KKCessAmtAppliedCaptionLbl)
                        {
                        }
                        column(No_of_PacketsCaption; No_of_PacketsCaptionLbl)
                        {
                        }
                        column(Sch__NoCaption; Sch__NoCaptionLbl)
                        {
                        }
                        column(Sub_TotalCaption; Sub_TotalCaptionLbl)
                        {
                        }
                        column(DataItem1000000010; C_E__RegN__No__AAACE4879QXM001Lbl)
                        {
                        }
                        column(ECCCaptionLbl; ECCCaptionLbl)
                        {
                        }
                        column(CentralCaptionLbl; CentralCaptionLbl)
                        {
                        }
                        column(Details_of_Reduction_Additions_made_to_arrive_at_value_under_sec__4_at_the_ActCaption; Details_of_Reduction_Additions_made_to_arrive_at_value_under_sec__4_at_the_ActCaptionLbl)
                        {
                        }
                        column(Tariff_Heading_No__Caption; Tariff_Heading_No__CaptionLbl)
                        {
                        }
                        column(Exemption_notification_No_Caption; Exemption_notification_No_CaptionLbl)
                        {
                        }
                        column(PackingCaption; PackingCaptionLbl)
                        {
                        }
                        column(Total_Assessable_Value_or_Tariff_ValueCaption; Total_Assessable_Value_or_Tariff_ValueCaptionLbl)
                        {
                        }
                        column(Serial_Number_of_Debit___Entry_in_PLA___Rg_23A_Part_II_Caption; Serial_Number_of_Debit___Entry_in_PLA___Rg_23A_Part_II_CaptionLbl)
                        {
                        }
                        column(B_E_D__Rate________Caption; B_E_D__Rate________CaptionLbl)
                        {
                        }
                        column(Total_Duty_Paid___in_words_Caption; Total_Duty_Paid___in_words_CaptionLbl)
                        {
                        }
                        column(Sub_Total____Caption; Sub_Total____CaptionLbl)
                        {
                        }
                        column(E_Cess___2___on_BEDCaption; E_Cess___2___on_BEDCaptionLbl)
                        {
                        }
                        column(SHE_Cess___1___on_BEDCaption; SHE_Cess___1___on_BEDCaptionLbl)
                        {
                        }
                        column(Sub_Total_______Caption; Sub_Total_______CaptionLbl)
                        {
                        }
                        column(GRAND_TOTAL___Caption; GRAND_TOTAL___CaptionLbl)
                        {
                        }
                        column(Mode_of_Transport___Vechicle_Regn_No_Caption; Mode_of_Transport___Vechicle_Regn_No_CaptionLbl)
                        {
                        }
                        column(Customer_s_Signature__Caption; Customer_s_Signature__CaptionLbl)
                        {
                        }
                        column(DateCaption; DateCaptionLbl)
                        {
                        }
                        column(Time_of_Removal_of_GoodsCaption; Time_of_Removal_of_GoodsCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1000000082; EmptyStringCaption_Control1000000082Lbl)
                        {
                        }
                        column(GST_Jur; "Sales Invoice Line"."GST Jurisdiction Type")
                        {
                        }
                        column(VATCaption; VATCaptionLbl)
                        {
                        }
                        column(CSTCaption; CSTCaptionLbl)
                        {
                        }
                        column(Round_offCaption; Round_offCaptionLbl)
                        {
                        }
                        column(ForwardingCaption; ForwardingCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102154049; EmptyStringCaption_Control1102154049Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1102154050; EmptyStringCaption_Control1102154050Lbl)
                        {
                        }
                        column(Sales_Invoice_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Sales_Invoice_Line_Line_No_; "Line No.")
                        {
                        }
                        column(InsuranceCaption; InsuranceCaptionLbl)
                        {
                        }
                        column(TotalBody1; TotalBody1)
                        {
                        }
                        column(capt_Control1000000204; capt)
                        {
                        }
                        column(FORMAT_ROUND_LineAmt_1_____00_; ROUND(LineAmt, 1))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(FORMAT_ROUND_LineAmt_1_____00__Control1000000212; ROUND(LineAmt, 1))
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(caplabel_Control1000000214; caplabel)
                        {
                        }
                        column(ROUND_taxamt_1__Control1000000215; ROUND(taxamt, 1))
                        {
                        }
                        column(caplabel1_Control1000000217; caplabel1)
                        {
                        }
                        column(formatadress_ChangeCurrency_ROUND_LineTotAmt_roundoff_1_____00_; FormatadressNew.ChangeCurrency(ROUND(LineTotAmt + roundoff, 1)))
                        {
                        }
                        column(round1_Control1102154003; round1)
                        {
                        }
                        column(Sales_Invoice_Header___Transport_Method___Sales_Invoice_Header___Vehicle_No___Control1102154046; "Sales Invoice Header"."Transport Method" + "Sales Invoice Header"."Vehicle No.")
                        {
                        }
                        column(ROUND_vatamt_1_; ROUND(vatamt, 1))
                        {
                        }
                        column(descri_1_; descri[1])
                        {
                        }
                        column(Mode_of_Transport___Vechicle_Regn_No_Caption_Control1000000205; Mode_of_Transport___Vechicle_Regn_No_Caption_Control1000000205Lbl)
                        {
                        }
                        column(Packing___ForwardingCaption; Packing___ForwardingCaptionLbl)
                        {
                        }
                        column(EmptyStringCaption_Control1000000208; EmptyStringCaption_Control1000000208Lbl)
                        {
                        }
                        column(Sub_TotalCaption_Control1000000209; Sub_TotalCaption_Control1000000209Lbl)
                        {
                        }
                        column(Sub_TotalCaption_Control1000000211; Sub_TotalCaption_Control1000000211Lbl)
                        {
                        }
                        column(CSTCaption_Control1000000213; CSTCaption_Control1000000213Lbl)
                        {
                        }
                        column(VATCaption_Control1000000216; VATCaption_Control1000000216Lbl)
                        {
                        }
                        column(GRAND_TOTAL___Caption_Control1000000219; GRAND_TOTAL___Caption_Control1000000219Lbl)
                        {
                        }
                        column(EmptyStringCaption_Control1000000222; EmptyStringCaption_Control1000000222Lbl)
                        {
                        }
                        column(Customer_s_Signature__Caption_Control1000000230; Customer_s_Signature__Caption_Control1000000230Lbl)
                        {
                        }
                        column(Round_offCaption_Control1102154004; Round_offCaption_Control1102154004Lbl)
                        {
                        }
                        column(DataItem1102152012; Certified_that_Particulars)
                        {
                        }
                        column(Amount_type_ruppes_dollarsL; Amount_type)
                        {
                        }
                        column(Rupees__in_Words__Caption; Rupees__in_Words__CaptionLbl)
                        {
                        }
                        column(DataItem1102152010; For_Efftronics_Systems)
                        {
                        }
                        column(Authorised_SignatoryCaption; Authorised_SignatoryCaptionLbl)
                        {
                        }
                        column(Prepared_byCaption; Prepared_byCaptionLbl)
                        {
                        }
                        column(Checked_byCaption; Checked_byCaptionLbl)
                        {
                        }
                        column(GoodsCaption; GoodsCaptionLbl)
                        {
                        }
                        column(OursResCapion; OursResCapionLbl)
                        {
                        }
                        column(SubjectCaption; SubjectCaptionLbl)
                        {
                        }
                        column(EOECAption; EOECAptionLbl)
                        {
                        }
                        column(TotalLineAmt; TotalLineAmt)
                        {
                        }
                        column(MRP_Tot_MRP_Price_Caption; Tot_MRP_Price_Caption)
                        {
                        }
                        column(MRP_Tot_Amt_After_Discount_Caption; Tot_Amt_After_Discount_Caption)
                        {
                        }
                        column(MRP_Excise_Rate_Caption; Excise_Rate_Caption)
                        {
                        }
                        column(MRP_AbatementCaption; AbatementCaption)
                        {
                        }
                        column(MRP_VatCaption; VatCaption)
                        {
                        }
                        column(MRP_CSTCaption; CSTCaption)
                        {
                        }
                        column(MRP_FinalAmt_Caption; FinalAmt_Caption)
                        {
                        }
                        column(Abatement_Notification_Caption; Abatement_Notification_Caption)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Clear(AmountGrec);
                            if "Sales Invoice Line"."Amount to Customer" <> 0 then
                                AmountGrec := ROUND((packing / "Sales Invoice Line"."Amount To Customer") * 100, 0.01);
                            //CstVatAmt := CstVatAmt + "Sales Invoice Line"."Tax Amount";//B2BUpg
                            //bed := 0;
                            /* EPS.SETRANGE("Excise Bus. Posting Group", "Sales Invoice Line"."Excise Bus. Posting Group");
                             EPS.SETRANGE("Excise Prod. Posting Group", "Sales Invoice Line"."Excise Prod. Posting Group");
                             IF ("Sales Invoice Header"."Posting Date" <> 0D) THEN
                                 EPS.SETRANGE("From Date", 0D, "Sales Invoice Header"."Posting Date")
                             ELSE
                                 EPS.SETRANGE("From Date", 0D, WORKDATE);
                             IF EPS.FIND('+') THEN
                                 bed := EPS."BED %";*/




                            // NAVIN
                            //SREENIVAS-EFF
                            n := n + 1;
                            IF ("Sales Invoice Line"."Unit Price" = 0) THEN BEGIN
                                c := 1;
                                n := n - c;
                                CurrReport.SKIP;
                            END;

                            IF ("Sales Invoice Line"."Unit Price" <> 0) THEN BEGIN
                                IF bed = 0 THEN
                                    bedcap := ''
                                ELSE
                                    bedcap := FORMAT(bed);
                            END;

                            IF ("Sales Invoice Line"."Tax Area Code" = 'SALES CST') AND ("Sales Invoice Line"."Amount To Customer" <> 0) THEN BEGIN
                                //B2BUpg>>
                                /*
                                taxamt := taxamt + "Sales Invoice Line"."Tax Amount";
                                IF ("Sales Invoice Line"."Tax %" = 2) THEN
                                    caplabel := '(2% aganist Form - C)';
                                IF ("Sales Invoice Line"."Tax %" = 3) THEN
                                    caplabel := '(3% aganist Form - C)';
                                IF ("Sales Invoice Line"."Tax %" = 4) THEN
                                    caplabel := '4%';
                                IF ("Sales Invoice Line"."Tax %" = 12.5) THEN
                                    caplabel := '(12.5%)';
                                IF ("Sales Invoice Line"."Tax %" = 5) THEN
                                    caplabel := '5%';
                                IF ("Sales Invoice Line"."Tax %" = 14.5) THEN
                                    caplabel := '(14.5%)';*/
                                //B2BUpg<<
                            END ELSE
                                caplabel := '';

                            IF ("Sales Invoice Line"."Tax Area Code" = 'SALES VAT') AND ("Sales Invoice Line"."Amount To Customer" <> 0) THEN BEGIN
                                /*vatamt := vatamt + "Sales Invoice Line"."Tax Amount";  //anil comented
                                                                                       //   vatamt:="Sales Invoice Line"."Tax Amount";
                                IF ("Sales Invoice Line"."Tax %" = 5) THEN
                                    caplabel1 := '5%';
                                IF ("Sales Invoice Line"."Tax %" = 4) THEN
                                    caplabel1 := '4%';
                                IF ("Sales Invoice Line"."Tax %" = 12.5) THEN
                                    caplabel1 := '12.5%';
                                IF ("Sales Invoice Line"."Tax %" = 14.5) THEN
                                    caplabel1 := '14.5%';*/
                            END ELSE
                                caplabel1 := '';



                            IF ("Sales Invoice Line"."Tax Group Code" = 'SOFTWARE') THEN
                                capt := '';
                            IF (("Sales Invoice Line"."Tax Group Code" = 'BOI-COMPUT') OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-O') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'BOI-O 2%') OR ("Sales Invoice Line"."Tax Group Code" = 'RAW') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'RAW 10.5') OR ("Sales Invoice Line"."Tax Group Code" = 'RAW 12.5') OR
                            ("Sales Invoice Line"."Tax Group Code" = '2%') OR ("Sales Invoice Line"."Tax Group Code" = '14.5%') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'BO-COM14.5') OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-O 5%')
                            OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-OVAT') OR ("Sales Invoice Line"."Tax Group Code" = 'BOI 1%')
                            OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-O 12.5')) THEN BEGIN
                                cap := 'COMMERCIAL INVOICE';
                                CopyText := '';
                                capt := '(Trading item)';
                            END ELSE
                                cap := 'SERVICE INVOICE';    //MODIFIED ON 01-31-09
                                                             //cap:='SALE INVOICE CUM DELIVERY CHALLAN';

                            IF IsGSTApplicable THEN BEGIN
                                /* IF COPYSTR("Sales Invoice Header"."External Document No.",1,2) = 'CI' THEN
                                   cap:='COMMERCIAL INVOICE'
                                 ELSE IF COPYSTR("Sales Invoice Header"."Order No.",5,3) = 'AMC' THEN
                                   cap:='SERVICING INVOICE'
                                 ELSE*/
                                cap := 'SERVICE INVOICE';
                            END;


                            /*IF "Sales Invoice Line"."Excise Bus. Posting Group" = 'EXPORT' THEN
                                cap := 'EXPORT INVOICE';*/
                            IF MRP = FALSE THEN BEGIN
                                //LineAmt := Quantity * "Unit Price";   //Commented by Pranavi on 02-Feb-2016 for to consider discount
                                LineAmt := Quantity * ("Unit Price" - ("Unit Price" * "Sales Invoice Line"."Line Discount %" / 100));    //Added by Pranavi on 02-Feb-2016 for to consider discount
                                                                                                                                         //MESSAGE(FORMAT(LineAmt));//anil240312
                            END ELSE BEGIN
                                //LineAmt := ROUND("Sales Invoice Line".Quantity * ("Sales Invoice Line"."MRP Price" * (100 - "Sales Invoice Line"."Line Discount %") / 100), 1);//B2BUpg    //Added by Pranavi on 14-OCt-2016 for MRP Pricing for LED Products
                                LineAmt := ROUND("Sales Invoice Line".Quantity * (100 - "Sales Invoice Line"."Line Discount %") / 100, 1);    //Added by Pranavi on 14-OCt-2016 for MRP Pricing for LED Products
                            END;
                            LineTotAmt := LineTotAmt + LineAmt;
                            TotalLineAmt += LineAmt;
                            // MESSAGE(FORMAT(LineTotAmt));
                            IF IsGSTApplicable AND (Type <> Type::" ") THEN BEGIN
                                J := 1;
                                // GSTComponent.RESET;
                                // GSTComponent.SETRANGE("GST Jurisdiction Type", "GST Jurisdiction Type");
                                //IF GSTComponent.FINDSET THEN
                                //REPEAT
                                //GSTComponentCode[J] := GSTComponent.Code;
                                DetailedGSTLedgerEntry.RESET;
                                DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                                //DetailedGSTLedgerEntry.SETRANGE("GST Component Code", GSTComponentCode[J]);
                                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                    REPEAT
                                        if DetailedGSTLedgerEntry."GST Component Code" = 'IGST' then
                                            J := 1
                                        else
                                            if DetailedGSTLedgerEntry."GST Component Code" = 'CGST' then
                                                J := 2
                                            else
                                                if DetailedGSTLedgerEntry."GST Component Code" = 'SGST' then
                                                    J := 3;
                                        GSTComponentCode[J] := DetailedGSTLedgerEntry."GST Component Code"; //BaluOn1Oct2022
                                        GSTCompAmount[J] +=
                                          CurrExchRate.ExchangeAmtLCYToFCY(
                                            DetailedGSTLedgerEntry."Posting Date", DetailedGSTLedgerEntry."Currency Code",
                                            abs(DetailedGSTLedgerEntry."GST Amount"), DetailedGSTLedgerEntry."Currency Factor");
                                        Tot_GST_Amount += ABS(DetailedGSTLedgerEntry."GST Amount"); //pranavi
                                        J += 1;
                                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;

                                END;
                                //UNTIL GSTComponent.NEXT = 0;

                            END;
                            //LineTotAmt := LineTotAmt + Tot_GST_Amount ; // added by vijaya for GST Amt Testing on 01-11-2017
                            //TotalLineAmt += Tot_GST_Amount;
                            //LineTotAmt := LineTotAmt;
                            //LineTotAmt := LineTotAmt-Tot_GST_Amount;
                            //TotalLineAmt += Tot_GST_Amount;
                            //B2BUpg>>
                            /*
                            StructureLineDetails.RESET;
                            StructureLineDetails.SETRANGE(Type, StructureLineDetails.Type::Sale);
                            StructureLineDetails.SETRANGE("Document Type", StructureLineDetails."Document Type"::Invoice);
                            StructureLineDetails.SETRANGE("Invoice No.", "Document No.");
                            StructureLineDetails.SETRANGE("Item No.", "No.");
                            StructureLineDetails.SETRANGE("Line No.", "Line No.");
                            IF StructureLineDetails.FIND('-') THEN
                                REPEAT
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                        Charges := Charges + ABS(StructureLineDetails.Amount);
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                        Othertaxes := Othertaxes + ABS(StructureLineDetails.Amount);
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Sales Tax" THEN
                                        SalesTax := SalesTax + ABS(StructureLineDetails.Amount);
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                        ServiceTax := ServiceTax + ABS(StructureLineDetails.Amount);
                                    IF (NOT (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise)) THEN
                                        LineTotAmt := LineTotAmt + ABS(StructureLineDetails.Amount);
                                UNTIL StructureLineDetails.NEXT = 0;
                            // NAVIN
                            ExciseAmount += "BED Amount" + "AED(GSI) Amount" + "AED(TTA) Amount" + "SED Amount" + "SAED Amount" + "CESS Amount" +
                                            "NCCD Amount" + "eCess Amount" + "ADET Amount" + "SHE Cess Amount";
                            LineTotAmt += "BED Amount" + "AED(GSI) Amount" + "AED(TTA) Amount" + "SED Amount" + "SAED Amount" + "CESS Amount" +
                                          "NCCD Amount" + "eCess Amount" + "ADET Amount" + "SHE Cess Amount";
                            */
                            //B2BUpg<<
                            //    MESSAGE(FORMAT(LineTotAmt));
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';
                            //SREENIVAS -EFF
                            IF ("Sales Invoice Line"."Tax Group Code" = 'MPBI') OR ("Sales Invoice Line"."Tax Group Code" = 'MPBIVAT') THEN BEGIN
                                s := '84711000';
                                capt := '(Microprocessor based data acquisition&control system)';
                            END;
                            //B2BUpg>>
                            /*
                            IF COPYSTR("Sales Invoice Line"."Tax Group Code", 1, 3) = 'LED' THEN BEGIN
                                IF ("Sales Invoice Line"."Excise Prod. Posting Group" = '94054090') THEN BEGIN
                                    s := '94054090';
                                    capt := '(LED Lighting)';
                                END;
                                IF ("Sales Invoice Line"."Excise Prod. Posting Group" = '90221900') THEN BEGIN
                                    s := '90221900';
                                    capt := '(X-Ray Viewer)';
                                END;
                                IF ("Sales Invoice Line"."Excise Prod. Posting Group" = 'LED_MRP') THEN BEGIN
                                    IF Itm.GET("Sales Invoice Line"."No.") THEN BEGIN
                                        IF Itm."Gen. Prod. Posting Group" = 'X-RAY VIEW' THEN BEGIN
                                            s := '90221900';
                                            capt := '(X-Ray Viewer)';
                                        END ELSE BEGIN
                                            s := '94054090';
                                            capt := '(LED Lighting)';
                                        END;
                                    END
                                    ELSE BEGIN
                                        s := '94054090';
                                        capt := '(LED Lighting)';
                                    END;
                                END;
                            END;
                            IF ("Sales Invoice Line"."Excise Prod. Posting Group" = '85414020') THEN BEGIN
                                s := '85414020';
                                capt := '(Electronic Moving Display unit for information Text)';
                            END;

                            IF ("Sales Invoice Line"."Excise Prod. Posting Group" = '85481090') THEN BEGIN
                                s := '85481090';
                                capt := '(Other Waste & Scrap)';

                            END;*/
                            //B2BUpg<<

                            IF IsGSTApplicable THEN BEGIN
                                IF GSTGroup.GET("Sales Invoice Line"."GST Group Code") THEN
                                    capt := '(' + GSTGroup.Description + ')';
                            END;

                            IF "Sales Invoice Line"."Tax Group Code" = 'SOFTWARE' THEN BEGIN
                                s := '85249112';
                            END;
                            IF (("Sales Invoice Line"."Tax Group Code" = 'BOI-COMPUT') OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-O') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'BOI-O 2%') OR ("Sales Invoice Line"."Tax Group Code" = 'RAW') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'RAW 10.5') OR ("Sales Invoice Line"."Tax Group Code" = 'RAW 12.5') OR
                            ("Sales Invoice Line"."Tax Group Code" = '2%') OR ("Sales Invoice Line"."Tax Group Code" = '4%') OR (
                            "Sales Invoice Line"."Tax Group Code" = 'BOI-O 4%') OR ("Sales Invoice Line"."Tax Group Code" = 'BOI-O 5%')) THEN BEGIN
                                bedamt := 0;
                                cessamt := 0;
                                ecessamt := 0;
                            END ELSE BEGIN
                                //bedamt:=bedamt+(LineAmt*(bed)/100);
                                //ROUND(LineAmt+bedamt+cessamt+ecessamt+"Sales Invoice Line"."Tax Amount"+roundoff,1)
                                //  bedamt:=bedamt+(LineAmt*(bed)/100);
                                //bedamt := bedamt + ("Sales Invoice Line"."Excise Base Amount" * (bed) / 100);    // Added by rakesh on 24-Sep-14 for calculation of packing charges also
                                // Added by Rakesh for the calculation of new Excise Rules on 3-Mar-15
                                IF "Sales Invoice Header"."Posting Date" < DMY2DATE(1, 3, 2015) THEN BEGIN
                                    cessamt := (bedamt) * 2 / 100;
                                    ecessamt := (bedamt) * 1 / 100;
                                END
                                ELSE BEGIN
                                    cessamt := 0;
                                    ecessamt := 0;
                                END;
                                // End by Rakesh on 3-Mar-15
                            END;


                            sub := LineAmt + bedamt;
                            sub1 := sub + cessamt + ecessamt;
                            sub2 := sub1 + CstVatAmt;
                            subtotal := ROUND(sub, 1);
                            subtotal1 := ROUND(sub1, 1);
                            subtotal2 := ROUND(sub2, 1);
                            IF "Sales Invoice Line"."Tax Liable" = FALSE THEN BEGIN
                                Capt12 := 'EXEMPTED VIDE NOTIFICATION NO. 42/2001- Central Excise (N.T.) Dated 26th June 2001, Bond.no. V(16)Tech/Bond/31/2012 on ';
                                Capt12 += '20.12.2012 Vide CT-1 Form.no. 366/2012 dt:28.12.2012';
                                Capt12 := 'EXEMPTED VIDE NOTIFICATION NO. 12/2012-CE dt 17.03.2012';
                            END;

                            IF IsGSTApplicable THEN BEGIN
                                IF "Sales Invoice Line".Exempted THEN
                                    Capt12 := 'EXEMPTED VIDE NOTIFICATION NO. 12/2012-CE dt 17.03.2012'
                                ELSE
                                    Capt12 := '';
                                IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::Export THEN
                                    Capt12 := 'EXEMPTED FROM PAYMENT OF INTEGRATED TAX                       1.VIDE NOTIFICATION NO. 16/2017-CT dt 07.07.2017' +
                                            '         2.S.NO.09/2017-18 CUS dt 14-08-2017,' +
                                            'OF ASSISTANT COMMISSIONER OF CENTRAL TAX,VJA,VIDE LETTER NO.V/05/13/2017 BOND dt 14.08.2017';
                            END;

                            IF "Sales Invoice Header"."No." = 'EX-INV-16-17-00510' THEN
                                Capt12 := '';
                            IF "Sales Invoice Line"."Sell-to Customer No." = 'CUST00464' THEN BEGIN
                                Capt12 := 'UNDER NOTIFICATION NO:10/97- CENTRAL EXCISE DT:01.03.97';
                            END;
                            IF "Sales Invoice Header"."No." = 'EX-INV-14-15-00611' THEN BEGIN
                                Capt12 := 'EXEMPTED VIDE NOTIFICATION NO.12/2012 - C.E.DATED 17-03-2012, AS AMENEDED VIDE NOTIFICATION NO.34/2012 - C.E.DATED 10.09.2012';
                            END;
                            IF "Sales Invoice Header"."No." = 'EX-INV-14-15-00674' THEN BEGIN
                                Capt12 := ' EXEMPTED   VIDE NOTIFICATION NO.12/2012 - C.E.DATED 17-03-2012, 28/2012 - C.E.DATED   27-06-2012, 04/2014 - C.E.DATED 17.02.2014';
                            END;




                            //Sales Invoice Line, Body (2) - OnPreSection()
                            //CurrReport.SHOWOUTPUT(Type > 0);
                            //SREENIVAS-EFF
                            //  if "Sales Invoice Line"."No."<>'48400' then

                            IF Type > 0 THEN BEGIN
                                //d1[k]:='SUPPLY OF '+"Sales Invoice Line".Description;
                                d1[k] := ' ' + "Sales Invoice Line".Description;
                                d1_Text := ' ' + "Sales Invoice Line".Description;
                                // IF "Sales Invoice Header"."Customer Posting Group"='PRIVATE' THEN
                                tot[k] [1] := FORMAT(n);
                                Tot_1_1 := FORMAT(n);
                                // ELSE
                                //   tot[k][1]:=FORMAT("Sales Invoice Line"."Schedule No");
                                tot[k] [2] := FORMAT("Sales Invoice Line"."Packet No");
                                Tot_1_2 := FORMAT("Sales Invoice Line"."Packet No");
                                /*
                                IF "Sales Invoice Line"."Unit of Measure Code"='NOS' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Nos';
                                IF "Sales Invoice Line"."Unit of Measure Code"='MTS' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Mts';
                                IF "Sales Invoice Line"."Unit of Measure Code"='KMS' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' KMs';
                                IF "Sales Invoice Line"."Unit of Measure Code"='FT' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Fts';
                                IF "Sales Invoice Line"."Unit of Measure Code"='SET' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Sets';
                                IF "Sales Invoice Line"."Unit of Measure Code"='PAIR' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Pairs';
                                IF "Sales Invoice Line"."Unit of Measure Code"='SQFT' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Sq Fts';
                                IF "Sales Invoice Line"."Unit of Measure Code"='KGS' THEN
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Kgs';
                                IF "Sales Invoice Line"."Unit of Measure Code"='COIL' THEN  // Added by Pranavi on 20-Jan-2016 for Coils
                                tot[k][3]:=FORMAT("Sales Invoice Line".Quantity)+' Coils';
                                */   // Commented by Pranavi on 20-Jan-2016 to generalize
                                IF "Sales Invoice Line"."Unit of Measure Code" <> '' THEN BEGIN
                                    tot[k] [3] := FORMAT("Sales Invoice Line".Quantity) + ' ' + UPPERCASE(COPYSTR("Sales Invoice Line"."Unit of Measure Code", 1, 1)) +
                                              LOWERCASE(COPYSTR("Sales Invoice Line"."Unit of Measure Code", 2, STRLEN("Sales Invoice Line"."Unit of Measure Code") - 1));  // Pranavi
                                    Tot_1_3 := FORMAT("Sales Invoice Line".Quantity) + ' ' + UPPERCASE(COPYSTR("Sales Invoice Line"."Unit of Measure Code", 1, 1)) +
                                              LOWERCASE(COPYSTR("Sales Invoice Line"."Unit of Measure Code", 2, STRLEN("Sales Invoice Line"."Unit of Measure Code") - 1));  // Pranavi
                                END
                                ELSE BEGIN
                                    tot[k] [3] := FORMAT("Sales Invoice Line".Quantity);
                                    Tot_1_3 := FORMAT("Sales Invoice Line".Quantity);
                                END;


                                IF "Sales Invoice Header"."Order No." = 'EFF/SAL/13-14/150' THEN BEGIN
                                    d1[1] := 'a) Supply of Upgradation of materials with 3072 digital inputs  b) Supply of Digital expansion mother board (715M)  c)Supply of digital expansion ribbons, hylum sheet rare plate and fixing accessories';
                                    d1[1] += 'd)   Upgradation of NMDL software with fault logic and yard simulation  software';
                                END;


                                //   tot[k][3]:=FORMAT("Sales Invoice Line".Quantity);
                                //Added by Pranavi on 23-Dec-2015
                                IF MRP = FALSE THEN BEGIN
                                    UnitPriceIncDiscnt := 0;
                                    UnitPriceIncDiscnt := "Sales Invoice Line"."Unit Price" - ROUND("Sales Invoice Line"."Unit Price" * "Sales Invoice Line"."Line Discount %" / 100);
                                    tot[k] [4] := FormatadressNew.ChangeCurrency(ROUND(UnitPriceIncDiscnt, 0.001));
                                    Tot_1_4 := FormatadressNew.ChangeCurrency(ROUND(UnitPriceIncDiscnt, 0.001));
                                    //tot[k][4]:=formatadress.ChangeCurrency(ROUND("Sales Invoice Line"."Unit Price",0.001));  //commented by pranavi on 23-Dec-2015
                                END ELSE BEGIN
                                    //B2BUpg>>
                                    /*
                                        tot[k] [4] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * "Sales Invoice Line"."MRP Price", 0.001));
                                        Tot_1_4 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * "Sales Invoice Line"."MRP Price", 0.001));*/
                                    //B2BUpg<<
                                    tot[k] [4] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity, 0.001));
                                    Tot_1_4 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity, 0.001));
                                END;
                                //Added by Pranavi on 23-Dec-2015
                                tot[k] [6] := FORMAT("Sales Invoice Line"."Schedule Type") + FORMAT("Sales Invoice Line"."Schedule No");
                                Tot_1_6 := FORMAT("Sales Invoice Line"."Schedule Type") + FORMAT("Sales Invoice Line"."Schedule No");
                                IF Tot_1_6 = ' 0' THEN
                                    Tot_1_6 := '';
                                IF MRP = FALSE THEN BEGIN
                                    tot[k] [5] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Line Amount", 1)) + '.00';
                                    Tot_1_5 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Line Amount", 1)) + '.00';
                                    // tot[k][6]:=FORMAT("Sales Invoice Line"."Schedule No");
                                END ELSE BEGIN
                                    //B2BUpg>>
                                    /*tot[k] [5] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * ("Sales Invoice Line"."MRP Price" * (100 - "Sales Invoice Line"."Line Discount %") / 100), 1)) + '.00';
                                    Tot_1_5 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * ("Sales Invoice Line"."MRP Price" * (100 - "Sales Invoice Line"."Line Discount %") / 100), 1)) + '.00';
                                    tot[k] [7] := FormatadressNew.ChangeCurrency(ROUND(("Sales Invoice Line".Quantity * "Sales Invoice Line"."MRP Price") * ("Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';
                                    Tot_1_7 := FormatadressNew.ChangeCurrency(ROUND(("Sales Invoice Line".Quantity * "Sales Invoice Line"."MRP Price") * ("Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';*/
                                    //B2BUpg<<
                                    tot[k] [5] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * (100 - "Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';
                                    Tot_1_5 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * (100 - "Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';
                                    tot[k] [7] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * ("Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';
                                    Tot_1_7 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * ("Sales Invoice Line"."Line Discount %") / 100, 1)) + '.00';

                                END;
                                //B2Bupg>>
                                /*IF "Sales Invoice Header".Structure = 'SERVICE' THEN BEGIN
                                    d1[k] := "Sales Invoice Line".Description;
                                    d1_Text := ' ' + "Sales Invoice Line".Description;
                                END;*/
                                //B2Bupg<<

                                // Added by Pranavi on 03-07-2017
                                IF IsGSTApplicable THEN BEGIN

                                    Totals[1] += "Sales Invoice Line".Quantity;  //pranavi
                                    Totals[2] += ROUND("Sales Invoice Line"."Unit Price", 1);  //pranavi
                                    Totals[3] += ROUND("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price", 1);  //pranavi
                                    IF "Sales Invoice Line"."Line Discount %" <> 0 THEN
                                        Totals[4] += ROUND("Sales Invoice Line"."Line Amount", 1);  //pranavi
                                    Totals[8] += ROUND("Sales Invoice Line"."Line Amount", 1);  //pranavi
                                    Totals[7] += ROUND("Sales Invoice Line"."Amount To Customer", 0.1);  //pranavi

                                    tot[k] [4] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Unit Price", 0.001));   // unit price
                                    Tot_1_4 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Unit Price", 0.001));   // unit price
                                    tot[k] [5] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price", 1));
                                    Tot_1_5 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line".Quantity * "Sales Invoice Line"."Unit Price", 1));
                                    IF "Sales Invoice Line"."Line Discount %" <> 0 THEN BEGIN
                                        tot[k] [7] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Line Amount", 1));
                                        Tot_1_7 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Line Amount", 1));
                                    END;


                                    IF ("Sales Invoice Line"."GST Jurisdiction Type" = "Sales Invoice Line"."GST Jurisdiction Type"::Interstate) THEN BEGIN
                                        tot[k] [8] := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTPercent("Sales Invoice Line"), 1)) + '%';
                                        Tot_1_8 := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTPercent("Sales Invoice Line"), 1)) + '%';
                                        IF Tot_1_8 = '0%' THEN
                                            Tot_1_8 := '';
                                        tot[k] [9] := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTLineWise("Sales Invoice Line"), 1));
                                        Tot_1_9 := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTLineWise("Sales Invoice Line"), 1));
                                        IF Tot_1_9 IN ['0', '0.00'] THEN
                                            Tot_1_9 := '';
                                        Totals[6] += ROUND(GetSalesGSTLineWise("Sales Invoice Line"), 1);  //pranavi
                                    END ELSE BEGIN
                                        tot[k] [10] := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTPercent("Sales Invoice Line"), 1)) + '%';
                                        Tot_1_10 := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTPercent("Sales Invoice Line"), 1)) + '%';
                                        IF Tot_1_10 = '0%' THEN
                                            Tot_1_10 := '';
                                        tot[k] [11] := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTLineWise("Sales Invoice Line") / 2, 1));
                                        Tot_1_11 := FormatadressNew.ChangeCurrency(ROUND(GetSalesGSTLineWise("Sales Invoice Line") / 2, 1));
                                        IF Tot_1_11 IN ['0', '0.00'] THEN
                                            Tot_1_11 := '';
                                        Totals[5] += ROUND(GetSalesGSTLineWise("Sales Invoice Line") / 2, 1);  //pranavi
                                    END;
                                    tot[k] [12] := "Sales Invoice Line"."HSN/SAC Code";
                                    Tot_1_12 := "Sales Invoice Line"."HSN/SAC Code";
                                    tot[k] [13] := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Amount To Customer", 1));
                                    Tot_1_13 := FormatadressNew.ChangeCurrency(ROUND("Sales Invoice Line"."Amount To Customer", 1));

                                    Totals_Txt[1] := FormatadressNew.ChangeCurrency(ROUND(Totals[1], 1));
                                    Totals_Txt[2] := FormatadressNew.ChangeCurrency(ROUND(Totals[2], 1));
                                    Totals_Txt[3] := FormatadressNew.ChangeCurrency(ROUND(Totals[3], 1));
                                    Totals_Txt[4] := FormatadressNew.ChangeCurrency(ROUND(Totals[4], 1));
                                    Totals_Txt[5] := FormatadressNew.ChangeCurrency(ROUND(Totals[5], 1));
                                    Totals_Txt[6] := FormatadressNew.ChangeCurrency(ROUND(Totals[6], 1));
                                    Totals_Txt[7] := FormatadressNew.ChangeCurrency(Totals[7]);
                                    Totals_Txt[8] := FormatadressNew.ChangeCurrency(ROUND(Totals[8], 1));
                                END;
                                // end by pranavi

                                k := k + 1;


                            END;


                            //Sales Invoice Line, Footer (4) - OnPreSection()
                            IF choice = choice::Commercialinvoice THEN BEGIN
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                SalesInvFooter4 := FALSE;
                            END;

                            str := '-';
                            str1 := FORMAT("Sales Invoice Header"."External Document No.");
                            pos := STRPOS(str1, str);

                            IF (pos = 3) OR (pos = 4) THEN BEGIN
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                SalesInvFooter4 := FALSE;

                            END ELSE BEGIN
                                //CurrReport.SHOWOUTPUT:=TRUE;
                                SalesInvFooter4 := TRUE;
                            END;

                            // for packing and forward purpose
                            packing := 0;
                            forwarding := 0;
                            //B2BUpg>>
                            /*
                                                        pstr.SETRANGE(pstr."Invoice No.", "Sales Invoice Header"."No.");
                                                        IF pstr.FIND('-') THEN
                                                            REPEAT
                                                                IF pstr."Tax/Charge Group" = 'PACKING' THEN
                                                                    packing := packing + pstr."Calculation Value";

                                                                IF pstr."Tax/Charge Group" = 'FORWARDING' THEN
                                                                    forwarding := forwarding + pstr."Calculation Value";

                                                            UNTIL pstr.NEXT = 0;
                            */
                            //B2BUpg<<

                            //   CurrReport.SHOWOUTPUT(choice=choice::saleinvoice);
                            /*
                              IF ("Sales Invoice Line"."Tax %"=2)AND("Sales Invoice Line"."Tax Area Code"='SALES CST') THEN
                                caplabel:='(2% aganist Form - C)';
                              IF ("Sales Invoice Line"."Tax %"=3)AND("Sales Invoice Line"."Tax Area Code"='SALES CST') THEN
                                caplabel:='(3% aganist Form - C)';
                              IF ("Sales Invoice Line"."Tax %"=12.5)AND("Sales Invoice Line"."Tax Area Code"='SALES CST') THEN
                                caplabel:='(12.5%)';
                              IF ("Sales Invoice Line"."Tax %"=4)AND("Sales Invoice Line"."Tax Area Code"='SALES VAT') THEN
                                caplabel1:='4%';
                              IF ("Sales Invoice Line"."Tax %"=12.5)AND("Sales Invoice Line"."Tax Area Code"='SALES VAT') THEN
                              caplabel1:='12.5%';
                              IF ("Sales Invoice Line"."Tax Area Code"='SALES VAT') THEN
                              caplabel1:='';
                            */

                            s2 := ROUND(bedamt, 1);
                            check.InitTextVariable;
                            check.FormatNoText(descri1, s2, "Sales Invoice Header"."Currency Code");

                            //SREENIVAS-EFF
                            IF roundoff < 0 THEN
                                round1 := -(roundoff);
                            IF roundoff > 0 THEN
                                round1 := roundoff;
                            //MESSAGE(capt);

                            /*IF "Sales Invoice Header".Structure = 'SERVICE' THEN
                                SalesInvFooter4 := FALSE;*/
                            //CurrReport.SHOWOUTPUT:=FALSE;
                            IF (choice = choice::saleinvoice) THEN BEGIN
                                TotalBody1 := FALSE;
                            END;
                            str := '-';
                            str1 := FORMAT("Sales Invoice Header"."External Document No.");
                            pos := STRPOS(str1, str);
                            //CurrReport.SHOWOUTPUT:=TRUE;
                            IF (pos = 3) OR (pos = 4) THEN BEGIN
                                TotalBody1 := TRUE;
                            END;

                            IF roundoff < 0 THEN
                                round1 := -(roundoff);
                            IF roundoff > 0 THEN
                                round1 := roundoff;

                            // Total, Body (2) - OnPreSection()
                            // SREENIVAS-EFF
                            // s1:=ROUND(LineAmt+bedamt+cessamt+ecessamt+"Sales Invoice Line"."Tax Amount"+roundoff
                            // +"Sales Invoice Line"."Charges To Customer",1);

                            //  s1:=ROUND(LineTotAmt);
                            //  s1:=subtotal2;   anil

                            IF MRP = FALSE THEN
                                s1 := ROUND(LineTotAmt + roundoff, 1)
                            ELSE
                                s1 := ROUND(TotalLineAmt + roundoff, 1);

                            IF "Sales Invoice Header"."No." = 'EX-INV-17-18-00539' THEN
                                s1 := ROUND(20720, 1);
                            s1 := Totals[7];//added by sujani on 23-11-17 line no 885

                            if not TcsCalculated then begin //EFFUPG1.9
                                GetTCSAmt("Sales Invoice Header", "Sales Invoice Line");
                                s1 += TcsAmt;
                            end; //EFFUPG1.9 

                            check.InitTextVariable;
                            check.FormatNoText(descri, s1, "Sales Invoice Header"."Currency Code");


                            IF CopyLoop.Number = 1 THEN
                                CopyText := text007;
                            IF CopyLoop.Number = 2 THEN
                                CopyText := Text003;
                            IF CopyLoop.Number = 3 THEN
                                CopyText := text008;
                            IF CopyLoop.Number = 4 THEN
                                CopyText := text009;

                            CurrReport.PAGENO := 1;

                        end;

                        trigger OnPostDataItem()
                        begin
                            /*
                            s2:=ROUND(bedamt,1);
                            check.InitTextVariable;
                            check.FormatNoText(descri1,s2,'');
                            */

                        end;

                        trigger OnPreDataItem()
                        begin
                            // NAVIN
                            n := 0;
                            k := 1;
                            LineTotAmt := 0;
                            ExciseAmount := 0;
                            Charges := 0;
                            Othertaxes := 0;
                            SalesTax := 0;
                            bedamt := 0;
                            servicetaxamt := 0;
                            servicecess := 0;
                            CstVatAmt := 0;
                            taxamt := 0;
                            vatamt := 0;
                            Tot_GST_Amount := 0;  //pranavi




                            // NAVIN

                            VATAmountLine.DELETEALL;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");

                            // NAVIN
                            //CurrReport.CREATETOTALS("Line Amount",Amount,"Amount Including VAT","Inv. Discount Amount");
                            //CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount","Line Discount Amount", "Tax Amount","Amount Including Tax", "Excise Amount", "Tax Base Amount");
                            //CurrReport.CREATETOTALS("KK Cess Amount");
                            //CurrReport.CREATETOTALS(LineAmt);
                            // NAVIN
                            //taxamt:="Sales Invoice Line"."Tax Amount";
                            //vatamt:="Sales Invoice Line"."VAT Amount";
                            IF "Sales Invoice Header"."No." = 'EX-INV-16-17-00510' THEN BEGIN
                                s := '84711000';
                                capt := '(Microprocessor based data acquisition&control system)';
                            END;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmountLine.GetTotalVATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Total_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin

                            //Total, Body (1) - OnPreSection()
                            /* IF choice=choice::Commercialinvoice THEN
                             CurrReport.SHOWOUTPUT:=TRUE;  */

                            /*
                            IF (choice=choice::saleinvoice) THEN BEGIN
                             CurrReport.SHOWOUTPUT:=FALSE;
                             TotalBody1 := FALSE;
                            END;
                            str:='-';
                            str1:=FORMAT("Sales Invoice Header"."External Document No.");
                            pos:=STRPOS(str1,str);

                            IF (pos=3) OR (pos=4) THEN BEGIN
                             CurrReport.SHOWOUTPUT:=TRUE;
                             TotalBody1 := TRUE;
                            END;
                            */
                            // MESSAGE(FORMAT(ROUND(bedamt+cessamt+ecessamt)));
                            //anil
                            /*
                            IF roundoff<0 THEN
                               round1:=-(roundoff);
                            IF roundoff>0 THEN
                               round1:=roundoff;

                           //Total, Body (2) - OnPreSection()
                               //SREENIVAS-EFF
                                 s1:=ROUND(LineAmt+bedamt+cessamt+ecessamt+"Sales Invoice Line"."Tax Amount"+roundoff
                                 +"Sales Invoice Line"."Charges To Customer",1);
                               //  s1:=ROUND(LineTotAmt);
                             //  s1:=subtotal2;   anil
                               check.InitTextVariable;
                               check.FormatNoText(descri,s1,'');
                            */

                            //IF "Sales Invoice Header".Structure='SERVICE' THEN
                            //TotalBody1:=FALSE;

                        end;
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }

                }

                trigger OnAfterGetRecord()
                var

                begin

                    clear(TcsCalculated);// EFFUPG1.9

                end;

                trigger OnPostDataItem()
                begin
                    /*
                    IF NOT CurrReport.PREVIEW THEN
                      SalesInvCountPrinted.RUN("Sales Invoice Header");
                     */

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;

            }

            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "External Document No." = FIELD("External Document No.");
                DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending);
            }
            /*dataitem("Transit Document Order Details"; "Transit Document Order Details")
            {
                DataItemLink = "PO / SO No."=FIELD("No.");
                DataItemTableView = SORTING(Line No., Type, PO / SO No., Vendor / Customer Ref., State, Form No.) ORDER(Ascending);
            }*/

            trigger OnAfterGetRecord()
            begin
                IF ("Sales Invoice Header"."Currency Code" = 'USD') THEN BEGIN
                    Amount_type := 'Dollars';
                    Amount_type_symbol := 'USD)';
                END
                ELSE BEGIN
                    Amount_type := 'Rupees';
                    Amount_type_symbol := 'RS';
                END;

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");//B2BUpg

                CompanyInfo.GET;
                //IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);//B2BUpg
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "No.");
                //DetailedGSTLedgerEntry.SETRANGE("GST Component Code", GSTComponentCode[J]);//balu
                IF DetailedGSTLedgerEntry.FindFirst() THEN
                    IsGSTApplicable := true;
                Customer.GET("Bill-to Customer No.");
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                /*
                  //For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                  tin.RESET;
                  tin.SETCURRENTKEY(tin.Code,tin.Description,tin."Effective Date");
                  tin.SETFILTER(tin."Effective Date",'<=%1',"Sales Invoice Header"."Posting Date");
                  IF tin.FINDLAST THEN
                  BEGIN
                    TNo:=tin.Code;
                  END;
                  //end For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                */
                //MNRAJU FOR TIN NO. CHANGING
                /*tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "Sales Invoice Header"."Posting Date");
                tin.SETFILTER(tin.Group, 'TIN');
                IF tin.FINDLAST THEN BEGIN
                    TNo := tin.Code;
                END;

                tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "Sales Invoice Header"."Posting Date");
                tin.SETFILTER(tin.Group, 'CST');
                IF tin.FINDLAST THEN BEGIN
                    CSTNo := tin.Code;
                END;*///B2BUpg
                //MNRAJU FOR TIN NO. CHANGING


                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                Cust.GET("Bill-to Customer No.");

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.SalesInvShipTo(ShipToAddr, ShipToAddr, "Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;



                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;
                //B2BUpg
                /*
                                TDD.SETRANGE(TDD."Vendor / Customer Ref.", "Sales Invoice Header"."Sell-to Customer No.");
                                TDD.SETRANGE(TDD."PO / SO No.", "Sales Invoice Header"."Order No.");
                                IF TDD.FINDFIRST THEN
                                    wayb1 := TDD."Form No.";*///B2BUpg
                                                              //MESSAGE('%1',WayBillNo);
                LedOrder := COPYSTR("Sales Invoice Header"."Order No.", 14, 2);
                MRP := FALSE;
                Discount_Percnt := '0';
                SIL1.RESET;
                SIL1.SETRANGE(SIL1."Document No.", "Sales Invoice Header"."No.");
                SIL1.SETFILTER(SIL1."No.", '<>%1', '');
                SIL1.SETFILTER(SIL1.Quantity, '>%1', 0);
                IF SIL1.FINDSET THEN BEGIN
                    LinesCount := SIL1.COUNT;
                    REPEAT
                    //B2BUpg>>
                    /*IF (SIL1."MRP Price" > 0) AND SIL1.MRP THEN BEGIN
                        MRP := TRUE;
                        IF SIL1."Line Discount %" > 0 THEN
                            Discount_Percnt := FORMAT(SIL1."Line Discount %");
                    END;*/
                    //B2BUpg<<
                    UNTIL SIL1.NEXT = 0;
                END;
                // $Pranavi -- GST changes
                /*
                Det_GSTLedgEnt.RESET;
                Det_GSTLedgEnt.SETRANGE("Document No.","Sales Invoice Header"."No.");
                Det_GSTLedgEnt.SETRANGE("Posting Date","Sales Invoice Header"."Posting Date");
                Det_GSTLedgEnt.SETRANGE("GST Customer Type","GST Customer Type"::Unregistered);
                IF Det_GSTLedgEnt.FINDFIRST THEN
                BEGIN
                  IsReverseCharge := 'Yes';
                  REPEAT
                    Reverse_Charge_Amount+=formatadress.ChangeCurrency(ROUND(ABS(Det_GSTLedgEnt."GST Amount"),1));
                  UNTIL Det_GSTLedgEnt.NEXT=0;
                END ELSE
                BEGIN
                */
                IsReverseCharge := 'No';
                Reverse_Charge_Amount := 'N.A.';
                //END;

                Loc.RESET;
                Loc.SETRANGE(Code, "Sales Invoice Header"."Location Code");
                IF Loc.FINDFIRST THEN BEGIN
                    IF StateGRec.GET(Loc."State Code") THEN BEGIN
                        Sup_State_Code := StateGRec."State Code (GST Reg. No.)";
                        Sup_State := StateGRec.Description;
                    END;
                END;
                IF Customer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN BEGIN
                    IF StateGRec.GET(Customer."State Code") THEN BEGIN
                        Rec_State_Code := StateGRec."State Code (GST Reg. No.)";
                        Rec_State := StateGRec.Description;
                        Con_GSTReg_No := Customer."GST Registration No.";
                    END;
                END;
                IF ("Sales Invoice Header"."Ship-to Code" <> '') OR ("Sales Invoice Header"."Ship-to Address" <> '') OR ("Sales Invoice Header"."Ship-to Name" <> '') THEN BEGIN
                    IF ShipToAddrGRec.GET("Sales Invoice Header"."Sell-to Customer No.", "Sales Invoice Header"."Ship-to Code") THEN BEGIN
                        IF StateGRec.GET(ShipToAddrGRec.State) THEN BEGIN
                            Con_State_Code := StateGRec."State Code (GST Reg. No.)";
                            Con_State := StateGRec.Description;
                            Con_GSTReg_No := ShipToAddrGRec."GST Registration No.";
                        END;
                    END ELSE BEGIN
                        Con_State := Rec_State;
                        Con_State_Code := Rec_State_Code;
                    END;
                    CLE.RESET;
                    CLE.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                    IF CLE.FINDFIRST THEN BEGIN
                        IF StateGRec.GET(CLE."Seller State Code") THEN BEGIN
                            Con_State_Code := StateGRec."State Code (GST Reg. No.)";
                            Con_State := StateGRec.Description;
                            Con_GSTReg_No := CLE."Seller GST Reg. No.";
                        END;
                    END;
                END ELSE BEGIN
                    Con_State := Rec_State;
                    Con_State_Code := Rec_State_Code;
                END;
                /*IF EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Invoice", "No.") THEN
                    EInvoiceEntry.CALCFIELDS("QR Code");*///B2BUpg

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;  // NAVIN
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(options)
                {
                    field("No. of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                    }
                    field("Show Internal Information"; ShowInternalInfo)
                    {
                        ApplicationArea = All;
                    }
                    field("Log Interaction"; LogInteraction)
                    {
                        ApplicationArea = All;
                    }
                    field("Round Off Value"; roundoff)
                    {
                        ApplicationArea = All;
                    }
                    field(Choice; choice)
                    {
                        Visible = false;
                        ApplicationArea = All;
                    }
                    field("LBT No"; LBT_No)
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
    end;

    trigger OnPreReport()
    begin
        //IF NOT CurrReport.USEREQUESTFORM THEN
        InitLogInteraction;
        CompanyInfo.CALCFIELDS(Picture);
        UserName := USERID;
    end;

    var
        AmountGrec: Decimal;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        //GSTComponent: Record "GST Component";
        Customer: Record Customer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        //GSTManagement: Codeunit "GST Management";
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        TempLineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist." temporary;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit 5051;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        GSTCompAmount: array[20] of Decimal;
        GSTComponentCode: array[20] of Code[10];
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[30];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        DisplayAssemblyInformation: Boolean;
        LogInteraction: Boolean;
        "-NAVIN-": Integer;
        //StructureLineDetails: Record "Posted Str Order Line Details";
        TotalTaxAmount: Decimal;
        LineAmt: Decimal;
        LineTotAmt: Decimal;
        ExciseAmount: Decimal;
        Charges: Decimal;
        Othertaxes: Decimal;
        SalesTax: Decimal;
        ServiceTax: Decimal;
        saleorder: Record "Sales Header";
        s: Text[30];
        descri: array[2] of Text[250];
        check: Codeunit "Cancel Reservation Entries";
        s1: Decimal;
        bedamt: Decimal;
        cessamt: Decimal;
        ecessamt: Decimal;
        "sum": Decimal;
        desc: Text[30];
        cap: Text[40];
        n: Integer;
        c: Integer;
        capt: Text[250];
        s2: Decimal;
        descri1: array[2] of Text[60];
        caplabel: Text[30];
        waybillno: Code[10];
        caplabel1: Text[30];
        d1: array[35] of Text[300];
        tot: array[31, 13] of Text[30];
        k: Integer;
        saleinvoice: Record "Sales Invoice Line";
        choice: Option saleinvoice,Commercialinvoice;
        taxamt: Decimal;
        vatamt: Decimal;
        str: Text[5];
        str1: Text[30];
        pos: Integer;
        subtotal: Decimal;
        subtotal1: Decimal;
        sub: Decimal;
        sub1: Decimal;
        subtotal2: Decimal;
        sub2: Decimal;
        roundoff: Decimal;
        round1: Decimal;
        servicetaxamt: Decimal;
        servicecess: Decimal;
        servicetotal: Decimal;
        servicetax1: Decimal;
        cesstax: Decimal;
        num: array[4] of Text[60];
        bedcap: Text[6];
        //pstr: Record "Posted Str Order Line Details";//B2BUpg
        packing: Decimal;
        forwarding: Decimal;
        //EPS: Record "Excise Posting Setup";//B2BUpg>>
        bed: Decimal;
        CstVatAmt: Decimal;
        SSH: Record "Sales Shipment Header";
        //TDD: Record "Transit Document Order Details";//B2BUpg
        wayb1: Text[30];
        Capt12: Text[250];
        formatadress: Codeunit "Format Address";
        FormatadressNew: Codeunit "Correct Dimension Values Cust";
        TotalBody1: Boolean;
        SalesInvFooter4: Boolean;
        TotalLineAmt: Decimal;
        LBT_No: Code[30];
        //tin: Record "T.I.N. Nos.";
        TNo: Text[15];
        CSTNo: Text;
        UnitPriceIncDiscnt: Decimal;
        LedOrder: Code[2];
        ServiceTaxSBCAmount: Decimal;
        ServiceTaxSBCAmt: Decimal;
        AppliedServiceTaxSBCAmt: Decimal;
        KKCessAmount: Decimal;
        KKCessAmt: Decimal;
        AppliedKKCessAmt: Decimal;
        MRP: Boolean;
        SIL1: Record "Sales Invoice Line";
        Discount_Percnt: Code[10];
        Itm: Record Item;
        IsGSTApplicable: Boolean;
        J: Integer;
        GSTDetails: array[10, 8] of Code[30];
        IsReverseCharge: Text[3];
        Det_GSTLedgEnt: Record "Detailed GST Ledger Entry";
        Sup_State_Code: Code[5];
        Rec_State_Code: Code[5];
        Con_State_Code: Code[5];
        Loc: Record Location;
        StateGRec: Record State;
        Sup_State: Text;
        Rec_State: Text;
        Con_State: Text;
        ShipToAddrGRec: Record "Ship-to Address";
        Con_GSTReg_No: Code[15];
        Tot_GST_Amount: Decimal;
        Totals: array[8] of Decimal;
        Totals_Txt: array[8] of Text[30];
        Reverse_Charge_Amount: Text;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'DUPLICATE FOR TRANSPORTER';
        Text004: Label 'Sales - Invoice %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        text007: Label 'ORIGINAL FOR BUYER';
        text008: Label 'TRIPLICATE FOR ASSESSEE';
        text009: Label 'ORIGINAL FOR BUYER';
        Text010: Label 'Sales - Prepayment Invoice %1';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        INVOICE_NO_CaptionLbl: Label 'INVOICE NO:';
        DATE__CaptionLbl: Label 'DATE :';
        Tin_No__28350166764CaptionLbl: Label 'Tin No. 28350166764';
        CST_No__VJ2_07_1_1976_02_05_1988CaptionLbl: Label 'CST No. VJ2-07-1-1976/02-05-1988';
        Consignee_Name___AddressCaptionLbl: Label 'Consignee Name & Address';
        Your_Order_No_CaptionLbl: Label 'Your Order No.';
        Dt__CaptionLbl: Label 'Your Order Date.:';
        TIME_OF_ISSUE_OF_INVOICECaptionLbl: Label 'TIME OF ISSUE OF INVOICE';
        WAY_BILL_NO_CaptionLbl: Label 'WAY BILL NO.';
        Regd__Office___Factory__CaptionLbl: Label 'Regd. Office - Factory :';
        EmptyStringCaptionLbl: Label ',';
        S_noCaptionLbl: Label 'S.no';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Unit_PriceCaptionLbl: Label 'Unit Price(';
        AmountCaptionLbl: Label 'Amount(';
        No_of_PacketsCaptionLbl: Label 'No.of Packets';
        Sch__NoCaptionLbl: Label 'Sch. No';
        Sub_TotalCaptionLbl: Label 'Sub Total';
        Details_of_Reduction_Additions_made_to_arrive_at_value_under_sec__4_at_the_ActCaptionLbl: Label 'Details of Reduction/Additions made to arrive at value under sec. 4 at the Act';
        Tariff_Heading_No__CaptionLbl: Label 'Tariff Heading No.:';
        Exemption_notification_No_CaptionLbl: Label 'Exemption notification No.';
        PackingCaptionLbl: Label 'Packing';
        Total_Assessable_Value_or_Tariff_ValueCaptionLbl: Label 'Total Assessable Value or Tariff Value';
        Serial_Number_of_Debit___Entry_in_PLA___Rg_23A_Part_II_CaptionLbl: Label 'Serial Number of Debit   Entry in PLA / Rg-23A Part II:';
        B_E_D__Rate________CaptionLbl: Label 'B.E.D. Rate     :  ';
        Total_Duty_Paid___in_words_CaptionLbl: Label 'Total Duty Paid :(in words)';
        Sub_Total____CaptionLbl: Label 'Sub Total   :';
        E_Cess___2___on_BEDCaptionLbl: Label 'E.Cess:  2 % on BED';
        SHE_Cess___1___on_BEDCaptionLbl: Label 'SHE Cess : 1 % on BED';
        Sub_Total_______CaptionLbl: Label 'Sub Total      :';
        GRAND_TOTAL___CaptionLbl: Label 'GRAND TOTAL  :';
        Mode_of_Transport___Vechicle_Regn_No_CaptionLbl: Label 'Mode of Transport & Vechicle Regn.No:';
        Customer_s_Signature__CaptionLbl: Label 'Customer''s Signature :';
        DateCaptionLbl: Label 'Date';
        Time_of_Removal_of_GoodsCaptionLbl: Label 'Time of Removal of Goods';
        EmptyStringCaption_Control1000000082Lbl: Label '------------';
        VATCaptionLbl: Label 'VAT';
        CSTCaptionLbl: Label 'CST';
        Round_offCaptionLbl: Label 'Round off';
        ForwardingCaptionLbl: Label 'Forwarding';
        EmptyStringCaption_Control1102154049Lbl: Label '%';
        EmptyStringCaption_Control1102154050Lbl: Label '%';
        Mode_of_Transport___Vechicle_Regn_No_Caption_Control1000000205Lbl: Label 'Mode of Transport & Vechicle Regn.No:';
        Packing___ForwardingCaptionLbl: Label 'Packing & Forwarding';
        EmptyStringCaption_Control1000000208Lbl: Label '-------------';
        Sub_TotalCaption_Control1000000209Lbl: Label 'Sub Total';
        Sub_TotalCaption_Control1000000211Lbl: Label 'Sub Total';
        CSTCaption_Control1000000213Lbl: Label 'CST';
        VATCaption_Control1000000216Lbl: Label 'VAT';
        GRAND_TOTAL___Caption_Control1000000219Lbl: Label 'GRAND TOTAL  :';
        InsuranceCaptionLbl: Label 'Insurance';
        EmptyStringCaption_Control1000000222Lbl: Label '----------------';
        Customer_s_Signature__Caption_Control1000000230Lbl: Label 'Customer''s Signature :';
        Round_offCaption_Control1102154004Lbl: Label 'Round off';
        Certified_that_Particulars: Label 'Certified that the Particulars given above are true and correct and the amount indicated represents the price actually charged and that there is no flow of additional consideration directly or indirectly from the buyer';
        Rupees__in_Words__CaptionLbl: Label ' (in Words):';
        For_Efftronics_Systems: Label 'For Efftronics Systems (P) Ltd.,';
        Authorised_SignatoryCaptionLbl: Label 'Authorised Signatory';
        Prepared_byCaptionLbl: Label 'Prepared by';
        Checked_byCaptionLbl: Label 'Checked by';
        GoodsCaptionLbl: Label '*  Goods once sold cannot be taken back';
        OursResCapionLbl: Label '*  Our responsibility cases ex; our Works / Godown';
        SubjectCaptionLbl: Label '*  Subject to Vijayawada Jurisdiction only';
        EOECAptionLbl: Label '*  E & O.E.';
        C_E__RegN__No__AAACE4879QXM001Lbl: Label 'C.E. RegN. No. AAACE4879QXM001';
        ECCCaptionLbl: Label 'E.C. Code No. AAACE 4879Q XM001.Range IV:divn:Vijayawada  ';
        CentralCaptionLbl: Label 'Central Revenue Building, M.G. Road, Vijayawada - 520002';
        TinNo: Label 'Tin';
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        SvcTaxSBCAmtAppliedCaptionLbl: Label 'SBC Amt (Applied)';
        KKCessAmtCaptionLbl: Label 'KKC Amount';
        KKCessAmtAppliedCaptionLbl: Label 'KKC Amt (Applied)';
        MRPCaptionLbl: Label 'MRP Price(Rs)';
        DiscountedPriceCaptionLbl: Label 'Discounted Price';
        Tot_MRP_Price_Caption: Label 'Total MRP Price';
        Tot_Amt_After_Discount_Caption: Label 'Total Amount After Discount';
        Excise_Rate_Caption: Label 'Exice Rate';
        AbatementCaption: Label 'Abatement';
        VatCaption: Label 'Vat';
        CSTCaption: Label 'CST';
        FinalAmt_Caption: Label 'Final Amount';
        Abatement_Notification_Caption: Label 'Abatement Notification No.: ';
        CompanyRegistrationLbl: Label 'Company Registration No.';
        CustomerRegistrationLbl: Label 'Customer GST Reg No.';
        GSTINLbl: Label 'GSTIN : ';
        Reverse_Charge_Lbl: Label 'Reverse Charge :';
        State_Code_Lbl: Label 'State Code : ';
        ModeOfTransportLbl: Label 'Mode Of Transport : ';
        VehicleNoLbl: Label 'Vehicle No. : ';
        DateOfSupplyLbl: Label 'Date Of Supply : ';
        PlaceOfSupplyLbl: Label 'Place Of Supply : ';
        GSTGroup: Record "GST Group";
        d1_Text: Text;
        Tot_1_1: Text[30];
        Tot_1_2: Text[30];
        Tot_1_3: Text[30];
        Tot_1_4: Text[30];
        Tot_1_5: Text[30];
        Tot_1_6: Text[30];
        Tot_1_7: Text[30];
        Tot_1_8: Text[30];
        Tot_1_9: Text[30];
        Tot_1_10: Text[30];
        Tot_1_11: Text[30];
        Tot_1_12: Text[30];
        Tot_1_13: Text[30];
        UserName: Code[50];
        LinesCount: Integer;
        Amount_type: Code[50];
        Amount_type_symbol: Code[50];
        CLE: Record "Cust. Ledger Entry";
        //EInvoiceEntry: Record "E-Invoice Entry";//B2BUpg
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        TcsAmt: Decimal;
        TcsCalculated: Boolean;//EFFUPG1.9


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

    local procedure GetSalesGSTLineWise(SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindFirst() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            exit(ABS(DetailedGSTLedgerEntry."GST Amount")); //BaluOn18Oct2022

        end;
    end;

    local procedure GetTCSAmt(SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line")
    var
        TCSEntry: Record "TCS Entry";
    begin
        Clear(TCSAmt);
        TCSEntry.Reset();
        TCSEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        if TCSEntry.FindSet() then
            repeat
                if SalesInvoiceHeader."Currency Code" <> '' then
                    TCSAmt += SalesInvoiceHeader."Currency Factor" * TCSEntry."Total TCS Including SHE CESS"
                else
                    TCSAmt += TCSEntry."Total TCS Including SHE CESS";
                TCSAmt := Round(TCSAmt, 1);
            until TCSEntry.Next() = 0;
        TcsCalculated := true;//EFFUPG1.9
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

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;


    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Invoice Line"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF "Sales Invoice Header"."Order No." = '' THEN
            EXIT("Sales Invoice Header"."Posting Date");

        CASE "Sales Invoice Line".Type OF
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Invoice Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Invoice Header"."Posting Date");
    end;


    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;


    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF "Sales Invoice Header"."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                END;
            UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;


    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;


    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        SalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        SalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        SalesShipmentBuffer."Entry No." := NextEntryNo;
        SalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        SalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        SalesShipmentBuffer.Quantity := QtyOnShipment;
        SalesShipmentBuffer."Posting Date" := PostingDate;
        SalesShipmentBuffer.INSERT;
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Sales Invoice Header"."Prepayment Invoice" THEN
            EXIT(Text010);
        EXIT(Text004);
    end;


    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;


    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL;
        IF "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item THEN
            EXIT;
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SETRANGE("Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
        ValueEntry.SETRANGE(Adjustment, FALSE);
        IF NOT ValueEntry.FINDSET THEN
            EXIT;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT = 0;
    end;


    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
    end;


    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;


    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

    local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
    var
        LineFeeNoteOnReportHist: Record "Line Fee Note on Report Hist.";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Customer: Record Customer;
    begin
        TempLineFeeNoteOnReportHist.DELETEALL;
        CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
        IF NOT CustLedgerEntry.FINDFIRST THEN
            EXIT;

        IF NOT Customer.GET(CustLedgerEntry."Customer No.") THEN
            EXIT;

        LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
        LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
        IF LineFeeNoteOnReportHist.FINDSET THEN BEGIN
            REPEAT
                TempLineFeeNoteOnReportHist.INIT;
                TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                TempLineFeeNoteOnReportHist.INSERT;
            UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END ELSE BEGIN
            //LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguage);//B2BUpg
            IF LineFeeNoteOnReportHist.FINDSET THEN
                REPEAT
                    TempLineFeeNoteOnReportHist.INIT;
                    TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
                    TempLineFeeNoteOnReportHist.INSERT;
                UNTIL LineFeeNoteOnReportHist.NEXT = 0;
        END;
    end;
}

