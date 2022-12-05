xmlport 50999 "Item-Cost"
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(Description; Item.Description)
                {
                }
                fieldelement(UnitCost; Item."Unit Cost")
                {
                }
                fieldelement(AvgUnitCost; Item."Avg Unit Cost")
                {
                }
                fieldelement(DumAvgCot; Item.Dum_Avg_Cot)
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

