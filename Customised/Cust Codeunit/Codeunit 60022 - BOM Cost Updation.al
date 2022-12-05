codeunit 60022 "BOM Cost Updation"
{
    // version Cost1.0,DWS1.0


    trigger OnRun();
    begin
        /*
        IF ProdBOMHeader.FINDSET THEN
          REPEAT
            IF ProdBOMHeader.Status<>ProdBOMHeader.Status::Certified THEN BEGIN
              ProdBOMLine.RESET;
              ProdBOMLine.SETRANGE("Production BOM No.",ProdBOMHeader."No.");
              ProdBOMLine.SETRANGE(Type,ProdBOMLine.Type::Item);
              IF ProdBOMLine.FINDSET THEN
                REPEAT
                  IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                    ProdBOMLine."Avg Cost":=Item."Avg Unit Cost";
                    ProdBOMLine."Tot Avg Cost":=ProdBOMLine."Avg Cost"*ProdBOMLine."Quantity per";
                    ProdBOMLine."Manufacturing Cost":=Item."Manufacturing Cost";
                    ProdBOMLine.MODIFY;
                  END ELSE IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                    ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost",ProdBOMHeader2."BOM Manufacturing Cost");
                    ProdBOMLine."Avg Cost":=ProdBOMHeader2."BOM Cost";
                    ProdBOMLine."Manufacturing Cost":=ProdBOMHeader2."BOM Manufacturing Cost";
                    ProdBOMLine."Tot Avg Cost":=ProdBOMHeader2."BOM Cost";
                    ProdBOMLine.MODIFY;
                  END;
                UNTIL ProdBOMLine.NEXT=0;
            END ELSE BEGIN
              ProdBOMHeader.Status:=ProdBOMHeader.Status::"Under Development";
              ProdBOMHeader.MODIFY;
              ProdBOMLine.RESET;
              ProdBOMLine.SETRANGE("Production BOM No.",ProdBOMHeader."No.");
              ProdBOMLine.SETRANGE(Type,ProdBOMLine.Type::Item);
              IF ProdBOMLine.FINDSET THEN
                REPEAT
                  IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                    ProdBOMLine."Avg Cost":=Item."Avg Unit Cost";
                    ProdBOMLine."Tot Avg Cost":=ProdBOMLine."Avg Cost"*ProdBOMLine."Quantity per";
                    ProdBOMLine."Manufacturing Cost":=Item."Manufacturing Cost";
                    ProdBOMLine.MODIFY;
                  END ELSE IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                    ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost",ProdBOMHeader2."BOM Manufacturing Cost");
                    ProdBOMLine."Avg Cost":=ProdBOMHeader2."BOM Cost";
                    ProdBOMLine."Manufacturing Cost":=ProdBOMHeader2."BOM Manufacturing Cost";
                    ProdBOMLine."Tot Avg Cost":=ProdBOMHeader2."BOM Cost";
                    ProdBOMLine.MODIFY;
                  END;
                UNTIL ProdBOMLine.NEXT=0;
              ProdBOMHeader.Status:=ProdBOMHeader.Status::Certified;
              ProdBOMHeader.MODIFY;
            END;
          UNTIL ProdBOMHeader.NEXT=0;
         */
        /*
        "Material Issues header".SETFILTER("Material Issues header"."No.",'A*');
        "Material Issues header".SETRANGE("Material Issues header"."Posting Date",101009D);
        //"Material Issues header".SETRANGE("Material Issues header"."Transfer-from Code",'PROD');
        IF "Material Issues header".FINDSET THEN
        REPEAT
            "Material Issues header".VALIDATE("Material Issues header".Status,"Material Issues header".Status::Released);
             "Material Issues header".VALIDATE("Material Issues header"."Released Date","Material Issues header"."Posting Date");
             "Material Issues header".VALIDATE("Material Issues header"."Released Time",TIME);
             "Material Issues header".VALIDATE("Material Issues header"."Released By","Material Issues header"."User ID");
             "Material Issues header".MODIFY;
        
        UNTIL "Material Issues header".NEXT=0;
        
             // CODE FOR RELEASING THE ALL MATERIAL ISSUES
        
        "Material Issues header".RESET;
        "Material Issues header".SETFILTER("Material Issues header"."No.",'A*');
        //"Material Issues header".SETRANGE("Material Issues header"."Transfer-from Code",'PROD');
        "Material Issues header".SETRANGE("Material Issues header"."Posting Date",101009D);
        IF "Material Issues header".FINDSET THEN
        REPEAT
          "Material Issues Line".RESET;
          "Material Issues Line".SETRANGE("Material Issues Line"."Document No.","Material Issues header"."No.");
          IF "Material Issues Line".FINDSET THEN
          REPEAT
            "tRACKING qTY":=0;
            "Tracking Specification".RESET;
            "Tracking Specification".SETRANGE("Tracking Specification"."Order No.","Material Issues Line"."Document No.");
            "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.","Material Issues Line"."Line No.");
            IF "Tracking Specification".FINDSET THEN
            REPEAT
              "tRACKING qTY":="tRACKING qTY"+"Tracking Specification".Quantity;
            UNTIL "Tracking Specification".NEXT=0;
            "Material Issues Line"."Qty. to Receive":="tRACKING qTY";
            IF "Material Issues Line".Quantity<"Material Issues Line"."Qty. to Receive" THEN
              "Material Issues Line".Quantity:="Material Issues Line"."Qty. to Receive";
            "Material Issues Line".MODIFY;
            IF "Material Issues Line"."Qty. to Receive">0 THEN
            BEGIN
               "Material Issues header"."Auto Post":=TRUE;
               "Material Issues header".MODIFY;
            END;
          UNTIL "Material Issues Line".NEXT=0;
        UNTIL "Material Issues header".NEXT=0;
          // CODE FOR QTY. TO RECEIVE UPDATION
        */
        /*
        "Material Issues header".RESET;
        "Material Issues header".SETFILTER("Material Issues header".Status,'Released');
        IF "Material Issues header".FINDSET THEN
        REPEAT
          Pending_Qty:=0;
          "Material Issues Line".RESET;
          "Material Issues Line".SETRANGE("Material Issues Line"."Document No.","Material Issues header"."No.");
          IF "Material Issues Line".FINDSET THEN
          REPEAT
            Pending_Qty:=Pending_Qty+("Material Issues Line".Quantity-"Material Issues Line"."Quantity Received");
          UNTIL "Material Issues Line".NEXT=0;
          IF Pending_Qty=0 THEN
            "Material Issues header".Rejected:=TRUE;
            "Material Issues header".MODIFY;
        UNTIL "Material Issues header".NEXT=0;
        
         */
        /*
         "Posted Material Issues Header".RESET;
         "Posted Material Issues Header".SETCURRENTKEY("Posted Material Issues Header"."Material Issue No.",
                                                   "Posted Material Issues Header"."Posting Date",
                                                   "Posted Material Issues Header"."Resource Name",
                                                   "Posted Material Issues Header"."Reason Code",
                                                   "Posted Material Issues Header"."Prod. Order No.",
                                                   "Posted Material Issues Header"."Transfer-to Code",
                                                   "Posted Material Issues Header"."Transfer-from Code");
         "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Material Issue No.",'A*');
         "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Posting Date",112009D);
         "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Receipt Date",102409D);
         IF "Posted Material Issues Header".FINDSET THEN
         REPEAT
           "Posted Material Issues Header"."Posting Date":="Posted Material Issues Header"."Receipt Date";
           "Posted Material Issues Header"."Issued DateTime":=CREATEDATETIME("Posted Material Issues Header"."Receipt Date",
                                                                             TIME);
           "Posted Material Issues Header".MODIFY;
        
         UNTIL "Posted Material Issues Header".NEXT=0;
         */


        //"Material Issues header".SETFILTER("Material Issues header"."No.",'M*');
        //SCS09HMU1551..SCS09HMU2220
        //SCS09HMU2223..SCS09HMU3400
        //SCS09GSL0433..SCS09GSL1200
        //SCS09HMU3401..SCS09HMU3750
        //SCS09RSL0901..SCS09RSL1000
        //SCS09YSL0601..SCS09YSL1550
        //SCS09YSL0301..SCS09YSL0432
        //SCS09YSL0448..SCS09YSL0513
        //SCS09YSL0604..SCS09YSL0904
        //SCS09YSL0951..SCS09YSL1201
        //SCS09RSL0866..SCS09RSL1069
        //SCS09GSL0201..SCS09GSL0263
        //SCS09GSL1001..SCS09GSL1171
        //SCS09CRL2597..SCS09CRL2706

        "Material Issues header".SETRANGE("Material Issues header"."Prod. Order No.", 'SCS09CRL2597', 'SCS09CRL2706');
        "Material Issues header".SETRANGE("Material Issues header"."Prod. Order Line No.", 10000);
        "Material Issues header".SETRANGE("Material Issues header".Status, "Material Issues header".Status::Released);
        MESSAGE(FORMAT("Material Issues header".COUNT));
        IF "Material Issues header".FINDSET THEN
            REPEAT
                "Material Issues header".Rejected := TRUE;
                "Material Issues header".MODIFY;
            /*"Material Issues Line".RESET;
            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.","Material Issues header"."No.");
            IF "Material Issues Line".FINDSET THEN
            REPEAT
              "Material Issues Line".DELETE;
            UNTIL "Material Issues Line".NEXT=0;
            "Material Issues header".DELETE;
            "Tracking Specification".RESET;
            "Tracking Specification".SETRANGE("Tracking Specification"."Order No.","Material Issues header"."No.");
            IF "Tracking Specification".FINDSET THEN
            REPEAT
              "Tracking Specification".DELETE;
            UNTIL "Tracking Specification".NEXT=0;*/
            UNTIL "Material Issues header".NEXT = 0;

    end;

    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMHeader2: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        Item: Record Item;
        "Material Issues header": Record "Material Issues Header";
        "Material Issues Line": Record "Material Issues Line";
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "tRACKING qTY": Decimal;
        "Posted Material Issues Header": Record "Posted Material Issues Header";
        Pending_Qty: Decimal;
        x: Codeunit "Release MaterialIssue Document";
}

