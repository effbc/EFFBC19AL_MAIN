xmlport 90100 "ijl dp"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable)
        {
            tableelement("<ijltable>"; "IJL Table")
            {
                XmlName = 'IJLTable';
                fieldelement(EntryNo; "<IJLTable>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable>".Location)
                {
                }
                fieldelement(amount; "<IJLTable>".amount)
                {
                }
                fieldelement(total; "<IJLTable>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable>"."Qty per")
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

