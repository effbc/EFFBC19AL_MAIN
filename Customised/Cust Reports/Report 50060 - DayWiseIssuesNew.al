report 50060 "Day Wise Issues New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DayWiseIssuesNew.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Material Issues Line";
        "Posted Material Issues Line")
        {
            DataItemTableView = SORTING("Material Requisition Date", "Production BOM No.", "Issued DateTime", Dept, "Item No.") ORDER(Ascending);
            RequestFilterFields = "Material Requisition Date", Dept, "Production BOM No.";
            RequestFilterHeading = 'Posted Material Issues Line';
            column(Item_No; "Posted Material Issues Line"."Item No.")
            {
            }
            column(Desc; "Posted Material Issues Line".Description)
            {
            }
            column(Qty; "Posted Material Issues Line".Quantity)
            {
            }
            column(UOM; "Posted Material Issues Line"."Unit of Measure")
            {
            }
            column(Mat_Req_Date; "Posted Material Issues Line"."Material Requisition Date")
            {
            }
            column(Dept; "Posted Material Issues Line".Dept)
            {
            }
            column(Prod_Ordr_No; "Posted Material Issues Line"."Prod. Order No.")
            {
            }
            column(Prod_Order_Line_No; "Posted Material Issues Line"."Prod. Order Line No.")
            {
            }
            column(Prod_BOM_No; ProdBOMNo)
            {
            }
            column(CURRENTDATETIME; CURRENTDATETIME)
            {
            }
            column(BinAddrs; BinAddrs)
            {
            }
            column(StockAddrs; StockAddrs)
            {
            }
            column(MechOrWring; MechOrWring)
            {
            }
            column(HeaderDesc; HeaderDesc)
            {
            }
            column(ProdBOMDesc; ProdBOMDesc)
            {
            }
            column(ReleasedDateTime; ReleasedDateTime)
            {
            }
            column(IssuedDateTime; IssuedDateTime)
            {
            }
            column(PostingDate; PostingDate)
            {
            }
            column(Req_By; Req_By)
            {
            }
            column(ProjCodes; ProjCodes)
            {
            }
            column(PMINos; PMINos)
            {
            }
            column(TransferFromCode; "Posted Material Issues Line"."Transfer-from Code")
            {
            }
            column(TransferToCode; "Posted Material Issues Line"."Transfer-to Code")
            {
            }
            column(ProdOrderNosSeries; ProdOrderNos)
            {
            }
            column(ItmDesc2; ItmDesc2)
            {
            }
            column(ShortageCount; ShortageCount)
            {
            }
            column(RequestedByCaption; RequestedByCaption)
            {
            }
            column(ProdCodesCaption; ProdCodesCaption)
            {
            }
            column(Tran4CodeCaption; Tran4CodeCaption)
            {
            }
            column(Trans2CodeCaption; Trans2CodeCaption)
            {
            }
            column(CompPCBCaption; CompPCBCaption)
            {
            }
            column(ReqDateCaption; ReqDateCaption)
            {
            }
            column(IssuedDateCaption; IssuedDateCaption)
            {
            }
            column(CompanyNameCaption; CompanyNameCaption)
            {
            }
            column(MatReqDateCaption; MatReqDateCaption)
            {
            }
            column(CurrtDateTime; CurrtDateTime)
            {
            }
            column(setcount; setcount)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No."), "Item No." = FIELD("Item No.");
                DataItemTableView = SORTING("Document No.", "Item No.", "Posting Date") ORDER(Ascending) WHERE("Entry Type" = CONST("Transfer"), Quantity = FILTER(> 0));
                column(SerialNo; "Item Ledger Entry"."Serial No.")
                {
                }
                column(LotNo; "Item Ledger Entry"."Lot No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                IF Picked = FALSE THEN BEGIN
                    IF NOT ("Posted Material Issues Line"."Transfer-from Code" IN ['STR', 'MCH']) THEN
                        CurrReport.SKIP;
                    IF NOT ("Posted Material Issues Line"."Transfer-to Code" IN ['PROD']) THEN
                        CurrReport.SKIP;
                    IF "Posted Material Issues Line".Quantity <= 0 THEN
                        CurrReport.SKIP;
                    PMIH.RESET;
                    IF PMIH.GET("Posted Material Issues Line"."Document No.") THEN BEGIN
                        Req_By := PMIH."Resource Name" + '(' + COPYSTR(PMIH."Released By", 12, STRLEN(PMIH."Released By")) + ')';
                        IssuedDateTime := PMIH."Issued DateTime";
                        ReleasedDateTime := PMIH."Released Date";
                        PostingDate := PMIH."Posting Date";
                    END;
                    IssdDate := 0D;
                    IssdDate := DT2DATE("Posted Material Issues Line"."Issued DateTime");
                    ProjCodes := "Posted Material Issues Line"."Prod. Order No.";
                    PMINos := "Posted Material Issues Line"."Document No.";
                    MechOrWring := '';
                    ItmDesc2 := '';
                    BinAddrs := '';
                    StockAddrs := '';
                    Item.RESET;
                    Item.SETRANGE(Item."No.", "Posted Material Issues Line"."Item No.");
                    IF Item.FINDFIRST THEN BEGIN
                        BinAddrs := Item."BIN Address";
                        StockAddrs := Item."Stock Address";
                        ItmDesc2 := Item."Description 2";
                    END;
                    ProdOrderLine.RESET;
                    ProdOrderLine.SETCURRENTKEY("Prod. Order No.", "Line No.", Status);
                    ProdOrderLine.SETRANGE(ProdOrderLine."Prod. Order No.", "Posted Material Issues Line"."Prod. Order No.");
                    ProdOrderLine.SETRANGE(ProdOrderLine."Line No.", "Posted Material Issues Line"."Prod. Order Line No.");
                    IF ProdOrderLine.FINDFIRST THEN BEGIN
                        ProdBOMNo := ProdOrderLine."Item No.";
                        ProdBOMDesc := ProdOrderLine.Description;
                    END;
                    "Mech&Wring".RESET;
                    "Mech&Wring".SETCURRENTKEY("Item No.", "Lot No.", "Production Order No.");
                    "Mech&Wring".SETRANGE("Mech&Wring"."Item No.", "Posted Material Issues Line"."Item No.");
                    "Mech&Wring".SETRANGE("Mech&Wring"."Request No.", "Posted Material Issues Line"."Material Issue No.");
                    IF "Mech&Wring".FINDFIRST THEN
                        MechOrWring := "Mech&Wring"."BOM Type";
                    IF MechOrWring = 'MECHANICAL' THEN
                        HeaderDesc := 'Mechanical Sets for ' + ProdBOMDesc
                    ELSE
                        IF MechOrWring = 'WIRING' THEN
                            HeaderDesc := 'Wiring Sets for ' + ProdBOMDesc
                        ELSE
                            IF MechOrWring IN ['Testing', 'TESTING'] THEN
                                HeaderDesc := 'Testing Sets for ' + ProdBOMDesc
                            ELSE
                                IF MechOrWring IN ['Packing', 'PACKING'] THEN
                                    HeaderDesc := 'Packing Sets for ' + ProdBOMDesc
                                ELSE
                                    HeaderDesc := 'Material Sets for ' + ProdBOMDesc;
                    TempBOM := '';
                    TempPRevItem := '';
                    ShortageCount := 0;
                    FOR i := 1 TO 1000 DO
                        Codes[i] := '';
                    i := 0;
                    j := 0;
                    count1 := 0;
                    c2 := 0;
                    templen := 0;
                    IF (PrevProdBOMNo <> ProdBOMNo) OR (IssdDate <> PrevIssdDate) THEN BEGIN
                        MIL.RESET;
                        MIL.SETCURRENTKEY("Transfer-from Code", "Transfer-to Code", "Material Requisition Date", "Production BOM No.", Dept, "Item No.");
                        MIL.SETFILTER(MIL."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                        MIL.SETFILTER(MIL."Transfer-to Code", '%1', 'PROD');
                        MIL.SETFILTER(MIL."Material Requisition Date", "Posted Material Issues Line".GETFILTER("Posted Material Issues Line"."Material Requisition Date"));
                        MIL.SETFILTER(MIL."Outstanding Qty. (Base)", '>%1', 0);
                        IF MIL.FINDSET THEN
                            REPEAT
                                TempBOM := '';
                                ProdOrderLine.RESET;
                                ProdOrderLine.SETCURRENTKEY("Prod. Order No.", "Line No.", Status);
                                ProdOrderLine.SETRANGE(ProdOrderLine."Prod. Order No.", MIL."Prod. Order No.");
                                ProdOrderLine.SETRANGE(ProdOrderLine."Line No.", MIL."Prod. Order Line No.");
                                IF ProdOrderLine.FINDFIRST THEN BEGIN
                                    TempBOM := ProdOrderLine."Item No.";
                                END;
                                IF TempBOM = ProdBOMNo THEN BEGIN
                                    IF TempPRevItem <> MIL."Item No." THEN
                                        ShortageCount := ShortageCount + 1;
                                END;
                                TempPRevItem := MIL."Item No.";
                            UNTIL MIL.NEXT = 0;
                        codestext := '';
                        ProdOrderNos := '';
                        PMIL.RESET;
                        PMIL.SETCURRENTKEY("Material Requisition Date", "Production BOM No.", Dept, "Item No.");
                        PMIL.SETRANGE(PMIL."Material Requisition Date", "Posted Material Issues Line"."Material Requisition Date");
                        PMIL.SETRANGE(PMIL."Production BOM No.", "Posted Material Issues Line"."Production BOM No.");
                        PMIL.SETRANGE(PMIL."Issued DateTime", CREATEDATETIME(IssdDate, 0T), CREATEDATETIME(IssdDate, 235900T));
                        IF PMIL.FINDFIRST THEN
                            REPEAT
                                i := 0;
                                j := 0;
                                count1 := 0;
                                c2 := 0;
                                templen := 0;
                                FOR i := 1 TO 1000 DO BEGIN
                                    IF Codes[i] = PMIL."Prod. Order No." THEN
                                        count1 := count1 + 1;
                                    IF Codes[i] = '' THEN
                                        i := 1000;
                                END;
                                FOR i := 1 TO 1000 DO BEGIN
                                    IF Codes[i] = '' THEN BEGIN
                                        j := i;
                                        i := 1000;
                                    END;
                                END;
                                IF count1 = 0 THEN BEGIN
                                    FOR i := 1 TO 1000 DO BEGIN
                                        IF Codes[i] <> '' THEN BEGIN
                                            templen := STRLEN(COPYSTR(PMIL."Prod. Order No.", 1, STRLEN(PMIL."Prod. Order No.") - 4));
                                            IF COPYSTR(Codes[i], 1, templen) = COPYSTR(PMIL."Prod. Order No.", 1, STRLEN(PMIL."Prod. Order No.") - 4) THEN BEGIN
                                                Codes[i] := COPYSTR(Codes[i], 1, templen + 4) + '..' + COPYSTR(PMIL."Prod. Order No.", STRLEN(PMIL."Prod. Order No.") - 3, 4);
                                                codestext := codestext + '|' + PMIL."Prod. Order No.";
                                                i := 1000;
                                                c2 := c2 + 1;
                                            END;
                                        END ELSE
                                            i := 1000;
                                    END;
                                    IF c2 = 0 THEN BEGIN
                                        Codes[j] := PMIL."Prod. Order No.";
                                        IF codestext = '' THEN
                                            codestext := PMIL."Prod. Order No."
                                        ELSE
                                            codestext := codestext + '|' + PMIL."Prod. Order No.";
                                    END;
                                END;
                            UNTIL PMIL.NEXT = 0;
                    END;
                    FOR i := 1 TO 1000 DO BEGIN
                        IF ProdOrderNos = '' THEN
                            ProdOrderNos := Codes[i]
                        ELSE
                            ProdOrderNos := ProdOrderNos + '|' + Codes[i];
                        IF Codes[i] = '' THEN
                            i := 1000;
                    END;
                    IF STRLEN(ProdOrderNos) > 1 THEN
                        ProdOrderNos := COPYSTR(ProdOrderNos, 1, STRLEN(ProdOrderNos) - 1);
                    setcount := 0;
                    POL.RESET;
                    //POL.SETRANGE(POL.Status,POL.Status::Released);
                    POL.SETFILTER(POL."Prod. Order No.", codestext);
                    POL.SETRANGE(POL."Production BOM No.", ProdBOMNo);
                    IF POL.FINDSET THEN
                        REPEAT
                            setcount := setcount + POL.Quantity;
                        UNTIL POL.NEXT = 0;
                    HeaderDesc := HeaderDesc + '-' + FORMAT(setcount);
                    PrevProdBOMNo := ProdBOMNo;
                    //PrevPostingDate:=PostingDate;
                    PrevIssdDate := IssdDate;
                    IF ProdBOMNo = '' THEN
                        CurrReport.SHOWOUTPUT(FALSE);
                END
                ELSE   //For picked field checking
                BEGIN
                    "Posted Material Issues Line"."Material Picked" := TRUE;
                    "Posted Material Issues Line".MODIFY;
                END;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE(FORMAT("Posted Material Issues Line".COUNT));
            end;

            trigger OnPreDataItem()
            begin
                CurrtDateTime := CURRENTDATETIME();
                IF "Posted Material Issues Line".GETFILTER("Posted Material Issues Line"."Material Requisition Date") = '' THEN
                    ERROR('Please enter Material Requisition Date!');
            end;
        }
        dataitem("Material Issues Line"; "Material Issues Line")
        {
            DataItemTableView = SORTING("Transfer-from Code", "Transfer-to Code", "Material Requisition Date", "Production BOM No.", Dept, "Item No.") ORDER(Ascending) WHERE("Transfer-from Code" = FILTER('STR|PROD'), "Transfer-to Code" = CONST('PROD'), "Outstanding Qty. (Base)" = FILTER(> 0));
            column(MItem_No; "Material Issues Line"."Item No.")
            {
            }
            column(MQty; "Material Issues Line".Quantity)
            {
            }
            column(MMRD; "Material Issues Line"."Material Requisition Date")
            {
            }
            column(MDept; "Material Issues Line".Dept)
            {
            }
            column(MProdOrderNo; "Material Issues Line"."Prod. Order No.")
            {
            }
            column(MProdOrderLineNo; "Material Issues Line"."Prod. Order Line No.")
            {
            }
            column(MOutQty; "Material Issues Line"."Outstanding Qty. (Base)")
            {
            }
            column(MMechOrWring; MMechOrWring)
            {
            }
            column(MHeaderDesc; MHeaderDesc)
            {
            }
            column(MProdBOMNo; MProdBOMNo)
            {
            }
            column(MProdBOMDesc; MProdBOMDesc)
            {
            }
            column(MItmDesc2; ItmDesc2)
            {
            }
            column(MItmDesc; "Material Issues Line".Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Picked = TRUE THEN
                    CurrReport.BREAK;
                MProdBOMNo := '';
                MProdBOMDesc := '';
                ItmDesc2 := '';
                Item.RESET;
                Item.SETRANGE(Item."No.", "Material Issues Line"."Item No.");
                IF Item.FINDFIRST THEN BEGIN
                    ItmDesc2 := Item."Description 2";
                END;
                ProdOrderLine.RESET;
                ProdOrderLine.SETCURRENTKEY("Prod. Order No.", "Line No.", Status);
                ProdOrderLine.SETRANGE(ProdOrderLine."Prod. Order No.", "Material Issues Line"."Prod. Order No.");
                ProdOrderLine.SETRANGE(ProdOrderLine."Line No.", "Material Issues Line"."Prod. Order Line No.");
                IF ProdOrderLine.FINDFIRST THEN BEGIN
                    MProdBOMNo := ProdOrderLine."Item No.";
                    MProdBOMDesc := ProdOrderLine.Description;
                END;
                MHeaderDesc := '';
                MMechOrWring := '';
                "Mech&Wring".RESET;
                "Mech&Wring".SETCURRENTKEY("Item No.", "Lot No.", "Production Order No.");
                "Mech&Wring".SETRANGE("Mech&Wring"."Item No.", "Material Issues Line"."Item No.");
                "Mech&Wring".SETRANGE("Mech&Wring"."Request No.", "Material Issues Line"."Document No.");
                IF "Mech&Wring".FINDFIRST THEN
                    MMechOrWring := "Mech&Wring"."BOM Type";
                IF MMechOrWring = 'MECHANICAL' THEN
                    MHeaderDesc := 'Mechanical Sets for ' + ProdBOMDesc
                ELSE
                    IF MMechOrWring = 'WIRING' THEN
                        MHeaderDesc := 'Wiring Sets for ' + ProdBOMDesc
                    ELSE
                        IF MMechOrWring IN ['Testing', 'TESTING'] THEN
                            MHeaderDesc := 'Wiring Sets for ' + ProdBOMDesc
                        ELSE
                            IF MMechOrWring IN ['Packing', 'PACKING'] THEN
                                MHeaderDesc := 'Wiring Sets for ' + ProdBOMDesc
                            ELSE
                                MHeaderDesc := 'Material Sets for ' + ProdBOMDesc;
            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE(FORMAT("Material Issues Line".COUNT));
            end;

            trigger OnPreDataItem()
            begin
                IF Picked = TRUE THEN
                    CurrReport.BREAK;
                "Material Issues Line".SETFILTER("Material Issues Line"."Material Requisition Date", "Posted Material Issues Line".GETFILTER("Posted Material Issues Line"."Material Requisition Date"));
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102152000)
                {
                    ShowCaption = false;
                    field(Picked; Picked)
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

    var
        CurrtDateTime: DateTime;
        Item: Record Item;
        BinAddrs: Code[15];
        sampledate: Date;
        ProdOrderLine: Record "Prod. Order Line";
        ProdBOMNo: Text;
        ILE: Record "Item Ledger Entry";
        "Mech&Wring": Record "Mech & Wirning Items";
        MechOrWring: Code[10];
        ProdBOMDesc: Text;
        HeaderDesc: Text;
        Req_By: Code[100];
        PMIH: Record "Posted Material Issues Header";
        IssuedDateTime: DateTime;
        ReleasedDateTime: Date;
        ProjCodes: Text;
        PMINos: Text;
        PMIL: Record "Posted Material Issues Line";
        PrevProdBOMNo: Code[25];
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderNos: Text;
        PrevProdOrderNo: Text;
        Series: Text;
        tempseries: Text;
        MIL: Record "Material Issues Line";
        MMechOrWring: Code[10];
        MHeaderDesc: Text;
        MProdBOMNo: Code[30];
        MProdBOMDesc: Text;
        ItmDesc2: Text;
        ShortageCount: Integer;
        TempBOM: Code[25];
        TempPRevItem: Code[30];
        Codes: array[1000] of Code[30];
        i: Integer;
        count1: Integer;
        j: Integer;
        c2: Integer;
        templen: Integer;
        Picked: Boolean;
        RequestedByCaption: Label 'Requested By: ';
        ProdCodesCaption: Label 'Prod Codes: ';
        Tran4CodeCaption: Label 'Transfer from Code: ';
        Trans2CodeCaption: Label 'Transfer To Code: ';
        CompPCBCaption: Label 'Compound PCB: ';
        ReqDateCaption: Label 'Requested date: ';
        IssuedDateCaption: Label 'Issued Date Time:';
        CompanyNameCaption: Label 'Efftronics Systems Pvt Ltd.';
        MatReqDateCaption: Label 'Material Required Date:';
        codestext: Text;
        POL: Record "Prod. Order Line";
        setcount: Integer;
        PostingDate: Date;
        PrevPostingDate: Date;
        IssdDate: Date;
        PrevIssdDate: Date;
        StockAddrs: Code[15];
}

