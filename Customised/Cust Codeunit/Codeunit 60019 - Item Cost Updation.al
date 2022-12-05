codeunit 60019 "Item Cost Updation"
{
    // version Cost1.0,DWS1.0

    //             {
    //             Window.OPEN(T0001);
    //             PBMH.RESET;
    //             Item.SETRANGE(Item."Product Group Code",'CPCB');
    //             IF Item.FINDSET THEN
    //             REPEAT
    //               IF PBMH.GET(Item."No.") THEN
    //               BEGIN
    // 
    //                 IF  PBMH.Status = PBMH.Status ::Certified THEN
    //                 BEGIN
    //                   Window.UPDATE(1,PBMH."No.");
    //                   PBMH.VALIDATE(PBMH.Status,PBMH.Status::Certified);
    //               {    PBMH."Total Soldering Points SMD":= 0;
    //                   PBMH."Total Soldering Points DIP":= 0;
    //                   PBMH."Total Soldering Points":= 0;
    //                   PBML.SETRANGE(PBML."Production BOM No.",PBMH."No.");
    //                   IF PBML.FINDSET THEN
    //                   REPEAT
    //                     IF PBML."Type of Solder"=PBML."Type of Solder"::SMD THEN
    //                        PBMH."Total Soldering Points SMD" := PBMH."Total Soldering Points SMD" + PBML."No. of Soldering Points";
    //                     IF PBML."Type of Solder"=PBML."Type of Solder"::DIP THEN
    //                       PBMH."Total Soldering Points DIP" := PBMH."Total Soldering Points DIP" +PBML."No. of Soldering Points";
    //                     PBMH."Total Soldering Points"+=PBML."No. of Soldering Points";
    //                   UNTIL PBML.NEXT=0;
    //                   PBMH."Bench Mark Time(In Hours)" := PBMH."Total Soldering Points SMD" * (MfgSetup."Soldering Time Req.for BID" / 3600) +
    //                                                       PBMH."Total Soldering Points DIP" * (MfgSetup."Soldering Time Req.for DIP" / 3600) +
    //                                                       PBMH."Total No. of Fixing Holes" * (MfgSetup."Total Fixing Points Time" / 3600);
    //                   PBMH.MODIFY;}
    //                 END;
    //               END;
    //             UNTIL Item.NEXT=0;
    //             Window.CLOSE;
    // 
    //             Window.OPEN(T0001);
    //             Item.RESET;
    //             Item.SETRANGE(Item."Product Group Code",'FPRODUCT');
    //             IF Item.FINDSET THEN
    //             REPEAT
    //               IF PBMH.GET(Item."No.") THEN
    //               BEGIN
    //                 IF  PBMH.Status = PBMH.Status ::Certified THEN
    //                 BEGIN
    //                   Window.UPDATE(1,PBMH."No.");
    //                   PBMH.VALIDATE(PBMH.Status,PBMH.Status::Certified);
    //                   PBMH."Total Soldering Points SMD":= 0;
    //                   PBMH."Total Soldering Points DIP":= 0;
    //                   PBMH."Total Soldering Points":= 0;
    //                   PBML.SETRANGE(PBML."Production BOM No.",PBMH."No.");
    //                   IF PBML.FINDSET THEN
    //                   REPEAT
    //                     IF PBML.Type = PBML.Type::Item THEN
    //                     BEGIN
    //                       Item.GET(PBML."No.");
    //                       IF ProdBOMHeader.GET(Item."Production BOM No.") THEN
    //                       BEGIN
    //                         ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
    //                         PBMH."Total Soldering Points SMD" := PBMH."Total Soldering Points SMD" + ProdBOMHeader."Total Soldering Points SMD";
    //                         PBMH."Total Soldering Points DIP" := PBMH."Total Soldering Points DIP" + ProdBOMHeader."Total Soldering Points DIP";
    //                       END ELSE
    //                       BEGIN
    //                         IF Item."Type of Solder"=Item."Type of Solder"::SMD THEN
    //                           PBMH."Total Soldering Points SMD" := PBMH."Total Soldering Points SMD" +Item."No. of Soldering Points"
    //                         ELSE
    //                            PBMH."Total Soldering Points DIP" := PBMH."Total Soldering Points DIP" +Item."No. of Soldering Points"
    //                       END;
    //                     END ELSE
    //                       IF PBML.Type = PBML.Type::"Production BOM" THEN
    //                       BEGIN
    //                         IF ProdBOMHeader.GET(PBML."No.") THEN
    //                         BEGIN
    //                           ProdBOMHeader.TESTFIELD(Status,ProdBOMHeader.Status::Certified);
    //                           PBMH."Total Soldering Points SMD" := PBMH."Total Soldering Points SMD" + ProdBOMHeader."Total Soldering Points SMD";
    //                           PBMH."Total Soldering Points DIP" := PBMH."Total Soldering Points DIP" + ProdBOMHeader."Total Soldering Points DIP";
    //                         END;
    //                       END;
    //                   UNTIL PBML.NEXT=0;
    //                   PBMH."Total Soldering Points":=PBMH."Total Soldering Points SMD"+PBMH."Total Soldering Points DIP";
    // 
    //                   PBMH."Bench Mark Time(In Hours)" := PBMH."Total Soldering Points SMD" * (MfgSetup."Soldering Time Req.for BID" / 3600) +
    //                                                       PBMH."Total Soldering Points DIP" * (MfgSetup."Soldering Time Req.for DIP" / 3600) +
    //                                                       PBMH."Total No. of Fixing Holes" * (MfgSetup."Total Fixing Points Time" / 3600);
    //                   PBMH.MODIFY;
    //                 END;
    //               END;
    //             UNTIL Item.NEXT=0;
    //                   }


    trigger OnRun();
    var
        UnitCost2: Decimal;
        Amt2: Decimal;
    begin
        /*
        "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Posting Date",010109D,092509D);
        "Posted Material Issues Header".SETFILTER("Posted Material Issues Header"."Transfer-from Code",'%1|%2|%3|%4|%5|%6|%7','RD1',
                                                   'RD2','RD3','RD4','RD5','RD6','RHW');
        "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code",'DAMAGE');
        IF "Posted Material Issues Header".FINDSET THEN
        REPEAT
        
          "Posted Material Issues Header".Stores:="Posted Material Issues Header".Stores::"RD STR";
          "Posted Material Issues Header".MODIFY;
        UNTIL "Posted Material Issues Header".NEXT=0;
         */

        Item.SETRANGE(Item."No.");
        IF Item.FINDSET THEN
            REPEAT
                    IF Item."Production BOM No." = '' THEN BEGIN
                        TotQty := 0;
                        TotVendorAmt := 0;
                        PurchaseInvLine.RESET;
                        PurchaseInvLine.SETCURRENTKEY(Type, "No.", "Variant Code", PurchaseInvLine."Invoice Date");
                        PurchaseInvLine.SETRANGE(Type, PurchaseInvLine.Type::Item);
                        PurchaseInvLine.SETRANGE("No.", Item."No.");
                        IF PurchaseInvLine.FINDLAST THEN BEGIN
                            IF PurchaseInvLine.Quantity > 0 THEN BEGIN
                                /* IF PurchaseInvLine."Direct Unit Cost"=PurchaseInvLine."Unit Cost (LCY)" THEN
                                   Item."Avg Unit Cost":=PurchaseInvLine."Amount To Vendor"/PurchaseInvLine.Quantity
                                 ELSE BEGIN
                                     UnitCost2:=0;
                                     UnitCost2:=PurchaseInvLine."Unit Cost (LCY)"/PurchaseInvLine."Direct Unit Cost";
                                     //Amt2:=PurchaseInvLine."Amount To Vendor"-PurchaseInvLine."Charges To Vendor";
                                     Amt2:=PurchaseInvLine."Amount Added to Inventory"+((
                                     PurchaseInvLine."Amount To Vendor"-PurchaseInvLine."Charges To Vendor")*UnitCost2);
                                     Item."Avg Unit Cost":=((Amt2)/PurchaseInvLine.Quantity);
                                   END;  */
                                //CODE COMMENTED BY SANTHOSH
                                IF PurchaseInvLine."Gen. Bus. Posting Group" <> 'FOREIGN' THEN BEGIN
                                    Item."Avg Unit Cost" := PurchaseInvLine."Amount To Vendor" / PurchaseInvLine."Quantity (Base)";
                                END ELSE BEGIN
                                    Structure_Amount := 0;
                                    //EFFUPG>>
                                    /*
                                     "Posted Str Order Line Details".RESET;
                                     "Posted Str Order Line Details".SETRANGE("Posted Str Order Line Details".Type,
                                                                              "Posted Str Order Line Details".Type::Purchase);
                                     "Posted Str Order Line Details".SETRANGE("Posted Str Order Line Details"."Document Type",
                                                                              "Posted Str Order Line Details"."Document Type"::Invoice);
                                     "Posted Str Order Line Details".SETRANGE("Posted Str Order Line Details"."Invoice No.", PurchaseInvLine."Document No.");
                                     "Posted Str Order Line Details".SETRANGE("Posted Str Order Line Details"."Item No.", PurchaseInvLine."No.");
                                     "Posted Str Order Line Details".SETRANGE("Posted Str Order Line Details"."Line No.", PurchaseInvLine."Line No.");
                                     IF "Posted Str Order Line Details".FINDSET THEN
                                         REPEAT
                                                 Structure_Amount += "Posted Str Order Line Details"."Amount (LCY)";
                                         UNTIL "Posted Str Order Line Details".NEXT = 0;
                                         */
                                    //EFFUPG<<
                                    Item."Avg Unit Cost" := ((PurchaseInvLine.Quantity * PurchaseInvLine."Unit Cost (LCY)") + Structure_Amount) /
                                                             PurchaseInvLine."Quantity (Base)";
                                END;
                                Item.MODIFY;
                            END;
                        END;
                    END ELSE BEGIN
                        /* BOMCost:=0;
                          RoutingCost:=0;
                          IF ProdBOMHeader.GET(Item."Production BOM No.") THEN BEGIN
                            ProdBOMHeader.CALCFIELDS(ProdBOMHeader."BOM Cost");
                            BOMCost:=ProdBOMHeader."BOM Cost";
                            IF RoutingHeader.GET(Item."Routing No.") THEN BEGIN
                              RoutingHeader.CALCFIELDS(RoutingHeader."Man Cost");
                              RoutingCost:=RoutingHeader."Man Cost";
                            END;
                            Item."Avg Unit Cost":=BOMCost;
                            Item."Manufacturing Cost":=RoutingCost;
                            Item.MODIFY;
                          END;       */
                    END;
            UNTIL Item.NEXT = 0;

    end;

    var
        PurchaseInvLine: Record "Purch. Inv. Line";
        Item: Record Item;
        TotQty: Decimal;
        TotVendorAmt: Decimal;
        ProdBOMHeader: Record "Production BOM Header";
        RoutingLine: Record "Routing Line";
        RoutingHeader: Record "Routing Header";
        BOMCost: Decimal;
        RoutingCost: Decimal;
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
        ItemLedEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        // "Posted Str Order Line Details": Record "Posted Str Order Line Details";
        Structure_Amount: Decimal;
        "Posted Material Issues Header": Record "Posted Material Issues Header";
        MfgSetup: Record "Manufacturing Setup";
        T0001: Label 'Updating BOM Values #1###################';
        Window: Dialog;
        T0002: Label 'Verifying BOM #2#############';


    procedure UpdateBOMCost2();
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMHeader2: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        Item: Record Item;
    begin
        IF ProdBOMHeader.FINDSET THEN
            REPEAT
                    IF ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified THEN BEGIN
                        ProdBOMLine.RESET;
                        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
                        IF ProdBOMLine.FINDSET THEN
                            REPEAT
                                    IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                                        ProdBOMLine."Avg Cost" := Item."Avg Unit Cost";
                                        ProdBOMLine."Tot Avg Cost" := ProdBOMLine."Avg Cost" * ProdBOMLine."Quantity per";
                                        ProdBOMLine."Manufacturing Cost" := Item."Manufacturing Cost";
                                        ProdBOMLine.MODIFY;
                                    END ELSE
                                        IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                                            ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost", ProdBOMHeader2."BOM Manufacturing Cost");
                                            ProdBOMLine."Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine."Manufacturing Cost" := ProdBOMHeader2."BOM Manufacturing Cost";
                                            ProdBOMLine."Tot Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine.MODIFY;
                                        END;
                            UNTIL ProdBOMLine.NEXT = 0;
                    END ELSE BEGIN
                        ProdBOMHeader.Status := ProdBOMHeader.Status::"Under Development";
                        ProdBOMHeader.MODIFY;
                        ProdBOMLine.RESET;
                        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
                        IF ProdBOMLine.FINDSET THEN
                                REPEAT
                                    IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                                        ProdBOMLine."Avg Cost" := Item."Avg Unit Cost";
                                        ProdBOMLine."Tot Avg Cost" := ProdBOMLine."Avg Cost" * ProdBOMLine."Quantity per";
                                        ProdBOMLine."Manufacturing Cost" := Item."Manufacturing Cost";
                                        ProdBOMLine.MODIFY;
                                    END ELSE
                                        IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                                            ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost", ProdBOMHeader2."BOM Manufacturing Cost");
                                            ProdBOMLine."Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine."Manufacturing Cost" := ProdBOMHeader2."BOM Manufacturing Cost";
                                            ProdBOMLine."Tot Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine.MODIFY;
                                        END;
                                UNTIL ProdBOMLine.NEXT = 0;
                        ProdBOMHeader.Status := ProdBOMHeader.Status::Certified;
                        ProdBOMHeader.MODIFY;
                    END;
            UNTIL ProdBOMHeader.NEXT = 0;
    end;


    procedure RoutingCostUpdation();
    var
        TotMin: Decimal;
        TotHours: Decimal;
        RoutingLine: Record "Routing Line";
        RoutingHeader: Record "Routing Header";
        BOMCost: Decimal;
        RoutingCost: Decimal;
        MachineCenter: Record "Machine Center";
        WorkCenter: Record "Work Center";
        ProdBOMHeader: Record "Production BOM Header";
    begin
        IF RoutingHeader.FINDSET THEN
                REPEAT
                    IF RoutingHeader.Status <> RoutingHeader.Status::Certified THEN BEGIN
                        RoutingLine.RESET;
                        RoutingLine.SETRANGE("Routing No.", RoutingHeader."No.");
                        IF RoutingLine.FINDSET THEN BEGIN
                            RoutingCost := 0;
                                                        REPEAT
                                                            IF RoutingLine.Type = RoutingLine.Type::"Work Center" THEN BEGIN
                                                                IF WorkCenter.GET(RoutingLine."No.") THEN
                                                                    RoutingLine."Man Cost" := WorkCenter."Unit Cost" * RoutingLine."Run Time";
                                                            END ELSE
                                                                IF RoutingLine.Type = RoutingLine.Type::"Machine Center" THEN BEGIN
                                                                    IF MachineCenter.GET(RoutingLine."No.") THEN
                                                                        RoutingLine."Man Cost" := MachineCenter."Unit Cost" * RoutingLine."Run Time";
                                                                END;
                                                            RoutingLine.MODIFY;
                                                        UNTIL RoutingLine.NEXT = 0;
                        END;
                    END ELSE BEGIN
                        RoutingHeader.Status := RoutingHeader.Status::"Under Development";
                        RoutingHeader.MODIFY;
                        RoutingLine.RESET;
                        RoutingLine.SETRANGE("Routing No.", RoutingHeader."No.");
                        IF RoutingLine.FINDSET THEN
                                REPEAT
                                    IF RoutingLine.Type = RoutingLine.Type::"Work Center" THEN BEGIN
                                        IF WorkCenter.GET(RoutingLine."No.") THEN
                                            RoutingLine."Man Cost" := WorkCenter."Unit Cost" * RoutingLine."Run Time";
                                    END ELSE
                                        IF RoutingLine.Type = RoutingLine.Type::"Machine Center" THEN BEGIN
                                            IF MachineCenter.GET(RoutingLine."No.") THEN
                                                RoutingLine."Man Cost" := MachineCenter."Unit Cost" * RoutingLine."Run Time";
                                        END;
                                    RoutingLine.MODIFY;
                                UNTIL RoutingLine.NEXT = 0;
                        TotHours := TotMin / 60;
                        RoutingHeader.Status := RoutingHeader.Status::Certified;
                        RoutingHeader.MODIFY;
                    END;
                UNTIL RoutingHeader.NEXT = 0;
    end;


    procedure UpdateBOMCost();
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMHeader2: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        Item: Record Item;
    begin
        IF ProdBOMHeader.FINDSET THEN
            REPEAT
                    IF ProdBOMHeader.Status <> ProdBOMHeader.Status::Certified THEN BEGIN
                        ProdBOMLine.RESET;
                        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
                        IF ProdBOMLine.FINDSET THEN
                            REPEAT
                                    IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                                        ProdBOMLine."Avg Cost" := Item."Avg Unit Cost";
                                        ProdBOMLine."Tot Avg Cost" := ProdBOMLine."Avg Cost" * ProdBOMLine."Quantity per";
                                        ProdBOMLine."Manufacturing Cost" := Item."Manufacturing Cost";
                                        ProdBOMLine.MODIFY;
                                    END ELSE
                                        IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                                            ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost", ProdBOMHeader2."BOM Manufacturing Cost");
                                            ProdBOMLine."Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine."Manufacturing Cost" := ProdBOMHeader2."BOM Manufacturing Cost";
                                            ProdBOMLine."Tot Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine.MODIFY;
                                        END;
                            UNTIL ProdBOMLine.NEXT = 0;
                    END ELSE BEGIN
                        ProdBOMHeader.Status := ProdBOMHeader.Status::"Under Development";
                        ProdBOMHeader.MODIFY;
                        ProdBOMLine.RESET;
                        ProdBOMLine.SETRANGE("Production BOM No.", ProdBOMHeader."No.");
                        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
                        IF ProdBOMLine.FINDSET THEN
                                REPEAT
                                    IF Item.GET(ProdBOMLine."No.") THEN BEGIN
                                        ProdBOMLine."Avg Cost" := Item."Avg Unit Cost";
                                        ProdBOMLine."Tot Avg Cost" := ProdBOMLine."Avg Cost" * ProdBOMLine."Quantity per";
                                        ProdBOMLine."Manufacturing Cost" := Item."Manufacturing Cost";
                                        ProdBOMLine.MODIFY;
                                    END ELSE
                                        IF ProdBOMHeader2.GET(ProdBOMLine."No.") THEN BEGIN
                                            ProdBOMHeader2.CALCFIELDS(ProdBOMHeader2."BOM Cost", ProdBOMHeader2."BOM Manufacturing Cost");
                                            ProdBOMLine."Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine."Manufacturing Cost" := ProdBOMHeader2."BOM Manufacturing Cost";
                                            ProdBOMLine."Tot Avg Cost" := ProdBOMHeader2."BOM Cost";
                                            ProdBOMLine.MODIFY;
                                        END;
                                UNTIL ProdBOMLine.NEXT = 0;
                        ProdBOMHeader.Status := ProdBOMHeader.Status::Certified;
                        ProdBOMHeader.MODIFY;
                    END;
            UNTIL ProdBOMHeader.NEXT = 0;
    end;


    procedure UpdateBOM();
    var
        PBML: Record "Production BOM Line";
        PBMH: Record "Production BOM Header";
        FPO_ITEM: Record Item;
    begin
        /*
        //PBML.SETRANGE(PBML."Production BOM No.",'ECPBPCB00458');
        Window.OPEN(T0002);
        PBMH.MODIFYALL(PBMH."Update BOM",FALSE);
        PBML.SETRANGE(PBML.Type,PBML.Type::Item);
        IF PBML.FINDSET THEN
        REPEAT
          Window.UPDATE(2,PBML."Production BOM No.");
          IF Item.GET(PBML."No.") THEN
          BEGIN
            IF (Item."Product Group Code"<>'FPRODUCT') AND (Item."Product Group Code"<>'CPCB') THEN
            BEGIN
              IF (Item."No. of Soldering Points"*PBML."Quantity per")<>PBML."No. of Soldering Points" THEN
              BEGIN
                PBML."No. of Soldering Points":=(Item."No. of Soldering Points"*PBML."Quantity per");
        
                IF PBMH.GET(PBML."Production BOM No.") THEN
                BEGIN
                  IF PBMH.Status=PBMH.Status::Certified THEN
                  BEGIN
                    PBMH."Update BOM":=TRUE;
                    PBMH.MODIFY;
                  END;
                END;
              END ELSE
              IF (Item."No. of Pins"*PBML."Quantity per") <> (PBML."No. of Pins") THEN
              BEGIN
                PBML."No. of Pins":=(Item."No. of Pins"*PBML."Quantity per");
        
                IF PBMH.GET(PBML."Production BOM No.") THEN
                BEGIN
                  IF PBMH.Status=PBMH.Status::Certified THEN
                  BEGIN
                    PBMH."Update BOM":=TRUE;
                    PBMH.MODIFY;
                  END;
                END;
              END;
              PBML."Type of Solder":=Item."Type of Solder";
              PBML.MODIFY;
            END;
          END;
        UNTIL PBML.NEXT=0;
        Window.CLOSE;
        COMMIT;
        
        Window.OPEN(T0001);
        PBMH.SETRANGE(PBMH."Update BOM",TRUE);
        IF PBMH.FINDSET THEN
        REPEAT
          Window.UPDATE(2,PBMH."No.");
          IF Item.GET(PBMH."No.") THEN
          BEGIN
            IF (Item."Product Group Code"='CPCB') THEN
              PBMH.VALIDATE(PBMH.Status,PBMH.Status::Certified);
        
          END;
        UNTIL PBMH.NEXT=0;
        Window.CLOSE;
        PBMH.MODIFYALL(PBMH."Update BOM",FALSE);
          */

        Window.OPEN(T0001);
        PBMH.RESET;
        IF PBMH.FINDSET THEN
                REPEAT
                    IF FPO_ITEM.GET(PBMH."No.") THEN BEGIN
                        IF FPO_ITEM."Product Group Code Cust" = 'FPRODUCT' THEN BEGIN
                            Window.UPDATE(1, PBMH."No.");
                            PBMH."Total Soldering Points DIP" := 0;
                            PBMH."Total Soldering Points" := 0;
                            PBMH."Total Soldering Points SMD" := 0;
                            PBML.RESET;
                            PBML.SETRANGE("Production BOM No.", PBMH."No.");
                            PBML.SETRANGE("Version Code", '');
                            IF PBML.FINDSET THEN
                                REPEAT
                                        IF ProdBOMHeader.GET(PBML."No.") THEN BEGIN
                                            CALC_SOLDERING_POINTS(PBML."No.");
                                            PBML."No. of Soldering Points" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points";
                                            PBML."No. of SMD Points" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points SMD";
                                            PBML."No. of DIP Point" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points DIP";
                                            PBMH."Total Soldering Points" += PBML."No. of Soldering Points";
                                            PBMH."Total Soldering Points DIP" += PBML."No. of DIP Point";
                                            PBMH."Total Soldering Points SMD" += PBML."No. of SMD Points";
                                            PBML.MODIFY;
                                        END ELSE
                                            IF Item.GET(PBML."No.") THEN BEGIN
                                                PBML."No. of Pins" := Item."No. of Pins";
                                                PBML."No. of Soldering Points" := Item."No. of Soldering Points" * (PBML.Quantity -
                                                                                                                         PBML."Scrap Quantity");
                                                PBML."Type of Solder" := Item."Type of Solder";
                                                IF PBML."Type of Solder" = 1 THEN
                                                    PBMH."Total Soldering Points SMD" += PBML."No. of Soldering Points";
                                                IF PBML."Type of Solder" = 2 THEN
                                                    PBMH."Total Soldering Points DIP" += PBML."No. of Soldering Points";
                                                PBMH."Total Soldering Points" += PBML."No. of Soldering Points";
                                            END;
                                UNTIL PBML.NEXT = 0;
                            PBMH.MODIFY;
                        END;
                    END;
                UNTIL PBMH.NEXT = 0;
        Window.CLOSE;


        Window.OPEN(T0001);
        PBMH.RESET;
        //PBMH.SETRANGE(PBMH."No.",'ECPBPCB00567');
        IF PBMH.FINDSET THEN
            REPEAT
                    IF FPO_ITEM.GET(PBMH."No.") THEN BEGIN
                        IF FPO_ITEM."Product Group Code Cust" = 'CPCB' THEN BEGIN
                            Window.UPDATE(1, PBMH."No.");
                            PBMH."Total Soldering Points DIP" := 0;
                            PBMH."Total Soldering Points" := 0;
                            PBMH."Total Soldering Points SMD" := 0;
                            PBML.RESET;
                            PBML.SETRANGE("Production BOM No.", PBMH."No.");
                            PBML.SETRANGE("Version Code", '');
                            IF PBML.FINDSET THEN
                                    REPEAT
                                        IF ProdBOMHeader.GET(PBML."No.") THEN BEGIN
                                            CALC_SOLDERING_POINTS(PBML."No.");
                                            PBML."No. of Soldering Points" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points";
                                            PBML."No. of SMD Points" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points SMD";
                                            PBML."No. of DIP Point" := PBML."Quantity per" * ProdBOMHeader."Total Soldering Points DIP";
                                            PBMH."Total Soldering Points" += PBML."No. of Soldering Points";
                                            PBMH."Total Soldering Points DIP" += PBML."No. of DIP Point";
                                            PBMH."Total Soldering Points SMD" += PBML."No. of SMD Points";
                                            PBML.MODIFY;
                                        END ELSE
                                            IF Item.GET(PBML."No.") THEN BEGIN
                                                PBML."No. of Pins" := Item."No. of Pins";
                                                PBML."No. of Soldering Points" := Item."No. of Soldering Points" * (PBML.Quantity -
                                                                                                                         PBML."Scrap Quantity");
                                                PBML."Type of Solder" := Item."Type of Solder";
                                                IF PBML."Type of Solder" = 1 THEN
                                                    PBMH."Total Soldering Points SMD" += PBML."No. of Soldering Points";
                                                IF PBML."Type of Solder" = 2 THEN
                                                    PBMH."Total Soldering Points DIP" += PBML."No. of Soldering Points";
                                                PBMH."Total Soldering Points" += PBML."No. of Soldering Points";
                                            END;
                                    UNTIL PBML.NEXT = 0;
                            PBMH.MODIFY;
                        END;
                    END;
            UNTIL PBMH.NEXT = 0;
        Window.CLOSE;

    end;


    procedure CALC_SOLDERING_POINTS("BOM NO.": Code[20]);
    var
        BOM_LINE: Record "Production BOM Line";
        BOM_HEADER: Record "Production BOM Header";
        BOM_ITEM: Record Item;
        BOM_HEADER2: Record "Production BOM Header";
    begin
        IF BOM_HEADER.GET("BOM NO.") THEN BEGIN
            BOM_HEADER."Total Soldering Points SMD" := 0;
            BOM_HEADER."Total Soldering Points DIP" := 0;
            BOM_HEADER."Total Soldering Points" := 0;
            BOM_LINE.SETRANGE(BOM_LINE."Production BOM No.", BOM_HEADER."No.");
            BOM_LINE.SETRANGE(BOM_LINE."Version Code", '');
            IF BOM_LINE.FINDSET THEN
                REPEAT
                        IF BOM_HEADER2.GET(BOM_LINE."No.") THEN BEGIN
                            CALC_SOLDERING_POINTS(BOM_LINE."No.");
                            BOM_LINE."No. of SMD Points" := BOM_HEADER2."Total Soldering Points SMD";
                            BOM_LINE."No. of DIP Point" := BOM_HEADER2."Total Soldering Points DIP";
                            BOM_LINE."No. of Soldering Points" := BOM_HEADER2."Total Soldering Points";
                            BOM_LINE.MODIFY;
                            BOM_HEADER."Total Soldering Points DIP" += BOM_HEADER2."Total Soldering Points DIP";
                            BOM_HEADER."Total Soldering Points SMD" += BOM_HEADER2."Total Soldering Points SMD";
                            BOM_HEADER."Total Soldering Points" += BOM_HEADER2."Total Soldering Points";
                        END ELSE
                            IF Item.GET(BOM_LINE."No.") THEN BEGIN
                                BOM_LINE."No. of Pins" := Item."No. of Pins";
                                BOM_LINE."No. of Soldering Points" := (BOM_LINE."Quantity per" - BOM_LINE."Scrap Quantity") * Item."No. of Soldering Points";
                                BOM_LINE."Type of Solder" := Item."Type of Solder";
                                IF BOM_LINE."Type of Solder" = 1 THEN
                                    BOM_HEADER."Total Soldering Points SMD" += BOM_LINE."No. of Soldering Points";
                                IF BOM_LINE."Type of Solder" = 2 THEN
                                    BOM_HEADER."Total Soldering Points DIP" += BOM_LINE."No. of Soldering Points";
                                BOM_HEADER."Total Soldering Points" += BOM_LINE."No. of Soldering Points";
                            END;
                    BOM_LINE.MODIFY;
                UNTIL BOM_LINE.NEXT = 0;
        END;
    end;
}

