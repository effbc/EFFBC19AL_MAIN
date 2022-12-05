pageextension 70307 " Planned Production Order" extends 99000813
{
    layout
    {
        addbefore(Posting)
        {
            field("Component Date"; "Component Date")
            {
                ApplicationArea = All;

            }
            field("Component Time"; "Component Time")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        addafter("C&opy Prod. Order Document")
        {
            action("Update &Components Date")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //KPK>>
                    IF ("Component Date" = 0D) OR (FORMAT("Component Time") = '') THEN
                        ERROR(Text001);

                    ProdOrderLine.SETRANGE(Status, Rec.Status);
                    ProdOrderLine.SETRANGE("Prod. Order No.", Rec."No.");
                    IF ProdOrderLine.FINDFIRST THEN BEGIN
                        ProdOrderLine.NEXT(1);
                        REPEAT
                            "Component DateTime" := CREATEDATETIME("Component Date", "Component Time");
                            ProdOrderLine.VALIDATE("Starting Date-Time", "Component DateTime");
                            ProdOrderLine.MODIFY;
                        UNTIL ProdOrderLine.NEXT = 0;

                        ProdOrderLine2.SETRANGE(Status, Rec.Status);
                        ProdOrderLine2.SETRANGE("Prod. Order No.", Rec."No.");
                        IF ProdOrderLine2.FINDFIRST THEN BEGIN
                            ProdOrderLine2.NEXT(1);
                            TempDateTime := CREATEDATETIME(ProdOrderLine2."Ending Date", ProdOrderLine2."Ending Time");
                            ProdOrderLine2.NEXT(-1);
                            ProdOrderLine2.VALIDATE("Starting Date-Time", TempDateTime);
                            ProdOrderLine2.MODIFY;
                        END;
                    END;


                    ProdOrderLine3.SETRANGE(Status, Rec.Status);
                    ProdOrderLine3.SETRANGE("Prod. Order No.", Rec."No.");
                    ProdOrderLine3.SETFILTER(Quantity, '>1');
                    IF ProdOrderLine3.FINDSET THEN BEGIN
                        REPEAT
                            ProdOrderRoutingLine.SETRANGE(Status, ProdOrderLine3.Status);
                            ProdOrderRoutingLine.SETRANGE("Prod. Order No.", ProdOrderLine3."Prod. Order No.");
                            ProdOrderRoutingLine.SETRANGE("Routing Reference No.", ProdOrderLine3."Line No.");
                            //ProdOrderRoutingLine.SETFILTER("Input Quantity",'>1');
                            IF ProdOrderRoutingLine.FINDSET THEN BEGIN
                                REPEAT
                                    IF ProdOrderRoutingLine."Run Time" <> 0 THEN
                                        RunTime += ProdOrderRoutingLine."Run Time"
                                    ELSE
                                        IF (ProdOrderRoutingLine."Run Time" = 0) AND (ProdOrderRoutingLine."Setup Time" <> 0) THEN BEGIN
                                            ProdOrderRoutingLine.VALIDATE("Setup Time", ProdOrderRoutingLine."Setup Time" - ((RunTime) *
                                                                                                                            (ProdOrderRoutingLine."Input Quantity" - 1)));

                                            ProdOrderRoutingLine.MODIFY;
                                            RunTime := 0;
                                        END;
                                UNTIL ProdOrderRoutingLine.NEXT = 0;
                            END;
                        UNTIL ProdOrderLine3.NEXT = 0;
                    END;
                    //KPK<<
                END;

            }
        }
    }

    var
        myInt: Integer;
        "Component Date": Date;
        "Component Time": Time;
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderLine2: Record "Prod. Order Line";
        ProdOrderLine3: Record "Prod. Order Line";
        TempDateTime: DateTime;
        "Component DateTime": DateTime;
        Text001: Label 'ENU=Component Date or Component Time should not be blank.';
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderRoutingLine2: Record "Prod. Order Routing Line";
        RunTime: Decimal;
        SetupTime: Decimal;
}