table 33000912 "Issue Track Header"
{
    DataClassification = CustomerContent;
    // version TRACK

    // 
    // 
    // {
    // CALCFIELDS("EFF. Attachment");
    // IF "EFF. Attachment" THEN
    //  ERROR('Attachment already exists, remove the attachment and delete the issue');
    // }


    fields
    {
        field(1; "Issue Id"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Issue Logged By"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if UserId in ['EFFTRONICS\SUNDAR', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] then begin
                    UserGRec.Reset;
                    if PAGE.RunModal(0, UserGRec) = ACTION::LookupOK then
                        "Issue Logged By" := UserGRec."User ID";
                end;
            end;
        }
        field(3; "Issued Logged Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //IF NOT (Status = Status::" ") THEN
                TeststatusOpen;
            end;
        }
        field(5; "Handled By"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Handled Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = '" ,Open,Released,closed,Compeleted"';
            OptionMembers = " ",Open,Released,closed,Compeleted;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*IF Status=Status::Completed then
                BEGIN

                END;
                 */

            end;
        }
        field(8; "EFF. Attachment"; Boolean)
        {
            CalcFormula = Exist(Attachments WHERE("Table ID" = CONST(33000912),
                                                   "Document Type" = CONST(Quote),
                                                   "Document No." = FIELD("Issue Id"),
                                                   "Attachment Status" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Reason for Reopen"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(11; Project; Option)
        {
            OptionCaption = ',ERP,Costing,CashFlow,OMS,PRM,Store Led';
            OptionMembers = ,ERP,Costing,CashFlow,OMS,PRM,"Store Led";
            DataClassification = CustomerContent;
        }
        field(12; "Completion Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; Dept; Code[10])
        {
            //TableRelation = UserGRec.Field60100 WHERE("User Name" = FIELD("Issue Logged By"));
            TableRelation = "User Setup".Dept WHERE("User ID" = FIELD("Issue Logged By"));
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Issue Id")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if (UserId <> "Issue Logged By") then begin
            if not IsAdministrator then
                Error('Only %1 can delete the Issue', "Issue Logged By");
        end;
        if (Status <> Status::Open) then
            Error('Issue can not be deleted. Issue has been already %1', Status);

        CalcFields("EFF. Attachment");
        if "EFF. Attachment" then
            Error('Attachment already exists, remove the attachment and delete the issue');



        IssueTrackerLine.Reset;
        IssueTrackerLine.SetRange(IssueTrackerLine."Issue Id", "Issue Id");
        IssueTrackerLine.DeleteAll;
    end;

    trigger OnInsert();
    begin
        IssueTrackHeader.Reset;
        if IssueTrackHeader.FindLast then begin
            "Issue Id" := IncStr(IssueTrackHeader."Issue Id");
        end else
            "Issue Id" := '000001';

        "Issued Logged Date" := Today;
        if UserId <> 'EFFTRONICS\SUNDAR' then
            "Issue Logged By" := UserId;
        Status := Status::Open;
    end;

    var
        IssueTrackerLine: Record "Issue Tracker Line";
        IssueTrackHeader: Record "Issue Track Header";
        Attachment: Record Attachments;
        Text001: Label 'Do you want to release the issue?';
        Text002: Label 'Do you want to change the status to completed?';
        Text003: Label 'Do you want to close the issue?';
        Text004: Label 'Do you want to re-open the issue?';
        Text005: Label 'Status must be %1.';
        Text006: Label '%1 can only %2 the issue.';
        Text007: Label 'Issue is already open.';
        Text008: Label 'Please enter the Reason for Re-Open.';
        UserGRec: Record "User Setup";


    procedure TeststatusOpen();
    begin
        TestField(Status, Status::Open);
    end;


    procedure IsAdministrator(): Boolean;
    var
        IssueAdminGRec: Record "Issue Tracker Administrators";
    begin
        IssueAdminGRec.Reset;
        IssueAdminGRec.SetRange("User Name", UserId);
        if IssueAdminGRec.FindFirst then
            exit(true)
        else
            exit(false);
    end;


    procedure ReleaseIssue();
    var
        IssueTrackLRec: Record "Issue Track Header";
    begin
        if not Confirm(Text001) then
            exit;
        IssueTrackLRec.Reset;
        IssueTrackLRec.SetRange("Issue Id", "Issue Id");
        if IssueTrackLRec.FindFirst then begin
            if IssueTrackLRec.Status = IssueTrackLRec.Status::Open then begin
                IssueTrackLRec.Status := IssueTrackLRec.Status::Released;
                IssueTrackLRec.Modify;
            end else
                Error(Text005, 'Open');
        end;
    end;


    procedure CompleteIssue();
    var
        IssueTrackLRec: Record "Issue Track Header";
    begin
        if not Confirm(Text002) then
            exit;
        IssueTrackLRec.Reset;
        IssueTrackLRec.SetRange("Issue Id", "Issue Id");
        if IssueTrackLRec.FindFirst then begin
            if IssueTrackLRec.Status = IssueTrackLRec.Status::Released then begin
                IssueTrackLRec.Status := IssueTrackLRec.Status::Compeleted;
                IssueTrackLRec."Completion Date" := Today;
                IssueTrackLRec.Modify;
            end else
                Error(Text005, 'Released');
        end;
    end;


    procedure CloseIssue();
    var
        IssueTrackLRec: Record "Issue Track Header";
    begin
        if not Confirm(Text003) then
            exit;

        IssueTrackLRec.Reset;
        IssueTrackLRec.SetRange("Issue Id", "Issue Id");
        if IssueTrackLRec.FindFirst then begin
            if UserId <> IssueTrackLRec."Issue Logged By" then
                Error(Text006, IssueTrackLRec."Issue Logged By", 'Close');
            if IssueTrackLRec.Status = IssueTrackLRec.Status::Compeleted then begin
                IssueTrackLRec.Status := IssueTrackLRec.Status::closed;
                IssueTrackLRec.Modify;
            end else
                Error(Text005, 'Completed');
        end;
    end;


    procedure ReOpenIssue();
    var
        IssueTrackLRec: Record "Issue Track Header";
    begin
        if not Confirm(Text004) then
            exit;

        IssueTrackLRec.Reset;
        IssueTrackLRec.SetRange("Issue Id", "Issue Id");
        if IssueTrackLRec.FindFirst then begin
            if UserId <> IssueTrackLRec."Issue Logged By" then
                Error(Text006, IssueTrackLRec."Issue Logged By", 'Re-Open');
            if IssueTrackLRec.Status <> IssueTrackLRec.Status::Open then begin
                if IssueTrackLRec."Reason for Reopen" = '' then
                    Error(Text008);
                IssueTrackLRec.Status := IssueTrackLRec.Status::Open;
                IssueTrackLRec.Modify;
            end else
                Error(Text007);
        end;
    end;
}

