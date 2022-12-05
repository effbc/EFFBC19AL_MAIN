report 50246 "Sales - Credit Memo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SalesCreditMemo.rdl';
    Caption = 'Sales - Credit Memo';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(QRCode; "QR Code")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                PrintOnlyIfDetail = true;
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(DocCaptionCopyText; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyRegistrationLbl; CompanyRegistrationLbl)
                    {
                    }
                    column(CompanyInfo_GST_RegistrationNo; CompanyInfo."GST Registration No.")
                    {
                    }
                    column(CompanyInfo_EMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo_HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfo_Phone; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo_Fax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CustomerRegistrationLbl; CustomerRegistrationLbl)
                    {
                    }
                    column(Customer_GST_RegistrationNo; Customer."GST Registration No.")
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Registration No.")
                    {
                    }
                    column(No1_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText; AppliedToText)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "Sales Cr.Memo Header"."Your Reference")
                    {
                    }
                    
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText; ReturnOrderNoText)
                    {
                    }
                    column(RetOrderNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Return Order No.")
                    {
                    }
                    column(SupplementaryText; SupplementaryText)
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricInclVAT1_SalesCrMemoHeader; FORMAT("Sales Cr.Memo Header"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPct_SalesCrMemoHeader; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(RegNoCaption; RegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(CrMemoNoCaption; CrMemoNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricIncVAT_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Prices Including VAT"))
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
                    column(IsGSTApplicable; IsGSTApplicable)
                    {
                    }

                    column(QR_CODE; '')
                    {
                    }
                    column(HSN; "Sales Cr.Memo Line"."HSN/SAC Code")
                    {
                    }
                    column(GST_Rate; FORMAT(ROUND(GetSalesGSTPercent("Sales Cr.Memo Line", false), 1)) + ' %')
                    {
                    }
                    column(Line_GST_Base_Amt; GetSalesGSTPercent("Sales Cr.Memo Line", true))
                    {
                    }
                    column(Line_Tot_GST_Amt; GetSalesGSTLineWise("Sales Cr.Memo Line"))
                    {
                    }
                    column(Tax_Type; "Sales Cr.Memo Line"."GST Jurisdiction Type")
                    {
                    }
                    column(Amt_To_Customer; "Sales Cr.Memo Line"."Amount To Customer")
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_IntegerLine; Number)
                        {
                        }
                        column(HdrDimCaption; HdrDimCaptionLbl)
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
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Noseq; Noseq)
                        {
                        }
                        column(Certify_Caption; Certify_Caption)
                        {
                        }
                        column(Ship2Name; "Sales Cr.Memo Header"."Ship-to Name")
                        {
                        }
                        column(Ship2Addrs; "Sales Cr.Memo Header"."Ship-to Address")
                        {
                        }
                        column(Ship2Adrs2; "Sales Cr.Memo Header"."Ship-to Address 2")
                        {
                        }
                        column(Ship2City; "Sales Cr.Memo Header"."Ship-to City")
                        {
                        }
                        column(Ship2Contact; "Sales Cr.Memo Header"."Ship-to Contact")
                        {
                        }
                        column(Ship2PostCode; "Sales Cr.Memo Header"."Ship-to Post Code")
                        {
                        }
                        column(Ship2Country; "Sales Cr.Memo Header"."Ship-to County")
                        {
                        }
                        column(Rupees_Words_Caption; Rupees_Words_Caption)
                        {
                        }
                        column(ShiptoAddrCaption1; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(LineAmt_SalesCrMemoLine; ROUND("Line Amount", 1))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine; Description)
                        {
                        }
                        column(No_SalesCrMemoLine; "No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine; Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesCrMemoLine; "Line Discount %")
                        {
                        }
                        column(DiscAmt_SalesCrMemoLineLine; "Line Discount Amount")
                        {
                        }
                        column(PostedReceiptDate; FORMAT(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalInvDiscAmt; NNC_TotalInvDiscAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(SourceDoctType; 'Ref: ' + '')
                        {
                        }
                        column(SourceDocNo_SalesCrMemoLine; '')
                        {
                        }
                        column(Supplementary_SalesCrMemoLine; '')
                        {
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesCrMemoLine; Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }

                        column(ExciseAmt_SalesCrMemoLine; '')
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServTaxAmt_SalesCrMemoLine; '')
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(ServTaxeCessAmt_SalesCrMemoLine; '')
                        {
                        }
                        column(TDSTCSAmt_SalesCrMemoLine; GetTCSAmt("Sales Cr.Memo Header", "Sales Cr.Memo Line"))
                        {
                        }
                        column(ServTaxSHECessAmt_SalesCrMemoLine; '')
                        {
                        }
                        column(TaxAmt_SalesCrMemoLine; '')
                        {
                        }
                        column(ChargesAmount; ChargesAmount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(OtherTaxesAmount; OtherTaxesAmount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalIncl_SalesCrMemoLine; GetTCSAmt("Sales Cr.Memo Header", "Sales Cr.Memo Line"))
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }

                        column(ServiceTaxAmt_SalesCrMemoLine; '')
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclTax_SalesCrMemoLine; '')
                        {
                        }
                        column(NNCTotalAmtToCust; NNC_TotalAmountToCustomer)
                        {
                        }
                        column(NNCTotalExciseAmt; NNC_TotalExciseAmount)
                        {
                        }
                        column(NNCTotalTaxAmt; NNC_TotalTaxAmount)
                        {
                        }
                        column(NNCTotalServTaxAmt; NNC_TotalServiceTaxAmount)
                        {
                        }
                        column(NNCTSTaxeCessAmt; NNC_TSTaxeCessAmount)
                        {
                        }
                        column(NNCTSTSHECessAmt; NNC_TSTSHECessAmount)
                        {
                        }
                        column(NNCttdstcsishecess; NNC_TTDSTCSISHECESS)
                        {
                        }
                        column(AmountIncludingVATAmt1; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText1; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText1; TotalExclVATText)
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(DiscAmtCaption; DiscAmtCaptionLbl)
                        {
                        }
                        column(PostedReceiptDateCaption; PostedReceiptDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubTotalCaption; SubTotalCaptionLbl)
                        {
                        }
                        column(ExciseAmtCaption; ExciseAmtCaptionLbl)
                        {
                        }
                        column(TaxAmtCaption; TaxAmtCaptionLbl)
                        {
                        }
                        column(ServTaxAmtCaption; ServTaxAmtCaptionLbl)
                        {
                        }
                        column(ChargesAmtCaption; ChargesAmtCaptionLbl)
                        {
                        }
                        column(OtherTaxesAmtCaption; OtherTaxesAmtCaptionLbl)
                        {
                        }
                        column(ServiceTaxeCessAmtCaption; ServiceTaxeCessAmtCaptionLbl)
                        {
                        }
                        column(TotalTDSIncludingeCessCaption; TotalTDSIncludingeCessCaptionLbl)
                        {
                        }
                        column(TCSAmountCaption; TCSAmountCaptionLbl)
                        {
                        }
                        column(ServiceTaxSHECessAmtCaption; ServiceTaxSHECessAmtCaptionLbl)
                        {
                        }
                        column(PaymentDiscOnVATCaption; PaymentDiscOnVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesCrMemoLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Descri1; descri1[1])
                        {
                        }
                        column(LineTotAmt; LineTotAmt)
                        {

                        }
                        column(NNCTotalServTaxSBCAmt; NNC_TotalServiceTaxSBCAmount)
                        {
                        }
                        column(ServTaxSBCAmtCaption; ServTaxSBCAmtCaptionLbl)
                        {
                        }
                        column(NNCTotalKKCessAmt; NNC_TotalKKCessAmount)
                        {
                        }
                        column(KKCessAmtCaption; KKCessAmtCaptionLbl)
                        {
                        }

                        column(SBCAmt; '')
                        {
                        }
                        column(KKCAmt; '')
                        {
                        }
                        column(Cess1Caption; Cess1Caption)
                        {
                        }
                        column(Cess2Caption; Cess2Caption)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShipmentBufferQuantity; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FIND('-') THEN
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin

                            /*
                            VATAmountLine.INIT;
                            VATAmountLine."Tax Identifier" := "VAT Identifier";
                            VATAmountLine."Tax Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."Tax %" := "VAT %";
                            VATAmountLine."Tax Base" := Amount;
                            VATAmountLine."Amount Including Tax" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                              VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine;
                            */
                            Noseq := Noseq + 1;
                            // NAVIN
                            LineAmt := "Sales Cr.Memo Line".Quantity * "Sales Cr.Memo Line"."Unit Price";
                            //LineAmt :="Sales Cr.Memo Line"."Amount To Customer";


                            LineTotAmt := LineTotAmt + LineAmt;
                            TotalAmount := TotalAmount + LineTotAmt;
                            IF (Type <> Type::" ") THEN BEGIN
                                J := 1;
                                //GSTComponent.RESET;
                                //GSTComponent.SETRANGE("GST Jurisdiction Type", "GST Jurisdiction Type");
                                //IF GSTComponent.FINDSET THEN
                                // REPEAT
                                // GSTComponentCode[J] := GSTComponent.Code;
                                DetailedGSTLedgerEntry.RESET;
                                DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                                DetailedGSTLedgerEntry.SETRANGE("Document No.", "Document No.");
                                DetailedGSTLedgerEntry.SETRANGE("Document Line No.", "Line No.");
                                //DetailedGSTLedgerEntry.SETRANGE("GST Component Code", GSTComponentCode[J]);
                                IF DetailedGSTLedgerEntry.FINDSET THEN BEGIN
                                    REPEAT
                                        GSTCompAmount[J] +=
                                          CurrExchRate.ExchangeAmtLCYToFCY(
                                            DetailedGSTLedgerEntry."Posting Date", DetailedGSTLedgerEntry."Currency Code",
                                            DetailedGSTLedgerEntry."GST Amount", DetailedGSTLedgerEntry."Currency Factor");
                                    UNTIL DetailedGSTLedgerEntry.NEXT = 0;
                                    J += 1;
                                END;
                                //UNTIL GSTComponent.NEXT = 0;
                            END;
                            //B2BUpg>>
                            /*StructureLineDetails.SETRANGE(StructureLineDetails.Type, StructureLineDetails.Type::Sale);
                            StructureLineDetails.SETFILTER(StructureLineDetails."Document Type", '%1|%2', StructureLineDetails."Document Type"::"Credit Memo",
                              StructureLineDetails."Document Type"::"Return Order");
                            StructureLineDetails.SETRANGE(StructureLineDetails."Invoice No.", "Document No.");
                            StructureLineDetails.SETRANGE(StructureLineDetails."Item No.", "No.");
                            StructureLineDetails.SETRANGE("Line No.", "Line No.");
                            IF StructureLineDetails.FIND('-') THEN
                                REPEAT
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges THEN
                                        Charges := Charges + StructureLineDetails.Amount;
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                        Othertaxes := Othertaxes + StructureLineDetails.Amount;
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Sales Tax" THEN
                                        SalesTax := SalesTax + StructureLineDetails.Amount;
                                    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                        ServiceTax := ServiceTax + StructureLineDetails.Amount;

                                    //    IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::VAT THEN
                                    //      VATAmount := VATAmount + StructureLineDetails.Amount;
                                    IF (NOT (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise)) THEN
                                        TotalAmount := TotalAmount + StructureLineDetails.Amount;
                                UNTIL StructureLineDetails.NEXT = 0;

                            ExciseAmount += "Excise Amount";
                            TotalAmount += "Excise Amount";
                            LineTotAmt1 := LineTotAmt1 + "Line Amount" + "Excise Amount" + "Service Tax Amount" + "Service Tax eCess Amount" + "TDS/TCS Amount" + "Service Tax SHE Cess Amount" + "Tax Amount" + ChargesAmount;
                            LineTotAmt += "Sales Cr.Memo Line"."Total GST Amount";*/

                            // ToTalAMount1 += "Sales Cr.Memo Line"."Amount to Customer";
                            // TotalAmount1 := TotalAmount1 / 4;
                            GetSalesGSTAmount("Sales Cr.Memo Header", "Sales Cr.Memo Line");
                            LineTotAmt := LineTotAmt + IGSTAmt + CGSTAmt + SGSTAmt;
                            //B2BUpg<<
                            s1 := ROUND(LineTotAmt1, 1);
                            check.InitTextVariable;
                            check.FormatNoText(descri1, LineTotAmt, "Sales Cr.Memo Header"."Currency Code");//LineTotAmt1

                            // NAVIN
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';

                        end;

                        trigger OnPreDataItem()
                        begin
                            //Clear(TotalAmount1);
                            // NAVIN
                            LineTotAmt := 0;
                            LineAmt := 0;
                            TotalAmount := 0;
                            // NAVIN

                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            // NAVIN
                            //CurrReport.CREATETOTALS(Amount,"Amount Including VAT","Inv. Discount Amount");
                            /*CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount",
                            "Line Discount Amount", "Inv. Discount Amount", "Amount Including Excise",
                            "Amount Including Tax", "Excise Amount", "Tax Base Amount");
                            CurrReport.CREATETOTALS(LineAmt, "Excise Base Amount");
                            CurrReport.CREATETOTALS("KK Cess Amount");*/
                            //CurrReport.CREATETOTALS(LineAmt,"Bal. TDS Including eCESS","Work Tax Amount");
                            // NAVIN
                            Noseq := -1;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmt1Caption; InvDiscAmt1CaptionLbl)
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
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
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
                        column(VATAmtLineVAT1; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code",
                                "Sales Cr.Memo Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Cr.Memo Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text008 + Text009
                            ELSE
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeaderCaption; "Sales Cr.Memo Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PAGENO := 1;
                    IF Number > 1 THEN
                        CopyText := Text004;
                    NNC_TotalServiceTaxSBCAmount := 0;
                    NNC_TotalKKCessAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    /*
                    IF NOT CurrReport.PREVIEW THEN
                      SalesCrMemoCountPrinted.RUN("Sales Cr.Memo Header");
                    */

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 4;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");//B2BUpg
                //IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);//B2BUpg
                //IsGSTApplicable := GSTManagement.IsGSTApplicable(Structure);
                DetailedGSTLedgerEntry.RESET;
                DetailedGSTLedgerEntry.SETCURRENTKEY("Transaction Type", "Document Type", "Document No.", "Document Line No.");
                DetailedGSTLedgerEntry.SETRANGE("Transaction Type", DetailedGSTLedgerEntry."Transaction Type"::Sales);
                DetailedGSTLedgerEntry.SETRANGE("Document No.", "No.");
                //DetailedGSTLedgerEntry.SETRANGE("GST Component Code", GSTComponentCode[J]);//balu
                IF DetailedGSTLedgerEntry.FindFirst() THEN
                    IsGSTApplicable := true;
                Customer.GET("Bill-to Customer No.");
                CompanyInfo.GET;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Return Order No." = '' THEN
                    ReturnOrderNoText := ''
                ELSE
                    ReturnOrderNoText := FIELDCAPTION("Return Order No.");
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
                    TotalExclVATText := STRSUBSTNO(Text007, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text007, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                /*IF "Applies-to Doc. No." = '' THEN
                  AppliedToText := ''
                ELSE
                  AppliedToText := STRSUBSTNO(Text003,"Applies-to Doc. Type","Applies-to Doc. No.");
                */
                AppliedToText := "Sales Cr.Memo Header"."External Document No.";

                FormatAddr.SalesCrMemoShipTo(ShipToAddr, ShipToAddr, "Sales Cr.Memo Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                // Added by Pranavi on 08-06-2016 for sb and kk cess amount inclusion
                EVALUATE(TempDate, '01-06-2016');
                IF "Sales Cr.Memo Header"."Posting Date" >= TempDate THEN BEGIN
                    Cess1Caption := ServTaxSBCAmtCaptionLbl;
                    Cess2Caption := KKCessAmtCaptionLbl;
                END ELSE BEGIN
                    Cess1Caption := ServiceTaxeCessAmtCaptionLbl;
                    Cess2Caption := ServiceTaxSHECessAmtCaptionLbl;
                END;
                // end by pranavi
                //B2BUpg>>
                /*
                IF EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Cr. Memo", "No.") THEN
                    EInvoiceEntry.CALCFIELDS("QR Code");*/
                //B2BUpg<<

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.GET;  // NAVIN
                n := 0;
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

    trigger OnInitReport()
    begin
        GLSetup.GET;
        SalesSetup.GET;
        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
    end;

    var
        TotalAmount1: Decimal;
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '(Applies to %1 %2)';
        Text004: Label 'COPY';
        Text005: Label 'Sales - Credit Memo %1';
        PageCaptionCap: Label 'Page %1 of %2';
        Text007: Label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        //GSTComponent: Record "GST Component";//B2BUpg
        Customer: Record Customer;
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        RespCenter: Record "Responsibility Center";
        //GSTManagement: Codeunit "GST Management";//B2BUpg
        SalesCrMemoCountPrinted: Codeunit 316;
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit 5051;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ReturnOrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        AppliedToText: Text;
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        FirstValueEntryNo: Integer;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        Text008: Label 'VAT Amount Specification in ';
        Text009: Label 'Local Currency';
        Text010: Label 'Exchange rate: %1/%2';
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        Text011: Label 'Sales - Prepmt. Credit Memo %1';
        OutputNo: Integer;
        NNC_TotalLineAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        NNC_TotalAmount: Decimal;
        ChargesAmount: Decimal;
        OtherTaxesAmount: Decimal;
        Text13700: Label 'Total %1 Incl. Taxes';
        Text13701: Label 'Total %1 Excl. Taxes';
        SupplementaryText: Text[30];
        Text16500: Label 'Supplementary Credit Memo';
        NNC_TotalAmountToCustomer: Decimal;
        NNC_TotalExciseAmount: Decimal;
        NNC_TotalTaxAmount: Decimal;
        NNC_TotalServiceTaxAmount: Decimal;
        NNC_TSTaxeCessAmount: Decimal;
        NNC_TSTSHECessAmount: Decimal;
        NNC_TTDSTCSISHECESS: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.';
        RegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankNameCaptionLbl: Label 'Bank';
        BankAccNoCaptionLbl: Label 'Account No.';
        CrMemoNoCaptionLbl: Label 'Credit Memo No.';
        PostingDateCaptionLbl: Label 'Posting Date';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        DiscPercentCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        DiscAmtCaptionLbl: Label 'Line Discount Amount';
        PostedReceiptDateCaptionLbl: Label 'Posted Return Receipt Date';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubTotalCaptionLbl: Label 'Subtotal';
        ExciseAmtCaptionLbl: Label 'Excise Amount';
        TaxAmtCaptionLbl: Label 'Tax Amount';
        ServTaxAmtCaptionLbl: Label 'Service Tax Amount';
        ChargesAmtCaptionLbl: Label 'Charges Amount';
        OtherTaxesAmtCaptionLbl: Label 'Other Taxes Amount';
        ServiceTaxeCessAmtCaptionLbl: Label 'Service Tax eCess Amount';
        TotalTDSIncludingeCessCaptionLbl: Label 'Total TDS Including eCess';
        TCSAmountCaptionLbl: Label 'TCS Amount';
        ServiceTaxSHECessAmtCaptionLbl: Label 'Service Tax SHE Cess Amount';
        PaymentDiscOnVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        VATPercentCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvDiscAmt1CaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        HomePageCaptionLbl: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        IsGSTApplicable: Boolean;
        J: Integer;
        CompanyRegistrationLbl: Label 'Company Registration No.';
        CustomerRegistrationLbl: Label 'Customer GST Reg No.';
        GSTCompAmount: array[20] of Decimal;
        GSTComponentCode: array[20] of Code[10];
        //StructureLineDetails: Record "Posted Str Order Line Details";//B2BUpg
        TotalAmount: Decimal;
        LineAmt: Decimal;
        LineTotAmt: Decimal;
        ExciseAmount: Decimal;
        Charges: Decimal;
        Othertaxes: Decimal;
        SalesTax: Decimal;
        VATAmount: Decimal;
        ServiceTax: Decimal;
        NNC_TotalServiceTaxSBCAmount: Decimal;
        ServTaxSBCAmtCaptionLbl: Label 'SBC Amount';
        NNC_TotalKKCessAmount: Decimal;
        KKCessAmtCaptionLbl: Label 'KK Cess Amount';
        check: Codeunit 60002;
        descri: array[4] of Text[250];
        s1: Decimal;
        n: Integer;
        Tin___28350166764CaptionLbl: Label 'Tin : 28350166764';
        CST_No__VJ2_07_1_1976_02_05_1988CaptionLbl: Label 'CST No. VJ2-07-1-1976/02-05-1988';
        SYSTEMS_PVT__LTD_CaptionLbl: Label 'SYSTEMS PVT. LTD.';
        ToCaptionLbl: Label 'To';
        M_s_CaptionLbl: Label 'M/s.';
        Date___CaptionLbl: Label 'Date  :';
        SI_no_CaptionLbl: Label 'SI.no.';
        PARTICULARSCaptionLbl: Label 'PARTICULARS';
        AMOUNT_Rs_CaptionLbl: Label 'AMOUNT(Rs)';
        //We_have_credited_to_your_A_c_with_a_sum_of_Rs________________________________________________________________________________Lbl: Label '   We have credited to your A/c with a sum of Rs..................................................................................................as detailed Under.';
        V1CaptionLbl: Label '1';
        In_Words_Rupees__CaptionLbl: Label 'In Words Rupees :';
        Prepared_by___CaptionLbl: Label 'Prepared by  :';
        Checked_by___CaptionLbl: Label 'Checked by  :';
        For_EFFTRONICS_SYSTEMS__P__LTD__CaptionLbl: Label 'For EFFTRONICS SYSTEMS (P) LTD.,';
        Authorised_SignatoryCaptionLbl: Label 'Authorised Signatory';
        Certify_Caption: Label ' Certified that the Particulars given above are true and correct and the amount indicated represents the price actually charged and that there is no flow of additional consideration directly or indirectly from the buyer';
        Rupees_Words_Caption: Label ' Rupees(in Words) : ';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label ' is already applied to %1 %2 for customer %3.';
        Text031: Label ' is already applied to %1 %2 for vendor %3.';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text1280000: Label 'LAKH';
        Text1280001: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        descri1: array[2] of Text[250];
        testvar: Decimal;
        Noseq: Decimal;
        formatadress: Codeunit "Format Address";
        LineTotAmt1: Decimal;
        Cess1Caption: Text[50];
        Cess2Caption: Text[50];
        Cess1Amt: Decimal;
        Cess2Amt: Decimal;
        TempDate: Date;
        //EInvoiceEntry: Record "E-Invoice Entry";//B2BUpg
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        TcsAmt: Decimal;
        CessAmt: Decimal;

    procedure InitLogInteraction()
    begin
        //LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        IF "Sales Cr.Memo Line"."Return Receipt No." <> '' THEN
            IF ReturnReceiptHeader.GET("Sales Cr.Memo Line"."Return Receipt No.") THEN
                EXIT(ReturnReceiptHeader."Posting Date");
        IF "Sales Cr.Memo Header"."Return Order No." = '' THEN
            EXIT("Sales Cr.Memo Header"."Posting Date");

        CASE "Sales Cr.Memo Line".Type OF
            "Sales Cr.Memo Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource,
          "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Cr.Memo Line");
            "Sales Cr.Memo Line".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "Sales Cr.Memo Line"."Line No.");

        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT("Sales Cr.Memo Header"."Posting Date");
            END;
        END ELSE
            EXIT("Sales Cr.Memo Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesCrMemoLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        IF SalesCrMemoHeader.FIND('-') THEN
            REPEAT
                SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                IF SalesCrMemoLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
                    UNTIL SalesCrMemoLine2.NEXT = 0;
            UNTIL SalesCrMemoHeader.NEXT = 0;

        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);

        IF ReturnReceiptLine.FIND('-') THEN
            REPEAT
                IF "Sales Cr.Memo Header"."Get Return Receipt Used" THEN
                    CorrectShipment(ReturnReceiptLine);
                IF ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
                ELSE BEGIN
                    IF ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity) THEN
                        ReturnReceiptLine.Quantity := TotalQuantity;
                    Quantity :=
                      ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

                    SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

                    IF ReturnReceiptHeader.GET(ReturnReceiptLine."Document No.") THEN BEGIN
                        AddBufferEntry(
                          SalesCrMemoLine,
                          -Quantity,
                          ReturnReceiptHeader."Posting Date");
                    END;
                END;
            UNTIL (ReturnReceiptLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        IF SalesCrMemoLine.FIND('-') THEN
            REPEAT
                ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            UNTIL SalesCrMemoLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            INIT;
            "Document No." := SalesCrMemoLine."Document No.";
            "Line No." := SalesCrMemoLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesCrMemoLine.Type;
            "No." := SalesCrMemoLine."No.";
            Quantity := -QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT;
            NextEntryNo := NextEntryNo + 1
        END;
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Sales Cr.Memo Header"."Prepayment Credit Memo" THEN
            EXIT(Text011);
        EXIT(Text005);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure GetSalesGSTAmount(SalesCrMemoHeader: Record "Sales Cr.Memo Header";
   SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesCrMemoHeader."Currency Code" <> '') then
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesCrMemoHeader."Currency Code" <> '') then
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesCrMemoHeader."Currency Code" <> '') then
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesCrMemoHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
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

    local procedure GetSalesGSTPercent(SalesCrMemoLine: Record "Sales Cr.Memo Line"; BaseAmount: Boolean): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindFirst() then
            if BaseAmount then
                exit(DetailedGSTLedgerEntry."GST Base Amount")
            else
                exit(DetailedGSTLedgerEntry."GST %");

    end;

    local procedure GetSalesGSTLineWise(SalesCrMemoLine: Record "Sales Cr.Memo Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindFirst() then begin
            DetailedGSTLedgerEntry.CalcSums("GST Amount");
            exit(DetailedGSTLedgerEntry."GST Amount");

        end;
    end;

    local procedure GetTCSAmt(SalesCrmemoHeader: Record "Sales Cr.Memo Header"; SalescrMemoLine: Record "Sales Cr.Memo Line"): Decimal
    var
        TCSEntry: Record "TCS Entry";
    begin
        Clear(TCSAmt);
        TCSEntry.Reset();
        TCSEntry.SetRange("Document No.", SalescrMemoLine."Document No.");
        if TCSEntry.FindSet() then
            repeat
                if SalesCrmemoHeader."Currency Code" <> '' then
                    TCSAmt += SalesCrmemoHeader."Currency Factor" * TCSEntry."Total TCS Including SHE CESS"
                else
                    TCSAmt += TCSEntry."Total TCS Including SHE CESS";
                TCSAmt := Round(TCSAmt, 1);
            until TCSEntry.Next() = 0;
        exit(TcsAmt);
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
}

