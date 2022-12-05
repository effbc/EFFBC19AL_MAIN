xmlport 80112 Char
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
                fieldelement(InspectionGroupCode; Characteristic."Inspection Group Code")
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

