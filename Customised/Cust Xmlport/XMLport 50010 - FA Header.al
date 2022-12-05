xmlport 50010 "FA Header"
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
                fieldelement(Description; "<FixedAsset>".Description)
                {
                }
                fieldelement(FAPostingGroup; "<FixedAsset>"."FA Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "<FixedAsset>"."Gen. Prod. Posting Group")
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

