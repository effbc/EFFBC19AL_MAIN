page 60262 "Expenditure Dimension Entry"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "G/L Entry" = rm;
    SourceTable = "G/L Entry";
    SourceTableView = WHERE("Posting Date" = FILTER(>= ' 04/01/18'), "Debit Amount" = FILTER('>0'), "G/L Account No." = FILTER(<> 36200 & <> 36300 & <> 41000));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    Caption = 'Document No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    Caption = 'G/L Account No';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    Caption = 'G/L Account Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Narration; Narration)
                {
                    Caption = 'Narration';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Caption = 'Location Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Debit Amount"; "Debit Amount")
                {
                    Caption = 'Debit Amount';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Vertical; Vertical)
                {
                    Caption = 'Vertical';
                    OptionCaption = '" ,Smart Signalling,Smart Cities,Smart Building,IOT,other"';
                    ApplicationArea = All;
                }
                field("Sale Order No."; "Sale Order No.")
                {
                    Caption = 'Order No';
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Caption = 'Employee Code';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Income/balance"; "Income/balance")
                {
                    Caption = 'Income/balance';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Data)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Rec.DELETEALL;
                    GLE.RESET;
                    GLE.SETRANGE("Posting Date", DMY2Date(04, 01, 18), DMY2Date(04, 04, 18));
                    GLE.SETFILTER("Debit Amount", '>%1', 0);

                    VC := 0;
                    IF GLE.FINDFIRST THEN
                        REPEAT
                            Rec.INIT;
                            "Posting Date" := GLE."Posting Date";
                            "Entry No." := GLE."Entry No.";
                            "Document No." := GLE."Document No.";
                            "G/L Account No." := GLE."G/L Account No.";
                            GLA.RESET;
                            GLA.SETFILTER("No.", GLE."G/L Account No.");
                            IF GLA.FINDFIRST THEN BEGIN
                                "G/L Account Name" := GLA.Name;
                            END;
                            PIL.RESET;
                            PIL.SETFILTER("Document No.", GLE."Document No.");
                            PIL.SETFILTER(Quantity, '>%1', 0);
                            IF PIL.FINDFIRST THEN BEGIN
                                PCL.RESET;
                                PCL.SETRANGE("Document Type", PCL."Document Type"::"Posted Invoice");
                                PCL.SETRANGE("No.", GLE."Document No.");
                                IF PCL.FINDFIRST THEN BEGIN
                                    Description := PCL.Comment;
                                END ELSE BEGIN
                                    Description := 'Material Cost Towards ' + PIL.Description;
                                END;
                            END ELSE BEGIN
                                Description := GLE.Description;
                            END;
                            SQLQuery := 'SELECT        [Entry No], [G/L Account No)], [Document No_], Vertical, Project_Code, [Order No_], [Employee Code] ' +
                                         'FROM            [Expenditure Dimension] where [Entry No] = ' + FORMAT(GLE."Entry No.");
                            // RecordSet:= SQLConnection.Execute(SQLQuery,RowCount);
                            RowCount := 0;
                            // IF NOT( (RecordSet.BOF) OR (RecordSet.EOF) ) THEN
                            //    RecordSet.MoveFirst;
                            // IF NOT(RecordSet.EOF) THEN
                            // BEGIN
                            //     EVALUATE("Bal. Account Type",FORMAT(RecordSet.Fields.Item('Vertical').Value));
                            //   //Rec."Bal. Account Type"::
                            // END;  
                            //B2BUPG

                            "Global Dimension 1 Code" := GLE."Global Dimension 1 Code";
                            "Debit Amount" := GLE."Debit Amount";
                            DSE.RESET;
                            DSE.SETRANGE("Dimension Set ID", GLE."Dimension Set ID");
                            DSE.SETRANGE("Dimension Code", 'EMPLOYEE CODES');
                            IF DSE.FINDFIRST THEN BEGIN
                                DV.RESET;
                                DV.SETRANGE(Code, DSE."Dimension Value Code");
                                IF DV.FINDFIRST THEN BEGIN
                                    "User ID" := DV.Name;
                                END;
                            END;

                            INSERT;

                        UNTIL GLE.NEXT = 0;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        PIL.RESET;
        PIL.SETFILTER("Document No.", "Document No.");
        PIL.SETFILTER(Quantity, '>%1', 0);
        IF PIL.FINDFIRST THEN BEGIN
            PCL.RESET;
            PCL.SETRANGE("Document Type", PCL."Document Type"::"Posted Invoice");
            PCL.SETRANGE("No.", "Document No.");
            IF PCL.FINDFIRST THEN BEGIN
                Narration := PCL.Comment;
            END ELSE BEGIN
                Narration := 'Material Cost Towards ' + PIL.Description;
            END;
        END ELSE BEGIN
            Narration := Description;
        END;
        GLA.RESET;
        GLA.SETRANGE("No.", "G/L Account No.");
        IF GLA.FINDFIRST THEN BEGIN
            "Income/balance" := GLA."Income/Balance";
        END;
    end;

    trigger OnOpenPage();
    var
        LinesCount: Integer;
    begin
    end;

    var
        GLE: Record "G/L Entry";
        GLA: Record "G/L Account";
        Vertical: Option " ","Smart Signalling","Smart Cities","Smart Building",IOT,other;
        VC: Integer;
        PIL: Record "Purch. Inv. Line";
        PCL: Record "Purch. Comment Line";
        //>> ORACLE UPG
        /* SQLConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        SQLQuery: Text;

        RowCount: Integer;
        ConnectionOpen: Integer;
        UpdateQuery: Text;
        Vertical_No: Integer;
        DSE: Record "Dimension Set Entry";
        DV: Record "Dimension Value";
        PIH: Record "Purch. Inv. Header";
        userid_name: Text;
        Narration: Text;
        "Income/balance": Option "Income Statement","Balance Sheet";

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

