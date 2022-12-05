codeunit 90012 "Routing Validate"
{
    // version BS Latest

    // routing validation
    // Rasool


    trigger OnRun();
    begin

        //Routing Header validate
        IF RoutingHeader.FINDFIRST THEN BEGIN
            REPEAT
                RoutingHeader.VALIDATE(RoutingHeader.Status, RoutingHeader.Status::New);
                RoutingHeader.VALIDATE(RoutingHeader.Type);
                RoutingHeader.VALIDATE(RoutingHeader."Version Nos.");
                RoutingHeader.VALIDATE(RoutingHeader."No. Series");
                RoutingHeader.MODIFY(TRUE);
            UNTIL RoutingHeader.NEXT = 0;
        END;

        //Routing Line validate
        IF RoutingLine.FINDFIRST THEN BEGIN
            REPEAT

                RoutingLine.VALIDATE(RoutingLine."Routing No.");

                RoutingLine.VALIDATE(RoutingLine."Operation No.");
                IF RoutingLine."Next Operation No." <> '' THEN
                    RoutingLine.VALIDATE(RoutingLine."Next Operation No.");
                IF RoutingLine."Previous Operation No." <> '' THEN
                    RoutingLine.VALIDATE(RoutingLine."Previous Operation No.");

                //RoutingLine.VALIDATE(RoutingLine.Type);
                RoutingLine.VALIDATE(RoutingLine."No.");

                IF RoutingLine."Work Center No." <> '' THEN BEGIN
                    RoutingLine.VALIDATE(RoutingLine."Work Center No.");
                    RoutingLine.VALIDATE(RoutingLine."Work Center Group Code");
                END;

                RoutingLine.VALIDATE(RoutingLine."Setup Time Unit of Meas. Code");
                RoutingLine.VALIDATE(RoutingLine."Run Time Unit of Meas. Code");
                RoutingLine.VALIDATE(RoutingLine."Wait Time Unit of Meas. Code");
                RoutingLine.VALIDATE(RoutingLine."Move Time Unit of Meas. Code");
                RoutingLine.VALIDATE(RoutingLine.Recalculate);
                RoutingLine.VALIDATE(RoutingLine."Sequence No. (Forward)");
                RoutingLine.VALIDATE(RoutingLine."Sequence No. (Backward)");

                RoutingLine.MODIFY(TRUE);
            UNTIL RoutingLine.NEXT = 0;
        END;

        RoutingHeader.RESET;
        IF RoutingHeader.FINDFIRST THEN
            REPEAT
                RoutingHeader.VALIDATE(RoutingHeader.Status, RoutingHeader.Status::Certified);
                RoutingHeader.MODIFY(TRUE);
            UNTIL RoutingHeader.NEXT = 0;

        MESSAGE('done');
    end;

    var
        RoutingHeader: Record "Routing Header";
        RoutingLine: Record "Routing Line";
        WorkCenter: Record "Work Center";
}

