xmlport 80813 "Temp Bank Acc Ledg. Entry Desc"
{
    Format = VariableText;

    schema
    {
        textelement(TempBankLedgEntryDesc)
        {
            tableelement("<tempbankledgentrydesc>"; "Temp Bank Ledg. Entry Desc")
            {
                XmlName = 'TempBankLedgEntryDesc';
                fieldelement(EntryNo; "<TempBankLedgEntryDesc>"."Entry No.")
                {
                }
                fieldelement(Description; "<TempBankLedgEntryDesc>".Description)
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

