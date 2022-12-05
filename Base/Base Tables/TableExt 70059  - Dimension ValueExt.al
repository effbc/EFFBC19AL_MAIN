tableextension 70059 DimensionValueExt extends "Dimension Value"
{
    fields
    {
        field(60010; "Division code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60011; Address1; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(60012; Address2; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }
    trigger OnBeforeInsert()
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\SITARAJYAM', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\RAMKUMARL', 'EFFTRONICS\GRAVI',
                                        'EFFTRONICS\RAJANI', 'EFFTRONICS\PURNACHAND', 'EFFTRONICS\ASWINI', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
            Error('CONTACT ERP TEAM');
    end;
}

