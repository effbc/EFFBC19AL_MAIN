report 50187 "Shortage Authorisation Report"
{
    // version NAVW17.00,Rev01,Eff02

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
    RDLCLayout = './Shortage Authorisation Report.rdlc';

    Caption = 'Shortage Authorisation Report';

    dataset
    {
        dataitem("Item Lot Numbers2"; "Item Lot Numbers")
        {
            DataItemTableView = SORTING("Sales Order No.", "Product Type", "Production Order No.", Authorisation, "Lead Time2")
                                ORDER(Ascending)
                                WHERE(Authorisation = FILTER(WAP | WFA | Authorised | indent),
                                      Shortage = FILTER(> 0),
                                      "Sales Order No." = FILTER(<> ''));
            column(SALE_ORDER_TOTAL1; SALE_ORDER_TOTAL1)
            {
            }
            column(SALE_ORDER_TOTAL2; SALE_ORDER_TOTAL2)
            {
            }
            column(SALE_ORDER_TOTAL3; SALE_ORDER_TOTAL3)
            {
            }
            column(SALE_ORDER_TOTAL4; SALE_ORDER_TOTAL4)
            {
            }
            column(SALE_ORDER_TOTAL5; SALE_ORDER_TOTAL5)
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
            column(ILN2GrpFShow; ILN2GrpFShow)
            {
            }
            column(ILN2GrpF1Show; ILN2GrpF1Show)
            {
            }
            column(ILN2GrpF2Show; ILN2GrpF2Show)
            {
            }
            column(ILN2GrpF3Show; ILN2GrpF3Show)
            {
            }

            trigger OnAfterGetRecord();
            begin

                /*SQLQuery :='Insert into SHORTAGE_DETAILS (ITEM_NO,PLANNED_DATE,SHORTAGE,PLANNED_PURCHASE_DATE,SUITABLE_VENDOR,UNIT_COST,'+
                           'ITEM_DESCRIPTION,MINIMUM_ORDER_QTY,UOM,VENDOR_NAME,PRODUCTION_ORDER,SALES_ORDER,'+
                           'CUSTOMER_NAME,PRODUCT_TYPE,PRODUCT,DIRECT_UNIT_COST,ITEM_LEAD_TIME,'+
                           'TOTAL ) VALUES ('''+"Item Lot Numbers2"."Item No"+''','''+
                            FORMAT("Item Lot Numbers2"."Planned Date",0,'<Day>-<Month Text,3>-<Year4>')+''','''+
                            CommaRemoval(FORMAT(ROUND("Item Lot Numbers2".Shortage,0.01)))+''','''+
                            FORMAT("Item Lot Numbers2"."Planned Purchase Date",0,'<Day>-<Month Text,3>-<Year4>')+''','''+
                            "Item Lot Numbers2"."Suitable Vendor"+''','''+
                            CommaRemoval(FORMAT(ROUND("Item Lot Numbers2"."Unit Cost",0.01)))+''','''+
                            "Item Lot Numbers2".Description+''','''+
                            CommaRemoval(FORMAT(ROUND("Item Lot Numbers2"."Minimum Order. Qty",0.01)))+''','''+
                            "Item Lot Numbers2"."Unit Of Measure"+''','''+
                            "Item Lot Numbers2"."Vendor Name"+''','''+
                            "Item Lot Numbers2"."Production Order No."+''','''+
                            "Item Lot Numbers2"."Sales Order No."+''','''+
                            "Item Lot Numbers2"."Customer Name"+''','''+
                            "Item Lot Numbers2"."Product Type"+''','''+
                            "Item Lot Numbers2".Product+''','''+
                            CommaRemoval(FORMAT(ROUND("Item Lot Numbers2"."Direct Unit Cost",0.01)))+''','''+
                            COPYSTR(FORMAT("Item Lot Numbers2"."Lead Time2"),1,STRLEN(FORMAT("Item Lot Numbers2"."Lead Time2"))-1)+''','''+
                            CommaRemoval(FORMAT(ROUND("Item Lot Numbers2".Total,0.01)))+''')';
                
                
                SQLConnection.Execute(SQLQuery);
                                                 */

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

                IF PrevLeadtime2 <> "Item Lot Numbers2"."Lead Time2" THEN BEGIN
                    PrevLeadtime2 := "Item Lot Numbers2"."Lead Time2";

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupHeader (3) - OnPreSection()
                    IF "Prev_Sales_Order_No." = '' THEN
                        "Prev_Sales_Order_No." := "Item Lot Numbers2"."Sales Order No.";

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (5) - OnPreSection()
                    IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                        Sale_Order_Change := TRUE;
                        IF (i = 1) THEN BEGIN
                            ILN2GrpFShow := TRUE;
                            //SALE_ORDER_TOTAL:=0; //ADSK
                            SALE_ORDER_TOTAL1 := 0;
                            FOR k := 1 TO 10 DO
                                //SALE_ORDER_TOTAL+=PRODUCTS_LEAD_PRICES[1][k]; //ADSK
                                SALE_ORDER_TOTAL1 += PRODUCTS_LEAD_PRICES[1] [k]; //ADSk
                            ORDER_TOTAL += SALE_ORDER_TOTAL1;
                            prodorder.RESET;
                            prodorder.SETFILTER(prodorder."No.", Prev_Production_Order);
                            IF prodorder.FINDFIRST THEN
                                PRODUCTS_COUNT[i] += prodorder.Quantity - 1;
                        END ELSE
                            ILN2GrpFShow := FALSE;
                    END ELSE BEGIN
                        ILN2GrpFShow := FALSE;

                        IF Prev_Product <> "Item Lot Numbers2"."Product Type" THEN BEGIN
                            Prev_Product := "Item Lot Numbers2"."Product Type";
                            i += 1;
                            PRODUCTS_LIST[i] [1] := "Item Lot Numbers2"."Product Type";
                        END ELSE BEGIN
                            IF Prev_Production_Order <> "Item Lot Numbers2"."Production Order No." THEN BEGIN
                                prodorder.RESET;
                                prodorder.SETFILTER(prodorder."No.", Prev_Production_Order);
                                IF prodorder.FINDFIRST THEN
                                    PRODUCTS_COUNT[i] += prodorder.Quantity;
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
                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (5) - OnPreSection()

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (6) - OnPreSection()
                    IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                        Sale_Order_Change := TRUE;
                        IF i = 2 THEN BEGIN
                            ILN2GrpF1Show := TRUE;
                            //SALE_ORDER_TOTAL:=0; //ADSK
                            SALE_ORDER_TOTAL2 := 0;
                            FOR J := 1 TO 2 DO
                                FOR k := 1 TO 10 DO
                                    //SALE_ORDER_TOTAL+=PRODUCTS_LEAD_PRICES[J][k]; //ADSK
                                    SALE_ORDER_TOTAL2 += PRODUCTS_LEAD_PRICES[J] [k];
                            ORDER_TOTAL += SALE_ORDER_TOTAL2;
                        END ELSE
                            ILN2GrpF1Show := FALSE;
                    END ELSE
                        ILN2GrpF1Show := FALSE;
                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (6) - OnPreSection()

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (7) - OnPreSection()
                    IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                        Sale_Order_Change := TRUE;
                        IF i = 3 THEN BEGIN
                            ILN2GrpF2Show := TRUE;
                            //SALE_ORDER_TOTAL:=0; //ADSK
                            SALE_ORDER_TOTAL3 := 0;
                            FOR J := 1 TO 3 DO
                                FOR k := 1 TO 10 DO
                                    //SALE_ORDER_TOTAL+=PRODUCTS_LEAD_PRICES[J][k]; //ADSK
                                    SALE_ORDER_TOTAL3 += PRODUCTS_LEAD_PRICES[J] [k];
                            ORDER_TOTAL += SALE_ORDER_TOTAL3;
                        END ELSE
                            ILN2GrpF2Show := FALSE;
                    END ELSE
                        ILN2GrpF2Show := FALSE;
                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (7) - OnPreSection()

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (8) - OnPreSection()
                    IF ("Prev_Sales_Order_No." <> "Item Lot Numbers2"."Sales Order No.") THEN BEGIN
                        Sale_Order_Change := TRUE;
                        IF (i > 3) THEN BEGIN
                            //SALE_ORDER_TOTAL:=0; //ADSK
                            SALE_ORDER_TOTAL4 := 0;
                            ILN2GrpF3Show := TRUE;
                            FOR J := 1 TO i DO
                                FOR k := 1 TO 10 DO
                                    //SALE_ORDER_TOTAL+=PRODUCTS_LEAD_PRICES[J][k]; //ADSK
                                    SALE_ORDER_TOTAL4 += PRODUCTS_LEAD_PRICES[J] [k];
                            ORDER_TOTAL += SALE_ORDER_TOTAL4;
                        END ELSE
                            ILN2GrpF3Show := FALSE;
                    END ELSE
                        ILN2GrpF3Show := FALSE;
                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (8) - OnPreSection()

                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (9) - OnPreSection()
                    "Prev_Sales_Order_No." := "Item Lot Numbers2"."Sales Order No.";
                    Prev_Customer_Name := "Item Lot Numbers2"."Customer Name";
                    Prev_Product := "Item Lot Numbers2"."Product Type";
                    Prev_Production_Order := "Item Lot Numbers2"."Production Order No.";
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
                    //Rev01 Code Copied from //Item Lot Numbers2, GroupFooter (9) - OnPreSection()
                END;

            end;

            trigger OnPostDataItem();
            begin
                //Rev01 code copied from //Item Lot Numbers2, Footer (11) - OnPreSection()

                //SALE_ORDER_TOTAL:=0; //ADSK
                SALE_ORDER_TOTAL5 := 0;
                FOR k := 1 TO 10 DO
                    //SALE_ORDER_TOTAL+=PRODUCTS_LEAD_PRICES[1][k]; //ADSK
                    SALE_ORDER_TOTAL5 += PRODUCTS_LEAD_PRICES[1] [k];

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

                //Rev01 code copied from //Item Lot Numbers2, Footer (11) - OnPreSection()



                /*
                SQLConnection.CommitTrans;
                SQLConnection.Close;
                                    */

            end;

            trigger OnPreDataItem();
            begin
                i := 0;
                //CurrReport.BREAK;
                /*
                IF ISCLEAR(SQLConnection) THEN
                  CREATE(SQLConnection);
                IF ISCLEAR(RecordSet) THEN
                  CREATE(RecordSet);
                
                WebRecStatus := Quotes+Text50001+Quotes;
                OldWebStatus := Quotes+Text50002+Quotes;
                
                
                SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                SQLConnection.Open;
                
                SQLQuery:='Delete from SHORTAGE_DETAILS';
                SQLConnection.Execute(SQLQuery);
                SQLConnection.BeginTrans;
                  */
                CurrReport.NEWPAGE;
                FOR i := 1 TO 10 DO
                    TOTAL_LEAD_PRICES[i] := 0;
                i := 1;
                //Rev01
                PrevLeadtime2 := '';
                CLEAR(ILN2GrpFShow);
                CLEAR(ILN2GrpF1Show);
                CLEAR(ILN2GrpF2Show);
                CLEAR(ILN2GrpF3Show);
                //Rev01

            end;
        }
        dataitem("Item Lot Numbers5"; "Item Lot Numbers")
        {
            DataItemTableView = SORTING(Product, "Production Order No.")
                                ORDER(Ascending)
                                WHERE(Authorisation = FILTER(WAP | WFA | Authorised | indent),
                                      Shortage = FILTER(> 0),
                                      "Sales Order No." = FILTER(<> ''));

            trigger OnPreDataItem();
            begin
                //CurrReport.BREAK;
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
            column(ShortageTempVisi; ShortageTempVisi)
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
                //Rev01 code copied from //Shortage Temp, Body (3) - OnPreSection()
                ShortageTempVisi := TRUE;
                PLT := '';
                Order_Qty := 0;
                //Order_Value:=0;
                /*
                IF Item.GET("Shortage Temp"."Item No.") THEN
                BEGIN
                  IF Item."Minimum Order Quantity">0 THEN
                  BEGIN
                    IF Item."Minimum Order Quantity">1 THEN
                    BEGIN
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
                //Rev01 code copied from //Shortage Temp, Body (3) - OnPreSection()


                //Shortage Temp, Footer (5) - OnPreSection()
                // MESSAGE(FORMAT(Tot_With_UC));
                ShortTempFooter5 := TRUE;
                FOR i := 1 TO 9 DO BEGIN
                    ShortTempFooter5 := TRUE;
                    IF (Lead_Time_Value[i] [1] > 0) AND (Lead_Time_Value[i] [2] > 0) THEN
                        Lead_Unit_Cost[i] [1] := Lead_Time_Value[i] [2] / Lead_Time_Value[i] [1];
                    IF (Lead_Time_Value[i] [3] > 0) AND (Lead_Time_Value[i] [4] > 0) THEN
                        Lead_Unit_Cost[i] [2] := Lead_Time_Value[i] [4] / Lead_Time_Value[i] [3];
                END;
                //CurrReport.SHOWOUTPUT:=FALSE;
                ShortTempFooter5 := FALSE;

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
            column(ItemLotNumbersVisi; ItemLotNumbersVisi)
            {
            }
            column(Item_Lot_Numbers_Planned_Purchase_Date; "Planned Purchase Date")
            {
            }
            column(Item_Lot_Numbers_Production_Order_No_; "Production Order No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                ItemLotNumbersVisi := TRUE;
            end;

            trigger OnPreDataItem();
            begin
                //IF Choice=Choice::"Groups " THEN
                CurrReport.BREAK;
            end;
        }
        dataitem(DataItem5444; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(Int_TOT; Int_TOT)
            {
            }
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
            column(IntegerVisi; IntegerVisi)
            {
            }

            trigger OnAfterGetRecord();
            begin

                IF "Break" THEN
                    CurrReport.BREAK;
                //Rev01 Code Copied from //Integer, Body (3) - OnPreSection()
                Pay_Temp := PO.Quantity;
                Pay_Date := PO."No.";
                //TOT+= Pay_Temp; //ADSK
                Int_TOT += Pay_Temp;
                //Rev01 Code Copied from //Integer, Body (3) - OnPreSection()

                //Rev01 Code Copied from //Integer, Body (3) - OnPostSection()
                IF PO.NEXT = 0 THEN
                    "Break" := TRUE;
                //Rev01 Code Copied from //Integer, Body (3) - OnPostSection()

                //Rev01 Code Copied from //Integer, Footer (4) - OnPreSection()
                //TOT+=PURCH_NOT_HAVING_EXPEC_DT;  //ADSK
                Int_TOT += PURCH_NOT_HAVING_EXPEC_DT;
                //Rev01 Code Copied from //Integer, Footer (4) - OnPreSection()
            end;

            trigger OnPreDataItem();
            begin
                //IF Choice=Choice::"Groups " THEN
                // CurrReport.BREAK;
                IntegerVisi := TRUE;
                PO.RESET;
                //TOT := 0; //ADSK
                Int_TOT := 0;
                PO.RESET;
                PO.SETRANGE(PO.Quantity, 1, 1000000000);
                IF PO.FIND('-') THEN BEGIN

                END ELSE
                    CurrReport.BREAK;
                "Break" := FALSE;
                Line := 0;
            end;
        }
        dataitem("Shortage Temp2"; "Shortage Temp")
        {
            DataItemTableView = SORTING("Item No.")
                                ORDER(Ascending)
                                WHERE("Not Needed" = CONST(true));
            column(ShortageTemp2_Choice; Choice)
            {
            }
            column(Shortage_Temp2_Shortage; Shortage)
            {
            }
            column(Shortage_Temp2_Description; Description)
            {
            }
            column(Shortage_Temp2__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(Shortage_Temp2__Shortage_Temp2__Reason; "Shortage Temp2".Reason)
            {
            }
            column(Not_Needed_Items_ReportCaption; Not_Needed_Items_ReportCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(ItemCaption_Control1102154217; ItemCaption_Control1102154217Lbl)
            {
            }
            column(UOMCaption_Control1102154220; UOMCaption_Control1102154220Lbl)
            {
            }
            column(ReasonCaption; ReasonCaptionLbl)
            {
            }
            column(ShotageTemp2Visi; ShotageTemp2Visi)
            {
            }
            column(Shortage_Temp2_Item_No_; "Item No.")
            {
            }

            trigger OnPreDataItem();
            begin
                ShotageTemp2Visi := TRUE;

                IF Choice = Choice::"Groups " THEN
                    CurrReport.BREAK;
                //MESSAGE('%1',Choice);
            end;
        }
        dataitem("Shortage Temp3"; "Shortage Temp")
        {
            DataItemTableView = SORTING("Item No.")
                                ORDER(Ascending)
                                WHERE("Don't Repeat" = CONST(true));
            column(Short_Temp3_Choice; Choice)
            {
            }
            column(Shortage_Temp3_Remarks; Remarks)
            {
            }
            column(Shortage_Temp3__Unit_of_Measure_; "Unit of Measure")
            {
            }
            column(Shortage_Temp3_Shortage; Shortage)
            {
            }
            column(Shortage_Temp3_Description; Description)
            {
            }
            column(Don_t_Repeat_Items_ReportCaption; Don_t_Repeat_Items_ReportCaptionLbl)
            {
            }
            column(QuantityCaption_Control1102154227; QuantityCaption_Control1102154227Lbl)
            {
            }
            column(ItemCaption_Control1102154228; ItemCaption_Control1102154228Lbl)
            {
            }
            column(UOMCaption_Control1102154229; UOMCaption_Control1102154229Lbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(ShotageTemp3Visi; ShotageTemp3Visi)
            {
            }
            column(Shortage_Temp3_Item_No_; "Item No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                ShotageTemp3Visi := TRUE;
            end;

            trigger OnPreDataItem();
            begin
                IF Choice = Choice::"Groups " THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Shortage Temp4"; "Shortage Temp")
        {
            DataItemTableView = SORTING("Item No.");
            column(Short_Temp4_Choice; Choice)
            {
            }
            column(Shortage_Temp4_Description; Description)
            {
            }
            column(Shortage_Temp4__Item_No__; "Item No.")
            {
            }
            column(Item_s_Don_t_Have_Tax_InformationCaption; Item_s_Don_t_Have_Tax_InformationCaptionLbl)
            {
            }
            column(Shortage_Temp4_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Shortage_Temp4__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(ShotageTemp4Visi; ShotageTemp4Visi)
            {
            }

            trigger OnAfterGetRecord();
            begin
                ShotageTemp4Visi := TRUE;

                Item.RESET;
                IF Item.GET("Shortage Temp4"."Item No.") THEN BEGIN
                    IF (FORMAT(Item."Gen. Prod. Posting Group") = '') OR
                       (FORMAT(Item."Tax Group Code") = '') OR
                       //(FORMAT(Item."Excise Prod. Posting Group") = '') OR  //B2BUpg
                       (FORMAT(Item."VAT Prod. Posting Group") = '') THEN BEGIN
                    END ELSE
                        CurrReport.SKIP;
                END;
            end;

            trigger OnPreDataItem();
            begin
                IF Choice <> Choice::"Groups " THEN
                    CurrReport.BREAK;
            end;
        }
        dataitem("Item Lot Numbers3"; "Item Lot Numbers")
        {
            DataItemTableView = SORTING("Sales Order No.", "Product Type", "Production Order No.", Authorisation, "Lead Time2")
                                ORDER(Ascending)
                                WHERE(Authorisation = FILTER('WFA|Authorised|indent'),
                                      Shortage = FILTER(> 0),
                                      "Planned Purchase Date" = FILTER(<> ''),
                                      "Sales Order No." = FILTER(<> ''),
                                      "Vendor Name" = FILTER(<> ''));
            column(ItemLot3GrpFoter4; ItemLot3GrpFoter4)
            {
            }
            column(ItemLot3GrpFoter5; ItemLot3GrpFoter5)
            {
            }
            column(ItemLot3GrpFoter6; ItemLot3GrpFoter6)
            {
            }
            column(ItemLot3GrpFoter7; ItemLot3GrpFoter7)
            {
            }
            column(Prev_Sales_Order_No___Control1102154289; "Prev_Sales_Order_No.")
            {
            }
            column(Prev_Customer_Name_Control1102154571; Prev_Customer_Name)
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154573; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154575; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154577; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154579; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154581; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154583; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154585; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154586; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154588; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154590; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154592; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154594; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154597; SALE_ORDER_TOTAL)
            {
            }
            column(Prev_Customer_Name_Control1102154598; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154600; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154601; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154603; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154606; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154608; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154610; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154612; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154614; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154615; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154617; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154619; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154621; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154623; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_COUNT_2__1_Control1102154625; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_LIST_2__1__Control1102154627; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1__Control1102154630; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2__Control1102154632; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3__Control1102154634; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4__Control1102154636; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5__Control1102154638; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6__Control1102154639; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7__Control1102154641; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8__Control1102154643; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9__Control1102154645; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10__Control1102154647; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154829; SALE_ORDER_TOTAL)
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154831; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154833; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9__Control1102154834; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10__Control1102154836; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154840; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8__Control1102154841; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154844; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7__Control1102154845; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154848; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6__Control1102154849; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154851; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5__Control1102154853; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154855; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4__Control1102154857; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154859; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3__Control1102154861; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154863; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2__Control1102154865; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154867; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1__Control1102154869; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154872; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_LIST_2__1__Control1102154873; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_COUNT_2__1_Control1102154874; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_COUNT_3__1_Control1102154876; PRODUCTS_COUNT[3] + 1)
            {
            }
            column(Prev_Customer_Name_Control1102154879; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154881; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__10__Control1102154883; PRODUCTS_LEAD_PRICES[3] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__9__Control1102154885; PRODUCTS_LEAD_PRICES[3] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__8__Control1102154887; PRODUCTS_LEAD_PRICES[3] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__7__Control1102154889; PRODUCTS_LEAD_PRICES[3] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__6__Control1102154891; PRODUCTS_LEAD_PRICES[3] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__5__Control1102154893; PRODUCTS_LEAD_PRICES[3] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__4__Control1102154895; PRODUCTS_LEAD_PRICES[3] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__3__Control1102154897; PRODUCTS_LEAD_PRICES[3] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__2__Control1102154899; PRODUCTS_LEAD_PRICES[3] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__1__Control1102154901; PRODUCTS_LEAD_PRICES[3] [1])
            {
            }
            column(PRODUCTS_LIST_3__1__Control1102154903; PRODUCTS_LIST[3] [1])
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154905; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154371; SALE_ORDER_TOTAL)
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__10__Control1102154907; PRODUCTS_LEAD_PRICES[1] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__9__Control1102154909; PRODUCTS_LEAD_PRICES[1] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__8__Control1102154911; PRODUCTS_LEAD_PRICES[1] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__7__Control1102154913; PRODUCTS_LEAD_PRICES[1] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__6__Control1102154915; PRODUCTS_LEAD_PRICES[1] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__5__Control1102154917; PRODUCTS_LEAD_PRICES[1] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__4__Control1102154919; PRODUCTS_LEAD_PRICES[1] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__3__Control1102154921; PRODUCTS_LEAD_PRICES[1] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__2__Control1102154923; PRODUCTS_LEAD_PRICES[1] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_1__1__Control1102154925; PRODUCTS_LEAD_PRICES[1] [1])
            {
            }
            column(PRODUCTS_LIST_1__1__Control1102154927; PRODUCTS_LIST[1] [1])
            {
            }
            column(PRODUCTS_COUNT_1__1_Control1102154928; PRODUCTS_COUNT[1] + 1)
            {
            }
            column(Prev_Customer_Name_Control1102154931; Prev_Customer_Name)
            {
            }
            column(Prev_Sales_Order_No___Control1102154933; "Prev_Sales_Order_No.")
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__9__Control1102154934; PRODUCTS_LEAD_PRICES[2] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__10__Control1102154936; PRODUCTS_LEAD_PRICES[2] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__8__Control1102154939; PRODUCTS_LEAD_PRICES[2] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__7__Control1102154941; PRODUCTS_LEAD_PRICES[2] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__6__Control1102154943; PRODUCTS_LEAD_PRICES[2] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__5__Control1102154945; PRODUCTS_LEAD_PRICES[2] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__4__Control1102154947; PRODUCTS_LEAD_PRICES[2] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__3__Control1102154949; PRODUCTS_LEAD_PRICES[2] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__2__Control1102154951; PRODUCTS_LEAD_PRICES[2] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_2__1__Control1102154953; PRODUCTS_LEAD_PRICES[2] [1])
            {
            }
            column(PRODUCTS_LIST_2__1__Control1102154955; PRODUCTS_LIST[2] [1])
            {
            }
            column(PRODUCTS_COUNT_2__1_Control1102154957; PRODUCTS_COUNT[2] + 1)
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__10__Control1102154959; PRODUCTS_LEAD_PRICES[3] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__9__Control1102154961; PRODUCTS_LEAD_PRICES[3] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__8__Control1102154963; PRODUCTS_LEAD_PRICES[3] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__7__Control1102154965; PRODUCTS_LEAD_PRICES[3] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__6__Control1102154967; PRODUCTS_LEAD_PRICES[3] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__5__Control1102154969; PRODUCTS_LEAD_PRICES[3] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__4__Control1102154971; PRODUCTS_LEAD_PRICES[3] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__3__Control1102154973; PRODUCTS_LEAD_PRICES[3] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__2__Control1102154975; PRODUCTS_LEAD_PRICES[3] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_3__1__Control1102154977; PRODUCTS_LEAD_PRICES[3] [1])
            {
            }
            column(PRODUCTS_LIST_3__1__Control1102154979; PRODUCTS_LIST[3] [1])
            {
            }
            column(PRODUCTS_COUNT_3__1_Control1102154981; PRODUCTS_COUNT[3] + 1)
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__10__Control1102154983; PRODUCTS_LEAD_PRICES[4] [10])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__9__Control1102154985; PRODUCTS_LEAD_PRICES[4] [9])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__8__Control1102154987; PRODUCTS_LEAD_PRICES[4] [8])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__7__Control1102154989; PRODUCTS_LEAD_PRICES[4] [7])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__6__Control1102154991; PRODUCTS_LEAD_PRICES[4] [6])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__5__Control1102154993; PRODUCTS_LEAD_PRICES[4] [5])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__4__Control1102154995; PRODUCTS_LEAD_PRICES[4] [4])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__3__Control1102154997; PRODUCTS_LEAD_PRICES[4] [3])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__2__Control1102154999; PRODUCTS_LEAD_PRICES[4] [2])
            {
            }
            column(PRODUCTS_LEAD_PRICES_4__1__Control1102155001; PRODUCTS_LEAD_PRICES[4] [1])
            {
            }
            column(PRODUCTS_LIST_4__1__Control1102155003; PRODUCTS_LIST[4] [1])
            {
            }
            column(PRODUCTS_COUNT_4__1_Control1102155005; PRODUCTS_COUNT[4] + 1)
            {
            }
            column(SALE_ORDER_TOTAL_Control1102154373; SALE_ORDER_TOTAL)
            {
            }
            column(Sale_Orders_of_Purchases_which_are__UNDER_CONTROL___HAVING_SUFFICIENT_LEAD_TIME_Caption; Sale_Orders_of_Purchases_which_are__UNDER_CONTROL___HAVING_SUFFICIENT_LEAD_TIME_CaptionLbl)
            {
            }
            column(CUSTOMERCaption_Control1102154390; CUSTOMERCaption_Control1102154390Lbl)
            {
            }
            column(SALE_ORDERCaption_Control1102154392; SALE_ORDERCaption_Control1102154392Lbl)
            {
            }
            column(TOTALCaption_Control1102155006; TOTALCaption_Control1102155006Lbl)
            {
            }
            column(V90_DAYSCaption_Control1102155008; V90_DAYSCaption_Control1102155008Lbl)
            {
            }
            column(V60_DAYSCaption_Control1102155010; V60_DAYSCaption_Control1102155010Lbl)
            {
            }
            column(V45_DAYSCaption_Control1102155012; V45_DAYSCaption_Control1102155012Lbl)
            {
            }
            column(V30_DAYSCaption_Control1102155014; V30_DAYSCaption_Control1102155014Lbl)
            {
            }
            column(V25_DAYSCaption_Control1102155016; V25_DAYSCaption_Control1102155016Lbl)
            {
            }
            column(V21_DAYSCaption_Control1102155018; V21_DAYSCaption_Control1102155018Lbl)
            {
            }
            column(V15_DAYSCaption_Control1102155020; V15_DAYSCaption_Control1102155020Lbl)
            {
            }
            column(V7_DAYSCaption_Control1102155022; V7_DAYSCaption_Control1102155022Lbl)
            {
            }
            column(V4_DAYSCaption_Control1102155024; V4_DAYSCaption_Control1102155024Lbl)
            {
            }
            column(V2_DAYSCaption_Control1102155026; V2_DAYSCaption_Control1102155026Lbl)
            {
            }
            column(QUANTTITYCaption_Control1102155028; QUANTTITYCaption_Control1102155028Lbl)
            {
            }
            column(PRODUCT_TYPECaption_Control1102155030; PRODUCT_TYPECaption_Control1102155030Lbl)
            {
            }
            column(Item_Lot_Numbers3_Item_No; "Item No")
            {
            }
            column(Item_Lot_Numbers3_Planned_Purchase_Date; "Planned Purchase Date")
            {
            }
            column(Item_Lot_Numbers3_Production_Order_No_; "Production Order No.")
            {
            }
            column(Item_Lot_Numbers3_Sales_Order_No_; "Sales Order No.")
            {
            }
            column(Item_Lot_Numbers3_Lead_Time2; "Lead Time2")
            {
            }

            trigger OnAfterGetRecord();
            begin

                IF "Item Lot Numbers3"."Lead Time2" = '2D' THEN
                    TOTAL_LEAD_PRICES[1] += "Item Lot Numbers3".Total
                ELSE
                    IF "Item Lot Numbers3"."Lead Time2" = '4D' THEN
                        TOTAL_LEAD_PRICES[2] += "Item Lot Numbers3".Total
                    ELSE
                        IF "Item Lot Numbers3"."Lead Time2" = '7D' THEN
                            TOTAL_LEAD_PRICES[3] += "Item Lot Numbers3".Total
                        ELSE
                            IF "Item Lot Numbers3"."Lead Time2" = '15D' THEN
                                TOTAL_LEAD_PRICES[4] += "Item Lot Numbers3".Total
                            ELSE
                                IF "Item Lot Numbers3"."Lead Time2" = '21D' THEN
                                    TOTAL_LEAD_PRICES[5] += "Item Lot Numbers3".Total
                                ELSE
                                    IF "Item Lot Numbers3"."Lead Time2" = '25D' THEN
                                        TOTAL_LEAD_PRICES[6] += "Item Lot Numbers3".Total
                                    ELSE
                                        IF "Item Lot Numbers3"."Lead Time2" = '30D' THEN
                                            TOTAL_LEAD_PRICES[7] += "Item Lot Numbers3".Total
                                        ELSE
                                            IF "Item Lot Numbers3"."Lead Time2" = '45D' THEN
                                                TOTAL_LEAD_PRICES[8] += "Item Lot Numbers3".Total
                                            ELSE
                                                IF "Item Lot Numbers3"."Lead Time2" = '60D' THEN
                                                    TOTAL_LEAD_PRICES[9] += "Item Lot Numbers3".Total
                                                ELSE
                                                    IF "Item Lot Numbers3"."Lead Time2" = '90D' THEN
                                                        TOTAL_LEAD_PRICES[10] += "Item Lot Numbers3".Total;


                //Rev01
                ItemLot3GrpFoter4 := TRUE;

                //Item Lot Numbers3, GroupFooter (4) - OnPreSection()
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers3"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    IF (i = 1) THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        ItemLot3GrpFoter4 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR k := 1 TO 10 DO
                            SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[1] [k];
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ItemLot3GrpFoter4 := FALSE;
                END ELSE BEGIN
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ItemLot3GrpFoter4 := FALSE;
                    IF Prev_Product <> "Item Lot Numbers3"."Product Type" THEN BEGIN
                        Prev_Product := "Item Lot Numbers3"."Product Type";
                        i += 1;
                        PRODUCTS_LIST[i] [1] := "Item Lot Numbers3"."Product Type";
                    END ELSE
                        IF Prev_Production_Order <> "Item Lot Numbers3"."Production Order No." THEN BEGIN
                            PRODUCTS_COUNT[i] += 1;
                            Prev_Production_Order := "Item Lot Numbers3"."Production Order No.";
                        END;

                    CASE "Item Lot Numbers3"."Lead Time2" OF
                        '2D':
                            PRODUCTS_LEAD_PRICES[i] [1] += "Item Lot Numbers3".Total;
                        '4D':
                            PRODUCTS_LEAD_PRICES[i] [2] += "Item Lot Numbers3".Total;
                        '7D':
                            PRODUCTS_LEAD_PRICES[i] [3] += "Item Lot Numbers3".Total;
                        '15D':
                            PRODUCTS_LEAD_PRICES[i] [4] += "Item Lot Numbers3".Total;
                        '21D':
                            PRODUCTS_LEAD_PRICES[i] [5] += "Item Lot Numbers3".Total;
                        '25D':
                            PRODUCTS_LEAD_PRICES[i] [6] += "Item Lot Numbers3".Total;
                        '30D':
                            PRODUCTS_LEAD_PRICES[i] [7] += "Item Lot Numbers3".Total;
                        '45D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers3".Total;
                        '60D':
                            PRODUCTS_LEAD_PRICES[i] [8] += "Item Lot Numbers3".Total;
                        '90D':
                            PRODUCTS_LEAD_PRICES[i] [10] += "Item Lot Numbers3".Total;
                    END;

                END;
                /*
                IF  ("Prev_Sales_Order_No."<>"Item Lot Numbers3"."Sales Order No.")   THEN BEGIN
                  Sale_Order_Change:=TRUE;
                  IF(i=1)THEN
                    CurrReport.SHOWOUTPUT:=TRUE
                  ELSE
                    CurrReport.SHOWOUTPUT:=FALSE;
                END ELSE BEGIN
                  CurrReport.SHOWOUTPUT:=FALSE;
                  IF Prev_Product<>"Item Lot Numbers3".Product THEN BEGIN
                    Prev_Product:="Item Lot Numbers3".Product;
                    i+=1;
                    PRODUCTS_LIST[i][1]:="Item Lot Numbers3".Product;
                    IF Item.GET("Item Lot Numbers3".Product) THEN
                       PRODUCTS_LIST[i][2]:=Item."Item Sub Group Code";
                  END;
                  CASE "Item Lot Numbers3"."Lead Time2" OF
                
                    '2D' :PRODUCTS_LEAD_PRICES[i][1]+="Item Lot Numbers3".Total;
                    '4D' :PRODUCTS_LEAD_PRICES[i][2]+="Item Lot Numbers3".Total;
                    '7D' :PRODUCTS_LEAD_PRICES[i][3]+="Item Lot Numbers3".Total;
                    '15D':PRODUCTS_LEAD_PRICES[i][4]+="Item Lot Numbers3".Total;
                    '21D':PRODUCTS_LEAD_PRICES[i][5]+="Item Lot Numbers3".Total;
                    '25D':PRODUCTS_LEAD_PRICES[i][6]+="Item Lot Numbers3".Total;
                    '30D':PRODUCTS_LEAD_PRICES[i][7]+="Item Lot Numbers3".Total;
                    '45D':PRODUCTS_LEAD_PRICES[i][8]+="Item Lot Numbers3".Total;
                    '60D':PRODUCTS_LEAD_PRICES[i][8]+="Item Lot Numbers3".Total;
                    '90D':PRODUCTS_LEAD_PRICES[i][10]+="Item Lot Numbers3".Total;
                  END;
                
                END;
                */
                //Item Lot Numbers3, GroupFooter (4) - OnPreSection()

                //Item Lot Numbers3, GroupFooter (5) - OnPreSection()
                ItemLot3GrpFoter5 := TRUE;
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers3"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    IF i = 2 THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        ItemLot3GrpFoter5 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR J := 1 TO 2 DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ItemLot3GrpFoter5 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ItemLot3GrpFoter5 := FALSE;
                //Item Lot Numbers3, GroupFooter (5) - OnPreSection()

                //Item Lot Numbers3, GroupFooter (6) - OnPreSection()
                ItemLot3GrpFoter6 := TRUE;
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers3"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    IF i = 3 THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        ItemLot3GrpFoter6 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR J := 1 TO 3 DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ItemLot3GrpFoter6 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ItemLot3GrpFoter6 := FALSE;
                //Item Lot Numbers3, GroupFooter (6) - OnPreSection()


                //Item Lot Numbers3, GroupFooter (7) - OnPreSection()
                ItemLot3GrpFoter7 := TRUE;
                IF ("Prev_Sales_Order_No." <> "Item Lot Numbers3"."Sales Order No.") THEN BEGIN
                    Sale_Order_Change := TRUE;
                    IF (i > 3) THEN BEGIN
                        //CurrReport.SHOWOUTPUT:=TRUE;
                        ItemLot3GrpFoter7 := TRUE;
                        SALE_ORDER_TOTAL := 0;
                        FOR J := 1 TO 4 DO
                            FOR k := 1 TO 10 DO
                                SALE_ORDER_TOTAL += PRODUCTS_LEAD_PRICES[J] [k];
                    END ELSE
                        //CurrReport.SHOWOUTPUT:=FALSE;
                        ItemLot3GrpFoter7 := FALSE;
                END ELSE
                    //CurrReport.SHOWOUTPUT:=FALSE;
                    ItemLot3GrpFoter7 := FALSE;
                //Item Lot Numbers3, GroupFooter (7) - OnPreSection()

            end;

            trigger OnPreDataItem();
            begin
                CurrReport.BREAK;
                "Prev_Sales_Order_No." := '';
                Prev_Product := '';

                FOR i := 1 TO 10 DO BEGIN
                    FOR J := 1 TO 2 DO
                        PRODUCTS_LIST[i] [J] := '';
                    FOR J := 1 TO 10 DO
                        PRODUCTS_LEAD_PRICES[i] [J] := 0;
                END;
                FOR i := 1 TO 10 DO
                    TOTAL_LEAD_PRICES[i] := 0;

                i := 0;

                IF "Item Lot Numbers3".COUNT = 0 THEN
                    ItemLotNumbers3Visi := TRUE;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(general)
                {
                    field(Choice; Choice)
                    {
                        Caption = 'Select An Option';
                        OptionCaption = '"Authorisation,Groups "';
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

    trigger OnPreReport();
    begin
        //  Status:="Shortage Authorisation".Form_Status;
        /*
        // Rev01 >>
        ShotageTemp4Visi := FALSE;
        IF Choice = Choice::"Groups " THEN
           ShotageTemp4Visi := TRUE;
        // Rev01 <<
        */

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
        "Break": Boolean;
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
        PRODUCTS_LIST: array[30, 2] of Code[20];
        PRODUCTS_COUNT: array[30] of Integer;
        PRODUCTS_LEAD_PRICES: array[30, 30] of Decimal;
        TOTAL_LEAD_PRICES: array[30] of Decimal;
        J: Integer;
        Sale_Order_Change: Boolean;
        //SQLConnection : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000514-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Connection";//B2BUpg
        //RecordSet : Automation "{2A75196C-D9EB-4129-B803-931327F72D5C} 2.8:{00000535-0000-0010-8000-00AA006D2EA4}:'Microsoft ActiveX Data Objects 2.8 Library'.Recordset";//B2BUpg
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
        NULL_ORDER_VALUES: array[30] of Decimal;
        NULL_ORDER_TOTAL: Decimal;
        NULL_ORDER_DETAILS: Record 60090;
        PURCH_NOT_HAVING_EXPEC_DT: Decimal;
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
        Not_Needed_Items_ReportCaptionLbl: Label 'Not Needed Items Report';
        QuantityCaptionLbl: Label 'Quantity';
        ItemCaption_Control1102154217Lbl: Label 'Item';
        UOMCaption_Control1102154220Lbl: Label 'UOM';
        ReasonCaptionLbl: Label 'Reason';
        Don_t_Repeat_Items_ReportCaptionLbl: Label 'Don''t Repeat Items Report';
        QuantityCaption_Control1102154227Lbl: Label 'Quantity';
        ItemCaption_Control1102154228Lbl: Label 'Item';
        UOMCaption_Control1102154229Lbl: Label 'UOM';
        RemarksCaptionLbl: Label 'Remarks';
        Item_s_Don_t_Have_Tax_InformationCaptionLbl: Label 'Item''s Don''t Have Tax Information';
        Sale_Orders_of_Purchases_which_are__UNDER_CONTROL___HAVING_SUFFICIENT_LEAD_TIME_CaptionLbl: Label 'Sale Orders of Purchases which are "UNDER CONTROL" (HAVING SUFFICIENT LEAD TIME)';
        CUSTOMERCaption_Control1102154390Lbl: Label 'CUSTOMER';
        SALE_ORDERCaption_Control1102154392Lbl: Label 'SALE ORDER';
        TOTALCaption_Control1102155006Lbl: Label 'TOTAL';
        V90_DAYSCaption_Control1102155008Lbl: Label '90 DAYS';
        V60_DAYSCaption_Control1102155010Lbl: Label '60 DAYS';
        V45_DAYSCaption_Control1102155012Lbl: Label '45 DAYS';
        V30_DAYSCaption_Control1102155014Lbl: Label '30 DAYS';
        V25_DAYSCaption_Control1102155016Lbl: Label '25 DAYS';
        V21_DAYSCaption_Control1102155018Lbl: Label '21 DAYS';
        V15_DAYSCaption_Control1102155020Lbl: Label '15 DAYS';
        V7_DAYSCaption_Control1102155022Lbl: Label '7 DAYS';
        V4_DAYSCaption_Control1102155024Lbl: Label '4 DAYS';
        V2_DAYSCaption_Control1102155026Lbl: Label '2 DAYS';
        QUANTTITYCaption_Control1102155028Lbl: Label 'QUANTTITY';
        PRODUCT_TYPECaption_Control1102155030Lbl: Label 'PRODUCT TYPE';
        "--rev01": Integer;
        prodorder: Record 5405;
        PrevLeadtime2: Code[20];
        ILN2GrpFShow: Boolean;
        ILN2GrpF1Show: Boolean;
        ILN2GrpF2Show: Boolean;
        ILN2GrpF3Show: Boolean;
        ItemLotNumbers3Visi: Boolean;
        ShotageTemp2Visi: Boolean;
        ShotageTemp3Visi: Boolean;
        ShotageTemp4Visi: Boolean;
        ItemLotNumbersVisi: Boolean;
        IntegerVisi: Boolean;
        ShortageTempVisi: Boolean;
        SALE_ORDER_TOTAL1: Decimal;
        SALE_ORDER_TOTAL2: Decimal;
        SALE_ORDER_TOTAL3: Decimal;
        SALE_ORDER_TOTAL4: Decimal;
        SALE_ORDER_TOTAL5: Decimal;
        ShortTempFooter5: Boolean;
        Int_TOT: Decimal;
        ItemLot3GrpFoter4: Boolean;
        ItemLot3GrpFoter5: Boolean;
        ItemLot3GrpFoter6: Boolean;
        ItemLot3GrpFoter7: Boolean;

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
}

