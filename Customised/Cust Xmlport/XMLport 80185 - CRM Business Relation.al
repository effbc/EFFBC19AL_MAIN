xmlport 80185 "CRM Business Relation"
{
    Format = VariableText;

    schema
    {
        textelement(BusinessRelations)
        {
            tableelement("<businessrelation>"; "Business Relation")
            {
                XmlName = 'BusinessRelation';
                fieldelement(Code; "<BusinessRelation>".Code)
                {
                }
                fieldelement(Description; "<BusinessRelation>".Description)
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

