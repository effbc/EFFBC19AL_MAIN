xmlport 80200 "Item Specification"
{
    Format = VariableText;

    schema
    {
        textelement(ItemSpecifications)
        {
            tableelement("<itemspecification>"; "Item Specification")
            {
                XmlName = 'ItemSpecification';
                fieldelement(ItemNo; "<ItemSpecification>"."Item No.")
                {
                }
                fieldelement(ItemCategoryCode; "<ItemSpecification>"."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; "<ItemSpecification>"."Product Group Code")
                {
                }
                fieldelement(ItemSubGroupCode; "<ItemSpecification>"."Item Sub Group Code")
                {
                }
                fieldelement(ItemSubSubGroupCode; "<ItemSpecification>"."Item Sub Sub Group Code")
                {
                }
                fieldelement(SpecificationCode; "<ItemSpecification>"."Specification Code")
                {
                }
                fieldelement(Description; "<ItemSpecification>".Description)
                {
                }
                fieldelement(Value; "<ItemSpecification>".Value)
                {
                }
                fieldelement(LineNo; "<ItemSpecification>"."Line No.")
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

