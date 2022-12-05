pageextension 70268 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        addfirst(content)
        {


            /*group(Control1102152007)
            {
                ShowCaption = false;

                field("xRec.COUNT"; xRec.COUNT)
                {
                    ApplicationArea = All;
                    caption='Total Entries';

                }
            }*/
            group(Control1102152054)
            {
                ShowCaption = false;
                Visible = "Totals_Visible";

                field("xRec.COUNT"; xRec.COUNT)
                {
                    ApplicationArea = All;
                    caption = 'Total Entries';

                }
                field(FiscialYear; FiscialYear)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CASE FiscialYear OF
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
                        IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND',
                                    'EFFTRONICS\SGANESH', 'EFFTRONICS\DSR', 'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\RENUKACH',
                                    'EFFTRONICS\PADMASRI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\CHOWDARY',
                                    'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                            VLE.RESET;
                            VLE.COPYFILTERS(Rec);
                            TotalCredit := 0;
                            TotalDebit := 0;
                            OpeningBal := 0;
                            ClosingBal := 0;
                            IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2008) THEN BEGIN
                                VLE.SETRANGE(VLE."Posting Date", DMY2DATE(1, 4, 2008), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                                IF VLE.FINDSET THEN
                                    REPEAT
                                        DVLE.RESET;
                                        DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                                        DVLE.SETFILTER(DVLE."Entry Type", '<>%1', DVLE."Entry Type"::Application);
                                        IF DVLE.FINDFIRST THEN
                                            REPEAT
                                                //OpeningBal+=DVLE."Debit Amount"-DVLE."Credit Amount"; // Commented by Vishnu on 29-04-2019
                                                OpeningBal += DVLE."Debit Amount (LCY)" - DVLE."Credit Amount (LCY)";
                                            UNTIL DVLE.NEXT = 0;
                                    UNTIL VLE.NEXT = 0;
                                // MESSAGE(FORMAT(OpeningBal)); //testing
                            END;

                            VLE.RESET;
                            VLE.COPYFILTERS(Rec);
                            IF VLE.FINDSET THEN
                                REPEAT
                                    DVLE.RESET;
                                    DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                                    DVLE.SETFILTER(DVLE."Entry Type", '<>%1', DVLE."Entry Type"::Application);
                                    IF DVLE.FINDFIRST THEN
                                        REPEAT
                                            /*{TotalCredit += DVLE."Credit Amount";
                                                TotalDebit += DVLE."Debit Amount";} */  // Commented by Vishnu on 29-04-2019
                                            TotalCredit += DVLE."Credit Amount (LCY)";
                                            TotalDebit += DVLE."Debit Amount (LCY)";
                                        UNTIL DVLE.NEXT = 0;
                                UNTIL VLE.NEXT = 0;
                            ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                            //MESSAGE(FORMAT(ClosingBal)); //testing
                        END;
                        CurrPage.UPDATE(false); // temporarily commented//EFFUPG1.2
                    end;
                }
            }

        }
        addafter("External Document No.")
        {
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;

            }
            field("Amount to Apply"; "Amount to Apply")
            {
                ApplicationArea = All;
            }
        }

        addafter("Remaining Amount")
        {
            /* field("TDS Nature of Deduction"; "TDS Nature of Deduction")
             {
                 ApplicationArea = All;

             }
             field("TDS Group"; "TDS Group")
             {
                 ApplicationArea = All;

             }*/
            field("Total TDS Including SHE CESS"; Rec."Total TDS Including SHE CESS")
            {
                ApplicationArea = All;

            }
            field("DD/FDR No."; Rec."DD/FDR No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Payment Through"; Rec."Payment Through")
            {
                Editable = true;
                ApplicationArea = All;
            }
        }
        addafter(Open)
        {
            field(Positive; Rec.Positive)
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Exported to Payment File")
        {
            field("Purchase (LCY)"; Rec."Purchase (LCY)")
            {
                ApplicationArea = All;

            }
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;

            }

        }
        addafter(Control1)
        {
            group(Totals)
            {
                Caption = 'Totals';
                Visible = "Totals_Visible";
                grid(Control1102152052)
                {
                    ShowCaption = false;
                    GridLayout = Rows;

                    group(Control1102152051)
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
                    group(Control1102152049)
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
                    group(Control1102152047)
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
                    group(Control1102152045)
                    {
                        ShowCaption = false;
                        field(ClosingBal; ClosingBal)
                        {
                            Width = 100;
                            Caption = 'Closing Balance';
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
                action("MSPT Vendor Ledger Entries")
                {
                    Caption = 'MSPT Vendor Ledger Entries';
                    RunObject = Page "MSPT Vendor Ledger Entries";
                    RunPageLink = "Entry No." = FIELD("Entry No.");
                    ApplicationArea = All;
                }
                action("MSPT Detailed Ledger Entries")
                {
                    Caption = 'MSPT Detailed Ledger Entries';
                    RunObject = Page "MSPT Dtld.Vendor Ledg. Entries";
                    RunPageLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    ApplicationArea = All;


                }
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
                    attachments.SETRANGE("Table ID", DATABASE::"Vendor Ledger Entry");
                    attachments.SETRANGE("Document No.", Rec."Document No.");
                    PAGE.RUN(PAGE::"ESPL Attachments", attachments);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Posting Date=FILTER(>31-03-08) //Rev01
        Rec.SETFILTER("Posting Date", '>%1', DMY2Date(31, 03, 10)); //Rev01
        IF Rec.GETFILTER("Document No.") = '' THEN BEGIN
            IF USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND',
                                   'EFFTRONICS\SGANESH', 'EFFTRONICS\DSR', 'EFFTRONICS\RAJANI', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\ANANDA',
                                   'EFFTRONICS\ASWINI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\CHOWDARY',
                                   'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\VHARIPRASAD', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\CHRAJYALAKSHMI', 'EFFTRONICS\SUJITH', 'EFFTRONICS\BLAVANYA'] THEN begin
                FiscialYear := FiscialYear::"22-23";
                VLE.RESET;
                VLE.COPYFILTERS(Rec);
                IF DATE2DMY(TODAY, 2) > 3 THEN BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3)), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) + 1));
                    VLE.SETRANGE(VLE."Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                END
                ELSE BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3) - 1), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                    VLE.SETRANGE(VLE."Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) - 1));
                END;

                Totals_Visible := TRUE;
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;
                IF VLE.FINDSET THEN
                    REPEAT
                        DVLE.RESET;
                        DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                        //DVLE.SETFILTER(DVLE."Entry Type",'<>%1',DVLE."Entry Type"::Application);
                        IF DVLE.FINDFIRST THEN
                            REPEAT
                                //OpeningBal+=DVLE."Debit Amount"-DVLE."Credit Amount";
                                OpeningBal += DVLE."Debit Amount (LCY)" - DVLE."Credit Amount (LCY)";
                            UNTIL DVLE.NEXT = 0;
                    UNTIL VLE.NEXT = 0;

                VLE.RESET;
                VLE.COPYFILTERS(Rec);
                IF VLE.FINDSET THEN
                    REPEAT
                        DVLE.RESET;
                        DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                        //DVLE.SETFILTER(DVLE."Entry Type",'<>%1',DVLE."Entry Type"::Application);
                        IF DVLE.FINDFIRST THEN
                            REPEAT
                                //TotalCredit+=DVLE."Credit Amount"; // vishnu Commented on 29-04-2019
                                //TotalDebit+=DVLE."Debit Amount"; // vishnu Commented on 29-04-2019

                                TotalCredit += DVLE."Credit Amount (LCY)";
                                TotalDebit += DVLE."Debit Amount (LCY)";
                            UNTIL DVLE.NEXT = 0;
                    UNTIL VLE.NEXT = 0;
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
        IF (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND',
                                          'EFFTRONICS\SGANESH', 'EFFTRONICS\DSR', 'EFFTRONICS\RAJANI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\PADMASRI',
                                          'EFFTRONICS\ANANDA', 'EFFTRONICS\ASWINI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\CHOWDARY',
                                          'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\VHARIPRASAD', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\CHRAJYALAKSHMI', 'EFFTRONICS\SUJITH', 'EFFTRONICS\BLAVANYA']) THEN BEGIN
            IF FilterChanged THEN BEGIN
                VLE.RESET;
                VLE.COPYFILTERS(Rec);
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;
                IF Rec.GETFILTER("Posting Date") = '' THEN
                    Rec.SETFILTER("Posting Date", '>=%1', DMY2DATE(1, 4, 2010));
                IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2010) THEN BEGIN
                    VLE.SETRANGE(VLE."Posting Date", DMY2DATE(1, 4, 2010), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                    // MESSAGE(FORMAT(GETRANGEMIN(Rec."Posting Date"))); //added by vishnu on 23-09-2019
                    IF VLE.FINDSET THEN
                        REPEAT
                            DVLE.RESET;
                            DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                            DVLE.SETFILTER(DVLE."Entry Type", '<>%1', DVLE."Entry Type"::Application);
                            IF DVLE.FINDFIRST THEN
                                REPEAT
                                    //OpeningBal+=DVLE."Debit Amount"-DVLE."Credit Amount"; // Commented by Vishnu on 29-04-2019
                                    OpeningBal += DVLE."Debit Amount (LCY)" - DVLE."Credit Amount (LCY)";
                                UNTIL DVLE.NEXT = 0;
                        UNTIL VLE.NEXT = 0;
                END;

                VLE.RESET;
                VLE.COPYFILTERS(Rec);
                IF VLE.FINDSET THEN
                    REPEAT
                        DVLE.RESET;
                        DVLE.SETFILTER(DVLE."Vendor Ledger Entry No.", '%1', VLE."Entry No.");
                        DVLE.SETFILTER(DVLE."Entry Type", '<>%1', DVLE."Entry Type"::Application);
                        IF DVLE.FINDFIRST THEN
                            REPEAT
                                /* TotalCredit += DVLE."Credit Amount";
                                 TotalDebit += DVLE."Debit Amount"; */  // commented by Vishnu on 29-04-2019
                                TotalCredit += DVLE."Credit Amount (LCY)";
                                TotalDebit += DVLE."Debit Amount (LCY)";
                            UNTIL DVLE.NEXT = 0;
                    UNTIL VLE.NEXT = 0;
                ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                //    CNT:=1;
            END;
        END;
    end;

    var
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        ClosingBal: Decimal;
        Totals_Visible: Boolean;
        OpeningBal: Decimal;
        VLE: Record "Vendor Ledger Entry";
        DVLE: Record "Detailed Vendor Ledg. Entry";
        FiscialYear: Option "10-11","11-12","12-13","13-14","14-15","15-16","16-17","17-18","18-19","19-20","20-21","21-22","22-23";
        CNT: Integer;
        attachments: Record Attachments;
        LastRecFilter: Text;

    PROCEDURE FilterChanged(): Boolean;
    BEGIN
        IF LastRecFilter <> Rec.GETFILTERS THEN BEGIN
            LastRecFilter := Rec.GETFILTERS;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    END;
}