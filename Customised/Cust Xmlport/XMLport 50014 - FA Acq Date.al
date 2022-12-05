xmlport 50014 "FA Acq Date"
{
    Format = VariableText;

    schema
    {
        textelement(FixedAssets)
        {
            tableelement("<fixedasset>"; "Fixed Asset")
            {
                XmlName = 'FixedAsset';
                fieldelement(No; "<FixedAsset>"."No.")
                {
                }
                fieldelement(ServiceTaxGroupCode; "<FixedAsset>"."Service Tax Group Code")
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

