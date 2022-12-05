codeunit 60007 "MSPT Customer Entries"
{
    // version MSPT1.0

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Customer Entries


    trigger OnRun();
    begin
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        Remainamount: Decimal;
        CheckAmount: Decimal;
        Checkamount1: Decimal;


    procedure PostMSPTCustLedgerEntries(CustLedgEntry: Record "Cust. Ledger Entry");
    var
        MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry";
        NextEntryNo2: Integer;
        MSPTOrderDetails: Record "MSPT Order Details";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PostedMSPTOrderDetails: Record "Posted MSPT Order Details";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        MSPTCustLedgEntry.LOCKTABLE;
        MSPTCustLedgEntry.INIT;
        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."No.", CustLedgEntry."Document No.");
        IF SalesInvoiceHeader.FINDFIRST THEN
            PostedMSPTOrderDetails.SETRANGE("MSPT Header Code", SalesInvoiceHeader."MSPT Code");
        PostedMSPTOrderDetails.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        IF PostedMSPTOrderDetails.FINDSET THEN BEGIN
            REPEAT
                IF MSPTCustLedgEntry.FINDLAST THEN
                    NextEntryNo2 := MSPTCustLedgEntry."MSPT Entry No." + 1
                ELSE
                    NextEntryNo2 := 1;
                MSPTCustLedgEntry."MSPT Entry No." := NextEntryNo2;
                MSPTCustLedgEntry."MSPT Header Code" := PostedMSPTOrderDetails."MSPT Header Code";
                MSPTCustLedgEntry."MSPT Line No." := PostedMSPTOrderDetails."MSPT Line No.";
                MSPTCustLedgEntry."MSPT Due Date" := PostedMSPTOrderDetails."Due Date";
                MSPTCustLedgEntry."MSPT Line Code" := PostedMSPTOrderDetails."MSPT Code";
                MSPTCustLedgEntry."MSPT Percentage" := PostedMSPTOrderDetails.Percentage;
                MSPTCustLedgEntry."Entry No." := CustLedgEntry."Entry No.";
                MSPTCustLedgEntry."Customer No." := CustLedgEntry."Customer No.";
                MSPTCustLedgEntry."Posting Date" := CustLedgEntry."Posting Date";
                MSPTCustLedgEntry."Document Type" := CustLedgEntry."Document Type";
                MSPTCustLedgEntry."Document No." := CustLedgEntry."Document No.";
                MSPTCustLedgEntry."External Document No." := CustLedgEntry."External Document No.";
                MSPTCustLedgEntry.Description := CustLedgEntry.Description;
                MSPTCustLedgEntry."Currency Code" := CustLedgEntry."Currency Code";
                MSPTCustLedgEntry."Sales (LCY)" := CustLedgEntry."Sales (LCY)";
                MSPTCustLedgEntry."Profit (LCY)" := CustLedgEntry."Profit (LCY)";
                MSPTCustLedgEntry."Inv. Discount (LCY)" := CustLedgEntry."Inv. Discount (LCY)";
                MSPTCustLedgEntry."Sell-to Customer No." := CustLedgEntry."Sell-to Customer No.";
                MSPTCustLedgEntry."Customer Posting Group" := CustLedgEntry."Customer Posting Group";
                MSPTCustLedgEntry."Global Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
                MSPTCustLedgEntry."Global Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
                MSPTCustLedgEntry."Salesperson Code" := CustLedgEntry."Salesperson Code";
                MSPTCustLedgEntry."Source Code" := CustLedgEntry."Source Code";
                MSPTCustLedgEntry."On Hold" := CustLedgEntry."On Hold";
                MSPTCustLedgEntry."Applies-to Doc. Type" := CustLedgEntry."Applies-to Doc. Type";
                MSPTCustLedgEntry."Applies-to Doc. No." := CustLedgEntry."Applies-to Doc. No.";
                MSPTCustLedgEntry."Due Date" := CustLedgEntry."Due Date";
                MSPTCustLedgEntry."Pmt. Discount Date" := CustLedgEntry."Pmt. Discount Date";
                MSPTCustLedgEntry."Applies-to ID" := CustLedgEntry."Applies-to ID";
                MSPTCustLedgEntry."Journal Batch Name" := CustLedgEntry."Journal Batch Name";
                MSPTCustLedgEntry."Reason Code" := CustLedgEntry."Reason Code";
                MSPTCustLedgEntry."Transaction No." := CustLedgEntry."Transaction No.";
                MSPTCustLedgEntry."User ID" := CustLedgEntry."User ID";
                MSPTCustLedgEntry."Document Date" := CustLedgEntry."Document Date";
                MSPTCustLedgEntry."Bal. Account Type" := CustLedgEntry."Bal. Account Type";
                MSPTCustLedgEntry."Bal. Account No." := CustLedgEntry."Bal. Account No.";
                MSPTCustLedgEntry."No. Series" := CustLedgEntry."No. Series";
                //B2B  MSPTCustLedgEntry."Export Document"  := CustLedgEntry."Export Document";
                //MSPTCustLedgEntry."TDS Nature of Deduction" := CustLedgEntry."TDS Nature of Deduction";
                // MSPTCustLedgEntry."TDS Group" := CustLedgEntry."TDS Group";
                //  MSPTCustLedgEntry."Total TDS Including eCESS" := CustLedgEntry."Total TDS/TCS Incl SHE CESS";
                MSPTCustLedgEntry.Open := CustLedgEntry.Open;
                MSPTCustLedgEntry.INSERT;
            UNTIL PostedMSPTOrderDetails.NEXT = 0;
        END ELSE BEGIN
            IF MSPTCustLedgEntry.FINDLAST THEN
                NextEntryNo2 := MSPTCustLedgEntry."MSPT Entry No." + 1
            ELSE
                NextEntryNo2 := 1;
            MSPTCustLedgEntry."MSPT Entry No." := NextEntryNo2;
            MSPTCustLedgEntry."MSPT Header Code" := '';
            MSPTCustLedgEntry."MSPT Line No." := 0;
            MSPTCustLedgEntry."MSPT Due Date" := CustLedgEntry."Due Date";
            MSPTCustLedgEntry."Entry No." := CustLedgEntry."Entry No.";
            MSPTCustLedgEntry."Customer No." := CustLedgEntry."Customer No.";
            MSPTCustLedgEntry."Posting Date" := CustLedgEntry."Posting Date";
            MSPTCustLedgEntry."Document Type" := CustLedgEntry."Document Type";
            MSPTCustLedgEntry.Open := CustLedgEntry.Open;
            MSPTCustLedgEntry."Document No." := CustLedgEntry."Document No.";
            MSPTCustLedgEntry."External Document No." := CustLedgEntry."External Document No.";
            MSPTCustLedgEntry.Description := CustLedgEntry.Description;
            MSPTCustLedgEntry."Currency Code" := CustLedgEntry."Currency Code";
            MSPTCustLedgEntry."Sales (LCY)" := CustLedgEntry."Sales (LCY)";
            MSPTCustLedgEntry."Profit (LCY)" := CustLedgEntry."Profit (LCY)";
            MSPTCustLedgEntry."Inv. Discount (LCY)" := CustLedgEntry."Inv. Discount (LCY)";
            MSPTCustLedgEntry."Document Date" := CustLedgEntry."Document Date";
            MSPTCustLedgEntry."Sell-to Customer No." := CustLedgEntry."Sell-to Customer No.";
            MSPTCustLedgEntry."Customer Posting Group" := CustLedgEntry."Customer Posting Group";
            MSPTCustLedgEntry."Global Dimension 1 Code" := CustLedgEntry."Global Dimension 1 Code";
            MSPTCustLedgEntry."Global Dimension 2 Code" := CustLedgEntry."Global Dimension 2 Code";
            MSPTCustLedgEntry."Salesperson Code" := CustLedgEntry."Salesperson Code";
            MSPTCustLedgEntry."Source Code" := CustLedgEntry."Source Code";
            MSPTCustLedgEntry."On Hold" := CustLedgEntry."On Hold";
            MSPTCustLedgEntry."Applies-to Doc. Type" := CustLedgEntry."Applies-to Doc. Type";
            MSPTCustLedgEntry."Applies-to Doc. No." := CustLedgEntry."Applies-to Doc. No.";
            MSPTCustLedgEntry."Due Date" := CustLedgEntry."Due Date";
            MSPTCustLedgEntry."Pmt. Discount Date" := CustLedgEntry."Pmt. Discount Date";
            MSPTCustLedgEntry."Applies-to ID" := CustLedgEntry."Applies-to ID";
            MSPTCustLedgEntry."Journal Batch Name" := CustLedgEntry."Journal Batch Name";
            MSPTCustLedgEntry."Reason Code" := CustLedgEntry."Reason Code";
            MSPTCustLedgEntry."Transaction No." := CustLedgEntry."Transaction No.";
            MSPTCustLedgEntry."User ID" := CustLedgEntry."User ID";
            MSPTCustLedgEntry."Bal. Account Type" := CustLedgEntry."Bal. Account Type";
            MSPTCustLedgEntry."Bal. Account No." := CustLedgEntry."Bal. Account No.";
            MSPTCustLedgEntry."No. Series" := CustLedgEntry."No. Series";
            //B2B  MSPTCustLedgEntry."Export Document"  := CustLedgEntry."Export Document";
            //MSPTCustLedgEntry."TDS Nature of Deduction" := CustLedgEntry."TDS Nature of Deduction";
            MSPTCustLedgEntry."MSPT Percentage" := 0;
            // MSPTCustLedgEntry."TDS Group" := CustLedgEntry."TDS Group";
            MSPTCustLedgEntry."MSPT Line Code" := '';
            //MSPTCustLedgEntry."Total TDS Including eCESS" := CustLedgEntry."Total TDS/TCS Incl SHE CESS";
            MSPTCustLedgEntry.INSERT;
        END;
    end;


    procedure CheckStatus(DtldMSPTCustLedgEntry: Record "MSPT Dtld. Cust. Ledg. Entry"; MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry");
    var
        Value: Decimal;
    begin
        DtldMSPTCustLedgEntry.SETRANGE("MSPT Cust. Led. Entry No.", MSPTCustLedgEntry."MSPT Entry No.");
        IF DtldMSPTCustLedgEntry.FINDSET THEN
            REPEAT
                Value := DtldMSPTCustLedgEntry."MSPT Amount" + Value;
            UNTIL DtldMSPTCustLedgEntry.NEXT = 0;
        IF Value = 0 THEN BEGIN
            MSPTCustLedgEntry.SETRANGE("MSPT Entry No.", DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No.");
            IF MSPTCustLedgEntry.FINDFIRST THEN BEGIN
                MSPTCustLedgEntry.Open := FALSE;
                MSPTCustLedgEntry.MODIFY;
            END;
        END;
    end;


    procedure PostMSPTDtldCustLedgEntries(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry");
    var
        DtldMSPTCustLedgEntry: Record "MSPT Dtld. Cust. Ledg. Entry";
        NextEntryNo1: Integer;
        DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry";
        Amount: Decimal;
        I: Integer;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        PostedMSPTOrderDetails: Record "Posted MSPT Order Details";
        MSPTOrderDetails: Record "MSPT Order Details";
    begin
        DtldMSPTCustLedgEntry.LOCKTABLE;
        DtldMSPTCustLedgEntry.INIT;
        IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
            CheckAmount := DtldCustLedgEntry."Amount (LCY)";
        END ELSE
            IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                Checkamount1 := DtldCustLedgEntry."Amount (LCY)";
            END;
        Amount := DtldCustLedgEntry."Amount (LCY)";
        I := 0;
        MSPTCustLedgEntry.FINDFIRST;
        MSPTCustLedgEntry.SETRANGE(MSPTCustLedgEntry."Entry No.", DtldCustLedgEntry."Cust. Ledger Entry No.");
        IF MSPTCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF (I = 0) THEN BEGIN
                    IF DtldMSPTCustLedgEntry.FINDLAST THEN
                        NextEntryNo1 := DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." + 1
                    ELSE
                        NextEntryNo1 := 1;

                    //For Detailed MSPT "Initial Entry"
                    IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Initial Entry") AND
                       (DtldCustLedgEntry."Document Type" <> DtldCustLedgEntry."Document Type"::Invoice)
                    THEN BEGIN
                        DtldMSPTCustLedgEntry."MSPT Amount" := DtldCustLedgEntry."Amount (LCY)";
                        DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                        DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                        DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                        DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                        DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                        DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                        DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                        DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                        DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                        DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                        DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                        DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                        DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                        DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                        DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                        DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                        DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                        DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                        DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                        DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                        DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                        DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                        DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                        DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                        //B2B DtldMSPTCustLedgEntry."Export Document"  := DtldCustLedgEntry."Export Document";
                        // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                        // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                        //DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                        DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                        DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                        DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                        DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                        DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                        IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                            DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                            DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                        END ELSE BEGIN
                            DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                            DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                        END;
                        DtldMSPTCustLedgEntry.INSERT;
                        CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);

                        //BHAVANI
                        //For Unrealized loss and Unrealized Gain
                    END ELSE
                        IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Unrealized Loss") THEN BEGIN
                            IF CheckAmount > 0 THEN BEGIN
                                UnrealizedLossEntry(DtldCustLedgEntry, MSPTCustLedgEntry);
                                CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                            END ELSE BEGIN
                            END;
                        END ELSE
                            IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::"Unrealized Gain") THEN BEGIN
                                IF Checkamount1 < 0 THEN BEGIN
                                    UnrealizedGainEntry(DtldCustLedgEntry, MSPTCustLedgEntry);
                                    CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                                END ELSE BEGIN
                                END;

                                //For Detailed MSPT "Payment Discount"
                            END ELSE
                                IF (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Initial Entry") AND
                                   (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::Application) AND
                                   (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Unrealized Loss") AND
                                   (DtldCustLedgEntry."Entry Type" <> DtldCustLedgEntry."Entry Type"::"Unrealized Gain")
                       THEN BEGIN
                                    DtldMSPTCustLedgEntry."MSPT Amount" := DtldCustLedgEntry."Amount (LCY)";
                                    DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                    DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                                    DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                                    DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                                    DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                                    DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                                    DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                                    DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                                    DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                                    DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                                    DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                                    DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                                    DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                                    DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                                    DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                                    DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                                    DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                                    DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                                    DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                                    DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                                    DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                                    DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                                    //B2B         DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                                    // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                                    // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                                    // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                                    DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                                    DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                                    DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                                    DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                                    DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                                    IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                        DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                                        DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                                    END ELSE BEGIN
                                        DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                                        DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                                    END;
                                    DtldMSPTCustLedgEntry.INSERT;
                                    CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);

                                    //For Detailed MSPT "APPlicaiton"
                                END ELSE
                                    IF (DtldCustLedgEntry."Entry Type" = DtldCustLedgEntry."Entry Type"::Application) THEN BEGIN
                                        MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."MSPT Remaining Amount");
                                        IF (-(Amount) = MSPTCustLedgEntry."MSPT Remaining Amount") OR
                                           (-(Amount) < MSPTCustLedgEntry."MSPT Remaining Amount")
                                        THEN BEGIN
                                            DtldMSPTCustLedgEntry."MSPT Amount" := Amount;
                                            I := 1;
                                            DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                            DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                                            DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                                            DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                                            DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                                            DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                                            DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                                            DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                                            DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                                            DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                                            DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                                            DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                                            DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                                            DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                                            DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                                            DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                                            DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                                            DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                                            DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                                            DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                                            DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                                            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                                            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                                            DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                                            //B2B  DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                                            // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                                            // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                                            // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                                            DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                                            DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                                            DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                                            DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                                            DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                                            IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                                                DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                                            END ELSE BEGIN
                                                DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                                                DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                                            END;
                                            DtldMSPTCustLedgEntry.INSERT;
                                            CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);

                                        END ELSE
                                            IF (-(Amount) > MSPTCustLedgEntry."MSPT Remaining Amount") THEN BEGIN
                                                MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."MSPT Remaining Amount");
                                                IF MSPTCustLedgEntry."MSPT Remaining Amount" = 0 THEN BEGIN
                                                END ELSE BEGIN
                                                    DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                                    DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                                                    DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                                                    DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                                                    DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                                                    DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                                                    DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                                                    DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                                                    DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                                                    DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                                                    DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                                                    DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                                                    DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                                                    DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                                                    DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                                                    DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                                                    DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                                                    DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                                                    DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                                                    DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                                                    DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                                                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                                                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                                                    DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                                                    //B2B DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                                                    // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                                                    // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                                                    //  DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                                                    DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                                                    DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                                                    DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                                                    DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                                                    DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                                                    //BHAVANI
                                                    MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."MSPT Remaining Amount");
                                                    MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."Remaining Amount");
                                                    IF MSPTCustLedgEntry."Remaining Amount" < 0 THEN
                                                        DtldMSPTCustLedgEntry."MSPT Amount" := DtldCustLedgEntry."Amount (LCY)"
                                                    ELSE BEGIN
                                                        DtldMSPTCustLedgEntry."MSPT Amount" := -(MSPTCustLedgEntry."MSPT Remaining Amount");
                                                        Amount := Amount + MSPTCustLedgEntry."MSPT Remaining Amount";
                                                    END;
                                                    IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                        DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                                                        DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                                                    END ELSE BEGIN
                                                        DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                                                        DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                                                    END;
                                                    DtldMSPTCustLedgEntry.INSERT;
                                                    CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                                                END;
                                            END ELSE BEGIN
                                                DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                                DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                                                DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                                                DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                                                DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                                                DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                                                DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                                                DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                                                DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                                                DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                                                DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                                                DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                                                DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                                                DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                                                DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                                                DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                                                DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                                                DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                                                DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                                                DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                                                DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                                                DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                                                DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                                                DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                                                //B2B DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                                                //  DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                                                // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                                                //  DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                                                DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                                                DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                                                DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                                                DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                                                DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                                                DtldMSPTCustLedgEntry."MSPT Amount" := DtldCustLedgEntry."Amount (LCY)";
                                                IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                                    DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                                                    DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                                                END ELSE BEGIN
                                                    DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                                                    DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                                                END;
                                                DtldMSPTCustLedgEntry.INSERT;
                                                CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                                            END;
                                    END ELSE BEGIN
                                        DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                                        DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                                        DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                                        DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                                        DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                                        DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                                        DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                                        DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                                        DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                                        DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                                        DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                                        DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                                        DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                                        DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                                        DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                                        DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                                        DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                                        DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                                        DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                                        DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                                        DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                                        DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                                        DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                                        DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                                        //B2B  DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                                        //  DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                                        // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                                        // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                                        DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                                        DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                                        DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                                        DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                                        //BHAVANI
                                        IF MSPTCustLedgEntry."MSPT Percentage" = 0 THEN
                                            DtldMSPTCustLedgEntry."MSPT Amount" := DtldCustLedgEntry."Amount (LCY)"
                                        ELSE
                                            DtldMSPTCustLedgEntry."MSPT Amount" := (DtldCustLedgEntry."Amount (LCY)" * MSPTCustLedgEntry."MSPT Percentage") / 100;
                                        DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                                        IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                                            DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                                            DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                                        END ELSE BEGIN
                                            DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                                            DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                                        END;
                                        DtldMSPTCustLedgEntry.INSERT;
                                        CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                                    END;
                END;
            UNTIL MSPTCustLedgEntry.NEXT = 0;
        END;
    end;


    procedure PostMSPTExchangeAdjEntries(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry");
    var
        DtldMSPTCustLedgEntry: Record "MSPT Dtld. Cust. Ledg. Entry";
        NextEntryNo1: Integer;
        DtldCVLedgEntryBuf: Record "Detailed CV Ledg. Entry Buffer" temporary;
        MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry";
        RemainAmount1: Decimal;
    begin
        DtldMSPTCustLedgEntry.LOCKTABLE;
        DtldMSPTCustLedgEntry.INIT;
        RemainAmount1 := 0;
        MSPTCustLedgEntry.SETRANGE(MSPTCustLedgEntry."Entry No.", DtldCustLedgEntry."Cust. Ledger Entry No.");
        IF MSPTCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF MSPTCustLedgEntry.Open = TRUE THEN BEGIN
                    MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."MSPT Remaining Amount");
                    RemainAmount1 := MSPTCustLedgEntry."MSPT Remaining Amount" + RemainAmount1;
                END;
            UNTIL MSPTCustLedgEntry.NEXT = 0;
        END;

        MSPTCustLedgEntry.SETRANGE(MSPTCustLedgEntry."Entry No.", DtldCustLedgEntry."Cust. Ledger Entry No.");
        IF MSPTCustLedgEntry.FINDSET THEN BEGIN
            REPEAT
                IF MSPTCustLedgEntry.Open = TRUE THEN BEGIN
                    IF DtldMSPTCustLedgEntry.FINDLAST THEN
                        NextEntryNo1 := DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." + 1
                    ELSE
                        NextEntryNo1 := 1;

                    DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
                    DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
                    DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                    DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
                    DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
                    DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
                    DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
                    DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
                    DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
                    DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
                    DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
                    DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
                    DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
                    DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
                    DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
                    DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
                    DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
                    DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
                    DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
                    DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
                    DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
                    DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
                    DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
                    //  DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
                    // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
                    // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
                    // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
                    DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
                    DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
                    DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
                    DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
                    DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
                    MSPTCustLedgEntry.CALCFIELDS(MSPTCustLedgEntry."MSPT Remaining Amount");
                    DtldMSPTCustLedgEntry."MSPT Amount" := (MSPTCustLedgEntry."MSPT Remaining Amount" / RemainAmount1) *
                                                                               DtldCustLedgEntry."Amount (LCY)";
                    IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                        DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                        DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                    END ELSE BEGIN
                        DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                        DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                    END;
                    DtldMSPTCustLedgEntry.INSERT;
                    CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
                END;
                CheckStatus(DtldMSPTCustLedgEntry, MSPTCustLedgEntry);
            UNTIL MSPTCustLedgEntry.NEXT = 0;
        END;
    end;


    procedure UnrealizedLossEntry(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry");
    var
        DtldMSPTCustLedgEntry: Record "MSPT Dtld. Cust. Ledg. Entry";
        NextEntryNo1: Integer;
        Value: Decimal;
        DtldMSPTCustLedgEntry2: Record "MSPT Dtld. Cust. Ledg. Entry";
        MSPTValue: Decimal;
    begin
        MSPTCustLedgEntry.CALCFIELDS("MSPT Remaining Amount");
        IF MSPTCustLedgEntry."MSPT Remaining Amount" <> 0 THEN BEGIN
            IF DtldMSPTCustLedgEntry.FINDLAST THEN
                NextEntryNo1 := DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." + 1
            ELSE
                NextEntryNo1 := 1;
            DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
            DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
            DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
            DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
            DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
            DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
            DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
            DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
            DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
            DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
            DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
            DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
            DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
            DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
            DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
            DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
            DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
            DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
            DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
            DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
            DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
            DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
            // B2B  DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
            // DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
            // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
            // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
            DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
            DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
            DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
            DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
            DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
            DtldMSPTCustLedgEntry."MSPT Amount" := 0;
            DtldMSPTCustLedgEntry.INSERT;

            DtldMSPTCustLedgEntry2.SETRANGE("MSPT Cust. Led. Entry No.", DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No.");
            DtldMSPTCustLedgEntry2.SETRANGE("Entry Type", DtldMSPTCustLedgEntry."Entry Type"::"Unrealized Loss");
            IF DtldMSPTCustLedgEntry2.FINDSET THEN BEGIN
                REPEAT
                    MSPTValue := MSPTValue + DtldMSPTCustLedgEntry2."MSPT Amount";
                UNTIL DtldMSPTCustLedgEntry2.NEXT = 0;
            END;

            DtldMSPTCustLedgEntry2.SETRANGE("MSPT Cust. Led. Entry No.", DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No.");
            DtldMSPTCustLedgEntry2.SETRANGE("Entry Type", DtldMSPTCustLedgEntry."Entry Type"::"Unrealized Loss");
            IF DtldMSPTCustLedgEntry2.FINDFIRST THEN BEGIN
                IF CheckAmount <= -(MSPTValue) THEN BEGIN
                    Value := CheckAmount;
                    CheckAmount := CheckAmount + MSPTValue;
                END ELSE
                    IF CheckAmount > -(MSPTValue) THEN BEGIN
                        Value := -(MSPTValue);
                        CheckAmount := CheckAmount + MSPTValue;
                    END;
            END;

            DtldMSPTCustLedgEntry.FINDFIRST;
            REPEAT
                DtldMSPTCustLedgEntry.SETRANGE(DtldMSPTCustLedgEntry."MSPT Dtld. Entry No.", NextEntryNo1);
                IF DtldMSPTCustLedgEntry.FINDFIRST THEN BEGIN
                    IF Value > 0 THEN BEGIN
                        DtldMSPTCustLedgEntry."MSPT Amount" := Value;
                        DtldMSPTCustLedgEntry.MODIFY;
                    END ELSE BEGIN
                        DtldMSPTCustLedgEntry."MSPT Amount" := 0;
                        DtldMSPTCustLedgEntry.MODIFY;
                    END;
                END;
                IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                    DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                    DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                END ELSE BEGIN
                    DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                    DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                END;
                DtldMSPTCustLedgEntry.MODIFY;
            UNTIL DtldMSPTCustLedgEntry.NEXT = 0;
        END;
    end;


    procedure UnrealizedGainEntry(DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; MSPTCustLedgEntry: Record "MSPT Customer Ledger Entry");
    var
        DtldMSPTCustLedgEntry: Record "MSPT Dtld. Cust. Ledg. Entry";
        NextEntryNo1: Integer;
        Value: Decimal;
        DtldMSPTCustLedgEntry2: Record "MSPT Dtld. Cust. Ledg. Entry";
        MSPTValue: Decimal;
    begin
        MSPTCustLedgEntry.CALCFIELDS("MSPT Remaining Amount");
        IF MSPTCustLedgEntry."MSPT Remaining Amount" <> 0 THEN BEGIN
            IF DtldMSPTCustLedgEntry.FINDLAST THEN
                NextEntryNo1 := DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." + 1
            ELSE
                NextEntryNo1 := 1;
            DtldMSPTCustLedgEntry."MSPT Dtld. Entry No." := NextEntryNo1;
            DtldMSPTCustLedgEntry."Entry No." := DtldCustLedgEntry."Entry No.";
            DtldMSPTCustLedgEntry."Cust. Ledger Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
            DtldMSPTCustLedgEntry."Entry Type" := DtldCustLedgEntry."Entry Type";
            DtldMSPTCustLedgEntry."Posting Date" := DtldCustLedgEntry."Posting Date";
            DtldMSPTCustLedgEntry."Document Type" := DtldCustLedgEntry."Document Type";
            DtldMSPTCustLedgEntry."Document No." := DtldCustLedgEntry."Document No.";
            DtldMSPTCustLedgEntry.Amount := DtldCustLedgEntry.Amount;
            DtldMSPTCustLedgEntry."Amount (LCY)" := DtldCustLedgEntry."Amount (LCY)";
            DtldMSPTCustLedgEntry."Customer No." := DtldCustLedgEntry."Customer No.";
            DtldMSPTCustLedgEntry."Currency Code" := DtldCustLedgEntry."Currency Code";
            DtldMSPTCustLedgEntry."User ID" := DtldCustLedgEntry."User ID";
            DtldMSPTCustLedgEntry."Source Code" := DtldCustLedgEntry."Source Code";
            DtldMSPTCustLedgEntry."Transaction No." := DtldCustLedgEntry."Transaction No.";
            DtldMSPTCustLedgEntry."Journal Batch Name" := DtldCustLedgEntry."Journal Batch Name";
            DtldMSPTCustLedgEntry."Reason Code" := DtldCustLedgEntry."Reason Code";
            DtldMSPTCustLedgEntry."Debit Amount" := DtldCustLedgEntry."Debit Amount";
            DtldMSPTCustLedgEntry."Credit Amount" := DtldCustLedgEntry."Credit Amount";
            DtldMSPTCustLedgEntry."Debit Amount (LCY)" := DtldCustLedgEntry."Debit Amount (LCY)";
            DtldMSPTCustLedgEntry."Credit Amount (LCY)" := DtldCustLedgEntry."Credit Amount (LCY)";
            DtldMSPTCustLedgEntry."Initial Entry Due Date" := DtldCustLedgEntry."Initial Entry Due Date";
            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 1" := DtldCustLedgEntry."Initial Entry Global Dim. 1";
            DtldMSPTCustLedgEntry."Initial Entry Global Dim. 2" := DtldCustLedgEntry."Initial Entry Global Dim. 2";
            DtldMSPTCustLedgEntry."Initial Document Type" := DtldCustLedgEntry."Initial Document Type";
            //B2B   DtldMSPTCustLedgEntry."Export Document" := DtldCustLedgEntry."Export Document";
            //DtldMSPTCustLedgEntry."TDS Nature of Deduction" := DtldCustLedgEntry."TDS Nature of Deduction";
            // DtldMSPTCustLedgEntry."TDS Group" := DtldCustLedgEntry."TDS Group";
            // DtldMSPTCustLedgEntry."Total TDS Including eCESS" := DtldCustLedgEntry."Total TDS/TCS Incl. SHECESS";
            DtldMSPTCustLedgEntry."MSPT Header Code" := MSPTCustLedgEntry."MSPT Header Code";
            DtldMSPTCustLedgEntry."MSPT Line No." := MSPTCustLedgEntry."MSPT Line No.";
            DtldMSPTCustLedgEntry."MSPT Due Date" := MSPTCustLedgEntry."MSPT Due Date";
            DtldMSPTCustLedgEntry."MSPT Line Code" := MSPTCustLedgEntry."MSPT Line Code";
            DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No." := MSPTCustLedgEntry."MSPT Entry No.";
            DtldMSPTCustLedgEntry."MSPT Amount" := 0;
            DtldMSPTCustLedgEntry.INSERT;
            DtldMSPTCustLedgEntry2.SETRANGE("MSPT Cust. Led. Entry No.", DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No.");
            DtldMSPTCustLedgEntry2.SETRANGE("Entry Type", DtldMSPTCustLedgEntry."Entry Type"::"Unrealized Gain");
            IF DtldMSPTCustLedgEntry2.FINDSET THEN BEGIN
                REPEAT
                    MSPTValue := MSPTValue + DtldMSPTCustLedgEntry2."MSPT Amount";
                UNTIL DtldMSPTCustLedgEntry2.NEXT = 0;
            END;

            DtldMSPTCustLedgEntry2.SETRANGE("MSPT Cust. Led. Entry No.", DtldMSPTCustLedgEntry."MSPT Cust. Led. Entry No.");
            DtldMSPTCustLedgEntry2.SETRANGE("Entry Type", DtldMSPTCustLedgEntry."Entry Type"::"Unrealized Gain");
            IF DtldMSPTCustLedgEntry2.FINDFIRST THEN BEGIN
                IF -(Checkamount1) <= MSPTValue THEN BEGIN
                    Value := Checkamount1;
                    Checkamount1 := Checkamount1 + MSPTValue;
                END ELSE
                    IF -(Checkamount1) > (MSPTValue) THEN BEGIN
                        Value := -(MSPTValue);
                        Checkamount1 := Checkamount1 + MSPTValue;
                    END;
            END;

            DtldMSPTCustLedgEntry.FINDFIRST;
            REPEAT
                DtldMSPTCustLedgEntry.SETRANGE(DtldMSPTCustLedgEntry."MSPT Dtld. Entry No.", NextEntryNo1);
                IF DtldMSPTCustLedgEntry.FINDFIRST THEN BEGIN
                    IF Value < 0 THEN BEGIN
                        DtldMSPTCustLedgEntry."MSPT Amount" := Value;
                        DtldMSPTCustLedgEntry.MODIFY;
                    END ELSE BEGIN
                        DtldMSPTCustLedgEntry."MSPT Amount" := 0;
                        DtldMSPTCustLedgEntry.MODIFY;
                    END;
                END;

                IF DtldMSPTCustLedgEntry."MSPT Amount" < 0 THEN BEGIN
                    DtldMSPTCustLedgEntry."MSPT Credit Value" := -(DtldMSPTCustLedgEntry."MSPT Amount");
                    DtldMSPTCustLedgEntry."MSPT Debit Value" := 0;
                END ELSE BEGIN
                    DtldMSPTCustLedgEntry."MSPT Debit Value" := DtldMSPTCustLedgEntry."MSPT Amount";
                    DtldMSPTCustLedgEntry."MSPT Credit Value" := 0;
                END;
                DtldMSPTCustLedgEntry.MODIFY;
            UNTIL DtldMSPTCustLedgEntry.NEXT = 0;
        END;
    end;
}

