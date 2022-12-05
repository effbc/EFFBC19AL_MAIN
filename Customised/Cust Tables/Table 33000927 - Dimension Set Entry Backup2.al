table 33000927 "Dimension Set Entry Backup2"
{
    // version NAVW17.00

    CaptionML = ENU = 'Dimension Set Entry Backup',
                ENN = 'Dimension Set Entry';
    DrillDownPageID = "dimension set entry page old";
    LookupPageID = "dimension set entry page old";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        ENN = 'Dimension Set ID';
            DataClassification = CustomerContent;
        }
        field(2; "Dimension Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension Code',
                        ENN = 'Dimension Code';
            NotBlank = true;
            TableRelation = Dimension;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not DimMgt.CheckDim("Dimension Code") then
                    Error(DimMgt.GetDimErr);
                if "Dimension Code" <> xRec."Dimension Code" then begin
                    "Dimension Value Code" := '';
                    "Dimension Value ID" := 0;
                end;
            end;
        }
        field(3; "Dimension Value Code"; Code[20])
        {
            CaptionML = ENU = 'Dimension Value Code',
                        ENN = 'Dimension Value Code';
            NotBlank = true;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") then
                    Error(DimMgt.GetDimErr);

                DimVal.Get("Dimension Code", "Dimension Value Code");
                "Dimension Value ID" := DimVal."Dimension Value ID";
            end;
        }
        field(4; "Dimension Value ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Value ID',
                        ENN = 'Dimension Value ID';
            DataClassification = CustomerContent;
        }
        field(5; "Dimension Name"; Text[30])
        {
            CalcFormula = Lookup(Dimension.Name WHERE(Code = FIELD("Dimension Code")));
            CaptionML = ENU = 'Dimension Name',
                        ENN = 'Dimension Name';
            Editable = true;
            FieldClass = FlowField;
        }
        field(6; "Dimension Value Name"; Text[50])
        {
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                               Code = FIELD("Dimension Value Code")));
            CaptionML = ENU = 'Dimension Value Name',
                        ENN = 'Dimension Value Name';
            Editable = true;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Dimension Set ID", "Dimension Code")
        {
        }
        key(Key2; "Dimension Value ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if DimVal.Get("Dimension Code", "Dimension Value Code") then
            "Dimension Value ID" := DimVal."Dimension Value ID"
        else
            "Dimension Value ID" := 0;
    end;

    trigger OnModify();
    begin
        if DimVal.Get("Dimension Code", "Dimension Value Code") then
            "Dimension Value ID" := DimVal."Dimension Value ID"
        else
            "Dimension Value ID" := 0;
        /*OldDim.RESET;
        OldDim.SETFILTER(OldDim."Dimension Code","Dimension Code");
        OldDim.SETFILTER(OldDim.Code,"Dimension Value Code");
        IF OldDim.FINDFIRST THEN
          OldDimValName := OldDim.Name;
        NewDim.RESET;
        NewDim.SETFILTER(NewDim."Dimension Code","Dimension Code");
        NewDim.SETFILTER(NewDim.Code,"Dimension Value Code");
        IF NewDim.FINDFIRST THEN
          NewDimValName := NewDim.Name;
        NewDim.RESET;
        Mail_From:='noreply@efftronics.com';
        Mail_To:='erp@efftronics.com';
        Subject:='ERP-Dimension Set Entry Changes';
        Body:='<html><BODY><h3><center>Dimension Set Entry Changes Details!<BR>';
        Body+= '</center></h3>';
        Body+='<br><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body+='border="1" align="Center">';
        Body+='<tr><td align="center">Field</td><td align="center">New Value</td><td align="center">Old Value</td></tr>';
        Body+='<tr><td>Dimension  Set ID</td><td align="right">'+FORMAT("Dimension Set ID")+'</td><td align="right">'+FORMAT(xRec."Dimension Set ID")+'</td></tr>';
        Body+='<tr><td>Dimension Code</td><td align="right">'+"Dimension Code"+'</td><td align="right">'+xRec."Dimension Code"+'</td></tr>';
        Body+='<tr><td>Dimension Value Code</td><td align="right">'+"Dimension Value Code"+'</td><td align="right">'+xRec."Dimension Value Code"+'</td></tr>';
        Body+='<tr><td>Dimension Value Id</td><td align="right">'+FORMAT("Dimension Value ID")+'</td><td align="right">'+FORMAT(xRec."Dimension Value ID")+'</td></tr>';
        Body+='<tr><td>Dimension Name</td><td align="right">'+"Dimension Name"+'</td><td align="right">'+xRec."Dimension Name"+'</td></tr>';
        Body+='<tr><td>Dimension Value Name</td><td align="right">'+OldDimValName+'</td><td align="right">'+NewDimValName+'</td></tr>';
        Body+='<tr><td>User ID</td><td colspan=2; align="right">'+USERID+'</td></tr></table><br>';
        Body+='<br><p><center>            ****  Automatic Mail Generated From ERP  ****       </center></p></BODY></html>';
        SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
        IF "Dimension Set ID" <> 0 THEN
          SMTP_MAIL.Send;*/// commented by SUJANI on 091018

    end;

    trigger OnRename();
    begin
        if not (UserId in ['EFFTRONICS\SUJANI'])

        then
            Error('You Donot have Right to Rename ' + Format("Dimension Set ID"));
    end;

    var
        DimVal: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        // Mail: Codeunit Mail;
        // SMTP_MAIL: Codeunit "SMTP Mail";
        OldDim: Record "Dimension Value";
        NewDim: Record "Dimension Value";
        OldDimValName: Text;
        NewDimValName: Text;


    procedure GetDimensionSetID(var DimSetEntry: Record "Dimension Set Entry"): Integer;
    var
        DimSetEntry2: Record "Dimension Set Entry";
        DimSetTreeNode: Record "Dimension Set Tree Node";
        Found: Boolean;
    begin
        DimSetEntry2.Copy(DimSetEntry);
        if DimSetEntry."Dimension Set ID" > 0 then
            DimSetEntry.SetRange("Dimension Set ID", DimSetEntry."Dimension Set ID");

        DimSetEntry.SetCurrentKey("Dimension Value ID");
        DimSetEntry.SetFilter("Dimension Code", '<>%1', '');
        DimSetEntry.SetFilter("Dimension Value Code", '<>%1', '');

        if not DimSetEntry.FindSet then
            exit(0);

        Found := true;
        DimSetTreeNode."Dimension Set ID" := 0;
        repeat
            DimSetEntry.TestField("Dimension Value ID");
            if Found then
                if not DimSetTreeNode.Get(DimSetTreeNode."Dimension Set ID", DimSetEntry."Dimension Value ID") then begin
                    Found := false;
                    DimSetTreeNode.LockTable;
                end;
            if not Found then begin
                DimSetTreeNode."Parent Dimension Set ID" := DimSetTreeNode."Dimension Set ID";
                DimSetTreeNode."Dimension Value ID" := DimSetEntry."Dimension Value ID";
                DimSetTreeNode."Dimension Set ID" := 0;
                DimSetTreeNode."In Use" := false;
                if not DimSetTreeNode.Insert(true) then
                    DimSetTreeNode.Get(DimSetTreeNode."Parent Dimension Set ID", DimSetTreeNode."Dimension Value ID");
            end;
        until DimSetEntry.Next = 0;
        if not DimSetTreeNode."In Use" then begin
            if Found then begin
                DimSetTreeNode.LockTable;
                DimSetTreeNode.Get(DimSetTreeNode."Parent Dimension Set ID", DimSetTreeNode."Dimension Value ID");
            end;
            DimSetTreeNode."In Use" := true;
            DimSetTreeNode.Modify;
            InsertDimSetEntries(DimSetEntry, DimSetTreeNode."Dimension Set ID");
        end;

        DimSetEntry.Copy(DimSetEntry2);

        exit(DimSetTreeNode."Dimension Set ID");
    end;


    local procedure InsertDimSetEntries(var DimSetEntry: Record "Dimension Set Entry"; NewID: Integer);
    var
        DimSetEntry2: Record "Dimension Set Entry";
    begin
        DimSetEntry2.LockTable;
        if DimSetEntry.FindSet then
            repeat
                DimSetEntry2 := DimSetEntry;
                DimSetEntry2."Dimension Set ID" := NewID;
                DimSetEntry2.Insert;
            until DimSetEntry.Next = 0;
    end;
}

