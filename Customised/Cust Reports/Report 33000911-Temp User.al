report 33000911 "Temp user"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;


    dataset
    {
        dataitem("User Setup"; "User Setup")
        {

            trigger OnAfterGetRecord()
            var

            begin
                TempUser.Reset;

                TempUser.SetRange("User Name", "User Setup"."User ID");
                if TempUser.Findfirst then begin
                    "User Setup".Dept := TempUser.Dept;
                    "User Setup".MailID := TempUser.MailID;
                    "User Setup".levels := TempUser.Levels;
                    "User Setup".Blocked := TempUser.Blocked;
                    "User Setup".Dimension := TempUser.Dimension;
                    "User Setup".EmployeeID := TempUser.EmployeeID;
                    "User Setup".Tams_Dept := TempUser.Tams_Dept;
                    "User Setup".Modify();
                end;


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }


    }

    trigger OnPostReport()
    var

    begin

        Message('Done');

    end;

    var

        TempUser: Record 33000933;

}
