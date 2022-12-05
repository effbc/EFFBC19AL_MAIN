xmlport 50182 "Item Batch Prices"
{
    Format = VariableText;

    schema
    {
        textelement(OldPurInvoices)
        {
            tableelement(Old_Pur_Invoices; Old_Pur_Invoices)
            {
                XmlName = 'OldPurInvoice';
                fieldelement(ItemNo; Old_Pur_Invoices."Item No.")
                {
                }
                fieldelement(LotNo; Old_Pur_Invoices."Lot No.")
                {
                }
                fieldelement(UnitCost; Old_Pur_Invoices."Unit Cost")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    /*Item.RESET;
                     Item.SETFILTER(Item."No.",Old_Pur_Invoices."Item No.");
                     IF Item.FINDFIRST THEN
                     BEGIN
                       Old_Pur_Invoices.Descrption:=Item.Description;
                       Old_Pur_Invoices.MODIFY;
                     END;
                     */

                end;
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

    var
        Item: Record Item;
}

