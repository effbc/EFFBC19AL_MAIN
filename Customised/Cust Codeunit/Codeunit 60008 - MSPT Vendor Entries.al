codeunit 60008 "MSPT Vendor Entries"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Vendor Entries


    trigger OnRun();
    begin
    end;

    var
        CheckAmount: Decimal;
        CheckAmount1: Decimal;
        RemainAmount1: Decimal;


    procedure PostMSPTVendorLedgerEntries(VendLedgEntry: Record "Vendor Ledger Entry");
    var
        MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry";
        NextEntryNo1: Integer;
        MSPTOrderDetails: Record "MSPT Order Details";
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        PostedMSPTOrderDetails: Record "Posted MSPT Order Details";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
    begin
        MSPTVendLedgEntry.LOCKTABLE;
        MSPTVendLedgEntry.INIT;
        PurchInvoiceHeader.SETRANGE(PurchInvoiceHeader."No.", VendLedgEntry."Document No.");
        IF PurchInvoiceHeader.FINDFIRST THEN
            //PostedMSPTOrderDetails.SETRANGE("MSPT Header Code",PurchInvoiceHeader."MSPT Code");
            PostedMSPTOrderDetails.SETRANGE("Document No.", PurchInvoiceHeader."No.");
        IF PostedMSPTOrderDetails.FINDSET THEN BEGIN
            REPEAT
                IF MSPTVendLedgEntry.FINDLAST THEN
                    NextEntryNo1 := MSPTVendLedgEntry."MSPT Entry No." + 1
                ELSE
                    NextEntryNo1 := 1;
                MSPTVendLedgEntry."MSPT Entry No." := NextEntryNo1;
                MSPTVendLedgEntry."MSPT Header Code" := PostedMSPTOrderDetails."MSPT Header Code";
                MSPTVendLedgEntry."MSPT Line No." := PostedMSPTOrderDetails."MSPT Line No.";
                MSPTVendLedgEntry."MSPT Due Date" := PostedMSPTOrderDetails."Due Date";
                MSPTVendLedgEntry."MSPT Line Code" := PostedMSPTOrderDetails."MSPT Code";
                MSPTVendLedgEntry."MSPT Percentage" := PostedMSPTOrderDetails.Percentage;
                MSPTVendLedgEntry."Entry No." := VendLedgEntry."Entry No.";
                MSPTVendLedgEntry."Vendor No." := VendLedgEntry."Vendor No.";
                MSPTVendLedgEntry."Posting Date" := VendLedgEntry."Posting Date";
                MSPTVendLedgEntry."Document Type" := VendLedgEntry."Document Type";
                MSPTVendLedgEntry."Document No." := VendLedgEntry."Document No.";
                MSPTVendLedgEntry."Document Date" := VendLedgEntry."Document Date";
                MSPTVendLedgEntry."External Document No." := VendLedgEntry."External Document No.";
                MSPTVendLedgEntry.Description := VendLedgEntry.Description;
                MSPTVendLedgEntry."Currency Code" := VendLedgEntry."Currency Code";
                MSPTVendLedgEntry."Purchase (LCY)" := VendLedgEntry."Purchase (LCY)";
                MSPTVendLedgEntry."Inv. Discount (LCY)" := VendLedgEntry."Inv. Discount (LCY)";
                MSPTVendLedgEntry."Buy-from Vendor No." := VendLedgEntry."Buy-from Vendor No.";
                MSPTVendLedgEntry."Vendor Posting Group" := VendLedgEntry."Vendor Posting Group";
                MSPTVendLedgEntry."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                MSPTVendLedgEntry."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                MSPTVendLedgEntry."Purchaser Code" := VendLedgEntry."Purchaser Code";
                MSPTVendLedgEntry."Source Code" := VendLedgEntry."Source Code";
                MSPTVendLedgEntry."On Hold" := VendLedgEntry."On Hold";
                MSPTVendLedgEntry."Applies-to Doc. Type" := VendLedgEntry."Applies-to Doc. Type";
                MSPTVendLedgEntry."Applies-to Doc. No." := VendLedgEntry."Applies-to Doc. No.";
                MSPTVendLedgEntry."Due Date" := VendLedgEntry."Due Date";
                MSPTVendLedgEntry."Pmt. Discount Date" := VendLedgEntry."Pmt. Discount Date";
                MSPTVendLedgEntry."Applies-to ID" := VendLedgEntry."Applies-to ID";
                MSPTVendLedgEntry."Journal Batch Name" := VendLedgEntry."Journal Batch Name";
                MSPTVendLedgEntry."Reason Code" := VendLedgEntry."Reason Code";
                MSPTVendLedgEntry."Transaction No." := VendLedgEntry."Transaction No.";
                MSPTVendLedgEntry."User ID" := VendLedgEntry."User ID";
                MSPTVendLedgEntry."Bal. Account Type" := VendLedgEntry."Bal. Account Type";
                MSPTVendLedgEntry."Bal. Account No." := VendLedgEntry."Bal. Account No.";
                MSPTVendLedgEntry."No. Series" := VendLedgEntry."No. Series";
                //      MSPTVendLedgEntry."Import Document" := VendLedgEntry."Import Document"; //B2B
                // MSPTVendLedgEntry."TDS Nature of Deduction" := VendLedgEntry."TDS Nature of Deduction";
                // MSPTVendLedgEntry."TDS Group" := VendLedgEntry."TDS Group";
                // MSPTVendLedgEntry."Total TDS Including eCESS" := VendLedgEntry."Total TDS Including SHE CESS";
                MSPTVendLedgEntry.Open := VendLedgEntry.Open;
                /*PostedMSPTOrderDetails.Amount := MSPTVendLedgEntry."MSPT Amount";
                PostedMSPTOrderDetails.MODIFY;*/
                MSPTVendLedgEntry.INSERT;
            UNTIL PostedMSPTOrderDetails.NEXT = 0;
        END ELSE BEGIN
            IF MSPTVendLedgEntry.FINDLAST THEN
                NextEntryNo1 := MSPTVendLedgEntry."MSPT Entry No." + 1
            ELSE
                NextEntryNo1 := 1;
            MSPTVendLedgEntry."MSPT Entry No." := NextEntryNo1;
            MSPTVendLedgEntry."MSPT Header Code" := '';
            MSPTVendLedgEntry."MSPT Line No." := 0;
            MSPTVendLedgEntry."MSPT Percentage" := 0;
            MSPTVendLedgEntry."MSPT Due Date" := VendLedgEntry."Due Date";
            MSPTVendLedgEntry."Entry No." := VendLedgEntry."Entry No.";
            MSPTVendLedgEntry.Open := VendLedgEntry.Open;
            MSPTVendLedgEntry."Vendor No." := VendLedgEntry."Vendor No.";
            MSPTVendLedgEntry."Posting Date" := VendLedgEntry."Posting Date";
            MSPTVendLedgEntry."MSPT Line Code" := '';
            MSPTVendLedgEntry."Document Type" := VendLedgEntry."Document Type";
            MSPTVendLedgEntry."Document No." := VendLedgEntry."Document No.";
            MSPTVendLedgEntry."External Document No." := VendLedgEntry."External Document No.";
            MSPTVendLedgEntry.Description := VendLedgEntry.Description;
            MSPTVendLedgEntry."Currency Code" := VendLedgEntry."Currency Code";
            MSPTVendLedgEntry."Purchase (LCY)" := VendLedgEntry."Purchase (LCY)";
            MSPTVendLedgEntry."Inv. Discount (LCY)" := VendLedgEntry."Inv. Discount (LCY)";
            MSPTVendLedgEntry."Buy-from Vendor No." := VendLedgEntry."Buy-from Vendor No.";
            MSPTVendLedgEntry."Vendor Posting Group" := VendLedgEntry."Vendor Posting Group";
            MSPTVendLedgEntry."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
            MSPTVendLedgEntry."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
            MSPTVendLedgEntry."Purchaser Code" := VendLedgEntry."Purchaser Code";
            MSPTVendLedgEntry."Source Code" := VendLedgEntry."Source Code";
            MSPTVendLedgEntry."On Hold" := VendLedgEntry."On Hold";
            MSPTVendLedgEntry."Applies-to Doc. Type" := VendLedgEntry."Applies-to Doc. Type";
            MSPTVendLedgEntry."Applies-to Doc. No." := VendLedgEntry."Applies-to Doc. No.";
            MSPTVendLedgEntry."Due Date" := VendLedgEntry."Due Date";
            MSPTVendLedgEntry."Document Date" := VendLedgEntry."Document Date";
            MSPTVendLedgEntry."Pmt. Discount Date" := VendLedgEntry."Pmt. Discount Date";
            MSPTVendLedgEntry."Applies-to ID" := VendLedgEntry."Applies-to ID";
            MSPTVendLedgEntry."Journal Batch Name" := VendLedgEntry."Journal Batch Name";
            MSPTVendLedgEntry."Reason Code" := VendLedgEntry."Reason Code";
            MSPTVendLedgEntry."Transaction No." := VendLedgEntry."Transaction No.";
            MSPTVendLedgEntry."User ID" := VendLedgEntry."User ID";
            MSPTVendLedgEntry."Bal. Account Type" := VendLedgEntry."Bal. Account Type";
            MSPTVendLedgEntry."Bal. Account No." := VendLedgEntry."Bal. Account No.";
            MSPTVendLedgEntry."No. Series" := VendLedgEntry."No. Series";
            //  MSPTVendLedgEntry."Import Document" := VendLedgEntry."Import Document"; //B2B
            // MSPTVendLedgEntry."TDS Nature of Deduction" := VendLedgEntry."TDS Nature of Deduction";
            //MSPTVendLedgEntry."TDS Group" := VendLedgEntry."TDS Group";
            MSPTVendLedgEntry."Total TDS Including eCESS" := VendLedgEntry."Total TDS Including SHE CESS";
            MSPTVendLedgEntry.INSERT;
        END;

    end;


    procedure CheckStatus(DtldMSPTVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry"; MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry");
    var
        Value: Decimal;
    begin
        DtldMSPTVendLedgEntry.SETRANGE("MSPT Vend. Led. Entry No.", MSPTVendLedgEntry."MSPT Entry No.");
        IF DtldMSPTVendLedgEntry.FINDSET THEN
            REPEAT
                Value := DtldMSPTVendLedgEntry."MSPT Amount" + Value;
            UNTIL DtldMSPTVendLedgEntry.NEXT = 0;
        IF Value = 0 THEN BEGIN
            MSPTVendLedgEntry.SETRANGE("MSPT Entry No.", DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No.");
            IF MSPTVendLedgEntry.FINDFIRST THEN BEGIN
                MSPTVendLedgEntry.Open := FALSE;
                MSPTVendLedgEntry.MODIFY;
            END;
        END;
    end;


    procedure PostMSPTDtldVendLedgEntries(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry");
    var
        DtldMSPTVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry";
        NextEntryNo1: Integer;
        DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry";
        Amount: Decimal;
        I: Integer;
        PurchInvoiceHeader: Record "Purch. Inv. Header";
        PostedMSPTOrderDetails: Record "Posted MSPT Order Details";
        MSPTOrderDetails: Record "MSPT Order Details";
    begin
        DtldMSPTVendLedgEntry.LOCKTABLE;
        DtldMSPTVendLedgEntry.INIT;
        IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
            CheckAmount := DtldVendLedgEntry."Amount (LCY)";
        END ELSE
            IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                CheckAmount1 := DtldVendLedgEntry."Amount (LCY)";
            END;

        Amount := DtldVendLedgEntry."Amount (LCY)";
        I := 0;
        MSPTVendLedgEntry.SETRANGE(MSPTVendLedgEntry."Entry No.", DtldVendLedgEntry."Vendor Ledger Entry No.");
        IF MSPTVendLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF (I = 0) THEN BEGIN
                    IF DtldMSPTVendLedgEntry.FINDLAST THEN
                        NextEntryNo1 := DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." + 1
                    ELSE
                        NextEntryNo1 := 1;

                    //For Detailed MSPT "Initial Entry"
                    IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::"Initial Entry") AND
                       (DtldVendLedgEntry."Document Type" <> DtldVendLedgEntry."Document Type"::Invoice)
                    THEN BEGIN
                        DtldMSPTVendLedgEntry."MSPT Amount" := DtldVendLedgEntry."Amount (LCY)";
                        DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                        DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                        DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                        DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                        DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                        DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                        DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                        DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                        DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                        DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                        DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                        DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                        DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                        DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                        DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                        DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                        DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                        DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                        DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                        DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                        DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                        DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                        DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                        DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                        // DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document"; //B2B
                        // DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                        // DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                        //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                        DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                        DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                        DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                        DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                        DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                        IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                            DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                            DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                        END ELSE BEGIN
                            DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                            DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                        END;
                        DtldMSPTVendLedgEntry.INSERT;
                        CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);

                        //BHAVANI
                        //For Unrealized loss and Unrealized Gain
                    END ELSE
                        IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
                            IF CheckAmount > 0 THEN BEGIN
                                UnrealizedLossEntry(DtldVendLedgEntry, MSPTVendLedgEntry);
                                CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
                            END ELSE BEGIN
                            END;
                        END ELSE
                            IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                                IF CheckAmount1 < 0 THEN BEGIN
                                    UnrealizedGainEntry(DtldVendLedgEntry, MSPTVendLedgEntry);
                                    CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
                                END ELSE BEGIN
                                END;

                                //For Detailed MSPT "Payment Discount"
                            END ELSE
                                IF (DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::"Initial Entry") AND
                                   (DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::Application) AND
                                   (DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::"Unrealized Loss") AND
                                   (DtldVendLedgEntry."Entry Type" <> DtldVendLedgEntry."Entry Type"::"Unrealized Gain")
                       THEN BEGIN
                                    DtldMSPTVendLedgEntry."MSPT Amount" := DtldVendLedgEntry."Amount (LCY)";
                                    DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                    DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                                    DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                                    DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                                    DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                                    DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                                    DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                                    DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                                    DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                                    DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                                    ;
                                    DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                                    DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                                    DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                                    DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                                    DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                                    DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                                    DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                                    DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                                    DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                                    DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                                    DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                                    DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                                    // DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document"; //B2B
                                    // DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                                    //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                                    //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                                    DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                                    DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                                    DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                                    DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                                    DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                                    IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                        DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                                        DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                                    END ELSE BEGIN
                                        DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                                        DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                                    END;
                                    DtldMSPTVendLedgEntry.INSERT;
                                    CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);

                                    //For Detailed MSPT "APPlicaiton"
                                END ELSE
                                    IF (DtldVendLedgEntry."Entry Type" = DtldVendLedgEntry."Entry Type"::Application) THEN BEGIN
                                        MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."MSPT Remaining Amount");
                                        IF (Amount = -(MSPTVendLedgEntry."MSPT Remaining Amount")) OR
                                           (Amount < -(MSPTVendLedgEntry."MSPT Remaining Amount"))
                                        THEN BEGIN
                                            DtldMSPTVendLedgEntry."MSPT Amount" := Amount;
                                            I := 1;
                                            DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                            DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                                            DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                                            DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                                            DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                                            DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                                            DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                                            DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                                            DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                                            DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                                            ;
                                            DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                                            DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                                            DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                                            DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                                            DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                                            DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                                            DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                                            DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                                            DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                                            DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                                            DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                                            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                                            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                                            DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                                            //          DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document"; //B2B
                                            //  DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                                            // DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                                            // DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                                            DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                                            DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                                            DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                                            DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                                            DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                                            IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                                                DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                                            END ELSE BEGIN
                                                DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                                                DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                                            END;
                                            DtldMSPTVendLedgEntry.INSERT;
                                            CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);

                                        END ELSE
                                            IF (Amount > -(MSPTVendLedgEntry."MSPT Remaining Amount")) THEN BEGIN
                                                MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."MSPT Remaining Amount");
                                                IF MSPTVendLedgEntry."MSPT Remaining Amount" = 0 THEN BEGIN
                                                END ELSE BEGIN
                                                    DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                                    DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                                                    DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                                                    DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                                                    DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                                                    DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                                                    DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                                                    DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                                                    DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                                                    DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                                                    DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                                                    DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                                                    DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                                                    DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                                                    DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                                                    DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                                                    DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                                                    DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                                                    DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                                                    DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                                                    DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                                                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                                                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                                                    DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                                                    //  DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
                                                    // DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                                                    //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                                                    //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                                                    DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                                                    DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                                                    DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                                                    DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                                                    DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                                                    //BHAVANI
                                                    MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."MSPT Remaining Amount");
                                                    MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."Remaining Amount");
                                                    IF MSPTVendLedgEntry."Remaining Amount" > 0 THEN
                                                        DtldMSPTVendLedgEntry."MSPT Amount" := DtldVendLedgEntry."Amount (LCY)"
                                                    ELSE BEGIN
                                                        DtldMSPTVendLedgEntry."MSPT Amount" := -(MSPTVendLedgEntry."MSPT Remaining Amount");
                                                        Amount := Amount + MSPTVendLedgEntry."MSPT Remaining Amount";
                                                    END;
                                                    IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                        DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                                                        DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                                                    END ELSE BEGIN
                                                        DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                                                        DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                                                    END;
                                                    DtldMSPTVendLedgEntry.INSERT;
                                                    CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
                                                END;
                                            END ELSE BEGIN
                                                DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                                DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                                                DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                                                DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                                                DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                                                DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                                                DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                                                DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                                                DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                                                DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                                                DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                                                DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                                                DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                                                DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                                                DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                                                DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                                                DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                                                DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                                                DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                                                DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                                                DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                                                DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                                                DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                                                DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                                                //          DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
                                                // DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                                                //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                                                //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                                                DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                                                DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                                                DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                                                DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                                                DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                                                ;
                                                DtldMSPTVendLedgEntry."MSPT Amount" := DtldVendLedgEntry."Amount (LCY)";
                                                IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                    DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                                                    DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                                                END ELSE BEGIN
                                                    DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                                                    DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                                                END;
                                                DtldMSPTVendLedgEntry.INSERT;
                                                CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
                                            END;
                                    END ELSE BEGIN
                                        DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                        DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                                        DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                                        DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                                        DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                                        DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                                        DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                                        DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                                        DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                                        DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                                        DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                                        DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                                        DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                                        DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                                        DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                                        DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                                        DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                                        DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                                        DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                                        DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                                        DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                                        DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                                        DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                                        DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                                        //        DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
                                        //  DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                                        //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                                        //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                                        DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                                        DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                                        DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                                        DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                                        IF MSPTVendLedgEntry."MSPT Percentage" = 0 THEN
                                            DtldMSPTVendLedgEntry."MSPT Amount" := DtldVendLedgEntry."Amount (LCY)"
                                        ELSE
                                            DtldMSPTVendLedgEntry."MSPT Amount" := (DtldVendLedgEntry."Amount (LCY)" * MSPTVendLedgEntry."MSPT Percentage") / 100;
                                        DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                                        IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                            DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                                            DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                                        END ELSE BEGIN
                                            DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                                            DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                                        END;
                                        DtldMSPTVendLedgEntry.INSERT;
                                        CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
                                    END;
                END;
            UNTIL MSPTVendLedgEntry.NEXT = 0;
        END;
    end;


    procedure PostMSPTExchangeAdjEntries(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry");
    var
        DtldMSPTVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry";
        NextEntryNo1: Integer;
        DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry";
    begin
        DtldMSPTVendLedgEntry.LOCKTABLE;
        DtldMSPTVendLedgEntry.INIT;
        RemainAmount1 := 0;
        MSPTVendLedgEntry.SETRANGE(MSPTVendLedgEntry."Entry No.", DtldVendLedgEntry."Vendor Ledger Entry No.");
        IF MSPTVendLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF MSPTVendLedgEntry.Open = TRUE THEN BEGIN
                    MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."MSPT Remaining Amount");
                    RemainAmount1 := MSPTVendLedgEntry."MSPT Remaining Amount" + RemainAmount1;
                END;
            UNTIL MSPTVendLedgEntry.NEXT = 0;
        END;

        MSPTVendLedgEntry.SETRANGE(MSPTVendLedgEntry."Entry No.", DtldVendLedgEntry."Vendor Ledger Entry No.");
        IF MSPTVendLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF MSPTVendLedgEntry.Open = TRUE THEN BEGIN
                    IF DtldMSPTVendLedgEntry.FINDLAST THEN
                        NextEntryNo1 := DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." + 1
                    ELSE
                        NextEntryNo1 := 1;
                    DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                    DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
                    DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                    DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
                    DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
                    DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
                    DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
                    DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
                    DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
                    DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
                    DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
                    DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
                    DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
                    DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
                    DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
                    DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
                    DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
                    DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
                    DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
                    DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
                    DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
                    DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
                    DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
                    //    DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
                    //  DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
                    //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
                    //  DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
                    DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
                    DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
                    DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
                    DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
                    DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
                    MSPTVendLedgEntry.CALCFIELDS(MSPTVendLedgEntry."MSPT Remaining Amount");
                    DtldMSPTVendLedgEntry."MSPT Amount" := (MSPTVendLedgEntry."MSPT Remaining Amount" / RemainAmount1) *
                                                                                (DtldVendLedgEntry."Amount (LCY)");
                    IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                        DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                        DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                    END ELSE BEGIN
                        DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                        DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                    END;
                    DtldMSPTVendLedgEntry.INSERT;
                END;
                CheckStatus(DtldMSPTVendLedgEntry, MSPTVendLedgEntry);
            UNTIL MSPTVendLedgEntry.NEXT = 0;
        END;
    end;


    procedure UnrealizedLossEntry(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry");
    var
        DtldMSPTVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry";
        NextEntryNo1: Integer;
        Value: Decimal;
        DtldMSPTVendLedgEntry2: Record "MSPT Dtld. Vendor Ledg. Entry";
        MSPTValue: Decimal;
    begin
        MSPTVendLedgEntry.CALCFIELDS("MSPT Remaining Amount");
        IF MSPTVendLedgEntry."MSPT Remaining Amount" <> 0 THEN BEGIN
            IF DtldMSPTVendLedgEntry.FINDLAST THEN
                NextEntryNo1 := DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." + 1
            ELSE
                NextEntryNo1 := 1;
            DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
            DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
            DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
            DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
            DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
            DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
            DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
            DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
            DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
            DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
            DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
            DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
            DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
            DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
            DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
            DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
            DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
            DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
            DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
            DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
            DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
            DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
            //  DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
            //  DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
            //  DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
            // DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
            DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
            DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
            DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
            DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
            DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
            DtldMSPTVendLedgEntry."MSPT Amount" := 0;
            DtldMSPTVendLedgEntry.INSERT;

            DtldMSPTVendLedgEntry2.SETRANGE("MSPT Vend. Led. Entry No.", DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No.");
            DtldMSPTVendLedgEntry2.SETRANGE("Entry Type", DtldMSPTVendLedgEntry."Entry Type"::"Unrealized Loss");
            IF DtldMSPTVendLedgEntry2.FINDSET THEN BEGIN
                REPEAT
                    MSPTValue := MSPTValue + DtldMSPTVendLedgEntry2."MSPT Amount";
                UNTIL DtldMSPTVendLedgEntry2.NEXT = 0;
            END;

            DtldMSPTVendLedgEntry2.SETRANGE("MSPT Vend. Led. Entry No.", DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No.");
            DtldMSPTVendLedgEntry2.SETRANGE("Entry Type", DtldMSPTVendLedgEntry."Entry Type"::"Unrealized Loss");
            IF DtldMSPTVendLedgEntry2.FINDFIRST THEN BEGIN
                IF CheckAmount <= -MSPTValue THEN BEGIN
                    Value := CheckAmount;
                    CheckAmount := CheckAmount + MSPTValue;
                END ELSE
                    IF CheckAmount > -MSPTValue THEN BEGIN
                        Value := -(MSPTValue);
                        CheckAmount := CheckAmount + MSPTValue;
                    END;
            END;
            DtldMSPTVendLedgEntry.FINDFIRST;
            REPEAT
                DtldMSPTVendLedgEntry.SETRANGE(DtldMSPTVendLedgEntry."MSPT Dtld. Entry No.", NextEntryNo1);
                IF DtldMSPTVendLedgEntry.FINDFIRST THEN BEGIN
                    IF Value > 0 THEN BEGIN
                        DtldMSPTVendLedgEntry."MSPT Amount" := Value;
                        DtldMSPTVendLedgEntry.MODIFY;
                    END ELSE BEGIN
                        DtldMSPTVendLedgEntry."MSPT Amount" := 0;
                        DtldMSPTVendLedgEntry.MODIFY;
                    END;
                END;

                IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                    DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                    DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                END ELSE BEGIN
                    DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                    DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                END;
                DtldMSPTVendLedgEntry.MODIFY;
            UNTIL DtldMSPTVendLedgEntry.NEXT = 0;
        END;
    end;


    procedure UnrealizedGainEntry(DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry");
    var
        DtldMSPTVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry";
        NextEntryNo1: Integer;
        Value: Decimal;
        DtldMSPTVendLedgEntry2: Record "MSPT Dtld. Vendor Ledg. Entry";
        MSPTValue: Decimal;
    begin
        MSPTVendLedgEntry.CALCFIELDS("MSPT Remaining Amount");
        IF MSPTVendLedgEntry."MSPT Remaining Amount" <> 0 THEN BEGIN
            IF DtldMSPTVendLedgEntry.FINDLAST THEN
                NextEntryNo1 := DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." + 1
            ELSE
                NextEntryNo1 := 1;
            DtldMSPTVendLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
            DtldMSPTVendLedgEntry."Entry No." := DtldVendLedgEntry."Entry No.";
            DtldMSPTVendLedgEntry."Vendor Ledger Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
            DtldMSPTVendLedgEntry."Entry Type" := DtldVendLedgEntry."Entry Type";
            DtldMSPTVendLedgEntry."Posting Date" := DtldVendLedgEntry."Posting Date";
            DtldMSPTVendLedgEntry."Document Type" := DtldVendLedgEntry."Document Type";
            DtldMSPTVendLedgEntry."Document No." := DtldVendLedgEntry."Document No.";
            DtldMSPTVendLedgEntry.Amount := DtldVendLedgEntry.Amount;
            DtldMSPTVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)";
            DtldMSPTVendLedgEntry."Vendor No." := DtldVendLedgEntry."Vendor No.";
            DtldMSPTVendLedgEntry."Currency Code" := DtldVendLedgEntry."Currency Code";
            DtldMSPTVendLedgEntry."User ID" := DtldVendLedgEntry."User ID";
            DtldMSPTVendLedgEntry."Source Code" := DtldVendLedgEntry."Source Code";
            DtldMSPTVendLedgEntry."Transaction No." := DtldVendLedgEntry."Transaction No.";
            DtldMSPTVendLedgEntry."Journal Batch Name" := DtldVendLedgEntry."Journal Batch Name";
            DtldMSPTVendLedgEntry."Reason Code" := DtldVendLedgEntry."Reason Code";
            DtldMSPTVendLedgEntry."Debit Amount" := DtldVendLedgEntry."Debit Amount";
            DtldMSPTVendLedgEntry."Credit Amount" := DtldVendLedgEntry."Credit Amount";
            DtldMSPTVendLedgEntry."Debit Amount (LCY)" := DtldVendLedgEntry."Debit Amount (LCY)";
            DtldMSPTVendLedgEntry."Credit Amount (LCY)" := DtldVendLedgEntry."Credit Amount (LCY)";
            DtldMSPTVendLedgEntry."Initial Entry Due Date" := DtldVendLedgEntry."Initial Entry Due Date";
            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 1" := DtldVendLedgEntry."Initial Entry Global Dim. 1";
            DtldMSPTVendLedgEntry."Initial Entry Global Dim. 2" := DtldVendLedgEntry."Initial Entry Global Dim. 2";
            DtldMSPTVendLedgEntry."Initial Document Type" := DtldVendLedgEntry."Initial Document Type";
            //  DtldMSPTVendLedgEntry."Import Document" := DtldVendLedgEntry."Import Document";
            //DtldMSPTVendLedgEntry."TDS Nature of Deduction" := DtldVendLedgEntry."TDS Nature of Deduction";
            //DtldMSPTVendLedgEntry."TDS Group" := DtldVendLedgEntry."TDS Group";
            // DtldMSPTVendLedgEntry."Total TDS Including eCESS" := DtldVendLedgEntry."Total TDS Including SHECESS";
            DtldMSPTVendLedgEntry."MSPT Header Code" := MSPTVendLedgEntry."MSPT Header Code";
            DtldMSPTVendLedgEntry."MSPT Line No." := MSPTVendLedgEntry."MSPT Line No.";
            DtldMSPTVendLedgEntry."MSPT Due Date" := MSPTVendLedgEntry."MSPT Due Date";
            DtldMSPTVendLedgEntry."MSPT Line Code" := MSPTVendLedgEntry."MSPT Line Code";
            DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No." := MSPTVendLedgEntry."MSPT Entry No.";
            DtldMSPTVendLedgEntry."MSPT Amount" := 0;
            DtldMSPTVendLedgEntry.INSERT;

            DtldMSPTVendLedgEntry2.SETRANGE("MSPT Vend. Led. Entry No.", DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No.");
            DtldMSPTVendLedgEntry2.SETRANGE("Entry Type", DtldMSPTVendLedgEntry."Entry Type"::"Unrealized Gain");
            IF DtldMSPTVendLedgEntry2.FINDSET THEN BEGIN
                REPEAT
                    MSPTValue := MSPTValue + DtldMSPTVendLedgEntry2."MSPT Amount";
                UNTIL DtldMSPTVendLedgEntry2.NEXT = 0;
            END;

            DtldMSPTVendLedgEntry2.SETRANGE("MSPT Vend. Led. Entry No.", DtldMSPTVendLedgEntry."MSPT Vend. Led. Entry No.");
            DtldMSPTVendLedgEntry2.SETRANGE("Entry Type", DtldMSPTVendLedgEntry."Entry Type"::"Unrealized Gain");
            IF DtldMSPTVendLedgEntry2.FINDFIRST THEN BEGIN
                IF -(CheckAmount1) <= (MSPTValue) THEN BEGIN
                    Value := CheckAmount1;
                    CheckAmount1 := CheckAmount1 + MSPTValue;
                END ELSE
                    IF -(CheckAmount1) > MSPTValue THEN BEGIN
                        Value := -(MSPTValue);
                        CheckAmount1 := CheckAmount1 + MSPTValue;
                    END;
            END;

            DtldMSPTVendLedgEntry.FINDFIRST;
            REPEAT
                DtldMSPTVendLedgEntry.SETRANGE(DtldMSPTVendLedgEntry."MSPT Dtld. Entry No.", NextEntryNo1);
                IF DtldMSPTVendLedgEntry.FINDFIRST THEN BEGIN
                    IF Value < 0 THEN BEGIN
                        DtldMSPTVendLedgEntry."MSPT Amount" := Value;
                        DtldMSPTVendLedgEntry.MODIFY;
                    END ELSE BEGIN
                        DtldMSPTVendLedgEntry."MSPT Amount" := 0;
                        DtldMSPTVendLedgEntry.MODIFY;
                    END;
                END;

                IF DtldMSPTVendLedgEntry."MSPT Amount" < 0 THEN BEGIN
                    DtldMSPTVendLedgEntry."MSPT Credit Value" := -(DtldMSPTVendLedgEntry."MSPT Amount");
                    DtldMSPTVendLedgEntry."MSPT Debit Value" := 0;
                END ELSE BEGIN
                    DtldMSPTVendLedgEntry."MSPT Debit Value" := DtldMSPTVendLedgEntry."MSPT Amount";
                    DtldMSPTVendLedgEntry."MSPT Credit Value" := 0;
                END;
                DtldMSPTVendLedgEntry.MODIFY;
            UNTIL DtldMSPTVendLedgEntry.NEXT = 0;
        END;
    end;
}

