xmlport 80091 "Production BOM Line"
{
    Format = VariableText;

    schema
    {
        textelement(ProductionBOMLines)
        {
            tableelement("<productionbomline>"; "Production BOM Line")
            {
                XmlName = 'ProductionBOMLine';
                fieldelement(ProductionBOMNo; "<ProductionBOMLine>"."Production BOM No.")
                {
                }
                fieldelement(Type; "<ProductionBOMLine>".Type)
                {
                }
                fieldelement(No; "<ProductionBOMLine>"."No.")
                {
                }
                fieldelement(LineNo; "<ProductionBOMLine>"."Line No.")
                {
                }
                fieldelement(Description; "<ProductionBOMLine>".Description)
                {
                }
                fieldelement(Description2; "<ProductionBOMLine>"."Description 2")
                {
                }
                fieldelement(RoutingLinkCode; "<ProductionBOMLine>"."Routing Link Code")
                {
                }
                fieldelement(NoofPins; "<ProductionBOMLine>"."No. of Pins")
                {
                }
                fieldelement(NoofSolderingPoints; "<ProductionBOMLine>"."No. of Soldering Points")
                {
                }
                fieldelement(NoofOpportunities; "<ProductionBOMLine>"."No. of Opportunities")
                {
                }
                fieldelement(TypeofSolder; "<ProductionBOMLine>"."Type of Solder")
                {
                }
                fieldelement(ShelfNo; "<ProductionBOMLine>"."Shelf No.")
                {
                }
                fieldelement(NoofFixingHoles; "<ProductionBOMLine>"."No. of Fixing Holes")
                {
                }
                fieldelement(Position; "<ProductionBOMLine>".Position)
                {
                }
                fieldelement(Position2; "<ProductionBOMLine>"."Position 2")
                {
                }
                fieldelement(Position3; "<ProductionBOMLine>"."Position 3")
                {
                }
                fieldelement(Position4; "<ProductionBOMLine>"."Position 4")
                {
                }
                fieldelement(QuantityPer; "<ProductionBOMLine>"."Quantity per")
                {
                }
                fieldelement(UnitofMeasureCode; "<ProductionBOMLine>"."Unit of Measure Code")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }
}

