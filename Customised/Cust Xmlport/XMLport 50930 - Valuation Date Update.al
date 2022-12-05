xmlport 50930 "Valuation Date Update"
{
    Format = VariableText;

    schema
    {
        textelement(ValueEntries)
        {
            tableelement("<valueentry>"; "Value Entry")
            {
                XmlName = 'ValueEntry';
                fieldelement(EntryNo; "<ValueEntry>"."Entry No.")
                {
                }
                fieldelement(ValuationDate; "<ValueEntry>"."Valuation Date")
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

