report 33000906 "Shortage Final"
{
    // version NAVW13.10,Eff02,Rev01

    //       PLT:='1D';
    //       "Expected Payment Date":=CALCDATE(PLT,TODAY);
    //       ExpecPayDate:=FORMAT("Expected Payment Date")+' (50%) ,';
    //       "Funds Allocation"("Expected Payment Date",(("Shortage Temp".Shortage*"Shortage Temp"."Unit Cost")*0.5));
    //       PLT:=FORMAT("Shortage Temp"."Lead Time");
    //       "Expected Payment Date":=CALCDATE(PLT,TODAY);
    //       ExpecPayDate+=FORMAT("Expected Payment Date")+' (50%) ';
    //       "Funds Allocation"("Expected Payment Date",(("Shortage Temp".Shortage*"Shortage Temp"."Unit Cost")*0.5));
    // 
    // 
    //       PLT:=FORMAT("Shortage Temp"."Lead Time");
    //       "Expected Payment Date":=CALCDATE(PLT,TODAY);
    //       "Funds Allocation"("Expected Payment Date",(("Shortage Temp".Shortage*"Shortage Temp"."Unit Cost")));
    //  "Shortage Temp"."Unit Cost";
    DefaultLayout = RDLC;
    RDLCLayout = './Shortage Final.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Vendor Register';

    dataset
    {
        dataitem(ProductionOrder9; "Production Order")
        {
            DataItemTableView = WHERE(Status = FILTER(Released));

            trigger OnAfterGetRecord();
            begin
                //MESSAGE('%1',ProductionOrder9."No.");
                //IF ProductionOrder9."No." = 'BRM18CHR0007' THEN
                //  MESSAGE('Production Order...BRM18CHR0007');
                ItemLotNumbers9.RESET;
                ItemLotNumbers9.SETRANGE("Production Order No.", ProductionOrder9."No.");
                ItemLotNumbers9.SETFILTER(Shortage, '<>%1', 0);
                ItemLotNumbers9.SETFILTER(Authorisation, '<>%1', 0);
                IF ItemLotNumbers9.FINDFIRST THEN BEGIN
                    //IF ItemLotNumbers9."Production Order No." = 'BRM18CHR0007' THEN
                    //ERROR('%1',ProductionOrder9);
                    Row += 1;
                    //xlWorkSheet1.Range('A' + FORMAT(Row)).Value := ProductionOrder9."No.";//B2BUpg
                    //xlWorkSheet1.Range('B' + FORMAT(Row)).Value := ProductionOrder9."Prod Start date";//B2BUpg

                    //B2BUpg
                    /*Item.RESET;
                    Item.SETFILTER(Item."No.", ProductionOrder9."Source No.");
                    IF Item.FINDFIRST THEN BEGIN
                        xlWorkSheet1.Range('C' + FORMAT(Row)).Value := Item."Item Sub Group Code";
                        xlWorkSheet1.Range('D' + FORMAT(Row)).Value := ProductionOrder9.Quantity;
                        xlWorkSheet1.Range('E' + FORMAT(Row)).Value := Item."No.of Units" * ProductionOrder9.Quantity;
                    END;*///B2BUpg
                END;

                /*
              IF PrevPDNo <> "Item Lot Numbers9"."Production Order No." THEN BEGIN
                 //IF PrevPDNo <> '' THEN
                 //MESSAGE('1...%1.2...%2',PrevPDNo,"Item Lot Numbers9"."Production Order No.");
                IF rpo.GET(3,"Production Order No.") THEN;
                ERROR('PO9."No." %1.%2',rpo."No.","Item Lot Numbers9"."Production Order No.");
                Row+=1;
                xlWorkSheet1.Range('A' + FORMAT(Row)).Value := "Item Lot Numbers9"."Production Order No.";
                xlWorkSheet1.Range('B' + FORMAT(Row)).Value := PO9."Prod Start date";
                Item.RESET;
                Item.SETFILTER(Item."No.",PO9."Source No.");
                IF Item.FINDFIRST THEN
                BEGIN
                  xlWorkSheet1.Range('C' + FORMAT(Row)).Value := Item."Item Sub Group Code";
                  xlWorkSheet1.Range('D' + FORMAT(Row)).Value := PO9.Quantity;
                  xlWorkSheet1.Range('E' + FORMAT(Row)).Value := Item."No.of Units"*PO9.Quantity;
                END;
                PrevPDNo := "Item Lot Numbers9"."Production Order No."
              END;
              */

            end;

            trigger OnPreDataItem();
            begin
                CLEAR(PrevPDNo);
                /*CLEAR(XLaPP);
                CLEAR(xlRange);
                //  CLEAR(xlWorkBooks);
                CLEAR(xlWorkBook);
                CLEAR(xlRange);
                //CLEAR(xlSheets);
                CLEAR(xlWorkSheet);
                
                //CREATE(XLaPP, TRUE, TRUE);//B2BUpg
                XLaPP.SheetsInNewWorkbook := 1;

                XLaPP.Workbooks.Add();

                xlWorkSheet1 := XLaPP.ActiveSheet;
                xlWorkSheet1.Name := 'Production_Plan';
                xlSheetName := xlWorkSheet1.Name;
                xlSheetName := CONVERTSTR(xlSheetName, ' -+', '___');
                // xlSheetName := CONVERTSTR(xlSheetName,' -+&','____');sujani
                xlWorkSheet1.Range('A1').Value := 'Production Order no.';
                xlWorkSheet1.Range('B1').Value := 'Production Start Date';
                xlWorkSheet1.Range('C1').Value := 'Product Type';
                xlWorkSheet1.Range('D1').Value := 'Quantity';
                xlWorkSheet1.Range('E1').Value := 'No.of Units';
                xlWorkSheet1.Range('F1').Value := 'Shortage';*///B2BUpg

                //"Production Order".SETRANGE("Production Order"."Prod Start date",TODAY-3,TODAY+365);
                //"Production Order".SETFILTER("Production Order"."Prod Start date",'<%1',TODAY+365);
            end;
        }
        dataitem("Item Lot Numbers2"; "Item Lot Numbers")
        {
            DataItemTableView = SORTING("Sales Order No.", "Product Type", "Production Order No.", Authorisation, "Lead Time2")
                                ORDER(Ascending)
                                WHERE(Authorisation = FILTER(WAP | WFA | Authorised | indent),
                                      Shortage = FILTER(> 0),
                                      "Sales Order No." = FILTER(<> ''));
            column(LotGroupFooter5; LotGroupFooter5)
            {
            }
            column(LotGroupFooter6; LotGroupFooter6)
            {
            }
            column(LotGroupFooter7; LotGroupFooter7)
            {
            }
            column(LotGroupFooter8; LotGroupFooter8)
            {
            }
            column(PRODUCTS_COUNT_1__1; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(PRODUCTS_LIST_1__1_; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1_; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2_; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3_; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4_; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5_; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6_; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7_; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8_; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9_; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10_; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(Prev_Customer_Name; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No__; "Prev_Sales_Order_No.")
            {
            }
            column(SALE_ORDER_TOTAL; SALE_ORDER_TOTAL)
            {
            }
            column(Prev_Customer_Name_Control1102154264; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154254; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154260; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154256; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154299; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154300; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154301; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154302; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154303; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154304; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154305; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154306; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154307; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154308; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_COUNT_2__1; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_LIST_2__1_; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1_; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2_; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3_; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4_; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5_; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6_; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7_; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8_; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9_; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10_; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(SALE_ORDER_TOTAL_Control1000000005; SALE_ORDER_TOTAL)
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154395; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154397; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9__Control1102154398; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10__Control1102154400; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154404; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8__Control1102154405; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154408; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7__Control1102154409; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154412; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6__Control1102154413; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154415; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5__Control1102154417; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154419; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4__Control1102154421; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154423; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3__Control1102154425; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154427; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2__Control1102154429; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154431; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1__Control1102154433; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154436; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LIST_2__1__Control1102154437; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_COUNT_2__1_Control1102154438; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_COUNT_3__1; PRODUCTS_COUNT[3] + 1)
            {
            }
            column(Prev_Customer_Name_Control1102154443; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154445; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__10_; PRODUCTS_LEAD_PRICES[3] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__9_; PRODUCTS_LEAD_PRICES[3] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__8_; PRODUCTS_LEAD_PRICES[3] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__7_; PRODUCTS_LEAD_PRICES[3] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__6_; PRODUCTS_LEAD_PRICES[3] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__5_; PRODUCTS_LEAD_PRICES[3] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__4_; PRODUCTS_LEAD_PRICES[3] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__3_; PRODUCTS_LEAD_PRICES[3] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__2_; PRODUCTS_LEAD_PRICES[3] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__1_; PRODUCTS_LEAD_PRICES[3] [1])
            {
            }
            column(PRODUCTS_LIST_3__1_; PRODUCTS_LIST[3] [1])
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154469; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154366; SALE_ORDER_TOTAL)
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154471; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154473; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154475; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154477; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154479; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154481; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154483; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154485; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154487; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154489; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154491; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154492; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(Prev_Customer_Name_Control1102154495; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154497; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9__Control1102154498; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10__Control1102154500; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8__Control1102154503; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7__Control1102154505; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6__Control1102154507; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5__Control1102154509; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4__Control1102154511; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3__Control1102154513; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2__Control1102154515; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1__Control1102154517; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LIST_2__1__Control1102154519; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_COUNT_2__1_Control1102154521; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__10__Control1102154523; PRODUCTS_LEAD_PRICES[3] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__9__Control1102154525; PRODUCTS_LEAD_PRICES[3] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__8__Control1102154527; PRODUCTS_LEAD_PRICES[3] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__7__Control1102154529; PRODUCTS_LEAD_PRICES[3] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__6__Control1102154531; PRODUCTS_LEAD_PRICES[3] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__5__Control1102154533; PRODUCTS_LEAD_PRICES[3] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__4__Control1102154535; PRODUCTS_LEAD_PRICES[3] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__3__Control1102154537; PRODUCTS_LEAD_PRICES[3] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__2__Control1102154539; PRODUCTS_LEAD_PRICES[3] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__1__Control1102154541; PRODUCTS_LEAD_PRICES[3] [1])
            {
            }
            column(PRODUCTS_LIST_3__1__Control1102154543; PRODUCTS_LIST[3] [1])
            {
            }
            column(PRODUCTS_COUNT_3__1_Control1102154545; PRODUCTS_COUNT[3] + 1)
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__10_; PRODUCTS_LEAD_PRICES[4] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__9_; PRODUCTS_LEAD_PRICES[4] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__8_; PRODUCTS_LEAD_PRICES[4] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__7_; PRODUCTS_LEAD_PRICES[4] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__6_; PRODUCTS_LEAD_PRICES[4] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__5_; PRODUCTS_LEAD_PRICES[4] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__4_; PRODUCTS_LEAD_PRICES[4] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__3_; PRODUCTS_LEAD_PRICES[4] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__2_; PRODUCTS_LEAD_PRICES[4] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__1_; PRODUCTS_LEAD_PRICES[4] [1])
            {
            }
            column(PRODUCTS_LIST_4__1_; PRODUCTS_LIST[4] [1])
            {
            }
            column(PRODUCTS_COUNT_4__1; PRODUCTS_COUNT[4] + 1)
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154368; SALE_ORDER_TOTAL)
            {
            }
            column(ORDER_TOTAL; ORDER_TOTAL)
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154008; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154375; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154377; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154379; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154381; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154383; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154385; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154386; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154388; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154650; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154652; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154654; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(Prev_Customer_Name_Control1102154656; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154659; "Prev_Sales_Order_No.")
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154661; SALE_ORDER_TOTAL)
            {
            }
            column(NULL_ORDER_VALUES_1_; NULL_ORDER_VALUES[1])
            {
            }
            column(NULL_ORDER_VALUES_2_; NULL_ORDER_VALUES[2])
            {
            }
            column(NULL_ORDER_VALUES_3_; NULL_ORDER_VALUES[3])
            {
            }
            column(NULL_ORDER_VALUES_4_; NULL_ORDER_VALUES[4])
            {
            }
            column(NULL_ORDER_VALUES_5_; NULL_ORDER_VALUES[5])
            {
            }
            column(NULL_ORDER_VALUES_6_; NULL_ORDER_VALUES[6])
            {
            }
            column(NULL_ORDER_VALUES_7_; NULL_ORDER_VALUES[7])
            {
            }
            column(NULL_ORDER_VALUES_8_; NULL_ORDER_VALUES[8])
            {
            }
            column(NULL_ORDER_VALUES_9_; NULL_ORDER_VALUES[9])
            {
            }
            column(NULL_ORDER_VALUES_10_; NULL_ORDER_VALUES[10])
            {
            }
            column(NULL_ORDER_TOTAL; NULL_ORDER_TOTAL)
            {
            }
            column(Sale_Orders_of_Purchases_which_are__NOT_UNDER_CONTROL___NOT_HAVING_SUFFICIENT_LEAD_TIME_Caption; Sale_Orders_of_Purchases_which_are__NOT_UNDER_CONTROL___NOT_HAVING_SUFFICIENT_LEAD_TIME_CaptionLbl)
            {
            }
            column(SALE_ORDERCaption; SALE_ORDERCaptionLbl)
            {
            }
            column(PRODUCT_TYPECaption; PRODUCT_TYPECaptionLbl)
            {
            }
            column(CUSTOMERCaption; CUSTOMERCaptionLbl)
            {
            }
            column(QUANTTITYCaption; QUANTTITYCaptionLbl)
            {
            }
            column(V2_DAYSCaption; V2_DAYSCaptionLbl)
            {
            }
            column(V4_DAYSCaption; V4_DAYSCaptionLbl)
            {
            }
            column(V7_DAYSCaption; V7_DAYSCaptionLbl)
            {
            }
            column(V15_DAYSCaption; V15_DAYSCaptionLbl)
            {
            }
            column(V21_DAYSCaption; V21_DAYSCaptionLbl)
            {
            }
            column(V25_DAYSCaption; V25_DAYSCaptionLbl)
            {
            }
            column(V30_DAYSCaption; V30_DAYSCaptionLbl)
            {
            }
            column(V45_DAYSCaption; V45_DAYSCaptionLbl)
            {
            }
            column(V60_DAYSCaption; V60_DAYSCaptionLbl)
            {
            }
            column(V90_DAYSCaption; V90_DAYSCaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(TOTAL_ORDERCaption; TOTAL_ORDERCaptionLbl)
            {
            }
            column(Items__Dont_have_Sale_Order_ReferenceCaption; Items__Dont_have_Sale_Order_ReferenceCaptionLbl)
            {
            }
            column(Item_Lot_Numbers2_Item_No; "Item No")
            {
            }
            column(Item_Lot_Numbers2_Planned_Purchase_Date; "Planned Purchase Date")
            {
            }
            column(Item_Lot_Numbers2_Production_Order_No_; "Production Order No.")
            {
            }
            column(Item_Lot_Numbers2_Sales_Order_No_; "Sales Order No.")
            {
            }
            column(Item_Lot_Numbers2_Lead_Time2; "Lead Time2")
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF "Item Lot Numbers2"."Lead Time2" = '2D' THEN
                    TOTAL_LEAD_PRICES[1] += "Item Lot Numbers2".Total
                ELSE
                    IF "Item Lot Numbers2"."Lead Time2" = '4D' THEN
                        TOTAL_LEAD_PRICES[2] += "Item Lot Numbers2".Total
                    ELSE
                        IF "Item Lot Numbers2"."Lead Time2" = '7D' THEN
                            TOTAL_LEAD_PRICES[3] += "Item Lot Numbers2".Total
                        ELSE
                            IF "Item Lot Numbers2"."Lead Time2" = '15D' THEN
                                TOTAL_LEAD_PRICES[4] += "Item Lot Numbers2".Total
                            ELSE
                                IF "Item Lot Numbers2"."Lead Time2" = '21D' THEN
                                    TOTAL_LEAD_PRICES[5] += "Item Lot Numbers2".Total
                                ELSE
                                    IF "Item Lot Numbers2"."Lead Time2" = '25D' THEN
                                        TOTAL_LEAD_PRICES[6] += "Item Lot Numbers2".Total
                                    ELSE
                                        IF "Item Lot Numbers2"."Lead Time2" = '30D' THEN
                                            TOTAL_LEAD_PRICES[7] += "Item Lot Numbers2".Total
                                        ELSE
                                            IF "Item Lot Numbers2"."Lead Time2" = '45D' THEN
                                                TOTAL_LEAD_PRICES[8] += "Item Lot Numbers2".Total
                                            ELSE
                                                IF "Item Lot Numbers2"."Lead Time2" = '60D' THEN
                                                    TOTAL_LEAD_PRICES[9] += "Item Lot Numbers2".Total
                                                ELSE
                                                    IF "Item Lot Numbers2"."Lead Time2" = '90D' THEN
                                                        TOTAL_LEAD_PRICES[10] += "Item Lot Numbers2".Total;


                CASE "Item Lot Numbers2"."Lead Time2" OF

                    '2D':
                        PRICES[1] += "Item Lot Numbers2".Total;
                    '3D':
                        PRICES[2] += "Item Lot Numbers2".Total;
                    '4D':
                        PRICES[3] += "Item Lot Numbers2".Total;
                    '5D':
                        PRICES[4] += "Item Lot Numbers2".Total;
                    '7D':
                        PRICES[5] += "Item Lot Numbers2".Total;
                    '10D':
                        PRICES[6] += "Item Lot Numbers2".Total;
                    '14D':
                        PRICES[7] += "Item Lot Numbers2".Total;
                    '15D':
                        PRICES[8] += "Item Lot Numbers2".Total;
                    '20D':
                        PRICES[9] += "Item Lot Numbers2".Total;
                    '21D':
                        PRICES[10] += "Item Lot Numbers2".Total;
                    '25D':
                        PRICES[11] += "Item Lot Numbers2".Total;
                    '30D':
                        PRICES[12] += "Item Lot Numbers2".Total;
                    '45D':
                        PRICES[13] += "Item Lot Numbers2".Total;
                    '56D':
                        PRICES[14] += "Item Lot Numbers2".Total;
                    '60D':
                        PRICES[15] += "Item Lot Numbers2".Total;
                    '65D':
                        PRICES[16] += "Item Lot Numbers2".Total;
                    '70D':
                        PRICES[17] += "Item Lot Numbers2".Total;
                    '75D':
                        PRICES[18] += "Item Lot Numbers2".Total;
                    '90D':
                        PRICES[19] += "Item Lot Numbers2".Total;
                    '120D':
                        PRICES[20] += "Item Lot Numbers2".Total;
                    ELSE BEGIN
                        PRICES[20] += "Item Lot Numbers2".Total;

                    END;
                END;



                //Rev01 Start
                //Group Condition Start
                IF PrevLeadTime2 <> "Item Lot Numbers2"."Lead Time2" THEN BEGIN
                    PrevLeadTime2 := "Item Lot Numbers2"."Lead Time2";
                END;

                //Item Lot Numbers2, GroupHeader (3) - OnPreSection()
                IF "Prev_Sales_Order_No." = '' THEN
                    "Prev_Sales_Order_No." := "Item Lot Numbers2"."Sales Order No.";
                //Item Lot Numbers2, GroupHeader (3) - OnPreSection()

                //Item Lot Numbers2, GroupFooter (4) - OnPreSection()
                //Group Condition Start
                IF ((PrevLeadTime2 <> PrevGRPLeadTime2) AND (PrevGRPLeadTime2 <> '')) OR (PrvGRPSalesOrderNo <> '') THEN BEGIN
                    FOR temp := 1 TO 20 DO BEGIN
                        IF PRICES[temp] <> 0 THEN BEGIN
                            Row += 1;
                            //Hack
                            //xlWorkSheet2.Range('A' + FORMAT(Row)).Value := "Prev_Sales_Order_No.";//PK
                            //B2BUpg
                            /* xlWorkSheet2.Range('A' + FORMAT(Row)).Value := PrvGRPSalesOrderNo;//"Item Lot Numbers2"."Sales Order No.";
                             xlWorkSheet2.Range('B' + FORMAT(Row)).Value := PrvGRPCustName;//"Item Lot Numbers2"."Customer Name";
                             xlWorkSheet2.Range('C' + FORMAT(Row)).Value := PrvGRPProductionOrderNo;//"Item Lot Numbers2"."Production Order No.";
                             xlWorkSheet2.Range('D' + FORMAT(Row)).Value := PrvGRPProductType;//"Item Lot Numbers2"."Product Type";
                             xlWorkSheet2.Range('H' + FORMAT(Row)).Value := rpo_start_date;

                             IF PrvGRPSalesOrderNo = '' THEN BEGIN
                                 MESSAGE('Testing');
                             END;
                             IF "Item Lot Numbers2"."Sales Order No." = 'STR INTERNAL' THEN
                                 xlWorkSheet2.Range('G' + FORMAT(Row)).Value := 'STR INTERNAL'
                             ELSE
                                 IF COPYSTR("Item Lot Numbers2"."Sales Order No.", 1, 7) = 'EFF/EXP' THEN
                                     xlWorkSheet2.Range('G' + FORMAT(Row)).Value := 'EXPECTED ORDER'
                                 ELSE
                                     IF COPYSTR("Item Lot Numbers2"."Sales Order No.", 1, 7) = 'EFF/SAL' THEN
                                         xlWorkSheet2.Range('G' + FORMAT(Row)).Value := 'SALE ORDER'
                                     ELSE
                                         xlWorkSheet2.Range('G' + FORMAT(Row)).Value := 'INTERNAL ORDER';

                             CASE temp OF
                                 1:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '002D';
                                 2:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '003D';
                                 3:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '004D';
                                 4:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '005D';
                                 5:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '007D';
                                 6:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '010D';
                                 7:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '014D';
                                 8:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '015D';
                                 9:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '020D';
                                 10:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '021D';
                                 11:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '025D';
                                 12:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '030D';
                                 13:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '045D';
                                 14:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '056D';
                                 15:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '060D';
                                 16:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '065D';
                                 17:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '070D';
                                 18:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '075D';
                                 19:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '090D';
                                 20:
                                     xlWorkSheet2.Range('E' + FORMAT(Row)).Value := '>=120D';
                             //21: xlWorkSheet2.Range('E' + FORMAT(Row)).Value :='>120D';
                             END;
                             xlWorkSheet2.Range('F' + FORMAT(Row)).Value := PRICES[temp];*///B2BUpg

                        END;
                    END;

                    FOR temp := 1 TO 20 DO
                        PRICES[temp] := 0;
                    //END;
                    //Item Lot Numbers2, GroupFooter (4) - OnPreSection()
                END;
                //Group condition END

                //Item Lot Numbers2, GroupFooter (5) - OnPreSection()
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    IF (i = 1) THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        LotGroupFooter5 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR k := 1 TO 10 DO
                            SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[1] [k];
                        ORDER_TOTAL += SALE_ORDER_TOTAL;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        LotGroupFooter5 := FALSE;
                END ELSE BEGIN
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    LotGroupFooter5 := FALSE;
                    IF Prev_Product <> "Item Lot Numbers2"."Product Type" THEN BEGIN
                        Prev_Product := "Item Lot Numbers2"."Product Type";
                        i += 1;
                        PRODUCTS_LIST[i] [1] := "Item Lot Numbers2"."Product Type";
                    END ELSE BEGIN
                        IF Prev_Production_Order <> "Item Lot Numbers2"."Production Order No." THEN BEGIN
                            PRODUCTS_COUNT[i] += 1;
                            Prev_Production_Order := "Item Lot Numbers2"."Production Order No.";
                        END;
                    END;
                    CASE "Item Lot Numbers2"."Lead Time2" OF

                        '2D':
                            PRODUCTS_LEAD_PRICES[i] [1] += "Item Lot Numbers2".Total;
                        '4D':
                            PRODUCTS_LEAD_PRICES[i] [2] += "Item Lot Numbers2".Total;
                        '7D':
                            PRODUCTS_LEAD_PRICES[i] [3] += "Item Lot Numbers2".Total;
                        '15D':
                            PRODUCTS_LEAD_PRICES[i] [4] += "Item Lot Numbers2".Total;
                        '21D':
                            PRODUCTS_LEAD_PRICES[i] [5] += "Item Lot Numbers2".Total;
                        '25D':
                            PRODUCTS_LEAD_PRICES[i] [6] += "Item Lot Numbers2".Total;
                        '30D':
                            PRODUCTS_LEAD_PRICES[i] [7] += "Item Lot Numbers2".Total;
                        '45D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers2".Total;
                        '60D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers2".Total;
                        '90D':
                            PRODUCTS_LEAD_PRICES[i] [10] += "Item Lot Numbers2".Total;
                    END;

                END;
                //Item Lot Numbers2, GroupFooter (5) - OnPreSection()

                //Item Lot Numbers2, GroupFooter (6) - OnPreSection()
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    LotGroupFooter6 := TRUE;
                    IF i = 2 THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        LotGroupFooter6 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR J := 1 TO 2 DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];
                        ORDER_TOTAL += SALE_ORDER_TOTAL;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        LotGroupFooter6 := TRUE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    LotGroupFooter6 := FALSE;
                //Item Lot Numbers2, GroupFooter (6) - OnPreSection()

                //Item Lot Numbers2, GroupFooter (7) - OnPreSection()
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    LotGroupFooter7 := TRUE;
                    IF i = 3 THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        LotGroupFooter7 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR J := 1 TO 3 DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];

                        ORDER_TOTAL += SALE_ORDER_TOTAL;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        LotGroupFooter7 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    LotGroupFooter7 := FALSE;
                //Item Lot Numbers2, GroupFooter (7) - OnPreSection()

                //Item Lot Numbers2, GroupFooter (8) - OnPreSection()
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    LotGroupFooter8 := TRUE;
                    IF (i > 3) THEN BEGIN
                        SALE_ORDER_TOTAL := 0;
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        LotGroupFooter8 := TRUE;
                        FOR J := 1 TO i DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];
                        ORDER_TOTAL += SALE_ORDER_TOTAL;
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        LotGroupFooter8 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    LotGroupFooter8 := FALSE;
                //Item Lot Numbers2, GroupFooter (8) - OnPreSection()

                //Item Lot Numbers2, GroupFooter (9) - OnPreSection()


                "Prev_Sales_Order_No." := "Item Lot Numbers2"."Sales Order No.";
                Prev_Customer_Name := "Item Lot Numbers2"."Customer Name";
                Prev_Product := "Item Lot Numbers2"."Product Type";
                Prev_Production_Order := "Item Lot Numbers2"."Production Order No.";
                Previous_Prod_Order := "Item Lot Numbers2"."Production Order No.";
                // xlWorkSheet2.Range('H' + FORMAT(Row)).Value := "Item Lot Numbers2"."Planned Date";
                IF Sale_Order_Change THEN BEGIN
                    FOR i := 1 TO 10 DO BEGIN
                        FOR J := 1 TO 2 DO
                            PRODUCTS_LIST[i] [J] := '';
                        FOR J := 1 TO 10 DO
                            PRODUCTS_LEAD_PRICES[i] [J] := 0;
                        PRODUCTS_COUNT[i] := 0;
                    END;
                    i := 1;
                    PRODUCTS_LIST[i] [1] := "Item Lot Numbers2"."Product Type";

                    CASE "Item Lot Numbers2"."Lead Time2" OF

                        '2D':
                            PRODUCTS_LEAD_PRICES[i] [1] += "Item Lot Numbers2".Total;
                        '4D':
                            PRODUCTS_LEAD_PRICES[i] [2] += "Item Lot Numbers2".Total;
                        '7D':
                            PRODUCTS_LEAD_PRICES[i] [3] += "Item Lot Numbers2".Total;
                        '15D':
                            PRODUCTS_LEAD_PRICES[i] [4] += "Item Lot Numbers2".Total;
                        '21D':
                            PRODUCTS_LEAD_PRICES[i] [5] += "Item Lot Numbers2".Total;
                        '25D':
                            PRODUCTS_LEAD_PRICES[i] [6] += "Item Lot Numbers2".Total;
                        '30D':
                            PRODUCTS_LEAD_PRICES[i] [7] += "Item Lot Numbers2".Total;
                        '45D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers2".Total;
                        '60D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers2".Total;
                        '90D':
                            PRODUCTS_LEAD_PRICES[i] [10] += "Item Lot Numbers2".Total;
                    END;

                    Sale_Order_Change := FALSE;
                END;
                //Item Lot Numbers2, GroupFooter (9) - OnPreSection()


                //Rev01 End
                //Hack
                PrevGRPLeadTime2 := PrevLeadTime2;
                PrvGRPSalesOrderNo := "Item Lot Numbers2"."Sales Order No.";//hack
                PrvGRPCustName := "Item Lot Numbers2"."Customer Name";
                PrvGRPProductionOrderNo := "Item Lot Numbers2"."Production Order No.";
                PrvGRPProductType := "Item Lot Numbers2"."Product Type";
                rpo_start_date := "Item Lot Numbers2"."Planned Date";
                //Hack
            end;

            trigger OnPostDataItem();
            begin
                //Item Lot Numbers2, Footer (11) - OnPreSection()
                SALE_ORDER_TOTAL := 0;
                FOR k := 1 TO 10 DO
                    SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[1] [k];

                ORDER_TOTAL += SALE_ORDER_TOTAL;

                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '2D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[1] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '4D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[2] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '7D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[3] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '15D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[4] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '21D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[5] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '25D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[6] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '30D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[7] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '45D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[8] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '60D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[9] := NULL_ORDER_DETAILS.Total;

                NULL_ORDER_DETAILS.RESET;
                NULL_ORDER_DETAILS.SETCURRENTKEY("Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date");
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Sales Order No.", '');
                NULL_ORDER_DETAILS.SETRANGE(NULL_ORDER_DETAILS."Lead Time2", '90D');
                NULL_ORDER_DETAILS.CALCSUMS(NULL_ORDER_DETAILS.Total);
                NULL_ORDER_VALUES[10] := NULL_ORDER_DETAILS.Total;

                FOR i := 1 TO 10 DO
                    NULL_ORDER_TOTAL += NULL_ORDER_VALUES[i];

                ORDER_TOTAL += NULL_ORDER_TOTAL;
                //B2BUpg
                /*FOR i := 1 TO 2000 DO BEGIN
                    IF FORMAT(xlWorkSheet1.Range('A' + FORMAT(i)).Value) = '' THEN BEGIN
                        Sheet_row := i - 1;
                        i := 2000;
                    END;
                END;

                FOR i := 2 TO Sheet_row DO BEGIN
                    Formula := '=SUMIFS(Shortage_Data!F:F,Shortage_Data!C:C,Production_Plan!A' + FORMAT(i) + ')';
                    xlWorkSheet1.Range('F' + FORMAT(i)).Formula := Formula;
                END;
                xlWorkSheet1.Columns.AutoFit;
                xlWorkSheet2.Columns.AutoFit;
                xlWorkSheet1.Range('D:F').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';*///B2BUpg

                //Item Lot Numbers2, Footer (11) - OnPreSection()
            end;

            trigger OnPreDataItem();
            begin
                //B2BUpg
                /*XLaPP.Worksheets.Add();

                xlWorkSheet2 := XLaPP.ActiveSheet;
                xlWorkSheet2.Name := 'Shortage_Data';
                xlSheetName := xlWorkSheet2.Name;
                xlSheetName := CONVERTSTR(xlSheetName, ' -+', '___');
                //xlSheetName := CONVERTSTR(xlSheetName,' -+&','____'); sujani
                xlWorkSheet2.Range('A1').Value := 'Sale order no';
                xlWorkSheet2.Range('B1').Value := 'Customer Name';
                xlWorkSheet2.Range('C1').Value := 'Production Order No';
                xlWorkSheet2.Range('D1').Value := 'Product';
                xlWorkSheet2.Range('E1').Value := 'Lead Time';
                xlWorkSheet2.Range('F1').Value := 'Total';
                xlWorkSheet2.Range('G1').Value := 'Order Type';
                xlWorkSheet2.Range('H1').Value := 'Production Start Dt';*///B2BUpg //commented by sujani
                                                                          /*
                                                                          xlWorkSheet2.Range('E1').Value := '02D';
                                                                          xlWorkSheet2.Range('F1').Value := '003D';
                                                                          xlWorkSheet2.Range('G1').Value := '004D';
                                                                          xlWorkSheet2.Range('H1').Value := '005D';
                                                                          xlWorkSheet2.Range('I1').Value := '007D';
                                                                          xlWorkSheet2.Range('J1').Value := '010D';
                                                                          xlWorkSheet2.Range('K1').Value := '014D';
                                                                          xlWorkSheet2.Range('L1').Value := '015D';
                                                                          xlWorkSheet2.Range('M1').Value := '020D';
                                                                          xlWorkSheet2.Range('N1').Value := '021D';
                                                                          xlWorkSheet2.Range('O1').Value := '025D';
                                                                          xlWorkSheet2.Range('P1').Value := '030D';
                                                                          xlWorkSheet2.Range('Q1').Value := '045D';
                                                                          xlWorkSheet2.Range('R1').Value := '056D';
                                                                          xlWorkSheet2.Range('S1').Value := '060D';
                                                                          xlWorkSheet2.Range('T1').Value := '065D';
                                                                          xlWorkSheet2.Range('U1').Value := '070D';
                                                                          xlWorkSheet2.Range('V1').Value := '075D';
                                                                          xlWorkSheet2.Range('W1').Value := '090D';
                                                                          xlWorkSheet2.Range('X1').Value := '120D';
                                                                          xlWorkSheet2.Range('Y1').Value := 'Total';
                                                                          */
                Row := 1;

                /*i:=0;
                CurrReport.NEWPAGE;
                */
                FOR i := 1 TO 10 DO
                    TOTAL_LEAD_PRICES[i] := 0;
                FOR temp := 1 TO 20 DO
                    PRICES[temp] := 0;

                i := 1;

            end;
        }
        dataitem("Shortage Temp"; "Shortage Temp")
        {
            CalcFields = "Minimum Order Qty.";
            DataItemTableView = SORTING("Total Cost", "Lead Time", "Item No.")
                                ORDER(Descending)
                                WHERE("Not Needed" = CONST(false),
                                      "Don't Repeat" = CONST(false));
            column(ShortTempFooter5; ShortTempFooter5)
            {
            }
            column(Shortage_Temp_Description; Description)
            {
            }
            column(Shortage_Temp_Shortage; Shortage)
            {
            }
            column(Shortage_Temp__Vendor_Name_; "Vendor Name")
            {
            }
            column(Shortage_Temp__Shortage_Temp___Unit_Cost_; "Shortage Temp"."Unit Cost")
            {
                DecimalPlaces = 2 : 3;
            }
            column(Shortage_Temp__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(Shortage_Temp__Lead_Time_; "Lead Time")
            {
            }
            column(Expected_Payment_Date_; "Expected Payment Date")
            {
            }
            column(PLT; PLT)
            {
            }
            column(Shortage_Temp___Unit_Cost__Shortage; "Shortage Temp"."Unit Cost" * Shortage)
            {
                DecimalPlaces = 2 : 3;
            }
            column(Order_Qty; Order_Qty)
            {
            }
            column(Shortage_Temp___Unit_Cost__Order_Qty; "Shortage Temp"."Unit Cost" * Order_Qty)
            {
                DecimalPlaces = 2 : 3;
            }
            column(Shortage_Temp__Minimum_Order_Qty__; "Minimum Order Qty.")
            {
            }
            column(Order_Value; Order_Value)
            {
            }
            column(TOT; TOT)
            {
            }
            column(Lead_Time_item_1__2_; Lead_Time_item[1] [2])
            {
            }
            column(Lead_Time_Value_1__3_; Lead_Time_Value[1] [3])
            {
            }
            column(Lead_Time_Value_1__4_; Lead_Time_Value[1] [4])
            {
            }
            column(Lead_Unit_Cost_1__2_; Lead_Unit_Cost[1] [2])
            {
            }
            column(Lead_Unit_Cost_1__1_; Lead_Unit_Cost[1] [1])
            {
            }
            column(Lead_Time_Value_1__1_; Lead_Time_Value[1] [1])
            {
            }
            column(Lead_Time_item_1__1_; Lead_Time_item[1] [1])
            {
            }
            column(Lead_Time_Value_1__2_; Lead_Time_Value[1] [2])
            {
            }
            column(Lead_Unit_Cost_2__1_; Lead_Unit_Cost[2] [1])
            {
            }
            column(Lead_Time_Value_2__2_; Lead_Time_Value[2] [2])
            {
            }
            column(Lead_Time_Value_2__1_; Lead_Time_Value[2] [1])
            {
            }
            column(Lead_Time_item_2__1_; Lead_Time_item[2] [1])
            {
            }
            column(Lead_Unit_Cost_2__2_; Lead_Unit_Cost[2] [2])
            {
            }
            column(Lead_Time_Value_2__4_; Lead_Time_Value[2] [4])
            {
            }
            column(Lead_Time_Value_2__3_; Lead_Time_Value[2] [3])
            {
            }
            column(Lead_Time_item_2__2_; Lead_Time_item[2] [2])
            {
            }
            column(Lead_Unit_Cost_3__1_; Lead_Unit_Cost[3] [1])
            {
            }
            column(Lead_Time_Value_3__2_; Lead_Time_Value[3] [2])
            {
            }
            column(Lead_Time_Value_3__1_; Lead_Time_Value[3] [1])
            {
            }
            column(Lead_Time_item_3__1_; Lead_Time_item[3] [1])
            {
            }
            column(Lead_Unit_Cost_3__2_; Lead_Unit_Cost[3] [2])
            {
            }
            column(Lead_Time_Value_3__4_; Lead_Time_Value[3] [4])
            {
            }
            column(Lead_Time_Value_3__3_; Lead_Time_Value[3] [3])
            {
            }
            column(Lead_Time_item_3__2_; Lead_Time_item[3] [2])
            {
            }
            column(Lead_Unit_Cost_4__1_; Lead_Unit_Cost[4] [1])
            {
            }
            column(Lead_Time_Value_4__2_; Lead_Time_Value[4] [2])
            {
            }
            column(Lead_Time_Value_4__1_; Lead_Time_Value[4] [1])
            {
            }
            column(Lead_Time_item_4__1_; Lead_Time_item[4] [1])
            {
            }
            column(Lead_Unit_Cost_4__2_; Lead_Unit_Cost[4] [2])
            {
            }
            column(Lead_Time_Value_4__4_; Lead_Time_Value[4] [4])
            {
            }
            column(Lead_Time_Value_4__3_; Lead_Time_Value[4] [3])
            {
            }
            column(Lead_Time_item_4__2_; Lead_Time_item[4] [2])
            {
            }
            column(Lead_Unit_Cost_5__1_; Lead_Unit_Cost[5] [1])
            {
            }
            column(Lead_Time_Value_5__2_; Lead_Time_Value[5] [2])
            {
            }
            column(Lead_Time_Value_5__1_; Lead_Time_Value[5] [1])
            {
            }
            column(Lead_Time_item_5__1_; Lead_Time_item[5] [1])
            {
            }
            column(Lead_Unit_Cost_5__2_; Lead_Unit_Cost[5] [2])
            {
            }
            column(Lead_Time_Value_5__4_; Lead_Time_Value[5] [4])
            {
            }
            column(Lead_Time_Value_5__3_; Lead_Time_Value[5] [3])
            {
            }
            column(Lead_Time_item_5__2_; Lead_Time_item[5] [2])
            {
            }
            column(Lead_Unit_Cost_6__1_; Lead_Unit_Cost[6] [1])
            {
            }
            column(Lead_Time_Value_6__2_; Lead_Time_Value[6] [2])
            {
            }
            column(Lead_Time_Value_6__1_; Lead_Time_Value[6] [1])
            {
            }
            column(Lead_Time_item_6__1_; Lead_Time_item[6] [1])
            {
            }
            column(Lead_Unit_Cost_6__2_; Lead_Unit_Cost[6] [2])
            {
            }
            column(Lead_Time_Value_6__4_; Lead_Time_Value[6] [4])
            {
            }
            column(Lead_Time_Value_6__3_; Lead_Time_Value[6] [3])
            {
            }
            column(Lead_Time_item_6__2_; Lead_Time_item[6] [2])
            {
            }
            column(Lead_Unit_Cost_7__1_; Lead_Unit_Cost[7] [1])
            {
            }
            column(Lead_Time_Value_7__2_; Lead_Time_Value[7] [2])
            {
            }
            column(Lead_Time_Value_7__1_; Lead_Time_Value[7] [1])
            {
            }
            column(Lead_Time_item_7__1_; Lead_Time_item[7] [1])
            {
            }
            column(Lead_Unit_Cost_7__2_; Lead_Unit_Cost[7] [2])
            {
            }
            column(Lead_Time_Value_7__4_; Lead_Time_Value[7] [4])
            {
            }
            column(Lead_Time_Value_7__3_; Lead_Time_Value[7] [3])
            {
            }
            column(Lead_Time_item_7__2_; Lead_Time_item[7] [2])
            {
            }
            column(Lead_Unit_Cost_8__1_; Lead_Unit_Cost[8] [1])
            {
            }
            column(Lead_Time_Value_8__2_; Lead_Time_Value[8] [2])
            {
            }
            column(Lead_Time_Value_8__1_; Lead_Time_Value[8] [1])
            {
            }
            column(Lead_Time_item_8__1_; Lead_Time_item[8] [1])
            {
            }
            column(Lead_Unit_Cost_8__2_; Lead_Unit_Cost[8] [2])
            {
            }
            column(Lead_Time_Value_8__4_; Lead_Time_Value[8] [4])
            {
            }
            column(Lead_Time_Value_8__3_; Lead_Time_Value[8] [3])
            {
            }
            column(Lead_Time_item_8__2_; Lead_Time_item[8] [2])
            {
            }
            column(Lead_Unit_Cost_9__1_; Lead_Unit_Cost[9] [1])
            {
            }
            column(Lead_Time_Value_9__2_; Lead_Time_Value[9] [2])
            {
            }
            column(Lead_Time_Value_9__1_; Lead_Time_Value[9] [1])
            {
            }
            column(Lead_Time_item_9__1_; Lead_Time_item[9] [1])
            {
            }
            column(Lead_Unit_Cost_9__2_; Lead_Unit_Cost[9] [2])
            {
            }
            column(Lead_Time_Value_9__4_; Lead_Time_Value[9] [4])
            {
            }
            column(Lead_Time_Value_9__3_; Lead_Time_Value[9] [3])
            {
            }
            column(Lead_Time_item_9__2_; Lead_Time_item[9] [2])
            {
            }
            column(Items_ListCaption; Items_ListCaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(Shortage_QuantityCaption; Shortage_QuantityCaptionLbl)
            {
            }
            column(Shortage_Temp__Vendor_Name_Caption; FIELDCAPTION("Vendor Name"))
            {
            }
            column(Shortage_Temp__Shortage_Temp___Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(Shortage_Temp__Lead_Time_Caption; FIELDCAPTION("Lead Time"))
            {
            }
            column(Paymnet_Lead_TimeCaption; Paymnet_Lead_TimeCaptionLbl)
            {
            }
            column(Expected_Payment_DateCaption; Expected_Payment_DateCaptionLbl)
            {
            }
            column(Total_Cost__Shortage_Caption; Total_Cost__Shortage_CaptionLbl)
            {
            }
            column(Order_QuantityCaption; Order_QuantityCaptionLbl)
            {
            }
            column(Total_Cost__Order_Caption; Total_Cost__Order_CaptionLbl)
            {
            }
            column(Shortage_Temp__Minimum_Order_Qty__Caption; FIELDCAPTION("Minimum Order Qty."))
            {
            }
            column(Lead_TimeCaption; Lead_TimeCaptionLbl)
            {
            }
            column(V2DCaption; V2DCaptionLbl)
            {
            }
            column(V45_DCaption; V45_DCaptionLbl)
            {
            }
            column(Minimum_Value_Item_DetailsCaption; Minimum_Value_Item_DetailsCaptionLbl)
            {
            }
            column(V4DCaption; V4DCaptionLbl)
            {
            }
            column(Maximum_Value_Item_DetailsCaption; Maximum_Value_Item_DetailsCaptionLbl)
            {
            }
            column(Total_CostCaption; Total_CostCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(ItemCaption_Control1102154043; ItemCaption_Control1102154043Lbl)
            {
            }
            column(Total_CostCaption_Control1102154044; Total_CostCaption_Control1102154044Lbl)
            {
            }
            column(QtyCaption_Control1102154045; QtyCaption_Control1102154045Lbl)
            {
            }
            column(Unit_CostCaption_Control1102154046; Unit_CostCaption_Control1102154046Lbl)
            {
            }
            column(ItemCaption_Control1102154047; ItemCaption_Control1102154047Lbl)
            {
            }
            column(V15DCaption; V15DCaptionLbl)
            {
            }
            column(V7DCaption; V7DCaptionLbl)
            {
            }
            column(V25DCaption; V25DCaptionLbl)
            {
            }
            column(V21DCaption; V21DCaptionLbl)
            {
            }
            column(V45DCaption; V45DCaptionLbl)
            {
            }
            column(V30DCaption; V30DCaptionLbl)
            {
            }
            column(Lead_Time_Wise_Maximium_and_Minimum_Value_Items_ReportCaption; Lead_Time_Wise_Maximium_and_Minimum_Value_Items_ReportCaptionLbl)
            {
            }
            column(Shortage_Temp_Item_No_; "Item No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                //Rev01 Start

                //Shortage Temp, Body (3) - OnPreSection()

                PLT := '';
                Order_Qty := 0;
                //Order_Value:=0;
                /*
                IF Item.GET("Shortage Temp"."Item No.") THEN BEGIN
                  IF Item."Minimum Order Quantity">0 THEN BEGIN
                    IF Item."Minimum Order Quantity">1 THEN BEGIN
                      IF "Shortage Temp".Shortage<Item."Minimum Order Quantity" THEN
                         Order_Qty:=Item."Minimum Order Quantity"
                      ELSE
                        Order_Qty:=(("Shortage Temp".Shortage DIV Item."Minimum Order Quantity" )+1)*Item."Minimum Order Quantity"
                      END ELSE
                       Order_Qty:="Shortage Temp".Shortage;
                    END ELSE
                  ERROR('THERE IS NO MINIMUM ORDER QUANTITY FOR '+ Item.Description);
                END;
                */
                // WRITTEN BY SANTHOSH
                IF Item.GET("Shortage Temp"."Item No.") THEN BEGIN
                    IF Item.EFF_MOQ > 0 THEN
                        MOQ_Temp := Item.EFF_MOQ
                    ELSE
                        MOQ_Temp := Item."Minimum Order Quantity";
                    IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" = 0) THEN BEGIN
                        IF MOQ_Temp > 1 THEN BEGIN
                            IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                Order_Qty := MOQ_Temp
                            ELSE
                                Order_Qty := "Shortage Temp".Shortage;
                        END ELSE BEGIN
                            Order_Qty := "Shortage Temp".Shortage;
                        END;
                    END ELSE
                        IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" <= MOQ_Temp) THEN BEGIN
                            IF MOQ_Temp > 1 THEN BEGIN
                                IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                    Order_Qty := MOQ_Temp
                                ELSE BEGIN
                                    IF MOQ_Temp = 1 THEN
                                        Order_Qty := ("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") * Item."Standard Packing Quantity"
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                END;
                            END ELSE
                                Order_Qty := "Shortage Temp".Shortage;
                        END ELSE
                            IF (MOQ_Temp > 0) AND (Item."Standard Packing Quantity" > MOQ_Temp) THEN BEGIN
                                IF MOQ_Temp > 1 THEN BEGIN
                                    IF "Shortage Temp".Shortage < MOQ_Temp THEN
                                        Order_Qty := MOQ_Temp
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV MOQ_Temp) + 1) * MOQ_Temp
                                END ELSE
                                    Order_Qty := "Shortage Temp".Shortage;

                            END ELSE
                                IF (MOQ_Temp = 0) AND (Item."Standard Packing Quantity" > 0) THEN BEGIN
                                    IF "Shortage Temp".Shortage < Item."Standard Packing Quantity" THEN
                                        Order_Qty := Item."Standard Packing Quantity"
                                    ELSE
                                        Order_Qty := (("Shortage Temp".Shortage DIV Item."Standard Packing Quantity") + 1) * Item."Standard Packing Quantity"
                                END;
                END;
                Vendor.RESET;
                "Expected Payment Date" := 0D;
                TOT += ("Shortage Temp".Shortage * "Shortage Temp"."Unit Cost");
                Order_Value += ("Shortage Temp"."Unit Cost" * Order_Qty);
                IF Vendor.GET("Shortage Temp"."Suitable Vendor") THEN BEGIN
                    IF Vendor."Payment Terms Code" = '' THEN BEGIN
                        ERROR('There is No Payment Terms Code For ' + Vendor.Name);
                        CurrReport.BREAK;
                    END;
                    PLT := Vendor."Payment Terms Code";
                    IF (Vendor."Payment Terms Code" = '15D') OR (Vendor."Payment Terms Code" = '15PDC') OR (Vendor."Payment Terms Code" = '15D-E') THEN BEGIN
                        PLT := FORMAT("Shortage Temp"."Lead Time");
                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                        PLT := '15D';
                        "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                        ExpecPayDate := FORMAT("Expected Payment Date");
                    END ELSE
                        IF (Vendor."Payment Terms Code" = '100D') THEN BEGIN
                            PLT := FORMAT("Shortage Temp"."Lead Time");
                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                            PLT := '100D';
                            "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                            ExpecPayDate := FORMAT("Expected Payment Date");
                        END ELSE
                            IF (Vendor."Payment Terms Code" = '1M') OR (Vendor."Payment Terms Code" = '30PDC') THEN BEGIN
                                PLT := FORMAT("Shortage Temp"."Lead Time");
                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                PLT := '1M';
                                "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                ExpecPayDate := FORMAT("Expected Payment Date");
                            END ELSE
                                IF (Vendor."Payment Terms Code" = 'QUART') THEN BEGIN
                                    PLT := FORMAT("Shortage Temp"."Lead Time");
                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                    PLT := '3M';
                                    "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                    ExpecPayDate := FORMAT("Expected Payment Date");
                                END ELSE
                                    IF (Vendor."Payment Terms Code" = '40PDC') OR (Vendor."Payment Terms Code" = '40D') THEN BEGIN
                                        PLT := FORMAT("Shortage Temp"."Lead Time");
                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                        PLT := '40D';
                                        "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                        ExpecPayDate := FORMAT("Expected Payment Date");
                                    END ELSE
                                        IF (Vendor."Payment Terms Code" = '45D') OR (Vendor."Payment Terms Code" = '45D-B') THEN BEGIN
                                            PLT := FORMAT("Shortage Temp"."Lead Time");
                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                            PLT := '45D';
                                            "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                            ExpecPayDate := FORMAT("Expected Payment Date");
                                        END ELSE
                                            IF (Vendor."Payment Terms Code" = '7D') THEN BEGIN
                                                PLT := FORMAT("Shortage Temp"."Lead Time");
                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                PLT := '7D';
                                                "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                                ExpecPayDate := FORMAT("Expected Payment Date");
                                            END ELSE
                                                IF (Vendor."Payment Terms Code" = '60PDC') OR (Vendor."Payment Terms Code" = '60D') THEN BEGIN
                                                    PLT := FORMAT("Shortage Temp"."Lead Time");
                                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                    PLT := '60D';
                                                    "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                                    ExpecPayDate := FORMAT("Expected Payment Date");
                                                END ELSE
                                                    IF (Vendor."Payment Terms Code" = 'ADVANCE') OR (Vendor."Payment Terms Code" = 'AG') OR
                                                        (Vendor."Payment Terms Code" = 'AR') OR (Vendor."Payment Terms Code" = 'CASH') OR
                                                        (Vendor."Payment Terms Code" = '15D-A') THEN BEGIN
                                                        PLT := FORMAT("Shortage Temp"."Lead Time");
                                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                                        ExpecPayDate := FORMAT("Expected Payment Date");
                                                    END ELSE
                                                        IF (Vendor."Payment Terms Code" = 'TOTADV') OR (Vendor."Payment Terms Code" = '45D-A') THEN BEGIN
                                                            PLT := '1D';
                                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                                            ExpecPayDate := FORMAT("Expected Payment Date");
                                                        END ELSE
                                                            IF (Vendor."Payment Terms Code" = 'ADV') OR (Vendor."Payment Terms Code" = '30D-B') OR
                                                                (Vendor."Payment Terms Code" = '30D-C') OR (Vendor."Payment Terms Code" = '15-DAYS') OR
                                                                (Vendor."Payment Terms Code" = '30D-A') THEN BEGIN
                                                                PLT := '1D';
                                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.5));
                                                                PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.5));

                                                            END ELSE
                                                                IF (Vendor."Payment Terms Code" = '25%') OR (Vendor."Payment Terms Code" = '30-G') THEN BEGIN
                                                                    PLT := '1D';
                                                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                    ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.25));
                                                                    PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                    ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.75));
                                                                END ELSE
                                                                    IF (Vendor."Payment Terms Code" = '30-F') OR (Vendor."Payment Terms Code" = '30-G') OR
                                                                       (Vendor."Payment Terms Code" = '7D-B') THEN BEGIN
                                                                        PLT := '1D';
                                                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                        ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.2));
                                                                        PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                        ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.8));
                                                                    END ELSE
                                                                        IF (Vendor."Payment Terms Code" = '30D') THEN BEGIN
                                                                            PLT := '1D';
                                                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                            ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.4));
                                                                            PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                            ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.6));
                                                                        END ELSE
                                                                            IF (Vendor."Payment Terms Code" = '30D-D') OR (Vendor."Payment Terms Code" = '30D-H') OR
                                                                               (Vendor."Payment Terms Code" = '7D-A') THEN BEGIN
                                                                                PLT := '1D';
                                                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.3));
                                                                                PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.7));
                                                                            END ELSE
                                                                                IF (Vendor."Payment Terms Code" = '30D-E') THEN BEGIN
                                                                                    PLT := '1D';
                                                                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                    ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.6));
                                                                                    PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                                    "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                    ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                                    "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.4));
                                                                                END ELSE
                                                                                    IF (Vendor."Payment Terms Code" = '30D-I') THEN BEGIN
                                                                                        PLT := '1D';
                                                                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                        ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.1));
                                                                                        PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                                        "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                        ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                                        "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.9));
                                                                                    END ELSE
                                                                                        IF (Vendor."Payment Terms Code" = '30D-I') THEN BEGIN
                                                                                            PLT := '1D';
                                                                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                            ExpecPayDate := FORMAT("Expected Payment Date") + ' (50%) ,';
                                                                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.1));
                                                                                            PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                                            "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                            ExpecPayDate += FORMAT("Expected Payment Date") + ' (50%) ';
                                                                                            "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost") * 0.9));

                                                                                        END ELSE
                                                                                            IF (Vendor."Payment Terms Code" = '100%COD') THEN BEGIN
                                                                                                PLT := FORMAT("Shortage Temp"."Lead Time");
                                                                                                "Expected Payment Date" := CALCDATE(PLT, TODAY);
                                                                                                PLT := '0D';
                                                                                                "Expected Payment Date" := CALCDATE(PLT, "Expected Payment Date");
                                                                                                "Funds Allocation"("Expected Payment Date", ((Order_Qty * "Shortage Temp"."Unit Cost")));
                                                                                                ExpecPayDate := FORMAT("Expected Payment Date");
                                                                                            END;

                END;
                IF "Expected Payment Date" = 0D THEN
                    PURCH_NOT_HAVING_EXPEC_DT += (Order_Qty * "Shortage Temp"."Unit Cost");

                ROW1 += 1;
                //B2BUpg
                /*xlWorkSheet3.Range('A' + FORMAT(ROW1)).Value := "Shortage Temp"."Item No.";
                xlWorkSheet3.Range('B' + FORMAT(ROW1)).Value := "Shortage Temp".Description;
                IF STRLEN(FORMAT("Shortage Temp"."Lead Time")) = 2 THEN
                    xlWorkSheet3.Range('C' + FORMAT(ROW1)).Value := '00' + FORMAT("Shortage Temp"."Lead Time")
                ELSE
                    IF STRLEN(FORMAT("Shortage Temp"."Lead Time")) = 3 THEN
                        xlWorkSheet3.Range('C' + FORMAT(ROW1)).Value := '0' + FORMAT("Shortage Temp"."Lead Time")
                    ELSE
                        xlWorkSheet3.Range('C' + FORMAT(ROW1)).Value := FORMAT("Shortage Temp"."Lead Time");
                xlWorkSheet3.Range('D' + FORMAT(ROW1)).Value := "Shortage Temp".Shortage;
                xlWorkSheet3.Range('E' + FORMAT(ROW1)).Value := "Shortage Temp".Shortage * "Shortage Temp"."Unit Cost";
                xlWorkSheet3.Range('F' + FORMAT(ROW1)).Value := "Shortage Temp"."Suitable Vendor";
                xlWorkSheet3.Range('G' + FORMAT(ROW1)).Value := "Shortage Temp"."Vendor Name";
                xlWorkSheet3.Range('H' + FORMAT(ROW1)).Value := Order_Qty;
                xlWorkSheet3.Range('I' + FORMAT(ROW1)).Value := Order_Qty * "Shortage Temp"."Unit Cost";
                xlWorkSheet3.Range('J' + FORMAT(ROW1)).Value := FORMAT("Expected Payment Date");
                xlWorkSheet3.Range('K' + FORMAT(ROW1)).Value := Order_Qty - "Shortage Temp".Shortage;
                xlWorkSheet3.Range('L' + FORMAT(ROW1)).Value := (Order_Qty - "Shortage Temp".Shortage) * "Shortage Temp"."Unit Cost";*///B2BUpg
                //Shortage Temp, Body (3) - OnPreSection()


                //Shortage Temp, Footer (5) - OnPreSection()
                // MESSAGE(FORMAT(Tot_With_UC));
                FOR i := 1 TO 9 DO BEGIN
                    IF (Lead_Time_Value[i] [1] > 0) AND (Lead_Time_Value[i] [2] > 0) THEN
                        Lead_Unit_Cost[i] [1] := Lead_Time_Value[i] [2] / Lead_Time_Value[i] [1];
                    IF (Lead_Time_Value[i] [3] > 0) AND (Lead_Time_Value[i] [4] > 0) THEN
                        Lead_Unit_Cost[i] [2] := Lead_Time_Value[i] [4] / Lead_Time_Value[i] [3];
                END;
                //CurrReport.SHOWOUTPUT:=FALSE;
                ShortTempFooter5 := FALSE;
                //Rev01 End

            end;

            trigger OnPostDataItem();
            begin
                //B2BUpg
                /* xlWorkSheet3.Columns.AutoFit;
                 xlWorkSheet3.Range('A:I').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';
                 xlWorkSheet3.Range('K:L').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';*///B2BUpg
            end;

            trigger OnPreDataItem();
            begin
                //IF Choice=Choice::"Groups " THEN
                //  CurrReport.BREAK;


                PO.DELETEALL;
                I1.DELETEALL;
                I2.DELETEALL;
                I3.DELETEALL;
                i4.DELETEALL;
                //B2BUpg
                /*XLaPP.Worksheets.Add();

                xlWorkSheet3 := XLaPP.ActiveSheet;
                xlWorkSheet3.Name := 'Shortage_Item_Data';
                xlSheetName := xlWorkSheet2.Name;
                //xlSheetName := CONVERTSTR(xlSheetName,' -+','___');sujani
                xlSheetName := CONVERTSTR(xlSheetName, ' -+&', '____');
                xlWorkSheet3.Range('A1').Value := 'Item No.';
                xlWorkSheet3.Range('B1').Value := 'Description';
                xlWorkSheet3.Range('C1').Value := 'Lead Time';
                xlWorkSheet3.Range('D1').Value := 'Shortage';
                xlWorkSheet3.Range('E1').Value := 'Shortage_Value';
                xlWorkSheet3.Range('F1').Value := 'Suitable Vendor';
                xlWorkSheet3.Range('G1').Value := 'Vendor Name';
                xlWorkSheet3.Range('H1').Value := 'Order Qty';
                xlWorkSheet3.Range('I1').Value := 'Total';
                xlWorkSheet3.Range('J1').Value := 'Expected Payment Date';
                xlWorkSheet3.Range('K1').Value := 'Excess MOQ_QTY';
                xlWorkSheet3.Range('L1').Value := 'Excess MOQ_Value';*///B2BUpg
                ROW1 := 1;
            end;
        }
        dataitem("Item Lot Numbers"; "Item Lot Numbers")
        {
            DataItemTableView = SORTING("Sales Order No.", "Production Order No.")
                                ORDER(Ascending)
                                WHERE(Authorisation = CONST(WFA),
                                      Shortage = FILTER(> 0));
            column(Item_Lot_Numbers__Sales_Order_No__; "Sales Order No.")
            {
            }
            column(Item_Lot_Numbers_Item_No; "Item No")
            {
            }
            column(Item_Lot_Numbers_Planned_Purchase_Date; "Planned Purchase Date")
            {
            }
            column(Item_Lot_Numbers_Production_Order_No_; "Production Order No.")
            {
            }

            trigger OnPreDataItem();
            begin
                //IF Choice=Choice::"Groups " THEN
                CurrReport.BREAK;
            end;
        }
        dataitem(DataItem5444; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(Pay_Date; Pay_Date)
            {
            }
            column(Pay_Temp; Pay_Temp)
            {
            }
            column(TOT_Control1102154026; TOT)
            {
            }
            column(PURCH_NOT_HAVING_EXPEC_DT; PURCH_NOT_HAVING_EXPEC_DT)
            {
            }
            column(Summarised_Payment_ReportCaption; Summarised_Payment_ReportCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(ValueCaption; ValueCaptionLbl)
            {
            }
            column(Purchases_Don_t_have_Expected_Payment_DatesCaption; Purchases_Don_t_have_Expected_Payment_DatesCaptionLbl)
            {
            }
            column(Integer_Number; Number)
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF "Break" THEN
                    CurrReport.BREAK;

                //Rev01 Start

                //Integer, Body (3) - OnPreSection()
                Pay_Temp := PO.Quantity;
                Pay_Date := PO."No.";
                TOT += Pay_Temp;
                //Integer, Body (3) - OnPreSection()


                //Rev01 End
                IF PO.NEXT = 0 THEN
                    CurrReport.BREAK;
            end;

            trigger OnPostDataItem();
            begin
                //Integer, Footer (4) - OnPreSection()
                //CurrReport.SHOWOUTPUT:=FALSE;
                TOT += PURCH_NOT_HAVING_EXPEC_DT;
                //Integer, Footer (4) - OnPreSection()
            end;

            trigger OnPreDataItem();
            begin
                //IF Choice=Choice::"Groups " THEN
                // CurrReport.BREAK;

                PO.RESET;
                TOT := 0;

                PO.SETRANGE(PO.Quantity, 1, 1000000000);
                IF PO.FIND('-') THEN BEGIN

                END ELSE
                    CurrReport.BREAK;
                "Break" := FALSE;
                Line := 0;
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
                    field(Choice; Choice)
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
        //B2BUpg
        /*
          xlWorkSheet2.Columns.AutoFit;
          xlWorkSheet2.Range('F:F').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';

          ExcelBuffer.VALIDATE("Column No.", 8 + NoOfColumns);
          xlPivotCache :=
            XLaPP.ActiveWorkbook.PivotCaches.Add(1, STRSUBSTNO('%1!A1:%2%3',
          xlWorkSheet2.Name, ExcelBuffer.xlColID, Row));
          xlWorkSheet2.Select;

          xlPivotCache.CreatePivotTable('', 'PivotTable1');
          xlWorkSheet2 := XLaPP.ActiveSheet();
          xlWorkSheet2.Name := 'Summary';
          xlPivotTable := xlWorkSheet2.PivotTables('PivotTable1');

          xlPivotField := xlPivotTable.PivotFields('Order Type');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 1;
          xlPivotField.Position := 1;
          xlPivotField.Subtotals(1, FALSE);

          xlPivotField := xlPivotTable.PivotFields('Customer Name');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 1;
          xlPivotField.Position := 2;
          xlPivotField.Subtotals(1, FALSE);


          xlPivotField := xlPivotTable.PivotFields('Lead Time');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 2;
          xlPivotField.Position := 1;
          xlPivotField.Subtotals(1, FALSE);

          xlPivotField := xlPivotTable.PivotFields('Total');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 4;
          xlPivotField.Position := 1;
          xlPivotField."Function" := 0;
          xlPivotField.Caption := ' Shortage Value';

          xlPivotField := xlPivotTable.PivotFields('Production Start Dt');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 1;
          xlPivotField.Position := 2;
          xlPivotField.Subtotals(1, FALSE);
          // xlPivotField.Caption:='Production Start Dt'; //commented by sujani

          xlWorkSheet2.Range('C1:Q1000').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';
          xlWorkSheet2.Columns.AutoFit;

          //Pivot Table 2
          ExcelBuffer.VALIDATE("Column No.", 6 + NoOfColumns);////commented by sujani

          xlPivotCache :=
            XLaPP.ActiveWorkbook.PivotCaches.Add(1, STRSUBSTNO('%1!A1:%2%3',
          xlWorkSheet1.Name, ExcelBuffer.xlColID, Sheet_row));


          xlPivotCache.CreatePivotTable(xlWorkSheet2.Range('Z3:Z3'), 'PivotTable2');
          xlPivotTable := xlWorkSheet2.PivotTables('PivotTable2');

          xlPivotField := xlPivotTable.PivotFields('Production Start Date');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 1;
          xlPivotField.Position := 1;
          xlPivotField.Subtotals(1, FALSE);

          xlPivotField := xlPivotTable.PivotFields('Shortage');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 4;
          xlPivotField.Position := 1;
          xlPivotField."Function" := 0;
          xlPivotField.Caption := 'Shortage Value';

          xlPivotField := xlPivotTable.PivotFields('No.of Units');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 4;
          xlPivotField.Position := 2;
          xlPivotField."Function" := 0;
          xlPivotField.Caption := 'Units Planned';

          xlPivotField := xlPivotTable.DataPivotField;
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 2;
          xlPivotField.Position := 1;

          xlPivotField := xlPivotTable.PivotFields('Production Start Date');
          xlPivotField.AutoSort(1, 'Production Start Date');

          //Pivot table 3
          xlPivotCache.CreatePivotTable(xlWorkSheet2.Range('AC3:AC3'), 'PivotTable3');
          xlPivotTable := xlWorkSheet2.PivotTables('PivotTable3');

          xlPivotField := xlPivotTable.PivotFields('Production Start Date');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 1;
          xlPivotField.Position := 1;
          xlPivotField.Subtotals(1, FALSE);

          xlPivotField := xlPivotTable.PivotFields('Product Type');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 2;
          xlPivotField.Position := 1;


          xlPivotField := xlPivotTable.PivotFields('Quantity');
          XLaPP.Visible := TRUE;
          xlPivotField.Orientation := 4;
          xlPivotField.Position := 1;
          xlPivotField."Function" := 0;

          xlPivotField := xlPivotTable.PivotFields('Production Start Date');
          xlPivotField.AutoSort(1, 'Production Start Date');


          xlRange := xlWorkSheet2.Range('AC:AC');
          xlRange.Columns().Hidden := TRUE;

          xlWorkSheet2.Range('AA:AZ').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';

          xlWorkSheet2.Range('Z1').Interior.Color := 255;
          xlWorkSheet2.Range('AA1').Value := 'Days having Production Plan Less than 8 DL Units';
          xlWorkSheet2.Range('Z2').Interior.Color := 15773696;
          xlWorkSheet2.Range('AA2').Value := 'Days having Production Plan Greater than 8 DL Units';

          Sheet_row := 0;
          FOR i := 5 TO 500 DO BEGIN
              IF FORMAT(xlWorkSheet2.Range('Z' + FORMAT(i)).Value) = 'Grand Total' THEN BEGIN
                  Sheet_row := i;
                  i := 500;
              END;
          END;*///B2BUpg
                //commented for Time being B2B
                /*
                FOR i:= 5 TO Sheet_row-1 DO
                BEGIN
                  EVALUATE(cell_value,xlWorkSheet2.Range('AB'+FORMAT(i)).Value);
                  IF cell_value > 8 THEN
                  BEGIN
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.Bold:=TRUE;
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.Color := -1003520;
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.TintAndShade := -0.249977111117893;
                  END
                  ELSE IF cell_value < 8 THEN
                  BEGIN
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.Bold:=TRUE;
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.Color :=-16776961 ;
                    xlWorkSheet2.Range('AA'+FORMAT(i)).Font.TintAndShade := -0.249977111117893;
                  END;
                END;
                *///commented for Time being B2B
                  //Pivot Table 4
        ExcelBuffer.VALIDATE("Column No.", 10 + NoOfColumns);//commented by sujani
                                                             //B2BUpg
                                                             /*xlPivotCache :=
                                                               XLaPP.ActiveWorkbook.PivotCaches.Add(1, STRSUBSTNO('%1!A1:%2%3',
                                                             xlWorkSheet3.Name, ExcelBuffer.xlColID, ROW1));*///B2BUpg


        /* xlPivotCache.CreatePivotTable(xlWorkSheet2.Range('A60:A60'),'PivotTable4');
         xlPivotTable := xlWorkSheet2.PivotTables('PivotTable4');                  anil

         xlPivotField := xlPivotTable.PivotFields('Item No.');
         XLaPP.Visible := TRUE;
         xlPivotField.Orientation := 1;
         xlPivotField.Position := 1;
         xlPivotField.Subtotals(1,FALSE);

         xlPivotField := xlPivotTable.PivotFields('Description');
         XLaPP.Visible := TRUE;
         xlPivotField.Orientation := 1;
         xlPivotField.Position := 2;
         xlPivotField.Subtotals(1,FALSE);

         xlPivotField := xlPivotTable.PivotFields('Lead Time');
         XLaPP.Visible := TRUE;
         xlPivotField.Orientation := 2;
         xlPivotField.Position := 1;
         xlPivotField.Subtotals(1,FALSE);


         xlPivotField := xlPivotTable.PivotFields('Shortage_Value');
         XLaPP.Visible := TRUE;
         xlPivotField.Orientation := 4;
         xlPivotField.Position := 1;
         xlPivotField."Function":=0;
         xlPivotField.Caption:='Shortage Value';

       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+3)).Value:='Shortage';
       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+4)).Value:='Excess_MOQ';
       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+5)).Value:='Authorization Value';

       Formula:= '=AA'+FORMAT(Sheet_row+5)+'-AA'+FORMAT(Sheet_row+3);
       xlWorkSheet2.Range('AA'+FORMAT(Sheet_row+3)).Formula:='=SUM(Shortage_Item_Data!E:E)';
       xlWorkSheet2.Range('AA'+FORMAT(Sheet_row+5)).Formula:='=SUM(Shortage_Item_Data!I:I)';
       xlWorkSheet2.Range('AA'+FORMAT(Sheet_row+4)).Formula:= Formula;

       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+3)+':Z'+ FORMAT(Sheet_row+5)).Font.Bold:=TRUE;
       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+3)+':Z'+ FORMAT(Sheet_row+5)).Font.Color :=-11489280 ;
       xlWorkSheet2.Range('Z'+FORMAT(Sheet_row+3)+':Z'+ FORMAT(Sheet_row+5)).Font.TintAndShade := -0.249977111117893;

          */

        //Pivot table 5
        //B2BUpg
        /*
                xlPivotCache.CreatePivotTable(xlWorkSheet2.Range('R3:R3'), 'PivotTable5');
                xlPivotTable := xlWorkSheet2.PivotTables('PivotTable5');

                xlPivotField := xlPivotTable.PivotFields('Expected Payment Date');
                XLaPP.Visible := TRUE;
                xlPivotField.Orientation := 1;
                xlPivotField.Position := 1;
                xlPivotField.Subtotals(1, FALSE);

                xlPivotField := xlPivotTable.PivotFields('Vendor Name');
                XLaPP.Visible := TRUE;
                xlPivotField.Orientation := 1;
                xlPivotField.Position := 2;


                xlPivotField := xlPivotTable.PivotFields('Total');
                XLaPP.Visible := TRUE;
                xlPivotField.Orientation := 4;
                xlPivotField.Position := 1;
                xlPivotField."Function" := 0;

                xlPivotField := xlPivotTable.PivotFields('Expected Payment Date');
                xlPivotField.AutoSort(1, 'Production Start Date');

                xlWorkSheet2.Range('C1:Q1000').NumberFormat := '_ * #,##0_ ;_ * -#,##0_ ;_ * ""-""??_ ;_ @_ ';
                xlWorkSheet2.Columns.AutoFit;




                xlRange := xlWorkSheet2.Range('AC:AC');
                xlRange.Columns().Hidden := TRUE;*///B2BUpg


        //FName:='\\oldrecep\SHARE\Sundar\Shortage.xlsx';

        FName := '\\erpserver\ErpAttachments\Authorisation Material' + FORMAT(TODAY, 0, '<Day>-<Month Text,3>-<Year4>') + '.xlsx';
        //B2BUpg
        /*xlWorkBook := XLaPP.ActiveWorkbook;
        IF FILE.EXISTS(FName) THEN
            ERASE(FName);
        xlWorkBook._SaveAs(FName);
        //xlWorkBook.Close;
        CLEAR(XLaPP);*///B2BUpg

    end;

    trigger OnPreReport();
    begin
        Row := 1;
        //CREATE(XLaPP, TRUE, TRUE);//B2BUpg
    end;

    var
        From_Date: Date;
        To_Date: Date;
        UOM: Code[100];
        Item: Record 27;
        "Payment Date": Date;
        PLT: Text[100];
        Vendor: Record 23;
        "Expected Payment Date": Date;
        PO: Record 5405 temporary;
        ExpecPayDate: Text[100];
        "Purchase Line": Record 39 temporary;
        Line: Integer;
        Pay_Temp: Decimal;
        Pay_Date: Code[100];
        TOT: Decimal;
        "Prev_Sale Order": Code[20];
        Prev_Prod_Order: Code[20];
        LeadTime_Values: array[6] of Decimal;
        i: Integer;
        Lead_Time_Value: array[10, 5] of Decimal;
        Lead_Time_item: array[10, 2] of Text[50];
        Lead_Unit_Cost: array[9, 2] of Decimal;
        Prev_Product: Code[20];
        Product_Qty: Integer;
        Nullify: Boolean;
        "Required_Bom _Value": Decimal;
        Shortage_Value: Decimal;
        "Purchasing Value": Decimal;
        Prod_Order: Record 5405;
        Shortage_Data: Text[30];
        Purchase_Data: Text[30];
        Total_Required_BOM: Decimal;
        Total_Shoratage_Value: Decimal;
        Total_Purchase_Value: Decimal;
        Total_Shortage_Data: Text[30];
        Total_Purchase_Data: Text[30];
        Lead_Time_Wise_Value: array[9] of Decimal;
        Material_Available: array[4] of Boolean;
        "Products_Material Available": array[4] of Integer;
        Value_Material_Available: array[4] of Decimal;
        Product_MAaterial_Availble_Dat: array[4] of Text[30];
        Leat_Tot_Value: array[4] of Decimal;
        Purchase_Qty: Integer;
        Req_Qty: Integer;
        Unit_Cost: Decimal;
        Item_Wise_Req: Record 60049;
        BOUT_Total_Value: Decimal;
        BOUT_Short_Value: Decimal;
        BOUT_Pur_Value: Decimal;
        Tot_Req_Value: Decimal;
        Tot_Shortage_Value_Dat: Text[30];
        Tot_Pur_Value_Dat: Text[30];
        Brk: Boolean;
        "Inc/Dec": Decimal;
        MOQ_Ref: Decimal;
        MOQ_Ref_Val: Decimal;
        Excess_Val_Plan: Decimal;
        Excess_Val_Other_Str: Decimal;
        Alternate_Item: Record 60045;
        I1: Record 27 temporary;
        I2: Record 27 temporary;
        I3: Record 27 temporary;
        i4: Record 27 temporary;
        Item_Desc: Text[50];
        Excess_Cost: Decimal;
        Excess_Qty: Decimal;
        Moq: Text[50];
        Tot_With_UC: Decimal;
        "Production Start Date": Date;
        "Production Ending Date": Date;
        Status: Code[30];
        Order_Qty: Decimal;
        Order_Value: Decimal;
        Choice: Option Authorisation,"Groups ";
        "Prev_Sales_Order_No.": Code[20];
        PRODUCTS_LIST: array[20, 2] of Code[100];
        PRODUCTS_COUNT: array[20] of Integer;
        PRODUCTS_LEAD_PRICES: array[20, 10] of Decimal;
        TOTAL_LEAD_PRICES: array[20] of Decimal;
        J: Integer;
        Sale_Order_Change: Boolean;
        //SQLConnection: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";//B2BUpg
        //RecordSet: Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";//B2BUpg
        SQLQuery: Text[1000];
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        Prev_Customer_Name: Text[50];
        SALE_ORDER_TOTAL: Decimal;
        Prev_Production_Order: Code[20];
        k: Integer;
        ORDER_TOTAL: Decimal;
        NULL_ORDER_VALUES: array[10] of Decimal;
        NULL_ORDER_TOTAL: Decimal;
        NULL_ORDER_DETAILS: Record 60090;
        PURCH_NOT_HAVING_EXPEC_DT: Decimal;
        Previous_Prod_Order: Code[20];
        PRICES: array[21] of Decimal;
        Row: Integer;
        /*XLaPP: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00024500-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlWorkBook: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlWorkSheet: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020820-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlWorkSheet2: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020820-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlPivotTable: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlPivotCache: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{0002441C-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlPivotCaches: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{0002441D-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlRange: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlPivotField: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020874-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlWorkSheet3: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020820-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";
        xlSheetName: Text[100];
        xlWorkSheet1: Automation "{00020813-0000-0000-C000-000000000046} 1.3:{00020820-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";*///B2BUpg
        FName: Text[100];
        temp: Integer;
        Sheet_row: Integer;
        Formula: Text[100];
        ROW1: Integer;
        ExcelBuffer: Record 370 temporary;
        NoOfColumns: Integer;
        row2: Integer;
        cell_value: Decimal;
        MOQ_Temp: Decimal;
        Sale_Orders_of_Purchases_which_are__NOT_UNDER_CONTROL___NOT_HAVING_SUFFICIENT_LEAD_TIME_CaptionLbl: Label 'SALE ORDER WISE PURCHASES';
        SALE_ORDERCaptionLbl: Label 'SALE ORDER';
        PRODUCT_TYPECaptionLbl: Label 'PRODUCT TYPE';
        CUSTOMERCaptionLbl: Label 'CUSTOMER';
        QUANTTITYCaptionLbl: Label 'QUANTTITY';
        V2_DAYSCaptionLbl: Label '2 DAYS';
        V4_DAYSCaptionLbl: Label '4 DAYS';
        V7_DAYSCaptionLbl: Label '7 DAYS';
        V15_DAYSCaptionLbl: Label '15 DAYS';
        V21_DAYSCaptionLbl: Label '21 DAYS';
        V25_DAYSCaptionLbl: Label '25 DAYS';
        V30_DAYSCaptionLbl: Label '30 DAYS';
        V45_DAYSCaptionLbl: Label '45 DAYS';
        V60_DAYSCaptionLbl: Label '60 DAYS';
        V90_DAYSCaptionLbl: Label '90 DAYS';
        TOTALCaptionLbl: Label 'TOTAL';
        TOTAL_ORDERCaptionLbl: Label 'TOTAL ORDER';
        Items__Dont_have_Sale_Order_ReferenceCaptionLbl: Label 'Items'' Dont have Sale Order Reference';
        Items_ListCaptionLbl: Label 'Items List';
        ItemCaptionLbl: Label 'Item';
        Shortage_QuantityCaptionLbl: Label 'Shortage Quantity';
        UOMCaptionLbl: Label 'UOM';
        Paymnet_Lead_TimeCaptionLbl: Label 'Paymnet Lead Time';
        Expected_Payment_DateCaptionLbl: Label 'Expected Payment Date';
        Total_Cost__Shortage_CaptionLbl: Label 'Total Cost (Shortage)';
        Order_QuantityCaptionLbl: Label 'Order Quantity';
        Total_Cost__Order_CaptionLbl: Label 'Total Cost (Order)';
        Lead_TimeCaptionLbl: Label 'Lead Time';
        V2DCaptionLbl: Label '2D';
        V45_DCaptionLbl: Label '>45 D';
        Minimum_Value_Item_DetailsCaptionLbl: Label 'Minimum Value Item Details';
        V4DCaptionLbl: Label '4D';
        Maximum_Value_Item_DetailsCaptionLbl: Label 'Maximum Value Item Details';
        Total_CostCaptionLbl: Label 'Total Cost';
        QtyCaptionLbl: Label 'Qty';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        ItemCaption_Control1102154043Lbl: Label 'Item';
        Total_CostCaption_Control1102154044Lbl: Label 'Total Cost';
        QtyCaption_Control1102154045Lbl: Label 'Qty';
        Unit_CostCaption_Control1102154046Lbl: Label 'Unit Cost';
        ItemCaption_Control1102154047Lbl: Label 'Item';
        V15DCaptionLbl: Label '15D';
        V7DCaptionLbl: Label '7D';
        V25DCaptionLbl: Label '25D';
        V21DCaptionLbl: Label '21D';
        V45DCaptionLbl: Label '45D';
        V30DCaptionLbl: Label '30D';
        Lead_Time_Wise_Maximium_and_Minimum_Value_Items_ReportCaptionLbl: Label 'Lead Time Wise Maximium and Minimum Value Items Report';
        Summarised_Payment_ReportCaptionLbl: Label 'Summarised Payment Report';
        DateCaptionLbl: Label 'Date(Year-Month-Date)';
        ValueCaptionLbl: Label 'Value';
        Purchases_Don_t_have_Expected_Payment_DatesCaptionLbl: Label 'Purchases Don''t have Expected Payment Dates';
        LotGroupFooter5: Boolean;
        LotGroupFooter6: Boolean;
        LotGroupFooter7: Boolean;
        LotGroupFooter8: Boolean;
        ShortTempFooter5: Boolean;
        "--Rev01": Integer;
        PrevLeadTime2: Code[20];
        PrevGRPLeadTime2: Code[20];
        PrvGRPSalesOrderNo: Code[20];
        PrvGRPCustName: Text[50];
        PrvGRPProductionOrderNo: Code[20];
        PrvGRPProductType: Code[20];
        DStore: Boolean;
        rpo_start_date: Date;
        PrevPDNo: Code[20];
        ItemLotNumbers9: Record 60090;
        "Break": Boolean;

    procedure "Funds Allocation"("Payment Date": Date; Value: Decimal);
    begin

        //  PO.SETRANGE(PO."No.",FORMAT("Payment Date",0,'<Day>-<Month Text,3>-<Year4>'));   anil added for asigning order purpose
        PO.SETRANGE(PO."No.", FORMAT("Payment Date", 0, '<Year4>-<Month,2>-<Day,2>'));
        IF PO.FIND('-') THEN BEGIN
            PO.Quantity += Value;
            PO."Unit Cost" += Order_Value;
            PO.MODIFY;
        END ELSE BEGIN


            PO.INIT;
            Line += 1000;
            PO.Status := PO.Status::Released;
            // PO."No.":=FORMAT("Payment Date",0,'<Day>-<Month Text,3>-<Year4>');
            PO."No." := FORMAT("Payment Date", 0, '<Year4>-<Month,2>-<Day,2>');
            PO.Quantity := Value;
            PO.INSERT;

        END;
    end;

    procedure CommaRemoval(Base: Text[100]) Converted: Text[100];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text[1024];CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pCommand : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{B08400BD-F9D1-4D02-B856-71D5DBA123E9}:'Microsoft ActiveX Data Objects 2.8 Library'._Command";pRecordset : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000556-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Recordset";pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text[1024];var UserID : Text[1024];var Password : Text[1024];var Options : Integer;adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000500-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Error";adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000550-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'._Connection");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";SaveAsUI : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";SyncEventType : Integer);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];IsRefresh : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";IsRefresh : Boolean;Result : Integer);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];Result : Integer);
    //begin
    /*
    */
    //end;

    //event XLaPP(Wb : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020819-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Description : Text[1024];Sheet : Text[1024];Success : Boolean);
    //begin
    /*
    */
    //end;

    //event XLaPP();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet3(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet2(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook();
    //begin
    /*
    */
    //end;

    //event xlWorkBook();
    //begin
    /*
    */
    //end;

    //event xlWorkBook();
    //begin
    /*
    */
    //end;

    //event xlWorkBook(var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(SaveAsUI : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event xlWorkBook();
    //begin
    /*
    */
    //end;

    //event xlWorkBook();
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Wn : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020893-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Sh : Automation ":{00020400-0000-0000-C000-000000000046}:''.IDISPATCH";Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkBook(SyncEventType : Integer);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];IsRefresh : Boolean;var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";IsRefresh : Boolean;Result : Integer);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Map : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{0002447B-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";Url : Text[1024];Result : Integer);
    //begin
    /*
    */
    //end;

    //event xlWorkBook(Description : Text[1024];Sheet : Text[1024];Success : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class";var Cancel : Boolean);
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1();
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020846-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00024431-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;

    //event xlWorkSheet1(Target : Automation "{00020813-0000-0000-C000-000000000046} 1.6:{00020872-0000-0000-C000-000000000046}:Unknown Automation Server.Unknown Class");
    //begin
    /*
    */
    //end;
}

