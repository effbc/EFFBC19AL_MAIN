codeunit 60026 "Plan Change"
{

    trigger OnRun();
    begin
        "G|L".GET;
        "Prod. Order".RESET;
        "Prod. Order".SETCURRENTKEY("Prod. Order".Week, "Prod. Order"."Sales Order No.", "Prod. Order"."Source No.");
        "Prod. Order".SETFILTER("Prod. Order".Week, '>%1', 0);
        IF "Prod. Order".FINDSET THEN
            REPEAT
                "Prod. Order".Week := 0;
                "Prod. Order".MODIFY;
            UNTIL "Prod. Order".NEXT = 0;
        "Prod. Order".RESET;
        "Prod. Order".SETCURRENTKEY("Prod. Order"."Prod Start date");
        //"Prod. Order".SETRANGE("Prod. Order"."No.",'DRV09DLR01');
        "Prod. Order".SETFILTER("Prod. Order"."Prod Start date", '>%1', ("G|L"."Shortage. Calc. Date" + 1));
        "Prod. Order".SETFILTER("Prod. Order"."Sales Order No.", '<>%1', '');
        IF "Prod. Order".FINDSET THEN
            REPEAT
                IF ("Prod. Order"."Prod Start date" - ("G|L"."Shortage. Calc. Date" + 1)) < 7 THEN
                    "Prod. Order".Week := 0
                ELSE
                    "Prod. Order".Week := ("Prod. Order"."Prod Start date" - ("G|L"."Shortage. Calc. Date" + 1)) DIV 7;

                "Prod. Order".MODIFY;

            UNTIL "Prod. Order".NEXT = 0;
    end;

    var
        "G|L": Record "General Ledger Setup";
        "Planned Purchase Date": Date;
        Buffer: Text[30];
        Total_Buffer: Text[30];
        Dum_Purch_Line: Record "Purchase Line";
        Possible_Procured_Date: Date;
        "Prod. Order": Record "Production Order";
        "Item Wise Req": Record "Item wise Requirement";
        "Item Wise Req2": Record "Item wise Requirement";
        Dum_Sal_Order: Code[20];
        Dum_Product: Code[20];
        Dum_Week: Integer;
        window: Dialog;
        t1: Label 'Changin from #1######### to #2###########  for #3##############';
        reqqty: Decimal;
        itemlotnums: Record "Item Lot Numbers";
        temprec: Record "Item Lot Numbers";


    procedure Sales_Plan_Change(Sale_Order: Code[30]; Line_No: Integer);
    var
        Sales_Line: Record "Sales Line";
    begin

        Sales_Line.RESET;
        Sales_Line.SETRANGE(Sales_Line."Document No.", Sale_Order);
        Sales_Line.SETRANGE(Sales_Line."Line No.", Line_No);
        Sales_Line.SETFILTER("Plan Shifting Date", '>%1', 0D);
        Sales_Line.SETRANGE("Change to Specified Plan Date", TRUE);
        IF Sales_Line.FINDFIRST THEN BEGIN
            Sales_Line."Material Reuired Date" := Sales_Line."Plan Shifting Date";
            Sales_Line."Change to Specified Plan Date" := FALSE;
            Sales_Line.MODIFY;
        END;
    end;


    procedure "Schedule_Plan Change"(Sale_Order: Code[30]; Sales_Line: Integer; Schedule_line: Integer);
    var
        schedule: Record Schedule2;
    begin
        schedule.RESET;
        schedule.SETRANGE(schedule."Document No.", Sale_Order);
        schedule.SETRANGE(schedule."Document Line No.", Sales_Line);
        schedule.SETRANGE(schedule."Line No.", Schedule_line);
        schedule.SETRANGE(schedule."Change To Specified Plan Date", TRUE);
        IF schedule.FINDSET THEN
            REPEAT
                schedule."Material Required Date" := schedule."Plan Shifting Date";
                schedule."Change To Specified Plan Date" := FALSE;
                schedule.MODIFY;

            UNTIL schedule.NEXT = 0;
    end;


    procedure Change_Alternate_Items(Actual_Item: Code[20]; Alternate_Item: Code[20]);
    var
        Shortage_Det2: Record "Item Lot Numbers";
        Item: Record Item;
        Shortage_Det1: Record "Item Lot Numbers";
        Shortage_Det3: Record "Item Lot Numbers";
    begin

        Buffer := '7D';
        "Item Wise Req2".RESET;
        "Item Wise Req2".SETRANGE("Item Wise Req2"."Item No.", Actual_Item);
        IF "Item Wise Req2".FINDFIRST THEN BEGIN
            // reqqty:="Item Wise Req2"."Required Quantity";
            "Item Wise Req".RESET;
            "Item Wise Req".SETRANGE("Item Wise Req"."Item No.", Alternate_Item);
            IF "Item Wise Req".FINDFIRST THEN BEGIN
                "Item Wise Req"."Required Quantity" += "Item Wise Req2"."Required Quantity";
                "Item Wise Req"."Req Qty" += "Item Wise Req2"."Req Qty";
                //   "Item Wise Req"."Required Quantity"+="Item Wise Req2"."Required Quantity";
                "Item Wise Req".MODIFY;
            END ELSE BEGIN
                "Item Wise Req".INIT;
                "Item Wise Req"."Item No." := Alternate_Item;
                "Item Wise Req".Description := "Item Wise Req2".Description;
                //  "Item Wise Req"."Required Quantity":="Item Wise Req"."Required Quantity";
                "Item Wise Req"."Required Quantity" := "Item Wise Req2"."Required Quantity";
                "Item Wise Req"."Req Qty" := "Item Wise Req2"."Req Qty";
                "Item Wise Req".INSERT;
            END;
        END;
        window.OPEN(t1);

        Shortage_Det2.RESET;
        Shortage_Det2.SETCURRENTKEY(Shortage_Det2."Item No", Shortage_Det2."Planned Date");
        Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Actual_Item);
        IF Shortage_Det2.FINDSET THEN
            REPEAT
                window.UPDATE(1, Actual_Item);
                window.UPDATE(2, Alternate_Item);
                window.UPDATE(3, Shortage_Det2."Production Order No.");
                Item.RESET;
                IF Item.GET(Alternate_Item) THEN BEGIN
                    Total_Buffer := '-' + FORMAT(Item."Safety Lead Time");
                    IF Shortage_Det2."Planned Date" > 0D THEN
                        "Planned Purchase Date" := CALCDATE(Total_Buffer, Shortage_Det2."Planned Date");
                    Shortage_Det1."Planned Purchase Dare (WOB)" := "Planned Purchase Date";
                    Total_Buffer := '-' + FORMAT(Buffer);
                    IF "Planned Purchase Date" > 0D THEN
                        "Planned Purchase Date" := CALCDATE(Total_Buffer, "Planned Purchase Date");

                    Shortage_Det3.RESET;
                    Shortage_Det3.SETRANGE(Shortage_Det3."Item No", Item."No.");
                    Shortage_Det3.SETRANGE(Shortage_Det3."Production Order No.", Shortage_Det2."Production Order No.");
                    Shortage_Det3.SETRANGE(Shortage_Det3."Sales Order No.", Shortage_Det2."Sales Order No.");
                    Shortage_Det3.SETRANGE(Shortage_Det3."Planned Purchase Date", Shortage_Det2."Planned Purchase Date");
                    IF Shortage_Det3.FINDFIRST THEN BEGIN
                        Shortage_Det3.Shortage += Shortage_Det2.Shortage;
                        Shortage_Det3.MODIFY;
                    END ELSE BEGIN
                        Shortage_Det1.VALIDATE(Shortage_Det1."Item No", Item."No.");
                        Shortage_Det1."Item No" := Item."No.";
                        Shortage_Det1.Description := Item.Description;
                        Shortage_Det1."Unit Of Measure" := Item."Base Unit of Measure";
                        Shortage_Det1."Lead Time" := Item."Safety Lead Time";
                        IF "Planned Purchase Date" >= WORKDATE THEN
                            Shortage_Det1."Planned Purchase Date" := "Planned Purchase Date"
                        ELSE BEGIN
                            Shortage_Det1."Planned Purchase Date" := 0D;
                            Shortage_Det1."Planned Purchase Dare (WOB)" := 0D;
                            Dum_Purch_Line.RESET;
                            Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.", Item."No.");
                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive", '>%1', 0);
                            Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date", '>%1', Shortage_Det2."Planned Date");
                            IF NOT (Dum_Purch_Line.FINDFIRST) THEN BEGIN
                                Total_Buffer := FORMAT(Item."Safety Lead Time");
                                Possible_Procured_Date := CALCDATE(Total_Buffer, WORKDATE);
                                Total_Buffer := FORMAT(Buffer);
                                Possible_Procured_Date := CALCDATE(Total_Buffer, Possible_Procured_Date);

                                Shortage_Det1."Possible Procured Date" := Possible_Procured_Date;
                                Shortage_Det1."Possible Production Plan Date" := Possible_Procured_Date + 4;


                            END ELSE BEGIN

                            END;
                        END;
                        //anil strat
                        /*
                         Dum_Purch_Line.RESET;
                         Dum_Purch_Line.SETRANGE(Dum_Purch_Line."No.",Item."No.");
                         Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Qty. to Receive",'>%1',0);
                         Dum_Purch_Line.SETFILTER(Dum_Purch_Line."Deviated Receipt Date",'>%1',Shortage_Det2."Planned Date");
                         IF Dum_Purch_Line.FINDSET THEN
                         BEGIN
                         REPEAT
                         IF (Dum_Purch_Line."Qty. to Receive">"Prod. Order Component"."Expected Quantity"-("Qty. In Issues & Req"+
                                                                                       Alternate_Buffer)) AND (NOT AVB) THEN
                         BEGIN
                           Dum_Purch_Line."Qty. to Receive"-="Prod. Order Component"."Expected Quantity"-("Qty. In Issues & Req"+
                                                                                                                 Alternate_Buffer);
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
                           END;
                           IF Possible_Procured_Date>0D THEN
                           BEGIN
                             Possible_Plan_Changed_Date:=Possible_Procured_Date;

                           END;

                       end;
                       */
                        //anil end

                        Shortage_Det1."Production Order No." := Shortage_Det2."Production Order No.";
                        Shortage_Det1."Sales Order No." := Shortage_Det2."Sales Order No.";
                        Shortage_Det1."Planned Date" := Shortage_Det2."Planned Date";
                        Shortage_Det1.Shortage := Shortage_Det2.Shortage;
                        Shortage_Det1."Suitable Vendor" := Shortage_Det2."Suitable Vendor";
                        Shortage_Det1."Unit Cost" := Item."Avg Unit Cost";

                        Shortage_Det1.Authorisation := Shortage_Det2.Authorisation;
                        Shortage_Det1."Minimum Order. Qty" := Item."Minimum Order Quantity";
                        Shortage_Det1."Vendor Name" := Shortage_Det2."Vendor Name";
                        Shortage_Det1."Indent No." := Shortage_Det2."Indent No.";
                        Shortage_Det1."Customer Name" := Shortage_Det2."Customer Name";
                        Shortage_Det1."Product Type" := Shortage_Det2."Product Type";
                        Shortage_Det1.Product := Shortage_Det2.Product;
                        Shortage_Det1."Direct Unit Cost" := Shortage_Det2."Direct Unit Cost";
                        Shortage_Det1."Material Required Date" := Shortage_Det2."Material Required Date";
                        Shortage_Det1."Material Required Day" := Shortage_Det2."Material Required Day";
                        Shortage_Det1."Lead Time" := Item."Safety Lead Time";
                        Shortage_Det1."Alternated Item" := Shortage_Det2."Item No";

                        Shortage_Det1.INSERT;
                    END;
                END;
                Shortage_Det2.DELETE;
            UNTIL Shortage_Det2.NEXT = 0;
        window.CLOSE;

    end;


    procedure Change_Shortage_Date();
    begin
        "G|L".GET;
        "G|L"."Shortage. Calc. Date" := WORKDATE;
        "G|L".MODIFY;
    end;

    procedure Shortage(Week: Integer; Sale_Order: Code[20]; Product: Code[20]);
    var
        Shortage_Details: Record "Item Lot Numbers";
        SMAD: Record "Shortage Management Audit Data";
        Shortage_Temp: Record "Shortage Temp";
        Start_Date: Date;
        Final_Date: Date;
        "Production Order": Record "Production Order";
        "g\l": Record "General Ledger Setup";
    begin
        "G|L".GET;
        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.");
        "Production Order".SETRANGE("Production Order".Week, Week);
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("g\l"."Shortage. Calc. Date"));
        "Production Order".SETRANGE("Production Order"."Sales Order No.", Sale_Order);
        "Production Order".SETRANGE("Production Order"."Source No.", Product);
        IF "Production Order".FINDFIRST THEN
            Start_Date := "Production Order"."Prod Start date";

        "Production Order".RESET;
        "Production Order".SETCURRENTKEY("Production Order".Week, "Production Order"."Sales Order No.", "Production Order"."Source No.");
        "Production Order".SETRANGE("Production Order".Week, Week);
        "Production Order".SETFILTER("Production Order"."Prod Start date", '>%1', ("g\l"."Shortage. Calc. Date"));
        "Production Order".SETRANGE("Production Order"."Sales Order No.", Sale_Order);
        "Production Order".SETRANGE("Production Order"."Source No.", Product);
        IF "Production Order".FINDLAST THEN
            Final_Date := "Production Order"."Prod Start date";

        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");
        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '2D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."2 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;

        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '4D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."4 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '7D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."7 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '15D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."15 Dyas_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '21D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."21 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;

        SMAD."21 Days" := FORMAT(Shortage_Temp.COUNT);

        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '25D');
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."25 Dyas_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '30D');
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN
                SMAD."30 Dyas_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '45D');
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN
                SMAD."45 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '60D');
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);
        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN
                SMAD."60 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;



        Shortage_Details.RESET;
        Shortage_Details.SETCURRENTKEY(Shortage_Details."Sales Order No.",
                                       Shortage_Details.Product,
                                       Shortage_Details.Authorisation,
                                       Shortage_Details."Lead Time2",
                                       Shortage_Details."Item No",
                                       Shortage_Details."Planned Date");

        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.", Sale_Order);
        Shortage_Details.SETRANGE(Shortage_Details.Product, Product);
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        Shortage_Details.SETFILTER(Shortage_Details."Lead Time2", '90D');
        Shortage_Details.SETRANGE(Shortage_Details."Planned Date", Start_Date, Final_Date);
        REPORT.RUN(16387, FALSE, TRUE, Shortage_Details);

        IF Shortage_Temp.COUNT > 0 THEN BEGIN
            SMAD.RESET;
            SMAD.SETRANGE(SMAD.Sale_Order, Sale_Order);
            SMAD.SETRANGE(SMAD.Product, Product);
            SMAD.SETRANGE(SMAD.Week, Week);
            IF SMAD.FINDFIRST THEN BEGIN

                SMAD."90 Days_S" := FORMAT(Shortage_Temp.COUNT);
                SMAD.MODIFY;
            END;
        END;
    end;


    procedure Item_Plan_Change(Shortage_Det: Record "Item Lot Numbers");
    var
        Shortage_Det2: Record "Item Lot Numbers";
        Shortage_Det3: Record "Item Lot Numbers";
    begin
        Shortage_Det2.RESET;
        Shortage_Det2.SETRANGE(Shortage_Det2."Item No", Shortage_Det."Item No");
        Shortage_Det2.SETRANGE(Shortage_Det2."Planned Purchase Date", Shortage_Det."Planned Purchase Date");
        Shortage_Det2.SETRANGE(Shortage_Det2."Production Order No.", Shortage_Det."Production Order No.");
        Shortage_Det2.SETRANGE(Shortage_Det2."Sales Order No.", Shortage_Det."Sales Order No.");
        IF Shortage_Det2.FINDFIRST THEN BEGIN
            Shortage_Det3.COPY(Shortage_Det2);
            Shortage_Det2.DELETE;
            Shortage_Det3."Planned Purchase Date" := TODAY;
            Shortage_Det3.INSERT;
        END;
    end;


    procedure Update_Sale_Order_Info();
    var
        Shortage_Details: Record "Item Lot Numbers";
        Production_Order: Record "Production Order";
        Shortage_Details2: Record "Item Lot Numbers";
    begin
        /*
        Shortage_Details.SETRANGE(Shortage_Details."Sales Order No.",'');
        IF Shortage_Details.FINDSET THEN
        REPEAT
          Production_Order.RESET;
          Production_Order.SETRANGE(Production_Order."No.",Shortage_Details."Production Order No.");
          IF Production_Order.FINDFIRST THEN
          BEGIN
            Shortage_Details2.RESET;
            Shortage_Details2.SETCURRENTKEY("Item No","Planned Date");
            Shortage_Details2.SETRANGE("Item No",Shortage_Details."Item No");
             Shortage_Details2.SETRANGE("Planned Purchase Date",Shortage_Details."Planned Purchase Date");
            Shortage_Details2.SETRANGE("Production Order No.",Production_Order."No.");
            IF Shortage_Details2.FINDSET THEN
            REPEAT
              Shortage_Details2."Sales Order No.":=Production_Order."Sales Order No.";
              Shortage_Details2.MODIFY;
            UNTIL Shortage_Details2.NEXT=0;
          END;
        UNTIL Shortage_Details.NEXT=0;
         */

    end;


    procedure FillSaleOrdrNum_ItmLotNums();
    begin
        //added by pranavi to fill the empty sales order numbers in item lot numbers on 06-01-2015
        itemlotnums.RESET;
        itemlotnums.SETFILTER(itemlotnums."Sales Order No.", '%1', '');   //get empty sales order number records
        IF itemlotnums.FIND('-') THEN
            REPEAT
                temprec.RESET;                  //copy record to temp record
                temprec.INIT;
                temprec.TRANSFERFIELDS(itemlotnums);
                temprec."Sales Order No." := 'STR INTERNAL';
                temprec.INSERT;                     //insert temp record
                itemlotnums.DELETE;                 //delete old empty sale.order number record
            UNTIL itemlotnums.NEXT = 0;             //repeat for all empty sale order no. records
        //end pranavi
    end;
}

