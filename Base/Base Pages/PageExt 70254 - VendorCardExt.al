pageextension 70254 VendorCardExtCust extends 26
{
    layout
    {
        modify("E-Mail")
        {
            trigger OnBeforeValidate()
            begin
                CheckValidEmailAddresses("E-Mail");
            end;
        }

        addafter(Name)
        {
            field("Address 3"; "Address 3")
            {
                ApplicationArea = All;
            }
        }

        addafter("Country/Region Code")
        {
            field(Contact2; Contact)
            {
                ApplicationArea = All;
            }
            field("Tally Reference"; "Tally Reference")
            {
                ApplicationArea = All;
            }
            field("User Id"; "User Id")
            {
                ApplicationArea = All;
            }
            field("Personal Account"; "Personal Account")
            {
                ApplicationArea = All;
            }
            field("C-Form"; "C-Form")
            {
                Caption = 'C-Form *';
                ApplicationArea = All;
            }
            field("Updated in Cashflow"; "Updated in Cashflow")
            {
                Caption = 'Updated in Cashflow *';
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    charvar := 39;
                    name2 := '';
                    name1 := '';
                    IF "Updated in Cashflow" THEN BEGIN
                        TESTFIELD(Name);
                        TESTFIELD(City);
                        IF category = category::Primary THEN
                            cat := 1
                        ELSE
                            IF category = category::Secondary THEN
                                cat := 2
                            ELSE
                                IF category = category::Lower THEN
                                    cat := 3;
                        IF cat = 0 THEN
                            ERROR('Select category for Vendor');
                        IF "Purchaser Code" = '' THEN
                            ERROR('Please select Purchaser Code!');     //added by pranavi on 18-jun-2016
                                                                        //CASHFLOWCONNECTION.ExecInOracle('Delete  From MRP_ERP_VENDOR where VENDOR_ID='''+"No."+'''');

                        IF NOT (("Vendor Posting Group" = 'FOREIGN') OR ("GST Vendor Type" = "GST Vendor Type"::Import)) THEN
                            TESTFIELD("State Code");
                        IF "GST Vendor Type" = "GST Vendor Type"::" " THEN
                            ERROR('Please Specify GST Vendor Type') //added by sujani  on 19-Dec-18
                        ELSE BEGIN
                            IF "GST Vendor Type" = "GST Vendor Type"::Registered THEN
                                IF "GST Registration No." = '' THEN
                                    ERROR('Please Specify GST Registration No');
                        END;

                        IF "Payment Method Code" = 'CHQ' THEN
                            Payment_Mode := 'CHEQUE'
                        ELSE
                            Payment_Mode := "Payment Method Code";
                        //Added By Pranavi
                        IF Name <> '' THEN BEGIN
                            position1 := STRPOS(Name, FORMAT(charvar));
                            IF position1 > 0 THEN
                                name1 := DELSTR(Name, position1, 1)
                            ELSE
                                name1 := Name;
                        END;
                        IF "Name 2" <> '' THEN BEGIN
                            position2 := STRPOS("Name 2", FORMAT(charvar));
                            IF position2 > 0 THEN
                                name2 := DELSTR("Name 2", position2, 1)
                            ELSE
                                name2 := "Name 2";
                        END;
                        //End By Pranavi
                        //Added by Pranavi on 24-Dec-2015
                        /*IF ("RTGS Code" <> '') AND ("Payment Method Code" <> 'RTGS') THEN
                            ERROR('Payment Method Code must be "RTGS"!');*/ // commented by vijaya on 24-01-2018 bcoz Payment method code need not to be RTGS even if vendor had RTGS Code
                        IF "Payment Method Code" = 'RTGS' THEN BEGIN
                            IF "RTGS Code" = '' THEN
                                ERROR('Please enter RTGS CODE in Payments Tab as payment method is RTGS!');
                            IF "Our Account No." = '' THEN
                                ERROR('Please enter Our Account No. in Payments Tab as payment method is RTGS!');
                            IF "Name of Bank" = '' THEN
                                ERROR('Please enter Name of Bank in Payments Tab as payment method is RTGS!');
                            IF "Branch Name" = '' THEN
                                ERROR('Please enter Branch Name in Payments Tab as payment method is RTGS!');
                            IF "E-Mail" = '' THEN
                                ERROR('Please enter E-Mail Address!');
                            IF "Mobile No." = '' THEN
                                ERROR('Please enter Mobile No.!');
                            MobileNo := "Mobile No.";
                        END ELSE
                            MobileNo := "Phone No.";
                        //End by Pranavi
                        // Added by Pranavi on 24-feb-2016 for TIN number validation
                        /* IF USERID <> 'EFFTRONICS\PRANAVI' THEN
                         IF ("T.I.N. No." = '') AND ("T.I.N Status" IN["T.I.N Status"::" ","T.I.N Status"::TINAPPLIED]) THEN
                           ERROR('Please enter T.I.N Number in Tax Information Tab!');*/
                        // End by Pranavi
                        CASHFLOWCONNECTION.ExecInOracle('Delete  From MRP_ERP_VENDOR where VENDOR_ID=''' + "No." + '''');
                        CASHFLOWCONNECTION.ExecInOracle('Delete  From MRP_ERP_VENDOR where VENDOR_ID=''' + "No." + '''');
                        CASHFLOWCONNECTION.ExecInOracle(
                               'INSERT INTO MRP_ERP_VENDOR (VENDOR_ID,NAME,CITY,DETAIL,ADDRESSLINE1,ADDRESSLINE2,STATE,CUST_CATEGORY,BANKNAME,' +
                               'BRANCHNAME,ACCOUNTNO, RTGSCODE,PAY_MODE,EMAIL_ID,CONTACT_PERSON,CONTACT_PHONE,VEN_TYPE,SWIFT_CODE,BANK_ADDR)  VALUES ' +
                                          '(''' + "No." + ''',''' + CommaRemoval(name1 + ' ' + name2) + ''',''' +
                                          CommaRemoval(City) + ''',''' + CommaRemoval(name1) + ''',''' +
                                          'null' + ''',''' + 'null' + ''',''' + CommaRemoval("State Code") + ''',''' + FORMAT(cat) + ''',''' +
                                          "Name of Bank" + ''',''' + "Branch Name" + ''',''' + "Our Account No." + ''',''' + "RTGS Code" + ''',''' +
                                          Payment_Mode + ''',''' + "E-Mail" + ''',''' + Contact + ''',''' + MobileNo + ''',''' + FORMAT(Type) + ''',''' + FORMAT("swift Code") + ''',''' + FORMAT("Bank Address") + ''')');
                    END ELSE BEGIN
                        //CASHFLOWCONNECTION.ExecInOracle('Delete  From MRP_ERP_VENDOR where VENDOR_ID='''+"No."+'''');
                    END;

                end;
            }
            field("Vendor Balance Verified"; "Vendor Balance Verified")
            {
                Caption = 'Vendor Balance Verified';
                ApplicationArea = All;
            }
            field("Prod Vendor Balance"; "Prod Vendor Balance")
            {
                ApplicationArea = All;

                trigger OnDrillDown();

                begin
                    Rec.DrillDownProdVendorBalance;
                end;
            }
            field(Vendor_Type; Vendor_Type)
            {
                Caption = 'Vendor Type';
                ApplicationArea = All;
            }
        }
        addafter("Balance (LCY)")
        {
            field("CS Vendor Balance"; "CS Vendor Balance")
            {
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    DrillDownCSVendorBalance;
                end;
            }
            field("RD Vendor Balance"; "RD Vendor Balance")
            {
                ApplicationArea = All;

                trigger OnDrillDown();
                begin
                    DrillDownRDVendorBalance;
                end;
            }
            field("Admin Vendor Balance"; "Admin Vendor Balance")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Date Modified")
        {
            field("TDS Alert"; "TDS Alert")
            {
                ApplicationArea = All;
            }
            field("Vendor Category"; "Vendor Category")
            {
                ApplicationArea = All;
            }
            field("Vendor Status"; "Vendor Status")
            {
                ApplicationArea = All;
            }
            field("Minimum Order Value"; "Minimum Order Value")
            {
                Editable = MINIMUMORDERVALCHECK;
                ApplicationArea = All;
            }
            field("Online Vendor"; "Online Vendor")
            {
                ApplicationArea = All;
            }
            field("swift Code"; REc."swift Code")
            {
                ApplicationArea = All;
            }
            field("Bank Address"; Rec."Bank Address")
            {
                ApplicationArea = All;
            }
            group("Approvals Info")
            {
                Caption = 'Approvals Info';
                field("Maanager Approved"; "Maanager Approved")
                {
                    Caption = '" Approved"';
                    Editable = Manager_Appr;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        // added by Vishnu Priya on 12-11-2020
                        IF "Maanager Approved" = TRUE THEN BEGIN
                            Rec."Approved By" := USERID;
                            Rec.MODIFY;
                        END
                        ELSE BEGIN
                            Rec."Approved By" := '';
                            Rec.MODIFY;
                        END;

                    end;
                }
                field("Approved By"; "Approved By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Created_Date_time; Created_Date_time)
                {
                    Caption = 'Created Date Time';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Phone No. 2>"; "Phone No.")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("Phone No2"; "Phone No2")
                {
                    ApplicationArea = All;
                }
                field("Phone No3"; "Phone No3")
                {
                    ApplicationArea = All;
                }
                field("Phone No4"; "Phone No4")
                {
                    ApplicationArea = All;
                }
                field("Mobile No."; "Mobile No.")
                {
                    ApplicationArea = All;
                }
            }
        }

        addafter("IC Partner Code")
        {
            field(Remarks; Remarks)
            {
                ApplicationArea = All;
            }
            field("Transportation Days"; "Transportation Days")
            {
                ApplicationArea = All;
            }
        }
        addafter("Tax Liable")
        {
            field("MSPT Code"; "MSPT Code")
            {
                ApplicationArea = All;
            }
            field("Consider Vendor Invoice Date"; "Consider Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
            field("Standard Packing %"; "Standard Packing %")
            {
                ApplicationArea = All;
            }
            field("Standard Insurnece %"; "Standard Insurnece %")
            {
                ApplicationArea = All;
            }
        }
        addafter("Prepayment %")
        {
            //EFFUPG<<
            /*
             field(Structure; Structure)
             {
                 ApplicationArea = All;
             }
             */
            //EFFUPG>>
        }
        addafter("Our Account No.")
        {
            field("Name of Bank"; "Name of Bank")
            {
                ApplicationArea = All;
            }
            field("Branch Name"; "Branch Name")
            {
                ApplicationArea = All;
            }
            field("RTGS Code"; "RTGS Code")
            {
                ApplicationArea = All;
            }
            field(category; category)
            {
                ApplicationArea = All;
            }
            field("T.I.N Status"; "T.I.N Status")
            {
                ApplicationArea = All;
            }
            field("TAN Number"; "TAN Number")
            {
                ApplicationArea = All;
            }
            group(GSTCust)
            {
                Caption = 'GST';


                field("GST Verification"; "GST Verification")
                {
                    ApplicationArea = All;
                }
            }
            group(Quality)
            {
                Caption = 'Quality';
                field("Rework Location"; "Rework Location")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        modify("Ledger E&ntries")
        {
            Promoted = false;
        }
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(NewBlanketPurchaseOrder)
        {
            Promoted = false;
        }
        modify(NewPurchaseQuote)
        {
            Promoted = false;
        }
        modify(NewPurchaseInvoice)
        {
            Promoted = true;
        }
        modify(NewPurchaseOrder)
        {
            Promoted = true;
        }
        modify(NewPurchaseCrMemo)
        {
            Promoted = false;
        }
        modify(NewPurchaseReturnOrder)
        {
            Promoted = false;
        }
        modify(Approve)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Reject)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        modify(Delegate)
        {
            Promoted = true;
        }
        modify(SendApprovalRequest)
        {
            Promoted = true;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = true;
        }
        modify(ApplyTemplate)
        {
            Promoted = true;
        }

        modify("Purchase Journal")
        {
            Promoted = true;
        }
        modify("Vendor - Labels")
        {
            Promoted = false;
        }
        modify("Vendor - Balance to Date")
        {
            Promoted = false;
        }
        addfirst("Ven&dor")
        {
            group("Purchase &History")
            {
                Caption = 'Purchase &History';
            }
        }
        addafter("Co&mments")
        {
            action("&MSPT Payables")
            {
                Caption = '&MSPT Payables';
                RunObject = Page "MSPT Vendor Purchases";
                RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
                ApplicationArea = All;
            }
        }
        addafter("Blanket Orders")
        {
            action("Order Lines")
            {
                Caption = 'Order Lines';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    PLGrec.RESET;
                    PLGrec.SETFILTER(PLGrec."Buy-from Vendor No.", "No.");
                    PLGrec.SETFILTER(PLGrec."Order Date", '>%1', DMY2DATE(1, 4, 2008));
                    PLGrec.SETFILTER(PLGrec.Quantity, '>%1', 0);
                    PAGE.RUNMODAL(56, PLGrec);
                end;
            }
        }
        addafter("Vendor - Balance to Date")
        {
            action("GST Details")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    HYPERLINK('http://app.efftronics.org:8567/GSTRegInternal/GSTRegistrationDetails.aspx?V_C_Num=' + "No.");
                end;
            }
            action("Send GST Mail")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    GSTMails;
                end;
            }
            /*action(Attachments)
            {
                Caption = 'Attachments';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "ESPL Attachments";
                RunPageLink = "Table ID" = CONST(23), "Document No." = FIELD("No.");
                ApplicationArea = All;
            }*/
        }
    }

    trigger OnOpenPage()
    var
        CustomEvent: codeunit 60027;
    begin
        IF NOT CustomEvent.Permission_Checking(USERID, 'VENDOR_MINIMUMORDER_') THEN
            MINIMUMORDERVALCHECK := FALSE
        ELSE
            MINIMUMORDERVALCHECK := TRUE;
        //VENDOR_APPROVAL
        IF NOT CustomEvent.Permission_Checking(USERID, 'VENDOR_APPROVAL') THEN
            Manager_Appr := FALSE
        ELSE
            Manager_Appr := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "User Id" := USERID;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        /* IF "Updated in Cashflow" = TRUE THEN BEGIN

            TESTFIELD(Name);
            TESTFIELD(City);
            IF category = category::Primary THEN
                cat := 1
            ELSE
                IF category = category::Secondary THEN
                    cat := 2
                ELSE
                    IF category = category::Lower THEN
                        cat := 3;
            IF cat = 0 THEN
                ERROR('Select category for Vendor');
            IF "Purchaser Code" = '' THEN
                ERROR('Please select Purchaser Code!');     //added by pranavi on 18-jun-2016


            IF "Vendor Posting Group" <> 'FOREIGN' THEN
                TESTFIELD("State Code");

            IF "Payment Method Code" = 'CHQ' THEN
                Payment_Mode := 'CHEQUE'
            ELSE
                Payment_Mode := "Payment Method Code";
            //Added By Pranavi
            IF Name <> '' THEN BEGIN
                position1 := STRPOS(Name, FORMAT(charvar));
                IF position1 > 0 THEN
                    name1 := DELSTR(Name, position1, 1)
                ELSE
                    name1 := Name;
            END;
            IF "Name 2" <> '' THEN BEGIN
                position2 := STRPOS("Name 2", FORMAT(charvar));
                IF position2 > 0 THEN
                    name2 := DELSTR("Name 2", position2, 1)
                ELSE
                    name2 := "Name 2";
            END;
            //End By Pranavi
            //Added by Pranavi on 24-Dec-2015
            IF "Payment Method Code" = 'RTGS' THEN BEGIN
                IF "RTGS Code" = '' THEN
                    ERROR('Please enter RTGS CODE in Payments Tab as payment method is RTGS!');
                IF "Our Account No." = '' THEN
                    ERROR('Please enter Our Account No. in Payments Tab as payment method is RTGS!');
                IF "Name of Bank" = '' THEN
                    ERROR('Please enter Name of Bank in Payments Tab as payment method is RTGS!');
                IF "Branch Name" = '' THEN
                    ERROR('Please enter Branch Name in Payments Tab as payment method is RTGS!');
            END;
            //End by Pranavi
            // Added by Pranavi on 24-feb-2016 for TIN number validation
            IF ("T.I.N. No." = '') AND ("T.I.N Status" IN ["T.I.N Status"::" ", "T.I.N Status"::TINAPPLIED]) THEN
                ERROR('Please enter T.I.N Number in Tax Information Tab!');
            // End by Pranavi
            MESSAGE('update MRP_ERP_VENDOR set NAME = ''' + CommaRemoval(name1 + ' ' + name2) +
                                ''',CITY = ''' + CommaRemoval(City) + ''',DETAIL= ''' + CommaRemoval(name1) + ''',STATE = ''' + CommaRemoval("State Code") +
                                ''',CUST_CATEGORY = ''' + FORMAT(cat) + ''',BANKNAME = ''' + "Name of Bank" + ''',BRANCHNAME = ''' + "Branch Name" +
                                ''',ACCOUNTNO = ''' + "Our Account No." + ''', RTGSCODE = ''' + "RTGS Code" + ''',PAY_MODE = ''' + Payment_Mode +
                                ''',EMAIL_ID = ''' + "E-Mail" + ''',CONTACT_PERSON = ''' + Contact +
                                ''',CONTACT_PHONE = ''' + "Phone No." + ''' where VENDOR_ID = ''' + "No." + '''');


            CASHFLOWCONNECTION.ExecInOracle('update MRP_ERP_VENDOR set NAME = ''' + CommaRemoval(name1 + ' ' + name2) +
                                ''',CITY = ''' + CommaRemoval(City) + ''',DETAIL= ''' + CommaRemoval(name1) + ''',STATE = ''' + CommaRemoval("State Code") +
                                ''',CUST_CATEGORY = ''' + FORMAT(cat) + ''',BANKNAME = ''' + "Name of Bank" + ''',BRANCHNAME = ''' + "Branch Name" +
                                ''',ACCOUNTNO = ''' + "Our Account No." + ''', RTGSCODE = ''' + "RTGS Code" + ''',PAY_MODE = ''' + Payment_Mode +
                                ''',EMAIL_ID = ''' + "E-Mail" + ''',CONTACT_PERSON = ''' + Contact +
                                ''',CONTACT_PHONE = ''' + "Phone No." + ''' where VENDOR_ID = ''' + "No." + '''');

        END; */

    end;


    var
        CASHFLOWCONNECTION: Codeunit "Cash Flow Connection";
        cat: Integer;
        Payment_Mode: Code[10];
        PLGrec: Record "Purchase Line";
        Text003: Label 'The email address "%1" is invalid.';
        tempstr: Text;
        position1: Integer;
        charvar: Char;
        name1: Text;
        name2: Text;
        position2: Integer;
        MobileNo: Code[100];
        MINIMUMORDERVALCHECK: Boolean;
        //  SMTP_MAIL: Codeunit "SMTP Mail";
        Manager_Appr: Boolean;
        StartDateLVar: Date;
        EndDateLVar: Date;
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";



    procedure CommaRemoval(Base: Text[100]) Converted: Text[50];
    var
        i: Integer;
    begin
        FOR i := 1 TO STRLEN(Base) DO BEGIN
            IF COPYSTR(Base, i, 1) <> ',' THEN
                Converted += COPYSTR(Base, i, 1);
        END;
        EXIT(Converted);
    end;


    local procedure CheckValidEmailAddresses(Recipients: Text);
    var
        TmpRecipients: Text;
    begin
        IF Recipients <> '' THEN BEGIN
            TmpRecipients := Recipients;
            WHILE STRPOS(TmpRecipients, ',') > 1 DO BEGIN
                CheckValidEmailAddress(COPYSTR(TmpRecipients, 1, STRPOS(TmpRecipients, ',') - 1));
                TmpRecipients := COPYSTR(TmpRecipients, STRPOS(TmpRecipients, ',') + 1);
            END;
            CheckValidEmailAddress(TmpRecipients);
        END;
    end;

    local procedure CheckValidEmailAddress(EmailAddress: Text);
    var
        i: Integer;
        NoOfAtSigns: Integer;
    begin

        IF (EmailAddress[1] = '@') OR (EmailAddress[STRLEN(EmailAddress)] = '@') THEN
            ERROR(Text003, EmailAddress);

        FOR i := 1 TO STRLEN(EmailAddress) DO BEGIN
            IF EmailAddress[i] = '@' THEN
                NoOfAtSigns := NoOfAtSigns + 1;
            IF NOT (
                    ((EmailAddress[i] >= 'a') AND (EmailAddress[i] <= 'z')) OR
                    ((EmailAddress[i] >= 'A') AND (EmailAddress[i] <= 'Z')) OR
                    ((EmailAddress[i] >= '0') AND (EmailAddress[i] <= '9')) OR
                    ((NoOfAtSigns = 0) AND (EmailAddress[i] IN ['!', '#', '$', '%', '&', '''',
                                                                '*', '+', '-', '/', '=', '?',
                                                                '^', '_', '`', '.', '{', '|',
                                                                '}', '~'])) OR
                    ((NoOfAtSigns > 0) AND (EmailAddress[i] IN ['@', '.', '-', '[', ']'])))
            THEN
                ERROR(Text003, EmailAddress);
        END;

        IF NoOfAtSigns <> 1 THEN
            ERROR(Text003, EmailAddress);
    end;

    procedure GSTMails();
    var
        Type: Code[2];
        No: Code[20];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1024];
        RowCount: Integer;
        //SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        // RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        TempText: Text;
        ConnectionOpen: Integer;
        Body: Text;
        Attachment: Text;
    begin
        /*
        IF ISCLEAR(SQLConnection) THEN
            CREATE(SQLConnection, FALSE, TRUE);

        IF ISCLEAR(RecordSet) THEN
            CREATE(RecordSet, FALSE, TRUE);
        ConnectionOpen := 0;
        IF ConnectionOpen <> 1 THEN BEGIN
            SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
            SQLConnection.Open;
            //SQLConnection.BeginTrans;
            ConnectionOpen := 1;
        END;
        //SQLQuery := 'select * from Vendor_Cust_List where NO in(''CUST00971'',''CUST00972'') and (MAIL_SEND_COUNT <=0 or MAIL_SEND_COUNT is null) order by type,no;';
        SQLQuery := 'select * from Vendor_Cust_List where NO = ''' + "No." + ''' order by type,no;';
        //MESSAGE(SQLQuery);
        RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
            RecordSet.MoveFirst;
        WHILE NOT RecordSet.EOF DO BEGIN
            Type := FORMAT(RecordSet.Fields.Item('TYPE').Value);
            No := FORMAT(RecordSet.Fields.Item('NO').Value);
            IF Type = 'V' THEN
                Mail_From := 'purchase@efftronics.com'
            ELSE
                Mail_From := 'sales@efftronics.com';
            Mail_To := FORMAT(RecordSet.Fields.Item('EMAIL').Value);
            Mail_To := 'pranavi@efftronics.com';

            Subject := 'Reg : GST Information Requirements from Efftronics System Pvt Ltd.,!';
            Body := '<html><head><style> divone{background-color: white; width: 1210px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
            Body := Body + '<body><div style="border-color:#666699; margin: 20px; border-width:15px; border-style:solid; padding: 20px; width: 1110px;"><label><font size="6">GST Information Requirements from Efftronics System Pvt Ltd.,!</font></label>';
            Body := Body + '<hr style=solid; color= #3333CC>';
            Body := Body + '<h>Dear Sir/Madam,</h><br><br>';
            Body := Body + '<P> As you are aware, GST Roll out is likely to be from 01st July 2017. </P>';
            Body := Body + '<P> We need to update our records with the Provisional GSTIN Registration Numbers of all our Vendors/Customers. ';
            Body := Body + 'Request you to kindly update PAN & GST registration provisional ID in <b><font color="red">below link</font></b> immediately.</P><br/>';
            //Body := Body+'<b>URL :</b><a href="http://localhost:51203/GSTRegistrationDetails.aspx?&V_C_Num=';
            Body := Body + '<font size="6"><b>URL :</b><b><a href="http://app.efftronics.org:8567/GST_Registration/GSTRegistrationDetails.aspx?V_C_Num=';
            //Body := Body+'<font size="6"><b>URL :</b><b><a href="http://app.efftronics.org:8567/GST_Reg_Internal/GSTRegistrationDetails.aspx?V_C_Num=';
            Body := Body + No + '" target="_blank">GST Registration Details</a></b></font><br/><br/>';
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
            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            Attachment := '\\erpserver\ErpAttachments\Efftronics_GST_Details.pdf';
            SMTP_MAIL.AddAttachment(Attachment, '');
            SMTP_MAIL.AddCC('erp@efftronics.com');
            SMTP_MAIL.Send;
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
            MESSAGE('Mail Has been send to ' + COPYSTR(TempText, 1, STRLEN(TempText) - 1) + ' - ' + Name + ' at ' + Mail_To);
            */
    end;

    procedure DrillDownCSVendorBalance()
    begin
        StartDateLVar := DMY2Date(01, 04, 10);
        EndDateLVar := DMY2Date(31, 03, 22);//modified by durga 23-07-2021


        VendLedgEntryLRec.RESET;
        VendLedgEntryLRec.SETCURRENTKEY("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SETRANGE("Vendor No.", "No.");
        VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 1", 'CUS-002', 'CUS-005');
        IF "Global Dimension 2 Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        IF "Currency Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SETRANGE("Posting Date", StartDateLVar, EndDateLVar);
        IF VendLedgEntryLRec.FINDFIRST THEN BEGIN
            CLEAR(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SETTABLEVIEW(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RUNMODAL;
        END;
    end;

    procedure DrillDownRDVendorBalance()
    begin
        /*StartDateLVar := DMY2Date(04, 01, 10);
        EndDateLVar := DMY2Date(03, 31, 22);*///modified by durga 23-07-2021

        StartDateLVar := DMY2Date(01, 04, 10);
        EndDateLVar := DMY2Date(31, 03, 22);

        VendLedgEntryLRec.RESET;
        VendLedgEntryLRec.SETCURRENTKEY("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SETRANGE("Vendor No.", "No.");
        VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 1", 'RD-000', 'RD-010');
        IF "Global Dimension 2 Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        IF "Currency Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SETRANGE("Posting Date", StartDateLVar, EndDateLVar);
        IF VendLedgEntryLRec.FINDFIRST THEN BEGIN
            CLEAR(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SETTABLEVIEW(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RUNMODAL;
        END;
    end;

}

