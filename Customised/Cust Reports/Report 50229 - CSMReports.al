report 50229 "CSM Reports"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CSMReports.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Service Header"; "Service Header")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order), "Order Date" = FILTER(>= '04/01/11'));
            RequestFilterFields = "Order Date";
            column(Received_DateCaption; Received_DateCaptionLbl)
            {
            }
            column(Service_Item_Line__Document_No__Caption; "Service Item Line".FIELDCAPTION("Document No."))
            {
            }
            column(Service_Item_Line__Item_No__Caption; "Service Item Line".FIELDCAPTION("Item No."))
            {
            }
            column(Service_Item_Line_DescriptionCaption; "Service Item Line".FIELDCAPTION(Description))
            {
            }
            column(Service_Item_Line__Serial_No__Caption; "Service Item Line".FIELDCAPTION("Serial No."))
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Manfacturing_DateCaption; Manfacturing_DateCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            column(Service_Item_Line__Response_Date_Caption; "Service Item Line".FIELDCAPTION("Response Date"))
            {
            }
            column(Service_Header_Document_Type; "Document Type")
            {
            }
            column(Service_Header_No_; "No.")
            {
            }
            dataitem("Service Item Line"; "Service Item Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = CONST(Order), "Item No." = FILTER(<> ''));
                RequestFilterFields = "Finishing Date";
                column(Service_Item_Line__Document_No__; "Document No.")
                {
                }
                column(Service_Item_Line__Item_No__; "Item No.")
                {
                }
                column(Service_Item_Line_Description; Description)
                {
                }
                column(Service_Item_Line__Serial_No__; "Serial No.")
                {
                }
                column(Service_Item_Line__Order_Date_; "Order Date")
                {
                }
                column(Location; Location)
                {
                }
                column(Manf_Date_; "Manf.Date")
                {
                }
                column(Status; Status)
                {
                }
                column(Service_Item_Line__Response_Date_; "Response Date")
                {
                }
                column(Service_Item_Line_Document_Type; "Document Type")
                {
                }
                column(Service_Item_Line_Line_No_; "Line No.")
                {
                }
                dataitem("Service Line"; "Service Line")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Service Item No." = FIELD("Service Item No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Service Item No.") ORDER(Ascending);

                    trigger OnAfterGetRecord()
                    begin
                        IF EXCEL AND ("Service Line".Type = "Service Line".Type::Item) THEN BEGIN
                            IF k = 0 THEN BEGIN
                                Row += 1;
                                Entercell(Row, 1, FORMAT("Service Header"."Order Date"), FALSE);
                                Entercell(Row, 2, "Service Header"."No.", FALSE);
                                Entercell(Row, 3, "Service Header".Description, FALSE);
                            END;
                            Entercell(Row, 4, "Service Line"."Fault Area Description", FALSE);
                            Entercell(Row, 5, "Service Line"."Fault Reason Description", FALSE);
                            Item.GET("Service Item Line"."Item No.");
                            Entercell(Row, 6, Item.Description, FALSE);
                            IF J = 0 THEN
                                Entercell(Row, 7, FORMAT(1), FALSE);

                            Entercell(Row, 8, "Service Item Line"."Serial No.", FALSE);
                            IF "Manf.Date" <> 0D THEN
                                Entercell(Row, 9, FORMAT("Manf.Date"), FALSE);
                            Entercell(Row, 20, FORMAT("Service Item Line"."Finishing Date"), FALSE);

                            Entercell(Row, 10, "Service Line"."Fault Code Description", FALSE);
                            Entercell(Row, 11, "Service Line"."Symptom Description", FALSE);
                            Entercell(Row, 12, "Service Line".Observations, FALSE);
                            Entercell(Row, 13, "Service Line"."Resolution Description", FALSE);
                            Entercell(Row, 14, "Service Line".Description, FALSE);
                            Entercell(Row, 15, FORMAT("Service Line".Quantity), FALSE);
                            Entercell(Row, 16, "Service Line"."Component Legending", FALSE);
                            ServiceLine.RESET;
                            ServiceLine.SETFILTER(ServiceLine."Document No.", "Service Line"."Document No.");
                            ServiceLine.SETFILTER(ServiceLine."Service Item No.", "Service Line"."Service Item No.");
                            ServiceLine.SETFILTER(ServiceLine."Line No.", '>%1', "Service Line"."Line No.");
                            ServiceLine.SETFILTER(ServiceLine.Type, '%1', 2);
                            IF ServiceLine.FINDFIRST THEN BEGIN
                                I := 0;
                                Entercell(Row, 18, ServiceLine.Description, FALSE);
                                newvalue := ServiceLine."Line No.";
                                IF newvalue <> oldvalue THEN BEGIN
                                    Entercell(Row, 19, FORMAT(ServiceLine.Quantity), FALSE);
                                END;
                                oldvalue := ServiceLine."Line No.";
                                PMIH.RESET;
                                PMIH.SETFILTER(PMIH."Service Order No.", "Service Line"."Document No.");
                                PMIH.SETFILTER(PMIH."Service Item", "Service Line"."Service Item No.");
                                PMIH.SETFILTER(PMIH."User ID", ServiceLine."No.");
                                IF PMIH.FINDFIRST THEN
                                    REPEAT
                                        ILE.RESET;
                                        ILE.SETFILTER(ILE."Entry Type", '%1', 4);
                                        ILE.SETFILTER(ILE."Item No.", "Service Line"."No.");
                                        ILE.SETFILTER(ILE."Document No.", PMIH."No.");
                                        IF ILE.FINDFIRST THEN BEGIN
                                            IF I = 0 THEN
                                                Entercell(Row, 17, ILE."Lot No.", FALSE);
                                            I := I + 1;
                                        END;
                                    UNTIL PMIH.NEXT = 0;
                            END;
                            J := 1;
                        END;
                        k := 0;
                        IF EXCEL AND ("Service Line".Type = "Service Line".Type::Resource) THEN BEGIN
                            test := 0;
                            ServiceLine.RESET;
                            ServiceLine.SETFILTER(ServiceLine."Document No.", "Service Line"."Document No.");
                            ServiceLine.SETFILTER(ServiceLine."Service Item No.", "Service Line"."Service Item No.");
                            ServiceLine.SETFILTER(ServiceLine."Line No.", '<%1', "Service Line"."Line No.");
                            IF ServiceLine.FINDLAST THEN BEGIN
                                IF ServiceLine.Type = ServiceLine.Type::Item THEN
                                    test := 5;
                            END;
                            IF test <> 5 THEN BEGIN
                                Row += 1;
                                Entercell(Row, 1, FORMAT("Service Header"."Order Date"), FALSE);
                                Entercell(Row, 2, "Service Header"."No.", FALSE);
                                Entercell(Row, 3, "Service Header".Description, FALSE);
                                Entercell(Row, 4, "Service Line"."Fault Area Description", FALSE);
                                Entercell(Row, 5, "Service Line"."Fault Reason Description", FALSE);
                                Entercell(Row, 20, FORMAT("Service Item Line"."Finishing Date"), FALSE);
                                Entercell(Row, 10, "Service Line"."Fault Code Description", FALSE);
                                Entercell(Row, 11, "Service Line"."Symptom Description", FALSE);
                                Entercell(Row, 12, "Service Line".Observations, FALSE);
                                Entercell(Row, 13, "Service Line"."Resolution Description", FALSE);
                                Entercell(Row, 18, "Service Line".Description, FALSE);
                                Entercell(Row, 19, FORMAT("Service Line".Quantity), FALSE);
                                Item.GET("Service Item Line"."Item No.");
                                Entercell(Row, 6, Item.Description, FALSE);
                                IF J = 0 THEN
                                    Entercell(Row, 7, FORMAT(1), FALSE);
                                Entercell(Row, 8, "Service Item Line"."Serial No.", FALSE);
                                IF "Manf.Date" <> 0D THEN
                                    Entercell(Row, 9, FORMAT("Manf.Date"), FALSE);
                            END;
                        END;
                        J := 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        IF Choice <> Choice::Ts THEN
                            CurrReport.BREAK;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    k := 0;
                    "Manf.Date" := 0D;
                    J := 0;
                    oldvalue := 0;
                    Item.GET("Service Item Line"."Item No.");
                    IF Item."Product Group Code Cust" <> 'B OUT' THEN BEGIN
                        ILE.RESET;
                        ILE.SETFILTER(ILE."Entry Type", '%1', 6);
                        ILE.SETFILTER(ILE."Item No.", "Service Item Line"."Item No.");
                        ILE.SETFILTER(ILE."Serial No.", "Service Item Line"."Serial No.");
                        IF ILE.FINDFIRST THEN
                            "Manf.Date" := ILE."Posting Date";
                    END;
                    IF "Service Item Line".Account = TRUE THEN
                        Status := "Service Item Line"."To Location"
                    ELSE
                        Status := 'TT';

                    IF EXCEL AND (Choice <> Choice::Ts) THEN BEGIN
                        Row += 1;
                        Entercell(Row, 1, FORMAT("Service Header"."Order Date"), FALSE);
                        Entercell(Row, 2, "Service Header".Description, FALSE);
                        Entercell(Row, 3, "Service Header"."No.", FALSE);
                        Entercell(Row, 4, "Service Item Line"."Item No.", FALSE);
                        Entercell(Row, 5, "Service Item Line".Description, FALSE);
                        Entercell(Row, 6, "Service Item Line"."Serial No.", FALSE);
                        Entercell(Row, 7, FORMAT("Manf.Date"), FALSE);
                        Entercell(Row, 8, Status, FALSE);
                        Entercell(Row, 9, FORMAT("Service Item Line"."Finishing Date"), FALSE);
                        IF Choice = Choice::In_out THEN BEGIN
                            ILE.RESET;
                            ILE.SETFILTER(ILE."Entry Type", '%1', 4);
                            ILE.SETFILTER(ILE."Item No.", "Service Item Line"."Item No.");
                            ILE.SETFILTER(ILE."Serial No.", "Service Item Line"."Serial No.");
                            ILE.SETFILTER(ILE."Posting Date", '>%1', "Service Header"."Order Date");
                            IF ILE.FINDFIRST THEN BEGIN
                                DV.RESET;
                                DV.SETFILTER(DV."Dimension Code", 'LOCATIONS');
                                DV.SETFILTER(DV.Code, ILE."Global Dimension 2 Code");
                                IF DV.FINDFIRST THEN
                                    Entercell(Row, 10, FORMAT(DV.Name), FALSE);
                                Entercell(Row, 11, FORMAT(ILE."Posting Date"), FALSE);
                            END;
                        END;
                    END;
                    /*IF EXCEL AND (Choice=Choice::Ts) THEN
                    BEGIN
                      Row+=1;
                      k:=1;
                      Entercell(Row,1,FORMAT("Service Header"."Order Date"),FALSE);
                      Entercell(Row,2,"Service Header"."No.",FALSE);
                      Entercell(Row,3,"Service Header".Description,FALSE);
                    END;
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                Location := "Service Header".Description;
            end;

            trigger OnPreDataItem()
            begin
                IF EXCEL AND (Choice <> Choice::Ts) THEN BEGIN
                    Row += 1;
                    EnterHeadings(Row, 1, 'PCB Received Date', TRUE);
                    EnterHeadings(Row, 2, 'Location', TRUE);
                    EnterHeadings(Row, 3, 'Service Order No', TRUE);
                    EnterHeadings(Row, 4, 'Item No', TRUE);
                    EnterHeadings(Row, 5, 'Description', TRUE);
                    EnterHeadings(Row, 6, 'Serial Number', TRUE);
                    EnterHeadings(Row, 7, 'Manfacturing Date', TRUE);
                    EnterHeadings(Row, 8, 'Status', TRUE);
                    EnterHeadings(Row, 9, 'Completion Date', TRUE);
                    IF Choice = Choice::In_out THEN BEGIN
                        EnterHeadings(Row, 10, 'Sent place', TRUE);
                        EnterHeadings(Row, 11, 'Sent Date', TRUE);
                    END;
                END;
                IF EXCEL AND (Choice = Choice::Ts) THEN BEGIN
                    Row := 1;
                    EnterHeadings(Row, 1, 'PCB Received Date', TRUE);
                    EnterHeadings(Row, 2, 'Service Order No', TRUE);
                    EnterHeadings(Row, 3, 'Location', TRUE);
                    EnterHeadings(Row, 4, 'Product-Module', TRUE);
                    EnterHeadings(Row, 5, 'Sub Module', TRUE);
                    EnterHeadings(Row, 6, 'Pcb Description', TRUE);
                    EnterHeadings(Row, 7, 'Quantity', TRUE);
                    EnterHeadings(Row, 8, 'Serial No.', TRUE);
                    EnterHeadings(Row, 9, 'Manfacturing Date', TRUE);
                    EnterHeadings(Row, 10, 'Problem description', TRUE);
                    EnterHeadings(Row, 11, 'Circuit wise', TRUE);
                    EnterHeadings(Row, 12, 'Observations', TRUE);
                    EnterHeadings(Row, 13, 'Action Taken', TRUE);
                    EnterHeadings(Row, 14, 'Components Replaced', TRUE);
                    EnterHeadings(Row, 15, 'QTY', TRUE);
                    EnterHeadings(Row, 16, 'Component Legending', TRUE);
                    EnterHeadings(Row, 17, 'Batch No', TRUE);
                    EnterHeadings(Row, 18, 'Person', TRUE);
                    EnterHeadings(Row, 19, 'Spent time(In HR)', TRUE);
                    EnterHeadings(Row, 20, 'Completion Date', TRUE);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF EXCEL THEN BEGIN
            Tempexcelbuffer.CreateBook('', '');//B2B //EFFUPG
            /*
            IF Choice=Choice::Ts THEN
              Tempexcelbuffer.CreateSheet('Trouble Shooting Data','',COMPANYNAME,'')
            ELSE IF Choice=Choice::In_out THEN
              Tempexcelbuffer.CreateSheet('In & Out Service Cards','',COMPANYNAME,'')
            ELSE
              Tempexcelbuffer.CreateSheet('Servicing Data','',COMPANYNAME,'');
            *///B2B
            //Tempexcelbuffer.GiveUserControl;
        END;

    end;

    trigger OnPreReport()
    begin
        IF EXCEL THEN BEGIN
            CLEAR(Tempexcelbuffer);
            Tempexcelbuffer.DELETEALL;
        END;
    end;

    var
        Choice: Option Inward,In_out,Ts;
        Location: Text[50];
        ILE: Record "Item Ledger Entry";
        "Manf.Date": Date;
        Item: Record Item;
        Status: Text[100];
        Tempexcelbuffer: Record "Excel Buffer";
        EXCEL: Boolean;
        Row: Integer;
        "sent Date": Date;
        DV: Record "Dimension Value";
        ServiceLine: Record "Service Line";
        PMIH: Record "Posted Material Issues Header";
        I: Integer;
        J: Integer;
        oldvalue: Integer;
        newvalue: Integer;
        k: Integer;
        test: Integer;
        Received_DateCaptionLbl: Label 'Received Date';
        LocationCaptionLbl: Label 'Location';
        Manfacturing_DateCaptionLbl: Label 'Manfacturing Date';
        StatusCaptionLbl: Label 'Status';


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean)
    begin

        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := CellValue;
        Tempexcelbuffer.Bold := bold;

        Tempexcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean)
    begin
        Tempexcelbuffer.INIT;
        Tempexcelbuffer.VALIDATE("Row No.", RowNo);
        Tempexcelbuffer.VALIDATE("Column No.", ColumnNo);
        Tempexcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        Tempexcelbuffer.Bold := Bold;

        Tempexcelbuffer.Formula := '';
        Tempexcelbuffer.INSERT;
    end;
}

