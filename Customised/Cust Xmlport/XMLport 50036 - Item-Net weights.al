xmlport 50036 "Item-Net weights"
{
    Format = VariableText;

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(NetWeight; Item."Net Weight")
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

