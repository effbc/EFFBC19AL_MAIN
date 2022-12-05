xmlport 90102 "ijl dp2"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable2)
        {
            tableelement("<ijltable2>"; "IJL Table2")
            {
                XmlName = 'IJLTable2';
                fieldelement(EntryNo; "<IJLTable2>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable2>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable2>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable2>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable2>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable2>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable2>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable2>".Location)
                {
                }
                fieldelement(amount; "<IJLTable2>".amount)
                {
                }
                fieldelement(total; "<IJLTable2>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable2>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable2>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable2>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable2>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable2>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable2>"."Qty per")
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

