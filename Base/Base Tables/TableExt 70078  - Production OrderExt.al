tableextension 70078 ProductionOrderExt extends "Production Order"
{
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'Production Order No.', ENN = 'Production Order No.';
        }
        field(60001; "Sales Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order | "Blanket Order"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*ProdOrderLine.RESET;
                ProdOrderLine.SETFILTER(ProdOrderLine."Prod. Order No.","No.");
                IF ProdOrderLine.FINDSET THEN
                BEGIN
                  ProdOrderLine.DELETEALL;
                END;
                "Sales Order Line No.":=0;
                "Schedule Line No.":=0;
                "Source No.":='';
                 */

            end;
        }
        field(60002; "Sales Order Line No."; Integer)
        {
            TableRelation = "Sales Line"."Line No." WHERE("Document No." = FIELD("Sales Order No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*ProdOrderLine.RESET;
                ProdOrderLine.SETFILTER(ProdOrderLine."Prod. Order No.","No.");
                IF ProdOrderLine.FINDSET THEN
                BEGIN
                  ProdOrderLine.DELETEALL;
                END;
                "Schedule Line No.":=0;
                "Source No.":='';
                 */


                /*SalesLine.SETRANGE("Document No.","Sales Order No.");
                SalesLine.SETRANGE("Line No.","Sales Order Line No.");
                IF SalesLine.FIND('-') THEN BEGIN
                  "Source Type" := "Source Type" :: Item;
                  VALIDATE("Source No.",SalesLine."No.");
                END;*/
                SalesLine.SetRange("Document No.", "Sales Order No.");
                SalesLine.SetRange("Line No.", "Sales Order Line No.");
                if SalesLine.Find('-') then begin
                    Quantity := SalesLine.Quantity;// ADDED BY SUJANI ON 13-02-2018
                    if "Schedule Line No." = 0 then begin
                        "Source Type" := "Source Type"::Item;
                        Validate("Source No.", SalesLine."No.");
                    end
                    else begin
                        Schedule.Reset;
                        if SalesLine."Document Type" = SalesLine."Document Type"::"Blanket Order" then
                            Schedule.SetFilter(Schedule."Document Type", '%1', Schedule."Document Type"::"Blanket Order") else
                            if SalesLine."Document Type" = SalesLine."Document Type"::Order then
                                Schedule.SetFilter(Schedule."Document Type", '%1', Schedule."Document Type"::Order);

                        Schedule.SetFilter(Schedule."Document No.", "Sales Order No.");
                        Schedule.SetFilter(Schedule."Document Line No.", '%1', "Sales Order Line No.");
                        Schedule.SetFilter(Schedule."Line No.", '%1', "Schedule Line No.");
                        if Schedule.Find('-') then begin
                            "Source Type" := "Source Type"::Item;
                            Validate("Source No.", Schedule."No.");
                        end;
                    end;
                end;

            end;
        }
        field(60005; "Item Sub Group Code"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ItemSubSubGroup: Record "Item Sub Sub Group";
            begin
            end;
        }
        field(60006; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            Description = 'B2B-Modified Added code in Onvalidate Trigger';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ItemSubGroup: Record "Item Sub Group";
            begin
            end;
        }
        field(60007; "Planned Dispatch Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if UserId in ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\ANVESH', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] then begin
                    if Format("Prod Start date") = '' then
                        Error('Please fill production start date');

                    if "Prod Start date" >= "Planned Dispatch Date" then
                        Error('Dispatch date must be less the or equal the start date');
                end;
            end;
        }
        field(60008; Week; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60009; Customer; Text[100])
        {
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("No." = FIELD("Sales Order No.")));
            FieldClass = FlowField;
        }
        field(60010; "Shortage Verified"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60011; "Shortage Items"; Integer)
        {
            CalcFormula = Count("Production Order Shortage Item" WHERE("Production Order" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;

        }
        field(60092; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60100; "Schedule Line No."; Integer)
        {
            TableRelation = Schedule2."Line No." WHERE("Document No." = FIELD("Sales Order No."),
                                                        "Document Line No." = FIELD("Sales Order Line No."),
                                                        "Document Type" = FILTER(Order | "Blanket Order"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                ProdOrderLine.RESET;
                ProdOrderLine.SETFILTER(ProdOrderLine."Prod. Order No.","No.");
                IF ProdOrderLine.FINDSET THEN
                BEGIN
                  ProdOrderLine.DELETEALL;
                END;
                "Source No.":='';
                 */


                SalesLine.SetRange("Document No.", "Sales Order No.");
                SalesLine.SetRange("Line No.", "Sales Order Line No.");
                if SalesLine.Find('-') then begin
                    Quantity := SalesLine.Quantity;// ADDED BY SUJANI ON 13-02-2018
                    if "Schedule Line No." = 0 then begin
                        "Source Type" := "Source Type"::Item;
                        Validate("Source No.", SalesLine."No.");
                    end
                    else begin
                        SalesDocType := Format(SalesLine."Document Type");
                        Schedule.Reset;
                        Schedule.SetFilter(Schedule."Document Type", SalesDocType);
                        Schedule.SetFilter(Schedule."Document No.", "Sales Order No.");
                        Schedule.SetFilter(Schedule."Document Line No.", '%1', "Sales Order Line No.");
                        Schedule.SetFilter(Schedule."Line No.", '%1', "Schedule Line No.");
                        if Schedule.FindFirst then begin
                            // Added by Pranavi on 20-Feb-2016 for not allowing to select default schedule line no.
                            if Schedule."Line No." = Schedule."Document Line No." then begin
                                SLt.Reset;
                                SLt.SetRange(SLt."Document No.", Schedule."Document No.");
                                SLt.SetRange(SLt."Line No.", Schedule."Document Line No.");
                                if SLt.FindFirst then begin
                                    if Schedule."No." = SLt."No." then
                                        Error('You cannot select this schedule line no.!\As it is default Line!');
                                end;
                            end;
                            // End by Pranavi
                            "Source Type" := "Source Type"::Item;
                            Validate("Source No.", Schedule."No.");
                        end;
                    end;
                end;

            end;
        }
        field(60101; "Service Order No."; Code[20])
        {
            Description = 'B2B EFF';
            TableRelation = "Service Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(60102; "Change Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60103; RefreshProdTime; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60104; Refreshdate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60105; StatusTemp; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60106; "Production Order Status"; Option)
        {
            OptionMembers = "Yet to Start","Under Production",Soldering,Integration,"Ready for Inspection","Call Letter Registered","Inspection Completed","Final Testing","Ready for Dispatch","Convertion- Need to close";
            DataClassification = CustomerContent;
        }
        field(60107; "Work.MesurInUnits(ASM)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60108; "Work.MesurInUnits(TST)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60109; "Work.MesurInUnits(SHF)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "Total Unts"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60111; Remarks; Text[100])
        {
            Description = 'added by sujani 29-11-18 to update the sale order  deviation remarks';
            DataClassification = CustomerContent;
        }
        field(60112; Itm_card_No_of_Units; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60113; Itm_Card_ttl_units; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "Sell-to Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchala devi for tracking customer name in RPOs';
        }
        field(60115; "Benchmarks(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchala devi for Item Benchmarks';
        }
        field(60116; "Total Time"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchala devi for Item Benchmarks';
        }

        field(60117; "Soldering Time(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchala devi for Item Benchmarks';
        }



        field(90080; "User Id"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90081; "Prod Start date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if UpperCase(UserId) <> '06PD012' then begin

                    if "Planned Dispatch Date" <> 0D then
                        if "Prod Start date" >= "Planned Dispatch Date" then
                            Error('Dispatch date is lessthe or equal the start date');
                    "Shortage Verified" := false;

                    //TESTFIELD("Product Group Code");
                    TestField("Sales Order No.");
                    //IF ("Prod Start date">0D) AND ("Prod Start date">=Product_Wise_Issues.PLAN_DATE) THEN
                    begin

                        if "Product Group Code" = 'FPRODUCT' then begin
                            Material_Issues_Header.Reset;
                            Material_Issues_Header.SetCurrentKey("Prod. Order No.", "Prod. Order Line No.");
                            Material_Issues_Header.SetRange("Prod. Order No.", "No.");
                            if Material_Issues_Header.FindFirst then
                                Error('Converted Production Order (Final Product) will not allow to plan');
                            Posted_Material_Issues_Header.SetCurrentKey("Prod. Order No.", "Prod. Order Line No.");
                            Posted_Material_Issues_Header.SetRange("Prod. Order No.", "No.");
                            if Posted_Material_Issues_Header.FindFirst then
                                Error('Converted Production Order (Final Product) will not allow to plan');
                        end;
                        /* IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                           MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                         ELSE IF (Planned_Units("Prod Start date")>14) THEN
                           ERROR('YOU ARE EXCEEDING THE 14 UNITS PLAN ON '+FORMAT("Prod Start date"));*///day wise production coutrol removed by anil

                        "Suppose to Plan" := false;
                        "Virtual Production Start Date" := "Prod Start date";
                    end;

                    /*  IF (Planned_Units("Prod Start date")>14) AND (Planned_Units("Prod Start date")<12) THEN
                        MESSAGE('YOU ARE EXCEEDING THE 14 UNITS PLAN ON '+FORMAT("Prod Start date"))
                      ELSE IF (Planned_Units("Prod Start date")>16) THEN
                        ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));*/
                end;

                //added for material requisition date updation
                "Prod. Order Component".Reset;
                ITEM.Reset;
                if UserId in ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\ANVESH', 'EFFTRONICS\GRAVI', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\DURGAMAHESWARI'] then begin
                    if ITEM.Get("Source No.") then
                        ITEM.TestField(ITEM."No.of Units");
                    if "Prod Start date" >= 0D then begin

                        /*
                         IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                           MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                         ELSE IF (Planned_Units("Prod Start date")>16) THEN
                           ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));
                        */
                        //   MESSAGE('HI');
                        /*IF "Prod Start date" <> CalMngmt.CalcDateBOC('+0D',"Prod Start date",3,'PROD','',3,'PROD','',FALSE) THEN  //pranavi for not allowng to select non working day on 26-10-2015
                          ERROR('You Can not select start date as '+FORMAT("Prod Start date")+' is non working day!');*/// COMMENTED FOR fINANCIAL YEAR PRODUCTION PURPOSE ON 10-02-2018
                        "Prod. Order Component".SetRange("Prod. Order Component"."Prod. Order No.", "No.");
                        if "Prod. Order Component".FindSet then begin
                            repeat
                                //    MESSAGE('HI1');
                                "Prod. Order Component"."Production Plan Date" := "Prod Start date";
                                if "Prod. Order Component"."Material Required Day" = 0 then
                                    "Prod. Order Component"."Material Requisition Date" := 0D
                                else
                                    if "Prod. Order Component"."Material Required Day" = 1 then
                                        "Prod. Order Component"."Material Requisition Date" := "Prod. Order Component"."Production Plan Date"
                                    else begin
                                        //"Prod. Order Component"."Material Requisition Date" := CALCDATE(FORMAT("Prod. Order Component"."Material Required Day" - 1) +'D',"Prod. Order Component"."Production Plan Date");
                                        // "Prod. Order Component"."Material Requisition Date" := CalMngmt.CalcDateBOC('+'+FORMAT("Prod. Order Component"."Material Required Day" - 1) + 'D', "Prod. Order Component"."Production Plan Date", 3, 'PROD', '', 3, 'PROD', '', false);  //pranavi)
                                        //EFFUPG>>
                                        CustomCalendarChange[1].SetSource(CustomCalendarChange[1]."Source Type"::"Location", 'PROD', '', '');//EFFUPG
                                        CustomCalendarChange[2].SetSource(CustomCalendarChange[2]."Source Type"::"Location", 'PROD', '', '');//EFFUPG

                                        "Prod. Order Component"."Material Requisition Date" := CalMngmt.CalcDateBOC('+' + FORMAT("Prod. Order Component"."Material Required Day" - 1) + 'D',
                                        "Prod. Order Component"."Production Plan Date", CustomCalendarChange, FALSE);
                                        //pranavi)
                                        //EFFUPG<<

                                    end;

                                "Prod. Order Component".Modify;
                            until "Prod. Order Component".Next = 0;
                        end else
                            Error('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                    end
                    //coded by anil
                    else begin
                        //     MESSAGE('HI');
                        "Prod. Order Component".SetRange("Prod. Order Component"."Prod. Order No.", "No.");
                        if "Prod. Order Component".FindSet then
                            repeat
                                "Prod. Order Component"."Production Plan Date" := "Prod Start date";
                                "Prod. Order Component"."Material Requisition Date" := 0D;
                                "Prod. Order Component".Modify;
                            until "Prod. Order Component".Next = 0;
                    end;

                end
                else
                    Error('You Dont have rights to perform this operation');

            end;
        }
        field(90082; "Plan Shifting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(90083; "Change To Specified Plan Date"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(90085; "No. Of Shortage Items"; Integer)
        {
            CalcFormula = Count("Item Lot Numbers" WHERE("Production Order No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(90086; "Virtual Production Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(90087; "Suppose to Plan"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                  GL.GET;
                  IF GL."Production_ Shortage_Status"= GL."Production_ Shortage_Status"::Applied THEN
                     ERROR('YOU ALLREADY ASKED PERMISSION TO MANAGEMENT. CHANGES ALLOWED ONLY AFTER APPROVAL');
                
                  IF GL."Production_ Shortage_Status"= GL."Production_ Shortage_Status"::Accepted THEN
                     ERROR('PERMISSION WAS AUTHORIZED BY MANAGEMENT. AFTER AUTO POSTINGS ONLY MODIFICATIONS WILL BE ALLOWED');
                */

            end;
        }
        field(90088; "Authorization Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(90089; "RDSO No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        // This Field created for alternative of AlternatePCB_BOM boolean variable in Create Prod. Order Lines codeunit. 
        field(90120; AlternatePCB_BOM; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key9; "Prod Start date")
        {

        }
        key(Key10; "Sales Order No.", "Item Sub Group Code")
        {
            Enabled = false;
        }
        key(Key11; "No.")
        {

        }
        /* key(Key12; "Sales Order No.", "Source No.", "Prod Start date")
        {

        }
        key(Key13; Week, "Sales Order No.", "Source No.")
        {

        }
        key(Key14; Status, "Prod Start date", "No.")
        {

        } */
    }


    trigger OnBeforeModify()
    begin
        if UpperCase(UserId) <> '06PD012' then;
    end;

    var
        GL: Record "General Ledger Setup";
        CalMngmt: Codeunit "Calendar Management";
        SalesDocType: Text;
        SLt: Record "Sales Line";
        ReservGRec: Record "Reservation Entry";
        Items: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderQty: Decimal;
        Text091: Label 'Number of Production Orders against Sales Order Exceeded';
        "--SH1.0--": Integer;
        Schedule: Record Schedule2;

        "Prod. Order Component": Record "Prod. Order Component";
        Product_Wise_Issues: Page Areas;
        Material_Issues_Header: Record "Material Issues Header";
        Posted_Material_Issues_Header: Record "Posted Material Issues Header";
        SALES_HEADER: Record "Sales Header";
        ITEM_LEAD_TIME: Integer;
        ITEM: Record Item;
        ITEM_LEAD_TEMP: Text[30];
        CustomCalendarChange: Array[2] of Record "Customized Calendar Change";//EFFUPG


    PROCEDURE Planned_Units(Prod_Date: Date) "Units Planned": Decimal;
    VAR
        Prod_Order: Record "Production Order";
        Item: Record Item;
    BEGIN
        Prod_Order.SetCurrentKey(Prod_Order."Prod Start date");
        Prod_Order.SetRange(Prod_Order."Prod Start date", Prod_Date);
        if Prod_Order.Find('-') then
            repeat
                Item.Reset;
                if Item.Get(Prod_Order."Source No.") then
                    "Units Planned" += Prod_Order.Quantity * Item."No.of Units";

            until Prod_Order.Next = 0;
        exit("Units Planned");
    END;
}

