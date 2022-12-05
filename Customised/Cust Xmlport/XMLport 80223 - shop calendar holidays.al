xmlport 80223 "shop calendar holidays"
{
    Format = VariableText;

    schema
    {
        textelement(ShopCalendarHolidays)
        {
            tableelement("<shopcalendarholiday>"; "Shop Calendar Holiday")
            {
                XmlName = 'ShopCalendarHoliday';
                fieldelement(ShopCalendarCode; "<ShopCalendarHoliday>"."Shop Calendar Code")
                {
                }
                fieldelement(Date; "<ShopCalendarHoliday>".Date)
                {
                }
                fieldelement(StartingTime; "<ShopCalendarHoliday>"."Starting Time")
                {
                }
                fieldelement(EndingTime; "<ShopCalendarHoliday>"."Ending Time")
                {
                }
                fieldelement(Description; "<ShopCalendarHoliday>".Description)
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

