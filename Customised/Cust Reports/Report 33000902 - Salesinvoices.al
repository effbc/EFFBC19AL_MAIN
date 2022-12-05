report 33000902 "Sales invoices"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Salesinvoices.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("External Document No.") ORDER(Ascending);
            RequestFilterFields = "Posting Date", "External Document No.";
            column(FORMAT_datefilter_; FORMAT(datefilter))
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Posting_Date_; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Sell_to_Customer_Name_; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___External_Document_No__; "Sales Invoice Header"."External Document No.")
            {
            }
            column(ProdPosgroup; ProdPosgroup)
            {
            }
            column(qty; qty)
            {
            }
            column(taxtype; taxtype)
            {
            }
            column(per; per)
            {
            }
            column(ROUND_vatamt_1_; ROUND(vatamt, 1))
            {
            }
            column(ROUND_cstamt_1_; ROUND(cstamt, 1))
            {
            }
            column(ROUND__Sales_Invoice_Header___Total_Invoiced_Amount__1_; ROUND("Sales Invoice Header"."Total Invoiced Amount", 1))
            {
            }
            column(ROUND_dlassessable_1_; ROUND(dlassessable, 1))
            {
            }
            column(ROUND_edbassessable_1_; ROUND(edbassessable, 1))
            {
            }
            column(ROUND_sftassessable_1_; ROUND(sftassessable, 1))
            {
            }
            column(ROUND_assessable_1_; ROUND(assessable, 1))
            {
            }
            column(ROUND_Excise_1_; ROUND(Excise, 1))
            {
            }
            //B2BUpg>>
            /*
            column(Sales_Invoice_Header__Sales_Invoice_Header___Form_Code_; "Sales Invoice Header"."Form Code")
            {
            }*/
            //B2BUpg<<
            column(ROUND_actualcess_2_3_1_; ROUND(actualcess * 2 / 3, 1))
            {
            }
            column(ROUND_actualcess_3_1_; ROUND(actualcess / 3, 1))
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Posting_Date__Control1102154096; "Sales Invoice Header"."Posting Date")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___Sell_to_Customer_Name__Control1102154097; "Sales Invoice Header"."Sell-to Customer Name")
            {
            }
            column(Sales_Invoice_Header__Sales_Invoice_Header___External_Document_No___Control1102154098; "Sales Invoice Header"."External Document No.")
            {
            }
            column(ROUND__Sales_Invoice_Header___Total_Invoiced_Amount__1__Control1102154105; ROUND("Sales Invoice Header"."Total Invoiced Amount", 1))
            {
            }
            column(ROUND_assessable_1__Control1102154109; ROUND(assessable, 1))
            {
            }
            column(ROUND_service_1_; ROUND(service, 1))
            {
            }
            column(ROUND_serviceecess_2_3_1_; ROUND(serviceecess * 2 / 3, 1))
            {
            }
            column(ROUND_serviceecess_1_3_1_; ROUND(serviceecess * 1 / 3, 1))
            {
            }
            column(typeofservice; typeofservice)
            {
            }
            column(ROUND_totvatamt_1_; ROUND(totvatamt, 1))
            {
            }
            column(ROUND_totcstamt_1_; ROUND(totcstamt, 1))
            {
            }
            column(ROUND_totamt_1_; ROUND(totamt, 1))
            {
            }
            column(ROUND_totdlassessable_1_; ROUND(totdlassessable, 1))
            {
            }
            column(ROUND_totedbassessable_1_; ROUND(totedbassessable, 1))
            {
            }
            column(ROUND_totsftassessable_1_; ROUND(totsftassessable, 1))
            {
            }
            column(ROUND_totassessable_1_; ROUND(totassessable, 1))
            {
            }
            column(ROUND_totExcise_1_; ROUND(totExcise, 1))
            {
            }
            column(ROUND__totactualcess_2_3__1_; ROUND((totactualcess * 2 / 3), 1))
            {
            }
            column(ROUND__totactualcess_3__1_; ROUND((totactualcess / 3), 1))
            {
            }
            column(ROUND_totamt_1__Control1102154175; ROUND(totamt, 1))
            {
            }
            column(ROUND_totassessable_1__Control1102154179; ROUND(totassessable, 1))
            {
            }
            column(ROUND_totalservice_1_; ROUND(totalservice, 1))
            {
            }
            column(ROUND__totalservicecess_2_3__1_; ROUND((totalservicecess * 2 / 3), 1))
            {
            }
            column(ROUND__totalservicecess_1_3__1_; ROUND((totalservicecess * 1 / 3), 1))
            {
            }
            column(Sale_Invoices_Between_the_Period_ofCaption; Sale_Invoices_Between_the_Period_ofCaptionLbl)
            {
            }
            column(Invoiced_DateCaption; Invoiced_DateCaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Invoice_NoCaption; Invoice_NoCaptionLbl)
            {
            }
            column(Product_typeCaption; Product_typeCaptionLbl)
            {
            }
            column(Tax_TypeCaption; Tax_TypeCaptionLbl)
            {
            }
            column(PercentageCaption; PercentageCaptionLbl)
            {
            }
            column(VAT_AmountCaption; VAT_AmountCaptionLbl)
            {
            }
            column(CST_AmountCaption; CST_AmountCaptionLbl)
            {
            }
            column(Invoiced_AmountCaption; Invoiced_AmountCaptionLbl)
            {
            }
            column(DATA_LOGGERCaption; DATA_LOGGERCaptionLbl)
            {
            }
            column(EDBCaption; EDBCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(SoftwareCaption; SoftwareCaptionLbl)
            {
            }
            column(AssessableCaption; AssessableCaptionLbl)
            {
            }
            column(ExciseCaption; ExciseCaptionLbl)
            {
            }
            column(Cess__2__Caption; Cess__2__CaptionLbl)
            {
            }
            column(Cess__1__Caption; Cess__1__CaptionLbl)
            {
            }
            column(FORM___CCaption; FORM___CCaptionLbl)
            {
            }
            column(Invoiced_DateCaption_Control1102154132; Invoiced_DateCaption_Control1102154132Lbl)
            {
            }
            column(Customer_NameCaption_Control1102154133; Customer_NameCaption_Control1102154133Lbl)
            {
            }
            column(Invoice_NoCaption_Control1102154134; Invoice_NoCaption_Control1102154134Lbl)
            {
            }
            column(Invoiced_AmountCaption_Control1102154140; Invoiced_AmountCaption_Control1102154140Lbl)
            {
            }
            column(AssessableCaption_Control1102154145; AssessableCaption_Control1102154145Lbl)
            {
            }
            column(Service_TaxCaption; Service_TaxCaptionLbl)
            {
            }
            column(Cess__2__Caption_Control1102154147; Cess__2__Caption_Control1102154147Lbl)
            {
            }
            column(Cess__1__Caption_Control1102154148; Cess__1__Caption_Control1102154148Lbl)
            {
            }
            column(Type_of_ServiceCaption; Type_of_ServiceCaptionLbl)
            {
            }
            column(TotalsCaption; TotalsCaptionLbl)
            {
            }
            column(TotalsCaption_Control1102154183; TotalsCaption_Control1102154183Lbl)
            {
            }
            column(Sales_Invoice_Header_No_; "No.")
            {
            }
            column(serviceinv; serviceinv)
            {
            }
            column(normal; normal)
            {
            }

            trigger OnAfterGetRecord()
            var
                temp: Text;
                CLE: Record "Cust. Ledger Entry";
            begin
                PGC := '';
                dlPGC := '';
                edbPGC := '';
                ledPGC := '';
                sftPGC := '';
                ProdPosgroup := '';
                dlProdPosgroup := '';
                ledProdPosgroup := '';
                sftProdPosgroup := '';
                edbProdPosgroup := '';
                cstamt := 0;
                vatamt := 0;
                assessable := 0;
                dlassessable := 0;
                ledassessable := 0;
                edbassessable := 0;
                sftassessable := 0;
                dlcstamt := 0;
                edbcstamt := 0;
                ledcstamt := 0;
                sftcstamt := 0;
                dlvatamt := 0;
                edbvatamt := 0;
                ledvatamt := 0;
                sftvatamt := 0;
                dlQty := 0;
                sftQty := 0;
                edbQty := 0;
                ledQty := 0;
                Excise := 0;
                dlExcise := 0;
                edbExcise := 0;
                ledExcise := 0;
                sftExcise := 0;
                dlAmtToCustomer := 0;
                edbAmtToCustomer := 0;
                ledAmtToCustomer := 0;
                sftAmtToCustomer := 0;
                service := 0;
                actualcess := 0;
                serviceecess := 0;
                instamt := 0;
                softamt := 0;
                servamt := 0;
                qty := 0;
                SBCessAmt := 0;
                KKCessAmt := 0;
                CurrHSN := 'START';
                TCS_Rate := 0;
                TCS_Amount := 0;
                PAN := '';
                //IF EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Invoice", "Sales Invoice Header"."No.") THEN;//B2BUpg
                IF FilterDate >= GSTDate THEN BEGIN
                    CurrHSN := 'START';
                    SIL.RESET;
                    SIL.SETCURRENTKEY("Document No.", "HSN/SAC Code");
                    SIL.SETRANGE(SIL."Document No.", "Sales Invoice Header"."No.");
                    SIL.SETRANGE(SIL."Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                    SIL.SETFILTER(SIL.Quantity, '>%1', 0);
                    IF SIL.FIND('-') THEN BEGIN
                        REPEAT
                            IF (SIL."HSN/SAC Code" <> CurrHSN) THEN BEGIN
                                igst_amt := 0;
                                cgst_amt := 0;
                                sgst_amt := 0;
                                tot_amt_cust := 0;
                                tot_gst_Assessible_amt := 0;
                                gst_qty := 0;
                                TCS_Amount := 0;
                                SIL1.RESET;
                                SIL1.SETRANGE(SIL1."Document No.", "Sales Invoice Header"."No.");
                                SIL1.SETRANGE(SIL1."Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                                SIL1.SETRANGE(SIL1."HSN/SAC Code", SIL."HSN/SAC Code");
                                SIL1.SETFILTER(SIL1.Quantity, '>%1', 0);
                                IF SIL1.FINDSET THEN
                                    REPEAT
                                        IF SIL1."GST Jurisdiction Type" = SIL1."GST Jurisdiction Type"::Interstate THEN
                                            igst_amt += (GetSalesGSTLineWise(SIL1))
                                        ELSE BEGIN
                                            sgst_amt += (GetSalesGSTLineWise(SIL1) / 2);
                                            cgst_amt += (GetSalesGSTLineWise(SIL1) / 2);
                                        END;
                                        tot_amt_cust += SIL1."Amount To Customer";
                                        tot_gst_Assessible_amt += SIL1."Line Amount";
                                        gst_qty += SIL1.Quantity;
                                        //TCS_Rate := SIL1."TDS/TCS %";//B2BUpg
                                        TCS_Amount += GetTCSAmt("Sales Invoice Header", SIL1);

                                    UNTIL SIL1.NEXT = 0;
                                IF ("Sales Invoice Header"."Currency Code" <> '') AND ("Sales Invoice Header"."Currency Factor" > 0) THEN BEGIN
                                    igst_amt := igst_amt / "Sales Invoice Header"."Currency Factor";
                                    sgst_amt := sgst_amt / "Sales Invoice Header"."Currency Factor";
                                    cgst_amt := cgst_amt / "Sales Invoice Header"."Currency Factor";
                                    tot_amt_cust := tot_amt_cust / "Sales Invoice Header"."Currency Factor";
                                    tot_gst_Assessible_amt := tot_gst_Assessible_amt / "Sales Invoice Header"."Currency Factor";
                                END;
                                row := row + 1;
                                EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                                EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF SIL."HSN/SAC Code" <> '' THEN
                                    EnterCell(row, 5, FORMAT(SIL."HSN/SAC Code"), FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE BEGIN
                                    IF (SIL.Type = SIL.Type::Item) AND (Item.GET(SIL."No.")) THEN
                                        EnterCell(row, 5, FORMAT(Item."HSN/SAC Code"), FALSE, TempExcelBuffer."Cell Type"::Text)
                                    ELSE
                                        IF GLAccnt.GET(SIL."No.") THEN
                                            EnterCell(row, 5, FORMAT(GLAccnt."HSN/SAC Code"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                END;
                                EnterCell(row, 6, FORMAT(gst_qty), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 7, FORMAT(SIL."GST Jurisdiction Type"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF SIL1."GST Jurisdiction Type" = SIL1."GST Jurisdiction Type"::Interstate THEN BEGIN
                                    EnterCell(row, 8, FORMAT(ROUND(GetSalesGSTPercent(SIL), 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                END ELSE BEGIN
                                    EnterCell(row, 9, FORMAT(ROUND(GetSalesGSTPercent(SIL) / 2, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                    EnterCell(row, 10, FORMAT(ROUND(GetSalesGSTPercent(SIL) / 2, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                END;
                                EnterCell(row, 11, FORMAT(ROUND(sgst_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 12, FORMAT(ROUND(cgst_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 13, FORMAT(ROUND(igst_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 14, FORMAT(ROUND(tot_amt_cust, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                IF SIL."GST Group Code" = 'MPBI' THEN
                                    EnterCell(row, 15, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number)
                                ELSE
                                    IF SIL."GST Group Code" = 'EDB' THEN
                                        EnterCell(row, 16, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number)
                                    ELSE
                                        IF SIL."GST Group Code" = 'LED' THEN
                                            EnterCell(row, 17, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number)
                                        ELSE
                                            IF SIL."GST Group Code" = 'X-RAY' THEN
                                                EnterCell(row, 18, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number)
                                            ELSE
                                                EnterCell(row, 19, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 20, FORMAT(ROUND(tot_gst_Assessible_amt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 21, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 22, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 23, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                user.RESET;
                                user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                                IF user.FIND('-') THEN
                                    EnterCell(row, 24, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF ("Sales Invoice Header"."Currency Code" <> '') AND ("Sales Invoice Header"."Currency Factor" > 0) THEN BEGIN
                                    EnterCell(row, 25, FORMAT("Sales Invoice Header"."Sale Order Total Amount" / "Sales Invoice Header"."Currency Factor"), FALSE, TempExcelBuffer."Cell Type"::Number);
                                END ELSE
                                    EnterCell(row, 25, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 26, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF SIL."Sell-to Customer No." = 'CUST00536' THEN BEGIN
                                    EnterCell(row, 29, FORMAT("Sales Invoice Header"."GST Customer Type"::Unregistered), FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE BEGIN
                                    CLE.RESET;
                                    CLE.SETFILTER("Document No.", SIL."Document No.");
                                    IF CLE.FINDFIRST THEN BEGIN
                                        IF CLE."Seller GST Reg. No." <> '' THEN BEGIN
                                            EnterCell(row, 27, "Sales Invoice Header"."Customer GST Reg. No.", FALSE, TempExcelBuffer."Cell Type"::Text);// bypriyanka for wrong gstno's
                                            IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::Unregistered THEN BEGIN
                                                EnterCell(row, 29, FORMAT("Sales Invoice Header"."GST Customer Type"::Registered), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            END ELSE BEGIN
                                                EnterCell(row, 29, FORMAT("Sales Invoice Header"."GST Customer Type"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            END;
                                        END ELSE BEGIN
                                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."GST Customer Type"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                        END;
                                    END;
                                END;
                                EnterCell(row, 28, SIL."GST Group Code", FALSE, TempExcelBuffer."Cell Type"::Text);
                                GroupCode := CopyStr(SIL."GST Group Code", 1, 10);
                                HSNSACTABLE.RESET;
                                HSNSACTABLE.SETRANGE("GST Group Code", GroupCode);
                                HSNSACTABLE.SETRANGE(Code, SIL."HSN/SAC Code");
                                IF HSNSACTABLE.FINDFIRST THEN
                                    EnterCell(row, 30, FORMAT(HSNSACTABLE.Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF SIL."GST Place of Supply" = SIL."GST Place of Supply"::"Bill-to Address" THEN BEGIN
                                    IF StateGRec.GET("Sales Invoice Header"."GST Bill-to State Code") THEN
                                        EnterCell(row, 31, FORMAT(StateGRec."State Code (GST Reg. No.)" + '-' + StateGRec.Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE BEGIN
                                    IF StateGRec.GET("Sales Invoice Header"."GST Ship-to State Code") THEN
                                        EnterCell(row, 31, FORMAT(StateGRec."State Code (GST Reg. No.)" + '-' + StateGRec.Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                                END;
                                EnterCell(row, 32, FORMAT("Sales Invoice Header"."No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 33, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF "Sales Invoice Header"."GST Customer Type" = "Sales Invoice Header"."GST Customer Type"::Export THEN BEGIN
                                    IF (GetSalesGSTLineWise(SIL) > 0) THEN
                                        EnterCell(row, 34, 'Export with payment of GST', FALSE, TempExcelBuffer."Cell Type"::Text)
                                    ELSE
                                        EnterCell(row, 34, 'Export without payment of GST', FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE
                                    IF "Sales Invoice Header"."GST Customer Type" IN ["Sales Invoice Header"."GST Customer Type"::"SEZ Development", "Sales Invoice Header"."GST Customer Type"::"SEZ Unit"] THEN BEGIN
                                        IF (GetSalesGSTLineWise(SIL) > 0) THEN
                                            EnterCell(row, 34, 'SEZ with payment of GST', FALSE, TempExcelBuffer."Cell Type"::Text)
                                        ELSE
                                            EnterCell(row, 34, 'SEZ without payment of GST', FALSE, TempExcelBuffer."Cell Type"::Text);
                                    END;
                                EnterCell(row, 35, FORMAT("Sales Invoice Header"."Bill Of Export Date"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 36, FORMAT("Sales Invoice Header"."Bill Of Export No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                IF SIL.Type = SIL.Type::Item THEN BEGIN
                                    PostingSetup.RESET;
                                    PostingSetup.SETRANGE("Gen. Prod. Posting Group", SIL."Gen. Prod. Posting Group");
                                    PostingSetup.SETRANGE("Gen. Bus. Posting Group", "Sales Invoice Header"."Gen. Bus. Posting Group");
                                    IF PostingSetup.FINDFIRST THEN BEGIN
                                        GLAct.RESET;
                                        GLAct.SETRANGE("No.", PostingSetup."Sales Account");
                                        IF GLAct.FINDFIRST THEN BEGIN
                                            IF "Sales Invoice Header"."Customer Posting Group" = 'RAILWAYS' THEN BEGIN
                                                temp := "Sales Invoice Header"."Sell-to Customer Name" + '_' + COPYSTR("Sales Invoice Header"."Order No.", 9, STRLEN("Sales Invoice Header"."Order No.")) + '_' + "Sales Invoice Header"."Bill-to Customer No.";
                                                EnterCell(row, 38, temp, FALSE, TempExcelBuffer."Cell Type"::Text)
                                            END ELSE BEGIN
                                                EnterCell(row, 38, FORMAT("Sales Invoice Header"."Sell-to Customer Name" + '_' + "Sales Invoice Header"."Bill-to Customer No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            END;
                                            EnterCell(row, 40, FORMAT(GLAct.Name + '_' + GLAct."No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            EnterCell(row, 41, FORMAT(GLAct."No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                        END;
                                    END;
                                    EnterCell(row, 39, FORMAT(SIL.Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE
                                    IF SIL.Type = SIL.Type::"G/L Account" THEN BEGIN
                                        GLAct.RESET;
                                        GLAct.SETRANGE("No.", SIL."No.");
                                        IF GLAct.FINDFIRST THEN BEGIN
                                            IF "Sales Invoice Header"."Customer Posting Group" = 'RAILWAYS' THEN BEGIN
                                                temp := "Sales Invoice Header"."Sell-to Customer Name" + '_' + COPYSTR("Sales Invoice Header"."Order No.", 9, STRLEN("Sales Invoice Header"."Order No.")) + '_' + "Sales Invoice Header"."Bill-to Customer No.";
                                                EnterCell(row, 38, temp, FALSE, TempExcelBuffer."Cell Type"::Text)
                                            END ELSE BEGIN
                                                EnterCell(row, 38, FORMAT("Sales Invoice Header"."Sell-to Customer Name" + '_' + "Sales Invoice Header"."Bill-to Customer No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            END;
                                            EnterCell(row, 40, FORMAT(GLAct.Name + '_' + GLAct."No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                            EnterCell(row, 41, FORMAT(GLAct."No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                        END;
                                        EnterCell(row, 39, FORMAT(SIL.Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                                    END;
                                IF (COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) = 'SI') OR (COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) = 'IN') THEN BEGIN
                                    EnterCell(row, 42, 'S', FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE BEGIN
                                    EnterCell(row, 42, 'G', FALSE, TempExcelBuffer."Cell Type"::Text);
                                END;
                                IF (COPYSTR("Sales Invoice Header"."Shortcut Dimension 1 Code", 1, 3) = 'CUS') THEN BEGIN
                                    EnterCell(row, 43, 'CS', FALSE, TempExcelBuffer."Cell Type"::Text);
                                END ELSE
                                    IF (COPYSTR("Sales Invoice Header"."Shortcut Dimension 1 Code", 1, 3) = 'PRD') THEN BEGIN
                                        EnterCell(row, 43, 'PROD', FALSE, TempExcelBuffer."Cell Type"::Text);
                                    END;
                                //Added by Durga on 06-11-2020
                                IF Customer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN
                                    EnterCell(row, 44, FORMAT(Customer."P.A.N. No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 45, FORMAT(TCS_Rate), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 46, FORMAT(TCS_Amount), FALSE, TempExcelBuffer."Cell Type"::Number);
                                EnterCell(row, 47, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 48, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 49, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 50, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 51, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 52, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                                /*EnterCell(row, 53, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 54, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*///B2BUpg
                                EnterCell(row, 53, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                                EnterCell(row, 54, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            END;
                            CurrHSN := SIL."HSN/SAC Code";
                        UNTIL SIL.NEXT = 0;
                    END ELSE
                        CurrReport.SKIP;
                END ELSE BEGIN
                    SIL.RESET;
                    SIL.SETRANGE(SIL."Document No.", "Sales Invoice Header"."No.");
                    SIL.SETRANGE(SIL."Sell-to Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
                    SIL.SETFILTER(SIL.Quantity, '>%1', 0);
                    IF SIL.FIND('-') THEN BEGIN
                        REPEAT
                            IF SIL."Amount To Customer" > 0 THEN BEGIN
                                //ProdPosgroup := SIL."Excise Prod. Posting Group";
                                qty := qty + SIL.Quantity;
                                //B2BUpg>>
                                /*IF SIL."Tax Area Code" = 'SALES CST' THEN BEGIN
                                    taxtype := 'CST';
                                    per := FORMAT(SIL."Tax %");
                                    cstamt := cstamt + SIL."Tax Amount";
                                    cstper := FORMAT(SIL."Tax %");
                                END ELSE
                                    IF SIL."Tax Area Code" = 'SALES VAT' THEN BEGIN
                                        taxtype := 'VAT';
                                        //per:=FORMAT(SIL."VAT %age");
                                        per := FORMAT(SIL."Tax %");
                                        vatamt := vatamt + SIL."Tax Amount";
                                    END;*/
                                //B2BUpg<<
                                Item.RESET;
                                Item.SETFILTER(Item."No.", SIL."No.");
                                IF Item.FINDFIRST THEN
                                    PGC := Item."Item Sub Group Code";
                                //B2BUpg
                                /*IF SIL."Excise Prod. Posting Group" IN ['84711000', '84715000'] THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER(Item."No.", SIL."No.");
                                    IF Item.FINDFIRST THEN
                                        dlPGC := Item."Item Sub Group Code";
                                    dlProdPosgroup := SIL."Excise Prod. Posting Group";
                                    dlAmtToCustomer := dlAmtToCustomer + SIL."Amount To Customer";
                                    dlassessable := dlassessable + SIL.Amount;
                                    dlQty := dlQty + SIL.Quantity;
                                    dlExcise := dlExcise + SIL."BED Amount";
                                    IF SIL."Tax Area Code" = 'SALES CST' THEN
                                        dlcstamt := dlcstamt + SIL."Tax Amount"
                                    ELSE
                                        IF SIL."Tax Area Code" = 'SALES VAT' THEN
                                            dlvatamt := dlvatamt + SIL."Tax Amount";
                                END;
                                IF SIL."Excise Prod. Posting Group" = '85414020' THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER(Item."No.", SIL."No.");
                                    IF Item.FINDFIRST THEN
                                        edbPGC := Item."Item Sub Group Code";
                                    edbProdPosgroup := SIL."Excise Prod. Posting Group";
                                    edbAmtToCustomer := edbAmtToCustomer + SIL."Amount To Customer";
                                    edbassessable := edbassessable + SIL.Amount;
                                    edbQty := edbQty + SIL.Quantity;
                                    edbExcise := edbExcise + SIL."BED Amount";
                                    IF SIL."Tax Area Code" = 'SALES CST' THEN
                                        edbcstamt := edbcstamt + SIL."Tax Amount"
                                    ELSE
                                        IF SIL."Tax Area Code" = 'SALES VAT' THEN
                                            edbvatamt := edbvatamt + SIL."Tax Amount";
                                END;
                                IF SIL."Excise Prod. Posting Group" = '90221900' THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER(Item."No.", SIL."No.");
                                    IF Item.FINDFIRST THEN
                                        sftPGC := Item."Item Sub Group Code";
                                    sftProdPosgroup := SIL."Excise Prod. Posting Group";
                                    sftAmtToCustomer := sftAmtToCustomer + SIL."Amount To Customer";
                                    sftassessable := sftassessable + SIL.Amount;
                                    sftQty := sftQty + SIL.Quantity;
                                    sftExcise := sftExcise + SIL."BED Amount";
                                    IF SIL."Tax Area Code" = 'SALES CST' THEN
                                        sftcstamt := sftcstamt + SIL."Tax Amount"
                                    ELSE
                                        IF SIL."Tax Area Code" = 'SALES VAT' THEN
                                            sftvatamt := sftvatamt + SIL."Tax Amount";
                                END;
                                IF SIL."Excise Prod. Posting Group" IN ['94054090', 'LED_MRP'] THEN BEGIN
                                    Item.RESET;
                                    Item.SETFILTER(Item."No.", SIL."No.");
                                    IF Item.FINDFIRST THEN
                                        ledPGC := Item."Item Sub Group Code";
                                    ledProdPosgroup := SIL."Excise Prod. Posting Group";
                                    ledAmtToCustomer := ledAmtToCustomer + SIL."Amount To Customer";
                                    ledassessable := ledassessable + SIL.Amount;
                                    ledQty := ledQty + SIL.Quantity;
                                    ledExcise := ledExcise + SIL."BED Amount";
                                    IF SIL."Tax Area Code" = 'SALES CST' THEN
                                        ledcstamt := ledcstamt + SIL."Tax Amount"
                                    ELSE
                                        IF SIL."Tax Area Code" = 'SALES VAT' THEN
                                            ledvatamt := ledvatamt + SIL."Tax Amount";
                                END;*/
                                //B2BUpg<<
                                assessable := assessable + SIL.Amount;
                                // Excise := Excise + SIL."BED Amount";
                                //service := service + SIL."Service Tax Amount";
                                //actualcess := actualcess + SIL."eCess Amount" + SIL."SHE Cess Amount"; //anil 3107
                                //serviceecess := serviceecess + SIL."Service Tax eCess Amount";
                                //SBCessAmt += SIL."Service Tax SBC Amount";
                                //KKCessAmt += SIL."KK Cess Amount";
                            END;
                            pos := STRPOS(SIL."External Document No.", str);
                            pos1 := STRPOS(SIL."External Document No.", str1);
                            IF pos <> 0 THEN BEGIN
                                typeofservice := 'Installation';
                                IF ((SIL."No." = '46400') OR (SIL."No." = '47505')) AND (SIL."Amount To Customer" > 0) THEN BEGIN
                                    typeofservice := 'Software';
                                    softamt := softamt + SIL.Amount;
                                END;
                                IF (SIL."No." = '47300') AND (SIL."Amount To Customer" > 0) THEN BEGIN
                                    typeofservice := 'Installation';
                                    instamt := instamt + SIL.Amount;
                                END;
                            END;
                            IF pos1 <> 0 THEN
                                IF (SIL."No." = '47503') AND (SIL."Amount To Customer" > 0) THEN BEGIN
                                    typeofservice := 'Servicing';
                                    servamt := servamt + SIL.Amount;
                                END;
                        /*
                          SSH.RESET;
                          SSH.SETFILTER(SSH."Sell-to Customer No.","Sales Invoice Header"."Sell-to Customer No.");
                          SSH.SETFILTER(SSH."External Document No.","Sales Invoice Header"."External Document No.");
                          SSH.SETFILTER(SSH."Posting Date",'%1',"Sales Invoice Header"."Posting Date");
                          IF SSH.FINDFIRST THEN
                          BEGIN
                            ILE.RESET;
                            ILE.SETFILTER(ILE."Item No.",SIL."No.");
                            ILE.SETFILTER(ILE."Document No.",SSH."No.");
                            IF ILE.FINDFIRST THEN
                            REPEAT
                              ILE2.RESET;
                              ILE2.SETCURRENTKEY("Item No.","Posting Date");
                              ILE2.SETFILTER(ILE2."Item No.",ILE."Item No.");
                              ILE2.SETFILTER(ILE2."Serial No.",ILE."Serial No.");
                              ILE2.SETFILTER(ILE2."Lot No.",ILE."Lot No.");
                              IF ILE2.FINDFIRST THEN
                              BEGIN
                                VLE.RESET;
                                VLE.SETFILTER(VLE."Item Ledger Entry No.",ILE2."Entry No.");
                                VLE.SETFILTER(VLE."Document Type",VLE."Document Type"::'Purchase Invoice');
                                IF VLE.FINDFIRST THEN
                                BEGIN
                                  VLE."Cost Amount (Actual)"
                                END;
                              END;
                            UNTIL ILE.NEXT=0;
                          END;
                        */
                        UNTIL SIL.NEXT = 0;
                    END ELSE
                        CurrReport.SKIP;

                    totdlassessable := totdlassessable + dlassessable;
                    totedbassessable := totedbassessable + edbassessable;
                    totledassessable := totledassessable + ledassessable;
                    totsftassessable := totsftassessable + sftassessable;
                    totassessable := totassessable + assessable;
                    totactualcess := totactualcess + actualcess;
                    totExcise := totExcise + Excise;
                    totalservice := totalservice + service;
                    totalservicecess := totalservicecess + serviceecess;
                    totvatamt := totvatamt + vatamt;
                    totcstamt := totcstamt + cstamt;


                    "Sales Invoice Header".CALCFIELDS("Sales Invoice Header"."Total Invoiced Amount");
                    totamt := totamt + "Sales Invoice Header"."Total Invoiced Amount";

                    //Rev01 code copied from // Sales Invoice Header, Body (4) - OnPostSection()
                    IF NOT serviceinv THEN BEGIN
                        //IF normal THEN BEGIN
                        "Sales Invoice Header".CALCFIELDS("Sales Invoice Header"."Total Invoiced Amount");
                        //IF "Sales Invoice Header"."Total Invoiced Amount"<>0 THEN BEGIN // REV01 >>
                        IF dlQty > 0 THEN BEGIN
                            row := row + 1;
                            EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                            EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            IF COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) <> 'CI' THEN
                                EnterCell(row, 5, FORMAT(dlProdPosgroup), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 6, FORMAT(dlQty), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 7, FORMAT(taxtype), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(per), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 9, FORMAT(ROUND(dlvatamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 10, FORMAT(ROUND(dlcstamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 11, FORMAT(ROUND(dlAmtToCustomer, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 12, FORMAT(ROUND(dlassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 13, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 14, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 15, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 16, FORMAT(ROUND(dlassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 17, FORMAT(ROUND(dlExcise, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 18, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 19, FORMAT(ROUND(actualcess * 1 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            //EnterCell(row,16,FORMAT(ROUND(actualcess,1)),FALSE);   anil
                            //EnterCell(row,17,FORMAT(ROUND(actualcess/2,1)),FALSE);
                            EnterCell(row, 20, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 21, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 22, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            user.RESET;
                            user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                            IF user.FIND('-') THEN
                                EnterCell(row, 23, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 24, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 25, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 27, dlPGC, FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 28, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 30, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 31, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 32, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 33, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 34, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                            /*EnterCell(row, 35, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*/
                            EnterCell(row, 35, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            Customer.RESET;
                            Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                            IF Customer.FINDFIRST THEN BEGIN
                                /*IF Customer."T.I.N. No." <> '' THEN
                                    EnterCell(row, 26, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE*/
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                            END
                            ELSE
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        IF edbQty > 0 THEN BEGIN
                            row := row + 1;
                            EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                            EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            IF COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) <> 'CI' THEN
                                EnterCell(row, 5, FORMAT(edbProdPosgroup), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 6, FORMAT(edbQty), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 7, FORMAT(taxtype), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(per), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 9, FORMAT(ROUND(edbvatamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 10, FORMAT(ROUND(edbcstamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 11, FORMAT(ROUND(edbAmtToCustomer, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 12, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 13, FORMAT(ROUND(edbassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 14, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 15, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 16, FORMAT(ROUND(edbassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 17, FORMAT(ROUND(edbExcise, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 18, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 19, FORMAT(ROUND(actualcess * 1 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            //EnterCell(row,16,FORMAT(ROUND(actualcess,1)),FALSE);   anil
                            //EnterCell(row,17,FORMAT(ROUND(actualcess/2,1)),FALSE);
                            //EnterCell(row, 20, FORMAT("Sales Invoice Header"."Form Code"), FALSE, TempExcelBuffer."Cell Type"::Text);//B2BUpg
                            EnterCell(row, 20, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 21, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 22, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            user.RESET;
                            user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                            IF user.FIND('-') THEN
                                EnterCell(row, 23, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 24, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 25, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 27, edbPGC, FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 28, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 30, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 31, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 32, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 33, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 34, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                            /*EnterCell(row, 35, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*/
                            EnterCell(row, 35, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            Customer.RESET;
                            Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                            IF Customer.FINDFIRST THEN BEGIN
                                /*IF Customer."T.I.N. No." <> '' THEN
                                    EnterCell(row, 26, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE*/
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                            END
                            ELSE
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        IF ledQty > 0 THEN BEGIN
                            row := row + 1;
                            EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                            EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            IF COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) <> 'CI' THEN
                                EnterCell(row, 5, FORMAT(ledProdPosgroup), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 6, FORMAT(ledQty), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 7, FORMAT(taxtype), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(per), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 9, FORMAT(ROUND(ledvatamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 10, FORMAT(ROUND(ledcstamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 11, FORMAT(ROUND(ledAmtToCustomer, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 12, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 13, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 14, FORMAT(ROUND(ledassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 15, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 16, FORMAT(ROUND(ledassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 17, FORMAT(ROUND(ledExcise, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 18, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 19, FORMAT(ROUND(actualcess * 1 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            //EnterCell(row,16,FORMAT(ROUND(actualcess,1)),FALSE);   anil
                            //EnterCell(row,17,FORMAT(ROUND(actualcess/2,1)),FALSE);
                            //EnterCell(row, 20, FORMAT("Sales Invoice Header"."Form Code"), FALSE, TempExcelBuffer."Cell Type"::Text);//B2BUpg
                            EnterCell(row, 20, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 21, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 22, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            user.RESET;
                            user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                            IF user.FIND('-') THEN
                                EnterCell(row, 23, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 24, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 25, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 27, ledPGC, FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 28, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 30, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 31, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 32, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 33, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 34, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);

                            /*EnterCell(row, 35, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*///B2BUpg
                            EnterCell(row, 35, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            Customer.RESET;
                            Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                            IF Customer.FINDFIRST THEN BEGIN
                                /*IF Customer."T.I.N. No." <> '' THEN
                                    EnterCell(row, 26, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE*/
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                            END
                            ELSE
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        IF sftQty > 0 THEN BEGIN
                            row := row + 1;
                            EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                            EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            IF COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) <> 'CI' THEN
                                EnterCell(row, 5, FORMAT(sftProdPosgroup), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 6, FORMAT(sftQty), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 7, FORMAT(taxtype), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(per), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 9, FORMAT(ROUND(sftvatamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 10, FORMAT(ROUND(sftcstamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 11, FORMAT(ROUND(sftAmtToCustomer, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 12, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 13, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 14, FORMAT(ROUND(0, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 15, FORMAT(ROUND(sftassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 16, FORMAT(ROUND(sftassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 17, FORMAT(ROUND(sftExcise, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 18, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 19, FORMAT(ROUND(actualcess * 1 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            //EnterCell(row,16,FORMAT(ROUND(actualcess,1)),FALSE);   anil
                            //EnterCell(row,17,FORMAT(ROUND(actualcess/2,1)),FALSE);
                            //EnterCell(row, 20, FORMAT("Sales Invoice Header"."Form Code"), FALSE, TempExcelBuffer."Cell Type"::Text);//B2BUpg
                            EnterCell(row, 20, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 21, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 22, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            user.RESET;
                            user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                            IF user.FIND('-') THEN
                                EnterCell(row, 23, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 24, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 25, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 27, sftPGC, FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 28, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 30, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 31, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 32, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 33, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 34, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                            /*EnterCell(row, 35, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*/
                            EnterCell(row, 35, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            Customer.RESET;
                            Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                            IF Customer.FINDFIRST THEN BEGIN
                                /*IF Customer."T.I.N. No." <> '' THEN
                                    EnterCell(row, 26, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE*/
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                            END
                            ELSE
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        IF (dlQty = 0) AND (edbQty = 0) AND (ledQty = 0) AND (sftQty = 0) AND (assessable > 0) THEN BEGIN
                            row := row + 1;
                            EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                            EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            IF COPYSTR("Sales Invoice Header"."External Document No.", 1, 2) <> 'CI' THEN
                                EnterCell(row, 5, FORMAT(ProdPosgroup), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 6, FORMAT(qty), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 7, FORMAT(taxtype), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(per), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 9, FORMAT(ROUND(vatamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 10, FORMAT(ROUND(cstamt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 11, FORMAT(ROUND("Sales Invoice Header"."Total Invoiced Amount", 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 12, FORMAT(ROUND(dlassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 13, FORMAT(ROUND(edbassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 14, FORMAT(ROUND(ledassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 15, FORMAT(ROUND(sftassessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 16, FORMAT(ROUND(assessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 17, FORMAT(ROUND(Excise, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 18, FORMAT(ROUND(actualcess * 2 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 19, FORMAT(ROUND(actualcess * 1 / 3, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                            //EnterCell(row,16,FORMAT(ROUND(actualcess,1)),FALSE);   anil
                            //EnterCell(row,17,FORMAT(ROUND(actualcess/2,1)),FALSE);
                            //EnterCell(row, 20, FORMAT("Sales Invoice Header"."Form Code"), FALSE, TempExcelBuffer."Cell Type"::Text);//B2BUpg
                            EnterCell(row, 20, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 21, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 22, FORMAT("Sales Invoice Header"."Customer Posting Group"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            user.RESET;
                            user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                            IF user.FIND('-') THEN
                                EnterCell(row, 23, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 24, FORMAT("Sales Invoice Header"."Sale Order Total Amount"), FALSE, TempExcelBuffer."Cell Type"::Number);
                            EnterCell(row, 25, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 27, PGC, FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 28, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 29, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 30, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 31, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 32, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 33, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 34, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                            /*EnterCell(row, 35, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*/
                            EnterCell(row, 35, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 36, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                            Customer.RESET;
                            Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                            IF Customer.FINDFIRST THEN BEGIN
                                /*IF Customer."T.I.N. No." <> '' THEN
                                    EnterCell(row, 26, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                                ELSE*/
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                            END
                            ELSE
                                EnterCell(row, 26, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        // END; // REV01 <<
                    END;
                END;
                //Rev01 code copied from //Sales Invoice Header, Body (4) - OnPostSection()


                //Rev01 code copied from //Sales Invoice Header, Body (5) - OnPostSection()
                IF serviceinv THEN BEGIN
                    IF "Sales Invoice Header"."Total Invoiced Amount" <> 0 THEN BEGIN
                        row := row + 1;
                        EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 2, FORMAT("Sales Invoice Header"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                        EnterCell(row, 3, FORMAT("Sales Invoice Header"."Sell-to Customer Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 4, FORMAT("Sales Invoice Header"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 5, FORMAT(ROUND(assessable, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 6, FORMAT(ROUND(service, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EVALUATE(tempdate, '31-05-2015');
                        IF ("Sales Invoice Header"."Posting Date" <= tempdate) THEN   // Condition added by pranavi on 02-jun-2016
                        BEGIN
                            EnterCell(row, 7, FORMAT(ROUND((service * 2 / 100), 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                            EnterCell(row, 8, FORMAT(ROUND((service * 1 / 100), 1)), FALSE, TempExcelBuffer."Cell Type"::Text);
                        END;
                        IF SBCessAmt > 0 THEN
                            EnterCell(row, 9, FORMAT(ROUND(SBCessAmt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                        IF KKCessAmt > 0 THEN
                            EnterCell(row, 10, FORMAT(ROUND(KKCessAmt, 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 11, FORMAT(ROUND("Sales Invoice Header"."Total Invoiced Amount", 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 12, FORMAT(typeofservice), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 13, FORMAT(instamt), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 14, FORMAT(softamt), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 15, FORMAT(servamt), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 16, FORMAT("Sales Invoice Header"."Order No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 17, FORMAT("Sales Invoice Header"."Customer OrderNo."), FALSE, TempExcelBuffer."Cell Type"::Text);
                        // $Pranavi Start
                        EnterCell(row, 19, FORMAT(qty), FALSE, TempExcelBuffer."Cell Type"::Number);
                        EnterCell(row, 21, FORMAT(SIL."Unit of Measure"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 22, FORMAT("Sales Invoice Header"."Ship-to Name"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 23, FORMAT("Sales Invoice Header"."Ship-to Address"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 24, FORMAT("Sales Invoice Header"."Ship-to Address 2"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 25, FORMAT("Sales Invoice Header"."Ship-to City"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 26, FORMAT("Sales Invoice Header"."Call letters Status"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 27, FORMAT("Sales Invoice Header".Vertical), FALSE, TempExcelBuffer."Cell Type"::Text);
                        /*EnterCell(row, 27, FORMAT(EInvoiceEntry."Ack No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 29, FORMAT(EInvoiceEntry."IRN Cancelled"), FALSE, TempExcelBuffer."Cell Type"::Text);*/
                        EnterCell(row, 27, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                        EnterCell(row, 29, FORMAT(''), FALSE, TempExcelBuffer."Cell Type"::Text);
                        user.RESET;
                        user.SETFILTER(user.EmployeeID, "Sales Invoice Header"."Salesperson Code");
                        IF user.FIND('-') THEN
                            EnterCell(row, 20, FORMAT(user."User ID"), FALSE, TempExcelBuffer."Cell Type"::Text);
                        // $Pranavi End
                        Customer.RESET;
                        Customer.SETFILTER(Customer."No.", "Sales Invoice Header"."Sell-to Customer No.");
                        IF Customer.FINDFIRST THEN BEGIN
                            /*IF Customer."T.I.N. No." <> '' THEN
                                EnterCell(row, 18, Customer."T.I.N. No.", FALSE, TempExcelBuffer."Cell Type"::Text)
                            ELSE*/
                            EnterCell(row, 18, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                        END
                        ELSE
                            EnterCell(row, 18, '11111111111', FALSE, TempExcelBuffer."Cell Type"::Text);
                    END;
                END;
                //Rev01 code copied from //Sales Invoice Header, Body (5) - OnPostSection()

            end;

            trigger OnPreDataItem()
            begin

                IF GLAdmin THEN
                    CurrReport.BREAK;

                //Rev01 Code copied from //Sales Invoice Header, Header (1) - OnPostSection()
                datefilter := "Sales Invoice Header".GETFILTER("Sales Invoice Header"."Posting Date");
                GSTDate := DMY2DATE(1, 7, 2017);
                FilterDate := "Sales Invoice Header".GETRANGEMIN("Sales Invoice Header"."Posting Date");
                //Rev01 code copied from //Sales Invoice Header, Header (1) - OnPostSection()
                totcstamt := 0;
                totvatamt := 0;

                str := 'IN';
                str1 := 'SI';


                IF Excel THEN BEGIN
                    TempExcelBuffer.DELETEALL;
                    CLEAR(TempExcelBuffer);
                    row := 0;

                    IF serviceinv = FALSE THEN BEGIN
                        row += 1;
                        IF FilterDate >= GSTDate THEN BEGIN
                            EnterHeadings(row, 1, 'S. No', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 2, 'POSTING DATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 3, 'PARTICULARS', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 4, 'ACTUAL INVOICE NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 5, 'HSN/SAC Code', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 6, 'QTY', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 7, 'JURISDICTION TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 8, 'IGST RATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 9, 'CGST RATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 10, 'SGST RATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 11, 'SGST', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 12, 'CGST', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 13, 'IGST', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 14, 'BILL AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 15, 'DATALOGGER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 16, 'DISPLAY BOARD', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 17, 'LED', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 18, 'X-RAY VIEWER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 19, 'OTHER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 20, 'NET ASSESSABLE VALUE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 21, 'CESS', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 22, 'ORDER NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 23, 'CUSTOMER TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 24, 'SALES EXECUTIVE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 25, 'SALE ORDER TOTAL AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 26, 'CUSTOMER ORDER NUMBER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 27, 'GSTIN NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 28, 'PROD TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 29, 'GST REG. TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 30, 'HSN DESCRIPTION', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 31, 'STATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 32, 'INVOICE NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 33, 'UOM', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 34, 'EXPORT TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 35, 'SHIPPING DATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 36, 'SHIPPING BILL NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 37, 'PORT CODE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 38, 'PARTY LEDGER NAME', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 39, 'NARRATION', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 40, 'SALES LEDGER NAME', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 41, 'LEDGER NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 42, 'GOODS/SERVICE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 43, 'DIMENSION', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 44, 'PAN', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 45, 'TCS Rate', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 46, 'TCS Amount', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 47, 'Ship To Name', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 48, 'Ship To Address', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 49, 'Ship To Address2', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 50, 'Ship To City', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 51, 'Call Letter Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 52, 'VERTICAL', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 53, 'IRN Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 54, 'IRN Cancelled', TRUE, TempExcelBuffer."Cell Type"::Text);
                        END ELSE BEGIN

                            "Sales Invoice Header".SETFILTER("Sales Invoice Header"."External Document No.", '%1|(%2..%3)|(%4..%5)', 'CI*', '0', '999',
                                                                                                        'L00000', 'L99999');
                            EnterHeadings(row, 1, 'S. No', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 2, 'POSTING DATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 3, 'PARTICULARS', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 4, 'INVOICE NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 5, 'PRODUCT', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 6, 'QTY', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 7, 'ST', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 8, 'RATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 9, 'VAT COLLCTED', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 10, 'CST COLLECTED', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 11, 'BILL AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 12, 'DATALOGGER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 13, 'DISPLAY BOARD', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 14, 'LED', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 15, 'X-RAY VIEWER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 16, 'NET ASSESSABLE VALUE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 17, 'EXCISE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 18, 'CESS2%', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 19, 'CESS1%', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 20, 'FORM C', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 21, 'ORDER NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 22, 'CUSTOMER TYPE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 23, 'SALES EXECUTIVE', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 24, 'SALE ORDER TOTAL AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 25, 'CUSTOMER ORDER NUMBER', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 26, 'TIN NO', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 27, 'Prod Type', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 28, 'UOM', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 29, 'Ship To Name', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 30, 'Ship To Address', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 31, 'Ship To Address2', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 32, 'Ship To City', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 33, 'Call Letter Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 34, 'VERTICAL', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 35, 'IRN Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                            EnterHeadings(row, 36, 'IRN Cancelled', TRUE, TempExcelBuffer."Cell Type"::Text);
                        END;
                    END ELSE BEGIN
                        "Sales Invoice Header".SETFILTER("Sales Invoice Header"."External Document No.", '%1|%2', 'IN*', 'SI*');
                        row += 1;
                        EnterHeadings(row, 1, 'S.NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 2, 'POSTING DATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 3, 'PARTICULARS', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 4, 'INVOICE NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 5, 'NET ASSESSABLE VALUE', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 6, 'SERVICE TAX', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 7, 'CESS 2%', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 8, 'CESS 1%', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 9, 'SBCESS 0.5%', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 10, 'KKCESS 0.5%', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 11, 'BILL AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 12, 'TYPE OF SERVICE', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 13, 'INST.AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 14, 'SOFT.AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 15, 'SERVICE', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 16, 'ORDER NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 17, 'CUSTOMER ORDER NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 18, 'TIN NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                        // Pranavi Start
                        EnterHeadings(row, 19, 'QUANTITY', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 20, 'SALES EXECUTIVE', TRUE, TempExcelBuffer."Cell Type"::Text);
                        // Pranavi End
                        EnterHeadings(row, 21, 'UOM', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 22, 'Ship To Name', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 23, 'Ship To Address', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 24, 'Ship To Address2', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 25, 'Ship To City', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 26, 'Call Letter Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 27, 'VERTICAL', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 28, 'IRN Status', TRUE, TempExcelBuffer."Cell Type"::Text);
                        EnterHeadings(row, 29, 'IRN Cancelled', TRUE, TempExcelBuffer."Cell Type"::Text);
                    END;
                END;
            end;
        }
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "G/L Account No.", "Posting Date", "Global Dimension 1 Code";
            column(GL_AcntNo; "G/L Entry"."G/L Account No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF Excel AND GLAdmin THEN BEGIN
                    row += 1;
                    EnterCell(row, 1, FORMAT(row - 1), FALSE, TempExcelBuffer."Cell Type"::Number);
                    EnterCell(row, 2, FORMAT("G/L Entry"."G/L Account No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                    IF GLAct.GET("G/L Entry"."G/L Account No.") THEN
                        EnterCell(row, 3, FORMAT(GLAct.Name), FALSE, TempExcelBuffer."Cell Type"::Text);
                    EnterCell(row, 4, FORMAT("G/L Entry"."Posting Date"), FALSE, TempExcelBuffer."Cell Type"::Date);
                    EnterCell(row, 5, FORMAT("G/L Entry"."Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                    EnterCell(row, 6, FORMAT("G/L Entry".Description), FALSE, TempExcelBuffer."Cell Type"::Text);
                    EnterCell(row, 7, FORMAT("G/L Entry"."External Document No."), FALSE, TempExcelBuffer."Cell Type"::Text);
                    EnterCell(row, 8, FORMAT("G/L Entry".Amount), FALSE, TempExcelBuffer."Cell Type"::Number);
                    EnterCell(row, 9, FORMAT(ROUND(ABS("G/L Entry"."Credit Amount"), 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                    EnterCell(row, 10, FORMAT(ROUND(ABS("G/L Entry"."Debit Amount"), 1)), FALSE, TempExcelBuffer."Cell Type"::Number);
                END;
            end;

            trigger OnPreDataItem()
            begin

                IF NOT GLAdmin THEN
                    CurrReport.BREAK;

                IF "G/L Entry".GETFILTER("G/L Entry"."Posting Date") IN ['0D', ''] THEN
                    ERROR('Please enter Posting Date in G/L Entry Tab!');
                IF "G/L Entry".GETFILTER("G/L Entry"."G/L Account No.") IN [''] THEN
                    ERROR('Please enter G/L Account No. in G/L Entry Tab!');

                IF Excel THEN BEGIN
                    TempExcelBuffer.DELETEALL;
                    CLEAR(TempExcelBuffer);
                    row := 0;

                    row += 1;

                    EnterHeadings(row, 1, 'S NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 2, 'G/L ACCOUNT NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 3, 'G/L ACCOUNT NAME', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 4, 'POSTING DATE', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 5, 'DOCUMENT NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 6, 'DESCRIPTION', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 7, 'EXT. DOC NO.', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 8, 'AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 9, 'CREDIT AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                    EnterHeadings(row, 10, 'DEBIT AMOUNT', TRUE, TempExcelBuffer."Cell Type"::Text);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(serviceinv; serviceinv)
                    {
                        Caption = 'Service invoices';
                        ApplicationArea = All;
                    }
                    field(normal; normal)
                    {
                        Caption = 'Excise/Commercial invoices';
                        ApplicationArea = All;
                    }
                    field(GLAdmin; GLAdmin)
                    {
                        Caption = 'GL Admin Input';
                        ApplicationArea = All;
                    }
                    field(Excel; Excel)
                    {
                        Caption = 'Excel';
                        ApplicationArea = All;
                    }
                    label("Note :  1. If you Want Only Service Bills With Excel Please Check Service Invoices & Excel")
                    {
                        Caption = 'Note :  1. If you Want Only Service Bills With Excel Please Check Service Invoices & Excel';
                        Style = Strong;
                        StyleExpr = TRUE;
                        ApplicationArea = All;
                    }
                    label(Control1102152006)
                    {
                        Caption = '2. If you want only Excise & Commercial Bills in to Excel Please Check Excise/Commercial Invoices with Excel Check Mark';
                        Style = Strong;
                        StyleExpr = TRUE;
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
        Excel := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF Excel THEN BEGIN
            /*
            TempExcelBuffer.CreateBook('Sales Invoices',''); //EFFUPG
            TempExcelBuffer.WriteSheet('Sales Invoices',COMPANYNAME,USERID);
            TempExcelBuffer.CloseBook;
            TempExcelBuffer.OpenExcel;
            TempExcelBuffer.GiveUserControl;
            */
            IF GLAdmin THEN
                TempExcelBuffer.CreateBookAndOpenExcel('', 'GL Input', 'GL Input', COMPANYNAME, USERID) //EFFUPG
            ELSE
                TempExcelBuffer.CreateBookAndOpenExcel('', 'Sales Invoices', 'Sales Invoices', COMPANYNAME, USERID); //EFFUPG
        END

    end;

    var
        SIL: Record "Sales Invoice Line";
        ProdPosgroup: Text[30];
        qty: Decimal;
        taxtype: Text[10];
        per: Text[10];
        dlassessable: Decimal;
        edbassessable: Decimal;
        sftassessable: Decimal;
        assessable: Decimal;
        Excise: Decimal;
        cess: Decimal;
        shecess: Decimal;
        actualcess: Decimal;
        cstamt: Decimal;
        vatamt: Decimal;
        vatper: Text[10];
        cstper: Text[10];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        row: Integer;
        Excel: Boolean;
        datefilter: Text[30];
        totdlassessable: Decimal;
        totedbassessable: Decimal;
        totsftassessable: Decimal;
        totassessable: Decimal;
        totExcise: Decimal;
        totactualcess: Decimal;
        totcstamt: Decimal;
        totvatamt: Decimal;
        totamt: Decimal;
        service: Decimal;
        serviceecess: Decimal;
        totalservice: Decimal;
        totalservicecess: Decimal;
        str: Text[5];
        str1: Text[3];
        pos: Integer;
        pos1: Integer;
        typeofservice: Text[30];
        serviceinv: Boolean;
        normal: Boolean;
        softamt: Decimal;
        instamt: Decimal;
        user: Record "User Setup";
        servamt: Decimal;
        ledassessable: Decimal;
        totledassessable: Decimal;
        PGC: Text[100];
        Item: Record Item;
        Sale_Invoices_Between_the_Period_ofCaptionLbl: Label 'Sale Invoices Between the Period of';
        Invoiced_DateCaptionLbl: Label 'Invoiced Date';
        Customer_NameCaptionLbl: Label 'Customer Name';
        Invoice_NoCaptionLbl: Label 'Invoice No';
        Product_typeCaptionLbl: Label 'Product type';
        Tax_TypeCaptionLbl: Label 'Tax Type';
        PercentageCaptionLbl: Label 'Percentage';
        VAT_AmountCaptionLbl: Label 'VAT Amount';
        CST_AmountCaptionLbl: Label 'CST Amount';
        Invoiced_AmountCaptionLbl: Label 'Invoiced Amount';
        DATA_LOGGERCaptionLbl: Label 'DATA LOGGER';
        EDBCaptionLbl: Label 'EDB';
        QtyCaptionLbl: Label 'Qty';
        SoftwareCaptionLbl: Label 'Software';
        AssessableCaptionLbl: Label 'Assessable';
        ExciseCaptionLbl: Label 'Excise';
        Cess__2__CaptionLbl: Label 'Cess (2%)';
        Cess__1__CaptionLbl: Label 'Cess (1%)';
        FORM___CCaptionLbl: Label 'FORM - C';
        Invoiced_DateCaption_Control1102154132Lbl: Label 'Invoiced Date';
        Customer_NameCaption_Control1102154133Lbl: Label 'Customer Name';
        Invoice_NoCaption_Control1102154134Lbl: Label 'Invoice No';
        Invoiced_AmountCaption_Control1102154140Lbl: Label 'Invoiced Amount';
        AssessableCaption_Control1102154145Lbl: Label 'Assessable';
        Service_TaxCaptionLbl: Label 'Service Tax';
        Cess__2__Caption_Control1102154147Lbl: Label 'Cess (2%)';
        Cess__1__Caption_Control1102154148Lbl: Label 'Cess (1%)';
        Type_of_ServiceCaptionLbl: Label 'Type of Service';
        TotalsCaptionLbl: Label 'Totals';
        TotalsCaption_Control1102154183Lbl: Label 'Totals';
        SSH: Record "Sales Shipment Header";
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        VLE: Record "Value Entry";
        Customer: Record Customer;
        tempdate: Date;
        SBCessAmt: Decimal;
        KKCessAmt: Decimal;
        dlQty: Decimal;
        edbQty: Decimal;
        sftQty: Decimal;
        ledQty: Decimal;
        dlcstamt: Decimal;
        edbcstamt: Decimal;
        ledcstamt: Decimal;
        sftcstamt: Decimal;
        dlvatamt: Decimal;
        edbvatamt: Decimal;
        ledvatamt: Decimal;
        sftvatamt: Decimal;
        dlExcise: Decimal;
        edbExcise: Decimal;
        ledExcise: Decimal;
        sftExcise: Decimal;
        dlPGC: Text[100];
        edbPGC: Text[100];
        ledPGC: Text[100];
        sftPGC: Text[100];
        dlProdPosgroup: Text[30];
        edbProdPosgroup: Text[30];
        ledProdPosgroup: Text[30];
        sftProdPosgroup: Text[30];
        dlAmtToCustomer: Decimal;
        edbAmtToCustomer: Decimal;
        ledAmtToCustomer: Decimal;
        sftAmtToCustomer: Decimal;
        GSTDate: Date;
        CurrHSN: Code[10];
        SIL1: Record "Sales Invoice Line";
        sgst_amt: Decimal;
        cgst_amt: Decimal;
        igst_amt: Decimal;
        tot_amt_cust: Decimal;
        tot_gst_Assessible_amt: Decimal;
        gst_qty: Decimal;
        FilterDate: Date;
        HSNSACTABLE: Record "HSN/SAC";
        StateGRec: Record State;
        GLAccnt: Record "G/L Account";
        GLAdmin: Boolean;
        GLAct: Record "G/L Account";
        PostingSetup: Record "General Posting Setup";
        PAN: Text;
        TCS_Amount: Decimal;
        TCS_Rate: Decimal;
        //EInvoiceEntry: Record "E-Invoice Entry";//B2BUpg
        IGSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        CessAmt: Decimal;
        TCSAmt: Decimal;
        GroupCode: Code[10];


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; CellType: Option)
    begin
        IF Excel THEN BEGIN
            TempExcelBuffer.INIT;
            TempExcelBuffer.VALIDATE("Row No.", RowNo);
            TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
            TempExcelBuffer."Cell Value as Text" := CellValue;
            TempExcelBuffer.Bold := Bold;
            TempExcelBuffer."Cell Type" := CellType;
            TempExcelBuffer.INSERT;
        END;
    end;

    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; CellType: Option)
    begin
        IF Excel THEN BEGIN
            TempExcelBuffer.INIT;
            TempExcelBuffer.VALIDATE("Row No.", RowNo);
            TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
            TempExcelBuffer."Cell Value as Text" := FORMAT(CellValue);
            TempExcelBuffer.Bold := Bold;
            TempExcelBuffer.Formula := '';
            TempExcelBuffer."Cell Type" := CellType;
            TempExcelBuffer.INSERT;
        END;
    end;

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
            exit(DetailedGSTLedgerEntry."GST Amount");

        end;
    end;

    local procedure GetTCSAmt(SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
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

