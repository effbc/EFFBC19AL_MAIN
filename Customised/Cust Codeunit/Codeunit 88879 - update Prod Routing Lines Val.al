codeunit 88879 "update Prod Routing Lines Val"
{

    trigger OnRun();
    begin
        /*
        ProdRoutingLineGRec.RESET;
        //ProdRoutingLineGRec.SETCURRENTKEY(Type,"No.","Starting Date");
        ProdRoutingLineGRec.SETFILTER("No.",'=%1','');
        IF ProdRoutingLineGRec.FINDSET THEN
          REPEAT
            IF ProdRoutingLineGRec."Work Center No." <> '' THEN BEGIN
              ProdRoutingLineGRec."No." := ProdRoutingLineGRec."Work Center No.";
              ProdRoutingLineGRec.MODIFY;
            END ELSE BEGIN
              RoutingLineGRec.RESET;
              RoutingLineGRec.SETRANGE("Routing No.",ProdRoutingLineGRec."Routing No.");
              RoutingLineGRec.SETRANGE("Operation No.",ProdRoutingLineGRec."Operation No.");
              IF RoutingLineGRec.FINDLAST THEN BEGIN
                ProdRoutingLineGRec."No." := RoutingLineGRec."No.";
                ProdRoutingLineGRec.MODIFY;
              END;
            END;
          UNTIL ProdRoutingLineGRec.NEXT = 0;
        */

        ProdRoutingLineGRec.RESET;
        ProdRoutingLineGRec.SETFILTER("No.", '=%1', '');
        IF ProdRoutingLineGRec.FINDSET THEN
            REPEAT
                ProdRoutingLineGRec."No." := 'TEST-UPG';
                ProdRoutingLineGRec.MODIFY;
            UNTIL ProdRoutingLineGRec.NEXT = 0;

        MESSAGE('Completed');

    end;

    var
        ProdRoutingLineGRec: Record "Prod. Order Routing Line";
        ProdRoutingTmp: Record "Prod. Routing Lines Tmp";
        EntryNo: Integer;
        RoutingLineGRec: Record "Routing Line";
}

