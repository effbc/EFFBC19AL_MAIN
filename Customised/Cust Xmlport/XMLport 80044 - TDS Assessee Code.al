xmlport 80044 "TDS Assessee Code"
{
    Format = VariableText;

    schema
    {
        textelement(AssesseeCodes)
        {
            tableelement("<assesseecode>"; "Assessee Code")
            {
                XmlName = 'AssesseeCode';
                fieldelement(Code; "<AssesseeCode>".Code)
                {
                }
                fieldelement(Description; "<AssesseeCode>".Description)
                {
                }
                fieldelement(Type; "<AssesseeCode>".Type)
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

