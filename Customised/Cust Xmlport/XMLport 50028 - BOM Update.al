xmlport 50028 "BOM Update"
{

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
                fieldelement(No; "<ProdBOMLine>"."No.")
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

