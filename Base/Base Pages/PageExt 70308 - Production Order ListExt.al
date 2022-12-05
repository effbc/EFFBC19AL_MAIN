pageextension 70308 MyExtension extends "Production Order List"
{

    layout
    {
        addafter(Description)
        {
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;

            }


            field("Prod Start date"; Rec."Prod Start date")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                    "Prod. Order Component": Record "Prod. Order Component";

                    item: Record Item;
                begin
                    IF item.GET(Rec."Source No.") THEN
                        item.TESTFIELD(item."No.of Units");

                    IF Rec."Prod Start date" > 0D THEN BEGIN
                        /* { IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                            MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                          ELSE IF (Planned_Units("Prod Start date")>16) THEN
                            ERROR('YOU ARE EXCEEDING THE 16 UNITS PLAN ON '+FORMAT("Prod Start date"));}*/

                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.", Rec."No.");
                        IF "Prod. Order Component".FINDSET THEN BEGIN
                            "Prod. Order Component".MODIFYALL("Prod. Order Component"."Production Plan Date", Rec."Prod Start date")
                        END ELSE
                            ERROR('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                    END ELSE BEGIN
                        "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.", Rec."No.");
                        IF "Prod. Order Component".FINDSET THEN BEGIN
                            "Prod. Order Component".MODIFYALL("Prod. Order Component"."Production Plan Date", Rec."Prod Start date")
                        END;
                    END;





                    /* {IF item.GET("Source No.") THEN
                       item.TESTFIELD(item."No.of Units");

                     IF "Prod Start date">0D THEN
                     BEGIN

                       IF (Planned_Units("Prod Start date")>10) AND (Planned_Units("Prod Start date")<12) THEN
                         MESSAGE('YOU ARE EXCEEDING THE 10 UNITS PLAN ON '+FORMAT("Prod Start date"))
                       ELSE IF (Planned_Units("Prod Start date")>14) THEN
                         ERROR('YOU ARE EXCEEDING THE 14 UNITS PLAN ON '+FORMAT("Prod Start date"));

                     "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.","No.");
                     IF "Prod. Order Component".FINDSET THEN
                     BEGIN
                     REPEAT
                      { IF "Prod Start date">0D THEN
                       BEGIN
                         IF "Prod. Order Component"."Material Required Day"<>99 THEN
                         BEGIN}
                           "Prod. Order Component"."Production Plan Date":="Prod Start date";
                           "Prod. Order Component".MODIFY;
                        { END;
                       END ELSE
                       BEGIN
                         "Prod. Order Component"."Production Plan Date":=0D;
                         "Prod. Order Component".MODIFY;
                       END; 
                     UNTIL "Prod. Order Component".NEXT=0;
                     END ELSE
                     ERROR('PLEASE REFRESH THE PRODUCTION ORDER PROPERLY');
                     END;
                     }*/
                END;

                // ImplicitType=Date;

                //end;
            }
            field("Planned Dispatch Date"; Rec."Planned Dispatch Date")
            {
                ApplicationArea = All;

            }


            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;

            }



        }

    }

    actions
    {
        addafter(Statistics)
        {
            action("Change the Plan")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.RESET;
                    Rec.SETRANGE("Change To Specified Plan Date", TRUE);
                    IF Rec.FINDSET THEN
                        REPEAT
                            Rec."Planned Dispatch Date" := Rec."Plan Shifting Date" + (Rec."Planned Dispatch Date" - Rec."Prod Start date");
                            Rec."Prod Start date" := Rec."Plan Shifting Date";
                            "Prod. Order Component".RESET;
                            "Prod. Order Component".SETRANGE("Prod. Order Component"."Prod. Order No.", Rec."No.");
                            IF "Prod. Order Component".FINDSET THEN
                                REPEAT
                                    IF "Prod. Order Component"."Material Required Day" <> 99 THEN BEGIN
                                        "Prod. Order Component"."Production Plan Date" := Rec."Plan Shifting Date";
                                        "Prod. Order Component".MODIFY;
                                    END ELSE BEGIN
                                        "Prod. Order Component"."Production Plan Date" := Rec."Planned Dispatch Date";
                                        "Prod. Order Component".MODIFY;
                                    END;
                                UNTIL "Prod. Order Component".NEXT = 0;
                            Rec."Change To Specified Plan Date" := FALSE;
                            Rec.MODIFY;
                        UNTIL Rec.NEXT = 0;
                    MESSAGE('Production Plan Changes are Changed');
                    "G/L".GET;
                    Rec.RESET;
                    Rec.SETCURRENTKEY("Prod Start date");
                    Rec.SETFILTER("Prod Start date", '>%1', "G/L"."Shortage. Calc. Date");
                    Rec.SETFILTER("Plan Shifting Date", '>%1', 0D);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //{CLEAR(Rec);}
        // SETFILTER("Production Order Status",'%1..%2|%3',1,6,8);
        //  SETFILTER("Production Order Status",'<>%1',"Production Order Status"::Completed);
        //SETFILTER(Status,'Released');
        //Rec.SETFILTER("Location Code",'PROD');
        IF UPPERCASE(USERID) IN ['EFFTRONICS\PADMAJA', 'SUPER', 'EFFTRONICS\VSNGEETHA', '10RD01'] THEN//(UPPERCASE(USERID)='06PD012')
        BEGIN
            CurrPage.EDITABLE := TRUE;
            Rec.SETFILTER("Location Code", 'PROD');
            //SETFILTER("Production Order Status",'%1..%2|%3',2,7,9);
            IF UPPERCASE(USERID) IN ['EFFTRONICS\PADMAJA', '10RD01', 'EFFTRONICS\SUJANI'] THEN
                Rec.SETFILTER("Creation Date", '>=%1', DMY2DATE(4, 4, 2013));
            // SETFILTER("Production Order Status",'<>%1',"Production Order Status"::Dispatched);
        END ELSE
            CurrPage.EDITABLE := FALSE
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        NoC2OnFormat;
    end;

    var
        "Prod. Order Component": Record "Prod. Order Component";
        Shortage_Details: Record "Item Lot Numbers";
        "G/L": Record "General Ledger Setup";
        item: Record Item;
        Prod_Order: Record "Production Order";
        PMIH: Record "Posted Material Issues Header";
        "No.Emphasize": Boolean;
    //"No.Emphasize": Boolean INDATASET;

    PROCEDURE Planned_Unitscust(Prod_Date: Date) "Units Planned": Decimal;
    BEGIN
        Prod_Order.SETCURRENTKEY(Prod_Order."Prod Start date");
        Prod_Order.SETRANGE(Prod_Order."Prod Start date", Prod_Date);
        IF Prod_Order.FINDSET THEN
            REPEAT
                item.RESET;
                IF item.GET(Prod_Order."Source No.") THEN
                    "Units Planned" += Prod_Order.Quantity * item."No.of Units";

            UNTIL Prod_Order.NEXT = 0;
        EXIT("Units Planned");
    END;

    LOCAL PROCEDURE NoC2OnFormat();
    BEGIN
        PMIH.RESET;
        PMIH.SETFILTER(PMIH."Prod. Order No.", Rec."No.");
        IF NOT PMIH.FINDFIRST THEN BEGIN
            "No.Emphasize" := TRUE;
        END ELSE
            "No.Emphasize" := FALSE;
    END;
}