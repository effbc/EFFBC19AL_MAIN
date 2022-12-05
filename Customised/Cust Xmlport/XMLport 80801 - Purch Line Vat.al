xmlport 80801 "Purch Line Vat"
{
    Format = VariableText;

    schema
    {
        textelement(PurchLineVats)
        {
            tableelement("<purchlinevat>"; "Purch Line Vat")
            {
                XmlName = 'PurchLineVat';
                fieldelement(DocumentType; "<PurchLineVat>"."Document Type")
                {
                }
                fieldelement(DocumentNo; "<PurchLineVat>"."Document No.")
                {
                }
                fieldelement(LineNo; "<PurchLineVat>"."Line No.")
                {
                }
                fieldelement(VatPerge; "<PurchLineVat>"."Vat %age")
                {
                }
                fieldelement(VatBase; "<PurchLineVat>"."Vat Base")
                {
                }
                fieldelement(VatAmount; "<PurchLineVat>"."Vat Amount")
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

