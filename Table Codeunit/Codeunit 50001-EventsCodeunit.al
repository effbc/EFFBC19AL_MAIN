codeunit 50001 "EventCodeunit"
{
    trigger OnRun()
    begin

    end;


    //CODEUNIT 11
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Check Line", 'OnBeforeErrorIfNegativeAmt', '', false, false)]

    procedure OnBeforeErrorIfNegativeAmt(GenJnlLine: Record "Gen. Journal Line"; var RaiseError: Boolean)
    begin
        MESSAGE(FORMAT(GenJnlLine.Amount));


    end;
    //>>Codeunit 12>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure OnBeforeRunWithCheck(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalLine2: Record "Gen. Journal Line");
    begin
        //B2B
        CheckCashAccBalance(GenJournalLine2);

        //B2B
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeRunWithoutCheck', '', false, false)]
    local procedure OnBeforeRunWithoutCheck(var GenJournalLine: Record "Gen. Journal Line"; var GenJournalLine2: Record "Gen. Journal Line");
    begin
        //B2B
        CheckCashAccBalance(GenJournalLine2);
        //B2B
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInitAmounts', '', false, false)]
    local procedure OnBeforeInitAmounts(var GenJnlLine: Record "Gen. Journal Line"; var Currency: Record Currency; var IsHandled: Boolean)
    begin
        GenJnlLine.Amount := ROUND(GenJnlLine.Amount, Currency."Amount Rounding Precision");
        GenJnlLine."Amount (LCY)" := ROUND(GenJnlLine."Amount (LCY)", Currency."Amount Rounding Precision");

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]

    local procedure OnAfterPostGLAcc(var GenJnlLine: Record "Gen. Journal Line"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer; Balancing: Boolean)
    begin
        TempGLEntryBuf."Apply Entry No" := GenJnlLine."Apply Entry No";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostCust', '', false, false)]
    local procedure OnAfterPostCust(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextEntryNo: Integer; var NextTransactionNo: Integer)
    var
    // cust: Record "MSPT Customer Ledger Entry";
    begin
        //B2B
        //"CustAccNo." := "Account No.";


        //B2B

        //B2B-MSPT1.0 for inserting the values into the customer ledger entry table BEGIN
        // MSPTCustEntry.PostMSPTCustLedgerEntries(CustLedgEntry);
        //B2B-MSPT1.0 for inserting the values into the customer ledger entry table END
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostVend', '', false, false)]
    local procedure OnBeforePostVend(var GenJournalLine: Record "Gen. Journal Line")
    var
        OriginalGenJnlLine: Record 81;
    // MSPTVendorEntry : Codeunit 60008;
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendOnBeforePostDtldVendLedgEntries', '', false, false)]
    local procedure OnPostVendOnBeforePostDtldVendLedgEntries(var VendorLedgerEntry: Record "Vendor Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; var TempDtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    begin
        //B2B-MSPT1.0 for inserting the values into the MSPT Vendor Ledger Entries Begin
        // MSPTVendorEntry.PostMSPTVendorLedgerEntries( VendorLedgerEntry);
        //B2B-MSPT1.0 for inserting the values into the MSPT Vendor Ledger Entries End
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnBeforeBankAccLedgEntryInsert', '', false, false)]
    local procedure OnPostBankAccOnBeforeBankAccLedgEntryInsert(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account"; var TempGLEntryBuf: Record "G/L Entry" temporary; var NextTransactionNo: Integer)
    begin
        // Rev01>>
        BankAccountLedgerEntry."DD/FDR No." := GenJournalLine."DD/FDR No.";
        BankAccountLedgerEntry."Payment Through" := GenJournalLine."Payment Through";
        // Rev01<<
        BankAccountLedgerEntry."customer ord no" := GenJournalLine."Customer Ord no"; //srinivas
        BankAccountLedgerEntry."Payment Type" := GenJournalLine."Payment Type";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', false, false)]
    local procedure OnAfterInitGLEntry(var GLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line"; Amount: Decimal; AddCurrAmount: Decimal; UseAddCurrAmount: Boolean; var CurrencyFactor: Decimal)
    begin
        //B2B>>
        //GLEntry.Amount := Amount;
        GLEntry.Amount := ROUND(Amount, 0.01);
        //B2B <<

        //B2B-knr
        //B2B
        //..TDSCertificate(GLEntry);
        //B2B

        //B2B-Knr
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldCustLedgEntry', '', false, false)]
    local procedure OnAfterInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; Offset: Integer)
    var
    //MSPTCustEntry : Codeunit 60007;
    begin
        //B2B-MSPT1.0 For inserting the values into the MSPT Detailed Customer Ledger Entries Begin
        //  MSPTCustEntry.PostMSPTDtldCustLedgEntries(DtldCustLedgEntry);
        //B2B-MSPT1.0 For inserting the values into the MSPT Detailed Customer Ledger Entries End
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry', '', false, false)]
    local procedure OnApplyCustLedgEntryOnBeforePrepareTempCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var NewCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var DetailedCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; var NextEntryNo: Integer)
    var
        PT_Applying_CLE_GRec: Record 21;
        PT_Temp_Applying_CLE_GRec: Record 21 TEMPORARY;
        PT_ApplyTo_CLE_GRec: Record 21 TEMPORARY;
        PT_Temp_ApplyTo_CLE_GRec: Record 21 TEMPORARY;
        // SQLInt : Codeunit 60021;
        applyToAmt: Decimal;
        TempApplyngAmt: Decimal;

    begin
        // Added by pranavi on 09-09-2016 for payment terms process
        PT_Applying_CLE_GRec.RESET;
        PT_Applying_CLE_GRec.SETRANGE(PT_Applying_CLE_GRec."Entry No.", NewCVLedgerEntryBuffer."Entry No.");
        IF PT_Applying_CLE_GRec.FINDFIRST THEN BEGIN
            PT_Temp_Applying_CLE_GRec := PT_Applying_CLE_GRec;
            PT_Temp_Applying_CLE_GRec.INSERT;
        END;
        // end by pranavi
        //cu12



    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry', '', false, false)]
    local procedure OnApplyCustLedgEntryOnBeforeCopyFromCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var OldCVLedgerEntryBuffer: Record "CV Ledger Entry Buffer"; var TempOldCustLedgEntry: Record "Cust. Ledger Entry")
    var
        PT_Temp_ApplyTo_CLE_GRec: Record 21 TEMPORARY;
    begin
        // added by pranavi on 09-09-2016 for payment terms
        PT_Temp_ApplyTo_CLE_GRec := TempOldCustLedgEntry;
        PT_Temp_ApplyTo_CLE_GRec.INSERT;
        // end by pranavi
        //cu12
    end;
    //cu12
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterApplyCustLedgEntry', '', false, false)]
    local procedure OnAfterApplyCustLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var NewCVLedgEntryBuf: Record "CV Ledger Entry Buffer"; var OldCustLedgEntry: Record "Cust. Ledger Entry"; NewRemainingAmtBeforeAppln: Decimal)
    var
        T_Applying_CLE_GRec: Record 21;
        PT_Temp_Applying_CLE_GRec: Record 21 TEMPORARY;
        PT_ApplyTo_CLE_GRec: Record 21 TEMPORARY;
        PT_Temp_ApplyTo_CLE_GRec: Record 21 TEMPORARY;
        // SQLInt : Codeunit 60021;
        applyToAmt: Decimal;
        TempApplyngAmt: Decimal;
    begin
        // Added by pranavi on 09-09-2016 for payment terms process
        //IF USERID = 'EFFTRONICS\PRANAVI' THEN
        //BEGIN
        PT_Temp_Applying_CLE_GRec.RESET;
        IF PT_Temp_Applying_CLE_GRec.FINDFIRST THEN BEGIN
            applyToAmt := 0;
            IF PT_Temp_Applying_CLE_GRec."Document Type" = PT_Temp_Applying_CLE_GRec."Document Type"::Invoice THEN BEGIN
                PT_Temp_ApplyTo_CLE_GRec.RESET;
                IF PT_Temp_ApplyTo_CLE_GRec.FINDSET THEN
                    REPEAT
                        applyToAmt := applyToAmt + ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply");
                    UNTIL (PT_Temp_ApplyTo_CLE_GRec.NEXT = 0);
                IF (ABS(applyToAmt) > 0) THEN BEGIN
                    IF (ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply") <= ABS(applyToAmt)) AND (ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply") > 0) THEN
                        SQLInt.PvtOrderInvoicePaymentInCF_3(PT_Temp_Applying_CLE_GRec, ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply"))
                    ELSE
                        SQLInt.PvtOrderInvoicePaymentInCF_3(PT_Temp_Applying_CLE_GRec, ABS(applyToAmt));
                END;
            END ELSE BEGIN
                TempApplyngAmt := ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply");
                PT_Temp_ApplyTo_CLE_GRec.RESET;
                IF PT_Temp_ApplyTo_CLE_GRec.FINDSET THEN
                    REPEAT
                        IF (TempApplyngAmt >= ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply")) THEN BEGIN
                            SQLInt.PvtOrderInvoicePaymentInCF_3(PT_Temp_ApplyTo_CLE_GRec, ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply"));
                            TempApplyngAmt := TempApplyngAmt - ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply");
                        END
                        ELSE BEGIN
                            IF (TempApplyngAmt > 0) THEN BEGIN
                                SQLInt.PvtOrderInvoicePaymentInCF_3(PT_Temp_ApplyTo_CLE_GRec, TempApplyngAmt);
                                TempApplyngAmt := 0;
                            END;
                        END;
                    UNTIL ((PT_Temp_ApplyTo_CLE_GRec.NEXT = 0) AND (TempApplyngAmt <= 0));
            END;



        END ELSE BEGIN
            // end by pranavi
            // Added by pranavi on 09-09-2016 for payment terms process
            PT_Temp_Applying_CLE_GRec.RESET;
            IF PT_Temp_Applying_CLE_GRec.FINDFIRST THEN BEGIN
                applyToAmt := 0;
                IF PT_Temp_Applying_CLE_GRec."Document Type" = PT_Temp_Applying_CLE_GRec."Document Type"::Invoice THEN BEGIN
                    PT_Temp_ApplyTo_CLE_GRec.RESET;
                    IF PT_Temp_ApplyTo_CLE_GRec.FINDSET THEN
                        REPEAT
                            applyToAmt := applyToAmt + ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply");
                        UNTIL (PT_Temp_ApplyTo_CLE_GRec.NEXT = 0);
                    IF (ABS(applyToAmt) > 0) THEN BEGIN
                        IF (ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply") <= ABS(applyToAmt)) AND (ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply") > 0) THEN
                            SQLInt.PvtOrderInvoicePaymentInCF_2(PT_Temp_Applying_CLE_GRec, ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply"))
                        ELSE
                            SQLInt.PvtOrderInvoicePaymentInCF_2(PT_Temp_Applying_CLE_GRec, ABS(applyToAmt));
                    END;
                END ELSE BEGIN
                    TempApplyngAmt := ABS(PT_Temp_Applying_CLE_GRec."Amount to Apply");
                    PT_Temp_ApplyTo_CLE_GRec.RESET;
                    IF PT_Temp_ApplyTo_CLE_GRec.FINDSET THEN
                        REPEAT
                            IF (TempApplyngAmt >= ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply")) THEN BEGIN
                                SQLInt.PvtOrderInvoicePaymentInCF_2(PT_Temp_ApplyTo_CLE_GRec, ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply"));
                                TempApplyngAmt := TempApplyngAmt - ABS(PT_Temp_ApplyTo_CLE_GRec."Amount to Apply");
                            END
                            ELSE BEGIN
                                IF (TempApplyngAmt > 0) THEN BEGIN
                                    SQLInt.PvtOrderInvoicePaymentInCF_2(PT_Temp_ApplyTo_CLE_GRec, TempApplyngAmt);
                                    TempApplyngAmt := 0;
                                END;
                            END;
                        UNTIL ((PT_Temp_ApplyTo_CLE_GRec.NEXT = 0) AND (TempApplyngAmt <= 0));
                END;
            END;
        END;

        // end by pranavi
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnHandleAddCurrResidualGLEntryOnBeforeInsertGLEntry', '', false, false)]
    local procedure OnHandleAddCurrResidualGLEntryOnBeforeInsertGLEntry(GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry"; var TempGLEntryBuf: Record "G/L Entry"; NextEntryNo: Integer; var IsHandled: Boolean)
    begin
        // Rev01>>
        GLEntry."DD/FDR No." := GenJournalLine."DD/FDR No.";
        GLEntry."Payment Through" := GenJournalLine."Payment Through";
        // Rev01<<cu12
    end;

    //>>Codeunit 13>>
    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Batch", 'OnBeforeRaiseExceedLengthError', '', false, false)]
       local procedure OnBeforeRaiseExceedLengthError(var GenJournalBatch: Record "Gen. Journal Batch"; var RaiseError: Boolean; var GenJnlLine: Record "Gen. Journal Line")
      begin

      end;*/

    //<<Codeunit13<<

    //  >>Codeunit17>>

    //>>Codeunit21>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", 'OnAfterGetItem', '', false, false)]

    local procedure OnAfterGetItem(Item: Record Item; var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        //Rasool
        IF ItemJournalLine."Posting Date" = 0D THEN
            ItemJournalLine."Posting Date" := WORKDATE;
    end;
    //<<Codeunit21<<
    //>>Codeunit22>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure OnBeforeRunWithCheckQC(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var

        ItemLedEntry: Record 32;
    begin
        //QC
        IF ItemJournalLine."Quality Ledger Entry No." <> 0 THEN
            PostItemJournalLine := TRUE;
        //QC
        //MESSAGE('%1',PostItemJournalLine);
        //PostItemJournalLine := FALSE;//UPG
        //SetupSplitJnlLine(ItemJournalLine2,PostItemJournalLine);//NAV2016CU19
        //SetupSplitJnlLine(ItemJournalLine2);NAV2016CU19
        //B2B ssr start
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption THEN BEGIN
            ItemLedEntry.SETCURRENTKEY("Entry Type", "Item No.", "Location Code",
                                  Open, "Lot No.", "Serial No.", "ITL Doc No.", "ITL Doc Line No.", "ITL Doc Ref Line No.");
            //ItemLedEntry.RESET;
            ItemLedEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
            ItemLedEntry.SETRANGE("Lot No.", ItemJournalLine."Lot No.");
            ItemLedEntry.SETRANGE("Serial No.", ItemJournalLine."Serial No.");
            ItemLedEntry.SETRANGE(Open, TRUE);
            ItemLedEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
            ItemLedEntry.SETRANGE("ITL Doc No.", ItemJournalLine."Order No.");
            ItemLedEntry.SETRANGE("ITL Doc Line No.", ItemJournalLine."Order Line No.");
            ItemLedEntry.SETRANGE("ITL Doc Ref Line No.", ItemJournalLine."Prod. Order Comp. Line No.");
            IF ItemLedEntry.FINDFIRST THEN BEGIN
                ItemJournalLine."Applies-to Entry" := ItemLedEntry."Entry No.";
                ItemJournalLine.MODIFY;
            END;
        END;
        //B2B ssr end

        //B2B KPK start
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt." THEN BEGIN
            ItemLedEntry.SETCURRENTKEY(ItemLedEntry."Item No.",
                                       ItemLedEntry.Open,
                                       ItemLedEntry."Variant Code",
                                       ItemLedEntry."Location Code",
                                       ItemLedEntry."Item Tracking",
                                       ItemLedEntry."Lot No.",
                                       ItemLedEntry."Serial No.");

            //ItemLedEntry.RESET;//commented by b2b sankar
            ItemLedEntry.SETRANGE("Item No.", ItemJournalLine."Item No.");
            ItemLedEntry.SETRANGE("Lot No.", ItemJournalLine."Lot No.");
            ItemLedEntry.SETRANGE("Serial No.", ItemJournalLine."Serial No.");
            ItemLedEntry.SETRANGE(Open, TRUE);
            ItemLedEntry.SETRANGE("Location Code", ItemJournalLine."Location Code");
            ItemLedEntry.SETRANGE("Global Dimension 2 Code", ItemJournalLine."Shortcut Dimension 2 Code");
            IF ItemLedEntry.FINDFIRST THEN BEGIN
                ItemJournalLine."Applies-to Entry" := ItemLedEntry."Entry No.";
                ItemJournalLine.MODIFY;
            END;
        END;
        //B2B KPK end
    end;
    //<<Codeunit22<<


    //<<Codeunit22<<

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforePostOutput', '', false, false)]
    //local procedure OnBeforePostOutput(var ItemJournalLine: Record "Item Journal Line")
    local procedure OnBeforePostOutput(var ItemJnlLine: Record "Item Journal Line")
    var
        "--QC--": Integer;
        InspectJnlLine: Codeunit 33000253;
        InspectHeader: Record 33000269;
        ProdOrderRtngLine2: Record 5409;
        CapLedgEntry2: Record 5832;
    begin
        //QC
        IF NOT ItemJnlLine."After Inspection" THEN
            ItemJnlLine.CreateInspectionDataSheets;
        //RQC1.0
        InspectHeader.RESET;
        InspectHeader.SETRANGE(InspectHeader."No.", ItemJnlLine."Inspectin Receipt No.");
        InspectHeader.SETRANGE(InspectHeader.Status, InspectHeader.Status, true);
        IF InspectHeader.FINDFIRST THEN BEGIN
            InspectHeader."Rework Posted" := TRUE;
            InspectHeader."Rework User" := ItemJnlLine."No.";
            InspectHeader.MODIFY;
        END;
        //RQC1.0

        //QC
        //B2B2.0 SGS
        ProdOrderRtngLine2.SETRANGE(Status, ProdOrderRtngLine2.Status::Released);
        ProdOrderRtngLine2.SETRANGE("Prod. Order No.", ItemJnlLine."Order No.");
        ProdOrderRtngLine2.SETRANGE("Routing Reference No.", ItemJnlLine."Routing Reference No.");
        ProdOrderRtngLine2.SETRANGE("Routing No.", ItemJnlLine."Routing No.");
        ProdOrderRtngLine2.SETRANGE("Operation No.", ItemJnlLine."Operation No.");
        IF ProdOrderRtngLine2.FINDFIRST THEN;
        IF ProdOrderRtngLine2."Previous Operation No." <> '' THEN BEGIN
            CapLedgEntry2.RESET;
            CapLedgEntry2.SETCURRENTKEY("Order No.", "Order Line No.",
                                         "Routing No.", "Routing Reference No.", "Operation No.");
            CapLedgEntry2.SETRANGE("Order No.", ItemJnlLine."Order No.");
            CapLedgEntry2.SETRANGE("Order Line No.", ItemJnlLine."Routing Reference No.");
            CapLedgEntry2.SETRANGE("Routing No.", ItemJnlLine."Routing No.");
            CapLedgEntry2.SETRANGE("Routing Reference No.", ItemJnlLine."Routing Reference No.");
            CapLedgEntry2.SETRANGE("Operation No.", ProdOrderRtngLine2."Previous Operation No.");
            IF CapLedgEntry2.FINDFIRST THEN BEGIN
                IF CapLedgEntry2."Output Quantity" < ItemJnlLine."Output Quantity" THEN
                    ERROR('You can not post more than %1 Quantity for this operation %2'
                     , CapLedgEntry2."Output Quantity", CapLedgEntry2."Operation No.");
            END;// ELSE
                //  ERROR('Post the previous operation %1 for this Production Order %2',ProdOrderRtngLine2."Previous Operation No.",
                //        ProdOrderRtngLine2."Prod. Order No.");
                // commented by santhosh for old data posting purpose
        END;
        //B2B2.0 SGS
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostOutputOnAfterCreateWhseJnlLine', '', false, false)]
    local procedure OnPostOutputOnAfterCreateWhseJnlLine(var ItemJournalLine: Record "Item Journal Line")
    var
        InspectJnlLine: Codeunit 33000253;
    begin
        //QC
        InspectJnlLine.CheckPostProdOrderOutput(ItemJournalLine);
        //QC
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnPostItemOnBeforeCheckInventoryPostingGroup', '', false, false)]
    local procedure OnPostItemOnBeforeCheckInventoryPostingGroup(var ItemJnlLine: Record "Item Journal Line"; var CalledFromAdjustment: Boolean; var Item: Record Item; var ItemTrackingCode: Record "Item Tracking Code")
    VAR
        PostedMatIssHdr: Record 50003;
    begin
        BEGIN
            // Conditon Added by Pranavi on 11-Jan-2016 for allowing blocked item for site stock updation purpose
            IF NOT ((ItemJnlLine."Journal Batch Name" = 'POS-CS-SIG') AND (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.")) THEN
                IF PostedMatIssHdr.GET(ItemJnlLine."Document No.") THEN BEGIN
                    IF NOT (((PostedMatIssHdr."Transfer-from Code" = 'SITE') AND (PostedMatIssHdr."Transfer-to Code" = 'CS')) OR
                           ((PostedMatIssHdr."Transfer-from Code" = 'CS') AND (PostedMatIssHdr."Transfer-to Code" = 'SITE'))) THEN
                        Item.TESTFIELD(Blocked, FALSE);
                END
                ELSE
                    Item.TESTFIELD(Blocked, FALSE);
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeProdOrderCompModify', '', false, false)]
    local procedure OnBeforeProdOrderCompModify(var ProdOrderComponent: Record "Prod. Order Component"; ItemJournalLine: Record "Item Journal Line")
    var
        ProdOrderInspectComponents: Record 33000279;
    begin
        //QC
        IF ItemJournalLine."After Inspection" THEN begin
            //  UpdateReworkComponents(ItemJournalLine.Quantity);
            IF ProdOrderInspectComponents.GET(ProdOrderInspectComponents.Status::Released, ItemJournalLine."Order No.",
   ItemJournalLine."Order Line No.", ItemJournalLine."Inspectin Receipt No.", ItemJournalLine."Prod. Order Comp. Line No.") THEN BEGIN
                ProdOrderInspectComponents."Quantity Consumed" := ProdOrderInspectComponents."Quantity Consumed" + ItemJournalLine.Quantity;
                ProdOrderInspectComponents."Remaining Quantity" := ProdOrderInspectComponents."Expected Quantity" -
                  ProdOrderInspectComponents."Quantity Consumed";
                ProdOrderInspectComponents.MODIFY;
            end;

            //QC
        end;
    end;


    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertCapLedgEntry', '', false, false)]
    local procedure OnBeforeInsertCapLedgEntry(var CapLedgEntry: Record "Capacity Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        //B2B
        CapLedgEntry."Operation Description" := ItemJournalLine."Operation Description";
        CapLedgEntry."Planed Setup Time" := ItemJournalLine."Planed Setup Time";
        CapLedgEntry."Reason Code" := ItemJournalLine."Reason Code";
        CapLedgEntry."Planed Run Time" := ItemJournalLine."Planed Run Time";
        CapLedgEntry."Planed Wait Time" := ItemJournalLine."Planed Wait Time";
        CapLedgEntry."Planed Move Time" := ItemJournalLine."Planed Move Time";
        CapLedgEntry."Internal Rework" := ItemJournalLine."Internal Rework";
        CapLedgEntry."Reworked User Id" := ItemJournalLine."Reworked User Id";
        CapLedgEntry."QC Rework" := ItemJournalLine."QC Rework";
        CapLedgEntry.Remarks := ItemJournalLine.Remarks;
        //B2B
    end;

    //<<Codeunit22cls<<

    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterApplyItemLedgEntrySetFilters', '', false, false)]
    local procedure ExcludeQualityItems(var ItemLedgerEntry2: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    VAR
        AcceptedQty: Decimal;

        Item: record Item;
        ItemLedgerEntryLRec: Record "Item Ledger Entry";
    begin

        //QC
        // ExcludeQualityItems(ItemLedgerEntry, ItemLedgerEntry.Positive);
        //QC
        ItemLedgerEntryLRec.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntryLRec.SetRange("Item No.", ItemLedgerEntry."Item No.");
        ItemLedgerEntryLRec.SetRange(Open, true);
        ItemLedgerEntryLRec.SetRange("Variant Code", ItemLedgerEntry."Variant Code");
        ItemLedgerEntryLRec.SetRange(Positive, not ItemLedgerEntry.Positive);
        ItemLedgerEntryLRec.SetRange("Location Code", ItemLedgerEntry."Location Code");
        IF ItemLedgerEntryLRec.FIND('-') THEN
            REPEAT

                IF NOT QualityItemLedgEntry.GET(ItemLedgerEntryLRec."Entry No.") THEN BEGIN
                    ItemLedgerEntryLRec.MARK(TRUE);
                    AcceptedQty := AcceptedQty + ItemLedgerEntryLRec."Remaining Quantity";
                END;
            UNTIL ItemLedgerEntryLRec.NEXT() = 0;
        ItemLedgerEntryLRec.MARKEDONLY(TRUE);
        Item.Get(ItemLedgerEntry."Item No.");
        IF (NOT ItemLedgerEntry.Positive) AND (Item."QC Enabled") THEN
            IF NOT ItemLedgerEntrylrec.FINDFIRST THEN BEGIN
                ERROR(Text33000251, ItemLedgerEntrylrec."Item No.");
            END
            ELSE
                IF AcceptedQty < ItemJournalLine.Quantity THEN
                    ERROR(Text33000250, ItemLedgerEntrylrec."Item No.");

    end;
    /*

    PROCEDURE ExcludeQualityItems(VAR ItemLedgEntry2: Record 32; Inbound: Boolean;);
    VAR
        AcceptedQty: Decimal;
        ItemJournalLine: Record "Item Journal Line";
        Item: record Item;
        ItemLedgerEntryLRec: Record "Item Ledger Entry"
    BEGIN
        /*
                IF ItemLedgEntry2.FINDSET THEN
                    REPEAT
                        IF NOT QualityItemLedgEntry.GET(ItemLedgEntry2."Entry No.") THEN BEGIN
                            ItemLedgEntry2.MARK(TRUE);
                            AcceptedQty := AcceptedQty + ItemLedgEntry2."Remaining Quantity";
                        END;
                    UNTIL ItemLedgEntry2.NEXT = 0;
                ItemLedgEntry2.MARKEDONLY(TRUE);
                IF (NOT Inbound) AND (Item."QC Enabled") THEN
                    IF NOT ItemLedgEntry2.FINDFIRST THEN BEGIN
                        ERROR(Text33000251, ItemLedgEntry2."Item No.");
                    END
                    ELSE
                        IF AcceptedQty < ItemJournalLine.Quantity THEN
                            ERROR(Text33000251, ItemLedgEntry2."Item No.");
            END;
            */

    //<<Codeunit22cls<<


    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeTestFirstApplyItemLedgEntry', '', false, false)]
    local procedure OnBeforeTestFirstApplyItemLedgEntry(var OldItemLedgerEntry: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        //QC
        IF QualityItemLedgEntry.GET(OldItemLedgerEntry."Entry No.") THEN BEGIN
            IF ItemJournalLine."Quality Ledger Entry No." = 0 THEN BEGIN
                IF (ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Purchase) AND (NOT ItemLedgerEntry.Positive) THEN BEGIN
                    IF QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection" THEN
                        QualityItemLedgEntry.FIELDERROR(QualityItemLedgEntry."Inspection Status")
                    ELSE BEGIN
                        QualityItemLedgEntry."Remaining Quantity" := QualityItemLedgEntry."Remaining Quantity" + ItemLedgerEntry.Quantity;
                        IF QualityItemLedgEntry."Remaining Quantity" = 0 THEN
                            QualityItemLedgEntry.DELETE
                        ELSE
                            QualityItemLedgEntry.MODIFY;
                    END;
                END ELSE
                    QualityItemLedgEntry.FIELDERROR(QualityItemLedgEntry."Inspection Status");
            END;
        END;
        //QC
    end;
    //<<Codeunit22clos<<




    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertTransferEntryOnTransferValues', '', false, false)]
    local procedure OnInsertTransferEntryOnTransferValues(var NewItemLedgerEntry: Record "Item Ledger Entry"; OldItemLedgerEntry: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var TempItemEntryRelation: Record "Item Entry Relation")
    begin
        //B2B QC Check start
        NewItemLedgerEntry."QC Check" := ItemJournalLine."QC Check";
        //B2B QC Check end

    end;
    //<<Codeunit22clos<<







    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    var
        Item: Record 27;
    begin
        IF (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Purchase) AND (ItemJournalLine."Document Type" = ItemJournalLine."Document Type"::"Purchase Credit Memo") THEN
            NewItemLedgEntry."Applies-to Entry" := ItemJournalLine."Applies-to Entry"//modified by sundar
        ELSE
            NewItemLedgEntry."Applies-to Entry" := ItemJournalLine."Applies-to Entry";

        //B2B-QC1.2
        NewItemLedgEntry."Purch.Rcpt Line" := ItemJournalLine."Purch.Rcpt Line";
        //B2B-QC1.2

        //B2BQC Check Start
        IF Item.GET(ItemJournalLine."Item No.") THEN BEGIN
            IF Item."QC Enabled" THEN
                IF NewItemLedgEntry."Entry Type" = NewItemLedgEntry."Entry Type"::Purchase THEN
                    NewItemLedgEntry."QC Check" := TRUE;
        END;
        //B2B
        NewItemLedgEntry."ITL Doc No." := ItemJournalLine."ITL Doc No.";
        NewItemLedgEntry."ITL Doc Line No." := ItemJournalLine."ITL Doc Line No.";
        NewItemLedgEntry."ITL Doc Ref Line No." := ItemJournalLine."ITL Doc Ref Line No.";
        //B2B

    end;
    //<<Codeunit22clos<<






    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeCheckSerialNo', '', false, false)]
    local procedure OnBeforeCheckSerialNo(ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var


    begin
        IF ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer THEN BEGIN
            Itm.RESET;
            Itm.SETFILTER(Itm."No.", ItemJournalLine."Item No.");
            IF Itm.FINDFIRST THEN BEGIN
                IF Itm."Item Tracking Code" <> 'SERIAL' THEN BEGIN
                    IF FindInInventoryNew(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."New Serial No.", ItemJournalLine."Location Code", ItemJournalLine."Lot No.") THEN
                        ERROR(Text014, ItemJournalLine."New Serial No.");    //added argument by b2b
                END
                ELSE
                    if FindInInventory(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."New Serial No.", ItemJournalLine."Location Code") THEN
                        ERROR(Text014, ItemJournalLine."New Serial No.");    //added argument by b2b
            END;
        END ELSE BEGIN   //anil
            Itm.RESET;
            Itm.SETFILTER(Itm."No.", ItemJournalLine."Item No.");
            IF Itm.FINDFIRST THEN BEGIN
                IF Itm."Item Tracking Code" <> 'SERIAL' THEN BEGIN
                    IF FindInInventoryNew(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."New Serial No.", ItemJournalLine."Location Code", ItemJournalLine."Lot No.") THEN
                        ERROR(Text014, ItemJournalLine."New Serial No.");    //added argument by b2b
                END
                ELSE
                    IF FindInInventory(ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Serial No.", ItemJournalLine."New Location Code") THEN //b2B
                        ERROR(Text014, ItemJournalLine."Serial No.");

            END;
        end;
        IsHandled := true;
    end;
    //<<Codeunit22clos<<

    //Item management  CU6500
    PROCEDURE FindInInventory(ItemNo: Code[20]; VariantCode: Code[20]; SerialNo: Code[20]; LocationCode: Code[20]): Boolean;
    VAR
        ItemLedgerEntry: Record 32;
    BEGIN
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive);
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Variant Code", VariantCode);
        //B2B-Rasool
        ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
        ItemLedgerEntry.SETRANGE(Positive, TRUE);
        IF SerialNo <> '' THEN
            ItemLedgerEntry.SETRANGE("Serial No.", SerialNo);
        EXIT(ItemLedgerEntry.FINDFIRST);
    END;

    PROCEDURE FindInInventoryNew(ItemNo: Code[20]; VariantCode: Code[20]; SerialNo: Code[20]; LocationCode: Code[20]; LotNo: Code[20]): Boolean;
    VAR
        ItemLedgerEntry: Record 32;
    BEGIN
        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.", Open, "Variant Code", Positive);
        ItemLedgerEntry.SETRANGE("Item No.", ItemNo);
        ItemLedgerEntry.SETRANGE(Open, TRUE);
        ItemLedgerEntry.SETRANGE("Variant Code", VariantCode);
        //B2B-Rasool
        ItemLedgerEntry.SETRANGE("Location Code", LocationCode);
        ItemLedgerEntry.SETRANGE(Positive, TRUE);
        IF SerialNo <> '' THEN
            ItemLedgerEntry.SETRANGE("Serial No.", SerialNo);
        IF LotNo <> '' THEN
            ItemLedgerEntry.SETRANGE("Serial No.", LotNo);
        EXIT(ItemLedgerEntry.FINDFIRST);
    END;




    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeSetupSplitJnlLineProcedure', '', false, false)]
    local procedure OnBeforeSetupSplitJnlLineProcedure(var ItemJnlLine2: Record "Item Journal Line"; TrackingSpecExists: Boolean; CalledFromAdjustment: Boolean)
    var
        PostedMatIssHdr: Record 50003;
        Item: Record 27;
    begin
        IF Item.GET(ItemJnlLine2."Item No.") THEN BEGIN
            IF NOT CalledFromAdjustment THEN BEGIN
                // Conditon Added by Pranavi on 11-Jan-2016 for allowing blocked item for site stock updation purpose
                IF NOT ((ItemJnlLine2."Journal Batch Name" = 'POS-CS-SIG') AND (ItemJnlLine2."Entry Type" = ItemJnlLine2."Entry Type"::"Positive Adjmt.")) THEN
                    IF PostedMatIssHdr.GET(ItemJnlLine2."Document No.") THEN BEGIN
                        IF NOT (((PostedMatIssHdr."Transfer-from Code" = 'SITE') AND (PostedMatIssHdr."Transfer-to Code" = 'CS')) OR
                            ((PostedMatIssHdr."Transfer-from Code" = 'CS') AND (PostedMatIssHdr."Transfer-to Code" = 'SITE'))) THEN
                            Item.TESTFIELD(Blocked, FALSE);
                    END
                    ELSE
                        Item.TESTFIELD(Blocked, FALSE);
            END;
        END ELSE
            Item.INIT;
    end;
    //<<Codeunit22clos<<



    //<<Codeunit23opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", 'OnCodeOnBeforePostLines', '', false, false)]
    local procedure OnCodeOnBeforePostLines1(var ItemJournalLine: Record "Item Journal Line"; var NoOfRecords: Integer)
    var
        ProductionOrderNo: Text;
        ItemNo: Text;
    begin
        ProductionOrderNo := ItemJournalLine."Order No.";
        ItemNo := ItemJournalLine."Item No.";

        //MESSAGE(ProductionOrderNo + '--' + ItemNo);
    end;

    //<<Codeunit23clos<<





    //<<Codeunit40opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, 'OnBeforeCompanyOpen', '', false, false)]
    local procedure OnBeforeCompanyOpen()
    var
        //WSHShell: Automation "{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B} 1.0:{72C24DD5-D70A-438B-8A42-98424B88AFB8}:'Windows Script Host Object Model'.WshShell";
        //WshEnvironment: Automation "{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B} 1.0:{F48229AF-E28C-42B5-BB92-E114E62BDD54}:'Windows Script Host Object Model'.WshEnvironment";
        EnvironmentPath: Text;
        ActiveSession: Record 2000000110;
        Asteric: Label 'ENU=''';
    begin
        //>>Pranavi
        //IF NOT (USERID IN['EFFTRONICS\VIJAYA','ERPSERVER\ADMINISTRATOR']) THEN
        //BEGIN*
        /*
        IF NOT (USERID IN ['ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\20TE106', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\20TE128', 'EFFTRONICS\GRAVI', 'EFFTRONICS\20TE099']) THEN BEGIN
            IF (CURRENTCLIENTTYPE = CLIENTTYPE::Windows) THEN BEGIN
                //    IF /ISCLEAR(WSHShell) THEN
                //CREATE(WSHShell,FALSE,TRUE);
                EnvironmentPath := 'Process';
                //WshEnvironment := WSHShell.Environment(EnvironmentPath);
                // EnvironmentPath := Asteric + '@' + UPPERCASE(WshEnvironment.Item('ComputerName')) + '*' + Asteric; B2BUPG
                IF STRLEN(EnvironmentPath) > 3 THEN BEGIN
                    ActiveSession.RESET;
                    ActiveSession.SETRANGE("User ID", USERID);
                    ActiveSession.SETRANGE("Client Type", ActiveSession."Client Type"::"Windows Client");
                    ActiveSession.SETFILTER("Client Computer Name", EnvironmentPath);
                    ActiveSession.SETFILTER("Session ID", '<>%1', SESSIONID);
                    IF ActiveSession.COUNT > 0 THEN
                        ERROR('You are Already Logged-In!');
                END;
            END ELSE
                
                IF CURRENTCLIENTTYPE = CLIENTTYPE::Web THEN BEGIN
                    ActiveSession.RESET;
                    ActiveSession.SETRANGE("User ID", USERID);
                    ActiveSession.SETRANGE("Client Type", ActiveSession."Client Type"::"Web Client");
                    ActiveSession.SETFILTER("Session ID", '<>%1', SESSIONID);
                    IF ActiveSession.COUNT > 0 THEN
                        ERROR('You are Already Logged-In!');
                END;

            //ERROR(USERID+'Temperarily ERP access is denied by ERP Team.\Please contact ERP Team!');
        END;
        //<<Pranavi
        */  //Temp
    end;
    //<<Codeunit40clos<<




    //<<Codeunit22opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        MSPT: Integer;
        MSPTCustEntry: Codeunit 60007;
        PerAmount: Decimal;
        check: Integer;
        Count1: Integer;
        Count2: Integer;
        Opp: Record 5092;
        OpportunityEntry: Record 5093;
        ScheduleComp: Record 60095;
        ItemJournalLineGrec: Record 83;
        ItemJnlPostLine1: Codeunit 22;
        LineNoc: Integer;
        GenJnlLineLRec: Record 81;
        LineNoGnlJnl: Integer;
        GenJnlPostLine1: Codeunit 12;
        Amount: Decimal;
        SalesLine1: Record 37;
        ScheduleComp1: Record 60095;
        Qty: Decimal;
        ReservationEntry: Record 337;
        Item1: Record 27;
    // ValidateEInvoiceRequest: Codeunit 15000053;
    begin
        //>>E-INV
        /* IF SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" THEN
            ValidateEInvoiceRequest.CheckValidEntriesApplied(SalesHeader); */
        //<<E-INV


        //B2B-MSPT1.0 For testing the MSPT Date Field
        IF SalesHeader."MSPT Code" <> '' THEN BEGIN
            IF SalesHeader."MSPT Date" = 0D THEN
                SalesHeader.TESTFIELD("MSPT Date");
        END;
        //B2B-MSPT1.0
    end;
    //<<Codeunit22clos<<



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnCheckAndUpdateOnAfterSetSourceCode', '', False, False)]
    local procedure OnCheckAndUpdateOnAfterSetSourceCode(SalesHeader: Record "Sales Header"; SourceCodeSetup: Record "Source Code Setup"; var SrcCode: Code[10]);
    var
        SalesLineGrec: Record "Sales Line";
        ScheduleComp: Record Schedule2;
        PostWhseJnlLine: Boolean;
        LineNo: Integer;
        ItemJournalLineGrec: Record 83;
        CheckApplFromItemEntry: Boolean;
        QtyToBeShippedBase: Decimal;
        ReserveDelChallanLine: Codeunit "Schedule Line Reserve1";
        ItemJnlPostLine1: Codeunit "Item Jnl.-Post Line";
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        ShptEntryNum: Integer;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ScheduleCompGrec: Record Schedule2;
        SalesLine: Record "Sales Line";
    begin
        //B2B START
        PostWhseJnlLine := TRUE;
        SalesLineGrec.RESET;
        SalesLineGrec.SETRANGE("Document No.", SalesLine."No.");
        SalesLineGrec.SETRANGE("Line No.", SalesLine."Line No.");
        SalesLineGrec.SETFILTER("Qty. to Ship", '<>%1', 0);
        IF SalesLineGrec.FINDSET THEN BEGIN
            REPEAT
                MESSAGE('%1 -- %2---%3', SalesLineGrec."Document No.", SalesLineGrec."Line No.", SalesLineGrec."Qty. to Ship");
                ScheduleComp.RESET;
                ScheduleComp.SETRANGE("Document No.", SalesLineGrec."Document No.");
                ScheduleComp.SETRANGE("Document Line No.", SalesLineGrec."Line No.");
                ScheduleComp.SETRANGE(Type, ScheduleComp.Type::Item);
                //ScheduleComp.SETFILTER("Line No.",'<>%1',1000);
                ScheduleComp.SETFILTER("Qty. to Ship", '<>%1', 0);
                IF ScheduleComp.FINDSET THEN BEGIN
                    LineNo := 1000;
                    REPEAT
                        IF ScheduleComp."Document Line No." <> ScheduleComp."Line No." THEN BEGIN
                            MESSAGE('%1 -- %2---%3', ScheduleComp."Document No.", ScheduleComp."Document Line No.", SalesLineGrec."Line No.");
                            ItemJournalLineGrec.INIT;
                            ItemJournalLineGrec."Journal Template Name" := 'Item';
                            ItemJournalLineGrec."Journal Batch Name" := 'Default';
                            // ItemJournalLineGrec."Document No." :=   ScheduleComp."Document No.";
                            ItemJournalLineGrec."Document No." := SalesHeader."Shipping No."; //Above line commented and added by pranavi for tracking shipement no.
                            ItemJournalLineGrec."Entry Type" := ItemJournalLineGrec."Entry Type"::Sale;//B2B1.1
                            ItemJournalLineGrec."Document Type" := ItemJournalLineGrec."Document Type"::"Sales Shipment"; //B2B1.1
                            ItemJournalLineGrec."Line No." := ScheduleComp."Line No.";
                            ItemJournalLineGrec.VALIDATE("Item No.", ScheduleComp."No.");
                            ItemJournalLineGrec.Description := ScheduleComp.Description;
                            ItemJournalLineGrec."Posting Date" := SalesHeader."Posting Date";
                            ItemJournalLineGrec.VALIDATE(Quantity, ScheduleComp."Qty. to Ship");
                            //ItemJournalLineGrec.Amount := ScheduleComp.Amount;
                            ItemJournalLineGrec.VALIDATE(Amount, ScheduleComp.Amount);
                            ItemJournalLineGrec."Source No." := '';
                            ItemJournalLineGrec.VALIDATE("Unit of Measure Code", ScheduleComp."Unit of Measure Code"); // by pranavi on 10 may 2016
                                                                                                                       // ItemJournalLineGrec."Location Code" := SalesLine."Location Code";
                            ItemJournalLineGrec."Location Code" := ScheduleComp."Location Code";
                            ItemJournalLineGrec."Variant Code" := SalesLineGrec."Variant Code";
                            ItemJournalLineGrec."Product Group Code Cust" := '';
                            ItemJournalLineGrec."Item Category Code" := '';
                            ItemJournalLineGrec."Gen. Bus. Posting Group" := SalesLineGrec."Gen. Bus. Posting Group";
                            ItemJournalLineGrec."Gen. Prod. Posting Group" := SalesLineGrec."Gen. Prod. Posting Group";
                            ItemJournalLineGrec."Dimension Set ID" := SalesLineGrec."Dimension Set ID";    // Added by Pranavi on 28-May-2016
                                                                                                           //
                            CheckApplFromItemEntry := FALSE;
                            QtyToBeShippedBase := ScheduleComp."Quantity(Base)";
                            ReserveDelChallanLine.TransferDelLineToItemJnlLine(
                            ScheduleComp, ItemJournalLineGrec, QtyToBeShippedBase, CheckApplFromItemEntry);
                            //

                            ScheduleComp."Qty. Shipped" += ScheduleComp."Qty. to Ship";
                            ScheduleComp."Qty.Shipped (Base)" += ScheduleComp."Qty. to Ship";// need to check based on review (b2b)
                            ScheduleComp."Outstanding Qty." := ScheduleComp.Quantity - ScheduleComp."Qty. Shipped";
                            CLEAR(ScheduleComp."Qty. to Ship");
                            CLEAR(ScheduleComp."Qty. to ship (Base)");
                            ScheduleComp.MODIFY;
                            //
                            ItemJnlPostLine1.RunWithCheck(ItemJournalLineGrec);
                            LineNo += 1000;
                            IF ItemJnlPostLine1.CollectTrackingSpecification(TempHandlingSpecification) THEN
                                IF TempHandlingSpecification.FINDSET THEN
                                    REPEAT
                                        TempTrackingSpecification := TempHandlingSpecification;
                                        TempTrackingSpecification."Source Type" := DATABASE::Schedule2;
                                        TempTrackingSpecification."Source ID" := ScheduleCompGrec."Document No.";
                                        TempTrackingSpecification."Source Batch Name" := '';
                                        TempTrackingSpecification."Source Prod. Order Line" := ScheduleCompGrec."Document Line No.";
                                        TempTrackingSpecification."Source Ref. No." := ScheduleCompGrec."Line No.";
                                        IF TempTrackingSpecification.INSERT THEN;
                                    UNTIL TempHandlingSpecification.NEXT = 0;

                            ShptEntryNum := InsertShptEntryRelation1(ScheduleComp);
                        END;
                    UNTIL ScheduleComp.NEXT = 0;
                END;
            UNTIL SalesLineGrec.NEXT = 0;
        END;
        //B2B END
    end;

    LOCAL procedure InsertShptEntryRelation1(VAR ScheduleComp: Record Schedule2): Integer
    var
        ItemEntryRelation: Record "Item Entry Relation";
        TempHandlingSpecification: Record "Tracking Specification" temporary;
        ItemLedgShptEntryNo: Integer;
    begin
        TempHandlingSpecification.RESET;
        IF TempHandlingSpecification.FINDSET THEN BEGIN
            REPEAT
                ItemEntryRelation.INIT;
                ItemEntryRelation."Item Entry No." := TempHandlingSpecification."Entry No.";
                ItemEntryRelation."Serial No." := TempHandlingSpecification."Serial No.";
                ItemEntryRelation."Lot No." := TempHandlingSpecification."Lot No.";
                ItemEntryRelation.TransferFieldsPostedMTLine(ScheduleComp);
                ItemEntryRelation.INSERT;
            UNTIL TempHandlingSpecification.NEXT = 0;
            TempHandlingSpecification.DELETEALL;
            EXIT(0);
        END ELSE
            EXIT(ItemLedgShptEntryNo);
    end;

    //EFF02NOV22>>
    /*
        //<<Codeunit81opn>>
        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
        local procedure OnConfirmPostOnBeforeSetSelection(var SalesHeader: Record "Sales Header")
        var
            Selection: Integer;
        begin
            if SalesHeader.SaleDocType = SalesHeader.SaleDocType::amc then begin //EFFUPG1.5

                Selection := STRMENU(Text000, 3);
                IF Selection = 0 THEN
                    EXIT;
                SalesHeader.Ship := Selection IN [1, 3];
                SalesHeader.Invoice := Selection IN [2, 3];
            END;
        end;
        //<<Codeunit81clos<<


    */  //EFF02NOV22<<

    //<<Codeunit81opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterPost', '', false, false)]  //EFFUPG1.2
    local procedure OnRunPreviewOnAfterSetPostingFlags1(var SalesHeader: Record "Sales Header")
    begin

        //B2BUpg>>
        /*IF SalesHeader."Document Type" = SalesHeader."Document Type"::Amc THEN BEGIN
            SQLConnection.CommitTrans;
            RecordSet.Close;
            SQLConnection.Close;
            ConnectionOpen := 0;
        END;*/
        //B2BUpg<<
        //End by Pranavi
        //B2B
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);
        //B2B
    END;
    //<<Codeunit81clos<<




    //<<Codeunit83opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnAfterSalesQuoteToOrderRun', '', false, false)]
    local procedure OnAfterSalesQuoteToOrderRun1(var SalesHeader2: Record "Sales Header"; var SalesHeader: Record "Sales Header")
    var
        MSPTOrderDetails: Record 60083;
        MSPTOrderDetails1: Record 60083;
    begin

        //B2B
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);
        //B2B

        SH.SETRANGE(SH."No.", SalesHeader."No.");
        IF SH.FINDFIRST THEN
            SH.CALCFIELDS(SH."Quote Value");
        QV := SH."Quote Value";
        REPORT.RUN(50096, FALSE, FALSE, SH);
        REPORT.SAVEASHTML(50096, '\\erpserver\ErpAttachments\Quote detail.html', SH);
        Attachment1 := '\\erpserver\ErpAttachments\Quote detail.html';

        charline := 10;
        Mail_Body := '';

        Mail_Subject := 'ERP- Quote Converted to Order';
        Mail_Body := 'QUOTE DETAILS :';
        Mail_Body += FORMAT(charline);
        Mail_Body += FORMAT(charline);
        Mail_Body += 'Quote No            :' + SalesHeader."No.";
        Mail_Body += FORMAT(charline);
        Mail_Body += 'Customer Name       :' + SalesHeader."Sell-to Customer Name";
        Mail_Body += FORMAT(charline);
        Mail_Body += FORMAT(charline);
        Mail_Body += 'Quote Value         :' + FORMAT(ROUND(QV, 1));
        Mail_Body += FORMAT(charline);
        IF SalesHeader."Salesperson Code" = '' THEN
            ERROR('PICK THE SALES PERSON CODE');
        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", SalesHeader."Salesperson Code");//B2B
        IF "Mail-Id".FINDFIRST THEN
            Mail_Body += 'Sales Executive     :' + "Mail-Id"."User Name";
        Mail_Body += FORMAT(charline);
        Mail_Body += FORMAT(charline);

        Mail_Body += '*** Auto Mail Generated from ERP ***';

        "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERID);//B2B
        IF "Mail-Id".FINDFIRST THEN
            //  "from Mail" := "Mail-Id".MailID;

            /*  "to mail".Add('dir@efftronics.com');
              "to mail".Add('padmaja@efftronics.com');
              "to mail".Add('cvmohan@efftronics.com');
              "to mail".Add('anilkumar@efftronics.com');
              "to mail".Add('phani@efftronics.com');
              "to mail".Add('ravi@efftronics.com');
              "to mail".Add('samba@efftronics.com');
              //"to mail".Add('baji@efftronics.com'); 10-08-2022
              "to mail".Add('prasannat@efftronics.com');
              //"to mail".Add('anuradhag@efftronics.com');10-08-2022
              "to mail".add('chandi@efftronics.com');
              "to mail".Add('anulatha@efftronics.com');
              //"to mail".Add('milind@efftronics.com'); 10-08-2022
              "to mail".Add('srasc@efftronics.com');
              "to mail".Add('renukach@efftronics.com');*/

        "to mail".Add('erp@efftronics.com');


        // mail.NewCDOMessage("from Mail", "to mail", Mail_Subject, Mail_Body,  Attachment1);
        EmailMessage.Create("to mail", Mail_Subject, Mail_Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22





        //B2B-MSPT1.0
        MSPTOrderDetails.SETRANGE(Type, MSPTOrderDetails.Type::Sale);
        MSPTOrderDetails.SETRANGE("Document Type", MSPTOrderDetails."Document Type"::Quote);
        MSPTOrderDetails.SETRANGE(MSPTOrderDetails."Document No.", SalesHeader."No.");
        IF MSPTOrderDetails.FINDSET THEN BEGIN
            REPEAT
                MSPTOrderDetails1.Type := MSPTOrderDetails.Type::Sale;
                MSPTOrderDetails1."Party Type" := MSPTOrderDetails."Party Type"::Customer;
                MSPTOrderDetails1."Document Type" := MSPTOrderDetails."Document Type"::Order;
                MSPTOrderDetails1."Party No." := MSPTOrderDetails."Party No.";
                MSPTOrderDetails1."MSPT Header Code" := MSPTOrderDetails."MSPT Header Code";
                MSPTOrderDetails1."MSPT Line No." := MSPTOrderDetails."MSPT Line No.";
                MSPTOrderDetails1."MSPT Code" := MSPTOrderDetails."MSPT Code";
                MSPTOrderDetails1.Percentage := MSPTOrderDetails.Percentage;
                MSPTOrderDetails1.Description := MSPTOrderDetails.Description;
                MSPTOrderDetails1."Calculation Period" := MSPTOrderDetails."Calculation Period";
                MSPTOrderDetails1.Remarks := MSPTOrderDetails.Remarks;
                MSPTOrderDetails1."Due Date" := MSPTOrderDetails."Due Date";
                MSPTOrderDetails1."Document No." := SalesHeader2."No.";
                MSPTOrderDetails1.INSERT;
            UNTIL MSPTOrderDetails.NEXT = 0;
        END;
        MSPTOrderDetails.SETRANGE(Type, MSPTOrderDetails.Type::Sale);
        MSPTOrderDetails.SETRANGE("Document Type", MSPTOrderDetails."Document Type"::Quote);
        MSPTOrderDetails.SETRANGE(MSPTOrderDetails."Document No.", ItemNo);
        IF MSPTOrderDetails.FINDFIRST THEN BEGIN
            MSPTOrderDetails.DELETEALL;
        END;
        //B2B-MSPT1.0
    end;
    //<<Codeunit83clos<<



    //<<Codeunit84opn>>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnBeforeRun', '', False, False)]
    local procedure OnBeforeRun(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader.TESTFIELD("Sale Order Total Amount");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blnkt Sales Ord. to Ord. (Y/N)", 'OnAfterCreateSalesOrder', '', false, false)]
    local procedure OnAfterCreateSalesOrder1(var SalesHeader: Record "Sales Header"; var SkipMessage: Boolean)
    var
        "Mail-Id": Record 2000000120;
        "from Mail": Text[100];
        "to mail": list of [text];
        Mail_Subject: Text[250];
        Mail_Body: Text[250];
        mail: Codeunit 397;
        charline: Char;
        SH: Record 36;
        Attachment: Text[1000];
        //objEmailConf : Automation "{CD000000-8B95-11D1-82DB-00C04FB1625D} 1.0:{CD000002-8B95-11D1-82DB-00C04FB1625D}:'Microsoft CDO for Windows 2000 Library'.Configuration";
        //objEmail : Automation "{CD000000-8B95-11D1-82DB-00C04FB1625D} 1.0:{CD000001-8B95-11D1-82DB-00C04FB1625D}:'Microsoft CDO for Windows 2000 Library'.Message";
        // flds : Automation "{00000205-0000-0010-8000-00AA006D2EA4} 2.5:{00000564-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.5 Library'.Fields";
        //fld : Automation "{00000205-0000-0010-8000-00AA006D2EA4} 2.5:{00000569-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.5 Library'.Field";
        SMTPSETUP: Record 50018;
        "--Rev01--": Integer;
        UserSetup: Record 91;
        BlanketSalesLines: Record 37;
        PartialConverted: Boolean;
        TH: Record 60062;

    begin
        charline := 10;
        /* Mail_Body : = '';
         Mail_Subject := 'ERP- Blanket Order Converted to Order';
         Mail_Body : = 'Blanket Order No.        : ' + SalesHeader."No.";
         Mail_Body + = FORMAT(charline);
         Mail_Body + = 'Customer Name            : ' + SalesHeader."Sell-to Customer Name";
         Mail_Body + = FORMAT(charline);
         IF SalesHeader."Salesperson Code" = '' THEN
             ERROR('PICK THE SALES PERSON CODE');
         //Rev01
         UserSetup.RESET;
         UserSetup.SETRANGE(UserSetup."Current UserId", SalesHeader."Salesperson Code");
         IF UserSetup.FINDFIRST THEN BEGIN
             "Mail-Id".RESET;
             "Mail-Id".SETRANGE("Mail-Id"."User Name", UserSetup."User ID")
         END ELSE
             ERROR('No user Setup is defined for %1', SalesHeader."Salesperson Code");

         IF "Mail-Id".FINDFIRST THEN
             Mail_Body + = 'Sales Executive          : ' + "Mail-Id"."User Name";
         Mail_Body + = FORMAT(charline);
         Mail_Body + = FORMAT(charline);*/

        "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);//B2B
        IF "Mail-Id".FINDFIRST THEN
            // "from Mail" := "Mail-Id".MailID;
            //Rev01 --

            SH.SETRANGE(SH."No.", SalesHeader."No.");
        IF SH.FINDFIRST THEN
            REPORT.RUN(50096, FALSE, FALSE, SH);
        //REPORT.SAVEASHTML(50096,'\\erpserver\ErpAttachments\Order.html',FALSE,SH);
        //Attachment:='\\erpserver\ErpAttachments\Order.html';
        /* "to mail".Add('dir@efftronics.com');
         "to mail".Add('sal@efftronics.com');
         "to mail".Add('erp@efftronics.com');
         "to mail".Add('prasanthi@efftronics.com');
         "to mail".Add('padmaja@efftronics.com');
         "to mail".add('cvmohan@efftronics.com');
         "to mail".Add('purchase@efftronics.com');
         "to mail".Add('bharat@efftronics.com');
         "to mail".Add('bsrilatha@efftronics.com');
         "to mail".Add('jhansi@efftronics.com');
         "to mail".Add('phani@efftronics.com');
         "to mail".Add('sambireddy@efftronics.com');*/
        "from Mail" := 'erp@efftronics.com';
        "to mail".Add('erp@efftronics.com');
        // "to mail".Add('sundar@efftronics.com');
        //    IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
        //   mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,A ttachment);
        //Added by Pranavi on 08-Dec-2015 for not updating sale order created field if order is partially converted
        PartialConverted := FALSE;
        BlanketSalesLines.RESET;
        BlanketSalesLines.SETRANGE(BlanketSalesLines."Document No.", SalesHeader."No.");
        IF BlanketSalesLines.FINDSET THEN
            REPEAT
                IF BlanketSalesLines.Quantity <> BlanketSalesLines."Quantity Shipped" THEN
                    PartialConverted := TRUE;
            UNTIL (BlanketSalesLines.NEXT = 0) OR (PartialConverted = TRUE);
        SalesHeader."Sale Order Created" := NOT (PartialConverted);
        //End by Pranavi on 08-Dec-2015

        // Start--added by pranavi on 28-Oct-2016 for tender status updation
        IF TH."Tender No." <> '' THEN BEGIN
            TH.RESET;
            TH.SETRANGE(TH."Tender No.", Th."Tender No.");
            IF TH.FINDFIRST THEN BEGIN
                TH."Sales Order Created" := TRUE;
                TH."Tender Status" := TH."Tender Status"::Received;
                TH.MODIFY;
            END;
        END;
        // ENd--added by pranavi on 28-Oct-2016 for tender status updation

        //"Sale Order Created":=TRUE; //Commented by Pranavi on 08-Dec-2015 for not updating sale order created field if order is partially converted

    end;

    //<<Codeunit84clos<<


    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeDeleteSalesQuote', '', false, false)]
    local procedure OnBeforeDeleteSalesQuote(var QuoteSalesHeader: Record "Sales Header"; var OrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean; var SalesQuoteLine: Record "Sales Line")
    var

    begin
        //B2B
        //SalesDesignQuotetoOrder(Rec); commented by B2B sankar
        //B2B
        //NSS 100907 copying attachments
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Sales Header");
        Attach.SETRANGE("Document No.", OrderSalesHeader."No.");
        IF Attach.FINDSET THEN
            REPEAT
                PostAttach.INIT;
                Attach.CALCFIELDS(Attach.FileAttachment);
                PostAttach.TRANSFERFIELDS(Attach);
                PostAttach."Table ID" := DATABASE::"Sales Header";
                PostAttach."Document No." := OrderSalesHeader."No.";
                PostAttach."Document Type" := PostAttach."Document Type"::Order;
                PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
        //NSS 100907
    end;
    //<<Codeunit86clos<<




    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnAfterInsertSalesOrderLine', '', false, false)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; SalesQuoteLine: Record "Sales Line"; SalesQuoteHeader: Record "Sales Header")
    begin
        //SH1.0
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Quote);
        Schedule.SETRANGE("Document No.", SalesQuoteLine."Document No.");
        Schedule.SETRANGE("Document Line No.", SalesQuoteLine."Line No.");
        IF Schedule.FINDSET THEN
            REPEAT
                Schedule2.INIT;
                Schedule2.TRANSFERFIELDS(Schedule);
                Schedule2."Document Type" := Schedule2."Document Type"::Order;
                Schedule2."Document No." := SalesQuoteLine."Document No.";
                Schedule2."Document Line No." := SalesQuoteLine."Line No.";
                Schedule2.INSERT;
                Schedule.DELETE;
            UNTIL Schedule.NEXT = 0;
        //SH1.0
    end;
    //<<Codeunit86clos<<

    //<<Codeunit86opn>>
    PROCEDURE SalesDesignQuotetoOrder(VAR Saleshdr: Record 36);
    VAR
        SalesLineDesign: Record 37;
        DesignWorkSheetQuaote: Record 60006;
        DesignWorkSheetLineQuote: Record 60007;
        DesignWorksheetHeader: Record 60006;
        DesignWorksheetLine: Record 60007;
    BEGIN
        SalesLineDesign.SETRANGE("Document Type", Saleshdr."Document Type");
        SalesLineDesign.SETRANGE("Document No.", Saleshdr."No.");
        IF SalesLineDesign.FINDSET THEN
            REPEAT
                DesignWorkSheetQuaote.SETRANGE("Document Type", DesignWorkSheetQuaote."Document Type"::Quote);
                DesignWorkSheetQuaote.SETRANGE("Document No.", SalesLineDesign."Document No.");
                DesignWorkSheetQuaote.SETRANGE("Document Line No.", SalesLineDesign."Line No.");
                IF DesignWorkSheetQuaote.FINDFIRST THEN BEGIN
                    DesignWorksheetHeader.INIT;
                    DesignWorksheetHeader."Document Type" := DesignWorksheetHeader."Document Type"::Order;
                    DesignWorksheetHeader."Document No." := DesignWorkSheetQuaote."Document No.";
                    DesignWorksheetHeader."Document Line No." := DesignWorkSheetQuaote."Document Line No.";
                    DesignWorksheetHeader."Item No." := DesignWorkSheetQuaote."Item No.";
                    DesignWorksheetHeader.Description := DesignWorkSheetQuaote.Description;
                    DesignWorksheetHeader.Quantity := DesignWorkSheetQuaote.Quantity;
                    DesignWorksheetHeader."Unit of Measure" := DesignWorkSheetQuaote."Unit of Measure";
                    DesignWorksheetHeader."Soldering Time for SMD" := DesignWorkSheetQuaote."Soldering Time for SMD";
                    DesignWorksheetHeader."Soldering time for DIP" := DesignWorkSheetQuaote."Soldering time for DIP";
                    DesignWorksheetHeader."Total time in Hours" := DesignWorkSheetQuaote."Total time in Hours";
                    DesignWorksheetHeader."Soldering Cost Perhour" := DesignWorkSheetQuaote."Soldering Cost Perhour";
                    DesignWorksheetHeader."Development Cost" := DesignWorkSheetQuaote."Development Cost";
                    DesignWorksheetHeader."Development Time in hours" := DesignWorkSheetQuaote."Development Time in hours";
                    DesignWorksheetHeader."Development Cost per hour" := DesignWorkSheetQuaote."Development Cost per hour";
                    DesignWorksheetHeader."Additional Cost" := DesignWorkSheetQuaote."Additional Cost";
                    DesignWorksheetHeader."Production Bom No." := DesignWorkSheetQuaote."Production Bom No.";
                    DesignWorksheetHeader."Production Bom Version No." := DesignWorkSheetQuaote."Production Bom Version No.";
                    DesignWorksheetHeader."Total Cost" := DesignWorkSheetQuaote."Total Cost";
                    DesignWorkSheetQuaote.CALCFIELDS(DesignWorkSheetQuaote."Components Cost", DesignWorkSheetQuaote."Manufacturing Cost",
                          DesignWorkSheetQuaote."Resource Cost", DesignWorkSheetQuaote."Installation Cost");
                    DesignWorksheetHeader."Components Cost" := DesignWorkSheetQuaote."Components Cost";
                    DesignWorksheetHeader."Manufacturing Cost" := DesignWorkSheetQuaote."Manufacturing Cost";
                    DesignWorksheetHeader."Resource Cost" := DesignWorkSheetQuaote."Resource Cost";
                    DesignWorksheetHeader."Installation Cost" := DesignWorkSheetQuaote."Installation Cost";
                    DesignWorksheetHeader."Total Cost (From Line)" := DesignWorkSheetQuaote."Total Cost (From Line)";
                    IF DesignWorksheetHeader."Document No." <> '' THEN
                        DesignWorksheetHeader.INSERT;
                    DesignWorkSheetLineQuote.SETRANGE("Document Type", DesignWorkSheetLineQuote."Document Type"::Quote);
                    DesignWorkSheetLineQuote.SETRANGE("Document No.", DesignWorkSheetQuaote."Document No.");
                    DesignWorkSheetLineQuote.SETRANGE("Document Line No.", DesignWorkSheetQuaote."Document Line No.");
                    IF DesignWorkSheetLineQuote.FINDSET THEN
                        REPEAT
                            DesignWorksheetLine."Document No." := DesignWorksheetHeader."Document No.";
                            DesignWorksheetLine."Document Type" := DesignWorksheetLine."Document Type"::Order;
                            DesignWorksheetLine."Document Line No." := DesignWorksheetHeader."Document Line No.";
                            DesignWorksheetLine."Line No." := DesignWorkSheetLineQuote."Line No.";
                            DesignWorksheetLine."Line No." := DesignWorksheetLine."Line No." + 10000;
                            DesignWorksheetLine.Type := DesignWorkSheetLineQuote.Type;
                            DesignWorksheetLine."No." := DesignWorkSheetLineQuote."No.";
                            DesignWorksheetLine.Description := DesignWorkSheetLineQuote.Description;
                            DesignWorksheetLine."Description 2" := DesignWorkSheetLineQuote."Description 2";
                            DesignWorksheetLine."No.of SMD Points" := DesignWorkSheetLineQuote."No.of SMD Points";
                            DesignWorksheetLine."No.of DIP Points" := DesignWorkSheetLineQuote."No.of DIP Points";
                            DesignWorksheetLine."Unit of Measure" := DesignWorkSheetLineQuote."Unit of Measure";
                            DesignWorksheetLine.Quantity := DesignWorkSheetLineQuote.Quantity;
                            DesignWorksheetLine."Unit Cost" := DesignWorkSheetLineQuote."Unit Cost";
                            DesignWorksheetLine.Amount := DesignWorkSheetLineQuote.Amount;
                            DesignWorksheetLine."Total time in Hours" := DesignWorkSheetLineQuote."Total time in Hours";
                            DesignWorksheetLine."Manufacturing Cost" := DesignWorkSheetLineQuote."Manufacturing Cost";
                            DesignWorksheetLine.INSERT;
                        UNTIL DesignWorkSheetLineQuote.NEXT = 0;
                END;
            UNTIL SalesLineDesign.NEXT = 0;
    END;
    //<<Codeunit86clos<<

    //<<Codeunit87opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip', '', false, false)]
    local procedure OnRunOnBeforeValidateBlanketOrderSalesLineQtytoShip(var BlanketOrderSalesLine: Record "Sales Line"; SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        //SH1.0
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
        Schedule.SETRANGE("Document No.", BlanketOrderSalesLine."Document No.");
        Schedule.SETRANGE("Document Line No.", BlanketOrderSalesLine."Line No.");
        IF Schedule.FINDSET THEN
            REPEAT
                Schedule2.INIT;
                Schedule2.TRANSFERFIELDS(Schedule);
                ResetScheduleItemQuantityFields(Schedule2); // COMMENTED DUE TO QTY NOT TRANSFERING WHILE CONVERTING THE ORDER
                Schedule2.Quantity := Schedule."Qty. to Ship";
                Schedule2.VALIDATE(Quantity);
                Schedule2."Document Type" := Schedule2."Document Type"::Order;
                Schedule2."Document No." := SalesOrderLine."Document No.";
                Schedule2."Document Line No." := SalesOrderLine."Line No.";
                Schedule2.INSERT;
            UNTIL Schedule.NEXT = 0;
        //SH1.0
        // NULLFIYING THE SCHEDULE QUANTITY
        Schedule.RESET;
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
        Schedule.SETRANGE("Document No.", BlanketOrderSalesLine."Document No.");
        Schedule.SETRANGE("Document Line No.", BlanketOrderSalesLine."Line No.");
        IF Schedule.FINDSET THEN
            REPEAT
                Schedule."To be Shipped Qty" := 0;
                Schedule."Material Required Date" := 0D;
                // Pranavi
                Schedule."Qty. Shipped" += Schedule."Qty. to Ship";
                Schedule."Qty.Shipped (Base)" := Schedule."Qty. Shipped";
                Schedule."Outstanding Qty." := Schedule.Quantity - Schedule."Qty. Shipped";
                Schedule."Outstanding Qty.(Base)" := Schedule."Outstanding Qty.";
                Schedule."Qty. to Ship" := 0;
                Schedule."Qty. to ship (Base)" := 0;
                // Pranavi End
                Schedule.MODIFY;
            UNTIL Schedule.NEXT = 0;
        //CODE ADDED BY SANTHOSH KUMAR
        //EFFUPG1.2>>

        IF BlanketOrderSalesLine."Qty. to Ship" <> 0 THEN BEGIN
            BlanketOrderSalesLine."Quantity Shipped" += BlanketOrderSalesLine."Qty. to Ship";   //Added by Pranavi on 08-Dec-2015
            BlanketOrderSalesLine.VALIDATE("Quantity Shipped");   //Added by Pranavi on 08-Dec-2015
                                                                  // Added by Pranavi on 05-01-2016
            BlanketOrderSalesLine."Qty. Shipped (Base)" := BlanketOrderSalesLine."Quantity Shipped";
            BlanketOrderSalesLine."Qty. Shipped Not Invoiced" += BlanketOrderSalesLine."Qty. to Ship";
            BlanketOrderSalesLine."Qty. Shipped Not Invd. (Base)" := BlanketOrderSalesLine."Qty. Shipped Not Invoiced";
            // End by Pranavi
            BlanketOrderSalesLine."Outstanding Quantity" := BlanketOrderSalesLine.Quantity - BlanketOrderSalesLine."Quantity Shipped";
            BlanketOrderSalesLine."Outstanding Qty. (Base)" := BlanketOrderSalesLine.Quantity - BlanketOrderSalesLine."Quantity Shipped";
        end;
        //EFFUPG1.2<<

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure ONBeforeSaleLineInsert(SalesOrderHeader: Record "Sales Header"; var SalesOrderLine: Record "Sales Line")
    begin
        // added by pranavi on 05-sep-2016 for payment terms
        IF SalesOrderLine."Document Type" = SalesOrderLine."Document Type"::Order THEN BEGIN
            SalesOrderHeader.RESET;
            SalesOrderHeader.SETRANGE("No.", SalesOrderLine."Document No.");
            IF SalesOrderHeader.FINDFIRST THEN
                IF SalesOrderHeader."Customer Posting Group" IN ['PRIVATE', 'OTHERS'] THEN
                    IF SalesOrderLine.Type = SalesOrderLine.Type::Item THEN BEGIN
                        SalesOrderLine."Supply Portion" := 100;
                        SalesOrderLine."Retention Portion" := 0;
                    END ELSE BEGIN
                        SalesOrderLine."Supply Portion" := 0;
                        SalesOrderLine."Retention Portion" := 100;
                    END;
        END;
        // end by pranavi

    end;


    //<<Codeunit87clos<<

    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeReserveItemsManuallyLoop', '', false, false)]
    local procedure OnBeforeReserveItemsManuallyLoop(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header"; var TempSalesLine: Record "Sales Line" temporary; var SuppressCommit: Boolean)
    begin
        //IF NOT LinesCreated THEN
        //  ERROR(Text002);
        //NSS 100907
        Attach.RESET;
        Attach.SETRANGE("Table ID", DATABASE::"Sales Header");
        Attach.SETRANGE("Document No.", SalesHeader."No.");
        IF Attach.FINDSET THEN
            REPEAT
                PostAttach.INIT;
                Attach.CALCFIELDS(Attach.FileAttachment);
                PostAttach.TRANSFERFIELDS(Attach);
                PostAttach."Table ID" := DATABASE::"Sales Header";
                PostAttach."Document No." := SalesOrderHeader."No.";
                PostAttach."Document Type" := PostAttach."Document Type"::Order;
                PostAttach.INSERT;
            UNTIL Attach.NEXT = 0;
        //NSS 100907

    end;
    //<<Codeunit86clos<<


    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]
    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var BlanketOrderSalesHeader: Record "Sales Header")
    var
        Schedule: Record 60095;
        Schedule2: Record 60095;
        Attach: Record 60098;
        PostAttach: Record 60098;
        BlanketOrderNo: Code[20];
        Noseries: Codeunit 396;
        SalesHeader: Record 36;

    begin
        BlanketOrderNo := BlanketOrderSalesHeader."No."; //added inorder to convert LMD Blanket orders as LMD Orders
        IF (COPYSTR(BlanketOrderNo, 15, 1) = 'L') OR (BlanketOrderNo IN ['EFF/EXP/13-14/0011', 'EFF/EXP/13-14/0012']) THEN BEGIN
            SalesOrderHeader."No." := Noseries.GetNextNo('SAL LED', WORKDATE, TRUE);
        END;

        // Added by Rakesh for Converting Effe HYD Blanket orders
        IF (COPYSTR(BlanketOrderNo, 15, 1) = 'T') THEN BEGIN
            SalesOrderHeader."No." := Noseries.GetNextNo('SALORD TEL', WORKDATE, TRUE);
        END;
        //end by Rakesh
    end;
    //<<Codeunit87clos<<



    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeSalesOrderHeaderModify', '', false, false)]
    local procedure OnBeforeSalesOrderHeaderModify(var SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        SalesOrderHeader."Blanket Order No" := BlanketOrderSalesHeader."No.";//EFF151222;
        SalesOrderHeader."Order Verified" := FALSE;   //Added by Pranavi on 12-Jan-2016 reset the order verified in created sale order
        SalesOrderHeader."Verification Status" := SalesOrderHeader."Verification Status"::" ";  //Added by Pranavi on 08-Dec-2016 reset the verification status in created sale order
        SalesOrderHeader."Order Released Date" := 0D;
        SalesOrderHeader."First Released Date Time" := 0DT;
        // anil added "Blanket order no" field
    end;

    //<<Codeunit87clos<<



    //<<Codeunit86opn>>
    PROCEDURE ResetScheduleItemQuantityFields(VAR TempSchLine: Record 60095);
    BEGIN
        TempSchLine.Quantity := 0;
        TempSchLine."Quantity(Base)" := 0;
        TempSchLine."Qty. to Ship" := 0;
        TempSchLine."Qty. to ship (Base)" := 0;
        TempSchLine."Qty. Shipped" := 0;
        TempSchLine."Qty.Shipped (Base)" := 0;
        TempSchLine."Outstanding Qty." := 0;
        TempSchLine."Outstanding Qty.(Base)" := 0;
        TempSchLine."To be Shipped Qty" := 0;
    END;
    //<<Codeunit87clos<<


    //<<Codeunit90pn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line")
    var
        TestValue: Decimal;
        "G|l": Record 98;
        Text062: Label 'ENU=Cashflow connection does not exist. Do you want to Continue %1?';

    begin

        //Added by sundar for resolving records missing in Cashflow
        "G|l".GET;
        IF NOT "G|l"."Active ERP-CF Connection" THEN BEGIN
            IF UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUNDAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                IF NOT CONFIRM(Text062, FALSE, PurchaseHeader."No.") THEN
                    EXIT;
            END
            ELSE
                ERROR('Cash Flow connection is not active Contact ERP Team');
        END;
        //Added by sundar for resolving records missing in Cashflow

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeInitNewGenJnlLineFromPostInvoicePostBufferLine', '', false, false)]
    local procedure OnBeforeInitNewGenJnlLineFromPostInvoicePostBufferLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; InvoicePostBuffer: Record "Invoice Post. Buffer"; var IsHandled: Boolean)
    begin
        GenJnlLine."Vendor Invoice Date" := PurchHeader."Vendor Invoice Date";
    end;


    //<<Codeunit90clos<<




    //<<Codeunit90opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostVendorEntry', '', false, false)]
    local procedure OnBeforePostVendorEntry(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        GenJnlLine."Vendor Invoice Date" := GenJnlLineVendInvDate;

    end;
    //<<Codeunit90clos<<

    //<<Codeunit90pn>>

    [EventSubscriber(ObjectType::codeunit, 90, 'OnAfterPurchRcptLineInsert', '', false, false)]
    procedure QualityCheckInspectPurch(PurchRcptLine: Record 121; PurchaseLine: Record 39; PurchRcptHeader: Record "Purch. Rcpt. Header");
    var



        PurchRcptLine3: Record 121;




    BEGIN
        IF PurchaseLine."Quality Before Receipt" THEN BEGIN
            PurchaseLine.CALCFIELDS("Quantity Accepted");
            IF PurchaseLine."Quantity Accepted" < PurchaseLine."Qty. to Receive" + PurchaseLine."Quantity Received" THEN
                ERROR(Text33000250, PurchaseLine."Document No.", PurchaseLine."Line No.");
            EXIT;
        END ELSE
            IF (PurchRcptLine.Type = PurchRcptLine.Type::Item)
     AND PurchRcptLine."QC Enabled" AND (PurchRcptLine.Quantity <> 0) THEN BEGIN
                IF PurchaseLine."Qty. Sending To Quality(R)" = 0 THEN BEGIN

                    InspectDataSheets."CreatePur.LineInspectDataSheet"(PurchRcptHeader, PurchRcptLine);
                    BOI_AlertMail(PurchaseLine);
                END
                ELSE BEGIN
                    PurchRcptLine3 := PurchRcptLine;
                    PurchRcptLine3.Quantity := PurchaseLine."Qty. Sending To Quality(R)";

                    InspectDataSheets."CreatePur.LineInspectDataSheet"(PurchRcptHeader, PurchRcptLine3);
                    IF PurchRcptLine.Quantity <> PurchaseLine."Qty. Sending To Quality(R)" THEN BEGIN
                        PurchRcptLine3.Quantity := PurchRcptLine.Quantity - PurchaseLine."Qty. Sending To Quality(R)";
                        InspectDataSheets."CreatePur.LineInspectDataSheet"(PurchRcptHeader, PurchRcptLine3);
                    END
                END
            END;
    END;

    //<<Codeunit90clos<<



    PROCEDURE QualityCheckInspect(TransferHeader: Record 5740);
    VAR
        TransferLine: Record 5741;
        Text33000250: Label 'ENU=You cannot Ship more than quality accepted quantity in Transfer Order %1 and Line No. %2.';
        Location: Record 14;
    BEGIN
        Location.GET(TransferHeader."Transfer-to Code");
        IF Location."QC Enabled Location" THEN BEGIN
            TransferLine.SETRANGE("Document No.", TransferHeader."No.");
            TransferLine.SETFILTER("QC Enabled", 'YES');
            IF TransferLine.FINDFIRST THEN
                TransferLine.CALCFIELDS("Quantity Accepted", TransferLine."Quantity Rejected");
            IF (TransferLine."Quantity Accepted" +
                  TransferLine."Quantity Rejected") < TransferLine."Qty. to Ship" + TransferLine."Quantity Shipped" THEN
                ERROR(Text33000250, TransferLine."Document No.", TransferLine."Line No.");
            EXIT;
        end;
    end;

    PROCEDURE checkvendorexciseinvoice(PurchHeader: Record 38): Boolean;
    VAR
        PurchaseLine: Record 39;
    BEGIN
        PurchaseLine.SETRANGE(PurchaseLine."Document Type", PurchHeader."Document Type");
        PurchaseLine.SETRANGE(PurchaseLine."Document No.", PurchHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        IF PurchaseLine.FINDSET THEN BEGIN
            MESSAGE('%1', PurchaseLine.COUNT);
            REPEAT
                IF (PurchaseLine."Qty. to Receive" <> 0) THEN
                    //IF (PurchaseLine."Excise %" <> 0) AND (PurchaseLine."Qty. to Receive" <> 0) THEN
                    //IF (PurchaseLine."BED %" <> 0) AND (PurchaseLine."Qty. to Receive" <> 0) THEN
                    IF (PurchHeader."Vendor Excise Invoice No." = '') THEN
                        EXIT(FALSE);
                CheckVendorExciseInvoiceNo(PurchHeader, PurchaseLine)
            UNTIL PurchaseLine.NEXT = 0;
        END;
        EXIT(TRUE);
    END;

    PROCEDURE CheckVendorExciseInvoiceNo(PurchHeader: Record 38; PurchaseLine: Record 39);
    VAR
    //RG23apartII: Record 13720;
    // RG23CpartII: Record 13722;
    BEGIN
        /* IF (PurchaseLine."Excise Accounting Type" = PurchaseLine."Excise Accounting Type"::"With CENVAT")
            AND (PurchaseLine.Type = PurchaseLine.Type::Item) AND (PurchaseLine."Capital Item" = FALSE) THEN BEGIN
             //RG23apartII.RESET;
             IF RG23apartII.FINDLAST THEN
                 IF RG23apartII."Vendor Excise Invoice No." = PurchHeader."Vendor Excise Invoice No." THEN BEGIN
                     RG23apartII.SETRANGE(RG23apartII."Vendor Excise Invoice No.", PurchHeader."Vendor Excise Invoice No.");
                     IF RG23apartII.FINDLAST THEN
                         ERROR('Please Enter different Vendor Excise Invoice No. %1 already exist', PurchHeader."Vendor Excise Invoice No.");
                 END;

         END;

         IF (PurchaseLine."Excise Accounting Type" = PurchaseLine."Excise Accounting Type"::"With CENVAT")
            AND (PurchaseLine.Type = PurchaseLine.Type::Item) AND (PurchaseLine."Capital Item" = TRUE) THEN BEGIN
             RG23CpartII.RESET;
             IF RG23CpartII.FINDLAST THEN
                 IF RG23CpartII."Vendor Excise Invoice No." <> PurchHeader."Vendor Excise Invoice No." THEN BEGIN
                     RG23CpartII.SETRANGE(RG23CpartII."Vendor Excise Invoice No.", PurchHeader."Vendor Excise Invoice No.");
                     IF RG23CpartII.FINDLAST THEN
                         ERROR('Please Enter different Vendor Excise Invoice No. %1 already exist', PurchHeader."Vendor Excise Invoice No.");
                 END;
         END;*/
    END;

    /* PROCEDURE CheckforTDS(VAR PurchaseHeader: Record 38);
     VAR
        // NODHeader: Record 13786;
         Text01: label 'ENU=Vendor is defined in NOD Header. Check for TDS! Do you want to Proceed?';
         Text02: label 'ENU=The Update has been interrupted to respect the warning!';
     BEGIN
         NODHeader.SETRANGE(NODHeader.Type, NODHeader.Type::Vendor);
         NODHeader.SETRANGE(NODHeader."No.", PurchaseHeader."Buy-from Vendor No.");
         IF NODHeader.FINDFIRST THEN BEGIN
             IF NOT CONFIRM(Text01, FALSE) THEN
                 ERROR(Text02);
         END;
     END;*/

    /*PROCEDURE CheckVEI(PurchHeader: Record 38);
     VAR
         PurchaseLine: Record 39;
         RG23apartII: Record 13720;
         RG23CpartII: Record 13722;
     BEGIN
     END;*/

    PROCEDURE CommaRemoval(Base: Text[30]) Converted: Text[30];
    VAR
        i: Integer;
    BEGIN
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    END;
    //<<Codeunit87clos<<



    //<<Codeunit90opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]
    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        PurchRcptHeader."Created Date Time" := CURRENTDATETIME;//EFFUPG
    end;

    //<<Codeunit90clos<<




    //<<Codeunit90opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvHeaderInsert', '', false, false)]
    local procedure OnBeforePurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        MESSAGE(FORMAT(PurchHeader."Posting No."));
        PurchInvHeader."Type of Supplier" := PurchHeader."Type of Supplier";
        PurchInvHeader."Vendor Excise Invoice No." := PurchHeader."Vendor Excise Invoice No.";          //sreenivas
        PurchInvHeader."Additional Duty Value" := PurchHeader."Additional Duty Value";

    end;
    //<<Codeunit90clos<<




    //<<Codeunit86opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeCheckExternalDocumentNumber', '', false, false)]
    local procedure OnBeforeCheckExternalDocumentNumber(VendorLedgerEntry: Record "Vendor Ledger Entry"; PurchaseHeader: Record "Purchase Header"; var Handled: Boolean; DocType: Option; ExtDocNo: Text[35])
    begin
        IF DATE2DMY(WORKDATE, 2) > 3 THEN
            FIN_YEAR := DATE2DMY(WORKDATE, 3)
        ELSE
            FIN_YEAR := DATE2DMY(WORKDATE, 3) - 1;


    end;
    //<<Codeunit90clos<<

    //<<Codeunit90opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckExternalDocumentNumberOnAfterSetFilters', '', false, false)]
    local procedure OnCheckExternalDocumentNumberOnAfterSetFilters(var VendLedgEntry: Record "Vendor Ledger Entry"; PurchaseHeader: Record "Purchase Header")
    begin
        //EFFUPG1.2>>
        IF DATE2DMY(WORKDATE, 2) > 3 THEN
            FIN_YEAR := DATE2DMY(WORKDATE, 3)
        ELSE
            FIN_YEAR := DATE2DMY(WORKDATE, 3) - 1;
        //EFFUPG1.2<<
        VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date", DMY2DATE(1, 4, FIN_YEAR), DMY2DATE(31, 3, FIN_YEAR + 1));//EFFUPG
    end;
    //<<Codeunit90clos<<

    //<<Codeunit86opn>>
    /* PROCEDURE BOI_AlertMail();
     VAR
         IH: Record 60024;
         "Mail-Id": Record 2000000120;
         MIH: Record 50001;
         MIL: Record 50002;
         Count: Integer;
     BEGIN
         // Created by Rakesh on 29-Nov-14 for Mail code for Alerting BOI inward
         Item.RESET;
         Item.SETFILTER(Item."No.", PurchLine."No.");
         IF Item.FINDFIRST THEN BEGIN
             IF (PurchHeader."Sale Order No" <> '') THEN BEGIN
           //changes by Ahamed on 01-DEC-14
          { mail_to := 'sales@efftronics.com,padmaja@efftronics.com,vsngeetha@efftronics.com,qainward@efftronics.com,purchase@efftronics.com,';
                 mail_to := mail_to + 'pmurali@efftronics.com,prasanthi@efftronics.com,erp@efftronics.com,pmsubhani@efftronics.com,cuspm@efftronics.com,bharat@efftronics.com,dineel@efftronics.com';
                 mail_from := 'erp@efftronics.com';
                 subject := 'Reg: Bought out Item - ' + PurchLine.Description + ' inwarded';
                 body := '';

                 SMTP_mail.CreateMessage('ERP', mail_from, mail_to, subject, body, TRUE);
                 SMTP_mail.AppendBody(' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                 SMTP_mail.AppendBody(' <body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Bought Out Item Inwarded</font></label>');
                 SMTP_mail.AppendBody(' <hr style=solid; color= #3333CC>');
                 SMTP_mail.AppendBody(' <h>Dear Sir/Madam,</h><br>');
                 SMTP_mail.AppendBody(' <P> BOUT Item Status Details </P>');
                 //IF (PurchHeader."No." = PurchLine."Document No.")
                 //BEGIN

                 SMTP_mail.AppendBody(' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>' + PurchLine.Description + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b> Item Number </b> </td><td>' + ItemJournalLine."Item No." + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b>Purchase Order No </b>    </td><td>' + PurchHeader."No." + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b>Sale Order No    </b> </td><td>' + PurchHeader."Sale Order No" + '</td></tr>');
                 salesheader.RESET;
                 salesheader.SETFILTER(salesheader."No.", PurchHeader."Sale Order No");
                 IF salesheader.FINDFIRST THEN BEGIN
                     SMTP_mail.AppendBody(' <tr><td><b>Customer Name   </b> </td><td>' + salesheader."Sell-to Customer Name" + '</td></tr>');
                 END;
                 // added by vishnu Priya for the Schedule line number Items addition on 05-Sept-2018
                 /*Schedule.RESET;
                 Schedule.SETFILTER("Document No.",PurchHeader."Sale Order No");
                 Schedule.SETFILTER("No.",PurchLine."No.");
                 IF Schedule.FINDSET THEN
                   BEGIN
                     SMTP_mail.AppendBody(' <tr><td><b> Sale Order Line Number </b></td><td>'+FORMAT(Schedule."Document Line No.")+'</td></tr>');
                     SMTP_mail.AppendBody(' <tr><td><b> Schedule Line Number </b></td><td>'+FORMAT(Schedule."Line No.")+'</td></tr>');
                     END;
                 // end by vishnu priya
                 SMTP_mail.AppendBody(' <tr><td><b> Received quantity </b></td><td>' + FORMAT(PurchLine."Qty. to Receive") + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b> To be recieved quantity  </b> </td><td>' + FORMAT(PurchLine.Quantity - (PurchLine."Quantity Received" + PurchLine."Qty. to Receive")) + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b> Total Ordered Quantity</b></td><td>' + FORMAT(PurchLine.Quantity) + '</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b> Total Received Quantity</b></td><td>' + FORMAT(PurchLine."Quantity Received" + PurchLine."Qty. to Receive") + '</td></tr></table>');
                 SMTP_mail.AppendBody(' <br>');
                 SMTP_mail.AppendBody(' <p align ="left"> Regards,<br>ERP Team </p>');
                 SMTP_mail.AppendBody(' <br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                 SMTP_mail.Send;}
           //end by ahmed
         END;
         IF (PurchLine."Location Code" = 'R&D STR') OR (PurchLine."Location Code" = 'CS STR') THEN
         BEGIN
            IH.RESET;
            IH.SETRANGE(IH."No.",PurchLine."Indent No.");
            IF IH.FINDFIRST THEN
            BEGIN
               "Mail-Id".RESET;
               "Mail-Id".SETRANGE("Mail-Id"."User Name",IH."Person Code");
                IF "Mail-Id".FINDFIRST THEN  BEGIN
                   mail_to := "Mail-Id".MailID ;
                END;
               //  mail_to := 'vijaya@efftronics.com';
                mail_from :='erp@efftronics.com';
                subject :='ERP- YOUR INDENTED ITEM ('+PurchLine.Description+') inwarded';
                body:='';

                SMTP_mail.CreateMessage('ERP',mail_from,mail_to,subject,body,TRUE);
                SMTP_mail.AppendBody(' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                SMTP_mail.AppendBody(' <body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Item Inwarded to Stores</font></label>');
                SMTP_mail.AppendBody(' <hr style=solid; color= #3333CC>');
                SMTP_mail.AppendBody(' <h>Dear Sir/Madam,</h><br>');
                 SMTP_mail.AppendBody(' <P> Item Status Details </P>');
                SMTP_mail.AppendBody(' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>'+PurchLine.Description+'</td></tr>');
                SMTP_mail.AppendBody(' <tr><td><b> Inward DATE & TIME </b> </td><td>'+FORMAT((TODAY),0,4)+FORMAT(TIME)+'</td></tr>');
                 SMTP_mail.AppendBody(' <tr><td><b> Indent Number </b> </td><td>' +PurchLine."Indent No."+'</td></tr>');
                SMTP_mail.AppendBody(' <tr><td><b>Purchase Order No </b></td><td>'+PurchHeader."No."+'</td></tr>');
                SMTP_mail.AppendBody(' <tr><td><b>Vendor Name </b>    </td><td>'+ PurchHeader."Buy-from Vendor Name" +'</td></tr>');
                SMTP_mail.AppendBody(' <tr><td><b> Received quantity </b></td><td>'+FORMAT(PurchLine."Qty. to Receive")+'</td></tr>');
                "Mail-Id".RESET;
                "Mail-Id".SETRANGE("Mail-Id"."User Name",USERID);
                IF "Mail-Id".FINDFIRST THEN  BEGIN
                    SMTP_mail.AppendBody(' <tr><td><b> Inward By </b></td><td>'+"Mail-Id"."User Name"+'</td></tr>');
                END;
                SMTP_mail.AppendBody(' </table>');
                SMTP_mail.AppendBody(' <br>');
                SMTP_mail.AppendBody(' <p align ="left"> Regards,<br>ERP Team </p>');
                SMTP_mail.AppendBody(' <br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                SMTP_mail.AddBCC('vijaya@efftronics.com');
                SMTP_mail.Send;
           END;
         END;


       END;
       // end by Rakesh
     END;

     EVENT RecordSet::WillChangeField@9(cFields : Integer;Fields : Variant;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::FieldChangeComplete@10(cFields : Integer;Fields : Variant;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::WillChangeRecord@11(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::RecordChangeComplete@12(adReason : Integer;cRecords : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::WillChangeRecordset@13(adReason : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::RecordsetChangeComplete(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::WillMove@15(adReason : Integer;adStatus : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::MoveComplete@16(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::EndOfRecordset@17(VAR fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::FetchProgress@18(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT RecordSet::FetchComplete@19(pError@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pRecordset@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
     BEGIN
     END;

     EVENT SQLConnection::InfoMessage@0(pError@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::BeginTransComplete@1(TransactionLevel@1102152003 : Integer;pError@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::CommitTransComplete@3(pError@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::RollbackTransComplete@2(pError@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::WillExecute@4(VAR Source@1102152007 : Text;CursorType@1102152006 : Integer;LockType@1102152005 : Integer;VAR Options@1102152004 : Integer;adStatus@1102152003 : Integer;pCommand@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset@1102152001 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::ExecuteComplete@5(RecordsAffected : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152003 : Integer;pCommand@1102152002 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset@1102152001 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::WillConnect@6(VAR ConnectionString : Text;VAR UserID : Text;VAR Password : Text;VAR Options : Integer;adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::ConnectComplete@7(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus@1102152001 : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     EVENT SQLConnection::Disconnect@8(adStatus : Integer;pConnection@1102152000 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
     BEGIN
     END;

     BEGIN
     {
       CommaRemoval(FORMAT(ROUND(PurchInvLine."VAT Amount",0.01)))+''','''+//commented for merging purpose
             IF DATE2DMY(WORKDATE,2)>3 THEN
               FIN_YEAR:=DATE2DMY(WORKDATE,3)
             ELSE
               FIN_YEAR:=DATE2DMY(WORKDATE,3)-1
              VendLedgEntry.SETRANGE(VendLedgEntry."Posting Date",DMY2DATE(04,01,FIN_YEAR),DMY2DATE(03,31,FIN_YEAR+1));
       //B2B
       //Deleted Var(SQLConnection, RecordSet Automation Variables, Commented code related to SQLConnection, RecordSet
       //B2B
       UPGREV2.0    Commented code uncommented line number 1172.
     }
     END;
     end;*/
    //<<Codeunit90clos<<




    //<<Codeunit91opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeSelectPostOrderOption', '', false, false)]
    local procedure OnBeforeSelectPostOrderOption(var PurchaseHeader: Record "Purchase Header"; DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        Selection: Integer;
        ArchiveManagement: Codeunit 5063;
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
    begin
        with PurchaseHeader do begin
            Selection := StrMenu(ReceiveInvoiceQst, 3);
            if Selection = 0 then
                Result := false;
            Receive := Selection in [1, 3];
            Invoice := Selection in [2, 3];
        end;

        Result := true;
        IsHandled := true;
    end;


    //<<Codeunit91clos<<

    //<<Codeunit92opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeGetReport', '', false, false)]
    local procedure OnBeforeGetReport(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
        IF PurchaseHeader."Posting No. Series" <> 'JV' THEN
            IsHandled := false;


    end;

    //<<Codeunit92clos<<


    //<<Codeunit93opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order (Yes/No)", 'OnAfterCreatePurchOrder', '', false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        MSPTOrderDetails: Record 60083;
        MSPTOrderDetails1: Record 60083;
        PPSetup: Record 312;
        ArchiveManagement: Codeunit 5063;
    begin
        //B2B-MSPT1.0
        MSPTOrderDetails.SETRANGE(Type, MSPTOrderDetails.Type::Purchase);
        MSPTOrderDetails.SETRANGE("Document Type", MSPTOrderDetails."Document Type"::Quote);
        MSPTOrderDetails.SETRANGE(MSPTOrderDetails."Document No.", PurchaseHeader."No.");
        IF MSPTOrderDetails.FINDSET THEN BEGIN
            REPEAT
                MSPTOrderDetails1.Type := MSPTOrderDetails.Type::Purchase;
                MSPTOrderDetails1."Party Type" := MSPTOrderDetails."Party Type"::Vendor;
                MSPTOrderDetails1."Document Type" := MSPTOrderDetails."Document Type"::Order;
                MSPTOrderDetails1."Party No." := MSPTOrderDetails."Party No.";
                MSPTOrderDetails1."MSPT Header Code" := MSPTOrderDetails."MSPT Header Code";
                MSPTOrderDetails1."MSPT Line No." := MSPTOrderDetails."MSPT Line No.";
                MSPTOrderDetails1."MSPT Code" := MSPTOrderDetails."MSPT Code";
                MSPTOrderDetails1.Percentage := MSPTOrderDetails.Percentage;
                MSPTOrderDetails1.Description := MSPTOrderDetails.Description;
                MSPTOrderDetails1."Calculation Period" := MSPTOrderDetails."Calculation Period";
                MSPTOrderDetails1.Remarks := MSPTOrderDetails.Remarks;
                MSPTOrderDetails1."Due Date" := MSPTOrderDetails."Due Date";
                MSPTOrderDetails1."Document No." := PurchaseHeader."No.";
                MSPTOrderDetails1.INSERT;
            UNTIL MSPTOrderDetails.NEXT = 0;
        END;
        MSPTOrderDetails.SETRANGE(Type, MSPTOrderDetails.Type::Purchase);
        MSPTOrderDetails.SETRANGE("Document Type", MSPTOrderDetails."Document Type"::Quote);
        MSPTOrderDetails.SETRANGE(MSPTOrderDetails."Document No.", PurchaseHeader."No.");
        IF MSPTOrderDetails.FINDFIRST THEN BEGIN
            MSPTOrderDetails.DELETEALL;
        END;
        //B2B-MSPT1.0
    end;
    //<<Codeunit93clos<<


    //<<Codeunit212opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Res. Jnl.-Post Line", 'OnBeforeResLedgEntryInsert', '', false, false)]
    local procedure OnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line")
    begin
        ResLedgerEntry."Planned Hr's" := ResJournalLine."Planned Hr's";
        ResLedgerEntry.Place := ResJournalLine.Place;
        ResLedgerEntry."AMC Order NO" := ResJournalLine."AMC Order NO";
    end;
    //<<Codeunit212clos<<
    //<<Codeunit226opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", 'OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters', '', false, false)]
    local procedure OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplyingCustLedgerEntry: Record "Cust. Ledger Entry" temporary; var IsHandled: Boolean);
    begin
        // Added by Pranavi on 13-Jan-2017 for not allowing to apply to other departments code entries
        IF COPYSTR(ApplyingCustLedgerEntry."Global Dimension 1 Code", 1, 3) = 'CUS' THEN
            CustLedgerEntry.SETFILTER(CustLedgerEntry."Global Dimension 1 Code", '%1', 'CUS*')
        ELSE
            CustLedgerEntry.SETFILTER(CustLedgerEntry."Global Dimension 1 Code", '%1', 'PRD*');
        // end by Pranavi on 13-Jan-2017
    end;

    //<<Codeunit228opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Test Report-Print", 'OnPrintGenJnlLineOnAfterGenJnlLineCopy', '', false, false)]
    local procedure OnPrintGenJnlLineOnAfterGenJnlLineCopy(var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine.SETRANGE("Payment Type", GenJnlLine."Payment Type");
        GenJnlLine.SETRANGE("Document No.", GenJnlLine."Document No."); //Rev01
    end;
    //<<Codeunit228clos<<


    //<<Codeunit241>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post", 'OnCodeOnBeforeItemJnlPostBatchRun', '', false, false)]
    local procedure OnCodeOnBeforeItemJnlPostBatchRunCust(var ItemJournalLine: Record "Item Journal Line")
    var
        Text001: Label 'Do you want to post the journal lines?';
    begin
        IF (((ItemJournalLine."Journal Batch Name" = 'PFOUROJ') OR (ItemJournalLine."Journal Batch Name" = 'PFOUR-OJ') OR
    (ItemJournalLine."Journal Batch Name" = 'PFOUR-RE') OR (ItemJournalLine."Journal Batch Name" = 'PONEOJ') OR
    (ItemJournalLine."Journal Batch Name" = 'PONE-OJ') OR (ItemJournalLine."Journal Batch Name" = 'PONE-RE') OR
    (ItemJournalLine."Journal Batch Name" = 'PTHREEOJ') OR (ItemJournalLine."Journal Batch Name" = 'PTHREE-OJ') OR
    (ItemJournalLine."Journal Batch Name" = 'PTHREE-RE') OR (ItemJournalLine."Journal Batch Name" = 'PTWOJ') OR
    (ItemJournalLine."Journal Batch Name" = 'PTWO-RE') OR (ItemJournalLine."Journal Batch Name" = 'PTW-OJ'))
    AND (ItemJournalLine."Operation No." <> '9999') AND (ItemJournalLine."Operation No." <> '1005')
    ) AND (ItemJournalLine."Reason Code" <> 'OUT SOURCE') THEN BEGIN
            //  IF ItemJournalLine."Reason Code"<>'OUT SOURCE' THEN
            //  BEGIN
            IF ItemJournalLine."Run Time" = 0 THEN
                ERROR('Run Time must not be zero');
            IF NOT CONFIRM(Text001, FALSE) THEN
                EXIT;
            //   END;
        END;
    end;
    //<<codeunitclose>.

    //<<codeunit365opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSetLineNos', '', false, false)]
    local procedure OnBeforeSetLineNoscust(Country: Record "Country/Region"; var NameLineNo: Integer; var Name2LineNo: Integer; var AddrLineNo: Integer; var Addr2LineNo: Integer; var ContLineNo: Integer; var PostCodeCityLineNo: Integer; var CountyLineNo: Integer; var CountryLineNo: Integer; var IsHandled: Boolean)
    begin
        if Country."Contact Address Format" = Country."Contact Address Format"::"After Company Name" then begin

            NameLineNo := 2;
            Name2LineNo := 3;
            ContLineNo := 1;
            AddrLineNo := 4;
            Addr2LineNo := 5;
            PostCodeCityLineNo := 6;
            CountyLineNo := 7;
            CountryLineNo := 8;

            IsHandled := true;

            /*{     NameLineNo := 1;
                 Name2LineNo := 2;
                 ContLineNo := 3;
                 AddrLineNo := 4;
                 Addr2LineNo := 5;
                 PostCodeCityLineNo := 6;
                 CountyLineNo := 7;
                 CountryLineNo := 8;  }*/
        END;

    end;
    //<<codeunit clos>>



    //<<Codeunit414opn<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReopenSalesDoc', '', false, false)]
    local procedure OnBeforeReopenSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        WITH SalesHeader DO BEGIN
            IF Status = Status::Open THEN
                EXIT;
            //IF SalesHeader."Document Type" <>4 THEN
            ArchiveManagement.ArchiveSalesDocument(SalesHeader);
            Status := Status::Open;
            SalesLine.SetSalesHeader(SalesHeader);
            SalesLine.SETRANGE("Document Type", "Document Type");
            SalesLine.SETRANGE("Document No.", "No.");
            SalesLine.SETFILTER(Type, '>0');
            SalesLine.SETFILTER(Quantity, '<>0');
            IF RECORDLEVELLOCKING THEN
                SalesLine.LOCKTABLE;
            IF SalesLine.FINDSET THEN
                REPEAT
                    SalesLine.Amount := 0;
                    SalesLine."Amount Including VAT" := 0;
                    SalesLine."VAT Base Amount" := 0;
                    SalesLine.InitOutstandingAmount;
                    SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
            SalesLine.RESET;

            /* IF "Document Type" <> "Document Type"::Order THEN
                 ReopenATOs(SalesHeader);*/

            MODIFY(TRUE);
            /* IF "Document Type" IN ["Document Type"::Order, "Document Type"::"Return Order"] THEN
                 WhseSalesRelease.Reopen(SalesHeader);*/
        END;
        IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnAfterReleaseATOscust(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        ErrorMess: text[1000];
        SHA: Record 5107;
        CLE1: Record "Change Log Entry";
        CLE2: Record "Change Log Entry";
        nextline: char;
        Verticals: Record "Verticals Info";
        customer: Record Customer;
        Divi: Record 5212;
        User: Record "user setup";
        Body: Text;
        Sale_Orader_Total_amt: Decimal;
        formataddress: Codeunit 50000;
        Tot_amt: text[30];

        BG_value: Text[30];
        SPP: Record "Salesperson/Purchaser";
        BI_Status: boolean;
        SL: Record "Sales Line";
        Shedul2_Count: Record Schedule2;
        SO: Record "Sales Invoice-Dummy";
        //Mail_To: list of [Text];
        Shedul2: Record Schedule2;
        Shedul2_UOM: Text[20];
        Shedul2_Count2: integer;
        Shedul2_Amt: Text[30];
        cus: Record Customer;
        Email: Codeunit Email;
        SalesLine: Record "Sales Line";//EFFUPG1.4


    begin

        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader.SaleDocType = SalesHeader.SaleDocType::Order) THEN BEGIN //EFFUPG1.5                                                     //Mail Code for Release Condition
            SalesHeader."Order Assurance" := TRUE;
            //anil 10/10/09;
            IF (SalesHeader."Sell-to Customer No." <> 'CUST00822') AND (SalesHeader."Sell-to Customer No." <> 'CUST00536') AND (COPYSTR(SalesHeader."No.", 15, 1) <> 'L') AND (COPYSTR(SalesHeader."No.", 15, 1) <> 'T') THEN BEGIN
                SalesLine.Reset;
                SalesLine.Setrange("Document Type", SalesHeader."Document Type");
                SalesLine.setrange("Document No.", Salesheader."No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        IF SalesLine."No." <> '' THEN
                            IF SalesLine."Unitcost(LOA)" <= 0 THEN
                                ERROR('Sales Item No.   ' + SalesLine."No." + '   Unit cost with tax value lessthen 0, Please fill the value');
                    UNTIL SalesLine.NEXT = 0;
                //anil 10/10/09;

                // Nagaraju
                IF COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS' THEN BEGIN
                    ErrorMess := 'Please Specify the fileds data : ';
                    IF SalesHeader."Shortcut Dimension 1 Code" = '' THEN
                        ErrorMess := ErrorMess + ' Department Code,';
                    IF SalesHeader.Product = '' THEN
                        ErrorMess := ErrorMess + ' Product Code,';
                    IF (SalesHeader."Payment Terms Code" = '') THEN
                        ErrorMess := ErrorMess + ' Payments Term Code,';
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') THEN BEGIN
                        // IF "Payment Discount %"=0 THEN
                        //        ErrorMess:=ErrorMess+'  Supply Portion,';
                        IF SalesHeader.Territory = '' THEN
                            ErrorMess := ErrorMess + '  Territory,';
                    END;
                    IF SalesHeader."Order Completion Period" = 0 THEN
                        ErrorMess := ErrorMess + '  Order Completion Period,';
                    IF SalesHeader."Sell-to City" = '' THEN
                        ErrorMess := ErrorMess + '  Sell-to City,';
                    IF SalesHeader."Customer OrderNo." = '' THEN
                        ErrorMess := ErrorMess + '  CUSTOMER ORDER NO.,';
                    IF SalesHeader."Requested Delivery Date" = 0D THEN
                        ErrorMess := ErrorMess + '  Requested Delivery Date,';
                    IF SalesHeader."Customer Order Date" = 0D THEN
                        ErrorMess := ErrorMess + '  Customer Order Date,';
                    IF SalesHeader."Order Date" = 0D THEN
                        ErrorMess := ErrorMess + ' ORDER DATE,';
                    IF SalesHeader."Sale Order Total Amount" = 0 THEN
                        ErrorMess := ErrorMess + ' Sale Order Total Amount,';
                    IF (SalesHeader."RDSO Inspection Req" = SalesHeader."RDSO Inspection Req"::" ") THEN
                        ErrorMess := ErrorMess + ' RDSO Inspection Req,';
                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::" ") THEN
                        ErrorMess := ErrorMess + ' Call letters Status,';

                    IF (SalesHeader."RDSO Inspection Req" = SalesHeader."RDSO Inspection Req"::YES) AND (SalesHeader."RDSO Inspection By" = SalesHeader."RDSO Inspection By"::" ") THEN   //
                        ErrorMess := ErrorMess + ' RDSO Inspection By,';                                                                     //

                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::Pending) THEN BEGIN
                        IF SalesHeader."Call Letter Exp.Date" = 0D THEN
                            ErrorMess := ErrorMess + ' Call Letter Exp.Date,';
                    END;
                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::Received) THEN BEGIN
                        IF SalesHeader.CallLetterExpireDate = 0D THEN
                            ErrorMess := ErrorMess + ' CallLetterExpireDate,';
                    END;
                    IF (SalesHeader."BG Status" = SalesHeader."BG Status"::" ") THEN
                        ErrorMess := ErrorMess + 'BG Status,';
                    IF (SalesHeader."Project Completion Date" = 0D) OR (FORMAT(SalesHeader."Project Completion Date") = ' ') THEN
                        ErrorMess := ErrorMess + ' Project Completion Date,';
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') AND (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) THEN BEGIN
                        IF (SalesHeader."CA Date" = 0D) THEN
                            ErrorMess := ErrorMess + ' B.G Required Date,';
                    END;
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') THEN BEGIN
                        IF (SalesHeader.Installation = SalesHeader.Installation::" ") THEN
                            ErrorMess := ErrorMess + ' Installation Type,';
                    END;
                    IF (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) OR (SalesHeader."BG Status" = SalesHeader."BG Status"::Submitted) THEN BEGIN
                        IF (SalesHeader."Exp.Payment" = 0) THEN ErrorMess := ErrorMess + ' BG Amount,';
                    END;
                    IF (SalesHeader."Security Deposit Amount" = 0) AND (SalesHeader."SD Status" <> SalesHeader."SD Status"::NA) THEN
                        ErrorMess := ErrorMess + ' Security Deposit Amount,';
                    // Added by Pranavi on 11-jun-2016 for emd,sd integration
                    IF (SalesHeader."Security Deposit" = SalesHeader."Security Deposit"::" ") AND (SalesHeader."SD Status" <> SalesHeader."SD Status"::NA) THEN
                        ErrorMess := ErrorMess + ' SD Mode,';
                    IF (SalesHeader."Tender No." <> '') AND (SalesHeader."EMD Amount" = 0) THEN
                        ErrorMess := ErrorMess + ' EMD Amount,';
                    IF SalesHeader."No." <> 'EFF/SAL/16-17/0329' THEN
                        IF (SalesHeader."Tender No." = '') AND (SalesHeader."EMD Amount" > 0) THEN
                            ErrorMess := ErrorMess + ' Tender No,';

                    // end by pranavi
                    IF SalesHeader."Sale Order Total Amount" = 0 THEN
                        ErrorMess := ErrorMess + ' Sale Order Total Amount,';
                    IF (SalesHeader."Salesperson Code" = '') AND (COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS') THEN
                        ErrorMess := ErrorMess + ' Salesperson Code,';
                    ErrorMess := COPYSTR(ErrorMess, 1, STRLEN(ErrorMess) - 1);
                    IF ErrorMess <> 'Please Specify the fileds data :' THEN
                        ERROR(ErrorMess);
                END;

                IF (SalesHeader."RDSO Inspection Req" <> SalesHeader."RDSO Inspection Req"::NA) OR (SalesHeader."Call letters Status" <> SalesHeader."Call letters Status"::NA) THEN BEGIN
                    ErrorMess := ' RDSO Detials are not mentioned in Order item Details';
                    SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
                    SalesLine.SETRANGE("Document No.", SalesHeader."No.");
                    SalesLine.SETRANGE(SalesLine."RDSO Inspection Required", true);
                    IF SalesLine.FINDFIRST THEN BEGIN
                        ErrorMess := '';
                    END;
                    IF ErrorMess <> '' THEN
                        ERROR(ErrorMess);
                END;


                //Nagaraju


                SHA.SETRANGE(SHA."No.", SalesHeader."No.");
                IF SHA.FINDFIRST THEN BEGIN
                    //SalesHeader.MODIFY(TRUE);//EFFUPG1.4
                    //Added by sundar for sending changes in Sale order as Mail to production Manager---12-12-13
                    CLE1.RESET;
                    CLE1.SETRANGE(CLE1."Primary Key Field 2 Value", SalesHeader."No.");
                    CLE1.SETFILTER(CLE1."Table No.", '37|60025');
                    CLE1.SETFILTER(CLE1."Primary Key Field 1 Value", '1|4');
                    CLE1.SETFILTER(CLE1."Field No.", '5|6|7|11|15|18|153');
                    CLE1.SETFILTER(CLE1."Type of Change", '<>%1', 0);
                    IF CLE1.FINDFIRST THEN BEGIN
                        CLE2.RESET;
                        CLE2.SETRANGE(CLE2."Primary Key Field 2 Value", SalesHeader."No.");
                        //REPORT.SAVEASPDF(50026, '\\erpserver\ErpAttachments\Changelog.PDF', CLE2); 8-10-22
                        //Attachment := '\\erpserver\ErpAttachments\Changelog.PDF'; 8-10-22
                        // Mail_From := 'ERP@efftronics.com';
                        //  Mail_To:='padmaja@efftronics.com,erp@efftronics.com,rakesht@efftronics.com,anilkumar@efftronics.com,spurthi@efftronics.com';
                        //Mail_To.add('erp@efftronics.com');
                        "to mail".Add('erp@efftronics.com');
                        Subject := 'Changes in Sale Order ' + SalesHeader."No.";
                        Body += '<HTML><BODY>Dear Sir,<BR>';
                        Body += '<BR>        The Sale Order ' + SalesHeader."No." + ' has been modified. Verify Attachment for list of changes in sale order<BR><BR>';
                        Body += '<b>Note:  Automatic Mail Generated From ERP</b> </BODY></HTML>';

                        //SMTP_MAIL.CreateMessage('ERP', Mail_From, "to mail", Subject, Body, TRUE);

                        EmailMessage.Create("to mail", 'ERP - ' + Subject, Body, TRUE);

                        //EmailMessage.AddAttachment(Attachment, '', ''); //EFFUPG 8-10-22
                        //  SMTP_MAIL.Send;
                    END; //Added by sundar for sending changes in Sale order as Mail to production Manager---12-12-13
                END
                ELSE BEGIN
                    //"Expiration Date":=TODAY;
                    SalesHeader."Order Released Date" := TODAY;// sujani on 01Apr2019 for before release
                    SalesHeader.MODIFY;
                    nextline := 10;
                    Mail_Body := '';
                    //  MESSAGE('anil2');
                    "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERSECURITYID);//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        // "from Mail":="Mail-Id".MailID;
                        "from Mail" := 'erp@efftronics.com';
                    // "to mail":='anilkumar@efftronics.com';
                    /*
                     "to mail".Add('mk@effe.in');
                     "to mail".Add('erp@efftronics.com');
                     "to mail".Add('padmaja@efftronics.com');
                     "to mail".Add('rajani@efftronics.com');
                     "to mail".Add('purchase@efftronics.com');
                     "to mail".Add('controlroom@efftronics.com');
                     "to mail".Add('prasanthi@efftronics.com'); //,rajani@efftronics.com
                                                                //,pmurali@efftronics.com
                                                                //"to mail"+='ganuradha@efftronics.com,';
                                                                //"to mail"+='vanidevi@efftronics.com,';
                     "to mail".Add('sales@efftronics.com');
                     "to mail".Add('marketing@efftronics.com');
                     "to mail".Add('anvesh@efftronics.com');
                     "to mail".Add('cuspm@efftronics.com'); //qms@efftronics.com,*/
                    "to mail".Add('erp@efftronics.com');
                    IF SalesHeader."Sale Order Total Amount" >= 500000 THEN BEGIN   //added anil on 13/01/15 more then 5 lakhs value then data sent to ceo.
                        //"to mail".Add('ceo@efftronics.com');
                        "to mail".Add('erp@efftronics.com');
                    END;
                    /* {
                     IF Product = 'BI' THEN
                           "to mail" += ',blockinstrument@efftronics.com';
                     }*/
                    Verticals.RESET;
                    Verticals.SETFILTER(Verticals.Product, SalesHeader.Product);
                    IF Verticals.FINDFIRST THEN BEGIN
                        IF Verticals."Vertical Head E_mail" <> '' THEN
                            // "to mail".Add(Verticals."Vertical Head E_mail");
                            "to mail".Add('erp@efftronics.com');
                        IF Verticals."PM E_mail" <> '' THEN
                            //"to mail".add(Verticals."PM E_mail");
                             "to mail".Add('erp@efftronics.com');
                        IF Verticals."APM E_mail" <> '' THEN
                            //"to mail".add(Verticals."APM E_mail");
                             "to mail".Add('erp@efftronics.com');
                    END;


                    customer.RESET;
                    customer.SETFILTER(customer."No.", SalesHeader."Sell-to Customer No.");
                    IF customer.FINDFIRST THEN BEGIN
                        IF customer."Service Zone Code" <> '' THEN BEGIN
                            Divi.RESET;
                            Divi.SETFILTER(Divi."Code", customer."Service Zone Code");
                            IF Divi.FINDFIRST THEN BEGIN
                                User.SETFILTER(User.EmployeeID, Divi."Project Manager");
                                IF User.FINDFIRST THEN BEGIN
                                    IF User.MailID <> '' THEN
                                        //"to mail".add(User.MailID);
                                         "to mail".Add('erp@efftronics.com');
                                END;
                            END;
                        END
                        ELSE BEGIN
                            ERROR('Enter Service Zone Code in customer card');
                        END;
                    END;
                    Mail_Subject := 'ERP - ' + 'Sale Order ' + SalesHeader."No." + ' Released on for the customer ' + SalesHeader."Sell-to Customer Name";
                    /* Mail_Body + = 'SALE ORDER RELEASE :';
                     Mail_Body + = FORMAT(nextline);
                     Mail_Body + = FORMAT(nextline);*/

                    /*{attach.SETRANGE(attach."Document No.","No.");
                     attach.SETFILTER(attach."Attachment Status",'1');
                     attach.SETRANGE(attach.Description,'LOA');
                     IF NOT attach.FINDFIRST THEN
                     ERROR('Please Attach LOA for Sale Order');}*/

                    IF SalesHeader."Shortcut Dimension 1 Code" = '' THEN
                        ERROR('Please Specify Department Code');
                    IF SalesHeader.Product = '' THEN
                        ERROR('Please specify the Product');
                    IF (SalesHeader."Payment Terms Code" = '') THEN
                        ERROR('Please Specify Payments Term Code for Order');
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') THEN BEGIN
                        IF SalesHeader.Territory = '' THEN
                            ERROR('Please Pick the Territory in Sales Header');
                    END;
                    /* {  Mail_Body+= 'Sale Order No          : '+"No.";
                       Mail_Body+= FORMAT(nextline);
                       Mail_Body+= 'Customer Name          : '+"Sell-to Customer Name";
                       Mail_Body+= FORMAT(nextline);
                       IF "Sell-to City"='' THEN
                         ERROR('Sell to City must not be Null');
                       Mail_Body+= 'Customer Place         : '+"Sell-to City";
                       Mail_Body+= FORMAT(nextline);
                       Mail_Body+= 'Customer Type          : '+"Customer Posting Group";
                       Mail_Body+= FORMAT(nextline);
                       Mail_Body+= 'Product                : '+Product;
                       Mail_Body+= FORMAT(nextline);

                       IF "Customer OrderNo."='' THEN
                         ERROR('ENTER CUSTOMER ORDER NO.');
                       Mail_Body+= 'Customer LOA No.       : '+"Customer OrderNo.";
                       Mail_Body+= FORMAT(nextline);
                       IF "Requested Delivery Date"=0D THEN
                         ERROR('SPECIFY REQUESTED DELIVERY DATE');
                       Mail_Body+= 'Customer Expected Date : '+FORMAT(("Requested Delivery Date"),0,4);
                       Mail_Body+= FORMAT(nextline);
                       IF "Customer Order Date"=0D THEN
                         ERROR('SPECIFY CUSTOMER ORDER DATE');
                       Mail_Body+= 'Customer Order Date    : '+FORMAT(("Customer Order Date"),0,4);
                       Mail_Body+= FORMAT(nextline);
                       IF "Order Date"=0D THEN
                         ERROR('SPECIFY ORDER DATE');
                       Mail_Body+= 'Order Date    : '+FORMAT(("Order Date"),0,4);
                       Mail_Body+= FORMAT(nextline);
                       IF "Sale Order Total Amount"=0 THEN
                         ERROR('ENTER SALE ORDER AMOUNT');
                       Tot_amt:=formataddress.ChangeCurrency(ROUND("Sale Order Total Amount",1)); // Added by Rakesh to insert indian format currency on 22-Aug-14
                       if "Sale Order Total Amount">=500000 then
                        Mail_To+=',ceo@efftronics.com';
                      // Mail_Body+= 'Sale Order Value(RS)   : '+FORMAT(ROUND("Sale Order Total Amount",1)); // Commented by rakesh
                       Mail_Body+= 'Sale Order Value(RS)   : '+Tot_amt;
                       IF Tot_amt>=FORMAT(500000) THEN     //added anil on 13/01/15 more then 5 lakhs value then data sent to ceo.
                        "to mail"+=',ceo@efftronics.com';
                       Mail_Body+= FORMAT(nextline);
                       IF ("RDSO Inspection Req"="RDSO Inspection Req"::" ") THEN
                         ERROR('SPECIFY RDSO STATUS IN HEADER');
                       Mail_Body+= 'RDSO Inspection        : '+FORMAT("RDSO Inspection Req");
                       Mail_Body+= FORMAT(nextline);
                       IF ( "Call letters Status"="Call letters Status"::" ")THEN
                         ERROR('ENTER THE CALL LETTER STATUS');
                       IF ("Call letters Status"="Call letters Status"::Pending) THEN
                       BEGIN
                         IF "Call Letter Exp.Date"=0D THEN
                           ERROR('Please enter call letter expected date');
                       END;
                       IF ("Call letters Status"="Call letters Status"::Received)THEN
                       BEGIN
                         IF CallLetterExpireDate=0D THEN
                           ERROR('Please enter call letter expired date');
                       END;
                       Mail_Body+= 'Call Letter Status     : '+FORMAT("Call letters Status");
                       Mail_Body+= FORMAT(nextline);
                       IF ("BG Status"="BG Status"::" ")THEN
                         ERROR('ENTER THE BG STATUS');
                       Mail_Body+= 'BG Status              : '+FORMAT("BG Status");
                       Mail_Body+= FORMAT(nextline);
                       IF ("Customer Posting Group"='RAILWAYS')AND("BG Status"="BG Status"::Pending)THEN
                       BEGIN
                         IF ("Project Completion Date"=0D) THEN
                           ERROR('Please Enter Project Completiton Date');
                         IF ("CA Date"=0D)THEN
                           ERROR('Enter the BG required Date')
                         ELSE
                           Mail_Body+= 'BG Required Date       : '+FORMAT(("CA Date"),0,4);
                           Mail_Body+= FORMAT(nextline);
                       END;
                       IF ("Customer Posting Group"='RAILWAYS')THEN
                       BEGIN
                         IF (Installation=Installation::" ") THEN
                           ERROR('Please enter installation type');
                       END;
                       IF ("BG Status"="BG Status"::Pending)OR("BG Status"="BG Status"::Submitted)THEN
                       BEGIN
                         IF ("Exp.Payment"=0) THEN
                           ERROR('Please Enter BG Value')
                         ELSE
                           BG_value:=formataddress.ChangeCurrency(ROUND("Exp.Payment",1));
                           //Mail_Body+= 'BG Value               : '+FORMAT(ROUND("Exp.Payment",1));
                           Mail_Body+= 'BG Value               : '+BG_value;
                           Mail_Body+= FORMAT(nextline);
                       END;
                       IF ("Customer Posting Group"='RAILWAYS') AND ("Security Deposit Amount"=0) ("SD Status" <> "SD Status"::NA) THEN
                         ERROR('Please enter the Security Deposit Amount');
                       IF ("Customer Posting Group"='RAILWAYS')AND("Security Deposit Amount">0)AND("Security Deposit"=0)THEN
                         ERROR('Please enter the Security Deposit Mode!');

                       IF ("Order Assurance"<>FALSE)THEN
                         Mail_Body+= 'Order Assured Status   : '+FORMAT("Order Assurance");
                       Mail_Body+= FORMAT(nextline);
                       IF ("Salesperson Code"='') AND ((COPYSTR("No.",1,13)<>'EFF/11-12/CUS')) THEN
                         ERROR('PICK THE SALES PERSON CODE');
                       // IF( "Customer Posting Group"='RAILWAYS') THEN
                       // BEGIN
                       SL.SETRANGE(SL."Document No.","No.");
                       IF SL.FINDSET THEN
                       REPEAT
                         IF rel(SL."Schedule Type"=0) OR (SL."Schedule No"=0) THEN
                         BEGIN
                           IF NOT ((Product = 'SPARES') AND ("Sell-to Customer No." = 'CUST00536')) THEN   //Added by Pranavi on 01-1-2016
                             ERROR('Select the Schedule Type and Enter the Schedule No for '+FORMAT(SL."Line No."));
                         END;
                       UNTIL SL.NEXT=0;
                       IF "Customer Posting Group"='RAILWAYS' THEN
                       BEGIN
                         SL.SETRANGE(SL."Document No.","No.");
                         SL.SETFILTER(SL."No.",'<>%1','47300');
                         IF SL.FINDSET THEN
                         REPEAT
                           IF (SL."Supply Portion"=0) THEN
                           BEGIN
                             IF (SL."Retention Portion"=0)  THEN
                                ERROR('PLEASE ENTER SUPPLY & RETENTION VALUE FOR LINE NO '+FORMAT(SL."Line No."))
                           END ELSE IF(SL."Retention Portion"=0) THEN
                           BEGIN
                             IF (SL."Supply Portion"=0) THEN
                                ERROR('PLEASE ENTER SUPPLY & RETENTION VALUE FOR LINE NO '+FORMAT(SL."Line No."));
                           END;
                         UNTIL SL.NEXT=0;
                       END;

                      { "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Salesperson Code");//B2B
                       IF "Mail-Id".FINDFIRST THEN
                       Mail_Body+= 'Sales Executive        : '+"Mail-Id"."User Name";//B2B
                       }Mail_Body+= FORMAT(nextline);
                       Mail_Body+= FORMAT(nextline);
                       Mail_Body+= '***** Auto Mail Generated From ERP *****';}*/

                    BI_Status := FALSE;
                    // *******************************new Mail code RAILWAY************************************
                    Mail_Subject := 'ERP- ' + 'Sale Order ' + SalesHeader."No." + ' Released on for the customer ' + SalesHeader."Sell-to Customer Name";
                    /*if ("to mail" <> '') then
                        Mail_To.Add("to mail");*/
                    //EmailMessage.Create("to mail", 'ERP - ' + Mail_Subject, Body, TRUE);//EFFUPG1.4
                    Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                    Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                    Body += ('<label><font size="6"> Sale Order Information</font></label>');
                    Body += ('<hr style=solid; color= #3333CC>');
                    Body += ('<h>Dear Sir/Madam,</h><br>');
                    Body += ('<P>SALE ORDER  DETAILS</P>');
                    IF SalesHeader."Shortcut Dimension 1 Code" = '' THEN
                        ERROR('Please Specify Department Code');
                    IF SalesHeader.Product = '' THEN
                        ERROR('Please specify the Product');
                    IF (SalesHeader."Payment Terms Code" = '') THEN
                        ERROR('Please Specify Payments Term Code for Order');
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') THEN BEGIN
                        IF SalesHeader.Territory = '' THEN
                            ERROR('Please Pick the Territory in Sales Header');
                    END;
                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>Sale Order No  </b> </td><td>' + SalesHeader."No." + '</td></tr>');
                    IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Allowed" THEN
                        Body += ('<tr><td><b>Shipment Type  </b> </td><td>Allowed</td></tr>')
                    ELSE
                        IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Not Allowed" THEN
                            Body += ('<tr><td><b>Shipment Type  </b> </td><td>Not Allowed</td></tr>')
                        ELSE
                            IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"No issue in Shipment" THEN
                                Body += ('<tr><td><b>Shipment Type  </b> </td><td>No issue in shipment</td></tr>')
                            ELSE
                                Body += ('<tr><td><b>Shipment Type  </b> </td><td>' + FORMAT(SalesHeader."Shipment Type") + '</td></tr>');  // added by sujani

                    Body += ('<tr><td><b>Customer Name   </b> </td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                    IF SalesHeader."Sell-to City" = '' THEN
                        ERROR('Sell to City must not be Null');
                    Body += ('<tr><td><b>Customer Place  </b></td><td>' + SalesHeader."Sell-to City" + '</td></tr>');
                    Body += ('<tr><td><b>Customer Type  </b></td><td>' + SalesHeader."Customer Posting Group" + '</td></tr>');
                    Body += ('<tr><td><b>Product  </b></td><td>' + SalesHeader.Product + '</td></tr>');
                    IF SalesHeader."Customer OrderNo." = '' THEN
                        ERROR('ENTER CUSTOMER ORDER NO.');
                    Body += ('<tr><td><b>Customer LOA No. </b></td><td>' + SalesHeader."Customer OrderNo." + '</td></tr>');
                    IF SalesHeader."Customer Order Date" = 0D THEN
                        ERROR('SPECIFY CUSTOMER ORDER DATE');
                    Body += ('<tr><td><b>Customer Order Date </b></td><td> ' + FORMAT((SalesHeader."Customer Order Date"), 0, 4) + '</td></tr>');
                    IF SalesHeader."Requested Delivery Date" = 0D THEN
                        ERROR('SPECIFY REQUESTED DELIVERY DATE');
                    Body += ('<tr><td><b>Customer Expected Date  </b></td><td>' + FORMAT((SalesHeader."Requested Delivery Date"), 0, 4) + '</td></tr>');
                    IF SalesHeader."Order Date" = 0D THEN
                        ERROR('SPECIFY ORDER DATE');
                    Body += ('<tr><td><b>Order Date   </b></td><td>' + FORMAT((SalesHeader."Order Date"), 0, 4) + '</td></tr>');
                    Body += ('<tr><td><b>Promised Delivery Date  </b></td><td>' + FORMAT((SalesHeader."Promised Delivery Date"), 0, 4) + '</td></tr>');
                    IF SalesHeader."Sale Order Total Amount" = 0 THEN
                        ERROR('ENTER SALE ORDER AMOUNT');
                    Tot_amt := formataddress.ChangeCurrency((ROUND(SalesHeader."Sale Order Total Amount", 1)));
                    IF SalesHeader."Currency Factor" > 0 THEN // Added by sujani for dollar amount in foreign orders
                      BEGIN
                        Sale_Orader_Total_amt := ROUND(SalesHeader."Sale Order Total Amount", 1) / SalesHeader."Currency Factor";
                        Sale_Orader_Total_amt := ROUND(Sale_Orader_Total_amt, 1);
                    END
                    ELSE
                        Sale_Orader_Total_amt := ROUND(SalesHeader."Sale Order Total Amount", 1);

                    //ROMail.AppendBody(' <tr><td><b> Sale Order Value(RS)   </b></td><td>'+Tot_amt+'</td></tr>');
                    Body += ('<tr><td><b> Sale Order Value(RS)   </b></td><td>' + FORMAT(Sale_Orader_Total_amt) + '</td></tr>');

                    IF (SalesHeader."RDSO Inspection Req" = SalesHeader."RDSO Inspection Req"::" ") THEN
                        ERROR('SPECIFY RDSO STATUS IN HEADER');
                    Body += ('<tr><td><b>RDSO Inspection  </b></td><td>' + FORMAT(SalesHeader."RDSO Inspection Req") + '</td></tr>');
                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::" ") THEN
                        ERROR('ENTER THE CALL LETTER STATUS');
                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::Pending) THEN BEGIN
                        IF SalesHeader."Call Letter Exp.Date" = 0D THEN
                            ERROR('Please enter call letter expected date');
                    END;
                    IF (SalesHeader."Call letters Status" = SalesHeader."Call letters Status"::Received) THEN BEGIN
                        IF SalesHeader.CallLetterExpireDate = 0D THEN
                            ERROR('Please enter call letter expired date');
                    END;
                    Body += ('<tr><td><b>Call Letter Status     </b></td><td>' + FORMAT(SalesHeader."Call letters Status") + '</td></tr>');
                    IF (SalesHeader."BG Status" = SalesHeader."BG Status"::" ") THEN
                        ERROR('ENTER THE BG STATUS');
                    Body += ('<tr><td><b> BG Status </b></td><td>' + FORMAT(SalesHeader."BG Status") + '</td></tr>');
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') AND (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) THEN BEGIN
                        IF (SalesHeader."Project Completion Date" = 0D) THEN
                            ERROR('Please Enter Project Completiton Date');
                        IF (SalesHeader."CA Date" = 0D) THEN
                            ERROR('Enter the BG required Date')
                        ELSE
                            Body += ('<tr><td><b>BG Required Date</b></td><td>' + FORMAT((SalesHeader."CA Date"), 0, 4) + '</td></tr>');
                    END;
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') THEN BEGIN
                        IF (SalesHeader.Installation = SalesHeader.Installation::" ") THEN
                            ERROR('Please enter installation type');
                    END;
                    IF (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) OR (SalesHeader."BG Status" = SalesHeader."BG Status"::Submitted) THEN BEGIN
                        IF (SalesHeader."Exp.Payment" = 0) THEN
                            ERROR('Please Enter BG Value')
                        ELSE
                            BG_value := formataddress.ChangeCurrency(ROUND(SalesHeader."Exp.Payment", 1));
                        //Mail_Body+= 'BG Value               : '+FORMAT(ROUND("Exp.Payment",1));
                        Body += ('<tr><td><b>BG Value</b></td><td>' + BG_value + '</td><tr>');

                    END;
                    IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') AND (SalesHeader."Security Deposit Amount" = 0) AND (SalesHeader."SD Status" <> SalesHeader."SD Status"::NA) THEN
                        ERROR('Please enter the Security Deposit Amount');
                    IF (SalesHeader."Order Assurance" <> FALSE) THEN
                        Body += ('<tr><td><b> Order Assured Status </td><td> ' + FORMAT(SalesHeader."Order Assurance") + '</td></tr>');
                    IF (SalesHeader."Salesperson Code" = '') AND ((COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS')) THEN
                        ERROR('PICK THE SALES PERSON CODE');
                    IF SalesHeader."Sell-to Customer No." = 'CUST00536' THEN
                        Body += ('<tr><td><b>Remarks</b></td><td>' + SalesHeader.Remarks + '</td></tr>');

                    Body += ('<tr><td><b>Consignee</b></td><td>' + SalesHeader."Ship-to Name" + '</td></tr>'); // Added by Pranavi on 22-05-2017

                    SPP.RESET;
                    SPP.SETFILTER(SPP.Code, SalesHeader."Salesperson Code");
                    IF SPP.FINDFIRST THEN
                        Body += ('<tr><td><b>Sales Person</b></td><td>' + SPP.Name + '</td></tr></table><br><br>');

                    SL.SETRANGE(SL."Document No.", SalesHeader."No.");
                    IF SL.FINDSET THEN
                        REPEAT
                            IF (SL."Schedule Type" = 0) OR (SL."Schedule No" = 0) THEN BEGIN
                                IF NOT ((SalesHeader.Product = 'SPARES') AND (SalesHeader."Sell-to Customer No." = 'CUST02293')) THEN   //Added by Pranavi on 01-1-2016
                                    ERROR('Select the Schedule Type and Enter the Schedule No for ' + FORMAT(SL."Line No."));
                            END;
                        UNTIL SL.NEXT = 0;
                    IF SalesHeader."Customer Posting Group" = 'RAILWAYS' THEN BEGIN
                        SL.SETRANGE(SL."Document No.", SalesHeader."No.");
                        SL.SETFILTER(SL."No.", '<>%1', '47300');
                        IF SL.FINDSET THEN
                            REPEAT
                                IF (SL."Supply Portion" = 0) THEN BEGIN
                                    IF (SL."Retention Portion" = 0) THEN
                                        ERROR('PLEASE ENTER SUPPLY & RETENTION VALUE FOR LINE NO ' + FORMAT(SL."Line No."))
                                END ELSE
                                    IF (SL."Retention Portion" = 0) THEN BEGIN
                                        IF (SL."Supply Portion" = 0) THEN
                                            ERROR('PLEASE ENTER SUPPLY & RETENTION VALUE FOR LINE NO ' + FORMAT(SL."Line No."));
                                    END;
                            UNTIL SL.NEXT = 0;
                    END;
                    Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b> </th><th>Item Description </th> <th>QTY</th><th>UOM</th><th>AMOUNT</th></tr>');
                    BI_Status := FALSE;
                    Shedul2_Count2 := 0;
                    SalesLine.RESET;
                    SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Tot_amt := formataddress.ChangeCurrency(ROUND(SalesLine."Amount To Customer", 1));
                            IF SalesHeader."Currency Factor" > 0 THEN // Added by sujani for dollar amount in foreign orders
                          BEGIN
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1) / salesHeader."Currency Factor";
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1);
                            END
                            ELSE
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1);
                            // Body+= ('<tr><td>'+SalesLine."No."+'</td><td>'+SalesLine.Description+'</td><TD>'+FORMAT(SalesLine.Quantity)+'</TD><td>'+SalesLine."Unit of Measure"+'</td><td align=right>'+Tot_amt+'</td></tr>');
                            Body += ('<tr><td>' + SalesLine."No." + '</td><td>' + SalesLine.Description + '</td><TD>' + FORMAT(SalesLine.Quantity) + '</TD><td>' + SalesLine."Unit of Measure" + '</td><td align=right>' + FORMAT(Sale_Orader_Total_amt) + '</td></tr>');

                            //Added by Pranavi on 28-09-2015 for including Schedule items also in Mail
                            Itm.RESET;
                            Itm.SETCURRENTKEY("No.");
                            Itm.SETFILTER(Itm."No.", SalesLine."No.");
                            IF Itm.FINDFIRST THEN BEGIN
                                IF Itm."Item Sub Group Code" = 'BI' THEN
                                    BI_Status := TRUE;
                            END;

                            Shedul2.RESET;
                            Shedul2.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.", "Line No.");
                            Shedul2.SETFILTER(Shedul2."Document No.", SalesLine."Document No.");
                            Shedul2.SETFILTER(Shedul2."Document Line No.", '%1', SalesLine."Line No.");
                            Shedul2.SETFILTER(Shedul2."Line No.", '<>%1', 10000);
                            IF Shedul2.FINDSET THEN
                                REPEAT
                                    IF Shedul2."Document Line No." <> Shedul2."Line No." THEN BEGIN
                                        Shedul2_UOM := '';
                                        Itm.RESET;
                                        Itm.SETCURRENTKEY("No.");
                                        Itm.SETFILTER(Itm."No.", Shedul2."No.");
                                        IF Itm.FINDFIRST THEN BEGIN
                                            Shedul2_UOM := Itm."Base Unit of Measure";
                                            IF Itm."Item Sub Group Code" = 'BI' THEN
                                                BI_Status := TRUE;
                                        END;


                                        //Shedul2_Amt := formataddress.ChangeCurrency(ROUND(Shedul2."Unit Cost" * Shedul2.Quantity,1));
                                        Body += ('<tr><td style="color:#FF0000">' + '  ' + Shedul2."No." + '</td><td style="color:#FF0000">' + '  ' + Shedul2.Description + '</td>');
                                        Body += ('<TD style="color:#FF0000">' + FORMAT(Shedul2.Quantity) + '</TD><td style="color:#FF0000">' + Shedul2_UOM + '</td><td align=right style="color:#FF0000">' + Shedul2_Amt + '</td></tr>');
                                    END;
                                UNTIL Shedul2.NEXT = 0;
                        //End by Pranavi
                        UNTIL SalesLine.NEXT = 0;
                    Body += ('</Table>');
                    IF Shedul2_Count2 > 0 THEN
                        Body += ('<BR><p align ="left" style="color:#FF0000"> Note: Red Color Items are Schedule Items</p>');
                    Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                    Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                    Mail_From := "from Mail";
                    IF BI_Status = TRUE THEN
                        //"to mail".Add('blockinstrument@efftronics.com');
                         "to mail".Add('erp@efftronics.com');


                    //  IF (Mail_To <> '') THEN BEGIN


                    // ROMail.CreateMessage('erp','erp@efftronics.com',Mail_To,'ERP - '+Subject,Body,T RUE);
                    // ROMail.AddAttachment(Attachment1);
                    EmailMessage.Create("to mail", 'ERP - ' + Mail_Subject, Body, TRUE);//EFFUPG1.4
                    //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//16-08-2022 //sujani  on 01Apr2019
                    //  END;
                    //********************************************* MAIL CODE END***************************************


                    /* {  {SH.RESET;
                       SH.SETRANGE(SH."No.","No.");
                       IF SH.FINDFIRST THEN
                       REPORT.RUN(60004,FALSE,FALSE,SH);
                       //REPORT.SAVEASHTML(50096,'\\erpserver\ErpAttachments\ErpAttachments1\Order.html',FALSE,SH);
                       REPORT.SAVEASPDF(60004,'\\erpserver\ErpAttachments\Order4.html',FALSE,SH);
                       //REPORT.SAVEASHTML(60004,'\\erpserver\ErpAttachments\SALEORDER1.html',FALSE,SH);
                       Attachment:='\\erpserver\ErpAttachments\Order4.html';   }
                       //Attachment:='\\erpserver\ErpAttachments\SALEORDER1.html';
                       //Attachment:='';

                       salesheader.RESET;
                       salesheader.SETFILTER(salesheader."No.","No.");
                       IF salesheader.FINDFIRST THEN BEGIN
                       //REPORT.RUN(60004,FALSE,FALSE,salesheader);
                       REPORT.SAVEASPDF(33000897,'\\erpserver\ErpAttachments\SALEORDER1.pdf',salesheader);
                       Attachment1:='\\erpserver\ErpAttachments\SALEORDER1.pdf';
                       END;
                       Mail_From:="from Mail";
                       Mail_To:="to mail";
                      // Mail_To:='murali@efftronics.com,padmaja@efftronics.com,sales@efftronics.com,anilkumar@efftronics.com,sundar@efftronics.com';

                       Subject:=Mail_Subject;
                       Body:= Mail_Body;
                        IF (Mail_From<>'')AND(Mail_To<>'') THEN  BEGIN
                          SMTP_MAIL.CreateMessage('erp','erp@efftronics.com',Mail_To,'ERP - '+Subject,Body,F ALSE);
                          SMTP_MAIL.AddAttachment(Attachment1);
                       //   SMTP_MAIL.AddAttachment(attachment13);
                       //   SMTP_MAIL.AddAttachment(attachment14);
                          SMTP_MAIL.Send;
                       END; }*/
                    // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,A ttachment);    //anil
                    SO.RESET;
                    SO.SETFILTER(SO."No.", SalesHeader."No.");
                    IF NOT SO.FINDFIRST THEN BEGIN
                        SO.INIT;
                        IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/SAL' THEN
                            SO."Document Type" := 1
                        ELSE
                            IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/AMC' THEN
                                SO."Document Type" := 6;
                        SO."No." := SalesHeader."No.";
                        SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                        SO."Bill-to Name" := SalesHeader."Bill-to Name";
                        SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                        SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                        // Pranavi
                        SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                        SO."SD Status" := SalesHeader."SD Status";
                        SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                        SO."EMD Amount" := SalesHeader."EMD Amount";
                        SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                        SO."SD Requested Date" := SalesHeader."SD Requested Date";
                        SO."SD Required Date" := SalesHeader."SD Required Date";
                        SO."Warranty Period" := SalesHeader."Warranty Period";
                        SO.Product := SalesHeader.Product;
                        SO."Security Deposit" := SalesHeader."Security Deposit";
                        // Pranavi
                        SO.INSERT;
                    END
                    // added by Vishnu Priya for Update in SID on 2018-Aug-10
                    ELSE BEGIN
                        SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                        SO."Bill-to Name" := SalesHeader."Bill-to Name";
                        SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                        SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                        SO."Sell-to Customer Name" := SalesHeader."Sell-to Customer Name";
                        SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                        SO."SD Status" := SalesHeader."SD Status";
                        SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                        SO."EMD Amount" := SalesHeader."EMD Amount";
                        SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                        SO."SD Requested Date" := SalesHeader."SD Requested Date";
                        SO."SD Required Date" := SalesHeader."SD Required Date";
                        SO."Warranty Period" := SalesHeader."Warranty Period";
                        SO.Product := SalesHeader.Product;
                        SO."Security Deposit" := SalesHeader."Security Deposit";
                        SO.MODIFY;
                    END;
                    //ended by Vishnu Priya

                    SalesHeader.Modify(TRUE);
                END;
            END
            ELSE BEGIN
                SHA.SETRANGE(SHA."No.", SalesHeader."No.");
                IF SHA.FINDFIRST THEN BEGIN
                    SalesHeader.MODIFY(TRUE);
                    //Added by sundar for sending changes in LED Sale order as Mail to production Manager---12-12-13

                    CLE1.RESET;
                    CLE1.SETRANGE(CLE1."Primary Key Field 2 Value", SalesHeader."No.");
                    CLE1.SETFILTER(CLE1."Table No.", '37|60025');
                    CLE1.SETFILTER(CLE1."Primary Key Field 1 Value", '1|4');
                    CLE1.SETFILTER(CLE1."Field No.", '5|6|7|11|15|18|153');
                    IF CLE1.FINDFIRST THEN BEGIN
                        CLE2.RESET;
                        CLE2.SETRANGE(CLE2."Primary Key Field 2 Value", SalesHeader."No.");
                        //REPORT.SAVEASPDF(50026, '\\erpserver\ErpAttachments\Changelog.PDF', CLE2); 8-10-22
                        //Attachment := '\\erpserver\ErpAttachments\Changelog.PDF'; 8-10-22
                        Mail_From := 'ERP@efftronics.com';
                        "to mail".add('ERP@efftronics.com');
                        //Mail_To := 'Padmaja@efftronics.com,erp@efftronics.com';
                        // Mail_To += ',Purchase@efftronics.com,sales@efftronics.com,qms@efftronics.com';
                        //Mail_To:='Padmaja@efftronics.com,qms@efftronics.com';
                        Subject := 'Changes in Sale Order ' + SalesHeader."No.";
                        Body += '<PDF><BODY>Dear Sir,<BR>';
                        Body += '<BR><PRE>       See the Attachment for list of changes in sale order</PRE><BR><BR>';
                        Body += '<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></PDF>';
                        EmailMessage.Create("to mail", 'ERP - ' + Subject, Body, TRUE);
                        //EmailMessage.AddAttachment(Attachment, '', ''); 8-10-22
                        //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22
                        // SMTP_MAIL.CreateMessage('ERP', Mail_From, "to mail", 'ERP - ' + Subject, Body, TRUE);
                        // SMTP_MAIL.AddAttachment(Attachment);
                        //SMTP_MAIL.Send;
                    END;//Added by sundar for sending changes in LED Sale order as Mail to production Manager---12-12-13
                END
                ELSE BEGIN
                    SalesHeader."Order Released Date" := TODAY;
                    SalesHeader.MODIFY;
                    nextline := 10;

                    "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERSECURITYID);//B2B
                    IF "Mail-Id".FINDFIRST THEN
                        // "from Mail" := "Mail-Id".MailID;

                        /* {"to mail":={'dir@efftronics.com,}'anilkumar@efftronics.com,padmaja@efftronics.com,';
                         "to mail"+='mk@effe.in,cvmohan@efftronics.com,chowdary@efftronics.com,bharat@efftronics.com,';
                         "to mail"+='Jhansi@efftronics.com,ravi@efftronics.com,';
                         "to mail"+='sganesh@efftronics.com,nagamani@efftronics.com,rajani@efftronics.com,';
                         "to mail"+='samba@efftronics.com,srasc@efftronics.com,prasannat@efftronics.com,';
                         "to mail"+='anuradhag@Efftronics.com,purchase@efftronics.com,durgaraov@efftronics.com,lmd@efftronics.com';}*/

                        /*  "to mail".Add('mk@effe.in');
                          "to mail".Add('bala@efftronics.com');
                          "to mail".Add('padmaja@efftronics.com');
                          "to mail".Add('marketing@efftronics.com');
                          "to mail".Add('bharat@efftronics.com');
                          "to mail".Add('erp@efftronics.com');
                          "to mail".Add('qms@efftronics.com');
                          "to mail".Add('somu@efftronics.com');
                          "to mail".Add('controlroom@efftronics.com');
                          "to mail".Add('vkrishna@efftronics.com');
                          "to mail".Add('purchase@efftronics.com');*/
                     "to mail".Add('erp@efftronics.com');
                    IF SalesHeader."Sale Order Total Amount" >= 500000 THEN
                        //"to mail".Add('ceo@efftronics.com');
                         "to mail".Add('erp@efftronics.com');
                    /* {
                     IF Product = 'BI' THEN
                       "to mail"+=',blockinstrument@efftronics.com';
                     }*/
                    //"to mail" := 'rakesht@efftronics.com'

                    //old

                    /* {   Mail_Body+= 'SALE ORDER RELEASE :';
                        Mail_Body+= FORMAT(nextline);
                        Mail_Body+= FORMAT(nextline);

                        Mail_Body+= 'Sale Order No          : '+"No.";
                        Mail_Body+= FORMAT(nextline);
                        Mail_Body+= 'Customer Name          : '+"Sell-to Customer Name";
                        Mail_Body+= FORMAT(nextline);
                        IF "Sell-to City"='' THEN
                          ERROR('Sell to City must not be Null');
                        Mail_Body+= 'Customer Place         : '+"Sell-to City";
                        Mail_Body+= FORMAT(nextline);
                        Mail_Body+= 'Customer Type          : '+"Customer Posting Group";
                        Mail_Body+= FORMAT(nextline);
                        Mail_Body+= 'Product                : '+Product;
                        Mail_Body+= FORMAT(nextline);

                        IF "Requested Delivery Date"=0D THEN
                          ERROR('SPECIFY REQUESTED DELIVERY DATE');
                        Mail_Body+= 'Customer Expected Date : '+FORMAT(("Requested Delivery Date"),0,4);
                        Mail_Body+= FORMAT(nextline);
                        IF "Order Date"=0D THEN
                          ERROR('SPECIFY ORDER DATE');
                        Mail_Body+= 'Order Date    : '+FORMAT(("Order Date"),0,4);
                        Mail_Body+= FORMAT(nextline);
                        Mail_Body+= 'Promised Delivery Date    : '+FORMAT(("Promised Delivery Date"),0,4);
                        Mail_Body+= FORMAT(nextline);

                        IF "Sale Order Total Amount"=0 THEN
                          ERROR('ENTER SALE ORDER AMOUNT');

                        Tot_amt:=formataddress.ChangeCurrency(ROUND("Sale Order Total Amount",1)); // Added by Rakesh to insert indian format currency on 22-Aug-14
                        Mail_Body+= 'Sale Order Value(RS)   : '+Tot_amt;}*/

                    //added by ahmed new
                    /*if ("to mail" <> '') then
                        Mail_To.Add("to mail");*/
                    Mail_Subject := 'ERP- ' + 'Sale Order ' + SalesHeader."No." + ' Released on for the customer ' + SalesHeader."Sell-to Customer Name";
                    Subject := Mail_Subject;
                    EmailMessage.Create("to mail", 'ERP - ' + Subject, Body, TRUE);
                    Body += (' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#C20202;  margin: 20px;} </style></head>');
                    Body += (' <body><div style="border-color:#C20202;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                    IF (COPYSTR(SalesHeader."No.", 15, 1) <> 'L') THEN BEGIN
                        Body += (' <label><font size="6"> Sale Order Information</font></label>');
                    END
                    ELSE BEGIN
                        Body += (' <label><font size="6">  LED Sale Order Information</font></label>');
                    END;


                    Body += (' <hr style=solid; color= #3333CC>');
                    Body += (' <h>Dear Sir/Madam,</h><br>');
                    Body += (' <P>SALE ORDER  DETAILS</P>');
                    Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>Sale Order No  </b> </td><td>' + SalesHeader."No." + '</td></tr>');

                    IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Allowed" THEN
                        Body += (' <tr><td><b>Shipment Type  </b> </td><td>Allowed</td></tr>')
                    ELSE
                        IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Not Allowed" THEN
                            Body += (' <tr><td><b>Shipment Type  </b> </td><td>Not Allowed</td></tr>')
                        ELSE
                            IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"No issue in Shipment" THEN
                                Body += (' <tr><td><b>Shipment Type  </b> </td><td>No issue in shipment</td></tr>')
                            ELSE
                                Body += (' <tr><td><b>Shipment Type  </b> </td><td>' + FORMAT(SalesHeader."Shipment Type") + '</td></tr>');



                    Body += (' <tr><td><b>Customer Name   </b> </td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                    IF SalesHeader."Sell-to City" = '' THEN
                        ERROR('Sell to City must not be Null');
                    Body += (' <tr><td><b>Customer Place  </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                    Body += (' <tr><td><b>Customer Type  </b></td><td>' + SalesHeader."Customer Posting Group" + '</td></tr>');
                    Body += (' <tr><td><b>Product  </b></td><td>' + SalesHeader.Product + '</td></tr>');
                    IF SalesHeader."Requested Delivery Date" = 0D THEN
                        ERROR('SPECIFY REQUESTED DELIVERY DATE');
                    Body += (' <tr><td><b>Customer Expected Date  </b></td><td>' + FORMAT((SalesHeader."Requested Delivery Date"), 0, 4) + '</td></tr>');
                    IF SalesHeader."Order Date" = 0D THEN
                        ERROR('SPECIFY ORDER DATE');
                    Body += (' <tr><td><b>Order Date   </b></td><td>' + FORMAT((SalesHeader."Order Date"), 0, 4) + '</td></tr>');
                    Body += (' <tr><td><b>Promised Delivery Date  </b></td><td>' + FORMAT((SalesHeader."Promised Delivery Date"), 0, 4) + '</td></tr>');
                    IF SalesHeader."Sale Order Total Amount" = 0 THEN
                        ERROR('ENTER SALE ORDER AMOUNT');

                    Tot_amt := formataddress.ChangeCurrency(ROUND(SalesHeader."Sale Order Total Amount", 1));

                    IF SalesHeader."Currency Factor" > 0 THEN // Added by sujani for dollar amount in foreign orders
                          BEGIN
                        Sale_Orader_Total_amt := ROUND(SalesHeader."Sale Order Total Amount", 1) / SalesHeader."Currency Factor";
                        Sale_Orader_Total_amt := ROUND(SalesHeader."Sale Order Total Amount", 1);
                    END
                    ELSE
                        Sale_Orader_Total_amt := ROUND(SalesHeader."Sale Order Total Amount", 1);
                    /* {IF Tot_amt>=FORMAT(500000) THEN     //added anil on 13/01/15 more then 5 lakhs value then data sent to ceo.
                      "to mail"+=',ceo@efftronics.com'; }*/
                    IF SalesHeader."Sell-to Customer No." = 'CUST00536' THEN
                        Body += (' <tr><td><b>Remarks</b></td><td>' + SalesHeader.Remarks + '</td></tr>');

                    Body += (' <tr><td><b>Consignee</b></td><td>' + SalesHeader."Ship-to Name" + '</td></tr>'); // Added by Pranavi on 22-05-2017

                    //SOMail.AppendBody(' <tr><td><b> Sale Order Value(RS)   </b></td><td>'+Tot_amt+'</td></tr></table><br><br>');
                    Body += (' <tr><td><b> Sale Order Value(RS)   </b></td><td>' + FORMAT(Sale_Orader_Total_amt) + '</td></tr></table><br><br>');


                    Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b></th><th><b>Item Description</b></th><th><b>Quantity</b></th><th><b>Amount</b></th></tr>');
                    BI_Status := FALSE;
                    Shedul2_Count2 := 0;
                    SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                    IF SalesLine.FINDSET THEN
                        REPEAT
                            Tot_amt := formataddress.ChangeCurrency(ROUND(SalesLine."Amount To Customer", 1));
                            IF SalesHeader."Currency Factor" > 0 THEN // Added by sujani for dollar amount in foreign orders
                            BEGIN
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1) / SalesHeader."Currency Factor";
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1);

                            END
                            ELSE
                                Sale_Orader_Total_amt := ROUND(SalesLine."Amount To Customer", 1);

                            Body += (' <tr><td>' + SalesLine."No." + '</td><td>' + SalesLine.Description + '</td><TD>' + FORMAT(SalesLine.Quantity) + '</TD><td align=right>' + FORMAT(Sale_Orader_Total_amt) + '</td></tr>');
                            //Added by Pranavi on 28-09-2015 for including Schedule items also in Mail
                            Itm.RESET;
                            Itm.SETCURRENTKEY("No.");
                            Itm.SETFILTER(Itm."No.", SalesLine."No.");
                            IF Itm.FINDFIRST THEN BEGIN
                                IF Itm."Item Sub Group Code" = 'BI' THEN
                                    BI_Status := TRUE;
                            END;
                            Shedul2.RESET;
                            Shedul2.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.", "Line No.");
                            Shedul2.SETFILTER(Shedul2."Document No.", SalesLine."Document No.");
                            Shedul2.SETFILTER(Shedul2."Document Line No.", '%1', SalesLine."Line No.");
                            Shedul2.SETFILTER(Shedul2."Line No.", '<>%1', 10000);
                            IF Shedul2.FINDSET THEN
                                REPEAT
                                    IF Shedul2."Document Line No." <> Shedul2."Line No." THEN BEGIN
                                        Shedul2_Amt := '';
                                        Shedul2_Count2 := Shedul2_Count2 + 1;
                                        //Shedul2_Amt := formataddress.ChangeCurrency(ROUND(Shedul2."Unit Cost" * Shedul2.Quantity,1));
                                        Body += (' <tr><td style="color:#FF0000">' + '  ' + Shedul2."No." + '</td><td style="color:#FF0000">' + '  ' + Shedul2.Description + '</td>');
                                        Body += (' <TD style="color:#FF0000">' + FORMAT(Shedul2.Quantity) + '</TD><td align=right style="color:#FF0000">' + Shedul2_Amt + '</td></tr>');

                                        IF Itm.FINDFIRST THEN BEGIN
                                            Shedul2_UOM := Itm."Base Unit of Measure";
                                            IF Itm."Item Sub Group Code" = 'BI' THEN
                                                BI_Status := TRUE;
                                        END;

                                    END;
                                UNTIL Shedul2.NEXT = 0;
                        //End by Pranavi
                        UNTIL SalesLine.NEXT = 0;
                    Body += (' </Table>');
                    IF BI_Status = TRUE THEN
                        //"to mail".add('blockinstrument@efftronics.com');
                         "to mail".Add('erp@efftronics.com');

                    IF Shedul2_Count2 > 0 THEN
                        Body += (' <BR><p align ="left" style="color:#FF0000"> Note: Red Color Items are Schedule Items</p>');
                    Body += (' <BR><p align ="left"> Regards,<br>ERP Team </p>');
                    Body += (' <br><p align = "center">::::::Note: Auto Generated mail from ERP:::::: </b></P></div></body></html>');


                    //      Mail_Body+= 'Sale Order Value(RS)   : '+FORMAT(ROUND("Sale Order Total Amount",1));


                    //Mail_Subject:='ERP- '+'Sale Order '+"No."+' Released on for the customer '+"Sell-to Customer Name";
                    // Subject:= Mail_Subject;
                    //old
                    /*{ salesheader.RESET;
                     salesheader.SETFILTER(salesheader."No.","No.");
                     IF salesheader.FINDFIRST THEN BEGIN
                       REPORT.SAVEASPDF(33000897,'\\erpserver\ErpAttachments\SALEORDER1.pdf',salesheader);
                       Attachment1:='\\erpserver\ErpAttachments\SALEORDER1.pdf';
                     END;}*/

                    //Mail_From := "from Mail";
                    // Mail_To:="to mail";
                    Subject := Mail_Subject;
                    //Body:= Mail_Body;
                    //old
                    /*  {  IF (Mail_From<>'')AND(Mail_To<>'') THEN  BEGIN
                        SMTP_MAIL.CreateMessage('erp','erp@efftronics.com',Mail_To,'ERP - '+Subject,Body,T RUE);
                        SMTP_MAIL.AddAttachment(Attachment1);
                        SMTP_MAIL.Send;
                     END;}*/
                    //ahmed



                    /* IF (Mail_From <> '') AND (Mail_To <> '') THEN BEGIN
                         SOMail.Send; //sujani 01Apr2019
                     END;*/


                    SO.RESET;
                    SO.SETFILTER(SO."No.", SalesHeader."No.");
                    IF NOT SO.FINDFIRST THEN BEGIN
                        SO.INIT;
                        IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/SAL' THEN
                            SO."Document Type" := 1
                        ELSE
                            IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/AMC' THEN
                                SO."Document Type" := 6;
                        SO."No." := SalesHeader."No.";
                        SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                        SO."Bill-to Name" := SalesHeader."Bill-to Name";
                        SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                        SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                        // Pranavi
                        SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                        SO."SD Status" := SalesHeader."SD Status";
                        SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                        SO."EMD Amount" := SalesHeader."EMD Amount";
                        SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                        SO."SD Requested Date" := SalesHeader."SD Requested Date";
                        SO."SD Required Date" := SalesHeader."SD Required Date";
                        SO."Warranty Period" := SalesHeader."Warranty Period";
                        SO.Product := SalesHeader.Product;
                        SO."Security Deposit" := SalesHeader."Security Deposit";
                        // Pranavi
                        SO.INSERT;
                    END
                    // added by Vishnu Priya for Update in SID on 2018-Aug-10
                    ELSE BEGIN
                        SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                        SO."Bill-to Name" := SalesHeader."Bill-to Name";
                        SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                        SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                        // Pranavi
                        SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                        SO."SD Status" := SalesHeader."SD Status";
                        SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                        SO."EMD Amount" := SalesHeader."EMD Amount";
                        SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                        SO."SD Requested Date" := SalesHeader."SD Requested Date";
                        SO."SD Required Date" := SalesHeader."SD Required Date";
                        SO."Warranty Period" := SalesHeader."Warranty Period";
                        SO.Product := SalesHeader.Product;
                        SO."Security Deposit" := SalesHeader."Security Deposit";
                        SO.MODIFY;
                    END;


                END;
            END;
        END;

        IF (SalesHeader.SaleDocType = SalesHeader.SaleDocType::Amc) THEN BEGIN  //EFFUPG1.5                                                   //Mail Code for Release Condition for AMC Order
            SHA.SETRANGE(SHA."No.", SalesHeader."No.");
            IF SHA.FINDFIRST THEN begin
                //SalesHeader.MODIFY(TRUE);//EFF02NOV22
            end ELSE BEGIN
                //"Expiration Date":=TODAY;
                SalesHeader."Order Released Date" := TODAY;
                SalesHeader."First Released Date Time" := CURRENTDATETIME;//EFF02NOV22
                SalesHeader.MODIFY;
                nextline := 10;

                "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERSECURITYID);//B2B
                IF "Mail-Id".FINDFIRST THEN
                    // "from Mail" := "Mail-Id".MailID;
                    /* "to mail".Add('mk@effe.in');
                 "to mail".Add('cuspm@efftronics.com');
                 "to mail".Add('rajani@efftronics.com');
                 //"to mail"+='pmurali@efftronics.com,';
                 "to mail".Add('sales@efftronics.com');
                 "to mail".Add('prasanthi@efftronics.com');
                 "to mail".Add('yesu@efftronics.com');
                 "to mail".Add('rishianvesh@efftronics.com');
                 "to mail".Add('erp@efftronics.com');*/
                 "to mail".Add('erp@efftronics.com');
                IF SalesHeader."Sale Order Total Amount" = 0 THEN BEGIN
                    //"to mail".Add('ceo@efftronics.com');
                    "to mail".Add('erp@efftronics.com');
                END;

                Divi.RESET;
                Divi.SETFILTER(Divi."Code", SalesHeader.Territory);
                IF Divi.FINDFIRST THEN BEGIN
                    User.SETFILTER(User.EmployeeID, Divi."Project Manager");
                    IF User.FINDFIRST THEN BEGIN
                        IF User.MailID <> '' THEN
                            // "to mail".add(User.MailID);
                            "to mail".Add('erp@efftronics.com');
                    END;
                END;


                IF SalesHeader."Shortcut Dimension 1 Code" = '' THEN
                    ERROR('specify department code');
                /* {
                   IF Product='' THEN
                    ERROR('Please specify the Product');
                   IF ("Payment Terms Code"='')THEN
                   ERROR('Please Specify Payments Term Code for Order');
                 }
                  { Mail_Subject:='Sale Order Released';
                   Mail_Body+= 'Sir/Madam,';
                   Mail_Body+= FORMAT(nextline);
                   Mail_Body+= FORMAT(nextline);
                   Mail_Body+= 'AMC Order No           : '+"No.";
                   Mail_Body+= FORMAT(nextline);
                   Mail_Body+= 'Customer Name          : '+"Sell-to Customer Name";
                   Mail_Body+= FORMAT(nextline);
                   IF "Sell-to City"='' THEN
                   ERROR('Sell to City must not be Null');
                   Mail_Body+= 'Customer Place         : '+"Sell-to City";
                   Mail_Body+= FORMAT(nextline);
                   Mail_Body+= 'Customer Type          : '+"Customer Posting Group";
                   Mail_Body+= FORMAT(nextline);
                   IF "Customer OrderNo."='' THEN
                   ERROR('ENTER CUSTOMER ORDER NO.');
                   Mail_Body+= 'Customer LOA No.       : '+"Customer OrderNo.";
                   Mail_Body+= FORMAT(nextline);
                   IF "Requested Delivery Date"=0D THEN
                   ERROR('SPECIFY AMC PERIOD START DATE');
                   Mail_Body+= 'AMC Period Start Date  : '+FORMAT(("Requested Delivery Date"),0,4);
                   Mail_Body+= FORMAT(nextline);
                   IF "Customer Order Date"=0D THEN
                   ERROR('SPECIFY CUSTOMER ORDER DATE');
                   Mail_Body+= 'Customer Order Date    : '+FORMAT(("Customer Order Date"),0,4);
                   Mail_Body+= FORMAT(nextline);
                   IF "Promised Delivery Date"=0D THEN
                   ERROR('SPECIFY AMC PERIOD END DATE');
                   IF "Promised Delivery Date"<"Requested Delivery Date" THEN
                   ERROR('Amc End Date must be greater than Stat Date');
                   IF "Order Date"=0D THEN
                   ERROR('SPECIFY ORDER DATE');
                   Mail_Body+= 'Order Date    : '+FORMAT(("Order Date"),0,4);
                   Mail_Body+= FORMAT(nextline);
                   IF "Sale Order Total Amount"=0 THEN
                     ERROR('ENTER SALE ORDER AMOUNT');

                   Tot_amt:=formataddress.ChangeCurrency(ROUND("Sale Order Total Amount",1)); // Added by Rakesh to insert indian format currency on 22-Aug-14
                   Mail_Body+= 'AMC Order Value(RS)    : '+Tot_amt;
               //    Mail_Body+= 'AMC Order Value(RS)    : '+FORMAT(ROUND("Sale Order Total Amount",1));
                   Mail_Body+= FORMAT(nextline);
                   cus.SETRANGE(cus."No.","Sell-to Customer No.");
                   IF cus.FINDFIRST THEN
                   BEGIN
                   IF cus."Service Zone Code"='' THEN
                   ERROR('Enter Service Zone Code for this Customer in Customer Card');
                   END;
                   IF "Posting from Whse. Ref."<0 THEN
                   ERROR('Enter data for AMC Visit Period field in invoicing Tab');
                   IF ("BG Status"="BG Status"::" ")THEN
                   ERROR('ENTER THE BG STATUS');
                   Mail_Body+= 'BG Submitted Status    : '+FORMAT("BG Status");
                   Mail_Body+= FORMAT(nextline);
                   IF ("Customer Posting Group"='RAILWAYS')AND("BG Status"="BG Status"::Pending)THEN
                   BEGIN
                   IF ("CA Date"=0D)THEN
                   ERROR('Enter the BG required Date')
                   ELSE
                   Mail_Body+= 'BG Required Date       : '+FORMAT(("CA Date"),0,4);
                   Mail_Body+= FORMAT(nextline);
                   END;
                   IF ("BG Status"="BG Status"::Pending)OR("BG Status"="BG Status"::Submitted)THEN
                   BEGIN
                   IF "Exp.Payment"=0 THEN
                     ERROR('Please Enter BG Value')
                   ELSE
                   BEGIN
                     BG_value:=formataddress.ChangeCurrency(ROUND("Exp.Payment",1));
                     Mail_Body+= 'BG Value               : '+BG_value;
                     //Mail_Body+= 'BG Value               : '+FORMAT(ROUND("Exp.Payment",1));
                   END;
                   Mail_Body+= FORMAT(nextline);
                   END;
                   IF ("Customer Posting Group"='RAILWAYS')AND("Security Deposit Amount"=0) and ("SD Status" <> "SD Status"::NA) THEN
                     ERROR('Please enter the Security Deposit Amount');
                   IF ("Salesperson Code"='') AND (COPYSTR("No.",1,13)<>'EFF/11-12/CUS') THEN
                   ERROR('PICK THE SALES PERSON CODE');
                  { "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Salesperson Code");//B2B
                   IF "Mail-Id".FINDFIRST THEN
                   Mail_Body+= 'Sales Executive        :'+"Mail-Id"."User Name";
                   }Mail_Body+= FORMAT(nextline);
                   Mail_Body+= FORMAT(nextline);
                   Mail_Body+= '***** Auto Mail Generated From ERP *****'; }*/
                //*****************************************************new code**************************************************
                Mail_Subject := 'AMC Order' + SalesHeader."No." + ' Released on for the Customer ' + SalesHeader."Sell-to Customer Name";
                /*if ("to mail" <> '') then
                    Mail_To.Add("to mail");*/

                Body += (' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#C20202;  margin: 20px;} </style></head>');
                Body += (' <body><div style="border-color:#C20202;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                Body += (' <label><font size="6"> AMC Sale Order Information</font></label>');
                Body += (' <hr style=solid; color= #3333CC>');
                Body += (' <h>Dear Sir/Madam,</h><br>');
                Body += (' <P>AMC SALE ORDER  DETAILS</P>');
                Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b>AMC Order No    </b> </td><td>' + SalesHeader."No." + '</td></tr>');
                /*{  IF "Shipment Type"="Shipment Type"::Allowed THEN
                  AMCMail.AppendBody(' <tr><td><b>Shipment Type   </b> </td><td>Allowed</td></tr>')
                  ELSE
                  AMCMail.AppendBody(' <tr><td><b>Shipment Type  </b> </td><td>Not Allowed</td></tr>');}*/
                Body += (' <tr><td><b>Customer Name   </b> </td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                IF SalesHeader."Sell-to City" = '' THEN
                    ERROR('Sell to City must not be Null');
                Body += (' <tr><td><b>Customer Place  </b></td><td>' + SalesHeader."Sell-to City" + '</td></tr>');
                Body += (' <tr><td><b>Customer Type  </b></td><td>' + SalesHeader."Customer Posting Group" + '</td></tr>');
                Body += (' <tr><td><b>Product  </b></td><td>' + SalesHeader.Product + '</td></tr>');
                IF SalesHeader."Customer OrderNo." = '' THEN
                    ERROR('ENTER CUSTOMER ORDER NO.');
                Body += (' <tr><td><b> Customer LOA No.: </b></td><td>' + SalesHeader."Customer OrderNo." + '</td></tr>');
                IF SalesHeader."Requested Delivery Date" = 0D THEN
                    ERROR('SPECIFY AMC PERIOD START DATE');
                Body += (' <tr><td><b> AMC Period Start Date  </b></td><td>' + FORMAT((SalesHeader."Requested Delivery Date"), 0, 4) + '</td></tr>');
                IF SalesHeader."Customer Order Date" = 0D THEN
                    ERROR('SPECIFY CUSTOMER ORDER DATE');
                Body += (' <tr><td><b> Customer Order Date   </b></td><td>' + FORMAT((SalesHeader."Customer Order Date"), 0, 4) + '</td></tr>');
                IF SalesHeader."Promised Delivery Date" = 0D THEN
                    ERROR('SPECIFY AMC PERIOD END DATE');
                IF SalesHeader."Promised Delivery Date" < SalesHeader."Requested Delivery Date" THEN
                    ERROR('Amc End Date must be greater than Stat Date');
                IF SalesHeader."Order Date" = 0D THEN
                    ERROR('SPECIFY ORDER DATE');
                Body += (' <tr><td><b> Order Date   </b></td><td>' + FORMAT((SalesHeader."Order Date"), 0, 4) + '</td></tr>');
                IF SalesHeader."Sale Order Total Amount" = 0 THEN
                    ERROR('ENTER SALE ORDER AMOUNT');


                Tot_amt := formataddress.ChangeCurrency(ROUND(SalesHeader."Sale Order Total Amount", 1)); // Added by Rakesh to insert indian format currency on 22-Aug-14
                Body += (' <tr><td><b>AMC Order Value(RS)  </b></td><td>' + Tot_amt + '</td></tr>');
                cus.SETRANGE(cus."No.", SalesHeader."Sell-to Customer No.");
                IF cus.FINDFIRST THEN BEGIN
                    IF cus."Service Zone Code" = '' THEN
                        ERROR('Enter Service Zone Code for this Customer in Customer Card');
                END;
                IF SalesHeader."Posting from Whse. Ref." < 0 THEN
                    ERROR('Enter data for AMC Visit Period field in invoicing Tab');
                IF (SalesHeader."BG Status" = SalesHeader."BG Status"::" ") THEN
                    ERROR('ENTER THE BG STATUS');
                Body += (' <tr><td><b> BG Submitted Status </b></td><td>' + FORMAT(SalesHeader."BG Status") + '</td></tr>');
                IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') AND (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) THEN BEGIN
                    IF (SalesHeader."CA Date" = 0D) THEN
                        ERROR('Enter the BG required Date')
                    ELSE
                        Body += (' <tr><td><b> BG Required Date </b></td><td>' + FORMAT((SalesHeader."CA Date"), 0, 4) + '</td></tr>');
                END;
                IF SalesHeader."Sell-to Customer No." = 'CUST00536' THEN
                    Body += (' <tr><td><b>Remarks</b></td><td>' + SalesHeader.Remarks + '</td></tr>');
                IF (SalesHeader."BG Status" = SalesHeader."BG Status"::Pending) OR (SalesHeader."BG Status" = SalesHeader."BG Status"::Submitted) THEN BEGIN
                    IF SalesHeader."Exp.Payment" = 0 THEN
                        ERROR('Please Enter BG Value')
                    ELSE BEGIN
                        BG_value := formataddress.ChangeCurrency(ROUND(SalesHeader."Exp.Payment", 1));
                        Body += (' <tr><td><b> BG Value </b></td><td>' + BG_value + '</td></tr></table><br><br>');
                    END;
                END;
                Body += (' <p><b>SALE ORDER DETAILS<b></p>');
                IF (SalesHeader."Customer Posting Group" = 'RAILWAYS') AND (SalesHeader."Security Deposit Amount" = 0) AND (SalesHeader."SD Status" <> SalesHeader."SD Status"::NA) THEN
                    ERROR('Please enter the Security Deposit Amount');
                IF (SalesHeader."Salesperson Code" = '') AND (COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS') THEN
                    ERROR('PICK THE SALES PERSON CODE');
                Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b> </th><th><b>Order no.</b></th><th>Item Description </th><th>Quantity</th></tr>');
                SalesLine.RESET;
                SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                IF SalesLine.FINDSET THEN
                    REPEAT
                        Body += (' <tr><td>' + SalesLine."No." + '</td><td>' + SalesLine."Document No." + '</td><td><font face="verdana" color="green">' + SalesLine.Description + '</font></td><TD>' + FORMAT(SalesLine.Quantity) + '</TD></tr>');
                    UNTIL SalesLine.NEXT = 0;
                Body += (' </Table>');
                Body += (' <BR><p align ="left"> Regards,<br>ERP Team </p>');
                Body += (' <br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                // Mail_From := "from Mail";
                EmailMessage.Create("to mail", 'ERP - ' + Mail_Subject, Body, TRUE);
                // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22

            END;
            //*******************************************************************************************************

            /*{{SH.SETRANGE(SH."No.","No.");
            IF SH.FINDFIRST THEN
            REPORT.RUN(60004,FALSE,FALSE,SH);
            REPORT.SAVEASHTML(60004,'\\erpserver\ErpAttachments\Order4.html',FALSE,SH);
            //REPORT.SAVEASHTML(60004,'\\erpserver\ErpAttachments\SALEORDER1.html',FALSE,SH);
            Attachment:='\\erpserver\ErpAttachments\Order4.html'; }
                salesheader.RESET;
                salesheader.SETFILTER(salesheader."No.","No.");
                IF salesheader.FINDFIRST THEN BEGIN
                //REPORT.RUN(60004,FALSE,FALSE,salesheader);
                REPORT.SAVEASPDF(33000897,'\\erpserver\ErpAttachments\SALEORDER1.pdf',salesheader);
                Attachment1:='\\erpserver\ErpAttachments\SALEORDER1.pdf';
                END;
            Mail_From:="from Mail";
            Mail_To:="to mail";
            Subject:=Mail_Subject;
            Body:= Mail_Body;

            IF (Mail_From<>'')AND(Mail_To<>'') THEN  BEGIN
               SMTP_MAIL.CreateMessage('erp','erp@efftronics.com',Mail_To,'ERP - '+Subject,Body,F ALSE);
               SMTP_MAIL.AddAttachment(Attachment1);
              // SMTP_MAIL.AddAttachment(attachment13);
              // SMTP_MAIL.AddAttachment(attachment14);
               SMTP_MAIL.Send;
            END;}*/

            //IF ("from Mail"<>'')AND("to mail"<>'') THEN
            // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,A ttachment);         //anil
            //SalesHeader.MODIFY(TRUE);//EFF02NOV22
            SO.RESET;
            SO.SETFILTER(SO."No.", SalesHeader."No.");
            IF NOT SO.FINDFIRST THEN BEGIN
                SO.INIT;
                IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/SAL' THEN
                    SO."Document Type" := 1
                ELSE
                    IF COPYSTR(SalesHeader."No.", 1, 7) = 'EFF/AMC' THEN
                        SO."Document Type" := 6;
                SO."No." := SalesHeader."No.";
                SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                SO."Bill-to Name" := SalesHeader."Bill-to Name";
                SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                // Pranavi
                SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                SO."SD Status" := SalesHeader."SD Status";
                SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                SO."EMD Amount" := SalesHeader."EMD Amount";
                SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                SO."SD Requested Date" := SalesHeader."SD Requested Date";
                SO."SD Required Date" := SalesHeader."SD Required Date";
                SO."Warranty Period" := SalesHeader."Warranty Period";
                SO.Product := SalesHeader.Product;
                SO."Security Deposit" := SalesHeader."Security Deposit";
                // Pranavi
                SO.INSERT;
            END
            // added by Vishnu Priya for Update in SID on 2018-Aug-10
            ELSE BEGIN
                SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                SO."Bill-to Name" := SalesHeader."Bill-to Name";
                SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                // Pranavi
                SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                SO."SD Status" := SalesHeader."SD Status";
                SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                SO."EMD Amount" := SalesHeader."EMD Amount";
                SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                SO."SD Requested Date" := SalesHeader."SD Requested Date";
                SO."SD Required Date" := SalesHeader."SD Required Date";
                SO."Warranty Period" := SalesHeader."Warranty Period";
                SO.Product := SalesHeader.Product;
                SO."Security Deposit" := SalesHeader."Security Deposit";
                SO.MODIFY;
            END;



        END

        ELSE
            SalesHeader.MODIFY(TRUE);

        //MAIL FOR CS Work ORDER RELEASE

        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order") THEN BEGIN

            // Nagaraju
            IF COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS' THEN BEGIN
                ErrorMess := 'Please Specify the fields data : ';

                IF (SalesHeader."Project Completion Date" = 0D) OR (FORMAT(SalesHeader."Project Completion Date") = ' ') THEN
                    ErrorMess := ErrorMess + ' Project Completion Date,';
                IF SalesHeader."Order Completion Period" = 0 THEN
                    ErrorMess := ErrorMess + ' Order Completion Period,';
                IF SalesHeader."Expecting Week" = 0D THEN
                    ErrorMess := ErrorMess + ' Expecting Week,';
                IF SalesHeader."Salesperson Code" = '' THEN
                    ErrorMess := ErrorMess + ' Salesperson Code,';
                IF SalesHeader."Sell-to City" = '' THEN
                    ErrorMess := ErrorMess + ' Sell to City,';

                ErrorMess := COPYSTR(ErrorMess, 1, STRLEN(ErrorMess) - 1);
                IF ErrorMess <> 'Please Specify the fields data :' THEN
                    ERROR(ErrorMess);
            END;

            // Nagaraju

            //Mail Code for Release Condition for Blanket Order
            SHA.SETRANGE(SHA."No.", SalesHeader."No.");
            IF SHA.FINDFIRST THEN BEGIN
                //"Expiration Date":=TODAY;
                SalesHeader.MODIFY(TRUE);
            END
            ELSE BEGIN
                SalesHeader."Order Released Date" := TODAY;
                nextline := 10;

                IF (USERID <> 'EFFTRONICS\PADMAJA') THEN BEGIN
                    "Mail-Id".SETRANGE("Mail-Id"."User Security ID", USERSECURITYID);//B2B

                    //oldcode
                    /* { IF (USERID='99PR003') OR(USERID='EFFTRONICS\PRASANTHI') THEN
                      BEGIN
                       Mail_Subject:='ERP- '+'INTERNAL Work Order Released';
                      Mail_Body+= 'ORDER DETAILS :';
                      Mail_Body+= FORMAT(nextline);
                      Mail_Body+= FORMAT(nextline);
                      Mail_Body+= 'Work Order No          : '+"No.";
                      Mail_Body+= FORMAT(nextline);
                      Mail_Body+= 'Customer Name          : '+"Sell-to Customer Name";
                      Mail_Body+= FORMAT(nextline);
                     "to mail":='mk@effe.in,padmaja@efftronics.com,prasanthi@efftronics.com,';
                     "to mail"+='erp@efftronics.com,qms@efftronics.com';
                      END}*/
                    IF (USERID = '99PR003') OR (USERID = 'EFFTRONICS\PRASANTHI') THEN BEGIN
                        /*"to mail".Add('mk@effe.in');
                        "to mail".Add('padmaja@efftronics.com');
                        "to mail".Add('prasanthi@efftronics.com');*/
                        "to mail".Add('erp@efftronics.com'); //,qms@efftronics.com
                        /*if ("to mail" <> '') then
                            Mail_To.Add("to mail");*/
                        EmailMessage.Create("to mail", 'ERP - ' + Mail_Subject, Body, TRUE);
                        Body += (' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#182F7A;  margin: 20px;} </style></head>');
                        Body += (' <body><div style="border-color:#182F7A;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                        Body += (' <label><font size="6">Blanket Sale Order Information</font></label>');
                        Body += (' <hr style=solid; color= #3333CC>');
                        Body += (' <h>Dear Sir/Madam,</h><br>');
                        Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                        Body += (' <tr><td><b> Work Order No</b></td><td>' + SalesHeader."No." + '</td></tr>');
                        IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Allowed" THEN
                            Body += (' <tr><td><b>Shipment Type  </b> </td><td>Allowed</td></tr>')
                        ELSE
                            IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Not Allowed" THEN
                                Body += (' <tr><td><b>Shipment Type  </b> </td><td>Not Allowed</td></tr>')
                            ELSE
                                IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"No issue in Shipment" THEN
                                    Body += (' <tr><td><b>Shipment Type  </b> </td><td>No issue in shipment</td></tr>')
                                ELSE
                                    Body += (' <tr><td><b>Shipment Type  </b> </td><td>' + FORMAT(SalesHeader."Shipment Type") + '</td></tr>');

                        Body += (' <tr><td><b> Customer Name </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr></table>');
                        Body += (' <p> Order Information</p>');
                        Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b></th><th>Item Description</th><th><b>Quantity</b></th><th><b>UOM</b></th></tr>');
                        SalesLine.RESET;
                        SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                                Body += (' <tr><td>' + SalesLine."No." + '</td><td><b>' + SalesLine.Description + '<b></td><td>' + FORMAT(SalesLine.Quantity) + '</td><td>' + FORMAT(SalesLine."Unit of Measure Code") + '</td></tr>');
                            UNTIL SalesLine.NEXT = 0;
                        Body += (' </table>');
                        Body += (' <BR><p align ="left"> Regards,<br>ERP Team </p>');
                        Body += (' <br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                    END

                    ELSE BEGIN
                        Mail_Subject := 'ERP- ' + 'Blanket Order ' + SalesHeader."No." + ' Released on for the customer ' + SalesHeader."Sell-to Customer Name";
                        ;

                        // Added by Rakesh to separate mail for LED Expected Orders on 28-Aug-14
                        IF (COPYSTR(SalesHeader."No.", 15, 1) <> 'L') THEN BEGIN
                            /*  "to mail".Add('padmaja@efftronics.com');
                              "to mail".Add('prasanthi@efftronics.com');
                              "to mail".Add('controlroom@efftronics.com');
                              "to mail".Add('erp@efftronics.com');
                              "to mail".Add('purchase@efftronics.com');
                              "to mail".Add('qms@efftronics.com');
                              "to mail".Add('marketing@efftronics.com');
                              "to mail".Add('sales@efftronics.com');*/
                            "to mail".Add('erp@efftronics.com');
                        END
                        ELSE BEGIN
                            /*  "to mail".Add('mk@effe.in');
                              "to mail".Add('bala@efftronics.com');
                              "to mail".Add('padmaja@efftronics.com');
                              "to mail".Add('bharat@efftronics.com');
                              "to mail".Add('erp@efftronics.com');
                              "to mail".Add('qms@efftronics.com');
                              "to mail".Add('somu@efftronics.com');
                              "to mail".Add('controlroom@efftronics.com');*/
                            "to mail".Add('erp@efftronics.com');
                        END;
                        /*if ("to mail" <> '') then
                            Mail_To.Add("to mail");*/
                        // end
                        /* { Divi.RESET;
                          Divi.SETFILTER(Divi."Division Code",Territory);
                          IF Divi.FINDFIRST THEN
                          BEGIN
                            User.SETFILTER(User."User Security ID",Divi."Project Manager");//B2B
                            IF User.FINDFIRST THEN
                            BEGIN
                              IF User.MailID<>'' THEN
                                "to mail"+=','+User.MailID;
                            END;
                          END;
                          }*/

                        IF SalesHeader."Order Completion Period" = 0 THEN
                            ERROR('Please Specify Order Completion Period');
                        IF SalesHeader."Expecting Week" = 0D THEN
                            ERROR('Please Specify Expecting Week for Blanket Order');
                        //old code
                        /*{ Mail_Body+= 'ORDER DETAILS :';
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= 'Work Order No          : '+"No.";
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= 'Customer Name          : '+"Sell-to Customer Name";
                         Mail_Body+= FORMAT(nextline);
                        IF "Sell-to City"='' THEN
                        ERROR('Sell to City must not be Null');
                         Mail_Body+= 'Customer Place         : '+"Sell-to City";
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= 'Order Completion Days  : '+FORMAT("Order Completion Period")+ ' Days';
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= 'Expecting Date         : '+FORMAT(("Expecting Week"),0,4);
                         Mail_Body+= FORMAT(nextline);
                        IF ("Salesperson Code"='') AND (COPYSTR("No.",1,13)<>'EFF/11-12/CUS') THEN
                        ERROR('PICK THE SALES PERSON CODE');
                        { "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Salesperson Code");//B2B
                         IF "Mail-Id".FINDFIRST THEN
                         Mail_Body+= 'Sales Executive        : '+"Mail-Id"."User Name";//B2B
                         }Mail_Body+= FORMAT(nextline);
                         Mail_Body+= FORMAT(nextline);
                         Mail_Body+= '***** Auto Mail Generated From ERP *****';
                      END; }*/

                        //*****************************************blanket orders********************************




                        Body += (' <html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#ED1A6F;  margin: 20px;} </style></head>');
                        Body += (' <body><div style="border-color:#ED1A6F;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                        Body += (' <label><font size="6"> Blanket Sale Order Information</font></label>');
                        Body += (' <hr style=solid; color= #3333CC>');
                        Body += (' <h>Dear Sir/Madam,</h><br>');
                        IF SalesHeader."Order Completion Period" = 0 THEN
                            ERROR('Please Specify Order Completion Period');
                        IF SalesHeader."Expecting Week" = 0D THEN
                            ERROR('Please Specify Expecting Week for Blanket Order');
                        Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                        Body += (' <tr><td><b> Customer Name </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                        Body += (' <tr><td><b> Work Order No</b></td><td>' + SalesHeader."No." + '</td></tr>');
                        IF SalesHeader."Shipment Type" = SalesHeader."Shipment Type"::"Partially Allowed" THEN
                            Body += (' <tr><td><b> Customer Name </b></td><td>Allowed</td></tr></table>')
                        ELSE
                            Body += (' <tr><td><b> Customer Name </b></td><td>Not Allowed</td></tr></table>');
                        Body += (' <tr><td><b> Customer Name </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                        IF SalesHeader."Sell-to City" = '' THEN
                            ERROR('Sell to City must not be Null');
                        Body += (' <tr><td><b> Customer Place</b></td><td>' + SalesHeader."Sell-to City" + '</td></tr>');
                        Body += (' <tr><td><b> Order Completion Days</b></td><td>' + FORMAT(SalesHeader."Order Completion Period") + '</td></tr>');
                        Body += (' <tr><td><b>Expecting Date </b></td><td>' + FORMAT((SalesHeader."Expecting Week"), 0, 4) + '</td></tr>');
                        IF (SalesHeader."Salesperson Code" = '') AND (COPYSTR(SalesHeader."No.", 1, 13) <> 'EFF/11-12/CUS') THEN
                            ERROR('PICK THE SALES PERSON CODE');
                        IF SalesHeader."Sell-to Customer No." = 'CUST00536' THEN
                            Body += (' <tr><td><b>Remarks</b></td><td>' + SalesHeader.Remarks + '</td></tr>');
                        SPP.RESET;
                        SPP.SETFILTER(SPP.Code, SalesHeader."Salesperson Code");
                        IF SPP.FINDFIRST THEN
                            Body += (' <tr><td><b>Sales Person</b></td><td>' + SPP.Name + '</td></tr></table><br><br>');
                        SPP.RESET;
                        Body += (' <P> Order Details <p>');
                        Body += (' <table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b></th><th><b>Order no.</b> </th><th>Item Description </th> <th>Quantity</th><th>UOM</th></tr>');

                        BI_Status := FALSE;
                        Shedul2_Count2 := 0;
                        SalesLine.RESET;
                        SalesLine.SETFILTER("Document No.", SalesHeader."No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                                //MESSAGE(SalesLine."No.");
                                Body += (' <tr><td>' + SalesLine."No." + '</td><td>' + SalesLine."Document No." + '</td><td>' + SalesLine.Description + '</td><td>' + FORMAT(SalesLine.Quantity) + '</td><td>' + FORMAT(SalesLine."Unit of Measure Code") + '</td></tr>');
                                //Added by Pranavi on 28-09-2015 for including Schedule items also in Mail
                                Itm.RESET;
                                Itm.SETCURRENTKEY("No.");
                                Itm.SETFILTER(Itm."No.", SalesLine."No.");
                                IF Itm.FINDFIRST THEN BEGIN
                                    IF Itm."Item Sub Group Code" = 'BI' THEN
                                        BI_Status := TRUE;
                                END;

                                Shedul2.RESET;
                                Shedul2.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.", "Line No.");
                                Shedul2.SETFILTER(Shedul2."Document No.", SalesLine."Document No.");
                                Shedul2.SETFILTER(Shedul2."Document Line No.", '%1', SalesLine."Line No.");
                                Shedul2.SETFILTER(Shedul2."Line No.", '<>%1', 10000);
                                IF Shedul2.FINDSET THEN
                                    REPEAT
                                        IF Shedul2."Document Line No." <> Shedul2."Line No." THEN BEGIN
                                            Shedul2_Amt := '';
                                            Shedul2_Count2 := Shedul2_Count2 + 1;
                                            //Shedul2_Amt := formataddress.ChangeCurrency(ROUND(Shedul2."Unit Cost" * Shedul2.Quantity,1));
                                            Body += (' <tr><td style="color:#FF0000">' + Shedul2."No." + '</td><td style="color:#FF0000">' + SalesLine."Document No." + '</td>');
                                            Body += (' <TD style="color:#FF0000">' + Shedul2.Description + '</TD><td style="color:#FF0000">' + FORMAT(Shedul2.Quantity) + '</td></tr>');

                                            IF Itm.FINDFIRST THEN BEGIN
                                                Shedul2_UOM := Itm."Base Unit of Measure";
                                                IF Itm."Item Sub Group Code" = 'BI' THEN
                                                    BI_Status := TRUE;
                                            END;

                                        END;
                                    UNTIL Shedul2.NEXT = 0;
                            //End by Pranavi
                            UNTIL SalesLine.NEXT = 0;
                        Body += (' </table>');
                        IF BI_Status = TRUE THEN
                            //"to mail".Add('blockinstrument@efftronics.com');
                             "to mail".Add('erp@efftronics.com');

                        IF Shedul2_Count2 > 0 THEN
                            Body += (' <BR><p align ="left" style="color:#FF0000"> Note: Red Color Items are Schedule Items</p>');
                        Body += (' <BR><p align ="left"> Regards,<br>ERP Team </p>');
                        Body += (' <br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                    END;
                    EmailMessage.Create("to mail", 'ERP - ' + Mail_Subject, Body, TRUE);
                    // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22
                    //*********************************************************end*****************************************

                    //  Mail_From := "from Mail";      //added by ahmed


                    // sujani on 01Apr2019

                    //old code

                    /* {{SH.SETRANGE(SH."No.","No.");
                     IF SH.FINDFIRST THEN
                     REPORT.RUN(50096,FALSE,FALSE,SH);
                     REPORT.SAVEASHTML(50096,'\\erpserver\ErpAttachments\Order4.html',FALSE,SH);
                     Attachment:='\\erpserver\ErpAttachments\Order4.html'; }
                         salesheader.RESET;
                         salesheader.SETFILTER(salesheader."No.","No.");
                         IF salesheader.FINDFIRST THEN  BEGIN
                         //REPORT.RUN(60004,FALSE,FALSE,salesheader);
                         REPORT.SAVEASPDF(33000897,'\\erpserver\ErpAttachments\SALEORDER1.Pdf',salesheader);
                         Attachment1:='\\erpserver\ErpAttachments\SALEORDER1.Pdf';
                         END;
                     Mail_From:="from Mail";
                     Mail_To:="to mail";
                     Subject:=Mail_Subject;
                     Body:= Mail_Body;
 
                     IF (Mail_From<>'')AND(Mail_To<>'') THEN  BEGIN
                        SMTP_MAIL.CreateMessage('erp','erp@efftronics.com',Mail_To,'ERP - '+Subject,Body,F ALSE);
                        SMTP_MAIL.AddAttachment(Attachment1);
                     //   SMTP_MAIL.AddAttachment(attachment13);
                     //   SMTP_MAIL.AddAttachment(attachment14);
                        SMTP_MAIL.Send;  // --->mnraju- Temporary change
                        //SLEEP(2000);

                     END; }*/


                    //IF ("from Mail"<>'')AND("to mail"<>'') THEN
                    // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,A ttachment);    //anil
                END;
                SalesHeader.MODIFY(TRUE);
            END;


        end;
    end;

    //<<Codeunit414clos<<

    //<<Codeunit415opn<<
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnAfterCheckPurchaseReleaseRestrictions', '', false, false)]
    local procedure OnCodeOnAfterCheckPurchaseReleaseRestrictions(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PurchaseLine: Record "Purchase Line";
        Text008: label 'ENU=Qc is not checked for Item %1';
    begin

        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETFILTER(Type, '%1', PurchaseLine.Type::Item);
        IF PurchaseLine.FINDFIRST THEN
            IF PurchaseLine."QC Enabled" = FALSE THEN
                ERROR(Text008, PurchaseLine."No.");
    end;
    //<<Codeunit415clos>>





    //<<Codeunit415opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', false, false)]
    local procedure OnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    begin
        //B2B
        PurchaseHeader."Release Date Time" := CURRENTDATETIME;
        //B2B
        PurchaseHeader."Released By" := USERID;

        // Added by Pranavi on 11-Feb-2017
        IF PurchaseHeader."First Release DateTime" = 0DT THEN
            PurchaseHeader."First Release DateTime" := CURRENTDATETIME;
        IF PurchaseHeader."First Release By" = '' THEN
            PurchaseHeader."First Release By" := USERID;

        // End by Pranavi on 11-Feb-2017
    end;

    //<<Codeunit415clos<<




    //<<Codeunit1252opn>>
    PROCEDURE MatchManuallyREverse(VAR SelectedBankAccReconciliationLine: Record 274; VAR SelectedBankAccountLedgerEntry: Record 271);
    VAR
        BankAccReconciliationLine: Record 274;
        BankAccountLedgerEntry: Record 271;
        BankAccEntrySetReconNo: Codeunit 375;
        Relation: Option "One-to-One","One-to-Many";
    BEGIN

        IF SelectedBankAccReconciliationLine.FINDFIRST THEN BEGIN
            BankAccReconciliationLine.GET(
              SelectedBankAccReconciliationLine."Statement Type",
              SelectedBankAccReconciliationLine."Bank Account No.",
              SelectedBankAccReconciliationLine."Statement No.",
              SelectedBankAccReconciliationLine."Statement Line No.");
            IF BankAccReconciliationLine.Type <> BankAccReconciliationLine.Type::"Bank Account Ledger Entry" THEN
                EXIT;

            IF SelectedBankAccountLedgerEntry.FINDSET THEN BEGIN
                REPEAT
                    BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
                    //BankAccEntrySetReconNo.RemoveApplication(BankAccountLedgerEntry);
                    ApplyEntriesReverse(BankAccReconciliationLine, BankAccountLedgerEntry, Relation::"One-to-Many");
                UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
            END;
        END;
    END;


    PROCEDURE RemoveMatchReverse(VAR SelectedBankAccReconciliationLine: Record 274; VAR SelectedBankAccountLedgerEntry: Record 271);
    VAR
        BankAccReconciliationLine: Record 274;
        BankAccountLedgerEntry: Record 271;
        BankAccEntrySetReconNo: Codeunit 375;
    BEGIN
        /*{
        IF SelectedBankAccReconciliationLine.FINDSET THEN
              REPEAT
                  BankAccReconciliationLine.GET(
                    SelectedBankAccReconciliationLine."Statement Type",
                    SelectedBankAccReconciliationLine."Bank Account No.",
                    SelectedBankAccReconciliationLine."Statement No.",
                    SelectedBankAccReconciliationLine."Statement Line No.");
                  BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccReconciliationLine."Bank Account No.");
                  BankAccountLedgerEntry.SETRANGE("Statement No.", BankAccReconciliationLine."Statement No.");
                  BankAccountLedgerEntry.SETRANGE("Statement Line No.", BankAccReconciliationLine."Statement Line No.");
                  BankAccountLedgerEntry.SETRANGE(Open, TRUE);
                  BankAccountLedgerEntry.SETRANGE("Statement Status", BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
                  IF BankAccountLedgerEntry.FINDSET THEN
                      REPEAT
                          BankAccEntrySetReconNo.RemoveApplicationReverse(BankAccountLedgerEntry);
                      UNTIL BankAccountLedgerEntry.NEXT = 0;
              UNTIL SelectedBankAccReconciliationLine.NEXT = 0;
        }*/
        IF SelectedBankAccountLedgerEntry.FINDSET THEN
            REPEAT
                BankAccountLedgerEntry.GET(SelectedBankAccountLedgerEntry."Entry No.");
                RemoveApplicationReverse(BankAccountLedgerEntry);
            UNTIL SelectedBankAccountLedgerEntry.NEXT = 0;
    END;

    PROCEDURE RemoveMatchReverseSingle(VAR SelectedBankAccReconciliationLine: Record 274; VAR SelectedBankAccountLedgerEntry: Record 271);
    VAR
        BankAccReconciliationLine: Record 274;
        BankAccountLedgerEntry: Record 271;
        BankAccEntrySetReconNo: Codeunit 375;
    BEGIN
        IF SelectedBankAccReconciliationLine.FINDFIRST THEN
            //REPEAT
            BankAccReconciliationLine.GET(
            SelectedBankAccReconciliationLine."Statement Type",
            SelectedBankAccReconciliationLine."Bank Account No.",
            SelectedBankAccReconciliationLine."Statement No.",
            SelectedBankAccReconciliationLine."Statement Line No.");
        BankAccountLedgerEntry.SETRANGE("Bank Account No.", BankAccReconciliationLine."Bank Account No.");
        BankAccountLedgerEntry.SETRANGE("Statement No.", BankAccReconciliationLine."Statement No.");
        BankAccountLedgerEntry.SETRANGE("Entry No.", SelectedBankAccReconciliationLine."Bank Acc LE");
        //BankAccountLedgerEntry.SETRANGE("Statement Line No.",BankAccReconciliationLine."Statement Line No.");
        BankAccountLedgerEntry.SETRANGE(Open, TRUE);
        BankAccountLedgerEntry.SETRANGE("Statement Status", BankAccountLedgerEntry."Statement Status"::"Bank Acc. Entry Applied");
        IF BankAccountLedgerEntry.FINDFIRST THEN
            RemoveApplicationReverseSingle(BankAccountLedgerEntry, BankAccReconciliationLine);
        // UNTIL SelectedBankAccReconciliationLine.NEXT = 0;


    END;

    //<<Codeunit1252clos<<









    //<<Codeunit5063opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesHeaderArchiveInsert', '', false, false)]
    local procedure OnBeforeSalesHeaderArchiveInsert(var SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header")
    var
        TH: Record "Tender Header";
        tempvar: Text;
    begin
        //added by pranavi on 31-03-2015
        tempvar := '';
        BG.RESET;
        BG.SETCURRENTKEY("BG No.");
        BG.SETFILTER(BG."Doc No.", SalesHeader."No.");
        IF BG.FINDFIRST THEN BEGIN
            SalesHeaderArchive."BG Amount" := BG."BG Value";
            SalesHeaderArchive."BG Date of Issue" := BG."Date of Issue";
            SalesHeaderArchive."BG Expiry Date" := BG."Expiry Date";
            //MESSAGE(FORMAT(SHA."BG Amount"));
            TH.RESET;
            TH.SETCURRENTKEY("Tender No.");
            TH.SETFILTER(TH."Tender No.", BG."Tender No.");
            IF TH.FINDFIRST THEN BEGIN
                SalesHeaderArchive."EMD Amount" := TH."EMD Amount";
                //MESSAGE(FORMAT(SHA."EMD Amount"));
            END;
        END;
        IF FORMAT(SalesHeader."Warranty Period") <> '' THEN BEGIN
            tempvar := '+' + FORMAT(SalesHeader."Warranty Period");
            SalesHeaderArchive."Warranty Exp Date" := CALCDATE(tempvar, WORKDATE);
        END;
        //end by pranavi
    end;
    //<<Codeunit5063clos<<

    //<<Codeunit5063opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterSalesHeaderArchiveInsert', '', false, false)]
    local procedure OnAfterSalesHeaderArchiveInsert(var SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header")
    var
        CustomerContactDataArchive: Record 14125606;
        CustomerContactData: RECORD "Customer/Contact Data";
    begin
        // B2B
        StoreSalesESPLAttachments(SalesHeader, DATABASE::"Sales Header");
        // B2B
        //B2BJM >>

        CustomerContactData.RESET;
        CustomerContactData.SETRANGE("Sales Quote No.", SalesHeader."No.");
        IF CustomerContactData.FINDSET THEN
            REPEAT
                CustomerContactDataArchive.INIT;
                CustomerContactDataArchive.TRANSFERFIELDS(CustomerContactData);
                CustomerContactDataArchive."Version No." := SalesHeaderArchive."Version No.";
                CustomerContactDataArchive.INSERT;
            UNTIL CustomerContactData.NEXT = 0;

        //B2bJM <<

    end;
    //<<Codeunit5063clos<<


    //<<Codeunit5063opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterPurchHeaderArchiveInsert', '', false, false)]
    local procedure OnAfterPurchHeaderArchiveInsert(var PurchaseHeaderArchive: Record "Purchase Header Archive"; PurchaseHeader: Record "Purchase Header")
    begin
        // B2B
        StorePurchaseESPLAttachments(PurchaseHeader, DATABASE::"Purchase Header");
        // B2B
    end;

    PROCEDURE StorePurchaseESPLAttachments(VAR PurchHeader: Record 38; TableId: Option);
    VAR
        Attachment: Record 60098;
        TableName: Text[100];
        AttachmentArchive: Record 60099;
        PurchHeader1: Record 38;
    BEGIN
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableId);
        Attachment.SETRANGE("Document No.", PurchHeader."No.");
        Attachment.SETRANGE("Document Type", PurchHeader."Document Type");
        IF Attachment.FINDSET THEN
            REPEAT
                Attachment.CALCFIELDS(FileAttachment);
                AttachmentArchive.TRANSFERFIELDS(Attachment);
                PurchHeader1 := PurchHeader;
                AttachmentArchive."Document Version No." := PurchHeader1."No. of Archived Versions" + 1;
                AttachmentArchive.INSERT;
            UNTIL Attachment.NEXT = 0;
    END;

    //<<Codeunit5063clos<<

    //<<Codeunit5063opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnGetNextOccurrenceNo', '', false, false)]
    local procedure OnGetNextOccurrenceNo1(TableId: Integer; DocType: Option; DocNo: Code[20]; var OccurenceNo: Integer)
    var
        ServiceHeaderArchive: RECORD "Sales Header Archive";
    begin
        //B2B
        if TableId = DATABASE::"Service Header" then BEGIN
            ServiceHeaderArchive.LOCKTABLE;
            ServiceHeaderArchive.SETRANGE("Document Type", DocType);
            ServiceHeaderArchive.SETRANGE("No.", DocNo);
            IF ServiceHeaderArchive.FINDLAST THEN
                OccurenceNo := (ServiceHeaderArchive."Doc. No. Occurrence" + 1)
            ELSE
                OccurenceNo := 1;
        END;
        //B2B
    end;
    //<<Codeunit5063clos<<


    //<<Codeunit5063opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnGetNextVersionNo', '', false, false)]
    local procedure OnGetNextVersionNo1(TableId: Integer; DocType: Option; DocNo: Code[20]; DocNoOccurrence: Integer; var VersionNo: Integer)
    var
        ServiceHeaderArchive: Record 60015;
    begin

        //B2B
        if TableId = DATABASE::"Service Header" then BEGIN
            ServiceHeaderArchive.LOCKTABLE;
            ServiceHeaderArchive.SETRANGE("Document Type", DocType);
            ServiceHeaderArchive.SETRANGE("No.", DocNo);
            ServiceHeaderArchive.SETRANGE("Doc. No. Occurrence", DocNoOccurrence);
            IF ServiceHeaderArchive.FINDLAST THEN
                VersionNo := (ServiceHeaderArchive."Version No." + 1)
            ELSE
                VersionNo := 1;
        END;
    end;
    //<<Codeunit5063clos<<


    //<<Codeunit5406opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Output Jnl.-Expl. Route", 'OnBeforeOutputItemJnlLineInsert', '', false, false)]
    local procedure OnBeforeOutputItemJnlLineInsert(var ItemJournalLine: Record "Item Journal Line"; LastOperation: Boolean)
    var
        ProdOrderRtngLine: Record 5409;
    begin
        //B2B
        ItemJournalLine."Operation Description" := ProdOrderRtngLine."Operation Description";
        ItemJournalLine."Planed Setup Time" := ProdOrderRtngLine."Setup Time";
        ItemJournalLine."Planed Run Time" := ProdOrderRtngLine."Run Time";
        ItemJournalLine."Planed Wait Time" := ProdOrderRtngLine."Wait Time";
        ItemJournalLine."Planed Move Time" := ProdOrderRtngLine."Move Time";
        //B2B
    end;


    PROCEDURE TobePosted_SemiProducts(Rec: Record 83; InputDate: Text);
    VAR
        ProdOrderLine: Record 5406;
        ProdOrderRtngLine: Record 5409;
        ItemJnlLine: Record 83;
        CostCalcMgt: Codeunit 5836;
        ItemJnlLineReserve: Codeunit 99000835;
        NextLineNo: Integer;
        LineSpacing: Integer;
        BaseQtyToPost: Decimal;
        PO: Record "Production Order";
        LastItemJnlLine: Record "Item Journal Line";
    BEGIN


        ProdOrderRtngLine.SETRANGE(Status, ProdOrderRtngLine.Status::Released);
        //ProdOrderRtngLine.SETRANGE("Prod. Order No.",'SEJ17MIN0008');//,'SEJ17MIN0012');
        ProdOrderRtngLine.SETRANGE("Operation No.", '9999');
        ProdOrderRtngLine.SETFILTER("Routing Status", '<> %1', ProdOrderRtngLine."Routing Status"::Finished);
        ProdOrderRtngLine.SETRANGE("Flushing Method", ProdOrderRtngLine."Flushing Method"::Manual);
        ProdOrderRtngLine.SETCURRENTKEY(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");

        // Clear fields in xRec to ensure that validation code regarding dimensions is executed:
        /* {"Order Line No." := 0;
         "Item No." := '';
         "Routing Reference No." := 0;
         "Routing No." := '';}*/


        ItemJnlLine := Rec;

        ItemJnlLine.SETRANGE(
          "Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SETRANGE(
          "Journal Batch Name", Rec."Journal Batch Name");

        IF ItemJnlLine.FIND('>') THEN BEGIN
            LineSpacing :=
              (ItemJnlLine."Line No." - Rec."Line No.") DIV
              (1 + ProdOrderLine.COUNT * ProdOrderRtngLine.COUNT);
            IF LineSpacing = 0 THEN
                ERROR(Text000);
        END ELSE
            LineSpacing := 10000;

        NextLineNo := Rec."Line No.";

        PO.RESET;
        PO.SETRANGE(Status, PO.Status::Released);
        PO.SETFILTER("Prod Start date", InputDate);
        IF PO.FINDFIRST THEN
            REPEAT
                ProdOrderLine.RESET;
                ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Released);
                //ProdOrderLine.SETRANGE("Prod. Order No.",'SEJ17MIN0001','SEJ17MIN0025');
                //ProdOrderLine.SETRANGE("Due Date",DMY2DATE(21,2,2018));
                //ProdOrderLine.SETFILTER("Due Date",InputDate);
                ProdOrderLine.SETRANGE("Prod. Order No.", PO."No.");
                ProdOrderLine.SETFILTER("Remaining Quantity", '>%1', 0);


                ProdOrderLine.SETASCENDING("Prod. Order No.", TRUE);
                ProdOrderLine.SETASCENDING("Line No.", TRUE);
                ProdOrderLine.SETCURRENTKEY(Status, "Prod. Order No.", "Line No.");
                IF ProdOrderLine.FINDSET THEN
                    REPEAT
                        ProdOrderRtngLine.SETCURRENTKEY(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.");
                        ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                        ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                        ProdOrderRtngLine.SETRANGE("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                        IF ProdOrderRtngLine.FINDSET THEN BEGIN
                            REPEAT
                                BaseQtyToPost :=
                                  CostCalcMgt.CalcQtyAdjdForRoutingScrap(
                                    ProdOrderLine."Quantity (Base)",
                                    ProdOrderRtngLine."Scrap Factor % (Accumulated)",
                                    ProdOrderRtngLine."Fixed Scrap Qty. (Accum.)") -
                                  CostCalcMgt.CalcActOutputQtyBase(ProdOrderLine, ProdOrderRtngLine);
                                IF BaseQtyToPost > 0 THEN BEGIN
                                    Rec."Order No." := ProdOrderRtngLine."Prod. Order No.";
                                    InsertOutputJnlLine(
                                      Rec, NextLineNo, LineSpacing,
                                      ProdOrderLine."Line No.",
                                      ProdOrderLine."Item No.",
                                      ProdOrderLine."Variant Code",
                                      ProdOrderLine."Location Code",
                                      ProdOrderLine."Bin Code",
                                      ProdOrderLine."Routing No.", ProdOrderLine."Routing Reference No.",
                                      ProdOrderRtngLine."Operation No.",
                                      ProdOrderLine."Unit of Measure Code",
                                      BaseQtyToPost / ProdOrderLine."Qty. per Unit of Measure",
                                      (ProdOrderRtngLine."Next Operation No." = ''),
                                      ProdOrderRtngLine);//b2B argument added
                                    IF ProdOrderRtngLine."Next Operation No." = '' THEN
                                        ItemTrackingMgt.CopyItemTracking(ProdOrderLine.RowID1, LastItemJnlLine.RowID1, FALSE);
                                END;
                            UNTIL ProdOrderRtngLine.NEXT = 0;
                        END ELSE
                            IF ProdOrderLine."Remaining Quantity" > 0 THEN BEGIN
                                Rec."Order No." := ProdOrderLine."Prod. Order No.";
                                InsertOutputJnlLine(
                                  Rec, NextLineNo, LineSpacing,
                                  ProdOrderLine."Line No.",
                                  ProdOrderLine."Item No.",
                                  ProdOrderLine."Variant Code",
                                  ProdOrderLine."Location Code",
                                  ProdOrderLine."Bin Code",
                                  ProdOrderLine."Routing No.", ProdOrderLine."Routing Reference No.", '',
                                  ProdOrderLine."Unit of Measure Code",
                                  ProdOrderLine."Remaining Quantity",
                                  TRUE, ProdOrderRtngLine);//b2B argument added
                                ItemTrackingMgt.CopyItemTracking(ProdOrderLine.RowID1, LastItemJnlLine.RowID1, FALSE);
                            END;
                    UNTIL ProdOrderLine.NEXT = 0;
            UNTIL PO.NEXT = 0;
    END;





    LOCAL PROCEDURE InsertOutputJnlLine(ItemJnlLine: Record 83; VAR NextLineNo: Integer; LineSpacing: Integer; ProdOrderLineNo: Integer; ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; BinCode: Code[20]; RoutingNo: Code[20]; RoutingRefNo: Integer; OperationNo: Code[10]; UnitOfMeasureCode: Code[10]; QtyToPost: Decimal; LastOperation: Boolean; ProdOrderRtngLine: Record 5409);
    VAR
        DimMgt: Codeunit 408;
        LastItemJnlLine: Record "Item Journal Line";
    BEGIN
        NextLineNo := NextLineNo + LineSpacing;

        ItemJnlLine."Line No." := NextLineNo;
        ItemJnlLine.VALIDATE("Entry Type", ItemJnlLine."Entry Type"::Output);
        ItemJnlLine.VALIDATE("Order Line No.", ProdOrderLineNo);
        ItemJnlLine.VALIDATE("Item No.", ItemNo);
        ItemJnlLine.VALIDATE("Variant Code", VariantCode);
        ItemJnlLine.VALIDATE("Location Code", LocationCode);
        IF BinCode <> '' THEN
            ItemJnlLine.VALIDATE("Bin Code", BinCode);
        ItemJnlLine.VALIDATE("Routing No.", RoutingNo);
        ItemJnlLine.VALIDATE("Routing Reference No.", RoutingRefNo);
        ItemJnlLine.VALIDATE("Operation No.", OperationNo);
        //B2B
        ItemJnlLine."Operation Description" := ProdOrderRtngLine."Operation Description";
        ItemJnlLine."Planed Setup Time" := ProdOrderRtngLine."Setup Time";
        ItemJnlLine."Planed Run Time" := ProdOrderRtngLine."Run Time";
        ItemJnlLine."Planed Wait Time" := ProdOrderRtngLine."Wait Time";
        ItemJnlLine."Planed Move Time" := ProdOrderRtngLine."Move Time";
        //B2B
        ItemJnlLine.VALIDATE("Unit of Measure Code", UnitOfMeasureCode);
        ItemJnlLine.VALIDATE("Setup Time", 0);
        ItemJnlLine.VALIDATE("Run Time", 0);
        IF (LocationCode <> '') AND LastOperation THEN
            ItemJnlLine.CheckWhse(LocationCode, QtyToPost);
        IF ItemJnlLine.SubcontractingWorkCenterUsed THEN
            ItemJnlLine.VALIDATE("Output Quantity", 0)
        ELSE
            ItemJnlLine.VALIDATE("Output Quantity", QtyToPost);

        DimMgt.UpdateGlobalDimFromDimSetID(
          ItemJnlLine."Dimension Set ID", ItemJnlLine."Shortcut Dimension 1 Code", ItemJnlLine."Shortcut Dimension 2 Code");
        ItemJnlLine.INSERT;

        LastItemJnlLine := ItemJnlLine;
    END;


    //<<Codeunit5406clos<<


    //<<Codeunit5407opn>>
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnBeforeShowStatusMessage', '', false, false)]
     local procedure OnBeforeShowStatusMessage(ProdOrder: Record "Production Order"; ToProdOrder: Record "Production Order"; var IsHandled: Boolean)
     begin

         // OMS Integration
         IF (NewStatus = NewStatus::Released) AND (Rec.Status = Rec.Status::Planned) THEN BEGIN
             OMSIntegration.RPOUpdationinOMS(Rec);
         END;
         // OMS Integration

         //PRM Integration
         IF (NewStatus = NewStatus::Released) THEN BEGIN
             PRMIntegration.ProdOrdRefresh("No.");
         END;

         //PRM Integration
     end;*/
    //<<Codeunit5407clos<<

    //<<Codeunit5407opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnTransProdOrderOnBeforeToProdOrderInsert', '', false, false)]
    local procedure OnTransProdOrderOnBeforeToProdOrderInsert(var ToProdOrder: Record "Production Order"; FromProdOrder: Record "Production Order"; NewPostingDate: Date)
    var
        PRMIntegration: Codeunit 60021;

    begin
        //B2B
        IF FromProdOrder.Status = FromProdOrder.Status::"Firm Planned" THEN BEGIN
            ToProdOrder."No." := FromProdOrder."No.";
            ToProdOrder.Status := ToProdOrder.Status::Released;
        END;
        //B2B
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnAfterChangeStatusOnProdOrder', '', false, false)]
    local procedure OnAfterChangeStatusOnProdOrdercust(var ProdOrder: Record "Production Order"; var ToProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status"; NewPostingDate: Date; NewUpdateUnitCost: Boolean; var SuppressCommit: Boolean)
    begin
        IF NewStatus = NewStatus::Released THEN BEGIN
            ProdOrder.Refreshdate := TODAY;
            ProdOrder.MODIFY;
        END;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnCheckMissingOutput', '', false, false)]
    local procedure OnCheckMissingOutputcust(var ProductionOrder: Record "Production Order"; var ProdOrderLine: Record "Prod. Order Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var ShowWarning: Boolean)
    var
        Item: Record Item;
    begin
        if ProdOrderLine.FindSet() then begin
            repeat

                IF Item.GET(ProdOrderLine."Item No.") THEN
                    IF (Item."Product Group Code Cust" = 'CPCB') OR (Item."Product Group Code Cust" = 'FPRODUCT') THEN BEGIN
                        ERROR('Please Consume the Compounds in :' + ProdOrderLine."Prod. Order No.");
                    END;
            until ProdOrderLine.Next() = 0;
        end;

    end;
    //<<Codeunit5407clos<<


    //<<Codeunit5708opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Transfer Document", 'OnAfterReleaseTransferDoc', '', false, false)]
    local procedure OnAfterReleaseTransferDocCUST(var TransferHeader: Record "Transfer Header")
    begin
        //B2B
        IF (TransferHeader."Released Date" = 0D) AND (TransferHeader.Status = TransferHeader.Status::Released) THEN BEGIN
            TransferHeader."Released Date" := WORKDATE;
            TransferHeader."Released By" := USERID;
            TransferHeader."Released Time" := TIME;
        END;
        //B2B
    end;
    //<<Codeunit5708clos<<

    //<<Codeunit5510opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnInsertConsumptionJnlLineOnBeforeCheck', '', false, false)]
    local procedure OnInsertConsumptionJnlLineOnBeforeCheck(ProdOrderComponent: Record "Prod. Order Component"; ProdOrderLine: Record "Prod. Order Line"; Item: Record Item; var IsHandled: Boolean)
    var
        UOMMgt: Codeunit 5402;
        UnitOfMeasConv: Decimal;
        UMC: Record 5407;
    begin
        UnitOfMeasConv := UOMMgt.GetQtyPerUnitOfMeasure(Item, UMC."Unit of Measure Code");

    end;
    //<<Codeunit5510clos<<


    //<<Codeunit5510opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Production Journal Mgt", 'OnInsertConsumptionJnlLineOnAfterItemJnlLineInit', '', false, false)]

    local procedure OnInsertConsumptionJnlLineOnAfterItemJnlLineInit(var ItemJournalLine: Record "Item Journal Line"; ItemJournalTemplate: Record "Item Journal Template"; ItemJournalBatch: Record "Item Journal Batch")

    VAR
        ProdOrderLine: record "Prod. Order Line";
    begin
        //start 00.ajay
        ItemJournalLine."Document No." := ProdOrderLine."Prod. Order No.";
        //stop 00.ajay
    end;
    //<<Codeunit5510clos<<




    //<<Codeunit5704opn>>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterTransferOrderPostShipment', '', false, false)]
    local procedure OnAfterTransferOrderPostShipmentcust(var TransferHeader: Record "Transfer Header"; CommitIsSuppressed: Boolean; var TransferShipmentHeader: Record "Transfer Shipment Header")
    var
        TransShptHeader: Record 5744;
        POSTEDINVOICE: Record "Sales Invoice Header";
        temp: Integer;
        temp1: Integer;
        Fyear: Integer;
        TH: Record 5740;
        Sal_doc: Text;
        TO_doc: Text;

    begin
        // Added by Rakesh for Ext.Doc no Transfer Order on 6-Mar-15
        IF DATE2DMY(TH."Posting Date", 2) <= 3 THEN
            Fyear := DATE2DMY(TH."Posting Date", 3) - 1
        ELSE
            Fyear := DATE2DMY(TH."Posting Date", 3);

        // Finding the last Ext Doc no in Sales invoices.
        temp := 0;
        temp1 := 0;
        POSTEDINVOICE.RESET;
        POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
        POSTEDINVOICE.ASCENDING;
        POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));
        POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", '0..9999');
        IF POSTEDINVOICE.FINDLAST THEN BEGIN
            Sal_doc := '0';
            Sal_doc := POSTEDINVOICE."External Document No.";
            temp := 1;
        END;

        // Finding the last Ext Doc no in Transfer orders.
        TransShptHeader.RESET;
        TransShptHeader.SETCURRENTKEY(TransShptHeader."External Document No.");
        TransShptHeader.ASCENDING;
        TransShptHeader.SETRANGE(TransShptHeader."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));
        TransShptHeader.SETFILTER(TransShptHeader."External Document No.", '0..9999');
        IF TransShptHeader.FINDLAST THEN BEGIN
            TO_doc := '0';
            TO_doc := TransShptHeader."External Document No.";
            temp1 := 1;
        END;

        IF (temp = 0) AND (temp1 = 0) THEN
            TH."External Document No." := '0001'
        ELSE
            IF Sal_doc > TO_doc THEN
                TH."External Document No." := INCSTR(Sal_doc)
            ELSE
                TH."External Document No." := INCSTR(TO_doc);
        TH.MODIFY();


        // End by Rakesh on 6-Mar-15
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeTransferOrderPostShipment', '', false, false)]
    local procedure OnBeforeTransferOrderPostShipment(var TransferHeader: Record "Transfer Header"; var CommitIsSuppressed: Boolean)
    begin
        //B2B
        QualityCheckInspect(TransferHeader);
        //B2B
    end;

    //<<Codeunit5704clos<<


    //<<Codeunit5704opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptLine', '', false, false)]
    local procedure OnAfterInsertTransShptLine(var TransShptLine: Record "Transfer Shipment Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; TransShptHeader: Record "Transfer Shipment Header")

    begin
        //B2B
        TransShptLine."Transfer Order Line No." := TransLine."Line No.";
        TransShptLine."Spec ID" := TransLine."Spec ID";
        TransLine.CALCFIELDS(TransLine."Quantity Accepted");
        TransShptLine."Quantity Accepted" := TransLine."Quantity Accepted";
        TransLine.CALCFIELDS(TransLine."Quantity Rejected");
        TransShptLine."Quantity Rejected" := TransLine."Quantity Rejected";
        TransShptLine."QC Enabled" := TransLine."QC Enabled";
        TransShptLine."Qty. Sending To Quality" := TransLine."Qty. Sending To Quality";
        TransShptLine."Qty. Sent To Quality" := TransLine."Qty. Sent To Quality";
        TransShptLine."Qty. Sending To Quality(R)" := TransLine."Qty. Sending To Quality(R)";
        TransShptLine."Spec Version" := TransLine."Spec Version";
        TransShptLine."Type of Material" := TransLine."Type of Material";
        TransShptLine."Prod. Order Comp. Line No." := TransLine."Prod. Order Comp. Line No.";
        //B2B
    end;




    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeCheckWarehouse', '', false, false)]
    local procedure OnBeforeCheckWarehouse(TransLine: Record "Transfer Line"; var IsHandled: Boolean)
    begin
        //TransLine.COPY(TransLine); commented
        TransLine.SETRANGE("Document No.", TransLine."Document No.");
        TransLine.SETRANGE("Line No.", TransLine."Line No.");
    end;

    //<<Codeunit15704clos<<

    //<<Codeunit5704opn>>
    PROCEDURE "--QC1--"();
    BEGIN
    END;

    /* PROCEDURE QualityCheckInspect(TransferHeader: Record 5740);
     VAR
         TransferLine: Record 5741;
         Text33000250: Label 'ENU=You cannot Ship more than quality accepted quantity in Transfer Order %1 and Line No. %2.';
         Location: Record 14;
     BEGIN
         Location.GET(TransferHeader."Transfer-to Code");
         IF Location."QC Enabled Location" THEN BEGIN
             TransferLine.SETRANGE("Document No.", TransferHeader."No.");
             TransferLine.SETFILTER("QC Enabled", 'YES');
             IF TransferLine.FINDFIRST THEN
                 TransferLine.CALCFIELDS("Quantity Accepted", TransferLine."Quantity Rejected");
             IF (TransferLine."Quantity Accepted" +
                   TransferLine."Quantity Rejected") < TransferLine."Qty. to Ship" + TransferLine."Quantity Shipped" THEN
                 ERROR(Text33000250, TransferLine."Document No.", TransferLine."Line No.");
             EXIT;
         end;
     end;*/
    //<<Codeunit5704clos<<




    //<<Codeunit5705opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnAfterInsertTransRcptHeader', '', false, false)]

    local procedure OnAfterInsertTransRcptHeader(var TransRcptHeader: Record "Transfer Receipt Header"; var TransHeader: Record "Transfer Header")
    begin
        //B2B
        TransRcptHeader."Prod. Order No." := TransHeader."Prod. Order No.";
        TransRcptHeader."Prod. Order Line No." := TransHeader."Prod. Order Line No.";
        TransRcptHeader."Service Item No." := TransHeader."Service Item No.";
        TransRcptHeader."Customer No." := TransHeader."Customer No.";
        TransRcptHeader."Prod. BOM No." := TransHeader."Prod. BOM No.";
        TransRcptHeader."Resource Name" := TransHeader."Resource Name";
        TransRcptHeader."User ID" := TransHeader."User ID";
        TransRcptHeader."Required Date" := TransHeader."Required Date";
        TransRcptHeader."Operation No." := TransHeader."Operation No.";
        TransRcptHeader."Due Date" := TransHeader."Due Date";
        TransRcptHeader."Sales Order No." := TransHeader."Sales Order No.";
        TransRcptHeader."Service Order No." := TransHeader."Service Order No.";
        //B2B 
    end;

    //<<Codeunit5705clos<<




    //<<Codeunit5705opn>>.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeInsertTransRcptLine', '', false, false)]
    local procedure OnBeforeInsertTransRcptLine(var TransRcptLine: Record "Transfer Receipt Line"; TransLine: Record "Transfer Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean; TransferReceiptHeader: Record "Transfer Receipt Header")
    begin
        TransRcptLine."Spec ID" := TransLine."Spec ID";
        TransLine.CALCFIELDS(TransLine."Quantity Accepted", TransLine."Quantity Rejected");//UPGREV2.0
        TransRcptLine."Quantity Accepted" := TransLine."Quantity Accepted";
        //TransLine.CALCFIELDS(TransLine."Quantity Rejected");//UPGREV2.0
        TransRcptLine."Quantity Rejected" := TransLine."Quantity Rejected";
        TransRcptLine."QC Enabled" := TransLine."QC Enabled";
        TransRcptLine."Qty. Sending To Quality" := TransLine."Qty. Sending To Quality";
        TransRcptLine."Qty. Sent To Quality" := TransLine."Qty. Sent To Quality";
        TransRcptLine."Qty. Sending To Quality(R)" := TransLine."Qty. Sending To Quality(R)";
        TransRcptLine."Spec Version" := TransLine."Spec Version";
        //B2B-ESPL
    end;
    //<<Codeunit5705clos<<



    //<<Codeunit5705opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    begin
        //B2B-Rasool
        ItemJournalLine."ITL Doc No." := TransferLine."Prod. Order No.";
        ItemJournalLine."ITL Doc Line No." := TransferLine."Prod. Order Line No.";
        ItemJournalLine."ITL Doc Ref Line No." := TransferLine."Prod. Order Comp. Line No.";
        //B2B
    end;
    //<<Codeunit5705clos<<



    //<<Codeunit58213opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        /*IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);


        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);
        //B2B
        "G|l".GET;
        IF "G|l"."Active ERP-CF Connection" THEN BEGIN
            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;


            SQLConnection.ConnectionString := "G|l"."Sql Connection String";
            SQLConnection.Open;

            SQLConnection.BeginTrans;
            //B2B
        END;*/
    end;

    //<<Codeunit5813clos<<


    //<<Codeunit5813opn>>
    /*  [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforePurchRcptLineModify', '', false, false)]
      local procedure OnBeforePurchRcptLineModify(var PurchRcptLine: Record "Purch. Rcpt. Line"; var TempWarehouseJournalLine: Record "Warehouse Journal Line" temporary)
      begin
          IF "G|l"."Active ERP-CF Connection" THEN BEGIN
              SQLQuery := 'Delete From Receipt_Line where RECEIPT_NO=''' + PurchRcptLine."Document No." + ''' and  RECEIPT_LINE_NO =' +
                           '''' + FORMAT(PurchRcptLine."Line No.") + '''';

              RecordSet := SQLConnection.Execute(SQLQuery);//B2B
          END;
      end;*/ //EffUPG SQL RELATED

    //<<Codeunit5813clos<<



    //<<Codeunit5813opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnAfterCode', '', false, false)]
    local procedure OnAfterCode(var PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        /*  IF "G|l"."Active ERP-CF Connection" THEN BEGIN
              SQLConnection.CommitTrans;
              SQLConnection.Close;//B2B
          END;*/    //sql comment
    end;
    //<<Codeunit5813clos<<



    //<<Codeunit5817opn>>
    PROCEDURE "UpdatePurchLineG/L"(PurchLine: Record 39; UndoQty: Decimal; UndoQtyBase: Decimal);
    VAR
        xPurchLine: Record 39;
        ReservePurchLine: Codeunit 99000834;
    BEGIN
        WITH PurchLine DO BEGIN
            xPurchLine := PurchLine;
            CASE "Document Type" OF
                "Document Type"::"Return Order":
                    BEGIN
                        "Return Qty. Shipped" := "Return Qty. Shipped" - UndoQty;
                        "Return Qty. Shipped (Base)" := "Return Qty. Shipped (Base)" - UndoQtyBase;
                        InitOutstanding;
                        InitQtyToShip;
                    END;
                "Document Type"::Order:
                    BEGIN
                        "Quantity Received" := "Quantity Received" - UndoQty;
                        "Qty. Received (Base)" := "Qty. Received (Base)" - UndoQtyBase;
                        InitOutstanding;
                        InitQtyToReceive;
                    END;
                ELSE
                    FIELDERROR("Document Type");
            END;
            MODIFY;
            //  RevertPostedItemTracking(TempUndoneItemLedgEntry,"Expected Receipt Date");
            xPurchLine."Quantity (Base)" := 0;
            ReservePurchLine.VerifyQuantity(PurchLine, xPurchLine);
        END;
    END;

    //<<Codeunit5817clos<<


    //<<Codeunit5836opn>>
    PROCEDURE CalcActTimeAndQtyBase2(ProdOrderLine: Record 5406; OperationNo: Code[10]; VAR ActRunTime: Decimal; VAR ActSetupTime: Decimal; VAR ActOutputQty: Decimal; VAR ActScrapQty: Decimal);
    VAR
        CapLedgEntry: Record 5832;
    BEGIN
        WITH CapLedgEntry DO BEGIN
            SETCURRENTKEY(
              "Order No.", "Order Line No.", "Routing No.", "Routing Reference No.",
              "Operation No.", "Last Output Line");
            SETRANGE("Order No.", ProdOrderLine."Prod. Order No.");
            SETRANGE("Order Line No.", ProdOrderLine."Line No.");
            SETRANGE("Routing No.", ProdOrderLine."Routing No.");
            SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
            SETRANGE("Operation No.", OperationNo);
            IF FINDSET THEN
                REPEAT
                    ActSetupTime += "Setup Time";
                    ActRunTime += "Run Time";
                    // Base Units
                    ActOutputQty += "Output Quantity";
                    ActScrapQty += "Scrap Quantity";
                UNTIL NEXT = 0;
        END;
    END;

    //<<Codeunit5836clos<<


    //<<Codeunit5920opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShpt', '', false, false)]
    local procedure OnCreateServItemOnSalesLineShpt(var ServiceItem: Record "Service Item"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line")
    var
        TrackingLinesExist: Boolean;
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        TempReservEntry: Record "Reservation Entry" temporary;
    begin
        //B2B
        ServiceItem.Description := SalesLine.Description;
        ServiceItem."Description 2" := STRSUBSTNO('%1 %2', SalesHeader."Document Type", SalesHeader."No.");

        //B2B ssr 25/09/05 Start
        ServiceItem."SO No." := SalesHeader."No.";
        ServiceItem."SO Line No." := SalesLine."Line No.";
        ServiceItem.Status := ServiceItem.Status::"Not Installed";
        //B2B ssr End
        IF TrackingLinesExist THEN BEGIN
            ServiceItem."Batch No." := TempReservEntry."Lot No.";//b2B Added
        END;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShptOnAfterAddServItemComponents', '', false, false)]
    local procedure OnCreateServItemOnSalesLineShptOnAfterAddServItemComponents(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line"; var SalesShipmentLine: Record "Sales Shipment Line"; var ServiceItem: Record "Service Item"; var TempServiceItem: Record "Service Item" temporary; var TempServiceItemComp: Record "Service Item Component" temporary)
    var
        ServItem2: Record "Service Item";
        ItemDesc: Record item;
        ServItemComponent: Record "Service Item Component";
        Item: Record Item;
        ProdOrder: Record "Production Order";
        ItemLedgEntry: Record "Item Ledger Entry";
        NextLineNo: Integer;
        BOMComponent: Record "BOM Component";
        ServMgtSetup: Record "Service Mgt. Setup";
        Index: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ServItem: Record "Service Item";

    begin
        //B2B ssr 25/09/05 Start
        IF Item.GET(SalesLine."No.") THEN
            Item.CALCFIELDS("Assembly BOM");
        IF Item."Assembly BOM" THEN BEGIN
            BOMComponent.SETRANGE("Parent Item No.", Item."No.");
            IF BOMComponent.FINDSET THEN
                REPEAT
                    FOR Index := 1 TO ROUND(BOMComponent."Quantity per", 1) DO BEGIN
                        ServItem2.INIT;
                        ServMgtSetup.TESTFIELD("Service Item Nos.");
                        ServItem2.TRANSFERFIELDS(ServItem);
                        ServItem2."No." := NoSeriesMgt.GetNextNo(ServMgtSetup."Service Item Nos.", 0D, TRUE);
                        //Serial no for this SH1.0
                        ProdOrder.RESET;
                        ProdOrder.SETRANGE(Status, ProdOrder.Status::Released);
                        ProdOrder.SETRANGE("Sales Order No.", SalesLine."Document No.");
                        ProdOrder.SETRANGE("Sales Order Line No.", SalesLine."Line No.");
                        ProdOrder.SETRANGE("Schedule Line No.");
                        ItemLedgEntry.RESET;
                        //              ItemLedgEntry.SETCURRENTKEY(ItemLedgEntry."Sales Order No",ItemLedgEntry."Sales Order Line No",
                        //                                      ItemLedgEntry."Schedule Line No");   // commented
                        ItemLedgEntry.SETRANGE("Entry Type", ItemLedgEntry."Entry Type"::Consumption);
                        //ItemLedgEntry.SETRANGE(ItemLedgEntry."Sales Order No");
                        //SH1.0
                        ServItem2.INSERT;
                        NextLineNo := NextLineNo + 10000;
                        /* {              ServItemComponent.INIT;
                                       ServItemComponent.Active := TRUE;
                                       ServItemComponent."Parent Service Item No." := ServItem."No.";
                                       ServItemComponent."Line No." := NextLineNo;
                                       ServItemComponent.Type := ServItemComponent.Type::"Service Item";
                                       ServItemComponent."No." := ServItem2."No.";
                                       ServItemComponent."Date Installed" := SalesHeader."Posting Date";
                                       ServItemComponent.Description := BOMComponent.Description;
                                       ServItemComponent."Serial No." := '';
                                       ServItemComponent."Variant Code" := BOMComponent."Variant Code";
                                       ServItemComponent.INSERT;}*/
                        ServItem2."Item No." := BOMComponent."No.";
                        ServItem2.MODIFY;
                    END;
                UNTIL BOMComponent.NEXT = 0;           // commented for the service item not to create
        END;
        //B2B ssr End
        //SH1.0

        /*{IF Y=0 THEN BEGIN
        Schedule.RESET;
        Schedule.SETRANGE("Document No.",SalesLine."Document No.");
        Schedule.SETRANGE("Document Line No.",SalesLine."Line No.");
        IF Schedule.FINDSET THEN BEGIN
          Schedule.NEXT;
          Y+=1;
          REPEAT
            CreateSerItemForScheduleItems(SalesHeader,SalesLine,SalesShipmentLine,Schedule);
          UNTIL Schedule.NEXT=0;
        END;

       END;}*/
        //SH1.0
    end;
    //<<Codeunit5920clos<<


    //<<Codeunit5920opn>>

    PROCEDURE CreateSerItemForScheduleItems(SalesHeader: Record 36; SalesLine: Record 37; SalesShipmentLine: Record 111; Schedule: Record 60095);
    VAR
        ItemTrackingCode: Record 6502;
        BOMComp: Record 90;
        BOMComp2: Record 90;
        TrackingLinesExist: Boolean;
        x: Integer;
        BOMComponent: Record 90;
        "---SH1.0--": Integer;
        Schedule2: Record 60095;
        ItemLedgerEntry: Record 32;
        SerItemLoc: Record 5940;
        ServiceItem: Record "Service Item";
        Item: Record Item;
        ServItemGr: Record "Service Item Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ServMgtSetup: Record "Service Mgt. Setup";
        ServItem2: Record "Service Item";
        ServItemComponent: Record "Service Item Component";
        NextLineNo: Integer;
        Index: Integer;
        ServLogMgt: codeunit ServLogManagement;

    BEGIN
        Schedule2 := Schedule;
        ServMgtSetup.GET;
        //MESSAGE(FORMAT(Schedule2));
        Item.GET(Schedule2."No.");
        IF NOT ItemTrackingCode.GET(Item."Item Tracking Code") THEN
            ItemTrackingCode.INIT;
        IF (ServItemGr.GET(Item."Service Item Group")) AND (ServItemGr."Create Service Item") THEN BEGIN

            FOR x := 1 TO Schedule2.Quantity DO BEGIN
                CLEAR(ServiceItem);
                ServiceItem.INIT;
                ServMgtSetup.TESTFIELD("Service Item Nos.");
                NoSeriesMgt.InitSeries(
                  ServMgtSetup."Service Item Nos.", ServiceItem."No. Series", 0D, ServiceItem."No.", ServiceItem."No. Series");
                ServiceItem."Sales/Serv. Shpt. Document No." := SalesShipmentLine."Document No.";
                ServiceItem."Sales/Serv. Shpt. Line No." := SalesShipmentLine."Line No.";
                //B2B
                ServiceItem.Description := Schedule2.Description;
                ServiceItem."Description 2" := STRSUBSTNO('%1 %2', SalesHeader."Document Type", SalesHeader."No.");
                ServiceItem.INSERT; //B2B
                                    //B2B ssr 25/09/05 Start
                ServiceItem."SO No." := SalesHeader."No.";
                ServiceItem."SO Line No." := SalesLine."Line No.";
                ServiceItem.Status := ServiceItem.Status::"Not Installed";
                //B2B ssr End
                ServiceItem.VALIDATE("Customer No.", SalesHeader."Sell-to Customer No.");
                ServiceItem.VALIDATE("Ship-to Code", SalesHeader."Ship-to Code");

                ServiceItem.VALIDATE("Item No.", ItemNo);
                //B2B- For tracking the Batch no
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETCURRENTKEY(ItemLedgerEntry."Sales Order No", ItemLedgerEntry."Sales Order Line No",
                                                ItemLedgerEntry."Schedule Line No");
                ItemLedgerEntry.SETRANGE("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SETRANGE("Sales Order No", Schedule2."Document No.");
                ItemLedgerEntry.SETRANGE("Sales Order Line No", Schedule2."Document Line No.");
                ItemLedgerEntry.SETRANGE("Schedule Line No", Schedule2."Line No.");
                IF ItemLedgerEntry.FINDSET THEN;
                REPEAT
                    SerItemLoc.RESET;
                    SerItemLoc.SETRANGE("Item No.", Schedule2."No.");
                    SerItemLoc.SETRANGE("Serial No.", ItemLedgerEntry."Serial No.");
                    SerItemLoc.SETRANGE("Batch No.", ItemLedgerEntry."Lot No.");
                    IF NOT SerItemLoc.FINDFIRST THEN BEGIN
                        ServiceItem."Serial No." := ItemLedgerEntry."Serial No.";
                        ServiceItem."Batch No." := ItemLedgerEntry."Lot No.";
                    END ELSE
                        SerItemLoc.NEXT;
                UNTIL ItemLedgerEntry.NEXT = 0;

                /* {      IF (Schedule2.Type=Schedule2.Type::Item) AND (Item.GET(Schedule2."No.")) THEN
                      IF Item."Item Tracking Code"='LOT' THEN
                         Schedule2.TESTFIELD(Schedule2."Lot No.")
                      ELSE IF Item."Item Tracking Code"='SERIAL' THEN
                         Schedule2.TESTFIELD(Schedule2."Serial No.")
                      ELSE IF Item."Item Tracking Code"='lotSERIAL' THEN BEGIN
                         Schedule2.TESTFIELD(Schedule2."Serial No.");
                         Schedule2.TESTFIELD(Schedule2."Lot No.")
                      END;

                    IF Schedule2."Serial No"=''  THEN
                      Schedule2."Serial No":=ServItem."Serial No."
                    ELSE
                      Schedule2."Serial No"+=','+ServItem."Serial No.";

                    IF Schedule2."Batch No"=''  THEN
                      Schedule2."Batch No":=ServItem."Batch No."
                    ELSE
                      Schedule2."Batch No"+=','+ServItem."Batch No.";
                     }*/
                Schedule2.MODIFY;
                //B2B

                ServiceItem."Variant Code" := SalesLine."Variant Code";
                ServiceItem.VALIDATE("Sales Unit Cost", Schedule2."Unit Cost");
                IF SalesHeader."Currency Code" <> '' THEN
                    ServiceItem.VALIDATE(
                      "Sales Unit Price",
                      AmountToLCY(
                        SalesLine."Unit Price",
                        SalesHeader."Currency Factor",
                        SalesHeader."Currency Code",
                        SalesHeader."Posting Date"))
                ELSE
                    ServiceItem.VALIDATE("Sales Unit Price", Schedule2."Estimated Unit Price");
                ServiceItem."Vendor No." := Item."Vendor No.";
                ServiceItem."Vendor Item No." := Item."Vendor Item No.";
                ServiceItem."Unit of Measure Code" := Item."Base Unit of Measure";
                ServiceItem."Sales Date" := SalesHeader."Posting Date";
                ServiceItem."Installation Date" := SalesHeader."Posting Date";
                ServiceItem."Warranty % (Parts)" := ServMgtSetup."Warranty Disc. % (Parts)";
                ServiceItem."Warranty % (Labor)" := ServMgtSetup."Warranty Disc. % (Labor)";
                ServiceItem."Warranty Starting Date (Parts)" := SalesHeader."Posting Date";
                IF FORMAT(ItemTrackingCode."Warranty Date Formula") <> '' THEN
                    ServiceItem."Warranty Ending Date (Parts)" :=
                      CALCDATE(ItemTrackingCode."Warranty Date Formula", SalesHeader."Posting Date")
                ELSE
                    ServiceItem."Warranty Ending Date (Parts)" :=
                      CALCDATE(
                        ServMgtSetup."Default Warranty Duration",
                        SalesHeader."Posting Date");
                ServiceItem."Warranty Starting Date (Labor)" := SalesHeader."Posting Date";
                ServiceItem."Warranty Ending Date (Labor)" :=
                  CALCDATE(
                    ServMgtSetup."Default Warranty Duration",
                    SalesHeader."Posting Date");
                ServiceItem.MODIFY; //b2b
                IF SalesLine."BOM Item No." <> '' THEN BEGIN
                    CLEAR(BOMComp);
                    BOMComp.SETRANGE("Parent Item No.", SalesLine."BOM Item No.");
                    BOMComp.SETRANGE(Type, BOMComp.Type::Item);
                    BOMComp.SETRANGE("No.", SalesLine."No.");
                    BOMComp.SETRANGE("Installed in Line No.", 0);
                    IF BOMComp.FINDSET THEN
                        REPEAT
                            CLEAR(BOMComp2);
                            BOMComp2.SETRANGE("Parent Item No.", SalesLine."BOM Item No.");
                            BOMComp2.SETRANGE("Installed in Line No.", BOMComp."Line No.");
                            NextLineNo := 0;
                            IF BOMComp2.FINDSET THEN
                                REPEAT
                                    FOR Index := 1 TO ROUND(BOMComp2."Quantity per", 1) DO BEGIN
                                        ServItem2.INIT;
                                        ServMgtSetup.TESTFIELD("Service Item Nos.");
                                        ServItem2.TRANSFERFIELDS(ServiceItem);
                                        ServItem2."No." := NoSeriesMgt.GetNextNo(ServMgtSetup."Service Item Nos.", 0D, TRUE);
                                        ServItem2.INSERT;
                                        NextLineNo := NextLineNo + 10000;
                                        ServItemComponent.INIT;
                                        ServItemComponent.Active := TRUE;
                                        ServItemComponent."Parent Service Item No." := ServiceItem."No.";
                                        ServItemComponent."Line No." := NextLineNo;
                                        ServItemComponent.Type := ServItemComponent.Type::Item;
                                        ServItemComponent."No." := BOMComp2."No.";
                                        ServItemComponent."Date Installed" := SalesHeader."Posting Date";
                                        ServItemComponent.Description := BOMComp2.Description;
                                        ServItemComponent."Serial No." := '';
                                        ServItemComponent."Variant Code" := BOMComp2."Variant Code";
                                        ServItemComponent.INSERT;
                                    END;
                                UNTIL BOMComp2.NEXT = 0;
                        UNTIL BOMComp.NEXT = 0;
                END;
                CLEAR(ServLogMgt);
                ServLogMgt.ServItemAutoCreated(ServiceItem);
            END;
        END;
    END;

    LOCAL PROCEDURE AmountToLCY(FCAmount: Decimal; CurrencyFactor: Decimal; CurrencyCode: Code[10]; CurrencyDate: Date): Decimal;
    VAR
        CurrExchRate: Record 330;
        Currency: Record 4;
    BEGIN
        Currency.GET(CurrencyCode);
        Currency.TESTFIELD("Unit-Amount Rounding Precision");
        EXIT(
          ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              CurrencyDate, CurrencyCode,
              FCAmount, CurrencyFactor),
            Currency."Unit-Amount Rounding Precision"));
    END;





    //<<Codeunit5920clos<<





    //<<Codeunit6620opn>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocUpdateHeaderOnBeforeUpdateCustLedgerEntry', '', false, false)]
    local procedure OnCopySalesDocUpdateHeaderOnBeforeUpdateCustLedgerEntry(var ToSalesHeader: Record "Sales Header"; FromDocType: Option; FromDocNo: Code[20])
    var
    begin
        IF FromDocType = PurchDocType::"Posted Invoice" THEN    // Condition Added by Pranavi on 23-May-2016
   BEGIN
            ToSalesHeader."Applies-to Doc. Type" := ToSalesHeader."Applies-to Doc. Type"::" ";
            ToSalesHeader."Applies-to Doc. No." := "FromDocNo";
        END
    end;
    //<<Codeunit6620clos<<









    //<<Codeunit270opn>>
    PROCEDURE TemplateSelection1(RecurringJnl: Boolean);
    VAR
        ResJnlTemplate: Record 206;
        ResJnlLine: Record 207;
        JnlSelected: Boolean;
        Text000: label 'RESOURCES';
        Text001: Label 'Resource Journals';
        Text002: Label ' RECURRING';
        Text003: Label 'Recurring Resource Journal';
        Text004: label 'DEFAULT';
        Text005: label 'Default Journal';
    BEGIN
        ;
        JnlSelected := TRUE;

        ResJnlTemplate.RESET;
        ResJnlTemplate.SETRANGE(Recurring, RecurringJnl);

        CASE ResJnlTemplate.COUNT OF
            0:
                BEGIN
                    ResJnlTemplate.INIT;
                    ResJnlTemplate.Recurring := RecurringJnl;
                    IF NOT RecurringJnl THEN BEGIN
                        ResJnlTemplate.Name := Text000;
                        ResJnlTemplate.Description := Text001;
                    END ELSE BEGIN
                        ResJnlTemplate.Name := Text002;
                        ResJnlTemplate.Description := Text003;
                    END;
                    ResJnlTemplate.VALIDATE("Page ID");
                    ResJnlTemplate.INSERT;
                    COMMIT;
                END;
            1:
                ResJnlTemplate.FINDFIRST;
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, ResJnlTemplate) = ACTION::LookupOK;
        END;
        IF JnlSelected THEN BEGIN
            ResJnlLine.FILTERGROUP := 2;
            ResJnlLine.SETRANGE("Journal Template Name", ResJnlTemplate.Name);
            ResJnlLine.FILTERGROUP := 0;
            PAGE.RUN(60210, ResJnlLine);
        END;
    END;

    PROCEDURE temp(RecurringJnl: Boolean);
    VAR
        ResJnlTemplate: Record 206;
        ResJnlLine: Record 207;
        JnlSelected: Boolean;
        Text001: Label 'Resource Journals';
        Text002: Label ' RECURRING';
        Text003: Label 'Recurring Resource Journal';
        Text004: label 'DEFAULT';
        Text005: label 'Default Journal';
    BEGIN
        JnlSelected := TRUE;

        ResJnlTemplate.RESET;
        ResJnlTemplate.SETRANGE(Recurring, RecurringJnl);

        CASE ResJnlTemplate.COUNT OF
            0:
                BEGIN
                    ResJnlTemplate.INIT;
                    ResJnlTemplate.Recurring := RecurringJnl;
                    IF NOT RecurringJnl THEN BEGIN
                        ResJnlTemplate.Name := Text000;
                        ResJnlTemplate.Description := Text001;
                    END ELSE BEGIN
                        ResJnlTemplate.Name := Text002;
                        ResJnlTemplate.Description := Text003;
                    END;
                    ResJnlTemplate.VALIDATE("Page ID");
                    ResJnlTemplate.INSERT;
                    COMMIT;
                END;
            1:
                ResJnlTemplate.FINDFIRST;
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, ResJnlTemplate) = ACTION::LookupOK;
        END;
        IF JnlSelected THEN BEGIN
            ResJnlLine.FILTERGROUP := 2;
            ResJnlLine.SETRANGE("Journal Template Name", ResJnlTemplate.Name);
            ResJnlLine.FILTERGROUP := 0;
            PAGE.RUN(ResJnlTemplate."Page ID", ResJnlLine);
        END;
    END;


    //<<Codeunit270clos<<


    //<<Codeunit370opn>>

    LOCAL PROCEDURE CloseBankAccLedgEntryReverse(BankAccReconLine: Record 274; VAR AppliedAmount: Decimal);
    var
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.RESET;
        BankAccLedgEntry.SETCURRENTKEY("Bank Account No.", Open);
        BankAccLedgEntry.SETRANGE("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry.SETRANGE("Entry No.", BankAccReconLine."Bank Acc LE");//REverse
        BankAccLedgEntry.SETRANGE(Open, TRUE);
        BankAccLedgEntry.SETRANGE(
          "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
        BankAccLedgEntry.SETRANGE("Statement No.", BankAccReconLine."Statement No.");
        //BankAccLedgEntry.SETRANGE("Statement Line No.",BankAccReconLine."Statement Line No.");
        IF BankAccLedgEntry.FIND('-') THEN
            REPEAT
                AppliedAmount += BankAccReconLine."Statement Amount";//BankAccLedgEntry."Remaining Amount";
                BankAccLedgEntry."Remaining Amount" -= BankAccReconLine."Statement Amount";
                IF BankAccLedgEntry."Remaining Amount" = 0 THEN BEGIN
                    BankAccLedgEntry.Open := FALSE;
                    BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Closed;
                END;
                //BankAccLedgEntry."Statement No." := '';//Reverse//BRS1.1
                BankAccLedgEntry.MODIFY;

                CheckLedgEntry.RESET;
                CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
                CheckLedgEntry.SETRANGE(
                  "Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
                CheckLedgEntry.SETRANGE(Open, TRUE);
                IF CheckLedgEntry.FIND('-') THEN
                    REPEAT
                        CheckLedgEntry.TESTFIELD(Open, TRUE);
                        CheckLedgEntry.TESTFIELD(
                          "Statement Status",
                          CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                        CheckLedgEntry.TESTFIELD("Statement No.", '');
                        CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                        CheckLedgEntry.Open := FALSE;
                        CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Closed;
                        CheckLedgEntry.MODIFY;
                    UNTIL CheckLedgEntry.NEXT = 0;
            UNTIL BankAccLedgEntry.NEXT = 0;
    END;


    //<<Codeunit370clos<<

    //<<Codeunit375opn>>

    PROCEDURE SetReconNoReverse(VAR BankAccLedgEntry: Record 271; VAR BankAccReconLine: Record 274);
    var
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        BankAccLedgEntry.TESTFIELD("Statement Status", BankAccLedgEntry."Statement Status"::Open);
        BankAccLedgEntry.TESTFIELD("Statement No.", '');
        BankAccLedgEntry.TESTFIELD("Statement Line No.", 0);
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" :=
          BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied";
        BankAccLedgEntry."Statement No." := BankAccReconLine."Statement No.";
        BankAccLedgEntry."Statement Line No." := BankAccReconLine."Statement Line No.";
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                CheckLedgEntry.TESTFIELD("Statement Status", CheckLedgEntry."Statement Status"::Open);
                CheckLedgEntry.TESTFIELD("Statement No.", '');
                CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                CheckLedgEntry."Statement Status" :=
                  CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied";
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    END;

    PROCEDURE ApplyEntriesReverse(VAR BankAccReconLine: Record 274; VAR BankAccLedgEntry: Record 271; Relation: Option): Boolean;
    VAR
        BankAccReconLine2: Record 274;
        AmtExceedsErr: Label 'ENU=You cann''t apply more than %1, current value is %2.';
        CheckLedgEntry: Record "Check Ledger Entry";

    BEGIN
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;
        BankAccReconLine.LOCKTABLE;
        BankAccReconLine.FIND;

        /* {
         IF BankAccLedgEntry.IsApplied THEN
           EXIT(FALSE);

         IF (Relation = Relation::"One-to-One") AND (BankAccReconLine."Applied Entries" > 0) THEN
           EXIT(FALSE);
         }*/
        BankAccReconLine.TESTFIELD(BankAccReconLine."Bank Acc LE", 0);
        BankAccReconLine.TESTFIELD(Type, BankAccReconLine.Type::"Bank Account Ledger Entry");
        //>>B2BN1.0 11Jan2019
        BankAccReconLine2.RESET;
        BankAccReconLine2.SETCURRENTKEY("Bank Acc LE");
        BankAccReconLine2.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        BankAccReconLine2.SETRANGE("Statement No.", BankAccReconLine."Statement No.");
        BankAccReconLine2.CALCSUMS("Applied Amount");
        IF ABS((BankAccReconLine2."Applied Amount" + BankAccReconLine."Statement Amount")) > ABS(BankAccLedgEntry."Remaining Amount") THEN
            ERROR(AmtExceedsErr,
              (ABS(BankAccLedgEntry."Remaining Amount") - ABS(BankAccReconLine2."Applied Amount")),
              (ABS(BankAccReconLine2."Applied Amount") + ABS(BankAccReconLine."Statement Amount")));
        //<<B2BN1.0 11Jan2019
        BankAccReconLine."Ready for Application" := TRUE;
        SetReconNoReverse(BankAccLedgEntry, BankAccReconLine);
        BankAccReconLine."Applied Amount" := BankAccReconLine."Statement Amount";
        //BankAccLedgEntry."Remaining Amount";
        BankAccReconLine."Applied Entries" := BankAccReconLine."Applied Entries" + 1;
        BankAccReconLine."Bank Acc LE" := BankAccLedgEntry."Entry No.";
        BankAccReconLine.VALIDATE("Statement Amount");
        BankAccReconLine.MODIFY;
        EXIT(TRUE);
    END;

    PROCEDURE RemoveApplicationReverse(VAR BankAccLedgEntry: Record 271);
    VAR
        BankAccReconLine: Record 274;
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;
        BankAccReconLine.LOCKTABLE;
        /*{
        IF NOT BankAccReconLine.GET(
             BankAccReconLine."Statement Type"::"Bank Reconciliation",
             BankAccLedgEntry."Bank Account No.",
             BankAccLedgEntry."Statement No.",BankAccLedgEntry."Statement Line No.")
        THEN
          EXIT;
        }*/
        BankAccReconLine.RESET;
        BankAccReconLine.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        BankAccReconLine.SETRANGE("Statement No.", BankAccLedgEntry."Statement No.");
        IF BankAccReconLine.FINDSET THEN BEGIN
            REPEAT
                BankAccReconLine."Applied Amount" -= BankAccReconLine."Statement Amount";//reverse
                BankAccReconLine."Applied Entries" := 0;//BankAccReconLine."Applied Entries" - 1;
                BankAccReconLine."Bank Acc LE" := 0;
                BankAccReconLine.VALIDATE("Statement Amount");
                BankAccReconLine.MODIFY;
            UNTIL BankAccReconLine.NEXT = 0;
            RemoveReconNoReverse(BankAccLedgEntry, BankAccReconLine, TRUE);
        END;
        //BankAccReconLine.TESTFIELD("Statement Type",BankAccReconLine."Statement Type"::"Bank Reconciliation");
        //BankAccReconLine.TESTFIELD(Type,BankAccReconLine.Type::"Bank Account Ledger Entry");
        //RemoveReconNoReverse(BankAccLedgEntry,BankAccReconLine,TRUE);
    END;


    PROCEDURE RemoveReconNoReverse(VAR BankAccLedgEntry: Record 271; VAR BankAccReconLine: Record 274; Test: Boolean);
    var
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        IF Test THEN BEGIN
            BankAccLedgEntry.TESTFIELD(
              "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
            BankAccLedgEntry.TESTFIELD("Statement No.", BankAccReconLine."Statement No.");
            //BankAccLedgEntry.TESTFIELD("Statement Line No.",BankAccReconLine."Statement Line No.");
        END;
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
        BankAccLedgEntry."Statement No." := '';
        BankAccLedgEntry."Statement Line No." := 0;
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                IF Test THEN BEGIN
                    CheckLedgEntry.TESTFIELD(
                      "Statement Status", CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    CheckLedgEntry.TESTFIELD("Statement No.", '');
                    CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                END;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Open;
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    END;

    PROCEDURE RemoveApplicationReverseSingle(VAR BankAccLedgEntry: Record 271; BankAccReconLine2: Record 274);
    VAR
        BankAccReconLine3: Record 274;
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.LOCKTABLE;
        CheckLedgEntry.LOCKTABLE;


        BankAccReconLine2.TESTFIELD("Statement Type", BankAccReconLine2."Statement Type"::"Bank Reconciliation");
        BankAccReconLine2.TESTFIELD(Type, BankAccReconLine2.Type::"Bank Account Ledger Entry");

        // verify bank account Ledger entry applied more than one entry or not >>
        BankAccReconLine3.RESET;

        BankAccReconLine3.SETRANGE("Bank Account No.", BankAccReconLine2."Bank Account No.");
        BankAccReconLine3.SETRANGE("Statement No.", BankAccReconLine2."Statement No.");
        BankAccReconLine3.SETFILTER("Statement Line No.", '<>%1', BankAccReconLine2."Statement Line No.");
        BankAccReconLine3.SETRANGE("Bank Acc LE", BankAccLedgEntry."Entry No.");
        IF NOT BankAccReconLine3.FINDFIRST THEN
            RemoveReconNoReverseSingle(BankAccLedgEntry, BankAccReconLine2, TRUE);
        // verify bank account Ledger entry applied more than one entry or not <<

        BankAccReconLine2."Applied Amount" := 0;//BankAccLedgEntry."Remaining Amount";
        BankAccReconLine2."Applied Entries" := 0;//BankAccReconLine."Applied Entries" - 1;
        BankAccReconLine2."Bank Acc LE" := 0;
        BankAccReconLine2.VALIDATE("Statement Amount");
        BankAccReconLine2.MODIFY;
    END;

    PROCEDURE RemoveReconNoReverseSingle(VAR BankAccLedgEntry: Record 271; VAR BankAccReconLine: Record 274; Test: Boolean);
    var
        CheckLedgEntry: Record "Check Ledger Entry";
    BEGIN
        BankAccLedgEntry.TESTFIELD(Open, TRUE);
        IF Test THEN BEGIN
            BankAccLedgEntry.TESTFIELD(
              "Statement Status", BankAccLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
            BankAccLedgEntry.TESTFIELD("Statement No.", BankAccReconLine."Statement No.");
            //BankAccLedgEntry.TESTFIELD("Statement Line No.",BankAccReconLine."Statement Line No.");
        END;
        BankAccLedgEntry.TESTFIELD("Bank Account No.", BankAccReconLine."Bank Account No.");
        BankAccLedgEntry."Statement Status" := BankAccLedgEntry."Statement Status"::Open;
        BankAccLedgEntry."Statement No." := '';
        BankAccLedgEntry."Statement Line No." := 0;
        BankAccLedgEntry.MODIFY;

        CheckLedgEntry.RESET;
        CheckLedgEntry.SETCURRENTKEY("Bank Account Ledger Entry No.");
        CheckLedgEntry.SETRANGE("Bank Account Ledger Entry No.", BankAccLedgEntry."Entry No.");
        CheckLedgEntry.SETRANGE(Open, TRUE);
        IF CheckLedgEntry.FIND('-') THEN
            REPEAT
                IF Test THEN BEGIN
                    CheckLedgEntry.TESTFIELD(
                      "Statement Status", CheckLedgEntry."Statement Status"::"Bank Acc. Entry Applied");
                    CheckLedgEntry.TESTFIELD("Statement No.", '');
                    CheckLedgEntry.TESTFIELD("Statement Line No.", 0);
                END;
                CheckLedgEntry."Statement Status" := CheckLedgEntry."Statement Status"::Open;
                CheckLedgEntry."Statement No." := '';
                CheckLedgEntry."Statement Line No." := 0;
                CheckLedgEntry.MODIFY;
            UNTIL CheckLedgEntry.NEXT = 0;
    END;

    //<<Codeunit375clos<<



    //<<Codeunit379opn>>


    PROCEDURE DeleteTenderLines(VAR TenderLine: Record 60063): Boolean;
    VAR
        TenderLine2: Record 60063;
    BEGIN
        TenderLine2.SETRANGE("Document No.", TenderLine."Document No.");
        //TenderLine2.SETRANGE("Attached to Line No.",TenderLine."Line No.");
        TenderLine2 := TenderLine;
        IF TenderLine2.FIND('>') THEN begin
            REPEAT
                TenderLine2.DELETE(TRUE);
            UNTIL TenderLine2.NEXT = 0;
            EXIT(TRUE);
        end;

    END;

    //<<Codeunit379clos<<




    //<<Codeunit408opn>>
    LOCAL PROCEDURE GetFilterFromDimValuesTable(VAR TempDimensionValue: Record 349 TEMPORARY; VAR DimValueFilter: Text);
    VAR
        DimensionValue: Record 349;
        RangeStartCode: Code[20];
        PreviousCode: Code[20];
        RangeStarted: Boolean;
        Finished: Boolean;
    BEGIN
        WITH TempDimensionValue DO BEGIN
            IF NOT ISTEMPORARY THEN
                EXIT;
            SETFILTER("Dimension Value Type", '%1|%2', "Dimension Value Type"::Standard, "Dimension Value Type"::Heading);
            IF FINDSET THEN BEGIN
                Finished := FALSE;
                DimensionValue.SETRANGE("Dimension Code", "Dimension Code");
                DimensionValue.FINDSET;
                DimValueFilter := '';
                REPEAT
                    IF Code = DimensionValue.Code THEN BEGIN
                        IF NOT RangeStarted THEN BEGIN
                            RangeStarted := TRUE;
                            RangeStartCode := Code;
                        END;
                        PreviousCode := Code;
                        DimensionValue.NEXT;
                        IF NEXT = 0 THEN
                            Finished := TRUE;
                    END ELSE BEGIN
                        IF RangeStarted THEN BEGIN
                            AddRangeToFilter(DimValueFilter, RangeStartCode, PreviousCode);
                            RangeStarted := FALSE;
                        END;
                        REPEAT
                            DimensionValue.NEXT;
                        UNTIL DimensionValue.Code = Code;
                    END;
                UNTIL Finished;
                IF RangeStarted THEN
                    AddRangeToFilter(DimValueFilter, RangeStartCode, PreviousCode);
            END
        END
    END;

    LOCAL PROCEDURE AddRangeToFilter(VAR DimValueFilter: Text; RangeStartCode: Code[20]; RangeEndCode: Code[20]);
    BEGIN
        IF DimValueFilter <> '' THEN BEGIN
            IF STRLEN(DimValueFilter) + 1 > MAXSTRLEN(DimValueFilter) THEN
                ERROR(OverflowDimFilterErr);
            DimValueFilter := DimValueFilter + '|';
        END;
        IF RangeStartCode = RangeEndCode THEN BEGIN
            IF STRLEN(DimValueFilter) + STRLEN(RangeStartCode) > MAXSTRLEN(DimValueFilter) THEN
                ERROR(OverflowDimFilterErr);
            DimValueFilter := DimValueFilter + RangeStartCode;
        END ELSE BEGIN
            IF STRLEN(DimValueFilter) + STRLEN(RangeStartCode) + 2 + STRLEN(RangeEndCode) > MAXSTRLEN(DimValueFilter) THEN
                ERROR(OverflowDimFilterErr);
            DimValueFilter := DimValueFilter + RangeStartCode + '..' + RangeEndCode;
        END;
    END;
    //<<Codeunit408clos<<

    // CODEUNIT 80>>   // EFFUPG1.3>>

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeUpdateBlanketOrderLine', '', false, false)]
    local procedure EXCLUDEBLANKETORDERLINEUPDATION(SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        if (SalesLine."Blanket Order No." <> '') and (SalesLine."Blanket Order Line No." <> 0) then
            IsHandled := TRUE;

    end;
    //CODEUNIT 80<<   // EFFUPG1.3<<

    //Table 36  init Record code as below
    //EFFUPG1.3>>
    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeInitRecord', '', false, false)]
    local procedure SaleAMCNoseries(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)

    var
        SalesSetup: record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        SalesSetup.GET;

        CASE SalesHeader.SaleDocType OF //EFFUPG1.5
            SalesHeader.SaleDocType::Amc:  //EFFUPG1.5
                BEGIN
                    IF SalesHeader.Trading THEN BEGIN
                        // NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos. (Trading)");
                        // NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Sales Shpt. (Trading)");
                    END ELSE BEGIN
                        NoSeriesMgt.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
                        NoSeriesMgt.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");
                    END;

                end;

        end;
        if not (SalesHeader.SaleDocType = SalesHeader.SaleDocType::Amc) then
            SalesHeader.SaleDocType := SalesHeader."Document Type";

    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnBeforeGetNoSeriesCode', '', false, false)]
    local procedure SaleAMCNumber(SalesSetup: Record "Sales & Receivables Setup"; var SalesHeader: Record "Sales Header"; var IsHandled: Boolean; var NoSeriesCode: Code[20])
    begin

        CASE SalesHeader.SaleDocType OF

            SalesHeader.SaleDocType::Amc:
                begin
                    NoSeriesCode := SalesSetup."Third Party Nos.";
                    SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                    IsHandled := true;

                end;

        END;

    end;
    //EFFUPG1.3<<




    //<<Codeunit 17<<
    LOCAL PROCEDURE GetDescriptionFieldNo(RecRef: RecordRef): Integer;
    VAR
        GLEntry: Record 17;
        CustLedgerEntry: Record 21;
        VendorLedgerEntry: Record 25;
        BankAccountLedgerEntry: Record 271;
    BEGIN
        CASE RecRef.NUMBER OF
            DATABASE::"G/L Entry":
                EXIT(GLEntry.FIELDNO(Description));
            DATABASE::"Cust. Ledger Entry":
                EXIT(CustLedgerEntry.FIELDNO(Description));
            DATABASE::"Vendor Ledger Entry":
                EXIT(VendorLedgerEntry.FIELDNO(Description));
            DATABASE::"Bank Account Ledger Entry":
                EXIT(BankAccountLedgerEntry.FIELDNO(Description));
        END;

        EXIT(0);
    END;
    //<<codeunit17 close<<

    //>>ArchiveManagcement C5063

    PROCEDURE StoreSalesESPLAttachments(VAR SalesHeader: Record 36; TableID: Option);
    VAR
        Attachment: Record 60098;
        TableName: Text[100];
        AttachmentArchive: Record 60099;
        SalesHeader1: Record 36;
    BEGIN
        Attachment.RESET;
        Attachment.SETRANGE("Table ID", TableID);
        Attachment.SETRANGE("Document No.", SalesHeader."No.");
        Attachment.SETRANGE("Document Type", SalesHeader."Document Type");
        /* {IF Attachment.FINDSET THEN
           REPEAT
             Attachment.CALCFIELDS(FileAttachment);
             AttachmentArchive.TRANSFERFIELDS(Attachment);
             SalesHeader1:=SalesHeader;
             AttachmentArchive."Document Version No.":=SalesHeader1."No. of Archived Versions"+1;
             AttachmentArchive.INSERT;
           UNTIL Attachment.NEXT=0;
          anil comented310312 }*/
    END;




    //Codeunit12
    PROCEDURE CheckCashAccBalance(GenJnlLine2: Record 81);
    VAR
        GLAcc: Record 15;
        Text000: Label 'ENU=Cash Account %1 balance should not be negative. Do you want to post the transactions?';
        GenJnlLine3: Record 81;
        Balance1: Decimal;
        Text001: Label 'ENU=Entry Posting Stopped';
        Text002: Label 'ENU=Balancing Account %1 balance should not be negative. Do you want to post the transactions?';
    BEGIN
        WITH GenJnlLine2 DO BEGIN
            IF "Journal Batch Name" = '' THEN
                EXIT;
            IF "Account Type" = "Account Type"::"G/L Account" THEN
                IF GLAcc.GET("Account No.") AND (GLAcc."Cash Account") THEN BEGIN
                    GenJnlLine3.RESET;
                    GenJnlLine3.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine3.SETRANGE("Account Type", "Account Type"::"G/L Account");
                    GenJnlLine3.SETRANGE("Account No.", "Account No.");
                    IF GenJnlLine3.FINDSET THEN BEGIN
                        REPEAT
                            Balance1 := Balance1 + GenJnlLine3."Amount (LCY)";
                            GLAcc.CALCFIELDS(Balance);
                            IF (GLAcc.Balance + Balance1 < 0) AND (Balance1 < 0) THEN
                                IF NOT CONFIRM(Text000, FALSE, "Account No.") THEN
                                    ERROR(Text001, "Account No.");
                        UNTIL GenJnlLine3.NEXT = 0;
                    end;
                    //COMMENTED TO CHECK LINE BY LINE
                    GLAcc.CALCFIELDS(Balance);
                    IF (GLAcc.Balance + Balance1 < 0) AND (Balance1 < 0) THEN
                        IF NOT CONFIRM(Text000, FALSE, "Account No.") THEN
                            ERROR(Text001, "Account No.");
                END;

            IF "Bal. Account Type" = "Bal. Account Type"::"G/L Account" THEN
                IF GLAcc.GET("Bal. Account No.") AND (GLAcc."Cash Account") THEN BEGIN
                    GenJnlLine3.SETRANGE("Journal Template Name", "Journal Template Name");
                    GenJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine3.SETRANGE("Bal. Account Type", "Bal. Account Type"::"G/L Account");
                    GenJnlLine3.SETRANGE("Bal. Account No.", "Bal. Account No.");
                    IF GenJnlLine3.FINDSET THEN
                        REPEAT
                            Balance1 := Balance1 - GenJnlLine3."Amount (LCY)";
                            GLAcc.CALCFIELDS(Balance);
                            IF (GLAcc.Balance + Balance1 < 0) AND (Balance1 < 0) THEN
                                IF NOT CONFIRM(Text002, FALSE, "Bal. Account No.") THEN
                                    ERROR(Text001, "Account No.");
                        UNTIL GenJnlLine3.NEXT = 0;
                    //COMMENTED TO CHECK LINE BY LINE
                    GLAcc.CALCFIELDS(Balance);
                    IF (GLAcc.Balance + Balance1 < 0) AND (Balance1 < 0) THEN
                        IF NOT CONFIRM(Text002, FALSE, "Bal. Account No.") THEN
                            ERROR(Text001, "Account No.");

                END;
        END;
    END;
    //END;
    /*PROCEDURE Formtracking(TaxEntry: Record 13700);
    VAR
        FormTracking: Record 60000;
        PurchInvHeader: Record 122;
        Vendor: Record 23;
        SalesInvHeader: Record 112;
        Customer: Record 18;
        NextEntry: Integer;
    BEGIN
        FormTracking.INIT;
        IF FormTracking.FINDLAST THEN BEGIN
            NextEntry := FormTracking."Entry No.";
        END ELSE
            NextEntry := 1;
        FormTracking."Entry No." := TaxEntry."Entry No.";
        FormTracking."Form Code" := TaxEntry."Form Code";
        FormTracking."Form No." := TaxEntry."Form No.";
        FormTracking."Document No." := TaxEntry."Document No.";
        FormTracking."Document Type" := FormTracking."Document Type"::Invoice;
        FormTracking."Invoice Base Amount" := ABS(TaxEntry.Base);
        FormTracking."Sales Tax Base Amount" := ABS(TaxEntry.Base);
        FormTracking.Status := FormTracking.Status::Open;
        FormTracking."Sales Tax Amount" := ABS(TaxEntry.Amount);
        FormTracking."Posting Date" := TaxEntry."Posting Date";
        IF TaxEntry.Type = TaxEntry.Type::Purchase THEN BEGIN
            FormTracking.Type := FormTracking.Type::Purchase;
            PurchInvHeader.SETRANGE("No.", FormTracking."Document No.");
            IF PurchInvHeader.FINDFIRST THEN BEGIN
                FormTracking."Vendor / Customer No." := PurchInvHeader."Buy-from Vendor No.";
               // FormTracking."Form No." := PurchInvHeader."Form No.";
            END;
            IF Vendor.GET(FormTracking."Vendor / Customer No.") THEN
                FormTracking.State := Vendor."State Code";
        END ELSE
            IF TaxEntry.Type = TaxEntry.Type::Sale THEN BEGIN
                FormTracking.Type := FormTracking.Type::Sale;
                SalesInvHeader.SETRANGE("No.", FormTracking."Document No.");
                IF SalesInvHeader.FINDFIRST THEN BEGIN
                    FormTracking."Vendor / Customer No." := SalesInvHeader."Sell-to Customer No.";
                    //FormTracking."Form No." := SalesInvHeader."Form No.";
                END;
                IF Customer.GET(FormTracking."Vendor / Customer No.") THEN
                    FormTracking.State := Customer."State Code";//b2B
            END;
        FormTracking.INSERT;
    END;*/

    PROCEDURE BOI_AlertMail(PurchLinePar: Record "Purchase Line");
    VAR
        IH: Record 60024;
        "Mail-Id": Record "User Setup";
        MIH: Record 50001;
        MIL: Record 50002;
        //Count : Integer;
        Item: Record 27;
        Recipients: List of [Text];
        PurchaseHeaderLRec: Record "Purchase Header";
    BEGIN
        // Created by Rakesh on 29-Nov-14 for Mail code for Alerting BOI inward
        Item.RESET;
        Item.SETFILTER(Item."No.", PurchLinePar."No.");
        IF Item.FINDFIRST THEN BEGIN
            PurchaseHeaderLRec.Get(PurchLinePar."Document Type", PurchLinePar."Document No.");
            IF (PurchaseHeaderLRec."Sale Order No" <> '') THEN BEGIN
                //changes by Ahamed on 01-DEC-14
                /*
                 mail_to :='sales@efftronics.com,padmaja@efftronics.com,vsngeetha@efftronics.com,qainward@efftronics.com,purchase@efftronics.com,';
                 mail_to :=mail_to + 'pmurali@efftronics.com,prasanthi@efftronics.com,erp@efftronics.com,pmsubhani@efftronics.com,cuspm@efftronics.com,bharat@efftronics.com,dineel@efftronics.com';
                 mail_from :='erp@efftronics.com';
                 subject := 'Reg: Bought out Item - '+PurchLine.Description+' inwarded';
                 body:='';

                 SMTP_mail.CreateMessage('ERP',mail_from,mail_to,subject,body,TRUE);
                 SMTP_mail.AppendBody('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                 SMTP_mail.AppendBody('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Bought Out Item Inwarded</font></label>');
                 SMTP_mail.AppendBody('<hr style=solid; color= #3333CC>');
                 SMTP_mail.AppendBody('<h>Dear Sir/Madam,</h><br>');
                 SMTP_mail.AppendBody('<P> BOUT Item Status Details </P>');
                 //IF (PurchHeader."No." = PurchLine."Document No.")
                 //BEGIN

                 SMTP_mail.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>'+PurchLine.Description+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b> Item Number </b> </td><td>' + ItemJnlLine."Item No."+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b>Purchase Order No </b>    </td><td>'+PurchHeader."No."+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b>Sale Order No    </b> </td><td>'+PurchHeader."Sale Order No"+'</td></tr>');
                 salesheader.RESET;
                 salesheader.SETFILTER(salesheader."No.",PurchHeader."Sale Order No");
                 IF salesheader.FINDFIRST THEN
                 BEGIN
                   SMTP_mail.AppendBody('<tr><td><b>Customer Name   </b> </td><td>'+salesheader."Sell-to Customer Name"+'</td></tr>');
                 END;
                 // added by vishnu Priya for the Schedule line number Items addition on 05-Sept-2018
                 {Schedule.RESET;
                 Schedule.SETFILTER("Document No.",PurchHeader."Sale Order No");
                 Schedule.SETFILTER("No.",PurchLine."No.");
                 IF Schedule.FINDSET THEN
                   BEGIN
                     SMTP_mail.AppendBody('<tr><td><b> Sale Order Line Number </b></td><td>'+FORMAT(Schedule."Document Line No.")+'</td></tr>');
                     SMTP_mail.AppendBody('<tr><td><b> Schedule Line Number </b></td><td>'+FORMAT(Schedule."Line No.")+'</td></tr>');
                     END;}
                 // end by vishnu priya
                 SMTP_mail.AppendBody('<tr><td><b> Received quantity </b></td><td>'+FORMAT(PurchLine."Qty. to Receive")+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b> To be recieved quantity  </b> </td><td>'+FORMAT(PurchLine.Quantity-(PurchLine."Quantity Received"+PurchLine."Qty. to Receive"))+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b> Total Ordered Quantity</b></td><td>' +FORMAT(PurchLine.Quantity)+'</td></tr>');
                 SMTP_mail.AppendBody('<tr><td><b> Total Received Quantity</b></td><td>'+FORMAT(PurchLine."Quantity Received"+PurchLine."Qty. to Receive")+'</td></tr></table>');
                 SMTP_mail.AppendBody('<br>');
                 SMTP_mail.AppendBody('<p align ="left"> Regards,<br>ERP Team </p>');
                 SMTP_mail.AppendBody('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                 SMTP_mail.Send; */
                //end by ahmed
            END;
            IF (PurchLinePar."Location Code" = 'R&D STR') OR (PurchLinePar."Location Code" = 'CS STR') THEN BEGIN
                IH.RESET;
                IH.SETRANGE(IH."No.", PurchLinePar."Indent No.");
                IF IH.FINDFIRST THEN BEGIN
                    "Mail-Id".RESET;
                    "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                    IF "Mail-Id".FINDFIRST THEN BEGIN
                        Recipients.add("Mail-Id".MailID);
                    END;
                    //  mail_to := 'vijaya@efftronics.com';
                    mail_from := 'erp@efftronics.com';
                    subject := 'ERP- YOUR INDENTED ITEM (' + PurchLinePar.Description + ') inwarded';
                    body := '';

                    EmailMessage.Create(Recipients, Subject, Body, true);


                    // SMTP_mail.CreateMessage('ERP',mail_from,mail_to,subject,body,TRUE);
                    Body += '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
                    Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Item Inwarded to Stores</font></label>';
                    Body += '<hr style=solid; color= #3333CC>';
                    Body += '<h>Dear Sir/Madam,</h><br>';
                    Body += '<P> Item Status Details </P>';
                    Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><td width="40%"><b> Item Description </b> </td><td>' + PurchLinePar.Description + '</td></tr>';
                    Body += '<tr><td><b> Inward DATE & TIME </b> </td><td>' + FORMAT((TODAY), 0, 4) + FORMAT(TIME) + '</td></tr>';
                    Body += '<tr><td><b> Indent Number </b> </td><td>' + PurchLinePar."Indent No." + '</td></tr>';
                    Body += '<tr><td><b>Purchase Order No </b></td><td>' + PurchaseHeaderLRec."No." + '</td></tr>';
                    Body += '<tr><td><b>Vendor Name </b>    </td><td>' + PurchaseHeaderLRec."Buy-from Vendor Name" + '</td></tr>';
                    Body += '<tr><td><b> Received quantity </b></td><td>' + FORMAT(PurchLinePar."Qty. to Receive") + '</td></tr>';
                    "Mail-Id".RESET;
                    "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                    IF "Mail-Id".FINDFIRST THEN BEGIN
                        Body += '<tr><td><b> Inward By </b></td><td>' + "Mail-Id"."User ID" + '</td></tr>';
                    END;
                    Body += '</table>';
                    Body += '<br>';
                    Body += '<p align ="left"> Regards,<br>ERP Team </p>';
                    Body += '<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>';
                    Recipients.Add('vijaya@efftronics.com');
                    // SMTP_mail.Send;
                    //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22
                END;
            END;


        END;
        // end by Rakesh
    END;


    // Codeunit 41>>
    PROCEDURE EvaluateIncStr(StringToIncrement: Code[20]; ErrorHint: Text);
    BEGIN
        IF INCSTR(StringToIncrement) = '' THEN
            ERROR(UnincrementableStringError, ErrorHint);
    END;

    PROCEDURE UnincrementableStringError(): Text;
    var
        UnincrementableStringErr: label '%1 contains no number and cannot be incremented.';
    BEGIN
        EXIT(UnincrementableStringErr)
    END;
    // Codeunit 41<<

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeUpdateSalesLineBeforePost', '', false, false)]
    local procedure UpdateSalesLines(var SalesHeader: Record "Sales Header")
    var
        SalesLineLRec: Record "Sales Line";
    begin
        SalesLineLRec.Reset;
        SalesLineLRec.Setrange("Document No.", SalesHeader."No.");
        SalesLineLRec.setrange("Document Type", SalesHeader."Document Type");
        if SalesLineLRec.findset then begin
            repeat

                // Added by Pranavi on 09-Dec-2015 for auto update of UnitcostLOA for LED Orders
                IF COPYSTR(SalesLineLRec."Document No.", 14, 2) IN ['/L', '/T'] THEN BEGIN
                    SalesLineLRec."Unitcost(LOA)" := SalesLineLRec."Amount To Customer" / SalesLineLRec.Quantity;
                    SalesLineLRec."Line Amount(LOA)" := SalesLineLRec."Unitcost(LOA)" * SalesLineLRec.Quantity;
                    SalesLineLRec."OutStanding(LOA)" := SalesLineLRec."Unitcost(LOA)" * (SalesLineLRec.Quantity - SalesLineLRec."Quantity Invoiced");
                    SalesLineLRec.modify;
                END;
            // Added by Pranavi

            until SalesLineLRec.next = 0;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnPostUpdateOrderLineOnAfterUpdateInvoicedValues', '', false, false)]
    local procedure UpdateOutstandingLOA(var TempSalesLine: Record "Sales Line")
    begin
        IF TempSalesLine."Document Type" = TempSalesLine."Document Type"::Order THEN      //Added by Pranavi on 13-07-2015
            TempSalesLine."OutStanding(LOA)" := TempSalesLine."Unitcost(LOA)" * (TempSalesLine.Quantity - TempSalesLine."Quantity Invoiced");

    end;
    //EFFUPG1.3<<

    //Table 36 on Rename Trigger >>

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeRename', '', false, false)]
    local procedure SaleDocumentRename(var IsHandled: Boolean)
    begin

        IsHandled := true;

    end;
    // Table 36 on Rename  Trigger<<
    //EFFUPG1.3<<

    //EFFUPG1.6>>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertInvoiceHeader', '', false, false)]
    local procedure SaleInvoiceMail(var SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    var
        sal1: Record "Sales Line";
        salinvhead: REcord "Sales Invoice Header";
        salinvline: Record "Sales Invoice Line";
        orderval: Decimal;
        invvalu: Decimal;
        amt: Decimal;
        penval: Decimal;
        orderval1: Decimal;
        totalcnt: Integer;
        finalcnt: Text;
        exciseamt: Decimal;
        vatamt: Decimal;
        taxamt: Decimal;
        servicetax: Decimal;
        charges: Decimal;
        ecessamt: Decimal;
        shecessamt: Decimal;
        UnitPrice: Decimal; //added Pranavi on 23-dec-2015
        GstAmount: Decimal;
        Cust: Record Customer;
        CLE: Record "Cust. Ledger Entry";
        noofdays: Integer;
        month: Integer;
        days: Integer;
        Recamt: Decimal;
        recper: Decimal;
        verticalInfo: Record 33000908;
        formataddress: Codeunit "Correct Dimension Values Cust";

        user: Record "User Setup";
        FromUser: REcord "User Setup";
        "from Mail": List of [Text];

        CustLE2: Record "Cust. Ledger Entry";

    begin

        MESSAGE('Sales Invoice no is %1', SalesInvHeader."No.");
        //swarupa     //Mail Implementation for Invoice



        sal1.SETCURRENTKEY(sal1."Document Type", sal1."Document No.", sal1."Line No.");
        sal1.SETRANGE(sal1."Document No.", SalesHeader."No.");
        sal1.SETFILTER(sal1."Qty. to Invoice", '%1..%2', 1, 1000000000);
        IF sal1.FINDSET THEN
            REPEAT
                exciseamt := 0;
                vatamt := 0;
                taxamt := 0;
                servicetax := 0;
                charges := 0;
                ecessamt := 0;
                shecessamt := 0;
                UnitPrice := 0;  //added Pranavi on 23-dec-2015
                GstAmount := 0;
                IF sal1."Tax Area Code" = 'SALES VAT' THEN
                    vatamt := (sal1."Line Amount" / sal1.Quantity) * sal1."Qty. to Invoice";//commented by b2b for merging
                IF sal1."Tax Area Code" = 'SALES CST' THEN
                    taxamt := (sal1."Line Amount" / sal1.Quantity) * sal1."Qty. to Invoice";
                // exciseamt := (sal1."BED Amount" / sal1.Quantity) * sal1."Qty. to Invoice";
                //servicetax := (sal1."Service Tax Amount" / sal1.Quantity) * sal1."Qty. to Invoice";
                //charges := sal1."Charges To Customer";
                IF (exciseamt > 0) AND (SalesHeader."Posting Date" < DMY2DATE(1, 3, 2015)) THEN       // Modified by Rakesh on 3-Mar-15 for new Excise Rules
                BEGIN
                    ecessamt := exciseamt * 2 / 100;
                    shecessamt := exciseamt * 1 / 100;
                END;
                IF (servicetax > 0) THEN BEGIN
                    ecessamt := servicetax * 2 / 100;
                    shecessamt := servicetax * 1 / 100;
                END;
                IF ((sal1.Quantity <> 0) and (sal1."Qty. to Invoice" <> 0)) THEN BEGIN
                    //B2BJM 22-FEB-2020 >>
                    //GstAmount := GstAmount + sal1."Total GST Amount";
                    //GstAmount := GstAmount + ((sal1."Qty. to Invoice" * sal1."Unit Price") * sal1."GST %" / 100); 
                    GstAmount := GstAmount + ((sal1."Qty. to Invoice" / sal1.Quantity * GetGSTAmount(sal1.RecordId)));

                    //B2BJM 22-FEB-2020 <<
                END;


                //added Pranavi on 23-dec-2015
                UnitPrice := sal1."Unit Price" - ROUND(sal1."Unit Price" * sal1."Line Discount %" / 100);
                //amt:=ROUND((amt+(sal1."Qty. to Invoice"*sal1."Unit Price")+exciseamt+charges+vatamt+taxamt+servicetax+ecessamt+shecessamt),1);
                amt := ROUND((amt + (sal1."Qty. to Invoice" * UnitPrice) + exciseamt + charges + vatamt + taxamt + servicetax + ecessamt + shecessamt + GstAmount), 1);
            //added Pranavi on 23-dec-2015
            UNTIL sal1.NEXT = 0;


        salinvhead.SETCURRENTKEY(salinvhead."Order No.");
        salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
        salinvhead.SETfilter("No.", '<>%1', SalesInvHeader."No.");//EFFUPG1.11
        IF salinvhead.FINDFIRST THEN BEGIN
            REPEAT
                IF (salinvhead."Sale Order Total Amount" > 0) THEN BEGIN
                    orderval := salinvhead."Sale Order Total Amount";
                END;
                /*
                salinvline.SETCURRENTKEY(salinvline."Document No.", salinvline."Line No.");
                salinvline.SETFILTER(salinvline."Document No.", salinvhead."No.");
                IF salinvline.FINDSET THEN BEGIN
                    REPEAT
                        invvalu := invvalu + salinvline."Amount To Customer";
                    UNTIL salinvline.NEXT = 0;
                END;
                */
                CustLE2.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
                CustLE2.SETRANGE("Document No.", salinvhead."No.");
                IF CustLE2.FINDfirst THEN begin
                    CustLE2.CALCFIELDS(Amount);

                    invvalu += CustLE2.Amount;

                end;
            UNTIL salinvhead.NEXT = 0;
        END;
        //  ELSE BEGIN
        //salhead.SETCURRENTKEY(salhead."Document Type",salhead."No.");
        // salhead.SETRANGE(salhead."No.","No.");
        //IF salhead.FINDFIRST THEN BEGIN
        orderval := Round(SalesHeader."Sale Order Total Amount", 1);
        // END;
        IF (SalesHeader."Sell-to Customer No." <> 'CUST00822') AND (SalesHeader."Sell-to Customer No." <> 'CUST00536') THEN BEGIN
            IF (orderval < (amt + invvalu)) THEN BEGIN  //Invvalu Added by sundar on 26-03-2012 so that the total invoice_amt is Compared 
                                                        //against order value rather than the single invoice being done.
                ERROR('Order value must be greater than invoice value');
            END;
        END;




        //B2B
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order)
          and (SalesHeader.SaleDocType = SalesHeader.SaleDocType::Amc) then //EFFUPG1.6
            UpdateWonOpportunities(SalesHeader, SalesInvHeader); // Second parametr added in BC









    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure PostSaleDocEMail(var SalesHeader: Record "Sales Header"; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        PostingPreviewNoTokLVar: Label '***';
        sal1: Record "Sales Line";
        salinvhead: REcord "Sales Invoice Header";
        salinvline: Record "Sales Invoice Line";
        orderval: Decimal;
        invvalu: Decimal;
        amt: Decimal;
        penval: Decimal;
        orderval1: Decimal;
        totalcnt: Integer;
        finalcnt: Text;
        exciseamt: Decimal;
        vatamt: Decimal;
        taxamt: Decimal;
        servicetax: Decimal;
        charges: Decimal;
        ecessamt: Decimal;
        shecessamt: Decimal;
        UnitPrice: Decimal; //added Pranavi on 23-dec-2015
        GstAmount: Decimal;
        Cust: Record Customer;
        CLE: Record "Cust. Ledger Entry";
        noofdays: Integer;
        month: Integer;
        days: Integer;
        Recamt: Decimal;
        recper: Decimal;
        verticalInfo: Record 33000908;
        formataddress: Codeunit "Correct Dimension Values Cust";

        user: Record "User Setup";
        FromUser: REcord "User Setup";
        "from Mail": List of [Text];
        SIH: Record "Sales Invoice Header";
        SIL: Record "Sales Invoice Line";
        SCrH: Record "Sales Cr.Memo Header";
        SCrL: Record "Sales Cr.Memo Line";
        CustLE: Record "Cust. Ledger Entry";


    begin

        TOMailNew.Add('erp@efftronics.com');
        //B2B


        SH.RESET;
        SH.SETFILTER(SH."Document Type", '%1', SH."Document Type"::Order);
        SH.SETRANGE(SH."No.", SalesHeader."No.");
        IF SH.FINDFIRST THEN BEGIN
            MESSAGE(SH."No.");
            REPORT.RUN(50098, FALSE, FALSE, SH);
            //  REPORT.SAVEASHTML(50159,'\\erpserver\ErpAttachments\order2.html',FALSE,SH);//B2BNOV2
            //REPORT.SAVEASPDF(50098, '\\erpserver\ErpAttachments\order2.pdf', SH);
            Attachment1 := '\\erpserver\ErpAttachments\order2.pdf';
            //  REPORT.SAVEASHTML(50159,'\\eff-cpu-211\erp\orderDetails.html',FALSE,SH);
            REPORT.SAVEASPDF(50098, '\\erpserver\ErpAttachments\orderDetails.pdf', SH);//B2BNOV2
        END;
        Attachment1 := '\\erpserver\ErpAttachments\orderDetails.pdf';


        Mail_Subject := 'ERP- ' + SalesHeader."Sell-to Customer Name" + ' Order Invoiced & Invoice No is : ' + SalesHeader."External Document No.";
        salinvhead.SETCURRENTKEY(salinvhead."Order No.");
        salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
        IF salinvhead.FINDFIRST THEN BEGIN
            REPEAT
                IF (salinvhead."Sale Order Total Amount" > 0) THEN BEGIN
                    orderval := salinvhead."Sale Order Total Amount";
                END;
                /*
                 salinvline.SETCURRENTKEY(salinvline."Document No.", salinvline."Line No.");
                 salinvline.SETFILTER(salinvline."Document No.", salinvhead."No.");
                 IF salinvline.FINDSET THEN BEGIN
                     REPEAT
                         if salinvline."Document No." <> SalesInvHdrNo then
                             invvalu := invvalu + salinvline."Amount To Customer"  // Previous invoice Amount
                         else
                             amt := amt + salinvline."Amount to Customer";  // Posting Invoice Amount

                     UNTIL salinvline.NEXT = 0;
                 END;
                 */
                CustLE.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
                CustLE.SETRANGE("Document No.", salinvhead."No.");
                IF CustLE.FINDfirst THEN begin
                    CustLE.CALCFIELDS(Amount);
                    if salinvhead."No." <> SalesInvHdrNo then
                        invvalu += CustLE.Amount
                    else
                        amt := amt + CustLE.Amount;
                end;
            UNTIL salinvhead.NEXT = 0;
        END;
        //  ELSE BEGIN
        //salhead.SETCURRENTKEY(salhead."Document Type",salhead."No.");
        // salhead.SETRANGE(salhead."No.","No.");
        //IF salhead.FINDFIRST THEN BEGIN
        orderval := SalesHeader."Sale Order Total Amount";
        // END;


        penval := orderval - invvalu - amt;
        orderval1 := amt + invvalu + ABS(penval);
        IF penval < 500 THEN BEGIN
            penval := 0;
        END;
        charline := 10;


        Mail_Body += 'INVOICING DETAILS :';
        Mail_Body += '<BR></BR>';//FORMAT(charline);
        Mail_Body += '<BR></BR>';//FORMAT(charline);

        Mail_Body += 'Customer Name                   : ' + SalesHeader."Sell-to Customer Name";
        //Mail_Body += FORMAT(charline);
        Mail_Body += '<br>';
        //  END;
        Mail_Body += 'Place                           : ' + SalesHeader."Sell-to City";
        Mail_Body += '<br>';
        //Mail_Body += FORMAT(charline);
        // END;
        Mail_Body += 'Type of Customer                : ' + FORMAT(SalesHeader."Customer Posting Group");
        Mail_Body += '<br>';
        //Mail_Body += FORMAT(charline);
        Mail_Body += 'Consignee Name                  : ' + FORMAT(SalesHeader."Ship-to Name");
        Mail_Body += '<BR></BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR></BR>';//Mail_Body += FORMAT(charline);
        salinvhead.RESET;
        salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
        IF salinvhead.FINDSET THEN
            REPEAT
                totalcnt += 1;
            UNTIL salinvhead.NEXT = 0;
        IF totalcnt = 0 THEN
            finalcnt := FORMAT(totalcnt + 1) + 'st Invoice'
        ELSE
            IF totalcnt = 1 THEN
                finalcnt := FORMAT(totalcnt + 1) + 'nd Invoice'
            ELSE
                IF totalcnt = 2 THEN
                    finalcnt := FORMAT(totalcnt + 1) + 'rd Invoice'
                ELSE
                    finalcnt := FORMAT(totalcnt + 1) + 'th Invoice';

        Cust.RESET;
        Cust.SETRANGE(Cust."No.", SalesHeader."Sell-to Customer No.");
        IF Cust.FINDFIRST THEN
            Cust.CALCFIELDS(Cust."Balance (LCY)");
        Mail_Body += 'Previous Customer Balance(Rs)   : ' + formataddress.ChangeCurrency(ROUND(Cust."Balance (LCY)" - amt, 1));       //FORMAT(ROUND(Cust."Balance (LCY)",1));
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Invoicing Amount (Rs)           : ' + formataddress.ChangeCurrency(ROUND(amt, 1));//+FORMAT(amt);
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Total Customer Balance(Rs)      : ' + formataddress.ChangeCurrency(ROUND(Cust."Balance (LCY)", 1));
        Mail_Body += '<BR></BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR></BR>';//Mail_Body += FORMAT(charline);


        Mail_Body += 'Total Order Value (Rs)          : ' + formataddress.ChangeCurrency(ROUND(orderval, 1));
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Previous Invoices Value (Rs)    : ' + formataddress.ChangeCurrency(ROUND(invvalu, 1));
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'To be invoiced Value (Rs)       : ' + formataddress.ChangeCurrency(ROUND(penval, 1));
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);

        CLE.SETRANGE(CLE."Customer No.", SalesHeader."Sell-to Customer No.");
        CLE.SETRANGE(CLE."Sale Order no", SalesHeader."No.");
        IF CLE.FINDSET THEN
            REPEAT
                CLE.CALCFIELDS(Amount);
                Recamt += CLE.Amount;
            UNTIL CLE.NEXT = 0;

        IF (invvalu <> 0) THEN BEGIN
            recper := ABS(Recamt / invvalu) * 100;
            Mail_Body += 'Total Received Amt(Rs)          : ' + formataddress.ChangeCurrency(ABS(Recamt)) + ' (' + FORMAT(ROUND(recper, 1)) + '%)';
            Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        END

        ELSE
            IF ((invvalu = 0) AND (Recamt <> 0)) THEN BEGIN
                recper := ABS(Recamt / orderval) * 100;
                Mail_Body += 'Total Received Amt(Rs)          : ' + formataddress.ChangeCurrency(ABS(Recamt)) + ' (' + FORMAT(ROUND(recper, 1)) + '%)';
                Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
            END


            ELSE BEGIN
                recper := 0;
                Mail_Body += 'Total Received Amt(Rs)          : ' + formataddress.ChangeCurrency(ABS(Recamt)) + ' (' + FORMAT(ROUND(recper, 1)) + '%)';
                Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
            END;


        "Mail-Id".SETRANGE("Mail-Id"."User Name", SalesHeader."Salesperson Code");// Rev01
        IF "Mail-Id".FINDFIRST THEN
            Mail_Body += 'Sales Executive                 : ' + "Mail-Id"."User Name";
        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Sale Order No.                  : ' + FORMAT(SalesHeader."No.");
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Invoice No                      : ' + SalesHeader."External Document No." + ' (' + finalcnt + ')';
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);
        Mail_Body += 'Customer Order No               : ' + SalesHeader."Customer OrderNo.";
        Mail_Body += '<br>';//Mail_Body += FORMAT(charline);


        salinvhead.RESET;
        salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
        IF salinvhead.FINDFIRST THEN BEGIN
            Mail_Body += FORMAT(charline);
            IF (salinvhead."Posting Date" <> TODAY) THEN BEGIN
                noofdays := TODAY - salinvhead."Posting Date";
                month := noofdays DIV 30;
                days := noofdays MOD 30;
            END;
            Mail_Body += 'First Invoice Info              : ' + FORMAT((salinvhead."Posting Date"), 0, 4) + ' (' +
            FORMAT(month) + ' Months , ' + FORMAT(days) + ' Days' + ' )';
            Mail_Body += FORMAT(charline);
        END;
        salinvhead.RESET;
        salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
        IF salinvhead.FINDLAST THEN BEGIN
            noofdays := TODAY - salinvhead."Posting Date";
            month := noofdays DIV 30;
            days := noofdays MOD 30;
        END;
        IF (noofdays > 0) THEN
            Mail_Body += 'Previous Invoice Info           : ' + FORMAT((salinvhead."Posting Date"), 0, 4) + ' (' +
            FORMAT(month) + ' Months , ' + FORMAT(days) + ' Days' + ' )'
        ELSE BEGIN
            salinvhead.RESET;
            salinvhead.SETRANGE(salinvhead."Order No.", SalesHeader."No.");
            salinvhead.SETFILTER(salinvhead."Posting Date", '<>%1', TODAY);
            IF salinvhead.FINDLAST THEN BEGIN
                noofdays := TODAY - salinvhead."Posting Date";
                month := noofdays DIV 30;
                days := noofdays MOD 30;

                Mail_Body += 'Previous Invoice Info           : ' + FORMAT((salinvhead."Posting Date"), 0, 4) + ' (' +
                FORMAT(month) + ' Months , ' + FORMAT(days) + ' Days' + ' )'

            END;
        END;

        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '<BR>';//Mail_Body += FORMAT(charline);
        Mail_Body += '** Auto Mail Generated From ERP ***';


        "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);// Rev01
        IF "Mail-Id".FINDFIRST THEN BEGIN
            FromUser.Get(USERID);
            IF FromUser.MailID <> '' THEN
                "from Mail".add(FromUser.MailID);

        END
        ELSE
            "from Mail".add('erp@efftronics.com');
        /*"to mail":='dir@efftronics.com,anilkumar@efftronics.com,cvmohan@efftronics.com,';
        "to mail"+='prasanthi@efftronics.com,padmaja@efftronics.com,rajani@efftronics.com,sganesh@efftronics.com,';
         "to mail"+='store@efftronics.com,shilpa@efftronics.com,madhavip@efftronics.com,praveena@efftronics.com,';
         "to mail"+='anupama@efftronics.com,pmurali@efftronics.com,';
        "to mail"+='purchase@efftronics.com,bharat@efftronics.com,';
        "to mail"+='anuradhag@efftronics.com,sitarajyam@efftronics.com,prasannat@efftronics.com';*/

        "to mail".add('erp@efftronics.com');
        "to mail".add('Sales@Efftronics.com');
        "to mail".Add('bharat@efftronics.com');
        "to mail".Add('dineel@efftronics.com');
        "to mail".Add('padmaja@efftronics.com'); //09-23-2022
        //  "to mail"+='sreenu@efftronics.com';
        "to mail".Add('erp@efftronics.com');

        //Mail Implementation for Invoice   (Swarupa)

        //B2B

        user.RESET;
        user.SETFILTER(user.EmployeeID, SalesHeader."Salesperson Code");
        IF user.FINDFIRST THEN BEGIN
            IF user.MailID <> '' THEN
                "to mail".Add(user.MailID);
        END;

        verticalInfo.RESET;
        verticalInfo.SETFILTER(verticalInfo.Product, SalesHeader.Product);
        IF verticalInfo.FINDFIRST THEN BEGIN
            IF verticalInfo."Vertical Head E_mail" <> '' THEN BEGIN
                "to mail".Add(verticalInfo."Vertical Head E_mail");
            END;
        END;

        "from Mail".add('erp@efftronics.com');
        "to mail".add('controlroom@efftronics.com');
        "to mail".add('cuspm@efftronics.com');
        "to mail".add('prasanthi@efftronics.com');
        "to mail".add('padmaja@efftronics.com');
        "to mail".add('erp@efftronics.com');
        "to mail".add('rajani@efftronics.com');
        "to mail".add('yesu@efftronics.com'); //pmurali@efftronics.com,vkrishna@efftronics.com,
                                              //added by Vishnu Priya on 21-08-2020 by the input from the jhancy mam
        IF SalesHeader.Vertical <> SalesHeader.Vertical::"Smart Signalling" THEN
            "to mail".add('marketing@efftronics.com');

        IF (COPYSTR(SalesHeader."External Document No.", 1, 2) <> 'IN') AND (COPYSTR(SalesHeader."External Document No.", 1, 2) <> 'SI') THEN
            "to mail".add('dispatch@efftronics.com');
        //"to mail" += ',spurthi@efftronics.com,anvesh@efftronics.com';         //Added by Pranavi on 21-10-2015
        /* anil
         IF ("from Mail"='')OR("to mail"='') THEN
           ERROR('Please specify Mail ID')
        ELSE
        BEGIN
          //MESSAGE('from mail'+"from Mail");
          //MESSAGE('to mail'+"to mail");
          IF (FORMAT("Document Type")='Order') {OR (FORMAT("Document Type")='AMC')} THEN
          BEGIN
            smtp.CreateMessage('SALE INVOICE',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
            smtp.AddAttachment( Attachment1);
            //smtp.Send;
            MESSAGE('Mail Has Been Sent');
          END;
        END;
        */

        //EFFUPG Start Already Code Exists
        /*
        IF "Document Type" = "Document Type"::Order THEN BEGIN
          Opp.RESET;
          Opp.SETCURRENTKEY("Sales Document Type","Sales Document No.");
          Opp.SETRANGE("Sales Document Type",Opp."Sales Document Type"::Order);
          Opp.SETRANGE("Sales Document No.","No.");
          Opp.SETRANGE(Status,Opp.Status::Won);
          IF Opp.FINDFIRST THEN BEGIN
            Opp."Sales Document Type" := Opp."Sales Document Type"::"Posted Invoice";
            Opp."Sales Document No." := SalesInvHeader."No.";
            Opp.MODIFY;
            OpportunityEntry.RESET;
            OpportunityEntry.SETCURRENTKEY(Active,"Opportunity No.");
            OpportunityEntry.SETRANGE(Active,TRUE);
            OpportunityEntry.SETRANGE("Opportunity No.",Opp."No.");
            IF OpportunityEntry.FINDFIRST THEN BEGIN
              OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(Rec);
              OpportunityEntry.MODIFY;
            END;
          END;
        END;
        */
        //EFFUPG End
        //B2b1.0>> Since Function doesn't exist in Nav 2013
        /*DimMgt.MoveOneDocDimToPostedDocDim(
          TempDocDim,DATABASE::"Sales Header","Document Type","No.",0,
          DATABASE::"Sales Invoice Header",SalesInvHeader."No.");*/
        //B2b1.0<<

        //IF  ("to mail" = '') THEN
        //    ERROR('Please specify Mail ID')
        // ELSE BEGIN
        //MESSAGE('from mail'+"from Mail");
        //MESSAGE('to mail'+"to mail");


        IF (FORMAT(SalesHeader."Document Type") = 'Order') and (SalesINvHdrno <> PostingPreviewNoTokLvar) tHEN BEGIN
            // smtp.CreateMessage('SALE INVOICE', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
            // smtp.AddAttachment(Attachment1, '');//EFFUPG
            //IF COPYSTR(FORMAT("No."),5,3)  <> 'AMC' THEN   //pranavi
            // smtp.Send;
            // EmailMessage.Create(TOMailNew, Mail_Subject, Mail_Body, true);
            //EmailMessage.Create("to mail", Mail_Subject, Mail_Body, true);
            // InputFile.Open(Attachment1);
            // InputFile.CreateInStream(AttachmentInStream);
            // EmailMessage.AddAttachment(Attachment1, 'PDF', AttachmentInStream);
            //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//B2BNov22
            MESSAGE('Mail Has Been Sent');
        END;

        if (SalesINvHdrNo <> PostingPreviewNoTokLvar) and (SalesINvHdrNo <> '') tHEN begin
            SIH.Reset;
            SIH.Setrange("No.", SalesInvHdrNo);
            if SIH.Findfirst then begin
                SIL.REset;
                SIL.setfilter("Document No.", SalesInvHdrNo);
                SIL.setfilter(Quantity, '<>%1', 0);
                if SIL.findset then begin
                    repeat
                        SIL."GST Amount" := GetSalesLineGSTAmount(SIH, SIL);
                        SIL."Amount to Customer" := SIL.Amount + SIL."GST Amount";

                        SIL.Modify();
                    until SIL.Next() = 0;

                end;
            end;
        end;

        if (SalesCrMemoHdrNo <> PostingPreviewNoTokLvar) and (SalesCrMemoHdrNo <> '') tHEN begin
            SCRH.Reset;
            SCRH.Setrange("No.", SalesCrMemoHdrNo);
            if SCRH.Findfirst then begin
                SCRL.REset;
                SCRL.setfilter("Document No.", SalesCrMemoHdrNo);
                SCRL.setfilter(Quantity, '<>%1', 0);
                if SCRL.findset then begin
                    repeat
                        SCRL."GST Amount" := GetSalesCreditLineGSTAmount(SCRH, SCRL);
                        SCRL."Amount to Customer" := SCRL.Amount + SCRL."GST Amount";

                        SCRL.Modify();
                    until SCRL.Next() = 0;

                end;
            end;
        end;

    end;

    local procedure GetSalesLineGSTAmount(SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        LineGSTAmt: Decimal;
    begin
        Clear(LineGSTAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (SalesInvoiceHeader."Currency Code" <> '') then
                    LineGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    LineGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");





            until DetailedGSTLedgerEntry.Next() = 0;
        Exit(LineGSTAmt);
    end;

    local procedure GetSalesCreditLineGSTAmount(SalesCRMemoHeader: Record "Sales Cr.Memo Header";
        SalesCRMemoLine: Record "Sales Cr.Memo Line"): Decimal
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        LineGSTAmt: Decimal;
    begin
        Clear(LineGSTAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCRMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCRMemoLine."Line No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (SalesCRMemoHeader."Currency Code" <> '') then
                    LineGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCRMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    LineGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");





            until DetailedGSTLedgerEntry.Next() = 0;
        Exit(LineGSTAmt);
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







    LOCAL PROCEDURE UpdateWonOpportunities(VAR SalesHeader: Record 36; SalesInvHeaderPar: Record "Sales Invoice Header");
    VAR
        Opp: Record 5092;
        OpportunityEntry: Record 5093;
    BEGIN
        WITH SalesHeader DO
            IF "Document Type" = "Document Type"::Order THEN BEGIN
                Opp.RESET;
                Opp.SETCURRENTKEY("Sales Document Type", "Sales Document No.");
                Opp.SETRANGE("Sales Document Type", Opp."Sales Document Type"::Order);
                Opp.SETRANGE("Sales Document No.", "No.");
                Opp.SETRANGE(Status, Opp.Status::Won);
                IF Opp.FINDFIRST THEN BEGIN
                    Opp."Sales Document Type" := Opp."Sales Document Type"::"Posted Invoice";
                    Opp."Sales Document No." := SalesInvHeaderPar."No.";
                    Opp.MODIFY;
                    OpportunityEntry.RESET;
                    OpportunityEntry.SETCURRENTKEY(Active, "Opportunity No.");
                    OpportunityEntry.SETRANGE(Active, TRUE);
                    OpportunityEntry.SETRANGE("Opportunity No.", Opp."No.");
                    IF OpportunityEntry.FINDFIRST THEN BEGIN
                        OpportunityEntry."Calcd. Current Value (LCY)" := OpportunityEntry.GetSalesDocValue(SalesHeader);
                        OpportunityEntry.MODIFY;
                    END;
                END;
            END;
    END;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;


    //EFFUPG1.6<<


    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
    local procedure UpdateAmountCust(var SalesLine: Record "Sales Line")
    begin

        SalesLine."GST Amount" := GetGSTAmount(SalesLine.RecordId);
        SalesLine."Amount to Customer" := SalesLine.Amount + SalesLine."GST Amount" + GetTCSAmount(SalesLine);

    end;


    [EventSubscriber(ObjectType::Page, Page::"Posted Purchase Rcpt. Subform", 'OnBeforeActionEvent', '&Undo Receipt', false, false)]
    local procedure UndoReceiptPurchase(var Rec: Record "Purch. Rcpt. Line")
    begin

        rec.UndoReceiptLine();

    end;


    local procedure GetTCSAmount(SalesLine: Record "Sales Line"): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";

        TCSGSTCompAmount: Decimal;
    begin

        clear(TCSGSTCompAmount);
        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", 'TCS');
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TCSGSTCompAmount += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;
        exit(TCSGSTCompAmount);

    end;

    // The Below code from Table 349 on Delete trigger customized code 
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnBeforeCheckIfDimValueUsedFromOnDelete', '', false, false)]
    local procedure DimValueDeleteCust(var IsHandled: Boolean; DimensionValue: Record "Dimension Value")
    begin

        IsHandled := true;

    end;

    [EventSubscriber(ObjectType::Page, page::"Blanket Sales Order", 'OnAfterActionEvent', 'MakeOrder', false, false)]
    local procedure BlanketOrderDelete(var Rec: Record "Sales Header")
    Var
        BlanketSalesLines: Record "Sales Line";
        BlanketSalesHeader: Record "Sales Header";

        IsFullyConverted: Boolean;
    begin

        IsFullyConverted := true;
        BlanketSalesLines.RESET;
        BlanketSalesLines.SETRANGE("Document Type", BlanketSalesLines."Document Type"::"Blanket Order");
        BlanketSalesLines.SETRANGE("Document No.", Rec."No.");
        IF BlanketSalesLines.FINDSET THEN
            REPEAT
                IF BlanketSalesLines.Quantity <> BlanketSalesLines."Quantity Shipped" THEN
                    IsFullyConverted := false;
            UNTIL (BlanketSalesLines.NEXT = 0) OR (IsFullyConverted = false);

        if IsFullyConverted then begin
            BlanketSalesHeader.RESET;
            BlanketSalesHeader.SETRANGE("Document Type", BlanketSalesHeader."Document Type"::"Blanket Order");
            BlanketSalesHeader.SETRANGE("No.", Rec."No.");
            IF BlanketSalesHeader.FindFirst() THEN
                BlanketSalesHeader.Delete(true);

        end;


    end;


    //EFF151122>>

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckLinkedBlanketOrderLineOnDelete', '', false, false)]
    local procedure BlanketLineDeleteBefore(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin

        if SalesLine."Document Type" = SalesLine."Document Type"::"Blanket Order" then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCheckNotInvoicedQty', '', false, false)]
    local procedure BlanketLineDelete(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)
    begin

        if SalesLine."Document Type" = SalesLine."Document Type"::"Blanket Order" then
            IsHandled := true;
    end;


    //EFF151122<<





    var
        //codeunit12
        /* "--B2B----"@1102154001 : Integer;
             CustAccNo : Code[20];
             SIH@: Record 112;
             */
        BG: Record 60061;
        SQLInt: Codeunit 60021;
        //>>Codeunit 13>>
        textcnt: Decimal;
        Genjournal: Record 81;
        VendrCount: Decimal;
        GenJournl: Record 81;
        //<<Codeunit12<<

        QualityItemLedgEntry1: Record 33000262;
        PurchLine: Record 121;
        //  Text33000251: Label 'ENU=Outbound quantity is more than accepted quantity for Item %1';
        Text33000251: Label 'Negative inventory is not allowed for  item %1  is QC Enabled';
        Text014: label 'Serial No. %1 is already on inventory.;ENN=Serial No. %1 is already on inventory.';
        Itm: Record 27;
        PostItemJournalLine: Boolean;
        QualityItemLedgEntry: Record 33000262;
        ItemTrackingMgt: Codeunit 6500;

        //codeunit 81
        Text000: label '&Ship,&Invoice,Ship &and Invoice';
        ArchiveManagement: Codeunit 5063;
        "g/l setup": Record 98;
        Attachment: Text[1000];
        SH: Record 36;
        SalesLines: Record 37;
        //SQLConnection@1102152011 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";
        //RecordSet@1102152010 : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";
        //SQLQuery: Text;
        RowCount: Integer;
        ConnectionOpen: Integer;
        AMCOrderID: Integer;
        SalesLines1: Record 37;

        //codeunit83
        SRSetup0: Record 311;
        //ArchiveManagement : Codeunit 5063;
        "Mail-Id": Record 2000000120;
        "from Mail": Text[100];
        "to mail": List of [Text];
        Mail_Subject: Text[1000];
        Mail_Body: Text;

        charline: Char;
        // "g/l setup" : Record 98;
        Attachment1: Text[1000];
        //SH : Record 36;
        QV: Decimal;
        //codeunit 86
        Schedule: Record 60095;
        Schedule2: Record 60095;
        Attach: Record 60098;
        PostAttach: Record 60098;

        //codeunit90



        "--QC--": Integer;
        QualitySetup: Record 33000257;
        InspectDataSheets: Codeunit 33000251;
        Text33000250: label 'ENU=You cannot receive more than quality accepted quantity in Purchase Order %1 and Line No. %2.';
        "---B2B---": Integer;
        VI: Boolean;
        "--MSPT--": Integer;
        MSPTOrderDetails: Record 60083;
        PostedMSPTOrderDetails: Record 60086;
        GenJnlLineVendInvDate: Date;
        Structure_Amount: Decimal;
        user: Record 2000000120;
        body: Text[1000];
        mail_from: Text[250];
        //mail_to: Text[500];
        mail: Codeunit 397;
        subject: Text[250];
        new_line: Char;
        "indent header": Record 60024;
        "indent line": Record 60025;
        SQLSelectQry: Text[1000];
        SQLQuery: Text[1000];
        // LRecordSet: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Purchase_Line: Record 39;
        "G|l": Record 98;
        "--- SQL END----": Integer;
        Order_No: Code[30];
        Packing_Value: Decimal;
        Frieght_Value: Decimal;
        Insurance_Value: Decimal;
        Additional_Duty: Decimal;
        Service_Amount: Decimal;
        OrderLineNo: Integer;
        Quotes: label 'ENU=''';
        Text50001: label 'ENU=NEW';
        Text50002: label 'ENU=OLD';
        VAT_AMOUNT: Decimal;
        CST_AMOUNT: Decimal;
        Dept: Code[10];
        FIN_YEAR: Integer;
        "--Rev01": Integer;
        salesheader: Record 36;
        itemgroup: Record 27;
        // SMTP_mail: Codeunit 400;
        PurchRcptLine: Record 121;
        Vend: Record 23;
        GST_Amount: Decimal;
        ItemNo: Text[50];
        OtherDeductions: Decimal;
        EmailMessage: codeunit "Email Message";
        Email: codeunit Email;
        RCMDeductions: Decimal;
        Rej_amt: Text;
        rej_qty: Text;
        rej_amt_int: Decimal;
        rej_qty_int: Decimal;
        //>> ORACLE UPG
        // SQLConnection: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";
        // RecordSet: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";
        //<< ORACLE UPG
        TCS_Amount: Decimal;
        //  Posted_Structure_details: Record 13794;
        // Structure_Lines: Record 13793;
        RDSO_Value: Decimal;
        // StrOrderLineDetails: Record 13795;
        //  Applied: Boolean;
        OverflowDimFilterErr: label 'ENU=Conversion of dimension filter results in a filter that becomes too long.;ENN=Conversion of dimension filter results in a filter that becomes too long.';

        TOMailNew: List of [Text];
        AttachmentInStream: InStream;
        InputFile: File;



}