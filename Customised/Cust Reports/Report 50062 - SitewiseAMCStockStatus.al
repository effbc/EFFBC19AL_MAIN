report 50062 "Site wise AMC Stock Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './SitewiseAMCStockStatus.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Item Wise Min. Req. Qty at Loc"; "Item Wise Min. Req. Qty at Loc")
        {
            CalcFields = "Actual Qty";
            DataItemTableView = SORTING(Location, Item) ORDER(Ascending) WHERE(Location = FILTER(<> ''), Item = FILTER(<> ''));
            column(LOC_TEMP; LOC_TEMP)
            {
            }
            column(HEAD_TEMP; HEAD_TEMP)
            {
            }
            column(Actual_Qty__PLANNED_QTY; "Actual Qty" - PLANNED_QTY)
            {
            }
            column(PLANNED_QTY; PLANNED_QTY)
            {
            }
            column(Item_Wise_Min__Req__Qty_at_Loc_Item; Item)
            {
            }
            column(Item_Wise_Min__Req__Qty_at_Loc_Descirption; Descirption)
            {
            }
            column(ITEM_COST; ITEM_COST)
            {
            }
            column(ITEM_COST___Actual_Qty__PLANNED_QTY_; ITEM_COST * ("Actual Qty" - PLANNED_QTY))
            {
            }
            column(Item_Wise_Min__Req__Qty_at_Loc__Actual_Qty_; "Actual Qty")
            {
            }
            column(Working_Cards; Working_Cards)
            {
            }
            column(Non_Working_Card_; "Non-Working_Card")
            {
            }
            column(ROUND_LOC_NET_VALUE_1_; ROUND(LOC_NET_VALUE, 1))
            {
            }
            column(LOC_SURPLUS_VALUE; LOC_SURPLUS_VALUE)
            {
            }
            column(LOC_DEFICIET_VALUE; LOC_DEFICIET_VALUE)
            {
            }
            column(SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaption; SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaptionLbl)
            {
            }
            column(ITEM_CODECaption; ITEM_CODECaptionLbl)
            {
            }
            column(ITEMCaption; ITEMCaptionLbl)
            {
            }
            column(ACTUAL_QUANTITY_Caption; ACTUAL_QUANTITY_CaptionLbl)
            {
            }
            column(ITEM_COSTCaption; ITEM_COSTCaptionLbl)
            {
            }
            column(SURPLUS___DEFICIET_VALUECaption; SURPLUS___DEFICIET_VALUECaptionLbl)
            {
            }
            column(SURPLUS___DEFICIET_QUANTITYCaption; SURPLUS___DEFICIET_QUANTITYCaptionLbl)
            {
            }
            column(WORKING_QUANTITYCaption; WORKING_QUANTITYCaptionLbl)
            {
            }
            column(NON_WORKING_QUANTITYCaption; NON_WORKING_QUANTITYCaptionLbl)
            {
            }
            column(NET_VALUE__Caption; NET_VALUE__CaptionLbl)
            {
            }
            column(TOTAL_SURPLUS_VALUE__Caption; TOTAL_SURPLUS_VALUE__CaptionLbl)
            {
            }
            column(TOTAL_DEFICIET_VALUE__Caption; TOTAL_DEFICIET_VALUE__CaptionLbl)
            {
            }
            column(Item_Wise_Min__Req__Qty_at_Loc_Location; Location)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PLANNED_QTY := 0;
                IF AMC THEN
                    PLANNED_QTY += "Item Wise Min. Req. Qty at Loc"."AMC Qty";
                IF WARRANTY THEN
                    PLANNED_QTY += "Item Wise Min. Req. Qty at Loc"."Warranty Qty";
                //IF NONE THEN

                IF ("INFORMATION_I/P" = "INFORMATION_I/P"::DEFICIET) THEN BEGIN
                    IF PLANNED_QTY <= "Item Wise Min. Req. Qty at Loc"."Actual Qty" THEN
                        CurrReport.SKIP;
                END ELSE
                    IF ("INFORMATION_I/P" = "INFORMATION_I/P"::SURPLUS) THEN BEGIN
                        IF PLANNED_QTY >= "Item Wise Min. Req. Qty at Loc"."Actual Qty" THEN
                            CurrReport.SKIP;
                    END;
                ITEM_COST := 0;
                /*
                IF ITEM_REC.GET("Item Wise Min. Req. Qty at Loc".Item) THEN BEGIN
                    IF (ITEM_REC."Item Category Code" = 'CPCB') OR (ITEM_REC."Item Category Code" = 'FPRODUCT') THEN
                        ITEM_COST := PRICE_LIST."Calculate Bom Value"("Item Wise Min. Req. Qty at Loc".Item)
                    ELSE
                        IF (ITEM_REC."Item Category Code" = 'B OUT') THEN
                            ITEM_COST := ITEM_REC."Item Final Cost"
                        ELSE
                            CurrReport.SKIP;
                END;*///B2BUpg
            end;

            trigger OnPreDataItem()
            begin
                IF (SORT_VIEW = SORT_VIEW::"ITEM WISE") THEN
                    CurrReport.BREAK;
                IF "SITE_I/P" = "SITE_I/P"::SPECIFIC THEN
                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location, LOCATION_IP);
                IF "ITEM_I/P" = "ITEM_I/P"::SPECIFIC THEN
                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, ITEM_IP);
            end;
        }
        dataitem(s1; "Item Wise Min. Req. Qty at Loc")
        {
            CalcFields = "Actual Qty";
            DataItemTableView = SORTING(Item, Location) ORDER(Ascending) WHERE(Location = FILTER(<> ''), Item = FILTER(<> ''));
            column(LOC_TEMP_Control1102154061; LOC_TEMP)
            {
            }
            column(HEAD_TEMP_Control1102154001; HEAD_TEMP)
            {
            }
            column(PLANNED_QTY_Control1102154054; PLANNED_QTY)
            {
            }
            column(s1_s1_Location; s1.Location)
            {
            }
            column(s1_s1__Location_Name_; s1."Location Name")
            {
            }
            column(s1__Actual_Qty_; "Actual Qty")
            {
            }
            column(Working_Cards_Control1102154040; Working_Cards)
            {
            }
            column(Non_Working_Card__Control1102154041; "Non-Working_Card")
            {
            }
            column(Actual_Qty__PLANNED_QTY_Control1102154042; "Actual Qty" - PLANNED_QTY)
            {
            }
            column(ITEM_COST_Control1102154043; ITEM_COST)
            {
            }
            column(ITEM_COST___Actual_Qty__PLANNED_QTY__Control1102154044; ITEM_COST * ("Actual Qty" - PLANNED_QTY))
            {
            }
            column(LOC_SURPLUS_VALUE_Control1102154002; LOC_SURPLUS_VALUE)
            {
            }
            column(LOC_DEFICIET_VALUE_Control1102154018; LOC_DEFICIET_VALUE)
            {
            }
            column(ROUND_LOC_NET_VALUE_1__Control1102154028; ROUND(LOC_NET_VALUE, 1))
            {
            }
            column(SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaption_Control1102154030; SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaption_Control1102154030Lbl)
            {
            }
            column(LOCATION_NAMECaption; LOCATION_NAMECaptionLbl)
            {
            }
            column(LOCATIONCaption; LOCATIONCaptionLbl)
            {
            }
            column(ACTUAL_QUANTITY_Caption_Control1102154005; ACTUAL_QUANTITY_Caption_Control1102154005Lbl)
            {
            }
            column(WORKING_QUANTITYCaption_Control1102154014; WORKING_QUANTITYCaption_Control1102154014Lbl)
            {
            }
            column(NON_WORKING_QUANTITYCaption_Control1102154031; NON_WORKING_QUANTITYCaption_Control1102154031Lbl)
            {
            }
            column(SURPLUS___DEFICIET_QUANTITYCaption_Control1102154032; SURPLUS___DEFICIET_QUANTITYCaption_Control1102154032Lbl)
            {
            }
            column(ITEM_COSTCaption_Control1102154034; ITEM_COSTCaption_Control1102154034Lbl)
            {
            }
            column(SURPLUS___DEFICIET_VALUECaption_Control1102154036; SURPLUS___DEFICIET_VALUECaption_Control1102154036Lbl)
            {
            }
            column(TOTAL_SURPLUS_VALUE__Caption_Control1102154003; TOTAL_SURPLUS_VALUE__Caption_Control1102154003Lbl)
            {
            }
            column(TOTAL_DEFICIET_VALUE__Caption_Control1102154026; TOTAL_DEFICIET_VALUE__Caption_Control1102154026Lbl)
            {
            }
            column(NET_VALUE__Caption_Control1102154027; NET_VALUE__Caption_Control1102154027Lbl)
            {
            }
            column(s1_Item; Item)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PLANNED_QTY := 0;
                IF AMC THEN
                    PLANNED_QTY += s1."AMC Qty";
                IF WARRANTY THEN
                    PLANNED_QTY += s1."Warranty Qty";


                IF ("INFORMATION_I/P" = "INFORMATION_I/P"::DEFICIET) THEN BEGIN
                    IF PLANNED_QTY <= "Item Wise Min. Req. Qty at Loc"."Actual Qty" THEN
                        CurrReport.SKIP;
                END ELSE
                    IF ("INFORMATION_I/P" = "INFORMATION_I/P"::SURPLUS) THEN BEGIN
                        IF PLANNED_QTY >= "Item Wise Min. Req. Qty at Loc"."Actual Qty" THEN
                            CurrReport.SKIP;
                    END;
                ITEM_COST := 0;
                /*
                IF ITEM_REC.GET(s1.Item) THEN BEGIN
                    IF (ITEM_REC."Item Category Code" = 'CPCB') OR (ITEM_REC."Item Category Code" = 'FPRODUCT') THEN
                        ITEM_COST := PRICE_LIST."Calculate Bom Value"(s1.Item)
                    ELSE
                        IF (ITEM_REC."Item Category Code" = 'B OUT') THEN
                            ITEM_COST := ITEM_REC."Item Final Cost"
                        ELSE
                            CurrReport.SKIP;
                END;*///B2BUpg
            end;

            trigger OnPreDataItem()
            begin
                IF (SORT_VIEW = SORT_VIEW::"LOCATION WISE ") THEN
                    CurrReport.BREAK;

                IF "ITEM_I/P" = "ITEM_I/P"::SPECIFIC THEN
                    s1.SETRANGE(s1.Item, ITEM_IP);

                IF "SITE_I/P" = "SITE_I/P"::SPECIFIC THEN
                    s1.SETRANGE(s1.Location, LOCATION_IP);
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

    trigger OnInitReport()
    begin
        AMC := TRUE;
        WARRANTY := TRUE;
        NONE := TRUE;
    end;

    trigger OnPostReport()
    begin
        IF EXCEL THEN BEGIN
            TempExcelbuffer.CreateBook('', '');//B2B //EFFUPG
                                               // TempExcelbuffer.CreateSheet('SITE WISE AMC CARDS STATUS','',COMPANYNAME,'');//B2b
                                               //TempExcelbuffer.GiveUserControl;
        END;
    end;

    trigger OnPreReport()
    begin
        IF EXCEL THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    var
        LOCATION_IP: Code[30];
        ITEM_IP: Code[30];
        "SITE_I/P": Option ALL,SPECIFIC;
        "ITEM_I/P": Option ALL,SPECIFIC;
        "INFORMATION_I/P": Option BOTH,SURPLUS,DEFICIET;
        AMC: Boolean;
        WARRANTY: Boolean;
        "NONE": Boolean;
        ITEM_LEDGER_ENTRY: Record "Item Ledger Entry";
        ITEM_WISE_MIN_REQ: Record "Item Wise Min. Req. Qty at Loc";
        PLANNED_QTY: Integer;
        SORT_VIEW: Option "LOCATION WISE ","ITEM WISE";
        LOC_TEMP: Text[100];
        HEAD_TEMP: Text[100];
        ITEM_COST: Decimal;
        ITEM_REC: Record Item;
        //PRICE_LIST: Report "Products Price List";//This Report Require in Future then it uncomment
        TOT_SURPLUS_VALUE: Decimal;
        LOC_SURPLUS_VALUE: Decimal;
        LOC_DEFICIET_VALUE: Decimal;
        ITEM_SURPLUS_VALUE: Decimal;
        ITEM_DEFICIET_VALUE: Decimal;
        TOT_DEFICIET_VALUE: Decimal;
        LOC_NET_VALUE: Decimal;
        EXCEL: Boolean;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        Actual_Qty_txt: Text[30];
        Working_Cards: Integer;
        "Non-Working_Card": Integer;
        Service_Item_working: Record "Service Item";
        Service_Item_non_working: Record "Service Item";
        PMH: Record "Posted Material Issues Header";
        SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaptionLbl: Label 'SITE WISE AMC & WARRANTY CARDS STATUS';
        ITEM_CODECaptionLbl: Label 'ITEM CODE';
        ITEMCaptionLbl: Label 'ITEM';
        ACTUAL_QUANTITY_CaptionLbl: Label 'ACTUAL QUANTITY ';
        ITEM_COSTCaptionLbl: Label 'ITEM COST';
        SURPLUS___DEFICIET_VALUECaptionLbl: Label 'SURPLUS / DEFICIET VALUE';
        SURPLUS___DEFICIET_QUANTITYCaptionLbl: Label 'SURPLUS / DEFICIET QUANTITY';
        WORKING_QUANTITYCaptionLbl: Label 'WORKING QUANTITY';
        NON_WORKING_QUANTITYCaptionLbl: Label 'NON-WORKING QUANTITY';
        NET_VALUE__CaptionLbl: Label 'NET VALUE :';
        TOTAL_SURPLUS_VALUE__CaptionLbl: Label 'TOTAL SURPLUS VALUE :';
        TOTAL_DEFICIET_VALUE__CaptionLbl: Label 'TOTAL DEFICIET VALUE :';
        SITE_WISE_AMC___WARRANTY_CARDS_STATUSCaption_Control1102154030Lbl: Label 'SITE WISE AMC & WARRANTY CARDS STATUS';
        LOCATION_NAMECaptionLbl: Label 'LOCATION NAME';
        LOCATIONCaptionLbl: Label 'LOCATION';
        ACTUAL_QUANTITY_Caption_Control1102154005Lbl: Label 'ACTUAL QUANTITY ';
        WORKING_QUANTITYCaption_Control1102154014Lbl: Label 'WORKING QUANTITY';
        NON_WORKING_QUANTITYCaption_Control1102154031Lbl: Label 'NON-WORKING QUANTITY';
        SURPLUS___DEFICIET_QUANTITYCaption_Control1102154032Lbl: Label 'SURPLUS / DEFICIET QUANTITY';
        ITEM_COSTCaption_Control1102154034Lbl: Label 'ITEM COST';
        SURPLUS___DEFICIET_VALUECaption_Control1102154036Lbl: Label 'SURPLUS / DEFICIET VALUE';
        TOTAL_SURPLUS_VALUE__Caption_Control1102154003Lbl: Label 'TOTAL SURPLUS VALUE :';
        TOTAL_DEFICIET_VALUE__Caption_Control1102154026Lbl: Label 'TOTAL DEFICIET VALUE :';
        NET_VALUE__Caption_Control1102154027Lbl: Label 'NET VALUE :';


    procedure UPDATE_ITEM_WISE_REQUIREMENT()
    begin
        ITEM_LEDGER_ENTRY.SETCURRENTKEY(ITEM_LEDGER_ENTRY."Location Code",
                                        ITEM_LEDGER_ENTRY."Global Dimension 2 Code",
                                        ITEM_LEDGER_ENTRY."Item No.");
        ITEM_LEDGER_ENTRY.SETFILTER(ITEM_LEDGER_ENTRY."Location Code", '%1|%2', 'CS', 'SITE');
        ITEM_LEDGER_ENTRY.SETFILTER(ITEM_LEDGER_ENTRY."Remaining Quantity", '>%1', 0);
        IF "SITE_I/P" = "SITE_I/P"::SPECIFIC THEN
            ITEM_LEDGER_ENTRY.SETRANGE(ITEM_LEDGER_ENTRY."Global Dimension 2 Code", LOCATION_IP);
        IF "ITEM_I/P" = "ITEM_I/P"::SPECIFIC THEN
            ITEM_LEDGER_ENTRY.SETRANGE(ITEM_LEDGER_ENTRY."Item No.", ITEM_IP);
        IF ITEM_LEDGER_ENTRY.FIND('-') THEN
            REPEAT
                ITEM_WISE_MIN_REQ.RESET;
                ITEM_WISE_MIN_REQ.SETRANGE(ITEM_WISE_MIN_REQ.Location, ITEM_LEDGER_ENTRY."Global Dimension 2 Code");
                ITEM_WISE_MIN_REQ.SETRANGE(ITEM_WISE_MIN_REQ.Item, ITEM_LEDGER_ENTRY."Item No.");
                IF NOT (ITEM_WISE_MIN_REQ.FIND('-')) THEN BEGIN
                    ITEM_WISE_MIN_REQ.INIT;
                    ITEM_WISE_MIN_REQ.Location := ITEM_LEDGER_ENTRY."Global Dimension 2 Code";
                    ITEM_WISE_MIN_REQ.VALIDATE(ITEM_WISE_MIN_REQ.Location, ITEM_LEDGER_ENTRY."Global Dimension 2 Code");
                    ITEM_WISE_MIN_REQ.Item := ITEM_LEDGER_ENTRY."Item No.";
                    ITEM_WISE_MIN_REQ.VALIDATE(ITEM_WISE_MIN_REQ.Item, ITEM_LEDGER_ENTRY."Item No.");
                    ITEM_WISE_MIN_REQ."Base Location" := ITEM_LEDGER_ENTRY."Location Code";
                    ITEM_WISE_MIN_REQ."User Id" := USERID;
                    ITEM_WISE_MIN_REQ.VALIDATE(ITEM_WISE_MIN_REQ."User Id", USERID);
                    ITEM_WISE_MIN_REQ.INSERT;

                END;
            UNTIL ITEM_LEDGER_ENTRY.NEXT = 0;
    end;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;

        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;

        TempExcelbuffer.Formula := '';
        TempExcelbuffer.INSERT;
    end;
}

