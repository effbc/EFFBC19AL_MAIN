xmlport 80066 "Sales Payment Methods"
{
    Format = VariableText;

    schema
    {
        textelement(PaymentMethods)
        {
            tableelement("<paymentmethod>"; "Payment Method")
            {
                XmlName = 'PaymentMethod';
                fieldelement(Code; "<PaymentMethod>".Code)
                {
                }
                fieldelement(Description; "<PaymentMethod>".Description)
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

