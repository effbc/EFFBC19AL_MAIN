pageextension 70265 GeneralLedgerEntriesExt extends "General Ledger Entries"
{
    Editable = true;

    layout
    {
        addbefore(Control1)
        {
            group(Control1102152015)
            {
                Visible = "Totals_Visible";
                ShowCaption = false;
                field(FiscialYear; 9)
                {
                    Caption = 'Year';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CASE FiscialYear OF
                            FiscialYear::"08-09":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, 2011));
                                END;
                            FiscialYear::"09-10":
                                BEGIN
                                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, 2011));
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
                        IF USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PURNACHAND', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\20TE128',
                                      'EFFTRONICS\DSR', 'EFFTRONICS\RAJANI', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\ASWINI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                            GLE.RESET;
                            GLE.COPYFILTERS(Rec);
                            TotalCredit := 0;
                            TotalDebit := 0;
                            OpeningBal := 0;
                            ClosingBal := 0;
                            IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2008) THEN BEGIN
                                GLE.SETRANGE(GLE."Posting Date", DMY2DATE(1, 4, 2008), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                                IF GLE.FINDSET THEN
                                    REPEAT
                                        OpeningBal += GLE."Debit Amount" - GLE."Credit Amount";
                                    UNTIL GLE.NEXT = 0;
                            END;

                            GLE.RESET;
                            GLE.COPYFILTERS(Rec);
                            IF GLE.FINDSET THEN
                                REPEAT
                                    TotalCredit += GLE."Credit Amount";
                                    TotalDebit += GLE."Debit Amount";
                                UNTIL GLE.NEXT = 0;
                            ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
            }
        }
        addafter(Control1)
        {
            field("No. Series"; Rec."No. Series")
            {
                ApplicationArea = All;

            }
        }
        addafter("Posting Date")
        {
            field("System Date"; Rec."System Date")
            {
                ApplicationArea = All;

            }
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Document No.")
        {
            field("Tender No"; Rec."Tender No")
            {
                ApplicationArea = All;

            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;

            }
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("G/L Account No.")
        {
            field("Payment Type"; Rec."Payment Type")
            {
                ApplicationArea = All;

            }
            field(Control1102154008; Rec.Attachment)
            {
                ApplicationArea = All;

            }
            field("System-Created Entry"; Rec."System-Created Entry")
            {
                ApplicationArea = All;

            }
        }
        addafter("Job No.")
        {
            field("Sale Order No."; Rec."Sale Order No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("VAT Amount")
        {
            /*
            field("Tax Amount"; "Tax Amount")
            {
                ApplicationArea = All;

            }
            */
        }
        addafter("Entry No.")
        {
            field("Add.-Currency Debit Amount"; Rec."Add.-Currency Debit Amount")
            {
                ApplicationArea = All;

            }
            field("Add.-Currency Credit Amount"; Rec."Add.-Currency Credit Amount")
            {
                ApplicationArea = All;

            }
            field("Currency Amount"; Rec."Currency Amount")
            {
                ApplicationArea = All;

            }


            /* group(Control1102152012)
             {
                 ShowCaption = false;
             }
             group(Control1102152011)
             {
                 ShowCaption = false;
             }*/
            field(OpeningBal; OpeningBal)
            {
                Caption = 'Opening Balance';
                Style = Favorable;
                StyleExpr = true;
                ApplicationArea = All;
            }
            /*group(Control1102152009)
            {
                ShowCaption = false;
            }*/
            field(TotalCredit; TotalCredit)
            {
                Caption = 'Credit';
                Style = StrongAccent;
                StyleExpr = true;
                ApplicationArea = All;
            }
            /* group(Control1102152008)
             {
                 ShowCaption = false;
             }*/
            field(TotalDebit; TotalDebit)
            {
                Caption = 'Debit';
                StyleExpr = true;
                Style = StrongAccent;
                ApplicationArea = All;
            }
            /*group(Control1102152005)
            {
                ShowCaption = false;
            }*/
            field(ClosingBal; ClosingBal)
            {
                Width = 100;
                Caption = 'Closing Balance';
                Style = Favorable;
                StyleExpr = true;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(IncomingDocAttachFile)
        {
            action(Print)
            {
                Caption = 'Print';
                Image = Print;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //  CurrPage.SETSELECTIONFILTER(GLAcc);
                    REPORT.RUNMODAL(13772, TRUE, TRUE);
                end;
            }
            action(Attachment)
            {
                Caption = 'Attachment';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CustAttach.SETRANGE("Table ID", DATABASE::"G/L Entry");
                    CustAttach.SETRANGE("Document No.", Rec."Document No.");

                    PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
                end;
            }
        }

    }

    trigger OnOpenPage()
    begin
        IF ((Rec."Document No.") = '') AND (Rec.GETFILTER("Document No.") = '') THEN BEGIN
            IF USERID IN ['EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\PADMASRI',
                          'EFFTRONICS\DSR', 'EFFTRONICS\PURNACHAND', 'EFFTRONICS\20TE128', 'EFFTRONICS\20TE106', 'EFFTRONICS\TPRIYANKA',
                          'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                FiscialYear := FiscialYear::"20-21";
                CurrPage.UPDATE;
                GLE.RESET;
                GLE.COPYFILTERS(Rec);
                IF DATE2DMY(TODAY, 2) > 3 THEN BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3)), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) + 1));
                    GLE.SETRANGE(GLE."Posting Date", DMY2DATE(1, 4, 2008), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                END
                ELSE BEGIN
                    Rec.SETRANGE("Posting Date", DMY2DATE(1, 4, DATE2DMY(TODAY, 3) - 1), DMY2DATE(31, 3, DATE2DMY(TODAY, 3)));
                    GLE.SETRANGE(GLE."Posting Date", DMY2DATE(1, 4, 2010), DMY2DATE(31, 3, DATE2DMY(TODAY, 3) - 1));
                END;
                Totals_Visible := TRUE;
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;
                IF GLE.FINDFIRST THEN
                    REPEAT
                        OpeningBal += GLE."Debit Amount" - GLE."Credit Amount";
                    UNTIL GLE.NEXT = 0;


                GLE.RESET;
                GLE.COPYFILTERS(Rec);
                IF GLE.FINDSET THEN
                    REPEAT
                        TotalCredit += GLE."Credit Amount";
                        TotalDebit += GLE."Debit Amount";

                    UNTIL GLE.NEXT = 0;
                ClosingBal := OpeningBal + TotalDebit - TotalCredit;
            END
            ELSE
                Totals_Visible := FALSE;
        END
        ELSE BEGIN
            IF Rec."Posting Date" <> 0D THEN
                Rec.SETRANGE("Posting Date", Rec."Posting Date", Rec."Posting Date");
        END;
    end;

    trigger OnAfterGetRecord()
    begin
        //StyleTxt := SetStyle;

        IF ((USERID IN ['EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\ASWINI', 'EFFTRONICS\ANILKUMAR',
          'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\20TE128', 'EFFTRONICS\TPRIYANKA',
                        'EFFTRONICS\DSR', 'EFFTRONICS\PURNACHAND', 'EFFTRONICS\RAJANI', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\BLAVANYA'])) THEN BEGIN
            IF FilterChanged THEN BEGIN
                GLE.RESET;
                GLE.COPYFILTERS(Rec);
                TotalCredit := 0;
                TotalDebit := 0;
                OpeningBal := 0;
                ClosingBal := 0;

                IF Rec.GETRANGEMIN(Rec."Posting Date") > DMY2DATE(1, 4, 2008) THEN BEGIN
                    GLE.SETRANGE(GLE."Posting Date", DMY2DATE(1, 4, 2008), Rec.GETRANGEMIN(Rec."Posting Date") - 1);
                    IF GLE.FINDSET THEN
                        REPEAT
                            OpeningBal += GLE."Debit Amount" - GLE."Credit Amount";
                        UNTIL GLE.NEXT = 0;
                END;

                GLE.RESET;
                GLE.COPYFILTERS(Rec);
                IF GLE.FINDSET THEN
                    REPEAT
                        TotalCredit += GLE."Credit Amount";
                        TotalDebit += GLE."Debit Amount";
                    UNTIL GLE.NEXT = 0;
                ClosingBal := OpeningBal + TotalDebit - TotalCredit;
                //CNT:=1;
            END;
        END;
    end;

    var
        CustAttach: Record Attachments;
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        ClosingBal: Decimal;
        Totals_Visible: Boolean;
        OpeningBal: Decimal;
        FiscialYear: option "08-09","09-10","10-11","11-12","12-13","13-14","14-15","15-16","16-17","17-18","18-19","19-20","20-21","21-22","22-23";
        GLE: Record "G/L Entry";
        CNT: Decimal;
        RecCount: Integer;
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