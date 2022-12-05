codeunit 60042 "Update G/L Setup_Posting_date"
{

    trigger OnRun();
    begin
        IF user_Setup.FINDSET THEN
            REPEAT
                IF user_Setup."User ID" IN ['EFFTRONICS\SUJANI'] THEN BEGIN
                    MESSAGE(user_Setup."User ID");
                    user_Setup."Allow Posting To" := CALCDATE('2D', TODAY());
                    user_Setup.MODIFY;
                    MESSAGE(FORMAT(user_Setup."Allow Posting To"));
                END;
            UNTIL user_Setup.NEXT = 0;
    end;

    var
        user_Setup: Record "User Setup";
}

