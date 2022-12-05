xmlport 80108 "QC Master Sub Assembly"
{
    Format = VariableText;

    schema
    {
        textelement(SubAssemblies)
        {
            tableelement("<subassembly>"; "Sub Assembly")
            {
                XmlName = 'SubAssembly';
                fieldelement(No; "<SubAssembly>"."No.")
                {
                }
                fieldelement(Description; "<SubAssembly>".Description)
                {
                }
                fieldelement(SearchName; "<SubAssembly>"."Search Name")
                {
                }
                fieldelement(SpecId; "<SubAssembly>"."Spec Id")
                {
                }
                fieldelement(QCEnabled; "<SubAssembly>"."QC Enabled")
                {
                }
                fieldelement(UnitOfMeasureCode; "<SubAssembly>"."Unit Of Measure Code")
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

