tableextension 70156 EmployeeStatisticsGroupExt extends "Employee Statistics Group"
{
    Caption = 'Division';
    fields
    {
        modify("Code")
        {
            CaptionML = ENU = 'Division Code';
        }
        /*modify(Description)
        {
            CaptionML = ENU = 'Zone code';
            TableRelation = "Cause of Inactivity".Code;
        }*/

        field(50000; "Division Name"; Text[50])
        {
            Caption = 'Division Name';
            DataClassification = CustomerContent;
        }
        field(50001; "Project Manager"; Code[50])
        {
            TableRelation = Employee."No.";
            DataClassification = CustomerContent;
        }
        field(50002; "Stock Verified"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Cumilative Division1"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Zone Code"; Code[10])
        {
            TableRelation = "Cause of Inactivity".Code;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        /* key(Key2; "Project Manager", "Division Code", "Zone code")
        {
        } */
    }
}

