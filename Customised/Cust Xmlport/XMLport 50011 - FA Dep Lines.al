xmlport 50011 "FA Dep Lines"
{

    schema
    {
        textelement(FADepreciationBooks)
        {
            tableelement("<fadepreciationbook>"; "FA Depreciation Book")
            {
                XmlName = 'FADepreciationBook';
                fieldelement(FANo; "<FADepreciationBook>"."FA No.")
                {
                }
                fieldelement(DepreciationBookCode; "<FADepreciationBook>"."Depreciation Book Code")
                {
                }
                fieldelement(DepreciationMethod; "<FADepreciationBook>"."Depreciation Method")
                {
                }
                fieldelement(DepreciationStartingDate; "<FADepreciationBook>"."Depreciation Starting Date")
                {
                }
                fieldelement(DecliningBalance; "<FADepreciationBook>"."Declining-Balance %")
                {
                }
                fieldelement(FAPostingGroup; "<FADepreciationBook>"."FA Posting Group")
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

