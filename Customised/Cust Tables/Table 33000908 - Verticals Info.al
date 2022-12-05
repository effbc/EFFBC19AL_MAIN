table 33000908 "Verticals Info"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Product; Code[20])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = CONST('FPRODUCT'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ISG.RESET;
                ISG.SETFILTER(ISG.Code, Product);
                IF ISG.FINDFIRST THEN BEGIN
                    "Project Name" := ISG.Description;
                END;
            end;
        }
        field(2; "Project Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Vertical Head"; Code[50])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                UserGRec.RESET;
                UserGRec.SETRANGE(levels, TRUE);
                IF PAGE.RUNMODAL(9800, UserGRec) = ACTION::LookupOK THEN
                    "Vertical Head" := UserGRec.EmployeeID;
            end;

            trigger OnValidate();
            begin
                UserGRec.RESET;
                UserGRec.SETFILTER(UserGRec.EmployeeID, "Vertical Head");
                IF UserGRec.FINDFIRST THEN BEGIN
                    "Vertical Head E_mail" := UserGRec.MailID;
                END;
            end;
        }
        field(4; "Project Manager"; Code[10])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                UserGRec.RESET;
                UserGRec.SETRANGE(levels, TRUE);
                IF PAGE.RUNMODAL(9800, UserGRec) = ACTION::LookupOK THEN
                    "Project Manager" := UserGRec.EmployeeID;
            end;

            trigger OnValidate();
            begin
                UserGRec.RESET;
                UserGRec.SETFILTER(UserGRec.EmployeeID, "Project Manager");
                IF UserGRec.FINDFIRST THEN BEGIN
                    "PM E_mail" := UserGRec.MailID;
                END;
            end;
        }
        field(5; "Asst. Project Manger"; Code[10])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                UserGRec.RESET;
                UserGRec.SETRANGE(levels, TRUE);
                IF PAGE.RUNMODAL(9800, UserGRec) = ACTION::LookupOK THEN
                    "Asst. Project Manger" := UserGRec.EmployeeID;
            end;

            trigger OnValidate();
            begin
                UserGRec.RESET;
                UserGRec.SETFILTER(UserGRec.EmployeeID, "Asst. Project Manger");
                IF UserGRec.FINDFIRST THEN BEGIN
                    "APM E_mail" := UserGRec.MailID;
                END;
            end;
        }
        field(6; "Vertical Head E_mail"; Text[40])
        {
            DataClassification = CustomerContent;
        }
        field(7; "PM E_mail"; Text[40])
        {
            DataClassification = CustomerContent;
        }
        field(8; "APM E_mail"; Text[40])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Tams Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(10; Veritical; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Product)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ISG: Record "Item Sub Group";
        UserGRec: Record "User Setup";
}

