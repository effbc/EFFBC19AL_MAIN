xmlport 50072 "test data"
{
    Format = VariableText;

    schema
    {
        textelement(StockStatements)
        {
            tableelement("Stock Statement"; "Stock Statement")
            {
                XmlName = 'StockStatement';
                fieldelement(Month; "Stock Statement".Month)
                {
                }
                fieldelement(Year; "Stock Statement".Year)
                {
                }
                fieldelement(Item; "Stock Statement".Item)
                {
                }
                fieldelement(StockQty; "Stock Statement"."Stock Qty")
                {
                }
                fieldelement(UnitCost; "Stock Statement"."Unit Cost")
                {
                }
                fieldelement(TotalCost; "Stock Statement"."Total Cost")
                {
                }
                fieldelement(MonthName; "Stock Statement"."Month Name")
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

