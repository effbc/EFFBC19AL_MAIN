report 50058 "Purchase Order"
{
    // Project : EFFTRONICS
    // *************************************************************************************************************************
    // SIGN Name
    // ************************************************************************************************************************
    // DIM : Resolution of Dimension Issues after Upgarding.
    // ***********************************************************************************************************************
    // VVersion  sign     Date       USERID    Description
    // *************************************************************************************************************************
    // 1.0      DIM      24-May-13  SAIRAM    New Code has been added for the dimensions updation after upgarding.
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseOrder.rdl';
    Caption = 'Purchase Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(Purchase_Header_Buy_from_Vendor_No_; "Buy-from Vendor No.")
            {
            }
            column(Purchase_Header_Buy_from_Vendor_Name; "Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(Vendor_State_Name; Vendor_State_Name)
            {
            }
            column(Vendor_State_No; Vendor_State_No)
            {
            }
            dataitem("<Vendor1>"; Vendor)
            {
                DataItemLink = "No." = FIELD("Buy-from Vendor No.");
                column(CompanyAddr_1_; CompanyAddr[1])
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
                column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfo_Picture; CompanyInfo.Picture)
                {
                }
                column(CompanyInfo_GST_No; CompanyInfo."GST Registration No.")
                {
                }
                column(E__Mail_Caption; E__Mail_CaptionLbl)
                {
                }
                column(Vendor1__E_Mail; "E-Mail")
                {
                }
                column(Ph_Caption; Ph_CaptionLbl)
                {
                }
                column(FAX_Caption; FAX_CaptionLbl)
                {
                }
                column(URL_Caption; URL_CaptionLbl)
                {
                }
                column(Purchase_OrderCaption; Purchase_OrderCaptionLbl)
                {
                }
                column(purchase_efftronics_comCaption; purchase_efftronics_comCaptionLbl)
                {
                }
                column(Vendor1__No_; "No.")
                {
                }
                column(UPPERCASE_BuyFromAddr_6__; UPPERCASE(BuyFromAddr[6]))
                {
                }
                column(UPPERCASE_BuyFromAddr_5__; UPPERCASE(BuyFromAddr[5]))
                {
                }
                column(UPPERCASE_BuyFromAddr_4__; UPPERCASE(BuyFromAddr[4]))
                {
                }
                column(UPPERCASE_BuyFromAddr_3__; UPPERCASE(BuyFromAddr[3]))
                {
                }
                column(UPPERCASE_BuyFromAddr_2__; UPPERCASE(BuyFromAddr[2]))
                {
                }
                column(UPPERCASE_BuyFromAddr_1__; UPPERCASE(BuyFromAddr[1]))
                {
                }
                column(Ord__Ref_No__Caption; Ord__Ref_No__CaptionLbl)
                {
                }
                column(Ordered_Date_Caption; Ordered_Date_CaptionLbl)
                {
                }
                column(ToCaption; ToCaptionLbl)
                {
                }
                column(Ref__Quotation_No__Caption; Ref__Quotation_No__CaptionLbl)
                {
                }
                column(Qtn__Dated_______Caption; Qtn__Dated_______CaptionLbl)
                {
                }
                column(Excise_Regn_No__Caption; Excise_Regn_No__CaptionLbl)
                {
                }
                column(TIN_No____________________Caption; TIN_No____________________CaptionLbl)
                {
                }
                column(CST_No____________Caption; CST_No____________CaptionLbl)
                {
                }
                column(TinNo; TNo)
                {
                }
                column(CSTNo; CSTNo)
                {
                }
                column(Service_Tax_Regn_No__Caption; Service_Tax_Regn_No__CaptionLbl)
                {
                }
                column(Cell_No____________Caption; Cell_No____________CaptionLbl)
                {
                }
                column(Fax_No_____________Caption; Fax_No_____________CaptionLbl)
                {
                }
                column(Ph_No______________Caption; Ph_No______________CaptionLbl)
                {
                }
                column(Contact___________Caption; Contact___________CaptionLbl)
                {
                }
                column(E_mail_____________Caption; E_mail_____________CaptionLbl)
                {
                }
                column(ContactCellNo__; "ContactCellNo.")
                {
                }
                column(Vendor1____Phone_No__; "<Vendor1>"."Phone No.")
                {
                }
                column(Vendor1____Fax_No__; "<Vendor1>"."Fax No.")
                {
                }
                column(Vendor1____Contact; Contact)
                {
                }
                //B2BUpg>>

                column(CompanyInfo__C_E__Registration_No__; '')
                {
                }
                column(CompanyInfo__T_I_N__No__; '')
                {
                }
                column(CompanyInfo__C_S_T_No__; '')
                {
                }
                column(CompanyInfo__Service_Tax_Registration_No__; '')
                {
                }
                //B2BUpg<<
                column(Purchase_Header___Buy_from_Contact_; "Purchase Header"."Buy-from Contact")
                {
                }
                column(Purchase_Header___No__; "Purchase Header"."No.")
                {
                }
                column(FORMAT__Purchase_Header___Order_Date__0_4_; FORMAT("Purchase Header"."Order Date", 0, '<Day>-<Month Text,3>-<Year4>'))
                {
                }
                column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
                {
                }
                column(Sl_No_Caption; Sl_No_CaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(UnitCaption; UnitCaptionLbl)
                {
                }
                column(RateCaption; RateCaptionLbl)
                {
                }
                column(Amount_in_Rs_LCY_Caption; Amount_in_Rs_LCY_CaptionLbl)
                {
                }
                column(Amt_Foregin_Caption; Amt_Foregin_CaptionLbl)
                {
                }
                column(Expected__Receipt_DateCaption; Expected__Receipt_DateCaptionLbl)
                {
                }
                column(Taxes_Extra; Taxes_Extra)
                {
                }
                column(Note_Control1102154052; Note)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Vendor_GST; GST_Reg_No)
                {
                }
                column(Vendor_PAN; "P.A.N. No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    State: Record State;
                begin
                    /* IF( Vendor."E.C.C No."='') AND ("Purchase Header"."Order Date">121609D) THEN
                       ERROR('THERE IS NO "ECC NO." FOR '+Vendor.Name); //anil */

                    GST_Reg_No := "<Vendor1>"."GST Registration No.";
                    IF "Purchase Header"."Order Address Code" <> '' THEN BEGIN
                        IF Ord_Adrss.GET("<Vendor1>"."No.", "Purchase Header"."Order Address Code") THEN
                            GST_Reg_No := Ord_Adrss."GST Registration No.";
                    END;

                end;
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
                    column(Vendor1____E_Mail_; "<Vendor1>"."E-Mail")
                    {
                    }
                    column(Qtn; Qtn)
                    {
                    }
                    column(Qtn_Date; Qtn_Date)
                    {
                    }
                    column(PaymentTerms_Description; PaymetStatic_or_dynamic)
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                    column(PurchaserName; PurchaserName)
                    {
                    }
                    column(PackingDetails; PackingDetails)
                    {
                    }
                    column(Verification_Requirements_; "Verification Requirements")
                    {
                    }
                    column(FORMAT__Purchase_Header___Requested_Receipt_Date__0_4_; FORMAT("Purchase Header"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>'))
                    {
                    }
                    column(Excise_Amount_Txt; Excise_Amount_Txt)
                    {
                    }
                    column(Charges_Txt; Charges_Txt)
                    {
                    }
                    column(Paching_Charges; Paching_Charges)
                    {
                    }
                    column(Insurance_Charges; Insurance_Charges)
                    {
                    }
                    column(GST_TAXES_TXT; GST_TAXES_TXT)
                    {
                    }
                    column(OTHER_TAXES_TXT; OTHER_TAXES_TXT)
                    {
                    }
                    column(Sales_Tax_Txt; Sales_Tax_Txt)
                    {
                    }
                    column(SERVICE_TAX_VALUE_TXT; SERVICE_TAX_VALUE_TXT)
                    {
                    }
                    column(CFORM; CFORM)
                    {
                    }
                    column(VAT_AMOUNT_TXT; VAT_AMOUNT_TXT)
                    {
                    }
                    column(GST_AMOUNT_TXT; GST_AMOUNT_TXT)
                    {
                    }
                    column(CST; CST)
                    {
                    }
                    column(EXCISE; EXCISE)
                    {
                    }
                    column(SERVICE; SERVICE)
                    {
                    }
                    column(VAT; VAT)
                    {
                    }
                    column(Material_Value_Txt; Material_Value_Txt)
                    {
                    }
                    column(Excei_Txt; Excei_Txt)
                    {
                    }
                    column(Other_Charges_Txt; Other_Charges_Txt)
                    {
                    }
                    column(Paching_Charges_Txt; Paching_Charges_Txt)
                    {
                    }
                    column(Insurance_Charges_Txt; Insurance_Charges_Txt)
                    {
                    }
                    column(PackingPercnt; PackingPercnt)
                    {
                    }
                    column(InsurancePercnt; InsurancePercnt)
                    {
                    }
                    column(OTHER_TAX_TXT; OTHER_TAX_TXT)
                    {
                    }
                    column(GST_TAX_TXT; GST_TAX_TXT)
                    {
                    }
                    column(CST_TXT; CST_TXT)
                    {
                    }
                    column(SERVICE_TAX_TXT; SERVICE_TAX_TXT)
                    {
                    }
                    column(VAT_TXT; VAT_TXT)
                    {
                    }
                    column(DISCOUNT; DISCOUNT)
                    {
                    }
                    column(TOTAL_AMOUNT_TXT; TOTAL_AMOUNT_TXT)
                    {
                    }
                    column(LINETOTAMT_TXT; LINETOTAMT_TXT)
                    {
                    }
                    column(Note; Note)
                    {
                    }
                    column(x; x)
                    {
                    }
                    column(y; y)
                    {
                    }
                    column(NOTE_Caption; NOTE_CaptionLbl)
                    {
                    }
                    column(Payment_Terms_Caption; Payment_Terms_CaptionLbl)
                    {
                    }
                    column(PLEASE_INTIMATE_ANY_DELAY_IN_MATERIAL_BEYOND_DELIVERY_DATE_OR_NON_AVAILABILITY_OF_MATERIAL_IMMEDIATELY_Caption; PLEASE_INTIMATE_ANY_DELAY_IN_MATERIAL_BEYOND_DELIVERY_DATE_OR_NON_AVAILABILITY_OF_MATERIAL_IMMEDIATELY_CaptionLbl)
                    {
                    }
                    column(Delivery_Terms_Caption; Delivery_Terms_CaptionLbl)
                    {
                    }
                    column(Delivery_Date_Caption; Delivery_Date_CaptionLbl)
                    {
                    }
                    column(Verification_Requirements_Caption; Verification_Requirements_CaptionLbl)
                    {
                    }
                    column(Packing_Details_Caption; Packing_Details_CaptionLbl)
                    {
                    }
                    column(Manager_Purchases_Caption; Manager_Purchases_CaptionLbl)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(Final_Amount_Txt; Final_Amount_Txt)
                    {
                        AutoFormatType = 1;
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                        column(DimLoop1Body1; DimLoop1Body1)
                        {
                        }
                        column(DimLoop1Body2; DimLoop1Body2)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control72; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            DimLoop1Body1 := TRUE;
                            DimLoop1Body2 := TRUE;

                            IF Number = 1 THEN BEGIN
                                //DIM1.0 Start
                                //Code Commented
                                /*
                                IF NOT DocDim1.FIND('-') THEN
                                 CurrReport.BREAK;
                                */
                                IF NOT DimSetEntryGRec.FINDFIRST THEN
                                    CurrReport.BREAK;
                                //DIM1.0 End
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            //DIM1.0 Start
                            //Code Commented
                            /*
                            REPEAT
                              OldDimText := DimText;
                              IF DimText = '' THEN
                                DimText := STRSUBSTNO(
                                  '%1 %2',DocDim1."Dimension Code",DocDim1."Dimension Value Code")
                              ELSE
                                DimText :=
                                  STRSUBSTNO(
                                    '%1, %2 %3',DimText,
                                    DocDim1."Dimension Code",DocDim1."Dimension Value Code");
                              IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                DimText := OldDimText;
                                Continue := TRUE;
                                EXIT; // Rev01
                              END;
                            UNTIL (DocDim1.NEXT = 0);
                            */

                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntryGRec."Dimension Code", DimSetEntryGRec."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntryGRec."Dimension Code", DimSetEntryGRec."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT; // Rev01
                                END;
                            UNTIL (DimSetEntryGRec.NEXT = 0);
                            //DIM1.0 End


                            //DimensionLoop1, Body (1) - OnPreSection() >>
                            //CurrReport.SHOWOUTPUT(Number = 1);
                            IF Number <> 1 THEN
                                DimLoop1Body1 := FALSE;
                            //DimensionLoop1, Body (1) - OnPreSection() <<

                            //DimensionLoop1, Body (2) - OnPreSection() >>
                            //CurrReport.SHOWOUTPUT(Number > 1);
                            IF Number <= 1 THEN
                                DimLoop1Body2 := FALSE;
                            //DimensionLoop1, Body (2) - OnPreSection() <<

                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
                        column(PurchLineBody4; PurchLineBody4)
                        {
                        }
                        column(PurchLineBody5; PurchLineBody5)
                        {
                        }
                        column(PurchLineBody6; PurchLineBody6)
                        {
                        }
                        column(PurchLineBody7; PurchLineBody7)
                        {
                        }
                        column(PurchLineBody8; PurchLineBody8)
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code_; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Sl_No__; "Sl.No.")
                        {
                        }
                        column(Pur_Line_Amt; Pur_Line_Amt)
                        {
                        }
                        column(CGST; CGST)
                        {
                        }
                        column(IGST; IGST)
                        {
                        }
                        column(SGST; SGST)
                        {
                        }
                        column(HSN_SAC; HSN_SAC)
                        {
                        }
                        column(PurchLine__Currency_Code_; PurchLine."Currency Code")
                        {
                        }
                        column(desc_desc; desc_desc)
                        {
                        }
                        column(Item_Ordered_QTY; Item_Ordered_QTY)
                        {
                        }
                        column(Foriegn_Value; Foriegn_Value)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Expected_Dates_; "Expected Dates")
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(desc_make; desc_make)
                        {
                        }
                        column(desc_partnumber; desc_partnumber)
                        {
                        }
                        column(desc_package; desc_package)
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Direct_Unit_Cost__Control1102154061; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code__Control1102154063; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Pur_Line_Amt_Control1102154072; Pur_Line_Amt)
                        {
                        }
                        column(PurchLine__Currency_Code__Control1102154073; PurchLine."Currency Code")
                        {
                        }
                        column(Purchase_Line__Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Item_Ordered_QTY_Control1102154077; Item_Ordered_QTY)
                        {
                        }
                        column(ROUND_Foriegn_Value_2_; ROUND(Foriegn_Value, 2))
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Expected_Dates__Control1102154080; "Expected Dates")
                        {
                        }
                        column(Sl_No___Control1000000001; "Sl.No.")
                        {
                        }
                        column(Sl_No___Control1000000026; "Sl.No.")
                        {
                        }
                        column(DESC; DESC)
                        {
                        }
                        column(Item_Ordered_QTY_Control1000000039; Item_Ordered_QTY)
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code__Control1000000041; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Direct_Unit_Cost__Control1102154018; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Pur_Line_Amt_Control1000000045; Pur_Line_Amt)
                        {
                        }
                        column(Foriegn_Value_Control1000000047; Foriegn_Value)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(PurchLine__Currency_Code__Control1000000048; PurchLine."Currency Code")
                        {
                        }
                        column(Expected_Dates__Control1000000050; "Expected Dates")
                        {
                        }
                        column(Purchase_Line__Purchase_Line__Description_Control1102152012; "Purchase Line".Description)
                        {
                        }
                        column(Sl_No___Control1102154067; "Sl.No.")
                        {
                        }
                        column(Item_Ordered_QTY_Control1000000009; Item_Ordered_QTY)
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Unit_of_Measure_Code__Control1000000011; "Purchase Line"."Unit of Measure Code")
                        {
                        }
                        column(Purchase_Line__Purchase_Line___Direct_Unit_Cost__Control1000000014; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Pur_Line_Amt_Control1000000017; Pur_Line_Amt)
                        {
                        }
                        column(ROUND_Foriegn_Value_2__Control1000000019; ROUND(Foriegn_Value, 2))
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(PurchLine__Currency_Code__Control1000000020; PurchLine."Currency Code")
                        {
                        }
                        column(Expected_Dates__Control1000000022; "Expected Dates")
                        {
                        }
                        column(Purchase_Line__Purchase_Line__Description_Control1102152013; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Purchase_Line__Description_Control1102154019; "Purchase Line".Description)
                        {
                        }
                        column(finalamount; finalamount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Tot_For_Currecy; Tot_For_Currecy)
                        {
                        }
                        column(Continued___Caption; Continued___CaptionLbl)
                        {
                        }
                        column(Purchase_Line_Document_Type; "Document Type")
                        {
                        }
                        column(Purchase_Line_Document_No_; "Document No.")
                        {
                        }
                        column(Purchase_Line_Line_No_; "Line No.")
                        {
                        }
                        column(Purchase_Line_No_; "No.")
                        {
                        }
                        column(PurchaseLine_Type; "Purchase Line".Type)
                        {
                        }
                        column(PurchaseLine_HSN; "Purchase Line"."HSN/SAC Code")
                        {
                        }
                        column(PurchaseLine_GST_TaxRate; "Purchase Line"."GST Group Code")
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            TaxTransactionValue: Record "Tax Transaction Value";
                            GSTSetup: Record "GST Setup";
                        begin

                            //Rev01 Start
                            PurchLineBody4 := TRUE;
                            PurchLineBody5 := TRUE;
                            PurchLineBody6 := TRUE;
                            PurchLineBody7 := TRUE;
                            PurchLineBody8 := TRUE;
                            //Rev01 End


                            //Comment by B2B, Grouping will not work as report is not designed properly.

                            /*
                            //Purchase Line, GroupHeader (3) - OnPreSection() >>
                            IF PrevNo <> "Purchase Line"."No." THEN BEGIN
                              Order_Breakup:='';
                              "No.Of Lines":=0;
                              "Sl.No."+=1;
                            END;
                            */
                            //Purchase Line, GroupHeader (3) - OnPreSection() <<


                            Pur_Line_Amt := 0;// Rev01;
                            Foriegn_Value := 0;
                            PurchLine.NEXT;
                            Item_Cnt += 1;


                            //B2BUpg>>
                            /* IF "Purchase Line"."No." <> '' THEN
                                 IF (FORMAT(EXCISE) = '') AND ("Purchase Line"."Excise Amount" > 0) THEN BEGIN
                                     EXCISE_POSTING_SETUP.SETRANGE(EXCISE_POSTING_SETUP."Excise Prod. Posting Group", "Purchase Line"."Excise Prod. Posting Group");
                                     EXCISE_POSTING_SETUP.SETFILTER(EXCISE_POSTING_SETUP."From Date", '<=%1', "Purchase Header"."Order Date");
                                     IF EXCISE_POSTING_SETUP.FINDLAST THEN
                                         //EXCISE:=FORMAT(EXCISE_POSTING_SETUP."BED %"+(EXCISE_POSTING_SETUP."eCess %"/10)+(EXCISE_POSTING_SETUP."SHE Cess %"/10));
                                         EXCISE := FORMAT(EXCISE_POSTING_SETUP."BED %" * (100 + EXCISE_POSTING_SETUP."eCess %" + EXCISE_POSTING_SETUP."SHE Cess %") / 100);
                                 END;*/
                            //B2BUpg<<

                            // IF (FORMAT(VAT) = '') AND ("Purchase Line"."Tax Area Code" = 'PUCH VAT') AND ("Purchase Line"."Tax Amount" > 0) THEN BEGIN //B2BUpg
                            IF (FORMAT(VAT) = '') AND ("Purchase Line"."Tax Area Code" = 'PUCH VAT') THEN BEGIN
                                TAX_DETAIL.SETRANGE(TAX_DETAIL."Tax Jurisdiction Code", 'PUCH VAT');
                                TAX_DETAIL.SETRANGE(TAX_DETAIL."Tax Group Code", "Purchase Line"."Tax Group Code");
                                TAX_DETAIL.SETFILTER(TAX_DETAIL."Effective Date", '<=%1', "Purchase Header"."Order Date");
                                IF TAX_DETAIL.FINDFIRST THEN
                                    VAT := FORMAT(ROUND(TAX_DETAIL."Tax Below Maximum", 0.1));
                            END;

                            //IF (FORMAT(CST) = '') AND ("Purchase Line"."Tax Area Code" = 'PUCH CST') AND ("Purchase Line"."Tax Amount" > 0) THEN BEGIN
                            IF (FORMAT(CST) = '') AND ("Purchase Line"."Tax Area Code" = 'PUCH CST') then Begin
                                TAX_DETAIL.SETRANGE(TAX_DETAIL."Tax Jurisdiction Code", 'PUCH CST');
                                TAX_DETAIL.SETRANGE(TAX_DETAIL."Tax Group Code", "Purchase Line"."Tax Group Code");
                                TAX_DETAIL.SETFILTER(TAX_DETAIL."Effective Date", '<=%1', "Purchase Header"."Order Date");
                                /*IF "Purchase Header"."C Form" = FALSE THEN
                                    TAX_DETAIL.SETFILTER(TAX_DETAIL."Form Code", '<>C');*///B2BUpg
                                IF TAX_DETAIL.FINDLAST THEN
                                    CST := FORMAT(ROUND(TAX_DETAIL."Tax Below Maximum", 0.1));
                            END;
                            /*
                                                        IF (FORMAT(SERVICE) = '') AND ("Purchase Line"."Service Tax Amount" > 0) THEN BEGIN
                                                            SERVICE_TAX_SETUP.SETRANGE(SERVICE_TAX_SETUP.Code, "Purchase Line"."Service Tax Group");
                                                            SERVICE_TAX_SETUP.SETFILTER(SERVICE_TAX_SETUP."From Date", '<=%1', "Purchase Header"."Order Date");

                                                            //IF SERVICE_TAX_SETUP.FINDFIRST THEN
                                                              //SERVICE:=FORMAT(SERVICE_TAX_SETUP."Service Tax %"+(SERVICE_TAX_SETUP."eCess %"/10)+(SERVICE_TAX_SETUP."SHE Cess %"/10));

                                                            //Added by Sundar to generalize the calculation on 02-APR-2012
                                                            IF SERVICE_TAX_SETUP.FINDLAST THEN BEGIN
                                                                IF SERVICE_TAX_SETUP."SB Cess%" > 0 THEN    // Added by Pranavi on 06-06-2016 for sb and kkcess calculation
                                                                    SERVICE := FORMAT(SERVICE_TAX_SETUP."Service Tax %" + SERVICE_TAX_SETUP."SB Cess%" + SERVICE_TAX_SETUP."KK Cess%")
                                                                ELSE
                                                                    SERVICE := FORMAT(SERVICE_TAX_SETUP."Service Tax %" * (100 + SERVICE_TAX_SETUP."eCess %" + SERVICE_TAX_SETUP."SHE Cess %") / 100);
                                                                MESSAGE(FORMAT(SERVICE_TAX_SETUP."Service Tax %") + ',' + FORMAT(SERVICE_TAX_SETUP."SB Cess%") + ',' + FORMAT(SERVICE_TAX_SETUP."KK Cess%"));
                                                                MESSAGE(FORMAT(SERVICE_TAX_SETUP."From Date") + ', ' + SERVICE);
                                                            END;
                                                        END;*///B2BUpg

                            IF ("Purchase Line"."No." <> '') AND ("Purchase Line".Type = "Purchase Line".Type::Item) THEN BEGIN
                                //  MESSAGE(FORMAT(PurchLine."No.")+'-'+FORMAT("Purchase Line"."No."));
                                IF (PurchLine."No." = "Purchase Line"."No.") AND (PurchLine.Make = "Purchase Line".Make) AND (Item_Cnt <> Pur_Cnt) THEN BEGIN
                                    IF Previous THEN BEGIN
                                        Item_Ordered_QTY += "Purchase Line".Quantity;
                                        "No.Of Lines" += 1;
                                    END ELSE BEGIN
                                        Item_Ordered_QTY := "Purchase Line".Quantity;
                                        "No.Of Lines" := 1;
                                        Order_Breakup := '';
                                        CGST := 0;
                                        SGST := 0;
                                        IGST := 0;
                                    END;

                                    Previous := TRUE;

                                    // MESSAGE(FORMAT(Item_Ordered_QTY));
                                    CASE "No.Of Lines" OF
                                        1:
                                            Schedu_Number := '1st   Sch. Req qty ';
                                        2:
                                            Schedu_Number := '2nd   Sch. Req qty ';
                                        3:
                                            Schedu_Number := '3rd   Sch. Req qty ';
                                        4:
                                            Schedu_Number := '4th   Sch. Req qty ';
                                        5:
                                            Schedu_Number := '5th   Sch. Req qty ';
                                    END;

                                    Order_Breakup += Schedu_Number + ' ' + FORMAT("Purchase Line".Quantity) + ' - ' +
                                                     FORMAT("Purchase Line"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ', ';

                                    HSN_SAC := "Purchase Line"."HSN/SAC Code";
                                    IF "Purchase Header"."GST Vendor Type" <> "Purchase Header"."GST Vendor Type"::Import THEN BEGIN
                                        /*GST_Setup.RESET;
                                        GST_Setup.SETFILTER("GST Group Code", "Purchase Line"."GST Group Code");
                                        GST_Setup.SETFILTER("GST State Code", "Purchase Header".State);
                                        IF GST_Setup.FINDSET THEN
                                            REPEAT
                                                    IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate) AND (GST_Setup."GST Component Code" = 'IGST') THEN BEGIN
                                                        IGST := IGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100;
                                                    END
                                                    ELSE
                                                        IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate) THEN BEGIN
                                                            IF (GST_Setup."GST Component Code" = 'CGST') THEN
                                                                CGST := CGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                            ELSE
                                                                IF (GST_Setup."GST Component Code" = 'SGST') THEN
                                                                    SGST := SGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                        END;
                                            UNTIL GST_Setup.NEXT = 0;*/

                                    END;
                                    IF "Purchase Line".COUNT > 1 THEN
                                        CurrReport.SKIP;

                                END ELSE BEGIN
                                    IF Previous THEN BEGIN
                                        Item_Ordered_QTY += "Purchase Line".Quantity;
                                        "No.Of Lines" += 1;

                                    END ELSE BEGIN
                                        Item_Ordered_QTY := "Purchase Line".Quantity;
                                        "No.Of Lines" := 1;
                                        Order_Breakup := '';
                                        CGST := 0;
                                        SGST := 0;
                                        IGST := 0;
                                    END;

                                    Previous := FALSE;
                                    // MESSAGE(FORMAT(Item_Ordered_QTY));

                                    CASE "No.Of Lines" OF
                                        1:
                                            Schedu_Number := '1st   Sch. Req qty ';
                                        2:
                                            Schedu_Number := '2nd   Sch. Req qty ';
                                        3:
                                            Schedu_Number := '3rd   Sch. Req qty ';
                                        4:
                                            Schedu_Number := '4th   Sch. Req qty ';
                                        5:
                                            Schedu_Number := '5th   Sch. Req qty ';
                                    END;
                                    Order_Breakup += Schedu_Number + ' ' + FORMAT("Purchase Line".Quantity) + ' - ' +
                                                     FORMAT("Purchase Line"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ', ';
                                    HSN_SAC := "Purchase Line"."HSN/SAC Code";
                                    IF "Purchase Header"."GST Vendor Type" <> "Purchase Header"."GST Vendor Type"::Import THEN BEGIN
                                        /*GST_Setup.RESET;
                                        GST_Setup.SETFILTER("GST Group Code", "Purchase Line"."GST Group Code");
                                        GST_Setup.SETFILTER("GST State Code", "Purchase Header".State);
                                        IF GST_Setup.FINDSET THEN
                                                REPEAT
                                                    IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate) AND (GST_Setup."GST Component Code" = 'IGST') THEN BEGIN
                                                        IGST := IGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100;
                                                    END
                                                    ELSE
                                                        IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate) THEN BEGIN
                                                            IF (GST_Setup."GST Component Code" = 'CGST') THEN
                                                                CGST := CGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                            ELSE
                                                                IF (GST_Setup."GST Component Code" = 'SGST') THEN
                                                                    SGST := SGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                        END;
                                                UNTIL GST_Setup.NEXT = 0;*/

                                        IF SGST > 0 THEN
                                            SGST := ROUND(SGST, 0.02);
                                        IF CGST > 0 THEN
                                            CGST := ROUND(CGST, 0.02);
                                        IF IGST > 0 THEN
                                            IGST := ROUND(IGST, 0.02);
                                    END;
                                END;
                            END ELSE BEGIN
                                IF Previous THEN BEGIN
                                    Item_Ordered_QTY += "Purchase Line".Quantity;
                                    "No.Of Lines" += 1;
                                END ELSE BEGIN
                                    Item_Ordered_QTY := "Purchase Line".Quantity;
                                    "No.Of Lines" := 1;
                                    Order_Breakup := '';
                                    CGST := 0;
                                    SGST := 0;
                                    IGST := 0;
                                END;

                                Previous := FALSE;
                                // MESSAGE(FORMAT(Item_Ordered_QTY));

                                CASE "No.Of Lines" OF
                                    1:
                                        Schedu_Number := '1st   Sch. Req qty ';
                                    2:
                                        Schedu_Number := '2nd   Sch. Req qty ';
                                    3:
                                        Schedu_Number := '3rd   Sch. Req qty ';
                                    4:
                                        Schedu_Number := '4th   Sch. Req qty ';
                                    5:
                                        Schedu_Number := '5th   Sch. Req qty ';
                                END;
                                Order_Breakup += Schedu_Number + ' ' + FORMAT("Purchase Line".Quantity) + ' - ' +
                                                 FORMAT("Purchase Line"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ', ';
                                HSN_SAC := "Purchase Line"."HSN/SAC Code";
                                IF "Purchase Header"."GST Vendor Type" <> "Purchase Header"."GST Vendor Type"::Import THEN BEGIN
                                    /* GST_Setup.RESET;
                                     GST_Setup.SETFILTER("GST Group Code", "Purchase Line"."GST Group Code");
                                     GST_Setup.SETFILTER("GST State Code", "Purchase Header".State);
                                     IF GST_Setup.FINDSET THEN
                                         REPEAT
                                                 IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate) AND (GST_Setup."GST Component Code" = 'IGST') THEN BEGIN
                                                     IGST := IGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100;
                                                 END
                                                 ELSE
                                                     IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate) THEN BEGIN
                                                         IF (GST_Setup."GST Component Code" = 'CGST') THEN
                                                             CGST := CGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                         ELSE
                                                             IF (GST_Setup."GST Component Code" = 'SGST') THEN
                                                                 SGST := SGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                     END;
                                         UNTIL GST_Setup.NEXT = 0;*/

                                    IF SGST > 0 THEN
                                        SGST := ROUND(SGST, 0.02);
                                    IF CGST > 0 THEN
                                        CGST := ROUND(CGST, 0.02);
                                    IF IGST > 0 THEN
                                        IGST := ROUND(IGST, 0.02);
                                END;
                            END;


                            //Rev01 Start



                            //Purchase Line, Body (4) - OnPreSection() >>
                            IF ("No.Of Lines" = 1) AND ("Purchase Line"."No." <> '') AND (COPYSTR("Purchase Line"."No.", 1, 5) <> 'ECPCB') THEN BEGIN
                                //  MESSAGE("Purchase Line"."No.");
                                Foriegn_Value := 0;
                                desc_make := '';
                                desc_partnumber := '';
                                desc_package := '';
                                desc_desc := '';

                                IF "Purchase Line"."Currency Code" <> '' THEN BEGIN
                                    Tot_For_Currecy += Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    //MESSAGE(FORMAT("Purchase Line"."Direct Unit Cost"));
                                    Foriegn_Value := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    //MESSAGE(FORMAT(Foriegn_Value));
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Unit Cost (LCY)";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Unit Cost (LCY)";
                                END ELSE BEGIN
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Direct Unit Cost";
                                END;

                                desc_desc := "Purchase Line".Description + ' ' + "Purchase Line"."Description 2";
                                "Expected Dates" := FORMAT("Purchase Line"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>');
                                //"Expected Dates":=FORMAT("Purchase Line"."Expected Receipt Date",0,'<Day>-<Month Text,3>-<Year4>');   // Above line commented and added this line by pranavi on 10-Feb-2017
                                CGST := 0;
                                SGST := 0;
                                IGST := 0;

                                HSN_SAC := "Purchase Line"."HSN/SAC Code";
                                IF "Purchase Header"."GST Vendor Type" <> "Purchase Header"."GST Vendor Type"::Import THEN BEGIN
                                    /* GST_Setup.RESET;
                                     GST_Setup.SETFILTER("GST Group Code", "Purchase Line"."GST Group Code");
                                     GST_Setup.SETFILTER("GST State Code", "Purchase Header".State);
                                     IF GST_Setup.FINDSET THEN
                                             REPEAT
                                                 IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Interstate) AND (GST_Setup."GST Component Code" = 'IGST') THEN BEGIN
                                                     IGST := IGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100;
                                                 END
                                                 ELSE
                                                     IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate) THEN BEGIN
                                                         IF (GST_Setup."GST Component Code" = 'CGST') THEN
                                                             CGST := CGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                         ELSE
                                                             IF (GST_Setup."GST Component Code" = 'SGST') THEN
                                                                 SGST := SGST + ("Purchase Line"."GST Base Amount" * GST_Setup."GST Component %") / 100
                                                     END;
                                             UNTIL GST_Setup.NEXT = 0;*/

                                    IF SGST > 0 THEN
                                        SGST := ROUND(SGST, 0.02);
                                    IF CGST > 0 THEN
                                        CGST := ROUND(CGST, 0.02);
                                    IF IGST > 0 THEN
                                        IGST := ROUND(IGST, 0.02);
                                END;
                                "Sl.No." += 1;
                                //Description := "Purchase Line".Description + "Purchase Line"."Description 2";

                                IF "Purchase Line".Type = "Purchase Line".Type::Item THEN BEGIN
                                    desc_make := 'MAKE :                ' + "Purchase Line".Make;
                                    // IF "Purchase Line"."Part Number" <>'' THEN
                                    desc_partnumber := 'PART-NUMBER : ' + "Purchase Line"."Part Number";
                                    //IF "Purchase Line".Package<>'' THEN
                                    desc_package := 'PACKAGE :         ' + "Purchase Line".Package;
                                END ELSE
                                    IF "Purchase Line".Make <> '' THEN
                                        desc_make := 'MAKE :                ' + "Purchase Line".Make;
                            END ELSE
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                PurchLineBody4 := FALSE;
                            //Purchase Line, Body (4) - OnPreSection() <<


                            //Purchase Line, Body (5) - OnPreSection() >>
                            IF ("No.Of Lines" > 1) AND ("Purchase Line"."No." <> '') AND (COPYSTR("Purchase Line"."No.", 1, 5) <> 'ECPCB') THEN BEGIN
                                Foriegn_Value := 0;
                                IF "Purchase Line"."Currency Code" <> '' THEN BEGIN
                                    Tot_For_Currecy += Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    Foriegn_Value := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Unit Cost (LCY)";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Unit Cost (LCY)";
                                END ELSE BEGIN
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Direct Unit Cost";
                                END;
                                "Expected Dates" := FORMAT(Order_Breakup);
                                "Sl.No." += 1;
                            END ELSE
                                //CurrReport.SHOWOUTPUT(FALSE);
                                PurchLineBody5 := FALSE;
                            // finalamount+=finalamount+Charges;//anil

                            //Purchase Line, Body (5) - OnPreSection() <<


                            //Purchase Line, Body (6) - OnPreSection() >>
                            IF ("No.Of Lines" = 1) AND ("Purchase Line"."No." <> '') AND (COPYSTR("Purchase Line"."No.", 1, 5) = 'ECPCB') THEN BEGIN
                                //  MESSAGE("Purchase Line"."No.");
                                Is_PCB := TRUE;
                                Foriegn_Value := 0;
                                SIZE := '';
                                DESC := '';

                                IF "Purchase Line"."Currency Code" <> '' THEN BEGIN
                                    Tot_For_Currecy += Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    //MESSAGE(FORMAT("Purchase Line"."Direct Unit Cost"));
                                    Foriegn_Value := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    //MESSAGE(FORMAT(Foriegn_Value));
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Unit Cost (LCY)";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Unit Cost (LCY)";
                                END ELSE BEGIN
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Direct Unit Cost";
                                END;
                                "Expected Dates" := FORMAT("Purchase Line"."Requested Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>');
                                //"Expected Dates":=FORMAT("Purchase Line"."Expected Receipt Date",0,'<Day>-<Month Text,3>-<Year4>');
                                "Sl.No." += 1;
                                /*
                                IF (COPYSTR("Purchase Line"."No.",1,5)='ECPCB') THEN BEGIN
                                  Item2.RESET;
                                  Item2.SETFILTER(Item2."No.","Purchase Line"."No.");
                                  IF Item2.FINDFIRST THEN BEGIN
                                    DESC:= "Purchase Line".Description;
                                    DESC+='                                          TYPE-'+Item2."Item Sub Group Code";
                                    DESC+='                                          Thickness-'+Item2."PCB thickness";
                                    DESC+='                                          BASE Copper Clad Thickness-';
                                    DESC+=Item2."Copper Clad Thickness"+' SIZE-'+FORMAT(Item2.Length)+'*'+FORMAT(Item2.Width) +' Sq.mm    ';
                                    //DESC+='                     SOLDER MASK-'+Mask;
                                  END;
                                 END ELSE
                                  DESC:= "Purchase Line".Description;
                                */
                                /*
                                IF (COPYSTR("Purchase Line"."No.",1,5)='ECPCB') THEN BEGIN
                                  Item2.RESET;
                                  Item2.SETFILTER(Item2."No.","Purchase Line"."No.");
                                  IF Item2.FINDFIRST THEN BEGIN
                                    IF Item2."PCB Shape"=1 THEN BEGIN
                                      SIZE:='Length                                      :' +FORMAT(Item2.Length)+'mm      ';
                                      SIZE+='Width                                        :'+FORMAT(Item2.Width)+'mm';
                                    END ELSE  IF Item2."PCB Shape"=2 THEN BEGIN
                                      IF  Item2.Length >0 THEN
                                        SIZE:='Diameter                                  :'+  FORMAT(Item2.Length)+'mm'
                                      ELSE IF  Item2.Width >0 THEN
                                        SIZE:='Diameter :'+FORMAT(Item2.Width)+'mm';
                                    END;
                                    DESC:='Type                                         :'+Item2."Item Sub Group Code"+'          ';
                                    DESC+='Thickness                                 :'+Item2."PCB thickness"+'mm          ';
                                    DESC+='BASE Copper Clad Thickness  :'+Item2."Copper Clad Thickness"+'Microns    ';
                                    DESC+=SIZE;
                                    DESC+=Mask;
                                  END;
                                END ELSE
                                 DESC:= "Purchase Line".Description;
                                */

                                IF (COPYSTR("Purchase Line"."No.", 1, 5) = 'ECPCB') THEN BEGIN
                                    Item2.RESET;
                                    Item2.SETFILTER(Item2."No.", "Purchase Line"."No.");
                                    IF Item2.FINDFIRST THEN BEGIN
                                        IF Item2."PCB Shape" = 1 THEN BEGIN
                                            SIZE := FORMAT(Item2.Length) + 'X';
                                            SIZE += FORMAT(Item2.Width) + 'Sqmm';
                                        END ELSE
                                            IF Item2."PCB Shape" = 2 THEN BEGIN
                                                IF Item2.Length > 0 THEN
                                                    SIZE := FORMAT(Item2.Length) + 'mm Dia'
                                                ELSE
                                                    IF Item2.Width > 0 THEN
                                                        SIZE := FORMAT(Item2.Width) + 'mm Dia';
                                            END;
                                        SIZE += ',Area(Sqcm):' + FORMAT(ROUND(Item2."PCB Area", 0.02)) + ',';  //Added by Pranavi on 28Jul2016
                                        DESC := Item2."Item Sub Group Code" + ',';
                                        DESC += FORMAT(Item2."PCB thickness") + 'mm ,';
                                        DESC += FORMAT(Item2."Copper Clad Thickness") + 'Microns, ';
                                        DESC += SIZE + ' ';

                                        IF Item2."Surface Finish" <> Item2."Surface Finish"::" " THEN
                                            DESC += FORMAT(Item2."Surface Finish");
                                        IF Item2."On C-Side" = Item2."On C-Side"::Green THEN
                                            DESC += ',GREEN On C-side';
                                        IF Item2."On C-Side" = Item2."On C-Side"::White THEN
                                            DESC += ',WHITE On C-side';
                                        IF Item2."On C-Side" = Item2."On C-Side"::Black THEN
                                            DESC += ',BLACK On C-side';
                                        IF Item2."On D-Side" = Item2."On D-Side"::Green THEN
                                            DESC += ',GREEN On D-side';
                                        IF Item2."On D-Side" = Item2."On D-Side"::White THEN
                                            DESC += ',WHITE On D-side';
                                        IF Item2."On D-Side" = Item2."On D-Side"::Black THEN
                                            DESC += ',BLACK On D-side';
                                        IF Item2."On S-Side" = Item2."On S-Side"::Green THEN
                                            DESC += ',GREEN On S-side';
                                        IF Item2."On S-Side" = Item2."On S-Side"::White THEN
                                            DESC += ',WHITE On S-side';
                                        IF Item2."On S-Side" = Item2."On S-Side"::Black THEN
                                            DESC += ',BLACK On S-side';
                                        IF Item2."Item Sub Sub Group Code" = 'AL' THEN
                                            DESC += ', Aluminium-MC';
                                        IF Item2."Item Sub Sub Group Code" = 'GLEPFR4' THEN
                                            DESC += ', Glass Epoxy -FR4';
                                        IF Item2."Item Sub Sub Group Code" = 'PAPER EPOXY' THEN
                                            DESC += ', Paper Epoxy';
                                    END;
                                END ELSE
                                    DESC := "Purchase Line".Description;
                            END ELSE
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                PurchLineBody6 := FALSE;
                            //Purchase Line, Body (6) - OnPreSection() <<

                            //Purchase Line, Body (7) - OnPreSection() >>
                            IF ("No.Of Lines" > 1) AND ("Purchase Line"."No." <> '') AND (COPYSTR("Purchase Line"."No.", 1, 5) = 'ECPCB') THEN BEGIN
                                Foriegn_Value := 0;
                                IF "Purchase Line"."Currency Code" <> '' THEN BEGIN
                                    Tot_For_Currecy += Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    Foriegn_Value := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Unit Cost (LCY)";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Unit Cost (LCY)";
                                END ELSE BEGIN
                                    Pur_Line_Amt := Item_Ordered_QTY * "Purchase Line"."Direct Unit Cost";
                                    finalamount += (Item_Ordered_QTY) * "Purchase Line"."Direct Unit Cost";
                                END;

                                "Expected Dates" := FORMAT(Order_Breakup);
                                "Sl.No." += 1;

                                IF (COPYSTR("Purchase Line"."No.", 1, 5) = 'ECPCB') THEN BEGIN
                                    Item2.RESET;
                                    Item2.SETFILTER(Item2."No.", "Purchase Line"."No.");
                                    IF Item2.FINDFIRST THEN BEGIN
                                        IF Item2."PCB Shape" = 1 THEN
                                            SIZE := 'Length : ' + FORMAT(Item2.Length) + 'mm' + 'Width  : ' + FORMAT(Item2.Width) + 'mm'
                                        ELSE
                                            IF Item2."PCB Shape" = 2 THEN BEGIN
                                                IF Item2.Length > 0 THEN
                                                    SIZE := 'Diameter :' + FORMAT(Item2.Length) + 'mm'
                                                ELSE
                                                    IF Item2.Width > 0 THEN
                                                        SIZE := 'Diameter :' + FORMAT(Item2.Width) + 'mm';
                                            END;
                                        DESC := "Purchase Line".Description;
                                        DESC += 'Type-' + Item2."Item Sub Group Code";
                                        DESC += 'Thickness-' + FORMAT(Item2."PCB thickness");
                                        DESC += 'BASE Copper Clad Thickness-';
                                        DESC += FORMAT(Item2."Copper Clad Thickness") + '' + SIZE;
                                        //DESC+='                     SOLDER MASK-'+Mask;
                                    END;
                                END ELSE
                                    DESC := "Purchase Line".Description;
                            END ELSE
                                //CurrReport.SHOWOUTPUT(FALSE);
                                PurchLineBody7 := FALSE;
                            //Purchase Line, Body (7) - OnPreSection() <<

                            //Purchase Line, Body (8) - OnPreSection() >>
                            //CurrReport.SHOWOUTPUT("Purchase Line"."No."='');
                            IF "Purchase Line"."No." <> '' THEN
                                PurchLineBody8 := FALSE;
                            //Purchase Line, Body (8) - OnPreSection() <<

                            //Comment by B2B, Grouping will not work as report is not designed properly.
                            /*
                            //Purchase Line, GroupFooter (9) - OnPreSection()
                            IF ("Purchase Line".Type="Purchase Line".Type::" ")THEN BEGIN
                              //CurrReport.SHOWOUTPUT(TRUE);
                              Item_Ordered_QTY:=0;
                            END  ELSE
                              //CurrReport.SHOWOUTPUT(FALSE);
                            */
                            //Purchase Line, GroupFooter (9) - OnPreSection()


                            //Final_Amount_Txt:=FORMAT(ROUND(finalamount,0.01));
                            //PrevNo := "Purchase Line"."No.";
                            //Rev01 End

                            /*IF ("Purchase Line"."GST Jurisdiction Type" = "Purchase Line"."GST Jurisdiction Type"::Intrastate) THEN
                            BEGIN
                            
                            END
                            ELSE  "Purchase Line"."GST Jurisdiction Type" =  "Purchase Line"."GST Jurisdiction Type"::Interstate THEN
                            BEGIN
                            
                            END;*/
                            Clear(SGST);
                            Clear(CGST);
                            Clear(IGST);
                            GSTSetup.Get();
                            GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                            IF SGST > 0 THEN
                                SGST := ROUND(SGST, 0.02);
                            IF CGST > 0 THEN
                                CGST := ROUND(CGST, 0.02);
                            IF IGST > 0 THEN
                                IGST := ROUND(IGST, 0.02);
                            //LineTotAmt += SGST + CGST + IGST;


                        end;

                        trigger OnPreDataItem()
                        begin
                            Previous := TRUE;

                            PurchLine.SETCURRENTKEY(PurchLine."Document Type", PurchLine."Document No.", PurchLine."Line No.");
                            PurchLine.RESET;
                            PurchLine.SETRANGE(PurchLine."Document No.", "Purchase Header"."No.");
                            IF PurchLine.FIND('-') THEN
                                Pur_Cnt := PurchLine.COUNT;

                            //Rev01 Start
                            PurchLineBody4 := TRUE;
                            PurchLineBody5 := TRUE;
                            PurchLineBody6 := TRUE;
                            PurchLineBody7 := TRUE;
                            PurchLineBody8 := TRUE;
                            //Rev01 End

                            CLEAR(PrevNo);
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Purchase_Line__Quantity____Purchase_Line___Unit_Cost__LCY___; ("Purchase Line".Quantity) * ("Purchase Line"."Unit Cost (LCY)"))
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                            column(DimText_Control74; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    //DIM1.0 Start
                                    //Code Commented

                                    /*
                                    IF NOT DocDim2.FIND('-') THEN
                                      CurrReport.BREAK;
                                    */
                                    IF NOT DimSetEntryGRec2.FINDFIRST THEN
                                        CurrReport.BREAK;
                                    //DIM1.0 End
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;

                                //DIM1.0 Start
                                //Code Commented

                                /*
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2',DocDim2."Dimension Code",DocDim2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DocDim2."Dimension Code",DocDim2."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL (DocDim2.NEXT = 0);
                                */

                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntryGRec2."Dimension Code", DimSetEntryGRec2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntryGRec2."Dimension Code", DimSetEntryGRec2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntryGRec2.NEXT = 0);

                                //DIM1.0 End

                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                //DIM1.0 Start
                                //COde Commented
                                /*
                                DocDim2.SETRANGE("Table ID",DATABASE::"Purchase Line");
                                DocDim2.SETRANGE("Document Type","Purchase Line"."Document Type");
                                DocDim2.SETRANGE("Document No.","Purchase Line"."Document No.");
                                DocDim2.SETRANGE("Line No.","Purchase Line"."Line No.");
                                */
                                DimSetEntryGRec2.RESET;
                                DimSetEntryGRec2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");

                                //DIM1.0 End

                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            TaxTransactionValue: Record "Tax Transaction Value";
                            GSTSetup: Record "GST Setup";
                        begin

                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT;



                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';

                            // NAVIN

                            IF Currency.GET(PurchLine."Currency Code") THEN;

                            LineAmt := ROUND(PurchLine.Quantity * PurchLine."Direct Unit Cost", Currency."Amount Rounding Precision");
                            LineTotAmt := LineTotAmt + LineAmt;

                            IF PurchLine."Frieght Charges" > 0 THEN BEGIN
                                Charges += PurchLine."Frieght Charges";
                                LineTotAmt += PurchLine."Frieght Charges";
                            END;

                            /* StructureLineDetails.RESET;
                             StructureLineDetails.SETRANGE(StructureLineDetails.Type, StructureLineDetails.Type::Purchase);
                             StructureLineDetails.SETRANGE(StructureLineDetails."Document Type", PurchLine."Document Type");
                             StructureLineDetails.SETRANGE(StructureLineDetails."Document No.", PurchLine."Document No.");
                             StructureLineDetails.SETRANGE(StructureLineDetails."Item No.", PurchLine."No.");
                             StructureLineDetails.SETRANGE(StructureLineDetails."Line No.", PurchLine."Line No.");
                             IF StructureLineDetails.FIND('-') THEN
                                 REPEAT
                                     IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Excise THEN
                                         ExciseAmount := ExciseAmount + StructureLineDetails.Amount;
                                     IF (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::Charges) THEN BEGIN
                                         IF StructureLineDetails."Tax/Charge Group" = 'PACKING' THEN
                                             Paching_Charges := Paching_Charges + StructureLineDetails."Amount (LCY)"
                                         ELSE
                                             IF StructureLineDetails."Tax/Charge Group" = 'INSURANCE' THEN
                                                 Insurance_Charges := Insurance_Charges + StructureLineDetails."Amount (LCY)"
                                             ELSE
                                                 Charges := Charges + StructureLineDetails."Amount (LCY)";
                                     END;
                                     IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Other Taxes" THEN
                                         Othertaxes := Othertaxes + StructureLineDetails.Amount;
                                     IF (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Sales Tax") AND (PurchLine."Tax Area Code" = 'PUCH CST') THEN
                                         SalesTax := SalesTax + StructureLineDetails.Amount;
                                     IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                         ServiceTax := ServiceTax + StructureLineDetails.Amount;
                                     IF (StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::"Sales Tax") AND
                                        (PurchLine."Tax Area Code" = 'PUCH VAT') THEN
                                         VATAmount := VATAmount + StructureLineDetails.Amount;
                                     IF StructureLineDetails."Tax/Charge Type" = StructureLineDetails."Tax/Charge Type"::GST THEN
                                         GstAmount := GstAmount + StructureLineDetails.Amount;

                                     LineTotAmt := LineTotAmt + StructureLineDetails.Amount;
                                 UNTIL StructureLineDetails.NEXT = 0;*/
                            // NAVIN


                            //Navision Efftronics
                            IF ("Purchase Line".Type <> "Purchase Line".Type::" ") THEN
                                "Sl.No." := "Sl.No." + 1;

                            IF Prev_Item = PurchLine."No." THEN BEGIN
                                Item_Ordered_QTY += PurchLine.Quantity;
                                IF PurchLine."Currency Code" <> '' THEN
                                    "Total  currency" += ("Purchase Line".Quantity) * PurchLine."Unit Cost";
                                IF "Purchase Line".Quantity > 0 THEN
                                    Tot_For_Currecy += "Total  currency";

                                totalamount := (Item_Ordered_QTY) * ("Purchase Line"."Unit Cost (LCY)");//anil
                                                                                                        //  IF("Purchase Line"."No."<>' ') THEN
                                                                                                        //    finalamount:=finalamount+totalamount;

                                // CurrReport.SKIP;
                            END ELSE BEGIN
                                Prev_Item := PurchLine."No.";
                                Item_Ordered_QTY += PurchLine.Quantity;
                                IF PurchLine."Currency Code" <> '' THEN
                                    "Total  currency" := ("Purchase Line".Quantity) * PurchLine."Unit Cost";
                                IF "Purchase Line".Quantity > 0 THEN
                                    Tot_For_Currecy += "Total  currency";
                                totalamount := ("Purchase Line".Quantity) * ("Purchase Line"."Unit Cost (LCY)");//anil
                                                                                                                //IF("Purchase Line"."No."<>' ') THEN
                                                                                                                //finalamount:=finalamount+totalamount;
                            END;


                            //PageLoop, Footer (3) - OnPreSection()
                            "Delivery Date" := 0D;
                            //MESSAGE("Purchase Header"."No.");

                            PL.SETRANGE(PL."Document No.", "Purchase Header"."No.");
                            "No.Of Lines" := PL.COUNT;
                            IF PL.FIND('-') THEN
                                REPEAT
                                    IF "Delivery Date" < PL."Expected Receipt Date" THEN
                                        "Delivery Date" := PL."Expected Receipt Date";
                                UNTIL PL.NEXT = 0;

                            IF "Purchase Header"."Payment Discount %" > 0 THEN BEGIN
                                LineTotAmt := finalamount - ((finalamount * "Purchase Header"."Payment Discount %") / 100);
                                DISCOUNT := 'DISCOUNT ' + FORMAT("Purchase Header"."Payment Discount %") + ' %';
                            END;


                            // CurrReport.SHOWOUTPUT:=FALSE;
                            IF (NOT "Purchase Header"."Inclusive of All Taxes") AND ("Purchase Header"."Order Date" > 20091217D) THEN BEGIN
                                IF EXCISE <> '' THEN
                                    EXCISE := EXCISE;
                                //EXCISE:=EXCISE+'%'; // Rev01
                                IF CST <> '' THEN
                                    CST := CST;
                                //CST:=CST+'%';  // Rev01
                                IF SERVICE <> '' THEN
                                    SERVICE := SERVICE;
                                // SERVICE:=SERVICE+'%'; // Rev01
                                IF VAT <> '' THEN
                                    VAT := VAT;
                                // VAT:=VAT+'%'; // Rev01


                                Material_Value_Txt := 'MATERIAL VALUE';
                                Excei_Txt := 'EXCISE';
                                Other_Charges_Txt := 'FRIEGHT CHARGES';
                                Paching_Charges_Txt := 'PACKING CHARGES';
                                Insurance_Charges_Txt := 'INSURANCE CHARGES';
                                CST_TXT := 'CST';
                                SERVICE_TAX_TXT := 'SERVICE TAX';
                                VAT_TXT := 'VAT';
                                OTHER_TAX_TXT := 'OTHER TAXES';
                                GST_TAX_TXT := 'Goods & Service Tax';
                                TOTAL_AMOUNT_TXT := 'TOTAL ORDER VALUE';
                                VendorNew.RESET;
                                VendorNew.SETFILTER(VendorNew."No.", "Purchase Header"."Buy-from Vendor No.");
                                IF VendorNew.FINDFIRST THEN BEGIN
                                    PackingPercnt := FORMAT(VendorNew."Standard Packing %") + ' %';
                                    InsurancePercnt := FORMAT(VendorNew."Standard Insurnece %") + ' %';
                                END;
                                IF finalamount <> 0 THEN
                                    Final_Amount_Txt := ROUND(finalamount, 0.01)
                                //Final_Amount_Txt :=FORMAT(ROUND(finalamount,0.01))
                                ELSE
                                    Final_Amount_Txt := Final_Amount_Txt;

                                IF ExciseAmount <> 0 THEN
                                    Excise_Amount_Txt := ROUND(ExciseAmount, 0.01)
                                //Excise_Amount_Txt:=FORMAT(ROUND(ExciseAmount,0.01))
                                ELSE
                                    Excise_Amount_Txt := Excise_Amount_Txt;

                                IF Othertaxes <> 0 THEN
                                    OTHER_TAXES_TXT := ROUND(Othertaxes, 0.01)
                                //OTHER_TAXES_TXT :=FORMAT(ROUND(Othertaxes,0.01))
                                ELSE
                                    OTHER_TAXES_TXT := OTHER_TAXES_TXT;

                                IF Charges <> 0 THEN
                                    Charges_Txt := ROUND(Charges, 0.01)
                                //Charges_Txt:=FORMAT(ROUND(Charges,0.01))
                                ELSE
                                    Charges_Txt := Charges_Txt;

                                IF SalesTax <> 0 THEN
                                    Sales_Tax_Txt := ROUND(SalesTax, 0.01)
                                //Sales_Tax_Txt:=FORMAT(ROUND(SalesTax,0.01))
                                ELSE
                                    Sales_Tax_Txt := Sales_Tax_Txt;

                                IF ServiceTax <> 0 THEN
                                    SERVICE_TAX_VALUE_TXT := ROUND(ServiceTax, 0.01)
                                //SERVICE_TAX_VALUE_TXT:=FORMAT(ROUND(ServiceTax,0.01))
                                ELSE
                                    SERVICE_TAX_VALUE_TXT := SERVICE_TAX_VALUE_TXT;

                                IF VATAmount <> 0 THEN
                                    VAT_AMOUNT_TXT := ROUND(VATAmount, 0.01)
                                //VAT_AMOUNT_TXT:=FORMAT(ROUND(VATAmount,0.01))
                                ELSE
                                    VAT_AMOUNT_TXT := VAT_AMOUNT_TXT;

                                IF LineTotAmt <> 0 THEN
                                    LINETOTAMT_TXT := ROUND(LineTotAmt, 0.01)
                                //LINETOTAMT_TXT := FORMAT(ROUND(LineTotAmt,0.01))
                                ELSE
                                    LINETOTAMT_TXT := LINETOTAMT_TXT;
                                IF GstAmount <> 0 THEN
                                    GST_AMOUNT_TXT := ROUND(GstAmount, 0.01)
                                ELSE
                                    GST_AMOUNT_TXT := GST_AMOUNT_TXT;

                            END;
                            //CurrReport.SHOWOUTPUT((NOT "Purchase Header"."Inclusive of All Taxes") AND ("Purchase Header"."Order Date">121709D));
                            x := '2)';
                            IF Is_PCB = TRUE THEN BEGIN
                                IF Note = '' THEN
                                    Note += 'PLEASE SEND ALL FILMS BACK ALONG WITH PCB.';
                                x := '2)';
                                y := '3)';
                            END;
                            //PageLoop, Footer (3) - OnPreSection()
                            Clear(SGST);
                            Clear(CGST);
                            Clear(IGST);
                            GSTSetup.Get();
                            GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                            IF SGST > 0 THEN
                                SGST := ROUND(SGST, 0.02);
                            IF CGST > 0 THEN
                                CGST := ROUND(CGST, 0.02);
                            IF IGST > 0 THEN
                                IGST := ROUND(IGST, 0.02);
                            LineTotAmt += SGST + CGST + IGST;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            // NAVIN
                            LineTotAmt := 0;
                            LineAmt := 0;
                            ExciseAmount := 0;
                            Charges := 0;
                            Othertaxes := 0;
                            SalesTax := 0;
                            VATAmount := 0;
                            GstAmount := 0;
                            // NAVIN

                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;

                            IF NOT MoreLines THEN
                                CurrReport.BREAK;

                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);

                            // NAVIN
                            //CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                            /*CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine.Amount, PurchLine."Inv. Discount Amount",
                                                    PurchLine."Line Discount Amount", PurchLine."Amount Including Excise",
                                                    PurchLine."Amount Including Tax", PurchLine."Excise Amount", PurchLine."Tax Amount",
                                                    PurchLine."Tax Base Amount", PurchLine."Excise Base Amount");
                            CurrReport.CREATETOTALS(LineAmt, PurchLine."Bal. TDS Including SHE CESS", PurchLine."Work Tax Amount");*/
                            // NAVIN

                            //Navision Efftronics
                            "Sl.No." := 0;
                            //SlFlag := FALSE;
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
                            IF VATAmount = 0 THEN
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
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //Rev01 Start

                        //PageLoop, Header (2) - OnPreSection() >>
                        IF "Purchase Header"."Quotation No." <> '' THEN
                            Qtn := FORMAT("Purchase Header"."Quotation No.")
                        ELSE
                            Qtn := 'NIL';

                        IF "Purchase Header"."Quotation Date" > 0D THEN
                            Qtn_Date := FORMAT("Purchase Header"."Quotation Date", 0, '<Day>-<Month Text,3>-<Year4>')
                        ELSE
                            Qtn_Date := 'NIL';
                        //PageLoop, Header (2) - OnPreSection() <<
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;

                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);

                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount := VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                        CopyText := Text003;

                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    /*
                    IF NOT CurrReport.PREVIEW THEN
                      PurchCountPrinted.RUN("Purchase Header");
                    */

                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                State: Record State;
            begin
                /*//For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                tin.RESET;
                tin.SETCURRENTKEY(tin.Code,tin.Description,tin."Effective Date");
                tin.SETFILTER(tin."Effective Date",'<=%1', DT2DATE("Purchase Header"."Release Date Time"));
                IF tin.FINDLAST THEN
                BEGIN
                  TNo:=tin.Code;
                END;
                //end For the Effective date TIN No in Prints   changed by MNRaju on 4-Jun-2014
                */

                //MNRAJU FOR TIN NO. CHANGING
                /*tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "Purchase Header"."Order Date");
                tin.SETFILTER(tin.Group, 'TIN');
                IF tin.FINDLAST THEN BEGIN
                    TNo := tin.Code;
                END;

                tin.RESET;
                tin.SETCURRENTKEY(tin.Group, tin.Code, tin.Description, tin."Effective Date");
                tin.SETFILTER(tin."Effective Date", '<=%1', "Purchase Header"."Order Date");
                tin.SETFILTER(tin.Group, 'CST');
                IF tin.FINDLAST THEN BEGIN
                    CSTNo := tin.Code;
                END;*///B2BUpg
                //MNRAJU FOR TIN NO. CHANGING



                IF "Purchase Header"."Inclusive of All Taxes" THEN
                    Taxes_Extra := 'Inclusive of all Taxes';

                PackingDetails := "Purchase Header"."Packing Type";

                IF (PackingDetails = '') AND ("Purchase Header"."Order Date" > DMY2Date(16, 12, 09)) THEN
                    ERROR('PLEASE ENTER THE PACKING DETAILS');

                IF ("Purchase Header"."Payment Terms Code" = '') AND ("Purchase Header"."Order Date" > DMY2Date(16, 12, 09)) THEN
                    ERROR('PLEASE ENTER THE PAYMENT TERMS CODE FOR THIS VENDOR');
                IF ("Purchase Header"."Requested Receipt Date" = 0D) AND ("Purchase Header"."Order Date" > DMY2Date(16, 12, 09)) THEN
                    ERROR('PLEASE ENTER THE REQUESTED RECIEPT DATE ');

                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                CompanyInfo.GET;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                //DIM1.0 Start
                //Code Commented
                /*
                DocDim1.SETRANGE("Table ID",DATABASE::"Purchase Header");
                DocDim1.SETRANGE("Document Type","Purchase Header"."Document Type");
                DocDim1.SETRANGE("Document No.","Purchase Header"."No.");
                */
                DimSetEntryGRec.RESET;
                DimSetEntryGRec.SETRANGE("Dimension Set ID", "Purchase Header"."Dimension Set ID");
                //DIM1.0 End
                //B2BUpg>>
                /*IF "Purchase Header"."Form Code" = 'C' THEN
                    CFORM := 'C FORM'
                ELSE
                    CFORM := '';*/
                //B2BUpg<<

                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    PurchaserText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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

                FormatAddrNew.PurchHeaderBuyFromtemp(BuyFromAddr, "Purchase Header");

                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");


                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE
                    PaymentTerms.GET("Payment Terms Code");


                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");
                /*
                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);
                
                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",DATABASE::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                  END;
                END;
                */

                //Navision Efftronics
                //PurcaserCode.GET("Purchase Header"."Purchaser Code");
                //PurchaserName := PurcaserCode.Name;
                PurchaserName := 'Ch. Renuka'; // added by vishnu Priya on 07-02-2020
                IF Contact.GET("Purchase Header"."Buy-from Contact No.") THEN
                    "ContactFAXNo." := Contact."Fax No.";
                ContactName := Contact.Name;
                "ContactPhNo." := Contact."Phone No.";
                "ContactCellNo." := Contact."Mobile Phone No.";
                "ContactE-mail" := Contact."E-Mail";
                IF CompanyInfo.FIND('-') THEN
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture);

                State.RESET;
                State.SETFILTER(State.Code, "Purchase Header".State);
                IF State.FINDFIRST THEN BEGIN
                    Vendor_State_Name := State.Description;
                    Vendor_State_No := FORMAT(State."State Code (GST Reg. No.)");
                END;


                //added by vishnu on 24-05-2019 to payment terms static code for construction code
                IF NOT ("Purchase Header"."No." IN ['EFF/19-20/P/O/01038']) THEN
                    PaymetStatic_or_dynamic := PaymentTerms.Description
                ELSE
                    PaymetStatic_or_dynamic := Text_new1;
                //ended by vishnu

            end;

            trigger OnPreDataItem()
            var
                State: Record State;
            begin
                Start_Date := 20070401D;
                Final_Date := 19990401D;
                EXCISE := '';
                VAT := '';
                CST := '';
                SERVICE := '';
                Taxes_Extra := '';

                //CFORM:='';
                //DISCOUNT:='';
                //FORIEGN:='';
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
                    field("No. of Copies"; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field("Packing Details"; PackingDetails)
                    {
                        ApplicationArea = All;
                    }
                    field("Verification Requirements"; "Verification Requirements")
                    {
                        ApplicationArea = All;
                    }
                    field("Note:"; Note)
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
        //SlFlag := FALSE;
    end;

    trigger OnPreReport()
    begin
        //  IF PackingDetails='' THEN
        //    PackingDetails:='Standard Packing';

        IF "Verification Requirements" = '' THEN
            "Verification Requirements" := 'NIL';
    end;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
    PurchaseLine: Record "Purchase Line";
    GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];

    begin
        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            SGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                        2:
                            CGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                        3:
                            IGST += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
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



    var
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record Language;
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        FormatAddrNew: Codeunit "Correct Dimension Values Cust";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit 5051;
        VendAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        PurchaserText: Text[100];
        VATNoText: Text[100];
        ReferenceText: Text[100];
        TotalText: Text[100];
        TotalInclVATText: Text[100];
        TotalExclVATText: Text[100];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[100];
        DimText: Text[120];
        OldDimText: Text[100];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        "-NAVIN-": Integer;
        // StructureLineDetails: Record "Structure Order Line Details";
        TotalTaxAmount: Decimal;
        LineAmt: Decimal;
        LineTotAmt: Decimal;
        ExciseAmount: Decimal;
        GstAmount: Decimal;
        Charges: Decimal;
        Othertaxes: Decimal;
        SalesTax: Decimal;
        Currency: Record Currency;
        ServiceTax: Decimal;
        "---Navision Efftronics-----": Integer;
        "Sl.No.": Integer;
        Vendor: Record Vendor;
        PurcaserCode: Record "Salesperson/Purchaser";
        PurchaserName: Text[50];
        "PhoneNo.": Code[20];
        Contact: Record Contact;
        "ContactFAXNo.": Code[100];
        ContactName: Text[50];
        "ContactPhNo.": Text[30];
        "ContactCellNo.": Text[30];
        "ContactE-mail": Text[250];
        PackingDetails: Text[50];
        "Verification Requirements": Text[50];
        Note: Text;
        totalamount: Decimal;
        finalamount: Decimal;
        "Total  currency": Decimal;
        Tot_For_Currecy: Decimal;
        Prev_Item: Code[30];
        Item_Ordered_QTY: Decimal;
        Order_Breakup: Text[1000];
        "No.Of Lines": Integer;
        "Expected Dates": Text[1000];
        Schedu_Number: Text[100];
        "Delivery Date": Date;
        Line_No: Integer;
        Previous: Boolean;
        Start_Date: Date;
        Final_Date: Date;
        PL: Record "Purchase Line";
        Pur_Cnt: Integer;
        Item_Cnt: Integer;
        Foriegn_Value: Decimal;
        Pur_Line_Amt: Decimal;
        Qtn: Code[30];
        Qtn_Date: Code[15];
        EXCISE: Text[30];
        VAT: Text[30];
        CST: Text[30];
        SERVICE: Text[30];
        CFORM: Text[30];
        DISCOUNT: Text[30];
        FORIEGN: Text[30];
        FORIEGN_AMOUNT: Decimal;
        Material_Value_Txt: Text[30];
        Final_Amount_Txt: Decimal;
        Excei_Txt: Text[30];
        Excise_Amount_Txt: Decimal;
        Other_Charges_Txt: Text[30];
        Sales_Tax_Txt: Decimal;
        CST_TXT: Text[30];
        SERVICE_TAX_TXT: Text[30];
        VAT_TXT: Text[30];
        SERVICE_TAX_VALUE_TXT: Decimal;
        VAT_AMOUNT_TXT: Decimal;
        TOTAL_AMOUNT_TXT: Text[30];
        LINETOTAMT_TXT: Decimal;
        OTHER_TAXES_TXT: Decimal;
        GST_TAXES_TXT: Decimal;
        Charges_Txt: Decimal;
        Other_Chrges_Txt: Text[30];
        OTHER_TAX_TXT: Text[30];
        GST_TAX_TXT: Text;
        //EXCISE_POSTING_SETUP: Record "Excise Posting Setup";//B2BUpg
        //SERVICE_TAX_SETUP: Record "Service Tax Setup";//B2BUpg
        Taxes_Extra: Text[30];
        TAX_DETAIL: Record "Tax Detail";
        DESC: Text[1000];
        Item2: Record Item;
        Mask: Text[30];
        SIZE: Text[300];
        Is_PCB: Boolean;
        desc_make: Text[100];
        desc_partnumber: Code[100];
        desc_package: Text[100];
        x: Text[10];
        y: Text[10];
        Description: Text[1000];
        desc_desc: Text[1000];
        E__Mail_CaptionLbl: Label 'E- Mail:';
        Ph_CaptionLbl: Label 'Ph:';
        FAX_CaptionLbl: Label '   FAX:';
        URL_CaptionLbl: Label 'URL:';
        Purchase_OrderCaptionLbl: Label 'Purchase Order';
        purchase_efftronics_comCaptionLbl: Label 'purchase@efftronics.com';
        Ref__Quotation_No__CaptionLbl: Label 'Ref. Quotation No :';
        Qtn__Dated_______CaptionLbl: Label 'Qtn. Dated      :';
        Cell_No____________CaptionLbl: Label 'Cell No.          :';
        Fax_No_____________CaptionLbl: Label 'Fax.No            :';
        Ph_No______________CaptionLbl: Label 'Ph.No             :';
        ToCaptionLbl: Label 'To';
        Ord__Ref_No__CaptionLbl: Label 'Ord. Ref.No: ';
        Ordered_Date_CaptionLbl: Label 'Ordered Date:';
        Contact___________CaptionLbl: Label 'Contact          :';
        E_mail_____________CaptionLbl: Label 'E-mail            :';
        Service_Tax_Regn_No__CaptionLbl: Label 'Service Tax Regn No :';
        Excise_Regn_No__CaptionLbl: Label 'Excise Regn No :';
        TIN_No____________________CaptionLbl: Label 'TIN No.                  :';
        CST_No____________CaptionLbl: Label 'CST.No           :';
        NOTE_CaptionLbl: Label 'NOTE:';
        Payment_Terms_CaptionLbl: Label 'Payment Terms:';
        PLEASE_INTIMATE_ANY_DELAY_IN_MATERIAL_BEYOND_DELIVERY_DATE_OR_NON_AVAILABILITY_OF_MATERIAL_IMMEDIATELY_CaptionLbl: Label 'Please intimate any delay in material beyond delivery date or non-availability of material immediately.';
        Delivery_Terms_CaptionLbl: Label 'Delivery Terms:';
        Delivery_Date_CaptionLbl: Label 'Delivery Date:';
        Verification_Requirements_CaptionLbl: Label 'Verification Requirements:';
        Packing_Details_CaptionLbl: Label 'Packing Details:';
        Manager_Purchases_CaptionLbl: Label '(Manager-Purchases)';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Sl_No_CaptionLbl: Label 'Sl.No';
        QuantityCaptionLbl: Label 'Quantity';
        UnitCaptionLbl: Label 'Unit';
        RateCaptionLbl: Label 'Rate';
        Amount_in_Rs_LCY_CaptionLbl: Label 'Amount in Rs(LCY)';
        Amt_Foregin_CaptionLbl: Label 'Amt.Foregin ';
        Expected__Receipt_DateCaptionLbl: Label 'Expected  Receipt Date';
        Continued___CaptionLbl: Label 'Continued...';
        TotalCaptionLbl: Label 'Total';
        ContinuedCaptionLbl: Label 'Continued';
        Line_DimensionsCaptionLbl: Label '';
        "-DIM1.0-": Integer;
        DimSetEntryGRec: Record "Dimension Set Entry";
        DimSetEntryGRec2: Record "Dimension Set Entry";
        "-Rev01-": Integer;
        PurchLineBody4: Boolean;
        PurchLineBody5: Boolean;
        PurchLineBody6: Boolean;
        PurchLineBody7: Boolean;
        PurchLineBody8: Boolean;
        DimLoop1Body1: Boolean;
        DimLoop1Body2: Boolean;
        PurchLineGRec: Record "Purchase Line";
        PrevNo: Code[20];
        //tin: Record "T.I.N. Nos.";
        TNo: Text[15];
        CSTNo: Text;
        Paching_Charges: Decimal;
        Insurance_Charges: Decimal;
        Paching_Charges_Txt: Text[30];
        Insurance_Charges_Txt: Text[30];
        VendorNew: Record Vendor;
        PackingPercnt: Text;
        InsurancePercnt: Text;
        CGST: Decimal;
        IGST: Decimal;
        SGST: Decimal;
        GST_AMOUNT_TXT: Decimal;
        GST_Setup: Record "GST Setup";
        HSN_SAC: Text;
        Vendor_State_Name: Text;
        Vendor_State_No: Text;
        GST_Reg_No: Text[15];
        Ord_Adrss: Record "Order Address";
        Text_new: Label '25% advance alongwith PO                          35%  On receipt of material                            10% on each phase  completion                             10%  on total completion                                     ';
        Text_new1: Label '14.5% advance alongwith PO                          2.18% on each floor( 6.5% on total floors)                          ';
        PaymetStatic_or_dynamic: Text;
}

