tableextension 70157 FaultCodeExt extends "Fault Code"
{

    fields
    {
        field(50000; Description1; Text[50])
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnModify()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUNDAR', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
            Error('You have no Rights');
    end;

    trigger OnDelete()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUNDAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
            Error('You have no Rights');
    end;

}

