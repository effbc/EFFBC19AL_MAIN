tableextension 70076 ConfidentialInformationExt extends "Confidential Information"
{
    fields
    {
        modify("Employee No.")
        {
            Caption = 'Station Code';
        }
        modify("Confidential Code")
        {
            Caption = 'Division Code';
            //TableRelation=Division."Division Code";
            TableRelation = "Employee Statistics Group".Code;
        }

    }
    keys
    {


        /* key(Key1; "Station Code", "Division  Code")
        {
        } */
    }



}

