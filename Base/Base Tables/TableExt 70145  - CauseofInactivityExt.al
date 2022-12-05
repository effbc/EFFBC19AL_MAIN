tableextension 70145 CauseofInactivityExt extends "Cause of Inactivity"
{
    Caption = 'Zones';
    fields
    {
        modify("Code")
        {
            Caption = 'Zone Code';
        }
        modify(Description)
        {
            Caption = 'Zone Name';
        }
    }
    keys
    {

        /* key(Key1; "Zone Code")
        {
        } */
    }
}

