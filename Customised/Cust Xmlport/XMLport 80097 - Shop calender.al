xmlport 80097 "Shop calender"
{
    Format = VariableText;

    schema
    {
        textelement(ShopCalendars)
        {
            tableelement("<shopcalendar>"; "Shop Calendar")
            {
                XmlName = 'ShopCalendar';
                fieldelement(Code; "<ShopCalendar>".Code)
                {
                }
                fieldelement(Description; "<ShopCalendar>".Description)
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

