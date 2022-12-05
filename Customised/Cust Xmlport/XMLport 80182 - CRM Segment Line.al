xmlport 80182 "CRM Segment Line"
{
    Format = VariableText;

    schema
    {
        textelement(SegmentLines)
        {
            tableelement("<segmentline>"; "Segment Line")
            {
                XmlName = 'SegmentLine';
                fieldelement(SegmentNo; "<SegmentLine>"."Segment No.")
                {
                }
                fieldelement(LineNo; "<SegmentLine>"."Line No.")
                {
                }
                fieldelement(ContactNo; "<SegmentLine>"."Contact No.")
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

