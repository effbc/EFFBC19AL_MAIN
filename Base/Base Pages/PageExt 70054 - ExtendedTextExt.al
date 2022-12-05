pageextension 70054 ExtendedTextExt extends 386
{
    layout
    {
        addafter("Finance Charge Memo")
        {
            field(Tender; Rec.Tender)
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnOpenPage()
    begin
        CurrPage.EDITABLE := TRUE;
    end;
}

