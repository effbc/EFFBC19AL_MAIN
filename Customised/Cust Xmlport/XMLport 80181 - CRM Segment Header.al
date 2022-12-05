xmlport 80181 "CRM Segment Header"
{
    Format = VariableText;

    schema
    {
        textelement(SegmentHeader)
        {
            tableelement("<segmentheader>"; "Segment Header")
            {
                XmlName = 'SegmentHeader';
                fieldelement(No; "<SegmentHeader>"."No.")
                {
                }
                fieldelement(Description; "<SegmentHeader>".Description)
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

