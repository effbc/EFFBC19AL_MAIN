report 50038 "Material Availability"
{
    //              {  IF NOT ("Verify Alternate"("Prod. Order Component"."Item No.",
    //                              ("Prod. Order Component"."Expected Quantity"-
    //                               "Prod. Order Component"."Qty. in Posted Material Issues"),
    //                                "Prod. Order Component"."Prod. Order No.")) THEN
    // // TempBoutStockTable table is a temperary table of sales lines to store the sale order wise Bout items total qty and Issued Qty
    // // TempBoutStockTable fields used here are TempBoutStockTable."Document Type",
    // // TempBoutStockTable."Document No.",TempBoutStockTable."Line No.",TempBoutStockTable."No.",TempBoutStockTable.Quantity,
    // // TempBoutStockTable."Qty. Sent To Quality" (is used to store total PMI Qty of item issued on  sale order)
    DefaultLayout = RDLC;
    RDLCLayout = './MaterialAvailability.rdl';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Prod. Order Component"; "Prod. Order Component")
        {
            CalcFields = "Qty. in Posted Material Issues", "Qty. in Material Issues";
            DataItemTableView = SORTING("Production Plan Date", "Item No.", "Prod. Order No.") ORDER(Ascending) WHERE("Expected Quantity" = FILTER(> 0), "Don't Consider" = CONST(false), Status = CONST(Released));
            RequestFilterFields = "Production Plan Date";
            column(Prod__Order_Component__Production_Plan_Date_; "Production Plan Date")
            {
            }
            column(Prod__Order_Component_Status; Status)
            {
            }
            column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
            {
            }
            column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
            {
            }
            column(Prod__Order_Component_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                /*IF "Prod. Order Component"."Item No." = 'ECDIOPN00120' THEN
                    MESSAGE("Prod. Order Component"."Item No.");*/

                //Rev01   Added Code from  //Prod. Order Component, GroupHeader (1) - OnPreSection()

                // CODE FOR ADDING FUTURE ESTIMATED INWARDS
                // AND CALCULATING SHORTAGE FOR THE SALE ORDER & SCHEDULE BOUT'S
                ShortgFlag := FALSE;         //Added By Pranavi on 24-11-2015 for shortage calc correction
                ShortgTemp := 0;
                Shortgvalue := 0;
                Alternate_Buffer := 0;
                IF Previous_Plan_Date > 0D THEN BEGIN
                    IF Previous_Plan_Date <> "Prod. Order Component"."Production Plan Date" THEN BEGIN
                        DAYS_GAP := "Prod. Order Component"."Production Plan Date" - Previous_Plan_Date;
                        FOR I := 1 TO DAYS_GAP DO BEGIN
                            //Include_Purchase_Qty(Previous_Plan_Date+I);  //commented by pranavi on 23-11-2015
                            Calculate_Sale_Order_Shortage(Previous_Plan_Date + I);
                            Calculate_Sale_Schedule_Shorta(Previous_Plan_Date + I);
                        END;
                        //Rev01 Code Copied From //Prod. Order Component, GroupFooter (3) - OnPreSection()
                        Previous_Plan_Date := "Prod. Order Component"."Production Plan Date";
                        //Rev01 Code Copied From //Prod. Order Component, GroupFooter (3) - OnPreSection()
                    END;
                END
                ELSE BEGIN
                    Previous_Plan_Date := "Prod. Order Component"."Production Plan Date";
                    //Include_Purchase_Qty("Prod. Order Component"."Production Plan Date");   //commented by pranavi on 23-11-2015
                    Calculate_Sale_Order_Shortage("Prod. Order Component"."Production Plan Date");
                    Calculate_Sale_Schedule_Shorta("Prod. Order Component"."Production Plan Date");
                END;
                //Rev01   Added Code from  //Prod. Order Component, GroupHeader (1) - OnPreSection()
                // VERIFYING REQUIREMENT IS THERE OR NOT ,
                // IF REQUIREMENT IS THERE PROCESS WILL BE CONTINUED OTHER WISE CONTROL WILL PASS TO NEXT RECORD
                //B2B.1.0.P.K 27Aug19
                /*IF ("Prod. Order Component"."Expected Quantity"-"Prod. Order Component"."Qty. in Posted Material Issues")>0 THEN
                BEGIN
                IF "Prod. Order Component"."Item No." = 'HACONWG00140' THEN
                  MESSAGE('Qty in PM %1 Req Qty  %2',"Prod. Order Component"."Qty. in Posted Material Issues","Prod. Order Component"."Expected Quantity");
                
                  // VERIFYING REQUIRED ITEM DETAILS IS AVAILBLE IN VIRTUAL STOCK OR NOT
                  Dum.RESET;
                  IF NOT( Dum.GET("Prod. Order Component"."Item No.") ) THEN
                    Include_Item("Prod. Order Component"."Item No.",TRUE);
                  {
                  IF "Manf. Setup"."Consider Exp. Order Material" THEN
                  BEGIN
                  }
                    PO.RESET;
                    IF PO.GET("Prod. Order Component".Status,"Prod. Order Component"."Prod. Order No.") THEN
                    BEGIN
                      IF COPYSTR(PO."Sales Order No.",1,7)='EFF/EXP' THEN
                      BEGIN
                        IF NOT ((COPYSTR(PO."Sales Order No.",14,2)='/L') OR (COPYSTR(PO."Sales Order No.",14,2)='/T')) THEN
                        BEGIN
                          ITEM_LEAD_TIME:=0;
                          {
                          EVALUATE(ITEM_LEAD_TIME,COPYSTR(FORMAT(Item."Safety Lead Time"),1,STRLEN(FORMAT(Item."Safety Lead Time"))-1));
                          IF NOT (Item."Product Group Code" IN['FPRODUCT','CPCB']) THEN
                            IF NOT (ITEM_LEAD_TIME<21) THEN
                          }
                          IF USERID <> 'EFFTRONICS\PRANAVI' THEN
                          IF (FORMAT(Itm."Safety Lead Time") IN ['2D','4D','7D','15D']) THEN
                          BEGIN
                          //  IF PO."Planned Dispatch Date" <= tempdate THEN
                              CurrReport.SKIP;
                          END;
                          // commented by Pranavi on 08-mar-2016
                        END;
                      END;
                    END;
                  {END;}
                END ELSE
                  CurrReport.SKIP;*/

                //B2B.1.0.P.K
                //Rev01 Code Copied From //Prod. Order Component, Body (2) - OnPreSection()

                //B2B.1.0.P.K
                IF NOT Dum.GET("Prod. Order Component"."Item No.") THEN BEGIN
                    Include_Item("Prod. Order Component"."Item No.", FALSE);
                END;
                //B2B.1.0.P.K

                Dum.RESET;
                "Qty. In Issues & Req" := "Prod. Order Component"."Qty. in Posted Material Issues";
                // VERIFYING REQUIRED ITEM IS IN VIRTUAL STOCK (OR) NOT
                IF Dum.GET("Prod. Order Component"."Item No.") THEN BEGIN // item item present in dum begin
                    /*IF "Prod. Order Component"."Item No." = 'ECREGPV00050' THEN
                    MESSAGE(' dum poc no %1',Dum."No."); // sujani#*/
                    Within_Buffer := FALSE;
                    DUm_Stk := Dum."Maximum Inventory";
                    DUm_Req := ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req");
                    Dum_Item := "Prod. Order Component"."Item No.";
                    Dum_Po := "Prod. Order Component"."Prod. Order No.";
                    // VERIFYING REQUIRED QUANTITY IS AVAILABLE IN VIRTUAL STOCK (OR) NOT
                    // IF STOCK IS THERE THEN DEDUCTING REQUIRED QUANTITY FROM VIRTUAL STOKC
                    //Added by Pranavi on 26-Dec-2015 for not considering expected orders items if lead time <=15 days
                    ExpFlag := FALSE;
                    PO1.RESET;
                    PO1.SETFILTER(PO1.Status, '%1', 3);
                    PO1.SETRANGE(PO1."No.", "Prod. Order Component"."Prod. Order No.");
                    IF PO1.FIND('-') THEN BEGIN // PO1 BEGIN
                        Itm.RESET;
                        Itm.SETRANGE(Itm."No.", "Prod. Order Component"."Item No.");
                        IF Itm.FINDFIRST THEN BEGIN // Itm Begin
                            IF USERID <> 'EFFTRONICS\PRANAVI' THEN
                                IF (COPYSTR(PO1."Sales Order No.", 5, 3) = 'EXP') AND (FORMAT(Itm."Safety Lead Time") IN ['2D', '4D', '7D', '15D']) THEN BEGIN
                                    IF NOT (COPYSTR(PO1."Sales Order No.", 14, 2) IN ['/L', '/T']) THEN
                                        ExpFlag := TRUE
                                    ELSE
                                        ExpFlag := FALSE;
                                END
                                ELSE
                                    ExpFlag := FALSE; //commented by Pranavi on 08-mar-2016

                        END; // Itm end
                    END; // PO1 END
                         // End by pranavi on 26-Dec-2015

                    IF ExpFlag = FALSE THEN BEGIN // exp flag false begin
                        IF Item_Req.GET("Prod. Order Component"."Item No.") THEN BEGIN
                            Item_Req."Required Quantity" += "Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req";
                            Item_Req."Req Qty" += "Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req";
                            Item_Req.MODIFY;
                        END
                        ELSE BEGIN
                            Item_Req.INIT;
                            Item_Req."Item No." := "Prod. Order Component"."Item No.";
                            Item_Req.Description := "Prod. Order Component".Description;
                            Item_Req."Required Quantity" := "Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req";
                            Item_Req."Req Qty" := "Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req";
                            Item_Req.INSERT;
                        END;
                        IF Dum."Maximum Inventory" >= ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req") THEN BEGIN
                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req");
                            Dum.MODIFY;
                        END
                        ELSE BEGIN // max invent < expected qty begin
                                   //  IF "Prod. Order Component"."Item No." ='ECDIOPN00120' THEN
                                   //  MESSAGE(FORMAT(Dum."Maximum Inventory"));
                                   // IF REQURED QUANTITY IS NOT THERE THEN VERIFYING IN ALTERNATE ITEMS
                            "Verify Alternate"(Dum."No.", ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req"),
                                             "Prod. Order Component"."Prod. Order No.");
                            // IF ALTERNATE ITEM STOCK IS ALSO NOT THERE, THEN SHORTAGE DETAILS WILL BE UPDATED
                            IF NOT AVB THEN BEGIN // not avb begin
                                Dum.RESET;
                                IF Dum.GET("Prod. Order Component"."Item No.") THEN BEGIN // if item in dum begin
                                    IF FORMAT(Dum."Safety Lead Time") <> '' THEN BEGIN // safety lead time not null begin
                                                                                       // CALCULATING PLANNED PURCHASE DATE ( WHEN WE HAVE TO PURCHASE THE REQUIRED MATERIAL FOR PRODUCTION )
                                        Total_Buffer := '-' + FORMAT(Dum."Safety Lead Time");
                                        "Planned_Purchase (Wit out Buf)" := CALCDATE(Total_Buffer, "Prod. Order Component"."Production Plan Date");
                                        Total_Buffer := '-' + FORMAT(Buffer);
                                        "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned_Purchase (Wit out Buf)");
                                        Possible_Procured_Date := 0D;
                                        Possible_Plan_Changed_Date := 0D;
                                        //  "Planned Purchase Date" := WORKDATE +1 ;
                                        AVB := FALSE;
                                        //ADDED by Sundar
                                        IF "Planned Purchase Date" < WORKDATE THEN BEGIN
                                            "Planned Purchase Date" := "Planned Purchase Date" + 7;
                                        END; //Added By Sundar
                                             // COMMENTED BY PRANAVI ON 04-03-2017 FOR TESTING
                                             // IF CALCULATED "PLANNED PURCHASE DATE" IS LESS THAN CURRENT DATE
                                        IF "Planned Purchase Date" < WORKDATE THEN BEGIN // planned purchase date < work date begin
                                                                                         // IF MATERIAL IS ARRIVING NEARER TO PLANNED PRODUCTION DATE
                                            "Planned Purchase Date" := 0D;
                                            Dum_Purch_Line.RESET;
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", "Prod. Order Component"."Item No.");
                                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date", "Prod. Order Component"."Production Plan Date" - 3,
                                                                                                             "Prod. Order Component"."Production Plan Date" - 2);

                                            ///**********Start  dum_purchline*****///////////
                                            IF NOT (Dum_Purch_Line.FIND('-')) THEN BEGIN
                                                // THERE IS NO "PURCHASE ARRIVALS " NEARER TO "PRODUCTION PLANE DATE" THEN VERIFYING  "PURCHASE ARRIVALS "
                                                // WHICH ARE IN THE FUTURE OF "PRODUCTION PLAN DATE"
                                                Dum_Purch_Line.RESET;
                                                Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", "Prod. Order Component"."Item No.");
                                                Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                                Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date", '>=%1', "Prod. Order Component"."Production Plan Date");
                                                IF Dum_Purch_Line.FIND('-') THEN BEGIN
                                                    REPEAT
                                                        // VERIFYING SUFFICIENT MATERIAL ARRIVAL IS THERE (OR) NOT
                                                        IF (Dum_Purch_Line."Qty. to Receive" > "Prod. Order Component"."Expected Quantity" - ("Qty. In Issues & Req" +
                                                                                                                                       Alternate_Buffer)) AND (NOT AVB) THEN BEGIN
                                                            //end by pranavi added on 25-11-2015
                                                            // IF THERE THEN RESERVING THE MATERIAL & UPDATE THE "POSSIBLE PROCURED DATE"
                                                            Dum_Purch_Line."Qty. to Receive" -= "Prod. Order Component"."Expected Quantity" - ("Qty. In Issues & Req" +
                                                                                                                                            Alternate_Buffer);
                                                            Dum_Purch_Line.MODIFY;
                                                            Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date" + 2;
                                                            AVB := TRUE;
                                                        END;
                                                    UNTIL (Dum_Purch_Line.NEXT = 0) OR (AVB);
                                                    // IF THERE IS NO "POSSIBLE PRODCUREMENT DATE" THEN
                                                    // UPDATE "POSSIBLE PRODCUREMENT DATE" BASED ON "LEAD TIME & BUFFER TIME"
                                                    IF Possible_Procured_Date = 0D THEN BEGIN
                                                        Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                        Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                        Total_Buffer := FORMAT(Buffer);
                                                        Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                    END;
                                                END
                                                ELSE BEGIN
                                                    Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                    Total_Buffer := FORMAT(Buffer);
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                END;
                                            END
                                            ELSE
                                                Within_Buffer := TRUE;
                                            ///**********end dum_purchline*****///////////
                                            IF Possible_Procured_Date > 0D THEN
                                                Possible_Plan_Changed_Date := Possible_Procured_Date;
                                            IF "Planned_Purchase (Wit out Buf)" < WORKDATE THEN
                                                "Planned_Purchase (Wit out Buf)" := 0D;
                                        END;//planned purchase date < work date end
                                            // IF PLANNED PURCHASE DATE IS SUNDAY THEN IT WIL CHANGE THAT INTO SATURDAY
                                        IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                            IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                                "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                        END;
                                        //  ENTERING / UPDATING  SHORTAGE INFORMATION INTO THE "SHORTAGE DETAILS" TABLE
                                        ShortgFlag := FALSE;
                                        ShortgTemp := 0;
                                        Item_Lot.RESET;
                                        Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                        Item_Lot.SETRANGE(Item_Lot."Production Order No.", "Prod. Order Component"."Prod. Order No.");
                                        Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                        IF Item_Lot.FIND('-') THEN BEGIN
                                            ShortgTemp := 0;
                                            // Item_Lot.Shortage+=("Prod. Order Component"."Expected Quantity"-("Qty. In Issues & Req"+Alternate_Buffer));
                                            IF Alternate_Buffer > 0 THEN BEGIN
                                                IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                    ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                                    Item_Lot.Shortage += ShortgTemp;
                                                    Dum."Maximum Inventory" := 0;
                                                    Dum.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Item_Lot.Shortage += ShortgTemp;
                                                    Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum.MODIFY;
                                                    ShortgFlag := TRUE;
                                                END;
                                            END
                                            ELSE BEGIN
                                                ShortgTemp := ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req") - Dum."Maximum Inventory";
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END;
                                            IF ShortgFlag = FALSE THEN
                                                Item_Lot.MODIFY;
                                        END
                                        ELSE BEGIN // if not find in ILE begin
                                            Item_Lot.INIT;
                                            Item_Lot."Item No" := Dum."No."; // dum table
                                            Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                            Item_Lot.Description := Dum.Description;
                                            Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                            Item_Lot."Possible Procured Date" := Possible_Procured_Date;
                                            Item_Lot."Possible Production Plan Date" := Possible_Plan_Changed_Date;
                                            Item_Lot."Within Buffer" := Within_Buffer;
                                            IF Alternate_Buffer > 0 THEN BEGIN
                                                IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                    Item_Lot.Shortage := Alternate_Buffer - Dum."Maximum Inventory";
                                                    Dum."Maximum Inventory" := 0;
                                                    Dum.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    Item_Lot.Shortage := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum.MODIFY;
                                                    ShortgFlag := TRUE;
                                                END;
                                            END
                                            ELSE BEGIN
                                                Item_Lot.Shortage := ("Prod. Order Component"."Expected Quantity" - "Qty. In Issues & Req") - Dum."Maximum Inventory";
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END;
                                            //END;
                                            //End By Pranavi on 24-11-2015 for shortage calc correction
                                            Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                            Item_Lot."Production Order No." := "Prod. Order Component"."Prod. Order No.";
                                            Item_Lot."Prod. Order Line No." := "Prod. Order Component"."Prod. Order Line No.";
                                            Item_Lot."Prod. Order Comp Line No." := "Prod. Order Component"."Line No.";
                                            PO.RESET;
                                            PO.SETFILTER(PO.Status, '%1', 3);
                                            PO.SETRANGE(PO."No.", "Prod. Order Component"."Prod. Order No.");
                                            IF PO.FIND('-') THEN BEGIN //PO BEGIN
                                                Item_Lot."Sales Order No." := PO."Sales Order No.";
                                                Item_Lot."Planned Date" := PO."Prod Start date";
                                                Item_Lot."Material Required Date" := "Prod. Order Component"."Production Plan Date" - 4;
                                                Item_Lot."Product Type" := PO."Item Sub Group Code";
                                                Item_Lot.Product := PO."Source No.";
                                                "Sales Header".RESET;
                                                "Sales Header".SETRANGE("Sales Header"."No.", PO."Sales Order No.");
                                                IF "Sales Header".FIND('-') THEN BEGIN
                                                    Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                                    "Sales Header"."Shortage Calculation" := TRUE;
                                                    "Sales Header".MODIFY;
                                                END;
                                                IF Item_Lot.Shortage > 0 THEN
                                                    IF ShortgFlag = FALSE THEN    //Added By Pranavi on 24-11-2015 for shortage calc correction
                                                        Item_Lot.INSERT;
                                            END; //PO END
                                        END;// ile not found end
                                    END;//safety lead time not null end
                                END; //if item in dum end
                            END;// not avb end
                        END;//max invent < expected qty end
                    END;//exp flag false end
                END;// item item present in dum end

                //Rev01 Code Copied From //Prod. Order Component, Body (2) - OnPreSection()
                /*IF "Prod. Order Component"."Item No." = 'ECREGPV00050' THEN
                    ERROR('%1',ExpFlag);*/

            end;

            trigger OnPreDataItem()
            begin
                //Rev01 Begin
                /*
                Prod. Order Component - DataItemTableView
                ------------------------------------------
                SORTING(Production Plan Date,Item No.,Prod. Order No.) ORDER(Ascending) WHERE(Expected Quantity=FILTER(>0),Don't Consider=CONST(No),
                Status=CONST(Released),Production Plan Date=FILTER(>01-01-08))
                */
                //Rev01 End

                "Prod. Order Component".SETFILTER("Production Plan Date", '> 01-01-2008'); //Rev01 Removed from DataItemTableView And Added here
                "Manf. Setup".GET;
                // CLEARENCE OF SHORTGE DETAILS (ITEM LOT NUMBERS) TABLE WHICH ARE CALCULATED IN LAST ITTREATION

                //Test_Item := 'ECPCBSS00640';
                Del := TRUE;

                //********************1 begin********************//
                // FILTERING THE SHORTAGE DETAILS WHICH ARE CONVERTED INTO INDENTS IN LAST ITTRATION
                IF USERID <> 'EFFTRONICS\SUJANI' THEN BEGIN
                    Item_Lot.SETRANGE(Item_Lot.Authorisation, Item_Lot.Authorisation::indent);
                    IF Item_Lot.FIND('-') THEN BEGIN
                        REPEAT
                            "Indent line".RESET;
                            "Indent line".SETRANGE("Indent line"."Document No.", Item_Lot."Indent No.");
                            "Indent line".SETRANGE("Indent line"."No.", Item_Lot."Item No");
                            IF "Indent line".FIND('-') THEN BEGIN
                                // VERIFYING INDENTS ARE CONVERTED INTO ORDER (OR) NOT
                                IF "Indent line"."Indent Status" = "Indent line"."Indent Status"::Indent THEN BEGIN
                                    // IF ANY OF THE INDENT STILL IN INDENT STATE , THAT ITEM INFORMATION PASSED TO USER IN MESSAGE MODE
                                    MESSAGE("Indent line".Description);
                                    MESSAGE("Indent line"."Document No.");
                                    Del := FALSE;
                                    // ONE SELECTION BOX WILL DISPLAY AND ASKS WHETHER  "DELETE THE OLD INDENTS"/"DON'T DELTE INDENTS"
                                    Selection := STRMENU(Text001, 2);
                                    IF Selection = 1 THEN BEGIN
                                        // if we select 1 st option all indents will be deleted which are created in previous cycle
                                        // & those are in Indent state
                                        Item_Lot.RESET;
                                        Item_Lot.SETRANGE(Item_Lot.Authorisation, Item_Lot.Authorisation::indent);
                                        IF Item_Lot.FIND('-') THEN
                                            REPEAT
                                                "Indent line".SETRANGE("Indent line"."Document No.", Item_Lot."Indent No.");
                                                "Indent line".SETRANGE("Indent line"."No.", Item_Lot."Item No");
                                                IF "Indent line".FIND('-') THEN
                                                    "Indent line".DELETE;
                                            UNTIL Item_Lot.NEXT = 0;
                                        // clearing the previouse cycle shortage details
                                        Item_Lot.RESET;
                                        Item_Lot.SETFILTER(Item_Lot.Shortage, '>%1', 0);
                                        IF Item_Lot.FIND('-') THEN
                                            Item_Lot.DELETEALL;

                                    END ELSE // if selection =2
                                    BEGIN
                                        // If we selected the 2 nd option then report processing iwll be stopped
                                        CurrReport.BREAK;
                                    END;
                                END; // indent line status check end
                            END; // indent line end
                        UNTIL Item_Lot.NEXT = 0;
                    END ELSE // ILN END and else

                      BEGIN
                        // if there is no Indents in previous cycle the Previous cycle Shortage Details will be deleted
                        Item_Lot.RESET;
                        Item_Lot.DELETEALL;
                    END;
                END;
                //********************1 end********************//


                IF Del THEN BEGIN
                    // deleting the Previous cycle Shortage Details
                    Item_Lot.RESET;
                    Item_Lot.DELETEALL;
                END;

                // deleting the data in item wise requirement table
                Item_Req.DELETEALL;

                // locking the Item table
                Item.LOCKTABLE;

                IF USERID <> 'EFFTRONICS\SUJANI' THEN BEGIN
                    // Added by Pranavi 23-Feb-2016 for checking mail send to vendor for pos
                    Auto := FALSE;
                    IF EVALUATE(PODateVar, '01-01-2016') = TRUE THEN BEGIN
                        Mail_count := 0;
                        PurchHeadr.RESET;
                        PurchHeadr.SETRANGE(PurchHeadr."Document Type", PurchHeadr."Document Type"::Order);
                        PurchHeadr.SETFILTER(PurchHeadr."Order Date", '>%1', PODateVar);
                        PurchHeadr.SETFILTER(PurchHeadr.Mail_count, '%1', 0);
                        IF PurchHeadr.FINDSET THEN
                            REPEAT
                                Auto := FALSE;
                                IF (TODAY - PurchHeadr."Order Date") > 2 THEN BEGIN
                                    PurchLineGRec.RESET;
                                    PurchLineGRec.SETRANGE(PurchLineGRec."Document No.", PurchHeadr."No.");
                                    IF PurchLineGRec.FINDSET THEN
                                        REPEAT
                                            IF COPYSTR(PurchLineGRec."Indent No.", 1, 6) = 'IND-AU' THEN BEGIN
                                                Auto := TRUE;
                                            END;
                                        UNTIL (PurchLineGRec.NEXT = 0) OR (Auto = FALSE);
                                    IF Auto = TRUE THEN BEGIN
                                        Mail_count += 1;
                                        IF Polist = '' THEN
                                            Polist := PurchHeadr."No."
                                        ELSE
                                            Polist += ', ' + PurchHeadr."No.";
                                    END;
                                END;
                            UNTIL PurchHeadr.NEXT = 0;
                        IF Mail_count > 0 THEN
                            ERROR('Mail has not been send to vendor for the following orders\' + Polist);
                    END
                    ELSE
                        ERROR('Date Format Mis match! Please contach ERP Team!');
                END;
                // End by Pranavi
                //Verification for Pending Purchase orders
                // conditions : 1) Considering only "STR" purchase orders
                //              2) It must not be AMC Order
                //              3) Order must be Released
                //              4) Expected/Deviated date must be below the current date
                //start
                IF USERID <> 'EFFTRONICS\SUJANI' THEN BEGIN
                    "Purchase line".RESET;
                    "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
                    "Purchase line".SETFILTER("Purchase line"."Deviated Receipt Date", '<>%1', 0D);
                    "Purchase line".SETFILTER("Purchase line"."Deviated Receipt Date", '<%1', TODAY - 1);
                    "Purchase line".SETFILTER("Purchase line".Type, 'Item');
                    "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
                    "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR');
                    "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
                    "Purchase line".SETRANGE("Purchase line"."AMC Order", FALSE);
                    IF "Purchase line".FIND('-') THEN BEGIN
                        // if there is any "Pending Purchase Order" then error will be returned with specifying the "Purchase Order No."
                        ERROR("Purchase line"."Document No." + ' There is Some Material to  change the Deviated Dates');
                    END;
                END;
                // Filtering Production Order Components data which are planned in Future
                "Prod. Order Component".SETFILTER("Prod. Order Component"."Production Plan Date", '>%1', WORKDATE);

                // calculating earliest "Production Start Date"
                ProdOrderCmpnt.SETCURRENTKEY(ProdOrderCmpnt."Production Plan Date", ProdOrderCmpnt."Item No.", ProdOrderCmpnt."Prod. Order No.");
                ProdOrderCmpnt.SETFILTER(ProdOrderCmpnt.Status, '%1', ProdOrderCmpnt.Status::Released);
                ProdOrderCmpnt.SETFILTER(ProdOrderCmpnt."Production Plan Date", '>%1', WORKDATE);
                IF ProdOrderCmpnt.FIND('-') THEN BEGIN
                    IF Prod_date = 0D THEN
                        Prod_date := ProdOrderCmpnt."Production Plan Date";
                END;

                // it will return the error if Production Plane is not there
                IF Prod_date = 0D THEN
                    ERROR('Please Enter the Production Plan');


                // VERIFYING THE SALE ORDER,START DATE,DISPACH DETAILS FOR EVERY PRODUCTION ORDER
                // IF ANY OF THE ABOVE INFORMATION MISSED , ERROR WILL RETURNED
                PO.SETCURRENTKEY(PO."Prod Start date");
                PO.SETFILTER(PO.Status, '%1', PO.Status::Released);
                PO.SETFILTER(PO."Prod Start date", '>%1', WORKDATE);
                IF PO.FIND('-') THEN
                    REPEAT
                        PO."Change To Specified Plan Date" := FALSE;

                        IF PO."Sales Order No." = '' THEN BEGIN
                            ERROR('There is no  Sale Order No. For the ' + FORMAT(PO."No."));
                            CurrReport.BREAK;
                        END;

                        IF PO."Planned Dispatch Date" = 0D THEN BEGIN
                            ERROR('There is no  "Planned Dispatch Date" For the ' + FORMAT(PO."No."));
                            CurrReport.BREAK;
                        END;
                        IF PO."Prod Start date" > PO."Planned Dispatch Date" THEN BEGIN
                            MESSAGE(FORMAT(PO."Prod Start date"));
                            MESSAGE(FORMAT(PO."Planned Dispatch Date"));
                            ERROR('Dispatch Date Must Be Greater than the Production Start Date For Production Order No.' + FORMAT(PO."No."));
                        END;
                    UNTIL PO.NEXT = 0;

                // STORING THE "SHORTAGE CALCULATION DATE"  IN GENERAL LEDGER SETUP
                "G|L".GET;
                "G|L"."Shortage. Calc. Date" := WORKDATE;
                "G|L"."Expected Orders Data Dump" := FALSE;
                "G|L".MODIFY;



                IF Test_Item <> '' THEN
                    "Prod. Order Component".SETRANGE("Prod. Order Component"."Item No.", Test_Item);

                // INCLUDING EXPECTED INWARDS WHICH ARE IN BITWEEN "WORK DATE" AND "PRODUCTION START DATE"(EARLIEST)  AND
                // INCLUDE "QC UNDER INSPECTION QTY" AND "RESERVE MATERIAL WHICH ARE IN MATERIAL REQUESTS"
                DAYS_GAP := (Prod_date - 1) - WORKDATE;
                /*  //commented by pranavi on 23-11-2015 to consider all purchase qty in future
                IF DAYS_GAP>4  THEN
                BEGIN
                  // UPDATING FUTURE PURCHASE MATERIAL INTO VIRTUAL STOCK
                  FOR I:=1 TO DAYS_GAP DO
                    Include_Purchase_Qty(WORKDATE+I);
                END;
                
                *///commented by pranavi on 23-11-2015 to consider all purchase qty in future


                //Include_Item('ECICSDI00245',TRUE);  //pranavi
                //Include_Item('ECICSDI00545',TRUE);  //pranavi
                //Include_Item('ECICSDI00567',TRUE);  //pranavi
                Include_Purchase_Qty(WORKDATE);     //Added by pranavi on 23-11-2015 to consider all purchase qty in future

                FOR I := 0 TO DAYS_GAP - 1 DO BEGIN
                    // CALCULATING THE SHORTAGE FOR SALE ORDER & SCHEDULE REQUIREMENT WHICH ARE PLANNED IN BETWEEN
                    // CURRENT DATE & "EARLIEST PRODUCION START DATE
                    Calculate_Sale_Order_Shortage(WORKDATE + I);
                    Calculate_Sale_Schedule_Shorta(WORKDATE + I);
                END;


                // UPDATING PENDING QC MATERIAL INTO VIRTUAL STOCK
                Include_Qc_Qty;

                // RESERVING MATERIAL FOR "PENDING STORE MATERIAL REQUESTS" IN AVAILABLE VIRTUAL STOCK
                // IF USERID <> 'EFFTRONICS\PRANAVI' THEN
                "Reserve Running Order Material";


                // Dummy Purchase Line Filling  ( IT WILL BE USED FOR SPECIFY "POSSIBLE PRODUCTION START DATE" BASED ON FUTURE MATERIAL ARRIVALS
                "Purchase line".RESET;
                "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
                "Purchase line".SETFILTER("Purchase line"."Deviated Receipt Date", '>%1', WORKDATE);
                "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
                "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR');
                "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
                "Purchase line".SETRANGE("Purchase line"."AMC Order", FALSE);
                IF Test_Item <> '' THEN
                    "Purchase line".SETRANGE("Purchase line"."No.", Test_Item);
                IF "Purchase line".FIND('-') THEN
                    REPEAT
                        PH.SETRANGE(PH."No.", "Purchase line"."Document No.");
                        IF PH.FIND('-') THEN BEGIN
                            IF PH.Status = PH.Status::Released THEN BEGIN
                                Line_no += 10000;
                                Dum_Purch_Line.INIT;
                                Dum_Purch_Line."Document Type" := "Purchase line"."Document Type"::Order;
                                Dum_Purch_Line."Document No." := "Purchase line"."Document No.";
                                Dum_Purch_Line."Line No." := Line_no;
                                Dum_Purch_Line."No." := "Purchase line"."No.";
                                Dum_Purch_Line.Description := "Purchase line".Description;
                                Dum_Purch_Line."Qty. to Receive" := "Purchase line"."Qty. to Receive";
                                Dum_Purch_Line."Deviated Receipt Date" := "Purchase line"."Deviated Receipt Date";
                                Dum_Purch_Line.INSERT;
                            END;
                        END;
                    UNTIL "Purchase line".NEXT = 0;
                "Purchase line".RESET;

                Line_no := 0;
                // "Prod. Order Component".SETFILTER("Prod. Order Component"."Item No.",'ECPCBSS00470');

            end;
        }
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = SORTING("Material Reuired Date", "No.") ORDER(Ascending) WHERE("Posting Group" = CONST('BOI'), "Outstanding Quantity" = FILTER(> 0), "Document Type" = FILTER(Order | "Blanket Order"));
            column(Planned_Purchase_Date_; "Planned Purchase Date")
            {
            }
            column(Sales_Line__Sales_Line___Material_Reuired_Date_; "Sales Line"."Material Reuired Date")
            {
            }
            column(Dum__Reorder_Quantity_; Dum."Reorder Quantity")
            {
            }
            column(To_Be_Shipped_Qty__Dum__Maximum_Inventory_; "To Be Shipped Qty" - Dum."Maximum Inventory")
            {
            }
            column(Dum__Safety_Lead_Time_; Dum."Safety Lead Time")
            {
            }
            column(Sales_Line__Unit_of_Measure_Code_; "Unit of Measure Code")
            {
            }
            column(Sales_Line_Description; Description)
            {
            }
            column(Sales_Line__Document_No__; "Document No.")
            {
            }
            column(Sales_Line__To_Be_Shipped_Qty_; "To Be Shipped Qty")
            {
            }
            column(Sales_Bout_s_PlanCaption; Sales_Bout_s_PlanCaptionLbl)
            {
            }
            column(Planned_Purchase_DateCaption; Planned_Purchase_DateCaptionLbl)
            {
            }
            column(Dispatch_Plan_DateCaption; Dispatch_Plan_DateCaptionLbl)
            {
            }
            column(Overall_Shortage_Caption; Overall_Shortage_CaptionLbl)
            {
            }
            column(Shortage___To_Be_Purchase_Qty__For_That_DayCaption; Shortage___To_Be_Purchase_Qty__For_That_DayCaptionLbl)
            {
            }
            column(Required_QTYCaption; Required_QTYCaptionLbl)
            {
            }
            column(Lead_TimeCaption; Lead_TimeCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(Sale_Order_No_Caption; Sale_Order_No_CaptionLbl)
            {
            }
            column(Sales_Line_Document_Type; "Document Type")
            {
            }
            column(Sales_Line_Line_No_; "Line No.")
            {
            }
            column(Sales_Line_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                SalHeadr.RESET;
                SalHeadr.SETRANGE(SalHeadr."No.", "Sales Line"."Document No.");
                SalHeadr.SETRANGE(SalHeadr."Sale Order Created", FALSE);
                SalHeadr.SETFILTER(SalHeadr."Order Status", '<>%1', SalHeadr."Order Status"::"Temporary Close");
                IF SalHeadr.FINDFIRST THEN    // find sales header where order status is not cancel and sale order not created
                BEGIN
                    // Pranavi
                    NewOutStndingQty := "Sales Line"."Outstanding Quantity";
                    PMIQty := 0;
                    RemPMIQty := 0;
                    InsrtRecLineNo := 0;
                    TempBoutStockTable.RESET;
                    TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", "Sales Line"."Document No.");
                    TempBoutStockTable.SETRANGE(TempBoutStockTable."No.", "Sales Line"."No.");
                    IF TempBoutStockTable.FINDFIRST THEN BEGIN
                        TempBoutStockTable.Quantity += "Sales Line".Quantity;
                        TempBoutStockTable.Quantity += Schedule2.Quantity;
                        IF TempBoutStockTable."Qty. Sent To Quality" > ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity") THEN
                            RemPMIQty := TempBoutStockTable."Qty. Sent To Quality" - ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity")
                        ELSE
                            RemPMIQty := 0;
                        IF RemPMIQty >= "Sales Line"."Outstanding Quantity" THEN BEGIN
                            NewOutStndingQty := 0;
                            TempBoutStockTable."Qty. Sent To Quality" -= "Sales Line"."Outstanding Quantity";
                            TempBoutStockTable.MODIFY;
                        END ELSE BEGIN
                            NewOutStndingQty := "Sales Line"."Outstanding Quantity" - RemPMIQty;
                            TempBoutStockTable."Qty. Sent To Quality" := 0;
                            TempBoutStockTable.MODIFY;
                        END;
                    END ELSE BEGIN
                        TempBoutStockTable.RESET;
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", "Sales Line"."Document No.");
                        IF TempBoutStockTable.FINDLAST THEN
                            InsrtRecLineNo := TempBoutStockTable."Line No." + 1000
                        ELSE
                            InsrtRecLineNo := 1000;
                        TempBoutStockTable.INIT;
                        TempBoutStockTable."Document Type" := "Sales Line"."Document Type";
                        TempBoutStockTable."Document No." := "Sales Line"."Document No.";
                        TempBoutStockTable."Line No." := InsrtRecLineNo;
                        TempBoutStockTable."No." := "Sales Line"."No.";
                        TempBoutStockTable.Quantity += "Sales Line".Quantity;
                        PostdMatIssHedrGRec.RESET;
                        PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", "Sales Line"."Document No.");
                        //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                        PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                        IF PostdMatIssHedrGRec.FINDSET THEN
                            REPEAT
                                PostedMatIssLinGRec.RESET;
                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", "Sales Line"."No.");
                                PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                    PMIQty += PostedMatIssLinGRec.Quantity;
                                END;
                            UNTIL PostdMatIssHedrGRec.NEXT = 0;
                        TempBoutStockTable."Qty. Sent To Quality" := PMIQty;
                        //TempBoutStockTable.INSERT;
                        IF PMIQty >= ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity") THEN
                            RemPMIQty := PMIQty - ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity")
                        ELSE
                            RemPMIQty := 0;
                        IF RemPMIQty >= "Sales Line"."Outstanding Quantity" THEN BEGIN
                            NewOutStndingQty := 0;
                            TempBoutStockTable."Qty. Sent To Quality" -= "Sales Line"."Outstanding Quantity";
                            //TempBoutStockTable.MODIFY;
                        END ELSE BEGIN
                            NewOutStndingQty := "Sales Line"."Outstanding Quantity" - RemPMIQty;
                            TempBoutStockTable."Qty. Sent To Quality" := 0;
                            //TempBoutStockTable.MODIFY;
                        END;
                        TempBoutStockTable.INSERT;
                    END;
                    // Pranavi End
                    IF NOT Dum.GET("Sales Line"."No.") THEN
                        Include_Item("Sales Line"."No.", TRUE);
                    IF Item_Req.GET("Sales Line"."No.") THEN BEGIN
                        Item_Req."Required Quantity" += NewOutStndingQty;
                        Item_Req."Req Qty" += NewOutStndingQty;
                        Item_Req.MODIFY;

                    END ELSE BEGIN
                        Item_Req.INIT;
                        Item_Req."Item No." := "Sales Line"."No.";
                        Item_Req.Description := "Sales Line".Description;
                        Item_Req."Required Quantity" := NewOutStndingQty;
                        Item_Req."Req Qty" := NewOutStndingQty;
                        Item_Req.INSERT;
                    END;

                    IF Dum.GET("Sales Line"."No.") THEN BEGIN
                        IF Dum."Maximum Inventory" >= (NewOutStndingQty) THEN BEGIN
                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - NewOutStndingQty;
                            Dum.MODIFY;
                        END ELSE BEGIN
                            Verify_BOUT_Alternate(Dum."No.", NewOutStndingQty);
                            IF NOT AVB THEN BEGIN
                                IF FORMAT(Dum."Safety Lead Time") <> '' THEN BEGIN
                                    Total_Buffer := '-' + FORMAT(Dum."Safety Lead Time");
                                    "Planned_Purchase (Wit out Buf)" := CALCDATE(Total_Buffer, "Sales Line"."Material Reuired Date");
                                    Total_Buffer := '-' + FORMAT(Buffer);
                                    "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned_Purchase (Wit out Buf)");
                                    // "Planned Purchase Date" := WORKDATE +1; // BY SUJANI ON 28-AUG 1:17 PM
                                    IF "Planned Purchase Date" < WORKDATE THEN BEGIN
                                        "Planned Purchase Date" := 0D;
                                        Dum_Purch_Line.RESET;
                                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", Dum."No.");
                                        Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                        IF Dum_Purch_Line.FIND('-') THEN BEGIN

                                            IF Dum_Purch_Line."Qty. to Receive" > NewOutStndingQty THEN BEGIN
                                                Dum_Purch_Line."Qty. to Receive" -= NewOutStndingQty;
                                                Dum_Purch_Line.MODIFY;
                                                Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date";
                                                Total_Buffer := FORMAT(Buffer);
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                "Sales Line"."Change to Specified Plan Date" := FALSE;
                                                "Sales Line"."Plan Shifting Date" := Possible_Procured_Date;
                                                "Sales Line".MODIFY

                                            END ELSE BEGIN

                                                Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                Total_Buffer := FORMAT(Buffer);
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                "Sales Line"."Change to Specified Plan Date" := FALSE;
                                                "Sales Line"."Plan Shifting Date" := Possible_Procured_Date;
                                                "Sales Line".MODIFY
                                            END;
                                        END ELSE BEGIN
                                            Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                            Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                            Total_Buffer := FORMAT(Buffer);
                                            Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                            "Sales Line"."Change to Specified Plan Date" := FALSE;
                                            "Sales Line"."Plan Shifting Date" := Possible_Procured_Date;
                                            "Sales Line".MODIFY
                                        END;

                                    END;

                                    IF "Planned_Purchase (Wit out Buf)" < WORKDATE THEN
                                        "Planned_Purchase (Wit out Buf)" := 0D;
                                END;

                                IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                    IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                        "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                END;
                                ShortgTemp := 0;
                                ShortgFlag := FALSE;
                                Item_Lot.RESET;
                                Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                Item_Lot.SETRANGE(Item_Lot."Sales Order No.", "Sales Line"."Document No.");
                                Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                IF Item_Lot.FIND('-') THEN BEGIN
                                    //Added by Pranavi on 10-Dec-2015
                                    IF Alternate_Buffer > 0 THEN BEGIN
                                        IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                            ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Dum.MODIFY;
                                            ShortgFlag := TRUE;
                                        END;
                                    END
                                    ELSE BEGIN
                                        ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                        Item_Lot.Shortage += ShortgTemp;
                                        Dum."Maximum Inventory" := 0;
                                        Dum.MODIFY;
                                    END;
                                    /*
                                    IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                    BEGIN
                                      IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                      BEGIN
                                        IF Item_Req.GET(Item_Lot."Item No") THEN
                                        BEGIN
                                          IF ShortgFlag = FALSE THEN
                                          BEGIN
                                          Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                          Item_Req.MODIFY;
                                          END;
                                        END;
                                      END;
                                    END;
                                    */
                                    //End by Pranavi
                                    //Item_Lot.Shortage+=("Sales Line"."Qty. to Ship");   //Commented by Pranavi on 10-Dec-2015
                                    IF ShortgFlag = FALSE THEN
                                        Item_Lot.MODIFY;
                                END ELSE BEGIN
                                    Item_Lot.INIT;
                                    Item_Lot."Item No" := Dum."No.";
                                    Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                    Item_Lot.Description := Dum.Description;
                                    Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                    Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                    Item_Lot."Sales Order No." := "Sales Line"."Document No.";
                                    Item_Lot."Material Required Date" := "Sales Line"."Material Reuired Date";
                                    "Sales Header".RESET;
                                    "Sales Header".SETRANGE("Sales Header"."No.", "Sales Line"."Document No.");
                                    IF "Sales Header".FIND('-') THEN BEGIN
                                        Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                        "Sales Header"."Shortage Calculation" := TRUE;
                                        "Sales Header".MODIFY;
                                    END;
                                    //Added by Pranavi on 10-Dec-2015
                                    IF Alternate_Buffer > 0 THEN BEGIN
                                        IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                            ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Dum.MODIFY;
                                            ShortgFlag := TRUE;
                                        END;
                                    END
                                    ELSE BEGIN
                                        ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                        Item_Lot.Shortage += ShortgTemp;
                                        Dum."Maximum Inventory" := 0;
                                        Dum.MODIFY;
                                    END;
                                    /*
                                    IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                    BEGIN
                                      IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                      BEGIN
                                        IF Item_Req.GET(Item_Lot."Item No") THEN
                                        BEGIN
                                          IF ShortgFlag = FALSE THEN
                                          BEGIN
                                          Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                          Item_Req.MODIFY;
                                          END;
                                        END;
                                      END;
                                    END;
                                    */
                                    //End by Pranavi
                                    /*
                                    IF Dum."Maximum Inventory">0 THEN
                                    BEGIN
                                      Item_Lot.Shortage:=(NewOutStndingQty- Dum."Maximum Inventory");
                                      Dum."Maximum Inventory":=0;
                                      Dum.MODIFY;
                                    END ELSE
                                    Item_Lot.Shortage:=NewOutStndingQty;
                                    *///commented by pranavi on 10-Dec-2015
                                    IF Item_Lot.Shortage > 0 THEN
                                        IF ShortgFlag = FALSE THEN
                                            Item_Lot.INSERT;
                                END;
                            END;
                        END;
                    END;
                END;  // Sales Header Find End

            end;

            trigger OnPostDataItem()
            begin
                //Rev01 Code Copied from //Sales Line, GroupFooter (4) - OnPreSection()

                /*
                IF Dum.GET("Sales Line"."No.") THEN
                BEGIN
                  Within_Buffer:=FALSE;
                  "Sales Line"."Plan Shifting Date":=0D;
                  Dum."Budget Quantity"+="Sales Line"."Outstanding Qty.";
                  Dum."Stock At MCH Location"+="Sales Line"."Outstanding Qty.";
                  Item_Decs:=Dum.Description;
                  "Quantity At Stores":=Dum."Maximum Inventory";
                
                  Dum.MODIFY;
                
                  IF Item_Req.GET("Sales Line"."No.") THEN
                  BEGIN
                    Item_Req."Required Quantity"+="Sales Line"."Outstanding Qty.";
                    Item_Req."Req Qty"+="Sales Line"."Outstanding Qty.";
                    Item_Req.MODIFY;
                  END ELSE
                  BEGIN
                    Item_Req.INIT;
                    Item_Req."Item No.":="Sales Line"."No.";
                    Item_Req.Description:="Sales Line".Description;
                    Item_Req."Required Quantity":="Sales Line"."Outstanding Qty.";
                    Item_Req."Req Qty":="Sales Line"."Outstanding Qty.";
                    Item_Req.INSERT;
                  END;
                
                  IF Dum."Maximum Inventory">"Sales Line"."Outstanding Qty." THEN
                  BEGIN
                   Dum."Maximum Inventory":=Dum."Maximum Inventory"-"Sales Line"."Outstanding Qty.";
                   Dum.MODIFY;
                  END ELSE
                  BEGIN
                    Dum."Reorder Quantity"+=("Sales Line"."Outstanding Qty."-Dum."Maximum Inventory");
                    Dum."Minimum Order Quantity"+=("Sales Line"."Outstanding Qty."-Dum."Maximum Inventory");;
                    Dum."Maximum Inventory":=0;
                    Dum.MODIFY;
                
                    IF FORMAT(Dum."Safety Lead Time") <>'' THEN
                    BEGIN
                      Total_Buffer:='-'+FORMAT(Dum."Safety Lead Time");
                      "Planned_Purchase (Wit out Buf)":=CALCDATE(Total_Buffer,Schedule."Material Required Date");
                      Total_Buffer:='-'+FORMAT(Buffer);
                      "Planned Purchase Date":=CALCDATE(Total_Buffer,"Planned_Purchase (Wit out Buf)");
                      Possible_Procured_Date:=0D;
                      IF "Planned Purchase Date"<WORKDATE THEN
                      BEGIN
                        AVB:=FALSE;
                        Dum_Purch_Line.RESET;
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.","Sales Line"."No.");
                        Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date","Sales Line"."Material Reuired Date"-3,
                                                                                       "Sales Line"."Material Reuired Date"-2 );
                        IF NOT (Dum_Purch_Line.FIND('-')) THEN
                        BEGIN
                          Dum_Purch_Line.RESET;
                          Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.","Sales Line"."No.");
                          Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                          Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date",'>%1',"Sales Line"."Material Reuired Date");
                          IF Dum_Purch_Line.FIND('-') THEN
                          BEGIN
                          REPEAT
                            IF (Dum_Purch_Line."Qty. to Receive">"Sales Line"."Outstanding Qty.") AND (NOT AVB)  THEN
                            BEGIN
                              Dum_Purch_Line."Qty. to Receive"-="Sales Line"."Outstanding Qty.";
                              Dum_Purch_Line.MODIFY;
                              Possible_Procured_Date:=Dum_Purch_Line."Deviated Receipt Date"+2;
                              AVB:=TRUE;
                            END;
                          UNTIL (Dum_Purch_Line.NEXT=0) OR (AVB);
                          IF Possible_Procured_Date=0D THEN
                          BEGIN
                            Total_Buffer:=FORMAT(Dum."Safety Lead Time");
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,WORKDATE);
                            Total_Buffer:=FORMAT(Buffer);
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,Possible_Procured_Date);
                          END;
                          END ELSE
                          BEGIN
                            Total_Buffer:=FORMAT(Dum."Safety Lead Time");
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,WORKDATE);
                            Total_Buffer:=FORMAT(Buffer);
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,Possible_Procured_Date);
                          END;
                        END ELSE
                        BEGIN
                          Within_Buffer:=TRUE;
                          Possible_Procured_Date:=Dum_Purch_Line."Deviated Receipt Date"+2;
                        END;
                
                              "Sales Line"."Change to Specified Plan Date":=FALSE;
                              "Sales Line"."Plan Shifting Date":=Possible_Procured_Date;
                              "Sales Line".MODIFY
                
                
                       { Dum_Purch_Line.RESET;
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.",Dum."No.");
                        Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date","Sales Line"."Material Reuired Date"-3,
                                                                                            "Sales Line"."Material Reuired Date"-2 );
                        IF NOT(Dum_Purch_Line.FIND('-')) THEN
                        BEGIN
                              Total_Buffer:=FORMAT(Dum."Safety Lead Time");
                              Possible_Procured_Date:=CALCDATE(Total_Buffer,WORKDATE);
                              Total_Buffer:=FORMAT(Buffer);
                              Possible_Procured_Date:=CALCDATE(Total_Buffer,Possible_Procured_Date);
                        END;   }
                
                      END;
                
                      IF "Planned_Purchase (Wit out Buf)" <WORKDATE THEN
                        "Planned_Purchase (Wit out Buf)":=0D;
                    END;
                
                    IF "Planned Purchase Date">0D THEN
                    BEGIN
                      IF DATE2DWY("Planned Purchase Date",1)=7 THEN
                         "Planned Purchase Date":="Planned Purchase Date"-1
                
                    END;
                
                    Item_Lot.SETRANGE(Item_Lot."Item No",Dum."No.");
                    Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date","Planned Purchase Date");
                    Item_Lot.SETRANGE(Item_Lot."Sales Order No.","Sales Line"."Document No.");
                    IF NOT(Item_Lot.FIND('-')) THEN
                    BEGIN
                
                      Item_Lot.INIT;
                      Item_Lot."Item No":=Dum."No.";
                      Item_Lot.Description:=Dum.Description;
                      Item_Lot."Planned Purchase Dare (WOB)":="Planned_Purchase (Wit out Buf)";
                      Item_Lot."Planned Date":="Sales Line"."Material Reuired Date";
                      Item_Lot."Planned Purchase Date":="Planned Purchase Date";
                      Item_Lot."Material Required Date":="Sales Line"."Material Reuired Date"-4;
                      "Sales Header".SETRANGE("Sales Header"."No.","Sales Line"."Document No.");
                      IF "Sales Header".FIND('-') THEN
                        Item_Lot."Customer Name":="Sales Header"."Bill-to Name";
                      Item_Lot.Shortage:=("Sales Line"."Outstanding Qty."-Dum."Maximum Inventory");
                      Item_Lot."Sales Order No.":="Sales Line"."Document No.";
                      "Sales Header".RESET;
                      "Sales Header".SETRANGE("Sales Header"."No.","Sales Line"."Document No.");
                      IF "Sales Header".FIND('-') THEN
                      BEGIN
                        Item_Lot."Customer Name":="Sales Header"."Bill-to Name";
                        "Sales Header"."Shortage Calculation":=TRUE;
                        "Sales Header".MODIFY;
                      END;
                
                      Item_Lot."Production Order No.":='';
                      IF Item_Lot.Shortage >0 THEN
                        Item_Lot.INSERT;
                    END ELSE
                      Item_Lot.Shortage+=("Sales Line"."Outstanding Qty."-Dum."Maximum Inventory");
                      Item_Lot.MODIFY;
                    BEGIN
                    END;
                  END;
                END;
                      */

                //Rev01 Code Copied from //Sales Line, GroupFooter (4) - OnPreSection()

            end;

            trigger OnPreDataItem()
            begin
                // THIS IS ALSO SAME AS "PROD. ORDER COMPONENT PROCESS"
                "Sales Line".SETFILTER("Sales Line"."Material Reuired Date", '>%1', "Prod. Order Component"."Production Plan Date");
                IF Test_Item <> '' THEN
                    "Sales Line".SETRANGE("Sales Line"."No.", Test_Item);
            end;
        }
        dataitem(Schedule2; Schedule2)
        {
            DataItemTableView = SORTING("Material Required Date", "No.") ORDER(Ascending) WHERE("Document Type" = FILTER(Order | "Blanket Order"), "Outstanding Qty." = FILTER(> 0), "Posting Group" = CONST('BOI'));
            column(Planned_Purchase_Date__Control1102154035; "Planned Purchase Date")
            {
            }
            column(Schedule2_Schedule2__Material_Required_Date_; Schedule2."Material Required Date")
            {
            }
            column(Dum__Reorder_Quantity__Control1102154037; Dum."Reorder Quantity")
            {
            }
            column(To_be_Shipped_Qty__Dum__Maximum_Inventory__Control1102154038; "To be Shipped Qty" - Dum."Maximum Inventory")
            {
            }
            column(Schedule2__To_be_Shipped_Qty_; "To be Shipped Qty")
            {
            }
            column(Dum__Safety_Lead_Time__Control1102154040; Dum."Safety Lead Time")
            {
            }
            column(Dum__Base_Unit_of_Measure_; Dum."Base Unit of Measure")
            {
            }
            column(Schedule2_Description; Description)
            {
            }
            column(Schedule2__Document_No__; "Document No.")
            {
            }
            column(Schedule_Bout_s_PlanCaption; Schedule_Bout_s_PlanCaptionLbl)
            {
            }
            column(Planned_Purchase_DateCaption_Control1102154015; Planned_Purchase_DateCaption_Control1102154015Lbl)
            {
            }
            column(Dispatch_Plan_DateCaption_Control1102154016; Dispatch_Plan_DateCaption_Control1102154016Lbl)
            {
            }
            column(Overall_Shortage_Caption_Control1102154017; Overall_Shortage_Caption_Control1102154017Lbl)
            {
            }
            column(Shortage___To_Be_Purchase_Qty__For_That_DayCaption_Control1102154018; Shortage___To_Be_Purchase_Qty__For_That_DayCaption_Control1102154018Lbl)
            {
            }
            column(Required_QTYCaption_Control1102154019; Required_QTYCaption_Control1102154019Lbl)
            {
            }
            column(Lead_TimeCaption_Control1102154020; Lead_TimeCaption_Control1102154020Lbl)
            {
            }
            column(UOMCaption_Control1102154021; UOMCaption_Control1102154021Lbl)
            {
            }
            column(ItemCaption_Control1102154022; ItemCaption_Control1102154022Lbl)
            {
            }
            column(Sale_Order_No_Caption_Control1102154033; Sale_Order_No_Caption_Control1102154033Lbl)
            {
            }
            column(Schedule2_Document_Type; "Document Type")
            {
            }
            column(Schedule2_Document_Line_No_; "Document Line No.")
            {
            }
            column(Schedule2_Line_No_; "Line No.")
            {
            }
            column(Schedule2_No_; "No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Schedule2."Document Line No." <> Schedule2."Line No." THEN BEGIN
                    SalHeadr.RESET;
                    SalHeadr.SETRANGE(SalHeadr."No.", Schedule2."Document No.");
                    SalHeadr.SETRANGE(SalHeadr."Sale Order Created", FALSE);
                    SalHeadr.SETFILTER(SalHeadr."Order Status", '<>%1', SalHeadr."Order Status"::"Temporary Close");
                    IF SalHeadr.FINDFIRST THEN    // find sales header where order status is not cancel and sale order not created
                    BEGIN
                        // Pranavi
                        NewOutStndingQty := Schedule2."Outstanding Qty.";
                        PMIQty := 0;
                        RemPMIQty := 0;
                        InsrtRecLineNo := 0;
                        TempBoutStockTable.RESET;
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", Schedule2."Document No.");
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."No.", Schedule2."No.");
                        IF TempBoutStockTable.FINDFIRST THEN BEGIN
                            TempBoutStockTable.Quantity += Schedule2.Quantity;
                            IF TempBoutStockTable."Qty. Sent To Quality" >= (Schedule2.Quantity - Schedule2."Outstanding Qty.") THEN
                                RemPMIQty := TempBoutStockTable."Qty. Sent To Quality" - (Schedule2.Quantity - Schedule2."Outstanding Qty.")
                            ELSE
                                RemPMIQty := 0;
                            IF RemPMIQty >= Schedule2."Outstanding Qty." THEN BEGIN
                                NewOutStndingQty := 0;
                                TempBoutStockTable."Qty. Sent To Quality" -= Schedule2."Outstanding Qty.";
                                TempBoutStockTable.MODIFY;
                            END ELSE BEGIN
                                NewOutStndingQty := Schedule2."Outstanding Qty." - RemPMIQty;
                                TempBoutStockTable."Qty. Sent To Quality" := 0;
                                TempBoutStockTable.MODIFY;
                            END;
                        END ELSE BEGIN
                            TempBoutStockTable.RESET;
                            TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", Schedule2."Document No.");
                            IF TempBoutStockTable.FINDLAST THEN
                                InsrtRecLineNo := TempBoutStockTable."Line No." + 1000
                            ELSE
                                InsrtRecLineNo := 1000;
                            TempBoutStockTable.INIT;
                            TempBoutStockTable."Document Type" := SalHeadr."Document Type";
                            TempBoutStockTable."Document No." := Schedule2."Document No.";
                            TempBoutStockTable."Line No." := InsrtRecLineNo;
                            TempBoutStockTable."No." := Schedule2."No.";
                            TempBoutStockTable.Quantity += Schedule2.Quantity;
                            PostdMatIssHedrGRec.RESET;
                            PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", Schedule2."Document No.");
                            //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                            PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                            IF PostdMatIssHedrGRec.FINDSET THEN
                                REPEAT
                                    PostedMatIssLinGRec.RESET;
                                    PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                    PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", Schedule2."No.");
                                    PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                    IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                        PMIQty += PostedMatIssLinGRec.Quantity;
                                    END;
                                UNTIL PostdMatIssHedrGRec.NEXT = 0;
                            TempBoutStockTable."Qty. Sent To Quality" := PMIQty;
                            //TempBoutStockTable.INSERT;
                            IF PMIQty >= (Schedule2.Quantity - Schedule2."Outstanding Qty.") THEN
                                RemPMIQty := PMIQty - (Schedule2.Quantity - Schedule2."Outstanding Qty.")
                            ELSE
                                RemPMIQty := 0;
                            IF RemPMIQty >= Schedule2."Outstanding Qty." THEN BEGIN
                                NewOutStndingQty := 0;
                                TempBoutStockTable."Qty. Sent To Quality" -= Schedule2."Outstanding Qty.";
                                //TempBoutStockTable.MODIFY;
                            END ELSE BEGIN
                                NewOutStndingQty := Schedule2."Outstanding Qty." - RemPMIQty;
                                TempBoutStockTable."Qty. Sent To Quality" := 0;
                                //TempBoutStockTable.MODIFY;
                            END;
                            TempBoutStockTable.INSERT;
                        END;
                        // Pranavi End
                        IF NOT Dum.GET(Schedule2."No.") THEN
                            Include_Item(Schedule2."No.", TRUE);

                        DUm_Stk := NewOutStndingQty;
                        Dum_Po := Schedule2."Document No.";
                        /* IF Schedule."No."='ECBOUBT00004' THEN
                         BEGIN
                           MESSAGE('tABLE-- '+FORMAT(DUm_Stk));
                           MESSAGE(Dum_Po);
                         END;  */
                        IF Item_Req.GET(Schedule2."No.") THEN BEGIN
                            Item_Req."Required Quantity" += NewOutStndingQty;
                            Item_Req."Req Qty" += NewOutStndingQty;
                            Item_Req.MODIFY;

                        END ELSE BEGIN
                            Item_Req.INIT;
                            Item_Req."Item No." := Schedule2."No.";
                            Item_Req.Description := Dum.Description;
                            Item_Req."Required Quantity" := NewOutStndingQty;
                            Item_Req."Req Qty" := NewOutStndingQty;
                            Item_Req.INSERT;
                        END;

                        IF Dum.GET(Schedule2."No.") THEN BEGIN
                            IF Dum."Maximum Inventory" >= (NewOutStndingQty) THEN BEGIN
                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - NewOutStndingQty;
                                Dum.MODIFY;
                            END ELSE BEGIN
                                Verify_BOUT_Alternate(Dum."No.", NewOutStndingQty);
                                IF NOT AVB THEN BEGIN
                                    IF FORMAT(Dum."Safety Lead Time") <> '' THEN BEGIN
                                        Total_Buffer := '-' + FORMAT(Dum."Safety Lead Time");
                                        "Planned_Purchase (Wit out Buf)" := CALCDATE(Total_Buffer, Schedule2."Material Required Date");
                                        Total_Buffer := '-' + FORMAT(Buffer);
                                        "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned_Purchase (Wit out Buf)");
                                        // "Planned Purchase Date" := WORKDATE +1;
                                        IF "Planned Purchase Date" < WORKDATE THEN BEGIN
                                            "Planned Purchase Date" := 0D;
                                            Dum_Purch_Line.RESET;
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", Dum."No.");
                                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                            IF Dum_Purch_Line.FIND('-') THEN BEGIN
                                                IF Dum_Purch_Line."Qty. to Receive" > NewOutStndingQty THEN BEGIN
                                                    Dum_Purch_Line."Qty. to Receive" -= NewOutStndingQty;
                                                    Dum_Purch_Line.MODIFY;
                                                    Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date";
                                                    Total_Buffer := FORMAT(Buffer);
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                    Schedule2."Change To Specified Plan Date" := FALSE;
                                                    Schedule2."Plan Shifting Date" := Possible_Procured_Date;
                                                    Schedule2.MODIFY

                                                END ELSE BEGIN

                                                    Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                    Total_Buffer := FORMAT(Buffer);
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                    Schedule2."Change To Specified Plan Date" := FALSE;
                                                    Schedule2."Plan Shifting Date" := Possible_Procured_Date;
                                                    Schedule2.MODIFY
                                                END;
                                            END ELSE BEGIN
                                                Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                Total_Buffer := FORMAT(Buffer);
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                Schedule2."Change To Specified Plan Date" := FALSE;
                                                Schedule2."Plan Shifting Date" := Possible_Procured_Date;
                                                Schedule2.MODIFY
                                            END;

                                        END;

                                        IF "Planned_Purchase (Wit out Buf)" < WORKDATE THEN
                                            "Planned_Purchase (Wit out Buf)" := 0D;
                                    END;

                                    IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                        IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                            "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                    END;
                                    ShortgTemp := 0;
                                    ShortgFlag := FALSE;
                                    Item_Lot.RESET;
                                    Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                    Item_Lot.SETRANGE(Item_Lot."Sales Order No.", Schedule2."Document No.");
                                    Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                    IF Item_Lot.FIND('-') THEN BEGIN
                                        //Added by Pranavi on 10-Dec-2015
                                        IF Alternate_Buffer > 0 THEN BEGIN
                                            IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END
                                            ELSE BEGIN
                                                ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Dum.MODIFY;
                                                ShortgFlag := TRUE;
                                            END;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END;
                                        /*
                                        IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                        BEGIN
                                          IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                          BEGIN
                                            IF Item_Req.GET(Item_Lot."Item No") THEN
                                            BEGIN
                                              IF ShortgFlag = FALSE THEN
                                              BEGIN
                                              Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                              Item_Req.MODIFY;
                                              END;
                                            END;
                                          END;
                                        END;
                                        */
                                        //End by Pranavi
                                        //Item_Lot.Shortage+=(Schedule2."To be Shipped Qty");   //Commented By Pranavi on 10-Dec-2015
                                        IF ShortgFlag = FALSE THEN
                                            Item_Lot.MODIFY;
                                    END ELSE BEGIN
                                        Item_Lot.INIT;
                                        Item_Lot."Item No" := Dum."No.";
                                        Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                        Item_Lot.Description := Dum.Description;
                                        Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                        Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                        Item_Lot."Sales Order No." := Schedule2."Document No.";
                                        Item_Lot."Material Required Date" := Schedule2."Material Required Date";
                                        "Sales Header".RESET;
                                        "Sales Header".SETRANGE("Sales Header"."No.", Schedule2."Document No.");
                                        IF "Sales Header".FIND('-') THEN BEGIN
                                            Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                            "Sales Header"."Shortage Calculation" := TRUE;
                                            "Sales Header".MODIFY;
                                        END;
                                        /*
                                        IF Dum."Maximum Inventory">0 THEN
                                        BEGIN
                                          Item_Lot.Shortage:=(NewOutStndingQty- Dum."Maximum Inventory");
                                          Dum."Maximum Inventory":=0;
                                          Dum.MODIFY;
                                        END ELSE
                                        Item_Lot.Shortage:=NewOutStndingQty;
                                        *///commented by pranavi on 10-Dec-2015
                                          //Added by Pranavi on 10-Dec-2015
                                        IF Alternate_Buffer > 0 THEN BEGIN
                                            IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END
                                            ELSE BEGIN
                                                ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Dum.MODIFY;
                                                ShortgFlag := TRUE;
                                            END;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END;
                                        /*
                                        IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                        BEGIN
                                          IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                          BEGIN
                                            IF Item_Req.GET(Item_Lot."Item No") THEN
                                            BEGIN
                                              IF ShortgFlag = FALSE THEN
                                              BEGIN
                                              Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                              Item_Req.MODIFY;
                                              END;
                                            END;
                                          END;
                                        END;
                                        */
                                        //End by Pranavi
                                        IF Item_Lot.Shortage > 0 THEN
                                            IF ShortgFlag = FALSE THEN
                                                Item_Lot.INSERT;
                                    END;
                                END;
                            END;
                        END;
                    END; // End of Sales Header Find
                END;  // End of Doc line No. <> line No.

            end;

            trigger OnPostDataItem()
            begin
                //Rev01 code Copied From //Schedule2, GroupFooter (4) - OnPreSection()

                /*
                IF Dum.GET(Schedule."No.") THEN
                BEGIN
                  Within_Buffer:=FALSE;
                  Dum."Budget Quantity"+=Schedule."Outstanding Qty.";
                  Dum."Stock At MCH Location"+=Schedule."Outstanding Qty.";
                  Item_Decs:=Dum.Description;
                  "Quantity At Stores":=Dum."Maximum Inventory";
                
                  Dum.MODIFY;
                
                  IF Dum."Maximum Inventory">Schedule."Outstanding Qty." THEN
                  BEGIN
                   Dum."Maximum Inventory":=Dum."Maximum Inventory"-Schedule."Outstanding Qty.";
                   Dum.MODIFY;
                  END ELSE
                  BEGIN
                    Dum."Reorder Quantity"+=(Schedule."Outstanding Qty."-Dum."Maximum Inventory");
                    Dum."Minimum Order Quantity"+=(Schedule."Outstanding Qty."-Dum."Maximum Inventory");;
                    Dum."Maximum Inventory":=0;
                    Dum.MODIFY;
                
                    IF FORMAT(Dum."Safety Lead Time") <>'' THEN
                    BEGIN
                      Total_Buffer:='-'+FORMAT(Dum."Safety Lead Time");
                      "Planned_Purchase (Wit out Buf)":=CALCDATE(Total_Buffer,Schedule."Material Required Date");
                      Total_Buffer:='-'+FORMAT(Buffer);
                      "Planned Purchase Date":=CALCDATE(Total_Buffer,"Planned_Purchase (Wit out Buf)");
                      Possible_Procured_Date:=0D;
                      IF "Planned Purchase Date"<WORKDATE THEN
                      BEGIN
                        AVB:=FALSE;
                        "Planned Purchase Date":=0D;
                        Dum_Purch_Line.RESET;
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.",Schedule."No.");
                        Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date",Schedule."Material Required Date"-3,
                                                                                       Schedule."Material Required Date"-2 );
                        IF NOT (Dum_Purch_Line.FIND('-')) THEN
                        BEGIN
                          Dum_Purch_Line.RESET;
                          Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.",Schedule."No.");
                          Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                          Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date",'>%1',Schedule."Material Required Date");
                          IF Dum_Purch_Line.FIND('-') THEN
                          BEGIN
                          REPEAT
                            IF (Dum_Purch_Line."Qty. to Receive">Schedule."Outstanding Qty." ) AND (NOT AVB) THEN
                            BEGIN
                              Dum_Purch_Line."Qty. to Receive"-=Schedule."Outstanding Qty.";
                              Dum_Purch_Line.MODIFY;
                              Possible_Procured_Date:=Dum_Purch_Line."Deviated Receipt Date"+2;
                              AVB:=TRUE;
                            END;
                
                          UNTIL (Dum_Purch_Line.NEXT=0) OR (AVB);
                          IF Possible_Procured_Date=0D THEN
                          BEGIN
                            Total_Buffer:=FORMAT(Dum."Safety Lead Time");
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,WORKDATE);
                            Total_Buffer:=FORMAT(Buffer);
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,Possible_Procured_Date);
                          END;
                          END ELSE
                          BEGIN
                            Total_Buffer:=FORMAT(Dum."Safety Lead Time");
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,WORKDATE);
                            Total_Buffer:=FORMAT(Buffer);
                            Possible_Procured_Date:=CALCDATE(Total_Buffer,Possible_Procured_Date);
                            END;
                        END ELSE
                        BEGIN
                          Within_Buffer:=TRUE;
                          Possible_Procured_Date:=Dum_Purch_Line."Deviated Receipt Date"+2;
                        END;
                        Schedule."Change To Specified Plan Date":=FALSE;
                        Schedule."Plan Shifting Date":=Possible_Procured_Date;
                        Schedule.MODIFY;
                      END;
                      IF "Planned_Purchase (Wit out Buf)" <WORKDATE THEN
                         "Planned_Purchase (Wit out Buf)":=0D;
                    END;
                    IF "Planned Purchase Date">0D THEN
                    BEGIN
                      IF DATE2DWY("Planned Purchase Date",1)=7 THEN
                         "Planned Purchase Date":="Planned Purchase Date"-1
                    END;
                
                    Item_Lot.SETRANGE(Item_Lot."Item No",Dum."No.");
                    Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date","Planned Purchase Date");
                    Item_Lot.SETRANGE(Item_Lot."Sales Order No.",Schedule."Document No.");
                    IF NOT(Item_Lot.FIND('-')) THEN
                    BEGIN
                
                      Item_Lot.INIT;
                      Item_Lot."Item No":=Dum."No.";
                      Item_Lot.Description:=Dum.Description;
                      Item_Lot."Planned Purchase Dare (WOB)":="Planned_Purchase (Wit out Buf)";
                      Item_Lot."Planned Date":=Schedule."Material Required Date";
                      Item_Lot."Planned Purchase Date":="Planned Purchase Date";
                      Item_Lot."Material Required Date":=Schedule."Material Required Date"-4;
                      "Sales Header".SETRANGE("Sales Header"."No.",Schedule."Document No.");
                      IF "Sales Header".FIND('-') THEN
                        Item_Lot."Customer Name":="Sales Header"."Bill-to Name";
                      Item_Lot.Shortage:=(Schedule."Outstanding Qty."-Dum."Maximum Inventory");
                      Item_Lot."Sales Order No.":=Schedule."Document No.";
                      "Sales Header".RESET;
                      "Sales Header".SETRANGE("Sales Header"."No.",Schedule."Document No.");
                      IF "Sales Header".FIND('-') THEN
                      BEGIN
                        Item_Lot."Customer Name":="Sales Header"."Bill-to Name";
                        "Sales Header"."Shortage Calculation":=TRUE;
                        "Sales Header".MODIFY;
                      END;
                
                      Item_Lot."Production Order No.":='';
                      IF Item_Lot.Shortage >0 THEN
                        Item_Lot.INSERT;
                    END ELSE
                      Item_Lot.Shortage+=(Schedule."Outstanding Qty."-Dum."Maximum Inventory");
                      Item_Lot.MODIFY;
                    BEGIN
                    END;
                  END;
                END;  */

                //Rev01 code Copied From //Schedule2, GroupFooter (4) - OnPreSection()

            end;

            trigger OnPreDataItem()
            begin
                // THIS IS ALSO SAME AS "PROD. ORDER COMPONENT PROCESS"
                Schedule2.SETFILTER(Schedule2."Material Required Date", '>%1', "Prod. Order Component"."Production Plan Date");
                IF Test_Item <> '' THEN
                    Schedule2.SETRANGE(Schedule2."No.", Test_Item);
            end;
        }
        dataitem("Saftey Items"; Item)
        {
            DataItemTableView = WHERE("Safety Stock Quantity" = FILTER(> 0), "Product Group Code Cust" = FILTER('<> FPRODUCT & <> CPCB'));

            trigger OnAfterGetRecord()
            begin
                "Saftey Items".CALCFIELDS("Saftey Items"."Stock at PROD Stores");
                /*Shortage_Details.RESET;
                Shortage_Details.SETRANGE(Shortage_Details."Item No","Saftey Items"."No.");
                IF NOT Shortage_Details.FINDFIRST THEN
                BEGIN
                
                  IF ("Saftey Items"."Safety Stock Quantity">("Saftey Items"."Stock at Stores"+"Saftey Items"."Stock at PROD Stores"
                                +PO_QTY("Saftey Items"."No."))) THEN
                    Include_Saftey_Stock_Quantity("Saftey Items"."No.",
                    ("Saftey Items"."Safety Stock Quantity"-("Saftey Items"."Stock at Stores"+"Saftey Items"."Stock at PROD Stores"+
                                                              PO_QTY("Saftey Items"."No."))));
                END;
                */
                Dum.RESET;
                //IF("Saftey Items"."No."='ECPCBSS00599') THEN
                //MESSAGE('"Saftey Items"."No."');

                //IF("Saftey Items"."No."='ECPCBDS00514') THEN
                //MESSAGE('"Saftey Items"."No."');


                IF NOT (Dum.GET("Saftey Items"."No.")) THEN BEGIN
                    Include_Item("Saftey Items"."No.", TRUE);
                    Include_Purchase_Qty_min("Saftey Items"."No.");
                    Include_Qc_Qty_min("Saftey Items"."No.");
                END;


                IF Dum.GET("Saftey Items"."No.") THEN BEGIN
                    IF "Saftey Items"."Safety Stock Quantity" > Dum."Maximum Inventory" THEN BEGIN
                        // Include_Saftey_Stock_Quantity1("Saftey Items"."No.",("Saftey Items"."Safety Stock Quantity"-Dum."Maximum Inventory"));
                    END;
                END;

            end;

            trigger OnPreDataItem()
            begin
                // THE PURPOSE OF THIS DATA ITEM IS FOR
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

        Buffer := '15D'; // changed by Vishnu Priya on 19-08-2020 from 7D to 15D by the Anil Sir input
        //EVALUATE(tempdate,'31-08-2016');
    end;

    trigger OnPostReport()
    begin

        Plan_Change.Update_Sale_Order_Info;
        IF USERID <> 'EFFTRONICS\PRANAVI' THEN BEGIN
            Item_Lot.RESET;
            Item_Lot.SETFILTER(Item_Lot."Sales Order No.", '%1&<>%2&<>%3', '*EXP*', '*EXP*/L*', '*EXP*/T*');
            Item_Lot.SETFILTER(Item_Lot."Lead Time", '2D|4D|7D|15D');
            IF Item_Lot.FINDSET THEN BEGIN
                Item_Lot.DELETEALL;
            END;
        END;
        // commented by Pranavi on 08-mar-2016

        /*
        Item_Lot.RESET;
        Item_Lot.SETFILTER(Item_Lot."Sales Order No.",'%1&<>%2&<>%3','*EXP*','*EXP
        Item_Lot.SETFILTER(Item_Lot."Lead Time", '2D|4D|7D|15D');
        IF Item_Lot.FINDSET THEN
            REPEAT
                ProdOrdrTemp.RESET;
                ProdOrdrTemp.SETRANGE(ProdOrdrTemp.Status, ProdOrdrTemp.Status::Released);
                ProdOrdrTemp.SETRANGE(ProdOrdrTemp."No.", Item_Lot."Production Order No.");
                ProdOrdrTemp.SETFILTER(ProdOrdrTemp."Planned Dispatch Date", '<=%1', tempdate);
                IF NOT ProdOrdrTemp.FINDFIRST THEN
                    Item_Lot.DELETE;
            UNTIL Item_Lot.NEXT = 0;
        */
        /*
        TempTableText:='Doc Type    Doc No.       Line No.    No.       Qty     PMIQty\';
        TempBoutStockTable.RESET;
        IF TempBoutStockTable.FINDSET THEN
        REPEAT
          TempTableText+=FORMAT(TempBoutStockTable."Document Type")+'   '+TempBoutStockTable."Document No."+'   '+FORMAT(TempBoutStockTable."Line No.")+
                    '   '+TempBoutStockTable."No."+'    '+FORMAT(TempBoutStockTable.Quantity)+'    '+FORMAT(TempBoutStockTable."Qty. Sent To Quality")+'\';
        UNTIL TempBoutStockTable.NEXT=0;
        MESSAGE(TempTableText);
        */

    end;

    var
        Prod_date: Date;
        Item: Record Item;
        "Quantity At Stores": Decimal;
        Item_Decs: Text[100];
        Dum: Record Item temporary;
        "Shortage Quantity": Decimal;
        PBMH: Record "Production BOM Header";
        PO: Record "Production Order";
        QTY: array[30] of Integer;
        REQ_QTY: Decimal;
        pbml: Record "Production BOM Line";
        "Sub BOM's": Text[1000];
        POS: Integer;
        CNT: Integer;
        SNO: Integer;
        "Order Date": Date;
        "Expected date": Date;
        "Purchase line": Record "Purchase Line";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        PBML2: Record "Production BOM Line";
        "Break": Boolean;
        "Stock AT Stores": Decimal;
        ILE: Record "Item Ledger Entry";
        Excel: Boolean;
        Choice: Option Shortage,Total;
        BOM_DUM: array[30] of Record Item temporary;
        PBML3: Record "Production BOM Line";
        Desc1: Text[100];
        Desc2: Text[100];
        Desc3: Text[100];
        Shortage_ByConsidering_Previou: Decimal;
        StockAtStores: Integer;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        Stock: Decimal;
        BOMName: Text[100];
        ItemLedgEntry1: Record "Item Ledger Entry";
        BOUT: Record "Bin Type";
        Update_Consumption: Boolean;
        Item_Consume_Update: Record Item;
        QC_Report: Boolean;
        PRL: Record "Purch. Rcpt. Line";
        IRS: Record "Inspection Receipt Header";
        First: Boolean;
        QC_From_Date: Date;
        QC_To_Date: Date;
        QC_ROW: Integer;
        BOM_Product_Group: Code[20];
        Inward_Count: Integer;
        "Expected Dates": Text[200];
        Orders: Text[1000];
        Plan_Date_Req_Qty: Decimal;
        Previous_Plan_Date: Date;
        "Planned Purchase Date": Date;
        Buffer: Text[30];
        Total_Buffer: Text[30];
        To_Be_Purchasing_Qty: Decimal;
        "Sr No.": Integer;
        Printed: Boolean;
        No_Of_Days: Integer;
        Consider_Production_Plan: Boolean;
        Month: Text[30];
        QILE: Record "Quality Item Ledger Entry";
        "Indent Header": Record "Indent Header";
        "Indent line": Record "Indent Line";
        Line_no: Integer;
        "No.": Code[20];
        "Planned_Purchase (Wit out Buf)": Date;
        Item_Lot: Record "Item Lot Numbers";
        Calculate_Stock: Boolean;
        Final_Date: Date;
        "Remove Old Data": Boolean;
        Selection: Integer;
        Text001: Label 'Delete Old Indents,Don''t Delete the Indents';
        Del: Boolean;
        "Sunday's": Integer;
        "Sales Header": Record "Sales Header";
        ProdOrderCmpnt: Record "Prod. Order Component";
        "Material Issues Line": Record "Material Issues Line";
        "Qc Added": Boolean;
        "Start Date": Integer;
        "Alternative Items": Record "Alternate Items";
        Alter_PO: Record "Production Order";
        DUm_Stk: Decimal;
        DUm_Req: Decimal;
        Dum_Item: Code[20];
        Dum_Po: Code[20];
        AVB: Boolean;
        DAYS_GAP: Integer;
        I: Integer;
        "G|L": Record "General Ledger Setup";
        Test_Item: Code[20];
        Possible_Procured_Date: Date;
        Possible_Plan_Changed_Date: Date;
        "Qty. In Issues & Req": Decimal;
        Dum_Purch_Line: Record "Purchase Line" temporary;
        Alternate_Buffer: Decimal;
        Within_Buffer: Boolean;
        Item_Req: Record "Item wise Requirement";
        PH: Record "Purchase Header";
        Shortage_Details: Record "Item Lot Numbers";
        Plan_Change: Codeunit "Plan Change";
        ITEM_LEAD_TIME: Integer;
        "Manf. Setup": Record "Manufacturing Setup";
        Sales_Bout_s_PlanCaptionLbl: Label 'Sales Bout''s Plan';
        Planned_Purchase_DateCaptionLbl: Label 'Planned Purchase Date';
        Dispatch_Plan_DateCaptionLbl: Label 'Dispatch Plan Date';
        Overall_Shortage_CaptionLbl: Label 'Overall Shortage ';
        Shortage___To_Be_Purchase_Qty__For_That_DayCaptionLbl: Label 'Shortage / To Be Purchase Qty. For That Day';
        Required_QTYCaptionLbl: Label 'Required QTY';
        Lead_TimeCaptionLbl: Label 'Lead Time';
        UOMCaptionLbl: Label 'UOM';
        ItemCaptionLbl: Label 'Item';
        Sale_Order_No_CaptionLbl: Label 'Sale Order No.';
        Schedule_Bout_s_PlanCaptionLbl: Label 'Schedule Bout''s Plan';
        Planned_Purchase_DateCaption_Control1102154015Lbl: Label 'Planned Purchase Date';
        Dispatch_Plan_DateCaption_Control1102154016Lbl: Label 'Dispatch Plan Date';
        Overall_Shortage_Caption_Control1102154017Lbl: Label 'Overall Shortage ';
        Shortage___To_Be_Purchase_Qty__For_That_DayCaption_Control1102154018Lbl: Label 'Shortage / To Be Purchase Qty. For That Day';
        Required_QTYCaption_Control1102154019Lbl: Label 'Required QTY';
        Lead_TimeCaption_Control1102154020Lbl: Label 'Lead Time';
        UOMCaption_Control1102154021Lbl: Label 'UOM';
        ItemCaption_Control1102154022Lbl: Label 'Item';
        Sale_Order_No_Caption_Control1102154033Lbl: Label 'Sale Order No.';
        ShortgFlag: Boolean;
        ShortgTemp: Decimal;
        Shortgvalue: Decimal;
        PO1: Record "Production Order";
        Itm: Record Item;
        ExpFlag: Boolean;
        PODateVar: Date;
        Mail_count: Integer;
        Polist: Text;
        PurchHeadr: Record "Purchase Header";
        PurchLineGRec: Record "Purchase Line";
        Auto: Boolean;
        SalHeadr: Record "Sales Header";
        TempBoutStockTable: Record "Sales Line" temporary;
        InsrtRecLineNo: Integer;
        NewOutStndingQty: Decimal;
        PostdMatIssHedrGRec: Record "Posted Material Issues Header";
        PostedMatIssLinGRec: Record "Posted Material Issues Line";
        PMIQty: Decimal;
        TempTableText: Text;
        RemPMIQty: Decimal;
        ProdOrdrTemp: Record "Production Order";
        tempdate: Date;


    procedure Include_Purchase_Qty("Plan Date": Date)
    begin
        /* //previous code commenting by pranavi on 23-11-2015 for considering all purchase qty
        "Purchase line".RESET;
        "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive",'>%1',0);
        "Purchase line".SETRANGE("Purchase line"."Deviated Receipt Date","Plan Date"-4);
        "Purchase line".SETRANGE("Purchase line"."Location Code",'STR');
        "Purchase line".SETFILTER("Purchase line"."Document Type",'ORDER');
        IF Test_Item<>'' THEN
        "Purchase line".SETRANGE("Purchase line"."No.",Test_Item);
        IF "Purchase line".FIND('-') THEN
        REPEAT
         //IF("Purchase line"."No."='ECPCBDS00514') THEN
         //MESSAGE('"Saftey Items"."No."');
        
         //IF("Purchase line"."No."='ECPCBSS00599') THEN
         //MESSAGE('"Saftey Items"."No."');
        
        
          IF NOT Dum.GET("Purchase line"."No.") THEN
             Include_Item("Purchase line"."No.",FALSE);
          IF Dum.GET("Purchase line"."No.") THEN
          BEGIN
            Dum."Maximum Inventory"+="Purchase line"."Qty. to Receive";
            Dum."Stock at Stores"+="Purchase line"."Qty. to Receive";
            Dum.MODIFY;
          END;
        UNTIL "Purchase line".NEXT=0;
        */ //previous code commenting by pranavi on 23-11-2015 for considering all purchase qty
        //New code added by pranavi on 23-11-2015 for considering all purchase qty
        "Purchase line".RESET;
        "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
        //IF USERID = 'EFFTRONICS\PRANAVI' THEN
        //  "Purchase line".SETFILTER("Purchase line"."No.",'%1','ECRESSD00036');
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
        //"Purchase line".SETRANGE("Purchase line"."Deviated Receipt Date","Plan Date"-4);  //commented by pranavi
        "Purchase line".SETFILTER("Purchase line"."Deviated Receipt Date", '>=%1', WORKDATE);  //added by pranavi
        "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR');
        "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
        IF Test_Item <> '' THEN
            "Purchase line".SETRANGE("Purchase line"."No.", Test_Item);
        IF "Purchase line".FIND('-') THEN
            REPEAT

                /*IF("Purchase line"."No."='ECREGPV00050') THEN
                MESSAGE('"Saftey Items"."No."');*/

                //IF("Purchase line"."No."='ECPCBSS00599') THEN
                //MESSAGE('"Saftey Items"."No."');


                IF NOT Dum.GET("Purchase line"."No.") THEN
                    Include_Item("Purchase line"."No.", FALSE);
                IF Dum.GET("Purchase line"."No.") THEN BEGIN
                    /*IF Dum."No." = 'ECREGPV00050' THEN
                         MESSAGE('dum no %1',Dum."No.");*/
                    Dum."Maximum Inventory" += "Purchase line"."Qty. to Receive";
                    Dum."Stock at Stores" += "Purchase line"."Qty. to Receive";
                    Dum.MODIFY;
                END;
            UNTIL "Purchase line".NEXT = 0;
        //New code added by pranavi on 23-11-2015 for considering all purchase qty

    end;


    procedure Include_Purchase_Qty_min(NO: Code[30])
    begin

        "Purchase line".RESET;
        "Purchase line".SETCURRENTKEY("Purchase line"."Deviated Receipt Date");
        "Purchase line".SETFILTER("Purchase line"."No.", NO);
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
        //"Purchase line".SETRANGE("Purchase line"."Deviated Receipt Date","Plan Date"-4);
        "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR');
        "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
        IF Test_Item <> '' THEN
            "Purchase line".SETRANGE("Purchase line"."No.", Test_Item);
        IF "Purchase line".FIND('-') THEN
            REPEAT
                IF NOT Dum.GET("Purchase line"."No.") THEN
                    Include_Item("Purchase line"."No.", FALSE);
                IF Dum.GET("Purchase line"."No.") THEN BEGIN
                    Dum."Maximum Inventory" += "Purchase line"."Qty. to Receive";
                    Dum."Stock at Stores" += "Purchase line"."Qty. to Receive";
                    Dum.MODIFY;
                END;
            UNTIL "Purchase line".NEXT = 0;
    end;


    procedure Include_Qc_Qty()
    begin
        // FILTERING THE QC PENDING INWARDS & UPDATE THOSE INFORMATION INTO VIRTUAL STOCK
        QILE.RESET;
        QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
        //QILE.SETFILTER(QILE."Item No.",'%1|%2|%3','ECICSDI00245','ECICSDI00545','ECICSDI00567');
        QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
        QILE.SETRANGE(QILE."Sent for Rework", FALSE);
        QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
        QILE.SETRANGE(QILE."Location Code", 'STR');
        QILE.SETRANGE(QILE.Accept, TRUE);
        IF Test_Item <> '' THEN
            QILE.SETRANGE(QILE."Item No.", Test_Item);

        IF QILE.FIND('-') THEN
            REPEAT
                IF NOT Dum.GET(QILE."Item No.") THEN
                    Include_Item(QILE."Item No.", FALSE);

                IF Dum.GET(QILE."Item No.") THEN BEGIN
                    Dum."Maximum Inventory" += QILE."Remaining Quantity";
                    Stock := Dum."Maximum Inventory";
                    Dum."Stock at Stores" += QILE."Remaining Quantity";
                    Dum.MODIFY;
                END;
            UNTIL QILE.NEXT = 0;
    end;


    procedure Include_Qc_Qty_min(NO: Code[30])
    begin
        // FILTERING THE QC PENDING INWARDS & UPDATE THOSE INFORMATION INTO VIRTUAL STOCK
        QILE.RESET;
        QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
        QILE.SETRANGE(QILE."Item No.", NO);
        QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
        QILE.SETRANGE(QILE."Sent for Rework", FALSE);
        QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
        QILE.SETRANGE(QILE."Location Code", 'STR');
        QILE.SETRANGE(QILE.Accept, TRUE);
        IF Test_Item <> '' THEN
            QILE.SETRANGE(QILE."Item No.", Test_Item);

        IF QILE.FIND('-') THEN
            REPEAT
                IF NOT Dum.GET(QILE."Item No.") THEN
                    Include_Item(QILE."Item No.", FALSE);

                IF Dum.GET(QILE."Item No.") THEN BEGIN
                    Dum."Maximum Inventory" += QILE."Remaining Quantity";
                    Stock := Dum."Maximum Inventory";
                    Dum."Stock at Stores" += QILE."Remaining Quantity";
                    Dum.MODIFY;
                END;
            UNTIL QILE.NEXT = 0;
    end;

    procedure "Reserve Running Order Material"()
    begin
        // FILTERING THE PENDING  MATERIAL REQUETS BASED ON FOLLOWING CONDITIONS
        // 1) TRANSFER- FROM -CODE MUST BE "STR" & TRANSFER-TO-CODE MUST BE "PROD"
        // 2) REQUEST MUST BE RELEASED


        "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.",
                                             "Material Issues Line"."Prod. Order No.",
                                             "Material Issues Line"."Prod. Order Line No.");

        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
        //"Material Issues Line".SETRANGE("Material Issues Line"."Item No.",'ECPCBSS00635');
        "Material Issues Line".SETRANGE("Material Issues Line".Status, "Material Issues Line".Status::Released);
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-from Code", 'STR');
        "Material Issues Line".SETRANGE("Material Issues Line"."Transfer-to Code", 'PROD');
        IF Test_Item <> '' THEN
            "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", Test_Item);
        IF "Material Issues Line".FIND('-') THEN
            REPEAT
                IF NOT Dum.GET("Material Issues Line"."Item No.") THEN
                    Include_Item("Material Issues Line"."Item No.", FALSE);
                // VERIFYING THAT MATERIAL IS PLANNED IN FUTURE PRODUCTION (OR) NOT
                ProdOrderCmpnt.RESET;
                ProdOrderCmpnt.SETCURRENTKEY(ProdOrderCmpnt."Production Plan Date", ProdOrderCmpnt."Item No."
                                                     , ProdOrderCmpnt."Prod. Order No.");
                ProdOrderCmpnt.SETFILTER(ProdOrderCmpnt."Production Plan Date", '>%1', WORKDATE);
                ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Item No.", "Material Issues Line"."Item No.");
                IF (ProdOrderCmpnt.FIND('-')) THEN BEGIN
                    ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order No.", "Material Issues Line"."Prod. Order No.");
                    ProdOrderCmpnt.SETRANGE(ProdOrderCmpnt."Prod. Order Line No.", "Material Issues Line"."Prod. Order Line No.");
                    IF NOT (ProdOrderCmpnt.FIND('-')) THEN BEGIN
                        // UPDATING INFORMATION INTO VIRTUAL STOCK
                        IF Dum.GET("Material Issues Line"."Item No.") THEN BEGIN
                            // UPDATING INFORMATION INTO "ITEM WISE REQUIREMENT" TABLE
                            IF Item_Req.GET("Material Issues Line"."Item No.") THEN BEGIN
                                Item_Req."Qty. In Material Issues" += "Material Issues Line"."Qty. to Receive";
                                Item_Req.MODIFY;
                            END ELSE BEGIN
                                Item_Req.INIT;
                                Item_Req."Item No." := "Material Issues Line"."Item No.";
                                Item_Req.Description := "Material Issues Line".Description;
                                Item_Req."Qty. In Material Issues" := "Material Issues Line"."Qty. to Receive";
                                Item_Req.INSERT;
                            END;
                            // IF MATERIAL IS THERE THEN RESERVING THAT MATERIAL
                            IF Dum."Maximum Inventory" >= "Material Issues Line"."Qty. to Receive" THEN BEGIN
                                Dum."Maximum Inventory" -= "Material Issues Line"."Qty. to Receive";
                                Dum.MODIFY;
                            END ELSE BEGIN
                                // IF SUFFICIENT STOCK IS NOT THERE THEN VERIFYING INTO ALTERNATE ITEMS STOCK
                                "Verify Alternate"(Dum."No.", "Material Issues Line"."Qty. to Receive", "Material Issues Line"."Prod. Order No.");

                                // ALTERNATE ITEM ALSO NOT AVAILABLE THEN ENTER THE SHORTAGE INFORMATION
                                IF NOT AVB THEN BEGIN
                                    Dum.RESET;
                                    IF Dum.GET("Material Issues Line"."Item No.") THEN BEGIN
                                        "Planned Purchase Date" := WORKDATE;
                                        IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                            IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                                "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                        END;
                                        ShortgFlag := FALSE;
                                        Item_Lot.RESET;
                                        Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                        Item_Lot.SETRANGE(Item_Lot."Production Order No.", "Material Issues Line"."Prod. Order No.");
                                        Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                        IF Item_Lot.FIND('-') THEN BEGIN
                                            //added by pranavi on 24-11-2015
                                            IF Alternate_Buffer > 0 THEN BEGIN
                                                IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                    Item_Lot.Shortage := Alternate_Buffer - Dum."Maximum Inventory";
                                                    Dum."Maximum Inventory" := 0;
                                                    Dum.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    Item_Lot.Shortage := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum.MODIFY;
                                                    ShortgFlag := TRUE;
                                                END;
                                            END
                                            ELSE BEGIN
                                                Item_Lot.Shortage := "Material Issues Line"."Qty. to Receive" - Dum."Maximum Inventory";
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END;
                                            //added by pranavi on 24-11-2015
                                            Item_Lot.Shortage += ("Material Issues Line"."Qty. to Receive");
                                            /*IF Item_Lot.Shortage<0 THEN
                                            BEGIN
                                              MESSAGE("Material Issues Line".Description+'-'+Dum.Description);
                                              MESSAGE(FORMAT("Material Issues Line"."Qty. to Receive"));
                                              MESSAGE(FORMAT(Dum."Maximum Inventory"));
                                            END; */
                                            IF (Item_Lot.Shortage > 0) AND (ShortgFlag = FALSE) THEN
                                                Item_Lot.MODIFY;
                                        END ELSE BEGIN
                                            Item_Lot.INIT;
                                            Item_Lot."Item No" := Dum."No.";
                                            Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                            //Item_Lot.VALIDATE(Item_Lot."Item No",Dum."No.");
                                            Item_Lot.Description := Dum.Description;
                                            Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                            Item_Lot."Possible Procured Date" := Possible_Procured_Date;
                                            Item_Lot."Possible Production Plan Date" := Possible_Plan_Changed_Date;
                                            /*//commented by pranavi on 24-11-2015
                                            IF Dum."Maximum Inventory">0 THEN
                                            BEGIN
                                              Item_Lot.Shortage:=("Material Issues Line"."Qty. to Receive"-Dum."Maximum Inventory");
                                              Dum."Maximum Inventory":=0;
                                              Dum.MODIFY;
                                            END ELSE
                                              Item_Lot.Shortage:=("Material Issues Line"."Qty. to Receive");
                                            *///commented by pranavi on 24-11-2015
                                              //added by pranavi on 24-11-2015
                                            IF Alternate_Buffer > 0 THEN BEGIN
                                                IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                    Item_Lot.Shortage := Alternate_Buffer - Dum."Maximum Inventory";
                                                    Dum."Maximum Inventory" := 0;
                                                    Dum.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    Item_Lot.Shortage := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                    Dum.MODIFY;
                                                    ShortgFlag := TRUE;
                                                END;
                                            END
                                            ELSE BEGIN
                                                Item_Lot.Shortage := "Material Issues Line"."Qty. to Receive" - Dum."Maximum Inventory";
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END;
                                            //added by pranavi on 24-11-2015
                                            Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                            Item_Lot."Production Order No." := "Material Issues Line"."Prod. Order No.";
                                            Item_Lot."Prod. Order Line No." := "Material Issues Line"."Prod. Order Line No.";
                                            Item_Lot."Prod. Order Comp Line No." := "Material Issues Line"."Prod. Order Comp. Line No.";
                                            Item_Lot."Material Required Date" := WORKDATE;
                                            PO.RESET;
                                            PO.SETFILTER(PO.Status, '%1', 3);
                                            PO.SETRANGE(PO."No.", "Material Issues Line"."Prod. Order No.");
                                            IF PO.FIND('-') THEN BEGIN
                                                Item_Lot."Sales Order No." := PO."Sales Order No.";
                                                Item_Lot."Planned Date" := PO."Prod Start date";
                                                Item_Lot."Product Type" := PO."Item Sub Group Code";
                                                Item_Lot.Product := PO."Source No.";
                                                "Sales Header".RESET;
                                                "Sales Header".SETRANGE("Sales Header"."No.", PO."Sales Order No.");
                                                IF "Sales Header".FIND('-') THEN BEGIN
                                                    Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                                    "Sales Header"."Shortage Calculation" := TRUE;
                                                    "Sales Header".MODIFY;
                                                END;
                                                IF Item_Lot.Shortage < 0 THEN BEGIN
                                                    //MESSAGE("Prod. Order Component".Description+'-'+Dum.Description);
                                                    //MESSAGE(FORMAT("Prod. Order Component"."Expected Quantity"));
                                                    //MESSAGE(FORMAT("Qty. In Issues & Req"));
                                                    //MESSAGE(FORMAT(Dum."Maximum Inventory"));
                                                END;
                                            END;
                                            IF (Item_Lot.Shortage > 0) AND (ShortgFlag = FALSE) THEN
                                                Item_Lot.INSERT;
                                        END;
                                    END;
                                END;
                            END;
                        END;
                    END;
                END;
            UNTIL "Material Issues Line".NEXT = 0;

    end;


    procedure "Verify Alternate"(Item1: Code[20]; Req_Qty: Decimal; "Prod. Order": Code[20])
    begin
        AVB := FALSE;
        Alternate_Buffer := 0;
        // FILETERING THE RPO
        Alter_PO.RESET;
        Alter_PO.SETRANGE(Alter_PO."No.", "Prod. Order");
        IF Alter_PO.FIND('-') THEN BEGIN
            // FINDING THE ITEMSUBGROUP CODE
            IF Item.GET(Alter_PO."Source No.") THEN BEGIN
                // FILTERING THE ALTERNATE ITEMS FOR REQUIRED ITEM BASED IN PRODUCT TYPE (EX :- DL, FEP, DB)
                //"Alternative Items".SETRANGE("Alternative Items"."Proudct Type",Item."Item Sub Group Code");  //this line Commented by pranavi onn 08-Dec-15
                "Alternative Items".SETFILTER("Alternative Items"."Proudct Type", '%1|%2', Item."Item Sub Group Code", 'ALL PRODUCTS'); //this line Added by pranavi onn 08-Dec-15
                "Alternative Items".SETRANGE("Alternative Items"."Item No.", Item1);
                IF "Alternative Items".FIND('-') THEN
                    REPEAT
                        // UPDATING ALTERNATE ITEM DETAILS INTO VIRTUAL STOCK
                        IF NOT (Dum.GET("Alternative Items"."Alternative Item No.")) THEN
                            Include_Item("Alternative Items"."Alternative Item No.", TRUE);

                        IF Dum.GET("Alternative Items"."Alternative Item No.") THEN BEGIN
                            IF Dum."Maximum Inventory" > 0 THEN BEGIN
                                IF Dum."Maximum Inventory" >= Req_Qty THEN BEGIN
                                    Dum."Maximum Inventory" := Dum."Maximum Inventory" - Req_Qty;
                                    Dum.MODIFY;
                                    Alternate_Buffer := 0;
                                    AVB := TRUE;
                                    IF Item_Req.GET(Dum."No.") THEN //pranavi
                                    BEGIN
                                        //Item_Req."Required Quantity"+=Req_Qty;
                                        Item_Req."Req Qty" += Req_Qty;
                                        Item_Req.MODIFY;
                                    END ELSE BEGIN
                                        Item_Req.INIT;
                                        Item_Req."Item No." := Dum."No.";
                                        Item_Req.Description := Dum.Description;
                                        Item_Req."Required Quantity" := 0;
                                        Item_Req."Req Qty" := Req_Qty;
                                        Item_Req.INSERT;
                                    END;     //pranavi
                                    IF Item_Req.GET(Item1) THEN //pranavi
                                    BEGIN
                                        //Item_Req."Required Quantity"-=Req_Qty;
                                        Item_Req."Req Qty" -= Req_Qty;
                                        Item_Req.MODIFY;
                                    END;
                                    EXIT;
                                END ELSE BEGIN
                                    Req_Qty := Req_Qty - Dum."Maximum Inventory";  //un commented by pranavi on 24-11-2015
                                                                                   //Alternate_Buffer:=Req_Qty-Dum."Maximum Inventory";    //commented by pranavi on 24-11-2015
                                    IF Alternate_Buffer = 0 THEN
                                        Alternate_Buffer := Req_Qty
                                    ELSE
                                        Alternate_Buffer -= Dum."Maximum Inventory";    //added by pranavi on 24-11-2015
                                                                                        // Alternate_Buffer:=
                                    IF Item_Req.GET(Dum."No.") THEN     //pranavi
                                    BEGIN
                                        //Item_Req."Required Quantity"+=Dum."Maximum Inventory";
                                        Item_Req."Req Qty" += Dum."Maximum Inventory";
                                        Item_Req.MODIFY;
                                    END ELSE BEGIN
                                        Item_Req.INIT;
                                        Item_Req."Item No." := Dum."No.";
                                        Item_Req.Description := Dum.Description;
                                        Item_Req."Required Quantity" := 0;
                                        Item_Req."Req Qty" := Dum."Maximum Inventory";
                                        Item_Req.INSERT;
                                    END;           //pranavi
                                    IF Item_Req.GET(Item1) THEN //pranavi
                                    BEGIN
                                        //Item_Req."Required Quantity"-=Req_Qty;
                                        Item_Req."Req Qty" -= Dum."Maximum Inventory";
                                        Item_Req.MODIFY;
                                    END;
                                    Dum."Maximum Inventory" := 0;
                                    Dum.MODIFY;
                                END;
                            END;
                        END;
                    UNTIL "Alternative Items".NEXT = 0;
            END;
        END;
    end;


    procedure Verify_BOUT_Alternate(Item1: Code[20]; Req_Qty: Decimal)
    begin
        AVB := FALSE;
        Alternate_Buffer := 0;
        "Alternative Items".SETRANGE("Alternative Items"."Item No.", Item1);
        IF "Alternative Items".FIND('-') THEN
            REPEAT
                IF NOT (Dum.GET("Alternative Items"."Alternative Item No.")) THEN
                    Include_Item("Alternative Items"."Alternative Item No.", TRUE);
                IF Dum.GET("Alternative Items"."Alternative Item No.") THEN BEGIN
                    IF Dum."Maximum Inventory" > 0 THEN BEGIN
                        IF Dum."Maximum Inventory" >= Req_Qty THEN BEGIN
                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - Req_Qty;
                            Dum.MODIFY;
                            AVB := TRUE;
                            IF Item_Req.GET(Dum."No.") THEN //pranavi
                            BEGIN
                                //Item_Req."Required Quantity"+=Req_Qty;
                                Item_Req."Req Qty" += Req_Qty;
                                Item_Req.MODIFY;
                            END ELSE BEGIN
                                Item_Req.INIT;
                                Item_Req."Item No." := Dum."No.";
                                Item_Req.Description := Dum.Description;
                                Item_Req."Required Quantity" := 0;
                                Item_Req."Req Qty" := Req_Qty;
                                Item_Req.INSERT;
                            END;     //pranavi
                            IF Item_Req.GET(Item1) THEN //pranavi
                            BEGIN
                                //Item_Req."Required Quantity"-=Req_Qty;
                                Item_Req."Req Qty" -= Req_Qty;
                                Item_Req.MODIFY;
                            END;
                            EXIT;
                        END ELSE BEGIN
                            Req_Qty := Req_Qty - Dum."Maximum Inventory";  //un commented by pranavi on 24-11-2015
                                                                           //Alternate_Buffer:=Req_Qty-Dum."Maximum Inventory";    //commented by pranavi on 24-11-2015
                            Alternate_Buffer := Req_Qty;                //added by pranavi on 24-11-2015
                                                                        // Alternate_Buffer:=
                            IF Item_Req.GET(Dum."No.") THEN     //pranavi
                            BEGIN
                                //Item_Req."Required Quantity"+=Dum."Maximum Inventory";
                                Item_Req."Req Qty" += Dum."Maximum Inventory";
                                Item_Req.MODIFY;
                            END ELSE BEGIN
                                Item_Req.INIT;
                                Item_Req."Item No." := Dum."No.";
                                Item_Req.Description := Dum.Description;
                                Item_Req."Required Quantity" := 0;
                                Item_Req."Req Qty" := Dum."Maximum Inventory";
                                Item_Req.INSERT;
                            END;           //pranavi
                            IF Item_Req.GET(Item1) THEN //pranavi
                            BEGIN
                                //Item_Req."Required Quantity"-=Req_Qty;
                                Item_Req."Req Qty" -= Dum."Maximum Inventory";
                                Item_Req.MODIFY;
                            END;
                            Dum."Maximum Inventory" := 0;
                            Dum.MODIFY;
                        END;
                    END; //End by Pranavi on 10-Dec-2015
                END;
            UNTIL "Alternative Items".NEXT = 0;
    end;


    procedure Include_Item(item1: Code[20]; Verify: Boolean)
    begin
        //IF item1 = 'ECDIOPN00120' THEN
        //   MESSAGE('Out %1',item1);
        Item.RESET;
        //Item.SETFILTER(Item."No.",''''+item1+'''');
        Item.SETFILTER(Item."No.", '''' + item1 + '''');

        IF Item.FIND('-') THEN BEGIN
            IF (Item."Product Group Code Cust" <> 'CPCB') AND (Item."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                Item.CALCFIELDS(Item."Inventory at Stores", Item."Qty. on Purch. Order",
                                Item."Quantity Under Inspection", Item."Stock At MCH Location");
                /* IF Item."No." = 'ECREGPV00050' THEN
                    MESSAGE('in %1',item1);*/
                //ECICSDI00074
                Dum.INIT;
                Dum."No." := Item."No.";
                Dum.Description := Item.Description;
                Dum."Standard Cost" := Item."Qty. on Purch. Order";
                Dum."Unit Cost" := Item."Quantity Under Inspection";
                Stock := 0;
                Item.CALCFIELDS(Item."Quantity Under Inspection", Item."Quantity Rejected", Item."Quantity Rework",
                Item."Quantity Sent for Rework", Item."Inventory at Stores");
                IF Item."QC Enabled" = TRUE THEN BEGIN
                    IF (Item."Quantity Under Inspection" = 0) AND (Item."Quantity Rejected" = 0) AND
                       (Item."Quantity Rework" = 0) AND (Item."Quantity Sent for Rework" = 0) THEN BEGIN
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                        "Expiration Date", "Lot No.", "Serial No.");
                        ItemLedgEntry.SETRANGE("Item No.", Item."No.");
                        ItemLedgEntry.SETRANGE(Open, TRUE);
                        ItemLedgEntry.SETRANGE("Location Code", 'STR');
                        IF ItemLedgEntry.FIND('-') THEN
                            REPEAT
                                Stock += ItemLedgEntry."Remaining Quantity";
                            UNTIL ItemLedgEntry.NEXT = 0;
                    END ELSE BEGIN
                        Stock := 0;
                        ItemLedgEntry.RESET;
                        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                                                    "Expiration Date", "Lot No.", "Serial No.");
                        ItemLedgEntry.SETRANGE("Item No.", Item."No.");
                        ItemLedgEntry.SETRANGE(Open, TRUE);
                        ItemLedgEntry.SETRANGE("Location Code", 'STR');
                        IF ItemLedgEntry.FIND('-') THEN
                            REPEAT
                                ItemLedgEntry.MARK(TRUE);
                                IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                                    QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                                    (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                    AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                                    ItemLedgEntry.MARK(FALSE);

                            UNTIL ItemLedgEntry.NEXT = 0;
                    END;
                END;
                ItemLedgEntry.MARKEDONLY(TRUE);
                IF ItemLedgEntry.FIND('-') THEN
                    REPEAT
                        Stock := Stock + ItemLedgEntry."Remaining Quantity";
                    UNTIL ItemLedgEntry.NEXT = 0;
                Item."Stock at Stores" := Stock;
                Item.MODIFY;

                Item.CALCFIELDS(Item."Stock at PROD Stores");  //sundar

                /*IF Item."Safety Stock Quantity">0 THEN
                BEGIN
                  IF Item."Safety Stock Quantity">(Stock+Item."Stock at PROD Stores") THEN
                  BEGIN
                    Include_Saftey_Stock_Quantity(Item."No.",(Item."Safety Stock Quantity"-(Stock+Item."Stock at PROD Stores")));
                    Stock:=-1*Item."Stock at PROD Stores";
                  END
                  ELSE
                    Stock-=Item."Safety Stock Quantity";
                END;*/

                Dum."Maximum Inventory" := Stock + Item."Stock At MCH Location" + Item."Stock at PROD Stores";   //sundar
                Dum."Base Unit of Measure" := Item."Base Unit of Measure";
                Dum."Stock at Stores" := Stock + Item."Stock At MCH Location";
                Dum."Safety Stock Qty (CS)" := Item."Stock At MCH Location";
                Dum."Product Group Code Cust" := Item."Product Group Code Cust";
                IF FORMAT(Item."Safety Lead Time") = '' THEN BEGIN
                    IF Verify THEN BEGIN
                        ERROR('There Is No Saftey Lead Time For the Item ' + Dum.Description + '(' + Dum."No." + ')');
                        CurrReport.BREAK;
                    END
                END ELSE
                    Dum."Safety Lead Time" := Item."Safety Lead Time";

                Dum.INSERT;//P.K Identified
            END;
        END;

    end;


    procedure Calculate_Sale_Order_Shortage(REQ_DATE: Date)
    var
        PMIH: Record "Posted Material Issues Header";
        PMIL: Record "Posted Material Issues Line";
    begin
        // FILTERTING THE SALES LINE DATA FOR THE PARTICULAR DATE
        Within_Buffer := FALSE;
        "Sales Line".RESET;
        "Sales Line".SETCURRENTKEY("Sales Line"."Material Reuired Date", "Sales Line"."No.");
        "Sales Line".SETFILTER("Sales Line"."Document Type", '%1|%2', "Sales Line"."Document Type"::"Blanket Order", "Sales Line"."Document Type"::Order);
        "Sales Line".SETRANGE("Sales Line"."Posting Group", 'BOI');
        "Sales Line".SETRANGE("Sales Line"."Material Reuired Date", REQ_DATE);
        "Sales Line".SETFILTER("Sales Line"."Outstanding Quantity", '>%1', 0);
        //"Sales Line".SETFILTER("Sales Line"."To Be Shipped Qty",'>%1',0);
        IF Test_Item <> '' THEN
            "Sales Line".SETRANGE("Sales Line"."No.", Test_Item);

        IF "Sales Line".FIND('-') THEN
            REPEAT
                SalHeadr.RESET;
                SalHeadr.SETRANGE(SalHeadr."No.", "Sales Line"."Document No.");
                SalHeadr.SETRANGE(SalHeadr."Sale Order Created", FALSE);
                SalHeadr.SETFILTER(SalHeadr."Order Status", '<>%1', SalHeadr."Order Status"::"Temporary Close");
                IF SalHeadr.FINDFIRST THEN    // find sales header where order status is not cancel and sale order not created
                BEGIN
                    // Pranavi
                    NewOutStndingQty := "Sales Line"."Outstanding Quantity";
                    PMIQty := 0;
                    RemPMIQty := 0;
                    InsrtRecLineNo := 0;
                    TempBoutStockTable.RESET;
                    TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", "Sales Line"."Document No.");
                    TempBoutStockTable.SETRANGE(TempBoutStockTable."No.", "Sales Line"."No.");
                    IF TempBoutStockTable.FINDFIRST THEN BEGIN
                        TempBoutStockTable.Quantity += "Sales Line".Quantity;
                        IF TempBoutStockTable."Qty. Sent To Quality" > ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity") THEN
                            RemPMIQty := TempBoutStockTable."Qty. Sent To Quality" - ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity")
                        ELSE
                            RemPMIQty := 0;
                        IF RemPMIQty >= "Sales Line"."Outstanding Quantity" THEN BEGIN
                            NewOutStndingQty := 0;
                            TempBoutStockTable."Qty. Sent To Quality" -= "Sales Line"."Outstanding Quantity";
                            TempBoutStockTable.MODIFY;
                        END ELSE BEGIN
                            NewOutStndingQty := "Sales Line"."Outstanding Quantity" - RemPMIQty;
                            TempBoutStockTable."Qty. Sent To Quality" := 0;
                            TempBoutStockTable.MODIFY;
                        END;
                    END ELSE BEGIN
                        TempBoutStockTable.RESET;
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", "Sales Line"."Document No.");
                        IF TempBoutStockTable.FINDLAST THEN
                            InsrtRecLineNo := TempBoutStockTable."Line No." + 1000
                        ELSE
                            InsrtRecLineNo := 1000;
                        TempBoutStockTable.INIT;
                        TempBoutStockTable."Document Type" := "Sales Line"."Document Type";
                        TempBoutStockTable."Document No." := "Sales Line"."Document No.";
                        TempBoutStockTable."Line No." := InsrtRecLineNo;
                        TempBoutStockTable."No." := "Sales Line"."No.";
                        TempBoutStockTable.Quantity += "Sales Line".Quantity;
                        PostdMatIssHedrGRec.RESET;
                        PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", "Sales Line"."Document No.");
                        //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                        PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                        IF PostdMatIssHedrGRec.FINDSET THEN
                            REPEAT
                                PostedMatIssLinGRec.RESET;
                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", "Sales Line"."No.");
                                PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                    PMIQty += PostedMatIssLinGRec.Quantity;
                                END;
                            UNTIL PostdMatIssHedrGRec.NEXT = 0;
                        TempBoutStockTable."Qty. Sent To Quality" := PMIQty;
                        //TempBoutStockTable.INSERT;
                        IF PMIQty >= ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity") THEN
                            RemPMIQty := PMIQty - ("Sales Line".Quantity - "Sales Line"."Outstanding Quantity")
                        ELSE
                            RemPMIQty := 0;
                        IF RemPMIQty >= "Sales Line"."Outstanding Quantity" THEN BEGIN
                            NewOutStndingQty := 0;
                            TempBoutStockTable."Qty. Sent To Quality" -= "Sales Line"."Outstanding Quantity";
                            //TempBoutStockTable.MODIFY;
                        END ELSE BEGIN
                            NewOutStndingQty := "Sales Line"."Outstanding Quantity" - RemPMIQty;
                            TempBoutStockTable."Qty. Sent To Quality" := 0;
                            //TempBoutStockTable.MODIFY;
                        END;
                        TempBoutStockTable.INSERT;
                    END;
                    // Pranavi End
                    // UPDATING ITEM WISE REQUIREMENT DETAILS
                    IF Item_Req.GET("Sales Line"."No.") THEN BEGIN
                        Item_Req."Required Quantity" += NewOutStndingQty;
                        Item_Req."Req Qty" += NewOutStndingQty;
                        Item_Req.MODIFY;
                    END ELSE BEGIN
                        Item_Req.INIT;
                        Item_Req."Item No." := "Sales Line"."No.";
                        Item_Req.Description := "Sales Line".Description;
                        Item_Req."Required Quantity" := NewOutStndingQty;
                        Item_Req."Req Qty" := NewOutStndingQty;
                        Item_Req.INSERT;
                    END;


                    "Sales Line"."Plan Shifting Date" := 0D;
                    IF NOT Dum.GET("Sales Line"."No.") THEN
                        Include_Item("Sales Line"."No.", TRUE);
                    Dum_Item := "Sales Line"."Document No.";
                    DUm_Req := NewOutStndingQty;
                    Dum_Po := FORMAT(NewOutStndingQty);
                    IF Dum.GET("Sales Line"."No.") THEN BEGIN
                        // VERIFYING THE STOCK , IF REQUIRED QUANTITY IS AVAILABLE THEN RESERVING THE MATERIAL OTHERWISE
                        // VERIFY FOR ALTERNATE ITEM EVENTHOUGH NOT AVAILBLE THEN WE HAVE TO POST THE SHORTAGE TRANSACTION
                        IF Dum."Maximum Inventory" >= (NewOutStndingQty) THEN BEGIN
                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - NewOutStndingQty;
                            Dum.MODIFY;
                        END ELSE BEGIN
                            Verify_BOUT_Alternate(Dum."No.", NewOutStndingQty);
                            IF NOT AVB THEN BEGIN
                                IF FORMAT(Dum."Safety Lead Time") <> '' THEN BEGIN

                                    Total_Buffer := '-' + FORMAT(Dum."Safety Lead Time");
                                    "Planned_Purchase (Wit out Buf)" := CALCDATE(Total_Buffer, REQ_DATE);
                                    Total_Buffer := '-' + FORMAT(Buffer);
                                    "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned_Purchase (Wit out Buf)");
                                    Possible_Procured_Date := 0D;
                                    //  "Planned Purchase Date" := WORKDATE + 1;

                                    IF "Planned Purchase Date" < WORKDATE THEN BEGIN
                                        AVB := FALSE;
                                        "Planned Purchase Date" := 0D;
                                        Dum_Purch_Line.RESET;
                                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", "Sales Line"."No.");
                                        Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                        Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date", "Sales Line"."Material Reuired Date" - 3,
                                                                                                       "Sales Line"."Material Reuired Date" - 2);
                                        IF NOT (Dum_Purch_Line.FIND('-')) THEN BEGIN
                                            Dum_Purch_Line.RESET;
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", "Sales Line"."No.");
                                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date", '>%1', "Sales Line"."Material Reuired Date");
                                            IF Dum_Purch_Line.FIND('-') THEN BEGIN
                                                REPEAT
                                                    IF (Dum_Purch_Line."Qty. to Receive" > NewOutStndingQty) AND (NOT AVB) THEN BEGIN
                                                        Dum_Purch_Line."Qty. to Receive" -= NewOutStndingQty;
                                                        Dum_Purch_Line.MODIFY;
                                                        Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date" + 2;
                                                        AVB := TRUE;
                                                    END;
                                                UNTIL (Dum_Purch_Line.NEXT = 0) OR (AVB);
                                                IF Possible_Procured_Date = 0D THEN BEGIN
                                                    Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                    Total_Buffer := FORMAT(Buffer);
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                END;

                                            END ELSE BEGIN
                                                Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                Total_Buffer := FORMAT(Buffer);
                                                Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                            END;
                                        END ELSE BEGIN
                                            Within_Buffer := TRUE;
                                            Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date" + 2;
                                        END;


                                        "Sales Line"."Change to Specified Plan Date" := FALSE;
                                        "Sales Line"."Plan Shifting Date" := Possible_Procured_Date;
                                        "Sales Line".MODIFY

                                    END;
                                    IF "Planned_Purchase (Wit out Buf)" < WORKDATE THEN
                                        "Planned_Purchase (Wit out Buf)" := 0D;
                                END;

                                IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                    IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                        "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                END;
                                ShortgFlag := FALSE;
                                Item_Lot.RESET;
                                Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                Item_Lot.SETRANGE(Item_Lot."Sales Order No.", "Sales Line"."Document No.");
                                Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                IF Item_Lot.FIND('-') THEN BEGIN
                                    //Item_Lot.Shortage+=("Sales Line"."Qty. to Ship");   //commented by pranavi on10-dec-2015
                                    //Added by Pranavi on 10-Dec-2015
                                    IF Alternate_Buffer > 0 THEN BEGIN
                                        IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                            ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Dum.MODIFY;
                                            ShortgFlag := TRUE;
                                        END;
                                    END
                                    ELSE BEGIN
                                        ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                        Item_Lot.Shortage += ShortgTemp;
                                        Dum."Maximum Inventory" := 0;
                                        Dum.MODIFY;
                                    END;
                                    /*
                                    IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                    BEGIN
                                      IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                      BEGIN
                                     // Commented by Pranavi on 08-mar-2016
                                        IF Item_Req.GET(Item_Lot."Item No") THEN
                                        BEGIN
                                          IF ShortgFlag = FALSE THEN
                                          BEGIN
                                          Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                          Item_Req.MODIFY;
                                          END;
                                        END;

                                      END;
                                    END;
                                    */ // Commented by Pranavi on 08-mar-2016
                                       //End by Pranavi
                                    IF (ShortgFlag = FALSE) AND (Item_Lot.Shortage > 0) THEN
                                        Item_Lot.MODIFY;
                                END ELSE BEGIN
                                    Item_Lot.INIT;
                                    Item_Lot."Item No" := Dum."No.";
                                    Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                    Item_Lot.Description := Dum.Description;
                                    Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                    /*
                                    IF Dum."Maximum Inventory">0 THEN
                                    BEGIN
                                      Item_Lot.Shortage:=(NewOutStndingQty- Dum."Maximum Inventory");
                                      Dum."Maximum Inventory":=0;
                                      Dum.MODIFY;
                                    END ELSE
                                    Item_Lot.Shortage:=NewOutStndingQty;
                                    *///Commented by Pranavi on 10-Dec-2015
                                    Item_Lot."Within Buffer" := Within_Buffer;
                                    Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                    Item_Lot."Sales Order No." := "Sales Line"."Document No.";
                                    Item_Lot."Material Required Date" := "Sales Line"."Material Reuired Date" - 4;
                                    "Sales Header".RESET;
                                    "Sales Header".SETRANGE("Sales Header"."No.", "Sales Line"."Document No.");
                                    IF "Sales Header".FIND('-') THEN BEGIN
                                        Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                        "Sales Header"."Shortage Calculation" := TRUE;
                                        "Sales Header".MODIFY;
                                    END;
                                    Item_Lot."Production Order No." := '';
                                    //Added by Pranavi on 10-Dec-2015
                                    IF Alternate_Buffer > 0 THEN BEGIN
                                        IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                            ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                            Dum.MODIFY;
                                            ShortgFlag := TRUE;
                                        END;
                                    END
                                    ELSE BEGIN
                                        ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                        Item_Lot.Shortage += ShortgTemp;
                                        Dum."Maximum Inventory" := 0;
                                        Dum.MODIFY;
                                    END;
                                    /*
                                    IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                    BEGIN
                                      IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                      BEGIN
                                     // Commented by Pranavi on 08-mar-2016
                                        IF Item_Req.GET(Item_Lot."Item No") THEN
                                        BEGIN
                                          IF ShortgFlag = FALSE THEN
                                          BEGIN
                                          Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                          Item_Req.MODIFY;
                                          END;
                                        END;

                                      END;
                                    END;
                                    */ // Commented by Pranavi on 08-mar-2016
                                       //End by Pranavi
                                    IF (ShortgFlag = FALSE) AND (Item_Lot.Shortage > 0) THEN
                                        Item_Lot.INSERT;
                                END;
                            END;
                        END;
                    END;
                END; // End of sales Header find
            UNTIL "Sales Line".NEXT = 0;

    end;


    procedure Calculate_Sale_Schedule_Shorta(REQ_DATE: Date)
    begin
        // THIS PROCESS ALSO SAME AS THE "SHORTAGE CALCULATON" PROCESS OF SALES ITEM
        // CONSIDERATION HAS BEEN CHANGED
        Within_Buffer := FALSE;
        Schedule2.RESET;
        Schedule2.SETCURRENTKEY(Schedule2."Material Required Date", Schedule2."No.");
        Schedule2.SETFILTER(Schedule2."Document Type", '%1|%2', Schedule2."Document Type"::Order, Schedule2."Document Type"::"Blanket Order");
        Schedule2.SETRANGE(Schedule2."Posting Group", 'BOI');      //Added by Pranavi on 10-Dec-2015
        Schedule2.SETRANGE(Schedule2."Material Required Date", REQ_DATE);
        Schedule2.SETFILTER(Schedule2."Outstanding Qty.", '>%1', 0);
        IF Test_Item <> '' THEN
            Schedule2.SETRANGE(Schedule2."No.", Test_Item);

        IF Schedule2.FIND('-') THEN
            REPEAT
                IF Schedule2."Document Line No." <> Schedule2."Line No." THEN BEGIN
                    SalHeadr.RESET;
                    SalHeadr.SETRANGE(SalHeadr."No.", Schedule2."Document No.");
                    SalHeadr.SETRANGE(SalHeadr."Sale Order Created", FALSE);
                    SalHeadr.SETFILTER(SalHeadr."Order Status", '<>%1', SalHeadr."Order Status"::"Temporary Close");
                    IF SalHeadr.FINDFIRST THEN    // find sales header where order status is not cancel and sale order not created
                    BEGIN
                        // Pranavi
                        NewOutStndingQty := Schedule2."Outstanding Qty.";
                        PMIQty := 0;
                        RemPMIQty := 0;
                        InsrtRecLineNo := 0;
                        TempBoutStockTable.RESET;
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", Schedule2."Document No.");
                        TempBoutStockTable.SETRANGE(TempBoutStockTable."No.", Schedule2."No.");
                        IF TempBoutStockTable.FINDFIRST THEN BEGIN
                            TempBoutStockTable.Quantity += Schedule2.Quantity;
                            IF TempBoutStockTable."Qty. Sent To Quality" > (Schedule2.Quantity - Schedule2."Outstanding Qty.") THEN
                                RemPMIQty := TempBoutStockTable."Qty. Sent To Quality" - (Schedule2.Quantity - Schedule2."Outstanding Qty.")
                            ELSE
                                RemPMIQty := 0;
                            IF RemPMIQty >= Schedule2."Outstanding Qty." THEN BEGIN
                                NewOutStndingQty := 0;
                                TempBoutStockTable."Qty. Sent To Quality" -= Schedule2."Outstanding Qty.";
                                TempBoutStockTable.MODIFY;
                            END ELSE BEGIN
                                NewOutStndingQty := Schedule2."Outstanding Qty." - RemPMIQty;
                                TempBoutStockTable."Qty. Sent To Quality" := 0;
                                TempBoutStockTable.MODIFY;
                            END;
                        END ELSE BEGIN
                            TempBoutStockTable.RESET;
                            TempBoutStockTable.SETRANGE(TempBoutStockTable."Document No.", Schedule2."Document No.");
                            IF TempBoutStockTable.FINDLAST THEN
                                InsrtRecLineNo := TempBoutStockTable."Line No." + 1000
                            ELSE
                                InsrtRecLineNo := 1000;
                            TempBoutStockTable.INIT;
                            TempBoutStockTable."Document Type" := SalHeadr."Document Type";
                            TempBoutStockTable."Document No." := Schedule2."Document No.";
                            TempBoutStockTable."Line No." := InsrtRecLineNo;
                            TempBoutStockTable."No." := Schedule2."No.";
                            TempBoutStockTable.Quantity += Schedule2.Quantity;
                            PostdMatIssHedrGRec.RESET;
                            PostdMatIssHedrGRec.SETRANGE(PostdMatIssHedrGRec."Sales Order No.", Schedule2."Document No.");
                            //PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Prod. Order No.",'%1','');
                            PostdMatIssHedrGRec.SETFILTER(PostdMatIssHedrGRec."Transfer-from Code", '%1|%2', 'STR', 'MCH');
                            IF PostdMatIssHedrGRec.FINDSET THEN
                                REPEAT
                                    PostedMatIssLinGRec.RESET;
                                    PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Document No.", PostdMatIssHedrGRec."No.");
                                    PostedMatIssLinGRec.SETRANGE(PostedMatIssLinGRec."Item No.", Schedule2."No.");
                                    PostedMatIssLinGRec.SETFILTER(PostedMatIssLinGRec.Quantity, '>%1', 0);
                                    IF PostedMatIssLinGRec.FINDFIRST THEN BEGIN
                                        PMIQty += PostedMatIssLinGRec.Quantity;
                                    END;
                                UNTIL PostdMatIssHedrGRec.NEXT = 0;
                            TempBoutStockTable."Qty. Sent To Quality" := PMIQty;
                            //TempBoutStockTable.INSERT;
                            IF PMIQty >= (Schedule2.Quantity - Schedule2."Outstanding Qty.") THEN
                                RemPMIQty := PMIQty - (Schedule2.Quantity - Schedule2."Outstanding Qty.")
                            ELSE
                                RemPMIQty := 0;
                            IF RemPMIQty >= Schedule2."Outstanding Qty." THEN BEGIN
                                NewOutStndingQty := 0;
                                TempBoutStockTable."Qty. Sent To Quality" -= Schedule2."Outstanding Qty.";
                                //TempBoutStockTable.MODIFY;
                            END ELSE BEGIN
                                NewOutStndingQty := Schedule2."Outstanding Qty." - RemPMIQty;
                                TempBoutStockTable."Qty. Sent To Quality" := 0;
                                //TempBoutStockTable.MODIFY;
                            END;
                            TempBoutStockTable.INSERT;
                        END;
                        // Pranavi End
                        IF Item_Req.GET(Schedule2."No.") THEN BEGIN
                            Item_Req."Required Quantity" += NewOutStndingQty;
                            Item_Req."Req Qty" += NewOutStndingQty;
                            Item_Req.MODIFY;

                        END ELSE BEGIN
                            Item_Req.INIT;
                            Item_Req."Item No." := Schedule2."No.";
                            Item_Req.Description := Dum.Description;
                            Item_Req."Required Quantity" := NewOutStndingQty;
                            Item_Req."Req Qty" := NewOutStndingQty;
                            Item_Req.INSERT;
                        END;
                        DUm_Stk := NewOutStndingQty;
                        Dum_Po := Schedule2."Document No.";
                        IF NOT Dum.GET(Schedule2."No.") THEN
                            Include_Item(Schedule2."No.", TRUE);

                        IF Dum.GET(Schedule2."No.") THEN BEGIN


                            IF Dum."Maximum Inventory" >= (NewOutStndingQty) THEN BEGIN
                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - NewOutStndingQty;
                                Dum.MODIFY;
                            END ELSE BEGIN
                                Verify_BOUT_Alternate(Dum."No.", NewOutStndingQty);
                                IF NOT AVB THEN BEGIN
                                    IF FORMAT(Dum."Safety Lead Time") <> '' THEN BEGIN
                                        Total_Buffer := '-' + FORMAT(Dum."Safety Lead Time");
                                        "Planned_Purchase (Wit out Buf)" := CALCDATE(Total_Buffer, REQ_DATE);
                                        Total_Buffer := '-' + FORMAT(Buffer);
                                        "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned_Purchase (Wit out Buf)");
                                        //  "Planned Purchase Date" := WORKDATE + 1;

                                        Possible_Procured_Date := 0D;
                                        IF "Planned Purchase Date" < WORKDATE THEN BEGIN
                                            AVB := FALSE;
                                            "Planned Purchase Date" := 0D;
                                            Dum_Purch_Line.RESET;
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", Schedule2."No.");
                                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."Deviated Receipt Date", Schedule2."Material Required Date" - 3,
                                                                                                           Schedule2."Material Required Date" - 2);
                                            IF NOT (Dum_Purch_Line.FIND('-')) THEN BEGIN
                                                Dum_Purch_Line.RESET;
                                                Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", Schedule2."No.");
                                                Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                                                Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date", '>%1', Schedule2."Material Required Date");
                                                IF Dum_Purch_Line.FIND('-') THEN BEGIN
                                                    REPEAT
                                                        IF (Dum_Purch_Line."Qty. to Receive" > NewOutStndingQty) AND (NOT AVB) THEN BEGIN
                                                            Dum_Purch_Line."Qty. to Receive" -= NewOutStndingQty;
                                                            Dum_Purch_Line.MODIFY;
                                                            Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date" + 2;
                                                            AVB := TRUE;
                                                        END;
                                                    UNTIL (Dum_Purch_Line.NEXT = 0) OR (AVB);
                                                    IF Possible_Procured_Date = 0D THEN BEGIN
                                                        Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                        Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                        Total_Buffer := FORMAT(Buffer);
                                                        Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                    END;


                                                END ELSE BEGIN
                                                    Total_Buffer := FORMAT(Dum."Safety Lead Time");
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                                    Total_Buffer := FORMAT(Buffer);
                                                    Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);
                                                END;
                                            END ELSE BEGIN
                                                Within_Buffer := TRUE;
                                                Possible_Procured_Date := Dum_Purch_Line."Deviated Receipt Date" + 2;
                                            END;

                                            Schedule2."Change To Specified Plan Date" := FALSE;
                                            Schedule2."Plan Shifting Date" := Possible_Procured_Date;
                                            Schedule2.MODIFY;

                                        END;


                                        IF "Planned_Purchase (Wit out Buf)" < WORKDATE THEN
                                            "Planned_Purchase (Wit out Buf)" := 0D;
                                    END;

                                    IF ("Planned Purchase Date" > 0D) THEN BEGIN
                                        IF DATE2DWY("Planned Purchase Date", 1) = 7 THEN
                                            "Planned Purchase Date" := "Planned Purchase Date" - 1;
                                    END;
                                    ShortgFlag := FALSE;
                                    Item_Lot.RESET;
                                    Item_Lot.SETRANGE(Item_Lot."Item No", Dum."No.");
                                    Item_Lot.SETRANGE(Item_Lot."Sales Order No.", Schedule2."Document No.");
                                    Item_Lot.SETRANGE(Item_Lot."Planned Purchase Date", "Planned Purchase Date");
                                    IF Item_Lot.FIND('-') THEN BEGIN
                                        //Item_Lot.Shortage+=(Schedule2."To be Shipped Qty");   //Commented By Pranavi on 10-Dec-2015
                                        //Added by Pranavi on 10-Dec-2015
                                        IF Alternate_Buffer > 0 THEN BEGIN
                                            IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END
                                            ELSE BEGIN
                                                ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Dum.MODIFY;
                                                ShortgFlag := TRUE;
                                            END;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END;
                                        /*
                                        IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                        BEGIN
                                          IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                          BEGIN
                                         // Commented by Pranavi on 08-mar-2016
                                            IF Item_Req.GET(Item_Lot."Item No") THEN
                                            BEGIN
                                              IF ShortgFlag = FALSE THEN
                                              BEGIN
                                              Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                              Item_Req.MODIFY;
                                              END;
                                            END;

                                          END;
                                        END;
                                        */ // Commented by Pranavi on 08-mar-2016
                                           //End by Pranavi
                                        IF (ShortgFlag = FALSE) AND (Item_Lot.Shortage > 0) THEN
                                            Item_Lot.MODIFY;

                                    END ELSE BEGIN
                                        Item_Lot.INIT;
                                        Item_Lot."Item No" := Dum."No.";
                                        Item_Lot.VALIDATE(Item_Lot."Item No", Dum."No.");
                                        Item_Lot.Description := Dum.Description;
                                        Item_Lot."Planned Purchase Dare (WOB)" := "Planned_Purchase (Wit out Buf)";
                                        DUm_Stk := NewOutStndingQty;
                                        Dum_Po := Schedule2."Document No.";
                                        /*
                                        IF Dum."Maximum Inventory">0 THEN
                                        BEGIN
                                          Item_Lot.Shortage:=(Schedule2."Outstanding Qty."- Dum."Maximum Inventory");
                                          Dum."Maximum Inventory":=0;
                                          Dum.MODIFY;
                                        END ELSE
                                          Item_Lot.Shortage:=NewOutStndingQty;
                                        *///Commented By Pranavi on 10-Dec-2015
                                        Item_Lot."Within Buffer" := Within_Buffer;
                                        Item_Lot."Planned Purchase Date" := "Planned Purchase Date";
                                        Item_Lot."Sales Order No." := Schedule2."Document No.";
                                        Item_Lot."Material Required Date" := Schedule2."Material Required Date" - 4;
                                        "Sales Header".RESET;
                                        "Sales Header".SETRANGE("Sales Header"."No.", Schedule2."Document No.");
                                        IF "Sales Header".FIND('-') THEN BEGIN
                                            Item_Lot."Customer Name" := "Sales Header"."Bill-to Name";
                                            "Sales Header"."Shortage Calculation" := TRUE;
                                            "Sales Header".MODIFY;
                                        END;
                                        Item_Lot."Production Order No." := '';
                                        //Added by Pranavi on 10-Dec-2015
                                        IF Alternate_Buffer > 0 THEN BEGIN
                                            IF Alternate_Buffer >= Dum."Maximum Inventory" THEN BEGIN
                                                ShortgTemp := Alternate_Buffer - Dum."Maximum Inventory";
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := 0;
                                                Dum.MODIFY;
                                            END
                                            ELSE BEGIN
                                                ShortgTemp := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Item_Lot.Shortage += ShortgTemp;
                                                Dum."Maximum Inventory" := Dum."Maximum Inventory" - Alternate_Buffer;
                                                Dum.MODIFY;
                                                ShortgFlag := TRUE;
                                            END;
                                        END
                                        ELSE BEGIN
                                            ShortgTemp := (NewOutStndingQty - Dum."Maximum Inventory");
                                            Item_Lot.Shortage += ShortgTemp;
                                            Dum."Maximum Inventory" := 0;
                                            Dum.MODIFY;
                                        END;
                                        /*
                                        IF (COPYSTR(Item_Lot."Sales Order No.",5,3) = 'EXP') AND (FORMAT(Item_Lot."Lead Time2") IN ['2D','4D','7D','15D']) THEN
                                        BEGIN
                                          IF NOT (COPYSTR(Item_Lot."Sales Order No.",14,2) IN ['/L','/T']) THEN     //exception for lED Orders
                                          BEGIN
                                         // Commented by Pranavi on 08-mar-2016
                                            IF Item_Req.GET(Item_Lot."Item No") THEN
                                            BEGIN
                                              IF ShortgFlag = FALSE THEN
                                              BEGIN
                                              Item_Req."Req Qty":=Item_Req."Req Qty"-ShortgTemp;
                                              Item_Req.MODIFY;
                                              END;
                                            END;

                                          END;
                                        END;
                                        */ // Commented by Pranavi on 08-mar-2016
                                           //End by Pranavi
                                        IF (ShortgFlag = FALSE) AND (Item_Lot.Shortage > 0) THEN
                                            Item_Lot.INSERT;
                                    END;
                                END;
                            END;
                        END;
                    END;  // End of Sales Header Find Rec
                END;  // End of Doc Line No. <> Line No.
            UNTIL Schedule2.NEXT = 0;

    end;


    procedure Include_Saftey_Stock_Quantity(Shortage_Item: Code[20]; Shortage_Quantity: Decimal)
    begin
        IF Item.GET(Shortage_Item) THEN BEGIN
            Item_Lot.INIT;
            Item_Lot."Item No" := Item."No.";
            Item_Lot.VALIDATE(Item_Lot."Item No", Item."No.");
            Item_Lot.Description := Item.Description;
            Item_Lot.Shortage := Shortage_Quantity;
            Item_Lot."Planned Purchase Date" := TODAY;
            Item_Lot."Sales Order No." := 'STR INTERNAL';
            Item_Lot."Material Required Date" := TODAY;
            Item_Lot."Customer Name" := 'PRODUCTION INTERNAL';
            Item_Lot."Production Order No." := '';
            IF Item_Lot.Shortage > 0 THEN
                Item_Lot.INSERT;
            IF Item_Req.GET(Shortage_Item) THEN BEGIN
                Item_Req."Required Quantity" += Shortage_Quantity;
                Item_Req."Req Qty" += Shortage_Quantity;
                Item_Req.MODIFY;
            END ELSE BEGIN
                Item_Req.INIT;
                Item_Req."Item No." := Shortage_Item;
                Item_Req.Description := Item.Description;
                Item_Req."Required Quantity" := Shortage_Quantity;
                Item_Req."Req Qty" := Shortage_Quantity;
                Item_Req.INSERT;
            END;
        END;
    end;


    procedure PO_QTY(Item_Code: Code[20]) PO_Quantity: Decimal
    begin
        "Purchase line".SETCURRENTKEY("Purchase line"."No.", "Purchase line"."Buy-from Vendor No.");
        "Purchase line".SETRANGE("Purchase line"."No.", Item_Code);
        "Purchase line".SETFILTER("Purchase line".Type, 'Item');
        "Purchase line".SETFILTER("Purchase line"."Qty. to Receive", '>%1', 0);
        "Purchase line".SETRANGE("Purchase line"."Location Code", 'STR');
        "Purchase line".SETFILTER("Purchase line"."Document Type", 'ORDER');
        IF "Purchase line".FINDSET THEN
            REPEAT
                PO_Quantity += "Purchase line"."Qty. to Receive";
            UNTIL "Purchase line".NEXT = 0;
        EXIT(PO_Quantity);
    end;


    procedure Include_Saftey_Stock_Quantity1(Shortage_Item: Code[20]; Shortage_Quantity: Decimal)
    begin
        IF Item.GET(Shortage_Item) THEN BEGIN
            Item_Lot.INIT;
            Item_Lot."Item No" := Item."No.";
            Item_Lot.VALIDATE(Item_Lot."Item No", Item."No.");
            Item_Lot.Description := Item.Description;
            Item_Lot.Shortage := Shortage_Quantity;
            Item_Lot."Planned Purchase Date" := TODAY;
            Item_Lot."Sales Order No." := 'STR INTERNAL';
            Item_Lot."Material Required Date" := TODAY;
            Item_Lot."Customer Name" := 'PRODUCTION INTERNAL';
            Item_Lot."Production Order No." := '';
            IF Item_Lot.Shortage > 0 THEN
                Item_Lot.INSERT;
            IF Item_Req.GET(Shortage_Item) THEN BEGIN
                Item_Req."Required Quantity" += "Saftey Items"."Safety Stock Quantity";
                Item_Req."Req Qty" += "Saftey Items"."Safety Stock Quantity";
                Item_Req.MODIFY;
            END ELSE BEGIN
                Item_Req.INIT;
                Item_Req."Item No." := Shortage_Item;
                Item_Req.Description := Item.Description;
                Item_Req."Required Quantity" := "Saftey Items"."Safety Stock Quantity";
                Item_Req."Req Qty" := "Saftey Items"."Safety Stock Quantity";
                Item_Req.INSERT;
            END;
        END;
    end;


    procedure MSLItemExpiryDate(ILE: Record "Item Ledger Entry"; ForPlan: Boolean) Expired: Boolean
    var
        MSL_ILE: Record "Item Ledger Entry";
        Itm: Record Item;
        IsExpired: Boolean;
        //DateAndTime: DotNet DateAndTime;
        //DayofWeekInput: DotNet FirstDayOfWeek;
        //WeekofYearInput: DotNet FirstWeekOfYear;
        Itm_floor_life: Decimal;
    begin
        IsExpired := FALSE;

        Itm_floor_life := 0;
        IF Itm.GET(ILE."Item No.") THEN BEGIN
            IF (Itm.MSL <> 0) THEN BEGIN
                MSL_ILE.RESET;
                MSL_ILE.SETCURRENTKEY("Item No.", "Entry Type");
                MSL_ILE.SETRANGE("Item No.", ILE."Item No.");
                MSL_ILE.SETRANGE("Entry Type", MSL_ILE."Entry Type"::Purchase);
                MSL_ILE.SETRANGE("Document Type", MSL_ILE."Document Type"::"Purchase Receipt");
                MSL_ILE.SETRANGE("Lot No.", ILE."Lot No.");
                IF MSL_ILE.FINDFIRST THEN BEGIN
                    IF (MSL_ILE."MFD Date" <> 0D) AND (Itm."Component Shelf Life(Years)" > 0) THEN BEGIN
                        // IF DateAndTime.DateDiff('YYYY',MSL_ILE."MFD Date",TODAY,DayofWeekInput,WeekofYearInput) >= Itm."Component Shelf Life(Years)" THEN
                        IF CALCDATE(FORMAT(Item."Component Shelf Life(Years)") + 'Y', MSL_ILE."MFD Date") < TODAY THEN
                            IsExpired := TRUE;
                    END;
                    IF NOT ForPlan THEN BEGIN
                        IF IsExpired = FALSE THEN BEGIN
                            IF NOT (Itm."Floor Life at 25 C 40% RH" IN ['', ' ', 'INFINITE']) THEN BEGIN
                                EVALUATE(Itm_floor_life, Itm."Floor Life at 25 C 40% RH");
                                IF (MSL_ILE."Floor Life" >= Itm_floor_life) AND (Itm_floor_life > 0) THEN
                                    IsExpired := TRUE;
                                IF IsExpired = FALSE THEN
                                    IF MSL_ILE."Recharge Cycles" >= 2 THEN
                                        IsExpired := TRUE;
                            END;
                        END;
                    END;
                END;
            END;
        END;
        EXIT(IsExpired);
    end;
}

