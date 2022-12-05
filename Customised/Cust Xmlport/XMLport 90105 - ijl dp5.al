xmlport 90105 "ijl dp5"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable5)
        {
            tableelement("<ijltable5>"; "IJL Table5")
            {
                XmlName = 'IJLTable5';
                fieldelement(EntryNo; "<IJLTable5>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable5>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable5>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable5>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable5>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable5>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable5>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable5>".Location)
                {
                }
                fieldelement(amount; "<IJLTable5>".amount)
                {
                }
                fieldelement(total; "<IJLTable5>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable5>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable5>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable5>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable5>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable5>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable5>"."Qty per")
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

