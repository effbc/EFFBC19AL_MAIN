tableextension 70225 TroubleshootingHeaderExt extends "Troubleshooting Header"
{

    fields
    {


    }


    trigger OnBeforeInsert()
    begin
        /* IF USERID <> 'EFFTRONICS\RAMADEVI' THEN
            ERROR('YOU HAVE NO PERMISSIONS'); */
    end;

    trigger OnModify()
    begin
        /* IF USERID <> 'EFFTRONICS\RAMADEVI' THEN
            ERROR('YOU HAVE NO PERMISSIONS'); */
    end;

    trigger OnDelete()
    begin
        /* IF USERID<>'EFFTRONICS\RAMADEVI' THEN
                    ERROR('YOU HAVE NO PERMISSIONS'); */
    end;

}

