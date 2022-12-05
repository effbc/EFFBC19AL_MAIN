page 33000294 "Temp User List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Temp User";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("User Security ID"; Rec."User Security ID")
                {
                    ApplicationArea = All;

                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;

                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;

                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;

                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;

                }
                field("Windows Security ID"; Rec."Windows Security ID")
                {
                    ApplicationArea = All;

                }
                field("Change Password"; Rec."Change Password")
                {
                    ApplicationArea = All;

                }
                field("License Type"; Rec."License Type")
                {
                    ApplicationArea = All;

                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ApplicationArea = All;

                }
                field("Contact Email"; Rec."Contact Email")
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
                field(Levels; Rec.Levels)
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


    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}