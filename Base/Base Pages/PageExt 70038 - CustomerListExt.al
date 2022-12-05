pageextension 70038 CustomerListExt extends 22
{
    layout
    {
        modify("Credit Limit (LCY)")
        {
            Style = None;
        }
        addafter(Name)
        {
            field("Service Zone Code"; Rec."Service Zone Code")
            {
                ApplicationArea = All;
            }
            field("Territory Code"; Rec."Territory Code")
            {
                ApplicationArea = All;
            }
            field(Address; Rec.Address)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Tally Ref"; Rec."Tally Ref")
            {
                ApplicationArea = All;
            }
            field(SalBalance; Rec.SalBalance)
            {
                ApplicationArea = All;
            }
            field(CSBalance; Rec.CSBalance)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("State Code"; Rec."State Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
            field("Primary Contact No."; Rec."Primary Contact No.")
            {
                ApplicationArea = All;
            }
            field("User Id"; Rec."User Id")
            {
                ApplicationArea = All;
            }
        }
        addafter("Base Calendar Code")
        {
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
            }
            /* field("Excise Bus. Posting Group"; "Excise Bus. Posting Group")
             {
                 Editable = false;
                 ApplicationArea = All;
             }*/ //B2b Upg
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                Editable = false;
                ApplicationArea = All;
            }
            /* field("T.I.N. No."; "T.I.N. No.")
             {
                 ApplicationArea = All;
             }*/
            field("Payment Realization Period"; Rec."Payment Realization Period")
            {
                ApplicationArea = All;
            }




        }
        addafter(Control1)
        {
            group(Control110215)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152011)
                {
                    ShowCaption = false;
                    group(Control1102152010)
                    {
                        ShowCaption = false;
                        field("TotalCustomers+FORMAT(Rec.COUNT)"; TotalCustomers + FORMAT(Rec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152001)
                    {
                        ShowCaption = false;
                        field(Color_GST_Update_C; Color_GST_Update_C)
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
        modify(CustomerLedgerEntries)
        {
            Promoted = true;
        }
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(NewSalesBlanketOrder)
        {
            Promoted = false;
        }
        modify(NewSalesQuote)
        {
            Promoted = true;
        }
        modify(NewSalesInvoice)
        {
            Promoted = true;
        }
        modify(NewSalesOrder)
        {
            Promoted = true;
        }
        modify(NewSalesCrMemo)
        {
            Promoted = false;
        }
        modify(NewSalesReturnOrder)
        {
            Promoted = false;
        }
        modify(NewServiceQuote)
        {
            Promoted = false;
        }
        modify(NewServiceInvoice)
        {
            Promoted = false;
        }
        modify(NewServiceOrder)
        {
            Promoted = false;
        }
        modify(NewServiceCrMemo)
        {
            Promoted = false;
        }
        modify(NewReminder)
        {
            Promoted = true;
        }
        modify(NewFinChargeMemo)
        {
            Promoted = false;
        }
        modify("Cash Receipt Journal")
        {
            Promoted = true;
        }
        modify("Sales Journal")
        {
            Promoted = true;
        }
        modify("Customer List")
        {
            Promoted = false;
        }
        modify("Customer Register")
        {
            Promoted = false;
        }
        modify("Customer - Top 10 List")
        {
            Promoted = true;
        }
        modify("Customer - Order Summary")
        {
            Promoted = true;
        }
        modify("Customer - Order Detail")
        {
            Promoted = false;
        }
        modify("Customer - Sales List")
        {
            Promoted = true;
        }
        modify("Sales Statistics")
        {
            Promoted = false;
        }
        modify("Customer/Item Sales")
        {
            Promoted = false;
        }
        modify(ReportCustomerDetailTrial)
        {
            Promoted = false;
        }
        modify(ReportCustomerSummaryAging)
        {
            Promoted = false;
        }
        modify(ReportCustomerDetailedAging)
        {
            Promoted = false;
        }
        modify(Statement)
        {
            Promoted = true;
        }

        modify(ReportAgedAccountsReceivable)
        {
            Promoted = true;
        }
        modify(ReportCustomerBalanceToDate)
        {
            Promoted = true;
        }
        modify(ReportCustomerTrialBalance)
        {
            Promoted = false;
        }
        modify(ReportCustomerPaymentReceipt)
        {
            Promoted = true;
        }
    }



    var
        TotalCustomers: Label '"Total Customers: "';
        Color_GST_Update: Code[30];
        RowCount: Integer;
        //>> ORACLE UPG
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */

        //<< ORACLE UPG
        ConnectionOpen: Integer;
        Color_GST_Update_C: Label 'GST Details Not Updated';
        cus: Record Customer;
        id: Integer;

    procedure GSTMails();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail"; //B2BUPG
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
        // EmailMessage: Codeunit 8904;
        //Email: Codeunit 8901;
        Recipients: List of [Text];
    begin
        /*IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);*/ //B2b UPG

        //>> ORACLE UPG
        /* 
                ConnectionOpen := 0;
                IF ConnectionOpen <> 1 THEN BEGIN
                    SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                    SQLConnection.Open;
                    //SQLConnection.BeginTrans;
                    ConnectionOpen := 1;
                END;
                //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
                SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + Rec."No." + ''' order by type,no;';
                //MESSAGE(SQLQuery);
                RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                    RecordSet.MoveFirst;
                WHILE NOT RecordSet.EOF DO BEGIN
                    Type := FORMAT(RecordSet.Fields.Item('TYPE').Value);
                    No := FORMAT(RecordSet.Fields.Item('NO').Value);
                    IF Type = 'V' THEN BEGIN
                        Mail_From := 'purchase@efftronics.com';
                        Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
                    END
                    ELSE BEGIN
                        Mail_From := 'sales@efftronics.com';
                        Mail_To := Rec."E-Mail";
                    END;

                    //Mail_To := 'pranavi@efftronics.com';

                    Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
                    Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
                    Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
                    Body := Body + '<hr style=solid; color= #3333CC>';
                    Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
                    Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
                    Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
                    Body := Body + '<b>Request you to kindly update PAN & GST registration provisional ID in <u>below link</u> immediately.</b></P><br/>';
                    //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
                    Body := Body + '<font size="8"><b>URL :</b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
                    Body := Body + No + '" target="_blank">GST Registration Details</a></font><br/><br/>';
                    Body := Body + 'Please note that this is required to have smooth business transaction after GST implementation effective July 1, 2017.<br/><br/>';
                    Body := Body + 'Our Company GST Registration details are also attached for your information.<br/><br/>';
                    Body := Body + 'In case you have any queries please contact undersigned.<br/><br/>';
                    Body := Body + 'Best Regards,<br/>';
                    IF Type = 'V' THEN BEGIN
                        Body := Body + 'Renuka CH<br/>';
                        Body := Body + 'Purchase Department<br/>';
                        Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                        Body := Body + '40-15-9,Brundavan Colony,<br/>';
                        Body := Body + 'Vijayawada - 520010,<br/>';
                        Body := Body + 'Andhra Pradesh, India.<br/>';
                        Body := Body + 'Ph No : 0866-2466679(Direct)/2466699/75<br/>';
                    END ELSE BEGIN
                        Body := Body + 'S.Ganesh<br/>';
                        Body := Body + 'Finance Department<br/>';
                        Body := Body + 'Efftronics Systems Pvt. Ltd.,<br/>';
                        Body := Body + '40-15-9,Brundavan Colony,<br/>';
                        Body := Body + 'Vijayawada - 520010,<br/>';
                        Body := Body + 'Andhra Pradesh, India.<br/>';
                        Body := Body + 'Mobile : 9394654999<br/>';
                        Body := Body + 'Ph No : 0866-2466675(Direct)/2466699/75<br/>';
                    END;
                    //  SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                    // Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
                    // SMTP_MAIL.AddAttachment(Attachment, '');
                    // SMTP_MAIL.AddCC('erp@efftronics.com');
                    // SMTP_MAIL.Send;          //B2BUPG

                    Recipients.Add('erp@efftronics.com');
                    EmailMessage.Create(Recipients, Subject, Body, true);
                    Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
                    EmailMessage.AddAttachment(Attachment, '', Attachment);
                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    SQLQuery := 'update Vendor_Cust_List set MAIL_SEND_COUNT = nvl(MAIL_SEND_COUNT,0)+1 where NO = ''' + No + '''';
                    //MESSAGE(SQLQuery);
                    SQLConnection.BeginTrans;
                    SQLConnection.Execute(SQLQuery);
                    SQLConnection.CommitTrans;
                    TempText := TempText + No + ',';
                    RowCount := RowCount + 1;
                    RecordSet.MoveNext;
                END;

                //RecordSet.Close;
                //SQLConnection.CommitTrans;
                SQLConnection.Close;
                ConnectionOpen := 0;
                IF STRLEN(TempText) > 1 THEN
                    MESSAGE('Mail Has been send to ' + COPYSTR(TempText, 1, STRLEN(TempText) - 1) + ' - ' + Rec.Name + 'at ' + Mail_To);
                    */
        //<< ORACLE UPG

    end;



    procedure GSTUpdated();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        TempText: Text;
        Body: Text;
        Attachment: Text;
    begin
        //>> ORACLE UPG
        /*
        //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
        SQLQuery := 'select * from Vendor_Cust_List where (GST_REG_NO is null) and NO = ''' + Rec."No." + ''' order by type,no';
        //MESSAGE(SQLQuery);
        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO BEGIN
            Color_GST_Update := 'StrongAccent';
            RowCount := RowCount + 1;
            RecordSet.MoveNext;
        END;
        //RecordSet.Close;
        //SQLConnection.CommitTrans;
        */
        //<< ORACLE UPG
    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //>= 20080401D
        Rec.setfilter("CSBalance Filter", '>=%1', DMY2Date(01, 04, 2008));//EFFUPG1.2
                                                                          //> 20080331D
        Rec.setfilter("SalBalance Filter", '>%1', DMY2Date(31, 03, 2008));//EFFUPG1.2

    end;
}

