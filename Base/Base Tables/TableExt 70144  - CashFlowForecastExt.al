tableextension 70144 CashFlowForecastExt extends "Cash Flow Forecast"
{
    fields
    {
        modify("Created By")
        {
            TableRelation = User."User Name";
        }
    }
}

