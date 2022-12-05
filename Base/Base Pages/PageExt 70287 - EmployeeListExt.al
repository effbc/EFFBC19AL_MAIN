pageextension 70287 EmployeeListExt extends "Employee List"
{
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;

            }
        }
        addafter("Statistics Group Code")
        {
            field("Inactive Date"; Rec."Inactive Date")
            {
                ApplicationArea = All;

            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    VAR
        USER: Record User;
}