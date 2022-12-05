codeunit 80014 "Production BOM lines"
{

    trigger OnRun();
    begin
        IF ProdBOMLine.FINDFIRST THEN
            REPEAT
                ProdBOMLine.VALIDATE(ProdBOMLine."Production BOM No.");
                //ProdBOMLine.VALIDATE(ProdBOMLine.Type);
                ProdBOMLine.VALIDATE(ProdBOMLine."No.");
                ProdBOMLine.VALIDATE(ProdBOMLine."Line No.");
                ProdBOMLine.VALIDATE(ProdBOMLine."Unit of Measure Code");
                ProdBOMLine.VALIDATE(ProdBOMLine."Quantity per");
                ProdBOMLine.MODIFY(TRUE);
            UNTIL ProdBOMLine.NEXT = 0;
        MESSAGE('DONE');
    end;

    var
        ProdBOMLine: Record "Production BOM Line";
}

