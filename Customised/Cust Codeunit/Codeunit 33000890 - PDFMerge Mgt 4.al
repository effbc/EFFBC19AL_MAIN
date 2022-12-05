codeunit 33000890 "PDFMerge Mgt 4"
{
    // version B2BQTO


    trigger OnRun();
    begin
        //POandTermsPrint_gFnc;

        //MergePDFFiles(String,'D:\Images\3.pdf');
    end;

    var
        Text50000_gCtx: Label 'Purchase Order %1 Must be Authorized to Print.';
        Text000: TextConst ENU = '%1\PdfMerge output=%2 input=%3,%4';


    procedure MergePDFFile_gFnc(CMDCmd_iTxt: Text);
    var
        CMDCmd_lTxt: Text;
        // WShell_gAut: Automation "'{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0:'{72C24DD5-D70A-438B-8A42-98424B88AFB8}':''{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0'.WshShell";
        DummyInt_gInt: Integer;
        WaitOnReturn_gBln: Boolean;
    begin
        //CLEAR(WShell_gAut);
        //   DummyInt_gInt := 0;  //0 = to Hide CMS Screen and 1
        //WaitOnReturn_gBln := FALSE;
        //  CREATE(WShell_gAut, TRUE, TRUE);
        // WShell_gAut.Run(CMDCmd_iTxt, DummyInt_gInt, WaitOnReturn_gBln);
        // CLEAR(WShell_gAut); 
        //B2BUPG
    end;


    procedure "------- Merge PDF Document -------------"();
    begin
    end;


    procedure POandTermsPrint_gFnc();
    var
        PH_lRec: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        POCode_lCod: Code[20];
        ServerFileName_lTxt: Text;
        ServerSharedPath_lTxt: Text;
        UniqueString_lTxt: Text;
        CMDCommand_lTxt: Text;
        POTermFile_lTxt: Text;
        OutputFilePath_lTxt: Text;
        R405: Report "Order";
        NewNoOfCopies: Integer;
        NewShowInternalInfo: Boolean;
        NewArchiveDocument: Boolean;
        NewLogInteraction: Boolean;
        ExciseInclusive_iBln: Boolean;
        ExciseAtActual_iBln: Boolean;
        VATInclusive_iBln: Boolean;
        VATAtActual_iBln: Boolean;
        BOMprint_iBln: Boolean;
    begin
        OutputFilePath_lTxt := '\\satish\Test\abcd.pdf';
        ServerSharedPath_lTxt := '\\satish\Test';
        IF EXISTS(OutputFilePath_lTxt) THEN
            ERASE(OutputFilePath_lTxt);
        CMDCommand_lTxt := STRSUBSTNO(Text000, ServerSharedPath_lTxt, OutputFilePath_lTxt, '\\satish\Test\1.pdf', '\\satish\Test\2.pdf');
        POCode_lCod := 'xyzwe';
        MergePDFFile_gFnc(CMDCommand_lTxt);
        SLEEP(3000);
    end;


    procedure UpdatePath_gFnc(var Path_vTxt: Text[250]);
    begin
        IF COPYSTR(Path_vTxt, STRLEN(Path_vTxt), 1) <> '\' THEN
            Path_vTxt := Path_vTxt + '\';
    end;


    procedure ExportAttToClientFile_gFnc(var ExportToFile: Text; ImportFileName_iTxt: Text[250]): Boolean;
    var
        FileMgmt_lCdu: Codeunit "File Management";
        FileExtension_lTxt: Text[100];
        FileFilter_lTxt: Text[100];
        Text024_gTxt: Label 'Export File';
    begin
        FileExtension_lTxt := FileMgmt_lCdu.GetExtension(ExportToFile);
        FileFilter_lTxt := UPPERCASE(FileExtension_lTxt) + ' (*.' + FileExtension_lTxt + ')|*.' + FileExtension_lTxt;
        DOWNLOAD(ExportToFile, Text024_gTxt, '', FileFilter_lTxt, ImportFileName_iTxt);
    end;


    local procedure "---Using Dotnet Variable----"();
    begin
    end;


    procedure MergePDFFiles(PDFFile1: Text; PDFFile2: Text; PDFFile3: Text; PDFFile4: Text; PDFFile5: Text; NewPDFFile: Text);
    var
        PDFDocOut: DotNet  PDFDocOutD;
        // "'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.PdfDocument";
    begin
        PDFDocOut := PDFDocOut.PdfDocument;

        IF PDFFile1 <> '' THEN
            AddPages(PDFFile1, PDFDocOut);
        IF PDFFile2 <> '' THEN
            AddPages(PDFFile2, PDFDocOut);
        IF PDFFile3 <> '' THEN
            AddPages(PDFFile3, PDFDocOut);
        IF PDFFile4 <> '' THEN
            AddPages(PDFFile4, PDFDocOut);
        IF PDFFile5 <> '' THEN
            AddPages(PDFFile5, PDFDocOut);

        IF EXISTS(NewPDFFile) THEN
            ERASE(NewPDFFile);

        PDFDocOut.Save(NewPDFFile);
        PDFDocOut.Close;
        PDFDocOut.Dispose;
    end;


    local procedure AddPages(PDFFileName: Text; var DestPDF: DotNet PDFDocOutD)
    //"'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.PdfDocument");
    var
        FromPDF: DotNet PDFDocOutD;
        //"'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.PdfDocument";
        PDFReader: DotNet PDFReaderD;
        //"'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.IO.PdfReader";
        PDFOpenDocMode: DotNet PDFOpenDocModeD;
        //"'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.IO.PdfDocumentOpenMode";
        i: Integer;
    begin
        FromPDF := PDFReader.Open(PDFFileName, PDFOpenDocMode.Import);

        FOR i := 0 TO FromPDF.PageCount - 1 DO
            DestPDF.AddPage(FromPDF.Pages.Item(i));

        FromPDF.Close;
        FromPDF.Dispose;
    end;


    procedure MergePDFFilesForAttachment(PDFFile1: Text; PDFFile2: Text; PDFFile3: Text; PDFFile4: Text; PDFFile5: Text; NewPDFFile: Text);
    var
        PDFDocOut: DotNet PDFDocOutD;
    //"'PdfSharp, Version=1.0.898.0, Culture=neutral, PublicKeyToken=f94615aa0424f9eb'.PdfSharp.Pdf.PdfDocument";
    begin
        PDFDocOut := PDFDocOut.PdfDocument;

        IF PDFFile1 <> '' THEN
            AddPages(PDFFile1, PDFDocOut);
        IF PDFFile2 <> '' THEN
            AddPages(PDFFile2, PDFDocOut);
        IF PDFFile3 <> '' THEN
            AddPages(PDFFile3, PDFDocOut);
        IF PDFFile4 <> '' THEN
            AddPages(PDFFile4, PDFDocOut);
        IF PDFFile5 <> '' THEN
            AddPages(PDFFile5, PDFDocOut);

        IF EXISTS(NewPDFFile) THEN
            ERASE(NewPDFFile);

        PDFDocOut.Save(NewPDFFile);
        PDFDocOut.Close;
        PDFDocOut.Dispose;
    end;
}

