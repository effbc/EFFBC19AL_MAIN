xmlport 90107 "ijl dp7"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable7)
        {
            tableelement("<ijltable7>"; "IJL Table7")
            {
                XmlName = 'IJLTable7';
                fieldelement(EntryNo; "<IJLTable7>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable7>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable7>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable7>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable7>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable7>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable7>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable7>".Location)
                {
                }
                fieldelement(amount; "<IJLTable7>".amount)
                {
                }
                fieldelement(total; "<IJLTable7>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable7>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable7>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable7>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable7>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable7>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable7>"."Qty per")
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

