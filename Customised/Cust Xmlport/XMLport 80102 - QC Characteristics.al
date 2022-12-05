xmlport 80102 "QC Characteristics"
{
    Format = VariableText;

    schema
    {
        textelement(Characteristics)
        {
            tableelement(Characteristic; Characteristic)
            {
                XmlName = 'Characteristic';
                fieldelement(Code; Characteristic.Code)
                {
                }
                fieldelement(Description; Characteristic.Description)
                {
                }
                fieldelement(Qualitative; Characteristic.Qualitative)
                {
                }
                fieldelement(UnitOfMeasureCode; Characteristic."Unit Of Measure Code")
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

