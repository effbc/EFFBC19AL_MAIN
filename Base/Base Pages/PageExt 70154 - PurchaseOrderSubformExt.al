pageextension 70154 PurchaseOrderSubformExt extends "Purchase Order Subform"
{
    layout
    {
        /*modify(Control1)
        {
            ShowCaption = false;
        }*/
        modify("Description 2")
        {
            Visible = true;

        }



        modify("No.")
        {
            Style = Unfavorable;
            StyleExpr = itm_clr_flg;
            trigger OnBeforeValidate()
            begin
                IF (Rec.Type = Rec.Type::Item) THEN BEGIN
                    DescriptionEditable := TRUE;
                END;
            end;

            trigger OnAfterValidate()
            begin
                //SETRANGE();

                /* PurchHeader.SETRANGE("No.", "Document No.");
                IF PurchHeader.FINDFIRST THEN
                VendNo := PurchHeader."Buy-from Vendor No.";
                ItemVendor.SETRANGE("Vendor No.", VendNo);
                ItemVendor.SETRANGE("Item No.", "No.");
                IF NOT ItemVendor.FINDFIRST THEN
                ERROR('%1 is not a valid num', "No."); */
                GPS.SETRANGE(GPS."Gen. Prod. Posting Group", Rec."Gen. Prod. Posting Group");
                GPS.SETFILTER(GPS."Gen. Bus. Posting Group", Rec."Gen. Bus. Posting Group");
                IF GPS.FINDFIRST THEN BEGIN
                    Rec."Account No." := GPS."Purch. Account";
                END;
                //Added by Pranavi on 22-07-2015 for restricting blocked make items
                ITEM.RESET;
                ITEM.SETFILTER(ITEM."No.", Rec."No.");
                IF ITEM.FINDFIRST THEN BEGIN
                    Make2.RESET;
                    Make2.SETFILTER(Make2.Make, ITEM.Make);
                    IF Make2.FINDFIRST THEN BEGIN
                        IF Make2.Blocked = TRUE THEN
                            ERROR('You Cannot Select this Item-- ' + Rec."No." + ' because its Make-- ' + Rec.Make + ' is Blocked!');
                    END;
                END;
            end;
        }
        /* modify(Control43)
         {
             ShowCaption = false;
         }
         modify(Control37)
         {
             ShowCaption = false;
         }
         modify(Control19)
         {
             ShowCaption = false;
         }*/
        /* modify(RefreshTotals)
        {
            ShowCaption = false;
        } 

         modify("Line Amount")
        {
            Visible = false;
        } 
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }*/
        modify(Description)
        {
            Editable = DescriptionEditable;
            trigger OnBeforeValidate()
            begin
                //Added by Vishnu Priya on 14-08-2020
                IF (Rec.Type IN [Rec.Type::Item, Rec.Type::"G/L Account", Rec.Type::"Fixed Asset"]) THEN BEGIN
                    IF STRLEN(Rec.Description) > 50 THEN
                        ERROR('Please Reduce the lenth of the Description to 50 characters. Current Length is ' + FORMAT(Rec.Description));
                END;
                //End by Vishnu Priya on 14-08-2020
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                IF ITEM.GET(Rec."No.") THEN BEGIN
                    IF (Rec."Location Code" = 'STR') AND (ITEM.EFF_MOQ > 0) THEN
                        MOQ_Temp := ITEM.EFF_MOQ
                    ELSE
                        MOQ_Temp := ITEM."Minimum Order Quantity";
                    IF MOQ_Temp = 0 THEN
                        ERROR(' PLEASE MENTION  THE MINIMUM ORDER QUANTITY IN ITEM CARD ');
                    IF Rec.Quantity < MOQ_Temp THEN
                        ERROR(' YOU ARE ORDERING THE QUANTITY BELOW THE MENTIONED MINIMUM ORDER QUANTITY');
                    IF ITEM."Order Multiple" > 0 THEN BEGIN
                        IF Rec.Quantity MOD ITEM."Order Multiple" <> 0 THEN
                            ERROR('Quantity should be a multiple of %1', ITEM."Order Multiple");
                    END;
                END;
            end;
        }
        addafter(Type)
        {
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }

        }
        addafter("No.")
        {

            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
            
            field("Depreciation Book Code"; Rec."Depreciation Book Code")
            {
                ApplicationArea = All;
            }

            field("Purchase Orders"; Rec."Purchase Orders")
            {
                ApplicationArea = All;
            }
            field(Make; Rec.Make)
            {
                Editable = Make_edit;
                Enabled = true;
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    IV.RESET;
                    IV.SETFILTER(IV."Item No.", Rec."No.");
                    IF IV.FINDFIRST THEN BEGIN
                        IV.RESET;
                        IV.SETFILTER(IV."Item No.", Rec."No.");
                        //IV.SETFILTER(Make,Make);
                        IF PAGE.RUNMODAL(Page::"Item Variants Cust", IV) = ACTION::LookupOK THEN//EFFUPG
                            Rec.Make := IV.Make;
                        IV.RESET;
                        IV.SETFILTER(IV."Item No.", Rec."No.");
                        IV.SETFILTER(Make, Make);
                        IF IV.FINDFIRST THEN
                            Rec."Part Number" := IV."Part No";
                    END
                    ELSE BEGIN
                        Make2.RESET;
                        IF PAGE.RUNMODAL(60041, Make2) = ACTION::LookupOK THEN
                            Rec.Make := Make2.Make;
                    END;
                end;

                trigger OnValidate();
                begin
                    IV.RESET;
                    IV.SETFILTER(IV."Item No.", Rec."No.");
                    IV.SETFILTER(Make, Rec.Make);
                    IF IV.FINDFIRST THEN
                        Rec."Part Number" := IV."Part No";
                end;
            }

        }
        addafter(Quantity)
        {
            /*  field("Purchase Invoice"; "Charges To Vendor")
             {
                 ApplicationArea = All;
             } */
            field("PCB Mode"; Rec."PCB Mode")
            {
                ApplicationArea = All;
            }
            /*  field("TDS Nature of Deduction"; "TDS Nature of Deduction")
              {
                  ApplicationArea = All;
              }*/

            field("Deviated Receipt Date"; Rec."Deviated Receipt Date")
            {
                Caption = 'Latest Mat. Expected date';
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //  IF "Deviated Receipt Date"<"Expected Receipt Date" THEN
                    //   ERROR('Please Enter the Date Greater than Expected Receipt Date');

                    // Rev01 >>
                    IF Rec."Deviated Receipt Date" <> xRec."Deviated Receipt Date" THEN BEGIN
                        IF Rec.Remarks = '' THEN
                            ERROR('Please Enter the Remarks')
                        ELSE BEGIN
                            "Excepted Rcpt.Date Tracking".INIT;
                            "Excepted Rcpt.Date Tracking"."Entry No." := "Excepted Rcpt.Date Tracking".COUNT + 1;
                            "Excepted Rcpt.Date Tracking"."Document No." := Rec."Document No.";
                            //"Excepted Rcpt.Date Tracking"."Document Type" := Rec."Document Type";//EFFUPG
                            "Excepted Rcpt.Date Tracking"."Document Type" := "Excepted Rcpt.Date Tracking"."Document Type"::Order;//EFFUPG
                            "Excepted Rcpt.Date Tracking"."Document Line No." := Rec."Line No.";
                            "Excepted Rcpt.Date Tracking"."Item No." := Rec."No.";
                            "Excepted Rcpt.Date Tracking"."Deviated By" := Rec."Deviated By";
                            "Excepted Rcpt.Date Tracking"."User Id" := USERID;
                            "Excepted Rcpt.Date Tracking"."Modified Date" := TODAY;
                            IF Rec."Deviated Receipt Date" > 0D THEN
                                "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date" := Rec."Deviated Receipt Date"
                            ELSE
                                "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date" := Rec."Expected Receipt Date";
                            "Excepted Rcpt.Date Tracking".Reason := Rec.Remarks;

                            "Excepted Rcpt.Date Tracking"."Excepted Receipt New Date" := Rec."Deviated Receipt Date";
                            "Excepted Rcpt.Date Tracking".INSERT;

                        END;
                    END;

                    IF FORMAT(xRec."Deviated Receipt Date") <> '' THEN BEGIN
                        IF FORMAT(Rec."Deviated Receipt Date") = '' THEN
                            ERROR('You Dont Have to Delete the Deviated Date');
                        /*
                        IF "Deviated Receipt Date" < "Expected Receipt Date" THEN       // Added by Pranavi on 31-mar-2016
                          ERROR('Deviated Receipt Date should be greater than or equal Expected Receipt Date!');
                        */
                    END;
                    // Rev01 <<



                    Rec.Period := Getperiod(Rec."Deviated Receipt Date");

                    "G|l".GET;
                    IF "G|l"."Active ERP-CF Connection" THEN BEGIN
                        CashFlowConnection.ExecInOracle('UPDATE PURCHASE_LINE SET DEVIATED_DATE=''' + FORMAT(Rec."Deviated Receipt Date", 0,
                                                                                      '<Day>-<Month Text,3>-<Year4>') +
                                                      ''' WHERE ORDERNO=''' + Rec."Document No." + '''  AND ORDER_LINE_NO=''' + DELCHR(FORMAT(Rec."Line No."), '=', ',') + '''');

                        // Start--Added by Pranavi on 31-Jan-2017 for Advance & COD plan_changes
                        /*IF NOT ISCLEAR(SQLConnection) THEN
                            CLEAR(SQLConnection);

                        IF NOT ISCLEAR(RecordSet) THEN
                            CLEAR(RecordSet);

                        IF ISCLEAR(SQLConnection) THEN
                            CREATE(SQLConnection, FALSE, TRUE); //Rev01

                        IF ISCLEAR(RecordSet) THEN
                            CREATE(RecordSet, FALSE, TRUE);
                            */ //Rev01
                               //>> ORACLE UPG
                               /*
                           SQLConnection.ConnectionString := "G|l"."Sql Connection String";
                           SQLConnection.Open;
                           SQLConnection.BeginTrans;
                           SQLQuery := 'SELECT * FROM Purchase_Heads_Details WHERE ORDERNO = ''' + FORMAT(Rec."Document No.") + ''' AND LINE_NO = ' + DELCHR(FORMAT(Rec."Line No."), '=', ',') + ' AND TYPE NOT LIKE ''%Advance%''';
                           // MESSAGE(SQLQuery);
                           RecordSet := SQLConnection.Execute(SQLQuery);
                           RecCount := 0;
                           IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                               RecordSet.MoveFirst;
                           WHILE NOT RecordSet.EOF DO BEGIN
                               ConsiderTax := FORMAT(RecordSet.Fields.Item('CONSIDER_TAX').Value);
                               IF FORMAT(RecordSet.Fields.Item('TYPE').Value) = 'Order' THEN
                                   Dev_Rcpt_Date := CALCDATE(FORMAT(RecordSet.Fields.Item('CREDIT').Value) + 'D', Rec."Deviated Receipt Date")
                               ELSE
                                   Dev_Rcpt_Date := Rec."Deviated Receipt Date";
                               ActPeriodActYearCalc(Dev_Rcpt_Date);
                               RecCount := 0;
                               SQLQuery := 'SELECT * FROM PURCHASE_ORDER_STATUS WHERE ORDERNO = ''' + Rec."Document No." + ''' AND ORDER_LINE_NO = ' + FORMAT(Rec."Line No.") + ' AND ITEMNO = ''' + FORMAT(Rec."No.") +
                                         ''' AND PAYMENT_TYPE = ''' + FORMAT(RecordSet.Fields.Item('TYPE').Value) + '''';
                               RecordSet1 := SQLConnection.Execute(SQLQuery);
                               RecCount := 0;
                               IF NOT ((RecordSet1.BOF) OR (RecordSet1.EOF)) THEN
                                   RecordSet1.MoveFirst;
                               WHILE NOT RecordSet1.EOF DO BEGIN
                                   SQLQuery := 'UPDATE PURCHASE_ORDER_STATUS SET PAYMENT_REALISATION_DATE = to_date(''' + FORMAT(Dev_Rcpt_Date, 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy''), ' +
                                             'ACCT_YEAR = ' + FORMAT(AccountYear) + ', ACCTPERIOD = ' + FORMAT(PeriodNum) + ', REASON = ''' + DELCHR(FORMAT(Rec.Remarks), '=', ',') + ''' WHERE ORDERNO = ''' + Rec."Document No." +
                                             ''' AND ORDER_LINE_NO = ' + FORMAT(Rec."Line No.") + ' AND ITEMNO = ''' + Rec."No." + ''' AND PAYMENT_TYPE = ''' + FORMAT(RecordSet.Fields.Item('TYPE').Value) + '''';
                                   SQLConnection.Execute(SQLQuery);
                                   RecordSet1.MoveNext;
                                   RecCount := RecCount + 1;
                               END;
                               IF RecCount = 0 THEN BEGIN
                                   SQLQuery := 'INSERT INTO PURCHASE_ORDER_STATUS (STATUS_ID,ORDERNO,PAYMENT_TYPE,REASON,ITEMNO,ORDER_LINE_NO,CONSIDER_TAX,PAYMENT_REALISATION_DATE,ACCTPERIOD,ACCT_YEAR,CREATION_DATE) VALUES ' +
                                             ' (Seq_Status_ID.Nextval,''' + Rec."Document No." + ''',''' + FORMAT(RecordSet.Fields.Item('TYPE').Value) + ''',''' + DELCHR(FORMAT(Rec.Remarks), '=', ',') + ''',''' +
                                             FORMAT(Rec."No.") + ''',''' + FORMAT(Rec."Line No.") + ''',' + ConsiderTax + ',to_date(''' + FORMAT(Dev_Rcpt_Date, 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy''),' +
                                             FORMAT(PeriodNum) + ',' + FORMAT(AccountYear) + ',sysdate)';
                                   SQLConnection.Execute(SQLQuery);
                               END;
                               RecordSet.MoveNext;
                           END;
                           SQLConnection.CommitTrans;
                           RecordSet.Close;
                           SQLConnection.Close;
                           // End--Added by Pranavi on 31-Jan-2017 for Advance & COD plan_changes
                           */
                               //<< ORACLE UPG
                    END;

                end;
            }
            field("Vendor Mat. Dispatch Date"; Rec."Vendor Mat. Dispatch Date")
            {
                ApplicationArea = All;
            }
            field("Mat. Dispatched"; Rec."Mat. Dispatched")
            {
                ApplicationArea = All;
            }
            field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
            {
                Editable = true;
                Enabled = true;
                ApplicationArea = All;
            }
            field("AMC Order"; Rec."AMC Order")
            {
                ApplicationArea = All;
            }
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;
            }

            /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
              {
                  ApplicationArea = All;
              }*/
            field("Frieght Charges"; Rec."Frieght Charges")
            {
                ApplicationArea = All;
            }
            field("Indent No."; Rec."Indent No.")
            {
                Editable = true;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //ADDED BY VISHNU PRIYA ON 06-07-2019
                    IL.RESET;
                    IL.SETCURRENTKEY(IL."Document No.", IL."Line No.");
                    IL.SETFILTER("Document No.", Rec."Indent No.");
                    IL.SETRANGE("No.", Rec."No.");
                    IF IL.FINDFIRST THEN BEGIN
                        Rec."Indent Line No." := IL."Line No.";
                        Rec.MODIFY;
                    END
                    ELSE
                        ERROR('You Can not Pick that Indent because the items in the Indent Line and Purchase Line are not same');
                end;
            }
        }

        addafter("Purchase Orders")
        {
            field(Quote; Rec.Quote)
            {
                ApplicationArea = All;
            }
        }
        addafter("IC Partner Reference")
        {
            /*field("Tax %"; "Tax %")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }*/
        }
        addafter("VAT Prod. Posting Group")
        {
            /*  field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
              {
                  ApplicationArea = All;
              }*/
            field("Customs Duty Value"; Rec."Customs Duty Value")
            {
                Visible = "Customs Duty ValueVisible";
                ApplicationArea = All;
            }
            field("Customs Duty Paid to"; Rec."Customs Duty Paid to")
            {
                Visible = "Customs Duty Paid toVisible";
                ApplicationArea = All;
            }
            field("Customs To be Paid on"; Rec."Customs To be Paid on")
            {
                Visible = "Customs To be Paid onVisible";
                ApplicationArea = All;
            }
            /*field("Amount To Vendor"; "Amount To Vendor")
            {
                ApplicationArea = All;
            }*/
            field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
            {
                ApplicationArea = All;
            }
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }

        addafter("Quantity Invoiced")
        {
            field("QC Enabled"; Rec."QC Enabled")
            {
                Editable = true;
                ApplicationArea = All;
            }
            /* field("Excise Amount"; "Excise Amount")
             {
                 ApplicationArea = All;

             }*/
            field("Material Received at Site"; Rec."Material Received at Site")
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Item Charge Assignment")
        {
            field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
            {
                ApplicationArea = All;

            }
        }
        addafter("Qty. Assigned")
        {
            /*field("GST %"; "GST %")
            {
                ApplicationArea = All;

            }*/ //B2BUPG
        }
        addafter(ShortcutDimCode8)
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("ICN No."; Rec."ICN No.")
            {
                ApplicationArea = All;
            }
            field("Indent Line No."; Rec."Indent Line No.")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field(Sample; Rec.Sample)
            {
                ApplicationArea = All;
            }
            field("Safety Lead Time"; Rec."Safety Lead Time")
            {
                ApplicationArea = All;
            }
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("Tax Liable"; Rec."Tax Liable")
            {
                ApplicationArea = All;
            } */
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. Rcd. Not Invoiced (Base)"; Rec."Qty. Rcd. Not Invoiced (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Part Number"; Rec."Part Number")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("TDS Group"; "TDS Group")
             {
                 ApplicationArea = All;

             }
             field("Tax Base Amount"; "Tax Base Amount")
             {
                 ApplicationArea = All;

             }
             field("TDS %"; "TDS %")
             {
                 ApplicationArea = All;

             }*/
            /*field("TDS Category"; "TDS Category")
            {
                ApplicationArea = All;

            }
            field("Assessee Code"; "Assessee Code")
            {
                ApplicationArea = All;

            }*/
            field("GST Reverse Charge"; "GST Reverse Charge")
            {
                Editable = true;
                ApplicationArea = All;
            }
            /* field("TDS Amount"; "TDS Amount")
             {
                 ApplicationArea = All;
             }
             field("Tax Amount"; "Tax Amount")
             {
                 ApplicationArea = All;
             }*/
        }

        moveafter("No."; Description)
        moveafter(Description; "Description 2")
        moveafter("Description 2"; Quantity)

    }
    actions
    {

        addbefore("F&unctions")
        {
            group("I&nspection")
            {
                Caption = 'I&nspection';
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.Page.*/
                        _ShowDataSheets;

                    end;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.Page.*/
                        _ShowPostDataSheets;

                    end;
                }
                action("Inspection &Receipts")
                {
                    Caption = 'Inspection &Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.Page.*/
                        _ShowInspectReceipt;

                    end;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                        /*CurrPage.PurchLines.Page.*/
                        _ShowPostInspectReceipt;

                    end;
                }
                action("Cancel Inspection")
                {
                    Caption = 'Cancel Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                    begin
                        IF CONFIRM(Text33000260, FALSE) THEN BEGIN
                            QualityStatusValue := 'Cancel';
                            CancelInspection1(QualityStatusValue);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                action("Short Close Inspection")
                {
                    Caption = 'Short Close Inspection';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        QualityStatusValue: Text[50];
                    begin
                        IF CONFIRM(Text33000261, FALSE) THEN BEGIN
                            QualityStatusValue := 'Close';
                            CloseInspection1(QualityStatusValue);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
            }
            action("Sample Lot Inspection")
            {
                Caption = 'Sample Lot Inspection';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                    /*CurrPage.PurchLines.Page.*/
                    _SampleLotInspection;

                end;
            }
        }
        addafter(OrderTracking)
        {
            action("&Attachments")
            {
                Caption = '&Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //This functionality was copied from page #50. Unsupported part was commented. Please check it.
                    /*CurrPage.PurchLines.Page.*/
                    OpenAttachments;

                end;
            }
        }
        addafter("Sales &Order")
        {
            action("Split Qty")
            {
                Caption = 'Split Qty';
                ApplicationArea = All;

                trigger OnAction();
                var
                    PurchHeader: Record "Purchase Header";
                begin
                    //TESTFIELD(s,Status::Released);
                    //ERROR('Please Contact ERP Team');
                    PurchHeader.RESET;
                    PurchHeader.SETRANGE("No.", Rec."Document No.");
                    IF PurchHeader.FINDSET THEN BEGIN
                        IF PurchHeader.Status = PurchHeader.Status::Released THEN
                            ERROR('Reopen the PO to Split the Qty')
                    END;
                    "G\L".GET;
                    IF "G\L"."Active ERP-CF Connection" THEN BEGIN
                        Split_Qty;
                    END;
                    // CalculateStructures(PurchHeader);
                    //Commented by Vishnu Priya on 08-11-2018
                    //CashFlowUpdation;

                    //MESSAGE('Release the Order to Complete the Split');
                end;
            }
            action("QC Override")
            {
                Caption = 'QC Override';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    QCOverride;
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(Deviations)
            {
                Caption = 'Deviations';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    "Show Deviations & Reasons";
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        DescriptionEditable := TRUE;
    end;

    trigger OnAfterGetRecord()
    begin
        itm_clr_flg := FALSE;
        ten_percent_item_Cost_high_chk;
        OnAfterGetCurrRecordCust;//EFFUPG
        NoOnFormat;
        DescriptionEditable := TRUE;

        //added by Vishnu on 09-07-2020

        /* PH.RESET;
        PH.SETFILTER("No.", Rec."Document No.");
        IF PH.FINDFIRST THEN BEGIN
        IF (PH.Mail_count > 0) AND (Rec.Make <> '') THEN
        Make_edit := FALSE
        ELSE
        Make_edit := TRUE;
        END */

        //Old Code for make modifications
        //end by Vishnu Priya

        //Added by Vishnu Priya on 12-09-2020
        FindCnt := 0;
        PRH.RESET;
        PRH.SETCURRENTKEY("Order No.");
        PRH.SETFILTER("Order No.", Rec."Document No.");
        IF PRH.FINDSET THEN
            REPEAT
            BEGIN
                PRL.RESET;
                PRL.SETFILTER("Document No.", PRH."No.");
                PRL.SETRANGE("Line No.", Rec."Line No.");
                PRL.SETRANGE(Correction, FALSE); // to eliminate the Undo Receipts of the inward
                PRL.SETFILTER(Quantity, '>%1', 0);
                IF PRL.FINDFIRST THEN
                    FindCnt := FindCnt + 1;
            END
            UNTIL PRH.NEXT = 0;

        IF FindCnt > 1 THEN
            Make_edit := FALSE
        ELSE
            Make_edit := TRUE;

        //ended by Vishnu Priya on 12-09-2020
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecordCust;//EFFUPG
    end;

    trigger OnAfterGetCurrRecord()
    begin
        itm_clr_flg := FALSE;
        ten_percent_item_Cost_high_chk;
    end;

    var
        ItemVendor: Record "Item Vendor";
        PurchaseOrder: Page 50;
        "Excepted Rcpt.Date Tracking": Record "Excepted Rcpt.Date Tracking";
        GPS: Record "General Posting Setup";
        ITEM: Record Item;
        CashFlowConnection: Codeunit "Cash Flow Connection";
        dum: array[10] of Decimal;
        "No.OfLine": Integer;
        pl: Record "Purchase Line";
        "Second Line No": Integer;
        i: Integer;
        gap: Integer;
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        RCNT: Integer;
        "G|l": Record "General Ledger Setup";
        "Payment Terms": Record "Payment Terms";
        pt: Code[10];
        POST: Boolean;
        PT_STAGE1: Option Advance,COD;
        PT_STAGE2: Option Advance,COD;
        t1: Label 'Please Enter the Quantity #1########';
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        //IV: Record "Item Variant";//EFFUPG
        IV: Record "Item Variant Cust";//EFFUPG
        Make2: Record Make;
        MOQ_Temp: Decimal;
        DescriptionEditable: Boolean;
        "No.Emphasize": Boolean;
        "Customs Duty Paid toVisible": Boolean;
        "Customs To be Paid onVisible": Boolean;
        "Customs Duty ValueVisible": Boolean;
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        RecordSet1: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        Text33000260: Label 'Do you want to Cancel Quality Inspection?';
        Text33000261: Label 'Do you want to Close Quality Inspection?';
        "G\L": Record "General Ledger Setup";
        GetSplitQtyPar: Report "Get Split Qty";
        PeriodNum: Integer;
        AccountYear: Integer;
        ConsiderTax: Code[10];
        RecCount: Integer;

        Dev_Rcpt_Date: Date;
        PaymentTerm: Record "Payment Terms";
        itm_clr_flg: Boolean;
        Pur_line: Record "Purchase Line";
        ten_percent_cost: Decimal;
        items_list_cost: array[100, 3] of Code[30];
        LoopVar: Integer;
        options_itm_cost: Text;
        itm_loop: Integer;
        PH: Record "Purchase Header";
        IL: Record "Indent Line";
        Make_edit: Boolean;
        PRH: Record "Purch. Rcpt. Header";
        PRL: Record "Purch. Rcpt. Line";
        FindCnt: Decimal;
        IDH: Record "Inspection Datasheet Header";
        PIDH: Record "Posted Inspect DatasheetHeader";




    procedure _ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        ShowDataSheets;
    end;



    procedure _ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        ShowPostDataSheets;
    end;



    procedure _ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        ShowInspectReceipt;
    end;

    PROCEDURE _ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        ShowPostInspectReceipt;
    END;


    procedure "---B2B---"();
    begin
    end;




    procedure OpenAttachments();
    var
        Attachment: Record Attachments;
    begin
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", DATABASE::"Purchase Header");
        Attachment.SETRANGE("Document No.", "Document No.");
        Attachment.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", Attachment);
    end;


    procedure CancelInspection1(var QualityStatus: Text[50]);
    begin
        TESTFIELD("No.");
        TESTFIELD("QC Enabled");
        CancelInspection(QualityStatus);
    end;

    procedure CloseInspection1(var QualityStatus: Text[50]);
    begin
        TESTFIELD("No.");
        TESTFIELD("QC Enabled");
        CloseInspection(QualityStatus);
    end;

    procedure _SampleLotInspection();
    var
        SampleLotInspection: Record "Sample Lot Inspection";
    begin
        TESTFIELD("QC Enabled");
        //TESTFIELD("Quality Before Receipt");
        //"Sample Lot Inspection" := TRUE;
        SampleLotInspection.SETRANGE("Purchase Order No.", "Document No.");
        SampleLotInspection.SETRANGE("Purchase Line No.", "Line No.");
        SampleLotInspection.SETRANGE(Quantity, Quantity);
        PAGE.RUN(60072, SampleLotInspection);
    end;

    procedure SampleLotInspection();
    var
        SampleLotInspection: Record "Sample Lot Inspection";
    begin
        TESTFIELD("QC Enabled");
        //TESTFIELD("Quality Before Receipt");
        //"Sample Lot Inspection" := TRUE;
        SampleLotInspection.SETRANGE("Purchase Order No.", "Document No.");
        SampleLotInspection.SETRANGE("Purchase Line No.", "Line No.");
        SampleLotInspection.SETRANGE(Quantity, Quantity);
        PAGE.RUN(60072, SampleLotInspection);
    end;



    procedure Getperiod(perioddate: Date) periodnumber: Integer;
    var
        periodNo1: Integer;
        periodDay: Integer;
        periodMonth: Integer;
        periodYear: Integer;
        acctYearMonth: Integer;
        MonthDays: Integer;
        cDay1: Integer;
        cDay2: Integer;
        cDay3: Integer;
        cDay4: Integer;
        cDay5: Integer;
    begin
        periodDay := DATE2DMY(perioddate, 1);
        periodMonth := DATE2DMY(perioddate, 2);
        periodYear := DATE2DMY(perioddate, 3);
        MonthDays := DATE2DMY(CALCDATE('CM', perioddate), 1);
        cDay1 := 1;
        cDay2 := 8;
        cDay3 := 16;
        cDay4 := 23;
        cDay5 := 24;
        IF periodDay < cDay2 THEN
            periodNo1 := 1
        ELSE
            IF (periodDay >= cDay2) AND (periodDay < cDay3) THEN BEGIN
                periodNo1 := 2
            END ELSE BEGIN
                IF MonthDays = 31 THEN BEGIN
                    IF (periodDay >= cDay3) AND (periodDay < cDay5) THEN
                        periodNo1 := 3
                    ELSE
                        periodNo1 := 4;
                END ELSE BEGIN
                    IF (periodDay >= cDay3) AND (periodDay < cDay4) THEN
                        periodNo1 := 3
                    ELSE
                        periodNo1 := 4;
                END;
            END;
        IF periodMonth < 4 THEN
            acctYearMonth := periodMonth + 9
        ELSE
            acctYearMonth := periodMonth - 3;
        periodnumber := (acctYearMonth * 4) - 4 + periodNo1;
    end;


    procedure "Show Deviations & Reasons"();
    begin
        "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document No.", "Document No.");
        "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document Line No.", "Line No.");
        PAGE.RUNMODAL(60048, "Excepted Rcpt.Date Tracking");
    end;


    procedure Show_Custom_Charges(show: Boolean);
    begin

        IF show THEN BEGIN
            "Customs Duty Paid toVisible" := TRUE;
            "Customs To be Paid onVisible" := TRUE;
            "Customs Duty ValueVisible" := TRUE;
        END ELSE BEGIN
            "Customs Duty Paid toVisible" := FALSE;
            "Customs To be Paid onVisible" := FALSE;
            "Customs Duty ValueVisible" := FALSE;
        END;
    end;


    procedure Split_Qty();
    var
        Base_Qty: Decimal;
        Splitted_Qty: Decimal;
        Qty_Window: Dialog;
        User_Qty: Decimal;
        PurchHeader: Record "Purchase Header";
    begin
        /*IF NOT (USERID  IN ['EFFTRONICS\ANANDA']) THEN
          ERROR('Please Contact ERP Team');*/
        //Rev01
        "G|l".GET;
        IF "G|l"."Active ERP-CF Connection" THEN BEGIN
            IF "Quantity Received" > 0 THEN
                ERROR('THERE IS NO POSSIBILTY FOR SPLITTING THE INWARDED QUANTITY');
            IF Type <> Type::Item THEN
                ERROR('SPLITTING OPTIONS ONLY FOR ITEMS');
            POST := FALSE;
            PurchHeader.SETRANGE(PurchHeader."No.", "Document No.");
            IF PurchHeader.FINDFIRST THEN BEGIN
                "Payment Terms".SETRANGE("Payment Terms"."Update In Cashflow", TRUE);
                IF "Payment Terms".GET(PurchHeader."Payment Terms Code") THEN BEGIN
                    IF (("Payment Terms"."Percentage 1" > 0) AND (("Payment Terms"."Stage 1" = "Payment Terms"."Stage 1"::Advance) OR
                                                                  ("Payment Terms"."Stage 1" = "Payment Terms"."Stage 1"::Delivery)))
                      OR (("Payment Terms"."Percentage 2" > 0) AND (("Payment Terms"."Stage 2" = "Payment Terms"."Stage 2"::Delivery) OR
                                                                 ("Payment Terms"."Stage 2" = "Payment Terms"."Stage 2"::Advance))) THEN BEGIN
                        Splitted_Qty := 0;
                        "No.OfLine" := 0;
                        FOR i := 1 TO 10 DO
                            dum[i] := 0;
                        /* IF ISCLEAR(SQLConnection) THEN
                             CREATE(SQLConnection, FALSE, TRUE); //Rev01

                         IF ISCLEAR(RecordSet) THEN
                             CREATE(RecordSet, FALSE, TRUE);*/ //Rev01

                        WebRecStatus := Quotes + Text50001 + Quotes;
                        OldWebStatus := Quotes + Text50002 + Quotes;
                        /* //>> ORACLE UPG
                        SQLConnection.ConnectionString := "G|l"."Sql Connection String";
                        SQLConnection.Open;
                        SQLQuery := 'SELECT TO_CHAR(COUNT(*)) CNT FROM PURCHASE_ORDER_STATUS WHERE ORDERNO=''' + FORMAT("Document No.") + ''' ' +
                                    ' AND ORDER_LINE_NO=''' + FORMAT("Line No.") + ''' AND STATUS=''Y'' ';
                        // MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery);
                        IF NOT (RecordSet.EOF OR RecordSet.BOF) THEN BEGIN
                            RecordSet.MoveFirst;
                            EVALUATE(RCNT, FORMAT(RecordSet.Fields.Item('CNT').Value));
                            */
                        //<< ORACLE UPG

                        IF RCNT = 1 THEN
                            POST := TRUE;


                        Base_Qty := Quantity;
                        //Rev01 Code commented as inPut
                        WHILE Base_Qty > Splitted_Qty DO BEGIN
                            CLEAR(GetSplitQtyPar);
                            GetSplitQtyPar.RUNMODAL;
                            GetSplitQtyPar.SetQTY(User_Qty);
                            IF User_Qty = 0 THEN
                                MESSAGE('PLEASE ENTER THE QUNTITY')
                            ELSE
                                IF Base_Qty < Splitted_Qty + User_Qty THEN BEGIN
                                    User_Qty := 0;
                                    MESSAGE('YOU ENTERED THE QUANTITY MORE THAN PREVIOUS QUANITY');
                                END ELSE BEGIN
                                    Splitted_Qty += User_Qty;
                                    "No.OfLine" += 1;
                                    IF "No.OfLine" > 10 THEN
                                        ERROR('you are exceeding the limit')
                                    ELSE
                                        dum["No.OfLine"] := User_Qty;
                                    User_Qty := 0;
                                END;
                        END;

                        /*
                         Qty_Window.OPEN(t1);
                        WHILE Base_Qty>Splitted_Qty DO
                        BEGIN
                          Qty_Window.INPUT(1,User_Qty);
                          IF User_Qty=0 THEN
                             MESSAGE('PLEASE ENTER THE QUNTITY')
                          ELSE IF Base_Qty<Splitted_Qty+User_Qty  THEN
                          BEGIN
                            User_Qty :=0;
                            MESSAGE('YOU ENTERED THE QUANTITY MORE THAN PREVIOUS QUANITY');
                          END ELSE
                          BEGIN
                            Splitted_Qty+=User_Qty;
                            "No.OfLine"+=1;
                            IF "No.OfLine">10 THEN
                               ERROR('you are exceeding the limit')
                            ELSE
                              dum["No.OfLine"]:=User_Qty;
                              User_Qty :=0;
                          END;
                        END;
                        Qty_Window.CLOSE;
                        *///Rev01 Code commented as inPut

                        IF "No.OfLine" > 0 THEN BEGIN
                            pl.RESET;
                            pl.SETRANGE(pl."Document No.", "Document No.");
                            pl.SETFILTER(pl."Line No.", '>%1', "Line No.");
                            IF pl.FINDFIRST THEN
                                "Second Line No" := pl."Line No.";

                            IF "Second Line No" > 0 THEN
                                gap := ROUND(("Second Line No" - "Line No.") / "No.OfLine", 1)
                            ELSE
                                IF gap = 0 THEN
                                    gap := 10000;
                            //SQLConnection.BeginTrans; //>> ORACLE UPG
                            FOR i := 2 TO "No.OfLine" DO BEGIN
                                pl.INIT;
                                pl.COPY(Rec);
                                pl."Document Type" := pl."Document Type"::Order;
                                pl."Document No." := "Document No.";
                                pl."Line No." := "Line No." + (i - 1) * gap;
                                pl.Quantity := dum[i];
                                pl."Outstanding Quantity" := dum[i];
                                pl."Qty. to Invoice" := dum[i];
                                pl."Qty. to Receive" := dum[i];
                                pl.Amount := dum[i] * pl."Direct Unit Cost";
                                pl."Quantity (Base)" := dum[i];
                                pl."Outstanding Qty. (Base)" := dum[i];
                                pl."Qty. to Invoice (Base)" := dum[i];
                                pl."Qty. to Receive (Base)" := dum[i];
                                pl.VALIDATE("Direct Unit Cost", pl."Direct Unit Cost");
                                IF POST THEN BEGIN
                                    IF "Payment Terms"."Stage 1" = "Payment Terms"."Stage 1"::Advance THEN
                                        PT_STAGE1 := PT_STAGE1::Advance
                                    ELSE
                                        PT_STAGE1 := PT_STAGE1::COD;
                                    IF "Payment Terms"."Stage 2" = "Payment Terms"."Stage 2"::Advance THEN
                                        PT_STAGE2 := PT_STAGE2::Advance
                                    ELSE
                                        PT_STAGE2 := PT_STAGE2::COD;
                                    //>> ORACLE UPG

                                    /*
                                                                        SQLQuery := 'INSERT INTO PURCHASE_ORDER_STATUS (STATUS_ID,ORDERNO,PAYMENT_TYPE,AUTHORISATION,REASON' +
                                                                                   ',ITEMNO,ORDER_LINE_NO,CONSIDER_TAX,STATUS) VALUES (Seq_Status_ID.Nextval,''' + "Document No." + ''',''' +
                                                                                   FORMAT(PT_STAGE1) + ''',0,''SPLITTED'',''' +
                                                                                   FORMAT("No.") + ''',''' +
                                                                                   FORMAT(pl."Line No.") + ''',0,''Y'')';
                                                                        SQLConnection.Execute(SQLQuery);
                                                                        IF (("Payment Terms"."Stage 1" = "Payment Terms"."Stage 1"::Advance) AND
                                                                           ("Payment Terms"."Stage 2" = "Payment Terms"."Stage 2"::Advance)) OR
                                                                           (("Payment Terms"."Stage 1" = "Payment Terms"."Stage 1"::Delivery) AND
                                                                           ("Payment Terms"."Stage 2" = "Payment Terms"."Stage 2"::Delivery)) THEN BEGIN
                                                                            SQLQuery := 'INSERT INTO PURCHASE_ORDER_STATUS (STATUS_ID,ORDERNO,PAYMENT_TYPE,' +
                                                                                      'ITEMNO,ORDER_LINE_NO,CONSIDER_TAX) VALUES (Seq_Status_ID.Nextval,''' + "Document No." + ''',''' +
                                                                                      FORMAT(PT_STAGE2) + ''',''' +
                                                                                      FORMAT("No.") + ''',''' +
                                                                                      FORMAT(pl."Line No.") + ''',1)';
                                                                            SQLConnection.Execute(SQLQuery);
                                                                        END;
                                                                        */ //<< ORACLE UPG
                                END;
                                pl.INSERT;
                            END;
                        END;
                        // SQLConnection.CommitTrans; //>> ORACLE UPG
                        Quantity := dum[1];
                        pl."Outstanding Quantity" := dum[1];
                        "Qty. to Invoice" := dum[1];
                        "Qty. to Receive" := dum[1];
                        Amount := dum[1] * "Direct Unit Cost";
                        "Quantity (Base)" := dum[1];
                        "Outstanding Qty. (Base)" := dum[1];
                        "Qty. to Invoice (Base)" := dum[1];
                        "Qty. to Receive (Base)" := dum[1];
                        VALIDATE("Direct Unit Cost", "Direct Unit Cost");
                        MODIFY;
                    END ELSE BEGIN
                        // SQLConnection.Close;
                        ERROR('THERE IS NO PROVISION FOR FOLLOWING PAYMENT TERMS');
                    END;
                END ELSE BEGIN
                    //  SQLConnection.Close; COMMENTED BY SUNDAR
                    ERROR('THERE IS NO PROVISION FOR FOLLOWING PAYMENT TERMS');
                END;
            END ELSE BEGIN
                ERROR(' PAYMENT TERMS CODE IS NOT UPDATED IN THE CASH FLOW');
            END;
        END ELSE
            ERROR(' THERE IS NO PURCHASE ORDER');
    END;
    //Rev01

    //end;


    local procedure TypeOnAfterValidate();
    begin
        IF Type = Type::Item THEN
            DescriptionEditable := FALSE
        ELSE
            DescriptionEditable := TRUE;
    end;


    local procedure OnAfterGetCurrRecordCust();
    begin
        xRec := Rec;
        IF Type = Type::Item THEN
            DescriptionEditable := FALSE
        ELSE
            DescriptionEditable := TRUE;
    end;


    local procedure DeviatedReceiptDateOnAfterInpu(var Text: Text[1024]);
    begin

        IF FORMAT("Deviated Receipt Date") = '' THEN
            ERROR('You Dont Have to Delete the Deviated Date');
    end;


    local procedure DeviatedReceiptDateOnInputChan(var Text: Text[1024]);
    begin

        IF Remarks = '' THEN
            MESSAGE('Please Enter the Remarks')
        ELSE BEGIN
            "Excepted Rcpt.Date Tracking".INIT;
            "Excepted Rcpt.Date Tracking"."Entry No." := "Excepted Rcpt.Date Tracking".COUNT + 1;
            "Excepted Rcpt.Date Tracking"."Document No." := "Document No.";

            //"Excepted Rcpt.Date Tracking"."Document Type" := Rec."Document Type";//EFFUPG
            "Excepted Rcpt.Date Tracking"."Document Type" := "Excepted Rcpt.Date Tracking"."Document Type"::Order;//EFFUPG
            "Excepted Rcpt.Date Tracking"."Document Line No." := "Line No.";
            "Excepted Rcpt.Date Tracking"."Item No." := "No.";
            "Excepted Rcpt.Date Tracking"."Deviated By" := "Deviated By";
            "Excepted Rcpt.Date Tracking"."User Id" := USERID;
            "Excepted Rcpt.Date Tracking"."Modified Date" := TODAY;
            IF "Deviated Receipt Date" > 0D THEN
                "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date" := "Deviated Receipt Date"
            ELSE
                "Excepted Rcpt.Date Tracking"."Excepted Receipt Old Date" := "Expected Receipt Date";
            "Excepted Rcpt.Date Tracking".Reason := Remarks;
        END;
    end;


    local procedure NoOnFormat();
    begin
        IF ("Document Type" = 2) AND ("No." <> '') THEN
            ITEM.GET("No.");
        IF FORMAT(ITEM."Item Status") = 'Obsolete' THEN BEGIN
            "No.Emphasize" := TRUE;
        END ELSE BEGIN
            "No.Emphasize" := FALSE;
        END;
    end;




    procedure ActPeriodActYearCalc(Req_Date: Date);
    var
        cDay: Integer;
        cMonth: Integer;
        cYear: Integer;
        cDay1: Integer;
        cDay2: Integer;
        cDay3: Integer;
        cDay4: Integer;
        cDay5: Integer;
        PeriodNo: Integer;
        AccountYearMonth: Integer;
        ShipmentDate: Text;
    begin
        //MESSAGE('Calculating Act Period and Act Year!');
        cDay1 := 1;
        cDay2 := 8;
        cDay3 := 16;
        cDay4 := 23;
        cDay5 := 24;
        ShipmentDate := '';
        PeriodNum := 0;
        AccountYear := 0;
        ShipmentDate := FORMAT(Req_Date, 0, '<Day>-<Month Text,3>-<Year4>');
        cDay := DATE2DMY(Req_Date, 1);
        cMonth := DATE2DMY(Req_Date, 2);
        cYear := DATE2DMY(Req_Date, 3);
        IF cMonth < 4 THEN BEGIN
            AccountYear := cYear - 1;
            AccountYearMonth := cMonth + 9;
        END
        ELSE BEGIN
            AccountYear := cYear;
            AccountYearMonth := cMonth - 3;
        END;
        IF cDay < cDay2 THEN
            PeriodNo := 1
        ELSE
            IF (cDay >= cDay2) AND (cDay < cDay3) THEN
                PeriodNo := 2
            ELSE BEGIN
                //MESSAGE(FORMAT(DATE2DMY(CALCDATE('CM',DMY2DATE(1,cMonth,cYear)),1)));
                IF DATE2DMY(CALCDATE('CM', DMY2DATE(1, cMonth, cYear)), 1) = 31 THEN BEGIN
                    IF (cDay >= cDay3) AND (cDay < cDay5) THEN
                        PeriodNo := 3
                    ELSE
                        PeriodNo := 4
                END
                ELSE BEGIN
                    IF (cDay >= cDay3) AND (cDay < cDay4) THEN
                        PeriodNo := 3
                    ELSE
                        PeriodNo := 4
                END;
            END;
        IF Req_Date = TODAY() THEN
            PeriodNum := 0
        ELSE
            PeriodNum := (AccountYearMonth * 4) - 4 + PeriodNo;
        // MESSAGE('Act Period: '+FORMAT(PeriodNum)+' Act Year: '+FORMAT(AccountYear));
    end;


    local procedure CashFlowUpdation();
    var
        "Packing Value": Decimal;
        "Payment Terms": Record "Payment Terms";
        Frieght_Value: Decimal;
        Insurance_Value: Decimal;
        Additional_Duty: Decimal;
        Service_Amount: Decimal;
        PurchHeader: Record "Purchase Header";
        //Structure_Order_Details: Record "Structure Order Details";
        Packing_Calculation: Boolean;
        Unit_Cost: Decimal;
        Line_Amount: Decimal;
        "G\L": Record "General Ledger Setup";
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
 */
        //<< ORACLE UPG

        SQLQuery: Text[1000];

        LineSQLQuery: Text[250];
        PurchLine: Record "Purchase Line";
        GST_AMOUNT: Decimal;
        VAT_AMOUNT: Decimal;
        CST_AMOUNT: Decimal;
        Dept: Code[10];
    //  StructureOrderLineDetails: Record "Structure Order Line Details";
    begin
        /* 
        CashFlowConnection.ExecInOracle('Update Purchase_line Set Actinact=0 Where  OrderNo=''' + PurchHeader."No." + '''');
        "Packing Value" := 0;
        PurchLine.CALCFIELDS(PurchLine."Document Date");
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchHeader."No.");
        PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
        PurchLine.SETFILTER(PurchLine.Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                    "G\L".GET;
                IF "G\L"."Active ERP-CF Connection" AND (PurchHeader."Order Date" >= DMY2Date(02, 01, 10)) THEN //
                BEGIN

                    "Packing Value" := 0;
                    Frieght_Value := 0;
                    Insurance_Value := 0;
                    Additional_Duty := 0;
                    Service_Amount := 0;
                    Line_Amount := 0;
                    Unit_Cost := 0;
                    StructureOrderLineDetails.RESET;
                     StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                     StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document No.", PurchLine."Document No.");
                     StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Line No.", PurchLine."Line No.");
                     StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                     IF StructureOrderLineDetails.FINDSET THEN
                             REPEAT
                                 IF ((StructureOrderLineDetails."Tax/Charge Group" = 'PACKING') OR
                                    (StructureOrderLineDetails."Tax/Charge Group" = 'FORWARDING')) THEN BEGIN

                                     "Packing Value" += StructureOrderLineDetails."Amount (LCY)";
                                 END ELSE
                                     IF StructureOrderLineDetails."Tax/Charge Group" = 'FREIGHT' THEN BEGIN
                                         Frieght_Value += StructureOrderLineDetails."Amount (LCY)";
                                     END ELSE
                                         IF StructureOrderLineDetails."Tax/Charge Group" = 'CUSTOMS DU' THEN BEGIN
                                             Frieght_Value += StructureOrderLineDetails."Amount (LCY)";
                                         END ELSE

                                             IF StructureOrderLineDetails."Tax/Charge Group" = 'INSURANCE' THEN BEGIN
                                                 Insurance_Value += StructureOrderLineDetails."Amount (LCY)";
                                             END ELSE
                                                 IF StructureOrderLineDetails."Tax/Charge Group" = 'ADD.DUTY' THEN
                                                     Additional_Duty += StructureOrderLineDetails."Amount (LCY)"
                                                 ELSE
                                                     IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                                         Service_Amount += StructureOrderLineDetails."Amount (LCY)";

                             UNTIL StructureOrderLineDetails.NEXT = 0;
                    // END;
                    IF PurchLine."Currency Code" = '' THEN BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost";
                        Line_Amount := PurchLine.Quantity * PurchLine."Direct Unit Cost";
                    END ELSE BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost" / PurchHeader."Currency Factor";
                        Line_Amount := (PurchLine.Quantity * PurchLine."Direct Unit Cost") / PurchHeader."Currency Factor";

                    END;
                    IF PurchLine."Line Discount Amount" > 0 THEN
                        Additional_Duty -= PurchLine."Line Discount Amount";
                    IF (PurchLine."Frieght Charges" > 0) THEN BEGIN
                        IF PurchLine."Currency Code" = '' THEN
                            Frieght_Value := PurchLine."Frieght Charges"
                        ELSE
                            Frieght_Value := PurchLine."Frieght Charges" / PurchHeader."Currency Factor";
                    END;
                    IF ((PurchHeader.Structure = 'PURCH_GST') OR (PurchHeader.Structure = 'PUR_FR_GST')) THEN
                        GST_AMOUNT := PurchLine."Total GST Amount"
                    ELSE
                        IF (PurchLine."Tax Area Code" = 'PURH VAT') THEN
                            VAT_AMOUNT := PurchLine."Tax Amount"
                        ELSE
                            CST_AMOUNT := PurchLine."Tax Amount";
                    IF PurchLine."Location Code" = 'CS STR' THEN
                        Dept := 'CS'
                    ELSE
                        Dept := 'NORMAL';
                    // added by sujani on 10-Oct-18 to avoid duplicate entries in cashflow while splitting the order
                    IF (PurchLine.Sample = FALSE) THEN
                        CashFlowConnection.ExecInOracle('Update Purchase_line Set ACTINACT=0 Where  OrderNo=''' + PurchHeader."No." + ''' and Order_line_no = ''' + FORMAT(PurchLine."Line No.") + '''');
                    IF (PurchLine.Sample = FALSE) THEN
                        CashFlowConnection.ExecInOracle('insert into Purchase_line' +
                                                        '(PURCHASE_ID,ORDERNO,ITEMNO,VENDORID,UNIT_COST,UNITS_REQ,DEVIATED_DATE,ORDER_RELEASE_DATE,' +
                                                        ' VAT,EXCISE,CST,PAYMENT_TERMS_CODE,ORDER_VALUE,PACKING_COST,ORDER_LINE_NO,SERVICE_AMOUNT,' +
                                                        'INSURANCE_VALUE,FRIEGHT_CHARGES,ADD_DUTY,LOCATION_CODE,DEPT_WISE,ACTINACT)' +
                                                        'values (seq_Purchase_ID.nextval,''' + PurchLine."Document No." + ''', ''' + PurchLine."No." + ''',''' +
                                                        Rec."Buy-from Vendor No." + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Unit_Cost, 0.001))) + ''',''' +
                                                        CommaRemoval(FORMAT(PurchLine.Quantity)) + ''',''' +
                                                        FORMAT(PurchLine."Deviated Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        FORMAT(DT2DATE(PurchHeader."Release Date Time"), 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        // CommaRemoval(FORMAT(ROUND(VAT_AMOUNT,0.01)))+''','''+
                                                        CommaRemoval(FORMAT(ROUND(GST_AMOUNT, 0.01))) + ''',''' +
                                                        // CommaRemoval(FORMAT(ROUND(PurchLine."Excise Amount", 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(CST_AMOUNT, 0.01))) + ''',''' +
                                                        FORMAT(PurchHeader."Payment Terms Code") + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Line_Amount, 0.001))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND("Packing Value", 0.001))) + ''',''' +
                                                        FORMAT(PurchLine."Line No.") + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Service_Amount, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Insurance_Value, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Frieght_Value, 0.01))) + ''',''' +
                                                        CommaRemoval(FORMAT(ROUND(Additional_Duty, 0.01))) + ''',''' +
                                                        PurchLine."Location Code" + ''',''' +
                                                        Dept + ''',1)');
                    //  MESSAGE(FORMAT(ROUND(Line_Amount,0.001)));
                END;
            UNTIL PurchLine.NEXT = 0;
            */
    end;


    procedure CommaRemoval(Base: Text[30]) Converted: Text[30];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;

    procedure ten_percent_item_Cost_high_chk();
    begin
        Pur_line.RESET;
        Pur_line.SETFILTER("Document No.", '<%1', Rec."Document No.");
        Pur_line.SETRANGE("No.", Rec."No.");
        Pur_line.SETRANGE(Type, Type::Item);
        Pur_line.SETFILTER("Outstanding Quantity", '>%1', 0);
        IF Pur_line.FINDLAST THEN
            REPEAT
            BEGIN
                ten_percent_cost := (Pur_line."Direct Unit Cost" * 0.1);
                ten_percent_cost := ten_percent_cost + Pur_line."Direct Unit Cost";
                IF Rec."Direct Unit Cost" > ten_percent_cost THEN BEGIN
                    itm_clr_flg := TRUE;
                    //true
                END
                ELSE
                    //false
                  itm_clr_flg := FALSE;
            END;
            UNTIL Pur_line.NEXT = 0
        ELSE
            itm_clr_flg := FALSE;
    end;
}

