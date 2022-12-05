pageextension 70249 UserSetupExt extends "User Setup"
{
    Editable = false;
    layout
    {
        /* modify(Control1)
        {
            ShowCaption = false;
        } */

        addafter("User ID")
        {
            field("Transfer- From Code"; Rec."Transfer- From Code")
            {
                ApplicationArea = All;
            }
            field("Transfer- To Code"; Rec."Transfer- To Code")
            {
                ApplicationArea = All;
            }
            field("Production Order"; Rec."Production Order")
            {
                ApplicationArea = All;
            }
            field(Dept; Rec.Dept)
            {
                ApplicationArea = All;
            }
            field(MailID; Rec.MailID)
            {
                ApplicationArea = All;
            }
            field(levels; Rec.levels)
            {
                ApplicationArea = All;
            }
            field(Blocked; Rec.Blocked)
            {
                ApplicationArea = All;
            }
            field(Dimension; Rec.Dimension)
            {
                ApplicationArea = All;
            }
            field(EmployeeID; Rec.EmployeeID)
            {
                ApplicationArea = All;
            }
            field(Tams_Dept; Rec.Tams_Dept)
            {
                ApplicationArea = All;
            }
        }
    }
}

