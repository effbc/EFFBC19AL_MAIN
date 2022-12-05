table 60072 "Tender Posting Lines"
{
    // version B2B1.0,DIM1.0

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13             -> Added New Field 480 ("Dimension Set ID") it Will assign the Dimension Set ID
    //                                                                 specific Combination of "Shorcut Dimension Code 1","Shorcut Dimension Code 2"
    //                                                                 These combinations are stored in the new Dimension Set Entry
    // 
    //                                                              -> Code has been Commented in the ShowDimensions() because Document Dimension Table does not exist in the
    //                                                                 NAV 2013 Instead of that code new Code is added for shows the data from the database against the Dimension Set ID.

    DrillDownPageID = "Tender Posting Lines";
    LookupPageID = "Tender Posting Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionMembers = EMD,SD,Cost;
            DataClassification = CustomerContent;
        }
        field(5; "Transaction Type"; Option)
        {
            OptionMembers = Payment,Receipt,Adjustment,"Write off";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Transaction Type" = "Transaction Type"::"Write off") then
                    "Mode of Receipt / Payment" := 4;
                if ("Transaction Type" = "Transaction Type"::Adjustment) then
                    "Mode of Receipt / Payment" := 4;
            end;
        }
        field(6; "Mode of Receipt / Payment"; Option)
        {
            OptionMembers = Cash,Bank,FDR,BG,Customer," ";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (Type = Type::EMD) and ("Mode of Receipt / Payment" = "Mode of Receipt / Payment"::BG) then
                    Error('EMD Mode of Payment / Receipt / Adjustment Shoud not be BG');
                if ("Transaction Type" = "Transaction Type"::"Write off") then
                    Error('Mode of Receipt / Payment Should be blank');
                if (Type = Type::EMD) and ("Transaction Type" = "Transaction Type"::Adjustment) and
                   (("Mode of Receipt / Payment" = "Mode of Receipt / Payment"::Cash) or
                    ("Mode of Receipt / Payment" = "Mode of Receipt / Payment"::Bank) or
                    ("Mode of Receipt / Payment" = "Mode of Receipt / Payment"::BG)) then
                    Error('Mode of Receipt / Payment Should be Blank or FDR only');
            end;
        }
        field(7; "Account No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //Cash,Bank,FDR,BG
                case "Mode of Receipt / Payment" of
                    "Mode of Receipt / Payment"::Cash:
                        begin
                            "G/LAccount".Get("Account No.");
                            //Description := "G/LAccount".Name;
                        end;
                    "Mode of Receipt / Payment"::Bank:
                        begin
                            BankAccount.Get("Account No.");
                            //Description := BankAccount.Name;
                        end;
                    "Mode of Receipt / Payment"::FDR:
                        begin
                            FDRMaster.Get("Account No.");
                            //Description := FDRMaster.Description;
                            Amount := FDRMaster."FDR Value";
                        end;
                    "Mode of Receipt / Payment"::BG:
                        begin
                            BankGuarntee.Get("Account No.");
                            //Description := BankGuarntee.Description;
                            Amount := BankGuarntee."BG Value";
                        end;
                end;
            end;
        }
        field(8; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; Amount; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TenderLedgerEntry: Record "Tender Ledger Entries";
                TenderHeader: Record "Tender Header";
                "Writeoff Amount": Decimal;
                EMDAmount: Decimal;
            begin
                if "Mode of Receipt / Payment" = "Mode of Receipt / Payment"::FDR then
                    Error('You Can not Change or Modify the Amount');
                if "Mode of Receipt / Payment" = "Mode of Receipt / Payment"::BG then
                    Error('You Can not Change or Modify the Amount');

                if Amount < 0 then
                    Error('Amount must be Positive');

                if ("Transaction Type" = "Transaction Type"::"Write off") and (Type = Type::EMD) then begin
                    TenderLedgerEntry.SetRange("Tender No.", "Tender No.");
                    TenderLedgerEntry.SetRange("Transaction Type", TenderLedgerEntry."Transaction Type"::"Write off");
                    if TenderLedgerEntry.Find('-') then
                        repeat
                            "Writeoff Amount" := "Writeoff Amount" + TenderLedgerEntry.Amount;
                        until TenderLedgerEntry.Next = 0;
                    TenderHeader.CalcFields("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount");
                    EMDAmount := TenderHeader."EMD Paid Amount" - TenderHeader."EMD Received Amount" - TenderHeader."EMD Adjusted Amount" -
                                     "Writeoff Amount";
                    if Amount < EMDAmount then
                        Error('Amount should not be Greater than the :%1', EMDAmount);
                end;
                CheckAmount;
            end;
        }
        field(12; "Cheque No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Cheque Date."; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Tender Posting Group"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(17; structure; Code[10])
        {
            // TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        ENN = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDimensions;
            end;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
    }

    keys
    {
        key(Key1; "Tender No.", "Tender Posting Group", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Sales&ReceivablesSetup".Get;
        "Sales&ReceivablesSetup".TestField("Tender Posting Nos.");
        if "Document No." = '' then
            NoSeriesMgt.InitSeries("Sales&ReceivablesSetup"."Tender Posting Nos.", xRec."No. Series", WorkDate, "Document No.", "No. Series");
    end;

    var
        FDRMaster: Record "FDR Master";
        "G/LAccount": Record "G/L Account";
        BankAccount: Record "Bank Account";
        BankGuarntee: Record "Bank Guarantee";
        "Sales&ReceivablesSetup": Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit 396;
        TenderLedgerEntry: Record "Tender Ledger Entries";
        Text001: Label 'Application Cost is Already posted';
        "-B2B1.1-": Integer;
        DimMgt: Codeunit DimensionManagement;


    procedure InsertApplicationAmount(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        TenderPostingLines1: Record "Tender Posting Lines";
    begin
        TenderHeader.Reset;

        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
        end;
        TenderHeader.TestField(TenderHeader."Tender Document Cost");
        TenderPostingLines."Tender No." := TenderHeader."Tender No.";
        TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
        "Sales&ReceivablesSetup".Get;
        "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
        TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
        //SalesHeader."No." := NoSeriesMgt.GetNextNo(SRSetup."Order Nos.",WORKDATE,TRUE);
        TenderPostingLines."Posting Date" := WorkDate;
        TenderPostingLines.Type := TenderPostingLines.Type::Cost;
        TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::Payment;
        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash;
        TenderPostingLines.Amount := TenderHeader."Tender Document Cost";
        TenderPostingLines.Description := 'Purchase of Application for Tender' + TenderHeader."Tender No.";
        TenderPostingLines.Insert;
        TenderHeader.Modify;
    end;


    procedure EmptyLine(): Boolean;
    begin
        exit(
          ("Account No." = '') and (Amount = 0) and
          ("Tender Posting Group" = ''));
    end;

    procedure InsertEMD(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        TenderPostingLines1: Record "Tender Posting Lines";
    begin
        TenderHeader.Reset;
        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
            TenderPostingLines."Tender No." := TenderHeader."Tender No.";
            TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
            "Sales&ReceivablesSetup".Get;
            "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
            TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
            TenderPostingLines."Posting Date" := WorkDate;
            TenderPostingLines.Type := TenderPostingLines.Type::EMD;
            TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::Payment;
            if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cash) or
               (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Others) then
                TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash
            else
                if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::FDR) then
                    TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::FDR
                else
                    if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::DD) or
                       (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cheque) then
                        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Bank;
            TenderHeader.CalcFields("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount");
            TenderPostingLines.Amount := TenderHeader."EMD Amount" - (TenderHeader."EMD Paid Amount" + TenderHeader."EMD Received Amount" +
                                                           TenderHeader."EMD Adjusted Amount");
            if TenderPostingLines.Amount <> 0 then
                TenderPostingLines.Insert
            else
                Message('EMD Already Paid');
        end;
    end;


    procedure InsertEMDWriteoffAmount(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        "Writeoff Amount": Decimal;
    begin
        TenderHeader.Reset;
        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
            TenderPostingLines.Init;
            TenderPostingLines."Tender No." := TenderHeader."Tender No.";
            TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
            "Sales&ReceivablesSetup".Get;
            "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
            TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
            TenderPostingLines."Posting Date" := WorkDate;
            TenderPostingLines.Type := TenderPostingLines.Type::EMD;
            TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::"Write off";
            if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cash) or
               (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Others) then
                TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash
            else
                if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::FDR) then
                    TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::FDR
                else
                    if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::DD) or
                       (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cheque) then
                        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Bank;
            TenderHeader.CalcFields("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount");
            TenderLedgerEntry.SetRange("Tender No.", TenderHeader."Tender No.");
            TenderLedgerEntry.SetRange("Transaction Type", TenderLedgerEntry."Transaction Type"::"Write off");
            repeat
                "Writeoff Amount" := "Writeoff Amount" + TenderLedgerEntry.Amount;
            until TenderLedgerEntry.Next = 0;
            TenderPostingLines.Amount := TenderHeader."EMD Paid Amount" - (TenderHeader."EMD Received Amount" + "Writeoff Amount" +
                                                 TenderHeader."EMD Adjusted Amount");
            if TenderPostingLines.Amount > 0 then
                TenderPostingLines.Insert
            else
                Message('There is no Write off Amount');
        end;
    end;


    procedure CheckAmount();
    var
        TenderLedgerEntries: Record "Tender Ledger Entries";
        TenderHeader: Record "Tender Header";
        Text001: Label 'Amout should not be more than the EMD Amount %1';
        PaidAmount: Decimal;
        EMDPaidAmount: Decimal;
        EMDReceiptAmount: Decimal;
        EMDAdjustedAmount: Decimal;
        TotEMDAmount: Decimal;
        Text002: Label 'Amount should not be more than the %1';
    begin
        case Type of
            Type::Cost:
                begin
                end;
            Type::EMD:
                begin
                    case "Transaction Type" of
                        "Transaction Type"::Payment:
                            begin
                                case "Mode of Receipt / Payment" of
                                    "Mode of Receipt / Payment"::Cash:
                                        begin
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Payment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    PaidAmount := PaidAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderHeader.Reset;
                                            TenderHeader.SetRange("Tender No.", "Tender No.");
                                            if TenderHeader.Find('-') then
                                                if TenderHeader."EMD Amount" < (PaidAmount + Amount) then
                                                    Error(Text001, TenderHeader."EMD Amount");
                                        end;
                                    "Mode of Receipt / Payment"::Bank:
                                        begin
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Payment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    PaidAmount := PaidAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderHeader.Reset;
                                            TenderHeader.SetRange("Tender No.", "Tender No.");
                                            if TenderHeader.Find('-') then
                                                if TenderHeader."EMD Amount" < (PaidAmount + Amount) then
                                                    Error(Text001, TenderHeader."EMD Amount");
                                        end;
                                    "Mode of Receipt / Payment"::FDR:
                                        begin
                                        end;
                                end;
                            end;
                        "Transaction Type"::Receipt:
                            begin
                                case "Mode of Receipt / Payment" of
                                    "Mode of Receipt / Payment"::Cash:
                                        begin
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Payment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                                      or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank)
                                    then
                                                        EMDPaidAmount := EMDPaidAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Receipt);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                                      or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank)
                                    then
                                                        EMDReceiptAmount := EMDReceiptAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Adjustment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = 4) then
                                                        EMDAdjustedAmount := EMDAdjustedAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            EMDPaidAmount := EMDPaidAmount - (EMDReceiptAmount + EMDAdjustedAmount);
                                            if Amount > EMDPaidAmount then
                                                Error(Text002, EMDPaidAmount);
                                        end;
                                    "Mode of Receipt / Payment"::Bank:
                                        begin
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Payment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                                      or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank)
                                    then
                                                        EMDPaidAmount := EMDPaidAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Receipt);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                                      or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank)
                                    then
                                                        EMDReceiptAmount := EMDReceiptAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            TenderLedgerEntries.Reset;
                                            TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                            TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                            TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Adjustment);
                                            if TenderLedgerEntries.Find('-') then
                                                repeat
                                                    if (TenderLedgerEntries."Mode of Receipt / Payment" = 4) then
                                                        EMDAdjustedAmount := EMDAdjustedAmount + TenderLedgerEntries.Amount;
                                                until TenderLedgerEntries.Next = 0;
                                            EMDPaidAmount := EMDPaidAmount - (EMDReceiptAmount + EMDAdjustedAmount);
                                            if Amount > EMDPaidAmount then
                                                Error(Text002, EMDPaidAmount);
                                        end;
                                    "Mode of Receipt / Payment"::FDR:
                                        begin
                                        end;
                                end;
                            end;
                        "Transaction Type"::Adjustment:
                            begin
                                if "Mode of Receipt / Payment" = 4 then begin
                                    TenderLedgerEntries.Reset;
                                    TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                    TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                    TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Payment);
                                    if TenderLedgerEntries.Find('-') then
                                        repeat
                                            if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                              or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank) then
                                                EMDPaidAmount := EMDPaidAmount + TenderLedgerEntries.Amount;
                                        until TenderLedgerEntries.Next = 0;
                                    TenderLedgerEntries.Reset;
                                    TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                    TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                    TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Receipt);
                                    if TenderLedgerEntries.Find('-') then
                                        repeat
                                            if (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Cash)
                                              or (TenderLedgerEntries."Mode of Receipt / Payment" = TenderLedgerEntries."Mode of Receipt / Payment"::Bank) then
                                                EMDReceiptAmount := EMDReceiptAmount + TenderLedgerEntries.Amount;
                                        until TenderLedgerEntries.Next = 0;
                                    TenderLedgerEntries.Reset;
                                    TenderLedgerEntries.SetRange("Tender No.", "Tender No.");
                                    TenderLedgerEntries.SetRange(Type, TenderLedgerEntries.Type::EMD);
                                    TenderLedgerEntries.SetRange("Transaction Type", TenderLedgerEntries."Transaction Type"::Adjustment);
                                    if TenderLedgerEntries.Find('-') then
                                        repeat
                                            if (TenderLedgerEntries."Mode of Receipt / Payment" = 4) then
                                                EMDAdjustedAmount := EMDAdjustedAmount + TenderLedgerEntries.Amount;
                                        until TenderLedgerEntries.Next = 0;
                                    EMDPaidAmount := EMDPaidAmount - (EMDReceiptAmount + EMDAdjustedAmount);
                                    if Amount > EMDPaidAmount then
                                        Error(Text002, EMDPaidAmount);
                                end;
                            end;
                        "Transaction Type"::"Write off":
                            begin
                                case "Mode of Receipt / Payment" of
                                    "Mode of Receipt / Payment"::Cash:
                                        begin
                                        end;
                                    "Mode of Receipt / Payment"::Bank:
                                        begin
                                        end;
                                    "Mode of Receipt / Payment"::FDR:
                                        begin
                                        end;
                                end;
                            end;
                    end;
                end;
            Type::SD:
                begin
                    case "Transaction Type" of
                        "Transaction Type"::Payment:
                            begin
                            end;
                        "Transaction Type"::Receipt:
                            begin
                            end;
                        "Transaction Type"::Adjustment:
                            begin
                            end;
                        "Transaction Type"::"Write off":
                            begin
                            end;
                    end;
                end;
        end;
    end;


    procedure InsertSDAmount(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        TenderPostingLines1: Record "Tender Posting Lines";
    begin
        TenderHeader.Reset;
        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
            TenderPostingLines."Tender No." := TenderHeader."Tender No.";
            TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
            "Sales&ReceivablesSetup".Get;
            "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
            TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
            TenderPostingLines."Posting Date" := WorkDate;
            TenderPostingLines.Type := TenderPostingLines.Type::SD;
            TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::Payment;
            if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Cash) or
               (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Others) then
                TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash
            else
                if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::FDR) then
                    TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::FDR
                else
                    if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::BG) then
                        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::BG
                    else
                        if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::DD) or
                           (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Cheque) then
                            TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Bank;
            TenderHeader.TestField(TenderHeader."Security Deposit Amount");
            TenderHeader.CalcFields("SD Paid Amount");
            TenderPostingLines.Amount := TenderHeader."Security Deposit Amount" - (TenderHeader."SD Paid Amount"
                                         + TenderHeader."SD Received Amount");
            if TenderPostingLines.Amount <> 0 then
                TenderPostingLines.Insert
            else
                Message('SD Amount is already Paid');
        end;
    end;


    procedure InsertEMDReceiptAmount(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        TenderPostingLines1: Record "Tender Posting Lines";
    begin
        TenderHeader.Reset;
        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
            TenderPostingLines."Tender No." := TenderHeader."Tender No.";
            TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
            "Sales&ReceivablesSetup".Get;
            "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
            TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
            TenderPostingLines."Posting Date" := WorkDate;
            TenderPostingLines.Type := TenderPostingLines.Type::EMD;
            TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::Receipt;
            if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cash) or
               (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Others) then
                TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash
            else
                if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::FDR) then
                    TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::FDR
                else
                    if (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::DD) or
                       (TenderHeader."EMD Mode of Payment" = TenderHeader."EMD Mode of Payment"::Cheque) then
                        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Bank;
            TenderHeader.CalcFields("EMD Paid Amount", "EMD Received Amount", "EMD Adjusted Amount");
            TenderPostingLines.Amount := TenderHeader."EMD Amount" - (TenderHeader."EMD Received Amount" +
                                          TenderHeader."EMD Adjusted Amount");
            if TenderPostingLines.Amount > 0 then
                TenderPostingLines.Insert
            else
                Message('EMD Already Received');
        end;
    end;


    procedure InsertSDReceiptAmount(var Rec: Record "Tender Posting Lines");
    var
        TenderHeader: Record "Tender Header";
        TenderPostingLines: Record "Tender Posting Lines";
        TenderPostingLines1: Record "Tender Posting Lines";
    begin
        TenderHeader.Reset;
        TenderHeader.SetRange("Tender No.", Rec."Tender No.");
        if TenderHeader.Find('-') then begin
            TenderPostingLines.SetRange("Tender No.", "Tender No.");
            if TenderPostingLines.Find('-') then begin
                if TenderPostingLines.Amount = 0 then
                    TenderPostingLines.Delete;
            end;
            TenderPostingLines."Tender No." := TenderHeader."Tender No.";
            TenderPostingLines."Tender Posting Group" := TenderHeader."Tender Posting Group";
            "Sales&ReceivablesSetup".Get;
            "Sales&ReceivablesSetup".TestField("Sales&ReceivablesSetup"."Tender Posting Nos.");
            TenderPostingLines."Document No." := NoSeriesMgt.GetNextNo("Sales&ReceivablesSetup"."Tender Posting Nos.", WorkDate, true);
            TenderPostingLines."Posting Date" := WorkDate;
            TenderPostingLines.Type := TenderPostingLines.Type::SD;
            TenderPostingLines."Transaction Type" := TenderPostingLines."Transaction Type"::Payment;
            if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Cash) or
               (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Others) then
                TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Cash
            else
                if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::FDR) then
                    TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::FDR
                else
                    if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::BG) then
                        TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::BG
                    else
                        if (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::DD) or
                           (TenderHeader."Security Mode of Payment" = TenderHeader."Security Mode of Payment"::Cheque) then
                            TenderPostingLines."Mode of Receipt / Payment" := TenderPostingLines."Mode of Receipt / Payment"::Bank;
            TenderHeader.TestField("Security Deposit Amount");
            TenderHeader.CalcFields("SD Paid Amount", "SD Received Amount");
            TenderPostingLines.Amount := TenderHeader."Security Deposit Amount" - (TenderHeader."SD Paid Amount" +
                                          TenderHeader."SD Received Amount");
            if TenderPostingLines.Amount > 0 then
                TenderPostingLines.Insert
            else
                Message('SD Amount is already Received');
        end;
    end;


    procedure ShowDimensions();
    begin
        //DIM1.0 Start
        //Code Comment
        /*
        //Deleted local Var(DocDimRecordTable357),Commented
        TESTFIELD("Tender No.");
        TESTFIELD("Document No.");
        DocDim.SETRANGE("Table ID",DATABASE::"Tender Posting Lines");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::"7");
        DocDim.SETRANGE("Document No.","Tender No.");
        DocDim.SETRANGE("Line No.","Line No.");
        DocDimensions.SETTABLEVIEW(DocDim);
        DocDimensions.RUNMODAL;
        */

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", StrSubstNo('%1', "Line No."),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
        //DIM 1.0 End

    end;
}

