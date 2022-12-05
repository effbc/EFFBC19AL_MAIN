codeunit 88880 "Update missing machine codes"
{

    trigger OnRun();
    begin
        ProdRoutingLineGRec.RESET;
        ProdRoutingLineGRec.SETCURRENTKEY(Type, "No.", "Starting Date");
        IF ProdRoutingLineGRec.FINDSET THEN
            REPEAT
                IF ProdRoutingLineGRec.Type = ProdRoutingLineGRec.Type::"Work Center" THEN BEGIN
                    IF NOT WorkCenterGRec.GET(ProdRoutingLineGRec."No.") THEN BEGIN
                        EntryNo += 1;
                        WorkCenterTmp.INIT;
                        WorkCenterTmp."Entry No." := EntryNo;
                        WorkCenterTmp.Type := ProdRoutingLineGRec.Type;
                        WorkCenterTmp."No." := ProdRoutingLineGRec."No.";
                        WorkCenterTmp.INSERT;
                    END;
                END ELSE
                    IF ProdRoutingLineGRec.Type = ProdRoutingLineGRec.Type::"Machine Center" THEN BEGIN
                        IF NOT MachineCenterGRec.GET(ProdRoutingLineGRec."No.") THEN BEGIN
                            EntryNo += 1;
                            WorkCenterTmp.INIT;
                            WorkCenterTmp."Entry No." := EntryNo;
                            WorkCenterTmp.Type := ProdRoutingLineGRec.Type;
                            WorkCenterTmp."No." := ProdRoutingLineGRec."No.";
                            WorkCenterTmp.INSERT;
                        END;
                    END;
            UNTIL ProdRoutingLineGRec.NEXT = 0;
    end;

    var
        ProdRoutingLineGRec: Record "Prod. Order Routing Line";
        EntryNo: Integer;
        WorkCenterTmp: Record "Routing Values";
        MachineCenterGRec: Record "Machine Center";
        WorkCenterGRec: Record "Work Center";
}

