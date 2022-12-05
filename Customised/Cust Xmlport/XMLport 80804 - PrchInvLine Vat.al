xmlport 80804 "PrchInvLine Vat"
{
    Format = VariableText;

    schema
    {
        textelement(PurchInvLineVats)
        {
            tableelement("<purchinvlinevat>"; "PurchInvLine Vat")
            {
                XmlName = 'PurchInvLineVat';
                fieldelement(DocumentNo; "<PurchInvLineVat>"."Document No.")
                {
                }
                fieldelement(LineNo; "<PurchInvLineVat>"."Line No.")
                {
                }
                fieldelement(VatPertage; "<PurchInvLineVat>"."Vat %age")
                {
                }
                fieldelement(VatBase; "<PurchInvLineVat>"."Vat Base")
                {
                }
                fieldelement(VatAmount; "<PurchInvLineVat>"."Vat Amount")
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

