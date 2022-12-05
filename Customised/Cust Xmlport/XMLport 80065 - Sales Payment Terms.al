xmlport 80065 "Sales Payment Terms"
{
    Format = VariableText;

    schema
    {
        textelement(PaymentTerms)
        {
            tableelement("<paymentterm>"; "Payment Terms")
            {
                XmlName = 'PaymentTerm';
                fieldelement(Code; "<PaymentTerm>".Code)
                {
                }
                fieldelement(Description; "<PaymentTerm>".Description)
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

