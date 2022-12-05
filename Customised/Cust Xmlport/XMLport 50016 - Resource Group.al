xmlport 50016 "Resource Group"
{
    Format = VariableText;

    schema
    {
        textelement(ResourceGroups)
        {
            tableelement("<resourcegroup>"; "Resource Group")
            {
                XmlName = 'ResourceGroup';
                fieldelement(No; "<ResourceGroup>"."No.")
                {
                }
                fieldelement(Name; "<ResourceGroup>".Name)
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

