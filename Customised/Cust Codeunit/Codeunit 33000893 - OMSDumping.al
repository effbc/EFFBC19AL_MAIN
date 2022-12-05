codeunit 33000893 OMSDumping
{

    trigger OnRun();
    begin
        MESSAGE('test');
        /*
        //Added by Pranavi on 27-06-2015 for forwarding Sale orders to OMS
        charline:=10;
        Mail_Subject:='Test Mail from OMS Dumping';
        To_mail:='pranavi@efftronics.com';
        From_Mail:='erp@efftronics.com';
        Mail_Body:='';
        {
        Mail_Body:=Mail_Body+'Hi'+FORMAT(charline);
        //Mail_Body+=FORMAT(charline);
        Mail_Body+='***** Auto Mail Generated From ERP *****';
        SMTP_Mail.CreateMessage('Pranavi',From_Mail,To_mail,Mail_Subject,Mail_Body,FALSE);
        SMTP_Mail.Send;
        Mail_Body:='';
        }
        SMTP_Mail.CreateMessage('Pranavi',From_Mail,To_mail,Mail_Subject,Mail_Body,FALSE);
        //SMTP_Mail.AppendBody('<html><body>');
        {
        IF GUIALLOWED THEN
          MESSAGE('Testing!');
        }
        OCount:=0;
        Orders:='';
        //items:='EFF/SAL/14-15/431&EFF/SAL/15-16/L00046';
        SH.RESET;
        SH.SETCURRENTKEY("Document Type","No.");
        SH.SETRANGE(SH."Document Type",SH."Document Type"::Order);
        //SH.SETFILTER(SH."Document Type",'%1|%2',SH."Document Type"::Order,SH."Document Type"::"Blanket Order");
        SH.SETRANGE(SH.Status,SH.Status::Released);
        //SH.SETFILTER(SH."No.",'%1|%2','EFF/SAL/*','EFF/EXP/*');
        IF SH.FINDSET THEN
        BEGIN
        REPEAT
          {
          contn:=FALSE;
          IF  ((COPYSTR(SH."No.",5,3) = 'EXP') AND (SH."Sale Order Created" = FALSE)) OR ((COPYSTR(SH."No.",5,3) = 'SAL')) THEN
             contn:=TRUE;
          }
          IF {contn=TRUE THEN }NOT (SH."No." IN ['SAL/15-16/L00046']) THEN
          BEGIN
          ChngLogEntry.RESET;
          ChngLogEntry.SETCURRENTKEY("Entry No.");
          ChngLogEntry.SETFILTER(ChngLogEntry."Primary Key Field 2 Value",FORMAT(SH."No."));
          //ChngLogEntry.SETFILTER(ChngLogEntry."Field No.",'<>%1|%2|%3',60016,60017,60117);
          IF ChngLogEntry.COUNT>0 THEN
          BEGIN
            SL.RESET;
            SL.SETRANGE("Document Type",SH."Document Type");
            SL.SETRANGE("Document No.",SH."No.");
            IF SL.FINDFIRST THEN
            BEGIN
              IF (OMSIntegrateCode.SaleOrderCreationinOMS(SH)) =FALSE THEN
              BEGIN
                IF GUIALLOWED THEN
                  MESSAGE('Error occured in OMS integration and record is not posted for order'+FORMAT(SH."No."));
              END
              ELSE  BEGIN
                OCount:=OCount+1;
               // Orders:=Orders+SH."No.";
                SMTP_Mail.AppendBody(SH."No."+', '+FORMAT(charline));
              END;
            END;
          END;
          END;
        UNTIL SH.NEXT=0;
        END;
        IF GUIALLOWED THEN
          MESSAGE('Total '+FORMAT(SH.COUNT)+' orders are Released!');
        IF GUIALLOWED THEN
          MESSAGE('Total '+FORMAT(OCount)+' orders are forwarded to OMS!');
        //MESSAGE('Orders are'+Orders);
        //End by Pranavi
        //Mail_Body:=Mail_Body+FORMAT(OCount)+FORMAT(charline)+Orders;
        SMTP_Mail.AppendBody('Forwarded Orders: '+FORMAT(OCount)+', Total Orders:'+FORMAT(SH.COUNT));
        SMTP_Mail.Send;
        */

    end;

    var
        OCount: Integer;
        Orders: Text[1024];
        ChngLogEntry: Record "Change Log Entry";
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        OMSIntegrateCode: Codeunit SQLIntegration;
        //Mail: Codeunit Mail;
        Mail_Body: Text;
        Mail_Subject: Text[1000];
        From_Mail: Text[250];
        To_mail: Text[250];
        //  SMTP_Mail: Codeunit "SMTP Mail";
        SMTPSETUP: Record "SMTP SETUP";
        charline: Char;
        items: Code[100];
        contn: Boolean;


    procedure ItemReclass();
    var
        IJL: Record "Item Journal Line";
        NIJL: Record "Item Op Balance";
        Window: Dialog;
        Item: Record Item;
        ItemGRec: Record Item;
        SkipLoop: Boolean;
        ErrorText: Text[250];
        ItemUOM: Record "Item Unit of Measure";
        LocationGRec: Record Location;
        EntryNoGVar: Integer;
        ReservationEntry: Record "Reservation Entry";
        LastReservEntryNo: Integer;
        ItemGRec2: Record Item;
    begin
        IF NOT CONFIRM('Do you want to insert the item journal lines?', FALSE) THEN
            EXIT;
        Window.OPEN('#1###############');

        ReservationEntry.RESET;
        ReservationEntry.SETRANGE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.SETRANGE("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
        ReservationEntry.SETRANGE("Source ID", 'RECLASS');
        ReservationEntry.SETRANGE("Source Batch Name", 'DEFAULT');
        ReservationEntry.DELETEALL;

        ReservationEntry.RESET;
        IF ReservationEntry.FINDLAST THEN
            LastReservEntryNo := ReservationEntry."Entry No." + 1
        ELSE
            LastReservEntryNo := 1;

        IJL.RESET;
        IJL.SETRANGE(IJL."Journal Template Name", 'RECLASS');
        IJL.SETRANGE(IJL."Journal Batch Name", 'DEFAULT');
        IJL.DELETEALL;

        NIJL.FIND('-');
        REPEAT
            CLEAR(SkipLoop);
            CLEAR(ErrorText);
            Window.UPDATE(1, NIJL."Line No");
            IF NOT ItemGRec.GET(NIJL."No.") THEN BEGIN
                ErrorText += 'Item No.,';
                SkipLoop := TRUE;
            END;
            IF NOT ItemUOM.GET(NIJL."No.", NIJL.UOM) THEN BEGIN
                ErrorText += 'Item UOM,';
                SkipLoop := TRUE;
            END;
            IF NOT LocationGRec.GET(NIJL.Location) THEN BEGIN
                ErrorText += 'Location,';
                SkipLoop := TRUE;
            END;

            IF NOT SkipLoop THEN BEGIN
                IJL.INIT;
                IJL.VALIDATE(IJL."Journal Template Name", 'RECLASS');
                IJL.VALIDATE(IJL."Journal Batch Name", 'DEFAULT');
                IJL.VALIDATE(IJL."Line No.", NIJL."Line No");
                IJL.INSERT(TRUE);

                IJL.VALIDATE(IJL."Posting Date", NIJL."Posting Date");
                IJL.VALIDATE(IJL."Document Date", NIJL."Document Date");
                IJL.VALIDATE("Entry Type", NIJL."Entry Type");
                IJL.VALIDATE(IJL."Document No.", NIJL."Document No.");
                IJL.VALIDATE(IJL."Item No.", NIJL."No.");
                IJL.VALIDATE("Entry Type", IJL."Entry Type"::Transfer);
                IJL.VALIDATE(IJL."Location Code", NIJL.Location);
                //IJL.VALIDATE(IJL."Inventory Posting Group",NIJL.IPG);
                //IJL.VALIDATE(IJL."Gen. Prod. Posting Group",NIJL.GPPG);
                IJL.VALIDATE(IJL."Unit of Measure Code", NIJL.UOM);
                IJL.VALIDATE(IJL."Location Code", NIJL.Location);
                IJL.VALIDATE(IJL.Quantity, NIJL.Quantity);
                EntryNoGVar := 0;
                IJL.VALIDATE(IJL."Unit Cost", NIJL."Unit Cost");
                IJL.VALIDATE("Unit Amount", NIJL."Unit Cost");
                IJL.VALIDATE("New Location Code", NIJL."New Location");
                IJL.MODIFY(TRUE);

                ItemGRec2.GET(NIJL."No.");
                IF ItemGRec2."Item Tracking Code" <> '' THEN BEGIN
                    ReservationEntry.INIT;
                    ReservationEntry."Entry No." := LastReservEntryNo;
                    // ReservationEntry.VALIDATE(Positive,TRUE);
                    ReservationEntry.INSERT(TRUE);
                    ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                    ReservationEntry."Source Type" := DATABASE::"Item Journal Line";
                    ReservationEntry."Source Subtype" := 4;
                    ReservationEntry."Source ID" := 'RECLASS';
                    ReservationEntry."Source Batch Name" := 'DEFAULT';
                    ReservationEntry."Source Ref. No." := IJL."Line No.";
                    ReservationEntry.VALIDATE("Item No.", NIJL."No.");
                    ReservationEntry.Description := 'Item Reclassfication';
                    ReservationEntry.VALIDATE("Location Code", NIJL.Location);
                    ReservationEntry.VALIDATE("Lot No.", NIJL."Lot No.");
                    ReservationEntry.VALIDATE("Serial No.", NIJL."Serial No.");
                    ReservationEntry.VALIDATE("New Lot No.", NIJL."Lot No.");
                    ReservationEntry.VALIDATE("New Serial No.", NIJL."Serial No.");
                    ReservationEntry.VALIDATE("Quantity (Base)", -NIJL.Quantity);
                    ReservationEntry.MODIFY(TRUE);
                    LastReservEntryNo += 1;
                END;
                // IJL.VALIDATE("Shortcut Dimension 1 Code",NIJL."Shortcut Dimension 1 Code");
                NIJL.Inserted := TRUE;

            END;
            NIJL."Error Text" := ErrorText;
            NIJL.MODIFY;
        UNTIL NIJL.NEXT = 0;
    end;
}

