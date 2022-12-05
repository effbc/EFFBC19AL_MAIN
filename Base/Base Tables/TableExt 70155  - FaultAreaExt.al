tableextension 70155 FaultAreaExt extends "Fault Area"
{

    fields
    {


    }
    trigger OnModify()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'SUPER', 'EFFTRONICS\RAMADEVI']) then
            Error('You have no Rights');
    end;

    trigger OnDelete()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'SUPER', 'EFFTRONICS\RAMADEVI']) then
            Error('You have no Rights');
    end;

}

