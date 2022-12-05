pageextension 70138 PurchCommentSheetExt extends 66
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
        addafter(Code)
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
        }
    }
}

