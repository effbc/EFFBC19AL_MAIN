xmlport 80090 "Production BOM Header"
{
    Format = VariableText;

    schema
    {
        textelement(ProductionBOMHeader)
        {
            tableelement("Production BOM Header"; "Production BOM Header")
            {
                XmlName = 'ProductionBOMHeader';
                fieldelement(No; "Production BOM Header"."No.")
                {
                }
                fieldelement(Description; "Production BOM Header".Description)
                {
                }
                fieldelement(Description2; "Production BOM Header"."Description 2")
                {
                }
                fieldelement(SearchName; "Production BOM Header"."Search Name")
                {
                }
                fieldelement(UnitofMeasureCode; "Production BOM Header"."Unit of Measure Code")
                {
                }
                fieldelement(Status; "Production BOM Header".Status)
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

