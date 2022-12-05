xmlport 50175 "site old stock data"
{
    Format = VariableText;

    schema
    {
        textelement(ProductwiseItems)
        {
            tableelement("Product wise Items"; "Product wise Items")
            {
                XmlName = 'ProductwiseItem';
                fieldelement(ItemNo; "Product wise Items"."Item No.")
                {
                }
                fieldelement(Description; "Product wise Items".Description)
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

