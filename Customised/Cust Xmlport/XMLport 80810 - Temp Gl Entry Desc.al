xmlport 80810 "Temp Gl Entry Desc"
{
    Format = VariableText;

    schema
    {
        textelement(TempGLEntryDesc)
        {
            tableelement("<tempglentrydesc>"; "Temp GL Entry Desc")
            {
                XmlName = 'TempGLEntryDesc';
                fieldelement(EntryNo; "<TempGLEntryDesc>"."Entry No.")
                {
                }
                fieldelement(Description; "<TempGLEntryDesc>".Description)
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

