codeunit 80010 "item tracking code validation"
{

    trigger OnRun();
    begin
        Window.OPEN('FIle Name #1#####################################\' + 'Record    #2#####################################'
                    , FileName, RecordNo);


        IF "No.Series".FINDFIRST THEN BEGIN
            FileName := 'noseriesitem track lines';
            REPEAT
                RecordNo := "No.Series"."Series Code";
                Window.UPDATE();
                "No.Series".VALIDATE("No.Series"."Series Code");
                "No.Series".VALIDATE("No.Series"."Starting No.");
                "No.Series".VALIDATE("No.Series"."Ending No.");
            UNTIL "No.Series".NEXT = 0;
        END;

        Window.CLOSE();

        MESSAGE('Done');
    end;

    var
        "No.Series": Record "No. Series Line";
        FileName: Text[30];
        Window: Dialog;
        RecordNo: Code[30];
}

