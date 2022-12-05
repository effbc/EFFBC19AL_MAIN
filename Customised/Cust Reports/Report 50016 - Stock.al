report 50016 Stock
{
    // version EFFUPG

    //     EnterHeadings(Row,1,DEsc_Loc,TRUE);
    //     Row+=2;
    //     EnterHeadings(Row,1,'ITEM',TRUE);
    //     EnterHeadings(Row,2,'ITEM DESCRIPTION',TRUE);
    //     EnterHeadings(Row,3,'QUANTITY',TRUE);
    //     EnterHeadings(Row,4,'UOM',TRUE);
    //     EnterHeadings(Row,5,'LOT NUMBER',TRUE);
    //     EnterHeadings(Row,6,'SERIAL NUMBER',TRUE);
    //     EnterHeadings(Row,7,'ITEM COST',TRUE);
    DefaultLayout = RDLC;
    RDLCLayout = './Stock.rdl';
    Permissions = TableData 32 = rm;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Stock';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Location Code", "Posting Date", "Document No.", "Item No.")
                                ORDER(Ascending)
                                WHERE("Location Code" = FILTER('CS|SITE'),
                                      "Global Dimension 2 Code" = FILTER(<> ''),
                                      "Remaining Quantity" = FILTER(> 0),
                                      "Item Category Code" = FILTER(<> 'STA'));
            RequestFilterFields = "Global Dimension 2 Code", "Item No.", "Serial No.", "Posting Date";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(TODAY; TODAY)
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME_Control1000000008; COMPANYNAME)
            {
            }
            column(TODAY_Control1000000049; TODAY)
            {
            }
            column(USERID_Control1000000050; USERID)
            {
            }
            column(DEsc_Loc; DEsc_Loc)
            {
            }
            column(COMPANYNAME_Control1000000023; COMPANYNAME)
            {
            }
            column(USERID_Control1000000024; USERID)
            {
            }
            column(TODAY_Control1000000025; TODAY)
            {
            }
            column(Desc_item; Desc_item)
            {
            }
            column(TODAY_Control1000000026; TODAY)
            {
            }
            column(USERID_Control1000000027; USERID)
            {
            }
            column(COMPANYNAME_Control1000000028; COMPANYNAME)
            {
            }
            column(Total_Cost_; "Total Cost")
            {
            }
            column(DEsc_Loc_Control1000000069; DEsc_Loc)
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_2_Code_; "Global Dimension 2 Code")
            {
            }
            column(Item_Ledger_Entry__Item_No__; "Item No.")
            {
            }
            column(DEsc_Loc_Control1000000055; DEsc_Loc)
            {
            }
            column(Desc_item_Control1000000056; Desc_item)
            {
            }
            column(Vendor_Name_; "Vendor Name")
            {
            }
            column(UC; UC)
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_2_Code__Control1000000040; "Global Dimension 2 Code")
            {
            }
            column(DEsc_Loc_Control1000000042; DEsc_Loc)
            {
            }
            column(Quantity_; (Quantity))
            {
            }
            column(Document_number; "Document No.")
            {
            }
            column(Entry_Type; "Entry Type")
            {
            }
            column(Item_Ledger_Entry__Serial_No__; "Serial No.")
            {
            }
            column(item__Avg_Unit_Cost_; item."Avg Unit Cost")
            {
            }
            column(Total; Total)
            {
            }
            column(Item_Ledger_Entry__Unit_of_Measure_Code_; "Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_2_Code__Control1000000064; "Global Dimension 2 Code")
            {
            }
            column(Item_Ledger_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(item__Avg_Unit_Cost__Control1000000068; item."Avg Unit Cost")
            {
            }
            column(Desc_item_Control1000000079; Desc_item)
            {
            }
            column(Item_Ledger_Entry__Item_Ledger_Entry___Serial_No__; "Item Ledger Entry"."Serial No.")
            {
            }
            column(item__Avg_Unit_Cost__Control1102154003; item."Avg Unit Cost")
            {
            }
            column(Item_Ledger_Entry__Serial_No___Control1102154004; "Serial No.")
            {
            }
            column(Item_Ledger_Entry__Lot_No__; "Lot No.")
            {
            }
            column(Item_Ledger_Entry__Unit_of_Measure_Code__Control1102154006; "Unit of Measure Code")
            {
            }
            column(Quantity__Control1102154007; (Quantity))
            {
            }
            column(Desc_item_Control1102154008; Desc_item)
            {
            }
            column(Item_Ledger_Entry__Item_No___Control1102154009; "Item No.")
            {
            }
            column(Item_Ledger_Entry__Posting_Date__Control1102154030; "Posting Date")
            {
            }
            column(Item_Ledger_Entry__Serial_No___Control1102154010; "Serial No.")
            {
            }
            column(item__Avg_Unit_Cost__Control1102154011; item."Avg Unit Cost")
            {
            }
            column(Quantity__Control1102154021; (Quantity))
            {
            }
            column(Location_Cost; Location_Cost)
            {
            }
            column(DEsc_Loc_Control1102154026; DEsc_Loc)
            {
            }
            column(Quantity__Control1000000006; (Quantity))
            {
            }
            column(Total_Control1000000033; Total)
            {
            }
            column(Item_Ledger_Entry__Item_No___Control1102154012; "Item No.")
            {
            }
            column(Desc_item_Control1102154013; Desc_item)
            {
            }
            column(Quantity__Control1102154014; (Quantity))
            {
            }
            column(item__Avg_Unit_Cost___Quantity_; item."Avg Unit Cost" * (Quantity))
            {
            }
            column(Item_Ledger_Entry__Unit_of_Measure_Code__Control1102154017; "Unit of Measure Code")
            {
            }
            column(STOCKCaption; STOCKCaptionLbl)
            {
            }
            column(STOCKCaption_Control1000000048; STOCKCaption_Control1000000048Lbl)
            {
            }
            column(STOCKCaption_Control1000000015; STOCKCaption_Control1000000015Lbl)
            {
            }
            column(Location__Caption; Location__CaptionLbl)
            {
            }
            column(STOCKCaption_Control1000000021; STOCKCaption_Control1000000021Lbl)
            {
            }
            column(Item__Caption; Item__CaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_2_Code_Caption; FIELDCAPTION("Global Dimension 2 Code"))
            {
            }
            column(Item_Ledger_Entry__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Location_NameCaption; Location_NameCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Item_No_Caption; Item_No_CaptionLbl)
            {
            }
            column(DescriptionCaption_Control1000000005; DescriptionCaption_Control1000000005Lbl)
            {
            }
            column(QTYCaption; QTYCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Lot_No_Caption; Lot_No_CaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Item_Ledger_Entry__Global_Dimension_2_Code__Control1000000064Caption; FIELDCAPTION("Global Dimension 2 Code"))
            {
            }
            column(Item_Ledger_Entry__Posting_Date_Caption; FIELDCAPTION("Posting Date"))
            {
            }
            column(Unit_CostCaption_Control1000000077; Unit_CostCaption_Control1000000077Lbl)
            {
            }
            column(Item_Caption; Item_CaptionLbl)
            {
            }
            column(Serial_No_Caption_Control1000000118; Serial_No_Caption_Control1000000118Lbl)
            {
            }
            column(Location_CodeCaption; Location_CodeCaptionLbl)
            {
            }
            column(Location_nameCaption_Control1000000011; Location_nameCaption_Control1000000011Lbl)
            {
            }
            column(QTYCaption_Control1000000044; QTYCaption_Control1000000044Lbl)
            {
            }
            column(Item_Ledger_Entry__Serial_No__Caption; FIELDCAPTION("Serial No."))
            {
            }
            column(Unit_CostCaption_Control1000000014; Unit_CostCaption_Control1000000014Lbl)
            {
            }
            column(ValueCaption_Control1000000030; ValueCaption_Control1000000030Lbl)
            {
            }
            column(UOMCaption_Control1000000035; UOMCaption_Control1000000035Lbl)
            {
            }
            column(Posting_DateCaption_Control1000000000; Posting_DateCaption_Control1000000000Lbl)
            {
            }
            column(Location_NameCaption_Control1000000070; Location_NameCaption_Control1000000070Lbl)
            {
            }
            column(Total_Quantity_At_Caption; Total_Quantity_At_CaptionLbl)
            {
            }
            column(Item_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Loc_OptionCaption; LocGvar)
            {
            }
            column(Item_OptionCaption; ItemGvar)
            {
            }
            column(Serial_OptionCaption; SeriaGvar)
            {
            }
            column(Nil_OptionCaption; NilGvar)
            {
            }
            column(Req_OptionCaption; ReqGvar)
            {
            }
            column(Hist_OptionCaption; HistGvar)
            {
            }
            column(Repla_OptionCaption; ReplaGvar)
            {
            }
            column(LocationNotFindCaption; LocationNotFind)
            {
            }
            column(ItemNotFindCaption; ItemNotFind)
            {
            }
            column(New_Caption; New)
            {
            }
            column(Serial_Requested_Caption; ((SeriaGvar = SeriaGvar::Serial) OR (ReqGvar = ReqGvar::Requested)))
            {
            }
            column(Item_Nil_Caption; ((ItemGvar = ItemGvar::item) OR (NilGvar = NilGvar::nil)))
            {
            }
            column(Loca_Item__Caption; ((LocGvar = LocGvar::Location) OR (NilGvar = NilGvar::nil)))
            {
            }
            column(ItemTrackingCode_Caption; item."Item Tracking Code")
            {
            }

            trigger OnAfterGetRecord();
            begin
                New := FALSE;
                Location_Cost := 0;
                one := TRUE;

                IF (Stock_Nullification) AND ("Item Ledger Entry"."Posting Date" <= Stock_On_Date) THEN BEGIN
                    IF ILE.GET("Item Ledger Entry"."Entry No.") AND ("Item Ledger Entry"."Item No." <> 'METOLGN00086') THEN BEGIN
                        ILE."Location Code" := 'OLD STOCK';
                        ILE.MODIFY;
                    END;
                END;


                IF LocGvar = LocGvar::Location THEN BEGIN
                    location.SETRANGE(location."Dimension Code", 'LOCATIONS');
                    location.SETRANGE(location.Code, "Item Ledger Entry"."Global Dimension 2 Code");
                    IF location.FIND('-') THEN
                        DEsc_Loc := location.Name;
                END ELSE
                    LocationNotFind := TRUE;

                IF (ItemGvar = ItemGvar::item) THEN BEGIN
                    item.SETRANGE(item."No.", "Item Ledger Entry"."Item No.");
                    IF item.FIND('-') THEN
                        Desc_item := item.Description;
                END ELSE
                    ItemNotFind := TRUE;



                IF SeriaGvar = SeriaGvar::Serial THEN BEGIN
                    location.SETRANGE(location."Dimension Code", 'LOCATIONS');
                    location.SETRANGE(location.Code, "Item Ledger Entry"."Global Dimension 2 Code");
                    IF location.FIND('-') THEN
                        DEsc_Loc := location.Name;
                    item.SETRANGE(item."No.", "Item Ledger Entry"."Item No.");
                    IF item.FIND('-') THEN
                        Desc_item := item.Description;
                    ILE.SETFILTER(ILE."Entry Type", 'Purchase');
                    ILE.SETCURRENTKEY(ILE."Item No.", ILE."Lot No.", ILE."Serial No.");
                    ILE.SETRANGE(ILE."Item No.", "Item Ledger Entry"."Item No.");
                    ILE.SETRANGE(ILE."Lot No.", "Item Ledger Entry"."Lot No.");
                    IF ILE.FIND('-') THEN BEGIN
                        PRH.SETRANGE(PRH."No.", ILE."Document No.");
                        IF PRH.FIND('-') THEN BEGIN
                            Vendor.SETRANGE(Vendor."No.", PRH."Buy-from Vendor No.");
                            IF Vendor.FIND('-') THEN
                                "Vendor Name" := Vendor.Name;
                            PIL.SETRANGE(PIL."No.", "Item Ledger Entry"."Item No.");
                            PIL.SETRANGE(PIL."Buy-from Vendor No.", PRH."Buy-from Vendor No.");
                            PIL.SETRANGE(PIL.Quantity, ILE.Quantity);
                            IF PIL.FIND('-') THEN
                                UC := PIL."Amount To Vendor" / PIL.Quantity;
                        END;
                    END;
                    IF UC = 0 THEN
                        UC := item."Avg Unit Cost";
                END;


                IF ItemGvar = ItemGvar::item THEN BEGIN
                    location.SETRANGE(location."Dimension Code", 'LOCATIONS');
                    location.SETRANGE(location.Code, "Item Ledger Entry"."Global Dimension 2 Code");
                    IF location.FIND('-') THEN
                        DEsc_Loc := location.Name;
                    Total := "Item Ledger Entry".Quantity * item."Avg Unit Cost";
                    "Total Cost" += Total;
                    Location_Cost += Total;
                    Total_Qty += "Item Ledger Entry".Quantity;
                END;



                IF ReqGvar = ReqGvar::Requested THEN BEGIN
                    IF item.GET("Item Ledger Entry"."Item No.") THEN
                        Desc_item := item.Description;
                END;


                IF (LocGvar = LocGvar::Location) THEN BEGIN
                    item.SETRANGE(item."No.", "Item Ledger Entry"."Item No.");
                    IF item.FIND('-') THEN
                        Desc_item := item.Description;

                    one := FALSE;
                    /*
                    CurrReport.SHOWOUTPUT((( choice=choice::Location ) OR (choice=choice::nil))
                                    AND ( (item."Item Tracking Code"='LOTSERIAL') OR (item."Item Tracking Code"='SERIAL')) );
                   */
                    c1 := 0;
                    c2 := 0;
                    IF EXCEL THEN BEGIN    //added by pranavi on 31-01-2015
                        c1 := STRPOS(Desc_item, 'FLASH MEMORY');
                        c2 := STRPOS(Desc_item, 'FLASH RAM');
                        IF NOT ((Desc_item = 'BALL PENS') OR (Desc_item = '100 P BIG EFF SCRIBLING PADS') OR (c1 > 0) OR (c2 > 0) AND (Text1 = 'H-OFF')) THEN BEGIN      //end pranavi
                            "var1" += 1;
                            Row += 1;
                            Entercell(Row, 1, FORMAT("Item No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, FORMAT(Desc_item), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 3, FORMAT((Quantity)), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 4, FORMAT("Unit of Measure Code"), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 5, FORMAT("Lot No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 6, FORMAT("Serial No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 7, FORMAT(item."Avg Unit Cost"), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 9, FORMAT("Posting Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                            IF COPYSTR("Document No.", 1, 7) = 'POS-ADJ' THEN
                                Entercell(Row, 10, 'Sales', FALSE, TempExcelbuffer."Cell Type"::Text)
                            ELSE
                                Entercell(Row, 10, 'Service', FALSE, TempExcelbuffer."Cell Type"::Text);//added  by Vishnu Priya on 13-02-2020
                            Entercell(Row, 11, FORMAT("Document No."), FALSE, TempExcelbuffer."Cell Type"::Text);//added  by Vishnu Priya on 13-02-2020
                        END;
                    END;
                END;


                IF ((LocGvar = LocGvar::Location) OR (NilGvar = NilGvar::nil)) THEN BEGIN
                    item.SETRANGE(item."No.", "Item Ledger Entry"."Item No.");
                    IF item.FIND('-') THEN
                        Desc_item := item.Description;
                    Total := "Item Ledger Entry".Quantity * item."Avg Unit Cost";
                    "Total Cost" += Total;
                    Total_Service_Items += "Item Ledger Entry".Quantity;
                    /*
                    IF item."Item Tracking Code"='LOT' THEN
                      CurrReport.SHOWOUTPUT:=FALSE;
                    */

                    //CurrReport.SHOWOUTPUT:=FALSE;
                    c1 := 0;
                    c2 := 0;
                    IF EXCEL THEN BEGIN       //added by pranavi on 31-01-2015
                        c1 := STRPOS(Desc_item, 'FLASH MEMORY');
                        c2 := STRPOS(Desc_item, 'FLASH RAM');
                        IF NOT ((Desc_item = 'BALL PENS') OR (Desc_item = '100 P BIG EFF SCRIBLING PADS') OR (c1 > 0) OR (c2 > 0) AND (Text1 = 'H-OFF')) THEN BEGIN           //end pranavi
                            Row += 1;
                            Entercell(Row, 1, FORMAT("Item No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 2, FORMAT(Desc_item), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 3, FORMAT((Quantity)), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 4, FORMAT("Unit of Measure Code"), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 5, FORMAT("Lot No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 6, FORMAT("Serial No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                            Entercell(Row, 7, FORMAT(item."Avg Unit Cost"), FALSE, TempExcelbuffer."Cell Type"::Number);
                            Entercell(Row, 8, FORMAT(DEsc_Loc), FALSE, TempExcelbuffer."Cell Type"::Text);
                        END;
                        // Entercell(Row,3,FORMAT((Quantity)),FALSE);
                        //Entercell(Row,7,FORMAT(Total),FALSE);
                    END;
                END;
                IF ((LocGvar = LocGvar::Location) OR (NilGvar = NilGvar::nil))
                THEN BEGIN

                    item.SETRANGE(item."No.", "Item Ledger Entry"."Item No.");
                    IF item.FIND('-') THEN
                        Desc_item := item.Description;
                    Total := "Item Ledger Entry".Quantity * item."Avg Unit Cost";
                    "Total Cost" += Total;
                END;
                /*
                IF item."Item Tracking Code"<>'LOT' THEN
                   CurrReport.SHOWOUTPUT:=FALSE
                ELSE
                BEGIN

                END;

               END ELSE
               CurrReport.SHOWOUTPUT:=FALSE;
                */

            end;

            trigger OnPreDataItem();
            begin
                CLEAR(LocationNotFind);
                CLEAR(ItemNotFind);
                CLEAR(Quantity);
                IF (Stock_On_Date = 0D) AND Stock_Nullification THEN
                    ERROR('PLEASE ENTER THE DATE');

                IF (HistGvar = HistGvar::History) THEN
                    CurrReport.BREAK;

                IF (ReqGvar <> ReqGvar::Requested) THEN BEGIN
                    Text1 := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Global Dimension 2 Code");
                    Text2 := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Item No.");
                    "Text 3" := "Item Ledger Entry".GETFILTER("Item Ledger Entry"."Serial No.");
                    IF Text1 <> '' THEN
                        LocGvar := LocGvar::Location
                    ELSE
                        IF (Text2 <> '') AND ("Text 3" <> '') THEN
                            SeriaGvar := SeriaGvar::Serial
                        ELSE
                            IF Text2 <> '' THEN
                                ItemGvar := ItemGvar::item
                            ELSE
                                NilGvar := NilGvar::nil;
                    Loc := "Item Ledger Entry"."Global Dimension 2 Code";
                    First := 0;
                END ELSE
                    IF ReqGvar = ReqGvar::Requested THEN BEGIN
                        /*
                        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Entry Type","Item Ledger Entry"."Item No.",
                        "Item Ledger Entry"."Location Code","Item Ledger Entry".Open,"Item Ledger Entry"."Lot No.",
                        "Item Ledger Entry"."Serial No.","Item Ledger Entry"."Global Dimension 2 Code");
                        */
                        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Entry Type", 'OUTput');
                    END;


                IF (LocGvar = LocGvar::Location) THEN BEGIN
                    IF EXCEL THEN BEGIN
                        Row += 1;
                        Entercell(Row, 1, 'Item No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, 'Description', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 3, 'Quantity', TRUE, TempExcelbuffer."Cell Type"::Number);
                        Entercell(Row, 4, 'UOM', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 5, 'Lot No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 6, 'Serial No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 7, 'Item Avg Cost', TRUE, TempExcelbuffer."Cell Type"::Number);
                        Entercell(Row, 9, 'Posting Date', TRUE, TempExcelbuffer."Cell Type"::Date);
                        Entercell(Row, 10, 'Service/Sale', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 11, 'Document No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    END;
                END;


                IF ((LocGvar = LocGvar::Location) OR (NilGvar = NilGvar::nil)) THEN BEGIN
                    IF EXCEL THEN BEGIN
                        Row += 1;
                        Entercell(Row, 1, 'Item No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 2, 'Description', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 3, 'Quantity', TRUE, TempExcelbuffer."Cell Type"::Number);
                        Entercell(Row, 4, 'UOM', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 5, 'Lot No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 6, 'Serial No', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 7, 'Item Avg Cost', TRUE, TempExcelbuffer."Cell Type"::Number);
                        Entercell(Row, 8, 'Description Location', TRUE, TempExcelbuffer."Cell Type"::Text);
                        Entercell(Row, 9, 'Posting Date', TRUE, TempExcelbuffer."Cell Type"::Date); //added  by Vishnu Priya on 13-02-2020
                        Entercell(Row, 10, 'Service/Sale', TRUE, TempExcelbuffer."Cell Type"::Text);//added  by Vishnu Priya on 13-02-2020
                        Entercell(Row, 11, 'Document No.', TRUE, TempExcelbuffer."Cell Type"::Text);//added  by Vishnu Priya on 13-02-2020
                    END;
                END;
                "var1" := 0;
                c1 := 0;
                c2 := 0;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102152001)
                {
                    Caption = '';
                    field(Requested; ReqGvar)
                    {
                    }
                    field(History; HistGvar)
                    {
                    }
                    field("Stock On Date"; Stock_On_Date)
                    {
                    }
                    field("Nullify The Stock"; Stock_Nullification)
                    {
                    }
                    field(EXCEL; EXCEL)
                    {
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
        /*
        IF EXCEL THEN
        BEGIN
          TempExcelbuffer.CreateBook;
          TempExcelbuffer.CreateSheet('SITE WISE AMC CARDS STATUS','',COMPANYNAME,'');
          TempExcelbuffer.GiveUserControl;
        END;
         */

        IF EXCEL THEN BEGIN
            /*
              TempExcelbuffer.CreateBook('SITE WISE AMC CARDS STATUS',''); //EFFUPG
              TempExcelbuffer.WriteSheet('SITE WISE AMC CARDS STATUS',COMPANYNAME,USERID);
              TempExcelbuffer.CloseBook;
              TempExcelbuffer.OpenExcel;
              TempExcelbuffer.GiveUserControl;
            */
            TempExcelbuffer.CreateBookAndOpenExcel('', 'SITE WISE AMC CARDS STATUS', 'SITE WISE AMC CARDS STATUS', COMPANYNAME, USERID); //EFFUPG
        END;

    end;

    trigger OnPreReport();
    begin
        IF EXCEL THEN BEGIN
            CLEAR(TempExcelbuffer);
            TempExcelbuffer.DELETEALL;
        END;
    end;

    var
        location: Record 349;
        item: Record 27;
        DEsc_Loc: Text[30];
        Desc_item: Text[70];
        choice1: Option Location,item,Serial,nil,Requested,History,Replacements;
        Text1: Text[30];
        Text2: Text[30];
        "Text 3": Text[30];
        "Total Cost": Decimal;
        Total: Decimal;
        ILE: Record 32;
        PRH: Record 120;
        "Vendor Name": Text[30];
        Vendor: Record 23;
        PIL: Record 123;
        UC: Decimal;
        Loc: Code[10];
        New: Boolean;
        First: Integer;
        TOT: Decimal;
        SH: Record 5900;
        "posting date": Date;
        Zone: Text[30];
        dim1: Record 349;
        dim2: Record 349;
        "from loc": Text[30];
        "to loc": Text[30];
        FromLoc2: Text[30];
        ToLoc2: Text[30];
        SIL: Record 5902;
        Postdate2: Date;
        single: Boolean;
        station: Text[30];
        Postdate3: Date;
        SI_Filter: Text[30];
        Customer: Record 18;
        "Service Item Line": Record 5901;
        SI: Record 5940;
        sno: Code[10];
        Old_Sno: Code[50];
        ItemLedEntryFilter: Text[200];
        ServItem1Filter: Text[200];
        ServItem2Filter: Text[200];
        "Serial_No.": Code[30];
        one: Boolean;
        Total_Qty: Integer;
        Location_Cost: Decimal;
        Total_Service_Items: Decimal;
        Stock_Nullification: Boolean;
        Stock_On_Date: Date;
        TempExcelbuffer: Record 370 temporary;
        Row: Integer;
        EXCEL: Boolean;
        STOCKCaptionLbl: Label 'STOCK';
        STOCKCaption_Control1000000048Lbl: Label 'STOCK';
        STOCKCaption_Control1000000015Lbl: Label 'STOCK';
        Location__CaptionLbl: Label 'Location :';
        STOCKCaption_Control1000000021Lbl: Label 'STOCK';
        Item__CaptionLbl: Label 'Item :';
        Location_NameCaptionLbl: Label 'Location Name';
        DescriptionCaptionLbl: Label 'Description';
        VendorCaptionLbl: Label 'Vendor';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        Item_No_CaptionLbl: Label 'Item No.';
        DescriptionCaption_Control1000000005Lbl: Label 'Description';
        QTYCaptionLbl: Label 'QTY';
        ValueCaptionLbl: Label 'Value';
        UOMCaptionLbl: Label 'UOM';
        Lot_No_CaptionLbl: Label 'Lot No.';
        Serial_No_CaptionLbl: Label 'Serial No.';
        Posting_DateCaptionLbl: Label 'Posting Date';
        Unit_CostCaption_Control1000000077Lbl: Label 'Unit Cost';
        Item_CaptionLbl: Label '"Item "';
        Serial_No_Caption_Control1000000118Lbl: Label 'Serial No.';
        Location_CodeCaptionLbl: Label 'Location Code';
        Location_nameCaption_Control1000000011Lbl: Label 'Location name';
        QTYCaption_Control1000000044Lbl: Label 'QTY';
        Unit_CostCaption_Control1000000014Lbl: Label 'Unit Cost';
        ValueCaption_Control1000000030Lbl: Label 'Value';
        UOMCaption_Control1000000035Lbl: Label 'UOM';
        Posting_DateCaption_Control1000000000Lbl: Label 'Posting Date';
        Location_NameCaption_Control1000000070Lbl: Label 'Location Name';
        Total_Quantity_At_CaptionLbl: Label '"Total Quantity At "';
        LocGvar: Option " ",Location;
        ItemGvar: Option " ",item;
        SeriaGvar: Option " ",Serial;
        NilGvar: Option " ",nil;
        ReqGvar: Option " ",Requested;
        HistGvar: Option " ",History;
        ReplaGvar: Option " ",Replacements;
        LocationNotFind: Boolean;
        ItemNotFind: Boolean;
        var1: Integer;
        c1: Integer;
        c2: Integer;

    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option Number,Text,Date,Time);
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer."Cell Type" := CellType; //New Parma for Excel
        TempExcelbuffer.Bold := bold;

        TempExcelbuffer.INSERT;
    end;

    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean);
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

