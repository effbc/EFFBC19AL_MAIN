xmlport 80607 "ITEMS WITH EXC-PPG"
{
    Format = VariableText;

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
                fieldelement(Description; Item.Description)
                {
                }

                //EFFUPG>> 
                /*
                fieldelement(ExciseProdPostingGroup; Item."Excise Prod. Posting Group")
                {
                }
                */
                //EFFUPG<<
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

