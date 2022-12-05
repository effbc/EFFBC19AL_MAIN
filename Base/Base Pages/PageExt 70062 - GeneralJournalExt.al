pageextension 70062 GeneralJournalExt extends "General Journal"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        modify("Posting Date")
        {
            //StyleExpr = BPV_CF_Color;
            Style = StrongAccent;
        }
        modify("Document No.")
        {
            Style = StrongAccent;
            //StyleExpr = BPV_CF_Color;
        }
        /*modify(Description)
        {
            //StyleExpr = BPV_CF_Color;
            Style = StrongAccent;
        }
        modify(Control30)
        {
            ShowCaption = false;
        }
        modify(Control1901776101)
        {
            ShowCaption = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify(BankChrgAmt)
        {
            Visible = false;
        }*/
        modify("External Document No.")
        {
            trigger OnBeforeValidate()
            begin
                External_doc_no_chk;// added by sujani on 11-Mar-19 for duplicate entries restriction for FTT Payments
            end;
        }
        modify("Account Type")
        {
            trigger OnBeforeValidate()
            begin
                IF (NOT (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV', 'BRV', 'CON'])) AND (Rec."Account Type" = Rec."Account Type"::"Bank Account") THEN
                    ERROR('In Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Bank Account should not be Selected!');
            end;
        }
        modify("Account No.")
        {
            trigger OnBeforeValidate()
            var
                GenJnlManagement: Codeunit GenJnlManagement;
            begin
                IF Rec."Account No." <> '' THEN BEGIN
                    IF (Rec."Journal Batch Name" = 'CONTRA') AND (Rec."Account Type" = Rec."Account Type"::"G/L Account") AND (NOT (Rec."Account No." IN ['22100', '22101', '22102'])) THEN
                        ERROR('In Batch Code ' + Rec."Journal Batch Name" + ' Should not select GL Account except Cash Accounts 22100,22101,22102!');

                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV', 'BRV', 'JV-']) AND (Rec."Account Type" = Rec."Account Type"::"G/L Account")
                        AND (Rec."Account No." IN ['22100', '22101', '22102']) THEN
                        ERROR('In Batch Code ' + Rec."Journal Batch Name" + ' Should not select Cash Accounts 22100,22101,22102!');

                    // added by pranavi on 22-oct-2016 for updating tender no. from sale order
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 2) = 'JV') AND (Rec."Account No." = '25500') AND (Rec."Sale Order No" <> '') THEN BEGIN
                        SH.RESET;
                        SH.SETRANGE(SH."No.", Rec."Sale Order No");
                        SH.SETFILTER(SH."Tender No.", '<>%1', '');
                        IF SH.FINDFIRST THEN BEGIN
                            Rec."Tender No" := SH."Tender No.";
                            Rec.MODIFY;
                        END ELSE BEGIN
                            SIH.RESET;
                            SIH.SETRANGE(SIH."Order No.", Rec."Sale Order No");
                            SIH.SETFILTER(SIH."Tender No.", '<>%1', '');
                            IF SIH.FINDFIRST THEN BEGIN
                                Rec."Tender No" := SIH."Tender No.";
                                Rec.MODIFY;
                            END;
                        END;
                    END;
                    // end by pranavi
                END;
                GenJnlManagement.GetAccounts(Rec, AccName, BalAccName);
                Rec.ShowShortcutDimCode(ShortcutDimCode);
                SetUserInteractions;
                CurrPage.UPDATE;
            end;
        }
        modify(Description)
        {
            trigger OnBeforeValidate()
            begin
                DescriptionOnAfterValidate;
            end;
        }
        modify("Debit Amount")
        {
            trigger OnBeforeValidate()
            begin
                IF Rec."Debit Amount" > 0 THEN BEGIN
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV']) AND (Rec."Account Type" = Rec."Account Type"::"Bank Account") THEN
                        ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Bank Account must be Credited!');
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['CRV']) AND (Rec."Account Type" = Rec."Account Type"::"G/L Account") THEN
                        IF NOT (Rec."Account No." IN ['22100', '22101', '22102']) THEN
                            ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Only Cash Account must be Debited!');
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['CPV']) AND (Rec."Account Type" = Rec."Account Type"::"G/L Account")
                       AND (Rec."Account No." IN ['22100', '22101', '22102']) THEN
                        ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Only Cash Account must be Credited!');
                END;
            end;
        }
        modify("Credit Amount")
        {
            trigger OnBeforeValidate()
            begin
                IF Rec."Credit Amount" > 0 THEN BEGIN
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BRV']) AND (Rec."Account Type" = Rec."Account Type"::"Bank Account") THEN
                        ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Bank Account must be in Debited!');
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['CPV']) AND (Rec."Account Type" = Rec."Account Type"::"G/L Account") THEN
                        IF NOT (Rec."Account No." IN ['22100', '22101', '22102']) THEN
                            ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Only Cash Account must be Credited!');
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['CRV']) AND (Rec."Account Type" = Rec."Account Type"::"G/L Account")
                      AND (Rec."Account No." IN ['22100', '22101', '22102']) THEN
                        ERROR('For Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Cash Account must be Debited!');
                END;
            end;
        }
        addafter("Posting Date")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = All;
            }
            field("Dimension Set ID"; Rec."Dimension Set ID")
            {
                ApplicationArea = All;
            }
            field("Apply Entry No"; Rec."Apply Entry No")
            {
                ApplicationArea = All;
            }
            field("<Apply Entry No>"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("Bal. VAT Calculation Type"; Rec."Bal. VAT Calculation Type")
            {
                ApplicationArea = All;
            }
            field("VAT Calculation Type"; Rec."VAT Calculation Type")
            {
                ApplicationArea = All;
            }
            field("From Date"; Rec."From Date")
            {
                ApplicationArea = All;
            }
            field("Prod. Order No."; Rec."Prod. Order No.")
            {
                Editable = true;
                LookupPageID = "Production Order List";
                ApplicationArea = All;
            }
            field("Final Bill Payment"; Rec."Final Bill Payment")
            {
                ApplicationArea = All;
            }
            field("Sale Order No"; Rec."Sale Order No")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    Salinv.RESET;// Rev01
                    IF Rec."Account Type" = Rec."Account Type"::Customer THEN
                        Salinv.SETRANGE("Sell-to Customer No.", Rec."Account No.");// Rev01
                    IF PAGE.RUNMODAL(60219, Salinv) = ACTION::LookupOK THEN BEGIN
                        Rec."Sale Order No" := Salinv."No.";
                        // MODIFY;
                    END;
                end;

                trigger OnValidate();
                begin
                    // added by pranavi on 22-oct-2016 for updating tender no. from sale order
                    IF (COPYSTR(Rec."Journal Batch Name", 1, 2) = 'JV') AND (Rec."Account No." = '25500') AND (Rec."Sale Order No" <> '') THEN BEGIN
                        SH.RESET;
                        SH.SETRANGE(SH."No.", Rec."Sale Order No");
                        SH.SETFILTER(SH."Tender No.", '<>%1', '');
                        IF SH.FINDFIRST THEN BEGIN
                            Rec."Tender No" := SH."Tender No.";
                            Rec.MODIFY;
                        END ELSE BEGIN
                            SIH.RESET;
                            SIH.SETRANGE(SIH."Order No.", Rec."Sale Order No");
                            SIH.SETFILTER(SIH."Tender No.", '<>%1', '');
                            IF SIH.FINDFIRST THEN BEGIN
                                Rec."Tender No" := SIH."Tender No.";
                                Rec.MODIFY;
                            END;
                        END;
                    END;
                    // end by pranavi
                end;
            }
            field("Tender No"; Rec."Tender No")
            {
                ApplicationArea = All;
            }
            field("Old Order"; Rec."Old Order")
            {
                ApplicationArea = All;
            }
            field("VAT Posting"; Rec."VAT Posting")
            {
                ApplicationArea = All;
            }
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                ApplicationArea = All;
            }

            /* field("BED Calculation Type"; "BED Calculation Type")
             {
                 ApplicationArea = All;
             }*/
            field("To Date"; Rec."To Date")
            {
                ApplicationArea = All;
            }
            /*field("Cheque No."; "Cheque No.")
            {
                ApplicationArea = All;
            }
           
            field("Cheque Date"; "Cheque Date")
            {
                ApplicationArea = All;
            }
             */
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = All;
            }
            field("Validate Posting"; Rec."Validate Posting")
            {
                ApplicationArea = All;
            }
            field("Invoice no"; Rec."Invoice no")
            {
                ApplicationArea = All;
            }
            field("Customer Ord no"; Rec."Customer Ord no")
            {
                ApplicationArea = All;
            }
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    IF COPYSTR("Journal Batch Name", 1, 3) IN ['BPV', 'CPV'] THEN BEGIN //CurrentJnlBatchName //EFFUPG
                        IF UPPERCASE(FORMAT(Rec."Payment Type")) <> 'PAYMENT' THEN
                            ERROR('payment type must be Payment');
                    END
                    ELSE
                        IF COPYSTR("Journal Batch Name", 1, 3) IN ['BRV', 'CRV'] THEN BEGIN//CurrentJnlBatchName //EFFUPG
                            IF UPPERCASE(FORMAT(Rec."Payment Type")) <> 'RECEIPT' THEN
                                ERROR('payment type must be Receipt');
                        END
                        ELSE
                            IF COPYSTR("Journal Batch Name", 1, 2) IN ['JV'] THEN BEGIN//CurrentJnlBatchName //EFFUPG
                                IF UPPERCASE(FORMAT(Rec."Payment Type")) <> 'JOURNAL' THEN
                                    ERROR('payment type must be Journal');
                            END;
                end;
            }
        }
        addafter("Currency Code")
        {
            field("Currency Rate"; Rec."Currency Rate")
            {
                ApplicationArea = All;
            }
            field("Currency Amount"; Rec."Currency Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("Bill-to/Pay-to No.")
        {
            field("DD/FDR No."; Rec."DD/FDR No.")
            {
                ApplicationArea = All;
            }
            field("Payment Through"; Rec."Payment Through")
            {
                ApplicationArea = All;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            /*field("Service Tax eCess Amount"; "Service Tax eCess Amount")
            {
                ApplicationArea = All;
            }
            field("Service Tax Amount"; "Service Tax Amount")
            {
                ApplicationArea = All;
            }*/
            field(Printed; Rec.Printed)
            {
                ApplicationArea = All;
            }
            /* field("Deferral Code"; "Deferral Code")
            {
                CaptionML = ENU = '"Deferral Code"',
                            ENN = 'Deferral Code';
                ApplicationArea = All;
            } */
            field("Deferral Line No."; Rec."Deferral Line No.")
            {
                ApplicationArea = All;
            }
            //B2BUPG
            /*  field("TDS/TCS Amt Incl Surcharge"; "TDS/TCS Amt Incl Surcharge")
               {
                   ApplicationArea = All;
               }
               field("Bal. TDS/TCS Including SHECESS"; "Bal. TDS/TCS Including SHECESS")
               {
                   ApplicationArea = All;
               }
               field("TDS Category"; "TDS Category")
               {
                   ApplicationArea = All;
               }
               field("Concessional Code"; "Concessional Code")
               {
                   ApplicationArea = All;
               }*/
            field("Pay TDS"; Rec."Pay TDS")
            {
                ApplicationArea = All;
            }
            /* field("TDS Entry"; "TDS Entry")
             {
                 ApplicationArea = All;
             }

            field("TDS/TCS Base Amount"; "TDS/TCS Base Amount")
             {
                 ApplicationArea = All;
             }
             field("Balance Surcharge Amount"; "Balance Surcharge Amount")
             {
                 ApplicationArea = All;
             }
             field("Surcharge Base Amount"; "Surcharge Base Amount")
             {
                 ApplicationArea = All;
             }
             field("TDS Group"; "TDS Group")
             {
                 ApplicationArea = All;
             }
             field("TDS From Orders"; "TDS From Orders")
             {
                 ApplicationArea = All;
             }
             field("TDS Line Amount"; "TDS Line Amount")
             {
                 ApplicationArea = All;
             }
             field("TDS/TCS Base Amount Applied"; "TDS/TCS Base Amount Applied")
             {
                 ApplicationArea = All;
             }
             field("TDS/TCS Base Amount Adjusted"; "TDS/TCS Base Amount Adjusted")
             {
                 ApplicationArea = All;
             }*/
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
            field(Vertical; Rec.Vertical)
            {
                ApplicationArea = All;
            }
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = All;
            }
            field("Product Group Code Cust"; Rec."Product Group Code Cust")
            {
                ApplicationArea = All;
            }
        }
        addafter("Total Balance")
        {
            group("Work Date")
            {
                Caption = 'Work Date';
                field(WorkDate; WORKDATE)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Control1102152022)
            {
                ShowCaption = false;
                field(Printed_Color; Printed_Color)
                {
                    Editable = false;
                    Style = StrongAccent;
                    StyleExpr = BPV_CF_Color;
                    ApplicationArea = All;
                }
            }
            /* field(BankChrgAmt; BankChrgAmt)
             {
                 CaptionML = ENU = 'Bank Charge Amount',
                             ENN = 'Bank Charge Amount';
                 Editable = false;
                 ApplicationArea = All;
             }*/
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        /*  modify("Calculate GST")
          {
              Promoted = true;
              PromotedIsBig = true;
          }
          modify("Update Reference Invoice No")
          {
              Promoted = true;
          }*/
        modify(GetStandardJournals)
        {
            Promoted = true;
        }
        modify(SaveAsStandardJournal)
        {
            Promoted = true;
        }
        modify("Test Report")
        {
            Promoted = true;
            PromotedCategory = Process;
            trigger OnAfterAction()
            begin
                // Added by Pranavi on 18-Mar-2017
                IF (Rec."Journal Template Name" = 'GENERAL') AND (Rec."Journal Batch Name" = 'BPV_CF') THEN BEGIN
                    Jrnl_Line.RESET;
                    Jrnl_Line.SETRANGE(Jrnl_Line."Journal Template Name", Rec."Journal Template Name");
                    Jrnl_Line.SETRANGE(Jrnl_Line."Journal Batch Name", Rec."Journal Batch Name");
                    Jrnl_Line.SETRANGE(Jrnl_Line."Document No.", Rec."Document No.");
                    IF Jrnl_Line.FINDSET THEN
                        Jrnl_Line.MODIFYALL(Jrnl_Line.Printed, TRUE);
                END;
                // Added by Pranavi on 18-Mar-2017
            end;
        }
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            var
                JGE: Record "Gen. Journal Line";
                PrevDoc: Code[30];
                DocumentNo: Text;
                GLA: Record "G/L Account";
                ErrorText: Text;
                Us: Record User;
                Pstdt: Date;
            begin
                Us.RESET;
                Us.SETFILTER("User Name", USERID);
                IF Us.FINDFIRST THEN
                    Pstdt := 20220331D;
                //IF (NOT (Us."User Name" IN ['EFFTRONICS\VHARIPRASAD', 'ERPSERVER\ADMINISTRATOR']) AND NOT (Us.Tams_Dept IN ['ERP'])) THEN
                    IF Rec."Posting Date" <= Pstdt THEN
                        ERROR('Posting Date is not in allowed range.');
                //HDFC_Construction_restirct;//added by sujani for HDFC Payments restriction for construction related 14-mar-19
                External_doc_no_chk;// added by sujani for foerign payment duplicate entries restriction


                /* Genjournal.SETRANGE(Genjournal."Journal Batch Name","Journal Batch Name");
                Genjournal.SETRANGE(Genjournal."Posting Date",WORKDATE);
                IF Genjournal.FINDSET THEN
                REPEAT
                  JournalLineDimension.RESET;
                  JournalLineDimension.SETRANGE(JournalLineDimension."Table ID",81);
                  JournalLineDimension.SETRANGE(JournalLineDimension."Journal Template Name",Genjournal."Journal Template Name");
                  JournalLineDimension.SETRANGE(JournalLineDimension."Journal Batch Name",Genjournal."Journal Batch Name");
                  JournalLineDimension.SETRANGE(JournalLineDimension."Journal Line No.",Genjournal."Line No.");
                  JournalLineDimension.SETRANGE(JournalLineDimension."Dimension Code",'EMPLOYEE CODES');
                  IF JournalLineDimension.FINDFIRST THEN
                  BEGIN
                    IF (Genjournal."Account No."='24000') AND USER.GET('EMPLOYEE CODES',JournalLineDimension."Dimension Value Code")  THEN
                    BEGIN
                      IF ISCLEAR(SQLConnection) THEN
                         CREATE(SQLConnection);
                      IF ISCLEAR(RecordSet) THEN
                         CREATE(RecordSet);
                      WebRecStatus := Quotes+Text50001+Quotes;
                      OldWebStatus := Quotes+Text50002+Quotes;
                      GLSetup.GET;

                      SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80';
                      SQLConnection.Open;
                      SQLConnection.BeginTrans;
                      SQLQuery:='Select to_char(Count(*)) CNT  from TRAVELLING_ADVANCES';
                      SQLConnection.Execute(SQLQuery);
                      RecordSet := SQLConnection.Execute(SQLQuery);
                      IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN
                        RecordSet.MoveFirst;
                      EVALUATE(RCNT,FORMAT(RecordSet.Fields.Item('CNT').Value));
                      SQLQuery:='Insert into Travelling_Advances values ('+FORMAT(RCNT+1)+','''+'ADVANCES'+''','''+'24000'+''',''';
                      SQLQuery+=Genjournal."Shortcut Dimension 1 Code"+''','''+JournalLineDimension."Dimension Value Code"+''',''';
                      SQLQuery+= FORMAT(Genjournal."Posting Date",0,'<Day>-<Month Text,3>-<Year4>')+''',';
                      SQLQuery+=CommaRemoval(FORMAT(ROUND(Genjournal.Amount,0.01)))+',';
                      SQLQuery+=CommaRemoval(FORMAT(ROUND(Genjournal."Debit Amount",0.01)))+',';
                      SQLQuery+=CommaRemoval(FORMAT(ROUND(Genjournal."Credit Amount",0.01)))+','''+USER.Name+''',''';
                      SQLQuery+=CommaRemoval(Genjournal.Description)+''')';
                      SQLConnection.Execute(SQLQuery);
                      SQLConnection.CommitTrans;
                      SQLConnection.Close;
                    END;
                  END;
                UNTIL Genjournal.NEXT=0; */

                //IF "Account No." IN ['25500','25700'] THEN;
                IF (Rec."Journal Batch Name" = 'PUR-CF') OR (Rec."Journal Batch Name" = 'PURCH-CF') THEN BEGIN
                    Invoice_Amount := 0;
                    Material_Value := 0;
                    Vat_Amount := 0;
                    Service_Amount := 0;
                    Vendor_Id := '';

                    /* IF NOT ISCLEAR(SQLConnection) THEN
                         CLEAR(SQLConnection);

                     IF NOT ISCLEAR(RecordSet) THEN
                         CLEAR(RecordSet);

                     IF ISCLEAR(SQLConnection) THEN
                         CREATE(SQLConnection, FALSE, TRUE) //Rev01
                     ELSE BEGIN
                         SQLConnection.Close;
                         CREATE(SQLConnection, FALSE, TRUE); //Rev01
                     END;

                     IF ISCLEAR(RecordSet) THEN
                         CREATE(RecordSet, FALSE, TRUE); //Rev01

                     WebRecStatus := Quotes + Text50001 + Quotes;
                     OldWebStatus := Quotes + Text50002 + Quotes;
                     GLSetup.GET;
                     SQLConnection.ConnectionString := GLSetup."Sql Connection String";
                     SQLConnection.Open;
                     SQLConnection.BeginTrans;
                     SQLQuery := '';*/

                    Genjournal.RESET;
                    Genjournal.SETRANGE(Genjournal."Journal Batch Name", Rec."Journal Batch Name");
                    Genjournal.SETFILTER(Genjournal."Credit Amount", '>%1', 0);
                    IF Genjournal.COUNT > 1 THEN
                        ERROR('AT A TIME YOU CAN  ENTER & POST "SINGLE INVOICE" ONLY');
                    Genjournal.RESET;
                    Genjournal.SETFILTER(Genjournal."Journal Batch Name", Rec."Journal Batch Name");
                    Genjournal.SETRANGE(Genjournal."Posting Date", WORKDATE);
                    IF Genjournal.FINDSET THEN
                        REPEAT
                            Genjournal.TESTFIELD(Genjournal."Document Type", Genjournal."Document Type"::Invoice);
                            IF (Genjournal."Account Type" = Genjournal."Account Type"::Vendor) THEN BEGIN
                                IF Genjournal."Location Code" = 'CS STR' THEN
                                    Dept := 'CS'
                                ELSE
                                    Dept := 'NORMAL';
                                IF Genjournal."Amount (LCY)" < 0 THEN BEGIN
                                    Invoice_Amount := ABS(Genjournal."Amount (LCY)");
                                    Vendor_Id := Genjournal."Account No.";
                                END;
                            END ELSE
                                IF (Genjournal."Account Type" = Genjournal."Account Type"::"G/L Account") THEN BEGIN
                                    EVALUATE(Acount_No, Genjournal."Account No.");
                                    IF Acount_No IN [16200, 17100, 23300, 23800, 23801, 23802, 23804, 61400, 61904, 61908, 61200, 51100, 53400, 53100, 51300, 51400, 59700, 59100, 60101, 60102, 60104, 58100,
                                                    53903, 60103, 59300, 53300, 61925, 61907, 58500, 61927, 33809, 33810, 33811, 15100, 58800, 53400, 33809, 33813, 61937, 59600, 59700, 58300, 59200, 61923, 58001, 58002, 58003, 59101, 19304, 59000] THEN BEGIN
                                        CASE Acount_No OF
                                            23800 .. 23802, 23804, 58001, 58002, 58003:
                                                BEGIN
                                                    // VAT AMOUNT
                                                    Vat_Amount += ABS(Genjournal."Amount (LCY)");
                                                END;
                                            61400, 61904, 61908, 61925, 33810, 33811, 53400, 33809, 33813, 61937, 19304:
                                                BEGIN
                                                    // SERVICE_AMOUNT
                                                    Service_Amount += ABS(Genjournal."Amount (LCY)");
                                                END;
                                            16200, 17100, 61200, 60101, 60102, 60103, 51100, 53100, 51300, 51400, 59700, 59100, 60104, 53903, 59300, 53300, 61907, 23300, 58500, 61927, 15100, 58800, 59600, 58300, 59200, 61923, 58100, 59101, 59000:
                                                BEGIN
                                                    // MATERIAL VALUE
                                                    Material_Value += ABS(Genjournal."Amount (LCY)");
                                                END;
                                        END;
                                    END
                                    ELSE
                                        ERROR('The G/L Account %1 is not valid to post to cash flow,Contact ERP Team', Acount_No);
                                END;
                        UNTIL Genjournal.NEXT = 0;
                END;
                IF (Rec."Account No." = '24000') AND (Rec."Prod. Order No." = '') THEN BEGIN
                    IF NOT CONFIRM(Text002, FALSE, Rec."Document No.") THEN
                        EXIT;
                END;

                IF (Rec."Journal Template Name" = 'GENERAL') AND (Rec."Journal Batch Name" = 'BPV_CF') AND (Rec.Printed = FALSE) THEN
                    ERROR('Voucher is not yet Printed.Please print Voucher!');    // Added by Pranavi on 08-04-2017 to restrict post CF_Purch vourchers if voucher is not printed


                // Added by Praanvi on 21-Jul-2016
                Genjournal1.COPYFILTERS(Rec);
                Genjournal1.SETRANGE(Genjournal1."Journal Batch Name", Rec."Journal Batch Name");
                Genjournal1.SETRANGE(Genjournal1."Posting Date", WORKDATE);
                IF Genjournal1.FINDSET THEN
                    REPEAT
                        IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['CPV', 'CRV']) AND (Genjournal1."Account Type" = Genjournal1."Account Type"::"Bank Account") THEN
                            ERROR('In Batch Code ' + COPYSTR(Rec."Journal Batch Name", 1, 3) + ' Bank Account should not be Selected!');

                        IF (Rec."Journal Batch Name" = 'CONTRA') AND (Genjournal1."Account Type" = Genjournal1."Account Type"::"G/L Account")
                            AND (NOT (Genjournal1."Account No." IN ['22100', '22101', '22102'])) THEN
                            ERROR('In Batch Code ' + Rec."Journal Batch Name" + ' Should not select GL Account except Cash Accounts 22100,22101,22102!');

                        IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV', 'BRV', 'JV-']) AND (Genjournal1."Account Type" = Genjournal1."Account Type"::"G/L Account")
                            AND (Genjournal1."Account No." IN ['22100', '22101', '22102']) THEN
                            ERROR('In Batch Code ' + Rec."Journal Batch Name" + ' Should not select Cash Accounts 22100,22101,22102!');
                    UNTIL Genjournal1.NEXT = 0;
                // End by Pranavi

                //Added by Pranavi on 10-10-2015 for FTT checking
                IF (COPYSTR(Rec."Journal Batch Name", 1, 3) = 'BPV') THEN BEGIN
                    Genjournal1.COPYFILTERS(Rec);
                    Genjournal1.SETRANGE(Genjournal1."Journal Batch Name", Rec."Journal Batch Name");
                    Genjournal1.SETRANGE(Genjournal1."Posting Date", WORKDATE);
                    IF Genjournal1.FINDSET THEN
                        REPEAT
                            IF Genjournal1."Account Type" = Genjournal1."Account Type"::Vendor THEN BEGIN
                                vendor1.RESET;
                                vendor1.SETFILTER(vendor1."No.", Genjournal1."Account No.");
                                IF vendor1.FINDFIRST THEN BEGIN
                                    IF ((vendor1."Gen. Bus. Posting Group" = 'FOREIGN') AND (Rec."Dimension Set ID" <> 19929)) THEN
                                        IF Genjournal1."Payment Through" <> Genjournal1."Payment Through"::FTT THEN
                                            ERROR('Please select Payment Through as FTT for foreign vendor payment. For Line No: ' + FORMAT(Genjournal1."Line No.") + 'Doc No.: ' + Genjournal1."Document No.")
                                        ELSE BEGIN
                                            IF Genjournal1."External Document No." = '' THEN
                                                ERROR('Please enter External Document No. as Payment Through is FTT!');
                                            IF Genjournal1."Currency Amount" = 0 THEN
                                                ERROR('Please enter Currency Amount!');
                                            IF Genjournal1."Currency Rate" = 0 THEN
                                                ERROR('Please enter Currency Rate!');
                                        END;
                                END;
                            END;
                        UNTIL Genjournal1.NEXT = 0;
                END;
                //End by Pranavi

                // Added by Pranavi on 15-Feb-2016 for Restrincting posting the JVs without sale order no. for some account heads

                IF ((COPYSTR(Rec."Journal Batch Name", 1, 2) = 'JV') AND NOT (SMTP_MAIL.Permission_Checking(USERID, 'ERP-ADMIN'))) THEN BEGIN
                    Genjournal1.COPYFILTERS(Rec);
                    Genjournal1.SETRANGE(Genjournal1."Journal Batch Name", Rec."Journal Batch Name");
                    Genjournal1.SETRANGE(Genjournal1."Posting Date", WORKDATE);
                    IF Genjournal1.FINDSET THEN
                        REPEAT
                            IF Genjournal1."Account Type" = Genjournal1."Account Type"::"G/L Account" THEN BEGIN
                                IF Genjournal1."Account No." IN ['53500', '23700', '25700', '61913', '61910', '59400'] THEN
                                    IF Genjournal1."Sale Order No" = '' THEN
                                        ERROR('Please select Sale Order No. For Line No: ' + FORMAT(Genjournal1."Line No.") + 'Doc No.: ' + Genjournal1."Document No.");
                                IF (Genjournal1."Account No." IN ['25500']) AND (Rec."Old Order" = FALSE) THEN
                                    IF Genjournal1."Tender No" = '' THEN
                                        ERROR('Please select Tendor No. For Line No: ' + FORMAT(Genjournal1."Line No.") + 'Doc No.: ' + Genjournal1."Document No.");
                            END;
                        UNTIL Genjournal1.NEXT = 0;
                END;
                // End by Pranavi

                // Added by Pranavi on 25-May-2016 for Restrincting posting the BPV or BRV without sale order no./Tender No for 25500,25700 account heads
                IF (COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV', 'BRV']) THEN BEGIN
                    Genjournal1.COPYFILTERS(Rec);
                    Genjournal1.SETRANGE(Genjournal1."Journal Batch Name", Rec."Journal Batch Name");
                    Genjournal1.SETRANGE(Genjournal1."Posting Date", WORKDATE);
                    IF Genjournal1.FINDSET THEN
                        REPEAT
                            IF Genjournal1."Account Type" = Genjournal1."Account Type"::"G/L Account" THEN BEGIN
                                IF (Genjournal1."Account No." IN ['25700']) AND (Genjournal1."Sale Order No" = '') AND (Rec."Old Order" = FALSE) THEN
                                    ERROR('Please select Sale Order No. For Line No: ' + FORMAT(Genjournal1."Line No.") + ' Doc No.: ' + Genjournal1."Document No.")
                                ELSE
                                    IF (Genjournal1."Account No." IN ['25500']) AND (Genjournal1."Tender No" = '') AND (Rec."Old Order" = FALSE) THEN
                                        ERROR('Please select Tender No. For Line No: ' + FORMAT(Genjournal1."Line No.") + ' Doc No.: ' + Genjournal1."Document No.");
                            END;
                        UNTIL Genjournal1.NEXT = 0;
                END;
                // End by Pranavi

                // Added by Pranavi on 23-Jun-2016 for SD Status Tracking
                IF (Rec."Journal Batch Name" = 'JV-CS RPTS') AND NOT (Rec."Account No." IN ['25700', '25500']) THEN BEGIN
                    IF Rec."Final Bill Payment" = FALSE THEN BEGIN
                        Selection := STRMENU(Text0001, 1);
                        CASE Selection OF
                            0:
                                EXIT;
                            2:
                                BEGIN
                                    Rec."Final Bill Payment" := TRUE;
                                    Rec.MODIFY;
                                    SaleOrder := Rec."Sale Order No";
                                    PostingDate := Rec."Posting Date";
                                    FinalBill := TRUE;
                                END;
                        END
                    END;
                END;
                // End by Pranavi

                Genjournal.COPYFILTERS(Rec);
                Genjournal.SETRANGE(Genjournal."Journal Batch Name", Rec."Journal Batch Name");
                Genjournal.SETRANGE(Genjournal."Posting Date", WORKDATE);
                IF Genjournal.FINDSET THEN
                    REPEAT
                        IF (Genjournal."Payment Through" = Genjournal."Payment Through"::DD) THEN
                            IF (Genjournal."DD/FDR No." = '') THEN    //Pranavi on 17-10-2015 for DD no. check if payment trhough DD
                                ERROR('Please enter DD No. for line no.: ' + FORMAT(Genjournal."Line No.") + 'Doc No.: ' + Genjournal."Document No.");
                    //IF "Validate Posting"="Validate Posting"::"0" THEN
                    //ERROR('Please check on Validate posting for posting entries');
                    UNTIL Genjournal.NEXT = 0;

                //added by vijaya on 09-06-2018 for Vertical wise expenditure tracking
                Genjournal.COPYFILTERS(Rec);
                Genjournal.SETRANGE(Genjournal."Journal Batch Name", Rec."Journal Batch Name");
                Genjournal.SETRANGE(Genjournal."Posting Date", WORKDATE);
                Genjournal.SETFILTER("Debit Amount", '>%1', 0);
                Genjournal.SETRANGE(Vertical, Genjournal.Vertical::" ");
                ErrorText := 'Please select vertical for expenditure entries';
                IF Genjournal.FINDSET THEN
                    REPEAT
                        GLA.RESET;
                        GLA.SETRANGE("No.", Genjournal."Account No.");
                        GLA.SETRANGE("Income/Balance", GLA."Income/Balance"::"Income Statement");
                        IF GLA.FINDFIRST THEN BEGIN
                            ErrorText := ErrorText + FORMAT(Genjournal."Line No.") + ',';
                        END;
                    UNTIL Genjournal.NEXT = 0;
                IF ErrorText <> 'Please select vertical for expenditure entries' THEN BEGIN
                    ERROR(ErrorText);
                END;
                //ended by vijaya

                // Added by Pranavi on 24-May-2016
                Temp_Jrnl_Line_Table.RESET;
                Temp_Jrnl_Line_Table.DELETEALL;
                JL.RESET;
                JL.COPYFILTERS(Rec);
                JL.SETRANGE(JL."Journal Batch Name", Rec."Journal Batch Name");
                JL.SETRANGE(JL."Posting Date", WORKDATE);
                //JL.SETRANGE(JL."Document No.","Document No.");
                //JL.SETRANGE(JL."Account No.","Account No.");
                IF JL.FINDSET THEN BEGIN
                    REPEAT
                        Temp_Jrnl_Line_Table := JL;
                        Temp_Jrnl_Line_Table.INSERT;
                    UNTIL JL.NEXT = 0;
                END;
                Temp_Jrnl_Line_Table.RESET;
                // end by Pranavi

                vendor.SETRANGE(vendor."No.", Rec."Account No.");
                IF vendor.FINDFIRST THEN BEGIN
                    IF vendor."Personal Account" = FALSE THEN BEGIN
                        Genjournal.SETRANGE(Genjournal."Journal Batch Name", Rec."Journal Batch Name");
                        IF Genjournal.FINDSET THEN
                            REPEAT
                                IF (COPYSTR(Genjournal."Journal Batch Name", 1, 2) = 'BP') OR (COPYSTR(Genjournal."Journal Batch Name", 1, 2) = 'CP') THEN BEGIN
                                    IF (Genjournal."Account Type" = Genjournal."Account Type"::Vendor) OR
                                       (Genjournal."Bal. Account Type" = Genjournal."Bal. Account Type"::Vendor) THEN BEGIN
                                        IF (Rec."Applies-to Doc. No." = '') THEN;
                                    END;
                                END;
                            UNTIL Genjournal.NEXT = 0;
                    END;
                END;

                IF WORKDATE = Rec."Posting Date" THEN BEGIN
                    // HDFC_Construction_restirct;//added by sujani for HDFC Payments restriction for construction related 14-mar-19

                    Temp_Jrnl_Line_Table.RESET;
                    IF Temp_Jrnl_Line_Table.FINDSET THEN
                        REPEAT
                            IF (Temp_Jrnl_Line_Table."Account Type" IN [Temp_Jrnl_Line_Table."Account Type"::Customer, Temp_Jrnl_Line_Table."Account Type"::Vendor]) AND
                              (Temp_Jrnl_Line_Table."GST on Advance Payment") AND (GetGSTAmounts(TaxTransactionValue, Temp_Jrnl_Line_Table, GSTSetup) <> 0) then begin //(Temp_Jrnl_Line_Table."Total GST Amount" <> 0) THEN BEGIN//EFFUPG
                                IF PrevDoc <> Temp_Jrnl_Line_Table."Document No." THEN BEGIN
                                    JGE.RESET;
                                    JGE.SETRANGE("Journal Batch Name", Temp_Jrnl_Line_Table."Journal Batch Name");
                                    JGE.SETRANGE("Journal Template Name", Temp_Jrnl_Line_Table."Journal Template Name");
                                    JGE.SETRANGE("Document No.", Temp_Jrnl_Line_Table."Document No.");
                                    IF JGE.FINDSET THEN BEGIN
                                        CLEAR(NoSeriesMgt);
                                        JGE.MODIFYALL(JGE."External Document No.", NoSeriesMgt.GetNextNo('ADV_VOUCH', WORKDATE, TRUE));
                                    END;
                                END;
                                PrevDoc := Temp_Jrnl_Line_Table."Document No.";
                            END;
                        UNTIL Temp_Jrnl_Line_Table.NEXT = 0;
                    PrevDoc := '';
                    IF Temp_Jrnl_Line_Table.FINDSET THEN
                        REPEAT
                            IF (PrevDoc <> Temp_Jrnl_Line_Table."Document No.") AND (PrevDoc <> '') THEN BEGIN
                                DocumentNo := DocumentNo + '|' + Temp_Jrnl_Line_Table."Document No.";
                            END;
                            PrevDoc := Temp_Jrnl_Line_Table."Document No.";
                        UNTIL Temp_Jrnl_Line_Table.NEXT = 0;
                    //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Rec);
                    IF (FinalBill = TRUE) AND (Rec."Journal Batch Name" = 'JV-CS RPTS') THEN BEGIN
                        sdupdate.SDStatusUpdate(SaleOrder, PostingDate);
                    END;

                    // Added by Pranavi on 24-May-2016
                    Temp_Jrnl_Line_Table.RESET;
                    IF Temp_Jrnl_Line_Table.FINDSET THEN BEGIN
                        REPEAT
                            IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 3) IN ['BPV', 'BRV']) AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                               (Temp_Jrnl_Line_Table."Account No." IN ['25500', '25700']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                                SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                                SendMail(Temp_Jrnl_Line_Table);
                            END;
                            IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 2) IN ['JV']) AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                              (Temp_Jrnl_Line_Table."Account No." IN ['25700']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                                SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                                SendMail(Temp_Jrnl_Line_Table);
                            END;
                            IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 2) IN ['JV']) AND (Temp_Jrnl_Line_Table."Tender No" <> '') AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                               (Temp_Jrnl_Line_Table."Account No." IN ['25500']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                                SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                                SendMail(Temp_Jrnl_Line_Table);
                            END;
                        UNTIL Temp_Jrnl_Line_Table.NEXT = 0;
                    END;

                    Temp_Jrnl_Line_Table.RESET;
                    Temp_Jrnl_Line_Table.DELETEALL;
                    // end by Pranavi
                end;
            end;

            trigger OnAfterAction()
            begin
                IF (FinalBill = TRUE) AND (Rec."Journal Batch Name" = 'JV-CS RPTS') THEN BEGIN
                    sdupdate.SDStatusUpdate(SaleOrder, PostingDate);
                END;

                // Added by Pranavi on 24-May-2016
                Temp_Jrnl_Line_Table.RESET;
                IF Temp_Jrnl_Line_Table.FINDSET THEN BEGIN
                    REPEAT
                        IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 3) IN ['BPV', 'BRV']) AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                           (Temp_Jrnl_Line_Table."Account No." IN ['25500', '25700']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                            SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                            SendMail(Temp_Jrnl_Line_Table);
                        END;
                        IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 2) IN ['JV']) AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                          (Temp_Jrnl_Line_Table."Account No." IN ['25700']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                            SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                            SendMail(Temp_Jrnl_Line_Table);
                        END;
                        IF (COPYSTR(Temp_Jrnl_Line_Table."Journal Batch Name", 1, 2) IN ['JV']) AND (Temp_Jrnl_Line_Table."Tender No" <> '') AND (Temp_Jrnl_Line_Table."Account Type" = Temp_Jrnl_Line_Table."Account Type"::"G/L Account") AND
                           (Temp_Jrnl_Line_Table."Account No." IN ['25500']) AND (Temp_Jrnl_Line_Table."Old Order" = FALSE) THEN BEGIN
                            SqlInt.EMDSDPaymentsEntryInCashFlow(Temp_Jrnl_Line_Table);
                            SendMail(Temp_Jrnl_Line_Table);
                        END;
                    UNTIL Temp_Jrnl_Line_Table.NEXT = 0;
                END;

                Temp_Jrnl_Line_Table.RESET;
                Temp_Jrnl_Line_Table.DELETEALL;
                // end by Pranavi
            end;
        }
        /*  modify(Preview)
          {
              Promoted = true;
              PromotedCategory = Process;
          }
          modify(PostAndPrint)
          {
              Promoted = true;
              PromotedIsBig = true;
          }
          modify(ImportBankStatement)
          {
              Promoted = true;
              PromotedIsBig = true;
          }
          modify(ShowStatementLineDetails)
          {
              Promoted = true;
              PromotedIsBig = true;
          }*/
        modify(Reconcile)
        {
            Promoted = true;
        }
        modify("Apply Entries")
        {
            Promoted = true;
        }
        modify(Match)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(AddMappingRule)
        {
            Promoted = true;
            PromotedIsBig = true;
        }

        /*  modify(ImportPayrollTransaction)
          {
              Promoted = true;
              PromotedIsBig = true;
          }*/
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        /* modify(Comment)
         {
             Promoted = true;
         }*/
        addafter("Bank Charges")
        {
            group("&Narration")
            {
                CaptionML = ENU = '&Narration',
                            ENN = '&Narration';
                Image = Description;
                action("Line Narration")
                {
                    CaptionML = ENU = 'Line Narration',
                                ENN = 'Line Narration';
                    Image = LineDescription;
                    /* RunObject = Page "Gen. Journal Narration";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), "Gen. Journal Line No." = FIELD("Line No."), "Document No." = FIELD("Document No."); */
                    ShortCutKey = 'Shift+Ctrl+N';
                    ApplicationArea = All;
                }
                action("Voucher Narration")
                {
                    CaptionML = ENU = 'Voucher Narration',
                                ENN = 'Voucher Narration';
                    Image = VoucherDescription;
                    RunObject = Page "Gen. Journal Voucher Narration";
                    RunPageLink = "Journal Template Name" = FIELD("Journal Template Name"), "Journal Batch Name" = FIELD("Journal Batch Name"), "Document No." = FIELD("Document No."), "Gen. Journal Line No." = FILTER(0);
                    ShortCutKey = 'Shift+Ctrl+V';
                    ApplicationArea = All;
                }
            }
        }
        addafter(DeferralSchedule)
        {
            action(AssginNoSeries)
            {
                Caption = 'Assign No. Series';
                ApplicationArea = All;

                trigger OnAction();
                var
                    GJrnlGRec: Record "Gen. Journal Line";
                begin
                    IF (Rec."GST on Advance Payment") AND (GetGSTAmounts(TaxTransactionValue, REc, GSTSetup) <> 0) then begin //("Total GST Amount" <> 0) THEN BEGIN//EFFUPG
                        CLEAR(NoSeriesMgt);
                        //"External Document No." := NoSeriesMgt.TryGetNextNo('ADV_VOUCH',TODAY);
                        GJrnlGRec.COPYFILTERS(Rec);
                        IF GJrnlGRec.FINDSET THEN
                            GJrnlGRec.MODIFYALL(GJrnlGRec."External Document No.", NoSeriesMgt.TryGetNextNo('ADV_VOUCH', TODAY));
                    END;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BPV_CF_Color := FALSE;
        IF (Rec."Journal Template Name" = 'GENERAL') AND (Rec."Journal Batch Name" = 'BPV_CF') THEN
            IF Rec.Printed = TRUE THEN
                BPV_CF_Color := TRUE;
    end;

    trigger OnOpenPage()
    begin
        BPV_CF_Color := FALSE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IF ((Rec.COUNT = 1) AND (Rec."Journal Batch Name" = 'BRV(EMP)')) OR ((Rec.COUNT = 1) AND (Rec."Journal Batch Name" = 'BRV(CUST)')) THEN
            MESSAGE('POST IN SINGLE LINE')
        ELSE BEGIN
        END;
        //Added by Pranavi on 12-11-2015 for setting default payment type according to batch name
        IF COPYSTR("Journal Batch Name", 1, 3) IN ['BPV', 'CPV'] THEN BEGIN //CurrentJnlBatchName//EFFUPG
            Rec."Payment Type" := Rec."Payment Type"::Payment;
        END
        ELSE
            IF COPYSTR("Journal Batch Name", 1, 3) IN ['BRV', 'CRV'] THEN BEGIN//CurrentJnlBatchName//EFFUPG
                Rec."Payment Type" := Rec."Payment Type"::Receipt;
            END
            ELSE
                IF COPYSTR("Journal Batch Name", 1, 2) IN ['JV'] THEN BEGIN//CurrentJnlBatchName//EFFUPG
                    Rec."Payment Type" := Rec."Payment Type"::Journal;
                END
                ELSE
                    IF "Journal Batch Name" IN ['CONTRA'] THEN//CurrentJnlBatchName//EFFUPG
                        Rec."Payment Type" := Rec."Payment Type"::Contra;
        //End by Pranavi
    end;

    var
        "sale header": Record "Sales Header";
        "sales invoice header": Record "Sales Invoice Header";
        Genjournal: Record "Gen. Journal Line";
        vendor: Record Vendor;
        Invoice_Amount: Decimal;
        Material_Value: Decimal;
        Vat_Amount: Decimal;
        Service_Amount: Decimal;
        Vendor_Id: Code[20];
        SQLQUERY2: Text[1000];
        SQLQuery: Text[1000];
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Acount_No: Integer;
        GLSetup: Record "General Ledger Setup";
        Text002: Label 'Project not selected for travelling advance.Do you want to post %1';
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        USER: Record "Dimension Value";
        RCNT: Integer;
        Dept: Code[10];
        SH: Record "Sales Header";
        SIH: Record "Sales Invoice Header";
        Temp_Jrnl_Line_Table: Record "Gen. Journal Line" temporary;
        Jrnl_Line: Record "Gen. Journal Line";
        Printed_Color: Label 'Voucher Printed';
        Salinv: Record "Sales Invoice-Dummy";
        Text19039985: Label 'Account Name';
        "--Rev01": Integer;
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        Genjournal1: Record "Gen. Journal Line";
        vendor1: Record Vendor;
        SqlInt: Codeunit SQLIntegration;
        Selection: Integer;
        Text0001: Label '&Not a Final Bill Payment,&Final Bill Payment';
        JL: Record "Gen. Journal Line";
        SaleOrder: Code[20];
        PostingDate: Date;
        FinalBill: Boolean;
        sdupdate: Codeunit "Custom Events";
        /* SH: Record "Sales Header";
         SIH: Record "Sales Invoice Header";
         Temp_Jrnl_Line_Table: Record "Gen. Journal Line" temporary;
         Jrnl_Line: Record "Gen. Journal Line";
         Printed_Color: Label 'Voucher Printed';*/
        BPV_CF_Color: Boolean;
        NoSeriesMgt: Codeunit 396;
        SMTP_MAIL: Codeunit "Custom Events";//"SMTP Mail";
        EX_GLE: Record "G/L Entry";
        AccName: Text[100];
        BalAccName: Text[100];





    procedure CommaRemoval(Base: Text[250]) Converted: Text[250];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF (COPYSTR(Base, i, 1) <> ',') AND (COPYSTR(Base, i, 1) <> '''') AND (COPYSTR(Base, i, 1) <> '&') THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;


    local procedure DescriptionOnAfterValidate();
    begin
        Rec.Description := UPPERCASE(Rec.Description);
    end;


    procedure SendMail(Jnrl_Grnl_Lin: Record "Gen. Journal Line");
    begin
    end;


    procedure DumptoOtherGSTTable(DocNo: Text);
    var
        GLE: Record "G/L Entry";
        GST_Entry: Boolean;
        "Posting Date": Date;
        "VENDOR NAME": Text;
        "INVOICE NO.": Text;
        "Vendor Invoice Date": Date;
        "Accessable Amt": Decimal;
        IGST: Decimal;
        CGST: Decimal;
        SGST: Decimal;
        DEPARTMENT: Text;
        "GST JURISDICTION TYPE": Text;
        "GST Registration No_": Text;
        "GST Vendor Type": Text;
        "HSN/SAC CODE": Text;
        "HSN/SAC DESCRIPTION": Text;
        "VENDOR STATE": Text;
        "System Date": Date;
        "Document No_": Text;
        "G_L Account No_": Code[10];
        Ven: Record Vendor;
        State: Record State;
        GLA: Record "G/L Account";
        HSNSAC: Record "HSN/SAC";
        SqlQuery: Text;
        Entry_DocNo: Text;
    begin
        GST_Entry := FALSE;
        GLE.RESET;
        GLE.SETFILTER("Document No.", DocNo);
        GLE.SETFILTER("G/L Account No.", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', '58001', '58002', '58003', '51101', '51102', '51103', '51104', '51105', '51106', '51107');
        IF GLE.FINDFIRST THEN BEGIN
            GST_Entry := TRUE;
        END;

        "Accessable Amt" := 0;
        IGST := 0;
        SGST := 0;
        CGST := 0;
        "HSN/SAC CODE" := '';
        "HSN/SAC DESCRIPTION" := '';
        Entry_DocNo := '';
        IF GST_Entry = FALSE THEN BEGIN
            EXIT;
        END ELSE BEGIN
            /*  IF ISCLEAR(SQLConnection) THEN
                  CREATE(SQLConnection, FALSE, TRUE);
              SQLConnection.ConnectionString := 'DSN=ERPSERVER;UID=report;PASSWORD=Efftronics@eff;SERVER:=erpserver;providerName=System.Data.SqlClient;';
              SQLConnection.Open;*/
            GLE.RESET;
            GLE.SETFILTER("Document No.", DocNo);
            GLE.SETCURRENTKEY("Document No.", "Posting Date", Amount);
            IF GLE.FINDFIRST THEN
                REPEAT
                    IF Entry_DocNo = '' THEN BEGIN
                        Entry_DocNo := GLE."Document No.";
                    END;
                    IF Entry_DocNo <> GLE."Document No." THEN BEGIN
                        IF (IGST > 0) AND (SGST + CGST = 0) THEN BEGIN
                            "GST JURISDICTION TYPE" := 'Interstate';
                        END ELSE BEGIN
                            "GST JURISDICTION TYPE" := 'Intrastate';
                        END;
                        GLA.RESET;
                        GLA.SETFILTER("No.", "G_L Account No_");
                        IF GLA.FINDFIRST THEN BEGIN
                            "HSN/SAC CODE" := GLA."HSN/SAC Code";
                            "HSN/SAC DESCRIPTION" := '';
                            IF (GLA."GST Group Code" <> '') AND (GLA."HSN/SAC Code" <> '') THEN BEGIN
                                HSNSAC.RESET;
                                HSNSAC.SETFILTER("GST Group Code", GLA."GST Group Code");
                                HSNSAC.SETFILTER(Code, GLA."HSN/SAC Code");
                                IF HSNSAC.FINDFIRST THEN BEGIN
                                    "HSN/SAC DESCRIPTION" := HSNSAC.Description;
                                END;
                            END;
                        END;
                        SqlQuery := 'Insert into [OTHER_GST_ENTRIES] ([Posting Date],[VENDOR NAME],[INVOICE NO.],[Vendor Invoice Date],[Accessable Amt],[IGST],[CGST],[SGST],[IGST Rate]' +
                              ',[CGST Rate],[SGST Rate],[TOTAL INVOICED AMT],[DEPARTMENT],[ACTUAL DATE] ,[GST JURISDICTION TYPE],[GST Registration No_],[GST Vendor Type],[HSN/SAC CODE]' +
                              ',[HSN/SAC DESCRIPTION],[VENDOR STATE],[System Date],[Quantity],[UOM],[Document No_],[G_L Account No_],[ITC Claim Type]) values(''' +
                              FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' + "VENDOR NAME" + ''',''' + "INVOICE NO." + ''',''' + FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') +
                              ''',' + CommaRemoval(FORMAT(ROUND("Accessable Amt", 1))) + ',' + CommaRemoval(FORMAT(ROUND(IGST, 1))) + ',' +
                              CommaRemoval(FORMAT(ROUND(CGST, 1))) + ',' + CommaRemoval(FORMAT(ROUND(SGST, 1))) + ',' + FORMAT(ROUND((IGST * 100 / "Accessable Amt"), 1)) + ',' +
                              FORMAT(ROUND((CGST * 100 / "Accessable Amt"), 1)) + ',' + FORMAT(ROUND((SGST * 100 / "Accessable Amt"), 1)) + ',' + CommaRemoval(FORMAT(ROUND("Accessable Amt" + IGST + CGST + SGST, 1))) +
                              ',''' + DEPARTMENT + ''',''' +
                              FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' + "GST JURISDICTION TYPE" + ''',''' + "GST Registration No_" + ''',''' + "GST Vendor Type" +
                              ''',''' + "HSN/SAC CODE" + ''',''' + "HSN/SAC DESCRIPTION" + ''',''' +
                              "VENDOR STATE" + ''',''' + FORMAT("System Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',1,''Nos'',''' + "Document No_" + ''',''' + "G_L Account No_" + ''',''Input Service'')';
                        //>> ORACLE UPG
                        /* IF SqlQuery <> '' THEN
                            SQLConnection.Execute(SqlQuery);
                        Entry_DocNo := GLE."Document No.";
                        "Accessable Amt" := 0;
                        IGST := 0;
                        SGST := 0;
                        CGST := 0;
                        "HSN/SAC CODE" := '';
                        "HSN/SAC DESCRIPTION" := ''; */
                        //<< ORACLE UPG
                    END;
                    IF Entry_DocNo = GLE."Document No." THEN BEGIN
                        IF GLE.Amount > 0 THEN BEGIN
                            "Posting Date" := GLE."Posting Date";
                            Ven.RESET;
                            Ven.SETFILTER("No.", GLE."Source No.");
                            IF Ven.FINDFIRST THEN BEGIN
                                "VENDOR NAME" := Ven.Name;
                                "GST Registration No_" := Ven."GST Registration No.";
                                "GST Vendor Type" := FORMAT(Ven."GST Vendor Type");
                                State.RESET;
                                State.SETRANGE(Code, Ven."State Code");
                                IF State.FINDFIRST THEN BEGIN
                                    "VENDOR STATE" := FORMAT(State."State Code (GST Reg. No.)") + '-' + State.Description;
                                END;
                            END;
                            "INVOICE NO." := GLE."External Document No.";
                            DEPARTMENT := GLE."Global Dimension 1 Code";
                            "System Date" := GLE."System Date";
                            "Document No_" := GLE."Document No.";
                        END ELSE
                            IF (GLE."G/L Account No." IN ['58001', '58002', '58003', '51101', '51102', '51103', '51104', '51105', '51106', '51107']) THEN BEGIN
                                // GST Details
                                IF (GLE."G/L Account No." IN ['58001', '51101', '51102', '51107']) THEN BEGIN
                                    IGST := IGST + (-GLE.Amount);
                                END ELSE
                                    IF (GLE."G/L Account No." IN ['58002', '51103', '51104']) THEN BEGIN
                                        SGST := SGST + (-GLE.Amount);
                                    END ELSE
                                        IF (GLE."G/L Account No." IN ['58003', '51105', '51106']) THEN BEGIN
                                            CGST := CGST + (-GLE.Amount);
                                        END;
                            END ELSE BEGIN
                                // Cost Details
                                "Accessable Amt" := "Accessable Amt" + (-GLE.Amount);
                                "G_L Account No_" := GLE."G/L Account No.";

                            END;
                    END;
                    Entry_DocNo := GLE."Document No.";
                UNTIL GLE.NEXT = 0;


        END;
        IF (IGST > 0) AND (SGST + CGST = 0) THEN BEGIN
            "GST JURISDICTION TYPE" := 'Interstate';
        END ELSE BEGIN
            "GST JURISDICTION TYPE" := 'Intrastate';
        END;
        GLA.RESET;
        GLA.SETFILTER("No.", "G_L Account No_");
        IF GLA.FINDFIRST THEN BEGIN
            "HSN/SAC CODE" := GLA."HSN/SAC Code";
            "HSN/SAC DESCRIPTION" := '';
            IF (GLA."GST Group Code" <> '') AND (GLA."HSN/SAC Code" <> '') THEN BEGIN
                HSNSAC.RESET;
                HSNSAC.SETFILTER("GST Group Code", GLA."GST Group Code");
                HSNSAC.SETFILTER(Code, GLA."HSN/SAC Code");
                IF HSNSAC.FINDFIRST THEN BEGIN
                    "HSN/SAC DESCRIPTION" := HSNSAC.Description;
                END;
            END;
        END;
        SqlQuery := 'Insert into [OTHER_GST_ENTRIES] ([Posting Date],[VENDOR NAME],[INVOICE NO.],[Vendor Invoice Date],[Accessable Amt],[IGST],[CGST],[SGST],[IGST Rate]' +
              ',[CGST Rate],[SGST Rate],[TOTAL INVOICED AMT],[DEPARTMENT],[ACTUAL DATE] ,[GST JURISDICTION TYPE],[GST Registration No_],[GST Vendor Type],[HSN/SAC CODE]' +
              ',[HSN/SAC DESCRIPTION],[VENDOR STATE],[System Date],[Quantity],[UOM],[Document No_],[G_L Account No_],[ITC Claim Type]) values(''' +
              FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' + "VENDOR NAME" + ''',''' + "INVOICE NO." + ''',''' + FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') +
              ''',' + CommaRemoval(FORMAT(ROUND("Accessable Amt", 1))) + ',' + CommaRemoval(FORMAT(ROUND(IGST, 1))) + ',' +
              CommaRemoval(FORMAT(ROUND(CGST, 1))) + ',' + CommaRemoval(FORMAT(ROUND(SGST, 1))) + ',' + FORMAT(ROUND((IGST * 100 / "Accessable Amt"), 1)) + ',' +
              FORMAT(ROUND((CGST * 100 / "Accessable Amt"), 1)) + ',' + FORMAT(ROUND((SGST * 100 / "Accessable Amt"), 1)) + ',' + CommaRemoval(FORMAT(ROUND("Accessable Amt" + IGST + CGST + SGST, 1))) +
              ',''' + DEPARTMENT + ''',''' +
              FORMAT("Posting Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' + "GST JURISDICTION TYPE" + ''',''' + "GST Registration No_" + ''',''' + "GST Vendor Type" +
              ''',''' + "HSN/SAC CODE" + ''',''' + "HSN/SAC DESCRIPTION" + ''',''' +
              "VENDOR STATE" + ''',''' + FORMAT("System Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',1,''Nos'',''' + "Document No_" + ''',''' + "G_L Account No_" + ''',''Input Service'')';
        //>> ORACLE UPG
        /*  IF SqlQuery <> '' THEN
             SQLConnection.Execute(SqlQuery); */
        //<< ORACLE UPG
    end;


    procedure External_doc_no_chk();
    begin
        IF ((COPYSTR(Rec."Journal Batch Name", 1, 3) IN ['BPV']) AND (Rec."Payment Through" = Rec."Payment Through"::FTT)) THEN BEGIN
            EX_GLE.RESET;
            EX_GLE.SETFILTER("Source No.", Rec."Source No.");
            EX_GLE.SETFILTER("External Document No.", Rec."External Document No.");
            IF EX_GLE.FINDSET THEN
                REPEAT
                BEGIN
                    ERROR('This External Document No Already Existed in ' + EX_GLE."Document No.");
                END;
                UNTIL EX_GLE.NEXT = 0;
        END;
    end;


    procedure HDFC_Construction_restirct();
    begin
        Rec.SETRANGE("Account Type", Rec."Account Type"::"Bank Account");
        Rec.SETFILTER("Account No.", 'BA000019');
        IF Rec.FINDSET THEN BEGIN
            Genjournal.RESET;
            Genjournal.SETFILTER("Document No.", Rec."Document No.");
            IF Genjournal.FINDSET THEN
                REPEAT
                    IF NOT (Genjournal."Dimension Set ID" IN [19929]) THEN
                        ERROR('You Can not post the HDFC Payments to Other Department for ' + Genjournal."Account No.");
                UNTIL Genjournal.NEXT = 0;
        END;
    end;

    //EFFUPG>
    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
    GenJnlLine: Record "Gen. Journal Line";
    GSTSetup: Record "GST Setup"): Decimal
    var
        ComponentName: Code[30];
        GSTAmt: Decimal;
    begin
        GSTSetup.get;
        ComponentName := GetComponentName(GenJnlLine, GSTSetup);
        clear(GSTAmt);

        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", GenJNlLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    6:
                        GSTAmt += Round(TaxTransactionValue.Amount, 0.1);
                    2:
                        GSTAmt += Round(TaxTransactionValue.Amount, 0.1);
                    3:
                        GSTAmt += Round(TaxTransactionValue.Amount, 0.1);
                end;
            until TaxTransactionValue.Next() = 0;
        exit(GSTAmt);

    end;

    local procedure GetComponentName(GenJnlLine: Record "Gen. Journal Line"; GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if GenJnlLine."GST Jurisdiction Type" = GenJnlLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            exit(ComponentName)
    end;

    var
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';

        GSTLbl: Label 'GST';
        GSTSetup: record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
    //EFFUPG<
}

