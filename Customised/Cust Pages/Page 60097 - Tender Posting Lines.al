page 60097 "Tender Posting Lines"
{
    // version B2B1.0,Rev01

    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "Tender Posting Lines";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Mode of Receipt / Payment"; Rec."Mode of Receipt / Payment")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    var
                        FDRMaster: Record "FDR Master";
                        TenderLedgerEntry: Record "Tender Ledger Entries";
                        GLAccount: Record "G/L Account";
                        BankAccount: Record "Bank Account";
                        BankGuarntee: Record "Bank Guarantee";
                        TenderHeader: Record "Tender Header";
                        Cust: Record Customer;
                    begin
                        CASE Rec.Type OF
                            Rec.Type::Cost:
                                BEGIN
                                    CASE Rec."Transaction Type" OF
                                        Rec."Transaction Type"::Payment:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Cash:
                                                        BEGIN
                                                            GLAccount.SETRANGE(GLAccount."Cash Account", TRUE);
                                                            GLAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := GLAccount."No.";
                                                            END;
                                                            GLAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::Bank:
                                                        BEGIN
                                                            BankAccount.SETFILTER("Currency Code", '=%1', '');
                                                            BankAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankAccount."No.";
                                                            END;
                                                            BankAccount.FILTERGROUP(0);
                                                        END;
                                                    ELSE
                                                        ERROR('Application Amount can be paid in Cash OR Bank Only');
                                                END;
                                            END;
                                        /* "Transaction Type" :: Receipt:
                                         BEGIN
                                           CASE "Mode of Receipt / Payment" OF
                                             "Mode of Receipt / Payment" :: Cash:
                                             BEGIN
                                               GLAccount.SETRANGE(GLAccount."Cash Account",TRUE);
                                               GLAccount.FILTERGROUP(2);
                                               IF Page.RUNMODAL(0,GLAccount) = ACTION::LookupOK THEN BEGIN
                                                 "Account No." := GLAccount."No.";
                                               END;
                                               GLAccount.FILTERGROUP(0);
                                             END;
                                             "Mode of Receipt / Payment" :: Bank:
                                             BEGIN
                                               BankAccount.SETFILTER("Currency Code",'=%1','');
                                               BankAccount.FILTERGROUP(2);
                                               IF Page.RUNMODAL(0,BankAccount) = ACTION::LookupOK THEN BEGIN
                                                 "Account No." := BankAccount."No.";
                                               END;
                                               BankAccount.FILTERGROUP(0);
                                             END;
                                           ELSE ERROR('CASH OR BANK ONLY');
                                           END;
                                         END;*/
                                        ELSE
                                            ERROR('Payments Only With Type Cost');
                                    END;
                                END;
                            Rec.Type::EMD:
                                BEGIN
                                    CASE Rec."Transaction Type" OF
                                        Rec."Transaction Type"::Payment:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Cash:
                                                        BEGIN
                                                            GLAccount.SETRANGE(GLAccount."Cash Account", TRUE);
                                                            GLAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := GLAccount."No.";
                                                            END;
                                                            GLAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::Bank:
                                                        BEGIN
                                                            BankAccount.SETFILTER("Currency Code", '=%1', '');
                                                            BankAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankAccount."No.";
                                                            END;
                                                            BankAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::FDR:
                                                        BEGIN
                                                            FDRMaster.SETRANGE(Closed, FALSE);
                                                            FDRMaster.SETRANGE(Status, FDRMaster.Status::Released);
                                                            FDRMaster.SETRANGE("FDR Posting Status", FDRMaster."FDR Posting Status"::Purchased);
                                                            FDRMaster.SETFILTER("Issued/Received", '<>%1', FDRMaster."Issued/Received"::Issued);
                                                            FDRMaster.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := FDRMaster."No.";
                                                                Rec.Amount := FDRMaster."FDR Value";
                                                            END;
                                                            FDRMaster.FILTERGROUP(0);
                                                        END;
                                                END;
                                            END;
                                        Rec."Transaction Type"::Receipt:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Cash:
                                                        BEGIN
                                                            GLAccount.SETRANGE(GLAccount."Cash Account", TRUE);
                                                            GLAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := GLAccount."No.";
                                                            END;
                                                            GLAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::Bank:
                                                        BEGIN
                                                            BankAccount.SETFILTER("Currency Code", '=%1', '');
                                                            BankAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankAccount."No.";
                                                            END;
                                                            BankAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::FDR:
                                                        BEGIN
                                                            FDRMaster.SETRANGE("Tender No.", Rec."Tender No.");
                                                            FDRMaster.SETRANGE("Issued/Received", FDRMaster."Issued/Received"::Issued);
                                                            FDRMaster.SETFILTER("FDR Posting Status", '<>%1', FDRMaster."FDR Posting Status"::Surrendered);
                                                            FDRMaster.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := FDRMaster."No.";
                                                                Rec.Amount := FDRMaster."FDR Value";
                                                            END;
                                                            FDRMaster.FILTERGROUP(0);
                                                        END;
                                                END;
                                            END;
                                        Rec."Transaction Type"::Adjustment:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::FDR:
                                                        BEGIN
                                                            //Rasool
                                                            TenderLedgerEntry.SETRANGE("Tender No.", Rec."Tender No.");
                                                            TenderLedgerEntry.SETRANGE(Type, TenderLedgerEntry.Type::EMD);
                                                            TenderLedgerEntry.SETRANGE("Transaction Type", TenderLedgerEntry."Transaction Type"::Payment);
                                                            TenderLedgerEntry.SETRANGE("Mode of Receipt / Payment", TenderLedgerEntry."Mode of Receipt / Payment"::FDR);
                                                            IF TenderLedgerEntry.FINDFIRST THEN BEGIN
                                                                FDRMaster.SETFILTER("FDR Posting Status", '<>%1', FDRMaster."FDR Posting Status"::Surrendered);
                                                                FDRMaster.SETRANGE("Tender No.", TenderLedgerEntry."Tender No.");
                                                                FDRMaster.FILTERGROUP(2);
                                                                IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                    //Checking for tender amounts
                                                                    TenderHeader.SETRANGE("Tender No.", Rec."Tender No.");
                                                                    IF TenderHeader.FINDFIRST THEN BEGIN
                                                                        TenderHeader.CALCFIELDS("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount");
                                                                        IF TenderHeader."EMD Paid Amount" = TenderHeader."EMD Received Amount" THEN
                                                                            ERROR('Amount is already received');
                                                                        IF TenderHeader."EMD Paid Amount" = (TenderHeader."EMD Received Amount" + TenderHeader."EMD Received Amount")
                                                      THEN
                                                                            ERROR('Amount is already adjusted');
                                                                    END;
                                                                    Rec."Account No." := FDRMaster."No.";
                                                                    Rec.Amount := FDRMaster."FDR Value";
                                                                END;
                                                                FDRMaster.FILTERGROUP(0);
                                                            END;
                                                        END;
                                                    ELSE
                                                        ERROR('Adjustments only through Cash / Bank / FDR only');
                                                END;
                                            END;
                                        ELSE
                                            ERROR('PAYMENTS / RECEIPTS / Adjustments ONLY');
                                    END;
                                END;
                            Rec.Type::SD:
                                BEGIN
                                    CASE Rec."Transaction Type" OF
                                        Rec."Transaction Type"::Payment:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Cash:
                                                        BEGIN
                                                            GLAccount.SETRANGE(GLAccount."Cash Account", TRUE);
                                                            GLAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := GLAccount."No.";
                                                            END;
                                                            GLAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::Bank:
                                                        BEGIN
                                                            BankAccount.SETFILTER("Currency Code", '=%1', '');
                                                            IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankAccount."No.";
                                                            END;
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::FDR:
                                                        BEGIN
                                                            FDRMaster.SETRANGE(Status, FDRMaster.Status::Released);
                                                            FDRMaster.SETRANGE(Closed, FALSE);
                                                            FDRMaster.SETRANGE("FDR Posting Status", FDRMaster."FDR Posting Status"::Purchased);
                                                            FDRMaster.SETFILTER("Tender No.", '=%1', '');
                                                            FDRMaster.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := FDRMaster."No.";
                                                                Rec.Amount := FDRMaster."FDR Value";
                                                            END;
                                                            FDRMaster.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::BG:
                                                        BEGIN
                                                            BankGuarntee.SETRANGE(Status, FDRMaster.Status::Released);
                                                            BankGuarntee.SETRANGE(Closed, FALSE);
                                                            BankGuarntee.SETFILTER("Issued/Received", '<>%1', BankGuarntee."Issued/Received"::Issued);
                                                            BankGuarntee.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, BankGuarntee) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankGuarntee."BG No.";
                                                                Rec.Amount := BankGuarntee."BG Value";
                                                            END;
                                                            BankGuarntee.FILTERGROUP(0);
                                                        END;
                                                END;
                                            END;
                                        Rec."Transaction Type"::Adjustment:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Customer:
                                                        BEGIN
                                                            TenderHeader.SETRANGE("Tender No.", Rec."Tender No.");
                                                            IF TenderHeader.FINDFIRST THEN
                                                                Cust.SETRANGE("No.", TenderHeader."Customer No.");
                                                            Cust.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, Cust) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := Cust."No.";
                                                            END;
                                                            Cust.FILTERGROUP(0);
                                                        END;
                                                END;
                                            END;
                                        Rec."Transaction Type"::Receipt:
                                            BEGIN
                                                CASE Rec."Mode of Receipt / Payment" OF
                                                    Rec."Mode of Receipt / Payment"::Cash:
                                                        BEGIN
                                                            GLAccount.SETRANGE(GLAccount."Cash Account", TRUE);
                                                            GLAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, GLAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := GLAccount."No.";
                                                            END;
                                                            GLAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::Bank:
                                                        BEGIN
                                                            BankAccount.SETFILTER("Currency Code", '=%1', '');
                                                            BankAccount.FILTERGROUP(2);
                                                            IF PAGE.RUNMODAL(0, BankAccount) = ACTION::LookupOK THEN BEGIN
                                                                Rec."Account No." := BankAccount."No.";
                                                            END;
                                                            BankAccount.FILTERGROUP(0);
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::FDR:
                                                        BEGIN
                                                            TenderLedgerEntry.SETRANGE("Tender No.", Rec."Tender No.");
                                                            //TenderLedgerEntry.SETRANGE(Type,TenderLedgerEntry.Type::SD);
                                                            //TenderLedgerEntry.SETRANGE("Transaction Type",TenderLedgerEntry."Transaction Type"::Payment);
                                                            //TenderLedgerEntry.SETRANGE("Mode of Receipt / Payment",TenderLedgerEntry."Mode of Receipt / Payment"::FDR);
                                                            IF TenderLedgerEntry.FINDFIRST THEN BEGIN
                                                                FDRMaster.SETRANGE("Tender No.", TenderLedgerEntry."Tender No.");
                                                                FDRMaster.SETRANGE(Closed, FALSE);
                                                                FDRMaster.SETFILTER("Issued/Received", '<>%1', FDRMaster."Issued/Received"::Received);
                                                                FDRMaster.FILTERGROUP(2);
                                                                IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                    Rec."Account No." := FDRMaster."No.";
                                                                    Rec.Amount := FDRMaster."FDR Value";
                                                                END;
                                                                FDRMaster.FILTERGROUP(0);
                                                            END
                                                            ELSE BEGIN
                                                                TenderLedgerEntry.SETRANGE("Tender No.", Rec."Tender No.");
                                                                TenderLedgerEntry.SETRANGE(Type, TenderLedgerEntry.Type::EMD);
                                                                TenderLedgerEntry.SETFILTER("Transaction Type", '<>%1', TenderLedgerEntry."Transaction Type"::Receipt);
                                                                TenderLedgerEntry.SETRANGE("Mode of Receipt / Payment", TenderLedgerEntry."Mode of Receipt / Payment"::FDR);
                                                                IF TenderLedgerEntry.FINDFIRST THEN BEGIN
                                                                    FDRMaster.SETRANGE("No.", TenderLedgerEntry."No.");
                                                                    FDRMaster.SETRANGE(Closed, FALSE);
                                                                    FDRMaster.SETFILTER("Issued/Received", '<>%1', FDRMaster."Issued/Received"::Received);
                                                                    FDRMaster.FILTERGROUP(2);
                                                                    IF PAGE.RUNMODAL(0, FDRMaster) = ACTION::LookupOK THEN BEGIN
                                                                        Rec."Account No." := FDRMaster."No.";
                                                                        Rec.Amount := FDRMaster."FDR Value";
                                                                    END;
                                                                    FDRMaster.FILTERGROUP(0);
                                                                END
                                                            END;
                                                        END;
                                                    Rec."Mode of Receipt / Payment"::BG:
                                                        BEGIN
                                                            TenderLedgerEntry.SETRANGE("Tender No.", Rec."Tender No.");
                                                            TenderLedgerEntry.SETRANGE(Type, TenderLedgerEntry.Type::SD);
                                                            TenderLedgerEntry.SETRANGE("Transaction Type", TenderLedgerEntry."Transaction Type"::Payment);
                                                            TenderLedgerEntry.SETRANGE("Mode of Receipt / Payment", TenderLedgerEntry."Mode of Receipt / Payment"::BG);
                                                            IF TenderLedgerEntry.FINDFIRST THEN BEGIN
                                                                BankGuarntee.SETRANGE("BG No.", TenderLedgerEntry."No.");
                                                                BankGuarntee.FILTERGROUP(2);
                                                                IF PAGE.RUNMODAL(0, BankGuarntee) = ACTION::LookupOK THEN BEGIN
                                                                    Rec."Account No." := BankGuarntee."BG No.";
                                                                    Rec.Amount := BankGuarntee."BG Value";
                                                                END;
                                                                BankGuarntee.FILTERGROUP(0);
                                                            END;
                                                        END;
                                                END;
                                            END;

                                        ELSE
                                            ERROR('PAYMENTS AND RECEIPTS ONLY');
                                    END;
                                END;
                        END;

                    end;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Tender Posting Group"; Rec."Tender Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Date."; Rec."Cheque Date.")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(structure; Rec.structure)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
                action("&Insert Application Amount")
                {
                    Caption = '&Insert Application Amount';
                    Image = AmountByPeriod;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.InsertApplicationAmount(Rec);
                        CurrPage.UPDATE;
                    end;
                }
                separator(Action1102152026)
                {
                }
                group("&Payments")
                {
                    Caption = '&Payments';
                    Image = Payment;
                    action("Insert &EMD Amount")
                    {
                        Caption = 'Insert &EMD Amount';
                        Image = Insert;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.InsertEMD(Rec);
                            CurrPage.UPDATE;
                        end;
                    }
                    action("Insert EMD &Write off Amount")
                    {
                        Caption = 'Insert EMD &Write off Amount';
                        Image = InsertBalanceAccount;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.InsertEMDWriteoffAmount(Rec);
                            CurrPage.UPDATE;
                        end;
                    }
                    separator(Action1102152033)
                    {
                    }
                    action("Insert &SD Amount")
                    {
                        Caption = 'Insert &SD Amount';
                        Image = InsertAccount;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.InsertSDAmount(Rec);
                        end;
                    }
                }
                separator(Action1102152038)
                {
                }
                group("&Receipts")
                {
                    Caption = '&Receipts';
                    Image = PostedReceipts;
                    action(Action1102152039)
                    {
                        Caption = 'Insert &EMD Amount';
                        Image = Insert;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.InsertEMDReceiptAmount(Rec);
                            CurrPage.UPDATE;
                        end;
                    }
                    separator(Action1102152040)
                    {
                    }
                    action(Action1102152041)
                    {
                        Caption = 'Insert &SD Amount';
                        Image = InsertAccount;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.InsertSDReceiptAmount(Rec);
                            CurrPage.UPDATE;
                        end;
                    }
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ShowDimensions;
                    end;
                }
            }
            group("Po&sting")
            {
                Caption = 'Po&sting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortCutKey = 'F11';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //TenderJnlPost.RunWithCheck(Rec);
                        TenderJnlPostTest.RunWithCheck(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec."Posting Date" := WORKDATE;

        IF Rec."Document No." <> xRec."Document No." THEN BEGIN
            "Sales&ReceivablesSetup".GET;
            NoSeriesMgt.TestManual("Sales&ReceivablesSetup"."Tender Posting Nos.");
            Rec."No. Series" := '';
        END;
    end;

    var
        TenderPostingLine: Record "Tender Posting Lines";
        TenderJnlPost: Codeunit Tender;
        "Sales&ReceivablesSetup": Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TenderJnlPostTest: Codeunit "Tender Jnl Test";
        "G/L Account": Record "G/L Account";

   
    local procedure ModeofReceiptPaymentOnInputCha(var Text: Text[1024]);
    begin
        Rec."Account No." := '';
    end;
}

