xmlport 50060 "No. Series Manual"
{
    Format = VariableText;

    schema
    {
        textelement(NoSeries)
        {
            tableelement("<noseries>"; "No. Series")
            {
                XmlName = 'NoSeries';
                fieldelement(Code; "<NoSeries>".Code)
                {
                }
                fieldelement(ManualNos; "<NoSeries>"."Manual Nos.")
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

