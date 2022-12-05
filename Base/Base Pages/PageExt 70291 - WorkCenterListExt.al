pageextension 70291 WorkCenterListExt extends "Work Center List"
{
    layout
    {
        addafter(Control1)
        {
            group(Control1102152001)
            {
                ShowCaption = false;
                group(Control1102152002)
                {
                    ShowCaption = false;
                    field("xRec.COUNT"; xRec.COUNT)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }
        addafter("Global Dimension 1 Code")
        {
            field("Consolidated Calendar"; Rec."Consolidated Calendar")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}