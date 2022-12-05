xmlport 90110 "ijl dp10"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable10)
        {
            tableelement("<ijltable10>"; "IJL Table10")
            {
                XmlName = 'IJLTable10';
                fieldelement(EntryNo; "<IJLTable10>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable10>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable10>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable10>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable10>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable10>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable10>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable10>".Location)
                {
                }
                fieldelement(amount; "<IJLTable10>".amount)
                {
                }
                fieldelement(total; "<IJLTable10>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable10>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable10>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable10>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable10>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable10>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable10>"."Qty per")
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

