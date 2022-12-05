xmlport 80003 "G/L No. Series Line"
{

    schema
    {
        textelement(NoSeriesLines)
        {
            tableelement("<noseriesline>"; "No. Series Line")
            {
                XmlName = 'NoSeriesLine';
                fieldelement(SeriesCode; "<NoSeriesLine>"."Series Code")
                {
                }
                fieldelement(StartingDate; "<NoSeriesLine>"."Starting Date")
                {
                }
                fieldelement(StartingNo; "<NoSeriesLine>"."Starting No.")
                {
                }
                fieldelement(EndingNo; "<NoSeriesLine>"."Ending No.")
                {
                }
                fieldelement(WarningNo; "<NoSeriesLine>"."Warning No.")
                {
                }
                fieldelement(LineNo; "<NoSeriesLine>"."Line No.")
                {
                }
                fieldelement(IncrementbyNo; "<NoSeriesLine>"."Increment-by No.")
                {
                }
                fieldelement(Open; "<NoSeriesLine>".Open)
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

