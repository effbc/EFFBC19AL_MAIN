table 150022 "Code Coverage Line"
{
    DataClassification = CustomerContent;
    // version DEBUGW13.10.01,Rev01


    fields
    {
        field(1; "Object Type"; Option)
        {
            OptionMembers = " ","Table",Form,"Report",Dataport,"Codeunit";
            DataClassification = CustomerContent;
        }
        field(2; "Object ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Line Type"; Option)
        {
            OptionMembers = "Object","Function/Trigger",Empty,"Code";
            DataClassification = CustomerContent;
        }
        field(5; Line; Text[131])
        {
            DataClassification = CustomerContent;
        }
        field(6; "No. of Hits"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50000; "In Use"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Function In Use"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Object In Use"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Object Name"; Text[30])
        {
            CalcFormula = Lookup(AllObj."Object Name" WHERE("Object Type" = FIELD("Object Type"),
                                                             "Object ID" = FIELD("Object ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Function/Trigger Name"; Text[131])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Connection ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50031; "User ID"; Code[50])
        {
            Description = 'Rev01';
            // TableRelation = Table2000000002;
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
            DataClassification = CustomerContent;

        }
        field(50040; "Login Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50041; "Login Time"; Time)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Login Date", "Login Time", "Connection ID", "Object Type", "Object ID", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Session1: Record Session;


    procedure SetConditionalConnectionFilter();
    var
        CodeCoverage: Record "Code Coverage Line";
    begin
        CodeCoverage.SetConnectionFilter;
        if CodeCoverage.Find('-') then
            SetConnectionFilter
        else
            if CodeCoverage.Find('+') then begin
                SetRange("Login Date", CodeCoverage."Login Date");
                SetRange("Login Time", CodeCoverage."Login Time");
                SetRange("Connection ID", CodeCoverage."Connection ID");
            end;
    end;


    procedure SetConnectionFilter();
    var
        ClientMonitor2: Record "Client Monitor";
    begin
        //Changed Var(Session to Session1) as it was defined more than once)
        //B2B

        if Session1."Connection ID" = 0 then begin
            Session1.SetRange("My Session", true);
            Session1.Find('-');
        end;
        SetRange("Login Date", Session1."Login Date");
        SetRange("Login Time", 000000T + Round(Session1."Login Time" - 000000T, 1000));
        SetRange("Connection ID", Session1."Connection ID");
    end;
}

