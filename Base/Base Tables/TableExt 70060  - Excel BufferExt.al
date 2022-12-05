tableextension 70060 ExcelBufferExt extends "Excel Buffer"
{

    fields
    {
        field(50000; "Font Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Font Size"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Font Color"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Background Color"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Using Custom Format"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
    PROCEDURE SaveBom(No: Text[30]);
    var
        XlWrkBk: DotNet XlWrkBkD;
    BEGIN
        //XlWrkBk := XlApp.ActiveWorkbook;
        str := '';
        fname1 := '';
        str := No;
        while StrPos(str, '/') > 1 do begin
            fname1 := fname1 + CopyStr(str, 1, StrPos(str, '/') - 1) + '_';
            str := CopyStr(str, StrPos(str, '/') + 1);
        end;
        fname1 := fname1 + str;

        XlWrkBk.SaveCopyAs('\\erpserver\erpattachments\Explosion of Bom\BOM_' + fname1 + '.xls');
        //XlWrkBk.SaveAs('d:\BOM_'+fname1+'.xls');
        //XlWrkBk.Close(FALSE);
        //CLEAR(XlApp);
        //XlApp.Quit;

    END;

    PROCEDURE SaveRout(No: Text[30]);
    var
        XlWrkBk: DotNet XlWrkBkD;
    BEGIN
        //XlWrkBk := XlApp.ActiveWorkbook;
        fname1 := '';
        str := '';
        str := No;
        while StrPos(str, '/') > 1 do begin
            fname1 := fname1 + CopyStr(str, 1, StrPos(str, '/') - 1) + '_';
            str := CopyStr(str, StrPos(str, '/') + 1);
        end;
        fname1 := fname1 + str;
        XlWrkBk.SaveCopyAs('\\erpserver\erpattachments\routing\Routing_' + fname1 + '.xls');
        //XlWrkBk.SaveAs('d:\Routing_'+fname1+'.xls');
        //XlWrkBk.Close(FALSE);
        //XlApp.Quit;
    END;


    PROCEDURE MergeRange(FromRow: Integer; FromCol: Integer; ToRow: Integer; ToCol: Integer);
    VAR
        FromRec: Record "Excel Buffer";
        ToRec: Record "Excel Buffer";
        XlApp: DotNet XlAppD;
        XlWrkBk: DotNet XlWrkBkD;
        XlWrkSht: DotNet XlWrkShtD;
        // XlHelper: Dotnet ExcelHelperD;//EFFUPG
        ActiveSheetName: text;
        XlWrkShtWriter: DotNet WorksheetWriter;
    BEGIN
        // Pranavi
        FromRec.Validate("Row No.", FromRow);
        FromRec.Validate("Column No.", FromCol);
        ToRec.Validate("Row No.", ToRow);
        ToRec.Validate("Column No.", ToCol);
        Message(Format(XlWrkBkWriter.SheetNames));
        Message(XlWrkShtWriter.Name);
        XlApp := XlApp.ApplicationClass;

        //XlWrkBk := XlApp.Workbooks.Open();
        XlWrkBk := XlApp.ActiveWorkbook;
        XlWrkBk.Activate();
        // XlHelper.ActivateSheet(XlWrkBk, ActiveSheetName);//EFFUPG
        XlWrkSht := XlApp.ActiveSheet;
        XlWrkSht := XlWrkBk.ActiveSheet;
        //XlWrkSht.Range(FromRec.xlColID + FromRec.xlRowID + ':' + ToRec.xlColID + ToRec.xlRowID).Select;
        //XlWrkSht.Range(FromRec.xlColID + FromRec.xlRowID).HorizontalAlignment := -4108;
        //XlWrkSht.Range(FromRec.xlColID + FromRec.xlRowID + ':' + ToRec.xlColID + ToRec.xlRowID).cells.Merge;
        XlWrkSht.Range(FromRec.xlColID + FromRec.xlRowID + ':' + ToRec.xlColID + ToRec.xlRowID).Merge(true);
        // Pranavi End
    END;


    LOCAL PROCEDURE GetCellDecoratorWithFontsold(IsBold: Boolean; IsItalic: Boolean; IsUnderlined: Boolean; VAR Decorator: DotNet CellDecoraterD; FontName: Text; FontSize: Integer; FontColor: Integer; BackgroundColor: Integer);
    VAR
        //EFFUPG>>
        /*
        CustomFont: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Font";
        XMLStringValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.StringValue";
        CustomFontName: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.FontName";
        CustomFontSize: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.FontSize";
        FontSizeValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.DoubleValue";
        CustomColor: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Color";
        HexColor: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.HexBinaryValue";
        Fonts: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Fonts";
        CustomCellFill: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Fill";
        CustomCellPatternFill: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.PatternFill";
        HexBackGroundColour: Text;
        CustomFontBold: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Bold";
        CustomFontItalic: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Italic";
        CustomFontUnderLine: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Underline";
        XMLBooleanValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.BooleanValue";
        ValueSet: Boolean;
        */
        CustomFont: DotNet CustomFontD;
        XMLStringValue: DotNet XMLStringValueD;
        CustomFontName: DotNet CustomFontNameD;
        CustomFontSize: DotNet CustomFontSizeD;
        FontSizeValue: DotNet FontSizeValueD;
        CustomColor: DotNet CustomColorD;
        HexColor: DotNet HexColorD;
        Fonts: DotNet FontsD;
        CustomCellFill: DotNet CustomCellFillD;
        CustomCellPatternFill: DotNet CustomCellPatternFillD;
        HexBackGroundColour: Text;
        CustomFontBold: DotNet CustomFontBoldD;
        CustomFontItalic: DotNet CustomFontItalicD;
        CustomFontUnderLine: DotNet CustomFontUnderLineD;
        XMLBooleanValue: DotNet XMLBooleanValueD;
        ValueSet: Boolean;
        XlWrkShtWriter: DotNet WorksheetWriter;


    //EFFUPG<<

    BEGIN

        IF IsBold AND IsItalic AND IsUnderlined THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldItalicUnderlinedCellDecorator;
        END;

        IF IsBold AND IsItalic THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldItalicCellDecorator;
        END;

        IF IsBold AND IsUnderlined THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldUnderlinedCellDecorator;
        END;

        IF IsBold THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldCellDecorator;
        END;

        IF IsItalic AND IsUnderlined THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultItalicUnderlinedCellDecorator;
        END;

        IF IsItalic THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultItalicCellDecorator;
        END;

        IF IsUnderlined THEN
            Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator
        ELSE
            Decorator := XlWrkShtWriter.DefaultCellDecorator;
        //>>Pranavi
        //>>#Saurav-NAV.19.00.ExcelFont BEGIN
        CLEAR(ValueSet);

        IF IsUnderlined THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator;
            ValueSet := TRUE;
        END;

        /*
         IF IsDoubleUnderlined THEN BEGIN
             Decorator := XlWrkShtWriter.DefaultDoubleUnderlinedCellDecorator;
             ValueSet := TRUE;
         END;
         */

        IF NOT ValueSet THEN
            Decorator := XlWrkShtWriter.DefaultCellDecorator;

        Fonts := XlWrkBkWriter.Workbook.WorkbookPart.WorkbookStylesPart.Stylesheet.Fonts;
        CustomFont := Decorator.Font;

        IF FontName <> '' THEN BEGIN
            CustomFont := CustomFont.Font;
            CustomFontName := CustomFontName.FontName;
            CustomFontName.Val := XMLStringValue.StringValue(FontName);
            CustomFont.FontName := CustomFontName;
        END;

        IF FontSize <> 0 THEN BEGIN
            CustomFontSize := CustomFontSize.FontSize;
            CustomFontSize.Val := FontSizeValue.DoubleValue(FontSize);
            CustomFont.FontSize := CustomFontSize;
        END;

        IF FontColor <> 0 THEN BEGIN
            CustomColor := CustomColor.Color;
            CASE FontColor OF
                1:
                    CustomColor.Rgb := HexColor.HexBinaryValue('00FF0000'); // Red
                2:
                    CustomColor.Rgb := HexColor.HexBinaryValue('001B1BC3'); // Blue
                3:
                    CustomColor.Rgb := HexColor.HexBinaryValue('0022B400'); // Green
                4:
                    CustomColor.Rgb := HexColor.HexBinaryValue('009E0808'); // Maroon
                5:
                    CustomColor.Rgb := HexColor.HexBinaryValue('00FFA500'); // Orange
            END;
            CustomFont.Color := CustomColor;
        END;
        // FOR MORE COLORS REFER - http://www.mathsisfun.com/numbers/color-wheel-interactive.html
        // APPEND 00 on the Result Found above & Add one more option in case statement.

        IF BackgroundColor <> 0 THEN BEGIN
            HexBackGroundColour := '';
            CASE BackgroundColor OF
                1:
                    HexBackGroundColour := '00FF0000'; // Red
                2:
                    HexBackGroundColour := '001B1BC3'; // Blue
                3:
                    HexBackGroundColour := '0022B400'; // Green
                4:
                    HexBackGroundColour := '009E0808'; // Maroon
                5:
                    HexBackGroundColour := '00FFA500'; // Orange
            END;

            // FOR MORE COLORS REFER - http://www.mathsisfun.com/numbers/color-wheel-interactive.html
            // APPEND 00 on the Result Found above & Add one more option in case statement.

            CustomCellFill := Decorator.Fill.CloneNode(TRUE);
            CustomCellPatternFill := CustomCellPatternFill.PatternFill(
                                        '<x:patternFill xmlns:x="http://schemas.openxmlformats.org/spreadsheetml/2006/main" ' + 'patternType="' + 'solid' + '">' +
                                        '<x:fgColor rgb="' + HexBackGroundColour + '" /></x:patternFill>');
            CustomCellFill.PatternFill := CustomCellPatternFill;
            Decorator.Fill := CustomCellFill;
        END;

        IF IsBold THEN BEGIN
            CustomFontBold := CustomFontBold.Bold;
            CustomFontBold.Val := XMLBooleanValue.BooleanValue(TRUE);
            CustomFont.Bold := CustomFontBold;
        END;

        IF IsItalic THEN BEGIN
            CustomFontItalic := CustomFontItalic.Italic;
            CustomFontItalic.Val := XMLBooleanValue.BooleanValue(TRUE);
            CustomFont.Italic := CustomFontItalic;
        END;

        Decorator.Font := CustomFont;
        //<<#Saurav-NAV.19.00.ExcelFont END
        //<<Pranavi

    END;


    PROCEDURE AddColumnWithFontsold(Value: Variant; IsFormula: Boolean; CommentText: Text[1000]; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option; FontName: Text; FontSize: Integer; FontColor: Integer; BGColor: Integer; UsingCustomFormat: Boolean);
    BEGIN

        IF CurrentRow < 1 THEN
            NewRow;

        CurrentCol := CurrentCol + 1;
        INIT;
        VALIDATE("Row No.", CurrentRow);
        VALIDATE("Column No.", CurrentCol);
        IF IsFormula THEN
            SetFormula(FORMAT(Value))
        ELSE
            "Cell Value as Text" := FORMAT(Value);
        Comment := CommentText;
        Bold := IsBold;
        Italic := IsItalics;
        Underline := IsUnderline;
        NumberFormat := NumFormat;
        "Cell Type" := CellType;
        "Font Name" := FontName;
        "Font Size" := FontSize;
        "Font Color" := FontColor;
        "Background Color" := BGColor;
        UsingCustomFormat := UsingCustomFormat;
        INSERT;

    END;


    LOCAL PROCEDURE "---EFFUPG--"();
    BEGIN
    END;


    PROCEDURE AddColumnWithFont(Value: Variant; IsFormula: Boolean; CommentText: Text[1000]; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option; FontName: Text; FontSize: Integer; FontColor: Integer; BGColor: Integer; UsingCustomFormat: Boolean);
    BEGIN
        if CurrentRow < 1 then
            NewRow;

        CurrentCol := CurrentCol + 1;
        Init;
        Validate("Row No.", CurrentRow);
        Validate("Column No.", CurrentCol);
        if IsFormula then
            SetFormula(Format(Value))
        else
            "Cell Value as Text" := Format(Value);
        Comment := CommentText;
        Bold := IsBold;
        Italic := IsItalics;
        Underline := IsUnderline;
        NumberFormat := NumFormat;
        "Cell Type" := CellType;
        //EFFUPG>>
        "Font Name" := FontName;
        "Font Size" := FontSize;
        "Font Color" := FontColor;
        "Background Color" := BGColor;
        "Using Custom Format" := UsingCustomFormat;
        //EFFUPG<<

        Insert;
    END;


    LOCAL PROCEDURE GetCellDecoratorWithFonts(IsBold: Boolean; IsItalic: Boolean; IsUnderlined: Boolean; IsDoubleUnderlined: Boolean; VAR Decorator: DotNet CellDecoraterD; FontName: Text; FontSize: Integer; FontColor: Integer; BGColor: Integer);
    VAR
        //EFFUPG>>
        /*
        CustomFont: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Font";
        XMLStringValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.StringValue";
        CustomFontName: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.FontName";
        CustomFontSize: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.FontSize";
        FontSizeValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.DoubleValue";
        CustomColor: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Color";
        HexColor: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.HexBinaryValue";
        Fonts: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Fonts";
        CustomCellFill: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Fill";
        CustomCellPatternFill: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.PatternFill";
        HexBackGroundColour: Text;
        CustomFontBold: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Bold";
        CustomFontItalic: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Italic";
        CustomFontUnderLine: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.Underline";
        XMLBooleanValue: DotNet "'DocumentFormat.OpenXml, Version=2.0.5022.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.BooleanValue";
        ValueSet: Boolean;
        */
        CustomFont: DotNet CustomFontD;
        XMLStringValue: DotNet XMLStringValueD;
        CustomFontName: DotNet CustomFontNameD;
        CustomFontSize: DotNet CustomFontSizeD;
        FontSizeValue: DotNet FontSizeValueD;
        CustomColor: DotNet CustomColorD;
        HexColor: DotNet HexColorD;
        Fonts: DotNet FontsD;
        CustomCellFill: DotNet CustomCellFillD;
        CustomCellPatternFill: DotNet CustomCellPatternFillD;
        HexBackGroundColour: Text;
        CustomFontBold: DotNet CustomFontBoldD;
        CustomFontItalic: DotNet CustomFontItalicD;
        CustomFontUnderLine: DotNet CustomFontUnderLineD;
        XMLBooleanValue: DotNet XMLBooleanValueD;
        ValueSet: Boolean;
        XlWrkBkWriter: DotNet WorkbookWriter;
        XlWrkBkReader: DotNet WorkbookReader;
        XlWrkShtWriter: DotNet WorksheetWriter;
        XlWrkShtReader: DotNet WorksheetReader;


    //EFFUPG<<

    BEGIN

        IF IsBold AND IsItalic THEN BEGIN
            IF IsDoubleUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultBoldItalicDoubleUnderlinedCellDecorator;
                EXIT;
            END;
            IF IsUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultBoldItalicUnderlinedCellDecorator;
                EXIT;
            END;
        END;

        IF IsBold AND IsItalic THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldItalicCellDecorator;
            EXIT;
        END;

        IF IsBold THEN BEGIN
            IF IsDoubleUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultBoldDoubleUnderlinedCellDecorator;
                EXIT;
            END;
            IF IsUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultBoldUnderlinedCellDecorator;
                EXIT;
            END;
        END;

        IF IsBold THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultBoldCellDecorator;
            EXIT;
        END;

        IF IsItalic THEN BEGIN
            IF IsDoubleUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultItalicDoubleUnderlinedCellDecorator;
                EXIT;
            END;
            IF IsUnderlined THEN BEGIN
                Decorator := XlWrkShtWriter.DefaultItalicUnderlinedCellDecorator;
                EXIT;
            END;
        END;

        IF IsItalic THEN BEGIN
            Decorator := XlWrkShtWriter.DefaultItalicCellDecorator;
            EXIT;
        END;

        IF IsDoubleUnderlined THEN
            Decorator := XlWrkShtWriter.DefaultDoubleUnderlinedCellDecorator
        ELSE BEGIN
            IF IsUnderlined THEN
                Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator
            ELSE
                Decorator := XlWrkShtWriter.DefaultCellDecorator;
        END;


        //EFFUPG>>
        Clear(ValueSet);

        if IsUnderlined then begin
            Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator;
            ValueSet := true;
        end;

        if IsDoubleUnderlined then begin
            Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator;
            ValueSet := true;
        end;

        if not ValueSet then
            Decorator := XlWrkShtWriter.DefaultCellDecorator;

        Fonts := XlWrkBkWriter.Workbook.WorkbookPart.WorkbookStylesPart.Stylesheet.Fonts;
        CustomFont := Decorator.Font;

        if FontName <> '' then begin
            CustomFont := CustomFont.Font;
            CustomFontName := CustomFontName.FontName;
            CustomFontName.Val := XMLStringValue.StringValue(FontName);
            CustomFont.FontName := CustomFontName;
        end;

        if FontSize <> 0 then begin
            CustomFontSize := CustomFontSize.FontSize;
            CustomFontSize.Val := FontSizeValue.DoubleValue(FontSize);
            CustomFont.FontSize := CustomFontSize;
        end;

        if FontColor <> 0 then begin
            CustomColor := CustomColor.Color;
            case FontColor of
                1:
                    CustomColor.Rgb := HexColor.HexBinaryValue('00FF0000'); // Red
                2:
                    CustomColor.Rgb := HexColor.HexBinaryValue('001B1BC3'); // Blue
                3:
                    CustomColor.Rgb := HexColor.HexBinaryValue('0022B400'); // Green
                4:
                    CustomColor.Rgb := HexColor.HexBinaryValue('009E0808'); // Maroon
                5:
                    CustomColor.Rgb := HexColor.HexBinaryValue('00FFA500'); // Orange
            end;
            CustomFont.Color := CustomColor;
        end;
        // FOR MORE COLORS REFER - http://www.mathsisfun.com/numbers/color-wheel-interactive.html
        // APPEND 00 on the Result Found above & Add one more option in case statement.

        if BGColor <> 0 then begin
            HexBackGroundColour := '';
            case BGColor of
                1:
                    HexBackGroundColour := '00FF0000'; // Red
                2:
                    HexBackGroundColour := '001B1BC3'; // Blue
                3:
                    HexBackGroundColour := '0022B400'; // Green
                4:
                    HexBackGroundColour := '009E0808'; // Maroon
                5:
                    HexBackGroundColour := '00FFA500'; // Orange
            end;

            // FOR MORE COLORS REFER - http://www.mathsisfun.com/numbers/color-wheel-interactive.html
            // APPEND 00 on the Result Found above & Add one more option in case statement.

            CustomCellFill := Decorator.Fill.CloneNode(true);
            CustomCellPatternFill := CustomCellPatternFill.PatternFill(
                                        '<x:patternFill xmlns:x="http://schemas.openxmlformats.org/spreadsheetml/2006/main" ' + 'patternType="' + 'solid' + '">' +
                                        '<x:fgColor rgb="' + HexBackGroundColour + '" /></x:patternFill>');
            CustomCellFill.PatternFill := CustomCellPatternFill;
            Decorator.Fill := CustomCellFill;
        end;

        if IsBold then begin
            CustomFontBold := CustomFontBold.Bold;
            CustomFontBold.Val := XMLBooleanValue.BooleanValue(true);
            CustomFont.Bold := CustomFontBold;
        end;

        if IsItalic then begin
            CustomFontItalic := CustomFontItalic.Italic;
            CustomFontItalic.Val := XMLBooleanValue.BooleanValue(true);
            CustomFont.Italic := CustomFontItalic;
        end;

        Decorator.Font := CustomFont;
        //EFFUPG<<
    END;


    PROCEDURE CreateBookAndSaveExcel(FileName: Text; SheetName: Text[250]; ReportHeader: Text; CompanyName2: Text; UserID2: Text);
    BEGIN
        CreateBook(FileName, SheetName);
        WriteSheet(ReportHeader, CompanyName2, UserID2);
        CloseBook;
        //SaveExcel;
    END;


    PROCEDURE SaveExcel(File_Path: Text; File_Name: Text);
    VAR
        FileNameClient: Text;
        fname1: Text;
        str: Text;
        XlWrkBk: DotNet XlWrkBkD;
    BEGIN
        str := '';
        fname1 := '';
        str := File_Name;
        while StrPos(str, '/') > 1 do begin
            fname1 := fname1 + CopyStr(str, 1, StrPos(str, '/') - 1) + '_';
            str := CopyStr(str, StrPos(str, '/') + 1);
        end;
        fname1 := fname1 + str;
        /*
        IF OpenUsingDocumentService('') THEN
            EXIT;

        IF NOT PreOpenExcel THEN
            EXIT;
            */

        // FileNameClient := FileManagement.DownloadTempFile(FileNameServer);
        //FileNameClient := FileManagement.MoveAndRenameClientFile(FileNameClient,fname1+'.xlsx',File_Path);
        XlWrkBk.SaveCopyAs('\\erpserver\erpattachments\Explosion of Bom\' + fname1 + '.xlsx');
    END;


    PROCEDURE SavingExcel(No: Text[30]);

    var
        XlWrkBk: DotNet XlWrkBkD;
    BEGIN
        //XlWrkBk := XlApp.ActiveWorkbook;
        str := '';
        fname1 := '';
        str := No;
        while StrPos(str, '/') > 1 do begin
            fname1 := fname1 + CopyStr(str, 1, StrPos(str, '/') - 1) + '_';
            str := CopyStr(str, StrPos(str, '/') + 1);
        end;
        fname1 := fname1 + str;
        XlWrkBk.SaveCopyAs('D:\Talley_Excels\' + fname1 + '.xls');
        //XlWrkBk.SaveAs('d:\BOM_'+fname1+'.xls');
        //XlWrkBk.Close(FALSE);
        //CLEAR(XlApp);
        //XlApp.Quit;
    END;


    var
        str: Text[100];
        fname1: Text[100];
        //XlRange: DotNet "'Microsoft.Office.Interop.Excel, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c'.Microsoft.Office.Interop.Excel.Range" RUNONCLIENT;
        //XlMerge: DotNet "'DocumentFormat.OpenXml, Version=2.5.5631.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.DocumentFormat.OpenXml.Spreadsheet.MergeCells" RUNONCLIENT;
        XlWrkBkWriter: DotNet XlWrkBkWriterD;
        //"'Microsoft.Dynamics.Nav.OpenXml, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorkbookWriter";
        CurrentRow: Integer;
        CurrentCol: Integer;
    // XlWrkShtWriter: DotNet XlWrkShtWriterD;
    //"'Microsoft.Dynamics.Nav.OpenXml, Version=14.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetWriter"



}