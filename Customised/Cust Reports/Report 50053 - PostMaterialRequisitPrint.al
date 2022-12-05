report 50053 "Post. Material Requisit Print"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PostMaterialRequisitPrint.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Posted Material Issues Header"; "Posted Material Issues Header")
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.", "Transfer-from Code", "Transfer-to Code", "Prod. Order No.", "Prod. Order Line No.", "Issued DateTime", "Prod. BOM No.";
            RequestFilterHeading = 'Material Issue';
            column(PMIHeader_Choice; Choice)
            {
            }
            column(CompanyAddr_1_; CompanyAddr[1])
            {
            }
            column(CURRENTDATETIME; CURRENTDATETIME)
            {
            }
            column(SET_Header; SET_Header)
            {
            }
            column(CURRENTDATETIME_Control1102154038; CURRENTDATETIME)
            {
            }
            column(CompanyAddr_1__Control1102154039; CompanyAddr[1])
            {
            }
            column(Posted_Material_Issues_Header__No__; "No.")
            {
            }
            column(Posted_Material_Issues_Header__Transfer_from_Code_; "Transfer-from Code")
            {
            }
            column(Posted_Material_Issues_Header__Prod__Order_No__; "Prod. Order No.")
            {
            }
            column(Prod_codes; Prod_codes)
            {
            }
            column(Posted_Material_Issues_Header__Transfer_to_Code2_; "Posted Material Issues Header"."Transfer-to Code")
            {
            }
            column(Posted_Material_Issues_Header__Posted_Material_Issues_Header___Resource_Name_; "Posted Material Issues Header"."Resource Name")
            {
            }
            column(Posted_Material_Issues_Header___Released_Date2_; "Posted Material Issues Header"."Released Date")
            {
            }
            column(Posted_Material_Issues_Header___Issued_DateTime2_; "Posted Material Issues Header"."Issued DateTime")
            {
            }
            column(COmpound_desc; COmpound_desc)
            {
            }
            column(Posted_Material_Issues_Header__Posted_Material_Issues_Header___Released_By_; "Posted Material Issues Header"."Released By")
            {
            }
            column(Material_Request_FormCaption; Material_Request_FormCaptionLbl)
            {
            }
            column(Requested__By_Caption; Requested__By_CaptionLbl)
            {
            }
            column(Requisition_NoCaption; Requisition_NoCaptionLbl)
            {
            }
            column(Posted_Material_Issues_Header__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
            {
            }
            column(Posted_Material_Issues_Header__Prod__Order_No__Caption; FIELDCAPTION("Prod. Order No."))
            {
            }
            column(Posted_Material_Issues_Header__Transfer_to_Code_Caption; FIELDCAPTION("Transfer-to Code"))
            {
            }
            column(CompoundCaption; CompoundCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154183; EmptyStringCaption_Control1102154183Lbl)
            {
            }
            column(PMI_Posting_Date; "Posted Material Issues Header"."Posting Date")
            {
            }
            column(PMI_Location_Code; LocationsCode)
            {
            }
            column(Req_Released_Date; "Posted Material Issues Header"."Released Date")
            {
            }
            dataitem("Posted Material Issues Line"; "Posted Material Issues Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending) WHERE("Item No." = FILTER(<> ''));
                RequestFilterFields = "Receipt Date";
                column(PMILineBody3; PMILineBody3)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Unit_of_Measure_Code_; "Posted Material Issues Line"."Unit of Measure Code")
                {
                }
                column(Desc2; Desc2)
                {
                }
                column(desc1; desc1)
                {
                }
                column(desc1_Control1000000056; desc1)
                {
                }
                column(Desc2_Control1000000070; Desc2)
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Unit_of_Measure_Code__Control1000000071; "Posted Material Issues Line"."Unit of Measure Code")
                {
                }
                column(Posted_Material_Issues_Line__Posted_Material_Issues_Line___Quantity__Base__; "Posted Material Issues Line"."Quantity (Base)")
                {
                }
                column(LOT; LOT)
                {
                }
                column(SERIAL; SERIAL)
                {
                }
                column(Posted_Material_Issues_Header___Resource_Name_; "Posted Material Issues Header"."Resource Name")
                {
                }
                column(Username; Username)
                {
                }
                column(Item_Count; Item_Count)
                {
                }
                column(Item_Count__Shortage_Items_; Item_Count - "Shortage Items")
                {
                }
                column(Shortage_Items_; "Shortage Items")
                {
                }
                column(ItemCaption; ItemCaptionLbl)
                {
                }
                column(Description_2Caption; Description_2CaptionLbl)
                {
                }
                column(UOMCaption; UOMCaptionLbl)
                {
                }
                column(QuantityCaption; QuantityCaptionLbl)
                {
                }
                column(Serial_NoCaption; Serial_NoCaptionLbl)
                {
                }
                column(Lot_NoCaption; Lot_NoCaptionLbl)
                {
                }
                column(ItemCaption_Control1000000017; ItemCaption_Control1000000017Lbl)
                {
                }
                column(Description_2Caption_Control1000000018; Description_2Caption_Control1000000018Lbl)
                {
                }
                column(UOMCaption_Control1000000019; UOMCaption_Control1000000019Lbl)
                {
                }
                column(QuantityCaption_Control1000000021; QuantityCaption_Control1000000021Lbl)
                {
                }
                column(Serial_NoCaption_Control1000000004; Serial_NoCaption_Control1000000004Lbl)
                {
                }
                column(Lot_NoCaption_Control1000000059; Lot_NoCaption_Control1000000059Lbl)
                {
                }
                column(Authrorised_byCaption; Authrorised_byCaptionLbl)
                {
                }
                column(Received_byCaption; Received_byCaptionLbl)
                {
                }
                column(Issued_byCaption; Issued_byCaptionLbl)
                {
                }
                column(Total_ItemsCaption; Total_ItemsCaptionLbl)
                {
                }
                column(Issued_itemsCaption; Issued_itemsCaptionLbl)
                {
                }
                column(Shortage_ItemsCaption; Shortage_ItemsCaptionLbl)
                {
                }
                column(Issues_Date_TimeCaption; Issues_Date_TimeCaptionLbl)
                {
                }
                column(Posted_Material_Issues_Line_Document_No_; "Document No.")
                {
                }
                column(Posted_Material_Issues_Line_Line_No_; "Line No.")
                {
                }
                column(Posted_Material_Issues_Line_Item_No_; "Item No.")
                {
                }
                column(Rem_Qty; Rem_Qty)
                {
                }
                column(MI_Qty; MI_Qty)
                {
                }
                column(PMI_Qty; PMI_Qty)
                {
                }
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Item No." = FIELD("Item No.");
                    DataItemTableView = SORTING("Document No.", "Item No.", "Posting Date") ORDER(Ascending) WHERE("Entry Type" = CONST(Transfer), Quantity = FILTER(> 0));
                    column(Item_Ledger_Entry__Serial_No__; "Serial No.")
                    {
                    }
                    column(desc1_Control1000000054; desc1)
                    {
                    }
                    column(Desc2_Control1000000025; Desc2)
                    {
                    }
                    column(Posted_Material_Issues_Line___Unit_of_Measure_Code_; "Posted Material Issues Line"."Unit of Measure Code")
                    {
                    }
                    column(Item_Ledger_Entry__Item_Ledger_Entry__Quantity; "Item Ledger Entry".Quantity)
                    {
                    }
                    column(Item_Ledger_Entry__Item_Ledger_Entry___Lot_No__; "Item Ledger Entry"."Lot No.")
                    {
                    }
                    column(Make; Make)
                    {
                    }
                    column(Item_Ledger_Entry__Item_No__; "Item No.")
                    {
                    }
                    column(vendor; vendor)
                    {
                    }
                    column(Posted_Material_Issues_Header___Prod__BOM_No__; "Posted Material Issues Header"."Prod. BOM No.")
                    {
                    }
                    column(Item_Ledger_Entry_Entry_No_; "Entry No.")
                    {
                    }
                    column(Item_Ledger_Entry_Document_No_; "Document No.")
                    {
                    }
                    column(BINAddrsIssues; BINAddrsIssues)
                    {
                    }
                    column(StockAddrsIssues; StockAddrsIssues)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        //Rev01

                        //Item Ledger Entry, Body (1) - OnPreSection()
                        /*
                        LOT:="Mat.Issue Track. Specification"."Lot No.";
                        SERIAL:="Mat.Issue Track. Specification"."Serial No.";
                        CurrReport.SHOWOUTPUT:=FALSE;
                        */
                        item.RESET;
                        item.SETRANGE(item."No.", "Posted Material Issues Line"."Item No.");
                        IF item.FIND('-') THEN
                            Desc2 := item."Description 2";

                        Make := '';
                        vendor := '';

                        PIDH.RESET;
                        PIDH.SETFILTER(PIDH."Item No.", "Posted Material Issues Line"."Item No.");
                        PIDH.SETFILTER(PIDH."Lot No.", "Item Ledger Entry"."Lot No.");
                        PIDH.SETFILTER(PIDH."Serial No.", "Serial No.");
                        IF PIDH.FINDFIRST THEN BEGIN
                            Make := PIDH.Make;
                            vendor := PIDH."Vendor Name";
                        END;
                        //Item Ledger Entry, Body (1) - OnPreSection()

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SLNO := SLNO + 1;
                    /*
                      ReservationEntry.SETRANGE("Source Type",DATABASE::"Item Journal Line");
                      ReservationEntry.SETRANGE("Source ID",'Transfer');
                      ReservationEntry.SETRANGE("Source Ref. No.","Line No.");
                      IF ReservationEntry.FIND('-') THEN;
                    */
                    BINAddrsIssues := '';
                    StockAddrsIssues := '';
                    //Rev01
                    /*
                    //Posted Material Issues Line, Header (1) - OnPreSection()
                    LOT:='';
                    SERIAL:='';
                    //Posted Material Issues Line, Header (1) - OnPreSection()
                    */
                    //Posted Material Issues Line, Body (3) - OnPreSection()
                    PMILineBody3 := TRUE;
                    desc1 := "Posted Material Issues Line".Description;
                    SERIAL := '';
                    LOT := '';
                    item.RESET;
                    item.SETRANGE(item."No.", "Posted Material Issues Line"."Item No.");
                    IF item.FIND('-') THEN BEGIN
                        Desc2 := item."Description 2";
                        BINAddrsIssues := item."BIN Address";
                        StockAddrsIssues := item."Stock Address";
                        // >> Pranavi on 29-07-2017
                        MI_Qty := 0;
                        PMI_Qty := 0;
                        Rem_Qty := 0;
                        MIL.RESET;
                        MIL.SETRANGE("Document No.", "Posted Material Issues Line"."Material Issue No.");
                        MIL.SETRANGE("Line No.", "Posted Material Issues Line"."Material Issue Line No.");
                        MIL.SETRANGE(MIL."Item No.", "Posted Material Issues Line"."Item No.");
                        IF MIL.FINDFIRST THEN
                            MI_Qty := MIL.Quantity;
                        PMIL.RESET;
                        PMIL.SETRANGE("Material Issue No.", "Posted Material Issues Line"."Material Issue No.");
                        PMIL.SETRANGE("Material Issue Line No.", "Posted Material Issues Line"."Material Issue Line No.");
                        PMIL.SETRANGE("Item No.", "Posted Material Issues Line"."Item No.");
                        IF PMIL.FINDSET THEN
                            REPEAT
                                PMI_Qty += PMIL.Quantity;
                            UNTIL PMIL.NEXT = 0;
                        IF MI_Qty = 0 THEN
                            MI_Qty := PMI_Qty;
                        Rem_Qty := MI_Qty - PMI_Qty;
                        // << Pranavi on 29-07-2017
                    END;
                    IF "Posted Material Issues Line".Quantity = 0 THEN BEGIN
                        "Shortage Items" += 1;
                    END
                    ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        PMILineBody3 := FALSE;

                    //Posted Material Issues Line, Body (3) - OnPreSection()

                end;

                trigger OnPostDataItem()
                begin
                    //Posted Material Issues Line, GroupFooter - OnPreSection()
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    IF Prev_Line <> "Posted Material Issues Line"."Line No." THEN BEGIN
                        PMILineGrupFoter := FALSE;
                        item.SETRANGE(item."No.", "Posted Material Issues Line"."Item No.");
                        IF item.FIND('-') THEN BEGIN
                            Desc2 := item."Description 2";
                            BINAddrsIssues := item."BIN Address";
                            StockAddrsIssues := item."Stock Address";
                            // >> Pranavi on 29-07-2017
                            MI_Qty := 0;
                            PMI_Qty := 0;
                            Rem_Qty := 0;
                            MIL.RESET;
                            MIL.SETRANGE("Document No.", "Posted Material Issues Line"."Material Issue No.");
                            MIL.SETRANGE("Line No.", "Posted Material Issues Line"."Material Issue Line No.");
                            MIL.SETRANGE(MIL."Item No.", "Posted Material Issues Line"."Item No.");
                            IF MIL.FINDFIRST THEN
                                MI_Qty := MIL.Quantity;
                            PMIL.RESET;
                            PMIL.SETRANGE("Material Issue No.", "Posted Material Issues Line"."Material Issue No.");
                            PMIL.SETRANGE("Material Issue Line No.", "Posted Material Issues Line"."Material Issue Line No.");
                            PMIL.SETRANGE("Item No.", "Posted Material Issues Line"."Item No.");
                            IF PMIL.FINDSET THEN
                                REPEAT
                                    PMI_Qty += PMIL.Quantity;
                                UNTIL PMIL.NEXT = 0;
                            IF MI_Qty = 0 THEN
                                MI_Qty := PMI_Qty;
                            Rem_Qty := MI_Qty - PMI_Qty;
                            // << Pranavi on 29-07-2017
                        END;
                        Prev_Line := "Posted Material Issues Line"."Line No."; //swathi
                    END;
                    //Posted Material Issues Line, GroupFooter - OnPreSection()


                    //Posted Material Issues Line, Footer (6) - OnPreSection()
                    User.RESET;
                    User.SETRANGE("User Name", USERID);
                    //IF User.GET(USERID) THEN BEGIN
                    IF User.FINDFIRST THEN
                        Username := User."User Name";
                    //END;
                    //Posted Material Issues Line, Footer (6) - OnPreSection()
                end;

                trigger OnPreDataItem()
                begin
                    SLNO := 0;
                    IF Choice <> Choice::Issue THEN
                        CurrReport.BREAK;
                    Item_Count := "Posted Material Issues Line".COUNT;

                    //Posted Material Issues Line, Header (1) - OnPreSection()
                    LOT := '';
                    SERIAL := '';
                    //Posted Material Issues Line, Header (1) - OnPreSection()
                    BINAddrsIssues := '';
                    StockAddrsIssues := '';
                end;
            }

            trigger OnAfterGetRecord()
            begin

                IF Choice <> Choice::Issue THEN BEGIN
                    Cnt += 1;
                    IF Cnt = 2 THEN
                        CurrReport.BREAK;
                END;
                //IF STRLEN("order no's")<12 THEN
                //  "order no's"+=FORMAT("Posted Material Issues Header"."Material Issue No.")+'..';
                CompanyInfo.GET();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                IF CompanyInfo.FIND('-') THEN
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                REQ_By := "Posted Material Issues Header"."Resource Name";

                //Rev01

                // Added by Rakesh to get all Prod. Orders in Print on 9-Aug-14
                Prod_codes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");
                IF Choice = Choice::Issue THEN
                    Prod_codes := "Posted Material Issues Header"."Prod. Order No.";
                //end by Rakesh

                //Posted Material Issues Header, Header (1 - OnPreSection()
                //CurrReport.SHOWOUTPUT(Choice=Choice::Issue);swathi code error for nav13
                //Posted Material Issues Header, Header (1 - OnPreSection()


                //Posted Material Issues Header, Header (2 - OnPreSection()
                //CurrReport.SHOWOUTPUT(Choice=Choice::Sets);swathi code error for nav13
                IF Choice = Choice::Sets THEN
                    PMIH2 := TRUE;
                sets_no := 0;
                POL.RESET;//sundar
                POL.SETRANGE(POL."Prod. Order No.", "Posted Material Issues Header"."Prod. Order No.");
                POL.SETRANGE(POL."Line No.", "Posted Material Issues Header"."Prod. Order Line No.");
                Compound1 := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No.");
                IF Compound1 <> '' THEN BEGIN
                    COdes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");
                    POL.RESET;
                    POL.SETFILTER(POL."Prod. Order No.", COdes);
                    POL.SETRANGE(POL."Production BOM No.", Compound1);
                    IF POL.FIND('-') THEN
                        REPEAT
                            sets_no += POL.Quantity;
                        UNTIL POL.NEXT = 0;
                    SET_Header := 'Material Sets ' + '"' + POL.Description + '"' + '-' + FORMAT(sets_no);
                END ELSE BEGIN
                    IF POL.FIND('-') THEN
                        SET_Header := 'Material Sets ' + '"' + POL.Description + '"' + '-' + FORMAT("Posted Material Issues Header".COUNT);
                END;

                //Posted Material Issues Header, Header (2 - OnPreSection()


                //Posted Material Issues Header, Header (3 - OnPreSection()
                IF Choice = Choice::Issue THEN //CurrReport.SHOWOUTPUT(Choice=Choice::Issue); swathi
                    PMIH3 := FALSE;
                PO.SETRANGE(PO."Prod. Order No.", "Posted Material Issues Header"."Prod. Order No.");
                PO.SETFILTER(PO."Line No.", FORMAT("Posted Material Issues Header"."Prod. Order Line No."));
                IF PO.FIND('-') THEN
                    COmpound_desc := PO.Description;

                //Posted Material Issues Header, Header (3 - OnPreSection()
                Resource := "Posted Material Issues Header"."Resource Name" + '(' + "Posted Material Issues Header"."Released By" + ')';
                //Added By Pranavi on 23-08-2015 for Locations code to issues print
                LocationsCode := '';
                dimValue.RESET;
                dimValue.SETFILTER(dimValue."Dimension Code", 'LOCATIONS'); //added by vishnu priya on 18-03-2020
                dimValue.SETRANGE(dimValue.Code, "Posted Material Issues Header"."Shortcut Dimension 2 Code");
                IF dimValue.FINDFIRST THEN
                    LocationsCode := "Posted Material Issues Header"."Shortcut Dimension 2 Code" + '-' + dimValue.Name
                ELSE
                    LocationsCode := "Posted Material Issues Header"."Shortcut Dimension 2 Code";
                //End by Pranavi
            end;

            trigger OnPostDataItem()
            begin

                "order no's" += FORMAT("Posted Material Issues Header"."Material Issue No.");
            end;

            trigger OnPreDataItem()
            begin
                IF Choice = Choice::Sets THEN BEGIN
                    PostMaterialQry.SETFILTER(PostMaterialQry.Prod_Order_No, "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No."));
                    PostMaterialQry.SETFILTER(PostMaterialQry.Prod_Order_Line_No, "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order Line No."));
                    PostMaterialQry.SETFILTER(PostMaterialQry.Prod_BOM_No, "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No."));
                END;
            end;
        }
        dataitem("<Item Ledger Entry1>"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Item No.", "Lot No.", "ITL Doc No.") ORDER(Ascending) WHERE("Entry Type" = CONST(Transfer), "Location Code" = CONST('STR'));
            RequestFilterFields = "Item No.";
            column(ILE1_Choice; Choice)
            {
            }
            column(ILE1Body6; ILE1Body6)
            {
            }
            column(ILE1Body7; ILE1Body7)
            {
            }
            column(ILE1GrupFooter11; ILE1GrupFooter11)
            {
            }
            column(ILE1GrupFooter12; ILE1GrupFooter12)
            {
            }
            column(ILE1_Lot_No__; "Lot No.")
            {
            }
            column(REQ_By; REQ_By)
            {
            }
            column(Posted_Material_Issues_Header___Released_Date_; "Posted Material Issues Header"."Released Date")
            {
            }
            column(Posted_Material_Issues_Header___Transfer_to_Code_; "Posted Material Issues Header"."Transfer-to Code")
            {
            }
            column(Posted_Material_Issues_Header___Issued_DateTime_; "Posted Material Issues Header"."Issued DateTime")
            {
            }
            column(Posted_Material_Issues_Header___Released_By_; "Posted Material Issues Header"."Released By")
            {
            }
            column(Store; Store)
            {
            }
            column(Prod__Orders_; "Prod. Orders")
            {
            }
            column(Ser_No_; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No__; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code_; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count_; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Item_Ledger_Entry1___Quantity_; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Desc2_Control1102152120; Desc2)
            {
            }
            column(Item_Desc; Item_Desc)
            {
            }
            column(Store_Control1102152126; Store)
            {
            }
            column(Prod__Orders__Control1102152128; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102152130; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102152132; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102152134; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102152136; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102152138; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Desc2_Control1102152140; Desc2)
            {
            }
            column(Item_Desc_Control1102152141; Item_Desc)
            {
            }
            column(Store_Control1102152146; Store)
            {
            }
            column(Prod__Orders__Control1102152147; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102152149; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102152151; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102152154; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102152156; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102152158; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Desc2_Control1102152160; Desc2)
            {
            }
            column(Item_Desc_Control1102152162; Item_Desc)
            {
            }
            column(Store_Control1102152166; Store)
            {
            }
            column(Prod__Orders__Control1102152167; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102152169; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102152172; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102152174; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102152176; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102152178; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Desc2_Control1102152181; Desc2)
            {
            }
            column(Item_Desc_Control1102152183; Item_Desc)
            {
            }
            column(Store_Control1102152187; Store)
            {
            }
            column(Prod__Orders__Control1102152189; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102152191; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102152193; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102152195; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102152197; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102152198; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Desc2_Control1102152201; Desc2)
            {
            }
            column(Item_Desc_Control1102152203; Item_Desc)
            {
            }
            column(Prod__Orders__Control1102154048; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154049; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154050; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154051; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154052; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154060; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Desc2_Control1102154073; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154061; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152003; Store)
            {
            }
            column(Prod__Orders__Control1102154149; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154150; "Ser No")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154152; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154153; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154161; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154105; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Desc2_Control1102154168; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154065; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152000; Store)
            {
            }
            column(Prod__Orders__Control1102154133; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154134; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154135; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154136; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154137; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154145; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Desc2_Control1102154169; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154098; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152013; Store)
            {
            }
            column(Prod__Orders__Control1102154117; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154118; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154119; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154120; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154121; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154129; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Desc2_Control1102154170; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154130; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152005; Store)
            {
            }
            column(Prod__Orders__Control1102154075; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154076; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154077; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154085; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154086; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154097; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Desc2_Control1102154171; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154146; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152006; Store)
            {
            }
            column(Prod__Orders__Control1102154040; "Prod. Orders")
            {
            }
            column(Ser_No__Control1102154041; "Ser No")
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Lot_No___Control1102154042; "<Item Ledger Entry1>"."Lot No.")
            {
            }
            column(Item_Ledger_Entry1___Quantity__Control1102154043; -("<Item Ledger Entry1>".Quantity))
            {
            }
            column(Item_Desc_Control1102154044; Item_Desc)
            {
            }
            column(Item_Ledger_Entry1____Item_Ledger_Entry1____Unit_of_Measure_Code__Control1102154108; "<Item Ledger Entry1>"."Unit of Measure Code")
            {
            }
            column(Desc2_Control1102154184; Desc2)
            {
            }
            column(Item_Ledger_Entry1___Quantity_Rec_Count__Control1102154185; -("<Item Ledger Entry1>".Quantity / Rec_Count))
            {
            }
            column(Store_Control1102152007; Store)
            {
            }
            column(Requisition_NoCaption_Control1102154001; Requisition_NoCaption_Control1102154001Lbl)
            {
            }
            column(Requested__By_Caption_Control1102154003; Requested__By_Caption_Control1102154003Lbl)
            {
            }
            column(Requested__Date___TImeCaption; Requested__Date___TImeCaptionLbl)
            {
            }
            column(DepartmentCaption; DepartmentCaptionLbl)
            {
            }
            column(Project_CodesCaption; Project_CodesCaptionLbl)
            {
            }
            column(Issued_Date___TimeCaption; Issued_Date___TimeCaptionLbl)
            {
            }
            column(EmptyStringCaption_Control1102154175; EmptyStringCaption_Control1102154175Lbl)
            {
            }
            column(EmptyStringCaption_Control1102154176; EmptyStringCaption_Control1102154176Lbl)
            {
            }
            column(Production_OrdersCaption; Production_OrdersCaptionLbl)
            {
            }
            column(Serial_No_Caption; Serial_No_CaptionLbl)
            {
            }
            column(LOT_NOCaption_Control1102154018; LOT_NOCaption_Control1102154018Lbl)
            {
            }
            column(ItemCaption_Control1102154019; ItemCaption_Control1102154019Lbl)
            {
            }
            column(QTY_Set_Caption; QTY_Set_CaptionLbl)
            {
            }
            column(UOMCaption_Control1102154029; UOMCaption_Control1102154029Lbl)
            {
            }
            column(QTYCaption; QTYCaptionLbl)
            {
            }
            column(Description_2Caption_Control1102154072; Description_2Caption_Control1102154072Lbl)
            {
            }
            column(LocationCaption; LocationCaptionLbl)
            {
            }
            column(Item_Ledger_Entry1__Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                /*
                 //<Item Ledger Entry1>, GroupHeader (4) - OnPreSection()
                 IF  Prev_Lot <> "<Item Ledger Entry1>"."Lot No." THEN BEGIN
                 "Ser No":='';
                 FOR i:=1 TO 20 DO
                   Prd_Ar[i]:='';
                   "Prod. Orders":='';
                 Ar_Len:=1;
                 Rec_Count:=0;
                 Prev_Lot:="<Item Ledger Entry1>"."Lot No.";
                 END;
                 //<Item Ledger Entry1>, GroupHeader (4) - OnPreSection()


                 R:=0;
                 IF Compound1<>'' THEN
                 BEGIN
                   POL1.RESET;
                   POL1.SETFILTER(POL1."Prod. Order No.","<Item Ledger Entry1>"."ITL Doc No.");
                   POL1.SETFILTER(POL1."Item No.",Compound1);
                   IF POL1.FINDFIRST THEN
                   BEGIN
                     IF POL1."Line No."<>"<Item Ledger Entry1>"."ITL Doc Line No." THEN
                        R:=5;
                   END
                   ELSE
                     R:=5;
                 END;

                 Temp:="<Item Ledger Entry1>"."Lot No.";
                 IF LOT1='' THEN
                   LOT1:="<Item Ledger Entry1>"."Lot No."
                 ELSE IF LOT1<>"<Item Ledger Entry1>"."Lot No." THEN
                 BEGIN
                   LOT1:="<Item Ledger Entry1>"."Lot No.";
                   "Prod. Orders":='';
                   "Ser No":='';
                 END;
                 IF Item_Temp<>"<Item Ledger Entry1>"."Item No." THEN
                 BEGIN
                 Item_Temp:="<Item Ledger Entry1>"."Item No.";
                 Item_Count+=1;
                 END;

               //<Item Ledger Entry1>, Body (5) - OnPreSection()
                IF item.GET("<Item Ledger Entry1>"."Item No.") THEN
                BEGIN
                 Rec_Count+=1;
                 //shelf:=item."Shelf No.";
                 Available:=FALSE;
                 IF item."Product Group Code"='PCB' THEN
                 BEGIN
                  IF Ar_Len=1 THEN
                  BEGIN
                    Prd_Ar[Ar_Len]:=FORMAT("<Item Ledger Entry1>"."ITL Doc No.");
                    Ar_Len+=1;
                  END ELSE BEGIN

                    FOR i:=1 TO Ar_Len DO
                    BEGIN
                      IF Prd_Ar[i]="<Item Ledger Entry1>"."ITL Doc No." THEN
                       Available:=TRUE;
                    END;
                    IF NOT Available THEN
                    BEGIN

                      Ar_Len+=1;
                      Prd_Ar[Ar_Len]:=FORMAT("<Item Ledger Entry1>"."ITL Doc No.");

                    END;
                   END;

                 // "Prod. Orders"+=FORMAT("<Item Ledger Entry1>"."ITL Doc No.")+' ,';
                  IF STRLEN(OH)>40 THEN
                  BEGIN

                    "Ser No":="Ser No"+FORMAT("<Item Ledger Entry1>"."Serial No.")+','+' ';
                     OH:='';
                  END ELSE
                  BEGIN
                    "Ser No":="Ser No"+FORMAT("<Item Ledger Entry1>"."Serial No.")+',';
                    OH +=FORMAT("<Item Ledger Entry1>"."Serial No.")+',';

                  END;
                 END;
                END;
               //<Item Ledger Entry1>, Body (5) - OnPreSection()

               //<Item Ledger Entry1>, Body (6) - OnPreSection()

                 IF (Compound1<>'') AND (R<>5) THEN
                 BEGIN
                   PRDSTR_QTY:=0;
                   IF item.GET("<Item Ledger Entry1>"."Item No.") THEN
                   BEGIN
                     Item_Desc:=item.Description;
                     Desc2:=item."Description 2";
                   END;
                   temp1:=0;
                   b:=1;
                   c:=0;
                   d:=0;
                   REPEAT
                     IF "<Item Ledger Entry1>"."Item No."= DETAILS[b][9] THEN
                     BEGIN
                       IF DETAILS[b][5]= "<Item Ledger Entry1>"."Lot No." THEN
                       BEGIN
                         Quantity_Set[b]:=Quantity_Set[b]+"<Item Ledger Entry1>".Quantity;
                         DETAILS[b][3]:=FORMAT(ABS(Quantity_Set[b]));
                         IF item."Item Tracking Code"<>'LOT' THEN
                         BEGIN
                           DETAILS[b][6]:=DETAILS[b][6]+','+ "<Item Ledger Entry1>"."Serial No.";
                           DETAILS[b][7]:= DETAILS[b][7]+','+"<Item Ledger Entry1>"."ITL Doc No.";
                         END;
                         temp1:=b;
                         b:=a;
                         c:=10;
                       END;
                     END;
                     b:=b+1;
                   UNTIL b>=a;
                   IF c=0 THEN
                   BEGIN
                     DETAILS[a][1]:= Item_Desc;
                     DETAILS[a][2]:= Desc2;
                     Quantity_Set[a]:= "<Item Ledger Entry1>".Quantity;
                     DETAILS[a][3]:=FORMAT(ABS(Quantity_Set[a]));
                     DETAILS[a][4]:= "<Item Ledger Entry1>"."Unit of Measure Code";
                     DETAILS[a][5]:= "<Item Ledger Entry1>"."Lot No.";
                     IF item."Item Tracking Code"<>'LOT' THEN
                     BEGIN
                       DETAILS[a][6]:= "<Item Ledger Entry1>"."Serial No.";
                       DETAILS[a][7]:= "<Item Ledger Entry1>"."ITL Doc No.";
                     END;
                     DETAILS[a][8]:=FORMAT(1);
                     DETAILS[a][9]:="<Item Ledger Entry1>"."Item No.";
                   END;


                   ILE.RESET;
                   ILE.SETCURRENTKEY("Item No.","Lot No.",ILE."ITL Doc No.");
                   ILE.SETFILTER("Lot No.","<Item Ledger Entry1>"."Lot No.");
                   ILE.SETFILTER("Item No.","<Item Ledger Entry1>"."Item No.");
                   ILE.SETFILTER(ILE."ITL Doc No.",'EFF11STR01');
                   ILE.SETFILTER(ILE."Posting Date",'%1..%2',"<Item Ledger Entry1>"."Posting Date"-1,"<Item Ledger Entry1>"."Posting Date");
                   ILE.SETFILTER(ILE."Location Code",'PRODSTR');
                   ILE.SETFILTER(ILE.Quantity,'<%1',0);
                   IF ILE.FINDSET THEN
                   BEGIN
                     Store:='PRODSTR';
                     REPEAT
                       PRDSTR_QTY:=PRDSTR_QTY+ILE.Quantity;
                     UNTIL ILE.NEXT =0;
                   END
                   ELSE
                     Store:='STR';
                   IF Store='PRODSTR' THEN
                   BEGIN
                     IF (-1*PRDSTR_QTY) > (-1*"<Item Ledger Entry1>".Quantity) THEN
                     BEGIN
                       Store:=Store+FORMAT("<Item Ledger Entry1>".Quantity);
                       d:="<Item Ledger Entry1>".Quantity;
                     END
                     ELSE
                     BEGIN
                       Store:=Store+FORMAT(PRDSTR_QTY);
                       d:=PRDSTR_QTY;
                     END;
                   END;
                   IF c=0 THEN
                   BEGIN
                     Prod_Str_Stock[a]:=d;
                     a:=a+1;
                   END
                   ELSE
                     Prod_Str_Stock[temp1]+=d;
                     CurrReport.SHOWOUTPUT:=FALSE;
                 END
                 ELSE
                 CurrReport.SHOWOUTPUT:=FALSE;

               //<Item Ledger Entry1>, Body (6) - OnPreSection()
               */


                //Not valid

                R := 0;
                IF Compound1 <> '' THEN BEGIN
                    POL1.RESET;
                    POL1.SETFILTER(POL1."Prod. Order No.", "<Item Ledger Entry1>"."ITL Doc No.");
                    POL1.SETFILTER(POL1."Item No.", Compound1);
                    IF POL1.FINDFIRST THEN BEGIN
                        IF POL1."Line No." <> "<Item Ledger Entry1>"."ITL Doc Line No." THEN
                            R := 5;
                    END
                    ELSE
                        R := 5;
                END;


                Temp := "<Item Ledger Entry1>"."Lot No.";
                IF LOT1 = '' THEN
                    LOT1 := "<Item Ledger Entry1>"."Lot No."
                ELSE
                    IF LOT1 <> "<Item Ledger Entry1>"."Lot No." THEN BEGIN
                        LOT1 := "<Item Ledger Entry1>"."Lot No.";
                        "Prod. Orders" := '';
                        "Ser No" := '';
                    END;
                IF Item_Temp <> "<Item Ledger Entry1>"."Item No." THEN BEGIN
                    Item_Temp := "<Item Ledger Entry1>"."Item No.";
                    Item_Count += 1;
                END;

                //Rev01
                /*
                //<Item Ledger Entry1>, Header (2) - OnPreSection()
                PO.SETRANGE(PO."Prod. Order No.","Posted Material Issues Header"."Prod. Order No.");
                PO.SETFILTER(PO."Line No.",FORMAT("Posted Material Issues Header"."Prod. Order Line No."));
                IF PO.FIND('-') THEN
                  "PCB Description":=PO.Description;
                //<Item Ledger Entry1>, Header (2) - OnPreSection()
                
                //<Item Ledger Entry1>, GroupHeader (4) - OnPreSection()
                IF  Prev_Lot <> "<Item Ledger Entry1>"."Lot No." THEN BEGIN //swathi
                "Ser No":='';
                FOR i:=1 TO 20 DO
                  Prd_Ar[i]:='';
                  "Prod. Orders":='';
                Ar_Len:=1;
                Rec_Count:=0;
                Prev_Lot:="<Item Ledger Entry1>"."Lot No.";
                END;
                //<Item Ledger Entry1>, GroupHeader (4) - OnPreSection()
                */
                //<Item Ledger Entry1>, Body (5) - OnPreSection()
                IF item.GET("<Item Ledger Entry1>"."Item No.") THEN BEGIN
                    Rec_Count += 1;
                    //shelf:=item."Shelf No.";
                    Available := FALSE;
                    IF item."Product Group Code Cust" = 'PCB' THEN BEGIN
                        IF Ar_Len = 1 THEN BEGIN
                            Prd_Ar[Ar_Len] := FORMAT("<Item Ledger Entry1>"."ITL Doc No.");
                            Ar_Len += 1;
                        END ELSE BEGIN
                            FOR i := 1 TO Ar_Len DO BEGIN
                                IF Prd_Ar[i] = "<Item Ledger Entry1>"."ITL Doc No." THEN
                                    Available := TRUE;
                            END;
                            IF NOT Available THEN BEGIN
                                Ar_Len += 1;
                                Prd_Ar[Ar_Len] := FORMAT("<Item Ledger Entry1>"."ITL Doc No.");

                            END;
                        END;
                        // "Prod. Orders"+=FORMAT("<Item Ledger Entry1>"."ITL Doc No.")+' ,';
                        IF STRLEN(OH) > 40 THEN BEGIN
                            "Ser No" := "Ser No" + FORMAT("<Item Ledger Entry1>"."Serial No.") + ',' + ' ';
                            OH := '';
                        END ELSE BEGIN
                            "Ser No" := "Ser No" + FORMAT("<Item Ledger Entry1>"."Serial No.") + ',';
                            OH += FORMAT("<Item Ledger Entry1>"."Serial No.") + ',';
                        END;
                    END;
                END;
                //<Item Ledger Entry1>, Body (5) - OnPreSection()

                //<Item Ledger Entry1>, Body (6) - OnPreSection()
                ILE1Body6 := TRUE;
                IF (Compound1 <> '') AND (R <> 5) THEN BEGIN
                    ILE1Body6 := TRUE;
                    PRDSTR_QTY := 0;
                    IF item.GET("<Item Ledger Entry1>"."Item No.") THEN BEGIN
                        Item_Desc := item.Description;
                        Desc2 := item."Description 2";
                    END;
                    temp1 := 0;
                    b := 1;
                    c := 0;
                    d := 0;
                    REPEAT
                        IF "<Item Ledger Entry1>"."Item No." = DETAILS[b] [9] THEN BEGIN
                            IF DETAILS[b] [5] = "<Item Ledger Entry1>"."Lot No." THEN BEGIN
                                Quantity_Set[b] := Quantity_Set[b] + "<Item Ledger Entry1>".Quantity;
                                DETAILS[b] [3] := FORMAT(ABS(Quantity_Set[b]));
                                IF item."Item Tracking Code" <> 'LOT NO' THEN BEGIN
                                    DETAILS[b] [6] := DETAILS[b] [6] + ',' + "<Item Ledger Entry1>"."Serial No.";
                                    DETAILS[b] [7] := DETAILS[b] [7] + ',' + "<Item Ledger Entry1>"."ITL Doc No.";
                                END;
                                /*
                                IF EVALUATE(sets_no,DETAILS[b][8]) THEN
                                DETAILS[b][8]:=FORMAT(sets_no+1);
                                */
                                temp1 := b;
                                b := a;
                                c := 10;
                            END;
                        END;
                        b := b + 1;
                    UNTIL b >= a;
                    IF c = 0 THEN BEGIN
                        DETAILS[a] [1] := Item_Desc;
                        DETAILS[a] [2] := Desc2;
                        Quantity_Set[a] := "<Item Ledger Entry1>".Quantity;
                        DETAILS[a] [3] := FORMAT(ABS(Quantity_Set[a]));
                        DETAILS[a] [4] := "<Item Ledger Entry1>"."Unit of Measure Code";
                        DETAILS[a] [5] := "<Item Ledger Entry1>"."Lot No.";
                        IF item."Item Tracking Code" <> 'LOT NO' THEN BEGIN
                            DETAILS[a] [6] := "<Item Ledger Entry1>"."Serial No.";
                            DETAILS[a] [7] := "<Item Ledger Entry1>"."ITL Doc No.";
                        END;
                        DETAILS[a] [8] := FORMAT(1);
                        DETAILS[a] [9] := "<Item Ledger Entry1>"."Item No.";
                    END;

                    ILE.RESET;
                    ILE.SETCURRENTKEY("Item No.", "Lot No.", ILE."ITL Doc No.");
                    ILE.SETFILTER("Lot No.", "<Item Ledger Entry1>"."Lot No.");
                    ILE.SETFILTER("Item No.", "<Item Ledger Entry1>"."Item No.");
                    ILE.SETFILTER(ILE."ITL Doc No.", 'EFF11STR01');
                    ILE.SETFILTER(ILE."Posting Date", '%1..%2', "<Item Ledger Entry1>"."Posting Date" - 1, "<Item Ledger Entry1>"."Posting Date");
                    ILE.SETFILTER(ILE."Location Code", 'PRODSTR');
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    IF ILE.FINDSET THEN BEGIN
                        Store := 'PRODSTR';
                        REPEAT
                            PRDSTR_QTY := PRDSTR_QTY + ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                    END ELSE
                        Store := 'STR';
                    IF Store = 'PRODSTR' THEN BEGIN
                        IF (-1 * PRDSTR_QTY) > (-1 * "<Item Ledger Entry1>".Quantity) THEN BEGIN
                            Store := Store + FORMAT("<Item Ledger Entry1>".Quantity);
                            d := "<Item Ledger Entry1>".Quantity;
                        END ELSE BEGIN
                            Store := Store + FORMAT(PRDSTR_QTY);
                            d := PRDSTR_QTY;
                        END;
                    END;
                    IF c = 0 THEN BEGIN
                        Prod_Str_Stock[a] := d;
                        a := a + 1;
                    END ELSE
                        Prod_Str_Stock[temp1] += d;
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ILE1Body6 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ILE1Body6 := FALSE;

                //<Item Ledger Entry1>, Body (6) - OnPreSection()


                //<Item Ledger Entry1>, Body (7) - OnPreSection()
                ILE1Body7 := TRUE;
                IF (Compound1 <> '') AND (R <> 5) THEN BEGIN
                    IF item.GET("<Item Ledger Entry1>"."Item No.") THEN BEGIN
                        Item_Desc := item.Description;
                        Desc2 := item."Description 2";
                        IF item."Item Tracking Code" = 'LOT NO' THEN
                            ILE1Body7 := FALSE;  //CurrReport.SHOWOUTPUT:=FALSE;

                        "Prod. Orders" := '';
                        FOR i := 1 TO Ar_Len DO
                            "Prod. Orders" += Prd_Ar[i] + ' ,';

                    END;

                    //CurrReport.SHOWOUTPUT((STRLEN("Ser No")<=40 ) AND ( item."Item Tracking Code"='LOTSERIAL' )) ;

                    // CurrReport.SHOWOUTPUT:=FALSE;
                    ILE.RESET;
                    ILE.SETCURRENTKEY("Item No.", "Lot No.", ILE."ITL Doc No.");
                    ILE.SETFILTER("Lot No.", "<Item Ledger Entry1>"."Lot No.");
                    ILE.SETFILTER("Item No.", "<Item Ledger Entry1>"."Item No.");
                    ILE.SETFILTER(ILE."ITL Doc No.", 'EFF11STR01');
                    ILE.SETFILTER(ILE."Posting Date", '%1..%2', "<Item Ledger Entry1>"."Posting Date" - 1, "<Item Ledger Entry1>"."Posting Date");
                    ILE.SETFILTER(ILE."Location Code", 'PRODSTR');
                    ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                    IF ILE.FINDSET THEN BEGIN
                        Store := 'PRODSTR';
                        REPEAT
                            PRDSTR_QTY := PRDSTR_QTY + ILE.Quantity;
                        UNTIL ILE.NEXT = 0;
                    END ELSE
                        Store := 'STR';

                    IF Store = 'PRODSTR' THEN BEGIN
                        IF (-1 * PRDSTR_QTY) > (-1 * "<Item Ledger Entry1>".Quantity) THEN
                            Store := Store + FORMAT("<Item Ledger Entry1>".Quantity)
                        ELSE
                            Store := Store + FORMAT(PRDSTR_QTY);
                    END;
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ILE1Body7 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ILE1Body7 := FALSE;
                //<Item Ledger Entry1>, Body (7) - OnPreSection()

                //<Item Ledger Entry1>, GroupFooter (11) - OnPreSection()
                IF Prev_Lot <> "<Item Ledger Entry1>"."Lot No." THEN BEGIN
                    ILE1GrupFooter11 := TRUE;
                    IF Compound1 = '' THEN BEGIN
                        PRDSTR_QTY := 0;
                        IF item.GET("<Item Ledger Entry1>"."Item No.") THEN BEGIN
                            Item_Desc := item.Description;
                            Desc2 := item."Description 2";
                            IF item."Item Tracking Code" = 'LOTSERIAL' THEN
                                //CurrReport.SHOWOUTPUT:=FALSE;
                                ILE1GrupFooter11 := FALSE;
                        END;
                        ILE.RESET;
                        ILE.SETCURRENTKEY("Item No.", "Lot No.", ILE."ITL Doc No.");
                        ILE.SETFILTER("Lot No.", "<Item Ledger Entry1>"."Lot No.");
                        ILE.SETFILTER("Item No.", "<Item Ledger Entry1>"."Item No.");
                        ILE.SETFILTER(ILE."ITL Doc No.", 'EFF11STR01');
                        ILE.SETFILTER(ILE."Posting Date", '%1..%2', "<Item Ledger Entry1>"."Posting Date" - 1, "<Item Ledger Entry1>"."Posting Date");
                        ILE.SETFILTER(ILE."Location Code", 'PRODSTR');
                        ILE.SETFILTER(ILE.Quantity, '<%1', 0);
                        IF ILE.FINDSET THEN BEGIN
                            Store := 'PRODSTR';
                            REPEAT
                                PRDSTR_QTY := PRDSTR_QTY + ILE.Quantity;
                            UNTIL ILE.NEXT = 0;
                        END ELSE
                            Store := 'STR';
                        IF Store = 'PRODSTR' THEN BEGIN
                            IF (-1 * PRDSTR_QTY) > (-1 * "<Item Ledger Entry1>".Quantity) THEN
                                Store := Store + FORMAT(ROUND("<Item Ledger Entry1>".Quantity, 2))
                            ELSE
                                Store := Store + FORMAT(ROUND(PRDSTR_QTY, 2));
                        END;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ILE1GrupFooter11 := FALSE;
                END;//swathi
                    //<Item Ledger Entry1>, GroupFooter (11) - OnPreSection()
                    /*
                   //<Item Ledger Entry1>, GroupFooter (12) - OnPreSection()
                   ILE1GrupFooter12 := TRUE;
                   IF Compound1='' THEN BEGIN
                     IF item.GET("<Item Ledger Entry1>"."Item No.") THEN BEGIN
                       Item_Desc:=item.Description;
                       Desc2:=item."Description 2";
                       IF item."Item Tracking Code"='LOT' THEN
                         //CurrReport.SHOWOUTPUT:=FALSE;
                         ILE1GrupFooter12 := FALSE;
                         "Prod. Orders":='';
                         FOR i:=1 TO Ar_Len DO
                          "Prod. Orders"+=Prd_Ar[i]+' ,';

                     END;
                   //CurrReport.SHOWOUTPUT((STRLEN("Ser No")<=40 ) AND ( item."Item Tracking Code"='LOTSERIAL' )) ;

                    // CurrReport.SHOWOUTPUT:=FALSE;
                     ILE.RESET;
                     ILE.SETCURRENTKEY("Item No.","Lot No.",ILE."ITL Doc No.");
                     ILE.SETFILTER("Lot No.","<Item Ledger Entry1>"."Lot No.");
                     ILE.SETFILTER("Item No.","<Item Ledger Entry1>"."Item No.");
                     ILE.SETFILTER(ILE."ITL Doc No.",'EFF11STR01');
                     ILE.SETFILTER(ILE."Posting Date",'%1..%2',"<Item Ledger Entry1>"."Posting Date"-1,"<Item Ledger Entry1>"."Posting Date");
                     ILE.SETFILTER(ILE."Location Code",'PRODSTR');
                     ILE.SETFILTER(ILE.Quantity,'<%1',0);
                     IF ILE.FINDSET THEN BEGIN
                       Store:='PRODSTR';
                       REPEAT
                         PRDSTR_QTY:=PRDSTR_QTY+ILE.Quantity;
                       UNTIL ILE.NEXT =0;
                     END ELSE
                     Store:='STR';
                     IF Store='PRODSTR' THEN BEGIN
                       IF (-1*PRDSTR_QTY) > (-1*"<Item Ledger Entry1>".Quantity) THEN
                          Store:=Store+FORMAT("<Item Ledger Entry1>".Quantity)
                       ELSE
                         Store:=Store+FORMAT(PRDSTR_QTY);
                     END;
                   END ELSE
                     //CurrReport.SHOWOUTPUT:=FALSE;
                     ILE1GrupFooter12 := FALSE;

                   //MESSAGE('%1',Store);
                     */
                    //Not Valid

            end;

            trigger OnPostDataItem()
            begin
                b := 0;
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Sets THEN
                    CurrReport.BREAK;

                COdes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");
                IF COdes <> '' THEN
                    "<Item Ledger Entry1>".SETFILTER("<Item Ledger Entry1>"."ITL Doc No.", COdes);

                Compound := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order Line No.");
                IF Compound <> '' THEN
                    "<Item Ledger Entry1>".SETFILTER("<Item Ledger Entry1>"."ITL Doc Line No.", Compound);
                /*
                 IF "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No.") <>'' THEN
                 BEGIN
                   PMIH.RESET;
                   PMIH.COPYFILTERS("Posted Material Issues Header");
                   IF PMIH.FINDFIRST THEN
                   REPEAT
                     IF com='' THEN
                       com:=PMIH."No."
                     ELSE
                       com:=com+'|'+PMIH."No.";
                   UNTIL PMIH.NEXT=0;
                   "<Item Ledger Entry1>".RESET;
                   "<Item Ledger Entry1>".SETFILTER("<Item Ledger Entry1>"."Document No.",com);
                 END;

                 */
                IF Not_Consider_Pcb THEN
                    "<Item Ledger Entry1>".SETFILTER("<Item Ledger Entry1>"."Item Category Code", '<>%1', 'PCB');
                IF Only_Pcb THEN
                    "<Item Ledger Entry1>".SETFILTER("<Item Ledger Entry1>"."Item Category Code", 'PCB');
                Cnt := "<Item Ledger Entry1>".COUNT;

                Item_Temp := "<Item Ledger Entry1>"."Item No.";
                Compound1 := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No.");
                a := 1;

                //swathi
                //<Item Ledger Entry1>, Header (2) - OnPreSection()
                PO.SETRANGE(PO."Prod. Order No.", "Posted Material Issues Header"."Prod. Order No.");
                PO.SETFILTER(PO."Line No.", FORMAT("Posted Material Issues Header"."Prod. Order Line No."));
                IF PO.FIND('-') THEN
                    "PCB Description" := PO.Description;
                //<Item Ledger Entry1>, Header (2) - OnPreSection()

            end;
        }
        dataitem(int1; "Integer")
        {
            column(Int1_Choice; Choice)
            {
            }
            column(Resource; Resource_Details)
            {
            }
            column(Item_Test; Item_Test)
            {
            }
            column(Lot_Test; Lot_Test)
            {
            }
            column(Serial_Test; Serial_Test)
            {
            }
            column(Qty_test; Qty_test)
            {
            }
            column(Int1_Desc; Int1_Desc)
            {
            }
            column(COdes; COdes)
            {
            }
            column(Int1_Desc2; Int1_Desc2)
            {
            }
            column(order_no_s_; "order no's")
            {
            }
            column(Qty_set_test; Qty_set_test)
            {
            }
            column(BINAddrsSets; BINAddrsSets)
            {
            }
            column(StockAddrsSets; StockAddrsSets)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF NOT PostMaterialQry.READ THEN
                    CurrReport.BREAK
                ELSE BEGIN
                    IF Not_Consider_Pcb AND (COPYSTR(PostMaterialQry.Item_No, 1, 5) = 'ECPCB') THEN
                        CurrReport.SKIP;
                    IF Only_Pcb AND (COPYSTR(PostMaterialQry.Item_No, 1, 5) <> 'ECPCB') THEN
                        CurrReport.SKIP;
                    item.RESET;
                    IF item.GET(PostMaterialQry.Item_No) THEN BEGIN
                        Item_Test := item.Description;
                        Int1_Desc := item."Description 2";
                        Int1_Desc2 := item."Base Unit of Measure";
                        BINAddrsSets := item."BIN Address";
                        StockAddrsSets := item."Stock Address";
                    END;
                    Lot_Test := PostMaterialQry.Lot_No;
                    Serial_Test := PostMaterialQry.Serial_No;
                    Qty_test := PostMaterialQry.Sum_Quantity;
                    IF Prev_ItemNo <> PostMaterialQry.Item_No THEN BEGIN
                        Item_Count += 1;
                        Prev_ItemNo := PostMaterialQry.Item_No;
                    END;

                    //Qty_set_test:=PostMaterialQry.Sum_Quantity/sets_no;

                END;
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Sets THEN
                    CurrReport.BREAK
                ELSE BEGIN
                    Item_Count := 0;
                    PostMaterialQry.OPEN;
                END;
                BINAddrsSets := '';
                StockAddrsSets := '';
            end;
        }
        dataitem("Integer"; "Integer")
        {
            column(Integer_choice; Choice)
            {
            }
            column(Store_Control1102152206; Store)
            {
            }
            column(DETAILS_b__7_; DETAILS[b] [7])
            {
            }
            column(DETAILS_b__6_; DETAILS[b] [6])
            {
            }
            column(DETAILS_b__5_; DETAILS[b] [5])
            {
            }
            column(DETAILS_b__4_; DETAILS[b] [4])
            {
            }
            column(ABS_Quantity_Set_b___sets_no; ABS(Quantity_Set[b]) / sets_no)
            {
            }
            column(ABS_Quantity_Set_b__; ABS(Quantity_Set[b]))
            {
            }
            column(DETAILS_b__2_; DETAILS[b] [2])
            {
            }
            column(DETAILS_b__1_; DETAILS[b] [1])
            {
            }
            column(Store_Control1102152298; Store)
            {
            }
            column(DETAILS_b__7__Control1102152300; DETAILS[b] [7])
            {
            }
            column(DETAILS_b__6__Control1102152302; DETAILS[b] [6])
            {
            }
            column(DETAILS_b__5__Control1102152304; DETAILS[b] [5])
            {
            }
            column(DETAILS_b__4__Control1102152306; DETAILS[b] [4])
            {
            }
            column(ABS_Quantity_Set_b___sets_no_Control1102152308; ABS(Quantity_Set[b]) / sets_no)
            {
            }
            column(ABS_Quantity_Set_b___Control1102152310; ABS(Quantity_Set[b]))
            {
            }
            column(DETAILS_b__2__Control1102152312; DETAILS[b] [2])
            {
            }
            column(DETAILS_b__1__Control1102152314; DETAILS[b] [1])
            {
            }
            column(Store_Control1102152279; Store)
            {
            }
            column(DETAILS_b__7__Control1102152280; DETAILS[b] [7])
            {
            }
            column(DETAILS_b__6__Control1102152282; DETAILS[b] [6])
            {
            }
            column(DETAILS_b__5__Control1102152284; DETAILS[b] [5])
            {
            }
            column(DETAILS_b__4__Control1102152287; DETAILS[b] [4])
            {
            }
            column(ABS_Quantity_Set_b___sets_no_Control1102152289; ABS(Quantity_Set[b]) / sets_no)
            {
            }
            column(ABS_Quantity_Set_b___Control1102152291; ABS(Quantity_Set[b]))
            {
            }
            column(DETAILS_b__2__Control1102152293; DETAILS[b] [2])
            {
            }
            column(DETAILS_b__1__Control1102152295; DETAILS[b] [1])
            {
            }
            column(Store_Control1102152259; Store)
            {
            }
            column(DETAILS_b__7__Control1102152262; DETAILS[b] [7])
            {
            }
            column(DETAILS_b__6__Control1102152263; DETAILS[b] [6])
            {
            }
            column(DETAILS_b__5__Control1102152266; DETAILS[b] [5])
            {
            }
            column(DETAILS_b__4__Control1102152268; DETAILS[b] [4])
            {
            }
            column(ABS_Quantity_Set_b___sets_no_Control1102152270; ABS(Quantity_Set[b]) / sets_no)
            {
            }
            column(ABS_Quantity_Set_b___Control1102152272; ABS(Quantity_Set[b]))
            {
            }
            column(DETAILS_b__2__Control1102152274; DETAILS[b] [2])
            {
            }
            column(DETAILS_b__1__Control1102152276; DETAILS[b] [1])
            {
            }
            column(Store_Control1102152239; Store)
            {
            }
            column(DETAILS_b__7__Control1102152242; DETAILS[b] [7])
            {
            }
            column(DETAILS_b__6__Control1102152244; DETAILS[b] [6])
            {
            }
            column(DETAILS_b__5__Control1102152246; DETAILS[b] [5])
            {
            }
            column(DETAILS_b__4__Control1102152248; DETAILS[b] [4])
            {
            }
            column(ABS_Quantity_Set_b___sets_no_Control1102152250; ABS(Quantity_Set[b]) / sets_no)
            {
            }
            column(ABS_Quantity_Set_b___Control1102152252; ABS(Quantity_Set[b]))
            {
            }
            column(DETAILS_b__2__Control1102152254; DETAILS[b] [2])
            {
            }
            column(DETAILS_b__1__Control1102152256; DETAILS[b] [1])
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord()
            begin
                b := b + 1;
                IF b >= a THEN
                    CurrReport.BREAK;
                IF Prod_Str_Stock[b] <> 0 THEN
                    Store := 'PRODSTR' + FORMAT(Prod_Str_Stock[b])
                ELSE
                    Store := 'STR';
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Sets THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Material Issues Line"; "Material Issues Line")
        {
            DataItemTableView = SORTING("Item No.", "Prod. Order No.") ORDER(Ascending) WHERE("Transfer-from Code" = CONST('STR'), "Outstanding Qty. (Base)" = FILTER(> 0));
            column(MIL_Choice; Choice)
            {
            }
            column(Material_Issues_Line__Material_Issues_Line__Description; "Material Issues Line".Description)
            {
            }
            column(Tot_Qty; "Material Issues Line".Quantity)
            {
            }
            column(Desc2_Control1102154186; Desc2)
            {
            }
            column(Item_Count_Control1102154036; Item_Count)
            {
            }
            column(Shortage_Items__Control1102154103; "Shortage Items")
            {
            }
            column(Item_Count__Shortage_Items__Control1102154104; Item_Count + "Shortage Items")
            {
            }
            column(Shortage_ItemCaption; Shortage_ItemCaptionLbl)
            {
            }
            column(Received_By__Caption; Received_By__CaptionLbl)
            {
            }
            column(Total_ItemsCaption_Control1102154035; Total_ItemsCaption_Control1102154035Lbl)
            {
            }
            column(Issued_itemsCaption_Control1102154101; Issued_itemsCaption_Control1102154101Lbl)
            {
            }
            column(Shortage_ItemsCaption_Control1102154102; Shortage_ItemsCaption_Control1102154102Lbl)
            {
            }
            column(Issued_By__Caption; Issued_By__CaptionLbl)
            {
            }
            column(Issued_Date_Time_Caption; Issued_Date_Time_CaptionLbl)
            {
            }
            column(Material_Issues_Line_Document_No_; "Document No.")
            {
            }
            column(Material_Issues_Line_Line_No_; "Line No.")
            {
            }
            column(Material_Issues_Line_Item_No_; "Item No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Prev_ItemNo <> "Material Issues Line"."Item No." THEN BEGIN
                    "Shortage Items" += 1;
                    Tot_Qty := QTY;
                    QTY := 0;
                    Prev_ItemNo := "Material Issues Line"."Item No.";
                END;

                //Material Issues Line, GroupFooter (2) - OnPreSection()
            end;

            trigger OnPostDataItem()
            begin
                /*
              //Material Issues Line, GroupFooter (2) - OnPreSection()
              IF Prev_ItemNo <>  "Material Issues Line"."Item No." THEN BEGIN
              "Shortage Items"+=1;
              Tot_Qty:=QTY;
              QTY:=0;
              Prev_ItemNo:=  "Material Issues Line"."Item No.";
              END;
              //Material Issues Line, GroupFooter (2) - OnPreSection()
               */

            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::Sets THEN
                    CurrReport.BREAK;
                QTY := 0;
                COdes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");
                //MESSAGE(FORMAT(COdes));
                IF COdes <> '' THEN
                    "Material Issues Line".SETFILTER("Material Issues Line"."Prod. Order No.", COdes);

                Compound := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order Line No.");
                IF Compound <> '' THEN
                    "Material Issues Line".SETFILTER("Material Issues Line"."Prod. Order Line No.", Compound);

                Compound1 := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No.");
                IF Compound1 <> '' THEN
                    "Material Issues Line".SETFILTER("Material Issues Line"."Production BOM No.", Compound1);
                "Shortage Items" := 0;
                Prev_ItemNo := '';
            end;
        }
        dataitem("Mech & Wirning Items"; "Mech & Wirning Items")
        {
            DataItemTableView = SORTING("Item No.", "Lot No.", "Production Order No.") ORDER(Ascending) WHERE(Description = FILTER(<> ''));
            RequestFilterFields = "Production Order No.";
            column(CURRENTDATETIME_Control1000000015; CURRENTDATETIME)
            {
            }
            column(CompanyAddr_1__Control1000000020; CompanyAddr[1])
            {
            }
            column(COdes_Control1000000000; COdes)
            {
            }
            column(Item_Desc_Control1102154188; Item_Desc)
            {
            }
            column(Lotno_Mech_wir; "Mech & Wirning Items"."Lot No.")
            {
            }
            column(Mech_quantity; "Mech & Wirning Items".Quantity)
            {
            }
            column(Mech_wiring_Header; SET_Headers)
            {
            }
            column(UOM; UOM)
            {
            }
            column(MW_Issd_Itm_Cnt1; Mech_i)
            {
            }
            column(Tot_MW_Itm_Count1; Mech_i + MWshortgCount)
            {
            }
            column(Show_Mech_Header; Mech_i)
            {
            }
            column(Shortg_Item_Count1; MWshortgCount)
            {
            }
            column(BINAddrsMech; BINAddrsMech)
            {
            }
            column(StockAddrsMech; StockAddrsMech)
            {
            }

            trigger OnAfterGetRecord()
            begin
                //Mech_i:=Mech_i+1;

                IF item.GET("Mech & Wirning Items"."Item No.") THEN BEGIN
                    Item_Desc := item.Description;
                    UOM := item."Base Unit of Measure";
                    BINAddrsMech := item."BIN Address";
                    StockAddrsMech := item."Stock Address";
                END;

                IF Prev_ItemNo <> "Mech & Wirning Items"."Item No." THEN BEGIN
                    Mech_i += 1;
                    Tot_Qty := QTY;
                    QTY := 0;
                    Prev_ItemNo := "Mech & Wirning Items"."Item No.";
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF Choice <> Choice::SETSM THEN
                    CurrReport.BREAK;

                CompanyInfo.GET();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                IF CompanyInfo.FIND('-') THEN
                    CompanyInfo.CALCFIELDS(CompanyInfo.Picture);


                "Mech & Wirning Items".SETRANGE("BOM Type", FORMAT("ME/WR"));
                "Posted Material Issues Header".COPYFILTER("Posted Material Issues Header"."Prod. Order No.",
                                                           "Mech & Wirning Items"."Production Order No.");

                "Posted Material Issues Header".COPYFILTER("Posted Material Issues Header"."Prod. Order No.",
                                                           "PROD. ORDER"."No.");
                COdes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");

                "PROD. ORDER".RESET;
                "PROD. ORDER".SETFILTER("No.", "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No."));
                "PROD. ORDER".SETFILTER("PROD. ORDER".Status, '%1|%2', "PROD. ORDER".Status::Released, "PROD. ORDER".Status::Finished);
                IF "PROD. ORDER".FINDFIRST THEN BEGIN
                    NO_OF_SETS := "PROD. ORDER".COUNT;
                    IF item.GET("PROD. ORDER"."Source No.") THEN
                        SET_Headers := FORMAT("ME/WR") + ' Sets ' + '"' + item.Description + '"' + '-' + FORMAT(NO_OF_SETS)
                    ELSE
                        SET_Headers := FORMAT("ME/WR") + ' Sets ' + '"' + "PROD. ORDER".Description + '"' + '-' + FORMAT(NO_OF_SETS);
                END;
                Mech_i := 0;
                MWshortgCount := 0;
                Prev_ItemNo := '';
                BINAddrsMech := '';
                StockAddrsMech := '';
            end;
        }
        dataitem("<Material Issues Line1>"; "Material Issues Line")
        {
            DataItemTableView = SORTING("Item No.", "Prod. Order No.") ORDER(Ascending) WHERE("Outstanding Qty. (Base)" = FILTER(> 0), "Transfer-from Code" = CONST('STR'));
            column(Material_Issues_Line1__Description; Description)
            {
            }
            column(Tot_Qty_Control1102154345; Quantity)
            {
            }
            column(Shortage_ItemCaption_Control1102154346; Shortage_ItemCaption_Control1102154346Lbl)
            {
            }
            column(Material_Issues_Line1__Document_No_; "Document No.")
            {
            }
            column(Material_Issues_Line1__Line_No_; "Line No.")
            {
            }
            column(Material_Issues_Line1__Item_No_; "Item No.")
            {
            }
            column(Shortg_Item_Count; MWshortgCount)
            {
            }
            column(Tot_MW_Itm_Count; Mech_i + MWshortgCount)
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
            column(MW_Issd_Itm_Cnt; Mech_i)
            {
            }

            trigger OnAfterGetRecord()
            begin
                MIH.RESET;
                MIH.SETFILTER(MIH."No.", "<Material Issues Line1>"."Document No.");
                MIH.SETFILTER(MIH."BOM Type", FORMAT("ME/WR"));
                IF MIH.FINDFIRST THEN BEGIN
                    QTY += "<Material Issues Line1>"."Outstanding Qty. (Base)";
                END;

                IF Prev_ItemNo <> "<Material Issues Line1>"."Item No." THEN BEGIN
                    MWshortgCount += 1;
                    Tot_Qty := QTY;
                    QTY := 0;
                    MIH.SETFILTER(MIH."No.", "<Material Issues Line1>"."Document No.");
                    MIH.SETFILTER(MIH."BOM Type", FORMAT("ME/WR"));
                    IF MIH.FINDFIRST THEN BEGIN
                        "Mech&Wire_Shortage" := TRUE;
                        "Shortage Items" += 1;
                    END ELSE
                        "Mech&Wire_Shortage" := FALSE;
                    Prev_ItemNo := "<Material Issues Line1>"."Item No.";
                END;
            end;

            trigger OnPreDataItem()
            begin
                MIH.RESET;
                IF Choice <> Choice::SETSM THEN
                    CurrReport.BREAK;
                QTY := 0;
                COdes := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order No.");
                IF COdes <> '' THEN
                    "<Material Issues Line1>".SETFILTER("<Material Issues Line1>"."Prod. Order No.", COdes);

                Compound := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. Order Line No.");
                IF Compound <> '' THEN
                    "<Material Issues Line1>".SETFILTER("<Material Issues Line1>"."Prod. Order Line No.", Compound);
                BOM := "Posted Material Issues Header".GETFILTER("Posted Material Issues Header"."Prod. BOM No.");
                IF BOM <> '' THEN
                    "<Material Issues Line1>".SETFILTER("<Material Issues Line1>"."Production BOM No.", BOM);
                /* MIH.SETFILTER(MIH."BOM Type",FORMAT("ME/WR"));
                 IF MIH.FINDSET THEN
                 BEGIN
                   REPEAT
                     "<Material Issues Line1>".SETFILTER("<Material Issues Line1>"."Document No.",MIH."No.");
                   UNTIL MIH.NEXT=0;
                 END ELSE MESSAGE('not');    */
                MWshortgCount := 0;
                Prev_ItemNo := '';
                "Shortage Items" := 0;

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
                    grid(Control1102152006)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152007)
                        {
                            ShowCaption = false;
                            label("Select an Option1")
                            {
                                Caption = 'Select an Option';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field("Select an Option"; Choice)
                            {
                                OptionCaption = 'Issues,SETS for RAW,SETS for MECH / WIRING';
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            field("ME/WR"; "ME/WR")
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152009)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152010)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152011)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152014)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152013)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152012)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152015)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152016)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152017)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152020)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152019)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152018)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152025)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152024)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152023)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152022)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152021)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152028)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152027)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152026)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                            label(Control1102152030)
                            {
                                ShowCaption = false;
                                ApplicationArea = All;
                            }
                        }
                    }
                    field("Don't Consider PCB"; Not_Consider_Pcb)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Not_Consider_Pcb = TRUE THEN
                                Only_Pcb := FALSE;
                        end;
                    }
                    field("Only PCB"; Only_Pcb)
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            IF Only_Pcb = TRUE THEN
                                Not_Consider_Pcb := FALSE;
                        end;
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

    trigger OnInitReport()
    begin
        //  MESSAGE('hi');
    end;

    var
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CompanyAddr: array[8] of Text[50];
        SLNO: Integer;
        Username: Text[50];
        User: Record User;
        desc1: Text[50];
        MTS: Record "Mat.Issue Track. Specification";
        LOT: Code[30];
        SERIAL: Code[30];
        item: Record Item;
        shelf: Code[30];
        Choice: Option Issue,Sets,SETSM;
        "Ser No": Text[1024];
        "order no's": Text[1000];
        COdes: Text[1000];
        Compound: Text[1000];
        Cnt: Integer;
        Item_Temp: Code[50];
        "PCB Description": Text[100];
        "Prod. Orders": Text[1000];
        Item_Desc: Text[50];
        Temp: Code[50];
        LOT1: Code[50];
        Item_Count: Integer;
        "Shortage Items": Integer;
        PO: Record "Prod. Order Line";
        COmpound_desc: Text[100];
        SET_Header: Text[100];
        SET_Headers: Text[100];
        Ar_Len: Integer;
        Prd_Ar: array[50] of Code[15];
        PMH: Record "Posted Material Issues Header";
        i: Integer;
        Available: Boolean;
        REQ_By: Code[40];
        POL: Record "Prod. Order Line";
        Rec_Count: Integer;
        OH: Text[50];
        Not_Consider_Pcb: Boolean;
        Only_Pcb: Boolean;
        Desc2: Text[50];
        "ME/WR": Option Mechanical,Wiring;
        "PROD. ORDER": Record "Production Order";
        NO_OF_SETS: Integer;
        "LOT_NO'S": array[10] of Code[20];
        "LOT_QTY'S": array[10] of Decimal;
        ITEM_TOT_QTY: Decimal;
        PREV_ITEM: Code[20];
        "NO_OF_LOT'S": Integer;
        UOM: Code[10];
        MIH: Record "Material Issues Header";
        QTY: Decimal;
        Tot_Qty: Decimal;
        BOM: Code[20];
        Store: Text[20];
        ILE: Record "Item Ledger Entry";
        PRDSTR_QTY: Decimal;
        STR_QTY: Decimal;
        Make: Code[50];
        PIDH: Record "Posted Inspect DatasheetHeader";
        vendor: Text[200];
        R: Integer;
        Compound1: Code[30];
        POL1: Record "Prod. Order Line";
        DETAILS: array[1000, 10] of Code[100];
        a: Integer;
        b: Integer;
        Quantity_Set: array[1000] of Decimal;
        c: Integer;
        d: Decimal;
        Prod_Str_Stock: array[1000] of Decimal;
        temp1: Integer;
        sets_no: Integer;
        Material_Request_FormCaptionLbl: Label 'Material Request Form';
        Requested__By_CaptionLbl: Label 'Requested  By:';
        Requisition_NoCaptionLbl: Label 'Requisition No';
        CompoundCaptionLbl: Label 'Compound';
        EmptyStringCaptionLbl: Label '(';
        EmptyStringCaption_Control1102154183Lbl: Label ')';
        ItemCaptionLbl: Label 'Item';
        Description_2CaptionLbl: Label 'Description 2';
        UOMCaptionLbl: Label 'UOM';
        QuantityCaptionLbl: Label 'Quantity';
        Serial_NoCaptionLbl: Label 'Serial No';
        Lot_NoCaptionLbl: Label 'Lot No';
        ItemCaption_Control1000000017Lbl: Label 'Item';
        Description_2Caption_Control1000000018Lbl: Label 'Description 2';
        UOMCaption_Control1000000019Lbl: Label 'UOM';
        QuantityCaption_Control1000000021Lbl: Label 'Quantity';
        Serial_NoCaption_Control1000000004Lbl: Label 'Serial No';
        Lot_NoCaption_Control1000000059Lbl: Label 'Lot No';
        Authrorised_byCaptionLbl: Label 'Authrorised by';
        Received_byCaptionLbl: Label 'Received by';
        Issued_byCaptionLbl: Label 'Issued by';
        Total_ItemsCaptionLbl: Label 'Total Items';
        Issued_itemsCaptionLbl: Label 'Issued items';
        Shortage_ItemsCaptionLbl: Label 'Shortage Items';
        Issues_Date_TimeCaptionLbl: Label 'Issues Date Time';
        Requisition_NoCaption_Control1102154001Lbl: Label 'Requisition No';
        Requested__By_Caption_Control1102154003Lbl: Label 'Requested  By:';
        Requested__Date___TImeCaptionLbl: Label 'Requested  Date & TIme';
        DepartmentCaptionLbl: Label 'Department';
        Project_CodesCaptionLbl: Label 'Project Codes';
        Issued_Date___TimeCaptionLbl: Label 'Issued Date & Time';
        EmptyStringCaption_Control1102154175Lbl: Label '(';
        EmptyStringCaption_Control1102154176Lbl: Label ')';
        Production_OrdersCaptionLbl: Label 'Production Orders';
        Serial_No_CaptionLbl: Label 'Serial No.';
        LOT_NOCaption_Control1102154018Lbl: Label 'LOT NO';
        ItemCaption_Control1102154019Lbl: Label 'Item';
        QTY_Set_CaptionLbl: Label 'QTY(Set)';
        UOMCaption_Control1102154029Lbl: Label 'UOM';
        QTYCaptionLbl: Label 'QTY';
        Description_2Caption_Control1102154072Lbl: Label 'Description 2';
        LocationCaptionLbl: Label 'Location';
        Shortage_ItemCaptionLbl: Label 'Shortage Item';
        Received_By__CaptionLbl: Label '( Received By )';
        Total_ItemsCaption_Control1102154035Lbl: Label 'Total Items';
        Issued_itemsCaption_Control1102154101Lbl: Label 'Issued items';
        Shortage_ItemsCaption_Control1102154102Lbl: Label 'Shortage Items';
        Issued_By__CaptionLbl: Label '( Issued By )';
        Issued_Date_Time_CaptionLbl: Label 'Issued Date Time:';
        Project_CodesCaption_Control1000000023Lbl: Label 'Project Codes';
        ITEMCaption_Control1102154187Lbl: Label 'ITEM';
        QTY__PER_SETCaptionLbl: Label 'QTY. PER SET';
        TOTAL_QUANTITYCaptionLbl: Label 'TOTAL QUANTITY';
        LOT_NO_CaptionLbl: Label 'LOT NO.';
        LOT_QTY_CaptionLbl: Label 'LOT QTY.';
        UOMCaption_Control1102154215Lbl: Label 'UOM';
        Shortage_ItemCaption_Control1102154346Lbl: Label 'Shortage Item';
        PMILineBody3: Boolean;
        PMILineGrupFoter: Boolean;
        ILE1Body6: Boolean;
        ILE1Body7: Boolean;
        ILE1GrupFooter11: Boolean;
        ILE1GrupFooter12: Boolean;
        WiringItemsGroupfooter4: Boolean;
        WiringItemsGroupfooter5: Boolean;
        WiringItemsGroupfooter6: Boolean;
        WiringItemsGroupfooter7: Boolean;
        WiringItemsGroupfooter8: Boolean;
        WiringItemFooter10: Boolean;
        WiringItemFooter11: Boolean;
        WiringItemFooter12: Boolean;
        WiringItemFooter13: Boolean;
        WiringItemFooter14: Boolean;
        Prev_Lot: Code[20];
        Prev_Line: Integer;
        Prev_ItemNo: Code[20];
        Prev_LotMech: Code[20];
        PMIH3: Boolean;
        PMIH2: Boolean;
        "Mech&Wire_Shortage": Boolean;
        PMIH: Record "Posted Material Issues Header";
        com: Text[1000];
        PostMaterialQry: Query "Post Material issues New";
        Item_Test: Text;
        Lot_Test: Code[20];
        Serial_Test: Code[20];
        Qty_test: Decimal;
        Qty_set_test: Decimal;
        Int1_Desc: Text;
        Int1_Desc2: Text;
        Int1_body7: Boolean;
        Material_Required_Day: Integer;
        Mech_i: Integer;
        Resource: Code[100];
        Resource_Details: Code[20];
        Prod_codes: Text[200];
        MWshortgCount: Integer;
        LocationsCode: Code[100];
        dimValue: Record "Dimension Value";
        BINAddrsMech: Code[10];
        BINAddrsSets: Code[10];
        BINAddrsIssues: Code[50];
        StockAddrsMech: Code[10];
        StockAddrsSets: Code[10];
        StockAddrsIssues: Code[50];
        PMIL: Record "Posted Material Issues Line";
        MIL: Record "Material Issues Line";
        MI_Qty: Decimal;
        PMI_Qty: Decimal;
        Rem_Qty: Decimal;
}

