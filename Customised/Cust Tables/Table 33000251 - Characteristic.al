table 33000251 Characteristic
{
    // version QC1.0

    LookupPageID = Characteristics;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Inspection Group Code"; Code[20])
        {
            TableRelation = "Inspection Group".Code;
            DataClassification = CustomerContent;
        }
        field(4; Attachment60098; BLOB)
        {
            DataClassification = CustomerContent;
        }
        field(5; "File Extension"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Unit Of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(7; Qualitative; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin

        //B2B ESPL prasad
        Specificationline.SetRange("Character Code", Code);
        if Specificationline.Find('-') then
            Error('This Character is being used in Specifications');

        assayline.SetRange("Character Code", Code);
        if assayline.Find('-') then
            Error('This Character is being used in Assay');
        //B2B ESPL prasad
    end;

    var
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
        Specificationline: Record "Specification Line";
        Characteristi: Record Characteristic;
        assayline: Record "Assay Line";


    procedure ImportAttchment(): Boolean;
    var
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        //Deleted Local Var(CommonDialogMgtCodeunitCodeunit412)
        //B2b1.0>> SInce CommonDialogMgt CU doesn't exist in Nav 2013
        //FileName := CommonDialogMgt.OpenFile(Text006,'',4,Text007,0);
        //B2b1.0<<
        if FileName <> '' then begin
            Attachment60098.Import(FileName);
            //B2b1.0>>Since Function doesn't exist in Nav 2013
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
        CalcFields(Attachment60098);
        if Attachment60098.HasValue then begin
            if ExportToFile = '' then begin
                FileFilter := UpperCase("File Extension") + ' ';
                FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                //B2b1.0>> SInce CommonDialogMgt CU doesn't exist in Nav 2013
                //FileName := CommonDialogMgt.OpenFile(Text005,'',4,FileFilter,1);
                //B2b1.0<<
            end else
                FileName := ExportToFile;
            if FileName <> '' then begin
                Attachment60098.Export(FileName);
                exit(true);
            end else
                exit(false)
        end else
            exit(false)
    end;


    procedure OpenAttachment();
    var
        //WordManagement: Codeunit WordManagement;
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        CalcFields(Attachment60098);
        if not Attachment60098.HasValue then
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
              Text009, false, FieldCaption(Attachment60098))
            then
                DeleteYesNo := false;
        if DeleteYesNo then begin
            Clear(Attachment60098);
            "File Extension" := '';
            DeleteOK := true;
        end;
    end;
}

