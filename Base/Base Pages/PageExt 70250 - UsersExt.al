pageextension 70250 UsersExt extends Users
{
    layout
    {
        modify("User Name")
        {
            StyleExpr = "Valid_color";
        }
        addafter("User Name")
        {
            /*
            field(Tams_Dept; Tams_Dept)
            {
                ApplicationArea = All;
            }
            field(Dept; Dept)
            {
                ApplicationArea = All;
            }*/
        }
        addafter("Windows Security ID")
        {
            /*
            field(levels; levels)
            {
                ApplicationArea = All;
            }*/
        }
        addafter("Authentication Email")
        {
            /*
            field(Blocked; Blocked)
            {
                ApplicationArea = All;
            }
          
            field(EmployeeID; EmployeeID)
            {
                ApplicationArea = All;
            }
            field(MailID; MailID)
            {
                ApplicationArea = All;
            }
            group(Control1102152012)
            {
                ShowCaption = false;
                grid(Control1102152010)
                {
                    ShowCaption = false;
                    group(Control1102152011)
                    {
                        ShowCaption = false;
                        field("xRec.COUNT"; xRec.COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152007)
                    {
                        ShowCaption = false;
                        field(Color_User; Color_User)
                        {
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }*/
        }
    }
    actions
    {


        modify("Action15")
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify("Permission Sets")
        {
            Promoted = true;
        }
        modify("Permission Set by User")
        {
            Promoted = true;
        }
        modify("Permission Set by User Group")
        {
            Promoted = true;
        }
        modify(AddMeAsSuper)
        {
            Promoted = true;
        }
    }




    var
        Valid_color: Text;
        EmployeeGRec: Record Employee;
        ResourceGRec: Record Resource;
        UserSetupGRec: Record "User Setup";
        Color_User: Text[100];
        User1: Record User;





    procedure Assign_color();
    begin
        /*
                EmployeeGRec.RESET;
                ResourceGRec.RESET;
                UserSetupGRec.RESET;

                IF (EmployeeGRec.GET(EmployeeID)) AND (ResourceGRec.GET(EmployeeID)) AND (UserSetupGRec.GET(Rec."User Name")) THEN
                    Valid_color := 'StrongAccent'
                ELSE
                    Valid_color := 'None';
                    */
    end;


}
