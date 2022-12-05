tableextension 70226 TroubleshootingLineExt extends "Troubleshooting Line"
{

    trigger OnInsert()
    begin
        if UserId <> 'EFFTRONICS\RAMADEVI' then
            Error('YOU HAVE NO PERMISSIONS');
    end;

    trigger OnModify()
    begin
        if UserId <> 'EFFTRONICS\RAMADEVI' then
            Error('YOU HAVE NO PERMISSIONS');
    end;

    trigger OnDelete()
    begin
        if UserId <> 'EFFTRONICS\RAMADEVI' then
            Error('YOU HAVE NO PERMISSIONS');
    end;
}

