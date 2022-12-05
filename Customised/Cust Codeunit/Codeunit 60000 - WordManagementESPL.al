codeunit 60000 WordManagementESPL
{
    trigger OnRun();
    begin
    end;

    var
        Window: Dialog;
        AttachmentManagement: Codeunit AttachmentManagementESPL;
        Text003: TextConst ENU = 'Merging Microsoft Word Documents...\\', ENN = 'Merging Microsoft Word Documents...\\';
        Text004: TextConst ENU = 'Preparing', ENN = 'Preparing';
        Text005: TextConst ENU = 'Program status', ENN = 'Program status';
        Text006: TextConst ENU = 'Preparing Merge...', ENN = 'Preparing Merge...';
        Text007: TextConst ENU = 'Waiting for print job...', ENN = 'Waiting for print job...';
        Text008: TextConst ENU = 'Transferring %1 data to Microsoft Word...', ENN = 'Transferring %1 data to Microsoft Word...';
        Text009: TextConst ENU = 'Sending individual email messages...', ENN = 'Sending individual email messages...';
        Text010: TextConst Comment = 'Attachment No. must have File Extension DOC or DOCX.', ENU = '%1 %2 must have %3 DOC or DOCX.', ENN = '%1 %2 must have %3 DOC or DOCX.';
        Text011: TextConst ENU = 'Attachment file error', ENN = 'Attachment file error';
        Text012: TextConst ENU = 'Creating merge source...', ENN = 'Creating merge source...';
        Text013: TextConst ENU = 'Microsoft Word is opening merge source...', ENN = 'Microsoft Word is opening merge source...';
        Text014: TextConst ENU = 'Merging %1 in Microsoft Word...', ENN = 'Merging %1 in Microsoft Word...';
        Text015: TextConst ENU = 'FaxMailTo', ENN = 'FaxMailTo';
        Text017: TextConst ENU = 'The merge source file is locked by another process.\', ENN = 'The merge source file is locked by another process.\';
        Text018: TextConst ENU = 'Please try again later.', ENN = 'Please try again later.';
        Text019: TextConst ENU = ' Mail Address', ENN = ' Mail Address';
        Text020: TextConst ENU = 'Document ', ENN = 'Document ';
        Text021: TextConst ENU = 'Import attachment ', ENN = 'Import attachment ';
        Text022: TextConst ENU = 'Delete %1?', ENN = 'Delete %1?';
        Text023: TextConst ENU = 'Another user has modified the record for this %1\after you retrieved it from the database.\\Enter the changes again in the updated document.', ENN = 'Another user has modified the record for this %1\after you retrieved it from the database.\\Enter the changes again in the updated document.';
        Text030: TextConst ENU = 'Formal Salutation', ENN = 'Formal Salutation';
        Text031: TextConst ENU = 'Informal Salutation', ENN = 'Informal Salutation';
        Text032: TextConst ENU = '*.htm|*.htm', ENN = '*.htm|*.htm';
        "--Rev01--": Integer;
        FileMgt: Codeunit "File Management";
        WordHelper: DotNet WordHelperD;
        //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.WordHelper" RUNONCLIENT;
        AttachmentLanguageCode: Code[10];


    procedure CreateWordAttachment(WordCaption: Text[260]) NewAttachNo: Integer;
    var
        AttachmentVoith: Record Attachments;
        AttachmentManagement: Codeunit AttachmentManagementESPL;
        FileName: Text[260];
        MergeFileName: Text[260];
        ParamInt: Integer;
        "--Rev01": Integer;
        Attachment: Record Attachments;
        WordApplication: DotNet WordApplicationD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.ApplicationClass" RUNONCLIENT;
        WordDocument: DotNet WordDocumentD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document" RUNONCLIENT;
        WordMergefile: DotNet WordMergefileD;
    //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler" RUNONCLIENT;
    begin
        WordMergefile := WordMergefile.MergeHandler;

        MergeFileName := FileMgt.ClientTempFileName('HTM');
        CreateHeader(WordMergefile, TRUE, MergeFileName); // Header without data

        WordApplication := WordApplication.ApplicationClass;
        Attachment."File Extension" := GetWordDocumentExtension(WordApplication.Version);
        WordDocument := WordHelper.AddDocument(WordApplication);
        WordDocument.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
        ParamInt := 7; // 7 = HTML
        WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);

        FileName := Attachment.ConstFileName;
        WordHelper.CallSaveAs(WordDocument, FileName);
        IF WordHandler(WordDocument, Attachment, WordCaption, FALSE, FileName, FALSE) THEN
            NewAttachNo := Attachment."No."
        ELSE
            NewAttachNo := 0;

        CLEAR(WordMergefile);
        CLEAR(WordDocument);
        WordHelper.CallQuit(WordApplication, FALSE);
        CLEAR(WordApplication);

        DeleteFile(MergeFileName);

        //Rev01 Chaitanya Commented old Code
        /*
        AttachmentVoith."File Extension" := 'DOC';
        
        IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp,FALSE,TRUE);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile,FALSE,TRUE);
        
        MergeFileName := ConstMergeSourceFileName;
        //CreateHeader(wrdMergefile,TRUE,MergeFileName); // Header without data
        
        wrdDoc := wrdApp.Documents.Add;
        wrdDoc.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
        ParamInt := 7; // 7 = HTML
        
        //wrdDoc.MailMerge.OpenDataSource(MergeFileName,ParamInt);
        
        FileName := AttachmentVoith.ConstFileName;
        
        wrdDoc.SaveAs2000(FileName);
        wrdDoc.ActiveWindow.Caption := WordCaption;
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        
        
        //IF WordHandler(wrdDoc,AttachmentVoith,WordCaption,FALSE,FileName,FALSE) THEN
        IF WordHandler(wrdDoc,AttachRec,WordCaption,FALSE,FileName,FALSE) THEN
          NewAttachNo := AttachmentVoith."No."
        ELSE
          NewAttachNo := 0;
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        
        DeleteFile(MergeFileName);
        
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure OpenWordAttachment(var AttachmentVoith: Record Attachments; FileName: Text[260]; Caption: Text[260]; IsTemporary: Boolean);
    var
        ParamFalse: Boolean;
        MergeFileName: Text[260];
        ParamInt: Integer;
        "Rev01-----": Integer;
        WordApplication: DotNet WordApplicationD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.ApplicationClass" RUNONCLIENT;
        WordDocument: DotNet WordDocumentD;
        //  "'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document" RUNONCLIENT;
        WordMergefile: DotNet WordMergefileD;
    //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler" RUNONCLIENT;
    begin
        WordMergefile := WordMergefile.MergeHandler;

        MergeFileName := FileMgt.ClientTempFileName('HTM');
        CreateHeader(WordMergefile, TRUE, MergeFileName);

        WordApplication := WordApplication.ApplicationClass;

        WordDocument := WordHelper.CallOpen(WordApplication, FileName, FALSE, AttachmentVoith."Read Only");

        // Handle Word documents without mergefields
        //IF DocumentContainMergefields(AttachmentVoith) THEN  EFFUPG
        IF ISNULL(WordDocument.MailMerge.MainDocumentType) THEN BEGIN
            WordDocument.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
            WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
        END;

        IF WordDocument.MailMerge.Fields.Count > 0 THEN BEGIN
            ParamInt := 7; // 7 = HTML
            WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
        END;

        WordHandler(WordDocument, AttachmentVoith, Caption, IsTemporary, FileName, FALSE);

        CLEAR(WordMergefile);
        CLEAR(WordDocument);
        WordHelper.CallQuit(WordApplication, FALSE);
        CLEAR(WordApplication);

        DeleteFile(MergeFileName);

        //Rev01 Chaitanya Commented old Code
        /*
        IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp,FALSE,TRUE);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile,FALSE,TRUE);
        
        MergeFileName := ConstMergeSourceFileName;
        //CreateHeader(wrdMergefile,TRUE,MergeFileName);
        ParamFalse := FALSE;
        //KPK//wrdDoc := wrdApp.Documents.Open2000(FileName,ParamFalse,AttachmentVoith."Read Only");
        wrdDoc := wrdApp.Documents.Open2000(FileName,ParamFalse,AttachmentVoith."Read Only");
        IF wrdDoc.MailMerge.MainDocumentType = -1 THEN BEGIN
          wrdDoc.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
          MergeFileName := ConstMergeSourceFileName;
          //CreateHeader(wrdMergefile,TRUE,MergeFileName); // Header without data
          //wrdDoc.MailMerge.OpenDataSource(MergeFileName,ParamInt);
        END;
        
        IF wrdDoc.MailMerge.Fields.Count > 0 THEN BEGIN
          IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile,FALSE,TRUE);
          ParamInt := 7; // 7 = HTML
          //wrdDoc.MailMerge.OpenDataSource(MergeFileName,ParamInt);
        END;
        
        wrdDoc.ActiveWindow.Caption := Caption;
        wrdDoc.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        
        WordHandler(wrdDoc,AttachmentVoith,Caption,IsTemporary,FileName,FALSE);
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        
        DeleteFile(MergeFileName);
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure WordHandler(var WordDocument: DotNet WordDocumentD; var Attachment: Record Attachments; Caption: Text[260]; IsTemporary: Boolean; FileName: Text; IsInherited: Boolean) DocImported: Boolean;
    //  "'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document"
    var
        Attachment2: Record Attachments;
        WordHandler: DotNet WordHandlerD;
        //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler" RUNONCLIENT;
        NewFileName: Text;
    begin
        WordHandler := WordHandler.WordHandler;

        WordDocument.ActiveWindow.Caption := Caption;
        WordDocument.Application.Visible := TRUE; // Visible before WindowState KB176866 - http://support.microsoft.com/kb/176866
        WordDocument.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        WordDocument.Saved := TRUE;
        WordDocument.Application.Activate;

        NewFileName := WordHandler.WaitForDocument(WordDocument);

        IF NOT Attachment."Read Only" THEN
            IF WordHandler.IsDocumentClosed THEN
                IF WordHandler.HasDocumentChanged THEN BEGIN
                    CLEAR(WordHandler);
                    IF CONFIRM(Text021 + Caption + '?', TRUE) THEN BEGIN
                        IF (NOT IsTemporary) AND Attachment2.GET(Attachment."No.") THEN
                            IF Attachment2."Last Time Modified" <> Attachment."Last Time Modified" THEN BEGIN
                                DeleteFile(FileName);
                                IF NewFileName <> FileName THEN
                                    IF CONFIRM(STRSUBSTNO(Text022, NewFileName), FALSE) THEN
                                        DeleteFile(NewFileName);
                                ERROR(STRSUBSTNO(Text023, Attachment.TABLECAPTION));
                            END;
                        Attachment.ImportAttachment(NewFileName, IsTemporary, IsInherited);
                        DeleteFile(NewFileName);
                        DocImported := TRUE;
                    END;
                END;

        CLEAR(WordHandler);
        DeleteFile(FileName);

        //Rev01 Chaitanya Commented old Code
        /*
        CREATE(wrdHandler,FALSE,TRUE);
        NewFileName := wrdHandler.WaitForDocument(wrdDoc);
        
        IF NOT AttachmentGet."Read Only" THEN
          IF wrdHandler.DocIsClosed THEN
            IF wrdHandler.DocChanged THEN BEGIN
              CLEAR(wrdHandler);
              IF CONFIRM(Text021 + Caption +'?',TRUE) THEN BEGIN
                IF (NOT IsTemporary) AND Attachment2.GET(AttachmentGet."No.") THEN
                  IF Attachment2."Last Time Modified" <> AttachmentGet."Last Time Modified" THEN BEGIN
                    DeleteFile(FileName);
                    IF NewFileName <> FileName THEN
                      IF CONFIRM(
                        STRSUBSTNO(Text022,NewFileName), FALSE)
                      THEN
                        DeleteFile(NewFileName);
                    ERROR(
                      STRSUBSTNO(Text023+Text025,AttachmentGet.TABLECAPTION));
                  END;
          //      Attachment.ImportAttachment(NewFileName,IsTemporary,IsInherited);
                 Attachment.ImportAttachment(NewFileName,IsTemporary,TRUE,AttachmentGet);        // jb
                DeleteFile(NewFileName);
                DocImported := TRUE;
              END;
            END;
        
        IF NOT ISCLEAR(wrdHandler) THEN
          CLEAR(wrdHandler);
        
        DeleteFile(FileName);
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure DeleteFile(FileName: Text[1024]) DeleteOk: Boolean;
    var
        I: Integer;
    begin
        // Wait for Word to release the files
        IF FileName = '' THEN
            EXIT(FALSE);

        IF NOT FileMgt.ClientFileExists(FileName) THEN
            EXIT(TRUE);

        REPEAT
            SLEEP(250);
            I := I + 1;
        UNTIL FileMgt.DeleteClientFile(FileName) OR (I = 25);
        EXIT(NOT FileMgt.ClientFileExists(FileName));

        //Rev01 Chaitanya Commented old Code
        /*
        // Wait for Word to release files
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
        //Rev01 Chaitanya Commented old Code

    end;


    procedure ConstDocFilenameOldNoUse() FileName: Text[260];
    var
        I: Integer;
        DocNo: Text[30];
    begin
        //Rev01 Chaitanya Commented old Code
        /*
        REPEAT
          IF I <> 0 THEN
            DocNo := FORMAT(I);
          FileName := ENVIRON('TEMP') + Text027 + DocNo + '.DOC';
          IF NOT EXISTS(FileName) THEN
            EXIT;
          I := I +1;
        UNTIL I=999;
        
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure ConstMergeSourceFileName() FileName: Text[260];
    var
        DocNo: Text[30];
        I: Integer;
    begin
        //Rev01 Chaitanya Commented old Code
        /*
        REPEAT
          IF I <> 0 THEN
            DocNo := FORMAT(I);
          FileName := ENVIRON('TEMP') + Text029 + DocNo + '.HTM';
          IF NOT EXISTS(FileName) THEN
            EXIT;
          I := I +1;
        UNTIL I=999;
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure OpenWordAttachmentArchive(var AttachmentVoithArchive: Record "Attachments Archive"; FileName: Text[260]; Caption: Text[260]; IsTemporary: Boolean);
    var
        ParamFalse: Boolean;
        MergeFileName: Text[260];
        ParamInt: Integer;
        "--Rev01----": Integer;
        WordApplication: DotNet WordApplicationD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.ApplicationClass" RUNONCLIENT;
        WordDocument: DotNet WordDocumentD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document" RUNONCLIENT;
        WordMergefile: DotNet WordMergefileD;
    //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler" RUNONCLIENT;
    begin
        WordMergefile := WordMergefile.MergeHandler;

        MergeFileName := FileMgt.ClientTempFileName('HTM');
        CreateHeader(WordMergefile, TRUE, MergeFileName);

        WordApplication := WordApplication.ApplicationClass;

        WordDocument := WordHelper.CallOpen(WordApplication, FileName, FALSE, AttachmentVoithArchive."Read Only");

        // Handle Word documents without mergefields
        IF DocumentContainMergefieldsArchive(AttachmentVoithArchive) THEN
            IF ISNULL(WordDocument.MailMerge.MainDocumentType) THEN BEGIN
                WordDocument.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
                WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
            END;

        IF WordDocument.MailMerge.Fields.Count > 0 THEN BEGIN
            ParamInt := 7; // 7 = HTML
            WordHelper.CallMailMergeOpenDataSource(WordDocument, MergeFileName, ParamInt);
        END;

        WordHandlerArchive(WordDocument, AttachmentVoithArchive, Caption, IsTemporary, FileName, FALSE);

        CLEAR(WordMergefile);
        CLEAR(WordDocument);
        WordHelper.CallQuit(WordApplication, FALSE);
        CLEAR(WordApplication);

        DeleteFile(MergeFileName);
        //Rev01 Chaitanya Commented old Code
        /*
        IF ISCLEAR(wrdApp) THEN
          CREATE(wrdApp,FALSE,TRUE);
        IF ISCLEAR(wrdMergefile) THEN
          CREATE(wrdMergefile,FALSE,TRUE);
        
        MergeFileName := ConstMergeSourceFileName;
        //CreateHeader(wrdMergefile,TRUE,MergeFileName);
        ParamFalse := FALSE;
        //KPK//wrdDoc := wrdApp.Documents.Open2000(FileName,ParamFalse,AttachmentVoithArchive."Read Only");
        wrdDoc := wrdApp.Documents.Open2000(FileName,ParamFalse,AttachmentVoithArchive."Read Only");
        IF wrdDoc.MailMerge.MainDocumentType = -1 THEN BEGIN
          wrdDoc.MailMerge.MainDocumentType := 0; // 0 = wdFormLetters
          MergeFileName := ConstMergeSourceFileName;
          //CreateHeader(wrdMergefile,TRUE,MergeFileName); // Header without data
          //wrdDoc.MailMerge.OpenDataSource(MergeFileName,ParamInt);
        END;
        
        IF wrdDoc.MailMerge.Fields.Count > 0 THEN BEGIN
          IF ISCLEAR(wrdMergefile) THEN
            CREATE(wrdMergefile,FALSE,TRUE);
          ParamInt := 7; // 7 = HTML
          //wrdDoc.MailMerge.OpenDataSource(MergeFileName,ParamInt);
        END;
        
        wrdDoc.ActiveWindow.Caption := Caption;
        wrdDoc.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        wrdDoc.Saved := TRUE;
        wrdApp.Visible := TRUE;
        
        WordHandlerArchive(wrdDoc,AttachmentVoithArchive,Caption,IsTemporary,FileName,FALSE);
        
        CLEAR(wrdMergefile);
        CLEAR(wrdDoc);
        CLEAR(wrdApp);
        
        DeleteFile(MergeFileName);
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure WordHandlerArchive(var WordDocument: DotNet WordDocumentD; var AttachmentGetArchive: Record "Attachments Archive"; Caption: Text[260]; IsTemporary: Boolean; FileName: Text[260]; IsInherited: Boolean) DocImported: Boolean;
    //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document"
    var
        Attachment2: Record "Attachments Archive";
        NewFileName: Text[260];
        Attachment: Record "Attachments Archive";
        WordHandler: DotNet WordHandlerD;
    //"'Microsoft.Dynamics.Nav.Integration.Office, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler" RUNONCLIENT;
    begin
        WordHandler := WordHandler.WordHandler;

        WordDocument.ActiveWindow.Caption := Caption;
        WordDocument.Application.Visible := TRUE; // Visible before WindowState KB176866 - http://support.microsoft.com/kb/176866
        WordDocument.ActiveWindow.WindowState := 1; // 1 = wdWindowStateMaximize
        WordDocument.Saved := TRUE;
        WordDocument.Application.Activate;

        NewFileName := WordHandler.WaitForDocument(WordDocument);

        IF NOT Attachment."Read Only" THEN
            IF WordHandler.IsDocumentClosed THEN
                IF WordHandler.HasDocumentChanged THEN BEGIN
                    CLEAR(WordHandler);
                    IF CONFIRM(Text021 + Caption + '?', TRUE) THEN BEGIN
                        IF (NOT IsTemporary) AND Attachment2.GET(Attachment."No.") THEN
                            IF Attachment2."Last Time Modified" <> Attachment."Last Time Modified" THEN BEGIN
                                DeleteFile(FileName);
                                IF NewFileName <> FileName THEN
                                    IF CONFIRM(STRSUBSTNO(Text022, NewFileName), FALSE) THEN
                                        DeleteFile(NewFileName);
                                ERROR(STRSUBSTNO(Text023, Attachment.TABLECAPTION));
                            END;
                        Attachment.ImportAttachment(NewFileName, IsTemporary, IsInherited);
                        DeleteFile(NewFileName);
                        DocImported := TRUE;
                    END;
                END;

        CLEAR(WordHandler);
        DeleteFile(FileName);

        //Rev01 Chaitanya Commented old Code
        /*
        CREATE(wrdHandler,FALSE,TRUE);
        NewFileName := wrdHandler.WaitForDocument(wrdDoc);
        
        IF NOT AttachmentGetArchive."Read Only" THEN
          IF wrdHandler.DocIsClosed THEN
            IF wrdHandler.DocChanged THEN BEGIN
              CLEAR(wrdHandler);
              IF CONFIRM(Text021 + Caption +'?',TRUE) THEN BEGIN
                IF (NOT IsTemporary) AND Attachment2.GET(AttachmentGetArchive."No.") THEN
                  IF Attachment2."Last Time Modified" <> AttachmentGetArchive."Last Time Modified" THEN BEGIN
                    DeleteFile(FileName);
                    IF NewFileName <> FileName THEN
                      IF CONFIRM(
                        STRSUBSTNO(Text022,NewFileName), FALSE)
                      THEN
                        DeleteFile(NewFileName);
                    ERROR(
                      STRSUBSTNO(Text023+Text025,AttachmentGetArchive.TABLECAPTION));
                  END;
          //      Attachment.ImportAttachment(NewFileName,IsTemporary,IsInherited);
        //         Attachment.ImportAttachment(NewFileName,IsTemporary,TRUE,AttachmentGetarchive);        // jb
                DeleteFile(NewFileName);
                DocImported := TRUE;
              END;
            END;
        
        IF NOT ISCLEAR(wrdHandler) THEN
          CLEAR(wrdHandler);
        
        DeleteFile(FileName);
        */
        //Rev01 Chaitanya Commented old Code

    end;


    procedure "--Rev01NewFunctions--"();
    begin
    end;


    procedure IsWordDocumentExtension(FileExtension: Text): Boolean;
    begin
        //Rev01 Chaitanya Commented old Code
        /*
        IF (UPPERCASE(FileExtension) <> 'DOC') AND
           (UPPERCASE(FileExtension) <> 'DOCX') AND
           (UPPERCASE(FileExtension) <> '.DOC') AND
           (UPPERCASE(FileExtension) <> '.DOCX')
        THEN
          EXIT(FALSE);
        
        EXIT(TRUE);
        
        */
        //Rev01 Chaitanya Commented old Code

    end;



    PROCEDURE CreateHeader(VAR WordMergefile: DotNet WordMergefileD; MergeFieldsOnly: Boolean; MergeFileName: Text);
    VAR
        Salesperson: Record 13;
        Country: Record 9;
        Contact: Record 5050;
        SegLine: Record 5077;
        CompanyInfo: Record 79;
        RMSetup: Record 5079;
        InteractionLogEntry: Record 5065;
        //Language: Record 8;
        I: Integer;
        MainLanguage: Integer;
        CreateOk: Boolean;
        Text015: Label 'FaxMailTo';
        Text017: Label 'The merge source file is locked by another process.\';
        Text018: label 'Please try again later.';
        Text019: Label ' Mail Address';
        Text030: Label 'Formal Salutation';
        Text031: Label 'Informal Salutation';
        Text032: Label '*.htm|*.htm';
    BEGIN
        CreateOk := TRUE;
        IF NOT WordMergefile.CreateMergeFile(MergeFileName) THEN
            ERROR(Text017 + Text018);

        // Create HTML Header source
        WITH WordMergefile DO BEGIN
            MainLanguage := GLOBALLANGUAGE;

            IF AttachmentLanguageCode = '' THEN BEGIN
                RMSetup.GET;
                IF RMSetup."Mergefield Language ID" <> 0 THEN
                    GLOBALLANGUAGE := RMSetup."Mergefield Language ID";
            END ELSE
                // GLOBALLANGUAGE := Language.GetLanguageID(AttachmentLanguageCode);//EFFUPG
                GlobalLanguage := Language.GetLanguageIdOrDefault(AttachmentLanguageCode);//EFFUPG
            AddField(InteractionLogEntry.FIELDCAPTION("Entry No."));
            AddField(Contact.TABLECAPTION + Text019);
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("No."));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Company Name"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(Name));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Name 2"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(Address));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Address 2"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Post Code"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(City));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION(County));
            AddField(Contact.TABLECAPTION + ' ' + Country.TABLECAPTION + ' ' + Country.FIELDCAPTION(Name));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Job Title"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Phone No."));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Fax No."));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("E-Mail"));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Mobile Phone No."));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("VAT Registration No."));
            AddField(Contact.TABLECAPTION + ' ' + Contact.FIELDCAPTION("Home Page"));
            AddField(Text030);
            AddField(Text031);
            AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION(Code));
            AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION(Name));
            AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("Job Title"));
            AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("Phone No."));
            AddField(Salesperson.TABLECAPTION + ' ' + Salesperson.FIELDCAPTION("E-Mail"));
            AddField(Text020 + SegLine.FIELDCAPTION(Date));
            AddField(Text020 + SegLine.FIELDCAPTION("Campaign No."));
            AddField(Text020 + SegLine.FIELDCAPTION("Segment No."));
            AddField(Text020 + SegLine.FIELDCAPTION(Description));
            AddField(Text020 + SegLine.FIELDCAPTION(Subject));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Name));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Name 2"));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(Address));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Address 2"));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Post Code"));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(City));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION(County));
            AddField(CompanyInfo.TABLECAPTION + ' ' + Country.TABLECAPTION + ' ' + Country.FIELDCAPTION(Name));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("VAT Registration No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Registration No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Phone No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Fax No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Branch No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Name"));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Bank Account No."));
            AddField(CompanyInfo.TABLECAPTION + ' ' + CompanyInfo.FIELDCAPTION("Giro No."));
            GLOBALLANGUAGE := MainLanguage;
            AddField(Text015);

            WriteLine;

            // Mergesource must be at least two lines
            IF MergeFieldsOnly THEN BEGIN
                FOR I := 1 TO 48 DO
                    AddField('');
                WriteLine;
                CloseMergeFile;
            END;
        END;
    END;



    procedure GetWordDocumentExtension(VersionTxt: Text[30]): Code[4];
    var
        Version: Decimal;
        SeparatorPos: Integer;
        CommaStr: Code[1];
        DefaultStr: Code[10];
        EvalOK: Boolean;
    begin
        DefaultStr := 'DOC';
        SeparatorPos := STRPOS(VersionTxt, '.');
        IF SeparatorPos = 0 THEN
            SeparatorPos := STRPOS(VersionTxt, ',');
        IF SeparatorPos = 0 THEN
            EvalOK := EVALUATE(Version, VersionTxt)
        ELSE BEGIN
            CommaStr := COPYSTR(FORMAT(11 / 10), 2, 1);
            EvalOK := EVALUATE(Version, COPYSTR(VersionTxt, 1, SeparatorPos - 1) + CommaStr + COPYSTR(VersionTxt, SeparatorPos + 1));
        END;
        IF EvalOK AND (Version >= 12.0) THEN
            EXIT('DOCX');
        EXIT(DefaultStr);
    end;


    local procedure DocumentContainMergefields(var Attachment: Record Attachments) MergeFields: Boolean;
    var
        WordApplication: DotNet WordApplicationD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.ApplicationClass"

        WordDocument: DotNet WordDocumentD;
        //"'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document" RUNONCLIENT
        ParamBln: Boolean;
        FileName: Text;
    begin
        WordApplication := WordApplication.ApplicationClass;
        IF (UPPERCASE(Attachment."File Extension") <> 'DOC') AND
           (UPPERCASE(Attachment."File Extension") <> 'DOCX')
        THEN
            EXIT(FALSE);
        FileName := Attachment.ConstFileName;
        Attachment.ExportAttachment(FileName);
        WordDocument := WordHelper.CallOpen(WordApplication, FileName, FALSE, FALSE);

        MergeFields := (WordDocument.MailMerge.Fields.Count > 0);
        ParamBln := FALSE;
        WordHelper.CallClose(WordDocument, ParamBln);
        DeleteFile(FileName);

        CLEAR(WordDocument);
        WordHelper.CallQuit(WordApplication, FALSE);
        CLEAR(WordApplication);
    end;


    local procedure DocumentContainMergefieldsArchive(var Attachment: Record "Attachments Archive") MergeFields: Boolean;
    var
        // WordApplication: DotNet "'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.ApplicationClass" RUNONCLIENT;//EFFUPG
        WordApplication: DotNet WordApplicationD;//EFFUPG
                                                 // WordDocument: DotNet "'Microsoft.Office.Interop.Word, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Word.Document" RUNONCLIENT;//EFFUPG
        WordDocument: DotNet WordDocumentD;//EFFUPG
        ParamBln: Boolean;
        FileName: Text;
    begin
        WordApplication := WordApplication.ApplicationClass;
        IF (UPPERCASE(Attachment."File Extension") <> 'DOC') AND
           (UPPERCASE(Attachment."File Extension") <> 'DOCX')
        THEN
            EXIT(FALSE);
        FileName := Attachment.ConstFileName;
        Attachment.ExportAttachment(FileName);
        WordDocument := WordHelper.CallOpen(WordApplication, FileName, FALSE, FALSE);

        MergeFields := (WordDocument.MailMerge.Fields.Count > 0);
        ParamBln := FALSE;
        WordHelper.CallClose(WordDocument, ParamBln);
        DeleteFile(FileName);

        CLEAR(WordDocument);
        WordHelper.CallQuit(WordApplication, FALSE);
        CLEAR(WordApplication);
    end;

    var
        Language: Codeunit Language;
}

