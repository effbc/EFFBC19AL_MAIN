codeunit 60023 itemsubgroupcode
{



    trigger OnRun();
    begin
        productionorder.SETFILTER("Prod Start date", '>=%1', TODAY);
        IF productionorder.FINDSET THEN
            REPEAT
                "Prod. Order Component".SETCURRENTKEY("Prod. Order Component"."Prod. Order No.",
                                                      "Prod. Order Component"."Item No.",
                                                      "Prod. Order Component"."Material Required Day");

                "Prod. Order Component".SETRANGE("Prod. Order No.", productionorder."No.");
                IF "Prod. Order Component".FINDSET THEN BEGIN
                    REPEAT
                        IF productionorder."Prod Start date" > 0D THEN BEGIN
                            IF "Prod. Order Component"."Material Required Day" <> 99 THEN BEGIN
                                "Prod. Order Component"."Production Plan Date" := productionorder."Prod Start date";
                                "Prod. Order Component".MODIFY;
                            END ELSE BEGIN
                                "Prod. Order Component"."Production Plan Date" := productionorder."Planned Dispatch Date";
                                "Prod. Order Component".MODIFY;
                            END;
                        END ELSE BEGIN
                            "Prod. Order Component"."Production Plan Date" := 0D;
                            "Prod. Order Component".MODIFY;
                        END;
                    UNTIL "Prod. Order Component".NEXT = 0;
                END;

            UNTIL productionorder.NEXT = 0;

        /*
        PBML.SETFILTER(PBML."Quantity per",'>%1',0);
        IF PBML.FINDSET THEN
        REPEAT
          PBML.Quantity:=PBML."Quantity per";
          PBML.MODIFY;
        UNTIL PBML.NEXT=0;  */
        // Plan_Change.Update_Sale_Order_Info;
        //ITEM_LOT_NUMBERS.SETRANGE(ITEM_LOT_NUMBERS.Authorisation,1);
        //IF ITEM_LOT_NUMBERS.FINDSET THEN
        //  ITEM_LOT_NUMBERS.MODIFYALL(ITEM_LOT_NUMBERS.Authorisation,3);
        //MESSAGE(FORMAT(DATE2DMY(WORKDATE,3)));
        /*
        "Material Issues Line".SETFILTER("Material Issues Line"."Quantity Received",'>%1',0);
        IF "Material Issues Line".FINDSET THEN
        REPEAT
          IF "Material Issues Line".Quantity="Material Issues Line"."Quantity Received" THEN
          BEGIN
            "Tracking Specification".RESET;
            "Tracking Specification".SETRANGE("Tracking Specification"."Order No.","Material Issues Line"."Document No.");
            "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.","Material Issues Line"."Line No.");
            IF "Tracking Specification".FINDSET THEN
              "Tracking Specification".DELETEALL;
         END;
        UNTIL "Material Issues Line".NEXT=0;
        */
        /*
        IF PBML.FINDFIRST THEN
        REPEAT
         // IF item.GET(PBML."No.") THEN
         // BEGIN
            //IF item."Product Group Code"='CPCB' THEN
            //BEGIN
              IF PBMH.GET(PBML."No.") THEN
              BEGIN
                PBML."No. of Soldering Points":=PBMH."Total Soldering Points"*PBML."Quantity per";
                PBML."No. of SMD Points":=PBMH."Total Soldering Points SMD"*PBML."Quantity per";
                PBML."No. of DIP Point":=PBMH."Total Soldering Points DIP"*PBML."Quantity per";
                PBML.MODIFY;
              END;
            //END;
         // END;
        UNTIL PBML.NEXT=0;
        
        
        IF PBMH.FINDSET THEN
        REPEAT
          PBMH."Total Soldering Points SMD":=0;
          PBMH."Total Soldering Points DIP":=0;
          PBMH."Total Soldering Points":=0;
          IF item.GET(PBMH."No.") THEN
          BEGIN
            IF (item."Product Group Code"='FPRODUCT') THEN
            BEGIN
              PBML.RESET;
              PBML.SETRANGE(PBML."Production BOM No.",PBMH."No.");
              IF PBML.FINDSET THEN
              REPEAT
                PBMH."Total Soldering Points SMD"+=PBML."No. of SMD Points";
                PBMH."Total Soldering Points DIP"+=PBML."No. of DIP Point";
                PBMH."Total Soldering Points"+=PBML."No. of Soldering Points";
              UNTIL PBML.NEXT=0;
        
            END ELSE
            BEGIN
              PBML.RESET;
              PBML.SETRANGE(PBML."Production BOM No.",PBMH."No.");
              IF PBML.FINDSET THEN
              REPEAT
                IF PBML."Type of Solder"=PBML."Type of Solder"::SMD THEN
                  PBMH."Total Soldering Points SMD"+=PBML."No. of Soldering Points";
               IF PBML."Type of Solder"=PBML."Type of Solder"::DIP THEN
                  PBMH."Total Soldering Points DIP"+=PBML."No. of Soldering Points";
                PBMH."Total Soldering Points"+=PBML."No. of Soldering Points";
              UNTIL PBML.NEXT=0;
            END;
            PBMH.MODIFY;
        
          END;
        
        UNTIL PBMH.NEXT=0;
        */

        /*
        WINDOW.OPEN(T1);
        PBMH.RESET;
        item.SETRANGE(item."Product Group Code",'CPCB');
        IF item.FINDSET THEN
        REPEAT
          IF PBMH.GET(item."No.") THEN
          BEGIN
            IF  PBMH.Status = PBMH.Status ::Certified THEN
            BEGIN
        
              WINDOW.UPDATE(1,PBMH."No.");
              PBMH.VALIDATE(PBMH.Status,PBMH.Status::Certified);
              PBMH.MODIFY;
            END;
          END;
        UNTIL item.NEXT=0;
        WINDOW.CLOSE;
         */


        /*
        TESTFILE.CREATE('\\eff-cpu-222\erp\Item_Detials.xml');
        TESTFILE.OPEN('\\eff-cpu-222\erp\Item_Detials.xml');
        item.SETFILTER(item."Product Group Code",'<>%1&<>%2','FPRODUCT','CPCB');
        item.SETRANGE(item.Blocked,FALSE);
        TESTFILE.CREATEOUTSTREAM(ITEM_STREAM);
        XMLPORT.EXPORT(60001,ITEM_STREAM,item);
        TESTFILE.CLOSE;
         */




        //MESSAGE(FORMAT(Financial_Year));
        //MESSAGE(FORMAT(DMY2DATE(26,8,2010)));
        //MESSAGE(FORMAT(CLOSINGDATE(TODAY)));
        /*
        IF "Material Issues Header".FINDSET THEN
        REPEAT
          "Material Issues Line".RESET;
          "Material Issues Line".SETRANGE("Material Issues Line"."Document No.","Material Issues Header"."No.");
          "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive",'>%1',0);
          IF NOT "Material Issues Line".FINDFIRST THEN
            "Material Issues Header".Rejected:=TRUE;
            "Material Issues Header".MODIFY;
        UNTIL "Material Issues Header".NEXT=0;
         */
        /*
        
        //SERVICE_ITEM.SETRANGE("No.",'SI-CST-08-09-001100');
        //
        //SERVICE_ITEM.SETRANGE(SERVICE_ITEM."Item No.",'BOIMODE00014');
        SERVICE_ITEM.SETFILTER(SERVICE_ITEM."Present Location",'<>%1','');
        IF SERVICE_ITEM.FINDSET THEN
        REPEAT
          "Item Ledger Entry".RESET;
          "Item Ledger Entry".SETCURRENTKEY("Item No.","Lot No.","Serial No.");
          "Item Ledger Entry".SETRANGE("Item No.",SERVICE_ITEM."Item No.");
          "Item Ledger Entry".SETRANGE("Serial No.",SERVICE_ITEM."Serial No.");
          "Item Ledger Entry".SETRANGE("Item Ledger Entry".Open,TRUE);
          "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity",'>%1',0);
          IF "Item Ledger Entry".FINDLAST THEN
          BEGIN
            IF ("Item Ledger Entry"."Location Code"='SITE')  THEN
            BEGIN
              DV.RESET;
              DV.SETRANGE(DV."Dimension Code",'LOCATIONS');
              DV.SETRANGE(DV.Code,"Item Ledger Entry"."Global Dimension 2 Code");
              IF DV.FINDFIRST THEN
              BEGIN
                SERVICE_ITEM."Present Location":=DV.Name;
                SERVICE_ITEM.MODIFY;
              END ELSE
              BEGIN
                SERVICE_ITEM."Present Location":='';
                SERVICE_ITEM.MODIFY;
              END;
            END ELSE
            BEGIN
              SERVICE_ITEM."Present Location":='';
              SERVICE_ITEM.MODIFY;
            END;
          END ELSE
          BEGIN
            SERVICE_ITEM."Present Location":='';
            SERVICE_ITEM.MODIFY;
          END;
        
        UNTIL SERVICE_ITEM.NEXT=0;
        */
        /*
        SH.RESET;
        SH.SETFILTER(SH."Document Type",'%1|%2',SH."Document Type"::Order,SH."Document Type"::Amc);
        SH.SETRANGE(SH."No.",'EFF/SAL/10-11/029');
        IF SH.FINDFIRST THEN
        BEGIN
        
           REPORT.RUN(50159,FALSE,FALSE,SH);
           REPORT.SAVEASHTML(50159,'\\erpserver\ErpAttachments\order2.html',FALSE,SH);
           //Attachment1:='\\erpserver\ErpAttachments\order.html';
        END;
        
        */

        /*
        USER_SETUP.SETFILTER(USER_SETUP."Allow Posting To",'<>%1',0D);
        IF USER_SETUP.FINDSET THEN
        REPEAT
          USER_SETUP."Allow Posting To":=TODAY;
          USER_SETUP.MODIFY;
        UNTIL USER_SETUP.NEXT=0;
        */
        /*
        "Material Issues Header".SETRANGE("Transfer-from Code",'R&D STR');
        "Material Issues Header".SETRANGE(Status,"Material Issues Header".Status::Released);
        "Material Issues Header".SETRANGE("Released Date",WORKDATE);
        IF "Material Issues Header".FINDSET THEN
        REPEAT
          "Material Issues Header".VALIDATE(Status,"Material Issues Header".Status::Released);
          "Material Issues Header".VALIDATE("Released Date",DT2DATE("Material Issues Header"."Creation DateTime"));
          "Material Issues Header".VALIDATE("Released Time",TIME);
          "Material Issues Header".VALIDATE("Released By",USERID);
          "Material Issues Header"."Posting Date":=TODAY;
          IF "Material Issues Header"."Authorized Date"=0D THEN
             "Material Issues Header"."Authorized Date":=TODAY;
          "Material Issues Header".MODIFY;
        UNTIL "Material Issues Header".NEXT=0;
        */







        /*
        "Material Issues Line".SETFILTER("Material Issues Line"."Prod. Order No.",'%1','');
        IF "Material Issues Line".FINDSET THEN
        REPEAT
          "Material Issues Header".RESET;
          "Material Issues Header".SETRANGE("Material Issues Header"."No.","Material Issues Line"."Document No.");
          IF "Material Issues Header".FINDFIRST THEN
          BEGIN
            "Material Issues Line"."Prod. Order No.":="Material Issues Header"."Prod. Order No.";
            "Material Issues Line"."Prod. Order Line No.":="Material Issues Header"."Prod. Order Line No.";
            "Material Issues Line".MODIFY;
          END;
        UNTIL "Material Issues Line".NEXT=0;
         */
        /*
        "Material Issues Header".SETRANGE("Material Issues Header".Status,"Material Issues Header".Status::Released);
        "Material Issues Header".SETRANGE("Material Issues Header"."Transfer-from Code",'STR');
        "Material Issues Header".SETRANGE("Material Issues Header".Rejected,TRUE);
        MESSAGE(FORMAT("Material Issues Header".COUNT));
        IF "Material Issues Header".FINDSET THEN
        REPEAT
          "Material Issues Line".RESET;
          "Material Issues Line".SETRANGE("Material Issues Line"."Document No.","Material Issues Header"."No.");
          IF "Material Issues Line".FINDSET THEN
          REPEAT
            "Material Issues Line".DELETE;
          UNTIL "Material Issues Line".NEXT=0;
          "Material Issues Header".DELETE;
          "Tracking Specification".RESET;
          "Tracking Specification".SETRANGE("Tracking Specification"."Order No.","Material Issues Header"."No.");
          IF "Tracking Specification".FINDSET THEN
          REPEAT
            "Tracking Specification".DELETE;
          UNTIL "Tracking Specification".NEXT=0;
        UNTIL "Material Issues Header".NEXT=0;*/

        /*
        IF item.FINDSET THEN
        REPEAT
          item."Used In DL":=FALSE;
          item."Used In MFEP":=FALSE;
          item."Used In RTU":=FALSE;
          item."Used In PMU":=FALSE;
          item.MODIFY;
        UNTIL item.NEXT=0; */

        /*
        IF "PRODUCT WISE ITEMS".FINDSET THEN
        REPEAT
          IF item.GET("PRODUCT WISE ITEMS"."Item No.") THEN
          BEGIN
            IF "PRODUCT WISE ITEMS"."Product Type"='DL' THEN
              item."Used In DL":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='FEP' THEN
              item."Used In MFEP":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='RTU' THEN
              item."Used In RTU":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='PMU' THEN
              item."Used In PMU":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='BMU' THEN
              item."Used In BMU":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='IPIS' THEN
              item."Used In IPIS":=TRUE;
        
            IF "PRODUCT WISE ITEMS"."Product Type"='PROTOCAL CONVERTER' THEN
              item."Used In PC":=TRUE;
        
            IF "PRODUCT WISE ITEMS"."Product Type"='SIGNAL LAMP' THEN
              item."Used In SIG.LMP":=TRUE;
            IF "PRODUCT WISE ITEMS"."Product Type"='SSIDL' THEN
              item."Used In SSIDL":=TRUE;
            item.MODIFY;
          END;
        
        UNTIL "PRODUCT WISE ITEMS".NEXT=0;
         */
        /*
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Location Code",
                                          "Item Ledger Entry"."Global Dimension 2 Code",
                                          "Item Ledger Entry"."Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Location Code",'SITE');
        
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity",'>%1',0);
        IF "Item Ledger Entry".FINDSET THEN
        MESSAGE(FORMAT("Item Ledger Entry".COUNT));
        REPEAT
            "Item Wise Min. Req. Qty at Loc".RESET;
            "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                     "Item Ledger Entry"."Global Dimension 2 Code");
            "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item,"Item Ledger Entry"."Item No.");
            IF NOT("Item Wise Min. Req. Qty at Loc".FINDFIRST ) THEN
            BEGIN
              "Item Wise Min. Req. Qty at Loc".INIT;
              "Item Wise Min. Req. Qty at Loc".Location:="Item Ledger Entry"."Global Dimension 2 Code";
              "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Location,
                                                        "Item Ledger Entry"."Global Dimension 2 Code");
              "Item Wise Min. Req. Qty at Loc".Item:="Item Ledger Entry"."Item No.";
              "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Item,"Item Ledger Entry"."Item No.");
              "Item Wise Min. Req. Qty at Loc"."Base Location":='SITE';
              "Item Wise Min. Req. Qty at Loc".INSERT;
            END;
        
        UNTIL "Item Ledger Entry".NEXT=0;
        */
        /*
        "Shortage Details".SETRANGE("Shortage Details".Authorisation,"Shortage Details".Authorisation::WAP);
        //"Shortage Details".SETRANGE("Shortage Details".Authorisation,"Shortage Details".Authorisation::Authorised);
        IF "Shortage Details".FINDSET THEN
        REPEAT
          "Shortage Details".Authorisation:="Shortage Details".Authorisation::Authorised;
          "Shortage Details".MODIFY;
        UNTIL "Shortage Details".NEXT=0;  */
        /*
        IF USER.FINDSET THEN
        REPEAT
          IF NOT USER_SETUP.GET(USER."User ID") THEN
          BEGIN
            USER.INIT;
            USER_SETUP."User ID":=USER."User ID";
            PMIH.RESET;
            PMIH.SETRANGE(PMIH."User ID",USER."User ID");
            IF PMIH.FINDLAST THEN
            BEGIN
              USER_SETUP."Transfer- From Code":=PMIH."Transfer-from Code";
              USER_SETUP."Transfer- To Code":=PMIH."Transfer-to Code";
              USER_SETUP."Production Order":=PMIH."Prod. Order No.";
            END;
            USER_SETUP.INSERT;
          END;
        UNTIL USER.NEXT=0;
         */
        /*
        FOR i:=1 TO 10 DO
        BEGIN
          RANDOMIZE(i);
          A[i]:=i;
        END;*/

    end;

    var
        productionorder: Record "Production Order";
        item: Record Item;
        "Material Issues Header": Record "Material Issues Header";
        "Material Issues Line": Record "Material Issues Line";
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "PRODUCT WISE ITEMS": Record "Product wise Items";
        "Item Ledger Entry": Record "Item Ledger Entry";
        ILE: Record "Item Ledger Entry";
        "Shortage Details": Record "Item Lot Numbers";
        i: Integer;
        A: array[10] of Integer;
        USER: Record User;
        USER_SETUP: Record "User Setup";
        PMIH: Record "Posted Material Issues Header";
        IRH: Record "Inspection Receipt Header";
        "Prod. Order Component": Record "Prod. Order Component";
        SH: Record "Sales Header";
        SERVICE_ITEM: Record "Service Item";
        DV: Record "Dimension Value";
        "Item Wise Min. Req. Qty at Loc": Record "Item Wise Min. Req. Qty at Loc";
        TESTFILE: File;
        ITEM_STREAM: OutStream;
        PBMH: Record "Production BOM Header";
        WINDOW: Dialog;
        T1: Label 'CERTIYING BOM''S  #1##############';
        PBML: Record "Production BOM Line";
        ITEM_LOT_NUMBERS: Record "Item Lot Numbers";
        Plan_Change: Codeunit "Plan Change";


    procedure Financial_Year() Fin_Year: Integer;
    begin
        IF DATE2DMY(WORKDATE, 2) > 3 THEN
            Fin_Year := DATE2DMY(WORKDATE, 3)
        ELSE
            Fin_Year := DATE2DMY(WORKDATE, 3) - 1;
    end;
}

