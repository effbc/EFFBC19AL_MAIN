xmlport 80084 "Item Category"
{
    Format = VariableText;

    schema
    {
        textelement(ItemCategories)
        {
            tableelement("<itemcategory>"; "Item Category")
            {
                XmlName = 'ItemCategory';
                fieldelement(Code; "<ItemCategory>".Code)
                {
                }
                fieldelement(Description; "<ItemCategory>".Description)
                {
                }
                //EFFUPG>>
                /*
                fieldelement(DefGenProdPostingGroup; "<ItemCategory>"."Def. Gen. Prod. Posting Group")
                {
                }
                fieldelement(DefInventoryPostingGroup; "<ItemCategory>"."Def. Inventory Posting Group")
                {
                }
                fieldelement(DefCostingMethod; "<ItemCategory>"."Def. Costing Method")
                {
                }
                */
                //EFFUPG<<
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

