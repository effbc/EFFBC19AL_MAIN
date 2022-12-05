xmlport 50073 "Purchase Data"
{
    Format = VariableText;

    schema
    {
        textelement(DAYWISEDETAILS)
        {
            tableelement("DAY WISE DETAILS"; "DAY WISE DETAILS")
            {
                XmlName = 'DAYWISEDETAIL';
                fieldelement(POSTINGDATE; "DAY WISE DETAILS"."POSTING DATE")
                {
                }
                fieldelement(STRSTOCKVALUE; "DAY WISE DETAILS"."STR STOCK VALUE")
                {
                }
                fieldelement(RDSTRSTOCKVALUE; "DAY WISE DETAILS"."R&D STR STOCK VALUE")
                {
                }
                fieldelement(CSSTRSTOCKVALUE; "DAY WISE DETAILS"."CS STR STOCK VALUE")
                {
                }
                fieldelement(STRDAMAGEVALUE; "DAY WISE DETAILS"."STR_DAMAGE VALUE")
                {
                }
                fieldelement(RDDAMAGEVALUE; "DAY WISE DETAILS"."R&D DAMAGE VALUE")
                {
                }
                fieldelement(CSDAMAGEVALUE; "DAY WISE DETAILS"."CS DAMAGE VALUE")
                {
                }
                fieldelement(BMUSTOCK; "DAY WISE DETAILS"."BMU STOCK")
                {
                }
                fieldelement(DLSTOCK; "DAY WISE DETAILS"."DL STOCK")
                {
                }
                fieldelement(EPSTOCK; "DAY WISE DETAILS"."EP STOCK")
                {
                }
                fieldelement(IPISSTOCK; "DAY WISE DETAILS"."IPIS STOCK")
                {
                }
                fieldelement(RTUSTOCK; "DAY WISE DETAILS"."RTU STOCK")
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

