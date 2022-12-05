page 60055 "Item Sub Sub Group"
{
    // version B2B1.0

    Editable = true;
    PageType = List;
    SourceTable = "Item Sub Sub Group";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Module; Rec.Module)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        IF USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\SUNDAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\RAMALAKSHMI'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;

    var
        FormEditable: Boolean;
}

