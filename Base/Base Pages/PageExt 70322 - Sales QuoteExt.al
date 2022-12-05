pageextension 70322 SalesQuoteExt extends "Sales Quote"
{
    // version NAVW19.00.00.50868,NAVIN9.00.00.50868,B2B1.0,B2BQTO

    layout
    {
        modify("Sell-to Post Code")
        {
            CaptionML = ENU = 'Sell-to Post Code/City';
        }
        modify("Order Date")
        {
            CaptionML = ENU = 'Quotation Date';
        }

        modify(Status)
        {
            CaptionML = ENU = 'Status';
        }


        modify("Bill-to Post Code")
        {
            CaptionML = ENU = 'Bill-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            CaptionML = ENU = 'Ship-to Post Code/City';
        }


        //trigger OnValidate();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        SelltoCustomerNoOnAfterValidat;
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        CustomerSpecification.RESET;
        CustomerSpecification.SETRANGE("Customer No.","Sell-to Customer No.");
        IF CustomerSpecification.FINDSET THEN BEGIN
          SalesQuoteSpecification.RESET;
          SalesQuoteSpecification.SETRANGE("Sales Quote No.","No.");
          IF SalesQuoteSpecification.FINDLAST THEN
            SnoGVar := SalesQuoteSpecification."No."+1
          ELSE
            SnoGVar := 1;
          REPEAT
            SalesQuoteSpecification.INIT;
            SalesQuoteSpecification."No." := SnoGVar;
            SalesQuoteSpecification."Sales Quote No." := "No.";
            SalesQuoteSpecification."Lookup Code" := CustomerSpecification."Lookup Code";
            SalesQuoteSpecification."Lookup Type ID" := CustomerSpecification."Lookup Type ID";
            SalesQuoteSpecification."Lookup Type Name" := CustomerSpecification."Lookup Type Name";
            SalesQuoteSpecification.Description := CustomerSpecification.Description;
            SalesQuoteSpecification.INSERT;
            SnoGVar +=1;
          UNTIL CustomerSpecification.NEXT = 0;
        END;

        //added by Vishnu Priya on 04-12-2020 for the default entry of this customer in contact list
        IF Customer.GET("Sell-to Customer No.") THEN
          BEGIN
            Cust_Contact.INIT;
            Cust_Contact."No." := 1;
            Cust_Contact."Sales Quote No." := Rec."No.";
            Cust_Contact."Customer\Contact" := Rec."Sell-to Customer No.";
            Cust_Contact."Email Id" := Customer."E-Mail";
            Cust_Contact.Name := Customer.Name;
            Cust_Contact.Place := Customer.City;
            Cust_Contact.Type := Cust_Contact.Type::Customer;
            Cust_Contact.INSERT;
          END;
        //added by Vishnu Priya on 04-12-2020




        SelltoCustomerNoOnAfterValidat;
        */
        //end;
        /*
        modify("Control 15")
        {
            Visible = false;
        }
        modify("Control 1500019")
        {
            Visible = false;
        }*/
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                SalesLine.RESET;
                SalesLine.SETFILTER(SalesLine."Document No.", Rec."No.");
                IF SalesLine.FINDSET THEN
                    SalesLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
            end;
        }
        addafter("No. of Archived Versions")
        {
            field("Type of Customer"; "Type of Customer")
            {
            }
            field("Type of Product"; "Type of Product")
            {
            }
            field("Pending(LOA)Value"; "Pending(LOA)Value")
            {
            }
            field("Total Order(LOA)Value"; "Total Order(LOA)Value")
            {
            }
            field("Document Dates"; "Document Date")
            {
                Caption = 'Customer Enquiry Date';
            }
            field(QuoteValue; QuoteValue)
            {
                Caption = 'Quotation Value';
            }
            field("Sale Order Total Amount"; "Sale Order Total Amount")
            {
                Caption = 'Quote value';
            }
        }
        addafter("Order Date")
        {
            field(Product; Product)
            {
            }
            field("Type of Enquiry"; "Type of Enquiry")
            {
            }
        }
        addafter("Responsibility Center")
        {
            field("Nature of Enquiry"; "Nature of Enquiry")
            {
            }
        }
        addafter("Assigned User ID")
        {
            field("Shipment Dates"; "Shipment Date")
            {
                Caption = 'Response Date';
            }
        }
        addafter(Status)
        {
            field("Enquiry Status"; "Enquiry Status")
            {
            }
            field("Package Tracking Nos"; "Package Tracking No.")
            {
                Caption = 'Quote Commu. Mode';
            }
        }
        addafter(SalesLines)
        {
            group("Mailing Purpose")
            {
                Caption = 'Mailing Purpose';
                field(Remarks; Remarks)
                {
                    Caption = 'Subject';
                }
                field("Your References"; "Your Reference")
                {
                }
            }
        }
        addafter("Ship-to Contact")
        {
            field("MSPT Date"; "MSPT Date")
            {
            }
            field("MSPT Code"; "MSPT Code")
            {
            }
        }
        addafter("Foreign Trade")
        {
            field("<Sell-to Customer Template C>"; "Sell-to Customer Template Code")
            {

                trigger OnValidate();
                begin
                    SelltoCustomerTemplateCodeC100;
                end;
            }
            field("<Enquiry Status2>"; "Enquiry Status")
            {
            }
        }
        addafter(Product)
        {
            field("Document Position"; "Document Position")
            {
            }
        }
    }
    actions
    {


        //Unsupported feature: CodeModification on "Action 1500003.OnAction". Please convert manually.

        //trigger OnAction();
        //Parameters and return type have not been exported.
        //>>>> ORIGINAL CODE:
        //begin
        /*
        CALCFIELDS("Price Inclusive of Taxes");
        IF "Price Inclusive of Taxes" THEN BEGIN
          SalesLine.InitStrOrdDetail(Rec);
        #4..6
        SalesLine.CalculateStructures(Rec);
        SalesLine.AdjustStructureAmounts(Rec);
        SalesLine.UpdateSalesLines(Rec);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..9
        QuoteValueCalculation;
        */
        //end;
        addafter(Approvals)
        {
            separator("Action1500002")
            {
            }
            action("&MSPT Order Details")
            {
                Caption = '&MSPT Order Details';
                RunObject = Page 60105;
                RunPageLink = Type = CONST(Sale),
                              "Document Type" = FIELD("Document Type"),
                              "Document No." = FIELD("No."),
                              "MSPT Header Code" = FIELD("MSPT Code"),
                              "Party No." = FIELD("Sell-to Customer No.");
            }
            action(Schedule)
            {
                Caption = 'Schedule';
                RunObject = Page 60189;
                RunPageLink = "Document No." = FIELD("Tender No."),
                              "Document Type" = CONST(Quote);
            }
            action("Quote Specification")
            {
                Caption = 'Quote Specification';
                Image = SpecialOrder;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 60271;
                RunPageLink = "Sales Quote No." = FIELD("No.");
            }
            action("Quote Customer List")
            {
                Caption = 'Quote Customer List';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    QuoteCustomerList: Page 60274;
                    Customer: Record 18;
                begin
                    Customer.RESET;
                    CLEAR(QuoteCustomerList);
                    QuoteCustomerList.SETRECORD(Customer);
                    QuoteCustomerList.SETTABLEVIEW(Customer);
                    QuoteCustomerList.LOOKUPMODE(TRUE);
                    QuoteCustomerList.SendQuoteNo(Rec."No.");
                    IF QuoteCustomerList.RUNMODAL = ACTION::LookupOK THEN;
                end;
            }
            action("Quote Contact List")
            {
                Caption = 'Quote Contact List';
                Image = CustomerContact;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    QuoteContactList: Page 60273;
                    Contact: Record 5050;
                begin
                    Contact.RESET;
                    CLEAR(QuoteContactList);
                    QuoteContactList.SETRECORD(Contact);
                    QuoteContactList.SETTABLEVIEW(Contact);
                    QuoteContactList.LOOKUPMODE(TRUE);
                    QuoteContactList.SendQuoteNo(Rec."No.");
                    IF QuoteContactList.RUNMODAL = ACTION::LookupOK THEN;
                end;
            }
            action("Customer/Contact List")
            {
                Caption = 'Customer/Contact List';
                Image = ContactFilter;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 60272;
                RunPageLink = "Sales Quote No." = FIELD("No.");
            }
        }
        addafter(Email)
        {
            action(PrintPDF)
            {
                Caption = 'Mail to Customers';

                trigger OnAction();
                var
                    SalesHeader2: Record 36;
                    FileDirectory: Text[250];
                    FileName: Text[250];
                    PDFMergeMgt4: Codeunit 33000890;
                    ReportPdf: Text;
                    OperationPdf: Text;
                    TempBlob: Record "Upgrade Blob Storage";
                    FileManagement: Codeunit 419;
                    CustomerContactData: Record 14125605;
                    Attachments: Record 60098;
                    AttachmentMgt: Codeunit 60001;
                    "---mail----": Integer;
                    ToMail: Text[250];
                    FromMail: Text[250];
                    SMTPMail: Codeunit 400;
                    Subject: Text[250];
                    MonthGvar: Text;
                    YearGVar: Integer;
                    totVendor: Integer;
                    PurchaseHeader: Record 38;
                    CustomerGRec: Record 18;
                    SalespersonPurchaserGRec: Record 13;
                    RegName: Text[250];
                    RegJobTitle: Text[250];
                    RegEmail: Text[250];
                    RegPhone: Text[250];
                    ContactGRec: Record 5050;
                    PdfCount: Text;
                begin
                    FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\';
                    CLEAR(FileDirectory);
                    Window.OPEN('Creating Pdf -------#1############');
                    SalesHeader2.RESET;
                    SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Quote);
                    SalesHeader2.SETRANGE("No.", Rec."No.");
                    IF SalesHeader2.FINDFIRST THEN BEGIN
                        FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\';
                        CustomerContactData.RESET;
                        CustomerContactData.SETRANGE("Sales Quote No.", SalesHeader2."No.");
                        CustomerContactData.SETRANGE("Mail Send", FALSE);
                        IF CustomerContactData.FINDSET THEN
                            REPEAT
                                CLEAR(FileName);
                                CLEAR(ReportPdf);
                                FileName := RemoveSpecialChar(CustomerContactData."Customer\Contact");
                                ReportPdf := FORMAT(FileDirectory) + FORMAT(FileName) + '.pdf';

                                CLEAR(QuoteFormatLatest);
                                QuoteFormatLatest.SETTABLEVIEW(SalesHeader2);
                                QuoteFormatLatest.SetValues(CustomerContactData.Type, CustomerContactData."Customer\Contact");
                                QuoteFormatLatest.SAVEASPDF(ReportPdf);

                                Window.UPDATE(1, ReportPdf);
                                Attachments.RESET;
                                Attachments.SETRANGE("Document Type", Attachments."Document Type"::Quote);
                                Attachments.SETRANGE("Table ID", 36);
                                Attachments.SETRANGE("Document No.", Rec."No.");
                                Attachments.SETRANGE("Attachment Status", TRUE);
                                IF Attachments.FINDSET THEN
                                    REPEAT
                                        IF Attachments.FileAttachment.HASVALUE THEN
                                            TempBlob.Blob := Attachments.FileAttachment;
                                        //OperationPdf := Attachments."Storage File Name";
                                        PdfCount := Attachments."Storage File Name";
                                        //Merging two PDF
                                        SLEEP(30000);
                                        PDFMergeMgt4.MergePDFFilesForAttachment(ReportPdf, PdfCount, '', '', '', ReportPdf);
                                        SLEEP(10000);
                                    UNTIL Attachments.NEXT = 0;
                                //Mail >>
                                FromMail := 'erp@efftronics.com';
                                Subject := 'Budgetary Quotation';
                                CLEAR(ToMail);
                                IF CustomerContactData."Email Id" <> '' THEN
                                    ToMail := CustomerContactData."Email Id";
                                IF (ToMail <> '') AND (FromMail <> '') THEN BEGIN
                                    //SMTPMail.CreateMessage('ERP', FromMail, ToMail, Subject, '', TRUE);
                                    SMTPMail.AddAttachment(ReportPdf, FileName + '.pdf');
                                    SMTPMail.AppendBody('Dear Customer,');
                                    SMTPMail.AppendBody('<BR><BR>');
                                    SMTPMail.AppendBody('Greetings of the day. We are here with furnishing the budgetary quote for your kind consideration');
                                    SMTPMail.AppendBody('<BR>');
                                    CLEAR(RegName);
                                    CLEAR(RegJobTitle);
                                    CLEAR(RegEmail);
                                    CLEAR(RegPhone);
                                    IF CustomerContactData.Type = CustomerContactData.Type::Customer THEN BEGIN
                                        CustomerGRec.GET(CustomerContactData."Customer\Contact");
                                        IF CustomerGRec."Salesperson Code" <> '' THEN BEGIN
                                            IF SalespersonPurchaserGRec.GET(CustomerGRec."Salesperson Code") THEN BEGIN
                                                RegName := SalespersonPurchaserGRec.Name;
                                                RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                                RegEmail := SalespersonPurchaserGRec."E-Mail";
                                                RegPhone := SalespersonPurchaserGRec."Phone No.";
                                            END;
                                        END;
                                    END ELSE BEGIN
                                        ContactGRec.GET(CustomerContactData."Customer\Contact");
                                        IF ContactGRec."Salesperson Code" <> '' THEN BEGIN
                                            IF SalespersonPurchaserGRec.GET(ContactGRec."Salesperson Code") THEN BEGIN
                                                RegName := SalespersonPurchaserGRec.Name;
                                                RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                                RegEmail := SalespersonPurchaserGRec."E-Mail";
                                                RegPhone := SalespersonPurchaserGRec."Phone No.";
                                            END;
                                        END;
                                    END;
                                    SMTPMail.AppendBody('<BR><BR>');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('<BR><BR>');
                                    SMTPMail.AppendBody('Thanking you..');
                                    SMTPMail.AppendBody('<BR><BR>');
                                    SMTPMail.AppendBody('Regards,');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody(RegName);
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody(RegJobTitle);
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Cell No :' + RegPhone);
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Mail Id:' + RegEmail);
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Vijayawada - 520010,');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Andhra Pradesh, India.');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Ph No : 0866-2483375');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
                                    SMTPMail.AppendBody('<BR>');
                                    SMTPMail.Send;
                                    CustomerContactData."Mail Send" := TRUE;
                                    CustomerContactData.MODIFY;
                                END;
                            //Mail <<
                            UNTIL CustomerContactData.NEXT = 0;
                        Window.CLOSE;
                        MESSAGE('mail send');
                    END;

                    //Exprot the Merged PDF
                    //TempBlob.Blob.IMPORT(ReportPdf);
                    //FileName := FileManagement.BLOBExport(TempBlob,FileName,TRUE);
                end;
            }
            action("Preview Report old")
            {
                Caption = 'Preview Report old';
                Visible = false;

                trigger OnAction();
                var
                    SalesHeader2: Record 36;
                    FileDirectory: Text[250];
                    FileName: Text[250];
                    PDFMergeMgt4: Codeunit 33000890;
                    ReportPdf: Text;
                    OperationPdf: Text;
                    //TempBlob: Record 99008535;//B2BUpg
                    FileManagement: Codeunit 419;
                    CustomerContactData: Record 14125605;
                    Attachments: Record 60098;
                    AttachmentMgt: Codeunit 60001;
                    "---mail----": Integer;
                    ToMail: Text[250];
                    FromMail: Text[250];
                    SMTPMail: Codeunit 400;
                    Subject: Text[250];
                    MonthGvar: Text;
                    YearGVar: Integer;
                    totVendor: Integer;
                    PurchaseHeader: Record 38;
                    CustomerGRec: Record 18;
                    SalespersonPurchaserGRec: Record 13;
                    RegName: Text[250];
                    RegJobTitle: Text[250];
                    RegEmail: Text[250];
                    RegPhone: Text[250];
                    ContactGRec: Record 5050;
                    I: Integer;
                    PdfCount: array[4] of Text;
                begin
                    FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\';
                    CLEAR(FileDirectory);
                    I := 0;
                    Attachments.RESET;
                    Attachments.SETRANGE("Document Type", Attachments."Document Type"::Quote);
                    Attachments.SETRANGE("Table ID", 36);
                    Attachments.SETRANGE("Document No.", Rec."No.");
                    Attachments.SETRANGE("Attachment Status", TRUE);
                    IF Attachments.FINDSET THEN
                        REPEAT
                            /*IF Attachments.FileAttachment.HASVALUE THEN
                                TempBlob.Blob := Attachments.FileAttachment;*///B2BUpg
                            //OperationPdf := Attachments."Storage File Name";
                            I += 1;
                            PdfCount[I] := Attachments."Storage File Name";
                        UNTIL (Attachments.NEXT = 0) OR (I = 4);
                    Window.OPEN('Creating Pdf -------#1############');
                    SalesHeader2.RESET;
                    SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Quote);
                    SalesHeader2.SETRANGE("No.", Rec."No.");
                    IF SalesHeader2.FINDFIRST THEN BEGIN
                        FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\';
                        CustomerContactData.RESET;
                        CustomerContactData.SETRANGE("Sales Quote No.", SalesHeader2."No.");
                        CustomerContactData.SETRANGE("Mail Send", FALSE);
                        IF CustomerContactData.FINDSET THEN BEGIN
                            REPEAT
                                CLEAR(FileName);
                                CLEAR(ReportPdf);
                                FileName := RemoveSpecialChar(CustomerContactData."Customer\Contact");
                                ReportPdf := FORMAT(FileDirectory) + FORMAT(FileName) + '.pdf';
                                CLEAR(QuoteFormatLatest);
                                QuoteFormatLatest.SETTABLEVIEW(SalesHeader2);
                                QuoteFormatLatest.SetValues(CustomerContactData.Type, CustomerContactData."Customer\Contact");
                                QuoteFormatLatest.SAVEASPDF(ReportPdf);
                                SLEEP(3000);
                                Window.UPDATE(1, ReportPdf);
                                //Merging two PDF
                                PDFMergeMgt4.MergePDFFilesForAttachment(ReportPdf, PdfCount[1], PdfCount[2], PdfCount[3], PdfCount[4], ReportPdf);
                                SLEEP(1000);
                            //Mail >>
                            /*
                                FromMail := 'erp@efftronics.com';
                                Subject := 'Efftronics company representative';
                                CLEAR(ToMail);
                                IF CustomerContactData."Email Id" <> '' THEN
                                  ToMail := CustomerContactData."Email Id";
                                 IF (ToMail <>'') AND (FromMail<>'')  THEN BEGIN
                                   SMTPMail.CreateMessage('ERP',FromMail,ToMail,Subject,'',TRUE);
                                   SMTPMail.AddAttachment(ReportPdf,FileName+'.pdf');
                                   SMTPMail.AppendBody('Dear Vendor,');
                                   SMTPMail.AppendBody('<BR><BR>');
                                   SMTPMail.AppendBody('Greetings of the day. We would like to inform that sales quote from  the company');
                                   SMTPMail.AppendBody('<BR>');
                                   CLEAR(RegName);
                                   CLEAR(RegJobTitle);
                                   CLEAR(RegEmail);
                                   CLEAR(RegPhone);
                                   IF CustomerContactData.Type = CustomerContactData.Type::Customer THEN BEGIN
                                      CustomerGRec.GET(CustomerContactData."Customer\Contact");
                                     IF CustomerGRec."Salesperson Code" <>''THEN BEGIN
                                       IF SalespersonPurchaserGRec.GET(CustomerGRec."Salesperson Code") THEN
                                          BEGIN
                                            RegName := SalespersonPurchaserGRec.Name;
                                            RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                            RegEmail := SalespersonPurchaserGRec."E-Mail";
                                            RegPhone := SalespersonPurchaserGRec."Phone No.";
                                          END;
                                     END;
                                   END ELSE BEGIN
                                     ContactGRec.GET(CustomerContactData."Customer\Contact");
                                     IF ContactGRec."Salesperson Code" <> '' THEN BEGIN
                                        IF SalespersonPurchaserGRec.GET(ContactGRec."Salesperson Code") THEN
                                          BEGIN
                                            RegName := SalespersonPurchaserGRec.Name;
                                            RegJobTitle := SalespersonPurchaserGRec."Job Title";
                                            RegEmail := SalespersonPurchaserGRec."E-Mail";
                                            RegPhone := SalespersonPurchaserGRec."Phone No.";
                                          END;
                                     END;
                                   END;
                                   SMTPMail.AppendBody('<BR><BR>');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('<BR><BR>');
                                   SMTPMail.AppendBody('Thanking you..');
                                   SMTPMail.AppendBody('<BR><BR>');
                                   SMTPMail.AppendBody('Regards,');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody(RegName);
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody(RegJobTitle);
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Cell No :'+ RegPhone);
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Mail Id:'+ RegEmail);
                                    SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('EfftronicsSystems Pvt. Ltd.,');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('40-15-9,Brundavan Colony,');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Vijayawada - 520010,');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Andhra Pradesh, India.');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Ph No : 0866-2483375');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.AppendBody('Website :<a href="http://www.effe.in/"><b>www.effe.in,</b></a><a href="https://www.efftronics.com/"><b>www.efftronics.com</b></a>');
                                   SMTPMail.AppendBody('<BR>');
                                   SMTPMail.Send;
                                   CustomerContactData."Mail Send" := TRUE;
                                   CustomerContactData.MODIFY;
                                   END;
                                   */
                            //Mail <<
                            UNTIL CustomerContactData.NEXT = 0;
                            MESSAGE('Pdf generated');
                        END;
                        Window.CLOSE;
                    END;

                    //Exprot the Merged PDF
                    /*TempBlob.Blob.IMPORT(ReportPdf);
                    FileName := FileManagement.BLOBExport(TempBlob, FileName, TRUE);*///B2BUpg

                end;
            }
            action("Preview Report")
            {
                Caption = 'Preview Report';
                Image = Print;
                ApplicationArea = all;

                trigger OnAction();
                var
                    SalesHeader2: Record 36;
                    FileDirectory: Text[250];
                    FileName: Text[250];
                    PDFMergeMgt4: Codeunit 33000890;
                    ReportPdf: Text;
                    OperationPdf: Text;
                    //TempBlob: Record 99008535;//B2BUpg
                    FileManagement: Codeunit 419;
                    CustomerContactData: Record 14125605;
                    Attachments: Record 60098;
                    AttachmentMgt: Codeunit 60001;
                    "---mail----": Integer;
                    ToMail: Text[250];
                    FromMail: Text[250];
                    SMTPMail: Codeunit 400;
                    Subject: Text[250];
                    MonthGvar: Text;
                    YearGVar: Integer;
                    totVendor: Integer;
                    PurchaseHeader: Record 38;
                    CustomerGRec: Record 18;
                    SalespersonPurchaserGRec: Record 13;
                    RegName: Text[250];
                    RegJobTitle: Text[250];
                    RegEmail: Text[250];
                    RegPhone: Text[250];
                    ContactGRec: Record 5050;
                    I: Integer;
                    PdfCount: Text;
                begin
                    FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\'; //  '\\erpserver\QuotePdf\';
                    CLEAR(FileDirectory);
                    Window.OPEN('Creating Pdf -------#1############');
                    SalesHeader2.RESET;
                    SalesHeader2.SETRANGE("Document Type", SalesHeader2."Document Type"::Quote);
                    SalesHeader2.SETRANGE("No.", Rec."No.");
                    IF SalesHeader2.FINDFIRST THEN BEGIN
                        FileDirectory := '\\erpserver\ErpAttachments\QuotePdf\';
                        CustomerContactData.RESET;
                        CustomerContactData.SETRANGE("Sales Quote No.", SalesHeader2."No.");
                        CustomerContactData.SETRANGE("Mail Send", FALSE);
                        IF CustomerContactData.FINDSET THEN BEGIN
                            REPEAT
                                CLEAR(FileName);
                                CLEAR(ReportPdf);
                                FileName := RemoveSpecialChar(CustomerContactData."Customer\Contact");
                                ReportPdf := FORMAT(FileDirectory) + FORMAT(FileName) + '.pdf';
                                CLEAR(QuoteFormatLatest);
                                QuoteFormatLatest.SETTABLEVIEW(SalesHeader2);
                                QuoteFormatLatest.SetValues(CustomerContactData.Type, CustomerContactData."Customer\Contact");
                                QuoteFormatLatest.SAVEASPDF(ReportPdf);
                                Window.UPDATE(1, ReportPdf);
                                //Merging two PDF
                                Attachments.RESET;
                                Attachments.SETRANGE("Table ID", 36);
                                Attachments.SETRANGE("Document No.", Rec."No.");
                                Attachments.SETRANGE("Attachment Status", TRUE);
                                IF Attachments.FINDSET THEN
                                    REPEAT
                                        /*IF Attachments.FileAttachment.HASVALUE THEN
                                            TempBlob.Blob := Attachments.FileAttachment;*///B2BUpg
                                        PdfCount := Attachments."Storage File Name";
                                        SLEEP(3000);
                                        PDFMergeMgt4.MergePDFFilesForAttachment(ReportPdf, PdfCount, '', '', '', ReportPdf);
                                        SLEEP(1000);
                                    UNTIL Attachments.NEXT = 0;
                            UNTIL CustomerContactData.NEXT = 0;
                            MESSAGE('Pdf generated')
                        END;
                        Window.CLOSE;
                    END;
                    //Exprot the Merged PDF
                    //TempBlob.Blob.IMPORT(ReportPdf);//B2BUpg
                    //FileName := FileManagement.BLOBExport(TempBlob, FileName, TRUE);//B2BUpg
                    if ReportPdf <> '' then
                        FileManagement.DownloadTempFile(ReportPdf);

                end;
            }
        }
        addafter("Archive Document")
        {
            action("Quote Attachment")
            {
                Caption = 'Quote Attachment';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    CustAttachments;
                end;
            }
        }
        addafter("C&reate Customer")
        {
            separator(Action)
            {
            }
            action("Release To Design")
            {
                Caption = 'Release To Design';

                trigger OnAction();
                var
                    Text01: Label 'Do You want to Send the Document to Design?';
                begin
                    IF NOT CONFIRM(Text01, FALSE) THEN
                        EXIT;
                    TESTFIELD("Document Position", "Document Position"::Sales);
                    "Document Position" := "Document Position"::Design;
                    MODIFY;
                end;
            }
        }
    }

    var
        MLTransactionType: Option Purchase,Sale;
        SalesHeader: Record 36;
        QuoteValue: Decimal;
        Buffervlaue: Decimal;
        "---B2B----": Integer;
        CustomerSpecification: Record 14125603;
        SalesQuoteSpecification: Record 14125604;
        SnoGVar: Integer;
        QuoteFormatLatest: Report 2000001;
        Window: Dialog;
        PageVar: Page 60272;
        Cust_Contact: Record 14125605;
        Customer: Record 18;
        SalesLine: Record "Sales Line";
        BilltoCustomerTemplateCodeEnab: Boolean;
        SelltoCustomerTemplateCodeEnab: Boolean;



    //Unsupported feature: CodeModification on "OnAfterGetCurrRecord". Please convert manually.

    //trigger OnAfterGetCurrRecord();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    ActivateFields;
    CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    ShowWorkflowStatus := CurrPage.WorkflowStatus.PAGE.SetFilterOnWorkflowRecord(RECORDID);
    CurrPage.ApprovalFactBox.PAGE.RefreshPage(RECORDID);
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..4
    //B2B
    DocumentPosition;
    */
    //end;




    trigger OnModifyRecord(): Boolean;
    begin
        IF Status = Status::Released THEN
            ERROR('Status Muste Be Open');
    end;


    //Unsupported feature: CodeModification on "OnOpenPage". Please convert manually.

    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    IF UserMgt.GetSalesFilter <> '' THEN BEGIN
      FILTERGROUP(2);
      SETRANGE("Responsibility Center",UserMgt.GetSalesFilter);
      FILTERGROUP(0);
    END;

    ActivateFields;

    SetDocNoVisible;
    SetLocGSTRegNoEditable;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    #1..7
    PageVar.SendQuoteNo(Rec."No."); // added by vishnu
    SetDocNoVisible;
    SetLocGSTRegNoEditable;
    */
    //end;

    procedure DocumentPosition();
    begin
        /*IF "Document Position" = "Document Position" :: Design THEN
          CurrPage.EDITABLE := FALSE
        ELSE
          CurrPage.EDITABLE := TRUE;    */

    end;

    local procedure SelltoCustomerTemplateCodeC100();
    begin
        ActivateFields;
        CurrPage.UPDATE;
    end;

    local procedure QuoteValueCalculation();
    begin
        Buffervlaue := 0;
        SalesLine.RESET;
        SalesLine.SETFILTER("Document No.", Rec."No.");
        IF SalesLine.FINDSET THEN
            REPEAT
                Buffervlaue += SalesLine."Amount To Customer";
            UNTIL SalesLine.NEXT = 0;
        QuoteValue := Buffervlaue;
    end;

    procedure CustAttachments();
    var
        CustAttach: Record 60098;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", "No.");
        CustAttach.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;

    local procedure ActivateFields()
    begin
        BilltoCustomerTemplateCodeEnab := "Bill-to Customer No." = '';
        SelltoCustomerTemplateCodeEnab := "Sell-to Customer No." = '';
        //"Sell-to Customer No.Enable" := "Sell-to Customer Template Code" = '';//B2BUpg
        //"Bill-to Customer No.Enable" := "Bill-to Customer Template Code" = '';//B2BUpg
    end;


}

