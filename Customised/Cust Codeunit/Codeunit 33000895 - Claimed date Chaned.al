codeunit 33000895 "Claimed date Chaned"
{

    trigger OnRun();
    begin
        //XMLPORT.RUN (50080, FALSE, TRUE,PIH);
        //MESSAGE('Updated');
        IF USERID IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA'] THEN
            XMLPORT.RUN(50080, FALSE, TRUE)
        ELSE
            ERROR('You does not have the rights to open');
    end;

    var
        PIH: Record "Purch. Inv. Header";
}

