table 33000253 "Specification Header"
{
    // version QC1.1

    DataCaptionFields = "Spec ID", Description;
    DrillDownPageID = "Specification List";
    LookupPageID = "Specification List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Spec ID"; Code[20])
        {
            NotBlank = false;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Attachment; BLOB)
        {
            DataClassification = CustomerContent;
        }
        field(5; "File Extension"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Comment; Boolean)
        {
            CalcFormula = Exist("Quality Comment Line" WHERE(Type = CONST(Specification),
                                                              "No." = FIELD("Spec ID")));
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'New,Under Development,Certified';
            OptionMembers = New,"Under Development",Certified;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Status = Status::Certified then
                    TestStatus;
            end;
        }
        field(8; "Sampling Plan"; Code[20])
        {
            TableRelation = "Sampling Plan Header";
            DataClassification = CustomerContent;
        }
        field(50; "Version Nos."; Code[10])
        {
            Caption = 'Version Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60001; "Inspection Time(In Hours)"; Decimal)
        {
            CalcFormula = Sum("Specification Line"."Inspection Time(In Min.)" WHERE("Spec ID" = FIELD("Spec ID")));
            Description = 'B2B1.0-ESPLQC';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Spec ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        /*Item.SETCURRENTKEY("Production BOM No.");
        Item.SETRANGE("Production BOM No.","No.");
        IF Item.FIND('-') THEN
          ERROR(Text000);
        
        ProdBOMLine.SETRANGE("Production BOM No.", "No.");
        ProdBOMLine.DELETEALL(TRUE);
        
        ProdBOMVersion.SETRANGE("Production BOM No.","No.");
        ProdBOMVersion.DELETEALL;
        */
        InspectDataHeader.SetRange("Spec ID", "Spec ID");
        if InspectDataHeader.Find('-') then
            Error('You can''t delete Specification %1 as Inspection Entries exist', "Spec ID");
        PurchLine.SetRange("Spec ID", "Spec ID");
        if PurchLine.Find('-') then
            Error('You can''t delete Specification %1 as Purchase Entries exist', "Spec ID");
        Item.SetRange("Spec ID", "Spec ID");
        Item.ModifyAll("Spec ID", '');
        SpecLine.SetRange("Spec ID", "Spec ID");
        SpecLine.DeleteAll;

    end;

    trigger OnInsert();
    begin
        QualitySetup.Get;
        QualitySetup.TestField("Specification Nos.");
        if "Spec ID" = '' then begin
            NoSeriesMgt.InitSeries(QualitySetup."Specification Nos.", xRec."No. Series", 0D, "Spec ID", "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        QualitySetup: Record "Quality Control Setup";
        Spec: Record "Specification Header";
        SpecLine: Record "Specification Line";
        PurchLine: Record "Purchase Line";
        InspectDataHeader: Record "Inspection Datasheet Header";
        Item: Record Item;
        Text002: Label 'The attachment is empty.';
        Text003: Label 'Attachment is already in use on this machine.';
        Text004: Label 'When you have saved your document, click Yes to import the document.';
        Text005: Label 'Export Attachment';
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file.';
        Text009: Label 'Do you want to remove %1?';
        Text010: Label 'External file could not be removed.';
        Text012: Label '\Doc';
        Text013: Label 'Only Microsoft Word documents can be printed.';
        Text014: Label 'Only Microsoft Word documents can be faxed.';


    procedure AssistEdit(OldSpec: Record "Specification Header"): Boolean;
    begin
        Spec := Rec;
        QualitySetup.Get;
        QualitySetup.TestField("Specification Nos.");
        if NoSeriesMgt.SelectSeries(QualitySetup."Specification Nos.", OldSpec."No. Series", Spec."No. Series") then begin
            QualitySetup.Get;
            QualitySetup.TestField("Specification Nos.");
            NoSeriesMgt.SetSeries(Spec."Spec ID");
            Rec := Spec;
            exit(true);
        end;
    end;


    procedure TestStatus();
    var
        SpecLine2: Record "Specification Line";
        SpecIndent: Codeunit "Spec Line-Indent";
        InspectGroupCode: Code[20];
        SamplingPlanCode: Code[20];
        EndCheck: Boolean;
        BeginCheck: Boolean;
    begin
        SpecIndent.ChangeStatus;
        SpecIndent.Run(Rec);
        SpecLine2.SetRange("Spec ID", "Spec ID");
        if SpecLine2.Find('-') then begin
            SpecLine2.TestField("Character Type", SpecLine2."Character Type"::"Begin");
            repeat
                if BeginCheck then begin
                    BeginCheck := false;
                    SpecLine2.TestField("Character Type", SpecLine2."Character Type"::Standard);
                end;

                if EndCheck then begin
                    EndCheck := false;
                    SpecLine2.TestField("Character Type", SpecLine2."Character Type"::"Begin");
                end;

                if SpecLine2."Character Type" = SpecLine2."Character Type"::"Begin" then begin
                    BeginCheck := true;
                    SpecLine2.TestField("Sampling Code");
                    SpecLine2.TestField("Inspection Group Code");
                    SamplingPlanCode := SpecLine2."Sampling Code";
                    InspectGroupCode := SpecLine2."Inspection Group Code"
                end else begin
                    if SpecLine2."Character Type" = SpecLine2."Character Type"::"End" then
                        EndCheck := true;
                    SpecLine2."Sampling Code" := SamplingPlanCode;
                    SpecLine2."Inspection Group Code" := InspectGroupCode;
                    SpecLine2.Modify;
                end;
            until SpecLine2.Next = 0
        end else
            Error('No specification lines exists');
    end;

    procedure ImportAttchment(): Boolean;
    var
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        //Deleted Local Var(CommonDialogMgtCodeunitCodeunit412)
        //B2b1.0>> Since CommonDialogMgt CU doesn't exist in Nan 2013
        //FileName := CommonDialogMgt.OpenFile(Text006,'',4,Text007,0);
        //B2b1.0<<
        if FileName <> '' then begin
            Attachment.Import(FileName);
            //B2b1.0>> Since Function doesn't exist in Nav 2013
            //"File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
            //B2b1.0<<
            Modify;
            exit(true)
        end else
            exit(false);
    end;

    procedure ExportAttachment(ExportToFile: Text[260]): Boolean;
    var
        FileName: Text[260];
        FileFilter: Text[260];
    begin
        //Deleted Local Var(CommonDialogMgtCodeunitCodeunit412)
        CalcFields(Attachment);
        if Attachment.HasValue then begin
            if ExportToFile = '' then begin
                FileFilter := UpperCase("File Extension") + ' ';
                FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                //B2b1.0>> Since CommonDialogMgt CU doesn't exist in Nan 2013
                //FileName := CommonDialogMgt.OpenFile(Text005,'',4,FileFilter,1);B2B
                //B2b1.0<<
            end else
                FileName := ExportToFile;
            if FileName <> '' then begin
                Attachment.Export(FileName);
                exit(true);
            end else
                exit(false)
        end else
            exit(false)
    end;


    procedure OpenAttachment();
    var
       // WordManagement: Codeunit WordManagement;
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        CalcFields(Attachment);
        if not Attachment.HasValue then
            Error(Text002);
        FileName := ConstFilename;
        if Exists(FileName) then
            if not DeleteFile(FileName) then
                Error(Text003);
        ExportAttachment(FileName);
        //IF AttachmentManagement.UseComServer("File Extension",FALSE) THEN
        //  WordManagement.OpenWordAttachment(Rec1,FileName,'',False);
        //ELSE BEGIN
        HyperLink(FileName);
        /*  IF NOT "Read Only" THEN BEGIN
            IF CONFIRM(Text004,TRUE) THEN BEGIN
              ImportAttachment(FileName,IsTemporary);
              MODIFY(TRUE);
            END;
          END ELSE
            SLEEP(10000);*/
        //END;

        DeleteFile(FileName);

    end;

    procedure ConstFilename() FileName: Text[260];
    var
        I: Integer;
        DocNo: Text[30];
    begin
        repeat
            if I <> 0 then
                DocNo := Format(I);
            // FileName := Environ('TEMP') + Text012 + DocNo + '.' + "File Extension";//EFFUPG
            FileName := System.TemporaryPath() + Text012 + DocNo + '.' + "File Extension";//EFFUPG
            if not Exists(FileName) then
                exit;
            I := I + 1;
        until I = 999;
        Message('%1', FileName);
    end;


    procedure DeleteFile(FileName: Text[260]): Boolean;
    var
        I: Integer;
    begin
        if FileName = '' then
            exit(false);

        if not Exists(FileName) then
            exit(true);

        repeat
            Sleep(250);
            I := I + 1;
        until Erase(FileName) or (I = 25);
        exit(not Exists(FileName));
    end;


    procedure RemoveAttachment(Prompt: Boolean) DeleteOK: Boolean;
    var
        DeleteYesNo: Boolean;
    begin
        DeleteOK := false;
        DeleteYesNo := true;
        if Prompt then
            if not Confirm(
              Text009, false, FieldCaption(Attachment))
            then
                DeleteYesNo := false;
        if DeleteYesNo then begin
            Clear(Attachment);
            "File Extension" := '';
            DeleteOK := true;
        end;
    end;


    procedure CopyAssay();
    var
        AssayHeader: Record "Assay Header";
        AssayLine: Record "Assay Line";
        SpecLine: Record "Specification Line";
        SpecLineNo: Integer;
    begin
        TestField("Spec ID");
        SpecLine.SetRange("Spec ID", "Spec ID");
        if SpecLine.Find('+') then
            SpecLineNo := SpecLine."Line No." + 10000
        else
            SpecLineNo := 10000;
        if PAGE.RunModal(0, AssayHeader) = ACTION::LookupOK then begin
            AssayHeader.TestField(Status, AssayHeader.Status::Certified);
            AssayLine.SetRange("Assay No.", AssayHeader."No.");
            if AssayLine.Find('-') then begin
                SpecLine.Init;
                SpecLine."Spec ID" := "Spec ID";
                SpecLine."Line No." := SpecLineNo;
                SpecLine."Character Type" := SpecLine."Character Type"::"Begin";
                SpecLine."Sampling Code" := AssayHeader."Sampling Plan Code";
                SpecLine."Inspection Group Code" := AssayHeader."Inspection Group Code";
                SpecLine.Description := AssayHeader.Description;
                SpecLine.Insert;
                repeat
                    SpecLine.Init;
                    SpecLineNo := SpecLineNo + 10000;
                    SpecLine."Spec ID" := "Spec ID";
                    SpecLine."Line No." := SpecLineNo;
                    SpecLine."Character Code" := AssayLine."Character Code";
                    SpecLine."Inspection Group Code" := AssayHeader."Inspection Group Code";
                    SpecLine.Description := AssayLine.Description;
                    SpecLine."Sampling Code" := AssayHeader."Sampling Plan Code";
                    SpecLine."Normal Value (Num)" := AssayLine."Normal Value (Num)";
                    SpecLine."Min. Value (Num)" := AssayLine."Min. Value (Num)";
                    SpecLine."Max. Value (Num)" := AssayLine."Max. Value (Num)";
                    SpecLine."Normal Value (Char)" := AssayLine."Normal Value (Char)";
                    SpecLine."Min. Value (Char)" := AssayLine."Min. Value (Char)";
                    SpecLine."Max. Value (Char)" := AssayLine."Max. Value (Char)";
                    SpecLine."Unit Of Measure Code" := AssayLine."Unit Of Measure Code";
                    SpecLine.Qualitative := AssayLine.Qualitative;
                    SpecLine."Character Type" := SpecLine."Character Type"::Standard;
                    SpecLine.Insert;
                until AssayLine.Next = 0;

                SpecLine.Init;
                SpecLine."Spec ID" := "Spec ID";
                SpecLine."Line No." := SpecLineNo + 10000;
                SpecLine."Character Type" := SpecLine."Character Type"::"End";
                SpecLine.Description := AssayHeader.Description;
                SpecLine.Insert;
            end;
        end;
    end;


    procedure GetSpecVersion(SpecHeaderNo: Code[20]; Date: Date; OnlyCertified: Boolean): Code[10];
    var
        SpecVersion: Record "Specification Version";
    begin
        SpecVersion.SetCurrentKey("Specification No.", "Starting Date");
        SpecVersion.SetRange("Specification No.", SpecHeaderNo);
        SpecVersion.SetFilter("Starting Date", '%1|..%2', 0D, Date);
        if OnlyCertified then
            SpecVersion.SetRange(Status, SpecVersion.Status::Certified);
        if not SpecVersion.Find('+') then
            Clear(SpecVersion);

        exit(SpecVersion."Version Code");
    end;
}

