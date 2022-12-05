page 50007 "Shortage Cumulative"
{
    PageType = List;
    SourceTable = "Production Order Shortage Item";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Shortage; Rec.Shortage)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortage At"; Rec."Shortage At")
                {
                    ApplicationArea = All;
                }
                field("Total Shortage"; Rec."Total Shortage")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. in Purchase Orders"; Rec."Qty. in Purchase Orders")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Purchase Line".RESET;
                        "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                        "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                        "Purchase Line".SETRANGE("Purchase Line"."No.", Rec.Item);
                        "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                        PAGE.RUNMODAL(56, "Purchase Line");
                    end;
                }
                field("Earliest Material Arrival Date"; Rec."Earliest Material Arrival Date")
                {
                    ApplicationArea = All;
                }
                field("Qty. Under Inspection"; Rec."Qty. Under Inspection")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        QILE.RESET;
                        QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                        QILE.SETRANGE(QILE."Item No.", Rec.Item);
                        QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                        QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                        QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                        QILE.SETRANGE(QILE."Location Code", 'STR');
                        QILE.SETRANGE(QILE.Accept, TRUE);
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ProdOrdShortage.RESET;
                        ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, Rec.Item);
                        IF ProdOrdShortage.FINDSET THEN BEGIN
                            ProdOrdShortage.MODIFYALL(ProdOrdShortage.Remarks, Rec.Remarks);
                        END;
                    end;
                }
                field("Stock at Stores"; "Stock at Stores")
                {
                    Caption = 'Stock at Stores';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CreateReq_STR; Rec.CreateReq_STR)
                {
                    Caption = 'Request';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Stock at Stores" = 0 THEN
                            ERROR('Quantity is Zero and request cannot be placed');
                        IF Rec."Shortage At" = 'STR' THEN
                            ERROR('Request from shortage location cannot be placed');

                        Req_stock := "Stock at Stores";
                        Req_count := 0;
                        IF Req_stock > Rec."Total Shortage" THEN
                            Req_count := 1;

                        IF Rec.CreateReq_CS THEN BEGIN
                            IF "Stock at CS Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at CS Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_RD THEN BEGIN
                            IF "Stock at RD Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at RD Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_MCH THEN BEGIN
                            IF "Stock at MCH" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at MCH";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Req_count > 1 THEN
                            ERROR('More stock is selected, kindly select the required quantity');


                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

                        IF MaterialIssueHeader.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueHeader."Transfer-from Code" = 'STR') THEN BEGIN
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                                    IF MaterialIssueLine.FINDSET THEN
                                        REPEAT
                                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                                ProdOrdShortage.CreateReq_STR := FALSE;
                                                ERROR('Material Request already created for this Item ' + MaterialIssueHeader."No.");
                                            END
                                        UNTIL MaterialIssueLine.NEXT = 0;
                                END;
                            UNTIL MaterialIssueHeader.NEXT = 0;
                    end;
                }
                field("Stock at CS Stores"; "Stock at CS Stores")
                {
                    Caption = 'Stock at CS Stores';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CreateReq_CS; Rec.CreateReq_CS)
                {
                    Caption = 'Request';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Stock at CS Stores" = 0 THEN
                            ERROR('Quantity is Zero and request cannot be placed');
                        IF Rec."Shortage At" = 'CS STR' THEN
                            ERROR('Request from shortage location cannot be placed');

                        Req_stock := "Stock at CS Stores";
                        Req_count := 0;
                        IF Req_stock > Rec."Total Shortage" THEN
                            Req_count := 1;

                        IF Rec.CreateReq_STR THEN BEGIN
                            IF "Stock at Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_RD THEN BEGIN
                            IF "Stock at RD Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at RD Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_MCH THEN BEGIN
                            IF "Stock at MCH" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at MCH";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Req_count > 1 THEN
                            ERROR('More stock is selected, kindly select the required quantity');

                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

                        IF MaterialIssueHeader.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueHeader."Transfer-from Code" = 'CS STR') THEN BEGIN
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                                    IF MaterialIssueLine.FINDSET THEN
                                        REPEAT
                                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                                ProdOrdShortage.CreateReq_CS := FALSE;
                                                ERROR('Material Request already created for this Item ' + MaterialIssueHeader."No.");
                                            END
                                        UNTIL MaterialIssueLine.NEXT = 0;
                                END;
                            UNTIL MaterialIssueHeader.NEXT = 0;
                    end;
                }
                field("Stock at RD Stores"; "Stock at RD Stores")
                {
                    Caption = 'Stock at RD Stores';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CreateReq_RD; Rec.CreateReq_RD)
                {
                    Caption = 'Request';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Stock at RD Stores" = 0 THEN
                            ERROR('Quantity is Zero and request cannot be placed');
                        IF Rec."Shortage At" = 'R&D STR' THEN
                            ERROR('Request from shortage location cannot be placed');

                        Req_stock := "Stock at RD Stores";
                        Req_count := 0;
                        IF Req_stock > Rec."Total Shortage" THEN
                            Req_count := 1;

                        IF Rec.CreateReq_STR THEN BEGIN
                            IF "Stock at Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                            Req_stock := Req_stock + "Stock at Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_CS THEN BEGIN
                            IF "Stock at CS Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                            Req_stock := Req_stock + "Stock at CS Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_MCH THEN BEGIN
                            IF "Stock at MCH" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at MCH";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Req_count > 1 THEN
                            ERROR('More stock is selected, kindly select the required quantity');

                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

                        IF MaterialIssueHeader.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueHeader."Transfer-from Code" = 'R&D STR') THEN BEGIN
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                                    IF MaterialIssueLine.FINDSET THEN
                                        REPEAT
                                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                                ProdOrdShortage.CreateReq_RD := FALSE;
                                                ERROR('Material Request already created for this Item ' + MaterialIssueHeader."No.");
                                            END
                                        UNTIL MaterialIssueLine.NEXT = 0;
                                END;
                            UNTIL MaterialIssueHeader.NEXT = 0;
                    end;
                }
                field("Stock at MCH"; "Stock at MCH")
                {
                    Caption = 'Stock at MCH';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(CreateReq_MCH; Rec.CreateReq_MCH)
                {
                    Caption = 'Request';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF "Stock at MCH" = 0 THEN
                            ERROR('Quantity is Zero and request cannot be placed');
                        IF Rec."Shortage At" = 'MCH' THEN
                            ERROR('Request from shortage location cannot be placed');

                        Req_stock := "Stock at MCH";
                        Req_count := 0;
                        IF Req_stock > Rec."Total Shortage" THEN
                            Req_count := 1;

                        IF Rec.CreateReq_STR THEN BEGIN
                            IF "Stock at Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_CS THEN BEGIN
                            IF "Stock at CS Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at CS Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Rec.CreateReq_RD THEN BEGIN
                            IF "Stock at RD Stores" > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;

                            Req_stock := Req_stock + "Stock at RD Stores";
                            IF Req_stock > Rec."Total Shortage" THEN
                                Req_count := Req_count + 1;
                        END;

                        IF Req_count > 1 THEN
                            ERROR('More stock is selected, kindly select the required quantity');


                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

                        IF MaterialIssueHeader.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueHeader."Transfer-from Code" = 'MCH') THEN BEGIN
                                    MaterialIssueLine.RESET;
                                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                                    IF MaterialIssueLine.FINDSET THEN
                                        REPEAT
                                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                                ProdOrdShortage.CreateReq_MCH := FALSE;
                                                ERROR('Material Request already created for this Item ' + MaterialIssueHeader."No.");
                                            END
                                        UNTIL MaterialIssueLine.NEXT = 0;
                                END;
                            UNTIL MaterialIssueHeader.NEXT = 0;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create Material Request")
            {
                Caption = 'Create Material Request';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    // Added by Rakesh to create Material request for Shortage Items on 16-Sep-14
                    // Request for STR items
                    //VerifyRequest;
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");

                    Rec.SETRANGE(CreateReq_STR, TRUE);
                    IF Rec.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'STR';
                        MaterialIssueHeader."Transfer-to Code" := Rec."Shortage At";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(Rec.Item);
                                IF (Rec.CreateReq_STR) OR NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        IF Rec."Total Shortage" <= "Stock at Stores" THEN
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                        ELSE
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at Stores");
                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_STR := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;

                    // Request for CS STR items for MCH
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");
                    Rec.SETRANGE("Shortage At", 'MCH');

                    Rec.SETRANGE(CreateReq_CS, TRUE);
                    IF Rec.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'CS STR';
                        MaterialIssueHeader."Transfer-to Code" := 'MCH';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(Rec.Item);
                                IF NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        IF Rec.CreateReq_STR THEN BEGIN
                                            IF (Rec."Total Shortage" - "Stock at Stores") <= "Stock at CS Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at Stores"))
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at CS Stores");
                                        END ELSE BEGIN
                                            IF Rec."Total Shortage" <= "Stock at CS Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at CS Stores");
                                        END;

                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_CS := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;

                    // Request for CS STR items for STR
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");
                    Rec.SETRANGE("Shortage At", 'STR');

                    Rec.SETRANGE(CreateReq_CS, TRUE);
                    IF Rec.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'CS STR';
                        MaterialIssueHeader."Transfer-to Code" := 'STR';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(Rec.Item);
                                IF NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");
                                        IF Rec.CreateReq_STR THEN BEGIN
                                            IF (Rec."Total Shortage" - "Stock at Stores") <= "Stock at CS Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at Stores"))
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at CS Stores");
                                        END ELSE BEGIN
                                            IF Rec."Total Shortage" <= "Stock at CS Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at CS Stores");
                                        END;

                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_CS := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;


                    // Request for RD STR items for MCH
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");
                    Rec.SETRANGE("Shortage At", 'MCH');

                    Rec.SETRANGE(CreateReq_RD, TRUE);
                    IF Rec.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'R&D STR';
                        MaterialIssueHeader."Transfer-to Code" := 'MCH';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(Rec.Item);
                                IF NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");

                                        IF Rec.CreateReq_STR AND Rec.CreateReq_CS THEN BEGIN
                                            IF (Rec."Total Shortage" - ("Stock at Stores" + "Stock at CS Stores")) <= "Stock at RD Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - ("Stock at Stores" + "Stock at CS Stores")))
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                        END ELSE
                                            IF Rec.CreateReq_STR THEN BEGIN
                                                IF (Rec."Total Shortage" - "Stock at Stores") <= "Stock at RD Stores" THEN
                                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at Stores"))
                                                ELSE
                                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                            END ELSE
                                                IF Rec.CreateReq_CS THEN BEGIN
                                                    IF (Rec."Total Shortage" - "Stock at CS Stores") <= "Stock at RD Stores" THEN
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at CS Stores"))
                                                    ELSE
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                                END ELSE BEGIN
                                                    IF Rec."Total Shortage" <= "Stock at RD Stores" THEN
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                                    ELSE
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                                END;

                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_RD := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;

                    // Request for RD STR items for STR
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");
                    Rec.SETRANGE("Shortage At", 'STR');

                    Rec.SETRANGE(CreateReq_RD, TRUE);
                    IF ProdOrdShortage.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'R&D STR';
                        MaterialIssueHeader."Transfer-to Code" := 'STR';
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(Rec.Item);
                                IF NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");

                                        IF Rec.CreateReq_MCH AND Rec.CreateReq_CS THEN BEGIN
                                            IF (Rec."Total Shortage" - ("Stock at Stores" + "Stock at CS Stores")) <= "Stock at RD Stores" THEN
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - ("Stock at Stores" + "Stock at CS Stores")))
                                            ELSE
                                                MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                        END ELSE
                                            IF Rec.CreateReq_MCH THEN BEGIN
                                                IF (Rec."Total Shortage" - "Stock at MCH") <= "Stock at RD Stores" THEN
                                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at Stores"))
                                                ELSE
                                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                            END ELSE
                                                IF Rec.CreateReq_CS THEN BEGIN
                                                    IF (Rec."Total Shortage" - "Stock at CS Stores") <= "Stock at RD Stores" THEN
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (Rec."Total Shortage" - "Stock at CS Stores"))
                                                    ELSE
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                                END ELSE BEGIN
                                                    IF Rec."Total Shortage" <= "Stock at RD Stores" THEN
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                                    ELSE
                                                        MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at RD Stores");
                                                END;

                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_RD := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;


                    // Request for MCH items
                    Rec.RESET;
                    //ProdOrdShortage.SETFILTER(ProdOrdShortage."Production Order","Production Order");

                    Rec.SETRANGE(CreateReq_MCH, TRUE);
                    IF Rec.FINDFIRST THEN BEGIN
                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.INIT;
                        MaterialIssueHeader."No." := GetNextNo;
                        MaterialIssueHeader."Receipt Date" := TODAY;
                        MaterialIssueHeader."Transfer-from Code" := 'MCH';
                        MaterialIssueHeader."Transfer-to Code" := Rec."Shortage At";
                        MaterialIssueHeader.VALIDATE("Prod. Order No.", 'EFF10STR01');
                        MaterialIssueHeader.VALIDATE("Prod. Order Line No.", 10000);
                        MaterialIssueHeader."Request for Authorization" := 'EFFTRONICS\PADMASRI';
                        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
                        MaterialIssueHeader."User ID" := USERID;
                        USER.GET(USERSECURITYID);
                        MaterialIssueHeader."Resource Name" := USER."Full Name";
                        MaterialIssueHeader."Creation DateTime" := CURRENTDATETIME;
                        MaterialIssueHeader.Remarks := 'Item Transfer';
                        MaterialIssueHeader.INSERT;
                        LineNo := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                GetStock(ProdOrdShortage.Item);
                                IF NOT (Rec.Req_created) THEN BEGIN
                                    LineNo := LineNo + 10000;
                                    IF ITEM1.GET(Rec.Item) THEN BEGIN
                                        MaterialIssueLine.INIT;
                                        MaterialIssueLine."Document No." := MaterialIssueHeader."No.";
                                        MaterialIssueLine.VALIDATE("Item No.", ITEM1."No.");
                                        MaterialIssueLine."Line No." := LineNo;
                                        MaterialIssueLine."Unit of Measure Code" := ITEM1."Base Unit of Measure";
                                        MaterialIssueLine.VALIDATE("Unit of Measure Code");
                                        MaterialIssueLine.VALIDATE("Unit of Measure");

                                        IF Rec."Total Shortage" <= "Stock at MCH" THEN
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, Rec."Total Shortage")
                                        ELSE
                                            MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, "Stock at MCH");

                                        MaterialIssueLine."Prod. Order No." := 'EFF10STR01';
                                        MaterialIssueLine."Prod. Order Line No." := 10000;
                                        MaterialIssueLine.INSERT;
                                        //        CreateReq_MCH := FALSE;
                                        //ProdOrdShortage.MODIFY;
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        //ProdOrdShortage.MODIFYALL(ProdOrdShortage.Req_created,FALSE);
                        IF LineNo < 10000 THEN
                            MaterialIssueHeader.DELETE
                        ELSE
                            AuthMail;
                    END;

                    Rec.CreateReq_STR := FALSE;
                    Rec.CreateReq_CS := FALSE;
                    Rec.CreateReq_RD := FALSE;
                    Rec.CreateReq_MCH := FALSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        getStockValues;
        VerifyRequest;
    end;

    trigger OnOpenPage();
    begin
        Rec.DELETEALL;

        Rec.RESET;
        ProdOrdShortage1.RESET;

        IF ProdOrdShortage1.FINDSET THEN
            REPEAT
                Rec.RESET;
                Rec.SETRANGE(Item, ProdOrdShortage1.Item);
                IF NOT Rec.FINDFIRST THEN BEGIN
                    Rec.INIT;
                    Rec.Item := ProdOrdShortage1.Item;
                    /*
                    // added by vijaya on 23-Jan
                    if  Item = 'ECLEDSM000107' then
                           Item := ProdOrdShortage1.Item;
                    // end by vijaya
                    */
                    Rec.Description := ProdOrdShortage1.Description;
                    Rec."Shortage At" := ProdOrdShortage1."Shortage At";
                    Rec.Remarks := ProdOrdShortage1.Remarks;

                    Rec."Qty. in Purchase Orders" := 0;
                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETRANGE("Purchase Line"."No.", ProdOrdShortage1.Item);
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR'); //Need to Add Location Code (Vishnu)
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                    IF "Purchase Line".FIND('-') THEN
                        REPEAT
                            Rec."Qty. in Purchase Orders" += "Purchase Line"."Qty. to Receive";
                        UNTIL "Purchase Line".NEXT = 0;

                    Rec."Qty. Under Inspection" := 0;
                    QILE.RESET;
                    QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                    QILE.SETRANGE(QILE."Item No.", Rec.Item);
                    QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                    QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                    QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                    QILE.SETRANGE(QILE."Location Code", 'STR'); //Need to Add Location Code (Vishnu)
                    QILE.SETRANGE(QILE.Accept, TRUE);
                    IF QILE.FIND('-') THEN
                        REPEAT
                            Rec."Qty. Under Inspection" += QILE."Remaining Quantity";
                        UNTIL QILE.NEXT = 0;


                    Total_shortage := 0;
                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, Rec.Item);
                    IF ProdOrdShortage.FINDSET THEN
                        REPEAT
                            Total_shortage := Total_shortage + ProdOrdShortage.Shortage;
                        UNTIL ProdOrdShortage.NEXT = 0;
                    ProdOrdShortage."Total Shortage" := Total_shortage;
                    Rec."Total Shortage" := Total_shortage;
                    getStockValues;
                    IF Rec."Shortage At" = 'MCH' THEN BEGIN
                        IF Rec."Total Shortage" > "Stock at Stores" THEN
                            Rec.INSERT;
                    END ELSE
                        IF Rec."Shortage At" = 'STR' THEN BEGIN
                            IF Rec."Total Shortage" > "Stock at MCH" THEN
                                Rec.INSERT;
                        END;

                END;
            //Need to Add Location Code (Vishnu) (Other Locations)

            UNTIL ProdOrdShortage1.NEXT = 0;
        Rec.RESET;

    end;

    var
        "Purchase Line": Record "Purchase Line";
        QILE: Record "Quality Item Ledger Entry";
        ITEM1: Record Item;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ProdOrdShortage: Record "Production Order Shortage Item";
        ProdOrdShortage1: Record "Production Order Shortage Item";
        "Stock at Stores": Decimal;
        "Stock at CS Stores": Decimal;
        "Stock at RD Stores": Decimal;
        "Stock at MCH": Decimal;
        MaterialIssueHeader: Record "Material Issues Header";
        MaterialIssueLine: Record "Material Issues Line";
        USER: Record User;
        LineNo: Integer;
        Body: Text[1000];
        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        Mail_To: Text[250];
        Subject: Text[250];
        UserSetup: Record "User Setup";
        CurrentUserID: Text[50];
        AuthorizedID: Text[50];
        MR: Record "Material Issues Header";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment: Text[1000];
        Total_shortage: Decimal;
        Req_stock: Decimal;
        Req_count: Decimal;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];


    procedure getStockValues();
    begin
        // Added by Rakesh to get the stock in stores, RD, CS and MCH on 15-Sep-14
        IF ITEM1.GET(Rec.Item) THEN BEGIN
            ITEM1.CALCFIELDS(ITEM1."Inventory at Stores");
            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection");
            ITEM1.CALCFIELDS(ITEM1."Quantity Rejected");
            ITEM1.CALCFIELDS(ITEM1."Stock At MCH Location");
            ITEM1.CALCFIELDS(ITEM1."Stock at CS Stores");
            ITEM1.CALCFIELDS(ITEM1."Stock at RD Stores");
            //Need to Add Location Code (Vishnu) (Other Locations)

            "Stock at MCH" := ITEM1."Stock At MCH Location";
            "Stock at CS Stores" := ITEM1."Stock at CS Stores";
            "Stock at RD Stores" := ITEM1."Stock at RD Stores";



            "Stock at Stores" := ITEM1."Inventory at Stores" - (ITEM1."Quantity Under Inspection" + ITEM1."Quantity Rejected");
            //Need to Add Location Code (Vishnu)  (Other Locations)
            IF "Stock at Stores" < 0 THEN
                "Stock at Stores" := 0;

            "Stock at Stores" := 0;

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework", ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores",
                ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores");
            //Need to Add Location Code (Vishnu) Other Locations

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Rec.Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                //Need to Add Location Code (Vishnu) (Other Locations)
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '<>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN

                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SETRANGE("Item No.", Rec.Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                //Need to Add Location Code (Vishnu) (Other Locations)
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                        QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                        (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                        AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);

                    UNTIL ItemLedgEntry.NEXT = 0;

            END;


            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT

                    "Stock at Stores" := "Stock at Stores" + ItemLedgEntry."Remaining Quantity";
                UNTIL ItemLedgEntry.NEXT = 0;

        END
        // end by Rakesh
    end;


    procedure GetStock(Item: Code[30]);
    begin
        IF ITEM1.GET(Item) THEN BEGIN
            ITEM1.CALCFIELDS(ITEM1."Inventory at Stores");
            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection");
            ITEM1.CALCFIELDS(ITEM1."Quantity Rejected");
            ITEM1.CALCFIELDS(ITEM1."Stock At MCH Location");
            ITEM1.CALCFIELDS(ITEM1."Stock at CS Stores");
            ITEM1.CALCFIELDS(ITEM1."Stock at RD Stores");

            //Need to Add Location Code (Vishnu) (Other Locations)

            "Stock at MCH" := ITEM1."Stock At MCH Location";
            "Stock at CS Stores" := ITEM1."Stock at CS Stores";
            "Stock at RD Stores" := ITEM1."Stock at RD Stores";



            "Stock at Stores" := ITEM1."Inventory at Stores" - (ITEM1."Quantity Under Inspection" + ITEM1."Quantity Rejected");
            IF "Stock at Stores" < 0 THEN
                "Stock at Stores" := 0;

            "Stock at Stores" := 0;

            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection", ITEM1."Quantity Rejected", ITEM1."Quantity Rework", ITEM1."Quantity Sent for Rework", ITEM1."Stock At MCH Location", ITEM1."Stock at CS Stores",
                ITEM1."Stock at RD Stores", ITEM1."Stock at PROD Stores");

            IF (ITEM1."Quantity Under Inspection" = 0) AND (ITEM1."Quantity Rejected" = 0) AND (ITEM1."Quantity Rework" = 0) AND (ITEM1."Quantity Sent for Rework" = 0) THEN BEGIN
                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");
                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                //Need to Add Location Code (Vishnu) (Other Locations)
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '<>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                    UNTIL ItemLedgEntry.NEXT = 0;
            END ELSE BEGIN

                ItemLedgEntry.RESET;
                ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SETRANGE("Item No.", Item);
                ItemLedgEntry.SETRANGE(Open, TRUE);
                ItemLedgEntry.SETRANGE("Location Code", 'STR');
                //Need to Add Location Code (Vishnu) (Other Locations)
                ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                IF ItemLedgEntry.FINDSET THEN
                    REPEAT
                        ItemLedgEntry.MARK(TRUE);
                        IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                        QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                        (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                        AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                            ItemLedgEntry.MARK(FALSE);

                    UNTIL ItemLedgEntry.NEXT = 0;

            END;


            ItemLedgEntry.MARKEDONLY(TRUE);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT

                    "Stock at Stores" := "Stock at Stores" + ItemLedgEntry."Remaining Quantity";
                UNTIL ItemLedgEntry.NEXT = 0;

        END
        // end by Rakesh
    end;


    procedure GetNextNo() NumberValue: Code[20];
    var
        DateValue: Text[30];
        MonthValue: Text[30];
        YearValue: Text[30];
        MaterialIssuesHeaderLocal: Record "Material Issues Header";
        PostedMatIssHeaderLocal: Record "Posted Material Issues Header";
        LastNumber: Code[20];
    begin
        IF DATE2DMY(WORKDATE, 1) < 10 THEN
            DateValue := '0' + FORMAT(DATE2DMY(WORKDATE, 1))
        ELSE
            DateValue := FORMAT(DATE2DMY(WORKDATE, 1));

        IF DATE2DMY(WORKDATE, 2) < 10 THEN
            MonthValue := '0' + FORMAT(DATE2DMY(WORKDATE, 2))
        ELSE
            MonthValue := FORMAT(DATE2DMY(WORKDATE, 2));

        IF DATE2DMY(WORKDATE, 2) <= 12 THEN
            YearValue := COPYSTR(FORMAT(DATE2DMY(WORKDATE, 3)), 3, 2);
        //IF ((TODAY=010810D) OR (TODAY=010910D) OR (TODAY=011010D))THEN
        //  NumberValue := 'V'+YearValue+MonthValue+DateValue
        //ELSE
        NumberValue := 'R' + YearValue + MonthValue + DateValue;

        LastNumber := NumberValue + '0000';
        MaterialIssuesHeaderLocal.RESET;
        MaterialIssuesHeaderLocal.SETFILTER("No.", NumberValue + '*');
        IF MaterialIssuesHeaderLocal.FINDLAST THEN
            LastNumber := MaterialIssuesHeaderLocal."No.";

        PostedMatIssHeaderLocal.RESET;
        PostedMatIssHeaderLocal.SETCURRENTKEY("Material Issue No.");
        PostedMatIssHeaderLocal.SETFILTER("Material Issue No.", NumberValue + '*');
        IF PostedMatIssHeaderLocal.FINDLAST THEN
            IF LastNumber < PostedMatIssHeaderLocal."Material Issue No." THEN
                LastNumber := PostedMatIssHeaderLocal."Material Issue No.";

        NumberValue := INCSTR(LastNumber);
    end;


    procedure VerifyRequest();
    begin
        // Added by Rakesh to verify request already created for Item on 17-Sep-14
        //Req_created := FALSE;
        MaterialIssueHeader.RESET;
        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

        IF MaterialIssueHeader.FINDSET THEN
            REPEAT
                IF (MaterialIssueHeader."Transfer-from Code" = 'STR') THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                    IF MaterialIssueLine.FINDSET THEN
                        REPEAT
                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                Rec.CreateReq_STR := FALSE;
                                Rec.Req_created := TRUE;
                                //        ProdOrdShortage.MODIFY;
                            END
                        UNTIL MaterialIssueLine.NEXT = 0;
                END;

                IF (MaterialIssueHeader."Transfer-from Code" = 'CS STR') THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                    IF MaterialIssueLine.FINDSET THEN
                        REPEAT
                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                Rec.CreateReq_CS := FALSE;
                                Rec.Req_created := TRUE;
                                //      ProdOrdShortage.MODIFY;
                            END
                        UNTIL MaterialIssueLine.NEXT = 0;
                END;

                IF (MaterialIssueHeader."Transfer-from Code" = 'R&D STR') THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                    IF MaterialIssueLine.FINDSET THEN
                        REPEAT
                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                Rec.CreateReq_RD := FALSE;
                                Rec.Req_created := TRUE;
                                //    ProdOrdShortage.MODIFY;
                            END
                        UNTIL MaterialIssueLine.NEXT = 0;
                END;

                IF (MaterialIssueHeader."Transfer-from Code" = 'MCH') THEN BEGIN
                    MaterialIssueLine.RESET;
                    MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");
                    IF MaterialIssueLine.FINDSET THEN
                        REPEAT
                            IF (MaterialIssueLine."Item No." = Rec.Item) THEN BEGIN
                                Rec.CreateReq_MCH := FALSE;
                                Rec.Req_created := TRUE;
                                //  ProdOrdShortage.MODIFY;
                            END
                        UNTIL MaterialIssueLine.NEXT = 0;
                END;

            // Need to Add Locations Code(Vishnu) Other Locations

            UNTIL MaterialIssueHeader.NEXT = 0;
        // End by Rakesh
    end;


    procedure AuthMail();
    begin
        //MESSAGE(MaterialIssueHeader."No.");
        /* Body := '';
        IF MaterialIssueHeader."Prod. Order No." = '' THEN
            ERROR('You must specify Production order no in Material Requests Header');

        IF MaterialIssueHeader."Prod. Order Line No." = 0 THEN
            ERROR('You must specify Production order line no in Material Requests Header');

        IF MaterialIssueHeader."Request for Authorization" = '' THEN
            ERROR('You must specify Authorised Person at Material Issues Header');

        MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");

        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                IF MaterialIssueLine.Quantity = 0 THEN
                    ERROR('You must specify the Quantity at Material Issues Line part');
            UNTIL MaterialIssueLine.NEXT = 0;

        "Mail-Id".SETRANGE("Mail-Id"."User Name", USERID);

        IF "Mail-Id".FINDFIRST THEN
            "from Mail" := "Mail-Id".MailID
        ELSE
            ERROR('You do not Have Mail id in ERP & Please inform the ERP Administrator to Create your Mail id');

        "Mail-Id".RESET;
        "Mail-Id".SETRANGE("Mail-Id"."User Name", MaterialIssueHeader."Request for Authorization");
        IF "Mail-Id".FINDFIRST THEN BEGIN
            IF "Mail-Id".levels = TRUE THEN
                Mail_To := "Mail-Id".MailID
            ELSE
                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
        END;

        Subject := 'ERP- Material Request for Authorisation' + FORMAT(MaterialIssueHeader."No.");

        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="center">';
        Body += '<tr><td>Requested No</td><td>' + MaterialIssueHeader."No." + '</td></tr><br>';
        Body += '<tr><td>Requested User</td><td>' + MaterialIssueHeader."User ID" + ':  ' + MaterialIssueHeader."Resource Name" + '</td></tr><br>';
        Body += '<tr><td>Project Name</td><td>' + MaterialIssueHeader."Proj Description" + '</td></tr>';
        Body += '<tr><td bgcolor="green">';

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            CurrentUserID := UserSetup."Current UserId";
        END;



        Body += '<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT(MaterialIssueHeader."No.") + '&val2=' + FORMAT(CurrentUserID);

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", MaterialIssueHeader."Request for Authorization");
        IF UserSetup.FINDFIRST THEN BEGIN
            AuthorizedID := UserSetup."Current UserId";
        END;


        Body += '&val3=' + FORMAT(AuthorizedID);
        Body += '&val4=1';
        Body += '&val5=' + Mail_To;
        Body += '&val6=' + "from Mail";
        Body += '&val7=Accepted"target="_blank">';
        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
        Body += '</td><td bgcolor="red">';
        Body += '<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT(MaterialIssueHeader."No.");
        Body += '&val2=' + FORMAT(CurrentUserID);
        Body += '&val3=' + FORMAT(AuthorizedID);
        Body += '&val4=0';
        Body += '&val5=' + Mail_To;
        Body += '&val6=' + "from Mail";
        Body += '&val7=Rejected';
        Body += '"target="_blank">';
        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
        Body += '</table></form></font></strong></body>';
        MR.SETRANGE(MR."No.", MaterialIssueHeader."No.");
        IF MR.FINDFIRST THEN
            REPORT.RUN(33000890, FALSE, FALSE, MR);
        REPORT.SAVEASPDF(33000890, '\\erpserver\ErpAttachments\ErpAttachments1\' + MaterialIssueHeader."No." + '.pdf', MR);
        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + MaterialIssueHeader."No." + '.pdf';

        SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
        SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
        SMTP_MAIL.Send; */      //B2B UPG

        Body := '';
        IF MaterialIssueHeader."Prod. Order No." = '' THEN
            ERROR('You must specify Production order no in Material Requests Header');

        IF MaterialIssueHeader."Prod. Order Line No." = 0 THEN
            ERROR('You must specify Production order line no in Material Requests Header');

        IF MaterialIssueHeader."Request for Authorization" = '' THEN
            ERROR('You must specify Authorised Person at Material Issues Header');

        MaterialIssueLine.SETRANGE(MaterialIssueLine."Document No.", MaterialIssueHeader."No.");

        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                IF MaterialIssueLine.Quantity = 0 THEN
                    ERROR('You must specify the Quantity at Material Issues Line part');
            UNTIL MaterialIssueLine.NEXT = 0;

        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);

        /* IF "Mail-Id".FINDFIRST THEN
            "from Mail" := "Mail-Id".MailID
        ELSE
            ERROR('You do not Have Mail id in ERP & Please inform the ERP Administrator to Create your Mail id'); */

        "Mail-Id".RESET;
        "Mail-Id".SETRANGE("Mail-Id"."User ID", MaterialIssueHeader."Request for Authorization");
        IF "Mail-Id".FINDFIRST THEN BEGIN
            IF "Mail-Id".levels = TRUE THEN begin

                Recipients.Add("Mail-Id".MailID);
            end
            ELSE
                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
        END;

        Subject := 'ERP- Material Request for Authorisation' + FORMAT(MaterialIssueHeader."No.");

        Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
        Body += 'border="1" align="center">';
        Body += '<tr><td>Requested No</td><td>' + MaterialIssueHeader."No." + '</td></tr><br>';
        Body += '<tr><td>Requested User</td><td>' + MaterialIssueHeader."User ID" + ':  ' + MaterialIssueHeader."Resource Name" + '</td></tr><br>';
        Body += '<tr><td>Project Name</td><td>' + MaterialIssueHeader."Proj Description" + '</td></tr>';
        Body += '<tr><td bgcolor="green">';

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            CurrentUserID := UserSetup."Current UserId";
        END;



        Body += '<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT(MaterialIssueHeader."No.") + '&val2=' + FORMAT(CurrentUserID);

        UserSetup.RESET;
        UserSetup.SETRANGE("User ID", MaterialIssueHeader."Request for Authorization");
        IF UserSetup.FINDFIRST THEN BEGIN
            AuthorizedID := UserSetup."Current UserId";
        END;


        Body += '&val3=' + FORMAT(AuthorizedID);
        Body += '&val4=1';
        Body += '&val5=' /* + Mail_To */;
        Body += '&val6=' /* + "from Mail" */;
        Body += '&val7=Accepted"target="_blank">';
        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
        Body += '</td><td bgcolor="red">';
        Body += '<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT(MaterialIssueHeader."No.");
        Body += '&val2=' + FORMAT(CurrentUserID);
        Body += '&val3=' + FORMAT(AuthorizedID);
        Body += '&val4=0';
        Body += '&val5=' /* + Mail_To */;
        Body += '&val6=' /* + "from Mail" */;
        Body += '&val7=Rejected';
        Body += '"target="_blank">';
        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
        Body += '</table></form></font></strong></body>';
        MR.SETRANGE(MR."No.", MaterialIssueHeader."No.");
        IF MR.FINDFIRST THEN
            REPORT.RUN(33000890, FALSE, FALSE, MR);
        REPORT.SAVEASPDF(33000890, '\\erpserver\ErpAttachments\ErpAttachments1\' + MaterialIssueHeader."No." + '.pdf', MR);
        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + MaterialIssueHeader."No." + '.pdf';

        //SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
        EmailMessage.Create(Recipients, Subject, Body, true);
        //SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
        EmailMessage.AddAttachment(Attachment, '', '');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
        Rec.MODIFY;

        MESSAGE('Material Request ' + MaterialIssueHeader."No." + ' is created. Mail is Sent to Store Manager');
        //end by rakesh
    end;
}

