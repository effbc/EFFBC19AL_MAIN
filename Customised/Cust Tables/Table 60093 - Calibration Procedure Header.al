table 60093 "Calibration Procedure Header"
{
    // version Cal1.0

    Caption = 'Calibration Procedure Header';
    LookupPageID = "Cal Proc Header List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                if "No." <> xRec."No." then begin
                    QCSetup.Get;
                    NoSeriesMgt.TestManual(QCSetup."Calibration Procedure No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        QCSetup.Get;
        if "No." = '' then begin
            QCSetup.TestField("Calibration Procedure No.");
            NoSeriesMgt.InitSeries(QCSetup."Calibration Procedure No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        Text000: Label 'No %1 was found.';
        Text001: Label 'No %1 was found for %2 %3.';
        QCSetup: Record "Quality Control Setup";
        CalProcHeader: Record "Calibration Procedure Header";
        CalProSetup: Record "Calibration Setup";
        CalProcHeader2: Record "Calibration Procedure Header";
        NoSeriesMgt: Codeunit 396;
        Text002: Label 'Calibration Procedure not found';
        CalProc: Page "Calibration Procedure";


    procedure AssistEdit(OldCalProcHeader: Record "Calibration Procedure Header"): Boolean;
    begin
        CalProcHeader := Rec;
        QCSetup.Get;
        QCSetup.TestField("Calibration Procedure No.");
        if NoSeriesMgt.SelectSeries(QCSetup."Calibration Procedure No.", OldCalProcHeader."No. Series", CalProcHeader."No. Series") then begin
            NoSeriesMgt.SetSeries(CalProcHeader."No.");
            Rec := CalProcHeader;
            exit(true);
        end;
    end;


    procedure ShowCalProc(Calibration: Record Calibration);
    var
        CalProFound: Boolean;
    begin
        CalProSetup.Reset;
        CalProSetup.SetRange("Equipment No.", Calibration."Equipment No");
        CalProFound := CalProSetup.Find('-');

        if not CalProFound then begin
            CalProSetup.Reset;
            CalProSetup.SetRange("Equipment No.", Calibration."Equipment No");
            CalProFound := CalProSetup.Find('-');
        end;
        if CalProFound then begin
            CalProcHeader.Get(CalProSetup."Procedure No.");
            MarkCalProHeader(CalProSetup);
            CalProcHeader2.MarkedOnly(true);
            Clear(CalProc);
            CalProc.SetRecord(CalProcHeader);
            CalProc.SetTableView(CalProcHeader2);
            CalProc.Run;
            CalProcHeader2.Reset;
        end else
            Message(Text001, CalProSetup.TableCaption, Calibration.FieldCaption("Equipment No"), Calibration."Equipment No");
    end;


    procedure MarkCalProHeader(CalProSetup2: Record "Calibration Setup");
    begin
        CalProSetup2.Find('-');
        repeat
            CalProcHeader2.Get(CalProSetup2."Procedure No.");
            CalProcHeader2.Mark(true);
        until CalProSetup2.Next = 0;
    end;


    procedure ShowCalProcForIDs(IDS: Record "Inspection Datasheet Header");
    var
        CalProFound: Boolean;
    begin
        CalProSetup.Reset;
        CalProSetup.SetRange("Equipment No.", IDS."Item No.");
        CalProFound := CalProSetup.Find('-');

        if not CalProFound then begin
            CalProSetup.Reset;
            CalProSetup.SetRange("Equipment No.", IDS."Item No.");
            CalProFound := CalProSetup.Find('-');
        end;
        if CalProFound then begin
            CalProcHeader.Get(CalProSetup."Procedure No.");
            MarkCalProHeader(CalProSetup);
            CalProcHeader2.MarkedOnly(true);
            Clear(CalProc);
            CalProc.SetRecord(CalProcHeader);
            CalProc.SetTableView(CalProcHeader2);
            CalProc.Run;
            CalProcHeader2.Reset;
        end else
            Message(Text002);
    end;
}

