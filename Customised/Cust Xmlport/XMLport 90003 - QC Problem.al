xmlport 90003 "QC Problem"
{
    Format = VariableText;

    schema
    {
        textelement(PurchRcptLines)
        {
            tableelement("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                XmlName = 'PurchRcptLine';
                fieldelement(DocumentNo; "Purch. Rcpt. Line"."Document No.")
                {
                }
                fieldelement(LineNo; "Purch. Rcpt. Line"."Line No.")
                {
                }
                fieldelement(QuantityAccepted; "Purch. Rcpt. Line"."Quantity Accepted")
                {
                }
                fieldelement(QuantityRework; "Purch. Rcpt. Line"."Quantity Rework")
                {
                }
                fieldelement(QuantityRejected; "Purch. Rcpt. Line"."Quantity Rejected")
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

