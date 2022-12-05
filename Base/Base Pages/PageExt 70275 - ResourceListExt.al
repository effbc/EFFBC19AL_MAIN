pageextension 70275 ResourceListExt extends "Resource List"
{
    layout
    {
        addbefore("No.")
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Strong;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
        addafter("Base Unit of Measure")
        {
            field(Department; Rec.Department)
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