xmlport 80103 "QC Quality Reason Codes"
{
    Format = VariableText;

    schema
    {
        textelement(QualityReasonCodes)
        {
            tableelement("<qualityreasoncode>"; "Quality Reason Code")
            {
                XmlName = 'QualityReasonCode';
                fieldelement(Code; "<QualityReasonCode>".Code)
                {
                }
                fieldelement(Description; "<QualityReasonCode>".Description)
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

