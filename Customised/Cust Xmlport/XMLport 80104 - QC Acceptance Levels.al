xmlport 80104 "QC Acceptance Levels"
{
    Format = VariableText;

    schema
    {
        textelement(AcceptanceLevels)
        {
            tableelement("<acceptancelevel>"; "Acceptance Level")
            {
                XmlName = 'AcceptanceLevel';
                fieldelement(Code; "<AcceptanceLevel>".Code)
                {
                }
                fieldelement(Description; "<AcceptanceLevel>".Description)
                {
                }
                fieldelement(ReasonCode; "<AcceptanceLevel>"."Reason Code")
                {
                }
                fieldelement(VendorRating; "<AcceptanceLevel>"."Vendor Rating")
                {
                }
                fieldelement(Type; "<AcceptanceLevel>".Type)
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

