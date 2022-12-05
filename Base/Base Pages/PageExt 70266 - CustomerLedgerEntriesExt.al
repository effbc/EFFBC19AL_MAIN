pageextension 70266 CustomerLedgerEntriesExt extends 25
{

    layout
    {


        addafter("Posting Date")
        {
            field("Amount to Apply"; Rec."Amount to Apply")
            {
                ApplicationArea = All;

            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Document Type")
        {
            field("Sale Order no"; Rec."Sale Order no")
            {
                ApplicationArea = All;

            }
            field("invoice no"; Rec."invoice no")
            {
                ApplicationArea = All;

            }
        }
        addafter("Document No.")
        {
            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;

            }
        }
        addafter("Customer No.")
        {
            field("Customer ord No"; Rec."Customer ord No")
            {
                ApplicationArea = All;

            }
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

            }
        }
        addafter("Remaining Amt. (LCY)")
        {
            field("DD/FDR No."; Rec."DD/FDR No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Payment Through"; Rec."Payment Through")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("Closed by Entry No."; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;

            }
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;

            }
            field("Adjusted Currency Factor"; Rec."Adjusted Currency Factor")
            {
                ApplicationArea = All;

            }
            field("Original Currency Factor"; Rec."Original Currency Factor")
            {
                ApplicationArea = All;

            }
            /* field("Seller State Code"; Rec."Seller State Code")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field("Seller GST Reg. No."; Rec."Seller GST Reg. No.")
            {
                Editable = true;
                ApplicationArea = All;
            } */
        }
        addbefore(Control1)
        {
            group(Control1102152009)
            {
                Visible = "Totals_Visible";
                ShowCaption = false;
                field(FiscialYear; FiscialYear)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CASE FiscialYear OF
                            FiscialYear::"08-09":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2008), DMY2DATE(31, 3, 2009));
                                END;
                            FiscialYear::"09-10":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2009), DMY2DATE(31, 3, 2010));
                                END;
                            FiscialYear::"10-11":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, 2011));
                                END;
                            FiscialYear::"11-12":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2011), DMY2DATE(31, 3, 2012));
                                END;
                            FiscialYear::"12-13":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2012), DMY2DATE(31, 3, 2013));
                                END;
                            FiscialYear::"13-14":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2013), DMY2DATE(31, 3, 2014));
                                END;
                            FiscialYear::"14-15":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2014), DMY2DATE(31, 3, 2015));
                                END;
                            FiscialYear::"15-16":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2015), DMY2DATE(31, 3, 2016));
                                END;
                            FiscialYear::"16-17":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2016), DMY2DATE(31, 3, 2017));
                                END;
                            FiscialYear::"17-18":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2017), DMY2DATE(31, 3, 2018));
                                END;
                            FiscialYear::"18-19":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2018), DMY2DATE(31, 3, 2019));
                                END;
                            FiscialYear::"19-20":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2019), DMY2DATE(31, 3, 2020));
                                END;
                            FiscialYear::"20-21":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2020), DMY2DATE(31, 3, 2021));
                                END;
                            FiscialYear::"21-22":
                                BEGIN
                                    SETRANGE("Posting Date", DMY2DATE(1, 4, 2021), DMY2DATE(31, 3, 2022));
                                END;
                            FiscialYear::"22-23":
                                BEGIN
                                    SETRANGE("Posting Date", DMY2DATE(1, 4, 2022), DMY2DATE(31, 3, 2023));
                                END;

                        END;
                        CNT := 0;
                        IF USERID IN ['EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND',
                                      'EFFTRONICS\SGANESH', 'EFFTRONICS\DSR', 'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BLAVANYA'] THEN BEGIN
                            CLE.RESET;
                            CLE.COPYFILTERS(Rec);
                            TotalCredit := 0;
                            TotalDebit := 0;
                            OpeningBal := 0;
                            ClosingBal := 0;
                            IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2008) THEN BEGIN
                                CLE.SETRANGE(CLE."Posting Date", DMY2DATE(1, 4, 2008), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                                IF CLE.FINDSET THEN
                                    REPEAT
                                        DLE.RESET;
                                        DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                                        DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                                        IF DLE.FINDFIRST THEN
                                            REPEAT
                                                OpeningBal += DLE."Debit Amount" - DLE."Credit Amount";
                                            UNTIL DLE.NEXT = 0;
                                    UNTIL CLE.NEXT = 0;
                            END;

                            CLE.RESET;
                            CLE.COPYFILTERS(Rec);
                            IF CLE.FINDSET THEN
                                REPEAT
                                    DLE.RESET;
                                    DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                                    DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                                    IF DLE.FINDFIRST THEN
                                        REPEAT
                                            TotalCredit += DLE."Credit Amount";
                                            TotalDebit += DLE."Debit Amount";
                                        UNTIL DLE.NEXT = 0;
                                UNTIL CLE.NEXT = 0;
                            ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                        END;
                        CurrPage.UPDATE(false);//EFFUPG1.2
                    end;
                }

            }
        }
        addafter(Control1)
        {
            group(Totals)
            {
                Caption = 'Totals';
                grid(Control1102152004)
                {
                    GridLayout = Rows;
                    ShowCaption = false;
                    group(Control1102152005)
                    {
                        ShowCaption = false;
                        field(OpeningBal; OpeningBal)
                        {
                            Caption = 'Opening Balance';
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152006)
                    {
                        ShowCaption = false;
                        field(TotalCredit; TotalCredit)
                        {
                            Caption = 'Credit';
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152007)
                    {
                        ShowCaption = false;
                        field(TotalDebit; TotalDebit)
                        {
                            Caption = 'Debit';
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152008)
                    {
                        ShowCaption = false;
                        field(ClosingBal; ClosingBal)
                        {
                            Caption = 'Closing Balance';
                            Width = 100;
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }

            }


        }
    }





    actions
    {
        addafter("Detailed &Ledger Entries")
        {
            group("MSPT Entries")
            {
                Caption = 'MSPT Entries';
                action("MSPT &Customer Ledger Entries")
                {
                    Caption = 'MSPT &Customer Ledger Entries';
                    RunObject = Page 60107;
                    RunPageLink = "Entry No." = FIELD("Entry No.");
                    ApplicationArea = All;
                }
                /*
                action("MSPT &Detailed Ledger Entries")
                {
                    Caption = 'MSPT &Detailed Ledger Entries';
                    RunObject = Page "MSPT Dtld. Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    ApplicationArea = All;
                }
                */
            }
        }
        addafter(ReverseTransaction)
        {
            action("Un Apply")
            {
                Caption = 'Un Apply';
                Enabled = true;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CreateCustLedgEntry: Record "Cust. Ledger Entry";
                    DLE_1: Record "Detailed Cust. Ledg. Entry";
                    DLE_2: Record "Detailed Cust. Ledg. Entry";
                    CLE_1: Record "Cust. Ledger Entry";
                    CLE_2: Record "Cust. Ledger Entry";
                    Amt: Decimal;
                    Temp_Amt: Decimal;
                begin

                    /* IF USERID <> 'EFFTRONICS\PRANAVI' THEN BEGIN
                    CLE.RESET;
                    CLE.SETRANGE(CLE."Customer No.", "Customer No.");
                    CLE.SETRANGE(CLE."Entry No.", "Closed by Entry No.");
                    IF CLE.FINDSET THEN
                        REPEAT
                            CLE."Closed by Entry No." := 0;
                            CLE."Closed at Date" := 0D;
                            CLE."Closed by Amount" := 0;
                            CLE."Closed by Amount (LCY)" := 0;
                            CLE."Closed by Currency Amount" := 0;
                            CLE."Sales (LCY)" := 0;
                            CLE."Profit (LCY)" := 0;
                            CLE.MODIFY;
                        UNTIL CLE.NEXT = 0;

                    Docno := "Document No.";
                    //MESSAGE(FORMAT(Docno));
                    DLE.RESET;
                    DLE.SETRANGE(DLE."Entry Type", DLE."Entry Type"::Application);
                    DLE.SETRANGE(DLE."Cust. Ledger Entry No.", "Entry No.");
                    //DLE.SETRANGE(DLE."Document No.",Docno);
                    IF DLE.FINDSET THEN
                        REPEAT
                            //MESSAGE(FORMAT(DLE."Entry No."));
                            DLE.Amount := 0;
                            DLE."Amount (LCY)" := 0;
                            DLE."Debit Amount" := 0;
                            DLE."Credit Amount" := 0;
                            DLE."Credit Amount (LCY)" := 0;
                            DLE."Debit Amount (LCY)" := 0;
                            DLE.MODIFY;
                        UNTIL DLE.NEXT = 0;

                    Open := TRUE;
                    MODIFY;
                END ELSE BEGIN */

                    // Added by Pranavi on 13-Jan-2017
                    Amt := 0;
                    DLE.RESET;
                    DLE.SETRANGE(DLE."Customer No.", Rec."Customer No.");
                    DLE.SETRANGE(DLE."Entry Type", DLE."Entry Type"::Application);
                    DLE.SETRANGE(DLE."Cust. Ledger Entry No.", Rec."Entry No.");
                    DLE.SETFILTER(DLE.Amount, '<>%1', 0);
                    IF DLE.FINDSET THEN
                        REPEAT
                            Amt := 0;
                            Temp_Amt := 0;
                            IF DLE.Amount > 0 THEN    // IF un-applying entry is receipt/credit memo
                            BEGIN
                                Temp_Amt := DLE.Amount;
                                DLE_1.RESET;
                                DLE_1.SETRANGE(DLE_1."Customer No.", DLE."Customer No.");
                                DLE_1.SETRANGE(DLE_1."Entry Type", DLE_1."Entry Type"::Application);
                                DLE_1.SETRANGE(DLE_1."Applied Cust. Ledger Entry No.", DLE."Applied Cust. Ledger Entry No.");
                                DLE_1.SETRANGE(DLE_1."Application No.", DLE."Application No.");
                                DLE_1.SETFILTER(DLE_1.Amount, '<%1', 0);
                                IF DLE_1.FINDSET THEN       // finding applied entries
                                    REPEAT
                                        IF Temp_Amt > 0 THEN BEGIN
                                            IF ABS(DLE_1.Amount) >= DLE.Amount THEN   // if applied entry amount  > un-applying entry amount then subtract the un-applying entry amount from applied entry amount
                                            BEGIN
                                                DLE_1.Amount := -(ABS(DLE_1.Amount) - DLE.Amount);
                                                DLE_1."Amount (LCY)" := -(ABS(DLE_1."Amount (LCY)") - DLE.Amount);
                                                DLE_1."Credit Amount" := ABS(DLE_1."Credit Amount") - DLE.Amount;
                                                DLE_1."Credit Amount (LCY)" := ABS(DLE_1."Credit Amount (LCY)") - DLE.Amount;
                                                DLE_1.MODIFY;
                                                Temp_Amt := 0;
                                            END ELSE BEGIN  // else make applied entry amount to zero
                                                Temp_Amt := Temp_Amt - ABS(DLE_1.Amount);
                                                DLE_1.Amount := 0;
                                                DLE_1."Amount (LCY)" := 0;
                                                DLE_1."Credit Amount" := 0;
                                                DLE_1."Credit Amount (LCY)" := 0;
                                                DLE_1.MODIFY;
                                            END;
                                            // Start--opening applied entry
                                            CLE_1.RESET;
                                            CLE_1.SETRANGE(CLE_1."Customer No.", DLE_1."Customer No.");
                                            CLE_1.SETRANGE(CLE_1."Entry No.", DLE_1."Cust. Ledger Entry No.");
                                            IF CLE_1.FINDFIRST THEN BEGIN
                                                CLE_1.CALCFIELDS(CLE_1."Remaining Amount");
                                                IF CLE_1."Remaining Amount" <> 0 THEN BEGIN
                                                    CLE_1.Open := TRUE;
                                                    CLE_1.MODIFY;
                                                END;
                                            END;
                                            // Ending--opening applied entry
                                        END;
                                    UNTIL DLE_1.NEXT = 0;
                            END ELSE BEGIN    // IF un-applying entry is Invoice
                                Temp_Amt := ABS(DLE.Amount);
                                DLE_1.RESET;
                                DLE_1.SETRANGE(DLE_1."Customer No.", DLE."Customer No.");
                                DLE_1.SETRANGE(DLE_1."Entry Type", DLE_1."Entry Type"::Application);
                                DLE_1.SETRANGE(DLE_1."Applied Cust. Ledger Entry No.", DLE."Applied Cust. Ledger Entry No.");
                                DLE_1.SETRANGE(DLE_1."Application No.", DLE."Application No.");
                                DLE_1.SETFILTER(DLE_1.Amount, '>%1', 0);
                                IF DLE_1.FINDSET THEN       // finding applied entries
                                    REPEAT
                                        IF Temp_Amt > 0 THEN BEGIN
                                            IF DLE_1.Amount >= ABS(DLE.Amount) THEN   // if applied entry amount  > un-applying entry amount then subtract the un-applying entry amount from applied entry amount
                                            BEGIN
                                                DLE_1.Amount := DLE_1.Amount - ABS(DLE.Amount);
                                                DLE_1."Amount (LCY)" := DLE_1."Amount (LCY)" - ABS(DLE.Amount);
                                                DLE_1."Debit Amount" := DLE_1."Debit Amount" - ABS(DLE.Amount);
                                                DLE_1."Debit Amount (LCY)" := DLE_1."Debit Amount (LCY)" - ABS(DLE.Amount);
                                                DLE_1.MODIFY;
                                                Temp_Amt := 0;
                                            END ELSE BEGIN          // else make applied entry amount to zero
                                                Temp_Amt := Temp_Amt - DLE_1.Amount;
                                                DLE_1.Amount := 0;
                                                DLE_1."Amount (LCY)" := 0;
                                                DLE_1."Debit Amount" := 0;
                                                DLE_1."Debit Amount (LCY)" := 0;
                                                DLE_1.MODIFY;
                                            END;
                                            // Starting--opening applied entry
                                            CLE_1.RESET;
                                            CLE_1.SETRANGE(CLE_1."Customer No.", DLE_1."Customer No.");
                                            CLE_1.SETRANGE(CLE_1."Entry No.", DLE_1."Cust. Ledger Entry No.");
                                            IF CLE_1.FINDFIRST THEN BEGIN
                                                CLE_1.CALCFIELDS(CLE_1."Remaining Amount");
                                                IF CLE_1."Remaining Amount" <> 0 THEN BEGIN
                                                    CLE_1.Open := TRUE;
                                                    CLE_1.MODIFY;
                                                END;
                                            END;
                                            // Ending--opening applied entry
                                        END;
                                    UNTIL DLE_1.NEXT = 0;
                            END;
                            DLE.Amount := 0;
                            DLE."Amount (LCY)" := 0;
                            DLE."Debit Amount" := 0;
                            DLE."Credit Amount" := 0;
                            DLE."Credit Amount (LCY)" := 0;
                            DLE."Debit Amount (LCY)" := 0;
                            DLE.MODIFY;
                        UNTIL DLE.NEXT = 0;

                    CLE.RESET;
                    CLE.SETRANGE(CLE."Customer No.", Rec."Customer No.");
                    CLE.SETRANGE(CLE."Closed by Entry No.", Rec."Entry No.");
                    IF CLE.FINDSET THEN
                        REPEAT
                            CLE."Closed by Entry No." := 0;
                            CLE."Closed at Date" := 0D;
                            CLE."Closed by Amount" := 0;
                            CLE."Closed by Amount (LCY)" := 0;
                            CLE."Closed by Currency Amount" := 0;
                            CLE."Sales (LCY)" := 0;
                            CLE."Profit (LCY)" := 0;
                            CLE.MODIFY;
                        UNTIL CLE.NEXT = 0;
                    Rec."Closed by Entry No." := 0;
                    Rec."Closed at Date" := 0D;
                    Rec."Closed by Amount" := 0;
                    Rec."Closed by Amount (LCY)" := 0;
                    Rec."Closed by Currency Amount" := 0;
                    Rec."Sales (LCY)" := 0;
                    Rec."Profit (LCY)" := 0;
                    Rec.Open := TRUE;
                    Rec.MODIFY;
                    // End by Pranavi
                    //END;
                end;
            }
        }
        addafter("&Navigate")
        {
            action(Attachments)
            {
                Caption = 'Attachments';
                Promoted = true;
                Image = Attachments;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    attachments.RESET;
                    attachments.SETRANGE("Table ID", DATABASE::"Cust. Ledger Entry");
                    attachments.SETRANGE("Document No.", Rec."Document No.");
                    PAGE.RUN(PAGE::"ESPL Attachments", attachments);
                end;
            }
            action("Un Apply All")
            {
                Caption = 'Un Apply All';
                Visible = false;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    // Added by Rakesh to unapply all Applied Entries

                    CLE.RESET;
                    CLE.SETRANGE(CLE."Customer No.", Rec."Customer No.");
                    //CLE.SETRANGE(CLE."Entry No.","Closed by Entry No.");
                    IF CLE.FINDSET THEN
                        REPEAT
                            CLE."Closed by Entry No." := 0;
                            CLE."Closed at Date" := 0D;
                            CLE."Closed by Amount" := 0;
                            CLE."Closed by Amount (LCY)" := 0;
                            CLE."Closed by Currency Amount" := 0;
                            CLE."Sales (LCY)" := 0;
                            CLE."Profit (LCY)" := 0;
                            CLE.MODIFY;
                        UNTIL CLE.NEXT = 0;

                    Docno := Rec."Document No.";
                    //MESSAGE(FORMAT(Docno));
                    CLE.RESET;
                    CLE.SETRANGE(CLE."Customer No.", Rec."Customer No.");
                    IF CLE.FINDSET THEN
                        REPEAT
                            DLE.RESET;
                            DLE.SETRANGE(DLE."Entry Type", DLE."Entry Type"::Application);
                            DLE.SETRANGE(DLE."Cust. Ledger Entry No.", CLE."Entry No.");
                            //DLE.SETRANGE(DLE."Document No.",Docno);
                            IF DLE.FINDSET THEN
                                REPEAT
                                    //MESSAGE(FORMAT(DLE."Entry No."));
                                    DLE.Amount := 0;
                                    DLE."Amount (LCY)" := 0;
                                    DLE."Debit Amount" := 0;
                                    DLE."Credit Amount" := 0;
                                    DLE."Credit Amount (LCY)" := 0;
                                    DLE."Debit Amount (LCY)" := 0;
                                    DLE.MODIFY;
                                UNTIL DLE.NEXT = 0;
                        UNTIL CLE.NEXT = 0;

                    Rec.Open := TRUE;
                    Rec.MODIFY;
                    // End by Rakesh
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        IF Rec.GETFILTER("Document No.") = '' THEN BEGIN
            IF USERID IN ['EFFTRONICS\DSR', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\BLAVANYA'] THEN BEGIN
                FiscialYear := FiscialYear::"22-23";
                CurrPage.UPDATE;
                CLE.RESET;
                CLE.COPYFILTERS(Rec);
                IF DATE2DMY(TODAY, 2) > 3 THEN BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3)), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) + 1));
                    CLE.SETRANGE(CLE."Posting Date", DMY2DATE(1, 4, 2008), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                END
                ELSE BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3) - 1), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                    CLE.SETRANGE(CLE."Posting Date", DMY2DATE(1, 4, 2008), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) - 1));
                END;

                Totals_Visible := TRUE;
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;
                IF CLE.FINDSET THEN
                    REPEAT
                        DLE.RESET;
                        DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                        DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                        IF DLE.FINDFIRST THEN
                            REPEAT
                                OpeningBal += DLE."Debit Amount" - DLE."Credit Amount";
                            UNTIL DLE.NEXT = 0;
                    UNTIL CLE.NEXT = 0;

                CLE.RESET;
                CLE.COPYFILTERS(Rec);
                IF CLE.FINDSET THEN
                    REPEAT
                        DLE.RESET;
                        DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                        DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                        IF DLE.FINDFIRST THEN
                            REPEAT
                                TotalCredit += DLE."Credit Amount";
                                TotalDebit += DLE."Debit Amount";
                            UNTIL DLE.NEXT = 0;
                    UNTIL CLE.NEXT = 0;
                ClosingBal := OpeningBal + TotalDebit - TotalCredit;
            END
            ELSE
                Totals_Visible := FALSE;
        END
        ELSE
            Rec.SETRANGE("Posting Date", Rec."Posting Date", Rec."Posting Date");
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle;
        IF ((USERID IN ['EFFTRONICS\DURGARAOV', 'EFFTRONICS\SGANESH', 'EFFTRONICS\DSR', 'EFFTRONICS\RAMKUMARL',
                        'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND', 'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BLAVANYA']) AND (CNT = 0)) THEN BEGIN
            IF FilterChanged THEN BEGIN

                CLE.RESET;
                CLE.COPYFILTERS(Rec);
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;
                IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2008) THEN BEGIN
                    CLE.SETRANGE(CLE."Posting Date", DMY2DATE(1, 4, 2008), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                    IF CLE.FINDSET THEN
                        REPEAT
                            DLE.RESET;
                            DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                            DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                            IF DLE.FINDFIRST THEN
                                REPEAT
                                    OpeningBal += DLE."Debit Amount" - DLE."Credit Amount";
                                UNTIL DLE.NEXT = 0;
                        UNTIL CLE.NEXT = 0;
                END;

                CLE.RESET;
                CLE.COPYFILTERS(Rec);
                IF CLE.FINDSET THEN
                    REPEAT
                        DLE.RESET;
                        DLE.SETFILTER(DLE."Cust. Ledger Entry No.", '%1', CLE."Entry No.");
                        DLE.SETFILTER(DLE."Entry Type", '<>%1', DLE."Entry Type"::Application);
                        IF DLE.FINDFIRST THEN
                            REPEAT
                                TotalCredit += DLE."Credit Amount";
                                TotalDebit += DLE."Debit Amount";
                            UNTIL DLE.NEXT = 0;
                    UNTIL CLE.NEXT = 0;
                ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                // CNT:=1;
            END;
        END;
    end;

    var
        CLE: Record "Cust. Ledger Entry";
        DLE: Record "Detailed Cust. Ledg. Entry";
        Docno: Code[30];
        UserSetupGRec: Record "User Setup";
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        ClosingBal: Decimal;
        Totals_Visible: Boolean;
        OpeningBal: Decimal;
        FiscialYear: Option "08-09","09-10","10-11","11-12","12-13","13-14","14-15","15-16","16-17","17-18","18-19","19-20","20-21","21-22","22-23";
        CNT: Integer;
        attachments: Record Attachments;
        LastEntryNo: Integer;
        LastRecFilter: Text;
        StyleTxt: Text;


    PROCEDURE FilterChanged(): Boolean;
    BEGIN
        IF LastRecFilter <> Rec.GETFILTERS THEN BEGIN
            LastRecFilter := Rec.GETFILTERS;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    END;
}