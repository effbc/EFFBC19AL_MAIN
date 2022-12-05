xmlport 50024 "Eff Prod BOM Line"
{
    Format = VariableText;

    schema
    {
        textelement(ProdBOMLines)
        {
            tableelement("<prodbomline>"; "Production BOM Line")
            {
                XmlName = 'ProdBOMLine';
                fieldelement(ProductionBOMNo; "<ProdBOMLine>"."Production BOM No.")
                {
                }
                fieldelement(LineNo; "<ProdBOMLine>"."Line No.")
                {
                }
                fieldelement(VersionCode; "<ProdBOMLine>"."Version Code")
                {
                }
                fieldelement(Type; "<ProdBOMLine>".Type)
                {
                }
                fieldelement(No; "<ProdBOMLine>"."No.")
                {
                }
                fieldelement(Description; "<ProdBOMLine>".Description)
                {
                }
                fieldelement(UnitofMeasureCode; "<ProdBOMLine>"."Unit of Measure Code")
                {
                }
                fieldelement(Quantity; "<ProdBOMLine>".Quantity)
                {
                }
                fieldelement(Position; "<ProdBOMLine>".Position)
                {
                }
                fieldelement(Position2; "<ProdBOMLine>"."Position 2")
                {
                }
                fieldelement(Position3; "<ProdBOMLine>"."Position 3")
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

