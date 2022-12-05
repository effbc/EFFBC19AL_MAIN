table 60098 Attachments
{
    // version B2B1.0,B2BQTO

    LookupPageID = "ESPL Attachments";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Production BOM,Service Item,Bank Guarantee,Released Prod. Order,Contract,Budgets';
            OptionMembers = Quote,"Order","Production BOM","Service Item","Bank Guarantee","Released Prod. Order",Contract,Budgets;
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; FileAttachment; BLOB)
        {
            Compressed = false;
            DataClassification = CustomerContent;
        }
        field(6; "Storage Type"; Option)
        {
            OptionCaption = 'Embedded,Disk File,Exchange Storage';
            OptionMembers = Embedded,"Disk File","Exchange Storage";
            DataClassification = CustomerContent;
        }
        field(7; "Storage Pointer"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(8; "File Extension"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
        }
        field(10; "Last Time Modified"; Time)
        {
            Caption = 'Last Time Modified';
            DataClassification = CustomerContent;
        }
        field(11; "Store Pointer ID"; BLOB)
        {
            Caption = 'Store Pointer ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                StoreIDInStream: InStream;
            begin
            end;
        }
        field(12; "Store Pointer Checksum"; Integer)
        {
            Caption = 'Store Pointer Checksum';
            DataClassification = CustomerContent;
        }
        field(13; "Entry Pointer ID"; BLOB)
        {
            Caption = 'Entry Pointer ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                EntryIDInStream: InStream;
            begin
            end;
        }
        field(14; "Entry Pointer Checksum"; Integer)
        {
            Caption = 'Entry Pointer Checksum';
            DataClassification = CustomerContent;
        }
        field(15; "Read Only"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Attachment Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Document Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Version No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60002; "Ids Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60003; Doc_Type; Option)
        {
            OptionCaption = '" ,Invoice,Warranty,Spec,Manual"';
            OptionMembers = " ",Invoice,Warranty,Spec,Manual;
            DataClassification = CustomerContent;
        }
        field(60015; "Storage File Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        //EFFUPG>>
        field(36; "File Attachment Media"; Media)
        {
        }
        //EFFUPG<<
    }

    keys
    {
        key(Key1; "No.", "Table ID", "Document Type", "Document No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ModifiyDocument;
        if (Rec."Table ID" = 33000929) and ("Attachment Status" = true) and ("Document No." <> '') then
            Error('You can not delete the file in posted data');
    end;

    trigger OnInsert();
    var
        GLSetup: Record "General Ledger Setup";
    begin

        "Last Date Modified" := Today;
        "Last Time Modified" := Time;

        Attachment2.LockTable;
        if Attachment2.Find('+') then
            "NextAttachmentNo." := Attachment2."No." + 1
        else
            "NextAttachmentNo." := 1;

        //B2B sankar
        "Ids Reference No." := "Document No.";
        if "Table ID" = 0 then
            if GetFilter("Table ID") = '112|36' then    //>> Added by Pranavi On 30-Mar-17
            begin
                "Table ID" := 112;
                "Document Type" := "Document Type"::Order;
                "Document No." := CopyStr(xRec.GetFilter(xRec."Document No."), 1, StrPos(xRec.GetFilter(xRec."Document No."), '|') - 1);
                "Ids Reference No." := CopyStr(xRec.GetFilter(xRec."Document No."), 1, StrPos(xRec.GetFilter(xRec."Document No."), '|') - 1);
            end
            else  //<< Added by Pranavi On 30-Mar-17
                "Table ID" := 33000269;
        //B2B sankar

        "No." := "NextAttachmentNo.";

        GLSetup.Get;
        "Storage Type" := GLSetup."ESPL Attachment Storage Type";
        if "Storage Type" = "Storage Type"::"Disk File" then begin
            GLSetup.TestField("ESPL Attmt. Storage Location");
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";
        end;
        //test
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := Today;
        "Last Time Modified" := Time;
    end;

    var
        Text000: Label 'You have canceled the create process.';
        Text001: Label 'Replace existing attachment?';
        Text112: Label 'You have canceled the import process.';
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
        Text015: Label 'The e-mail has been deleted.';
        Text016: Label 'When you have finished working with a document, you should delete the associated temporary file. Please note that this will not delete the document.\\Do you want to delete the temporary file?';
        Attachment2: Record Attachments;
        "NextAttachmentNo.": Integer;
        GL: Record "G/L Entry";
        Text020: TextConst ENU = 'An Outlook dialog box is open. Close it and try again.', ENN = 'An Outlook dialog box is open. Close it and try again.';
        Text021: TextConst Comment = 'Default.', ENU = 'Default.', ENN = 'Default.';
        "--Rev01----": Integer;
        //TempBlob: Record TempBlob;//EFFUPG
        TempBlob1: Codeunit "Temp Blob";//EFFUPG
        FileMgt: Codeunit "File Management";
        AttachmentMgt: Codeunit AttachmentManagementESPL;
        Text022: Label 'MECH_ITEM.';

    procedure OpenAttachment(Caption: Text[260]; IsTemporary: Boolean);
    var
        WordManagement: Codeunit WordManagementESPL;
        FileName: Text[260];
        FileManagement: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        DocumentStream: OutStream;
    begin

        if "Storage Type" = "Storage Type"::Embedded then begin

            if not "File Attachment Media".HasValue then
                Error(Text002);
            FileName := Rec.Description;
            FileName := System.TemporaryPath() + '\' + FileName + '.' + Rec."File Extension";
            //  "File Attachment Media".Exportfile(FileName);
            TempBlob.CreateOutStream(DocumentStream);
            "File Attachment Media".ExportStream(DocumentStream);
            FileManagement.BLOBExport(TempBlob, FileName, false)

        end else begin

            FileName := ConstFileName;
            if not DeleteFile(FileName) then
                Error(Text003);
            ExportAttachment(FileName);
            if WordManagement.IsWordDocumentExtension("File Extension") then begin
                WordManagement.OpenWordAttachment(Rec, FileName, Caption, IsTemporary);
            end else begin
                HyperLink(FileName);
                if not "Read Only" then begin
                    if Confirm(Text004, true) then
                        ImportAttachment(FileName, IsTemporary, false);
                    DeleteFile(FileName);
                end else
                    if Confirm(Text016, true) then
                        DeleteFile(FileName);
            end;

            //EFFUPG1.3
            FileManagement.BLOBImportFromServerFile(tempBlob1, Rec."Storage Pointer");
            FileName := Rec.Description;
            FileName := FileName + '.' + Rec."File Extension";
            //AttachmentIssue
            FileName := FileManagement.BLOBExport(tempBlob1, FileName, TRUE)
        end;
        //Rev01 chaitanya commented old code
        /*
        IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
          CALCFIELDS(FileAttachment);
          IF NOT FileAttachment.HASVALUE THEN
            ERROR(Text002);
        END;
        
        FileName := ConstFileName;
        IF EXISTS(FileName) THEN
          IF NOT DeleteFile(FileName) THEN
            ERROR(Text003);
        ExportAttachment(FileName);
        IF AttachmentManagement.UseComServer("File Extension",FALSE) THEN
          WordManagement.OpenWordAttachment(Rec,FileName,Caption,IsTemporary)
        ELSE BEGIN
          HYPERLINK(FileName);
          IF NOT "Read Only" THEN BEGIN
            IF CONFIRM(Text004,TRUE) THEN
              ImportAttachment(FileName,IsTemporary,FALSE);
            DeleteFile(FileName);
          END ELSE
            IF CONFIRM(Text016,TRUE) THEN
              DeleteFile(FileName);
        END;
        */
        //Rev01 chaitanya commented old code

    end;





    procedure ImportAttachment(ImportFromFile: Text; IsTemporary: Boolean; IsInherited: Boolean): Boolean;
    var
        FileName: Text[260];
        NewAttachmentNo: Integer;
        GLSetup: Record "General Ledger Setup";
        "--Rev01": Integer;
        ServerFileName: Text;
        DocStream: InStream;//EFFUPG
    begin



        if IsTemporary then begin
            FileName := FileMgt.BLOBImport(TempBlob1, ImportFromFile);//EFFUPG
            TempBlob1.CreateInStream(DocStream);
            if FileName <> '' then begin
                "File Attachment Media".ImportStream(DocStream, '');//EFFUPG
                                                                    // FileAttachment := TempBlob.Blob;//EFFUPG
                "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
                exit(true);
            end;
            exit(false);
        end;

        TestField("Read Only", false);
        GLSetup.Get;
        if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then
            GLSetup.TestField("ESPL Attmt. Storage Location");
        if "Storage Pointer" = '' then
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";

        if IsInherited then begin
            NewAttachmentNo := AttachmentMgt.InsertAttachment("No.", "Table ID", "Document Type", "Document No.");
            //GET(NewAttachmentNo);
            Get("No.", "Table ID", "Document Type", "Document No.");//hack
        end else
            if "No." = 0 then
                NewAttachmentNo := AttachmentMgt.InsertAttachment(0, "Table ID", "Document Type", "Document No.") //hack
            else
                NewAttachmentNo := "No.";

        Get(NewAttachmentNo, "Table ID", "Document Type", "Document No.");//hack

        if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then begin
            ServerFileName := ConstDiskFileName;
            FileName := ImportFromFile;
            if not Upload(Text006, '', Text007, FileName, ServerFileName) then
                Error(Text008);
            //B2BQTO >>
            "Storage File Name" := FileName;

            //B2BQTO <<
            if FileName = '' then
                exit(false);
            "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";
            "Storage Type" := "Storage Type"::"Disk File";
            "Attachment Status" := true;
            if Modify(true) then;
            //Efftronics
            if "Table ID" = 17 then begin
                GL.Reset;
                GL.SetRange(GL."Document No.", "Document No.");
                if GL.Find('-') then
                    repeat
                        if GL."G/L Account No." in ['23700', '53500', '24606', '20300'] then begin
                            GL.Attachment := true;
                            GL.Modify;
                        end;
                    until GL.Next = 0;
            end;
            //Efftronics
        end else begin
            FileName := ImportFromFile;
            FileName := FileMgt.BLOBImport(TempBlob1, FileName);//EFFUPG
            TempBlob1.CreateInStream(DocStream);//EFFUPG

            if FileName = '' then
                exit(false);
            //FileAttachment := TempBlob.Blob;//EFFUPG
            "File Attachment Media".ImportStream(DocStream, '');//EFFUPG
            "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
            "Storage Type" := "Storage Type"::Embedded;
            "Attachment Status" := true;
            //B2BQTO >>
            "Storage File Name" := FileName;

            //B2BQTO <<
            if Modify(true) then;
            //Efftronics
            if "Table ID" = 17 then begin
                GL.Reset;
                GL.SetRange(GL."Document No.", "Document No.");
                if GL.Find('-') then
                    repeat
                        if GL."G/L Account No." in ['23700', '53500', '24606', '20300'] then begin
                            GL.Attachment := true;
                            GL.Modify;
                        end;
                    until GL.Next = 0;
            end;
            //Efftronics
        end;
        exit(true);

        //Rev01 chaitanya commented old code
        /*
        //B2b Deleted local var(CommonDialogMgtCodeunitCodeunit412), commented code
        
        IF IsTemporary THEN BEGIN
        
          //B2b1.0>> Since CommonDialogMgt codeunit doesn't exist in Nav 2013
          {IF ImportFromFile = '' THEN
            FileName := CommonDialogMgt.OpenFile(Text006,ImportFromFile,4,Text007,0)
          ELSE
            FileName := ImportFromFile;}
          //B2b1.0<<
        
          IF FileName <> '' THEN BEGIN
            FileAttachment.IMPORT(FileName);
            "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
                EXIT(TRUE)
          END ELSE
            EXIT(FALSE);
        END;
        
        
        TESTFIELD("Read Only",FALSE);
        
        GLSetup.GET;
        IF GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" THEN
          GLSetup.TESTFIELD("ESPL Attmt. Storage Location");
        
        //B2b1.0>> Since CommonDialogMgt codeunit doesn't exist
        {IF ImportFromFile = '' THEN
          FileName := CommonDialogMgt.OpenFile(Text006,'',4,Text007,0)
        ELSE
          FileName := ImportFromFile;
         }//B2B<<1.0
        
        IF FileName <> '' THEN BEGIN
          IF "Storage Pointer" = '' THEN
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";
          IF GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" THEN BEGIN
            GET(AttachGetRec."No.",AttachGetRec."Table ID",AttachGetRec."Document Type",AttachGetRec."Document No.");
            "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";
            "Storage Type" := "Storage Type"::"Disk File";
            "Attachment Status":=TRUE;
            MODIFY(TRUE);
            IF "Table ID"=17 THEN
            BEGIN
            GL.SETRANGE(GL."Document No.","Document No.");            //sreenivas
            IF GL.FIND('-') THEN
            REPEAT
            IF GL."G/L Account No."='23700' THEN
            BEGIN
            GL.Attachment:=TRUE;
           // MESSAGE('Hai1');
            GL.MODIFY;
            END;
        
            IF GL."G/L Account No."='53500' THEN
            BEGIN
            GL.Attachment:=TRUE;
           // MESSAGE('Hai1');
            GL.MODIFY;
            END;
        
            IF GL."G/L Account No."='24606' THEN
            BEGIN
            GL.Attachment:=TRUE;
           // MESSAGE('Hai1');
            GL.MODIFY;
            END;
            IF GL."G/L Account No."='20300' THEN
            BEGIN
            GL.Attachment:=TRUE;
           // MESSAGE('Hai1');
            GL.MODIFY;
            END;
        
        
            UNTIL GL.NEXT=0;
        
            END;
        
        
            IF NOT FILE.COPY(FileName,ConstDiskFileName) THEN
              ERROR(
                Text008);
          END ELSE BEGIN
            GET(AttachGetRec."No.",AttachGetRec."Table ID",AttachGetRec."Document Type",AttachGetRec."Document No.",
                 AttachGetRec."Document Line No.");
            IF NOT FILE.COPY(FileName,ConstDiskFileName) THEN
              ERROR(
                Text008);
            GET(AttachGetRec."No.",AttachGetRec."Table ID",AttachGetRec."Document Type",AttachGetRec."Document No.",
                 AttachGetRec."Document Line No.");
            FileAttachment.IMPORT(FileName);
            "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
            "Storage Type" := "Storage Type"::Embedded;
            "Attachment Status":=TRUE;
            IF MODIFY(TRUE) THEN;
          END;
          EXIT(TRUE);
        END ELSE
          EXIT(FALSE);
        */
        //Rev01 chaitanya commented old code

    end;


    procedure ExportAttachment(var ExportToFile: Text): Boolean;
    var
        FileName: Text[260];
        FileFilter: Text[260];
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        case "Storage Type" of
            "Storage Type"::Embedded:
                begin
                    if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then
                        GLSetup.TestField("ESPL Attmt. Storage Location");
                    //EFFUPG>>
                    /*
                    CalcFields(FileAttachment);
                    if FileAttachment.HasValue then begin
                        TempBlob.Blob := FileAttachment;
                        if ExportToFile = '' then begin
                            FileName := Text021 + "File Extension";
                            ExportToFile := FileMgt.BLOBExport(TempBlob, FileName, true);
                        end else
                            // If a filename is provided, the file will be treated as temp file.
                            ExportToFile := FileMgt.BLOBExport(TempBlob, ExportToFile, false);

                        exit(true);
                    end;
                    exit(false)
                    */



                    exit(true);


                    if "File Attachment Media".HasValue then begin


                        FileName := Text021 + "File Extension";
                        "File Attachment Media".ExportFile(FileName);


                        exit(true);
                    end;
                    exit(false)

                    //EFFUPG<<

                end;
            "Storage Type"::"Disk File":
                begin
                    if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then
                        GLSetup.TestField("ESPL Attmt. Storage Location");

                    FileFilter := UpperCase("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    exit(Download(ConstDiskFileName, Text005, '', FileFilter, ExportToFile))
                end;
        end;


        //Rev01 chaitanya commented old code
        /*
        //B2B Deleted local var(CommonDialogMgtCodeunitCodeunit412), Commented code
        
        GLSetup.GET;
        CASE "Storage Type" OF
          "Storage Type"::Embedded:
            BEGIN
              IF GLSetup."ESPL Attachment Storage Type" =
                 GLSetup."ESPL Attachment Storage Type"::"Disk File"
              THEN
                GLSetup.TESTFIELD("ESPL Attmt. Storage Location");
              CALCFIELDS(FileAttachment);
              IF FileAttachment.HASVALUE THEN BEGIN
                IF ExportToFile = '' THEN BEGIN
                  FileFilter := UPPERCASE("File Extension") + ' ';
                  FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                  //B2b1.0>> Since CommonDialogMgt doesn't exist in Nav 2013
                  //FileName := CommonDialogMgt.OpenFile(Text005,'',4,FileFilter,1);
                  //B2b1.0<<
                END ELSE
                  FileName := ExportToFile;
                IF FileName <> '' THEN BEGIN
                  FileAttachment.EXPORT(FileName);
                  EXIT(TRUE);
                END ELSE
                  EXIT(FALSE)
              END ELSE
                EXIT(FALSE)
            END;
        
          "Storage Type":: "Disk File":
            BEGIN
              IF GLSetup."ESPL Attachment Storage Type" =
                 GLSetup."ESPL Attachment Storage Type"::"Disk File"
              THEN
                GLSetup.TESTFIELD("ESPL Attmt. Storage Location");
              IF ExportToFile = '' THEN BEGIN
                FileFilter := UPPERCASE("File Extension") + ' ';
                FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
                //B2b1.0>> Since CommonDialogMgt doesn't exist in Nav 2013
                //FileName := CommonDialogMgt.OpenFile(Text005,'',4,FileFilter,1);
                //B2b1.0<<
              END ELSE
                FileName := ExportToFile;
              IF FileName <> '' THEN BEGIN
                IF FILE.COPY(ConstDiskFileName,FileName) THEN
                  EXIT(TRUE)
                ELSE
                  EXIT(FALSE);
              END ELSE
                EXIT(FALSE)
              END;
            END;
        */
        //Rev01 chaitanya commented old code

    end;

    procedure DeleteFile(FileName: Text): Boolean;
    var
        I: Integer;
    begin
        if FileName = '' then
            exit(false);

        if not FileMgt.ClientFileExists(FileName) then
            exit(true);

        repeat
            Sleep(250);
            I := I + 1;
        until FileMgt.DeleteClientFile(FileName) or (I = 25);
        exit(not FileMgt.ClientFileExists(FileName));

        //Rev01 chaitanya commented old code
        /*
        IF FileName = '' THEN
          EXIT(FALSE);
        
        IF NOT EXISTS(FileName) THEN
          EXIT(TRUE);
        
        REPEAT
          SLEEP(250);
          I := I + 1;
        UNTIL ERASE(FileName) OR (I = 25);
        EXIT(NOT EXISTS(FileName));
        */
        //Rev01 chaitanya commented old code

    end;


    procedure RemoveAttachment(Prompt: Boolean) DeleteOk: Boolean;
    var
        DeleteYesNo: Boolean;
    begin
        DeleteOk := false;
        DeleteYesNo := true;
        if Prompt then
            if not Confirm(
                 Text009, false, TableCaption)
            then
                DeleteYesNo := false;

        if DeleteYesNo then begin
            if "Storage Type" = "Storage Type"::"Disk File" then
                if not DeleteFile(ConstDiskFileName) then
                    Message(Text010);
            Delete(true);
            DeleteOk := true;
        end;

        //Rev01 chaitanya commented old code
        /*
        DeleteOk := FALSE;
        DeleteYesNo := TRUE;
        IF Prompt THEN
          IF NOT CONFIRM(
            Text009,FALSE,TABLECAPTION)
          THEN
            DeleteYesNo := FALSE;
        
        IF DeleteYesNo THEN BEGIN
          IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
            IF NOT DeleteFile(ConstDiskFileName) THEN
              MESSAGE(Text010);
          END;
          Rec.DELETE(TRUE);
          DeleteOk := TRUE;
          "Attachment Status":=FALSE;
        END;
        */
        //Rev01 chaitanya commented old code

    end;


    procedure ConstFileName() FileName: Text[260];
    var
        I: Integer;
        DocNo: Text[30];
    begin
        FileName := FileMgt.ClientTempFileName("File Extension");
        //Rev01 chaitanya commented old code
        /*
        REPEAT
          IF I <> 0 THEN
            DocNo := FORMAT(I);
          FileName := TEMPORARYPATH + Text012 + DocNo + '.' + "File Extension";
          IF NOT EXISTS(FileName) THEN
            EXIT;
          I := I +1;
        UNTIL I=999;
        */
        //Rev01 chaitanya commented old code

    end;


    procedure ConstDiskFileName() DiskFileName: Text[260];
    begin
        DiskFileName := "Storage Pointer" + '\' + Format("No.") + '.';
        //Rev01 chaitanya commented old code
        /*
        DiskFileName := "Storage Pointer" + '\' + FORMAT("No.") + '.';
        */
        //Rev01 chaitanya commented old code

    end;


    procedure CreateAttachment();
    var
        Attachment: Record Attachments;
        AttachmentManagement: Codeunit AttachmentManagementESPL;
        NewAttachNo: Integer;
        WordManagement: Codeunit WordManagementESPL;
    begin
        //Rev01 chaitanya commented old code
        /*
        TESTFIELD(Description);
        {IF "No." <> 0 THEN BEGIN
          IF Attachment.GET("No.") THEN
            Attachment.TESTFIELD("Read Only",FALSE);
          IF NOT CONFIRM(Text001,FALSE) THEN
            EXIT;
        END;}
        
        IF AttachmentManagement.UseComServer('DOC',TRUE) THEN;
        
        NewAttachNo := WordManagement.CreateWordAttachment(Description,Rec);
        
        {IF NewAttachNo <> 0 THEN BEGIN
          IF "No." <> 0  THEN
            //RemoveAttachment(FALSE);
            "No." := NewAttachNo;
          //IF InteractTmplLanguage.GET("Interaction Template Code","Language Code") THEN
          // MODIFY
          //ELSE
            INSERT;
        END ELSE
          ERROR(Text000);    }
        */
        //Rev01 chaitanya commented old code

    end;

    procedure "--Rev01"();
    begin
    end;

    procedure CheckCorrespondenceType(CorrespondenceType: Option " ","Hard Copy","E-Mail",Fax) ErrorText: Text[80];
    begin
        case CorrespondenceType of
            CorrespondenceType::"Hard Copy":
                if (UpperCase("File Extension") <> 'DOC') and (UpperCase("File Extension") <> 'DOCX') then
                    exit(Text013);
            CorrespondenceType::Fax:
                if (UpperCase("File Extension") <> 'DOC') and (UpperCase("File Extension") <> 'DOCX') then
                    exit(Text014);
        end;
    end;


    procedure ImportAttachment2(ImportFromFile: Text; IsTemporary: Boolean; IsInherited: Boolean; FileN: Text): Boolean;
    var
        FileName: Text[260];
        NewAttachmentNo: Integer;
        GLSetup: Record "General Ledger Setup";
        "--Rev01": Integer;
        ServerFileName: Text;
        DocStream: InStream;//EFFUPG
    begin
        if IsTemporary then begin
            FileName := FileN;
            if FileName <> '' then begin
                //FileAttachment := TempBlob.Blob;//EFFUPG
                FileName := FileMgt.BLOBImport(TempBlob1, ImportFromFile);//EFFUPG
                TempBlob1.CreateInStream(DocStream);//EFFUPG
                "File Attachment Media".ImportStream(DocStream, '');//EFFUPG
                "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
                exit(true);
            end;
            exit(false);
        end;

        TestField("Read Only", false);
        GLSetup.Get;
        if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then
            GLSetup.TestField("ESPL Attmt. Storage Location");
        if "Storage Pointer" = '' then
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";

        if IsInherited then begin
            NewAttachmentNo := AttachmentMgt.InsertAttachment("No.", "Table ID", "Document Type", "Document No.");
            //GET(NewAttachmentNo);
            Get("No.", "Table ID", "Document Type", "Document No.");//hack
        end else
            if "No." = 0 then
                NewAttachmentNo := AttachmentMgt.InsertAttachment(0, "Table ID", "Document Type", "Document No.") //hack
            else
                NewAttachmentNo := "No.";

        Get(NewAttachmentNo, "Table ID", "Document Type", "Document No.");//hack

        if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then begin
            ServerFileName := ConstDiskFileName;
            FileName := FileN;
            /* IF NOT UPLOAD(Text006,'',Text007,FileName,ServerFileName) THEN
               ERROR(Text008);*/
            if FileName = '' then
                exit(false);
            "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
            "Storage Pointer" := GLSetup."ESPL Attmt. Storage Location";
            "Storage Type" := "Storage Type"::"Disk File";
            "Attachment Status" := true;
            if Modify(true) then;
            //Efftronics
            if "Table ID" = 17 then begin
                GL.Reset;
                GL.SetRange(GL."Document No.", "Document No.");
                if GL.Find('-') then
                    repeat
                        if GL."G/L Account No." in ['23700', '53500', '24606', '20300'] then begin
                            GL.Attachment := true;
                            GL.Modify;
                        end;
                    until GL.Next = 0;
            end;
            //Efftronics
        end else begin
            FileName := FileN;
            //FileMgt.BLOBImportFromServerFile(TempBlob, FileName);//EFFUPG
            FileName := FileMgt.BLOBImport(TempBlob1, ImportFromFile);//EFFUPG
            TempBlob1.CreateInStream(DocStream);//EFFUPG
            //FileName := FileMgt.BLOBImport(TempBlob,FileName);
            if FileName = '' then
                exit(false);
            //FileAttachment := TempBlob.Blob;//EFFUPG
            "File Attachment Media".ImportStream(DocStream, '');//EFFUPG
            "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
            "Storage Type" := "Storage Type"::Embedded;
            "Attachment Status" := true;
            if Modify(true) then;
            //Efftronics
            if "Table ID" = 17 then begin
                GL.Reset;
                GL.SetRange(GL."Document No.", "Document No.");
                if GL.Find('-') then
                    repeat
                        if GL."G/L Account No." in ['23700', '53500', '24606', '20300'] then begin
                            GL.Attachment := true;
                            GL.Modify;
                        end;
                    until GL.Next = 0;
            end;
            //Efftronics
        end;
        exit(true);

    end;


    procedure ReadFilePath(var ExportToFile: Text): Boolean;
    var
        FileName: Text[260];
        FileFilter: Text[260];
        GLSetup: Record "General Ledger Setup";
        DescriptionString: Text[100];
    begin
        GLSetup.Get;
        case "Storage Type" of
            "Storage Type"::Embedded:
                begin
                    CalcFields("File Attachment Media");//EFFUPG
                    if "File Attachment Media".HasValue then begin//EFFUPG

                        //TempBlob.Blob := "File Attachment";//EFFUPG
                        DescriptionString := '';
                        DescriptionString := ConvertStr(Description, '/', ' ');
                        DescriptionString := ConvertStr(DescriptionString, '\', ' ');
                        FileName := '\\erpserver\ErpAttachments\Mechanical_Items\' + "Document No." + '-' + DescriptionString + '.' + "File Extension";
                        //FileName := ExportToFile;
                        //FileMgt.BLOBExportToServerFile(TempBlob, FileName);//EFFUPG
                        "File Attachment Media".ExportFile(FileName);//EFFUPG
                        exit(true);
                    end;
                    exit(false)
                end;
            "Storage Type"::"Disk File":
                begin
                    if GLSetup."ESPL Attachment Storage Type" = GLSetup."ESPL Attachment Storage Type"::"Disk File" then
                        GLSetup.TestField("ESPL Attmt. Storage Location");

                    FileFilter := UpperCase("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    exit(Download(ConstDiskFileName, Text005, '', FileFilter, ExportToFile))
                end;
        end;
    end;


    procedure ModifiyDocument();
    var
        InspectionReceiptHeader: Record "Inspection Receipt Header";
        UserSetup: Record "User Setup";
    begin
        InspectionReceiptHeader.Reset;
        InspectionReceiptHeader.SetRange("No.", "Document No.");
        InspectionReceiptHeader.SetRange(Status, true);
        if InspectionReceiptHeader.FindFirst then begin
            if not (UserId in ['EFFTRONICS\VIJAYALAKSHMIB', 'EFFTRONICS\DINEEL', 'EFFTRONICS\KRATNABABU', 'EFFTRONICS\DURGAMAHESWARI']) then
                Error('You are not Authorised to modify');
        end;
    end;
}

