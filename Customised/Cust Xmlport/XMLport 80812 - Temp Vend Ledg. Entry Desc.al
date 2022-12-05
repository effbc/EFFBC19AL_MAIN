xmlport 80812 "Temp Vend Ledg. Entry Desc"
{
    Format = VariableText;

    schema
    {
        textelement(TempVendLedgEntryDesc)
        {
            tableelement("<tempvendledgentrydesc>"; "Temp Vend Ledg. Entry Desc")
            {
                XmlName = 'TempVendLedgEntryDesc';
                fieldelement(EntryNo; "<TempVendLedgEntryDesc>"."Entry No.")
                {
                }
                fieldelement(Description; "<TempVendLedgEntryDesc>".Description)
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

