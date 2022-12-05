page 50009 "Purchase Automail VendorsList"
{
    PageType = List;
    SourceTable = Vendor;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Send Mail"; Rec."Send Mail")
                {
                    ApplicationArea = All;
                }
                field("Mail Required"; Rec."Mail Required")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Action1102152006)
            {
                action("Send Auto Mail")
                {
                    Image = MailSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        // Added by Rakesh for Auto followup mail for Vendors regarding pending items on 20-Nov-14

                        /*
                        Mail_From := 'purchase@efftronics.com';
                        USER.RESET;
                        USER.SETRANGE(USER."User Name",USERID);
                        IF USER.FINDFIRST THEN
                          username:= USER."Full Name"
                        ELSE
                          username:= 'Chowdary Ch';
                        
                        
                        RESET;
                        SETRANGE("Send Mail",TRUE);
                        IF FINDSET THEN
                        REPEAT
                          first := FALSE;
                          Mail_To := "E-Mail";
                          PL.RESET;
                          PL.SETCURRENTKEY(PL."Document Type",PL."Buy-from Vendor No.");
                          PL.SETFILTER(PL."Document Type",'%1',1);
                          PL.SETFILTER(PL."Qty. to Receive",'>%1',0);
                          PL.SETFILTER(PL."Buy-from Vendor No.","No.");
                          IF PL.FINDSET THEN
                          REPEAT
                            IF first = FALSE THEN
                            BEGIN
                              Mail_Subject := 'Reg: Pending Material Expected dates Required -'+ Name;
                              Mail_Body := '';
                              SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Mail_Subject,Mail_Body,TRUE);
                              SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                              SMTP_MAIL.AppendBody('<br><br>');
                              SMTP_MAIL.AppendBody('Please provide the material expected date for the below pending material.<br>');
                              SMTP_MAIL.AppendBody('Please mention the dispatch date in below field and reply through return mail.<br><br>');
                              SMTP_MAIL.AppendBody('<html><body><table border=1 style="border-collapse: collapse; font-size:10pt;" ><col width="180"><col width="90">');
                              SMTP_MAIL.AppendBody('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Deviated Days</th><th>Exp. Dispatch Date</th></tr>');
                              PurchaseHeader.RESET;
                              PurchaseHeader.SETRANGE(PurchaseHeader."No.",PL."Document No.");
                              IF PurchaseHeader.FINDFIRST THEN
                              BEGIN
                                Ord_date := PurchaseHeader."Order Date";
                                Dev_date := CALCDATE(PL."Safety Lead Time",Ord_date);
                              END;
                              IF Dev_date < TODAY THEN
                                font_color := 'red'
                              ELSE IF (Dev_date - TODAY) > 10 THEN
                                font_color := 'green'
                              ELSE
                                font_color := 'black';
                              SMTP_MAIL.AppendBody('<tr style="color:'+font_color+';"><td>'+PL."Document No."+'</td><td>'+FORMAT(Ord_date)+'</td>');
                              SMTP_MAIL.AppendBody('<td>'+PL.Description+'</td><td align=right>'+FORMAT(PL."Qty. to Receive")+'</td><td align=right>'+FORMAT(TODAY-Dev_date)+'</td><td>-</td></tr>');
                              first := TRUE;
                            END
                            ELSE
                            BEGIN
                              PurchaseHeader.RESET;
                              PurchaseHeader.SETRANGE(PurchaseHeader."No.",PL."Document No.");
                              IF PurchaseHeader.FINDFIRST THEN
                              BEGIN
                                Ord_date := PurchaseHeader."Order Date";
                                Dev_date := CALCDATE(PL."Safety Lead Time",Ord_date);
                              END;
                              IF Dev_date < TODAY THEN
                                font_color := 'red'
                              ELSE IF (Dev_date - TODAY) > 10  THEN
                                font_color := 'green'
                              ELSE
                                font_color := 'black';
                              SMTP_MAIL.AppendBody('<tr style="color:'+font_color+';"><td>'+PL."Document No."+'</td><td>'+FORMAT(Ord_date)+'</td>');
                              SMTP_MAIL.AppendBody('<td>'+PL.Description+'</td><td align=right>'+FORMAT(PL."Qty. to Receive")+'</td><td align=right>'+FORMAT(TODAY-Dev_date)+'</td><td>-</td></tr>');
                            END;
                          UNTIL PL.NEXT =0;
                          SMTP_MAIL.AppendBody('</table><br>Regards,<br>');
                          SMTP_MAIL.AppendBody('<b>'+username+'<br> Purchase Department<BR>'+'Efftronics Systems Pvt. Ltd.,</b><BR>');
                          SMTP_MAIL.AppendBody('40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>');
                          SMTP_MAIL.AppendBody('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                          SMTP_MAIL.AppendBody('<br><b>Note:<br>1. This is System generated Automail.<br>2. <font color=red>Color items</font> are deviated.<br>');
                          SMTP_MAIL.AppendBody('3. Black color items are to be received items less than 10 days<br>4. <font color=green>Color items</font> are yet to receive items greater than 10 days</b></body></html>');
                        
                          IF (Mail_To <> '')  THEN
                          BEGIN
                            SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');
                            SMTP_MAIL.Send;
                            MESSAGE('Mail sent to '+Name);
                          END;
                        
                        UNTIL NEXT=0;
                        // End by Rakesh on 20-Nov-14
                        */


                        // Added by Rakesh for Auto followup mail for Vendors regarding pending items on 20-Nov-14
                        //Mail_From := 'purchase@efftronics.com';
                        USER.RESET;
                        USER.SETRANGE(USER."User Name", USERID);
                        IF USER.FINDFIRST THEN
                            username := USER."Full Name"
                        ELSE
                            username := 'Chowdary Ch';

                        Vendor_Name := '';
                        Rec.RESET;
                        Rec.SETRANGE("Send Mail", TRUE);
                        //Added by vijaya on 24-May-2016 for Differentiate Material Receive and Bill Receive
                        IF (Mail_Purpose = 'Material') THEN BEGIN// end by vijaya
                            IF Rec.FINDSET THEN
                                REPEAT
                                    first := FALSE;
                                    Mail_To := Rec."E-Mail"; // 'rakesht@efftronics.com';
                                    PL.RESET;
                                    PL.SETCURRENTKEY(PL."Document Type", PL."Buy-from Vendor No.");
                                    PL.SETFILTER(PL."Document Type", '%1', 1);
                                    PL.SETFILTER(PL."Qty. to Receive", '>%1', 0);
                                    PL.SETFILTER(PL."Buy-from Vendor No.", Rec."No.");
                                    IF PL.FINDSET THEN
                                        REPEAT
                                            //Added By Pranavi on 26-Dec-2015 to send mail only for released order items
                                            PH.RESET;
                                            PH.SETRANGE(PH.Status, PH.Status::Released);
                                            PH.SETRANGE(PH."No.", PL."Document No.");
                                            IF PH.FINDFIRST THEN BEGIN     //End By Pranavi on 26-Dec-2015 to send mail only for released order items
                                                IF first = FALSE THEN BEGIN
                                                    Mail_Subject := 'Reg: Pending Material Expected dates Required -' + Rec.Name;
                                                    Mail_Body := '';
                                                    // SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Mail_Subject, Mail_Body, TRUE);


                                                    Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                                    Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="6">Material Expected Dates Required</font></label></div><br/>');
                                                    Body += ('Dear Sir/Madam,');
                                                    Body += ('<br><br>');
                                                    Body += ('Please provide the material expected date for the below pending material.<br>');
                                                    Body += ('Please mention the dispatch date in below field and reply through return mail.<br><br><HR COLOR=#26148C>');

                                                    Body += ('<table border=1 style="border-collapse: collapse;font-size:10pt; width:100%;">');
                                                    Body += ('<tr><th>Purchase Order No.</th><th>Order Date</th><th>Description</th><th>Qty. to Receive</th><th>Pending Days</th><th>Exp. Dispatch Date</th></tr>');
                                                    EmailMessage.Create(Recipients, Subject, Body, true);
                                                    PurchaseHeader.RESET;
                                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", PL."Document No.");
                                                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                                                        Ord_date := PurchaseHeader."Order Date";
                                                        Dev_date := CALCDATE(PL."Safety Lead Time", Ord_date);
                                                    END;
                                                    /*IF Dev_date < TODAY THEN
                                                      font_color := 'red'
                                                    ELSE IF (Dev_date - TODAY) > 10 THEN
                                                      font_color := 'green'
                                                    ELSE*/
                                                    font_color := 'black';
                                                    Body += ('<tr style="color:' + font_color + ';"><td>' + PL."Document No." + '</td><td>' + FORMAT(Ord_date) + '</td>');
                                                    Body += ('<td>' + PL.Description + '</td><td align=right>' + FORMAT(PL."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Ord_date) + '</td><td align=center>-</td></tr>');
                                                    first := TRUE;
                                                END
                                                ELSE BEGIN
                                                    PurchaseHeader.RESET;
                                                    PurchaseHeader.SETRANGE(PurchaseHeader."No.", PL."Document No.");
                                                    IF PurchaseHeader.FINDFIRST THEN BEGIN
                                                        Ord_date := PurchaseHeader."Order Date";
                                                        Dev_date := CALCDATE(PL."Safety Lead Time", Ord_date);
                                                    END;
                                                    /*IF Dev_date < TODAY THEN
                                                      font_color := 'red'
                                                    ELSE IF (Dev_date - TODAY) > 10  THEN
                                                      font_color := 'green'
                                                    ELSE*/
                                                    font_color := 'black';
                                                    Body += ('<tr style="color:' + font_color + ';"><td>' + PL."Document No." + '</td><td>' + FORMAT(Ord_date) + '</td>');
                                                    Body += ('<td>' + PL.Description + '</td><td align=right>' + FORMAT(PL."Qty. to Receive") + '</td><td align=right>' + FORMAT(TODAY - Ord_date) + '</td><td align=center>-</td></tr> ');
                                                END;
                                            END;
                                        UNTIL PL.NEXT = 0;
                                    IF first = TRUE THEN BEGIN
                                        Body += ('<BR></table>');
                                        /*SMTP_MAIL.AppendBody('<br><br><b>Note</b>:<br><br>1. <font color=red>Color items</font> are deviated.<br>');
                                        SMTP_MAIL.AppendBody('2. Black color items are to be received items less than 10 days<br>3. <font color=green>Color items</font> are yet to receive items greater than 10 days</body></html>');*/
                                        Body += ('<br><br><HR COLOR=#26148C><br>Regards,<br><b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>');
                                        Body += ('40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>');
                                        Body += ('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');

                                        // #6589EB
                                        IF (Mail_To <> '') THEN BEGIN
                                            //SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');
                                            Recipients.Add('purchase@efftronics.com,erp@efftronics.com');
                                            // SMTP_MAIL.Send;
                                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                            Vendor_Name := Vendor_Name + '::' + Rec.Name;
                                        END
                                        ELSE
                                            MESSAGE('Mail-ID N/A for ' + Rec.Name);
                                    END;
                                UNTIL Rec.NEXT = 0;
                        END
                        //Added by vijaya on 24-May-2016 for Differentiate Material Receive and Bill Receive
                        ELSE
                            IF Mail_Purpose = 'Bill' THEN BEGIN
                                IF Rec.FINDSET THEN
                                    REPEAT
                                        first := FALSE;
                                        Mail_To := Rec."E-Mail";
                                        //Mail_To := 'anilkumar@efftronics.com,pranavi@efftronics.com,vijaya@efftronics.com';
                                        PRH.RESET;
                                        PRH.SETFILTER(PRH."Buy-from Vendor No.", Rec."No.");
                                        PRH.SETFILTER(PRH."Bill Received", 'NO');
                                        IF PRH.FINDSET THEN
                                            REPEAT
                                                PRL.RESET;
                                                PRL.SETFILTER(PRL."Document No.", PRH."No.");
                                                PRL.SETFILTER(PRL."Qty. Rcd. Not Invoiced", '>%1', 0);
                                                PRL.SETFILTER(PRL.Sample, '=%1', FALSE);
                                                PRL.SETFILTER(PRL.Quantity, '>%1', 0);
                                                IF PRL.FINDSET THEN
                                                    REPEAT
                                                        IF first = FALSE THEN BEGIN
                                                            Subject := 'Reg: Original invoice  Required -' + Rec.Name;
                                                            Mail_Body := '';
                                                            //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Mail_Subject, Mail_Body, TRUE);
                                                            Body += ('<html><body><div style="border-color:white;  margin: 20px; border-width:10px; font-size:11pt;  border-style:solid; padding: 20px; width: 800px;">');
                                                            Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><br/><label><font size="6">Original invoice  Required</font></label></div><br/>');
                                                            Body += ('Dear Sir/Madam,');
                                                            Body += ('<br><br>');
                                                            Body += ('Below list is already material received and Original invoice to be received report.<br>');
                                                            Body += ('Please courier original invoice and please mention expected courier date & Docket details.<br><br><HR COLOR=#26148C>');

                                                            Body += ('<table border=1 style="border-collapse: collapse;font-size:10pt; width:100%;">');
                                                            Body += ('<tr><th>Purchase Order No.</th><th><Description></th><th>Quantity</th><th>Amount</th><th>Received Date</th>');
                                                            Body += ('<th>Pending Days</th><th>Exp. Couriour date & Docket details</th></tr>');
                                                            Body += ('<tr><td>' + PRH."Order No." + '</td><td>' + PRL.Description + '</td><td align=right>' + FORMAT(PRL.Quantity) + '</td><td align=right>');
                                                            Body += (FORMAT(PRL.Quantity * PRL."Unit Cost (LCY)") + '</td><td>' + FORMAT(PRH."Posting Date") + '</td><td align=right>');
                                                            Body += (FORMAT(TODAY - PRH."Posting Date") + '</td><td  align=center>-</td></tr>');
                                                            first := TRUE;
                                                        END
                                                        ELSE BEGIN
                                                            Body += ('<tr><td>' + PRH."Order No." + '</td><td>' + PRL.Description + '</td><td align=right>' + FORMAT(PRL.Quantity) + '</td><td align=right>');
                                                            Body += (FORMAT(PRL.Quantity * PRL."Unit Cost (LCY)") + '</td><td>' + FORMAT(PRH."Posting Date") + '</td><td align=right>');
                                                            Body += (FORMAT(TODAY - PRH."Posting Date") + '</td><td  align=center>-</td></tr>');




                                                        END;
                                                    UNTIL PRL.NEXT = 0;
                                            UNTIL PRH.NEXT = 0;
                                        Body += ('<BR></table>');
                                        Body += ('<br><br><HR COLOR=#26148C><br>Regards,<br><b>' + username + '<br> Purchase Department<BR>' + 'Efftronics Systems Pvt. Ltd.,</b><BR>');
                                        Body += ('40-15-9,Brundavan Colony,<br>Vijayawada - 520010,<br>Andhra Pradesh, India.<br>');
                                        Body += ('Ph No : 0866-2466679(Direct)/2466699/75<br>');
                                        Body += ('<div style="Background-color:#0971D9; color:#F0F1F5; "><p align= "center">:::: AUTO GENERATED MAIL FROM ERP ::::</div><br/></div>');

                                        IF (Mail_To <> '') THEN BEGIN
                                            //SMTP_MAIL.AddBCC('purchase@efftronics.com,erp@efftronics.com');

                                            Recipients.Add('purchase@efftronics.com,erp@efftronics.com');
                                            EmailMessage.Create(Recipients, Subject, Body, true);
                                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                            // SMTP_MAIL.Send;
                                            Vendor_Name := Vendor_Name + '::' + Rec.Name;
                                        END
                                        ELSE
                                            MESSAGE('Mail-ID N/A for ' + Rec.Name);
                                    UNTIL Rec.NEXT = 0;
                            END;
                        MESSAGE('Mail sent to ' + Vendor_Name);
                        //end by Vijaya on 24-May-2014

                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.RESET;
        Rec.MODIFYALL("Send Mail", FALSE);

        Rec.RESET;
        Rec.SETRANGE("Mail Required", TRUE);
    end;

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PL: Record "Purchase Line";
        Count1: Integer;
        // SMTP_MAIL: Codeunit "SMTP Mail";
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        USER: Record User;
        username: Text[50];
        first: Boolean;
        PurchaseHeader: Record "Purchase Header";
        Ord_date: Date;
        font_color: Text;
        Dev_date: Date;
        PH: Record "Purchase Header";
        Mail_Purpose: Text[10];
        Vendor_Name: Text;
        PRH: Record "Purch. Rcpt. Header";
        PRL: Record "Purch. Rcpt. Line";


    procedure MailPusposeAssignment(Mailreason: Text[10]);
    begin
        //Added by vijaya on 24-May-2016 for Differentiate Material Receive and Bill Receive
        Mail_Purpose := Mailreason;
    end;
}

