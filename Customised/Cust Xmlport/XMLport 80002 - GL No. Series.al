xmlport 80002 "G/L No. Series"
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
                fieldelement(Description; "<NoSeries>".Description)
                {
                }
                fieldelement(DefaultNos; "<NoSeries>"."Default Nos.")
                {
                }
                fieldelement(ManualNos; "<NoSeries>"."Manual Nos.")
                {
                }
                fieldelement(DateOrder; "<NoSeries>"."Date Order")
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

