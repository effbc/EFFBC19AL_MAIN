report 50039 "QC Inwards"
{
    //                 flag:=false;
    DefaultLayout = RDLC;
    RDLCLayout = './QCInwards.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("Inspection Datasheet Header"; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("Created Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"), "Partial Inspection" = FILTER(false));
            RequestFilterFields = "Created Date";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(FORMAT_filter_; FORMAT(filter))
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Item_Description_; "Inspection Datasheet Header"."Item Description")
            {
            }
            column(pen; pen)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Vendor_Name_; "Inspection Datasheet Header"."Vendor Name")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header__Quantity; "Inspection Datasheet Header".Quantity)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Unit_Of_Measure_Code_; "Inspection Datasheet Header"."Unit Of Measure Code")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Created_Date_; "Inspection Datasheet Header"."Created Date")
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header__Location; "Inspection Datasheet Header".Location)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Datasheet_Header___Reason_for_Pending_; "Inspection Datasheet Header"."Reason for Pending")
            {
            }
            column(pendays; pendays)
            {
            }
            column(QC_InwardsCaption; QC_InwardsCaptionLbl)
            {
            }
            column(Pending_ItemsCaption; Pending_ItemsCaptionLbl)
            {
            }
            column(SNO_Caption; SNO_CaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Inward_DateCaption; Inward_DateCaptionLbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(Reason_for_PendingCaption; Reason_for_PendingCaptionLbl)
            {
            }
            column(Pending_DaysCaption; Pending_DaysCaptionLbl)
            {
            }
            column(Inspection_Datasheet_Header_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                pen += 1;
                pendays := TODAY - "Inspection Datasheet Header"."Created Date";

                //Rev01

                //Inspection Datasheet Header, Header (2) - OnPreSection()
                flag := TRUE;
                //Inspection Datasheet Header, Header (2) - OnPreSection()
            end;

            trigger OnPreDataItem()
            begin
                IF "Inspection Datasheet Header".GETFILTER("Inspection Datasheet Header"."Created Date") <> '' THEN BEGIN
                    Max := "Inspection Datasheet Header".GETRANGEMAX("Inspection Datasheet Header"."Created Date");
                    min := "Inspection Datasheet Header".GETRANGEMIN("Inspection Datasheet Header"."Created Date");
                END ELSE BEGIN
                    Max := TODAY - 1;
                    min := DMY2Date(04, 01, 08);
                END;
                "Inspection Datasheet Header".SETRANGE("Inspection Datasheet Header"."Created Date", min, Max);
                // "Inspection Datasheet Header".SETRANGE("Inspection Datasheet Header"."Partial Inspection",FALSE);
                pending += "Inspection Datasheet Header".COUNT;
            end;
        }
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("IDS creation Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
            column(IRH_Flag; Flag)
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___Item_Description_; "Inspection Receipt Header"."Item Description")
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header__Quantity; "Inspection Receipt Header".Quantity)
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___Vendor_Name_; "Inspection Receipt Header"."Vendor Name")
            {
            }
            column(pen_Control1102154032; pen)
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___Unit_Of_Measure_Code_; "Inspection Receipt Header"."Unit Of Measure Code")
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___IDS_creation_Date_; "Inspection Receipt Header"."IDS creation Date")
            {
            }
            column(Inspection_Receipt_Header__Inspection_Receipt_Header___Location_Code_; "Inspection Receipt Header"."Location Code")
            {
            }
            column(pendays_Control1102154065; pendays)
            {
            }
            column(Pending_ItemsCaption_Control1102154040; Pending_ItemsCaption_Control1102154040Lbl)
            {
            }
            column(SNO_Caption_Control1102154041; SNO_Caption_Control1102154041Lbl)
            {
            }
            column(Vendor_NameCaption_Control1102154042; Vendor_NameCaption_Control1102154042Lbl)
            {
            }
            column(Item_NameCaption_Control1102154043; Item_NameCaption_Control1102154043Lbl)
            {
            }
            column(QuantityCaption_Control1102154044; QuantityCaption_Control1102154044Lbl)
            {
            }
            column(UOMCaption_Control1102154051; UOMCaption_Control1102154051Lbl)
            {
            }
            column(Inward_DateCaption_Control1102154052; Inward_DateCaption_Control1102154052Lbl)
            {
            }
            column(Location_codeCaption_Control1102154011; Location_codeCaption_Control1102154011Lbl)
            {
            }
            column(Pending_DaysCaption_Control1102154064; Pending_DaysCaption_Control1102154064Lbl)
            {
            }
            column(Inspection_Receipt_Header_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                pen += 1;
                IF ("Inspection Receipt Header"."IDS creation Date" <> 0D) THEN
                    pendays := TODAY - "Inspection Receipt Header"."IDS creation Date";

                //Rev01

                //Inspection Receipt Header, Header (1) - OnPreSection()
                // IF Flag = TRUE THEN
                //     CurrReport.SHOWOUTPUT := FALSE
                // ELSE
                //     CurrReport.SHOWOUTPUT := TRUE;
                //Inspection Receipt Header, Header (1) - OnPreSection()
            end;

            trigger OnPreDataItem()
            begin
                "Inspection Receipt Header".SETRANGE("Inspection Receipt Header"."IDS creation Date", min, Max);
                "Inspection Receipt Header".SETRANGE("Inspection Receipt Header".Status, FALSE);
                pending += "Inspection Receipt Header".COUNT;
            end;
        }
        dataitem("<Inspection Receipt Header1>"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("IDS creation Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
            column(IRH1_WithRej; withrej)
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Nature_Of_Rejection_; "<Inspection Receipt Header1>"."Nature Of Rejection")
            {
            }
            column(rej; rej)
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Vendor_Name_; "<Inspection Receipt Header1>"."Vendor Name")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Item_Description_; "<Inspection Receipt Header1>"."Item Description")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Qty__Rejected_; "<Inspection Receipt Header1>"."Qty. Rejected")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1____Unit_Of_Measure_Code_; "<Inspection Receipt Header1>"."Unit Of Measure Code")
            {
            }
            column(Inspection_Receipt_Header1____Inspection_Receipt_Header1___Quantity; "<Inspection Receipt Header1>".Quantity)
            {
            }
            column(SNO_Caption_Control1102154023; SNO_Caption_Control1102154023Lbl)
            {
            }
            column(Vendor_NameCaption_Control1102154024; Vendor_NameCaption_Control1102154024Lbl)
            {
            }
            column(Item_NameCaption_Control1102154025; Item_NameCaption_Control1102154025Lbl)
            {
            }
            column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
            {
            }
            column(Nature_of_RejectionCaption; Nature_of_RejectionCaptionLbl)
            {
            }
            column(Rejection_ItemsCaption; Rejection_ItemsCaptionLbl)
            {
            }
            column(UOMCaption_Control1102154053; UOMCaption_Control1102154053Lbl)
            {
            }
            column(Total_QuantityCaption; Total_QuantityCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header1__No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                rej += 1;

                //Rev01

                //<Inspection Receipt Header1>, Header (1) - OnPreSection()
                // IF withrej = TRUE THEN
                //     CurrReport.SHOWOUTPUT := TRUE
                // ELSE
                //     CurrReport.SHOWOUTPUT := FALSE;

                //<Inspection Receipt Header1>, Header (1) - OnPreSection()
                /*
                //<Inspection Receipt Header1>, Body (2) - OnPreSection()
                IF withrej=TRUE THEN
                 CurrReport.SHOWOUTPUT:=TRUE
                ELSE
                 CurrReport.SHOWOUTPUT:=FALSE;
                //<Inspection Receipt Header1>, Body (2) - OnPreSection()
                */

            end;

            trigger OnPreDataItem()
            begin
                /* "Inspection Receipt Header".SETRANGE("Inspection Receipt Header"."Document Date",min,Max);
                  "Inspection Receipt Header".SETRANGE("Inspection Receipt Header".Status,FALSE);
                   pending+="Inspection Receipt Header".COUNT;
                  "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>"."Document Date",min,Max);
                  "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>".Status,FALSE);
                    pending:="<Inspection Receipt Header1>".COUNT;

                  "Inspection Receipt Header".SETRANGE("Inspection Receipt Header"."Document Date",min,Max);
                  "Inspection Receipt Header".SETRANGE("Inspection Receipt Header".Status,TRUE);
                   completed:="Inspection Receipt Header".COUNT;
                   "Inspection Receipt Header".SETFILTER("Inspection Receipt Header"."Qty. Rejected",'>%1',0);*/

                "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>"."IDS creation Date", min, Max);
                "<Inspection Receipt Header1>".SETRANGE("<Inspection Receipt Header1>".Status, TRUE);
                completed := "<Inspection Receipt Header1>".COUNT;
                "<Inspection Receipt Header1>".SETFILTER("<Inspection Receipt Header1>"."Qty. Rejected", '>%1', 0);

            end;
        }
        dataitem("<Inspection Receipt Header2>"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("IDS creation Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
            column(IRH2_Accepted; Accepted)
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2____Item_Description_; "<Inspection Receipt Header2>"."Item Description")
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2____Vendor_Name_; "<Inspection Receipt Header2>"."Vendor Name")
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2____Qty__Accepted_; "<Inspection Receipt Header2>"."Qty. Accepted")
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2____Unit_Of_Measure_Code_; "<Inspection Receipt Header2>"."Unit Of Measure Code")
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2___Quantity; "<Inspection Receipt Header2>".Quantity)
            {
            }
            column(SNO; SNO)
            {
            }
            column(Inspection_Receipt_Header2____Inspection_Receipt_Header2____Lot_No__; "<Inspection Receipt Header2>"."Lot No.")
            {
            }
            column(UOMCaption_Control1102154082; UOMCaption_Control1102154082Lbl)
            {
            }
            column(SNO_Caption_Control1102154083; SNO_Caption_Control1102154083Lbl)
            {
            }
            column(Vendor_NameCaption_Control1102154084; Vendor_NameCaption_Control1102154084Lbl)
            {
            }
            column(Item_NameCaption_Control1102154085; Item_NameCaption_Control1102154085Lbl)
            {
            }
            column(Qty_AcceptedCaption; Qty_AcceptedCaptionLbl)
            {
            }
            column(Accepeted_ItemsCaption; Accepeted_ItemsCaptionLbl)
            {
            }
            column(Total_QuantityCaption_Control1102154090; Total_QuantityCaption_Control1102154090Lbl)
            {
            }
            column(Batch_No_Caption; Batch_No_CaptionLbl)
            {
            }
            column(Inspection_Receipt_Header2__No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SNO += 1;

                //Rev01

                //<Inspection Receipt Header2>, Header (1) - OnPreSection()
                // IF Accepted = TRUE THEN
                //     CurrReport.SHOWOUTPUT := TRUE
                // ELSE
                //     CurrReport.SHOWOUTPUT := FALSE;

                IF Excel = TRUE THEN BEGIN
                    row += 1;
                    EnterHeadings(row, 1, 'SNO.', TRUE);
                    EnterHeadings(row, 2, 'VENDOR NAME', TRUE);
                    EnterHeadings(row, 3, 'ITEM NAME', TRUE);
                    EnterHeadings(row, 4, 'UOM', TRUE);
                    EnterHeadings(row, 5, ' TOTAL QUANTITY', TRUE);
                    EnterHeadings(row, 6, 'ACCEPTED QUANTITY', TRUE);
                    EnterHeadings(row, 7, 'BATCH NO.', TRUE);
                END;

                //<Inspection Receipt Header2>, Header (1) - OnPreSection()

                //<Inspection Receipt Header2>, Body (2) - OnPreSection()
                /*
                IF Accepted=TRUE THEN
                 CurrReport.SHOWOUTPUT:=TRUE
                ELSE
                 CurrReport.SHOWOUTPUT:=FALSE;
                */

                IF Excel = TRUE THEN BEGIN
                    row := row + 1;
                    EnterCell(row, 1, FORMAT(SNO), FALSE);
                    EnterCell(row, 2, "<Inspection Receipt Header2>"."Vendor Name", FALSE);
                    EnterCell(row, 3, "<Inspection Receipt Header2>"."Item Description", FALSE);
                    EnterCell(row, 4, "<Inspection Receipt Header2>"."Unit Of Measure Code", FALSE);
                    EnterCell(row, 5, FORMAT("<Inspection Receipt Header2>".Quantity), FALSE);
                    EnterCell(row, 6, FORMAT("<Inspection Receipt Header2>"."Qty. Accepted"), FALSE);
                    EnterCell(row, 7, "<Inspection Receipt Header2>"."Lot No.", FALSE);
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF Excel = TRUE THEN BEGIN
                    TempExcelBuffer.DELETEALL;
                    CLEAR(TempExcelBuffer);
                    row := 0;
                END;
                "<Inspection Receipt Header2>".SETRANGE("<Inspection Receipt Header2>"."IDS creation Date", min, Max);
                "<Inspection Receipt Header2>".SETRANGE("<Inspection Receipt Header2>".Status, TRUE);
                "<Inspection Receipt Header2>".SETFILTER("<Inspection Receipt Header2>"."Qty. Accepted", '>%1', 0);
            end;
        }
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending);
            column(Int_Choice; choice)
            {
            }
            column(pending; pending)
            {
            }
            column(completed; completed)
            {
            }
            column(rej_Control1102154073; rej)
            {
            }
            column(CNT; CNT)
            {
            }
            column(RejectionsCaption; RejectionsCaptionLbl)
            {
            }
            column(Completed_Inc_Rej_Caption; Completed_Inc_Rej_CaptionLbl)
            {
            }
            column(PendingCaption; PendingCaptionLbl)
            {
            }
            column(Total_InwardsCaption; Total_InwardsCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF i = 2 THEN
                    CurrReport.BREAK
                ELSE
                    i += 1;

                //Rev01

                //Integer, Header (1) - OnPreSection()
                CNT := pending + completed;

                // IF choice = choice::Accepted THEN
                //     CurrReport.SHOWOUTPUT := FALSE
                // ELSE
                //     CurrReport.SHOWOUTPUT := TRUE;
                //Integer, Header (1) - OnPreSection()
            end;
        }
        dataitem(IDH; "Inspection Datasheet Header")
        {
            DataItemTableView = SORTING("Created Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));

            trigger OnAfterGetRecord()
            begin
                IF IDH.Location = 'STR' THEN
                    totm := totm + 1
                ELSE
                    IF IDH.Location = 'R&D STR' THEN
                        totr := totr + 1
                    ELSE
                        IF IDH.Location = 'CS STR' THEN
                            totc := totc + 1;
            end;

            trigger OnPreDataItem()
            begin
                totpen := IDH.COUNT;
            end;
        }
        dataitem(IR; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("IDS creation Date") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
            column(IR_Choice; choice)
            {
            }
            column(totpen1; totpen1)
            {
            }
            column(totr; totr)
            {
            }
            column(totc; totc)
            {
            }
            column(totm; totm)
            {
            }
            column(Total_Pendings_as_on_date_Caption; Total_Pendings_as_on_date_CaptionLbl)
            {
            }
            column(Main_STR_Caption; Main_STR_CaptionLbl)
            {
            }
            column(R_D_STR_Caption; R_D_STR_CaptionLbl)
            {
            }
            column(CS_STR_Caption; CS_STR_CaptionLbl)
            {
            }
            column(IR_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF IR."Location Code" = 'STR' THEN
                    totm := totm + 1
                ELSE
                    IF IR."Location Code" = 'R&D STR' THEN
                        totr := totr + 1
                    ELSE
                        IF IR."Location Code" = 'CS STR' THEN
                            totc := totc + 1;

                //Rev01

                //IR, Footer (2) - OnPreSection()
                totpen1 := totpen1 + totpen;

                // IF choice = choice::Accepted THEN
                //     CurrReport.SHOWOUTPUT := FALSE
                // ELSE
                //     CurrReport.SHOWOUTPUT := TRUE;
                //IR, Footer (2) - OnPreSection()
            end;

            trigger OnPreDataItem()
            begin
                IR.SETRANGE(IR.Status, FALSE);
                totpen1 := IR.COUNT;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Without Rejection"; withoutrej)
                    {
                        ApplicationArea = All;
                    }
                    field("With Rejection"; withrej)
                    {
                        ApplicationArea = All;
                    }
                    field("Only Accepted"; Accepted)
                    {
                        ApplicationArea = All;
                    }
                    field(Excel; Excel)
                    {
                        ApplicationArea = All;
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

    trigger OnPostReport()
    begin
        IF Excel THEN BEGIN
            /*
            TempExcelBuffer.CreateBook('test excel','');//B2B //EFFUPG
            //TempExcelBuffer.CreateSheet('test excel','',COMPANYNAME,'');//B2B
            TempExcelBuffer.WriteSheet('test excel',COMPANYNAME,USERID);
            TempExcelBuffer.OpenExcel;
            TempExcelBuffer.CloseBook;
            TempExcelBuffer.GiveUserControl;
            */
            TempExcelBuffer.CreateBookAndOpenExcel('', 'test excel', 'test excel', COMPANYNAME, USERID); //EFFUPG
        END;

    end;

    trigger OnPreReport()
    begin
        // filter:="Inspection Datasheet Header".GETFILTERS;
    end;

    var
        total: Decimal;
        pending: Decimal;
        completed: Decimal;
        SNO: Integer;
        CNT: Integer;
        pen: Integer;
        rej: Integer;
        text: Label 'Partially Rejected';
        "Max": Date;
        "min": Date;
        flag: Boolean;
        "filter": Text[150];
        i: Integer;
        totpen: Integer;
        totpen1: Integer;
        totr: Integer;
        totc: Integer;
        totm: Integer;
        choice: Option withoutrej,withrej,Accepted;
        pendays: Integer;
        sno1: Integer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        row: Integer;
        Excel: Boolean;
        withoutrej: Boolean;
        withrej: Boolean;
        Accepted: Boolean;
        posted: Boolean;
        QC_InwardsCaptionLbl: Label 'QC Inwards';
        Pending_ItemsCaptionLbl: Label 'Pending Items';
        SNO_CaptionLbl: Label 'SNO.';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Item_NameCaptionLbl: Label 'Item Name';
        QuantityCaptionLbl: Label 'Quantity';
        UOMCaptionLbl: Label 'UOM';
        Inward_DateCaptionLbl: Label 'Inward Date';
        Location_CodeCaptionLbl: Label 'Location Code';
        Reason_for_PendingCaptionLbl: Label 'Reason for Pending';
        Pending_DaysCaptionLbl: Label 'Pending Days';
        Pending_ItemsCaption_Control1102154040Lbl: Label 'Pending Items';
        SNO_Caption_Control1102154041Lbl: Label 'SNO.';
        Vendor_NameCaption_Control1102154042Lbl: Label 'Vendor Name';
        Item_NameCaption_Control1102154043Lbl: Label 'Item Name';
        QuantityCaption_Control1102154044Lbl: Label 'Quantity';
        UOMCaption_Control1102154051Lbl: Label 'UOM';
        Inward_DateCaption_Control1102154052Lbl: Label 'Inward Date';
        Location_codeCaption_Control1102154011Lbl: Label 'Location code';
        Pending_DaysCaption_Control1102154064Lbl: Label 'Pending Days';
        SNO_Caption_Control1102154023Lbl: Label 'SNO.';
        Vendor_NameCaption_Control1102154024Lbl: Label 'Vendor Name';
        Item_NameCaption_Control1102154025Lbl: Label 'Item Name';
        Qty_RejectedCaptionLbl: Label 'Qty Rejected';
        Nature_of_RejectionCaptionLbl: Label 'Nature of Rejection';
        Rejection_ItemsCaptionLbl: Label 'Rejection Items';
        UOMCaption_Control1102154053Lbl: Label 'UOM';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
        UOMCaption_Control1102154082Lbl: Label 'UOM';
        SNO_Caption_Control1102154083Lbl: Label 'SNO.';
        Vendor_NameCaption_Control1102154084Lbl: Label 'Vendor Name';
        Item_NameCaption_Control1102154085Lbl: Label 'Item Name';
        Qty_AcceptedCaptionLbl: Label 'Qty Accepted';
        Accepeted_ItemsCaptionLbl: Label 'Accepeted Items';
        Total_QuantityCaption_Control1102154090Lbl: Label 'Total Quantity';
        Batch_No_CaptionLbl: Label 'Batch No.';
        RejectionsCaptionLbl: Label 'Rejections';
        Completed_Inc_Rej_CaptionLbl: Label 'Completed(Inc Rej)';
        PendingCaptionLbl: Label 'Pending';
        Total_InwardsCaptionLbl: Label 'Total Inwards';
        Total_Pendings_as_on_date_CaptionLbl: Label 'Total Pendings as on date:';
        Main_STR_CaptionLbl: Label 'Main STR:';
        R_D_STR_CaptionLbl: Label 'R&D STR:';
        CS_STR_CaptionLbl: Label 'CS STR:';


    procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.INSERT;
    end;
}

