codeunit 80054 "Gen Journal validate"
{

    trigger OnRun();
    begin
        Window.OPEN('#1###############');
        NGJL.FINDFIRST;
        REPEAT
            Window.UPDATE(1, NGJL."Line No.");
            GJL.INIT;
            GJL.VALIDATE(GJL."Journal Template Name", NGJL."Journal Template Name");
            GJL.VALIDATE(GJL."Journal Batch Name", NGJL."Journal Batch Name");
            GJL.VALIDATE(GJL."Line No.", NGJL."Line No.");
            GJL.VALIDATE(GJL."Account Type", NGJL."Account Type");
            IF NGJL."Account Type" = NGJL."Account Type"::"G/L Account" THEN
                GJL.VALIDATE(GJL."Account No.", NGJL."Account No.")
            ELSE
                GJL.VALIDATE(GJL."Account No.", NGJL."Account No.");
            GJL.VALIDATE(GJL."Posting Date", WORKDATE);
            GJL.VALIDATE(GJL."Document No.", 'OBGL-05-00001');
            GJL.VALIDATE(GJL.Amount, NGJL.Amount);
            GJL.VALIDATE(GJL."Document Date", NGJL."Document Date");
            GJL.VALIDATE(GJL."External Document No.", NGJL."External Document No.");
            GJL.VALIDATE(GJL."FA Posting Date", NGJL."FA Posting Date");
            GJL.VALIDATE(GJL."FA Posting Type", NGJL."FA Posting Type");
            GJL.INSERT;
        UNTIL NGJL.NEXT = 0;
    end;

    var
        GJL: Record "Gen. Journal Line";
        NGJL: Record "Gen. Journal Line2";
        Window: Dialog;
}

