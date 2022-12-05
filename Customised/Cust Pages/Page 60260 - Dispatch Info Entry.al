page 60260 "Dispatch Info Entry"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = true;
    PageType = List;
    Permissions = TableData "Sales Invoice Header" = rm;
    ShowFilter = true;
    SourceTable = "Sales Invoice Header";
    SourceTableView = SORTING("Order No.", "Posting Date") ORDER(Descending) WHERE("Posting Date" = FILTER('>= 04/01/16'));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Order No."; "Order No.")
                {
                    Editable = false;
                    Enabled = false;
                    StyleExpr = "No.Format";
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Editable = false;
                    Enabled = false;
                    StyleExpr = "No.Format";
                    ApplicationArea = All;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("<Extended Date2>"; "Extended Date")
                {
                    Caption = 'Material Dispatch Date';
                    ApplicationArea = All;
                }
                field("Expected Reached Date"; "Expected Reached Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Date Sent"; "Date Sent")
                {
                    Caption = 'Material Reached Date';
                    ApplicationArea = All;
                }
                field("Dispatched Location"; "Dispatched Location")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Dispatched Location name"; "Dispatched Location name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    Caption = 'Mode of Transport';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Reason For Deviation"; "Reason For Deviation")
                {
                    ApplicationArea = All;
                }
                field("Total Invoiced Amount"; "Total Invoiced Amount")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Dispatched Amount"; "Dispatched Amount")
                {
                    Caption = 'Tansportation Amount';
                    ApplicationArea = All;
                }
                field(Dispatched_packets_Qunatity; Dispatched_packets_Qunatity)
                {
                    ApplicationArea = All;
                }
                field("Bill Of Export Date"; "Bill Of Export Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Of Export No."; "Bill Of Export No.")
                {
                    ApplicationArea = All;
                }
                field("Port Code"; "Port Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (STRLEN("Port Code") = 6) AND NOT ("Port Code" = '')
                          THEN
                            ERROR('Port Code Size Should be 6 ');
                    end;
                }
                field("Send for Assurance"; "BizTalk Document Sent")
                {
                    Caption = 'Send for Assurance';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        // added by sujani on 08-05-18
                        IF Rec."GST Customer Type" IN [Rec."GST Customer Type"::Export, Rec."GST Customer Type"::"Deemed Export", Rec."GST Customer Type"::"SEZ Development", Rec."GST Customer Type"::"SEZ Unit"]

                         //Rec."GST Customer Type" IN[3,4,6,7]
                         THEN BEGIN
                            IF ("Port Code" = '') THEN
                                ERROR('Please Fill Port Code');
                            IF ("Bill Of Export Date" = 0D) THEN
                                ERROR('Please Fill the Bill Of Export Date ');
                            IF ("Bill Of Export No." = '') THEN
                                ERROR('Please Fill the Bill Of Export No');
                        END;


                        //Rev01

                        //sreenivas added coded as on dec-20-2009 as per instructions of anilkumar
                        //IF (UPPERCASE(USERID)='06FT008') OR (UPPERCASE(USERID)='04DI002') THEN BEGIN
                        /*IF (UPPERCASE(USERID)='EFFTRONICS\PMSUBHANI') OR (UPPERCASE(USERID)='EFFTRONICS\PADMAJA') THEN BEGIN
                          Mail_Body:='';
                          "from Mail":='';
                          "to mail":='';
                          Mail_Subject:='';
                          IF "Posting Date" > 010409D THEN BEGIN
                            IF "Extended Date"=0D THEN
                              ERROR('Enter Material Dispatch Date');
                            IF "Expected Reached Date"=0D THEN
                              ERROR('Enter Expected Reached Date');
                            IF "Date Sent"=0D THEN
                              ERROR('Enter Material Received Date');
                            IF "Hand Overed Person"='' THEN BEGIN
                              IF "Hand Overed Person(Others)"='' THEN
                                ERROR('Enter the Hand Overed Person Name')
                            END;
                        
                            //user.SETFILTER(user."User ID","Hand Overed Person"); //ADSK
                            user.SETFILTER(user."User Name","Hand Overed Person");
                            IF user.FINDFIRST THEN
                              personname:=user."User Name";
                              //IF (FORMAT("Reason For Deviation")<>'') THEN
                              //ERROR('Enter Reason for Deviation');
                              IF "Dispatched Location"='' THEN
                                ERROR('Enter Dispatch Location');
                                division.SETFILTER(division."Division Code","Dispatched Location");
                              IF  division.FINDFIRST THEN
                                location:=division."Division Name";
                              IF "Transport Method"='' THEN
                                ERROR('Enter Method of Transportation');
                              MODIFY(TRUE);
                              Mail_Subject:='DISPATCH - Assurance for Dispatched Material Status';
                              //"Mail-Id".SETRANGE("Mail-Id"."User ID",USERID);
                              "Mail-Id".SETRANGE("Mail-Id"."User Name",USERID);
                              IF "Mail-Id".FINDFIRST THEN
                                "from Mail":="Mail-Id".MailID;
                                charline:=10;
                                Mail_Body:='Customer Name      :'+FORMAT("Sell-to Customer Name");
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Invoice No.        :'+FORMAT("External Document No.");
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Sale Order No.     :'+FORMAT("Order No.");
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Invoice Date       :'+FORMAT(("Posting Date"),0,4);
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Material Recived   :'+FORMAT(("Date Sent"),0,4);
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Material Location  :'+location;
                                Mail_Body+=FORMAT(charline);
                                Mail_Body+='Mode of Transport  :'+FORMAT("Transport Method");
                                Mail_Body+=FORMAT(charline);
                                IF "Hand Overed Person"='' THEN BEGIN
                                  Mail_Body+='Handover Person     :'+FORMAT("Hand Overed Person(Others)");
                                  Mail_Body+=FORMAT(charline);
                                  Mail_Body+='Handover Person No. :'+FORMAT("Contact Info(Others)");
                                  Mail_Body+=FORMAT(charline);
                                END ELSE BEGIN
                                  Mail_Body+='Handover Person    :'+FORMAT(personname);
                                  Mail_Body+=FORMAT(charline);
                                  Mail_Body+='Handover Person No.:'+FORMAT("Contact Info");
                                  Mail_Body+=FORMAT(charline);
                              END;
                              Mail_Body+=FORMAT(charline);
                             Mail_Body+='***** I confirmed from Customer/Site Person,that Material has Reached and Packing Condition Also Satisfactory *****';
                        
                            "to mail":={dir@efftronics.com,}'erp@efftronics.com,praveena@efftronics.com,pmsubhani@efftronics.com,padmaja@efftronics.com,anvesh@efftronics.com,spurthi@efftronics.com,';
                            "to mail"+='cuspm@efftronics.com,';
                            "to mail"+='pmurali@efftronics.com,';
                            "to mail"+='bharat@efftronics.com,prasanthi@efftronics.com';
                            IF (COPYSTR("Order No.",15,1)='L') THEN
                              "to mail"+=',bala@efftronics.com,lmd@efftronics.com'
                            ELSE
                               "to mail"+=',sales@efftronics.com';
                            IF SalesInvHeader."Customer Posting Group"='RAILWAYS' THEN
                            "to mail"+=',prasanthi@efftronics.com';
                            //"to mail"+='mohang@efftronics.com';
                            SIH.SETFILTER(SIH."No.","No.");
                            //REPORT.RUN(50181,FALSE,FALSE,SIH);
                            "to mail" := 'sujani@efftronics.com';
                            REPORT.SAVEASPDF(50021,'\\erpserver\ErpAttachments\ErpAttachments1\Billdetails.Pdf',SIH);
                            attachment:='\\erpserver\ErpAttachments\ErpAttachments1\Billdetails.Pdf';
                           IF ("from Mail"<>'')AND("to mail"<>'') THEN BEGIN
                           //mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,attachment);
                             SMTP_MAIL.CreateMessage('ERP',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
                             //EFFUPG Start
                             {
                             SMTP_MAIL.AddAttachment(attachment);
                             }
                             SMTP_MAIL.AddAttachment(attachment,'');
                             //EFFUPG End
                             SMTP_MAIL.Send;
                           END;
                            "Dispatch Assurance Date" := TODAY();     //Added by Pranavi on 04-11-2015
                            //IF "BizTalk Document Sent"= TRUE THEN
                              //CurrPage."BizTalk Document Sent".EDITABLE(FALSE)
                           // ELSE
                             // CurrPage."BizTalk Document Sent".EDITABLE(TRUE);
                            END ELSE
                            BEGIN
                             "BizTalk Document Sent":=FALSE;
                             "Dispatch Assurance Date" := 0D;
                            END;
                          //CurrForm."BizTalk Document Sent".EDITABLE(TRUE);
                         MODIFY;
                        END;
                        */

                    end;
                }
                field("LR No."; "LR No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF UPPERCASE(USERID) IN ['EFFTRONICS\PMSUBHANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\PRAVEENA', 'EFFTRONICS\KBHAGYALAKSHMI', 'EFFTRONICS\RAMAGOPAL'] THEN
                            MODIFY(TRUE)
                        ELSE
                            ERROR('You Donot have Permissions');
                    end;
                }
                field(ContactName; ContactName)
                {
                    Caption = 'Contact Name';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer Contact No"; "Customer Contact No")
                {
                    Caption = 'Customer_Contact_no';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Hand Overed Person(Others)"; "Hand Overed Person(Others)")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Hand Overed Person(Others)" <> '' THEN
                            HandOveredPersonOthersEditable := FALSE
                        ELSE
                            HandOveredPersonOthersEditable := TRUE;
                        //   "Edit Text":=FALSE;
                        HandOveredPersonOthersOnAfterV;
                    end;
                }
                field("Contact Info(Others)"; "Contact Info(Others)")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Contact Info(Others)" <> '' THEN
                            "Contact Info(Others)Editable" := FALSE
                        ELSE
                            "Contact Info(Others)Editable" := TRUE;
                        // "Edit Text":=FALSE;
                    end;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Consignee Name"; "Consignee Name")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    CaptionML = ENU = 'Consignee',
                                ENN = 'Ship-to Name';
                    ApplicationArea = All;
                }
                field(Trasportation_Days; Trasportation_Days)
                {
                    Caption = 'Trasportation_Days';
                    ApplicationArea = All;
                }
            }
            group(Control1102152049)
            {
                ShowCaption = false;
                grid(Control1102152048)
                {
                    ShowCaption = false;
                    group(Control1102152045)
                    {
                        ShowCaption = false;
                        field(Color_Export_Sez; Color_Export_Sez)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Excel)
            {
                Image = Excel;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    RESET;
                    ExcelDump;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        NoOnFormat;
        "Customer Contact No" := '';
        ContactName := '';
        CustGRec.RESET;
        IF CustGRec.GET("Sell-to Customer No.") THEN BEGIN
            "Customer Contact No" := CustGRec."Phone No.";
            IF CustGRec."Primary Contact No." <> '' THEN BEGIN
                ContactGRec.RESET;
                IF ContactGRec.GET(CustGRec."Primary Contact No.") THEN
                    ContactName := ContactGRec.Name
                ELSE
                    ContactName := CustGRec.Name;
            END;
        END;

        IF ("Date Sent" <> 0D) AND ("Extended Date" <> 0D) THEN BEGIN
            Trasportation_Days := Rec."Date Sent" - Rec."Extended Date";
        END;



        //added by vishnu priya
        /*division.RESET;
        IF Rec."Dispatched Location" <> '' THEN
          BEGIN
            division.SETFILTER("Division Code",Rec."Dispatched Location");
            division.FINDFIRST;
            "LOCATION NAME" := division."Division Name";
          END
          */
        // end by Vishnu Priya

    end;

    trigger OnInit();
    begin
        division.RESET;
        IF "Dispatched Location" <> '' THEN BEGIN
            division.SETFILTER(Code, Rec."Dispatched Location");
            division.FINDFIRST;
            "LOCATION NAME" := division."Division Name";
        END
    end;

    trigger OnOpenPage();
    begin

        //Color_Export_Sez:= 'Export Bills';
        //IF NOT (SMTP_MAIL.Permission_Checking(USERID,'LOGISTICKS'))
        //  THEN
        // ERROR('You Don"t have Permissions');
        //IF(Permission_Checking(UserName : Text[50];"Action ID" : Text[100]))
        //"User ID" IN ['LOGISTICKS']
        //THEN
        //ELSE

        // BEGIN

        SETFILTER("Order No.", '%1', '*SAL*');

        // END;

        Color_Export_Sez := 'Color Indicates Export Bills';
    end;

    var

        "Extended DateEditable": Boolean;

        "Date SentEditable": Boolean;

        "Expected Reached DateEditable": Boolean;

        "Hand Overed PersonEditable": Boolean;

        HandOveredPersonOthersEditable: Boolean;

        "Contact Info(Others)Editable": Boolean;

        "Dispatched LocationEditable": Boolean;

        "BizTalk Sales InvoiceEditable": Boolean;

        "BizTalk Document SentEditable": Boolean;

        "Transport MethodEditable": Boolean;
        Quantity: Integer;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        CustGRec: Record Customer;
        ContactGRec: Record Contact;
        ContactName: Text;
        Mail_Body: Text[1000];
        "Mail-Id": Record User;
        "from Mail": Text[1000];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        mail: Codeunit Mail;
        user: Record User;
        personname: Text[30];
        division: Record "Employee Statistics Group";
        location: Text[30];
        charline: Char;
        SalesInvHeader: Record "Sales Invoice Header";
        SIH: Record "Sales Invoice Header";
        attachment: Text[250];
        "Customer Contact No": Text;
        Trasportation_Days: Integer;
        No_: Integer;
        "No.Format": Text;
        Color_Export_Sez: Text[30];
        "LOCATION NAME": Text[50];
        LOCKA: Text[50];

    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option);
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer.INSERT;
    end;

    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option);
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer.Formula := '';
        TempExcelbuffer.INSERT;
    end;


    procedure ExcelDump();
    begin
        TempExcelbuffer.DELETEALL;
        CLEAR(TempExcelbuffer);

        Row := 1;
        EnterHeadings(Row, 1, 'Order No', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 2, 'External Doc no', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 3, 'No', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 4, 'Bill of Export Date', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 5, 'Bill of Export No', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 6, 'Port Code', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 7, 'Send for Assurance', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 8, 'Sell to Customer No', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 9, 'Sell to Customer Name', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 10, 'Posting Date', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 11, 'Material Dispatch Date', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 12, 'Expected Reached Date', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 13, 'Material Reached Date', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 14, 'Dispatched Location', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 15, 'Mode Of Transport', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 16, 'Reason For Deviation', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 17, 'Total Invoiced Amount', TRUE, TempExcelbuffer."Cell Type"::Number);
        EnterHeadings(Row, 18, 'Transportation Amount', TRUE, TempExcelbuffer."Cell Type"::Number);
        EnterHeadings(Row, 19, 'Dispatched Packet Quantity', TRUE, TempExcelbuffer."Cell Type"::Number);
        EnterHeadings(Row, 20, 'LR No', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 21, 'Contact Name', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 22, 'Customer Contact Number', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 23, 'Handoverd Person(Other)', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 24, 'Contact Info(Others)', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 25, 'User ID', TRUE, TempExcelbuffer."Cell Type"::Text);
        EnterHeadings(Row, 26, 'Transportation Days', TRUE, TempExcelbuffer."Cell Type"::Number);




        RESET;
        SETFILTER("Posting Date", '>=%1', DMY2Date(04, 01, 16));

        IF FINDFIRST THEN
            REPEAT
                Row += 1;
                Entercell(Row, 1, FORMAT("Order No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 2, FORMAT("External Document No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 3, FORMAT("No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 4, FORMAT("Bill Of Export Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                Entercell(Row, 5, FORMAT("Bill Of Export No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 6, FORMAT("Port Code"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 7, FORMAT("BizTalk Document Sent"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 8, FORMAT("Sell-to Customer No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 9, FORMAT("Sell-to Customer Name"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 10, FORMAT("Posting Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                Entercell(Row, 11, FORMAT("Extended Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                Entercell(Row, 12, FORMAT("Expected Reached Date"), FALSE, TempExcelbuffer."Cell Type"::Date);
                Entercell(Row, 13, FORMAT("Date Sent"), FALSE, TempExcelbuffer."Cell Type"::Date);
                Entercell(Row, 14, FORMAT("Dispatched Location"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 15, FORMAT("Transport Method"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 16, FORMAT("Reason For Deviation"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 17, FORMAT(ROUND("Total Invoiced Amount", 1)), FALSE, TempExcelbuffer."Cell Type"::Number);
                Entercell(Row, 18, FORMAT(ROUND("Dispatched Amount", 1)), FALSE, TempExcelbuffer."Cell Type"::Number);
                Entercell(Row, 19, FORMAT(Dispatched_packets_Qunatity), FALSE, TempExcelbuffer."Cell Type"::Number);
                Entercell(Row, 20, FORMAT("LR No."), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 21, FORMAT(ContactName), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 22, FORMAT("Customer Contact No"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 23, FORMAT("Hand Overed Person(Others)"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 24, FORMAT("Contact Info(Others)"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 25, FORMAT("User ID"), FALSE, TempExcelbuffer."Cell Type"::Text);
                Entercell(Row, 26, FORMAT(Trasportation_Days), FALSE, TempExcelbuffer."Cell Type"::Number);

            UNTIL NEXT = 0;
        //TempExcelbuffer.CreateBook('Excise Returns');EFFUPG
        /*
        TempExcelbuffer.CreateBook('Excise Returns','Excise Returns');//Rev01 EFFUPG
        TempExcelbuffer.WriteSheet('Excise Returns',COMPANYNAME,USERID);//Rev01
        TempExcelbuffer.CloseBook; //Rev01
        TempExcelbuffer.OpenExcel; //Rev01
        TempExcelbuffer.GiveUserControl;
        */
        TempExcelbuffer.CreateBookAndOpenExcel('', 'Dispatch Information', 'Dispatch Information1', COMPANYNAME, USERID); //EFFUPG

    end;


    local procedure HandOveredPersonOthersOnAfterV();
    begin
        "Hand Overed Person(Others)" := UPPERCASE("Hand Overed Person(Others)");
    end;


    local procedure NoOnFormat();
    begin
        IF Rec."GST Customer Type" IN [Rec."GST Customer Type"::Export, Rec."GST Customer Type"::"Deemed Export", Rec."GST Customer Type"::"SEZ Development", Rec."GST Customer Type"::"SEZ Unit"]
       THEN
            "No.Format" := 'StrongAccent'
        ELSE
            "No.Format" := 'NONE'

    end;
}

