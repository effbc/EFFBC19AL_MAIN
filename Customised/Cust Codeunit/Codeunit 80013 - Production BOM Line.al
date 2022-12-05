codeunit 80013 "Production BOM Line"
{

    trigger OnRun();
    begin

        IF ProductionBOMLine.FINDFIRST THEN
            REPEAT
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Production BOM No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Line No.");
                //           MESSAGE('%1',ProductionBOMLine."Line No.");

                //     ProductionBOMLine.VALIDATE(ProductionBOMLine.Type);
                ProductionBOMLine.VALIDATE(ProductionBOMLine."No.");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Unit of Measure Code");
                //   ProductionBOMLine.VALIDATE(ProductionBOMLine."Production Lead Time");//B2b
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Routing Link Code");
                ProductionBOMLine.VALIDATE(ProductionBOMLine."Quantity per");
                ProductionBOMLine.MODIFY(TRUE);
            UNTIL ProductionBOMLine.NEXT = 0;
        MESSAGE('Done');
        /*
        IF ProdBOMLine.FINDFIRST THEN
          REPEAT
            ProdBOMLine.VALIDATE(ProdBOMLine."Production BOM No.");
            ProdBOMLine.VALIDATE(ProdBOMLine."No.");
            ProdBOMLine.VALIDATE(ProdBOMLine."Line No.");
            ProdBOMLine.VALIDATE(ProdBOMLine."Unit of Measure Code");
            ProdBOMLine.VALIDATE(ProdBOMLine.Quantity);
            ProdBOMLine.MODIFY(TRUE);
          UNTIL ProdBOMLine.NEXT = 0;
        MESSAGE('DONE');
        */

    end;

    var
        ProductionBOMLine: Record "Production BOM Line";
        ProdBOMLine: Record "Production BOM Line";
}

