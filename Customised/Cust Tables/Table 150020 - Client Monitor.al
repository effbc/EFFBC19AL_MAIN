table 150020 "Client Monitor"
{
    DataClassification = CustomerContent;
    // version DEBUGW13.10.01,Rev01


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Function No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Function Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Table Name"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Search Method"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Search Result"; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Key"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Filter"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Records Read"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Record Found"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Order"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Record"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Elapsed Time (ms)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Server Time (ms)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Sum Intervals"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Records Deleted"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Disk Reads"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Disk Writes"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(21; Wait; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(22; Commit; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(24; Time; Time)
        {
            DataClassification = CustomerContent;
        }
        field(25; "SQL Statement"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(26; "SQL Status"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(27; "SQL Plan"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(28; "SQL Error"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Table Size (Current)"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Connection ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(31; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(32; Locking; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33; SumIndexFields; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Sum"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Source Object"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Source Function/Trigger"; Text[132])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Source Text"; Text[132])
        {
            DataClassification = CustomerContent;
        }
        field(38; "Source Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(39; "Problem Description"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(40; "Login Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(41; "Login Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(42; "SQL Index"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(43; "SQL Index Conflict"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50; "Blocking Checked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Check Blocking"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Cache Usage Checked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(61; "Check Cache Usage"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(101; "Good Filtered Start of Key"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(102; "Key Candidate Fields"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(105; "No. of Fil. Order By Fields"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(106; "Key Remainder"; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(107; "Check Key Usage"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(108; "Optimistic Read"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(109; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(110; "Potential Deadlocks Checked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(111; "Transactions Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(112; "Locking Rules Checked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Login Date", "Login Time", "Connection ID", "Entry No.")
        {
        }
        key(Key2; "Login Date", "Login Time", "Connection ID", "Transaction No.")
        {
        }
        key(Key3; "Login Date", "Login Time", "Connection ID", "Table Name")
        {
        }
        key(Key4; "Login Date", "Login Time", "Connection ID", "Elapsed Time (ms)")
        {
        }
        key(Key5; "Login Date", "Login Time", "Connection ID", "Source Object", "Table Name")
        {
        }
        key(Key6; Date, Time)
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
        ClientMonitor: Record "Client Monitor";
    begin
        ClientMonitor.SetConnectionFilter;
        if ClientMonitor.Find('-') then
            SetConnectionFilter
        else begin
            ClientMonitor.Reset;
            ClientMonitor.SetCurrentKey(Date, Time);
            if ClientMonitor.Find('+') then begin
                SetRange("Login Date", ClientMonitor."Login Date");
                SetRange("Login Time", ClientMonitor."Login Time");
                SetRange("Connection ID", ClientMonitor."Connection ID");
            end;
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

