pageextension 70029 CheckCreditLimitExt extends "Check Credit Limit"
{
    layout
    {
        modify(Control2)
        {
            ShowCaption = false;
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
    }
}

