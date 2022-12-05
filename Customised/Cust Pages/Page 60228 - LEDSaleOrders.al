page 60228 "LED Sale Orders"
{
    Caption = 'Sales Order';
    PageType = Document;
    Permissions = TableData "Sales Invoice Header" = rm;
    RefreshOnActivate = true;
    SourceTable = "Sales Header";
    //>>B2BUPG
    //SourceTableView = WHERE ("Document Type"=FILTER(Order),"Order Status"=FILTER(<>"Temporary Close"),"No."=FILTER(EFF/SAL/*/L*));
    //<<B2BUPG

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Visible = DocNoVisible;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CUS.SETRANGE(CUS."No.", "Sell-to Customer No.");
                        IF CUS.FINDFIRST THEN BEGIN
                            // Added by Pranavi on 22-Jul-2016
                            IF (CUS."Copy Sell-to Addr. to Qte From" = CUS."Copy Sell-to Addr. to Qte From"::Company) //AND (CUS."T.I.N. No." = '')
                               AND (CUS."Customer Posting Group" <> 'RAILWAYS') THEN
                                ERROR('Please enter the T.I.N Number in Customer Card in Taxes Information Tab for Customer :' + CUS."No.");
                            // END by Pranavi
                            IF (CUS."Customer Posting Group" IN ['PRIVATE', 'OTHERS']) AND NOT (CUS."No." IN ['CUST00536', 'CUST01164']) THEN
                                IF CUS."Payment Terms Code" = '' THEN
                                    ERROR('Please enter Payment Terms Code in customer card for the customer: ' + CUS.Name);

                            Territory := CUS."Territory Code";
                            SelltoCustomerNoOnAfterValidat;

                            // Added by Rakesh on 9-Jul-14 to validate customer phoneno.
                            IF CUS."Phone No." = '' THEN
                                ERROR('Enter the Customer Phone no. in customer card');
                            // End by rakesh
                        END;
                        IF "Sell-to Customer No." <> xRec."Sell-to Customer No." THEN BEGIN
                            SL1.RESET;
                            SL1.SETRANGE(SL1."Document Type", SL1."Document Type"::Order);
                            SL1.SETRANGE(SL1."Document No.", "No.");
                            SL1.SETFILTER(SL1."No.", '<>%1', '');
                            SL1.SETFILTER(SL1.Quantity, '>%1', 0);
                            IF SL1.FINDSET THEN
                                REPEAT
                                    IF SL1."Quantity Invoiced" > 0 THEN
                                        ERROR('You Cannot Change the Customer as some of the items already invoiced!');
                                UNTIL SL1.NEXT = 0;
                        END;
                    end;
                }
                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; "Sell-to Customer Name")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Sell-to Customer Name" <> '' THEN BEGIN
                            "Bill-to Name" := "Sell-to Customer Name";
                            "Ship-to Name" := "Sell-to Customer Name";

                        END;
                    end;
                }
                field("Sell-to Address"; "Sell-to Address")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Sell-to Address" <> '' THEN BEGIN
                            "Ship-to Address" := "Sell-to Address";
                            "Bill-to Address" := "Sell-to Address";
                        END;
                    end;
                }
                field("Sell-to Address 2"; "Sell-to Address 2")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Sell-to Address 2" <> '' THEN BEGIN
                            "Ship-to Address 2" := "Sell-to Address 2";
                            "Bill-to Address 2" := "Sell-to Address 2";
                        END;
                    end;
                }
                field("Sell-to Post Code"; "Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code/City';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Sell-to Post Code" <> '' THEN BEGIN
                            "Bill-to Post Code" := "Sell-to Post Code";
                            "Ship-to Post Code" := "Sell-to Post Code";
                        END;
                        IF "Sell-to City" <> '' THEN BEGIN
                            "Bill-to City" := "Sell-to City";
                            "Ship-to City" := "Sell-to City";

                        END;
                    end;
                }
                field("Sell-to City"; "Sell-to City")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Sell-to City" <> '' THEN BEGIN
                            "Bill-to City" := "Sell-to City";
                            "Ship-to City" := "Sell-to City";

                        END;
                        IF "Sell-to Post Code" <> '' THEN BEGIN
                            "Bill-to Post Code" := "Sell-to Post Code";
                            "Ship-to Post Code" := "Sell-to Post Code";
                        END;
                    end;
                }
                field(State; State)
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact"; "Sell-to Contact")
                {
                    ApplicationArea = All;
                }
                field("No. of Archived Versions"; "No. of Archived Versions")
                {
                    ApplicationArea = All;
                }
                /*  field(Structure; Structure)
                 {
                 } */
                field("Installation Amount"; "Installation Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bought out Items Amount"; "Bought out Items Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Product; Product)
                {
                    ApplicationArea = All;
                }
                field("Software Amount"; "Software Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User ID"; "Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; "Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field(Control80; Comment)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; "Order Date")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Delivery Date"; "Requested Delivery Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Order Date" > "Requested Delivery Date" THEN
                            ERROR('Requested Delivery Date Must be Greater than Order Date');
                    end;
                }
                field("Promised Delivery Date"; "Promised Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Project Completion Date"; "Project Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; "Salesperson Code")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalespersonCodeOnAfterValidate;
                    end;
                }
                field("Campaign No."; "Campaign No.")
                {
                    ApplicationArea = All;
                }
                field("Opportunity No."; "Opportunity No.")
                {
                    ApplicationArea = All;
                }
                field("Order Released Date"; "Order Released Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(InvoiceNos; InvoiceNos)
                {
                    Caption = 'INVOICE NO SERIES';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF "Posting Date" = 0D THEN
                            ERROR('Enter posting date');

                        IF "Posting Date" < TODAY THEN    // Added by Pranavi on 16-04-2016 for correction of prev year ext doc no. updatation
                            ERROR('Posting Date should not be Previous date!');

                        ExtenalDocNo(InvoiceNos, "Posting Date");

                        //ChooseInvoice;
                    end;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Total Order(LOA)Value"; "Total Order(LOA)Value")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pending(LOA)Value"; "Pending(LOA)Value")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sale Order Total Amount"; "Sale Order Total Amount")
                {
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        /*  IF "Sale Order Total Amount">0 THEN
                          CurrPage."Sale Order Total Amount".EDITABLE:=FALSE
                          ELSE
                        CurrPage."Sale Order Total Amount".EDITABLE:=TRUE;
                        */
                        //Added by sundar(26-03-12) to reflect the changes in Saler order total amount to the invoices all ready posted
                        SIH.RESET;
                        SIH.SETFILTER(SIH."Order No.", "No.");
                        IF SIH.FINDFIRST THEN
                            REPEAT
                                SIH."Sale Order Total Amount" := "Sale Order Total Amount";
                                SIH.MODIFY;
                            UNTIL SIH.NEXT = 0;
                        //sundar(26-03-12)

                    end;
                }
                field("Customer OrderNo."; "Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Customer Order Date"; "Customer Order Date")
                {
                    ApplicationArea = All;
                }
                field("Quote No."; "Quote No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field("Payment Received"; "Payment Received")
                {
                    ApplicationArea = All;
                }
                field("Order Verified"; "Order Verified")
                {
                    Visible = true;
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //Added by Pranavi on 08-Dec-2015 for order verification rights
                        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\anilkumar', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You Do Not Have Rights!');
                        //End by Pranavi
                    end;
                }
                field("Verification Status"; "Verification Status")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Remarks: Text;
                        salesperson: Record "Salesperson/Purchaser";
                        MailCC: Text;
                        Body: text;

                    begin

                        // ADDED BY VIJAYA ON 20-MAY-2016 for order Verifying
                        IF (xRec."Verification Status" <> "Verification Status"::Request) THEN
                            ERROR('Sales Dept Not Requested For Changing verification Status');
                        IF (USERID IN ['EFFTRONICS\JHANSI', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN BEGIN
                            IF ("Verification Status" = "Verification Status"::Accept) THEN BEGIN
                                IF (NOT (CONFIRM('Do you want to Accept'))) THEN BEGIN
                                    "Verification Status" := "Verification Status"::Request;
                                    MODIFY;
                                    EXIT;
                                END;
                                IF ("Order Verified" = FALSE) THEN BEGIN
                                    user.RESET;
                                    user.SETRANGE(user."User ID", USERID);
                                    IF user.FINDFIRST THEN
                                        username := user."User ID"
                                    ELSE
                                        username := 'ERP User';
                                    Remarks := InputBox();
                                    IF (Remarks = '') THEN BEGIN
                                        ERROR('You must enter Remarks');
                                        EXIT;
                                    END;
                                    "Order Verified" := TRUE;
                                    MODIFY;
                                    salesperson.RESET;
                                    salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                    IF salesperson.FINDFIRST THEN
                                        MailCC := 'anvesh@efftronics.com,' + salesperson."E-Mail"
                                    ELSE
                                        MailCC := 'anvesh@efftronics.com';
                                    MailCC := MailCC + ',pmurali@efftronics.com';
                                    //// Mail_From := 'ERP@efftronics.com';
                                    // Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vsngeetha@efftronics.com';
                                    Subject := 'Sale Order Verified ::' + "No.";
                                    EmailMessage.Create(Recipient, Subject, Body, TRUE);
                                    //SMTP_MAIL.AddCC(MailCC);
                                    Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification Status</font></label></div><br/>');
                                    Body += ('Dear Sir/Madam,');
                                    Body += ('<br><br>');
                                    Body += ('The Sale Order has been Verified.<br><br><label><font size="3" color ="#0971D9">The Sale Order ' + "No." + '</font></label><br>');
                                    Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                    Body += ('<br><br><b>Remarks</b><br>');
                                    Body += (Remarks + '<br>');
                                    Body += ('<br><br>With Regards<br>');
                                    Body += (username + '<br>');
                                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                    //SMTP_MAIL.AppendBody('This Mail Sent to :: '+"Verfication Req MailID");
                                    //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                    //SMTP_MAIL.AddBCC('erp@efftronics.com');

                                    MESSAGE('Mail sent to Sales Dept');

                                END
                                ELSE BEGIN
                                    user.RESET;
                                    user.SETRANGE(user."User ID", USERID);
                                    IF user.FINDFIRST THEN begin
                                        USER2.Get(USER."User ID");
                                        username := USER2."Full Name";
                                    END ELSE
                                        username := 'ERP User';
                                    Remarks := InputBox();
                                    IF (Remarks = '') THEN BEGIN
                                        ERROR('You must enter Remarks');
                                        EXIT;
                                    END;
                                    "Order Verified" := FALSE;
                                    MODIFY;
                                    salesperson.RESET;
                                    salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                    IF salesperson.FINDFIRST THEN
                                        MailCC := 'anvesh@efftronics.com,' + salesperson."E-Mail"
                                    ELSE
                                        MailCC := 'anvesh@efftronics.com';
                                    MailCC := MailCC + ',pmurali@efftronics.com';
                                    // Mail_From := 'ERP@efftronics.com';
                                    // Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vsngeetha@efftronics.com';
                                    Subject := 'Sale Order verified :: ' + "No.";

                                    // SMTP_MAIL.AddCC(MailCC);
                                    Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification Status</font></label></div><br/>');
                                    Body += ('Dear Sir/Madam,');
                                    Body += ('<br><br>');
                                    Body += ('The Sale Order Verification Status Removed.<br><br><label><font size="3" color ="#0971D9">The Sale Order ' + "No." + '</font></label><br>');
                                    Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                    Body += ('<br><br><b>Remarks</b><br>');
                                    Body += (Remarks + '<br>');
                                    Body += ('<br><br>With Regards<br>');
                                    Body += (username + '<br>');
                                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                    //SMTP_MAIL.AppendBody('This Mail Sent to :: '+"Verfication Req MailID");
                                    //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                    //SMTP_MAIL.AddBCC('erp@efftronics.com');
                                    Recipient.Add('vanidevi@efftronics.com');
                                    Recipient.Add('vsngeetha@efftronics.com');
                                    // EmailMessage.CreateMessage(Recipient, Subject, Body, TRUE);
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                    MESSAGE('Mail sent to Sales Dept');
                                END;
                            END
                            ELSE
                                IF ("Verification Status" = "Verification Status"::Reject) THEN BEGIN
                                    IF (NOT (CONFIRM('Do you want to Reject'))) THEN BEGIN
                                        "Verification Status" := "Verification Status"::Request;
                                        MODIFY;
                                        EXIT;
                                    END;
                                    IF ("Order Verified" = FALSE) THEN BEGIN
                                        user.RESET;
                                        user.SETRANGE(user."User ID", USERID);
                                        IF user.FINDFIRST THEN begin
                                            USER2.Get(USER."User ID");
                                            username := USER2."Full Name";

                                        END ELSE
                                            username := 'ERP User';
                                        Remarks := InputBox();
                                        IF (Remarks = '') THEN BEGIN
                                            ERROR('You must enter Remarks');
                                            EXIT;
                                        END;
                                        salesperson.RESET;
                                        salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                        IF salesperson.FINDFIRST THEN
                                            MailCC := 'anvesh@efftronics.com,' + salesperson."E-Mail"
                                        ELSE
                                            MailCC := 'anvesh@efftronics.com';
                                        MailCC := MailCC + ',pmurali@efftronics.com';
                                        //"Order Verified" :=
                                        // Mail_From := 'ERP@efftronics.com';
                                        // Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vsngeetha@efftronics.com';
                                        Subject := 'Sale Order Rejected ::' + "No.";

                                        // SMTP_MAIL.AddCC(MailCC);
                                        Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification Status</font></label></div><br/>');
                                        Body += ('Dear Sir/Madam,');
                                        Body += ('<br><br>');
                                        Body += ('<font color="#FF0000">The Sale Order has been not Verified.</font><br><br><label><font size="3" color ="#0971D9">The Sale Order ' + "No." + '</font></label><br>');
                                        Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                        Body += ('<br><br><b>Remarks</b><br>');
                                        Body += (Remarks + '<br>');
                                        Body += ('<br><br>With Regards<br>');
                                        Body += (username + '<br>');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                        //Body += ('This Mail Sent to :: '+"Verfication Req MailID");
                                        //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                        //SMTP_MAIL.AddBCC('erp@efftronics.com');
                                        Recipient.Add('vanidevi@efftronics.com');
                                        Recipient.Add('vsngeetha@efftronics.com');
                                        // EmailMessage.CreateMessage(Recipient, Subject, Body, TRUE);
                                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                        MESSAGE('Mail sent to Sales Dept');

                                    END
                                    ELSE BEGIN
                                        user.RESET;
                                        user.SETRANGE(user."User ID", USERID);
                                        IF user.FINDFIRST THEN begin
                                            USER2.Get(USER."User ID");
                                            username := USER2."Full Name"
                                        END ELSE
                                            username := 'ERP User';
                                        Remarks := InputBox();
                                        IF (Remarks = '') THEN BEGIN
                                            ERROR('You must enter Remarks');
                                            EXIT;
                                        END;
                                        "Order Verified" := FALSE;
                                        MODIFY;
                                        salesperson.RESET;
                                        salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                        IF salesperson.FINDFIRST THEN
                                            MailCC := 'anvesh@efftronics.com,' + salesperson."E-Mail"
                                        ELSE
                                            MailCC := 'anvesh@efftronics.com';

                                        MailCC := MailCC + ',pmurali@efftronics.com';
                                        // Mail_From := 'ERP@efftronics.com';
                                        //Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vsngeetha@efftronics.com';
                                        Subject := 'Sale Order Rejected ::' + "No.";

                                        // SMTP_MAIL.AddCC(MailCC);
                                        Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification Status</font></label></div><br/>');
                                        Body += ('Dear Sir/Madam,');
                                        Body += ('<br><br>');
                                        Body += ('<font color="#FF0000">The Sale Order Verification Status Not Removed.</font><br><br><label><font size="3" color ="#0971D9">The Sale Order ' + "No." + '</font></label><br>');
                                        Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                        Body += ('<br><br><b>Remarks</b><br>');
                                        Body += (Remarks + '<br>');
                                        Body += ('<br><br>With Regards<br>');
                                        Body += (username + '<br>');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                        //SMTP_MAIL.AppendBody('This Mail Sent to :: '+"Verfication Req MailID");
                                        //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                        //SMTP_MAIL.AddBCC('erp@efftronics.com');
                                        Recipient.Add('vanidevi@efftronics.com');
                                        Recipient.Add('vsngeetha@efftronics.com');
                                        // EmailMessage.CreateMessage(Recipient, Subject, Body, TRUE);

                                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                        MESSAGE('Mail sent to Sales Dept');
                                    END;

                                END
                        END
                        ELSE
                            MESSAGE('You Do not have a Right To Verify Order');

                        // end by Vijaya
                    end;
                }
                field(Vertical; Vertical)
                {
                    ApplicationArea = All;
                }
                field("Shipment Type"; "Shipment Type")
                {
                    ApplicationArea = All;
                }
            }
            group("OMS Details")
            {
                Visible = forwordomsVisible;
                field(forwordoms; forwordtooms)
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
            part(SalesLines; "Led Order Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        BilltoCustomerNoOnAfterValidat;
                    end;
                }
                field("Bill-to Contact No."; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address"; "Bill-to Address")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Address 2"; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Post Code"; "Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Bill-to City"; "Bill-to City")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Contact"; "Bill-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. Type"; "Applies-to Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Applies-to Doc. No."; "Applies-to Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Applies-to ID"; "Applies-to ID")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; "No. Series")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Payment Discount %"; "Payment Discount %")
                {
                    Caption = 'Expected Payment %';
                    ApplicationArea = All;
                }
                field(Consignee; Consignee)
                {
                    ApplicationArea = All;
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No"; "Blanket Order No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Status"; "Order Status")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension1CodeOnAfterV;
                    end;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        ShortcutDimension2CodeOnAfterV;
                    end;
                }
                field("Payment Terms Code"; "Payment Terms Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // Added by Pranavi on 01-Oct-2016
                        IF (xRec."Payment Terms Code" <> "Payment Terms Code") AND (xRec."Payment Terms Code" <> '') THEN BEGIN
                            SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                            SalesLine.SETFILTER(SalesLine."No.", '<>%1', '');
                            SalesLine.SETFILTER(SalesLine.Quantity, '>%1', 0);
                            IF SalesLine.FINDSET THEN
                                REPEAT
                                    IF SalesLine."Quantity Invoiced" > 0 THEN
                                        ERROR('You Cannot Change the Payment terms code after the order is invoice!');
                                UNTIL SalesLine.NEXT = 0;
                            PayTerm.SETRANGE(PayTerm.Code, xRec."Payment Terms Code");
                            IF PayTerm.FINDFIRST THEN BEGIN
                                IF PayTerm."Stage 1" = PayTerm."Stage 1"::Advance THEN BEGIN
                                    CustLedgEntr.RESET;
                                    CustLedgEntr.SETRANGE(CustLedgEntr."Sale Order no", "No.");
                                    CustLedgEntr.SETRANGE(CustLedgEntr."Payment Type", CustLedgEntr."Payment Type"::Advance);
                                    IF CustLedgEntr.FINDFIRST THEN
                                        ERROR('You cannot change the payment terms code as the advance amount is already paid for the order!');
                                END;
                            END;
                        END;
                        // End by Pranavi
                    end;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Pmt. Discount Date"; "Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Method Code"; "Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Prices Including VAT"; "Prices Including VAT")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        PricesIncludingVATOnAfterValid;
                    end;
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Language Code"; "Language Code")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field(Territory; Territory)
                {
                    ApplicationArea = All;
                }
                field("<Document Date2>"; "Document Date")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("<Project Completion Date2>"; "Project Completion Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Installation Amount(CS)"; "Installation Amount(CS)")
                {
                    ApplicationArea = All;
                }
                field("PT Release Auth Stutus"; "PT Release Auth Stutus")
                {
                    Editable = Editable_Bool;
                    ApplicationArea = All;
                }
                field("PT Post Auth Stutus"; "PT Post Auth Stutus")
                {
                    Editable = Editable_Bool;
                    ApplicationArea = All;
                }
            }
            group(Shipping)
            {
                Caption = 'Shipping';
                field("Ship-to Code"; "Ship-to Code")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Name"; "Ship-to Name")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address"; "Ship-to Address")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Address 2"; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Post Code"; "Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code/City';
                    ApplicationArea = All;
                }
                field("Ship-to City"; "Ship-to City")
                {
                    ApplicationArea = All;
                }
                field("Ship-to Contact"; "Ship-to Contact")
                {
                    ApplicationArea = All;
                }
                field("Shipping No. Series"; "Shipping No. Series")
                {
                    ApplicationArea = All;
                }
                field("MSPT Date"; "MSPT Date")
                {
                    ApplicationArea = All;
                }
                field("MSPT Code"; "MSPT Code")
                {
                    ApplicationArea = All;
                }
                field("<Transport Method2>"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; "Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                field("Outbound Whse. Handling Time"; "Outbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Shipment Method Code"; "Shipment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Code"; "Shipping Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Agent Service Code"; "Shipping Agent Service Code")
                {
                    ApplicationArea = All;
                }
                field("Shipping Time"; "Shipping Time")
                {
                    ApplicationArea = All;
                }
                field("Late Order Shipping"; "Late Order Shipping")
                {
                    ApplicationArea = All;
                }
                field("Package Tracking No."; "Package Tracking No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; "Shipment Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SalesLine."Shipment Date" := "Posting Date";
                    end;
                }
                field("Shipping Advice"; "Shipping Advice")
                {
                    ApplicationArea = All;
                }
                field(WayBillNo; WayBillNo)
                {
                    ApplicationArea = All;
                }
                field("<Payment Discount %2>"; "Payment Discount %")
                {
                    Caption = 'Supply Portion';
                    ApplicationArea = All;
                }
                field("Order Completion Period"; "Order Completion Period")
                {
                    ApplicationArea = All;
                }
            }
            group("Installtion Status")
            {
                Caption = 'Installtion Status';
                field(Installation; Installation)
                {
                    ApplicationArea = All;
                }
                field("Inst.Start Date"; "Inst.Start Date")
                {
                    Caption = 'Base Plan Start date';
                    ApplicationArea = All;
                }
                field("Inst.Status"; "Inst.Status")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; "Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Assured Date"; "Assured Date")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; "Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Area)
                {
                    ApplicationArea = All;
                }
                field("<Currency Code2>"; "Currency Code")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        CLEAR(ChangeExchangeRate);
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Posting Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);
                            CurrPage.UPDATE;
                        END;
                        CLEAR(ChangeExchangeRate);
                    end;

                    trigger OnValidate()
                    begin
                        CurrencyCodeC111OnAfterValidat;
                    end;
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("<Transport Method3>"; "Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit Status"; "Security Deposit Status")
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
            }
            group("Sales Status")
            {
                Caption = 'Sales Status';
                field("<Order Status2>"; "Order Status")
                {
                    ApplicationArea = All;
                }
                field(Inspection; Inspection)
                {
                    ApplicationArea = All;
                }
                field("Call letters Status"; "Call letters Status")
                {
                    ApplicationArea = All;
                }
                field(CallLetterExpireDate; CallLetterExpireDate)
                {
                    ApplicationArea = All;
                }
                field(CallLetterRecivedDate; CallLetterRecivedDate)
                {
                    ApplicationArea = All;
                }
                field("BG Status"; "BG Status")
                {
                    ApplicationArea = All;
                }
                field("CA Date"; "CA Date")
                {
                    Caption = 'BG. Require Date';
                    ApplicationArea = All;
                }
                field("<Payment Terms Code2>"; "Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Exp.Payment"; "Exp.Payment")
                {
                    Caption = 'BG Value';
                    ApplicationArea = All;
                }
                field("<Station Names2>"; Consignee)
                {
                    ApplicationArea = All;
                }
                field("Posting No."; "Posting No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Extended Date"; "Extended Date")
                {
                    ApplicationArea = All;
                }
                field("Call Letter Exp.Date"; "Call Letter Exp.Date")
                {
                    ApplicationArea = All;
                }
            }
            group(" Others")
            {
                Caption = ' Others';
                field("RDSO Charges Paid By"; "RDSO Charges Paid By")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection Req"; "RDSO Inspection Req")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection By"; "RDSO Inspection By")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges"; "RDSO Charges")
                {
                    ApplicationArea = All;
                }
                field("RDSO Call Letter"; "RDSO Call Letter")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Pmt. Discount Date"; "Prepmt. Pmt. Discount Date")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; "Prepayment %")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Prepayment37OnAfterValidate;
                    end;
                }
                field("Compress Prepayment"; "Compress Prepayment")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Discount %"; "Prepmt. Payment Discount %")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Payment Terms Code"; "Prepmt. Payment Terms Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Due Date"; "Prepayment Due Date")
                {
                    ApplicationArea = All;
                }
                field("<Tender No2.>"; "Tender No.")
                {
                    ApplicationArea = All;
                }
                field("LD Amount"; "LD Amount")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; "Document Position")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit"; "Security Deposit")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1904868001)
            {
                Caption = 'Security Deposit';
                field("Security Deposit Amount"; "Security Deposit Amount")
                {
                    Caption = 'Security Deposit Amount(Inc Of EMD)*';
                    ApplicationArea = All;
                }
                field("EMD Amount"; "EMD Amount")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; "Tender No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        // Start--added by pranavi on 28-Oct-2016 for tender status updation
                        IF "Tender No." <> '' THEN BEGIN
                            TH.RESET;
                            TH.SETRANGE(TH."Tender No.", "Tender No.");
                            IF TH.FINDFIRST THEN BEGIN
                                TH."Sales Order Created" := TRUE;
                                TH."Tender Status" := TH."Tender Status"::Received;
                                TH.MODIFY;
                            END;
                        END;
                        // ENd--added by pranavi on 28-Oct-2016 for tender status updation
                    end;
                }
                field("Deposit Payment Due Date"; "Deposit Payment Due Date")
                {
                    ApplicationArea = All;
                }
                field("Deposit Payment Date"; "Deposit Payment Date")
                {
                    ApplicationArea = All;
                }
                field("<Security Deposit Status2>"; "Security Deposit Status")
                {
                    ApplicationArea = All;
                }
                field("SD Requested Date"; "SD Requested Date")
                {
                    ApplicationArea = All;
                }
                field("SD Required Date"; "SD Required Date")
                {
                    ApplicationArea = All;
                }
                field("SecurityDeposit Exp. Rcpt Date"; "SecurityDeposit Exp. Rcpt Date")
                {
                    ApplicationArea = All;
                }
                field("Order Assurance"; "Order Assurance")
                {
                    Editable = "Order AssuranceEditable";
                    ApplicationArea = All;
                }
                field("<Shipment Date2>"; "Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Final Bill Date"; "Final Bill Date")
                {
                    ApplicationArea = All;
                }
                field("SD Status"; "SD Status")
                {
                    ApplicationArea = All;
                }
                field("<Due Date2>"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Warranty Period"; "Warranty Period")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                /* field("Transit Document"; "Transit Document")
                 {
                 }
                 field("Free Supply"; "Free Supply")
                 {
                 }*/
                field("TDS Certificate Receivable"; "TDS Certificate Receivable")
                {
                    ApplicationArea = All;
                }
                /*field("Calc. Inv. Discount (%)"; "Calc. Inv. Discount (%)")
                {
                }
                field("Export or Deemed Export"; "Export or Deemed Export")
                {
                }
                field("VAT Exempted"; "VAT Exempted")
                {
                }*/
                field(Trading; Trading)
                {
                    ApplicationArea = All;
                }
                /*  field("ST Pure Agent"; "ST Pure Agent")
                  {
                  }*/
                /*field("Re-Dispatch"; "Re-Dispatch")
                {

                    trigger OnValidate()
                    begin
                        ReDispatchOnPush;
                        IF NOT ("Re-Dispatch") AND ("Return Re-Dispatch Rcpt. No." <> '') THEN
                            ERROR(Text16500);
                        IF "Re-Dispatch" THEN BEGIN
                            ReturnOrderNoVisible := TRUE;
                        END ELSE BEGIN
                            ReturnOrderNoVisible := FALSE;
                        END;
                    end;
                }*/
                /* field(ReturnOrderNo; "Return Re-Dispatch Rcpt. No.")
                 {
                     Caption = 'Return Receipt No.';
                     Visible = ReturnOrderNoVisible;
                 }*/
                /*field("LC No."; "LC No.")
                {
                }
                field("Form Code"; "Form Code")
                {
                }
                field("Form No."; "Form No.")
                {
                }*/
                field("<Posting Date2>"; "Posting Date")
                {
                    Caption = 'Date of Removal';
                    ApplicationArea = All;
                }
                field("Time of Removal"; "Time of Removal")
                {
                    Caption = 'Time of Removal';
                    ApplicationArea = All;
                }
                field("Mode of Transport"; "Mode of Transport")
                {
                    Caption = 'Mode of Transport';
                    ApplicationArea = All;
                }
                field("Vehicle No."; "Vehicle No.")
                {
                    Caption = 'Vehicle No.';
                    ApplicationArea = All;
                }
                field("LR/RR No."; "LR/RR No.")
                {
                    Caption = 'LR/RR No.';
                    ApplicationArea = All;
                }
                field("LR/RR Date"; "LR/RR Date")
                {
                    Caption = 'LR/RR Date';
                    ApplicationArea = All;
                }
                /* field("Service Tax Rounding Precision"; "Service Tax Rounding Precision")
                 {
                 }
                 field("Service Tax Rounding Type"; "Service Tax Rounding Type")
                 {
                 }*/
                group(GST)
                {
                    Caption = 'GST';
                    field("GST Bill-to State Code"; "GST Bill-to State Code")
                    {
                        Editable = true;
                        ApplicationArea = All;
                    }
                    field("GST Ship-to State Code"; "GST Ship-to State Code")
                    {
                        Editable = true;
                        ApplicationArea = All;
                    }
                    field("Location State Code"; "Location State Code")
                    {
                        Editable = true;
                        ApplicationArea = All;
                    }
                    field("Nature of Supply"; "Nature of Supply")
                    {
                        ApplicationArea = All;
                    }
                    field("GST Customer Type"; "GST Customer Type")
                    {
                        Editable = true;
                        ApplicationArea = All;
                    }
                    field("GST Without Payment of Duty"; "GST Without Payment of Duty")
                    {
                        ApplicationArea = All;
                    }
                    field("Invoice Type"; "Invoice Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill Of Export No."; "Bill Of Export No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill Of Export Date"; "Bill Of Export Date")
                    {
                        ApplicationArea = All;
                    }
                    field("e-Commerce Customer"; "e-Commerce Customer")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            Customer: Record Customer;
                        begin
                        end;
                    }
                    field("e-Commerce Merchant Id"; "e-Commerce Merchant Id")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                Image = "Order";
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    ShortCutKey = 'F7';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin



                        OpenSalesOrderStatistics();
                        CurrPage.SalesLines.Page.ForceTotalsCalculation();
                    end;
                }
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No."), "Document Line No." = CONST(0);
                    ApplicationArea = All;
                }
                action("S&hipments")
                {
                    Caption = 'S&hipments';
                    Image = Shipment;
                    RunObject = Page "Posted Sales Shipments";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action(Invoices)
                {
                    Caption = 'Invoices';
                    Image = Invoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Order No." = FIELD("No.");
                    RunPageView = SORTING("Order No.");
                    ApplicationArea = All;
                }
                action("Prepa&yment Invoices")
                {
                    Caption = 'Prepa&yment Invoices';
                    Image = PrepaymentInvoice;
                    RunObject = Page "Posted Sales Invoices";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
                action("Prepayment Credi&t Memos")
                {
                    Caption = 'Prepayment Credi&t Memos';
                    Image = PrepaymentCreditMemo;
                    RunObject = Page "Posted Sales Credit Memos";
                    RunPageLink = "Prepayment Order No." = FIELD("No.");
                    RunPageView = SORTING("Prepayment Order No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                    end;
                }
                action("A&pprovals")
                {
                    Caption = 'A&pprovals';
                    Image = Approvals;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"Sales Header", "Document Type", "No.");
                        ApprovalEntries.RUN;
                    end;
                }
                separator(Action173)
                {
                }
                action("Whse. Shipment Lines")
                {
                    Caption = 'Whse. Shipment Lines';
                    Image = ShipmentLines;
                    RunObject = Page "Whse. Shipment Lines";
                    RunPageLink = "Source Type" = CONST(37), "Source Subtype" = FIELD("Document Type"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                    Visible = false;
                    ApplicationArea = All;
                }
                action("In&vt. Put-away/Pick Lines")
                {
                    Caption = 'In&vt. Put-away/Pick Lines';
                    Image = PickLines;
                    RunObject = Page "Warehouse Activity List";
                    RunPageLink = "Source Document" = CONST("Sales Order"), "Source No." = FIELD("No.");
                    RunPageView = SORTING("Source Document", "Source No.", "Location Code");
                    Visible = false;
                    ApplicationArea = All;
                }
                separator(Action120)
                {
                }
                action("Pla&nning")
                {
                    Caption = 'Pla&nning';
                    Image = Planning;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesPlanPage: Page "Sales Order Planning";
                    begin
                        SalesPlanPage.SetSalesOrder("No.");
                        SalesPlanPage.RUNMODAL;
                    end;
                }
                action("Order &Promising")
                {
                    Caption = 'Order &Promising';
                    Image = OrderPromising;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderPromisingLine: Record "Order Promising Line" temporary;
                    begin
                        OrderPromisingLine.SETRANGE("Source Type", "Document Type");
                        OrderPromisingLine.SETRANGE("Source ID", "No.");
                        PAGE.RUNMODAL(PAGE::"Order Promising Lines", OrderPromisingLine);
                    end;
                }
                separator(Action1500026)
                {
                }
                /* action("St&ructure")
                 {
                     Caption = 'St&ructure';
                     Image = Hierarchy;
                     RunObject = Page "Structure Order Details";
                     RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Structure Code" = FIELD(Structure), "Document Line No." = FILTER(0);
                 }
                 action("Transit Documents")
                 {
                     Caption = 'Transit Documents';
                     Image = TransferOrder;
                     RunObject = Page "Transit Document Order Details";
                     RunPageLink = Type = CONST(Sale), "PO / SO No." = FIELD("No."), "Vendor / Customer Ref." = FIELD("Sell-to Customer No."), State = FIELD(State);
                 }
                 action("Detailed &Tax")
                 {
                     Caption = 'Detailed &Tax';
                     Image = TaxDetail;
                     RunObject = Page "Sale Detailed Tax";
                     RunPageLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "Transaction Type" = CONST(Sale);
                 }*/
                separator(Action1102152025)
                {
                }
                action("Check List")
                {
                    Caption = 'Check List';
                    Image = CheckList;
                    RunObject = Page "Check List";
                    RunPageLink = "Document Type" = CONST(Sales), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("&MSPT Order Details")
                {
                    Caption = '&MSPT Order Details';
                    Image = ViewDetails;
                    RunObject = Page "MSPT Order Details";
                    RunPageLink = Type = CONST(Sale), "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No."), "MSPT Header Code" = FIELD("MSPT Code"), "Party No." = FIELD("Sell-to Customer No.");
                    ApplicationArea = All;
                }
                action(Schedule)
                {
                    Caption = 'Schedule';
                    Image = PlannedOrder;
                    RunObject = Page Schedule;
                    RunPageLink = "Document No." = FIELD("Tender No."), "Document Type" = CONST(Order);
                    ApplicationArea = All;
                }
                action("Order Verification")
                {
                    Caption = 'Order Verification';
                    Image = MailAttachment;
                    ApplicationArea = All;

                    trigger OnAction()
                    var

                        usename: Text;

                        Remarks: Text;
                        salesperson: Record "Salesperson/Purchaser";
                        MailCC: Text;
                        Shedul2_Count: Integer;
                        LastModifiedDate: DateTime;
                        RegExp: Text;
                        Tot_amt: Text;
                        formataddress: Codeunit "Correct Dimension Values Cust";

                        Shedul2_UOM: Text;
                        Shedul2_Amt: Text;
                        Itm: Record Item;
                        Email: Codeunit Email;
                        EmailMessage: Codeunit "Email Message";
                    begin
                        IF ("Order Verified" = TRUE) THEN BEGIN
                            IF (CONFIRM('Do you want to Send Mail for Removing Verified Status')) THEN BEGIN
                                USER.RESET;
                                USER.SETRANGE(USER."User ID", USERID);
                                IF USER.FINDFIRST THEN BEGIN

                                    USER2.Get(USER."User ID");
                                    username := USER2."Full Name";
                                    IF USER.MailID <> '' THEN BEGIN
                                        "Verfication Req MailID" := USER.MailID;
                                        MODIFY;
                                    END
                                    ELSE BEGIN
                                        MESSAGE('You do not have Mail-ID. Mail-ID is required for requesting');
                                        EXIT;
                                    END
                                END
                                ELSE
                                    username := 'ERP User';
                                Remarks := InputBox();
                                IF (Remarks = '') THEN BEGIN
                                    MESSAGE('You must enter Remarks');
                                    EXIT;
                                END;
                                salesperson.RESET;
                                salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                IF salesperson.FINDFIRST THEN
                                    MailCC := 'anvesh@efftronics.com,vkrishna@efftronics.com,' + salesperson."E-Mail"
                                // MailCC := 'sujani@efftronics.com'
                                ELSE
                                    MailCC := 'anvesh@efftronics.com,pmurali@efftronics.com,vkrishna@efftronics.com';
                                // MailCC := 'sujani@efftronics.com';

                                //MailCC := MailCC+',pmurali@efftronics.com';
                                //Mail_From:='ERP@efftronics.com';
                                //Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vkrishna@efftronics.com,vsngeetha@efftronics.com';
                                // Mail_To:= 'sujani@efftronics.com';

                                Subject := 'Changes for Sale Order ' + "No.";

                                // SMTP_MAIL.AddCC(MailCC);
                                Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification</font></label></div><br/>');
                                Body += ('Dear Sir/Madam,');
                                Body += ('<br><br>');
                                Body += ('The Sale Order has been Verified. Need to Change the item Details So Please Remove the Verified Status<br><br>');
                                Body += ('<br><br><b>Remarks</b><br>');
                                Body += (Remarks + '<br>');
                                Body += ('<font size="3" color ="#0971D9">The Sale Order ' + "No." + '</font></label><br>');
                                Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                Body += ('<br><br>With Regards<br>');
                                Body += (username + '<br>');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                //SMTP_MAIL.AppendBody(' This mail Sent to :: jhansi@efftronics.com ');
                                //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                //SMTP_MAIL.AddBCC('erp@efftronics.com');


                                "Verification Status" := "Verification Status"::Request;
                                MODIFY;
                                //EmailMessage.CreateMessage(Recipient, Subject, Body, TRUE);
                                //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                MESSAGE('Mail sent to Authorized Person');
                            END
                            ELSE
                                EXIT;
                        END
                        ELSE BEGIN
                            IF (CONFIRM('Do you want to Send Mail for Order Verification')) THEN BEGIN
                                USER.RESET;
                                USER.SETRANGE(USER."User ID", USERID);
                                IF USER.FINDFIRST THEN BEGIN
                                    USER2.Get(USER."User ID");
                                    username := USER2."Full Name";
                                    IF USER.MailID <> '' THEN BEGIN
                                        "Verfication Req MailID" := USER.MailID;
                                        MODIFY;
                                    END
                                    ELSE BEGIN
                                        MESSAGE('You do not have Mail-ID. Mail-ID is required for requesting');
                                        EXIT;
                                    END;
                                    MODIFY;
                                END
                                ELSE
                                    username := 'ERP User';
                                Remarks := InputBox();
                                IF (Remarks = '') THEN BEGIN
                                    MESSAGE('You must enter Remarks');
                                    EXIT;
                                END;
                                salesperson.RESET;
                                salesperson.SETRANGE(salesperson.Code, "Salesperson Code");
                                IF salesperson.FINDFIRST THEN
                                    MailCC := 'anvesh@efftronics.com,vkrishna@efftronics.com,' + salesperson."E-Mail"
                                //    MailCC := 'sujani@efftronics.com'

                                ELSE
                                    MailCC := 'anvesh@efftronics.com,pmurali@efftronics.com,vkrishna@efftronics.com';
                                //MailCC := MailCC+',pmurali@efftronics.com';
                                //    MailCC := 'sujani@efftronics.com';

                                // Mail_From := 'ERP@efftronics.com';
                                // Mail_To := "Verfication Req MailID" + ',vanidevi@efftronics.com,vkrishna@efftronics.com,vsngeetha@efftronics.com';
                                // Mail_To:= 'sujani@efftronics.com';

                                Subject := 'Order Verification for Sale Order ' + "No.";
                                //  SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
                                // SMTP_MAIL.AddCC(MailCC);
                                Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="4"> Sale Order Verification</font></label></div><br/>');
                                Body += ('Dear Sir/Madam,');
                                Body += ('<br><br>');
                                Body += ('The Sale Order Need to be Released.Please Verify the Order.<br><br><label><font size="3" color ="#0971D9">The Sale Order ' + "No.");


                                // Added by Vijaya on 11-Jul-16 for Sending Log Entry
                                //                IF NOT (COPYSTR("No.",14,2) IN ['/L','/T']) THEN
                                //                BEGIN
                                SHA.RESET;
                                SHA.SETFILTER(SHA."No.", "No.");

                                //  for the 1st Time Releasing  Verification
                                IF NOT SHA.FINDFIRST THEN BEGIN
                                    Body += ('(New Order)</font></label><br>');
                                    Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                    Body += ('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Item no.</b> </th><th>Item Description </th> <th>QTY</th><th>UOM</th><th>AMOUNT</th></tr>');
                                    Shedul2_Count := 0;
                                    SalesLine.RESET;
                                    SalesLine.SETFILTER("Document No.", "No.");
                                    IF SalesLine.FINDSET THEN
                                        REPEAT
                                            Tot_amt := formataddress.ChangeCurrency(ROUND(SalesLine."Amount To Customer", 1));
                                            Body += ('<tr><td>' + SalesLine."No." + '</td><td>' + SalesLine.Description + '</td><TD>' + FORMAT(SalesLine.Quantity) + '</TD><td>' + SalesLine."Unit of Measure" + '</td><td align=right>' + Tot_amt + '</td></tr>');
                                            SCHEDULEOMS.RESET;
                                            SCHEDULEOMS.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.", "Line No.");
                                            SCHEDULEOMS.SETFILTER(SCHEDULEOMS."Document No.", SalesLine."Document No.");
                                            SCHEDULEOMS.SETFILTER(SCHEDULEOMS."Document Line No.", '%1', SalesLine."Line No.");
                                            SCHEDULEOMS.SETFILTER(SCHEDULEOMS."Line No.", '<>%1', 10000);
                                            IF SCHEDULEOMS.FINDSET THEN
                                                REPEAT
                                                    IF SCHEDULEOMS."Document Line No." <> SCHEDULEOMS."Line No." THEN BEGIN
                                                        Shedul2_UOM := '';
                                                        Itm.RESET;
                                                        Itm.SETCURRENTKEY("No.");
                                                        Itm.SETFILTER(Itm."No.", SCHEDULEOMS."No.");
                                                        IF Itm.FINDFIRST THEN
                                                            Shedul2_UOM := Itm."Base Unit of Measure";
                                                        Shedul2_Amt := '';
                                                        Shedul2_Count := Shedul2_Count + 1;
                                                        Body += ('<tr><td style="color:#FF0000">' + '  ' + SCHEDULEOMS."No." + '</td><td style="color:#FF0000">' + '  ' + SCHEDULEOMS.Description + '</td>');
                                                        Body += ('<TD style="color:#FF0000">' + FORMAT(SCHEDULEOMS.Quantity) + '</TD><td style="color:#FF0000">' + Shedul2_UOM + '</td><td align=right style="color:#FF0000">' + Shedul2_Amt + '</td></tr>');
                                                    END;
                                                UNTIL SCHEDULEOMS.NEXT = 0;
                                        UNTIL SalesLine.NEXT = 0;
                                    Body += ('</Table>');
                                    IF Shedul2_Count > 0 THEN
                                        Body += ('<BR><p align ="left" style="color:#FF0000"> Note: Red Color Items are Schedule Items</p>');
                                END

                                //  for already Relased Order Verification
                                ELSE BEGIN
                                    Body += ('(Re-Verfying Order)</font></label><br>');
                                    Body += ('<font size="2" color ="#0971D9">Customer Name :: ' + "Sell-to Customer Name" + '</font></label><br>');
                                    Body += ('<br>Sales Lines Items Modifications ::');
                                    CHANGELOGSETUP.RESET;
                                    CHANGELOGSETUP.SETCURRENTKEY("Table No.", "Date and Time");
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Table No.", 36);
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Field No.", 80002);
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Primary Key Field 2 Value", "No.");
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."New Value", 'false');
                                    IF CHANGELOGSETUP.FINDLAST THEN BEGIN
                                        LastModifiedDate := CHANGELOGSETUP."Date and Time";
                                    END;
                                    CHANGELOGSETUP.RESET;
                                    CHANGELOGSETUP.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Table No.", 37);
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Primary Key Field 2 Value", "No.");
                                    CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Date and Time", '>%1', LastModifiedDate);
                                    CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Field No.", '%1|%2|%3|%4|%5|%6', 6, 15, 80006, 7, 60, 50002);
                                    Body += ('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Line no.</b></th><th>Item No.');
                                    Body += ('</th><th>Item Description </th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th>');
                                    Body += ('<th>New Value</th></tr>');
                                    IF CHANGELOGSETUP.FINDSET THEN
                                        REPEAT
                                            SalesLine.RESET;
                                            SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                                            SalesLine.SETFILTER(SalesLine."Line No.", CHANGELOGSETUP."Primary Key Field 3 Value");
                                            IF SalesLine.FINDSET THEN BEGIN
                                                Body += ('<tr><td>' + CHANGELOGSETUP."Primary Key Field 3 Value" + '</td><td>' + SalesLine."No." + '</td><td>' + SalesLine.Description + '</td>');
                                                CASE CHANGELOGSETUP."Type of Change" OF
                                                    CHANGELOGSETUP."Type of Change"::Insertion:
                                                        Body += ('<td>Insertion</td>');
                                                    CHANGELOGSETUP."Type of Change"::Modification:
                                                        Body += ('<td>Modification</td>');
                                                    CHANGELOGSETUP."Type of Change"::Deletion:
                                                        Body += ('<td>Deletion</td>');
                                                END;
                                                CASE CHANGELOGSETUP."Field No." OF
                                                    6:
                                                        Body += ('<td>Item No</td>');
                                                    15:
                                                        Body += ('<td>Quantity</td>');
                                                    80006:
                                                        Body += ('<td>Pending Qty</td>');
                                                    7:
                                                        Body += ('<td>Laction Code</td>');
                                                    60:
                                                        Body += ('<td>Qty to Shipped</td>');
                                                    50002:
                                                        Body += ('<td>Packet No</td>');
                                                END;
                                                Body += ('</td><td>' + CHANGELOGSETUP."Old Value" + '</td><td>');
                                                IF CHANGELOGSETUP."Field No." = 6 THEN BEGIN
                                                    Itm.RESET;
                                                    Itm.SETFILTER(Itm."No.", CHANGELOGSETUP."New Value");
                                                    IF Itm.FINDSET THEN BEGIN
                                                        CASE Itm."Item Status" OF
                                                            Itm."Item Status"::Obsolete:
                                                                Body += (CHANGELOGSETUP."New Value" + '(Obsolete)</td></tr>');
                                                            Itm."Item Status"::"In-Active":
                                                                Body += (CHANGELOGSETUP."New Value" + '(In-Active)</td></tr>');
                                                            ELSE
                                                                Body += (CHANGELOGSETUP."New Value" + '</td></tr>');
                                                        END;
                                                    END;
                                                END
                                                ELSE
                                                    Body += (CHANGELOGSETUP."New Value" + '</td></tr>');
                                            END;
                                        UNTIL CHANGELOGSETUP.NEXT = 0;
                                    Body += ('</table>');
                                    Body += ('<br>Shedule Items Modifications :: ');
                                    SalesLine.RESET;
                                    SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                                    CHANGELOGSETUP.RESET;
                                    CHANGELOGSETUP.SETCURRENTKEY("Table No.", "Primary Key Field 2 Value", "Primary Key Field 3 Value", "Date and Time");
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Table No.", 60095);
                                    CHANGELOGSETUP.SETRANGE(CHANGELOGSETUP."Primary Key Field 2 Value", "No.");
                                    CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Date and Time", '>%1', LastModifiedDate);
                                    CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Field No.", '%1|%2', 5, 7);
                                    Body += ('<br><table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th><b>Sales Line no.</b></th><th>Sales Item No.');
                                    Body += ('</th><th>Item Description </th><th>Type of Change</th><th>Changed Field</th><th>Previous Value</th>');
                                    Body += ('<th>New Value</th></tr>');

                                    IF SalesLine.FINDSET THEN
                                        REPEAT
                                            CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Primary Key Field 3 Value", FORMAT(SalesLine."Line No."));
                                            RegExp := '*' + FORMAT(SalesLine."Line No.") + '*' + FORMAT(SalesLine."Line No.") + '*';
                                            CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Primary Key", '<>%1', RegExp);
                                            IF CHANGELOGSETUP.FINDSET THEN
                                                REPEAT
                                                    Body += ('<tr><td>' + CHANGELOGSETUP."Primary Key Field 3 Value" + '</td><td>' + SalesLine."No." + '</td><td>' + SalesLine.Description + '</td>');
                                                    CASE CHANGELOGSETUP."Type of Change" OF
                                                        CHANGELOGSETUP."Type of Change"::Insertion:
                                                            Body += ('<td>Insertion</td>');
                                                        CHANGELOGSETUP."Type of Change"::Modification:
                                                            Body += ('<td>Modification</td>');
                                                        CHANGELOGSETUP."Type of Change"::Deletion:
                                                            Body += ('<td>Deletion</td>');
                                                    END;
                                                    CASE CHANGELOGSETUP."Field No." OF
                                                        5:
                                                            Body += ('<td>Item No</td>');
                                                        7:
                                                            Body += ('<td>Quantity</td>');
                                                    END;
                                                    Body += ('</td><td>' + CHANGELOGSETUP."Old Value" + '</td><td>');
                                                    IF CHANGELOGSETUP."Field No." = 5 THEN BEGIN
                                                        Itm.RESET;
                                                        Itm.SETFILTER(Itm."No.", CHANGELOGSETUP."New Value");
                                                        IF Itm.FINDSET THEN BEGIN
                                                            CASE Itm."Item Status" OF
                                                                Itm."Item Status"::Obsolete:
                                                                    Body += (CHANGELOGSETUP."New Value" + '(Obsolete)</td></tr>');
                                                                Itm."Item Status"::"In-Active":
                                                                    Body += (CHANGELOGSETUP."New Value" + '(In-Active)</td></tr>');
                                                                ELSE
                                                                    Body += (CHANGELOGSETUP."New Value" + '</td></tr>');
                                                            END;
                                                        END;
                                                    END;
                                                UNTIL CHANGELOGSETUP.NEXT = 0;
                                        UNTIL SalesLine.NEXT = 0;
                                END;
                                //                END;
                                //end by Vijaya on 11-Jul-16



                                Body += ('<br><br><b>Remarks</b><br>');
                                Body += (Remarks + '<br><br>');
                                Body += ('<br><br>With Regards<br>');
                                Body += (username + '<br>');
                                Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');
                                //SMTP_MAIL.AppendBody(' This mail Sent to :: jhansi@efftronics.com ');
                                //SMTP_MAIL.AppendBody('This Mail CC to :: '+MailCC);
                                //SMTP_MAIL.AddBCC('erp@efftronics.com');

                                "Verification Status" := "Verification Status"::Request;
                                MODIFY;
                                // EmailMessage.CreateMessage(Recipient, Subject, Body, TRUE);
                                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                MESSAGE('Mail sent to Authorized Person');
                            END
                            ELSE
                                EXIT;
                        END;
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                    end;
                }
                action(Comment)
                {
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                separator(Action71)
                {
                }
                action("Create Prod. Order")
                {
                    Caption = 'Create Prod. Order';
                    Image = GetOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        NewStatus2: Option Simulated,Planned,"Firm Planned",Released;
                        NewOrderType2: Option ItemOrder,ProjectOrder;
                    begin
                        /*SalesPlanPage.SetSalesOrder("No.");
                        SalesPlanPage.RUNMODAL;
                        */

                        //IF CreateOrderPage.RUNMODAL <> ACTION::Yes THEN
                        //EXIT;

                        SalesPlanLine.DELETEALL;
                        Quantity := CurrPage.SalesLines.PAGE.MakeLines(SalesLineRec);

                        NewStatus2 := NewStatus2::Released;
                        NewOrderType2 := NewOrderType2::ItemOrder;
                        //CreateOrderPage.ReturnPostingInfo(NewStatus2,NewOrderType2);
                        /*IF ("sales header"."Document Type"="sales header"."Document Type"::Order)THEN
                        BEGIN
                        //MESSAGE('hai');
                          IF "Order Assurance"=FALSE THEN
                             ERROR('Order Was not Assured By Sales Dept.');
                        //end ELSE
                        //BEGIN
                          MESSAGE(FORMAT(Quantity));
                          FOR I := 1 TO Quantity
                          DO BEGIN
                           // MESSAGE('hi');
                            Qty := 1;
                            CreateOrders(Qty);
                          END;
                        END;*/
                        IF "Order Assurance" = FALSE THEN
                            ERROR('Order Was not Assured By Sales Dept.')
                        ELSE BEGIN
                            FOR I := 1 TO Quantity
                              DO BEGIN
                                Qty := 1;
                                CreateOrders(Qty);
                            END;
                        END;

                        //IF NOT CreateOrders THEN
                        //MESSAGE(Text001);

                        //SalesPlanLine.SETRANGE("Planning Status");

                        //BuildForm;

                        //CurrPage.UPDATE;

                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("Calculate &Invoice Discount")
                {
                    Caption = 'Calculate &Invoice Discount';
                    Image = CalculateInvoiceDiscount;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /* CALCFIELDS("Price Inclusive of Taxes");
                         IF NOT "Price Inclusive of Taxes" THEN
                             ApproveCalcInvDisc
                         ELSE
                             ERROR(STRSUBSTNO(Text16501, FIELDCAPTION("Price Inclusive of Taxes")));*/
                    end;
                }
                separator(Action172)
                {
                }
                action("Get St&d. Cust. Sales Codes")
                {
                    Caption = 'Get St&d. Cust. Sales Codes';
                    Ellipsis = true;
                    Image = CustomerCode;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        StdCustSalesCode: Record "Standard Customer Sales Code";
                    begin
                        StdCustSalesCode.InsertSalesLines(Rec);
                    end;
                }
                separator(Action171)
                {
                }
                action("Copy Document")
                {
                    Caption = 'Copy Document';
                    Ellipsis = true;
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CopySalesDoc.SetSalesHeader(Rec);
                        CopySalesDoc.RUNMODAL;
                        CLEAR(CopySalesDoc);
                    end;
                }
                action("Archi&ve Document")
                {
                    Caption = 'Archi&ve Document';
                    Image = Archive;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        ArchiveManagement.ArchiveSalesDocument(Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Move Negative Lines")
                {
                    Caption = 'Move Negative Lines';
                    Ellipsis = true;
                    Image = MoveNegativeLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CLEAR(MoveNegSalesLines);
                        MoveNegSalesLines.SetSalesHeader(Rec);
                        MoveNegSalesLines.RUNMODAL;
                        MoveNegSalesLines.ShowDocument;
                    end;
                }
                separator(Action195)
                {
                }
                action("Cancel Order")
                {
                    Caption = 'Cancel Order';
                    Enabled = true;
                    Image = CancelLine;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderStatusValue: Text[50];
                        Text051: Label 'Do you want to Cancel the Order No. %1';
                    begin
                        IF CONFIRM(Text051, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Cancel';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                action("Short Close Order")
                {
                    Caption = 'Short Close Order';
                    Image = Close;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        OrderStatusValue: Text[50];
                        Text050: Label 'Do you want to Short Close the Order No. %1';
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You Do not have Right to Short Close!');
                        IF CONFIRM(Text050, FALSE, "No.") THEN BEGIN
                            OrderStatusValue := 'Close';
                            CancelCloseOrder(OrderStatusValue, Rec);
                            CurrPage.UPDATE(FALSE);
                        END;
                    end;
                }
                separator(Action1102152012)
                {
                }
                action("Create &Whse. Shipment")
                {
                    Caption = 'Create &Whse. Shipment';
                    Image = CreateWarehousePick;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    begin
                        GetSourceDocOutbound.CreateFromSalesOrder(Rec);

                        IF NOT FIND('=><') THEN
                            INIT;
                    end;
                }
                action("Create Inventor&y Put-away / Pick")
                {
                    Caption = 'Create Inventor&y Put-away / Pick';
                    Ellipsis = true;
                    Image = CreateInventoryPickup;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CreateInvtPutAwayPick;

                        IF NOT FIND('=><') THEN
                            INIT;
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin


                        ApprovalsMgmt.ApproveRecordApprovalRequest(RecordId);
                    end;

                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelSalesApprovalRequest(Rec);
                    end;
                }
                separator(Action174)
                {
                }
                separator(Action175)
                {
                }
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                        OMSIntegrateCode: Codeunit SQLIntegration;
                        PaymentTerms: Record "Payment Terms";
                        CLE: Record "Cust. Ledger Entry";
                        DCLE: Record "Detailed Cust. Ledg. Entry";
                        AdvPaymentAmt: Decimal;
                    begin
                        /*IF ("Sell-to Customer No."<>'CS INT') OR ("Sell-to Customer No."<>'R&D INT')THEN
                        TESTFIELD("SalOrd Des Approval");comented for design approval*/
                        TESTFIELD("Warranty Period");
                        /*IF FORMAT("Project Completion Date") ='' THEN
                        ERROR('Please Enter the Project Completion Date');
                        VALIDATE("Project Completion Date");
                        
                        IF FORMAT("Promised Delivery Date") ='' THEN
                        ERROR('Please Enter the Promised Delivery Date');
                        VALIDATE("Promised Delivery Date") ;
                        
                        IF FORMAT("Project Completion Date") ='' THEN
                        ERROR('Please Enter the Project Completion Date');
                         */
                        // IF ("Sell-to Customer No."='CUST00822') AND ("Total Order(LOA)Value" >1000) THEN
                        // ERROR('change the customer.you cannot release orders with this customer');
                        IF Vertical = Vertical::" " THEN BEGIN
                            ERROR('Please Choose Vertical');
                        END;

                        IF "Shipment Type" = "Shipment Type"::"  " THEN BEGIN
                            ERROR('Please Choose Whether Partial Shipment Allowed or Not');
                        END;
                        SCHEDULEOMS.RESET;
                        SCHEDULEOMS.SETFILTER(SCHEDULEOMS."No.", "No.");
                        IF SCHEDULEOMS.FIND('-') THEN
                            REPEAT
                                IF SCHEDULEOMS.Type = SCHEDULEOMS.Type::Item THEN BEGIN
                                    IF SCHEDULEOMS."No." = '' THEN
                                        ERROR('salese line ' + FORMAT(SCHEDULEOMS."Document Line No.") + 'Schedules Must have  Item Numbers');
                                    IF SCHEDULEOMS."No." <> '' THEN
                                        IF FORMAT(SCHEDULEOMS.Quantity) = '' THEN
                                            ERROR('Sales line ' + FORMAT(SCHEDULEOMS."Document Line No.") + 'Schedule Must have  Item Number');
                                END;
                            UNTIL SCHEDULEOMS.NEXT = 0;

                        //sundar
                        IF ("RDSO Inspection Req" = "RDSO Inspection Req"::YES) AND ("Call letters Status" = "Call letters Status"::NA) THEN
                            ERROR('Call Letter Status should not be NA while RDSO inspection Req is YES');

                        IF "Call letters Status" = "Call letters Status"::Pending THEN BEGIN
                            IF ((CallLetterExpireDate <> 0D) OR (CallLetterRecivedDate <> 0D)) THEN
                                ERROR('Call letter Expire date and received date must be empty');
                            IF "Call Letter Exp.Date" < TODAY THEN
                                ERROR('Call letter Expected date must be greater than or equal to today ');
                        END;

                        IF "Call letters Status" = "Call letters Status"::Received THEN BEGIN
                            IF ((CallLetterExpireDate = 0D) OR (CallLetterRecivedDate = 0D)) THEN
                                ERROR('Call letter Expire date and received date must be Filled');
                            IF CallLetterExpireDate <= TODAY THEN
                                ERROR('Call letter Expire date must be greater than today ');
                            IF CallLetterRecivedDate > TODAY THEN
                                ERROR('Call letter Received date must be less than or equal to today ');

                        END;
                        //Added by Pranavi on 18-08-2015
                        IF "Salesperson Code" = '' THEN
                            ERROR('Please Enter Sales Person Code!');
                        IF "Customer Posting Group" = '' THEN
                            ERROR('Please select Customer Posting Group!');
                        IF "Payment Terms Code" = '' THEN
                            ERROR('Please select Payment Terms Code!');
                        //End By Pranavi

                        // Added by Pranavi on 22-Jul-2016
                        CUS.RESET;
                        CUS.SETRANGE(CUS."No.", "Sell-to Customer No.");
                        IF CUS.FINDFIRST THEN BEGIN
                            IF (CUS."Copy Sell-to Addr. to Qte From" = CUS."Copy Sell-to Addr. to Qte From"::Company) //AND (CUS."T.I.N. No." = '')
                               AND (CUS."Customer Posting Group" <> 'RAILWAYS') THEN
                                ERROR('Please enter the T.I.N Number in Customer Card in Taxes Information Tab for Customer :' + CUS."No.");
                        END;
                        // END by Pranavi
                        IF (("Order Verified" = FALSE) OR ("Verification Status" = "Verification Status"::Reject)) THEN
                            ERROR('Order is not Verified So You can not release order!');

                        SalesLine.SETFILTER(SalesLine."Document No.", "No.");
                        SalesLine.SETRANGE(SalesLine."RDSO Inspection Required", TRUE);
                        IF SalesLine.FINDFIRST THEN BEGIN
                            IF "RDSO Inspection Req" <> "RDSO Inspection Req"::YES THEN
                                ERROR('You must specify RDSO Inspection Req to Yes in header as one or more lines have Rdso inspection');
                        END
                        ELSE
                            IF "RDSO Inspection Req" = "RDSO Inspection Req"::YES THEN
                                ERROR('Rdso Inspection is Yes and no lines have rdso inspection yes');
                        //sundar
                        //Added by Pranavi on 02-11-2015
                        IF NOT ("Sell-to Customer No." IN ['CUST00536', 'CUST01164']) THEN BEGIN
                            attachments.RESET;
                            attachments.SETFILTER(attachments."Document Type", '%1', "Document Type");
                            attachments.SETFILTER(attachments."Document No.", "No.");
                            attachments.SETFILTER(attachments."Attachment Status", '%1', TRUE);
                            IF NOT attachments.FINDFIRST THEN
                                ERROR('Please attach Sale Order Document/ LOA of the Order!');
                        END
                        ELSE BEGIN
                            IF Remarks = '' THEN   // Added by Pranavi on 06-Aprl-2016
                                ERROR('Please enter remarks for the Order in General Tab!\Remarks are mandatory for Efftronics Order!');
                        END;
                        Remarks := DELCHR(Remarks, '=', Quote);
                        //End by Pranavi
                        //Added by Pranavi on 09-Dec-2015 for not allowing to release led order if tax structure not calcted
                        /*IF (NOT "Calculate Tax Structure") AND (Structure <> '') THEN
                            ERROR('Please Calculate Tax Structure!');
                        IF (Structure = '') THEN
                            ERROR('Please Select Tax Structure!');*/
                        CALCFIELDS("Total Order(LOA)Value");
                        IF ROUND("Total Order(LOA)Value") <> ROUND("Sale Order Total Amount") THEN
                            ERROR('Sale Order Total Amount and Total Order(LOA) Value are not equal!');
                        //End by Pranavi
                        // Added by Pranavi on 16-feb-2016 for not allowing to release if location code not updated in lines
                        SalesLine.RESET;
                        SalesLine.SETRANGE("Document Type", "Document Type");
                        SalesLine.SETRANGE("Document No.", "No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                                IF SalesLine."Location Code" = '' THEN
                                    ERROR('Please enter Location Code in Line No.: ' + FORMAT(SalesLine."Line No."));
                                Schedl2.RESET;
                                Schedl2.SETRANGE(Schedl2."Document No.", SalesLine."Document No.");
                                Schedl2.SETRANGE(Schedl2."Document Line No.", SalesLine."Line No.");
                                Schedl2.SETFILTER(Schedl2."No.", '<>%1', '');
                                IF Schedl2.FINDSET THEN
                                    REPEAT
                                        IF Schedl2."Document Line No." <> Schedl2."Line No." THEN
                                            IF Schedl2."Location Code" = '' THEN
                                                ERROR('Please enter Location Code in the Schedules for the Doc Line No.: ' + FORMAT(SalesLine."Line No.") + ' Line No.: ' + FORMAT(Schedl2."Line No."));
                                    UNTIL Schedl2.NEXT = 0;
                            UNTIL SalesLine.NEXT = 0;
                        // End by Pranavi
                        // Added by Pranavi on 30-Jun-2016 for SD amount checking
                        IF ("SD Status" <> "SD Status"::NA) AND ("Security Deposit Amount" <= 5) THEN
                            ERROR('Please enter Security Deposit Amount!\If SD amount not applicable update SD Status as NA!');
                        // End by pranavi

                        //Added by Pranavi on 16-Sep-2016 for not allowing to release led order if tax structure not calcted

                        IF "Customer Posting Group" IN ['PRIVATE', 'OTHERS', 'EXPORT'] THEN BEGIN
                            /*  IF (NOT "Calculate Tax Structure") AND (Structure <> '') THEN
                                  ERROR('Please Calculate Tax Structure!');
                              IF (Structure = '') THEN
                                  ERROR('Please Select Tax Structure!');*/
                            CALCFIELDS("Total Order(LOA)Value");
                            IF ROUND("Total Order(LOA)Value") <> ROUND("Sale Order Total Amount") THEN
                                ERROR('Sale Order Total Amount and Total Order(LOA) Value are not equal!');
                        END;
                        IF NOT ("Sell-to Customer No." IN ['CUST00536', 'CUST01164']) AND ("Customer Posting Group" IN ['PRIVATE', 'OTHERS', 'EXPORT']) AND (Order_After_CF_Integration = TRUE) THEN BEGIN
                            CUS.RESET;
                            CUS.SETRANGE(CUS."No.", "Sell-to Customer No.");
                            IF CUS.FINDFIRST THEN BEGIN
                                IF CUS."Customer Posting Group" IN ['PRIVATE', 'OTHERS', 'EXPORT'] THEN BEGIN
                                    PT.RESET;
                                    PT.SETRANGE(PT.Code, CUS."Payment Terms Code");
                                    IF PT.FINDFIRST THEN
                                        IF (PT."Stage 1" = PT."Stage 1"::Credit) OR (PT."Stage 2" = PT."Stage 2"::Credit) OR (PT."Stage 3" = PT."Stage 3"::Credit) THEN
                                            IF CUS."Payment Term Auth" = CUS."Payment Term Auth"::Rejected THEN
                                                ERROR('Payment terms of customer authorization is rejected for credit based term!\' +
                                                      'Please change payment terms code or take authorization')
                                            ELSE
                                                IF CUS."Payment Term Auth" IN [CUS."Payment Term Auth"::"Sent For Authorization", CUS."Payment Term Auth"::" "] THEN
                                                    ERROR('Payment term is not authorized for the customer as it is credit based term!\' +
                                                          'Please change payment terms code or take authorization');
                                END;
                            END;
                            SalesLineRec.RESET;
                            SalesLineRec.SETRANGE(SalesLineRec."Document No.", "No.");
                            SalesLineRec.SETFILTER(SalesLineRec."No.", '<>%1', '');
                            IF SalesLineRec.FINDSET THEN
                                REPEAT
                                    IF (SalesLineRec."Supply Portion" = 0) AND (SalesLineRec."Retention Portion" = 0) THEN
                                        ERROR('Please enter Suply & Retention Portion for the line no. ' + FORMAT(SalesLineRec."Line No."));
                                UNTIL SalesLineRec.NEXT = 0;
                        END;

                        //End by Pranavi
                        // Added by Pranavi on 26-Jul-2016 for payment terms process

                        IF ("Customer Posting Group" IN ['PRIVATE', 'OTHERS', 'EXPORT']) AND NOT ("Sell-to Customer No." IN ['CUST00536', 'CUST01164']) AND (Order_After_CF_Integration = TRUE) THEN BEGIN
                            IF "Payment Terms Code" = '' THEN BEGIN
                                CUS.RESET;
                                CUS.SETRANGE(CUS."No.", "Sell-to Customer No.");
                                IF CUS.FINDFIRST THEN BEGIN
                                    IF CUS."Payment Terms Code" <> '' THEN BEGIN
                                        "Payment Terms Code" := CUS."Payment Terms Code";
                                        MODIFY;
                                    END
                                    ELSE
                                        ERROR('Please enter Payment terms code in customer card!');
                                END;
                            END
                            ELSE BEGIN
                                IF "Payment Terms Code" IN ['ASPERMNC', 'ASPERTNDR'] THEN
                                    ERROR('Please enter Payment Terms mentioned in PO!\It should not be ' + "Payment Terms Code")
                                ELSE BEGIN
                                    "PT_Adv%" := 0;
                                    "PT_Del%" := 0;
                                    "PT_Crd%" := 0;
                                    PaymentTerms.RESET;
                                    PaymentTerms.SETRANGE(PaymentTerms.Code, "Payment Terms Code");
                                    IF PaymentTerms.FINDFIRST THEN BEGIN
                                        IF PaymentTerms."Stage 1" = PaymentTerms."Stage 1"::Advance THEN
                                            "PT_Adv%" := PaymentTerms."Percentage 1"
                                        ELSE
                                            IF PaymentTerms."Stage 1" IN [PaymentTerms."Stage 1"::Delivery, PaymentTerms."Stage 1"::Against_RDSO_IC] THEN
                                                "PT_Del%" := PaymentTerms."Percentage 1"
                                            ELSE
                                                IF PaymentTerms."Stage 1" = PaymentTerms."Stage 1"::Credit THEN
                                                    "PT_Crd%" := PaymentTerms."Percentage 1";

                                        IF PaymentTerms."Stage 2" IN [PaymentTerms."Stage 2"::Delivery, PaymentTerms."Stage 2"::Against_RDSO_IC] THEN
                                            "PT_Del%" := PaymentTerms."Percentage 2"
                                        ELSE
                                            IF PaymentTerms."Stage 2" = PaymentTerms."Stage 2"::Credit THEN
                                                "PT_Crd%" := PaymentTerms."Percentage 2";

                                        IF PaymentTerms."Stage 3" IN [PaymentTerms."Stage 3"::Delivery, PaymentTerms."Stage 3"::Against_RDSO_IC] THEN
                                            "PT_Del%" := PaymentTerms."Percentage 3"
                                        ELSE
                                            IF PaymentTerms."Stage 3" = PaymentTerms."Stage 3"::Credit THEN
                                                "PT_Crd%" := PaymentTerms."Percentage 3";
                                        SL1.RESET;
                                        SL1.SETRANGE(SL1."Document Type", SL1."Document Type"::Order);
                                        SL1.SETRANGE(SL1."Document No.", "No.");
                                        SL1.SETFILTER(SL1."No.", '<>%1', '');
                                        SL1.SETFILTER(SL1.Quantity, '>%1', 0);
                                        IF SL1.FINDSET THEN
                                            REPEAT
                                                IF SL1.Type = SL1.Type::Item THEN BEGIN
                                                    IF SL1."Supply Portion" + SL1."Retention Portion" <> 100 THEN
                                                        ERROR('Total supply and retention portion must be equal to 100 %!\present value is :' +
                                                              FORMAT(SL1."Supply Portion" + SL1."Retention Portion"));
                                                    IF SL1."Retention Portion" > 0 THEN BEGIN
                                                        IF SL1."Supply Portion" <> ("PT_Adv%" + "PT_Del%") THEN
                                                            ERROR('Supply portion of line no.: ' + FORMAT(SL1."Line No.") + ' must be equal to (adv+del)% in payment term!');
                                                        IF SL1."Retention Portion" <> "PT_Crd%" THEN
                                                            ERROR('Retention portion of line no.: ' + FORMAT(SL1."Line No.") + ' must be equal to credit % in payment term!');
                                                    END ELSE BEGIN
                                                        IF SL1."Supply Portion" <> ("PT_Adv%" + "PT_Del%" + "PT_Crd%") THEN
                                                            ERROR('Supply portion of line no.: ' + FORMAT(SL1."Line No.") + ' must be equal to (adv+del)% in payment term!');
                                                    END;
                                                END;
                                            UNTIL SL1.NEXT = 0;
                                        SalesLine.RESET;
                                        SalesLine.SETRANGE(SalesLine."Document Type", SalesLine."Document Type"::Order);
                                        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                                        SalesLine.SETFILTER(SalesLine."No.", '<>%1', '');
                                        SalesLine.SETFILTER(SalesLine.Quantity, '>%1', 0);
                                        IF SalesLine.FINDSET THEN
                                            REPEAT
                                                LineAmtLOA := 0;
                                                LineAmtLOA := ROUND(SalesLine.Quantity * SalesLine."Unitcost(LOA)", 1);
                                                IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
                                                    AdvAmt += LineAmtLOA * "PT_Adv%" / 100;
                                                    IF SalesLine."Retention Portion" > 0 THEN BEGIN
                                                        RetentionAmt := RetentionAmt + (LineAmtLOA * SalesLine."Retention Portion" / 100);
                                                        SupplyAmt := SupplyAmt + (LineAmtLOA - (LineAmtLOA * SalesLine."Retention Portion" / 100));
                                                    END ELSE BEGIN
                                                        SupplyAmt := SupplyAmt + LineAmtLOA;
                                                    END;
                                                END
                                                ELSE
                                                    IF SalesLine.Type = SalesLine.Type::"G/L Account" THEN BEGIN
                                                        InstAmt := InstAmt + ROUND(SalesLine.Quantity * SalesLine."Unitcost(LOA)", 1);
                                                    END;
                                            UNTIL SalesLine.NEXT = 0;

                                        IF (PaymentTerms."Stage 1" = PaymentTerms."Stage 1"::Credit) OR (PaymentTerms."Stage 1" = PaymentTerms."Stage 2"::Credit) OR
                                           (PaymentTerms."Stage 1" = PaymentTerms."Stage 3"::Credit) THEN BEGIN
                                            CUS.RESET;
                                            CUS.SETRANGE(CUS."No.", "Sell-to Customer No.");
                                            IF CUS.FINDFIRST THEN
                                                IF CUS."Payment Term Auth" <> CUS."Payment Term Auth"::Authorized THEN
                                                    ERROR('As payment terms is credit based. Authorization is required!\Please take authorization!');
                                        END;
                                        IF PaymentTerms."Update In Cashflow" = FALSE THEN
                                            ERROR('Please update Payment Term Code: ' + "Payment Terms Code" + ' to CashFlow!')
                                        ELSE BEGIN
                                            IF (PaymentTerms."Stage 1" = PaymentTerms."Stage 1"::Advance) AND (PaymentTerms."Percentage 1" <> 0) THEN BEGIN
                                                CLE.RESET;
                                                CLE.SETRANGE(CLE."Customer No.", "Sell-to Customer No.");
                                                CLE.SETRANGE(CLE."Payment Type", CLE."Payment Type"::Advance);
                                                CLE.SETRANGE(CLE."Sale Order no", "No.");
                                                IF CLE.FINDSET THEN BEGIN
                                                    REPEAT
                                                        DCLE.RESET;
                                                        DCLE.SETRANGE(DCLE."Cust. Ledger Entry No.", CLE."Entry No.");
                                                        DCLE.SETRANGE(DCLE."Entry Type", DCLE."Entry Type"::"Initial Entry");
                                                        IF DCLE.FINDSET THEN
                                                            REPEAT
                                                                AdvPaymentAmt := AdvPaymentAmt + ABS(DCLE."Amount (LCY)");
                                                            UNTIL DCLE.NEXT = 0;
                                                    UNTIL CLE.NEXT = 0;
                                                    IF ABS(ROUND(AdvPaymentAmt, 0.01, '>') - ROUND((SupplyAmt * PaymentTerms."Percentage 1") / 100, 0.01, '>')) > 1 THEN BEGIN
                                                        IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::"Sent For Auth" THEN
                                                            ERROR('Authorization is in pending.Please take Authorization!')
                                                        ELSE
                                                            IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::Rejected THEN
                                                                ERROR('Your permission for releasing is rejected!');
                                                        IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::" " THEN BEGIN
                                                            MESSAGE('Total Advance Payment is not recovered!Advance Amt of Order Value is: ' +
                                                                  FORMAT(ROUND(("Sale Order Total Amount" * PaymentTerms."Percentage 1") / 100, 0.01, '>')) +
                                                                  '\Recovered Adv Amount is: ' + FORMAT(ROUND(AdvPaymentAmt, 0.01, '>')));
                                                            IF CONFIRM('Do you want to release with Authorization?\Do you want to Send for Authorization? ') THEN
                                                                SendForAuth('Release');
                                                            EXIT;
                                                        END;
                                                    END;
                                                END ELSE BEGIN
                                                    IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::"Sent For Auth" THEN
                                                        ERROR('Authorization is in pending.Please take Authorization!')
                                                    ELSE
                                                        IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::Rejected THEN
                                                            ERROR('Your permission for releasing is rejected!');
                                                    IF "PT Release Auth Stutus" = "PT Release Auth Stutus"::" " THEN BEGIN
                                                        MESSAGE('Payment terms has ' + FORMAT(PaymentTerms."Percentage 1") + ' % Advance Payment! But Advance payment is not done!');
                                                        IF CONFIRM('Do you want to release with Authorization?\Do you want to Send for Authorization? ') THEN
                                                            SendForAuth('Release');
                                                        EXIT;
                                                    END;
                                                END;
                                            END;
                                        END;
                                    END
                                    ELSE
                                        ERROR('Payment Terms Code ' + "Payment Terms Code" + ' does not exist in Payment Terms Table!');
                                END;
                            END;
                        END;
                        // End by Pranavi

                        ReleaseSalesDoc.PerformManualRelease(Rec);

                        //mnraju- forward to oms on release the order
                        IF Status = Status::Released THEN BEGIN
                            // MESSAGE('Today OMS Integration Stopped');
                            //MESSAGE("No.");
                            SHA.RESET;
                            SHA.SETFILTER(SHA."No.", "No.");
                            IF NOT SHA.FINDFIRST THEN BEGIN
                                "First Released Date Time" := CURRENTDATETIME;
                                MODIFY;
                            END;
                            SalesLine.SETRANGE("Document Type", "Document Type");
                            SalesLine.SETRANGE("Document No.", "No.");
                            // SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                            IF SalesLine.FINDFIRST THEN BEGIN
                                // MESSAGE('Enter in OMS Part');      OR ("Document Type"="Document Type"::"Blanket Order")
                                IF "Document Type" = "Document Type"::Order THEN BEGIN
                                    IF (OMSIntegrateCode.SaleOrderCreationinOMS(Rec)) = FALSE THEN BEGIN
                                        MESSAGE('Error occured in OMS integration and record is not posted');
                                    END;
                                END;
                            END;

                            // Added by pranavi on 19-may-2016
                            IF NOT ("Sell-to Customer No." IN ['CUST00536', 'CUST01164']) THEN BEGIN
                                IF "Customer Posting Group" = 'RAILWAYS' THEN
                                    OMSIntegrateCode.SaleOrderCreationinCashFlow(Rec)
                                ELSE BEGIN
                                    IF Order_After_CF_Integration = TRUE THEN
                                        OMSIntegrateCode.PrivateSaleOrdrCreationInCashFlow(Rec)
                                    ELSE BEGIN
                                        IF "Payment Received" = FALSE THEN
                                            OMSIntegrateCode.SaleOrderCreationinCashFlow(Rec);
                                    END;
                                END;
                            END;
                            // end by Pranavi
                            // end by Pranavi
                        END ELSE
                            ERROR('Order in Open State');
                        forwordomsVisible := FALSE;
                        //mnraju- forward to oms on release the order

                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ReleaseSalesDoc: Codeunit "Release Sales Document";
                    begin
                        ReleaseSalesDoc.PerformManualReopen(Rec);
                        /*IF  (userid1<>'SUPER') THEN
                        BEGIN
                        user1.SETRANGE(user1."User ID",userid1);
                        IF user1.FINDFIRST THEN
                        username:=user1.Name;
                            Mail_From:='erp@efftronics.com';
                            Mail_To:='padmaja@efftronics.com,jhansi@efftronics.com,Sal@efftronics.com,';
                            Mail_To+='mohang@efftronics.com';
                            Subject:="No."+' Order Has been Re-opened';
                        Body:='<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                        Body+='border="1" align="left">';
                        Body+='<tr><td>Order No:</td><td>'+"No.";
                        Body+='</td></tr><tr><td>Customer Name:</td><td>'+"Sell-to Customer Name";
                        Body+='</td></tr><tr><td>Previously Order Release on:</td><td>'+FORMAT("Order Released Date",0,4);
                        Body+='</td></tr><tr><td>Re-Opened By:</td><td>'+username;
                        Body+='</td></tr><tr><td>Re-opened Date:</td><td>'+FORMAT(TODAY,0,4)+'</td></td></table></form></strong></body>';
                        Body+='<br><br><br><br><br>****  Automatic Mail Generated From ERP  ****';
                            Attachment:='';
                            SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                            SMTP_MAIL.AddAttachment(Attachment);
                            
                            //NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment);
                            // CODE WAS COMMENTED FOR NAVISION UPGRADATION
                        
                        END;*/

                        /*IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        MAPIHandler.ToName := 'bharat@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'padmaja@efftronics.net';
                        MAPIHandler.Subject :=xRec."No."+'ORDER Reopen';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('ORDER number in ERP'+xRec."No."+',');
                        MAPIHandler.AddBodyText(xRec."Sell-to Customer Name"+' is Reopen');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;
                        */
                        // "Calculate Tax Structure" := FALSE; //Added by Pranavi on 09-Dec-2015

                    end;
                }
                separator(Action608)
                {
                }
                action("Send IC Sales Order Cnfmn.")
                {
                    AccessByPermission = TableData "IC G/L Account" = R;
                    Caption = 'Send IC Sales Order Cnfmn.';
                    Image = IntercompanyOrder;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ICInOutboxMgt: Codeunit ICInboxOutboxMgt;
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                            ICInOutboxMgt.SendSalesDoc(Rec, FALSE);
                    end;
                }
                separator(Action1500031)
                {
                }
                action("Calc&ulate Structure Values")
                {
                    Caption = 'Calc&ulate Structure Values';
                    Image = CalculateHierarchy;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Itm: Record Item;
                        ExcAmt: Decimal;
                        MDP: Decimal;
                        //ExcPostingSetup: Record "Excise Posting Setup";
                        SL: Record "Sales Line";
                        TaxDetails: Record "Tax Detail";
                    begin
                        /*
                        //Added by Pranavi on 09-Dec-2015 for UnitCost LOA Calc for LED Orders
                        TESTFIELD(Status, Status::Open);
                        TESTFIELD(Structure);
                        TESTFIELD("Order Date");
                        //End by pranavi
                        SalesLine.UpdateUnitPriceBasedOnMRP(Rec);   // Added by Pranavi on 18-Oct-2016 for Unit Price update based on MRP Price
                        CALCFIELDS("Price Inclusive of Taxes");
                        IF "Price Inclusive of Taxes" THEN BEGIN
                            SalesLine.InitStrOrdDetail(Rec);
                            SalesLine.GetSalesPriceExclusiveTaxes(Rec);
                            SalesLine.UpdateSalesLinesPIT(Rec);
                        END;
                        SalesLine.CalculateStructures(Rec);
                        SalesLine.AdjustStructureAmounts(Rec);
                        SalesLine.UpdateSalesLines(Rec);

                        "Calculate Tax Structure" := TRUE; //Added by Pranavi on 09-Dec-2015
                    */
                    end;
                }
                action("Calculate TCS")
                {
                    Caption = 'Calculate TCS';
                    Image = CalculateLines;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        // SalesLine.CalculateStructures(Rec);
                        // SalesLine.AdjustStructureAmounts(Rec);
                        // SalesLine.UpdateSalesLines(Rec);
                        // SalesLine.CalculateTCS(Rec);

                        //EFFUPG
                    end;
                }
                action("Direct Debit To PLA / RG")
                {
                    Caption = 'Direct Debit To PLA / RG';
                    Image = Change;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        /*SalesLine.CalculateStructures(Rec);
                        SalesLine.AdjustStructureAmounts(Rec);
                        SalesLine.UpdateSalesLines(Rec);
                        OpenExciseCentvatClaimForm;*/ //EFFUPG
                    end;
                }
                action("Request for Authorisation")
                {
                    Caption = 'Request for Authorisation';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        EmailMessage: Codeunit "Email Message";
                        Email: Codeunit Email;
                    begin
                        IF "Customer Posting Group" = 'PRIVATE' THEN BEGIN
                            IF "Reason For Pending" = '' THEN
                                ERROR('Please Enter Comment At Shipping Tab, Supply Issues Field At Sales Header')
                            ELSE
                                "Request for Authorisation" := TRUE;
                            MODIFY;

                            CLE.SETRANGE(CLE."Customer No.", "Sell-to Customer No.");
                            CLE.SETRANGE(CLE."Sale Order no", "No.");
                            IF CLE.FINDSET THEN
                                REPEAT
                                    CLE.CALCFIELDS(CLE.Amount);
                                    Receivedamt := Receivedamt + ABS(CLE.Amount);
                                UNTIL CLE.NEXT = 0;

                            /*
                            Cust.SETRANGE(Cust."No.","Sell-to Customer No.");
                            Cust.SETRANGE(Cust."Date Filter",(040108D),TODAY);
                            IF Cust.FINDFIRST THEN
                            REPORT.RUN(50136,FALSE,FALSE,Cust);
                            REPORT.SAVEASHTML(50136,FORMAT('\\eff-cpu-222\ErpAttachments\cusstatement.html'),FALSE);
                            */

                            PT.SETRANGE(PT.Code, "Payment Terms Code");
                            IF PT.FINDFIRST THEN
                                paymenttermdesc := PT.Description;

                            SALPUR.SETRANGE(SALPUR.Code, "Salesperson Code");
                            IF SALPUR.FINDFIRST THEN
                                spname := SALPUR.Name;

                            Cust.RESET;
                            Cust.SETRANGE(Cust."No.", "Sell-to Customer No.");
                            IF Cust.FINDFIRST THEN BEGIN
                                Cust.CALCFIELDS(Cust."Sales (LCY)");
                                cusbalance := FORMAT(ROUND(Cust."Sales (LCY)", 1));
                            END;

                            //Rev01 Start
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            //Rev01 End

                            //Mail_From:='anilkumar@efftronics.com';
                            //Mail_To := 'dir@efftronics.com';
                            Subject := 'Request for Authorisation of Invoice For the Order No:' + FORMAT("No.");
                            Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                            //cellspacing="7"
                            //cellpadding="1"
                            //width="105"
                            Body += 'border="1" align="center">';
                            Body += '<tr><td>Name</td><td>' + "Sell-to Customer Name" + '</td></tr><br>';
                            Body += '<tr><td>Balance</td><td>' + cusbalance + '</td></tr><br>';
                            Body += '<tr><td>OrderValue</td><td>' + FORMAT("Sale Order Total Amount") + '</td></tr>';
                            Body += '<tr><td>Rec.Amount</td><td>' + FORMAT(ROUND(Receivedamt, 1)) + '</td></tr><br>';
                            Body += '<tr><td>PaymentTerms</td><td>' + paymenttermdesc + '</td></tr>';
                            Body += '<tr><td>Sal.Person</td><td>' + spname + '</td></tr>';
                            Body += '<tr><td>Req.Comments</td><td>' + "Reason For Pending" + '</td></tr>';
                            Body += '<tr><td bgcolor="green">'; //#009900
                            Body += '<a Href="http://eff-cpu-178/erp/webform1.aspx?val1=' + FORMAT("No.") + '&val2=' + FORMAT(spname);
                            //Body+='&val2='+FORMAT(ROUND(Receivedamt,1));
                            Body += '&val3=' + FORMAT('Accepted');
                            //Body+='&val2='+FORMAT(spname);
                            Body += '&val4=1"target="_blank">';
                            //Calibri,#ffffff white
                            Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                            Body += '</td><td bgcolor="red">';
                            Body += '<a Href="http://eff-cpu-178/erp/webform1.aspx?val1=' + FORMAT("No.");
                            Body += '&val2=' + FORMAT(spname);
                            Body += '&val3=' + FORMAT('rejected');
                            Body += '&val4=0';
                            Body += '"target="_blank">';
                            Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                            Body += '</table></form></font></strong></body>';
                            //Attachment:='\\eff-cpu-222\ErpAttachments\cusstatement.html';
                            // Attachment := '';
                            /// TempFimeName := '';//EFFUPG                                               //NewCDOMessage(Mail_From,Mail_To,Subject,Body,Attachment);
                            //SMTP_MAIL.CreateMessage('ERP', "from Mail", Mail_To, Subject, Body, TRUE);
                            // EmailMessage.CreateMessage(Recipient, Subject, Body, FALSE);
                            //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            //SMTP_MAIL.AddAttachment(Attachment);//EFFUPG
                            // EmailMessage.AddAttachment(Attachment, '');//EFFUPG



                            //NewCDOMessage("from Mail",Mail_To,Subject,Body,Attachment);
                            MESSAGE(Body);
                        END ELSE
                            ERROR('This Option Only For Private Orders Only');
                        /*
                       UpdateAllowed() : Boolean
                       IF CurrPage.EDITABLE = FALSE THEN
                         ERROR(Text000);
                       EXIT(TRUE);   */

                    end;
                }
                separator(Action1102152007)
                {
                }
                action("Release to Design")
                {
                    Caption = 'Release to Design';
                    Image = Design;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text01: Label 'Do You want to Send the Document to Design?';
                        Email: Codeunit Email;
                        EmailMessage: Codeunit "Email Message";
                    begin
                        IF ("Sell-to Customer No." = 'CS INT') OR ("Sell-to Customer No." = 'R&D INT') THEN
                            ERROR('These are internal department orders no need to send for DESIGN Approval');
                        IF Status = 1 THEN
                            ERROR('This is released order Not possible to release to Design');
                        IF "SalOrd Des Approval" = TRUE THEN
                            ERROR('This blanket Order already approved');
                        //Rev01 Start
                        //Code Commented
                        /*
                        user.GET(USERID);
                        */
                        user.GET(USERSECURITYID);
                        //Rev01 End
                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        newline := 10;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::Design;
                        MODIFY;
                        Mail_Subject := 'Order Released to Design by ' + user."User ID";
                        Mail_Body := 'Order No        : ' + "No.";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += 'Customer Name   : ' + "Sell-to Customer Name";
                        Mail_Body += FORMAT(newline);
                        Mail_Body += FORMAT(newline);
                        Mail_Body += '***** Auto Mail Generated From ERP *****';
                        //Rev01 Start
                        /*
                        "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                        */
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                        //Rev01 End
                        IF "Mail-Id".FINDFIRST THEN
                            "from Mail" := "Mail-Id".MailID;
                        salesheader.RESET;
                        salesheader.SETFILTER(salesheader."No.", "No.");
                        REPORT.RUN(60004, FALSE, FALSE, salesheader);
                        REPORT.SAVEASHTML(60004, '\\erpserver\ErpAttachments\SALEORDER1.html', salesheader);
                        //Attachment1 := '\\erpserver\ErpAttachments\SALEORDER1.html';

                        "to mail" := 'prodeng@efftronics.com,sal@efftronics.com,anilkumar@efftronics.com,Pmurali@efftronics.com';
                        MODIFY;

                        // EmailMessage.CreateMessage("to mail", Mail_Subject, Mail_Body, FALSE);
                        //TempFimeName := '';//EFFUPG
                        //SMTP_MAIL.AddAttachment(Attachment1);//EFFUPG
                        //  EmailMessage.AddAttachment(Attachment1, '');//EFFUPG


                        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');

                        /*IF ISCLEAR(MAPIHandler) THEN
                          CREATE(MAPIHandler);
                        IF user.GET(user."User ID") THEN
                        eroorno:=0;
                        //MAPIHandler.ToName := 'anilkumar@efftronics.net';
                        MAPIHandler.ToName := 'chowdary@efftronics.net';
                        MAPIHandler.ToName := 'jhansi@efftronics.net';
                        MAPIHandler.ToName := 'anulatha@efftronics.net';
                        MAPIHandler.ToName := 'sganesh@efftronics.net';
                        MAPIHandler.ToName := 'dir@efftronics.net';
                        MAPIHandler.ToName := 'prasanthi@efftronics.net';
                        MAPIHandler.CCName := 'anilkumar@efftronics.net';
                        MAPIHandler.Subject :=xRec."No."+'ORDER Relesed to design';
                        //OpenNewMessage('anilkumar@efftronics.net');
                        //NewMessage('anilkumar@efftronics','swarupa@efftronics.net','hai','body','attachment',TRUE);
                        MAPIHandler.AddBodyText('ORDER number in ERP'+xRec."No."+',');
                        MAPIHandler.AddBodyText(xRec."Sell-to Customer Name"+' is Relesed to Design');
                        MAPIHandler.Send;
                        eroorno:=MAPIHandler.ErrorStatus;*/

                    end;
                }
                action("Update RDSO Details")
                {
                    Caption = 'Update RDSO Details';
                    Image = UpdateDescription;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        SalesLine: Record "Sales Line";
                    begin
                        SalesLine.SETRANGE(SalesLine."Document Type", "Document Type");
                        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                        IF SalesLine.FINDSET THEN
                            REPEAT
                                SalesLine."RDSO Charges Paid By" := "RDSO Charges Paid By";
                                SalesLine."RDSO Inspection Required" := "RDSO Inspection Required";
                                SalesLine."RDSO Inspection By" := "RDSO Inspection By";
                                SalesLine."RDSO Charges" := "RDSO Charges";
                                SalesLine.MODIFY;
                            UNTIL SalesLine.NEXT = 0;
                    end;
                }
                separator(Action1000000024)
                {
                }
                action("Release To Finance")
                {
                    Caption = 'Release To Finance';
                    Image = SuggestFinancialCharge;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        Text01: Label 'Do You want to Send the Document to Finance?';
                    begin
                        IF NOT CONFIRM(Text01, FALSE) THEN
                            EXIT;
                        TESTFIELD("Document Position", "Document Position"::Sales);
                        "Document Position" := "Document Position"::Sales;
                        MODIFY;
                    end;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attach;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        CustAttachments;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;
                action("ProformaInvoice Report")
                {
                    Caption = 'ProformaInvoice Report';
                    Ellipsis = true;
                    Image = SelectReport;
                    ApplicationArea = All;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction()
                    begin
                        ReportPrint.PrintSalesHeader(Rec);
                    end;
                }
                action("Test Report2")
                {
                    Caption = 'Test Report2';
                    Image = TestReport;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        "sales header".SETRANGE("sales header"."No.", "No.");
                        REPORT.RUN(50151, TRUE, FALSE, "sales header");
                    end;
                }
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                        SalesLine: Record "Sales Line";
                        ScheduleComp: Record Schedule2;
                        Item: Record Item;
                        ReservationEntry: Record "Reservation Entry";
                        Qty: Decimal;
                        ScheduleComp1: Record Schedule2;
                        SalesLine1: Record "Sales Line";
                    begin

                        // Added by Rakesh on 24-Jun-14 for validating posting date
                        IF "Posting Date" < TODAY THEN
                            //  IF NOT ("No." IN ['EFF/SAL/16-17/L00024','EFF/SAL/15-16/L00304','EFF/SAL/15-16/L00294','EFF/SAL/15-16/L00304']) THEN
                            ERROR('You cannot post with previous date than today');
                        // end by Rakesh

                        IF "Posting Date" < "Order Date" THEN
                            ERROR('Posting Date must be Greater than Order Date');

                        DepartmentsCode := COPYSTR("Shortcut Dimension 1 Code", 1, 3);
                        IF InvoiceNos IN [InvoiceNos::ExciseInv, InvoiceNos::InstInv, InvoiceNos::TradingInv] THEN BEGIN
                            IF DepartmentsCode <> 'PRD' THEN
                                ERROR('Departments Code must be "PRD" for %1', InvoiceNos);
                        END;
                        IF InvoiceNos IN [InvoiceNos::ServiceInv] THEN BEGIN
                            IF DepartmentsCode <> 'CUS' THEN
                                ERROR('Departments Code must be "CUS" for %1', InvoiceNos);
                        END;

                        //posting date error
                        SaleInvHeadRec.RESET;
                        SaleInvHeadRec.SETRANGE(SaleInvHeadRec."External Document No.", y);
                        IF SaleInvHeadRec.FINDLAST THEN
                            IF ("Posting Date" < SaleInvHeadRec."Posting Date") THEN
                                ERROR('Please Check the Posting Date');

                        // Added by Rakesh on 11-Nov-14 for validating the Salesperson code
                        IF "Salesperson Code" = '' THEN
                            ERROR('Enter the Salesperson code in General tab');
                        // End by Rakesh

                        /*
                        IF ("Sell-to Customer No."='CUST00822') AND ("Total Order(LOA)Value" >1000) THEN
                        ERROR('change the customer.you cannot post orders with this customer');
                        */
                        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                        SalesLine.SETFILTER(SalesLine."Qty. to Invoice", '%1..%2', 1, 1000000000);
                        IF SalesLine.FINDSET THEN BEGIN
                            IF SalesLine.COUNT > 5 THEN
                                ERROR('At a time you can invoice a maximum of 5 lines only');
                            REPEAT   //Added by sundar for Dimensions in sales lines
                                SalesLine.VALIDATE(SalesLine."Shortcut Dimension 1 Code", 'PRD-0010');
                                MODIFY;
                            UNTIL SalesLine.NEXT = 0;
                        END;

                        IF "Customer Posting Group" = 'RAILWAYS' THEN BEGIN
                            SalesLine.SETRANGE(SalesLine."Document No.", "No.");
                            SalesLine.SETFILTER(SalesLine."Qty. to Invoice", '%1..%2', 1, 1000000000);
                            IF SalesLine.FINDSET THEN
                                REPEAT
                                    IF (SalesLine."Schedule No" = 0) OR (SalesLine."Schedule Type" = 0) THEN
                                        ERROR('PLEASE ENTER SCHEDULE NO');
                                UNTIL SalesLine.NEXT = 0;
                        END;
                        servicetaxamt := 0;
                        /*
                        IF Structure = 'SERVICE' THEN BEGIN
                            SL.RESET;
                            SL.SETRANGE(SL."Document No.", "No.");
                            IF SL.FINDSET THEN
                                REPEAT
                                    servicetaxamt := servicetaxamt + SL."Service Tax Amount";
                                UNTIL SL.NEXT = 0;
                            IF servicetaxamt = 0 THEN
                                ERROR('You are not calculated the Service Tax Amount, first calculate the Structure Values then post the invoice');
                                
                        END;
                        */

                        // Added by Pranavi on 07-Jul-2016 for checking if Ext doc no already exist
                        IF DATE2DMY("Posting Date", 2) <= 3 THEN
                            Fyear := DATE2DMY("Posting Date", 3) - 1
                        ELSE
                            Fyear := DATE2DMY("Posting Date", 3);

                        POSTEDINVOICE1.RESET;
                        POSTEDINVOICE1.SETCURRENTKEY(POSTEDINVOICE1."External Document No.");
                        POSTEDINVOICE1.ASCENDING;
                        POSTEDINVOICE1.SETRANGE(POSTEDINVOICE1."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));  // Added by Rakesh
                        POSTEDINVOICE1.SETFILTER(POSTEDINVOICE1."External Document No.", "External Document No.");
                        IF POSTEDINVOICE1.FINDFIRST THEN BEGIN
                            ERROR('External Doc No.' + "External Document No." + ' already exist. Select again the Invoice No. Series!');
                        END;
                        // End by Pranavi on 07-Jul-2016
                        // Added by Pranavi on 14-Jul-2016 for Customer Checking
                        IF "Sell-to Customer No." <> "Bill-to Customer No." THEN
                            ERROR('Sell to Customer No.:' + "Sell-to Customer No." + ' and Bill to Customer No.:' + "Bill-to Customer No." + ' should be equal!');
                        // End by Pranavi on14-Jul-2016

                        //B2BSP  Start
                        //B2B
                        SalesLine1.RESET;
                        SalesLine1.SETRANGE("Document No.", "No.");
                        IF SalesLine1.FINDSET THEN BEGIN
                            REPEAT
                                SalesLine.RESET;
                                SalesLine.SETRANGE("Document No.", SalesLine1."Document No.");
                                //SalesLine.SETRANGE("Line No.",SalesLine1."Line No.");
                                SalesLine.SETRANGE(Type, SalesLine.Type::Item);
                                SalesLine.SETFILTER("Qty. to Ship", '<>%1', 0);
                                IF SalesLine.FINDSET THEN BEGIN
                                    REPEAT
                                        ScheduleComp.RESET;
                                        ScheduleComp.SETRANGE("Document No.", SalesLine."Document No.");
                                        ScheduleComp.SETRANGE("Document Line No.", SalesLine."Line No.");
                                        ScheduleComp.SETRANGE(Type, ScheduleComp.Type::Item);
                                        ScheduleComp.SETFILTER("Line No.", '<>%1', 10000);
                                        IF ScheduleComp.FINDSET THEN BEGIN
                                            REPEAT
                                                IF ScheduleComp."Document Line No." <> ScheduleComp."Line No." THEN BEGIN
                                                    IF NOT (ScheduleComp."Qty. to Ship" = ScheduleComp."Qty. Per" * SalesLine."Qty. to Ship (Base)") THEN BEGIN
                                                        MESSAGE('%1-- %2', ScheduleComp."Qty. to Ship", (ScheduleComp."Qty. Per" * SalesLine."Qty. to Ship (Base)"));
                                                        ERROR('As per the "Qty Per" Schedule Items are not sufficient for Schedule Component line no %1 of Line No.: %2', ScheduleComp."Line No.", ScheduleComp."Document Line No.");
                                                    END;
                                                    Item.GET(ScheduleComp."No.");
                                                    IF Item."Item Tracking Code" <> '' THEN BEGIN
                                                        CLEAR(Qty);
                                                        ReservationEntry.SETRANGE("Source ID", ScheduleComp."Document No.");
                                                        ReservationEntry.SETRANGE("Source Prod. Order Line", ScheduleComp."Document Line No.");
                                                        ReservationEntry.SETRANGE("Source Ref. No.", ScheduleComp."Line No.");
                                                        IF ReservationEntry.FINDSET THEN BEGIN
                                                            REPEAT
                                                                Qty += ABS(ReservationEntry.Quantity);
                                                            UNTIL ReservationEntry.NEXT = 0;
                                                            IF Qty < (ScheduleComp."Qty. to Ship") THEN
                                                                ERROR('Define Item Tracking for Schedule Components Line no  %1 of Line No.: %2', ScheduleComp."Line No.", ScheduleComp."Document Line No.");
                                                        END ELSE
                                                            ERROR('Item Tracking Doesnt Exist for the Schedule Comp Line no %1 of Line No.: %2', ScheduleComp."Line No.", ScheduleComp."Document Line No.");
                                                    END;
                                                END;
                                            UNTIL ScheduleComp.NEXT = 0;
                                        END;
                                    UNTIL SalesLine.NEXT = 0;
                                END;
                            UNTIL SalesLine1.NEXT = 0;
                        END;
                        //B2B

                        //B2BSP End
                        TestRPOStatus;    //Added by Pranavi on 28-10-2015 for not allowing to post if RPO is not finished
                                          //COMMENTED FOR F_YEAR BILLS

                        //Added by Pranavi on 02-Jan-2016 for CS Spares posting to H-Off problem clearence
                        CustPostGrp := "Customer Posting Group";
                        OrderNo := "No.";
                        CustNo := "Sell-to Customer No.";
                        PostingDt := "Posting Date";
                        ExteranlDoc := "External Document No.";
                        //End by Pranavi on 02-Jan-2016
                        /*//EFFUPG>>
                        IF ApprovalMgt.PrePostApprovalCheck(Rec,PurchaseHeader) THEN
                        BEGIN
                          IF ApprovalMgt.TestSalesPrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text001,"Document Type","No."))
                          ELSE
                          BEGIN
                            IF ApprovalMgt.TestSalesPayment(Rec) THEN
                              ERROR(STRSUBSTNO(Text002,"Document Type","No."))
                            ELSE
                              CODEUNIT.RUN(CODEUNIT::"Sales-Post (Yes/No)",Rec);
                          END;
                        END;
                        */
                        Post(CODEUNIT::"Sales-Post (Yes/No)");
                        //EFFUGP<<
                        "sales header".RESET;
                        "sales header".SETFILTER("sales header"."External Document No.", '<>%1', ' ');
                        IF "sales header".FINDSET THEN
                            REPEAT
                                "sales header"."External Document No." := '';
                                "sales header".MODIFY;
                            UNTIL "sales header".NEXT = 0;

                        // Added by Pranavi on 08-09-2016 for payment terms integration
                        IF (CustPostGrp IN ['PRIVATE', 'OTHERS', 'EXPORT']) AND NOT (CustNo IN ['CUST00536', 'CUST01164']) THEN
                            SQLInt.PvtSaleOrdrInvoiceCreationinCF(OrderNo, PostingDt, ExteranlDoc);
                        // End by Pranavi

                        //Added by Pranavi on 30 Dec 15 for duplicate external doc no
                        SHNew.RESET;
                        SHNew.SETRANGE(SHNew."No.", OrderNo);
                        IF SHNew.FINDFIRST THEN BEGIN
                            InvoiceNos := 0;
                            SHNew."External Document No." := '';
                            SHNew.MODIFY;
                        END;
                        //End by Pranavi

                    end;
                }
                action("Post and &Print")
                {
                    Caption = 'Post and &Print';
                    Ellipsis = true;
                    Image = PostPrint;
                    ShortCutKey = 'Shift+F9';
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        PurchaseHeader: Record "Purchase Header";
                    begin
                        Post(CODEUNIT::"Sales-Post + Print");
                    end;
                }
                action("Post &Batch")
                {
                    Caption = 'Post &Batch';
                    Ellipsis = true;
                    Image = PostBatch;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(REPORT::"Batch Post Sales Orders", TRUE, TRUE, Rec);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                separator(Action230)
                {
                }
                group("Prepa&yment")
                {
                    Caption = 'Prepa&yment';
                    Image = Prepayment;
                    action("Prepayment &Test Report")
                    {
                        Caption = 'Prepayment &Test Report';
                        Ellipsis = true;
                        Image = PrepaymentSimulation;
                        ApplicationArea = All;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";

                        trigger OnAction()
                        begin
                            ReportPrint.PrintSalesHeaderPrepmt(Rec);
                        end;
                    }
                    action(PostPrepaymentInvoice)
                    {
                        Caption = 'Post Prepayment &Invoice';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Invoic&e")
                    {
                        Caption = 'Post and Print Prepmt. Invoic&e';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtInvoiceYN(Rec, TRUE);
                        end;
                    }
                    action(PostPrepaymentCreditMemo)
                    {
                        Caption = 'Post Prepayment &Credit Memo';
                        Ellipsis = true;
                        Image = PrepaymentPost;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, FALSE);
                        end;
                    }
                    action("Post and Print Prepmt. Cr. Mem&o")
                    {
                        Caption = 'Post and Print Prepmt. Cr. Mem&o';
                        Ellipsis = true;
                        Image = PrepaymentPostPrint;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            SalesPostYNPrepmt: Codeunit "Sales-Post Prepayment (Yes/No)";
                        begin
                            IF ApprovalsMgmt.PrePostApprovalCheckSales(Rec) THEN
                                SalesPostYNPrepmt.PostPrepmtCrMemoYN(Rec, TRUE);
                        end;
                    }
                }
                action("Invoice Preview")
                {
                    Caption = 'Invoice Preview';
                    Image = PreviewChecks;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        "sales header".SETRANGE("sales header"."No.", "No.");
                        REPORT.RUN(50114, TRUE, FALSE, "sales header");
                    end;
                }
                action("Dispatch Note")
                {
                    Caption = 'Dispatch Note';
                    Image = OneNote;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        "sales header".SETRANGE("sales header"."No.", "No.");
                        //REPORT.RUN(90000,TRUE,FALSE,SalesHeader);
                        REPORT.RUN(50107, TRUE, FALSE, "sales header");
                    end;
                }
            }
            group("&Print")
            {
                Caption = '&Print';
                Image = Print;
                action("Order Confirmation")
                {
                    Caption = 'Order Confirmation';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                    end;
                }
                action("Work Order")
                {
                    Caption = 'Work Order';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        DocPrint.PrintSalesOrder(Rec, Usage::"Work Order");
                    end;
                }
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*IF ISCLEAR(SQLConnection) THEN
                        CREATE(SQLConnection, FALSE, TRUE); //Rev01

                    IF ISCLEAR(RecordSet) THEN
                        CREATE(RecordSet, FALSE, TRUE); //Rev01

                    IF ConnectionOpen <> 1 THEN BEGIN
                        SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                        SQLConnection.Open;
                        SQLConnection.BeginTrans;
                        ConnectionOpen := 1;
                    END;
                    SQLQuery := 'select orderno,salpersonname from authorisedorders where (status=1)and authorisedorders.orderno=''' + FORMAT("No.") + ''''
                    ;
                    //MESSAGE(SQLQuery);
                    RecordSet := SQLConnection.Execute(SQLQuery, RowCount);

                    IF RowCount < -1 THEN
                        ERROR('Request not yet authorized to Refresh the data')
                    ELSE BEGIN
                        IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                            RecordSet.MoveFirst;

                        WHILE NOT RecordSet.EOF DO BEGIN

                            IF ("No." = FORMAT(RecordSet.Fields.Item('orderno').Value)) THEN BEGIN
                                IF "No." <> '' THEN BEGIN
                                    //Authorized:=TRUE;
                                    "Document Position" := "Document Position"::Sales;
                                    MODIFY;
                                END;
                            END;
                            RecordSet.MoveNext;
                        END;
                    END;
                    MESSAGE('Data Refreshed');*/
                end;
            }
            action("Forward to OMS")
            {
                Caption = 'Forward to OMS';
                Image = MoveUp;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    OMSIntegrateCode: Codeunit SQLIntegration;
                begin
                    IF Status = Status::Released THEN BEGIN
                        // MESSAGE('Today OMS Integration Stopped');
                        MESSAGE("No.");
                        SalesLine.SETRANGE("Document Type", "Document Type");
                        SalesLine.SETRANGE("Document No.", "No.");
                        // SalesLine.SETRANGE(Type,SalesLine.Type::Item);
                        IF SalesLine.FINDFIRST THEN BEGIN
                            // MESSAGE('Enter in OMS Part');      OR ("Document Type"="Document Type"::"Blanket Order")
                            IF "Document Type" = "Document Type"::Order THEN BEGIN
                                IF (OMSIntegrateCode.SaleOrderCreationinOMS(Rec)) = FALSE THEN BEGIN
                                    MESSAGE('Error occured in OMS integration and record is not posted');
                                END;
                            END;
                        END;
                    END ELSE
                        ERROR('Order in Open State');
                    forwordomsVisible := FALSE
                end;
            }
            action(SalesHistoryBtn)
            {
                Caption = 'Sales H&istory';
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                Visible = SalesHistoryBtnVisible;
                ApplicationArea = All;
            }
            action("&Avail. Credit")
            {
                Caption = '&Avail. Credit';
                Image = AvailableToPromise;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //SalesInfoPaneMgt.LookupAvailCredit("Bill-to Customer No."); //B2b1.0
                end;
            }
        }
    }






    trigger OnAfterGetRecord()
    begin
        SetControlVisibility;
        /*  IF "Re-Dispatch" THEN
              ReturnOrderNoVisible := TRUE
          ELSE
              ReturnOrderNoVisible := FALSE;*/
        "sales header".SETRANGE("sales header"."No.", "No.");
        IF "sales header".FINDFIRST THEN BEGIN
            IF "sales header"."Order Assurance" = FALSE THEN
                "Order AssuranceEditable" := TRUE
            ELSE
                "Order AssuranceEditable" := FALSE;
            /*IF "sales header"."Sale Order Total Amount">0 THEN
            CurrPage."Sale Order Total Amount".EDITABLE:=FALSE
            ELSE
            CurrPage."Sale Order Total Amount".EDITABLE:=TRUE;
            IF "sales header"."Salesperson Code"='' THEN
            CurrPage."Salesperson Code".EDITABLE:=TRUE
            ELSE
            CurrPage."Salesperson Code".EDITABLE:=FALSE;

            IF "sales header"."Exp.Payment">0 THEN
            CurrPage."Exp.Payment".EDITABLE:=FALSE
            ELSE
            CurrPage."Exp.Payment".EDITABLE:=TRUE;

            IF "sales header"."Security Deposit Amount">0 THEN
            CurrPage."Security Deposit Amount".EDITABLE:=FALSE
            ELSE
            CurrPage."Security Deposit Amount".EDITABLE:=TRUE; */


        END;
        CHANGELOGSETUP.SETFILTER(CHANGELOGSETUP."Primary Key Field 2 Value", FORMAT("No."));
        IF CHANGELOGSETUP.COUNT > 0 THEN
            forwordomsVisible := TRUE
        ELSE
            forwordomsVisible := FALSE;
        /* IF "Installa Amount">0 THEN
         CurrPage."Installation Amount(CS)".EDITABLE(FALSE)
         ELSE
         CurrPage."Installation Amount(CS)".EDITABLE(TRUE);
         */
        NoOnFormat;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
        EXIT(ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        SalesHistoryStnVisible := TRUE;
        BillToCommentBtnVisible := TRUE;
        BillToCommentPictVisible := TRUE;
        SalesHistoryBtnVisible := TRUE;
        "Order AssuranceEditable" := TRUE;
        forwordomsVisible := TRUE;
        ReturnOrderNoVisible := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CheckCreditMaxBeforeInsert;
        IF COPYSTR("No.", 14, 2) <> '/L' THEN
            ERROR('U Cant Insert record without selecting "SAL LED" No Series');
        VALIDATE("Sell-to Customer No.", 'CUST00822');
        VALIDATE("Bill-to Customer No.", 'CUST00822');
        // VALIDATE(Structure, 'SALE-E+V');
        VALIDATE("Tax Area Code", 'SALES VAT');
        VALIDATE("Due Date", TODAY);
        VALIDATE(Product, 'LLM');
        EVALUATE(Warranty_Var, '5Y');
        VALIDATE("Warranty Period", Warranty_Var);
        VALIDATE("Location Code", 'PROD');
        VALIDATE("RDSO Inspection Req", 2);  //added by pranavi on 31-01-2015 if LED order rdso inspection req is set to NA
        VALIDATE("SD Status", "SD Status"::NA); // Added by Pranavi on 20-Jun-2016
    end;

    trigger OnModifyRecord(): Boolean
    begin
        /* IF "Re-Dispatch" THEN
             ReturnOrderNoVisible := TRUE
         ELSE
             ReturnOrderNoVisible := FALSE;*/
        // CurrPage.SalesLines.Page.UPDATECONTROLS;
        TESTFIELD(Status, Status::Open);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Responsibility Center" := UserMgt.GetSalesFilter();
        /*IF "No." = '' THEN BEGIN
          NoSeriesMgt.InitSeries('SAL LED1',xRec."No. Series","Posting Date","No.","No. Series");
        END;
         */

    end;

    trigger OnOpenPage()
    begin
        IF UserMgt.GetSalesFilter() <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center", UserMgt.GetSalesFilter());
            FILTERGROUP(0);
        END;
        "sales header".SETRANGE("sales header"."No.", "No.");
        IF "sales header".FINDFIRST THEN BEGIN
            IF "sales header"."Order Assurance" = FALSE THEN
                "Order AssuranceEditable" := TRUE
            ELSE
                "Order AssuranceEditable" := FALSE;

            /*IF "sales header"."Sale Order Total Amount">0 THEN
            CurrPage."Sale Order Total Amount".EDITABLE:=FALSE
            ELSE
            CurrPage."Sale Order Total Amount".EDITABLE:=TRUE;

            IF "sales header"."Salesperson Code"='' THEN
            CurrPage."Salesperson Code".EDITABLE:=TRUE
            ELSE
            CurrPage."Salesperson Code".EDITABLE:=FALSE;
            IF "sales header"."Exp.Payment">0 THEN
            CurrPage."Exp.Payment".EDITABLE:=FALSE
            ELSE
            CurrPage."Exp.Payment".EDITABLE:=TRUE;

            IF "sales header"."Security Deposit Amount">0 THEN
            CurrPage."Security Deposit Amount".EDITABLE:=FALSE
            ELSE
            CurrPage."Security Deposit Amount".EDITABLE:=TRUE;*/
        END;

        "sales header".RESET;
        "sales header".SETFILTER("sales header"."External Document No.", '<>%1', ' ');
        IF "sales header".FINDSET THEN
            REPEAT
                "sales header"."External Document No." := '';
                "sales header".MODIFY;
            UNTIL "sales header".NEXT = 0;

        SETRANGE("Date Filter", 0D, WORKDATE - 1);
        forwordtooms := 'Need To Press FORWARD OMS Button';
        /*  IF "Installa Amount">0 THEN
          CurrPage."Installation Amount(CS)".EDITABLE(FALSE)
          ELSE
          CurrPage."Installation Amount(CS)".EDITABLE(TRUE);
         */
        IF USERID IN ['EFFTRONICS\PRANAVI'] THEN
            Editable_Bool := TRUE
        ELSE
            Editable_Bool := FALSE;

    end;

    var
        Text000: Label 'Unable to execute this function while in view only mode.';
        CopySalesDoc: Report "Copy Sales Document";
        MoveNegSalesLines: Report "Move Negative Sales Lines";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ReportPrint: Codeunit "Test Report-Print";
        DocPrint: Codeunit "Document-Print";
        ArchiveManagement: Codeunit ArchiveManagement;
        SalesInfoPaneMgt: Codeunit "Sales Info-Pane Management";
        SalesSetup: Record "Sales & Receivables Setup";
        UserMgt: Codeunit "User Setup Management";
        Usage: Option "Order Confirmation","Work Order";
        Text001: Label 'There are non posted Prepayment Amounts on %1 %2.';
        Text002: Label 'There are unpaid Prepayment Invoices related to %1 %2.';
        SalesLine: Record "Sales Line";
        Text16500: Label 'You can not uncheck Re-Dispatch until Return Receipt No. is Blank.';
        Text16501: Label 'To calculate invoice discount, check Cal. Inv. Discount on header when Price Inclusive of Tax = Yes.\This option cannot be used to calculate invoice discount when Price Inclusive Tax = Yes.';
        MLTransactionType: Option Purchase,Sale;
        SalesPlanLine: Record "Sales Planning Line";
        Quantity: Decimal;
        SalesLineRec: Record "Sales Line";
        I: Integer;
        Qty: Decimal;
        NewStatus: Option Simulated,Planned,"Firm Planned",Released;
        NewOrderType: Option ItemOrder,ProjectOrder;
        eroorno: Integer;

        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        mail: Codeunit Mail;
        amt: Decimal;
        vatamt: Decimal;
        taxamt: Decimal;
        exciseamt: Decimal;
        pendingamt: Decimal;
        ecessamt: Decimal;
        shecessamt: Decimal;
        "sales header": Record "Sales Header";
        newline: Char;
        SHA: Record "Sales Header Archive";
        CUS: Record Customer;
        CLE: Record "Cust. Ledger Entry";
        Receivedamt: Decimal;
        Needtoreceive: Decimal;
        PT: Record "Payment Terms";
        Percent: Decimal;
        Actualreceived: Decimal;
        CI: Boolean;
        NI: Boolean;
        POSTEDINVOICE: Record "Sales Invoice Header";
        X: Text[30];
        y: Code[10];
        SI: Boolean;
        NORMAL: Boolean;
        salhed: Record "Sales Header";
        SL: Record "Sales Line";
        j: Integer;
        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[1000];
        //objEmailConf: Automation;
        //objEmail: Automation;
        //flds: Automation;
        //fld: Automation;
        bodies: Integer;
        body1: Text[1000];
        Body: Text[1000];
        Subject: Text[1000];
        Mail_To: List OF [Text];
        Mail_From: Text[1000];
        Attachment: Text[1000];
        nextline: Char;
        paymenttermdesc: Text[100];
        SALPUR: Record "Salesperson/Purchaser";
        spname: Text[20];
        Cust: Record Customer;
        cusbalance: Text[20];
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        updateQuery: Text[500];
        servicetaxamt: Decimal;
        temp: Integer;
        user1: Record User;
        username: Text[30];
        SMTP_MAIL: Codeunit "SMTP Mail";
        InvoiceNos: Option " ",ExciseInv,ServiceInv,TradingInv,InstInv,,EffeVJA;
        SCHEDULEOMS: Record Schedule2;
        salesheader: Record "Sales Header";
        Attachment1: Text[1000];
        forwordtooms: Text[50];
        CHANGELOGSETUP: Record "Change Log Entry";
        SIH: Record "Sales Invoice Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;

        ReturnOrderNoVisible: Boolean;

        forwordomsVisible: Boolean;

        "Order AssuranceEditable": Boolean;

        "No.Emphasize": Boolean;

        SalesHistoryBtnVisible: Boolean;

        BillToCommentPictVisible: Boolean;

        BillToCommentBtnVisible: Boolean;

        SalesHistoryStnVisible: Boolean;
        Text19070588: Label 'Sell-to Customer';
        Text19069283: Label 'Bill-to Customer';
        ChangeExchangeRate: Page "Change Exchange Rate";
        "--Rev01": Integer;
        // SQLConnection: Automation;
        //RecordSet: Automation;
        DepartmentsCode: Text[5];
        SaleInvHeadRec: Record "Sales Invoice Header";
        Warranty_Var: DateFormula;
        attachments: Record Attachments;
        SHNew: Record "Sales Header";
        OrderNo: Code[30];
        Schedl2: Record Schedule2;
        POSTEDINVOICE1: Record "Sales Invoice Header";
        Fyear: Integer;
        "PT_Adv%": Decimal;
        "PT_Del%": Decimal;
        "PT_Crd%": Decimal;
        SL1: Record "Sales Line";
        LineAmtLOA: Decimal;
        AdvAmt: Decimal;
        RetentionAmt: Decimal;
        SupplyAmt: Decimal;
        InstAmt: Decimal;
        CustPostGrp: Code[10];
        SQLInt: Codeunit SQLIntegration;
        PostingDt: Date;
        CustNo: Code[20];
        ExteranlDoc: Code[15];
        PayTerm: Record "Payment Terms";
        CustLedgEntr: Record "Cust. Ledger Entry";
        Editable_Bool: Boolean;
        TH: Record "Tender Header";
        Quote: Label '''';
        "--EFFUPG--": Integer;
        TempFimeName: Text;
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        DocNoVisible: Boolean;

    local procedure Post(PostingCodeunitID: Integer)
    begin
        SendToPosting(PostingCodeunitID);
        IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
            CurrPage.CLOSE;
        CurrPage.UPDATE(FALSE);
    end;


    procedure UpdateAllowed(): Boolean
    begin
        IF CurrPage.EDITABLE = FALSE THEN
            ERROR(Text000);
        EXIT(TRUE);
    end;

    local procedure UpdateInfoPanel()
    var
        DifferSellToBillTo: Boolean;
    begin
        DifferSellToBillTo := "Sell-to Customer No." <> "Bill-to Customer No.";
        SalesHistoryBtnVisible := DifferSellToBillTo;
        BillToCommentPictVisible := DifferSellToBillTo;
        BillToCommentBtnVisible := DifferSellToBillTo;
        // SalesHistoryStnVisible := SalesInfoPaneMgt.DocExist(Rec, "Sell-to Customer No.");
        //IF DifferSellToBillTo THEN
        //SalesHistoryBtnVisible := SalesInfoPaneMgt.DocExist(Rec, "Bill-to Customer No.") //EFFUPG
    end;

    local procedure ApproveCalcInvDisc()
    begin
        CurrPage.SalesLines.PAGE.ApproveCalcInvDisc;
    end;


    procedure "---B2B---"()
    begin
    end;


    procedure DocumentPosition()
    begin
        /*
        IF "Document Position" = "Document Position" :: Design THEN
          CurrPage.EDITABLE := FALSE
        ELSE
          CurrPage.EDITABLE := TRUE;
        */

    end;


    procedure CreateOrders(Qtyparam: Decimal) OrdersCreated: Boolean
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        ProdOrderFromSale: Codeunit "Event Handling Cust";
    begin
        IF NOT SalesPlanLine.FINDSET THEN
            EXIT;

        REPEAT
            SalesLine.GET(
              SalesLine."Document Type"::Order,
              SalesPlanLine."Sales Order No.",
              SalesPlanLine."Sales Order Line No.");
            //SalesLine.TESTFIELD("Shipment Date");
            SalesLine.CALCFIELDS("Reserved Qty. (Base)");
            //IF SalesLine."Outstanding Qty. (Base)" > SalesLine."Reserved Qty. (Base)" THEN BEGIN
            Item.GET(SalesLine."No.");
            IF Item."Replenishment System" = Item."Replenishment System"::"Prod. Order" THEN BEGIN
                OrdersCreated := TRUE;
                ProdOrderFromSale.CreateProdOrder2(
                  SalesLine, NewStatus::Released, NewOrderType::ItemOrder, 1);
                IF NewOrderType = NewOrderType::ProjectOrder THEN
                    EXIT;
            END;
        //END;
        UNTIL (SalesPlanLine.NEXT = 0);
    end;


    procedure calcamt()
    begin
        "Sale Order Total Amount" := 0;
        SalesLine.SETRANGE(SalesLine."Document No.", "No.");
        IF SalesLine.FINDSET THEN
            REPEAT
                "Sale Order Total Amount" += SalesLine."Line Amount";
            //+ SalesLine."Excise Amount" + SalesLine."Tax Amount";
            UNTIL SalesLine.NEXT = 0;
        MODIFY;
    end;


    procedure ChooseInvoice()
    var
        temp: Integer;
    begin
        temp := 0;
        "sales header".RESET;
        "sales header".SETFILTER("sales header"."External Document No.", '<>%1', ' ');
        IF "sales header".FINDSET THEN
            REPEAT
                "sales header"."External Document No." := '';
                "sales header".MODIFY;
            UNTIL "sales header".NEXT = 0;

        CASE InvoiceNos OF
            1:
                BEGIN

                    salhed.SETFILTER(salhed."Document Type", 'Order');
                    salhed.SETFILTER(salhed."External Document No.", '<>%1', '');
                    IF salhed.COUNT > 0 THEN
                        IF salhed.FINDSET THEN
                            REPEAT
                                ERROR(salhed."No." + '  Sale Have the Invoice Number');
                            UNTIL salhed.NEXT = 0;

                    //ERROR('Invoice Number Already Assign to Another Sale Order');
                    //POSTEDINVOICE.RESET;
                    /*  POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                      POSTEDINVOICE.ASCENDING;      //this line too
                      POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date",(010412D),(310313D));
                      POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.",'L00000..L99999');
                    //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                      IF POSTEDINVOICE.FINDLAST THEN
                      BEGIN
                      y:='0';
                      y:=POSTEDINVOICE."External Document No.";
                      temp:=1;
                      END;
                      IF temp=0 THEN
                        "External Document No.":='L00001'
                      ELSE
                      "External Document No.":=INCSTR(y);*/

                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                    POSTEDINVOICE.ASCENDING;      //this line too
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(04, 01, 13), DMY2DATE(31, 03, 14));
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", '0..999');
                    //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "External Document No." := '001'
                    ELSE
                        "External Document No." := INCSTR(y);

                    //  UNTIL POSTEDINVOICE.NEXT = 0;
                    //  "External Document No.":=INCSTR(y);
                    //MESSAGE(FORMAT("External Document No."));
                    MODIFY;
                END;

            2:
                BEGIN
                    salhed.SETFILTER(salhed."Document Type", 'Order');
                    salhed.SETFILTER(salhed."External Document No.", '<>%1', '');
                    IF salhed.COUNT > 0 THEN
                        IF salhed.FINDSET THEN
                            REPEAT
                                ERROR(salhed."No." + '  Sale Have the Invoice Number');
                            UNTIL salhed.NEXT = 0;

                    //ERROR('Invoice Number Already Assign to Another Sale Order');
                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                    POSTEDINVOICE.ASCENDING;      //this line too
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(04, 01, 13), DMY2DATE(31, 03, 14));
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'SI*');
                    //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "External Document No." := 'SI-001'
                    ELSE
                        "External Document No." := INCSTR(y);

                    /* IF POSTEDINVOICE.FINDLAST THEN
                     REPEAT
                     y:=POSTEDINVOICE."External Document No.";
                     UNTIL POSTEDINVOICE.NEXT = 0;
                     "External Document No.":=INCSTR(y);*/
                    //MESSAGE(FORMAT("External Document No."));
                    MODIFY;

                END;
            3:
                BEGIN
                    salhed.SETFILTER(salhed."Document Type", 'Order');
                    salhed.SETFILTER(salhed."External Document No.", '<>%1', '');
                    IF salhed.COUNT > 0 THEN
                        IF salhed.FINDSET THEN
                            REPEAT
                                ERROR(salhed."No." + '  Sale Have the Invoice Number');
                            UNTIL salhed.NEXT = 0;

                    //ERROR('Invoice Number Already Assign to Another Sale Order');
                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                    POSTEDINVOICE.ASCENDING;      //this line too
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(04, 01, 13), DMY2DATE(31, 03, 14));
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'CI*');
                    //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "External Document No." := 'CI-001'
                    ELSE
                        "External Document No." := INCSTR(y);

                    /*IF POSTEDINVOICE.FINDLAST THEN
                    REPEAT
                    y:=POSTEDINVOICE."External Document No.";
                    UNTIL POSTEDINVOICE.NEXT = 0;
                    "External Document No.":=INCSTR(y);*/
                    //MESSAGE(FORMAT("External Document No."));
                    MODIFY;

                END;
            4:
                BEGIN
                    salhed.SETFILTER(salhed."Document Type", 'Order');
                    salhed.SETFILTER(salhed."External Document No.", '<>%1', '');
                    IF salhed.COUNT > 0 THEN
                        IF salhed.FINDSET THEN
                            REPEAT
                                ERROR(salhed."No." + '  Sale Have the Invoice Number');
                            UNTIL salhed.NEXT = 0;

                    //ERROR('Invoice Number Already Assign to Another Sale Order');
                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");  //sreenivas modified this line
                    POSTEDINVOICE.ASCENDING;      //this line too
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(04, 01, 13), DMY2DATE(31, 03, 14));
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'IN*');
                    //MESSAGE(FORMAT(POSTEDINVOICE.COUNT));
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "External Document No." := 'IN-001'
                    ELSE
                        "External Document No." := INCSTR(y);

                    /*IF POSTEDINVOICE.FINDLAST THEN
                    REPEAT
                    y:=POSTEDINVOICE."External Document No.";
                    UNTIL POSTEDINVOICE.NEXT = 0;
                    "External Document No.":=INCSTR(y);*/
                    //MESSAGE(FORMAT("External Document No."));
                    MODIFY;

                END;

        END;

    end;

    local procedure SelltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SalespersonCodeOnAfterValidate()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure BilltoCustomerNoOnAfterValidat()
    begin
        CurrPage.UPDATE;
    end;

    local procedure ShortcutDimension1CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure ShortcutDimension2CodeOnAfterV()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure PricesIncludingVATOnAfterValid()
    begin
        CurrPage.UPDATE;
    end;

    local procedure CurrencyCodeC111OnAfterValidat()
    begin
        CurrPage.SalesLines.PAGE.UpdateForm(TRUE);
    end;

    local procedure Prepayment37OnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;

    local procedure SelltoCityOnInputChange(var Text: Text[1024])
    begin
        IF "Sell-to City" <> '' THEN BEGIN
            "Bill-to City" := "Sell-to City";
            "Ship-to City" := "Sell-to City";

        END;
        IF "Sell-to Post Code" <> '' THEN BEGIN
            "Bill-to Post Code" := "Sell-to Post Code";
            "Ship-to Post Code" := "Sell-to Post Code";
        END;
    end;

    local procedure SelltoPostCodeOnInputChange(var Text: Text[1024])
    begin
        IF "Sell-to Post Code" <> '' THEN BEGIN
            "Bill-to Post Code" := "Sell-to Post Code";
            "Ship-to Post Code" := "Sell-to Post Code";
        END;
        IF "Sell-to City" <> '' THEN BEGIN
            "Bill-to City" := "Sell-to City";
            "Ship-to City" := "Sell-to City";

        END;
    end;

    local procedure ReDispatchOnPush()
    begin
        /* IF "Re-Dispatch" THEN
             CurrPage.SalesLines.PAGE.MakeVisibleLineControl
         ELSE
             CurrPage.SalesLines.PAGE.MakeInvisibleLineControl;*/
    end;

    local procedure ServiceInvInvoiceNosOnPush()
    begin
        //ChooseInvoice;
    end;

    local procedure TradingInvInvoiceNosOnPush()
    begin
        //ChooseInvoice;
    end;

    local procedure InstInvInvoiceNosOnPush()
    begin
        //ChooseInvoice;
    end;

    local procedure ExciseInvInvoiceNosOnPush()
    begin
        //ChooseInvoice;
    end;

    local procedure InvoiceNosOnPush()
    begin
        "External Document No." := '';
        MODIFY;
    end;

    local procedure NoOnFormat()
    begin
        IF "SalOrd Des Approval" = TRUE THEN BEGIN
            "No.Emphasize" := TRUE;
        END
        ELSE BEGIN
            "No.Emphasize" := TRUE;
        END;
    end;

    local procedure InvoiceNosOnValidate()
    begin
        InvoiceNosOnPush;
    end;

    local procedure ExciseInvInvoiceNosOnValidate()
    begin
        ExciseInvInvoiceNosOnPush;
    end;

    local procedure ServiceInvInvoiceNosOnValidate()
    begin
        ServiceInvInvoiceNosOnPush;
    end;

    local procedure TradingInvInvoiceNosOnValidate()
    begin
        TradingInvInvoiceNosOnPush;
    end;

    local procedure InstInvInvoiceNosOnValidate()
    begin
        InstInvInvoiceNosOnPush;
    end;


    procedure CustAttachments()
    var
        CustAttach: Record Attachments;
    begin
        CustAttach.RESET;
        CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
        CustAttach.SETRANGE("Document No.", "No.");
        CustAttach.SETRANGE("Document Type", "Document Type");

        PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
    end;


    procedure TestRPOStatus()
    var
        SLn: Record "Sales Line";
        ILEs: Record "Item Ledger Entry";
        RPOs: Record "Production Order";
        REs: Record "Reservation Entry";
        Lot: Text;
    begin
        //Added by Pranavi on 28-10-2015 for not allowing to post if RPO is not finished
        SLn.RESET;
        SLn.SETFILTER(SLn."Document Type", '%1', "Document Type");
        SLn.SETFILTER(SLn.Type, '%1', SLn.Type::Item);
        SLn.SETFILTER(SLn."Document No.", "No.");
        SLn.SETFILTER(SLn."Qty. to Ship", '>%1', 0);
        IF SLn.FINDSET THEN
            REPEAT
                REs.RESET;
                REs.SETFILTER(REs."Item No.", SLn."No.");
                REs.SETFILTER(REs."Source ID", "No.");
                REs.SETFILTER(REs."Source Ref. No.", '%1', SLn."Line No.");
                IF REs.FINDSET THEN
                    REPEAT
                        ILEs.RESET;
                        ILEs.SETFILTER(ILEs."Entry Type", '%1', ILEs."Entry Type"::Output);
                        ILEs.SETFILTER(ILEs."Item No.", SLn."No.");
                        ILEs.SETFILTER(ILEs."Serial No.", REs."Serial No.");
                        ILEs.SETFILTER(ILEs."Lot No.", REs."Lot No.");
                        IF ILEs.FINDFIRST THEN BEGIN
                            Lot := '';
                            IF ILEs."Lot No." <> '' THEN
                                Lot := ' Lot No.: ' + ILEs."Lot No.";
                            RPOs.RESET;
                            RPOs.SETFILTER(RPOs.Status, '%1', RPOs.Status::Released);
                            RPOs.SETFILTER(RPOs."No.", ILEs."Order No.");
                            IF RPOs.FINDFIRST THEN
                                ERROR('Released Prod Order ' + ILEs."Order No." + ' is not Finished for Item ' + ILEs."Item No." + '\Serial No.: ' + ILEs."Serial No." + Lot);
                        END;
                    UNTIL REs.NEXT = 0;
            UNTIL SLn.NEXT = 0;
        //End by Pranavi
    end;


    procedure SendForAuth(TypeFlag: Code[10])
    var
        Body: Text;
        Mail_From: Text[250];
        Mail_To: Text[250];
        Mail: Codeunit Mail;
        Subject: Text[250];
        SMTP_MAIL: Codeunit "SMTP Mail";
        AuthorizedID: Text[50];
        ReqUserGRec: Record "User Setup";
        AuthUserGRec: Record User;
        PT: Record "Payment Terms";
        PT_Name: Text[100];
        Auth_User: Text[50];
        Req_User: Text[50];
        SP: Record "Salesperson/Purchaser";
        Req_Person_Id: Code[10];
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";

    begin
        Body := '';
        // Mail_From := '';
        Mail_To := '';
        Req_Person_Id := '';
        ReqUserGRec.RESET;
        ReqUserGRec.SETRANGE(ReqUserGRec."User ID", USERID);
        IF ReqUserGRec.FINDFIRST THEN BEGIN
            Req_User := ReqUserGRec."User ID";
            Req_Person_Id := ReqUserGRec.EmployeeID;

            Req_User := COPYSTR(USERID, 12, STRLEN(USERID));
        end;
        /*
        IF COPYSTR("No.",14,2) IN['/L','/T'] THEN
        BEGIN
          Auth_User := 'VIJAYMOHAN. CHITTINENI';
          Mail_To := 'cvmohan@effe.in,erp@efftronics.com';
        END
        ELSE BEGIN
          AuthUserGRec.RESET;
          AuthUserGRec.SETRANGE(AuthUserGRec.EmployeeID,"Salesperson Code");
          IF AuthUserGRec.FINDFIRST THEN
          BEGIN
            Auth_User := AuthUserGRec."Full Name";
            IF AuthUserGRec.MailID <> '' THEN
            BEGIN
              Mail_To := AuthUserGRec.MailID+',erp@efftronics.com';
            END ELSE Mail_To := 'erp@efftronics.com';
          END ELSE Mail_To := 'erp@efftronics.com';
        END;
        */
        Auth_User := 'Murali Krishna M';
        //Mail_To := 'mk@effe.in,erp@efftronics.com';
        Recipient.Add('mk@effe.in');
        Recipient.Add('erp@efftronics.com');
        PT.RESET;
        PT.SETRANGE(PT.Code, "Payment Terms Code");
        IF PT.FINDFIRST THEN
            PT_Name := PT.Description;
        IF TypeFlag IN ['Release', 'RELEASE'] THEN
            Subject := 'ERP-Request for Authorisation for Order Release without Advance Payment for ' + FORMAT("No.") + '-' + FORMAT("Sell-to Customer Name")
        ELSE
            Subject := 'ERP-Request for Authorisation for Billing Order without Advance Payment for ' + FORMAT("No.") + '-' + FORMAT("Sell-to Customer Name");
        Body := '<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body += '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6">Customer Details</font></label>';
        Body += '<hr style=solid; color= #3333CC>';
        Body += '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">';
        Body += '<tr><td>Sale Order</td><td>' + "No." + '</td></tr><br>';
        Body += '<tr><td>Customer</td><td>' + "Sell-to Customer Name" + '</td></tr><br>';
        Body += '<tr><td>Order Value</td><td>' + FORMAT("Sale Order Total Amount") + '</td></tr><br>';
        Body += '<tr><td>Payment Term</td><td>' + "Payment Terms Code" + ':- ' + PT_Name + '</td></tr><br>';
        SP.RESET;
        SP.SETRANGE(SP.Code, "Salesperson Code");
        IF SP.FINDFIRST THEN
            Body += '<tr><td>Sales Executive</td><td>' + SP.Name + '</td></tr>'
        ELSE
            Body += '<tr><td>Sales Executive</td><td>' + "Salesperson Code" + '</td></tr>';
        Body += '<tr><td>Customer Type</td><td>' + "Customer Posting Group" + '</td></tr>';

        Body += '<tr><td bgcolor="green">';
        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/AdvancePaymentAuth.aspx?ORDERNO=' + FORMAT("No.") + '&CUSTNAME=' + FORMAT("Sell-to Customer Name");
        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
        Body += '&REQPERSON=' + FORMAT(Req_User);
        Body += '&REQPERSONMAIL=' + Mail_From;
        Body += '&REQID=' + Req_Person_Id;
        IF TypeFlag IN ['Release', 'RELEASE'] THEN
            Body += '&AUTHSTATUS=1"target="_blank">'
        ELSE
            Body += '&AUTHSTATUS=3"target="_blank">';
        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';

        Body += '</td><td bgcolor="red">';
        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/AdvancePaymentAuth.aspx?CUSTNO=' + FORMAT("No.") + '&CUSTNAME=' + FORMAT("Sell-to Customer Name");
        Body += '&AUTHPERSON=' + FORMAT(Auth_User);
        Body += '&REQPERSON=' + FORMAT(Req_User);
        Body += '&REQPERSONMAIL=' + Mail_From;
        Body += '&REQID=' + Req_Person_Id;
        IF TypeFlag IN ['Release', 'RELEASE'] THEN
            Body += '&AUTHSTATUS=0"target="_blank">'
        ELSE
            Body += '&AUTHSTATUS=2"target="_blank">';
        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';

        Body += '</table><br>';
        Body += '<br><p align = "center">:: Note: Auto Generated mail from ERP</b> :: </b></P></div></body></html>';
        //Mail_From:='pranavi@efftronics.com';
        //Mail_To:='pranavi@efftronics.com';
        Recipient.Add('pranavi@efftronics.com');
        EmailMessage.Create(Recipient, Subject, Body, TRUE);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


        MESSAGE(TypeFlag);
        IF TypeFlag IN ['Release', 'RELEASE'] THEN
            "PT Release Auth Stutus" := "PT Release Auth Stutus"::"Sent For Auth"
        ELSE
            "PT Post Auth Stutus" := "PT Post Auth Stutus"::"Sent For Auth";
        MODIFY;

        MESSAGE('Authorization Mail Has been Sent to :' + Mail_To);

    end;


    local procedure SetControlVisibility()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        //JobQueueVisible := "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting";
        //HasIncomingDocument := "Incoming Document Entry No." <> 0;
        //SetExtDocNoMandatoryCondition;

        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
    end;


    procedure InputBox(): Text
    var
        NoOFRows_gInt: Integer;
        NoOFColumns_gInt: Integer;
        Result: Text;
        FindWhat: Text[2];
        ReplaceWith: Text[4];
        NewString: Text;
        i: Integer;
    begin

        // ADDED BY VIJAYA ON 20-MAY-2016 for Changing Order Status

        Prompt := Prompt.Form();
        Prompt.Width := 400;
        Prompt.Height := 650;
        Prompt.FormBorderStyle := FormBorderStyle.FixedToolWindow;
        Prompt.Text := 'Remarks';
        Prompt.StartPosition := FormStartPosition.CenterParent;

        LblRows := LblRows.Label();
        LblRows.Text := 'Enter Remarks :: ';
        LblRows.Left := 20;
        LblRows.Top := 20;
        Prompt.Controls.Add(LblRows);

        TxtRows := TxtRows.TextBox();
        TxtRows.Left(20);
        TxtRows.Top(50);
        TxtRows.Width(350);
        TxtRows.Height(520);
        TxtRows.Multiline := TRUE;
        TxtRows.ScrollBars := 1;


        Prompt.Controls.Add(TxtRows);

        ButtonOk := ButtonOk.Button();
        ButtonOk.Text('Ok');
        ButtonOk.Left(215);
        ButtonOk.Top(580);
        ButtonOk.Width(75);
        ButtonOk.DialogResult := DialogResult.OK;
        Prompt.Controls.Add(ButtonOk);

        ButtonCancel := ButtonCancel.Button();
        ButtonCancel.Text('Cancel');
        ButtonCancel.Left(295);
        ButtonCancel.Top(580);
        ButtonCancel.Width(75);
        ButtonCancel.DialogResult := DialogResult.Cancel;
        Prompt.Controls.Add(ButtonCancel);

        IF (Prompt.ShowDialog().ToString() <> DialogResult.OK.ToString()) THEN BEGIN
            EXIT;
        END;
        Prompt.Dispose;
        Result := TxtRows.Text;   /*
          FindWhat:=format(13);
          ReplaceWith:= 'xx';
          WHILE STRPOS(Result,FindWhat) > 0 DO
            Result := DELSTR(Result,STRPOS(Result,FindWhat)) + ReplaceWith + COPYSTR(Result,STRPOS(Result,FindWhat) + STRLEN(FindWhat));*/

        //NewString := String;

        i := 1;
        NewString := '';
        WHILE i < STRLEN(Result) + 2 DO BEGIN
            IF (Result[i] = 13) THEN
                NewString := NewString + '<br>'
            ELSE
                NewString := NewString + FORMAT(Result[i]);
            i := i + 1;
        END;



        EXIT(NewString);

        //end by vijaya

    end;

    local procedure SetDocNoVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Reminder,FinChMemo;
    begin
        DocNoVisible := DocumentNoVisibility.SalesDocumentNoIsVisible(DocType::Order, "No.");
    end;

    var
        TxtRows: DotNet TxtRowsD;

        prompt: DotNet PromptD;
        ButtonCancel: DotNet ButtonCancelD;
        ButtonOk: DotNet confirmationD;
        LblRows: DotNet LblRowsD;
        DialogResult: DotNet DialogResultD;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        USER: Record "User Setup";
        USER2: Record user;
        FormStartPosition: DotNet FormStartPositionD;
        FormBorderStyle: DotNet FormBorderStyleD;
        Recipient: List of [Text];

}

