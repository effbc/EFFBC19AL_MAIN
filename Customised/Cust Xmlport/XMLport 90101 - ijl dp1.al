xmlport 90101 "ijl dp1"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable1)
        {
            tableelement("<ijltable1>"; "IJL Table1")
            {
                XmlName = 'IJLTable1';
                fieldelement(EntryNo; "<IJLTable1>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable1>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable1>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable1>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable1>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable1>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable1>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable1>".Location)
                {
                }
                fieldelement(amount; "<IJLTable1>".amount)
                {
                }
                fieldelement(total; "<IJLTable1>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable1>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable1>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable1>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable1>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable1>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable1>"."Qty per")
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

