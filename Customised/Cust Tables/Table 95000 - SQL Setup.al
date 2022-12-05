table 95000 "SQL Setup"
{
    DataClassification = CustomerContent;
    // version SessionKiller 1.0/Tarek Demiati

    // ______________________________________________________________________________________________________________________________
    // 
    //                            SESSION KILLER V1.0 - FREEWARE - Developed by Tarek Demiati -
    // 
    //                            Last Revision : 07th July 2000 - TD
    // 
    // Please Note that Session Killer only works on Microsoft SQL Databases
    // 
    // I'm always looking for good Navision Financials tools and mainly if they're free!
    // I'm contactable under tarek_demiati@ureach.com
    // ______________________________________________________________________________________________________________________________


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(2; "SQL Server Name"; Text[100])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                /*
                CLEAR(recServer);
                //CLEAR(frmServerName);
                //frmServerName.LOOKUPMODE(TRUE);
                frmServerName.SETTABLEVIEW(recServer);
                LookupAction := frmServerName.RUNMODAL;
                frmServerName.GETRECORD(recServer);
                IF LookupAction = ACTION::LookupOK THEN
                  "SQL Server Name" := recServer."Server Name";
                */

            end;
        }
        field(3; "SQL Server Login"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; "SQL Server Password"; Text[100])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Encrypt password
                // Use encrytion method from the User table here
            end;
        }
        field(5; "SQL Server Database Name"; Text[128])
        {
            CalcFormula = Lookup(Session."Database Name" WHERE("My Session" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        // recServer: Record Server;
        LookupAction: Action;
}

