page 60095 "FDR Card"
{
    // version B2B1.0,DIM1.0,Rev01

    // PROJECT : Efftronics
    // *********************************************************************
    // SIGN
    // *********************************************************************
    // B2B     : B2B Softwarre Technologies
    // *********************************************************************
    // VER      SIGN      USERID          DATE          DESCRIPTION
    // *********************************************************************
    // 1.0       B2B    PallaJagadeesh    11-May-13     ->Code in OnAfterGetRecord() and added the functions(from "NoOnBeforeInput"
    //                                                    to "ReceiptAccountNoOnBeforeInput") to convey the OnBeforeInput()
    //                                                    trigger in Pages.

    PageType = Card;
    SourceTable = "FDR Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("FDR Document No."; Rec."FDR Document No.")
                {
                    ApplicationArea = All;
                }
                field("Mode of Payment"; Rec."Mode of Payment")
                {
                    ApplicationArea = All;
                }
                field("Payment Account No."; Rec."Payment Account No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Issuing Bank"; Rec."Issuing Bank")
                {
                    ApplicationArea = All;
                }
                field("Date of Issue"; Rec."Date of Issue")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("FDR Value"; Rec."FDR Value")
                {
                    ApplicationArea = All;
                }
                field("Mode of Receipt"; Rec."Mode of Receipt")
                {
                    ApplicationArea = All;
                }
                field("Receipt Account No."; Rec."Receipt Account No.")
                {
                    ApplicationArea = All;
                }
                field("FDR Posting Status"; Rec."FDR Posting Status")
                {
                    ApplicationArea = All;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field(Extended; Rec.Extended)
                {
                    ApplicationArea = All;
                }
                field("FDR Surrended Date"; Rec."FDR Surrended Date")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Issued/Received"; Rec."Issued/Received")
                {
                    ApplicationArea = All;
                }
                field("Posting Account No."; Rec."Posting Account No.")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    Caption = 'Linked to Tender.';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Order No."; Rec."Customer Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.FDRAttachments;
                    end;
                }
                separator(Action1102152059)
                {
                }
                action("FDR Re&lease")
                {
                    Caption = 'FDR Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF Rec.Status = Rec.Status::Released THEN
                            EXIT;
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD("Issuing Bank");
                        Rec.TESTFIELD("FDR Value");
                        Rec.TESTFIELD("Payment Account No.");
                        IF CONFIRM('Do you want to Release?') THEN BEGIN
                            Rec.Status := Rec.Status::Released;
                            MESSAGE('The FDR has been Released.')
                        END ELSE
                            EXIT;
                        CurrPage.UPDATE;
                    end;
                }
                action("FDR Re&open")
                {
                    Caption = 'FDR Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF Rec.Status = Rec.Status::Open THEN
                            EXIT;
                        IF Rec.Status <> Rec.Status::Released THEN
                            IF CONFIRM('Do you want to Reopen?') THEN
                                Rec.Status := Rec.Status::Open
                            ELSE
                                EXIT
                        ELSE
                            ERROR('You can not open the Closed FDR');
                        CurrPage.UPDATE;
                    end;
                }
                action("&Close FDR")
                {
                    Caption = '&Close FDR';
                    Image = Close;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF Rec.Closed = TRUE THEN
                            EXIT;
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        IF CONFIRM('Do you want to close FDR?') THEN BEGIN
                            MESSAGE('The FDR has been closed.');
                            Rec.Closed := TRUE;
                        END ELSE
                            EXIT;
                        CurrPage.UPDATE;
                    end;
                }
                separator(Action1102152050)
                {
                }
                group(Post)
                {
                    Caption = 'Post';
                    Image = Post;
                    action(Purchase)
                    {
                        Caption = 'Purchase';
                        Image = Purchase;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            IF NOT CONFIRM(Text001, FALSE, Rec."No.") THEN
                                EXIT;

                            Rec.TESTFIELD("Posting Account No.");
                            Rec.TESTFIELD("No.");
                            Rec.TESTFIELD("FDR Value");
                            Rec.TESTFIELD(Status, Rec.Status::Released);
                            Rec.TESTFIELD(Posted, FALSE);
                            IF Rec."Mode of Payment" = Rec."Mode of Payment"::Cash THEN BEGIN
                                "AccountNo." := Rec."Posting Account No.";
                                AccountType := AccountType::"G/L Account";
                                "BalAccountNo." := Rec."Payment Account No.";
                                BalAccountType := BalAccountType::"G/L Account";
                                Amount := Rec."FDR Value";
                                InitGenJnlLine(Rec, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, Amount);
                                Rec.Posted := TRUE;
                                Rec.MODIFY;
                            END ELSE
                                IF Rec."Mode of Payment" = Rec."Mode of Payment"::Bank THEN BEGIN
                                    "AccountNo." := Rec."Posting Account No.";
                                    AccountType := AccountType::"G/L Account";
                                    "BalAccountNo." := Rec."Payment Account No.";
                                    BalAccountType := BalAccountType::"Bank Account";
                                    Amount := Rec."FDR Value";
                                    InitGenJnlLine(Rec, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, Amount);
                                    Rec.Posted := TRUE;
                                    Rec.MODIFY;
                                END;
                            Rec."FDR Posting Status" := Rec."FDR Posting Status"::Purchased;
                            Rec.MODIFY;
                            MESSAGE(Text002, Rec."No.");
                        end;
                    }
                    action(Receipt)
                    {
                        Caption = 'Receipt';
                        Image = Receipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            IF NOT CONFIRM(Text003, FALSE, Rec."No.") THEN
                                EXIT;

                            Rec.TESTFIELD("Receipt Account No.");
                            Rec.TESTFIELD("No.");
                            Rec.TESTFIELD("FDR Value");
                            Rec.TESTFIELD(Status, Rec.Status::Released);
                            Rec.TESTFIELD(Posted, TRUE);
                            Rec.TESTFIELD("Issued/Received", Rec."Issued/Received"::Received);
                            IF Rec."Mode of Receipt" = Rec."Mode of Receipt"::Cash THEN BEGIN
                                "AccountNo." := Rec."Posting Account No.";
                                AccountType := AccountType::"G/L Account";
                                "BalAccountNo." := Rec."Receipt Account No.";
                                BalAccountType := BalAccountType::"G/L Account";
                                Amount := -Rec."FDR Value";
                                InitGenJnlLine(Rec, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, Amount);
                                Rec.Posted := FALSE;
                                Rec.MODIFY;
                            END ELSE
                                IF Rec."Mode of Receipt" = Rec."Mode of Receipt"::Bank THEN BEGIN
                                    "AccountNo." := Rec."Posting Account No.";
                                    AccountType := AccountType::"G/L Account";
                                    "BalAccountNo." := Rec."Receipt Account No.";
                                    BalAccountType := BalAccountType::"Bank Account";
                                    Amount := -Rec."FDR Value";
                                    InitGenJnlLine(Rec, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, Amount);
                                    Rec.Posted := FALSE;
                                    Rec.MODIFY;
                                END;
                            Rec."FDR Posting Status" := Rec."FDR Posting Status"::Surrendered;
                            Rec."FDR Surrended Date" := WORKDATE;
                            Rec.MODIFY;
                            MESSAGE(Text002, Rec."No.");
                        end;
                    }
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //B2b1.0>>
        NoOnBeforeInput;
        FDRDocumentNoOnBeforeInput;
        ModeofPaymentOnBeforeInput;
        DescriptionOnBeforeInput;
        IssuingBankOnBeforeInput;
        DateofIssueOnBeforeInput;
        ExpiryDateOnBeforeInput;
        FDRValueOnBeforeInput;
        RemarksOnBeforeInput;
        ExtendedOnBeforeInput;
        PaymentAccountNoOnBeforeInput;
        PostingAccountNoOnBeforeInput;
        ModeofReceiptOnBeforeInput;
        ReceiptAccountNoOnBeforeInput;
        //B2b1.0<<
    end;

    var
        "AccountNo.": Code[20];
        "BalAccountNo.": Code[20];
        AccountType: Enum "Gen. Journal Account Type";
        BalAccountType: Enum "Gen. Journal Account Type";
        Amount: Decimal;
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        Text001: Label 'Do you want to Purchase the FDR No. %1?';
        Text002: Label 'FDR No. %1 Posted Successfully.';
        Text003: Label 'Do you want to Receive the FDR No. %1?';
        Text004: Label 'FDR No. %1 Posted Successfully.';

        NoHideValue: Boolean;

        FDRDocNoHidevalue: Boolean;

        ModeofPayment: Boolean;

        DescriptionHideValue: Boolean;

        IssuingBankHideValue: Boolean;

        DateofIssueHideValue: Boolean;

        ExpiryDateHideValue: Boolean;

        FDRHideValue: Boolean;

        RemarksHideValue: Boolean;

        ExtendedHideValue: Boolean;

        PaymentAccNoHideValue: Boolean;

        PostingAccNoHideValue: Boolean;

        ModeofReceiptHidevalue: Boolean;

        ReceiptAccNoHidevalue: Boolean;

    procedure InitGenJnlLine(var Rec: Record "FDR Master"; "AccountNo.": Code[20]; "BalAccountNo.": Code[20]; AccountType: Enum "Gen. Journal Account Type"; BalAccountType: Enum "Gen. Journal Account Type"; Amount: Decimal);
    var
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        PostingGroups: Record "Tender Posting Groups";
    begin
        GenJnlLine.INIT;
        GenJnlLine."Account Type" := AccountType;
        GenJnlLine."Account No." := "AccountNo.";
        GenJnlLine."Posting Date" := WORKDATE;
        GenJnlLine."Document No." := Rec."No.";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine.Description := Rec.Description;
        GenJnlLine."Bal. Account No." := "BalAccountNo.";
        GenJnlLine."Bal. Account Type" := BalAccountType;
        GenJnlLine.Amount := Amount;
        GenJnlLine.VALIDATE(Amount);
        //GenJnlLine."Cheque No." := TenderPostingLine."Cheque No.";
        //GenJnlLine."Cheque Date" := TenderPostingLine."Cheque Date.";
        GenJnlLine."Source Code" := 'GENJNL';

        //DIM1.0 Start
        //Code Comment
        /*
        TempJnlLineDim.DELETEALL;
        TempDocDim.RESET;
        TempDocDim.SETRANGE("Table ID",DATABASE::"Tender Posting Lines");
        DimMgt.CopyDocDimToJnlLineDim(TempDocDim,TempJnlLineDim);
        GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim);
        */
        // Rev01 >>


        // Rev01 <<

        GenJnlPostLine.RunWithCheck(GenJnlLine);

        //DIM1.0 End;

    end;

    local procedure NoOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            NoHideValue := FALSE
        ELSE
            NoHideValue := TRUE;

        /* CurrPage."No.".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."No.".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure FDRDocumentNoOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            FDRDocNoHidevalue := FALSE
        ELSE
            FDRDocNoHidevalue := TRUE;

        /* CurrPage."FDR Document No.".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."FDR Document No.".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure ModeofPaymentOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            ModeofPayment := FALSE
        ELSE
            ModeofPayment := TRUE;

        /* CurrPage."Mode of Payment".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Mode of Payment".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure DescriptionOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            DescriptionHideValue := FALSE
        ELSE
            DescriptionHideValue := TRUE;

        /* CurrPage.Description.UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage.Description.UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure IssuingBankOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            IssuingBankHideValue := FALSE
        ELSE
            IssuingBankHideValue := TRUE;

        /* CurrPage."Issuing Bank".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Issuing Bank".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure DateofIssueOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            DateofIssueHideValue := FALSE
        ELSE
            DateofIssueHideValue := TRUE;

        /* CurrPage."Date of Issue".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Date of Issue".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure ExpiryDateOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            ExpiryDateHideValue := FALSE
        ELSE
            ExpiryDateHideValue := TRUE;

        /* CurrPage."Expiry Date".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Expiry Date".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure FDRValueOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            FDRHideValue := FALSE
        ELSE
            FDRHideValue := TRUE;

        /* CurrPage."FDR Value".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."FDR Value".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure RemarksOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            RemarksHideValue := FALSE
        ELSE
            RemarksHideValue := TRUE;

        /* CurrPage.Remarks.UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage.Remarks.UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure ExtendedOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            ExtendedHideValue := FALSE
        ELSE
            ExtendedHideValue := TRUE;

        /* CurrPage.Extended.UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage.Extended.UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure PaymentAccountNoOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            PaymentAccNoHideValue := FALSE
        ELSE
            PaymentAccNoHideValue := TRUE;

        /* CurrPage."Payment Account No.".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Payment Account No.".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure PostingAccountNoOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            PostingAccNoHideValue := FALSE
        ELSE
            PostingAccNoHideValue := TRUE;

        /*  CurrPage."Posting Account No.".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Posting Account No.".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure ModeofReceiptOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            ModeofReceiptHidevalue := FALSE
        ELSE
            ModeofReceiptHidevalue := TRUE;

        /* CurrPage."Mode of Receipt".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Mode of Receipt".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;

    local procedure ReceiptAccountNoOnBeforeInput();
    begin
        IF Rec.Status = Rec.Status::Released THEN
            //B2b1.0>>
            ReceiptAccNoHidevalue := FALSE
        ELSE
            ReceiptAccNoHidevalue := TRUE;

        /* CurrPage."Receipt Account No.".UPDATEEDITABLE(FALSE)
        ELSE
          CurrPage."Receipt Account No.".UPDATEEDITABLE(TRUE)
        *///B2b1.0<<

    end;
}

