xmlport 90104 "ijl dp4"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable4)
        {
            tableelement("<ijltable4>"; "IJL Table4")
            {
                XmlName = 'IJLTable4';
                fieldelement(EntryNo; "<IJLTable4>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable4>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable4>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable4>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable4>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable4>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable4>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable4>".Location)
                {
                }
                fieldelement(amount; "<IJLTable4>".amount)
                {
                }
                fieldelement(total; "<IJLTable4>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable4>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable4>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable4>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable4>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable4>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable4>"."Qty per")
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

