tableextension 70203 ResolutionCodeExt extends "Resolution Code"
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
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'SUPER', '10RD010', 'EFFTRONICS\RAMADEVI']) then
            Error('You have no Rights');
    end;

    trigger OnDelete()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SRIVALLI', 'SUPER', '10RD010']) then
            Error('You have no Rights');
    end;

}

