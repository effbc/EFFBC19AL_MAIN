table 33000266 "Assay Header"
{
    // version QC1.1

    LookupPageID = "Assay List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    QCSetup.Get;
                    NoSeriesMgt.TestManual(QCSetup."Assay Nos.");
                end;
            end;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Sampling Plan Code"; Code[20])
        {
            TableRelation = "Sampling Plan Header";
            DataClassification = CustomerContent;
        }
        field(4; "Inspection Group Code"; Code[20])
        {
            TableRelation = "Inspection Group";
            DataClassification = CustomerContent;
        }
        field(5; Status; Option)
        {
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = New,"Under Development",Certified;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Certified then begin
                    TestField(Description);
                    TestField("Sampling Plan Code");
                    TestField("Inspection Group Code");
                end;
            end;
        }
        field(6; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(10; Comment; Boolean)
        {
            CalcFormula = Exist("Quality Comment Line" WHERE(Type = CONST(Assay),
                                                              "No." = FIELD("No.")));
            FieldClass = FlowField;
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

    trigger OnDelete();
    begin
        AssayLine.SetRange("Assay No.", "No.");
        AssayLine.DeleteAll;
    end;

    trigger OnInsert();
    begin
        QCSetup.Get;
        QCSetup.TestField("Assay Nos.");
        if "No." = '' then begin
            NoSeriesMgt.InitSeries(QCSetup."Assay Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        QCSetup: Record "Quality Control Setup";
        AssayHeader: Record "Assay Header";
        NoSeriesMgt: Codeunit 396;
        AssayLine: Record "Assay Line";


    procedure AssistEdit(oldAssayNo: Record "Assay Header"): Boolean;
    begin
        AssayHeader := Rec;
        QCSetup.Get;
        QCSetup.TestField("Assay Nos.");
        if NoSeriesMgt.SelectSeries(QCSetup."Assay Nos.", oldAssayNo."No. Series", AssayHeader."No. Series") then begin
            QCSetup.Get;
            QCSetup.TestField("Assay Nos.");
            NoSeriesMgt.SetSeries(AssayHeader."No.");
            Rec := AssayHeader;
            exit(true);
        end;
    end;
}

