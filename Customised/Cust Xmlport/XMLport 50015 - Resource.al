xmlport 50015 Resource
{
    Format = VariableText;

    schema
    {
        textelement(Resources)
        {
            tableelement(Resource; Resource)
            {
                XmlName = 'Resource';
                fieldelement(No; Resource."No.")
                {
                }
                fieldelement(Type; Resource.Type)
                {
                }
                fieldelement(Name; Resource.Name)
                {
                }
                fieldelement(SearchName; Resource."Search Name")
                {
                }
                fieldelement(ResourceGroupNo; Resource."Resource Group No.")
                {
                }
                fieldelement(BaseUnitofMeasure; Resource."Base Unit of Measure")
                {
                }
                fieldelement(GenProdPostingGroup; Resource."Gen. Prod. Posting Group")
                {
                }
                fieldelement(DirectUnitCost; Resource."Direct Unit Cost")
                {
                }
                fieldelement(IndirectCostPer; Resource."Indirect Cost %")
                {
                }
                fieldelement(UnitPrice; Resource."Unit Price")
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

