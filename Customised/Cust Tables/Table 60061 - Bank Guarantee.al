table 60061 "Bank Guarantee"
{
    // version B2B1.0

    // 2.0      UPGREV                        Code Reviewed and Field "Final Railway Bill Date" and  Warranty Period Code changed for process
    //                                        little bit faster.

    LookupPageID = "Bank Guarntee List";
    Permissions = TableData "Sales Invoice Header" = rm;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "BG No."; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(2; Description; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(3; "Issuing Bank"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(4; Branch; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(5; Address; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(6; "Address 2"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(7; "Post Code"; Code[20])
        {
            TableRelation = "Post Code".Code;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                /*PostCode.LookUpPostCode(City,"Post Code",TRUE);*///B2B

            end;

            trigger OnValidate();
            begin
                TestRelease;
                PostCode.ValidatePostCode(City, "Post Code", County, CountryCode, true);
            end;
        }
        field(8; City; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                /*PostCode.LookUpPostCode(City,"Post Code",TRUE);*///B2b

            end;

            trigger OnValidate();
            begin
                TestRelease;
                PostCode.ValidatePostCode(City, "Post Code", County, CountryCode, true);
            end;
        }
        field(9; State; Code[20])
        {
            TableRelation = State;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(10; "Transaction Type"; Option)
        {
            OptionMembers = Sale,Purchase,Amc;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(11; "Issued to/Received from"; Code[20])
        {
            TableRelation = IF ("Transaction Type" = CONST(Sale)) Customer
            ELSE
            IF ("Transaction Type" = CONST(Purchase)) Vendor;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(13; "Doc No."; Code[20])
        {
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(14; "Date of Issue"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(15; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(16; "Claim Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(17; "Type of BG"; Option)
        {
            OptionMembers = " ",Security,Performance,EMD;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(18; Description2; Text[50])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(19; "BG Value"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(20; "Confirmed BY"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(21; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(22; Attachment; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(23; "File Extension"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(24; "BG Margin Amount"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(25; "Tender No."; Code[20])
        {
            Editable = false;
            TableRelation = "Tender Header"."Tender No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(26; "Security Deposit No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(27; Closed; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
                IF (NOT (USERID IN ['EFFTRONICS\RAJANI', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\RISHIANVESH', 'EFFTRONICS\CHRAJYALAKSHMI'])) THEN begin

                    Error('You do not have a permision to Close BG');
                end;
            end;
        }
        field(29; "Account No."; Code[20])
        {
            TableRelation = "Bank Account"."No." WHERE("Currency Code" = FILTER(= ''));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(50; "Issued/Received"; Option)
        {
            Editable = false;
            OptionMembers = " ",Issued,Received;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(51; "Posting Account No."; Code[20])
        {
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(52; Posted; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(53; "BG Posting Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Purchased,Surrendered;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(54; Extended; Option)
        {
            OptionMembers = " ",Amount,Date,Both;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(55; "Mode Of Payment"; Option)
        {
            OptionMembers = Cash,Bank;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60000; "Customer Order No."; Text[100])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RunModal(45, SalesHeader) = ACTION::LookupOK then
                    "Customer Order No." := SalesHeader."Customer OrderNo.";
            end;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60001; "Final Bill Payment"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60002; "Date Period"; DateFormula)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60003; "BG Head Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Due,Not Due"';
            OptionMembers = " ",Due,"Not Due";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60004; "Order No."; Code[100])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RunModal(143, salesinvoiceheader) = ACTION::LookupOK then
                    "Order No." := salesinvoiceheader."Customer OrderNo.";
            end;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60005; "BG Closed Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60006; "BG Received Back Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
        field(60007; "Final Railway Bill Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //Added by Pranavi on 13-feb-2016
                TestRelease;
                if "Transaction Type" = "Transaction Type"::Sale then begin
                    if (Format("Warranty Period") = '') and ("Final Railway Bill Date" <> 0D) then
                        Error('Please enter Warranty Period!')
                    else begin
                        if "Final Railway Bill Date" <> 0D then
                            "BG Warranty Completion Date" := CalcDate('+' + Format("Warranty Period"), "Final Railway Bill Date")
                        else
                            "BG Warranty Completion Date" := "Final Railway Bill Date";
                    end;
                    SIH.Reset;
                    SIH.SetCurrentKey("Order No.");//UPGREV2.0
                    SIH.SetRange(SIH."Order No.", "Doc No.");
                    if SIH.FindSet then
                        repeat
                            SIH."Final Railway Bill Date" := "Final Railway Bill Date";
                            if SIH."Final Railway Bill Date" <> 0D then begin
                                if CalcDate('+' + Format("Warranty Period"), "Final Railway Bill Date") <= Today() then
                                    SIH.SecDepStatus := SIH.SecDepStatus::Due
                                else
                                    SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                            end;
                            SIH.Modify;
                        until SIH.Next = 0;
                end
                else
                    if "Transaction Type" = "Transaction Type"::Amc then begin
                        "BG Warranty Completion Date" := "Final Railway Bill Date";
                        SIH.Reset;
                        SIH.SetCurrentKey("Order No.");//UPGREV2.0
                        SIH.SetRange(SIH."Order No.", "Doc No.");
                        if SIH.FindSet then
                            repeat
                                SIH."Final Railway Bill Date" := "Final Railway Bill Date";
                                if SIH."Final Railway Bill Date" <> 0D then begin
                                    SIH.SecDepStatus := SIH.SecDepStatus::Due;
                                end;
                                SIH.Modify;
                            until SIH.Next = 0;
                    end;
                // end by pranavi
            end;
        }
        field(60008; "Warranty Period"; DateFormula)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Added by Pranavi on 13-feb-2016
                TestRelease;
                if Format("Warranty Period") = '' then
                    "BG Warranty Completion Date" := 0D
                else begin
                    if "Final Railway Bill Date" <> 0D then begin
                        "BG Warranty Completion Date" := CalcDate('+' + Format("Warranty Period"), "Final Railway Bill Date");
                        SIH.Reset;
                        SIH.SetCurrentKey("Order No.");//UPGREV2.0
                        SIH.SetRange(SIH."Order No.", "Doc No.");
                        if SIH.FindSet then
                            repeat
                                SIH.Validate(SIH."Final Railway Bill Date", "Final Railway Bill Date");
                                SIH.Validate(SIH."Warranty Period", "Warranty Period");
                                if "Transaction Type" = "Transaction Type"::Amc then
                                    SIH.SecDepStatus := SIH.SecDepStatus::Due
                                else
                                    if "Transaction Type" = "Transaction Type"::Sale then begin
                                        if CalcDate('+' + Format("Warranty Period"), "Final Railway Bill Date") <= Today() then
                                            SIH.SecDepStatus := SIH.SecDepStatus::Due
                                        else
                                            SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                                    end;
                                SIH.Modify;
                            until SIH.Next = 0;
                    end
                    else begin
                        "BG Warranty Completion Date" := "Final Railway Bill Date";
                        SIH.Reset;
                        SIH.SetCurrentKey("Order No.");//UPGREV2.0
                        SIH.SetRange(SIH."Order No.", "Doc No.");
                        if SIH.FindSet then
                            repeat
                                SIH.Validate(SIH."Warranty Period", "Warranty Period");
                                if "Transaction Type" = "Transaction Type"::Sale then begin
                                    if SIH."Final Railway Bill Date" <> 0D then
                                        if CalcDate('+' + Format(SIH."Warranty Period"), SIH."Final Railway Bill Date") <= Today() then
                                            SIH.SecDepStatus := SIH.SecDepStatus::Due
                                        else
                                            SIH.SecDepStatus := SIH.SecDepStatus::Warranty;
                                end;
                                SIH.Modify;
                            until SIH.Next = 0;
                    end;
                end;
                // end by pranavi
            end;
        }
        field(60009; "BG Warranty Completion Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60010; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60011; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Issued to/Received from")));
            FieldClass = FlowField;
        }
        field(60012; "Confirmed BY Name"; Text[50])
        {
            CalcFormula = Lookup("Salesperson/Purchaser".Name WHERE(Code = FIELD("Confirmed BY")));
            FieldClass = FlowField;
        }
        field(60013; "Released to Finance"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestRelease;
            end;
        }
    }

    keys
    {
        key(Key1; "BG No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if Status = Status::Released then
            Error('You cannot delete.');
    end;

    trigger OnInsert();
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\RAJANI', 'EFFTRONICS\YESU', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\RAMKUMARL',
          'EFFTRONICS\SGANESH', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\MDIVYA', 'EFFTRONICS\SHABANABEGUM', 'EFFTRONICS\DIVYA', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\MRAJYALAKSHMI'
          ]) then
            Error('YOU CANNOT INSERT DATA');
    end;

    trigger OnModify();
    begin
        if not (UpperCase(UserId) in ['EFFTRONICS\RAJANI', 'EFFTRONICS\YESU', 'EFFTRONICS\DURGARAOV', 'EFFTRONICS\SUSMITHAL', 'EFFTRONICS\RAMKUMARL',
          'EFFTRONICS\RADHIKAK', 'EFFTRONICS\SITARAJYAM', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\MDIVYA', 'EFFTRONICS\SHABANABEGUM', 'EFFTRONICS\DIVYA', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\VISHNUPRIYA'
          , 'EFFTRONICS\MRAJYALAKSHMI']) then
            Error('YOU CANNOT MODIFY DATA');
    end;

    var
        PostCode: Record "Post Code";
        BG: Record "Bank Guarantee";
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
        Text015: Label 'To-Date must be greater than the From-Date.';
        Text016: Label 'Clain-Date must be greater than the From-Date.';
        SalesHeader: Record "Sales Header";
        salesinvoiceheader: Record "Sales Invoice Header";
        //userid: Record User;
        CountryCode: Code[10];
        County: Text[30];
        SIH: Record "Sales Invoice Header";


    procedure OpenAttachment(): Boolean;
    var
        //WordManagement: Codeunit WordManagement;
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        /*
        CALCFIELDS(Attachment);
        IF NOT Attachment.HASVALUE THEN
          ERROR(Text002);
        FileName := ConstFileName;
        IF EXISTS(FileName) THEN
          IF NOT DeleteFile(FileName) THEN
            ERROR(Text003);
        ExportAttachment(FileName);
          HYPERLINK(FileName);
        
        DeleteFile(FileName);
        */

    end;


    procedure ImportAttachment(): Boolean;
    var
        AttachmentManagement: Codeunit AttachmentManagement;
        FileName: Text[260];
    begin
        /*
        FileName := CommonDialogMgt.OpenFile(Text006,'',4,Text007,0);
        IF FileName <> '' THEN BEGIN
          Attachment.IMPORT(FileName);
          "File Extension" := UPPERCASE(AttachmentManagement.FileExtension(FileName));
          MODIFY;
          EXIT(TRUE)
        END ELSE
         EXIT(FALSE);
        */

    end;


    procedure ExportAttachment(ExportToFile: Text[260]): Boolean;
    var
        FileName: Text[260];
        FileFilter: Text[260];
    begin
        /*
        CALCFIELDS(Attachment);
        IF Attachment.HASVALUE THEN BEGIN
          IF ExportToFile = '' THEN BEGIN
            FileFilter := UPPERCASE("File Extension") + ' ';
            FileFilter := FileFilter + '(*.' + "File Extension" + ')|*.' + "File Extension";
            FileName := CommonDialogMgt.OpenFile(Text005,'',4,FileFilter,1);
          END ELSE
            FileName := ExportToFile;
          IF FileName <> '' THEN BEGIN
            Attachment.EXPORT(FileName);
            EXIT(TRUE);
          END ELSE
            EXIT(FALSE)
          END ELSE
            EXIT(FALSE)
        */

    end;

    procedure RemoveAttachment(Prompt: Boolean) DeleteOk: Boolean;
    var
        DeleteYesNo: Boolean;
    begin
        /*
        CALCFIELDS(Attachment);
        IF NOT Attachment.HASVALUE THEN
          ERROR(Text002);
        DeleteOk := FALSE;
        DeleteYesNo := TRUE;
        IF Prompt THEN
          IF NOT CONFIRM(
            Text009,FALSE,FIELDCAPTION("Issued to/Received from"))
          THEN
            DeleteYesNo := FALSE;
        IF DeleteYesNo THEN BEGIN
          CLEAR("Issued to/Received from");
          "File Extension" := '';
          DeleteOk := TRUE;
        END;
        */

    end;


    procedure ConstFileName() Filename: Text[260];
    var
        I: Integer;
        DocNo: Code[10];
    begin
        /*
        REPEAT
          IF I <> 0 THEN
            DocNo := FORMAT(I);
          Filename := ENVIRON('TEMP') + Text012 + DocNo + '.' + "File Extension";
          IF NOT EXISTS(Filename) THEN
            EXIT;
          I := I +1;
        UNTIL I=999;
        MESSAGE('%1',Filename);
        */

    end;


    procedure DeleteFile(Filename: Text[260]): Boolean;
    var
        I: Integer;
    begin
        /*
        IF Filename = '' THEN
          EXIT(FALSE);
        
        IF NOT EXISTS(Filename) THEN
          EXIT(TRUE);
        
        REPEAT
          SLEEP(250);
          I := I + 1;
        UNTIL ERASE(Filename) OR (I = 25);
        EXIT(NOT EXISTS(Filename));
        */

    end;


    procedure TestRelease();
    begin
        TestField(Status, Status::Open);
    end;
}

