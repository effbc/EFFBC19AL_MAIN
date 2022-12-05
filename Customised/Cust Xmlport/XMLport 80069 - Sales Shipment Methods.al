xmlport 80069 "Sales Shipment Methods"
{
    Format = VariableText;

    schema
    {
        textelement(ShipmentMethods)
        {
            tableelement("<shipmentmethod>"; "Shipment Method")
            {
                XmlName = 'ShipmentMethod';
                fieldelement(Code; "<ShipmentMethod>".Code)
                {
                }
                fieldelement(Description; "<ShipmentMethod>".Description)
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

