pageextension 70152 PurchaseOrderListExt extends 9307
{


    layout
    {


        /*modify("Control1")
        {


            ShowCaption = false;
        }*/


        addafter("Buy-from Vendor No.")
        {
            /*field(Structure; Structure)
            {
                ApplicationArea = All;
            }*/
        }
        addafter("Buy-from Vendor Name")
        {
            /* field("Amount to Vendor"; "Amount to Vendor")
             {
                 CaptionML = ENU = 'Net Total',
                             ENN = 'Amount to Vendor';
                 ApplicationArea = All;
             }*/
        }
        addafter("Ship-to Name")
        {
            field("First Release DateTime"; Rec."First Release DateTime")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Country/Region Code")
        {
            field("Sale Order No"; Rec."Sale Order No")
            {
                ApplicationArea = All;
            }
        }
        addafter("Job Queue Status")
        {
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field(Mail_Sent; Rec.Mail_Sent)
            {
                ApplicationArea = All;
            }
            field(QA_Auth_Status; Rec.QA_Auth_Status)
            {
                ApplicationArea = All;
            }
            field(QA_Auth_Date; Rec.QA_Auth_Date)
            {
                ApplicationArea = All;
            }

        }
        addafter(Control1)
        {
            group(Control1102152006)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152005)
                {
                    ShowCaption = false;
                    group(Control1102152004)
                    {
                        ShowCaption = false;
                        field("POCount+FORMAT(xRec.COUNT)"; POCount + FORMAT(xRec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }
    actions
    {



        /* modify("Action 1102601035")
         {



             Promoted = false;
             PromotedIsBig = false;


         }*/
        modify(Statistics)
        {
            Promoted = true;
            PromotedIsBig = true;
        }
        /*modify("Action 18")
         {
             Promoted = false;
             PromotedIsBig = false;



         }*/



        /*   modify("Action 1102601031")
           {


               Promoted = false;
               PromotedIsBig = false;


           }
           modify(PostedPurchaseInvoices)
           {


               Promoted = false;
               PromotedIsBig = false;
           }*/



        modify(Print)
        {


            Promoted = true;
        }



        modify(Post)
        {


            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PostAndPrint)
        {


            Promoted = true;
            PromotedIsBig = true;
        }
        modify(PostBatch)
        {

            Promoted = true;
        }
        addafter(Reopen)
        {
            action("Multiple Order Release ")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    "Count": Integer;
                    //PO: Page "Purchase Order";
                    PH: Record "Purchase Header";
                    PFU: Page "Purchase FollowUp";
                begin
                    /*CurrPage.SETSELECTIONFILTER(Rec);
                    IF FINDFIRST THEN
                    REPEAT
                      PO.StructureDetails(Rec,TRUE);
                    UNTIL NEXT = 0;
                    RESET;*/
                    //Added by vijaya on 06-Aug-2016 for Differentiate Shortage Page and To be Relese Orders
                    PFU.PagePurpose('Release');
                    PFU.RUN;
                    //PAGE.RUN(50013);  commented by vijaya on 06-Aug-2016

                end;
            }
        }
    }



    var
        [SecurityFiltering(SecurityFilter::Validated)]
        PL: Record "Purchase Line";
        POCount: Label '"Total POs: "';
        PurchLine: Record "Purchase Line";
        item: Record Item;
        "Packing Value": Decimal;
        "Payment Terms": Record "Payment Terms";
        Frieght_Value: Decimal;
        Insurance_Value: Decimal;
        Additional_Duty: Decimal;
        Service_Amount: Decimal;
        Packing_Calculation: Boolean;
        Unit_Cost: Decimal;
        Line_Amount: Decimal;
        "G\L": Record "General Ledger Setup";
        VAT_AMOUNT: Decimal;
        CST_AMOUNT: Decimal;
        Dept: Code[10];
        Text001: Label 'Cashflow connection does not exist. Do you want to Continue?';
        "Excepted Rcpt.Date Tracking": Record "Excepted Rcpt.Date Tracking";
        //StructureOrderLineDetails: Record "Structure Order Line Details";
        CashFlowConnection: Codeunit "Cash Flow Connection";

    procedure Testing();
    var
        ReleasePurchDoc: Codeunit 415;
        vendorRec: Record Vendor;
    begin
        // Added by Rakesh to restrict items with unit cost zero on 15-Oct-14
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
        PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::Item);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF (PurchLine."Unit Cost (LCY)" = 0) AND (PurchLine.Sample = FALSE) THEN     //Added by Pranavi on 07-08-2015 for if item is sample then allow without unit cost
                    ERROR('Enter the unit cost for ' + PurchLine."No.");
                IF PurchLine."Gen. Prod. Posting Group" = '' THEN      //added by Pranavi on 07-07-2015 to restrict items without Gen.Prod.posting grp
                    ERROR('Please Enter General Prod. Posting Group for ' + PurchLine."No.");
                item.RESET;                                   //Added by Pranavi to restrict items with PO Blocked is true on 27-07-2015
                item.SETFILTER(item."No.", PurchLine."No.");
                IF item.FINDFIRST THEN BEGIN
                    IF item."PO Blocked" = TRUE THEN
                        ERROR('Purch Order Cannot be released beacause of Item: ' + item."No." + ' is blocked for PO!');
                END;                                      //End by Pranavi
            UNTIL PurchLine.NEXT = 0;

        // end by Rakesh

        vendorRec.RESET;
        vendorRec.SETFILTER(vendorRec."No.", Rec."Buy-from Vendor No.");
        vendorRec.SETFILTER(vendorRec."Way bill Required", '%1', TRUE);
        IF vendorRec.FINDFIRST THEN BEGIN
            IF Rec."Way bill" = '' THEN
                ERROR('Please enter way bill No.');
        END;



        "G\L".GET;
        IF "G\L"."Active ERP-CF Connection" THEN BEGIN
            Rec.TESTFIELD(Status, Rec.Status::Open);
            //TESTFIELD(Structure);
            Rec.TESTFIELD("Payment Terms Code");
            IF "Payment Terms".GET(Rec."Payment Terms Code") THEN BEGIN
                IF NOT "Payment Terms"."Update In Cashflow" THEN
                    ERROR('PAYMENT TERMS CODE MUST BE UPDATED IN CASH FLOW');
            END;
            /*IF (NOT Rec."Calculate Tax Structure") AND (Structure <> '') THEN
                ERROR('PLEASE CALCULATE THE TAX STRUCTURE');*/
        END
        //Added by sundar for resolving records missing in Cashflow
        ELSE BEGIN
            IF UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                IF NOT CONFIRM(Text001, FALSE, Rec."No.") THEN
                    EXIT;
            END
            ELSE
                ERROR('Cash Flow connection is not active Contact ERP Team');
        END;
        //Added by sundar for resolving records missing in Cashflow
        IF (Rec."Order Date" = 0D) OR (Rec."Order Date" > "G\L"."Allow Posting To") THEN
            MESSAGE('PLEASE ENTER THE ORDER DATE ');

        /* IF (Structure = '') AND (NOT Rec."Inclusive of All Taxes") AND (Rec."Order Date" > DMY2Date(12, 17, 09)) THEN //Rev01
             ERROR('PLEASE ENTER THE TAX STRUCTRE & CALCULATE THE TAX STRUCTURE');*/

        IF NOT ((Rec."Location Code" = 'R&D STR') OR (Rec."Location Code" = 'CS STR') OR (Rec."Location Code" = 'STR') OR (Rec."Location Code" = 'SITE')) THEN
            ERROR('Location Code Must be In R&D STR,CS STR,STR,SITE');//sundar

        IF Rec."Location Code" = 'R&D STR' THEN BEGIN
            IF (COPYSTR(Rec."Shortcut Dimension 1 Code", 1, 2) <> 'RD') THEN
                ERROR('Please Pick R&D Dimension Code')
        END;
        IF Rec."Location Code" = 'CS STR' THEN BEGIN
            IF (COPYSTR(Rec."Shortcut Dimension 1 Code", 1, 3) <> 'CUS') THEN
                ERROR('Please Pick CS Dimension Code')
        END;
        IF Rec."Location Code" = 'STR' THEN BEGIN
            IF (COPYSTR(Rec."Shortcut Dimension 1 Code", 1, 3) <> 'PRD') THEN
                ERROR('Please Pick PRD Dimension Code')
        END;
        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
        PurchLine.SETFILTER(PurchLine.Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF PurchLine."Buy-from Vendor No." <> Rec."Buy-from Vendor No." THEN
                    ERROR('VENDOR MUST BE SAME IN PURCHASE LINES & HEADER');
                IF (PurchLine.Type = PurchLine.Type::Item) OR (PurchLine.Type = PurchLine.Type::"G/L Account") THEN BEGIN
                    IF (PurchLine.Type = PurchLine.Type::Item) AND (PurchLine.Make = '') THEN
                        ERROR('Enter Make for Item ' + PurchLine.Description);
                    IF ((Rec."Sale Order No" = '') AND (PurchLine.Type = PurchLine.Type::Item)) AND (Rec."Order Date" > DMY2Date(06, 01, 09)) THEN;
                    // PurchLine.TESTFIELD(PurchLine."Expected Receipt Date");

                    IF PurchLine."Gen. Prod. Posting Group" = '' THEN
                        ERROR(' THERE IS NO "Gen. Prod. Posting Group" FOR ' + PurchLine.Description);
                    IF (PurchLine."Location Code" = 'SITE') AND (Rec."Order Date" > DMY2Date(08, 11, 09)) THEN BEGIN
                        IF PurchLine."Shortcut Dimension 2 Code" = '' THEN
                            ERROR('Please Enter the Site Information');
                        /* IF ("Sale Order No"='') THEN
                            //  ERROR('Please Enter the Sale Order Information');
                          END
                          ELSE  IF (PurchLine."Location Code"='SITE') AND ("Order Date"<110809D)   THEN
                          BEGIN */
                        /* IF ("Sale Order No"='') THEN
                            ERROR('Please Enter the Sale Order Information');*///anil comented for closed sale orders details
                    END;


                    IF (PurchLine."Direct Unit Cost" = 0) AND NOT (PurchLine.Sample) THEN
                        ERROR('THERE IS NO COST FOR THE ITEM  ' + PurchLine.Description);
                    "Excepted Rcpt.Date Tracking".RESET;
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document No.", PurchLine."Document No.");
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document Line No.", PurchLine."Line No.");
                    /*  IF NOT ("Excepted Rcpt.Date Tracking".FINDFIRST) THEN
                      BEGIN
                        IF(PurchLine."Expected Receipt Date"<>PurchLine."Deviated Receipt Date")  AND ("Order Date">010609D) THEN
                        ERROR('Expected Receipt Date is not equal to Deviated Receipt Date for '+PurchLine."No.");
                      //MESSAGE('');
                      END;   */
                    IF (PurchLine.Type <> PurchLine.Type::"G/L Account") THEN
                        PurchLine.TESTFIELD(PurchLine."QC Enabled");
                    IF Rec."Location Code" <> PurchLine."Location Code" THEN
                        ERROR('location code not matching in both line and header');
                END;
            UNTIL PurchLine.NEXT = 0;
        //comment by anil
        // MAIL CODE FOR ORDERING THE R&D INDENTS
        /*
        IF (USERID<>'EFFTRONICS\CHOWDARY') AND (USERID<>'EFFTRONICS\BRAHMAIAH') AND (USERID<>'EFFTRONICS\ANILKUMAR')AND (USERID<>'SUPER') AND (USERID<>'EFFTRONICS\PRANAVI')  THEN
        ERROR('You have No Rights')
        ELSE
        BEGIN
        
        IF ("Location Code"='R&D STR') AND (Status=Status::Open) THEN
        BEGIN
        j:=0;
          Prev_Indent:='';
          PurchLine.RESET;
          PurchLine.SETRANGE(PurchLine."Document No.","No.");
          PurchLine.SETCURRENTKEY(PurchLine."Indent No.");
          PurchLine.SETRANGE(PurchLine."Location Code",'R&D STR');
          IF PurchLine.FINDSET THEN
          REPEAT
        
          IF PurchLine."Indent No."<>'' THEN
          BEGIN
           IF (Prev_Indent='') OR (Prev_Indent<>PurchLine."Indent No.") THEN
           BEGIN
              IF j<=0 THEN
              j:=1
              ELSE
              j:=j;
              Body:='';
              Mail_From:='';
              Mail_To:='';
              Subject:='';
              attachment:='';
              Prev_Indent:=PurchLine."Indent No.";
              PL.RESET;
              PL.SETRANGE(PL."Document No.",PurchLine."Document No.");
              PL.SETRANGE(PL."Indent No.",Prev_Indent);
              IF PL.FINDFIRST THEN
              BEGIN
              REPORT.RUN(50157,FALSE,FALSE,PL);
              attachment:='\\erpserver\ErpAttachments\ErpAttachments1\p_int_details'+FORMAT(j)+'.html';
              REPORT.SAVEASHTML(50157,attachment,FALSE,PL);
              END;
              INDENT_HEADER.RESET;
              INDENT_HEADER.SETRANGE(INDENT_HEADER."No.",Prev_Indent);
              INDENT_HEADER.SETRANGE(INDENT_HEADER."Delivery Location",'R&D STR');
               IF INDENT_HEADER.FINDFIRST THEN
                BEGIN
                 dateofit:=DT2DATE(INDENT_HEADER."Release Date Time");
                 noofdays:=FORMAT(TODAY-dateofit);
                 USER.RESET;
                 USER.SETRANGE(USER."User ID",USERID);
                 IF USER.FINDFIRST THEN
                  Mail_From:=USER.MailID;
                 USER.RESET;
                 USER.SETRANGE(USER."User ID",INDENT_HEADER."Person Code");
                 IF USER.FINDFIRST THEN
                   Mail_To:=USER.MailID;
                 Subject:='YOUR INDENT ('+Prev_Indent +' ) FOR "'+INDENT_HEADER."Production Order Description"+'" HAS BEEN ORDERED ';
        //         Body+=FORMAT(NEW_LINE);
                 Body+='****testing  Auto Mail Generated From ERP  ****';
        //         Mail_From:='sreenu@efftronics.com';
        //         Mail_To:='sreenu@efftronics.com';
                 IF((Mail_From<>'') AND (Mail_To<>'')) THEN
                 BEGIN
                   SMTP_MAIL.CreateMessage('PURCHASE ORDER',Mail_From,Mail_To,Subject,Body,FALSE);
                   SMTP_MAIL.AddAttachment(attachment);
                 END;
        //            SLEEP(2000);
                j:=j+1;
                END;
            END;
           END;
          UNTIL PurchLine.NEXT=0;
        END;
        END;
        */
        IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to release. Contact Purchase Dept Manager')
        ELSE
            ReleasePurchDoc.PerformManualRelease(Rec);

        "Packing Value" := 0;
        PurchLine.CALCFIELDS(PurchLine."Document Date");
        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", Rec."No.");
        PurchLine.SETFILTER(PurchLine."No.", '<>%1', '');
        IF PurchLine.FINDSET THEN
            REPEAT
                "G\L".GET;
                IF "G\L"."Active ERP-CF Connection" AND (Rec."Order Date" >= DMY2Date(02, 01, 10)) THEN //
                BEGIN

                    "Packing Value" := 0;
                    Frieght_Value := 0;
                    Insurance_Value := 0;
                    Additional_Duty := 0;
                    Service_Amount := 0;
                    Line_Amount := 0;
                    Unit_Cost := 0;
                    /*  StructureOrderLineDetails.RESET;
                      StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                      StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Document No.", PurchLine."Document No.");
                      StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails."Line No.", PurchLine."Line No.");
                      StructureOrderLineDetails.SETRANGE(StructureOrderLineDetails.Type, StructureOrderLineDetails.Type::Purchase);
                      IF StructureOrderLineDetails.FINDSET THEN
                          REPEAT
                              IF ((StructureOrderLineDetails."Tax/Charge Group" = 'PACKING') OR
                                 (StructureOrderLineDetails."Tax/Charge Group" = 'FORWARDING')) THEN BEGIN

                                  "Packing Value" += StructureOrderLineDetails."Amount (LCY)";
                              END ELSE
                                  IF StructureOrderLineDetails."Tax/Charge Group" = 'FREIGHT' THEN BEGIN
                                      Frieght_Value += StructureOrderLineDetails."Amount (LCY)";
                                  END ELSE
                                      IF StructureOrderLineDetails."Tax/Charge Group" = 'CUSTOMS DU' THEN BEGIN
                                          Frieght_Value += StructureOrderLineDetails."Amount (LCY)";
                                      END ELSE

                                          IF StructureOrderLineDetails."Tax/Charge Group" = 'INSURANCE' THEN BEGIN
                                              Insurance_Value += StructureOrderLineDetails."Amount (LCY)";
                                          END ELSE
                                              IF StructureOrderLineDetails."Tax/Charge Group" = 'ADD.DUTY' THEN
                                                  Additional_Duty += StructureOrderLineDetails."Amount (LCY)"
                                              ELSE
                                                  IF StructureOrderLineDetails."Tax/Charge Type" = StructureOrderLineDetails."Tax/Charge Type"::"Service Tax" THEN
                                                      Service_Amount += StructureOrderLineDetails."Amount (LCY)";

                          UNTIL StructureOrderLineDetails.NEXT = 0;*/
                    // END;
                    IF PurchLine."Currency Code" = '' THEN BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost";
                        Line_Amount := PurchLine."Line Amount";
                    END ELSE BEGIN
                        Unit_Cost := PurchLine."Direct Unit Cost" / Rec."Currency Factor";
                        Line_Amount := (PurchLine.Quantity * PurchLine."Direct Unit Cost") / Rec."Currency Factor";

                    END;
                    IF PurchLine."Line Discount Amount" > 0 THEN
                        Additional_Duty -= PurchLine."Line Discount Amount";
                    IF (PurchLine."Frieght Charges" > 0) THEN BEGIN
                        IF PurchLine."Currency Code" = '' THEN
                            Frieght_Value := PurchLine."Frieght Charges"
                        ELSE
                            Frieght_Value := PurchLine."Frieght Charges" / Rec."Currency Factor";
                    END;
                    //EFFUPG>>
                    /*
                    IF (PurchLine."Tax Area Code" = 'PURH VAT') THEN
                        VAT_AMOUNT := PurchLine."Tax Amount"
                    ELSE
                        CST_AMOUNT := PurchLine."Tax Amount";
                        */
                    //EFFUPG<<
                    IF PurchLine."Location Code" = 'CS STR' THEN
                        Dept := 'CS'
                    ELSE
                        Dept := 'NORMAL';

                    IF PurchLine.Sample = FALSE THEN
                        CashFlowConnection.ExecInOracle('insert into Purchase_line' +
                                                        '(PURCHASE_ID,ORDERNO,ITEMNO,VENDORID,UNIT_COST,UNITS_REQ,DEVIATED_DATE,ORDER_RELEASE_DATE,' +
                                                        ' VAT,EXCISE,CST,PAYMENT_TERMS_CODE,ORDER_VALUE,PACKING_COST,ORDER_LINE_NO,SERVICE_AMOUNT,' +
                                                        'INSURANCE_VALUE,FRIEGHT_CHARGES,ADD_DUTY,DEPT_WISE,ACTINACT)' +
                                                        'values (seq_Purchase_ID.nextval,''' + PurchLine."Document No." + ''', ''' + PurchLine."No." + ''',''' +
                                                        Rec."Buy-from Vendor No." + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Unit_Cost, 0.001))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(PurchLine.Quantity)) + ''',''' +
                                                        FORMAT(PurchLine."Deviated Receipt Date", 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        FORMAT(DT2DATE(Rec."Release Date Time"), 0, '<Day>-<Month Text,3>-<Year4>') + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(VAT_AMOUNT, 0.01))) + ''',''' +
                                                        //Rec.CommaRemoval(FORMAT(ROUND(PurchLine."Excise Amount", 0.01))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(CST_AMOUNT, 0.01))) + ''',''' +
                                                        FORMAT(Rec."Payment Terms Code") + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Line_Amount, 0.001))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND("Packing Value", 0.001))) + ''',''' +
                                                        FORMAT(PurchLine."Line No.") + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Service_Amount, 0.01))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Insurance_Value, 0.01))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Frieght_Value, 0.01))) + ''',''' +
                                                        Rec.CommaRemoval(FORMAT(ROUND(Additional_Duty, 0.01))) + ''',''' +
                                                        Dept + ''',1)');
                    //  MESSAGE(FORMAT(ROUND(Line_Amount,0.001)));
                END;
            UNTIL PurchLine.NEXT = 0;

        Mails;

    end;


    procedure Mails();
    var
        Lpurchase: Record "Purchase Header";
    begin
        /*
        Mail_From:='ERP@efftronics.com';
        
        IF UPPERCASE(USERID) IN ['EFFTRONICS\MNRAJU','EFFTRONICS\RAKESHT'] THEN
        Mail_To:='mnraju@efftronics.com,rakesht@efftronics.com'
        ELSE
        Mail_To:='purchase@efftronics.com,ramkumarl@efftronics.com,anilkumar@efftronics.com';
        
        //Mail_To:=VENDOR."E-Mail";
        fname:='';
        str:='';
        
        flag:=FALSE;
        
        IF (Mail_Sent=FALSE) THEN
        BEGIN
          IF (DIALOG.CONFIRM('Send Mail to: '+Mail_To)) THEN
            flag:=TRUE;
        END
        ELSE IF(Mail_Sent=TRUE) THEN
        BEGIN
          IF  (DIALOG.CONFIRM('Resend Mail to: '+Mail_To)) THEN
          BEGIN
            flag:=TRUE;
          END;
        END;
        
        
        IF flag=TRUE THEN
        BEGIN
          str:="No.";
          PurchaseHeader.SETFILTER(PurchaseHeader."No.","No.");
          WHILE STRPOS(str,'/') > 1 DO BEGIN
            fname:=fname+COPYSTR(str,1,STRPOS(str,'/')-1)+'_';
            str := COPYSTR(str,STRPOS(str,'/') + 1);
          END;
          fname:=fname+str;
        
          IF ISCLEAR(Bullzippdf) THEN
          CREATE(Bullzippdf,FALSE,TRUE); //Rev01
          //CREATE(Bullzippdf); //Rev01
        
          FileDirectory :='\\erpserver\ErpAttachments\PurchaseOrders\';
          Window.OPEN('PREPARING THE REPORT');
          FileName :=fname+'.pdf';
          Bullzippdf.Init;
          Bullzippdf.LoadSettings;
          RunOnceFile := Bullzippdf.GetSettingsFileName(TRUE);
          Bullzippdf.SetValue('Output',FileDirectory+FileName);
          Bullzippdf.SetValue('Showsettings', 'never');
          Bullzippdf.SetValue('ShowPDF', 'no');
          Bullzippdf.SetValue('ShowProgress', 'no');
          Bullzippdf.SetValue('ShowProgressFinished', 'no');
          Bullzippdf.SetValue('SuppressErrors', 'yes');
          Bullzippdf.SetValue('ConfirmOverwrite', 'no');
          Bullzippdf.WriteSettings(TRUE);
        
          REPORT.RUNMODAL(50058,FALSE,FALSE,PurchaseHeader);
          TimeOut := 0;
        
          WHILE EXISTS(RunOnceFile) AND (TimeOut < 10) DO
          BEGIN
            SLEEP(2000);
            TimeOut := TimeOut + 1;
          END;
          Window.CLOSE;
        
          attachment:=FileDirectory+FileName;
          Subject:='Reg : Purchase order - '+str;
          Body:='<HTML><BODY>Dear Sir,<BR>';
          Body+='<BR><PRE>  Please find the attachment for purchase order and arrange the material at the earliest</PRE>';
          Body+='<PRE><B>and send the order acknowledgment by return mail (without fail ).</B></PRE>';
          Body+='<PRE>             ****  Automatic Mail Generated From ERP  ****</PRE></BODY></HTML>';
        
          SMTP_MAIL.CreateMessage('EFF',Mail_From,Mail_To,Subject,Body,TRUE);
          SMTP_MAIL.AddAttachment(attachment);
          SMTP_MAIL.Send;
          //SLEEP(5000);
        
        
          IF PurchaseHeader.FINDFIRST THEN
          REPEAT
            PurchaseHeader.Mail_Sent:=TRUE;
            PurchaseHeader.MODIFY;
          UNTIL PurchaseHeader.NEXT=0;
        
          MESSAGE('Mail has been Sent');
        END;
        */

    end;



}

