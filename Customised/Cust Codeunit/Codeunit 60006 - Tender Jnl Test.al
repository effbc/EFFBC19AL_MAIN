codeunit 60006 "Tender Jnl Test"
{
    // version DIM1.0

    // Project : EFFTRONICS
    // *************************************************************************************************************************
    // SIGN Name
    // ************************************************************************************************************************
    // DIM : Resolution of Dimension Issues after Upgarding.
    // ***********************************************************************************************************************
    // Version  sign     Date       USERID    Description
    // *************************************************************************************************************************
    // 1.0      DIM      28-May-13  SAIRAM    New Code has been added for the dimensions updation after upgarding.
    // 2.0      UPGREV   05-Dec-18            Rectrified code the Filters assigned Value.


    trigger OnRun();
    begin
    end;

    var
        Text001: Label 'Do you want to post the Tender journal lines?';
        Text002: Label 'Tender Posting Lines are Posted Successfully.';
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        "AccountNo.": Code[20];
        "BalAccountNo.": Code[20];
        AccountType: Option "G/L Account","Bank Account";
        BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        Amount: Decimal;
        TenderLedgerEntries: Record "Tender Ledger Entries";
        TenderDocuments: Record "Tender Documents";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[100];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
       // mail: Codeunit 397;
        charline: Char;
        TH: Record "Tender Header";
        dev: Integer;
        cust: Record Customer;
        Recipients: List of [Text];


    procedure RunWithCheck(var TenderPostingLine: Record "Tender Posting Lines");
    var
        "AccountNo.": Code[20];
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;
        IF TenderPostingLine.FINDSET THEN
                REPEAT
                    TenderPostingLine.TESTFIELD("Tender Posting Group");
                    TenderPostingLine.TESTFIELD(Amount);
                    TenderPostingLine.TESTFIELD(Description);
                    //For Checking the Type of Tender Posting Lines.
                    CASE TenderPostingLine.Type OF
                        TenderPostingLine.Type::Cost:
                            BEGIN
                                CostPosting(TenderPostingLine);
                            END;
                        TenderPostingLine.Type::EMD:
                            BEGIN
                                EMDPosting(TenderPostingLine);
                            END;
                        TenderPostingLine.Type::SD:
                            BEGIN
                                SDPosting(TenderPostingLine);
                            END;
                    END;
                UNTIL TenderPostingLine.NEXT = 0;
        IF (TenderPostingLine.Type = TenderPostingLine.Type::EMD) AND
        (TenderPostingLine."Transaction Type" = TenderPostingLine."Transaction Type"::Payment) THEN BEGIN
            charline := 10;
            Mail_Body := '';
            Mail_Subject := 'ERP- EMD Amount To Sales';
            Mail_Body += 'EMD AMOUNT TO SALES DETAILS :';
            Mail_Body += FORMAT(charline);
            Mail_Body += FORMAT(charline);
            Mail_Body += 'Tender No          : ' + TenderPostingLine."Tender No.";
            Mail_Body += FORMAT(charline);
            TH.SETRANGE(TH."Tender No.", TenderPostingLine."Tender No.");
            IF TH.FINDFIRST THEN
                Mail_Body += 'Customer Name      : ' + TH."Customer Name";
            Mail_Body += FORMAT(charline);
            Mail_Body += 'EMD Value          : ' + FORMAT(ROUND(TenderPostingLine.Amount, 1));
            Mail_Body += FORMAT(charline);
            TH.SETRANGE(TH."Tender No.", TenderPostingLine."Tender No.");
            IF TH.FINDFIRST THEN BEGIN
                TH."Released to Sales" := TRUE;
                TH.MODIFY;
                Mail_Body += 'BID Amount         : ' + FORMAT(ROUND(TH."Minimum Bid Amount", 1));
                Mail_Body += FORMAT(charline);
                cust.SETRANGE(cust."No.", TH."Customer No.");
                IF cust.FINDFIRST THEN
                    IF cust."Salesperson Code" = '' THEN
                        ERROR('Enter Sales Person Code in Customer Card')
                    ELSE
                        //"Mail-Id".SETRANGE("Mail-Id"."User Security ID",cust."Salesperson Code");//B2B
                        "Mail-Id".SETRANGE("User ID", cust."Salesperson Code");//UPGREV2.0
                IF "Mail-Id".FINDFIRST THEN
                    Mail_Body += 'Sales Excecutive   : ' + FORMAT("Mail-Id"."User ID");//B2B
                Mail_Body += FORMAT(charline);
                Mail_Body += 'EMD Required Date  : ' + FORMAT((TH."EMD Required Date"), 0, 4);
                Mail_Body += FORMAT(charline);
                Mail_Body += FORMAT(charline);


                dev := TODAY - TH."EMD Required Date";
                IF dev > 0 THEN BEGIN
                    Mail_Body += 'Deviation Days     : ' + FORMAT(dev);
                    Mail_Body += FORMAT(charline);
                    Mail_Body += FORMAT(charline);
                    Mail_Body += FORMAT(charline);
                END;
            END;
            Mail_Body += '***** Auto mail Generated From ERP *****';
            //"Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);//B2B
            "Mail-Id".SETRANGE("User ID", USERID);//UPGREV2.0
            IF "Mail-Id".FINDFIRST THEN
                "from Mail" := "Mail-Id".MailID;
            /* "to mail" := 'ceo@efftronics.com,dir@efftronics.com,cvmohan@efftronics.com,anilkumar@efftronics.com,';
            "to mail" += 'renukach@efftronics.com,sitarajyam@efftronics.com,';
            "to mail" += 'sganesh@efftronics.com,rajani@efftronics.com,dsr@efftronics.com,';
            "to mail" += 'sunil@efftronics.com,ravi@efftronics.com,samba@efftronics.com,baji@efftronics.com,prasannat@efftronics.com,';
            "to mail" += 'anuradhag@efftronics.com,chandi@efftronics.com,anulatha@efftronics.com,milind@efftronics.com,srasc@efftronics.com'; */    //UPG

            Recipients.Add('ceo@efftronics.com');
            Recipients.Add('dir@efftronics.com');
            Recipients.Add('cvmohan@efftronics.com');
            Recipients.Add('anilkumar@efftronics.com');
            Recipients.Add('renukach@efftronics.com');
            Recipients.Add('sitarajyam@efftronics.com');
            Recipients.Add('sganesh@efftronics.com');
            Recipients.Add('rajani@efftronics.com');
            Recipients.Add('dsr@efftronics.com');
            Recipients.Add('sunil@efftronics.com');
            Recipients.Add('ravi@efftronics.com');
            Recipients.Add('samba@efftronics.com');
            Recipients.Add('baji@efftronics.com');
            Recipients.Add('prasannat@efftronics.com');
            Recipients.Add('anuradhag@efftronics.com');
            Recipients.Add('chandi@efftronics.com');
            Recipients.Add('anulatha@efftronics.com');
            Recipients.Add('milind@efftronics.com');
            Recipients.Add('srasc@efftronics.com');

            /*     IF ( "from Mail"<>'') AND ("to mail"<>'') THEN
             mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');*/
        END;

        MESSAGE(Text002);

    end;

    procedure CostPosting(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
    begin
        CASE TenderPostingLine."Transaction Type" OF
            TenderPostingLine."Transaction Type"::Payment:
                BEGIN
                    CASE TenderPostingLine."Mode of Receipt / Payment" OF
                        TenderPostingLine."Mode of Receipt / Payment"::Cash:
                            BEGIN
                                TenderPostingLine.TESTFIELD(TenderPostingLine."Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD("Tender/Quote Expenses A/c");
                                    "AccountNo." := TenderPostingGroup."Tender/Quote Expenses A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"G/L Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                            END;//2ND BEGIN END
                        TenderPostingLine."Mode of Receipt / Payment"::Bank:
                            BEGIN
                                TenderPostingLine.TESTFIELD(TenderPostingLine."Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD("Tender/Quote Expenses A/c");
                                    "AccountNo." := TenderPostingGroup."Tender/Quote Expenses A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"Bank Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                            END;
                        ELSE
                            ERROR('Cost Payment only through Cash / Bank Only');
                    END;//INNER CASE END
                END;
            ELSE //FOR CASE ELSE
                ERROR('Cost only Payments');
        END; //CASE END

        //For Inserting the ledger entries
        InsertLedgerEntries(TenderPostingLine);
    end;


    procedure EMDPosting(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
    begin
        CASE TenderPostingLine."Transaction Type" OF
            TenderPostingLine."Transaction Type"::Payment:
                BEGIN
                    CASE TenderPostingLine."Mode of Receipt / Payment" OF
                        TenderPostingLine."Mode of Receipt / Payment"::Cash:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."EMD Recoverable A/c");
                                    "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"G/L Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                                //PostCust(TenderPostingLine);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::Bank:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."EMD Recoverable A/c");
                                    "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"Bank Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::FDR:
                            BEGIN
                                EMDFDRPayment(TenderPostingLine);
                            END;
                        ELSE
                            ERROR('Cash bank FDR only');
                    END;
                END;
            TenderPostingLine."Transaction Type"::Receipt:
                BEGIN
                    CASE TenderPostingLine."Mode of Receipt / Payment" OF
                        TenderPostingLine."Mode of Receipt / Payment"::Cash:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."EMD Recoverable A/c");
                                    "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"G/L Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::Bank:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."EMD Recoverable A/c");
                                    "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"Bank Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::FDR:
                            BEGIN
                                EMDFDRReceipt(TenderPostingLine);
                            END;
                        ELSE
                            ERROR('Cash Bank Fdr only');
                    END;
                END;
            TenderPostingLine."Transaction Type"::Adjustment:
                BEGIN
                    IF TenderPostingLine."Mode of Receipt / Payment" = 4 THEN BEGIN
                        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                        IF TenderPostingGroup.FINDFIRST THEN BEGIN
                            TenderPostingGroup.TESTFIELD("Security Deposit A/c");
                            TenderPostingGroup.TESTFIELD("EMD Recoverable A/c");
                            "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                            "BalAccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                        END;
                        AccountType := AccountType::"G/L Account";
                        BalAccountType := BalAccountType::"G/L Account";
                        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                    END
                    ELSE
                        IF TenderPostingLine."Mode of Receipt / Payment" = TenderPostingLine."Mode of Receipt / Payment"::FDR THEN BEGIN
                            TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                            IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                TenderPostingGroup.TESTFIELD("Tender (FDR) Control A/c");
                                TenderPostingGroup.TESTFIELD("EMD Recoverable A/c");
                                "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                                "BalAccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                            END;
                            AccountType := AccountType::"G/L Account";
                            BalAccountType := BalAccountType::"G/L Account";
                            InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                        END;
                END;
            TenderPostingLine."Transaction Type"::"Write off":
                BEGIN
                    TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                    IF TenderPostingGroup.FINDFIRST THEN BEGIN
                        TenderPostingGroup.TESTFIELD("Tender/Quote Expenses A/c");
                        TenderPostingGroup.TESTFIELD("EMD Recoverable A/c");
                        "AccountNo." := TenderPostingGroup."Tender/Quote Expenses A/c";
                        "BalAccountNo." := TenderPostingGroup."EMD Recoverable A/c";
                    END;
                    AccountType := AccountType::"G/L Account";
                    BalAccountType := BalAccountType::"G/L Account";
                    InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                END;
        END;

        //For Inserting the ledger entries
        InsertLedgerEntries(TenderPostingLine);
    end;


    procedure SDPosting(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
    begin
        CASE TenderPostingLine."Transaction Type" OF
            TenderPostingLine."Transaction Type"::Payment:
                BEGIN
                    CASE TenderPostingLine."Mode of Receipt / Payment" OF
                        TenderPostingLine."Mode of Receipt / Payment"::Cash:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
                                    "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                                    ;
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"G/L Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::Bank:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
                                    "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                                    ;
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"Bank Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::FDR:
                            BEGIN
                                SDFDRPayment(TenderPostingLine);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::BG:
                            BEGIN
                                //SDBGPayment(TenderPostingLine);
                                MESSAGE('BG Feature is not Updated');
                            END;
                        ELSE
                            ERROR('SD PAYMENT');
                    END;
                END;
            TenderPostingLine."Transaction Type"::Receipt:
                BEGIN
                    CASE TenderPostingLine."Mode of Receipt / Payment" OF
                        TenderPostingLine."Mode of Receipt / Payment"::Cash:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
                                    "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                                    ;
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"G/L Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::Bank:
                            BEGIN
                                TenderPostingLine.TESTFIELD("Account No.");
                                TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                                IF TenderPostingGroup.FINDFIRST THEN BEGIN
                                    TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
                                    "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                                    ;
                                END;
                                "BalAccountNo." := TenderPostingLine."Account No.";
                                AccountType := AccountType::"G/L Account";
                                BalAccountType := BalAccountType::"Bank Account";
                                InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::FDR:
                            BEGIN
                                SDFDRReceipt(TenderPostingLine);
                            END;
                        TenderPostingLine."Mode of Receipt / Payment"::BG:
                            BEGIN
                                //SDBGReceipt(TenderPostingLine);
                                MESSAGE('BG Feature is not Updated');
                            END;
                        ELSE
                            ERROR('SD RECEIPT');
                    END;
                END;
            TenderPostingLine."Transaction Type"::Adjustment:
                BEGIN
                    TenderPostingLine.TESTFIELD("Account No.");
                    TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
                    IF TenderPostingGroup.FINDFIRST THEN BEGIN
                        TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
                        "AccountNo." := TenderPostingGroup."Security Deposit A/c";
                        ;
                    END;
                    "BalAccountNo." := TenderPostingLine."Account No.";
                    AccountType := AccountType::"G/L Account";
                    BalAccountType := BalAccountType::Customer;
                    InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);
                    //rasool
                END;
            TenderPostingLine."Transaction Type"::"Write off":
                BEGIN
                    ERROR('Not at Started');
                END;
            ELSE
                ERROR('SECURITY DEPOSIT');
        END;

        //For Inserting the ledger entries
        InsertLedgerEntries(TenderPostingLine);
    end;


    procedure InitGenJnlLine(var TenderPostingLine: Record "Tender Posting Lines"; "AccountNo.": Code[20]; "BalAccountNo.": Code[20]; AccountType: Option "G/L Account","Bank Account"; BalAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset"; Amount: Decimal);
    var
        DimMgt: Codeunit DimensionManagement;
        DimBufMgt: Codeunit "Dimension Buffer Management";
        PostingGroups: Record "Tender Posting Groups";
    begin
        //Deleted Var(TempJnlLineDimRecordTable356,DocDimRecordTable357,TempDocDimRecordTable357,DocumentDimensionRecordTable357)
        GenJnlLine.INIT;
        GenJnlLine."Account Type" := AccountType;
        GenJnlLine."Account No." := "AccountNo.";
        GenJnlLine."Posting Date" := TenderPostingLine."Posting Date";
        GenJnlLine."Document No." := TenderPostingLine."Document No.";
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine.Description := TenderPostingLine.Description;
        GenJnlLine."Bal. Account No." := "BalAccountNo.";
        GenJnlLine."Bal. Account Type" := BalAccountType;
        GenJnlLine.Amount := Amount;
        GenJnlLine.VALIDATE(Amount);
        GenJnlLine."Cheque No." := TenderPostingLine."Cheque No.";
        GenJnlLine."Cheque Date" := TenderPostingLine."Cheque Date.";
        GenJnlLine."Source Code" := 'GENJNL';
        GenJnlLine.VALIDATE("Dimension Set ID", TenderPostingLine."Dimension Set ID");//DIM1.0
                                                                                      //rasool
                                                                                      /*
                                                                                      IF DocumentDimension.FINDFIRST THEN
                                                                                        ERROR('rasool');

                                                                                      TempJnlLineDim.DELETEALL;
                                                                                      //TempDocDim.RESET;
                                                                                      //TempDocDim.SETRANGE("Table ID",DATABASE :: "Tender Posting Lines");
                                                                                      TempDocDim.SETRANGE("Table ID",60072);
                                                                                      TempDocDim.SETRANGE("Document Type",TempDocDim."Document Type"::Tender);
                                                                                      TempDocDim.SETRANGE("Document No.",TenderPostingLine."Tender No.");
                                                                                      TempDocDim.SETRANGE("Line No.",TenderPostingLine."Line No.");
                                                                                      IF TempDocDim.FINDFIRST THEN BEGIN
                                                                                        MESSAGE('%1',TempDocDim."Table ID");
                                                                                        MESSAGE('%1',TempDocDim."Document Type");
                                                                                        MESSAGE('%1',TempDocDim."Document No.");
                                                                                        MESSAGE('%1',TempDocDim."Line No.");
                                                                                        ERROR('Rasool');
                                                                                      END;
                                                                                      */

        //DIM1.0 Start
        //Code Commented
        /*
        DocumentDimension.SETRANGE("Table ID",60072);
        DocumentDimension.SETRANGE(DocumentDimension."Document Type",DocumentDimension."Document Type"::Tender);
        DocumentDimension.SETRANGE(DocumentDimension."Document No.",TenderPostingLine."Tender No.");//anil 5-jul-2010
        DimMgt.CopyDocDimToJnlLineDim(DocumentDimension,TempJnlLineDim);
        */
        //DIM1.0 End

        CheckCashAccBalance(GenJnlLine);


        //DIM1.0 Start
        //GenJnlPostLine.RunWithCheck(GenJnlLine,TempJnlLineDim);
        GenJnlPostLine.RunWithCheck(GenJnlLine);
        //DIM1.0 End

    end;


    procedure EMDFDRPayment(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        FDRMaster: Record "FDR Master";
    begin
        //For posting the Fixed Deposits Account
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("Fixed Deposit A/c");
            "AccountNo." := TenderPostingGroup."Fixed Deposit A/c";
        END;
        FDRMaster.SETRANGE("No.", TenderPostingLine."Account No.");
        IF FDRMaster.FINDFIRST THEN
            IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Cash THEN BEGIN
                "BalAccountNo." := FDRMaster."Payment Account No.";
                BalAccountType := BalAccountType::"G/L Account";
            END
            ELSE
                IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Bank THEN BEGIN
                    "BalAccountNo." := FDRMaster."Payment Account No.";
                    BalAccountType := BalAccountType::"Bank Account";
                END;
        AccountType := AccountType::"G/L Account";

        //InitGenJnlLine(TenderPostingLine,"AccountNo.","BalAccountNo.",AccountType,BalAccountType,TenderPostingLine.Amount);


        //For posting the EMD Recoverable Account
        TenderPostingGroup.RESET;
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("EMD Recoverable A/c");
            TenderPostingGroup.TESTFIELD("Tender (FDR) Control A/c");
            "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
            "BalAccountNo." := TenderPostingGroup."Tender (FDR) Control A/c";
        END;
        AccountType := AccountType::"G/L Account";
        BalAccountType := BalAccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);

        //To change FDR Issued/ Received
        FDRMaster."Issued/Received" := FDRMaster."Issued/Received"::Issued;
        FDRMaster."Tender No." := TenderPostingLine."Tender No.";
        FDRMaster.Purpose := FDRMaster.Purpose::EMD;
        FDRMaster.MODIFY;
    end;


    procedure EMDFDRReceipt(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        FDRMaster: Record "FDR Master";
    begin
        //For posting the Fixed Deposits Account
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("Fixed Deposit A/c");
            "AccountNo." := TenderPostingGroup."Fixed Deposit A/c";
        END;
        FDRMaster.SETRANGE("No.", TenderPostingLine."Account No.");
        IF FDRMaster.FINDFIRST THEN
            IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Cash THEN BEGIN
                "BalAccountNo." := FDRMaster."Payment Account No.";
                BalAccountType := BalAccountType::"G/L Account";
            END
            ELSE
                IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Bank THEN BEGIN
                    "BalAccountNo." := FDRMaster."Payment Account No.";
                    BalAccountType := BalAccountType::"Bank Account";
                END;
        AccountType := AccountType::"G/L Account";
        //InitGenJnlLine(TenderPostingLine,"AccountNo.","BalAccountNo.",AccountType,BalAccountType,-TenderPostingLine.Amount);


        //For posting the EMD Recoverable Account
        TenderPostingGroup.RESET;
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("EMD Recoverable A/c");
            TenderPostingGroup.TESTFIELD("Tender (FDR) Control A/c");
            "AccountNo." := TenderPostingGroup."EMD Recoverable A/c";
            "BalAccountNo." := TenderPostingGroup."Tender (FDR) Control A/c";
        END;
        AccountType := AccountType::"G/L Account";
        BalAccountType := BalAccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);

        //To change FDR Issued/ Received
        FDRMaster."Issued/Received" := FDRMaster."Issued/Received"::Received;
        FDRMaster."Tender No." := '';
        FDRMaster.Purpose := 0;
        FDRMaster.MODIFY;
    end;


    procedure SDFDRPayment(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        FDRMaster: Record "FDR Master";
    begin

        //For posting the Fixed Deposits Account
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("Fixed Deposit A/c");
            "AccountNo." := TenderPostingGroup."Fixed Deposit A/c";
        END;
        FDRMaster.SETRANGE("No.", TenderPostingLine."Account No.");
        IF FDRMaster.FINDFIRST THEN
            IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Cash THEN BEGIN
                "BalAccountNo." := FDRMaster."Payment Account No.";
                BalAccountType := BalAccountType::"G/L Account";
            END
            ELSE
                IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Bank THEN BEGIN
                    "BalAccountNo." := FDRMaster."Payment Account No.";
                    BalAccountType := BalAccountType::"Bank Account";
                END;
        AccountType := AccountType::"G/L Account";

        //InitGenJnlLine(TenderPostingLine,"AccountNo.","BalAccountNo.",AccountType,BalAccountType,TenderPostingLine.Amount);

        //For posting the EMD Recoverable Account
        TenderPostingGroup.RESET;
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD(TenderPostingGroup."Security Deposit A/c");
            TenderPostingGroup.TESTFIELD("Tender (FDR) Control A/c");
            "AccountNo." := TenderPostingGroup."Security Deposit A/c";
            "BalAccountNo." := TenderPostingGroup."Tender (FDR) Control A/c";
        END;
        AccountType := AccountType::"G/L Account";
        BalAccountType := BalAccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);

        //To change FDR Issued/ Received
        FDRMaster."Issued/Received" := FDRMaster."Issued/Received"::Issued;
        FDRMaster."Tender No." := TenderPostingLine."Tender No.";
        FDRMaster.Purpose := FDRMaster.Purpose::"Security Deposit";
        FDRMaster.MODIFY;
    end;


    procedure SDFDRReceipt(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        FDRMaster: Record "FDR Master";
    begin

        //For posting the Fixed Deposits Account
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("Fixed Deposit A/c");
            "AccountNo." := TenderPostingGroup."Fixed Deposit A/c";
        END;
        FDRMaster.SETRANGE("No.", TenderPostingLine."Account No.");
        IF FDRMaster.FINDFIRST THEN
            IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Cash THEN BEGIN
                "BalAccountNo." := FDRMaster."Payment Account No.";
                BalAccountType := BalAccountType::"G/L Account";
            END
            ELSE
                IF FDRMaster."Mode of Payment" = FDRMaster."Mode of Payment"::Bank THEN BEGIN
                    "BalAccountNo." := FDRMaster."Payment Account No.";
                    BalAccountType := BalAccountType::"Bank Account";
                END;
        AccountType := AccountType::"G/L Account";
        //InitGenJnlLine(TenderPostingLine,"AccountNo.","BalAccountNo.",AccountType,BalAccountType,-TenderPostingLine.Amount);

        //For posting the EMD Recoverable Account
        TenderPostingGroup.RESET;
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("Security Deposit A/c");
            TenderPostingGroup.TESTFIELD("Tender (FDR) Control A/c");
            "AccountNo." := TenderPostingGroup."Security Deposit A/c";
            "BalAccountNo." := TenderPostingGroup."Tender (FDR) Control A/c";
        END;
        AccountType := AccountType::"G/L Account";
        BalAccountType := BalAccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);

        //To change FDR Issued/ Received
        FDRMaster."Issued/Received" := FDRMaster."Issued/Received"::Received;
        FDRMaster."Tender No." := '';
        FDRMaster.Purpose := 0;
        FDRMaster.MODIFY;
    end;


    procedure SDBGPayment(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        BankGuarntee: Record "Bank Guarantee";
    begin
        //For Posting the BG Amount
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("B.G Margin Money A/c");
            "AccountNo." := TenderPostingGroup."B.G Margin Money A/c";
        END;

        BankGuarntee.SETRANGE("BG No.", TenderPostingLine."Account No.");
        IF BankGuarntee.FINDFIRST THEN BEGIN
            "BalAccountNo." := BankGuarntee."Account No.";
            BalAccountType := BalAccountType::"Bank Account";
        END;
        AccountType := AccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, -TenderPostingLine.Amount);

        //To change BG Issued/Received
        BankGuarntee."Issued/Received" := BankGuarntee."Issued/Received"::Issued;
        BankGuarntee."Tender No." := TenderPostingLine."Tender No.";
        BankGuarntee.MODIFY;
    end;


    procedure SDBGReceipt(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderPostingGroup: Record "Tender Posting Groups";
        BankGuarntee: Record "Bank Guarantee";
    begin
        //For Posting the BG Amount
        TenderPostingGroup.SETRANGE(Code, TenderPostingLine."Tender Posting Group");
        IF TenderPostingGroup.FINDFIRST THEN BEGIN
            TenderPostingGroup.TESTFIELD("B.G Margin Money A/c");
            "AccountNo." := TenderPostingGroup."B.G Margin Money A/c";
        END;

        BankGuarntee.SETRANGE("BG No.", TenderPostingLine."Account No.");
        IF BankGuarntee.FINDFIRST THEN BEGIN
            "BalAccountNo." := BankGuarntee."Account No.";
            BalAccountType := BalAccountType::"Bank Account";
        END;
        AccountType := AccountType::"G/L Account";
        InitGenJnlLine(TenderPostingLine, "AccountNo.", "BalAccountNo.", AccountType, BalAccountType, TenderPostingLine.Amount);

        //To change BG Issued/Received
        BankGuarntee."Issued/Received" := BankGuarntee."Issued/Received"::Received;
        BankGuarntee."Tender No." := '';
        BankGuarntee.MODIFY;
    end;


    procedure InsertLedgerEntries(var TenderPostingLines: Record "Tender Posting Lines");
    var
        "EntryNo.": Integer;
        TenderHeader: Record "Tender Header";
    begin
        IF TenderLedgerEntries.FINDLAST THEN
            "EntryNo." := TenderLedgerEntries."Entry No."
        ELSE
            "EntryNo." := 0;
        TenderLedgerEntries."Entry No." := "EntryNo." + 1;
        TenderLedgerEntries."Tender No." := TenderPostingLines."Tender No.";
        TenderLedgerEntries."Line No." := TenderPostingLines."Line No.";
        TenderLedgerEntries."Posting Date" := TenderPostingLines."Posting Date";
        TenderLedgerEntries.Type := TenderPostingLines.Type;
        TenderLedgerEntries."Transaction Type" := TenderPostingLines."Transaction Type";
        TenderLedgerEntries."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment";
        TenderLedgerEntries."No." := TenderPostingLines."Account No.";
        TenderLedgerEntries.Description := TenderPostingLines.Description;
        TenderLedgerEntries.Amount := TenderPostingLines.Amount;
        TenderLedgerEntries."Cheque No." := TenderPostingLines."Cheque No.";
        TenderLedgerEntries."Cheque Date." := TenderPostingLines."Cheque Date.";
        TenderLedgerEntries."Tender Posting Group" := TenderPostingLines."Tender Posting Group";
        TenderLedgerEntries."Document No." := TenderPostingLines."Document No.";
        TenderLedgerEntries.INSERT;

        //To Modify the Tender Status
        ModifyStatus(TenderPostingLines);

        //To Update the Tender Documents
        UpdateTenderDocuments(TenderPostingLines);

        //To Delete the Tender Posting Lines
        TenderPostingLines.DELETE;
    end;


    procedure ModifyStatus(var TenderPostingLines: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
    begin
        //For modifying the EMD Status
        TenderHeader.CALCFIELDS("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount", "EMD Write off Amount");
        TenderHeader.SETRANGE("Tender No.", TenderPostingLines."Tender No.");
        IF TenderHeader.FINDFIRST THEN BEGIN
            IF (TenderHeader."EMD Paid Amount" = (TenderHeader."EMD Received Amount" + TenderHeader."EMD Adjusted Amount" +
                                                TenderHeader."EMD Write off Amount")) THEN BEGIN
                IF (TenderHeader."EMD Paid Amount" <> 0) THEN
                    TenderHeader."EMD Status" := TenderHeader."EMD Status"::Received;
                TenderHeader.MODIFY;
            END;
        END;

        IF (TenderPostingLines.Type = TenderPostingLines.Type::EMD) AND (TenderPostingLines."Transaction Type" =
                        TenderPostingLines."Transaction Type"::Adjustment) THEN BEGIN
            TenderHeader.SETRANGE("Tender No.", TenderPostingLines."Tender No.");
            IF TenderHeader.FINDFIRST THEN BEGIN
                TenderHeader."EMD Status" := TenderHeader."EMD Status"::"Adjusted against Security Deposited";
                TenderHeader.MODIFY;
            END;
        END;

        TenderHeader.SETRANGE("Tender No.", TenderPostingLines."Tender No.");
        IF TenderHeader.FINDFIRST THEN BEGIN
            IF TenderHeader."Tender Status" = 0 THEN BEGIN
                TenderHeader."Tender Status" := TenderHeader."Tender Status"::Open;
                TenderHeader.MODIFY;
            END;
        END;
    end;


    procedure UpdateTenderDocuments(var TenderPostingLines: Record "Tender Posting Lines");
    begin
        CASE TenderPostingLines.Type OF
            TenderPostingLines.Type::EMD:
                BEGIN
                    CASE TenderPostingLines."Transaction Type" OF
                        TenderPostingLines."Transaction Type"::Payment:
                            BEGIN
                                IF TenderPostingLines."Mode of Receipt / Payment" = TenderPostingLines."Mode of Receipt / Payment"::FDR THEN BEGIN
                                    TenderDocuments.INIT;
                                    TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                    TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                    IF TenderDocuments.FINDLAST THEN
                                        TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                    ELSE
                                        TenderDocuments."Line No." := 10000;
                                    TenderDocuments.Type := TenderDocuments.Type::FDR;
                                    TenderDocuments.Purpose := TenderDocuments.Purpose::EMD;
                                    TenderDocuments."No." := TenderPostingLines."Account No.";
                                    TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                    TenderDocuments.Amount := TenderPostingLines.Amount;
                                    TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type"::Payment;
                                    TenderDocuments.INSERT;
                                END;
                            END;
                        TenderPostingLines."Transaction Type"::Receipt:
                            BEGIN
                                IF TenderPostingLines."Mode of Receipt / Payment" = TenderPostingLines."Mode of Receipt / Payment"::FDR THEN BEGIN
                                    /*
                                    TenderDocuments.INIT;
                                    TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                    TenderDocuments.SETRANGE("Document No.",TenderPostingLines."Tender No.");
                                    IF TenderDocuments.FINDLAST THEN
                                      TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                    ELSE
                                      TenderDocuments."Line No." := 10000;
                                    TenderDocuments.Type := TenderDocuments.Type :: FDR;
                                    TenderDocuments.Purpose := TenderDocuments.Purpose :: EMD;
                                    TenderDocuments."No." := TenderPostingLines."Account No.";
                                    TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                    TenderDocuments.Amount := TenderPostingLines.Amount;
                                    TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type" ::Receipt;
                                    TenderDocuments.INSERT;
                                    */
                                    TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                    TenderDocuments.SETRANGE(Type, TenderDocuments.Type::FDR);
                                    TenderDocuments.SETRANGE("Transaction Type", TenderDocuments."Transaction Type"::Payment);
                                    IF TenderDocuments.FINDFIRST THEN BEGIN
                                        TenderDocuments."Received / Adjusted" := TRUE;
                                        TenderDocuments.MODIFY;
                                    END;
                                END;
                            END;
                        TenderPostingLines."Transaction Type"::Adjustment:
                            BEGIN
                                IF TenderPostingLines."Mode of Receipt / Payment" = TenderPostingLines."Mode of Receipt / Payment"::FDR THEN BEGIN
                                    /*
                                    TenderDocuments.INIT;
                                    TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                    TenderDocuments.SETRANGE("Document No.",TenderPostingLines."Tender No.");
                                    IF TenderDocuments.FINDLAST THEN
                                      TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                    ELSE
                                      TenderDocuments."Line No." := 10000;
                                    TenderDocuments.Type := TenderDocuments.Type :: FDR;
                                    TenderDocuments.Purpose := TenderDocuments.Purpose :: EMD;
                                    TenderDocuments."No." := TenderPostingLines."Account No.";
                                    TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                    TenderDocuments.Amount := TenderPostingLines.Amount;
                                    TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type" ::Adjustment;
                                    TenderDocuments.INSERT;
                                    */
                                    TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                    TenderDocuments.SETRANGE(Type, TenderDocuments.Type::FDR);
                                    TenderDocuments.SETRANGE("Transaction Type", TenderDocuments."Transaction Type"::Payment);
                                    IF TenderDocuments.FINDFIRST THEN BEGIN
                                        TenderDocuments."Received / Adjusted" := TRUE;
                                        TenderDocuments.MODIFY;
                                    END;
                                END;
                            END;
                    END;
                END;
            TenderPostingLines.Type::SD:
                BEGIN
                    CASE TenderPostingLines."Transaction Type" OF
                        TenderPostingLines."Transaction Type"::Payment:
                            BEGIN
                                CASE TenderPostingLines."Mode of Receipt / Payment" OF
                                    TenderPostingLines."Mode of Receipt / Payment"::FDR:
                                        BEGIN
                                            TenderDocuments.INIT;
                                            TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                            TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                            IF TenderDocuments.FINDLAST THEN
                                                TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                            ELSE
                                                TenderDocuments."Line No." := 10000;
                                            TenderDocuments.Type := TenderDocuments.Type::FDR;
                                            TenderDocuments.Purpose := TenderDocuments.Purpose::SD;
                                            TenderDocuments."No." := TenderPostingLines."Account No.";
                                            TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                            TenderDocuments.Amount := TenderPostingLines.Amount;
                                            TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type"::Payment;
                                            TenderDocuments.INSERT;
                                        END;
                                    TenderPostingLines."Mode of Receipt / Payment"::BG:
                                        BEGIN
                                            TenderDocuments.INIT;
                                            TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                            TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                            IF TenderDocuments.FINDLAST THEN
                                                TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                            ELSE
                                                TenderDocuments."Line No." := 10000;
                                            TenderDocuments.Type := TenderDocuments.Type::BG;
                                            TenderDocuments.Purpose := TenderDocuments.Purpose::SD;
                                            TenderDocuments."No." := TenderPostingLines."Account No.";
                                            TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                            TenderDocuments.Amount := TenderPostingLines.Amount;
                                            TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type"::Payment;
                                            TenderDocuments.INSERT;
                                        END;
                                END;
                            END;
                        TenderPostingLines."Transaction Type"::Receipt:
                            BEGIN
                                CASE TenderPostingLines."Mode of Receipt / Payment" OF
                                    TenderPostingLines."Mode of Receipt / Payment"::FDR:
                                        BEGIN
                                            TenderDocuments.INIT;
                                            TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                            TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                            IF TenderDocuments.FINDLAST THEN
                                                TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                            ELSE
                                                TenderDocuments."Line No." := 10000;
                                            TenderDocuments.Type := TenderDocuments.Type::FDR;
                                            TenderDocuments.Purpose := TenderDocuments.Purpose::SD;
                                            TenderDocuments."No." := TenderPostingLines."Account No.";
                                            TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                            TenderDocuments.Amount := TenderPostingLines.Amount;
                                            TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type"::Receipt;
                                            TenderDocuments.INSERT;
                                        END;
                                    TenderPostingLines."Mode of Receipt / Payment"::BG:
                                        BEGIN
                                            TenderDocuments.INIT;
                                            TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                            TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                            IF TenderDocuments.FINDLAST THEN
                                                TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                            ELSE
                                                TenderDocuments."Line No." := 10000;
                                            TenderDocuments.Type := TenderDocuments.Type::BG;
                                            TenderDocuments.Purpose := TenderDocuments.Purpose::SD;
                                            TenderDocuments."No." := TenderPostingLines."Account No.";
                                            TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                            TenderDocuments.Amount := TenderPostingLines.Amount;
                                            TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type"::Receipt;
                                            TenderDocuments.INSERT;
                                        END;
                                END;
                            END;
                        TenderPostingLines."Transaction Type"::Adjustment:
                            BEGIN
                                IF TenderPostingLines."Mode of Receipt / Payment" = TenderPostingLines."Mode of Receipt / Payment"::FDR THEN BEGIN
                                    /*
                                    TenderDocuments.INIT;
                                    TenderDocuments."Document No." := TenderPostingLines."Tender No.";
                                    TenderDocuments.SETRANGE("Document No.",TenderPostingLines."Tender No.");
                                    IF TenderDocuments.FINDLAST THEN
                                      TenderDocuments."Line No." := TenderDocuments."Line No." + 10000
                                    ELSE
                                      TenderDocuments."Line No." := 10000;
                                    TenderDocuments.Type := TenderDocuments.Type :: FDR;
                                    TenderDocuments.Purpose := TenderDocuments.Purpose :: EMD;
                                    TenderDocuments."No." := TenderPostingLines."Account No.";
                                    TenderDocuments."Payment/Receipt/Adjusted Date" := TenderPostingLines."Posting Date";
                                    TenderDocuments.Amount := TenderPostingLines.Amount;
                                    TenderDocuments."Transaction Type" := TenderDocuments."Transaction Type" ::Adjustment;
                                    TenderDocuments.INSERT;
                                    */
                                    TenderDocuments.SETRANGE("Document No.", TenderPostingLines."Tender No.");
                                    TenderDocuments.SETRANGE(Type, TenderDocuments.Type::FDR);
                                    TenderDocuments.SETRANGE("Transaction Type", TenderDocuments."Transaction Type"::Payment);
                                    IF TenderDocuments.FINDFIRST THEN BEGIN
                                        TenderDocuments."Received / Adjusted" := TRUE;
                                        TenderDocuments.MODIFY;
                                    END;

                                END;
                            END;
                    END;
                END;
        END;

    end;

    procedure PostCust(var TenderPostingLine: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        "Cust.LedgerEntry": Record "Cust. Ledger Entry";
        "NextEntryNo.": Integer;
        "DetailedCust.Ledg.Entry": Record "Detailed Cust. Ledg. Entry";
        "EntryNo.": Integer;
        "G/LEntry": Record "G/L Entry";
    begin
        IF "Cust.LedgerEntry".FINDLAST THEN
            "NextEntryNo." := "Cust.LedgerEntry"."Entry No." + 1
        ELSE
            "NextEntryNo." := 1;

        "Cust.LedgerEntry".INIT;
        TenderHeader.SETRANGE("Tender No.", TenderPostingLine."Tender No.");
        IF TenderHeader.FINDFIRST THEN BEGIN
            TenderHeader.TESTFIELD(TenderHeader."Customer No.");
            "Cust.LedgerEntry"."Customer No." := TenderHeader."Customer No.";
        END;
        "Cust.LedgerEntry"."Entry No." := "NextEntryNo.";
        "Cust.LedgerEntry"."Posting Date" := TenderPostingLine."Posting Date";
        "Cust.LedgerEntry"."Document Type" := "Cust.LedgerEntry"."Document Type"::Payment;
        "Cust.LedgerEntry"."Document No." := TenderPostingLine."Document No.";
        "Cust.LedgerEntry"."User ID" := USERID;
        "Cust.LedgerEntry"."Source Code" := 'TENDER';
        "Cust.LedgerEntry".Open := TRUE;
        "Cust.LedgerEntry".Amount := TenderPostingLine.Amount;
        "Cust.LedgerEntry".Description := TenderPostingLine.Description;
        "G/LEntry".SETRANGE("Document No.", TenderPostingLine."Document No.");
        IF "G/LEntry".FINDFIRST THEN
            "Cust.LedgerEntry"."Transaction No." := "G/LEntry"."Transaction No.";

        IF "DetailedCust.Ledg.Entry".FINDLAST THEN
            "EntryNo." := "DetailedCust.Ledg.Entry"."Entry No." + 1
        ELSE
            "EntryNo." := 1;
        "DetailedCust.Ledg.Entry".INIT;
        "DetailedCust.Ledg.Entry"."Entry No." := "EntryNo.";
        "DetailedCust.Ledg.Entry"."Cust. Ledger Entry No." := "Cust.LedgerEntry"."Entry No.";
        "DetailedCust.Ledg.Entry"."Entry Type" := "DetailedCust.Ledg.Entry"."Entry Type"::"Initial Entry";
        "DetailedCust.Ledg.Entry"."Posting Date" := TenderPostingLine."Posting Date";
        "DetailedCust.Ledg.Entry"."Document Type" := "DetailedCust.Ledg.Entry"."Document Type"::Payment;
        "DetailedCust.Ledg.Entry"."Document No." := TenderPostingLine."Document No.";
        "DetailedCust.Ledg.Entry".Amount := TenderPostingLine.Amount;
        "DetailedCust.Ledg.Entry"."Amount (LCY)" := TenderPostingLine.Amount;
        "DetailedCust.Ledg.Entry"."User ID" := USERID;
        "DetailedCust.Ledg.Entry"."Source Code" := 'TENDER';
        "DetailedCust.Ledg.Entry"."Customer No." := "Cust.LedgerEntry"."Customer No.";
        "DetailedCust.Ledg.Entry"."Debit Amount" := "DetailedCust.Ledg.Entry".Amount;
        "DetailedCust.Ledg.Entry"."Debit Amount (LCY)" := "DetailedCust.Ledg.Entry"."Amount (LCY)";
        "DetailedCust.Ledg.Entry"."Transaction No." := "Cust.LedgerEntry"."Transaction No.";

        "DetailedCust.Ledg.Entry".INSERT;

        "Cust.LedgerEntry".INSERT;
    end;


    procedure CheckCashAccBalance(var GenJnlLine2: Record "Gen. Journal Line");
    var
        GLAcc: Record "G/L Account";
        Text000: Label 'Cash Account %1 balance should not be negative. Do you want to post the transactions?';
        GenJnlLine3: Record "Gen. Journal Line";
        Balance1: Decimal;
        Text001: Label 'Entry Posting Stopped';
        Text002: Label 'Balancing Account %1 balance should not be negative. Do you want to post the transactions?';
    begin
        IF GenJnlLine2."Account Type" = GenJnlLine2."Account Type"::"G/L Account" THEN
            IF GLAcc.GET(GenJnlLine2."Account No.") AND (GLAcc."Cash Account") THEN BEGIN
                GLAcc.CALCFIELDS(Balance);
                Balance1 := GLAcc.Balance - GenJnlLine2.Amount;
                IF (Balance1 < 0) THEN
                    IF NOT CONFIRM(Text000, FALSE, GenJnlLine2."Account No.") THEN
                        ERROR(Text001, GenJnlLine2."Account No.");
            END;
        IF GenJnlLine2."Bal. Account Type" = GenJnlLine2."Bal. Account Type"::"G/L Account" THEN
            IF GLAcc.GET(GenJnlLine2."Bal. Account No.") AND (GLAcc."Cash Account") THEN BEGIN
                GLAcc.CALCFIELDS(Balance);
                Balance1 := GLAcc.Balance - GenJnlLine2.Amount;
                IF (Balance1 < 0) THEN
                    IF NOT CONFIRM(Text002, FALSE, GenJnlLine2."Bal. Account No.") THEN
                        ERROR(Text001, GenJnlLine2."Account No.");
            END;
    end;
}

