dotnet
{

    assembly("System.Windows.Forms")
    {

        type("System.Windows.Forms.Form"; PromptD)
        {

        }
        type("System.Windows.Forms.FormBorderStyle"; FormBorderStyleD)
        {

        }
        type("System.Windows.Forms.FormStartPosition"; FormStartPositionD)
        {

        }
        type("System.Windows.Forms.Label"; lblIBINAddressD)
        {

        }

        type("System.Windows.Forms.Label"; lblStockAddressD)
        {

        }
        type("System.Windows.Forms.TextBox"; txtBINAddressD)
        {

        }


        type("System.Windows.Forms.TextBox"; txtStockAddressD)
        {



        }

        type("System.Windows.Forms.Button"; confirmationD)
        {

        }


        type("System.Windows.Forms.DialogResult"; DialogResultD)
        {

        }

        type("System.Windows.Forms.Button"; ButtonCancelD)
        {

        }
        type("System.Windows.Forms.Label"; LblRowsD)
        {

        }
        type("System.Windows.Forms.TextBox"; TxtRowsD)
        {

        }

        type("System.Windows.Forms.OpenFileDialog"; OpenFileDialogD)
        {

        }






    }


    assembly("Microsoft.VisualBasic")
    {

        type("Microsoft.VisualBasic.Interaction"; WindowVB)
        {

        }
        type("Microsoft.VisualBasic.DateAndTime"; DateAndTimeD)
        {

        }








        type("Microsoft.VisualBasic.FirstDayOfWeek"; DayofWeekInputD)
        {

        }
        type("Microsoft.VisualBasic.FirstWeekOfYear"; WeekofYearInputD)
        {

        }



    }

    assembly("DocumentFormat.OpenXml")
    {

        type("DocumentFormat.OpenXml.Spreadsheet.Font"; CustomFontD)
        {

        }


        type("DocumentFormat.OpenXml.StringValue"; XMLStringValueD)
        {

        }

        type("DocumentFormat.OpenXml.Spreadsheet.FontName"; CustomFontNameD)
        {

        }


        type("DocumentFormat.OpenXml.Spreadsheet.FontSize"; CustomFontSizeD)
        {

        }


        type("DocumentFormat.OpenXml.DoubleValue"; FontSizeValueD)
        {

        }

        type("DocumentFormat.OpenXml.Spreadsheet.Color"; CustomColorD)
        {

        }
        type("DocumentFormat.OpenXml.HexBinaryValue"; HexColorD)
        {

        }


        type("DocumentFormat.OpenXml.Spreadsheet.Fonts"; FontsD)
        {

        }

        type("DocumentFormat.OpenXml.Spreadsheet.Fill"; CustomCellFillD)
        {

        }

        type("DocumentFormat.OpenXml.Spreadsheet.PatternFill"; CustomCellPatternFillD)
        {

        }


        type("DocumentFormat.OpenXml.Spreadsheet.Bold"; CustomFontBoldD)
        {

        }

        type("DocumentFormat.OpenXml.Spreadsheet.Italic"; CustomFontItalicD)
        {

        }
        type("DocumentFormat.OpenXml.Spreadsheet.Underline"; CustomFontUnderLineD)
        {

        }


        type("DocumentFormat.OpenXml.BooleanValue"; XMLBooleanValueD)
        {

        }




    }

    assembly("Microsoft.Dynamics.Nav.Timer")
    {

        type("Microsoft.Dynamics.Nav.Timer"; NavTimerD)
        {

        }
    }

    assembly("Microsoft.Dynamics.Nav.OpenXml")
    {


        type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.CellDecorator"; CellDecoraterD)
        {

        }

        type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorkbookWriter"; XlWrkBkWriterD)
        {

        }
        type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorkbookReader"; XlWrkBkReaderD)
        {

        }
        type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetWriter"; XlWrkShtWriterdD)
        {

        }
        type("Microsoft.Dynamics.Nav.OpenXml.Spreadsheet.WorksheetReader"; XlWrkShtReaderD)
        {

        }
    }


    assembly("Microsoft.Office.Interop.Excel")
    {


        type("Microsoft.Office.Interop.Excel.ApplicationClass"; XlAppD)
        {

        }
        type("Microsoft.Office.Interop.Excel.Workbook"; XlWrkBkD)
        {

        }
        type("Microsoft.Office.Interop.Excel.Worksheet"; XlWrkShtD)
        {

        }






    }



    assembly(PdfSharp)
    {
        type("PdfSharp.Pdf.PdfDocument"; PDFDocOutD)
        {

        }

        type("PdfSharp.Pdf.IO.PdfReader"; PDFReaderD)
        {

        }
        type("PdfSharp.Pdf.IO.PdfDocumentOpenMode"; PDFOpenDocModeD)
        {

        }



    }
    assembly("Microsoft.Office.Interop.Word")
    {
        type("Microsoft.Office.Interop.Word.ApplicationClass"; WordApplicationD)
        {

        }
        type("Microsoft.Office.Interop.Word.Document"; WordDocumentD)
        {

        }


    }
    assembly("Microsoft.Dynamics.Nav.Integration.Office")
    {
        type("Microsoft.Dynamics.Nav.Integration.Office.Word.MergeHandler"; WordMergefileD)
        {

        }
        type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHelper"; WordHelperD)
        {

        }
        type("Microsoft.Dynamics.Nav.Integration.Office.Word.WordHandler"; WordHandlerD)
        {

        }

        /*
        type("Microsoft.Dynamics.Nav.Integration.Office.Excel.ExcelHelper"; ExcelHelperD)
        {

        }
        */


    }










}