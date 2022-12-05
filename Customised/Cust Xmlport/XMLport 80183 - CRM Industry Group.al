xmlport 80183 "CRM Industry Group"
{
    Format = VariableText;

    schema
    {
        textelement(IndustryGroups)
        {
            tableelement("<industrygroup>"; "Industry Group")
            {
                XmlName = 'IndustryGroup';
                fieldelement(Code; "<IndustryGroup>".Code)
                {
                }
                fieldelement(Description; "<IndustryGroup>".Description)
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

