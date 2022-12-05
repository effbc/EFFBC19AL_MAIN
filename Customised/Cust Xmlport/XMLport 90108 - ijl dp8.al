xmlport 90108 "ijl dp8"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable8)
        {
            tableelement("<ijltable8>"; "IJL Table8")
            {
                XmlName = 'IJLTable8';
                fieldelement(EntryNo; "<IJLTable8>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable8>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable8>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable8>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable8>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable8>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable8>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable8>".Location)
                {
                }
                fieldelement(amount; "<IJLTable8>".amount)
                {
                }
                fieldelement(total; "<IJLTable8>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable8>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable8>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable8>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable8>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable8>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable8>"."Qty per")
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

