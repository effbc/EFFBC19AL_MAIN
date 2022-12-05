pageextension 70184 SalesJournalExt extends 253
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        }
        modify(Control28)
        {
            ShowCaption = false;
        }
        modify(Control1902205001)
        {
            ShowCaption = false;
        } */
        modify("Debit Amount")
        {
            Visible = false;
        }
        modify("Credit Amount")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
            Visible = false;
        }
        modify("Applies-to Doc. No.")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = true;
            Editable = true;
        }
        modify("Posting Date")
        {
            trigger OnBeforeValidate()
            begin
                IF "Posting Date" <= 20220331D THEN
                    ERROR('You Can''t'' Post the transaction')
            end;

        }
        addafter("Currency Code")
        {
            field("Currency Factor"; "Currency Factor")
            {
                Editable = true;
                ApplicationArea = all;
            }
        }
        addafter("Document No.")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    IF (Rec."Payment Type" = Rec."Payment Type"::"Final Payment") OR (Rec."Payment Type" = Rec."Payment Type"::Receipt) OR
                       (Rec."Payment Type" = Rec."Payment Type"::Advance) THEN
                        "Cheque Date" := Rec."Posting Date";
                end;
            }
            field("Sale Order No"; Rec."Sale Order No")
            {
                ApplicationArea = All;

                trigger OnLookup(var Text: Text): Boolean;
                begin
                    Salinv.RESET;
                    IF PAGE.RUNMODAL(60219, Salinv) = ACTION::LookupOK THEN BEGIN
                        Rec."Sale Order No" := Salinv."No.";
                        Rec.MODIFY;
                    END;
                end;
            }
            field("Final Bill Payment"; Rec."Final Bill Payment")
            {
                ApplicationArea = All;
            }
            field("Sale invoice order no"; Rec."Sale invoice order no")
            {
                Caption = 'Sale invoice no';
                Visible = false;
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    "sales invoice header".RESET;
                    "sales invoice header".SETFILTER("sales invoice header"."No.", Rec."Sale invoice order no");
                    IF "sales invoice header".FINDFIRST THEN BEGIN
                        Rec."Customer Ord no" := "sales invoice header"."Customer OrderNo.";
                        Rec."Sale Order No" := "sales invoice header"."Order No."
                    END;
                end;
            }
            field("Sale Invoice No"; Rec."Sale Invoice No")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    "sales invoice header".RESET;
                    "sales invoice header".SETFILTER("sales invoice header"."No.", Rec."Sale Invoice No");
                    IF "sales invoice header".FINDFIRST THEN
                        Rec."Invoice no" := "sales invoice header"."External Document No.";
                end;
            }
            field("Invoice no"; Rec."Invoice no")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Customer Ord no"; Rec."Customer Ord no")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /*  field("Cheque No."; "Cheque No.")
              {
                  ApplicationArea = All;
              }
              field("Cheque Date"; "Cheque Date")
              {
                  ApplicationArea = All;
              }*/
        }
        addafter("Account No.")
        {
            field("Amount Percentage"; Rec."Amount Percentage")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    AmountPercentageOnAfterValidat;
                end;
            }
        }

        addbefore("Account Name")
        {
            field("GST on Advance Payment"; Rec."GST on Advance Payment")
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
        }
    }
    actions
    {
        modify(Dimensions)
        {
            Promoted = true;
        }
        modify(IncomingDoc)
        {
            Promoted = true;
        }
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify("Apply Entries")
        {
            Promoted = true;
        }
        /* modify("Calculate GST")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Update Reference Invoice No")
        {
            Promoted = true;
        } */
        modify(Post)
        {
            Promoted = true;
            PromotedIsBig = true;
            trigger OnBeforeAction()
            var
                JGE: Record "Gen. Journal Line";
                PrevDoc: Code[30];
                Temp_Jrnl_Line_Table: Record "Gen. Journal Line";
                User: Record User;
                Pstdt: Date;
            begin
                GJL1.RESET;
                GJL1.DELETEALL;
                GJL1.RESET;
                User.RESET;
                User.SETFILTER("User Name", USERID);
                IF User.FINDFIRST THEN
                    Pstdt := 20220331D;
                //Pstdt :=200621D;
                //IF User."User Name" IN ['EFFTRONICS\21TE072','EFFTRONICS\GRAVI'] THEN
                IF (Rec."Posting Date" < Pstdt)
                THEN
                    ERROR('Posting Date is not in allowed range.');
                FinalBill := FALSE;
                IF Rec."Sale Order No" = '' THEN
                    ERROR('Please specify the Sale order no');
                SaleOrder := Rec."Sale Order No";
                PostingDate := Rec."Posting Date";
                // Added by Pranavi on 23-Jun-2016 for SD Status Tracking
                IF Rec."Journal Batch Name" = 'BRV-SALES' THEN BEGIN
                    IF Rec."Final Bill Payment" = FALSE THEN BEGIN
                        Selection := STRMENU(Text0001, 1);
                        CASE Selection OF
                            0:
                                EXIT;
                            2:
                                BEGIN
                                    Rec."Final Bill Payment" := TRUE;
                                    Rec.MODIFY;
                                    FinalBill := TRUE;
                                END;
                        END
                    END;
                    GJL1.RESET;
                    /* IF "Payment Type" = "Payment Type"::Advance THEN  // added by pranavi on 09-09-2016 for adv payment entry to cf
                    BEGIN */
                    GJL.RESET;
                    GJL.SETRANGE(GJL."Journal Batch Name", Rec."Journal Batch Name");
                    GJL.SETRANGE(GJL."Account Type", GJL."Account Type"::Customer);
                    IF GJL.FINDSET THEN BEGIN
                        IF GJL."Sale Order No" <> '' THEN BEGIN
                            GJL1 := GJL;
                            GJL1.INSERT;
                        END
                        ELSE
                            ERROR('Please specify the Sale order no');
                    END;
                    //END;
                END;
                // End by Pranavi
                //IF NOT(USERID IN['EFFTRONICS\PRANAVI']) THEN
                //BEGIN
                IF (FinalBill = TRUE) AND (SaleOrder <> '') THEN
                    SDStatusUpdate(SaleOrder, PostingDate);

                // >> Pranavi
                Temp_Jrnl_Line_Table.RESET;
                Temp_Jrnl_Line_Table.COPYFILTERS(Rec);
                IF Temp_Jrnl_Line_Table.FINDSET THEN
                    REPEAT
                        IF (Temp_Jrnl_Line_Table."Account Type" IN [Temp_Jrnl_Line_Table."Account Type"::Customer]) AND
                          (Temp_Jrnl_Line_Table."GST on Advance Payment") AND ((GetGSTAmounts(TaxTransactionValue, Temp_Jrnl_Line_Table, GSTSetup) <> 0)) then begin  //(Temp_Jrnl_Line_Table."Total GST Amount" <> 0) THEN BEGIN//EFFUPG
                            IF PrevDoc <> Temp_Jrnl_Line_Table."Document No." THEN BEGIN
                                JGE.RESET;
                                JGE.SETRANGE("Journal Batch Name", Temp_Jrnl_Line_Table."Journal Batch Name");
                                JGE.SETRANGE("Journal Template Name", Temp_Jrnl_Line_Table."Journal Template Name");
                                JGE.SETRANGE("Document No.", Temp_Jrnl_Line_Table."Document No.");
                                IF JGE.FINDSET THEN BEGIN
                                    CLEAR(NoSeriesMgt);
                                    JGE.MODIFYALL(JGE."External Document No.", NoSeriesMgt.GetNextNo('ADV_VOUCH', WORKDATE, TRUE));
                                END;
                                //NoSeriesMgt.TryGetNextNo('ADV_VOUCH',TODAY);
                                //MESSAGE(NoSeriesMgt.GetNextNo('ADV_VOUCH',TODAY,TRUE));
                            END;
                            PrevDoc := Temp_Jrnl_Line_Table."Document No.";
                        END;
                    UNTIL Temp_Jrnl_Line_Table.NEXT = 0;
                // << Pranavi


                //IF NOT (USERID = 'EFFTRONICS\PRANAVI') THEN
            end;

            trigger OnAfterAction()
            begin
                //END;
                GJL1.RESET;
                IF GJL1.FINDSET THEN
                    REPEAT
                        IF GJL1."Payment Type" = GJL1."Payment Type"::Advance THEN BEGIN
                            SQLInt.PvtAdvOrderPaymentinCF_1(GJL1)  // added by pranavi on 09-09-2016 for adv payment entry to cf
                        END
                        ELSE
                            SQLInt.Pvt_Remaining_Adv_OrderPaymentinCF_1(GJL1);  // added by pranavi on 09-09-2016 for adv payment entry to cf
                    UNTIL GJL1.NEXT = 0;

                GJL1.RESET;
                GJL1.DELETEALL;
            end;
        }
        modify(Preview)
        {
            Promoted = true;
            PromotedCategory = Process;
            trigger OnAfterAction()
            var
                User: Record User;
                Pstdt: Date;
            begin
                User.RESET;
                User.SETFILTER("User Name", USERID);
                IF User.FINDFIRST THEN
                    Pstdt := 20220331D;
                //Pstdt :=200621D;
                //IF User."User Name" IN ['EFFTRONICS\21TE072','EFFTRONICS\GRAVI'] THEN
                IF (Rec."Posting Date" < Pstdt)
                THEN
                    ERROR('Posting Date is not in allowed range.');
            end;
        }
        modify("Post and &Print")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        /* modify(Approve)
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
        modify(Comment)
        {
            Promoted = true;
        } */
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action(ForwardToCF)
            {
                Caption = 'Forward To Cashflow';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    GJL1.RESET;
                    GJL1.DELETEALL;
                    GJL1.RESET;
                    FinalBill := FALSE;
                    IF Rec."Sale Order No" = '' THEN
                        ERROR('Please specify the Sale order no');
                    SaleOrder := Rec."Sale Order No";
                    PostingDate := Rec."Posting Date";
                    // Added by Pranavi on 23-Jun-2016 for SD Status Tracking
                    IF Rec."Journal Batch Name" = 'BRV-SALES' THEN BEGIN
                        GJL1.RESET;
                        /*IF "Payment Type" = "Payment Type"::Advance THEN  // added by pranavi on 09-09-2016 for adv payment entry to cf
                        BEGIN */
                        GJL.RESET;
                        GJL.SETRANGE(GJL."Journal Batch Name", Rec."Journal Batch Name");
                        GJL.SETRANGE(GJL."Account Type", GJL."Account Type"::Customer);
                        IF GJL.FINDSET THEN BEGIN
                            IF GJL."Sale Order No" <> '' THEN BEGIN
                                GJL1 := GJL;
                                GJL1.INSERT;
                            END ELSE
                                ERROR('Please specify the Sale order no');
                        END;
                        /* END;*/
                    END;

                    GJL1.RESET;
                    IF GJL1.FINDSET THEN
                        REPEAT
                            IF GJL1."Payment Type" = GJL1."Payment Type"::Advance THEN BEGIN
                                SQLInt.PvtAdvOrderPaymentinCF_1(GJL1)  // added by pranavi on 09-09-2016 for adv payment entry to cf
                            END
                            ELSE
                                SQLInt.Pvt_Remaining_Adv_OrderPaymentinCF_1(GJL1);  // added by pranavi on 09-09-2016 for adv payment entry to cf
                        UNTIL GJL1.NEXT = 0;

                    GJL1.RESET;
                    GJL1.DELETEALL;

                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /* IF ((COUNT = 1) AND ("Journal Batch Name" = 'BRV(CUST)')) OR ((COUNT = 1) AND ("Journal Batch Name" = 'BRV(EMP)')) THEN
            MESSAGE('POST RECEIPT IN SINGLE LINE'); */
        //srinivas
    end;


    var
        "sales invoice header": Record "Sales Invoice Header";
        "sales header": Record "Sales Header";
        Salinv: Record "Sales Invoice-Dummy";
        Text0001: Label '&Not a Final Bill Payment,&Final Bill Payment';
        Selection: Integer;
        FinalBill: Boolean;
        SaleOrder: Code[20];
        PostingDate: Date;
        GJL: Record "Gen. Journal Line";
        GJL1: Record "Gen. Journal Line" temporary;
        SQLInt: Codeunit SQLIntegration;
        NoSeriesMgt: Codeunit 396;



    local procedure AmountPercentageOnAfterValidat();
    begin
        Rec."Credit Amount" := (Rec."Credit Amount" * Rec."Amount Percentage") / 100;
        Rec.Amount := -Rec."Credit Amount";
        Rec."Amount (LCY)" := -Rec."Credit Amount";
        Rec."Balance (LCY)" := -Rec."Credit Amount";
        Rec."VAT Base Amount" := -Rec."Credit Amount";
        Rec."Bal. VAT Base Amount" := Rec."Credit Amount";
        Rec."VAT Base Amount (LCY)" := -Rec."Credit Amount";
        Rec."Bal. VAT Base Amount (LCY)" := Rec."Credit Amount";
    end;


    procedure SDStatusUpdate(SaleOrderNo: Code[20]; PostingDateVar: Date);
    var
        SIH: Record "Sales Invoice Header";
        SIDummy: Record "Sales Invoice-Dummy";
        SQLQuery: Text[1000];
        RowCount: Integer;
        ConnectionOpen: Integer;
        //>> ORACLE UPG
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A7 5196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
         */
        //<< ORACLE UPG
        SDId: Integer;
        Warranty: Code[10];
    begin
        // Added by Pranavi on 10-Aug-2016
        IF (SaleOrderNo <> '') THEN BEGIN
            SIH.RESET;
            SIH.SETRANGE(SIH."Order No.", SaleOrderNo);
            IF SIH.FINDSET THEN
                REPEAT
                    SIH.VALIDATE(SIH."Final Railway Bill Date", PostingDateVar);
                    IF COPYSTR(SIH."Order No.", 5, 3) = 'AMC' THEN
                        SIH.SecDepStatus := SIH.SecDepStatus::Due
                    ELSE BEGIN
                        IF (FORMAT(SIH."Warranty Period") <> '') THEN BEGIN
                            IF CALCDATE('+' + FORMAT(SIH."Warranty Period"), SIH."Final Railway Bill Date") <= TODAY() THEN
                                SIH.SecDepStatus := SIH.SecDepStatus::Due
                            ELSE
                                SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                        END;
                    END;
                    Warranty := FORMAT(SIH."Warranty Period");
                    SIH.MODIFY;
                UNTIL SIH.NEXT = 0;
            SIDummy.RESET;
            SIDummy.SETRANGE(SIDummy."No.", SaleOrderNo);
            IF SIDummy.FINDFIRST THEN BEGIN
                SIDummy.VALIDATE(SIDummy."Final Railway Bill Date", PostingDateVar);
                IF COPYSTR(SIDummy."No.", 5, 3) = 'AMC' THEN
                    SIDummy.SecDepStatus := SIDummy.SecDepStatus::Due
                ELSE BEGIN
                    IF (FORMAT(SIDummy."Warranty Period") <> '') THEN BEGIN
                        IF CALCDATE('+' + FORMAT(SIDummy."Warranty Period"), SIDummy."Final Railway Bill Date") <= TODAY() THEN
                            SIDummy.SecDepStatus := SIDummy.SecDepStatus::Due
                        ELSE
                            SIDummy.SecDepStatus := SIDummy.SecDepStatus::Warranty;
                    END;
                END;
                SIDummy.MODIFY;
            END;
        END;
        //Initialization start
        RowCount := 0;
        SQLQuery := '';
        SDId := 0;
        //Initializations end

        /*IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);*/ //B2BUPG
                                              /*
                                                      IF ConnectionOpen <> 1 THEN BEGIN
                                                          SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                                                          SQLConnection.Open;
                                                          SQLConnection.BeginTrans;
                                                          ConnectionOpen := 1;
                                                      END;
                                                      SQLQuery := 'SELECT * FROM MRP_SECURITY_DEPOSIT WHERE INT_SAL_ORD_NO = ''' + FORMAT(SaleOrderNo) + ''' AND SD_STATUS = ''N''';
                                                      //MESSAGE(SQLQuery);
                                                      RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                                                      IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                                          RecordSet.MoveFirst;

                                                      WHILE NOT RecordSet.EOF DO BEGIN
                                                          SDId := RecordSet.Fields.Item('SD_ID').Value;
                                                          RowCount := RowCount + 1;
                                                          RecordSet.MoveNext;
                                                      END;
                                                      IF SDId <> 0 THEN BEGIN
                                                          //SQLQuery:='UPDATE  WARRANTY_PERIOD = '''+FORMAT(Warranty)+''', SD_FINAL_BILL_DATE = to_date('''+FORMAT(PostingDateVar,0,'<Day>-<Month Text,3>-<Year4>')+''',''dd-mon-yyyy'') WHERE INT_SAL_ORD_NO = '''+FORMAT(SaleOrderNo)+'''';
                                                          SQLQuery := 'UPDATE MRP_SECURITY_DEPOSIT SET WARRANTY_PERIOD = ''' + FORMAT(SIH."Warranty Period") + ''', SD_FINAL_BILL_DATE = to_date(''' +
                                                                FORMAT(SIH."Final Railway Bill Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''dd-mon-yyyy'') WHERE INT_SAL_ORD_NO = ''' + FORMAT(SIH."Order No.") + '''';
                                                          SQLConnection.Execute(SQLQuery);
                                                      END;
                                                      SQLConnection.CommitTrans;
                                                      RecordSet.Close;
                                                      SQLConnection.Close;
                                                      ConnectionOpen := 0;
                                                      // End by Pranavi

                                              */

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

