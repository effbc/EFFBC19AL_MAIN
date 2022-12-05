pageextension 70166 ReasonCodesExt extends "Reason Codes"
{
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */
    }

    trigger OnOpenPage()
    begin
        IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\KRISHNAD'] THEN
            EDITING := TRUE
        ELSE
            EDITING := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin

    end;

    var
        EDITING: Boolean;
}

