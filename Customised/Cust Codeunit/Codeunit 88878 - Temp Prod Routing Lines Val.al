codeunit 88878 "Temp Prod Routing Lines Val"
{

    trigger OnRun();
    begin
        ProdRoutingLineGRec.RESET;
        ProdRoutingLineGRec.SETFILTER("No.", '<>%1', '');
        IF ProdRoutingLineGRec.FINDSET THEN
            REPEAT

                EntryNo += 1;

                ProdRoutingTmp.INIT;
                ProdRoutingTmp."Entry No." := EntryNo;
                ProdRoutingTmp."Prod. Order No." := ProdRoutingLineGRec."Prod. Order No.";
                ProdRoutingTmp."Prod. Order Line No." := ProdRoutingLineGRec."Routing Reference No.";
                // ProdRoutingTmp."Prod. Comp. Line No." :=

                ProdRoutingTmp.INSERT;


            UNTIL ProdRoutingLineGRec.NEXT = 0;
    end;

    var
        ProdRoutingLineGRec: Record "Prod. Order Routing Line";
        ProdRoutingTmp: Record "Prod. Routing Lines Tmp";
        EntryNo: Integer;
}

