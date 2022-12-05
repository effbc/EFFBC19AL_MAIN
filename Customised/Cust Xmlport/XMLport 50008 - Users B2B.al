xmlport 50008 "Users B2B"
{
    Format = VariableText;

    schema
    {
        textelement(Users)
        {
            tableelement(User; User)
            {
                XmlName = 'User';
                fieldelement(UserSecurityID; User."User Security ID")
                {
                }
                fieldelement(UserName; User."User Name")
                {
                }
                fieldelement(FullName; User."Full Name")
                {
                }
                fieldelement(WindowsSecurityID; User."Windows Security ID")
                {
                }
                fieldelement(LicType; User."License Type")
                {
                }
                textelement(Dept)
                {
                }
                textelement(Mail)//; UserSetup.MailID)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Mail := UserSetup.MailID;
                    end;
                }
                textelement(Levels)//; UserSetup.levels)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Levels := Format(UserSetup.Levels);
                    end;
                }
                textelement(Blocked)//; UserSetup.Blocked)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Blocked := Format(UserSetup.blocked);
                    end;
                }
                textelement(Dim)// UserSetup.Dimension)
                {
                    trigger OnBeforePassVariable()
                    begin
                        dim := UserSetup.Dimension;
                    end;
                }
                trigger OnAfterGetRecord();
                var



                begin
                    UserSetup.get(user."User Name");
                end;
            }


        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        UserSetup: Record "User setup";
}

