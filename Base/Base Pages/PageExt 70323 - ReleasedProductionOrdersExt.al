pageextension 70323 ReleasedProductionOrdersExt extends "Released Production Orders"
{
    // version NAVW19.00.00.45778,Rev01

    layout
    {


        addbefore(Control1)
        {

            group(Filters)
            {
                Caption = '';
                field(PlnndDisptchDate; PlnndDisptchDate)
                {
                    Caption = 'Planned Dispatch Date';
                }
                field(FILTEREDUNITSSUMS; FILTEREDUNITSSUMS)
                {
                    Caption = 'Filtered Units';
                }
                field("Sum of Total units"; "Sum of Total units")
                {
                    Caption = 'Total Units';
                }
                field("Total Benchmarks"; "Total Benchmarks")
                {
                    Caption = 'Total Time';
                }
                field(FilteredPOs; FilteredPOs)
                {
                    Caption = 'Filtered Time';
                }
                field("Total Soldering Time";"Total Soldering Time")
                {
                    ApplicationArea = All;
                    Caption = 'Total Soldering Time';
                }
                field("Filtered Soldering Time";"Filtered Soldering Time")
                {
                    ApplicationArea = All;
                    Caption = 'Filtered Soldering Time';
                }
                field("Soldering Time(in Min)";"Soldering Time(in Min)")
                {
                    ApplicationArea = All;
                }

            }
            

        }
        //Unsupported feature: Change Editable on "Control 1". Please convert manually.

        modify("No.")
        {

            //Unsupported feature: Change Editable on "Control 2". Please convert manually.

            Style = StrongAccent;
            StyleExpr = "No.Emphasize";
        }
        modify(Description)
        {

            //Unsupported feature: Change Editable on "Control 4". Please convert manually.

            Style = Ambiguous;
            StyleExpr = refreshbool;
        }
        modify("Source No.")
        {

            //Unsupported feature: Change Editable on "Control 6". Please convert manually.

            Style = Unfavorable;
            StyleExpr = BackDateBool;
        }

        modify("Routing No.")
        {
            Visible = false;
            Editable = false;
        }
        modify("Quantity")
        {

            Editable = false;
        }

        modify("Shortcut Dimension 1 Code")
        {

            Editable = false;
        }


        modify("Shortcut Dimension 2 Code")
        {

            Editable = false;
        }
        modify("Location Code")
        {

            Editable = false;
        }

        modify(Status)
        {

            Editable = false;
        }












        addafter(Status)
        {

            field(ProdStartDat; ProdStartDat)
            {
                Caption = 'Prod Start Date';
                Visible = Visibl;

                trigger OnValidate();
                begin

                    /*IF NOT FilterChanged THEN
                      BEGIN
                        Variable1 := SumofUnits(xRec);
                      END
                    ELSE
                      BEGIN
                        //Rec.SETRANGE("Prod Start date","Prod Start date","Prod Start date");
                         Rec.SETRANGE("Prod Start date",GETRANGEMIN(Rec."Prod Start date"),GETRANGEMAX(Rec."Prod Start date"));
                        Variable1 := SumofUnits(xRec);
                      END;
                     CurrPage.UPDATE;
                     */

                end;
            }
            field(SupToPlan; SupToPlan)
            {
                Caption = 'Suppose To Plan';
                Visible = Visibl;
            }
        }

        addafter(Quantity)
        {
            field("Benchmarks(in Min)"; "Benchmarks(in Min)")
            {
                Caption = 'Benchmarks(in Hrs)';
            }
            field("<Total Benchmarks>"; "Total Time")
            {
                Caption = 'Total Benchmarks';
            }
        }
        addafter("Search Description")
        {
            field("Sales Order No."; "Sales Order No.")
            {
                Editable = false;
            }
            field("Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Editable = false;
            }
            field("Sales Order Line No."; "Sales Order Line No.")
            {
                Editable = false;
            }
            field("Schedule Line No."; "Schedule Line No.")
            {
                Editable = false;
            }
        }

        addafter("Bin Code")
        {
            field("Prod Start date"; "Prod Start date")
            {
                Editable = true;

                trigger OnValidate();
                begin
                    /*
                    MESSAGE('hi');
                    IF USERID IN ['EFFTRONICS\PADMAJA','EFFTRONICS\PRANAVI','EFFTRONICS\ANILKUMAR'] THEN
                    BEGIN
                    MESSAGE('hi');
                      IF Item.GET("Source No.") THEN
                        Item.TESTFIELD(Item."No.of Units");
                      IF "Prod Start date">=0D THEN
                      BEGIN
                    
                       {
                        IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                          MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                        ELSE IF (Planned_Units("Prod Start date")>16) THEN
                          ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));
                       }
                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.","No.");
                        IF "Prod. Order Component".FINDSET THEN
                        BEGIN
                        REPEAT
                          "Prod. Order Component"."Production Plan Date":="Prod Start date";
                          "Prod. Order Component".MODIFY;
                        UNTIL "Prod. Order Component".NEXT=0;
                        END ELSE
                        ERROR('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                      END
                        //coded by anil
                      ELSE
                      BEGIN
                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.","No.");
                        IF "Prod. Order Component".FINDSET THEN
                        REPEAT
                          "Prod. Order Component"."Production Plan Date":="Prod Start date";
                          "Prod. Order Component".MODIFY;
                        UNTIL "Prod. Order Component".NEXT=0;
                      END;
                    
                    END
                    ELSE
                      ERROR('You Dont have rights to perform this operation');
                    */
                end;
            }


            field("Suppose to Plan"; "Suppose to Plan")
            {
                Editable = false;
            }
            field("Planned Dispatch Date"; "Planned Dispatch Date")
            {
                Editable = false;
            }
            field(Remarks; Remarks)
            {
            }
            field("Product Group Code"; "Product Group Code")
            {
                Editable = false;
            }
            field("Item Sub Group Code"; "Item Sub Group Code")
            {
                Editable = false;
            }
            field("Production Order Status"; "Production Order Status")
            {
            }
            field(Itm_card_No_of_Units; Itm_card_No_of_Units)
            {
                Editable = false;
            }
            field(Itm_Card_ttl_units; Itm_Card_ttl_units)
            {
                Editable = false;
            }
            field(Blocked; Blocked)
            {
            }
            field("Shortage Verified"; "Shortage Verified")
            {
            }
        }


        addafter(Control1)
        {
            group(Test)
            {
                Editable = false;
                Caption = '';
                grid(Test2)
                {
                    Caption = '';
                    group(Test3)
                    {
                        Caption = '';
                        field(xRec_Count; xRec.Count)
                        {
                            Editable = false;
                            Caption = '';
                        }
                    }
                    group(Test4)
                    {
                        Caption = '';
                        field(Color_No_Issues; Color_No_Issues)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                    group(Test5)
                    {
                        Caption = '';
                        field(Color_Refresh; Color_Refresh)
                        {
                            Editable = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                    group(Test6)
                    {
                        Caption = '';
                        field(Color_BachDate; Color_BachDate)
                        {
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            Caption = '';
                        }
                    }
                }
            }
        }

    }
    actions
    {
        addfirst("F&unctions")
        {
            action("Move Production Start Date")
            {
                Image = CalendarWorkcenter;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction();
                begin
                    // REPORT.RUN(10720);
                end;
            }
            action(SupposeToPLan)
            {
                Caption = 'Suppose To PLan';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    //Added by Pranavi ON 27-Nov-2015 for auto suppose to plan
                    PO.RESET;
                    PO.COPYFILTERS(Rec);
                    /*IF ProdStartDat <> '' THEN
                      PO.SETFILTER(PO."Prod Start date",ProdStartDat);*/
                    IF PO.FINDSET THEN
                        REPEAT
                            PMIH.RESET;
                            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                            IF NOT PMIH.FINDFIRST THEN BEGIN
                                IF PO."Prod Start date" <> 0D THEN BEGIN
                                    PO."Suppose to Plan" := SupToPlan;
                                    PO.VALIDATE("Suppose to Plan");
                                    PO.MODIFY;
                                END
                                ELSE
                                    ERROR('Please select Prod. start date for' + PO."No.");
                            END;
                        UNTIL PO.NEXT = 0;
                    //END by Pranavi ON 27-Nov-2015

                end;
            }
            action(GiveProdStartDate)
            {
                Caption = 'Asign Prod Start Date';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    //Added by Pranavi ON 27-Nov-2015 for auto PROD. Start Date
                    IF ProdStartDat = 0D THEN
                        ERROR('Please enter Planned Dispatch Date!');
                    TEMPDATE := ProdStartDat;
                    PO.RESET;
                    PO.COPYFILTERS(Rec);
                    IF PO.FINDSET THEN
                        REPEAT
                            PMIH.RESET;
                            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                            IF NOT PMIH.FINDFIRST THEN BEGIN
                                PO."Prod Start date" := TEMPDATE;
                                PO.VALIDATE("Prod Start date");
                                PO.MODIFY;
                            END;
                        UNTIL PO.NEXT = 0;
                    //END by Pranavi ON 27-Nov-2015
                end;
            }
            action(AsignPlnndDisptchDate)
            {
                Caption = 'Asign Planned Dispatch Date';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    //Added by Pranavi ON 27-Nov-2015 for auto PROD. Start Date
                    IF PlnndDisptchDate = 0D THEN
                        ERROR('Please enter Planned Dispatch Date!');
                    PO.RESET;
                    PO.COPYFILTERS(Rec);
                    IF PO.FINDSET THEN
                        REPEAT
                            PMIH.RESET;
                            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            PMIH.SETFILTER(PMIH."Prod. Order No.", PO."No.");
                            IF NOT PMIH.FINDFIRST THEN BEGIN
                                PO."Planned Dispatch Date" := PlnndDisptchDate;
                                PO.VALIDATE("Planned Dispatch Date");
                                PO.MODIFY;
                            END;
                        UNTIL PO.NEXT = 0;
                    //END by Pranavi ON 27-Nov-2015
                end;
            }
            action(FilterNoIssuesRPOs)
            {

                trigger OnAction();
                begin
                    RESET;
                    RPO.RESET;
                    RPO.SETRANGE(RPO.Status, RPO.Status::Released);
                    IF RPO.FINDSET THEN
                        REPEAT
                            PMIH.RESET;
                            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                            PMIH.SETFILTER(PMIH."Prod. Order No.", RPO."No.");
                            IF NOT PMIH.FINDFIRST THEN BEGIN
                                SETRANGE("No.", RPO."No.");
                                IF FINDFIRST THEN
                                    MARK(TRUE);
                            END;
                        UNTIL RPO.NEXT = 0;

                    SETRANGE("No.");
                    MARKEDONLY(TRUE);
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var

        "No.Emphasize": Boolean;
        PMIH: Record 50003;
        Form_Editable: Boolean;
        Item: Record 27;
        "Prod. Order Component": Record 5407;
        Color_No_Issues: Label 'No Material Issues';
        Color_OutPut: Label 'Output Posted';
        Color_Refresh: Label 'Not Refreshed';
        refreshcount: Integer;
        refreshbool: Boolean;
        TEMPDATE: Date;
        ProdStartDat: Date;
        SupToPlan: Boolean;
        PO: Record 5405;
        Visibl: Boolean;
        BackDateBool: Boolean;
        Color_BachDate: Label 'Prod Start Date < Today';
        PlnndDisptchDate: Date;
        RPO: Record 5405;
        No_of_Units: Decimal;
        Total_Units: Decimal;
        LastRecFilter: Text;
        Variable1: Decimal;
        "Sum of Total units": Decimal;
        Variable2: Decimal;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Datetypevariable1: Date;
        FILTEREDUNITSSUMS: Decimal;
        RPO1: Record 5405;
        ItmTable: Record 27;
        Item1: Record 27;
        "Total Benchmarks": Decimal;
        FilteredPOs: Decimal;
        "Total Soldering Time": Decimal;
        "Filtered Soldering Time": Decimal;




    trigger OnAfterGetRecord();
    begin

        NoC2OnFormat;

        // added by vishnu on 06-05-2019
        //"Sum of Total units" += Itm_Card_ttl_units;

        /*CALCSUMS(Itm_Card_ttl_units);
        "Sum of Total units" := Itm_Card_ttl_units;*/

        RPO.RESET;
        RPO.COPYFILTERS(Rec);
        RPO.CALCSUMS(Itm_Card_ttl_units);
        RPO.CALCSUMS("Total Time");
        FILTEREDUNITSSUMS := 0;
        FILTEREDUNITSSUMS += RPO.Itm_Card_ttl_units;
        FilteredPOs := 0;
        FilteredPOs += RPO."Total Time";
        "Filtered Soldering Time" := 0;
        "Filtered Soldering Time" += RPO."Soldering Time(in Min)";




        /*
        Day := 0;
        Month := 0;
        Year := 0;
        IF (NOT FilterChanged)   THEN  // when no filters  applied
          BEGIN
            Variable1 := SumofUnits(xRec);
          END
          ELSE IF GETFILTER("Prod Start date" )=''  THEN  // when prod start date is blank
           BEGIN
            Variable1 := SumofUnits(xRec);
          END
          ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '>' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) = '=' ) THEN  // when the filter is like  >=
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),3,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),6,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),9,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'>=%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '>' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) <> '=' ) THEN  // when the filter is like  >
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),2,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),5,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),8,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'>%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '<' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) = '=' ) THEN  // when the filter is like  <=
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),3,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),6,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),9,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'<=%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),1,1) = '<' ) AND (COPYSTR(GETFILTER("Prod Start date"),2,1) <> '=' ) THEN  // when the filter is like  <
            BEGIN
              EVALUATE(Day,COPYSTR(GETFILTER("Prod Start date"),2,2));
              EVALUATE(Month,COPYSTR(GETFILTER("Prod Start date"),5,2));
              EVALUATE(Year,COPYSTR(GETFILTER("Prod Start date"),8,2));
              Year := Year + 2000;
              Datetypevariable1 := DMY2DATE(Day,Month,Year);
              Rec.SETFILTER("Prod Start date",'<%1',Datetypevariable1);
              Variable1 := SumofUnits(xRec);
            END
            ELSE IF (COPYSTR(GETFILTER("Prod Start date"),9,2) = '..' ) THEN
              BEGIN
                Rec.SETRANGE("Prod Start date",GETRANGEMIN(Rec."Prod Start date"),GETRANGEMAX(Rec."Prod Start date")); // when the filter is like  between
                Variable1 := SumofUnits(xRec);
              END
            ELSE
            BEGIN
              Rec.SETFILTER("Prod Start date",'%1',Rec."Prod Start date");
              Variable1 := SumofUnits(xRec);
            END;
          // end by vishnu on 06-05-2019



        */
    end;



    trigger OnDeleteRecord(): Boolean;
    begin
        // added by Vishnu Priya on 
        IF SearchinPostedMaterial("No.") THEN
            ERROR('You Can not delete this RPO Because, Material Requests are alredy existed on thsi RPO');

    end;








    trigger OnOpenPage();
    begin

        "Sum of Total units" := 0;  // Nav 2016 Oninit trigger code moved to onopen page
        "Total Benchmarks" := 0;// Nav 2016 Oninit trigger code moved to onopen page
        "Total Soldering Time" := 0;                      //CurrPage.EDITABLE := FALSE;

        IF CurrPage.EDITABLE = TRUE THEN
            Visibl := TRUE
        ELSE
            Visibl := FALSE;


        // added by vishnu on 06-05-2019
        /*Variable1 := SumofUnits(xRec);
        IF NOT FilterChanged THEN
          BEGIN
            Variable1 := SumofUnits(xRec);
          END
        ELSE
          BEGIN
            Rec.SETRANGE("Prod Start date","Prod Start date","Prod Start date");
            Variable1 := SumofUnits(xRec);
          END;
        */
        // end by vishnu on 06-05-2019

        //Added by Vishnu Priya
        RPO1.RESET;
        RPO1.SETCURRENTKEY("Prod Start date");
        RPO1.SETFILTER("Prod Start date", '>=%1', TODAY);
        RPO1.SETFILTER(Itm_card_No_of_Units, '%1', 0);
        RPO1.SETFILTER("Benchmarks(in Min)", '%1', 0);

        IF RPO1.FINDSET THEN
            REPEAT
            BEGIN
                ItmTable.RESET;
                ItmTable.SETFILTER("No.", RPO1."Source No.");
                IF ItmTable.FINDFIRST THEN BEGIN
                    RPO1.Itm_card_No_of_Units := ItmTable."No.of Units";
                    RPO1.Itm_Card_ttl_units := ItmTable."No.of Units" * RPO1.Quantity;
                    RPO1."Benchmarks(in Min)" := ItmTable."Benchmarks(in Min)";
                    RPO1."Total Time" := ItmTable."Benchmarks(in Min)" * RPO1.Quantity;
                    RPO1.MODIFY;
                    MESSAGE(ItmTable.Description);
                END
            END
            UNTIL RPO1.NEXT = 0;

        //Added by Vishnu Priya




        RPO.RESET;
        RPO.COPYFILTERS(Rec);
        RPO.CALCSUMS(Itm_Card_ttl_units);
        RPO.CALCSUMS("Total Time");
        RPO.CALCSUMS("Soldering Time(in Min)");
        "Sum of Total units" += RPO.Itm_Card_ttl_units;
        "Total Benchmarks" += RPO."Total Time";
        "Total Soldering Time" += RPO."Soldering Time(in Min)";

        // "Filtered Soldering Time" := 0;
        //"Filtered Soldering Time" += RPO."Soldering Time(in Min)";
        /*Item1.RESET;
        Item1.SETFILTER("No.","Source No.");
        IF Item1.FINDFIRST THEN
          Rec."Benchmarks(in Min)" := Item1."Benchmarks(in Min)";
          Rec.MODIFY;*/
    END;









    local procedure NoC2OnFormat();
    begin
        // Added by Anil on 21-Feb-15
        refreshbool := FALSE;
        BackDateBool := FALSE;
        PMIH.RESET;
        PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        PMIH.SETFILTER(PMIH."Prod. Order No.", "No.");
        IF NOT PMIH.FINDFIRST THEN BEGIN
            "No.Emphasize" := TRUE;
            IF Refreshdate = 0D THEN
                refreshbool := TRUE
            ELSE
                refreshbool := FALSE;
            IF ("Prod Start date" < TODAY()) AND ("Prod Start date" <> 0D) THEN
                BackDateBool := TRUE
            ELSE
                BackDateBool := FALSE;
        END
        ELSE
            "No.Emphasize" := FALSE;
        // end

        /*
        BEGIN
           "No.Emphasize" :=TRUE;
        END ELSE
           "No.Emphasize" := FALSE;
        anil */

    end;

    local procedure SumofUnits("RPOS Page": Record 5405) Units: Decimal;
    var
        Units_per: Decimal;
        "Ttl Units": Decimal;
        "Sum of Units": Decimal;
        "Production Order1": Record 5405;
    begin
        Units := 0;
        "RPOS Page".RESET;
        "RPOS Page".SETCURRENTKEY(Status, "Prod Start date", "No.");
        "RPOS Page".SETFILTER(Status, FORMAT(3));
        "RPOS Page".COPYFILTERS(Rec);
        IF "RPOS Page".FINDSET THEN BEGIN
            "RPOS Page".CALCSUMS(Itm_Card_ttl_units);
            Units := Itm_Card_ttl_units;
        END;
        /*
        //
        //Units+= Total_Units;

        REPEAT

          Units := Itm_Card_ttl_units + Units;
          {Item.RESET;
          Item.SETFILTER("No.","RPOS Page"."Source No.");
          IF Item.FINDFIRST THEN
          BEGIN
             Units_per := Item."No.of Units";
             "Ttl Units" := "RPOS Page".Quantity * Units_per;
             Units := Units + "Ttl Units"; }
          END
        UNTIL "RPOS Page".NEXT = 0;
      END;*/
        //

    end;

    procedure FilterChanged(): Boolean;
    begin
        IF LastRecFilter <> GETFILTERS THEN BEGIN
            LastRecFilter := GETFILTERS;
            EXIT(TRUE);
        END ELSE
            EXIT(FALSE);
    end;

    local procedure SearchinPostedMaterial(RPO: Text) exis: Boolean;
    var
        MIH: Record 50001;
        PMIH: Record 50003;
    begin
        MIH.RESET;
        MIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
        MIH.SETFILTER("Prod. Order No.", RPO);
        IF MIH.FINDFIRST THEN
            exis := TRUE
        ELSE BEGIN
            PMIH.RESET;
            PMIH.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
            PMIH.SETFILTER("Prod. Order No.", RPO);
            IF PMIH.FINDFIRST THEN
                exis := TRUE
            ELSE
                exis := FALSE;
        END;
    end;



}

