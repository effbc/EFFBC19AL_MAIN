xmlport 80811 "Temp Cust Ledg Entry Desc"
{
    Format = VariableText;

    schema
    {
        textelement(TempCustLedgEntryDesc)
        {
            tableelement("<tempcustledgentrydesc>"; "Temp Cust Ledg. Entry Desc")
            {
                XmlName = 'TempCustLedgEntryDesc';
                fieldelement(EntryNo; "<TempCustLedgEntryDesc>"."Entry No.")
                {
                }
                fieldelement(Description; "<TempCustLedgEntryDesc>".Description)
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

