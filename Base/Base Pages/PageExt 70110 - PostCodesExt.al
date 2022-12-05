pageextension 70110 PostCodesExt extends "Post Codes"
{
    Editable = true;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addfirst(Control1)
        {
            field(State; Rec.State)
            {
                ApplicationArea = All;
            }
        }
    }
}

