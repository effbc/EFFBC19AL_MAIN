xmlport 50174 "Inward Data"
{
    Format = VariableText;

    schema
    {
        textelement(PurchaseInwardDatas)
        {
            tableelement("<purchaseinwarddata>"; "Purchase Inward Data")
            {
                XmlName = 'PurchaseInwardData';
                fieldelement(PurchaseOrder; "<PurchaseInwardData>"."Purchase Order")
                {
                }
                fieldelement(PostingDate; "<PurchaseInwardData>"."Posting Date")
                {
                }
                fieldelement(LocationCode; "<PurchaseInwardData>"."Location Code")
                {
                }
                fieldelement(Item; "<PurchaseInwardData>".Item)
                {
                }
                fieldelement(Qty; "<PurchaseInwardData>".Qty)
                {
                }
                fieldelement(BatchCode; "<PurchaseInwardData>"."Batch Code")
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

