tableextension 70017 CompanyInformationExt extends "Company Information"
{


    fields
    {


        field(50001; "C.S.T.Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Insurance Policy No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Insurance Policy Name"; Text[150])
        {
            DataClassification = CustomerContent;
        }
        field(60002; "C.S.T No.1"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }
}

