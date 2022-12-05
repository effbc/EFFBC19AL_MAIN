report 50092 Cancellation_report_new
{
    // version Rev01,Eff02,EFFUPG

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    dataset
    {
        dataitem("Prod. Order Line"; "Prod. Order Line")
        {
            RequestFilterFields = "Prod. Order No.", "Line No.";
            dataitem("Reservation Entry"; "Reservation Entry")
            {
                DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
                                    WHERE("Reservation Status" = FILTER(Reservation),
                                          "Source Type" = FILTER(5406));

                trigger OnAfterGetRecord();
                begin
                    //ReservEngineMgt.CloseReservEntry2("Reservation Entry");EFFUPG
                    ReservEngineMgt.CancelReservation("Reservation Entry");//EFFUPG
                    Cnt := Cnt + 1;
                end;

                trigger OnPostDataItem();
                begin
                    //MESSAGE(FORMAT(Cnt));
                end;

                trigger OnPreDataItem();
                begin

                    "P.O No" := "Prod. Order Line".GETFILTER("Prod. Order Line"."Prod. Order No.");
                    IF "P.O No" <> '' THEN BEGIN
                        "Reservation Entry".SETFILTER("Reservation Entry"."Source ID", "P.O No");
                        "Reservation Entry".SETRANGE("Reservation Entry"."Source Subtype", "Prod. Order Line".Status);
                        "Reservation Entry".SETRANGE("Reservation Entry"."Source Batch Name", '');
                        "Reservation Entry".SETRANGE("Reservation Entry"."Source Ref. No.", 0);
                    END
                    ELSE
                        CurrReport.BREAK;

                    IF "Prod. Order Line".GETFILTER("Prod. Order Line"."Line No.") <> '' THEN
                        EVALUATE(Line, "Prod. Order Line".GETFILTER("Prod. Order Line"."Line No."));
                    IF Line <> 0 THEN BEGIN
                        "Reservation Entry".SETRANGE("Reservation Entry"."Source Prod. Order Line", Line);
                    END;
                end;
            }

            trigger OnPreDataItem();
            begin
                IF RE = FALSE THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            DataItemTableView = WHERE("Prod. Order Line No." = FILTER(10000));
            dataitem("<Reservation Entry1>"; "Reservation Entry")
            {
                DataItemLink = "Source ID" = FIELD("Prod. Order No."),
                               "Source Prod. Order Line" = FIELD("Prod. Order Line No."),
                               "Item No." = FIELD("Item No.");
                DataItemTableView = WHERE("Source Type" = FILTER(5407));

                trigger OnAfterGetRecord();
                begin
                    "<Reservation Entry1>".DELETE;
                end;
            }

            trigger OnPreDataItem();
            begin
                IF IT = FALSE THEN
                    CurrReport.BREAK;

                "Prod. Order Component".RESET;
                "Prod. Order Component".SETFILTER("Prod. Order Component"."Prod. Order No.", no);
            end;
        }
        dataitem("<Prod. Order Line1>"; "Prod. Order Line")
        {
            dataitem(DataItem7209; "Item Ledger Entry")
            {
                DataItemLink = "Order No." = FIELD("Prod. Order No."),
                               "Item No." = FIELD("Item No.");
                DataItemTableView = WHERE("Entry Type" = FILTER(Output),
                                          "Location Code" = FILTER('PROD'),
                                          "Remaining Quantity" = FILTER(> 0),
                                          Open = CONST(true),
                                          Positive = CONST(true));
                dataitem("<Reservation Entry2>"; "Reservation Entry")
                {
                    DataItemLink = "Item No." = FIELD("Item No."),
                                   "Serial No." = FIELD("Serial No.");
                    DataItemTableView = SORTING("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
                                        WHERE("Reservation Status" = FILTER(Reservation),
                                              "Source Type" = FILTER(32));

                    trigger OnAfterGetRecord();
                    begin
                        //ReservEngineMgt.CloseReservEntry2("<Reservation Entry2>");EFFUPG
                        ReservEngineMgt.CancelReservation("<Reservation Entry2>");//EFFUPG
                        Cnt := Cnt + 1;
                    end;
                }
            }

            trigger OnPreDataItem();
            begin
                IF IL = FALSE THEN
                    CurrReport.BREAK;
                "<Prod. Order Line1>".SETFILTER("<Prod. Order Line1>"."Prod. Order No.", no);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(RE; RE)
                    {
                        Caption = 'Reservation entries';
                    }
                    field(IT; IT)
                    {
                        Caption = 'Tracking Entries';
                    }
                    field(IL; IL)
                    {
                        Caption = 'Reservation Entries(After Serial no Posting)';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        MESSAGE(FORMAT(Cnt));
    end;

    trigger OnPreReport();
    begin
        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\GRAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\ANUSHAB', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\GURULAKSHMI', 'EFFTRONICS\RTEJASWI', 'EFFTRONICS\TPRIYANKA']) THEN
            ERROR('U HAVE NO RIGHTS TO RUN THIS REPORT');
        IF ("Prod. Order Line".GETFILTER("Prod. Order Line"."Prod. Order No.") = '') AND (("Reservation Entry"."Item No." = '')
           OR (("Reservation Entry"."Serial No." = '') AND ("Reservation Entry"."Lot No." = ''))) THEN
            ERROR('Enter Sufficient Inputs');
        no := "Prod. Order Line".GETFILTER("Prod. Order Line"."Prod. Order No.");
    end;

    var
        ReservEngineMgt: Codeunit 99000831;
        Cnt: Integer;
        Text: Text[100];
        "P.O No": Code[400];
        Item1: Code[20];
        Line: Integer;
        RE: Boolean;
        IT: Boolean;
        no: Code[400];
        IL: Boolean;
}

