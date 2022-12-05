codeunit 80008 "IJL Validate"
{

    trigger OnRun();
    begin
        /*
          "Purch. Inv. Line".SETFILTER("Purch. Inv. Line"."Receipt No.",'<>%1','');
       IF "Purch. Inv. Line".FINDFIRST THEN
       REPEAT
         "Purch. rcpt. header".RESET;
         "Purch. rcpt. header".SETRANGE("Purch. rcpt. header"."No.","Purch. Inv. Line"."Receipt No.");
         IF "Purch. rcpt. header".FINDFIRST THEN
         BEGIN
           "Purch. Inv. Line"."Purchase_Order No.":="Purch. rcpt. header"."Order No.";
           "Purch. Inv. Line".MODIFY;
         END;
       UNTIL "Purch. Inv. Line".NEXT=0;
         */
        /*
      "Purchase Header".SETRANGE("Purchase Header"."Document Type","Purchase Header"."Document Type"::Order);
      "Purchase Header".SETFILTER("Purchase Header"."Order Date",'>%1',122709D);
      "Purchase Header".SETRANGE("Purchase Header".Status,"Purchase Header".Status::Released);
      "Purchase Header".SETFILTER("Purchase Header".Structure,'<>%1','');
      IF "Purchase Header".FINDFIRST THEN
      REPEAT
        "Purchase Line".CalculateStructures("Purchase Header");
        COMMIT;
      UNTIL "Purchase Header".NEXT=0;
      */
        /*
        IF IJL.FINDFIRST THEN
        REPEAT
         IJL.VALIDATE(IJL."Journal Template Name", 'ITEM');
         IJL.VALIDATE(IJL."Journal Batch Name", 'IJNL-OPNB');
         IJL.VALIDATE(IJL."Posting Date",033107D);
         IJL.VALIDATE(IJL."Document No.",'OPIJN-00001');
         IJL.VALIDATE(IJL."Item No.");
         IJL.VALIDATE(IJL."Entry Type",IJL."Entry Type"::"Positive Adjmt.");
         IJL.VALIDATE( IJL.Quantity);
         IJL.VALIDATE(IJL."Location Code");
         IJL.VALIDATE(IJL."Unit of Measure Code");
         IJL.VALIDATE(IJL."Qty. per Unit of Measure");
        UNTIL IJL.NEXT=0;
        
        MESSAGE('Completed');  */
        /*
        "Indent Line".SETFILTER("Indent Line"."Document No.",'IND*');
        "Indent Line".SETRANGE("Indent Line"."Indent Status","Indent Line"."Indent Status"::Indent);
        IF "Indent Line".FINDFIRST THEN
        REPEAT
          "Indent Line"."Indent Status":="Indent Line"."Indent Status"::Order;
          "Indent Line".MODIFY;
        UNTIL "Indent Line".NEXT=0;
        */
        MESSAGE(FORMAT(PID.COUNT));
        /*
         Location.VALIDATE(Location."Put-away Template Code");
         Location.VALIDATE(Location."Purch. Invoice Nos.");
         Location.VALIDATE(Location."Purch. Receipt Nos.");
         Location.VALIDATE(Location."Sales Invoice Nos.");
         Location.VALIDATE(Location."Sales Shipment Nos.");
         //Location.VALIDATE(Location.Bonded);
         Location.VALIDATE(Location."Excise Bus. Posting Group");
         Location.VALIDATE(Location."E.C.C. No.");
         Location.VALIDATE(Location."C.E. Regd No.");
         Location.VALIDATE(Location."C.E. Range");
         Location.VALIDATE(Location."C.E. Commissionerate");
         Location.VALIDATE(Location."C.E. Division");
         Location.VALIDATE(Location.State);
         Location.VALIDATE(Location."Subcontracting Location");
         Location.VALIDATE(Location."Subcontractor No.");
         Location.MODIFY(TRUE);
         UNTIL Location.NEXT=0;
         END;
         */


        /*
        
        IF Vendor.FINDFIRST THEN
        REPEAT
          "Purchase Header".RESET;
          "Purchase Header".SETCURRENTKEY("Purchase Header"."Document Type",
                                          "Purchase Header"."Buy-from Vendor No.",
                                          "Purchase Header"."No.");
        
          "Purchase Header".SETRANGE("Purchase Header"."Document Type","Purchase Header"."Document Type"::Order);
          "Purchase Header".SETRANGE("Purchase Header"."Buy-from Vendor No.",Vendor."No.");
          "Purchase Header".SETFILTER("Purchase Header"."Order Date",'<>%1',0D);
           IF "Purchase Header".FINDFIRST THEN
           BEGIN
             Vendor."First Order Date":="Purchase Header"."Order Date";
             Vendor.MODIFY;
           END;
        UNTIL Vendor.NEXT=0;
         */
        /*
        PostedMaterialIssuesHeader.SETRANGE(PostedMaterialIssuesHeader."Posting Date",102409D);
        PostedMaterialIssuesHeader.SETRANGE(PostedMaterialIssuesHeader."Transfer-from Code",'STR');
        PostedMaterialIssuesHeader.SETFILTER(PostedMaterialIssuesHeader."Material Issue No.",'A*');
        IF PostedMaterialIssuesHeader.FINDFIRST THEN
        REPEAT
          MESSAGE('HI');
          ILE.RESET;
          ILE.SETCURRENTKEY(ILE."Document No.",
                            ILE."Item No.",
                            ILE."Posting Date");
          ILE.SETRANGE(ILE."Entry Type",ILE."Entry Type"::Transfer);
          ILE.SETRANGE(ILE."Document No.",PostedMaterialIssuesHeader."No.");
          IF ILE.FINDFIRST THEN
          REPEAT
            ILE."Posting Date":=PostedMaterialIssuesHeader."Posting Date";
            ILE.MODIFY;
        
          UNTIL ILE.NEXT=0;
        UNTIL PostedMaterialIssuesHeader.NEXT=0;
         */
        /*
        PID.SETRANGE(PID.Mismatch,TRUE);
        PID.SETRANGE(PID.Avb,TRUE);
        PID.SETRANGE(PID."Avb at Site",TRUE);
        
        PID.SETFILTER(PID."Entry No",'>%1',0);
        PID.SETFILTER(PID."Serial No.",'<>%1','');
        IF PID.FINDFIRST THEN
        REPEAT
          PID.Mismatch:=FALSE;
          PID.Avb:=FALSE;
          PID."Avb at Site":=FALSE;
          PID.Remain:=FALSE;
          IF ILE.GET(PID."Entry No") THEN
          BEGIN
            IF (ILE."Item No."=PID."Item No.")  AND (ILE."Serial No."=PID."Serial No.")   THEN
            BEGIN
              PID.Avb:=TRUE;
              IF ILE."Remaining Quantity">0 THEN
                PID.Remain:=TRUE
              ELSE
              BEGIN
                ILE.RESET;
                ILE.SETCURRENTKEY(ILE."Item No.",
                                  ILE."Lot No.",
                                  ILE."Serial No.");
                ILE.SETRANGE(ILE."Item No.",PID."Item No.");
                ILE.SETRANGE(ILE."Serial No.",PID."Serial No.");
                ILE.SETFILTER(ILE."Remaining Quantity",'>%1',0);
                IF ILE.FINDFIRST THEN
                BEGIN
                  PID.Avb:=TRUE;
                  PID.Remain:=TRUE;
                  IF ILE."Location Code"='SITE' THEN
                     PID."Avb at Site":=TRUE
                  ELSE BEGIN
                    PID."Present Location":=ILE."Location Code";
                      PID."Last Transaction Date":=ILE."Posting Date";
                  END;
                END;
        
              END;
              IF ILE."Location Code"='SITE' THEN
                PID."Avb at Site":=TRUE
              ELSE BEGIN
                PID."Present Location":=ILE."Location Code";
                  PID."Last Transaction Date":=ILE."Posting Date";
              END;
            END ELSE
            BEGIN
              PID.Mismatch:=TRUE;
              ILE.RESET;
              ILE.SETCURRENTKEY(ILE."Item No.",
                                ILE."Lot No.",
                                ILE."Serial No.");
              ILE.SETRANGE(ILE."Item No.",PID."Item No.");
              ILE.SETRANGE(ILE."Serial No.",PID."Serial No.");
              ILE.SETFILTER(ILE."Remaining Quantity",'>%1',0);
              IF ILE.FINDFIRST THEN
              BEGIN
                PID.Avb:=TRUE;
                PID.Remain:=TRUE;
        
                IF ILE."Location Code"='SITE' THEN
                BEGIN
                  PID."Avb at Site":=TRUE;
                  PID."Last Transaction Date":=ILE."Posting Date";
                END
                ELSE BEGIN
                  PID."Present Location":=ILE."Location Code";
                  PID."Last Transaction Date":=ILE."Posting Date";
                END;
              END;
        
            END;
          END;
          PID.MODIFY;
        UNTIL PID.NEXT=0;
         */
        /*
        // PID.SETRANGE(PID.Mismatch,FALSE);
        // PID.SETRANGE(PID.Avb,TRUE);
        // PID.SETRANGE(PID."Avb at Site",TRUE);
        PID.SETFILTER(PID."Entry No",'>%1',0);
        //PID.SETRANGE(PID."Latest Location",'SITE');
         IF PID.FINDFIRST THEN
         REPEAT
           PID."Latest Location":='';
           ILE.RESET;
           ILE.SETCURRENTKEY(ILE."Item No.",
                             ILE."Lot No.",
                             ILE."Serial No.");
           ILE.SETRANGE(ILE."Item No.",PID."Item No.");
           ILE.SETRANGE(ILE."Serial No.",PID."Serial No.");
           ILE.SETFILTER(ILE."Remaining Quantity",'>%1',0);
           IF ILE.FINDLAST THEN
           BEGIN
            // ILE."Location Code":='OLD STOCK';
             PID."Latest Location":=ILE."Location Code";
            // ILE. MODIFY
           END;
           PID.MODIFY;
         UNTIL PID.NEXT=0;
         */
        /*
        Item.SETFILTER(Item."No.",'<>%1','');
        IF Item.FINDFIRST THEN
        REPEAT
          IF Item."Used In DL" OR Item."Used In MFEP" OR Item."Used In RTU" OR Item."Used In PMU" THEN
          BEGIN
            Item.Qc_Item:=TRUE;
            Item.MODIFY;
          END;
        UNTIL Item.NEXT=0;
         */

        /*{
        "Service Item Line".SETFILTER("Service Item Line"."Service Item No.",'<>%1','');
        IF "Service Item Line".FINDFIRST THEN
        REPEAT
          "Service Item".RESET;
          "Service Item".SETRANGE("Service Item"."No.","Service Item Line"."Service Item No.");
          IF "Service Item".FINDFIRST THEN
          BEGIN
            IF  (("Service Item"."Item No."<>"Service Item Line"."Item No.") OR
                    ("Service Item Line"."Serial No."<>"Service Item"."Serial No.")) THEN
            BEGIN
              "Service Item".RESET;
              "Service Item".SETRANGE("Service Item"."Item No.","Service Item"."Serial No.");
              "Service Item".SETRANGE("Service Item"."Item No.","Service Item Line"."Item No.");
              "Service Item".SETRANGE("Service Item"."Serial No.","Service Item Line"."Serial No.");
              IF "Service Item".FINDLAST THEN
              BEGIN
                "Service Item Line"."Service Item No.":="Service Item"."No.";
                "Service Item Line".MODIFY;
              END;
            END;
          END;
        UNTIL "Service Item Line".NEXT=0;}
        */
        "Prod. Order Component".RESET;

        "Prod. Order Component".SETFILTER("Prod. Order Component"."Production Plan Date", '>%1', TODAY);
        IF "Prod. Order Component".FINDFIRST THEN BEGIN
            REPEAT
                "Production Order".RESET;
                "Production Order".SETRANGE("Production Order"."No.", "Prod. Order Component"."Prod. Order No.");
                IF "Production Order".FINDFIRST THEN BEGIN
                    IF "Production Order"."Prod Start date" > 0D THEN BEGIN
                        IF "Prod. Order Component"."Material Required Day" <> 99 THEN BEGIN
                            "Prod. Order Component"."Production Plan Date" := "Production Order"."Prod Start date";
                            "Prod. Order Component".MODIFY;
                        END;
                    END ELSE BEGIN
                        "Prod. Order Component"."Production Plan Date" := 0D;
                        "Prod. Order Component".MODIFY;
                    END;
                END;
            UNTIL "Prod. Order Component".NEXT = 0;
        END;

    end;

    var
        IJL: Record "Item Journal Line";
        Item: Record Item;
        "Indent Line": Record "Indent Line";
        "Purchase Line": Record "Purchase Line";
        pd: Record "DAY WISE DETAILS";
        PID: Record "Site Old Stock Data";
        Vendor: Record Vendor;
        "Purchase Header": Record "Purchase Header";
        PostedMaterialIssuesHeader: Record "Posted Material Issues Header";
        ILE: Record "Item Ledger Entry";
        "Service Item Line": Record "Service Item Line";
        "Service Item": Record "Service Item";
        "Purch. Inv. Line": Record "Purch. Inv. Line";
        "Purch. rcpt. header": Record "Purch. Rcpt. Header";
        "Prod. Order Component": Record "Prod. Order Component";
        "Production Order": Record "Production Order";
}

