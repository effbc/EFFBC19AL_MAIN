xmlport 90106 "ijl dp6"
{
    Format = VariableText;

    schema
    {
        textelement(IJLTable6)
        {
            tableelement("<ijltable6>"; "IJL Table6")
            {
                XmlName = 'IJLTable6';
                fieldelement(EntryNo; "<IJLTable6>"."Entry No.")
                {
                }
                fieldelement(No; "<IJLTable6>"."No.")
                {
                }
                fieldelement(Quantity; "<IJLTable6>".Quantity)
                {
                }
                fieldelement(Rate; "<IJLTable6>".Rate)
                {
                }
                fieldelement(DocumentNo; "<IJLTable6>"."Document No.")
                {
                }
                fieldelement(DocumentDate; "<IJLTable6>"."Document Date")
                {
                }
                fieldelement(LineNo; "<IJLTable6>"."Line No")
                {
                }
                fieldelement(Location; "<IJLTable6>".Location)
                {
                }
                fieldelement(amount; "<IJLTable6>".amount)
                {
                }
                fieldelement(total; "<IJLTable6>".total)
                {
                }
                fieldelement(JnlBatchName; "<IJLTable6>"."Jnl Batch Name")
                {
                }
                fieldelement(JnlTemplate; "<IJLTable6>"."Jnl Template")
                {
                }
                fieldelement(IPG; "<IJLTable6>".IPG)
                {
                }
                fieldelement(GPPG; "<IJLTable6>".GPPG)
                {
                }
                fieldelement(UOM; "<IJLTable6>".UOM)
                {
                }
                fieldelement(Qtyper; "<IJLTable6>"."Qty per")
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

