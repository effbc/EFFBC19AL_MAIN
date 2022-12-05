xmlport 80098 "Shop calender working days"
{
    Format = VariableText;

    schema
    {
        textelement(ShopCalendarWorkingDays)
        {
            tableelement("<shopcalendarworkingdays>"; "Shop Calendar Working Days")
            {
                XmlName = 'ShopCalendarWorkingDays';
                fieldelement(ShopCalendarCode; "<ShopCalendarWorkingDays>"."Shop Calendar Code")
                {
                }
                fieldelement(Day; "<ShopCalendarWorkingDays>".Day)
                {
                }
                fieldelement(WorkShiftCode; "<ShopCalendarWorkingDays>"."Work Shift Code")
                {
                }
                fieldelement(StartingTime; "<ShopCalendarWorkingDays>"."Starting Time")
                {
                }
                fieldelement(EndingTime; "<ShopCalendarWorkingDays>"."Ending Time")
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

