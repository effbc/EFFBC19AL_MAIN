pageextension 70328 CRMConnectionSetupExt extends "CRM Connection Setup"
{
    layout
    {
        // Add changes to page layout here
    modify("Is CRM Solution Installed")
    {
        Visible = true;
    }
    modify(NAVURL)
    {
        Visible = true;
    }
    }
    
    
    var
        myInt: Integer;
}