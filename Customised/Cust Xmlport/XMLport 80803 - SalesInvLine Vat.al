xmlport 80803 "SalesInvLine Vat"
{
    Format = VariableText;

    schema
    {
        textelement(SalesInvLineVats)
        {
            tableelement("<salesinvlinevat>"; "SalesInvLine Vat")
            {
                XmlName = 'SalesInvLineVat';
                fieldelement(DocumentNo; "<SalesInvLineVat>"."Document No.")
                {
                }
                fieldelement(LineNo; "<SalesInvLineVat>"."Line No.")
                {
                }
                fieldelement(VatPersge; "<SalesInvLineVat>"."Vat %age")
                {
                }
                fieldelement(VatBase; "<SalesInvLineVat>"."Vat Base")
                {
                }
                fieldelement(VatAmount; "<SalesInvLineVat>"."Vat Amount")
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

