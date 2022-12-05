xmlport 91001 "Test - Mi"
{
    Format = VariableText;

    schema
    {
        textelement(TestMi)
        {
            tableelement("Test - Mi"; "Test - Mi")
            {
                XmlName = 'TestMi';
                fieldelement(DocumentNo; "Test - Mi"."Document No.")
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

