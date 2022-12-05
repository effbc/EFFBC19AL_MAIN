xmlport 80802 "Sales Line Vat"
{
    Format = VariableText;

    schema
    {
        textelement(SalesLineVats)
        {
            tableelement("<saleslinevat>"; "Sales Line Vat")
            {
                XmlName = 'SalesLineVat';
                fieldelement(DocumentType; "<SalesLineVat>"."Document Type")
                {
                }
                fieldelement(DocumentNo; "<SalesLineVat>"."Document No.")
                {
                }
                fieldelement(LineNo; "<SalesLineVat>"."Line No.")
                {
                }
                fieldelement(VatPerage; "<SalesLineVat>"."Vat %age")
                {
                }
                fieldelement(VatBase; "<SalesLineVat>"."Vat Base")
                {
                }
                fieldelement(VatAmount; "<SalesLineVat>"."Vat Amount")
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

