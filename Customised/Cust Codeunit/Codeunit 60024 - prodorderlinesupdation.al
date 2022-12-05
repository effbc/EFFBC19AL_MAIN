codeunit 60024 prodorderlinesupdation
{

    trigger OnRun();
    begin
        IF "production order".FINDSET THEN
            REPEAT
            BEGIN
                prodline.SETRANGE("Prod. Order No.", "production order"."No.");
                //MESSAGE(FORMAT(prodline.COUNT));
                IF prodline.FINDSET THEN
                    REPEAT
                        prodline."Sales Order No" := "production order"."Sales Order No.";
                        //MESSAGE(FORMAT(prodline."Sales Order No"));
                        prodline.MODIFY;
                    UNTIL prodline.NEXT = 0;
            END;
            UNTIL "production order".NEXT = 0;
    end;

    var
        "production order": Record "Production Order";
        prodline: Record "Prod. Order Line";
}

