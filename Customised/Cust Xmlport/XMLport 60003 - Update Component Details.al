xmlport 60003 "Update Component Details"
{

    schema
    {
        textelement(Items)
        {
            tableelement(Item; Item)
            {
                XmlName = 'Item';
                fieldelement(No; Item."No.")
                {
                }
                fieldelement(Make; Item.Make)
                {
                }
                fieldelement(PartNumber; Item."Part Number")
                {
                }
                fieldelement(Package; Item.Package)
                {
                }
                fieldelement(OperatingTemperature; Item."Operating Temperature")
                {
                }
                fieldelement(StorageTemperature; Item."Storage Temperature")
                {
                }
                fieldelement(Humidity; Item.Humidity)
                {
                }
                fieldelement(ESDSensitive; Item."ESD Sensitive")
                {
                }
                fieldelement(ESD; Item.ESD)
                {
                }
                fieldelement(WorkareaTempHumadity; Item."Work area Temp &  Humadity")
                {
                }
                fieldelement(SolderingTemp; Item."Soldering Temp.")
                {
                }
                fieldelement(SolderingTimeSec; Item."Soldering Time (Sec)")
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

