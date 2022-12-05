xmlport 50190 "Site Stock Correction"
{

    schema
    {
        textelement(Test)
        {
            tableelement("Item Ledger Entry"; "Item Ledger Entry")
            {
                XmlName = 'ILEGREC';
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

