xmlport 80224 "service item"
{
    Format = VariableText;

    schema
    {
        textelement(ServiceItems)
        {
            tableelement("<serviceitem>"; "Service Item")
            {
                XmlName = 'ServiceItem';
                fieldelement(No; "<ServiceItem>"."No.")
                {
                }
                fieldelement(ServiceItemGroupCode; "<ServiceItem>"."Service Item Group Code")
                {
                }
                fieldelement(Description; "<ServiceItem>".Description)
                {
                }
                fieldelement(Priority; "<ServiceItem>".Priority)
                {
                }
                fieldelement(CustomerNo; "<ServiceItem>"."Customer No.")
                {
                }
                fieldelement(Name; "<ServiceItem>".Name)
                {
                }
                fieldelement(PostCode; "<ServiceItem>"."Post Code")
                {
                }
                fieldelement(City; "<ServiceItem>".City)
                {
                }
                fieldelement(ItemNo; "<ServiceItem>"."Item No.")
                {
                }
                fieldelement(ShiptoName; "<ServiceItem>"."Ship-to Name")
                {
                }
                fieldelement(ShiptoPostCode; "<ServiceItem>"."Ship-to Post Code")
                {
                }
                fieldelement(ShiptoCity; "<ServiceItem>"."Ship-to City")
                {
                }
                fieldelement(LocationofServiceItem; "<ServiceItem>"."Location of Service Item")
                {
                }
                fieldelement(UnitofMeasureCode; "<ServiceItem>"."Unit of Measure Code")
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

