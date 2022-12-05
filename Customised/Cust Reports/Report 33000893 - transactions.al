report 33000893 transactions
{
    // Project : EFFTRONICS
    // *************************************************************************************************************************
    // SIGN Name
    // ************************************************************************************************************************
    // DIM : Resolution of Dimension Issues after Upgarding.
    // ***********************************************************************************************************************
    // Version  sign     Date       USERID    Description
    // *************************************************************************************************************************
    // 1.0      DIM      28-May-13  SAIRAM    New Code has been added for the dimensions updation after upgarding.
    DefaultLayout = RDLC;
    RDLCLayout = './transactions.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;


    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Source Code" = FILTER('<>SALESAPPL'));
            RequestFilterFields = "System Date", "User ID";
            column(G_L_Entry__G_L_Account_No__; "G/L Account No.")
            {
            }
            column(Gl_Name; Gl.Name)
            {
            }
            column(G_L_Entry__Posting_Date_; "Posting Date")
            {
            }
            column(G_L_Entry__Document_No__; "Document No.")
            {
            }
            column(G_L_Entry_Description; Description)
            {
            }
            column(G_L_Entry_Amount; Amount)
            {
            }
            column(G_L_Entry__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(name1; name1)
            {
            }
            column(G_L_Entry__System_Date_; "System Date")
            {
            }
            column(G_L_Entry__Cheque_No__; "Cheque No.")
            {
            }
            column(G_L_Entry__Cheque_Date_; "Cheque Date")
            {
            }
            column(vname; vname)
            {
            }
            column(bankname; bankname)
            {
            }
            column(cusname; cusname)
            {
            }
            column(CustomerOrderno; CustomerOrderno)
            {
            }
            column(G_L_Entry__G_L_Entry___User_ID_; "G/L Entry"."User ID")
            {
            }
            column(G_L_Entry_Entry_No_; "Entry No.")
            {
            }
            column(GL_Account_Name_no; GL_Account_Name_no)
            {
            }
            column(Entry_Type; Entry_Type)
            {
            }

            trigger OnAfterGetRecord()
            begin
                vname := '';
                bankname := '';
                cusname := '';
                Name := '';
                name1 := '';
                EmpID := '';
                Dimension := '';
                CustomerOrderno := '';
                Gl.RESET;
                Gl.SETRANGE(Gl."No.", "G/L Entry"."G/L Account No.");
                IF Gl.FIND('-') THEN BEGIN
                    Name := Gl.Name;
                END;

                //DIM1.0 Start
                //Code Commented
                /*
                LED.SETRANGE(LED."Entry No.","G/L Entry"."Entry No.");
                LED.SETFILTER(LED."Table ID",'17');
                IF LED.FIND('-') THEN
                REPEAT
                IF LED."Dimension Code"='EMPLOYEE CODES' THEN
                BEGIN
                DV.SETRANGE(DV."Dimension Code",LED."Dimension Code");
                DV.SETRANGE(DV.Code,LED."Dimension Value Code");
                IF DV.FIND('-') THEN
                REPEAT
                name1:=DV.Name;
                EmpID:=DV.Code;
                UNTIL DV.NEXT=0;
                END;
                UNTIL LED.NEXT=0;
                */
                DimSetEntryGRec.RESET;
                DimSetEntryGRec.SETRANGE("Dimension Set ID", "Dimension Set ID");
                IF DimSetEntryGRec.FINDSET THEN
                    REPEAT
                        IF DimSetEntryGRec."Dimension Code" = 'EMPLOYEE CODES' THEN BEGIN
                            DimSetEntryGRec.CALCFIELDS("Dimension Value Name");
                            name1 := DimSetEntryGRec."Dimension Value Name";
                            EmpID := DimSetEntryGRec."Dimension Value Code";
                        END;
                        IF DimSetEntryGRec."Dimension Code" <> 'DEPARTMENTS' THEN BEGIN
                            DimSetEntryGRec.CALCFIELDS("Dimension Value Name");
                            Dimension += DimSetEntryGRec."Dimension Value Name" + ',';
                        END;
                    UNTIL DimSetEntryGRec.NEXT = 0;
                //DIM1.0 End
                IF STRLEN(Dimension) > 1 THEN
                    Dimension := COPYSTR(Dimension, 1, STRLEN(Dimension) - 1);

                customer.SETRANGE(customer."No.", "G/L Entry"."Source No.");
                IF customer.FIND('-') THEN
                    cusname := customer.Name;

                Vendor.SETRANGE(Vendor."No.", "G/L Entry"."Source No.");
                IF Vendor.FIND('-') THEN BEGIN
                    vname := Vendor.Name;
                END;
                customer.SETRANGE(customer."No.", "G/L Entry"."Source No.");
                IF customer.FIND('-') THEN
                    cusname := customer.Name;

                bank.SETRANGE(bank."No.", "G/L Entry"."Source No.");
                IF bank.FIND('-') THEN
                    bankname := bank.Name;

                CLE.RESET;
                CLE.SETRANGE(CLE."Document No.", "G/L Entry"."Document No.");
                IF CLE.FIND('-') THEN BEGIN
                    CustomerOrderno := CLE."Customer ord No";
                END;

                NarrationText := '';
                narrationrec.RESET;
                narrationrec.SETRANGE(Type, narrationrec.Type::"Narration Line");
                narrationrec.SETFILTER("No.", "G/L Entry"."Document No.");
                IF narrationrec.FINDFIRST THEN
                    REPEAT
                        NarrationText := NarrationText + narrationrec.Comment;
                    UNTIL narrationrec.NEXT = 0;
                IF NarrationText = '' THEN BEGIN
                    NarrationText := "G/L Entry".Description;
                END;
                GL_Account_Name_no := '';
                GL_Account_Name_no := FORMAT(Gl.Name) + '_' + FORMAT("G/L Entry"."G/L Account No.");
                EVALUATE(Acount_No, "G/L Entry"."G/L Account No.");
                CASE Acount_No OF
                    24300:
                        BEGIN
                            GL_Account_Name_no := 'ADV-FOR-EXP-' + name1 + '_' + EmpID + '_24300';
                        END;
                    24200:
                        BEGIN
                            GL_Account_Name_no := 'SAL-ADV-' + name1 + '_' + EmpID + '_24200';
                        END;
                    24000:
                        BEGIN
                            GL_Account_Name_no := 'TA-' + name1 + '_' + EmpID + '_24000';
                        END;
                    37200:
                        BEGIN
                            GL_Account_Name_no := 'SAL-DEP-' + name1 + '_' + EmpID + '_37200';
                        END;
                    25700:
                        BEGIN
                            GL_Account_Name_no := 'SD-' + cusname + '_' + "G/L Entry"."Source No." + '_25700';
                        END;
                    20200 .. 20900:
                        BEGIN
                            IF "G/L Entry"."Sale Order No." <> '' THEN BEGIN
                                GL_Account_Name_no := cusname + '_' + COPYSTR("G/L Entry"."Sale Order No.", 9, STRLEN("G/L Entry"."Sale Order No.")) + '_' + "G/L Entry"."Source No.";
                            END
                            ELSE BEGIN
                                IF "G/L Entry"."Document Type" = "G/L Entry"."Document Type"::Invoice THEN BEGIN
                                    SIH.RESET;
                                    SIH.SETFILTER("No.", "G/L Entry"."Document No.");
                                    IF SIH.FINDFIRST THEN
                                        GL_Account_Name_no := cusname + '_' + COPYSTR(SIH."Order No.", 9, STRLEN(SIH."Order No.")) + '_' + "G/L Entry"."G/L Account No.";
                                END;
                            END;
                        END;
                    36000 .. 41999:
                        BEGIN
                            GL_Account_Name_no := vname + '_' + "G/L Entry"."Source No.";
                        END;
                END;
                Entry_Type := '';
                /*
                IF COPYSTR("G/L Entry"."Document No.",1,6) = 'EX-INV' THEN
                BEGIN
                    Entry_Type := 'Sales';
                END; */
                SIH.RESET;
                SIH.SETFILTER("No.", "G/L Entry"."Document No.");
                PIH.RESET;
                PIH.SETFILTER("No.", "G/L Entry"."Document No.");
                PCN.RESET;
                PCN.SETFILTER("No.", "G/L Entry"."Document No.");
                PDN.RESET;
                PDN.SETFILTER("No.", "G/L Entry"."Document No.");
                IF SIH.FINDFIRST THEN BEGIN
                    Entry_Type := 'Sales';
                END ELSE
                    IF PIH.FINDFIRST THEN BEGIN
                        Entry_Type := 'Purchase';
                    END ELSE
                        IF PCN.FINDFIRST THEN BEGIN
                            Entry_Type := 'Credit Note';
                        END ELSE
                            IF PDN.FINDFIRST THEN BEGIN
                                Entry_Type := 'Debit Note';
                            END ELSE
                                IF (COPYSTR("G/L Entry"."Document No.", 1, 3) = 'BPV') OR (COPYSTR("G/L Entry"."Document No.", 1, 3) = 'CPV') THEN BEGIN
                                    Entry_Type := 'Payment';
                                END
                                ELSE
                                    IF (COPYSTR("G/L Entry"."Document No.", 1, 3) = 'CRV') OR (COPYSTR("G/L Entry"."Document No.", 1, 3) = 'BRV') THEN BEGIN
                                        Entry_Type := 'Reciept';
                                    END
                                    ELSE
                                        IF (COPYSTR("G/L Entry"."Document No.", 1, 2) = 'JV') THEN BEGIN
                                            Entry_Type := 'JV';
                                        END;


                //Rev01 Code Copied from //G/L Entry, Body (2) - OnPostSection()
                IF Excel THEN BEGIN
                    Row += 1;
                    Entercell(Row, 1, Entry_Type, FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 2, FORMAT("G/L Entry"."Posting Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                    Entercell(Row, 3, FORMAT("G/L Entry"."Document No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 4, FORMAT("G/L Entry"."Cheque No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 5, FORMAT("G/L Entry"."G/L Account No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 6, FORMAT(Gl.Name), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 7, GL_Account_Name_no, FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 8, FORMAT(NarrationText), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 9, FORMAT("G/L Entry".Amount), FALSE, TempExcelbuffer."Cell Type"::Number);
                    Entercell(Row, 10, FORMAT("G/L Entry"."Global Dimension 1 Code"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 11, FORMAT(name1), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 12, FORMAT("G/L Entry"."Cheque Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                    Entercell(Row, 13, FORMAT(vname), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 14, FORMAT(bankname), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 15, FORMAT(cusname), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 16, FORMAT(CustomerOrderno), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 17, FORMAT("G/L Entry"."User ID"), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 18, FORMAT("G/L Entry"."System Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                    Entercell(Row, 19, FORMAT("G/L Entry"."External Document No."), FALSE, TempExcelbuffer."Cell Type"::Text); //Rev01
                    IF EmpID <> '' THEN
                        Entercell(Row, 20, FORMAT(EmpID), FALSE, TempExcelbuffer."Cell Type"::Text)
                    ELSE
                        Entercell(Row, 20, FORMAT("G/L Entry"."Source No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 21, FORMAT(Dimension), FALSE, TempExcelbuffer."Cell Type"::Text);
                    Entercell(Row, 22, FORMAT(customer."Salesperson Code"), FALSE, TempExcelbuffer."Cell Type"::Text);


                    //Rev01 Code Copied from //G/L Entry, Body (2) - OnPostSection()
                END;

            end;

            trigger OnPreDataItem()
            begin
                TempExcelbuffer.DELETEALL;
                CLEAR(TempExcelbuffer);
                Row := 0;
                IF Excel THEN BEGIN
                    Row += 1;
                    EnterHeadings(Row, 1, 'Entry Type', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 2, 'POSTING DATE', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 3, 'Document NO.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 4, 'Cheque No', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 5, 'G/L account', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 6, 'A/c Name', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 7, 'Account_Name_No', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 8, 'Description', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 9, 'Amount', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 10, 'Dept.Code', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 11, 'Employee Code', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 12, 'Cheque Date', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 13, 'Vendor Name', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 14, 'Bank a/c Name', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 15, 'Customer Name', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 16, 'Customer Order No', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 17, 'User ID', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 18, 'System Date', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 19, 'External Document No.', TRUE, TempExcelbuffer."Cell Type"::Text); //Rev01
                    EnterHeadings(Row, 20, 'Source No.', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 21, 'Dimensions', TRUE, TempExcelbuffer."Cell Type"::Text);
                    EnterHeadings(Row, 22, 'Salesperson', TRUE, TempExcelbuffer."Cell Type"::Text);
                    /*

                    */

                END;
                //Rev01 code copied from //G/L Entry, Header (1) - OnPostSection()

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field(Excel; Excel)
                    {
                        Caption = 'Excel';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Excel := TRUE; //Rev01
    end;

    trigger OnPostReport()
    begin
        //Code Commented
        /*
        IF Excel THEN
        BEGIN
        //TempExcelbuffer.CreateBook('');//B2B
        //TempExcelbuffer.CreateSheet('Total Sale orders','',COMPANYNAME,'');//B2B
        TempExcelbuffer.GiveUserControl;
        END;
        */
        //Rev01 Begin
        IF Excel THEN BEGIN
            /*
              TempExcelbuffer.CreateBook('Total Sale orders',''); //EFFUPG
              TempExcelbuffer.WriteSheet('Total Sale orders',COMPANYNAME,USERID);
              TempExcelbuffer.CloseBook;
              TempExcelbuffer.OpenExcel;
              TempExcelbuffer.GiveUserControl;
            */
            TempExcelbuffer.CreateBookAndOpenExcel('', 'Total Sale orders', 'Total Sale orders', COMPANYNAME, USERID); //EFFUPG
            Sales_Excel.CreateBookAndOpenExcel('', 'Sales', 'Sales', COMPANYNAME, USERID);
            //TempExcelbuffer.
        END;
        //Rev01 End

    end;

    var
        Gl: Record "G/L Account";
        DV: Record "Dimension Value";
        Name: Text[50];
        name1: Text[50];
        Vendor: Record Vendor;
        VLE: Record "Vendor Ledger Entry";
        vname: Text[50];
        bank: Record "Bank Account";
        bankname: Text[50];
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        Excel: Boolean;
        cusname: Text[100];
        customer: Record Customer;
        CLE: Record "Cust. Ledger Entry";
        CustomerOrderno: Text[75];
        "-DIM1.0-": Integer;
        DimSetEntryGRec: Record "Dimension Set Entry";
        EmpID: Code[20];
        Dimension: Text[100];
        NarrationText: Text[1024];
        narrationrec: Record "Purch. Comment Line";
        GL_Account_Name_no: Text;
        Entry_Type: Text;
        SIH: Record "Sales Invoice Header";
        PIH: Record "Purch. Inv. Header";
        PCN: Record "Sales Cr.Memo Header";
        PDN: Record "Purch. Cr. Memo Hdr.";
        Acount_No: Integer;
        Sales_Excel: Record "Excel Buffer";


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option)
    begin

        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option)
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;
        TempExcelbuffer.Formula := '';
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer.INSERT;
    end;


    procedure ExcelHeading(Excel: Record "Excel Buffer")
    begin
        EnterHeadings(Row, 1, 'Entry Type', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 2, 'POSTING DATE', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 3, 'Document NO.', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 4, 'Cheque No', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 5, 'G/L account', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 6, 'A/c Name', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 7, 'Account_Name_No', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 8, 'Description', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 9, 'Amount', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 10, 'Dept.Code', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 11, 'Employee Code', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 12, 'Cheque Date', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 13, 'Vendor Name', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 14, 'Bank a/c Name', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 15, 'Customer Name', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 16, 'Customer Order No', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 17, 'User ID', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 18, 'System Date', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 19, 'External Document No.', TRUE, Excel."Cell Type"::Text); //Rev01
        EnterHeadings(Row, 20, 'Source No.', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 21, 'Dimensions', TRUE, Excel."Cell Type"::Text);
        EnterHeadings(Row, 22, 'Salesperson', TRUE, TempExcelbuffer."Cell Type"::Text);
    end;
}

