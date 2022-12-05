page 50012 "Shortage Cumulative1"
{
    PageType = List;
    SourceTable = "Production Order Shortage Item";
    SourceTableTemporary = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Control1102152069)
            {
                ShowCaption = false;
                Visible = true;
                field(NoOfDays; NoOfDays)
                {
                    Caption = 'No Of Days';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        GrecProdOrderShrtg1.RESET;
                        GrecProdOrderShrtg1.SETCURRENTKEY("Prod. Start Date");
                        IF GrecProdOrderShrtg1.FINDFIRST THEN
                            First_Date1 := GrecProdOrderShrtg1."Prod. Start Date";
                        GrecProdOrderShrtg1.RESET;
                        GrecProdOrderShrtg1.SETCURRENTKEY("Prod. Start Date");
                        IF GrecProdOrderShrtg1.FINDLAST THEN
                            Last_Date1 := GrecProdOrderShrtg1."Prod. Start Date";

                        IF (NoOfDays > (Last_Date1 - First_Date1) + 1) OR (NoOfDays <= 0) THEN
                            ERROR('Please Select between 1 to' + FORMAT((Last_Date1 - First_Date1) + 1) + ' Only!');
                        SetValues(NoOfDays);
                        //PAGE.RUN(50012);
                        FieldsVisible;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                field(Include_QC_Stock; Include_QC_Stock)
                {
                    Caption = 'Include QC Stock';
                    Visible = vis;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_CS_Stock; Include_CS_Stock)
                {
                    Caption = 'Include CS Stock';
                    Visible = vis;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_RD_Stock; Include_RD_Stock)
                {
                    Caption = 'Include RD Stock';
                    Visible = vis;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_Purch_Qty; Include_Purch_Qty)
                {
                    Caption = 'Include Purch Qty';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_MCH_Stock; Include_MCH_Stock)
                {
                    Caption = 'Include_MCH_Stock(For STR Shortage)';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_STR_Stock; Include_STR_Stock)
                {
                    Caption = 'Include_STR_Stock(For MCH shortage)';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_Alt_Items_Qty; Include_Alt_Items_Qty)
                {
                    Caption = 'Include Alt Items Purch Qty';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_Alt_Items_MCH_QTY; Include_Alt_Items_MCH_QTY)
                {
                    Visible = vis1;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Include_Alt_Items_STR_QTY; Include_Alt_Items_STR_QTY)
                {
                    Visible = vis1;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Include_Stock;
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Show_Only_Shortage_Items; Show_Only_Shortage_Items)
                {
                    Caption = 'Show Only Shortage Items';
                    Visible = vis;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Show_Only_Shortg_Itms;
                    end;
                }
                field(Show_Only_Crital_Items; Show_Only_Crital_Items)
                {
                    Caption = 'Show Only Critical Items';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Show_Only_Critical_Itms;
                    end;
                }
            }
            repeater(Group)
            {
                FreezeColumn = "Total Shortage";
                field(Item; Rec.Item)
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field(Shortage; Rec.Shortage)
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortage At"; Rec."Shortage At")
                {
                    Enabled = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field("Total Shortage"; Rec."Total Shortage")
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field("Qty. in Purchase Orders"; Rec."Qty. in Purchase Orders")
                {
                    Editable = false;
                    StyleExpr = Color_Critical_Items;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        "Purchase Line".RESET;
                        "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                        "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                        "Purchase Line".SETRANGE("Purchase Line"."No.", Rec.Item);
                        "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR'); // Need to Add Location Code (VISHNU)
                        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                        PAGE.RUNMODAL(56, "Purchase Line");
                    end;
                }
                field("Total Shortage Inc Purch Qty"; Rec."Total Shortage Inc Purch Qty")
                {
                    Caption = 'Total Shortage Inc Stock Considerations';
                    Editable = false;
                    StyleExpr = Color_Critical_Items;
                    ApplicationArea = All;
                }
                field("Alt Item Qty. in Purch Orders"; Rec."Alt Item Qty. in Purch Orders")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        ProdGrpsList := 'ALL PRODUCTS|';
                        Prev_ProdGrp := '';
                        ProdOrdShortage.RESET;
                        ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, Rec.Item);
                        ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", Rec."Shortage At");
                        IF ProdOrdShortage.FINDSET THEN
                            REPEAT
                                ProdOrdr.RESET;
                                ProdOrdr.SETRANGE(ProdOrdr.Status, ProdOrdr.Status::Released);
                                ProdOrdr.SETRANGE(ProdOrdr."No.", ProdOrdShortage."Production Order");
                                IF ProdOrdr.FINDFIRST THEN BEGIN
                                    IF ProdOrdr."Item Sub Group Code" <> '' THEN BEGIN
                                        IF Prev_ProdGrp <> ProdOrdr."Item Sub Group Code" THEN
                                            ProdGrpsList := ProdGrpsList + ProdOrdr."Item Sub Group Code" + '|';
                                        Prev_ProdGrp := ProdOrdr."Item Sub Group Code";
                                    END ELSE BEGIN
                                        IF ITEM1.GET(ProdOrdr."Source No.") THEN BEGIN
                                            IF ITEM1."Item Sub Group Code" <> '' THEN BEGIN
                                                IF Prev_ProdGrp <> ITEM1."Item Sub Group Code" THEN
                                                    ProdGrpsList := ProdGrpsList + ITEM1."Item Sub Group Code" + '|';
                                                Prev_ProdGrp := ITEM1."Item Sub Group Code";
                                            END;
                                        END;
                                    END;
                                END;
                            UNTIL ProdOrdShortage.NEXT = 0;
                        ProdGrpsList := COPYSTR(ProdGrpsList, 1, STRLEN(ProdGrpsList) - 1);
                        Alt_Items_List := '';
                        Prev_Alt_Itm := '';
                        Alt_Items.RESET;
                        Alt_Items.SETCURRENTKEY("Alternative Item No.");
                        Alt_Items.SETRANGE(Alt_Items."Item No.", Rec.Item);
                        Alt_Items.SETFILTER(Alt_Items."Proudct Type", ProdGrpsList);
                        IF Alt_Items.FINDSET THEN
                            REPEAT
                                IF Prev_Alt_Itm <> Alt_Items."Alternative Item No." THEN
                                    Alt_Items_List := Alt_Items_List + Alt_Items."Alternative Item No." + '|';
                                Prev_Alt_Itm := Alt_Items."Alternative Item No.";
                            UNTIL Alt_Items.NEXT = 0;
                        IF NOT (Alt_Items_List IN ['', ' ']) THEN
                            Alt_Items_List := COPYSTR(Alt_Items_List, 1, STRLEN(Alt_Items_List) - 1);
                        //MESSAGE(Alt_Items_List+'\'+ProdGrpsList);
                        "Purchase Line".RESET;
                        "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                        "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                        "Purchase Line".SETFILTER("Purchase Line"."No.", Alt_Items_List);
                        "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR'); // Need to Add Location Code (VISHNU)
                        "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                        PAGE.RUN(518, "Purchase Line");
                    end;
                }
                field("Alt Item PO No"; Rec."Alt Item PO No")
                {
                    ApplicationArea = All;
                }
                field("Alt Item Vendor No"; Rec."Alt Item Vendor No")
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
                        QILE.SETRANGE(QILE."Location Code", 'STR'); // Need to Add Location Code (VISHNU)
                        QILE.SETRANGE(QILE.Accept, TRUE);
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
                        // Need to Add Location Code (VISHNU) other locations

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

                        // Need to Add Location Code (VISHNU) other loactions 2

                        IF Req_count > 1 THEN
                            ERROR('More stock is selected, kindly select the required quantity');


                        MaterialIssueHeader.RESET;
                        MaterialIssueHeader.SETRANGE(MaterialIssueHeader.Remarks, 'Item Transfer');

                        IF MaterialIssueHeader.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueHeader."Transfer-from Code" = 'STR') THEN  // Need to Add Location Code (VISHNU)
                                BEGIN
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
                        // Need to Add Location Code (VISHNU) other locations inclusion

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
                        // Need to Add Location Code (VISHNU) other locations conditions need to include

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

                        // Need to Add Location Code (VISHNU) other locations

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
                field("Earliest Material Arrival Date"; Rec."Earliest Material Arrival Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Earliest Material Arrival Qty"; Rec."Earliest Material Arrival Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Earliest Material Shortage Dat"; Rec."Earliest Material Shortage Dat")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Earliest Material Shortage Qty"; Rec."Earliest Material Shortage Qty")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + ColumnCaptions[1];
                    DrillDown = true;
                    Editable = false;
                    Visible = Field1Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[1]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    CaptionClass = '3,' + ColumnCaptions[2];
                    Editable = false;
                    Visible = Field2Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[2]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    CaptionClass = '3,' + ColumnCaptions[3];
                    Editable = false;
                    Visible = Field3Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[3]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    CaptionClass = '3,' + ColumnCaptions[4];
                    Editable = false;
                    Visible = Field4Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[4]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    CaptionClass = '3,' + ColumnCaptions[5];
                    Editable = false;
                    Visible = Field5Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[5]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    CaptionClass = '3,' + ColumnCaptions[6];
                    Editable = false;
                    Visible = Field6Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[6]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    CaptionClass = '3,' + ColumnCaptions[7];
                    Editable = false;
                    Visible = Field7Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[7]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    CaptionClass = '3,' + ColumnCaptions[8];
                    Editable = false;
                    Visible = Field8Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[8]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    CaptionClass = '3,' + ColumnCaptions[9];
                    Editable = false;
                    Visible = Field9Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[9]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    CaptionClass = '3,' + ColumnCaptions[10];
                    Editable = false;
                    Visible = Field10Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[10]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    CaptionClass = '3,' + ColumnCaptions[11];
                    Editable = false;
                    Visible = Field11Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[11]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    CaptionClass = '3,' + ColumnCaptions[12];
                    Editable = false;
                    Visible = Field12Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[12]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    CaptionClass = '3,' + ColumnCaptions[13];
                    Editable = false;
                    Visible = Field13Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[13]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    CaptionClass = '3,' + ColumnCaptions[14];
                    Editable = false;
                    Visible = Field14Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[14]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    CaptionClass = '3,' + ColumnCaptions[15];
                    Editable = false;
                    Visible = Field15Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[15]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    CaptionClass = '3,' + ColumnCaptions[16];
                    Editable = false;
                    Visible = Field16Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[16]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    CaptionClass = '3,' + ColumnCaptions[17];
                    Editable = false;
                    Visible = Field17Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[17]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    CaptionClass = '3,' + ColumnCaptions[18];
                    Editable = false;
                    Visible = Field18Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[18]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    CaptionClass = '3,' + ColumnCaptions[19];
                    Editable = false;
                    Visible = Field19Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[19]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    CaptionClass = '3,' + ColumnCaptions[20];
                    Editable = false;
                    Visible = Field20Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[20]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field21; MATRIX_CellData[21])
                {
                    CaptionClass = '3,' + ColumnCaptions[21];
                    Editable = false;
                    Visible = Field21Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[21]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    CaptionClass = '3,' + ColumnCaptions[22];
                    Editable = false;
                    Visible = Field22Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[22]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    CaptionClass = '3,' + ColumnCaptions[23];
                    Editable = false;
                    Visible = Field23Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[23]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    CaptionClass = '3,' + ColumnCaptions[24];
                    Editable = false;
                    Visible = Field24Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[24]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    CaptionClass = '3,' + ColumnCaptions[25];
                    Editable = false;
                    Visible = Field25Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[25]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    CaptionClass = '3,' + ColumnCaptions[26];
                    Editable = false;
                    Visible = Field26Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[26]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    CaptionClass = '3,' + ColumnCaptions[27];
                    Editable = false;
                    Visible = Field27Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[27]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    CaptionClass = '3,' + ColumnCaptions[28];
                    Editable = false;
                    Visible = Field28Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[28]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    CaptionClass = '3,' + ColumnCaptions[29];
                    Editable = false;
                    Visible = Field29Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[29]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    CaptionClass = '3,' + ColumnCaptions[30];
                    Editable = false;
                    Visible = Field30Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[30]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field31; MATRIX_CellData[31])
                {
                    CaptionClass = '3,' + ColumnCaptions[31];
                    Editable = false;
                    Visible = Field31Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[31]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field32; MATRIX_CellData[32])
                {
                    CaptionClass = '3,' + ColumnCaptions[32];
                    Editable = false;
                    Visible = Field32Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[32]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field33; MATRIX_CellData[33])
                {
                    CaptionClass = '3,' + ColumnCaptions[33];
                    Editable = false;
                    Visible = Field33Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[3]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field34; MATRIX_CellData[34])
                {
                    CaptionClass = '3,' + ColumnCaptions[34];
                    Editable = false;
                    Visible = Field34Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[34]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field35; MATRIX_CellData[35])
                {
                    CaptionClass = '3,' + ColumnCaptions[35];
                    Editable = false;
                    Visible = Field35Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[35]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field36; MATRIX_CellData[36])
                {
                    CaptionClass = '3,' + ColumnCaptions[36];
                    Editable = false;
                    Visible = Field36Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[36]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field37; MATRIX_CellData[37])
                {
                    CaptionClass = '3,' + ColumnCaptions[37];
                    Editable = false;
                    Visible = Field37Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[37]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field38; MATRIX_CellData[38])
                {
                    CaptionClass = '3,' + ColumnCaptions[38];
                    Editable = false;
                    Visible = Field38Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[38]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field39; MATRIX_CellData[39])
                {
                    CaptionClass = '3,' + ColumnCaptions[39];
                    Editable = false;
                    Visible = Field39Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[39]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field40; MATRIX_CellData[40])
                {
                    CaptionClass = '3,' + ColumnCaptions[40];
                    Editable = false;
                    Visible = Field40Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[40]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field41; MATRIX_CellData[41])
                {
                    CaptionClass = '3,' + ColumnCaptions[41];
                    Editable = false;
                    Visible = Field41Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[41]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field42; MATRIX_CellData[42])
                {
                    CaptionClass = '3,' + ColumnCaptions[42];
                    Editable = false;
                    Visible = Field42Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[42]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field43; MATRIX_CellData[43])
                {
                    CaptionClass = '3,' + ColumnCaptions[43];
                    Editable = false;
                    Visible = Field43Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[43]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field44; MATRIX_CellData[44])
                {
                    CaptionClass = '3,' + ColumnCaptions[44];
                    Editable = false;
                    Visible = Field44Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[44]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field45; MATRIX_CellData[45])
                {
                    CaptionClass = '3,' + ColumnCaptions[45];
                    Editable = false;
                    Visible = Field45Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[45]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field46; MATRIX_CellData[46])
                {
                    CaptionClass = '3,' + ColumnCaptions[46];
                    Editable = false;
                    Visible = Field46Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[46]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field47; MATRIX_CellData[47])
                {
                    CaptionClass = '3,' + ColumnCaptions[47];
                    Editable = false;
                    Visible = Field47Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[47]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field48; MATRIX_CellData[48])
                {
                    CaptionClass = '3,' + ColumnCaptions[48];
                    Editable = false;
                    Visible = Field48Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[48]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field49; MATRIX_CellData[49])
                {
                    CaptionClass = '3,' + ColumnCaptions[49];
                    Editable = false;
                    Visible = Field49Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[49]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field50; MATRIX_CellData[50])
                {
                    CaptionClass = '3,' + ColumnCaptions[50];
                    Editable = false;
                    Visible = Field50Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[50]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field51; MATRIX_CellData[51])
                {
                    CaptionClass = '3,' + ColumnCaptions[51];
                    Editable = false;
                    Visible = Field51Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[51]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field52; MATRIX_CellData[52])
                {
                    CaptionClass = '3,' + ColumnCaptions[52];
                    Editable = false;
                    Visible = Field52Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[52]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field53; MATRIX_CellData[53])
                {
                    CaptionClass = '3,' + ColumnCaptions[53];
                    Editable = false;
                    Visible = Field53Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[53]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field54; MATRIX_CellData[54])
                {
                    CaptionClass = '3,' + ColumnCaptions[54];
                    Editable = false;
                    Visible = Field54Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[54]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field55; MATRIX_CellData[55])
                {
                    CaptionClass = '3,' + ColumnCaptions[55];
                    Editable = false;
                    Visible = Field55Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[55]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field56; MATRIX_CellData[56])
                {
                    CaptionClass = '3,' + ColumnCaptions[56];
                    Editable = false;
                    Visible = Field56Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[56]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field57; MATRIX_CellData[57])
                {
                    CaptionClass = '3,' + ColumnCaptions[57];
                    Editable = false;
                    Visible = Field57Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[57]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field58; MATRIX_CellData[58])
                {
                    CaptionClass = '3,' + ColumnCaptions[58];
                    Editable = false;
                    Visible = Field58Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[58]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field59; MATRIX_CellData[59])
                {
                    CaptionClass = '3,' + ColumnCaptions[59];
                    Editable = false;
                    Visible = Field59Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[59]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
                field(Field60; MATRIX_CellData[60])
                {
                    CaptionClass = '3,' + ColumnCaptions[60];
                    Editable = false;
                    Visible = Field60Visible;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PO_SHORTAGEITEMS.SETRANGE(PO_SHORTAGEITEMS.Item, Rec.Item);
                        PO_SHORTAGEITEMS.SETFILTER(PO_SHORTAGEITEMS."Prod. Start Date", ColumnCaptions[60]);
                        PAGE.RUN(60143, PO_SHORTAGEITEMS);
                    end;
                }
            }
            group(Control1102152067)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152066)
                {
                    ShowCaption = false;
                    group(Control1102152065)
                    {
                        ShowCaption = false;
                        field("TotalItemsCount+FORMAT(xRec.COUNT)"; TotalItemsCount + FORMAT(xRec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152076)
                    {
                        ShowCaption = false;
                        field("TotalShortageItemsCount+FORMAT(Tot_Shortg_Items_Cnt)"; TotalShortageItemsCount + FORMAT(Tot_Shortg_Items_Cnt))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152063)
                    {
                        ShowCaption = false;
                        field(ColorText; ColorText)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152112)
                    {
                        ShowCaption = false;
                        field(ColorText_1; ColorText_1)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102152058; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1102152057; Notes)
            {
                Visible = true;
                ApplicationArea = All;
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
                Promoted = true;
                PromotedCategory = Process;
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
            action(PurchaseFollowUp)
            {
                Caption = 'Purchase Follow Up1';
                Promoted = false;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETFILTER("Purchase Line".Type, '%1', "Purchase Line".Type::Item);
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                    PAGE.RUNMODAL(56, "Purchase Line");
                end;
            }
            action(PurchFollowUp)
            {
                Caption = 'Purchase Follow Up';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    PFU: Page "Purchase FollowUp";
                begin
                    //Added by vijaya on 06-Aug-2016 for Differentiate Shortage Page and To be Relese Orders
                    PFU.PagePurpose('Shortage');
                    PFU.RUN;
                    //PAGE.RUN(50013);  commented by vijaya on 06-Aug-2016
                end;
            }
            action("Alternate Item")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ProdGrpsList := 'ALL PRODUCTS|';
                    Prev_ProdGrp := '';
                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, Rec.Item);
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", Rec."Shortage At");
                    IF ProdOrdShortage.FINDSET THEN
                        REPEAT
                            ProdOrdr.RESET;
                            ProdOrdr.SETRANGE(ProdOrdr.Status, ProdOrdr.Status::Released);
                            ProdOrdr.SETRANGE(ProdOrdr."No.", ProdOrdShortage."Production Order");
                            IF ProdOrdr.FINDFIRST THEN BEGIN
                                IF ProdOrdr."Item Sub Group Code" <> '' THEN BEGIN
                                    IF Prev_ProdGrp <> ProdOrdr."Item Sub Group Code" THEN
                                        ProdGrpsList := ProdGrpsList + ProdOrdr."Item Sub Group Code" + '|';
                                    Prev_ProdGrp := ProdOrdr."Item Sub Group Code";
                                END ELSE BEGIN
                                    IF ITEM1.GET(ProdOrdr."Source No.") THEN BEGIN
                                        IF Prev_ProdGrp <> ITEM1."Item Sub Group Code" THEN
                                            ProdGrpsList := ProdGrpsList + ITEM1."Item Sub Group Code" + '|';
                                        Prev_ProdGrp := ITEM1."Item Sub Group Code";
                                    END;
                                END;
                            END;
                        UNTIL ProdOrdShortage.NEXT = 0;
                    ProdGrpsList := COPYSTR(ProdGrpsList, 1, STRLEN(ProdGrpsList) - 1);

                    Alt_Items.RESET;
                    Alt_Items.SETRANGE(Alt_Items."Item No.", Rec.Item);
                    Alt_Items.SETFILTER(Alt_Items."Proudct Type", ProdGrpsList);
                    PAGE.RUN(60070, Alt_Items);
                end;
            }
            action("Export To Excel")
            {
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ExporttoExcel;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        FiristShrtgFind := FALSE;
        getStockValues(Rec.Item);
        Include_Stock_For_Record(Rec.Item);
        VerifyRequest;
        FOR i := 1 TO 60 DO BEGIN
            MATRIX_CellData[i] := 0;
        END;

        Rec."Earliest Material Shortage Dat" := 0D;
        Rec."Earliest Material Shortage Qty" := 0;

        ProdOrdShortageRec.RESET;
        ProdOrdShortageRec.SETCURRENTKEY(Item, "Prod. Start Date");
        ProdOrdShortageRec.SETFILTER(ProdOrdShortageRec.Item, Rec.Item);
        ProdOrdShortageRec.SETRANGE(ProdOrdShortageRec."Shortage At", Rec."Shortage At");
        IF ProdOrdShortageRec.FINDSET THEN
            REPEAT
                FOR i := 1 TO 60 DO BEGIN
                    tempdate := 0D;
                    EVALUATE(tempdate, ColumnCaptions[i]);
                    IF ProdOrdShortageRec."Prod. Start Date" = tempdate THEN BEGIN
                        IF Tot_Stock_Inc_Others > 0 THEN BEGIN
                            IF ProdOrdShortageRec.Shortage > Tot_Stock_Inc_Others THEN BEGIN
                                MATRIX_CellData[i] += (ProdOrdShortageRec.Shortage - Tot_Stock_Inc_Others);
                                Tot_Stock_Inc_Others := 0;
                            END ELSE BEGIN
                                Tot_Stock_Inc_Others -= ProdOrdShortageRec.Shortage;
                            END;
                        END ELSE BEGIN
                            MATRIX_CellData[i] += (ProdOrdShortageRec.Shortage - Tot_Stock_Inc_Others);
                        END;
                        i := 60;
                    END;
                END;
            UNTIL ProdOrdShortageRec.NEXT = 0;
        FOR i := 1 TO 60 DO BEGIN
            tempdate := 0D;
            EVALUATE(tempdate, ColumnCaptions[i]);
            IF MATRIX_CellData[i] > 0 THEN BEGIN
                Rec."Earliest Material Shortage Dat" := tempdate;
                Rec."Earliest Material Shortage Qty" := MATRIX_CellData[i];
                i := 60;
            END;
        END;
        Rec.MODIFY;
        Color_Shotg_Inc_Purch := '';
        IF Rec."Total Shortage Inc Purch Qty" > 0 THEN
            Color_Shotg_Inc_Purch := 'Ambiguous';
        Color_Critical_Items := '';

        IF (Rec."Earliest Material Shortage Qty" > 0) THEN BEGIN
            IF (Rec."Earliest Material Arrival Date" = 0D) THEN
                Color_Critical_Items := 'Unfavorable'
            ELSE BEGIN
                IF (Rec."Earliest Material Arrival Date" < Rec."Earliest Material Shortage Dat") THEN BEGIN
                    IF (Rec."Earliest Material Shortage Qty" > Rec."Earliest Material Arrival Qty") THEN
                        Color_Critical_Items := 'Unfavorable';
                END ELSE
                    Color_Critical_Items := 'Unfavorable';
            END;
        END;
    end;

    trigger OnInit();
    begin
        FieldsVisible;
        IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\ANVESH', 'EFFTRONICS\PKOTESWARARAO',
          'EFFTRONICS\VANIDEVI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            vis := TRUE
        ELSE
            vis := FALSE;

        IF USERID IN ['EFFTRONICS\SUJANI'] THEN
            vis1 := TRUE
        ELSE
            vis1 := FALSE;

        //Include_Purch_Qty := TRUE;
    end;

    trigger OnOpenPage();
    begin
        Rec.DELETEALL;
        Tot_Shortg_Items_Cnt := 0;
        Rec.RESET;
        ProdOrdShortage1.RESET;
        ProdOrdShortage1.SETCURRENTKEY(Item, "Shortage At");
        IF ProdOrdShortage1.FINDSET THEN
            REPEAT
                Rec.RESET;
                Rec.SETRANGE(Item, ProdOrdShortage1.Item);
                Rec.SETRANGE("Shortage At", ProdOrdShortage1."Shortage At");
                IF NOT Rec.FINDFIRST THEN BEGIN
                    Rec.INIT;
                    Rec.Item := ProdOrdShortage1.Item;
                    Rec.Description := ProdOrdShortage1.Description;
                    Rec."Shortage At" := ProdOrdShortage1."Shortage At";
                    Rec.Remarks := ProdOrdShortage1.Remarks;
                    /*
                    "Qty. in Purchase Orders":=0;
                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type",'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.","Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETRANGE("Purchase Line"."No.",ProdOrdShortage1.Item);
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code",'STR');
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive",'>%1',0);
                    IF "Purchase Line".FIND('-') THEN
                    REPEAT
                     "Qty. in Purchase Orders" +="Purchase Line"."Qty. to Receive";
                    UNTIL "Purchase Line".NEXT=0;


                    "Qty. Under Inspection":=0;
                    QILE.RESET;
                    QILE.SETCURRENTKEY(QILE."Posting Date",QILE."Item No.");
                    QILE.SETRANGE(QILE."Item No.",Item);
                    QILE.SETRANGE(QILE."Inspection Status",QILE."Inspection Status"::"Under Inspection");
                    QILE.SETRANGE(QILE."Sent for Rework",FALSE);
                    QILE.SETFILTER(QILE."Remaining Quantity",'>%1',0);
                    QILE.SETRANGE(QILE."Location Code",'STR');
                    QILE.SETRANGE(QILE.Accept,TRUE);
                    IF QILE.FIND('-') THEN
                    REPEAT
                      "Qty. Under Inspection"+=QILE."Remaining Quantity";
                    UNTIL QILE.NEXT=0;
                    */
                    Rec."Alt Item Qty. in Purch Orders" := 0;
                    ProdGrpsList := 'ALL PRODUCTS|';
                    Prev_ProdGrp := '';
                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, ProdOrdShortage1.Item);
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", ProdOrdShortage1."Shortage At");
                    IF ProdOrdShortage.FINDSET THEN
                        REPEAT
                            ProdOrdr.RESET;
                            ProdOrdr.SETRANGE(ProdOrdr.Status, ProdOrdr.Status::Released);
                            ProdOrdr.SETRANGE(ProdOrdr."No.", ProdOrdShortage."Production Order");
                            IF ProdOrdr.FINDFIRST THEN BEGIN
                                IF ProdOrdr."Item Sub Group Code" <> '' THEN BEGIN
                                    IF Prev_ProdGrp <> ProdOrdr."Item Sub Group Code" THEN
                                        ProdGrpsList := ProdGrpsList + ProdOrdr."Item Sub Group Code" + '|';
                                    Prev_ProdGrp := ProdOrdr."Item Sub Group Code";
                                END ELSE BEGIN
                                    IF ITEM1.GET(ProdOrdr."Source No.") THEN BEGIN
                                        IF ITEM1."Item Sub Group Code" <> '' THEN BEGIN
                                            IF Prev_ProdGrp <> ITEM1."Item Sub Group Code" THEN
                                                ProdGrpsList := ProdGrpsList + ITEM1."Item Sub Group Code" + '|';
                                            Prev_ProdGrp := ITEM1."Item Sub Group Code";
                                        END;
                                    END;
                                END;
                            END;
                        UNTIL ProdOrdShortage.NEXT = 0;
                    ProdGrpsList := COPYSTR(ProdGrpsList, 1, STRLEN(ProdGrpsList) - 1);
                    Prev_Alt_Itm := '';
                    Alt_Items.RESET;
                    Alt_Items.SETCURRENTKEY("Alternative Item No.");
                    Alt_Items.SETRANGE(Alt_Items."Item No.", ProdOrdShortage1.Item);
                    Alt_Items.SETFILTER(Alt_Items."Proudct Type", ProdGrpsList);
                    IF Alt_Items.FINDSET THEN
                        REPEAT
                            IF Prev_Alt_Itm <> Alt_Items."Alternative Item No." THEN BEGIN
                                "Purchase Line".RESET;
                                "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                                "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                                "Purchase Line".SETRANGE("Purchase Line"."No.", Alt_Items."Alternative Item No.");
                                "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR'); // Need to Add Location Code (VISHNU)
                                "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                                IF "Purchase Line".FIND('-') THEN
                                    REPEAT
                                        Rec."Alt Item Qty. in Purch Orders" += "Purchase Line"."Qty. to Receive";
                                        Rec."Alt Item Qty. in Purch Orders" += "Purchase Line"."Qty. to Receive";
                                        Rec."Alt Item PO No" := "Purchase Line"."Document No.";
                                        BEGIN
                                            vendor.RESET;
                                            IF vendor.GET("Purchase Line"."Buy-from Vendor No.") THEN
                                                Rec."Alt Item Vendor No" := vendor.Name

                                        END;
                                    UNTIL "Purchase Line".NEXT = 0;
                                Prev_Alt_Itm := Alt_Items."Alternative Item No.";
                            END;
                        UNTIL Alt_Items.NEXT = 0;

                    Total_shortage := 0;

                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETCURRENTKEY(Item, "Shortage At", "Prod. Start Date");
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, ProdOrdShortage1.Item);
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", ProdOrdShortage1."Shortage At");
                    IF ProdOrdShortage.FINDFIRST THEN
                        Rec."Earliest Material Shortage Dat" := ProdOrdShortage."Prod. Start Date";

                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETCURRENTKEY(Item, "Shortage At", "Prod. Start Date");
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, ProdOrdShortage1.Item);
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", ProdOrdShortage1."Shortage At");
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Prod. Start Date", Rec."Earliest Material Shortage Dat");
                    IF ProdOrdShortage.FINDSET THEN
                        REPEAT
                            Rec."Earliest Material Shortage Qty" += ProdOrdShortage.Shortage;
                        UNTIL ProdOrdShortage.NEXT = 0;

                    ProdOrdShortage.RESET;
                    ProdOrdShortage.SETRANGE(ProdOrdShortage.Item, ProdOrdShortage1.Item);
                    ProdOrdShortage.SETRANGE(ProdOrdShortage."Shortage At", ProdOrdShortage1."Shortage At");
                    IF ProdOrdShortage.FINDSET THEN
                        REPEAT
                            Total_shortage := Total_shortage + ProdOrdShortage.Shortage;
                        UNTIL ProdOrdShortage.NEXT = 0;
                    ProdOrdShortage."Total Shortage" := Total_shortage;
                    Rec."Total Shortage" := Total_shortage;
                    //"Total Shortage Inc Purch Qty" :="Total Shortage"-"Qty. in Purchase Orders";
                    Rec."Total Shortage Inc Purch Qty" := Rec."Total Shortage";
                    ProdOrdShortage1.CALCFIELDS(ProdOrdShortage1."Qty. in Purchase Orders", ProdOrdShortage1."Qty. Under Inspection");
                    Rec."Qty. in Purchase Orders" := ProdOrdShortage1."Qty. in Purchase Orders";
                    Rec."Qty. Under Inspection" := ProdOrdShortage1."Qty. Under Inspection";
                    getStockValues(ProdOrdShortage1.Item);
                    // Need to Add Location Code (VISHNU) Other Locations also Include
                    IF Rec."Shortage At" = 'MCH' THEN BEGIN
                        IF Rec."Total Shortage" > "Stock at Stores" THEN
                            Rec.INSERT;
                    END ELSE
                        IF Rec."Shortage At" = 'STR' THEN BEGIN
                            IF Rec."Total Shortage" > "Stock at MCH" THEN
                                Rec.INSERT;
                        END;
                END;
            UNTIL ProdOrdShortage1.NEXT = 0;
        Rec.RESET;
        //MESSAGE(FORMAT(Rec.COUNT));
        Calc_Shortage_items_Count;
        //MESSAGE(FORMAT(Rec.COUNT));

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

        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        Mail_To: Text[250];

        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        UserSetup: Record "User Setup";
        CurrentUserID: Text[50];
        AuthorizedID: Text[50];
        MR: Record "Material Issues Header";
        // SMTP_MAIL: Codeunit "SMTP Mail";
        Attachment: Text[1000];
        Total_shortage: Decimal;
        Req_stock: Decimal;
        Req_count: Decimal;

        Field1Visible: Boolean;

        Field2Visible: Boolean;

        Field3Visible: Boolean;

        Field4Visible: Boolean;

        Field5Visible: Boolean;

        Field6Visible: Boolean;

        Field7Visible: Boolean;

        Field8Visible: Boolean;

        Field9Visible: Boolean;

        Field10Visible: Boolean;

        Field11Visible: Boolean;

        Field12Visible: Boolean;

        Field13Visible: Boolean;

        Field14Visible: Boolean;

        Field15Visible: Boolean;

        Field16Visible: Boolean;

        Field17Visible: Boolean;

        Field18Visible: Boolean;

        Field19Visible: Boolean;

        Field20Visible: Boolean;

        Field21Visible: Boolean;

        Field22Visible: Boolean;

        Field23Visible: Boolean;

        Field24Visible: Boolean;

        Field25Visible: Boolean;

        Field26Visible: Boolean;

        Field27Visible: Boolean;

        Field28Visible: Boolean;

        Field29Visible: Boolean;

        Field30Visible: Boolean;

        Field31Visible: Boolean;

        Field32Visible: Boolean;

        Field33Visible: Boolean;

        Field34Visible: Boolean;

        Field35Visible: Boolean;

        Field36Visible: Boolean;

        Field37Visible: Boolean;

        Field38Visible: Boolean;

        Field39Visible: Boolean;

        Field40Visible: Boolean;

        Field41Visible: Boolean;

        Field42Visible: Boolean;

        Field43Visible: Boolean;

        Field44Visible: Boolean;

        Field45Visible: Boolean;

        Field46Visible: Boolean;

        Field47Visible: Boolean;

        Field48Visible: Boolean;

        Field49Visible: Boolean;

        Field50Visible: Boolean;

        Field51Visible: Boolean;

        Field52Visible: Boolean;

        Field53Visible: Boolean;

        Field54Visible: Boolean;

        Field55Visible: Boolean;

        Field56Visible: Boolean;

        Field57Visible: Boolean;

        Field58Visible: Boolean;

        Field59Visible: Boolean;

        Field60Visible: Boolean;
        MATRIX_CellData: array[1000000] of Decimal;
        ColumnCaptions: array[1000000] of Text[250];
        i: Integer;
        tempdate: Date;
        ProdOrdShortageRec: Record "Production Order Shortage Item";
        FieldVisible: array[32] of Boolean;
        PO_SHORTAGEITEMS: Record "Production Order Shortage Item";
        NoOfDays: Integer;
        Color_Shotg_Inc_Purch: Text;
        ColorText: Label 'Totage Shortage > Total Stock with considerations';
        TotalItemsCount: Label '"Total Items: "';
        LastDate: Date;
        FirstDate: Date;
        ColumnCaptionsDyn: array[60] of Text[250];
        Include_QC_Stock: Boolean;
        Include_CS_Stock: Boolean;
        Include_RD_Stock: Boolean;
        vis: Boolean;
        tempStock: Decimal;
        Include_Purch_Qty: Boolean;
        Show_Only_Shortage_Items: Boolean;
        vis1: Boolean;
        Include_MCH_Stock: Boolean;
        Include_STR_Stock: Boolean;
        TotalShortageItemsCount: Label '"Total Shortage Items: "';
        Tot_Shortg_Items_Cnt: Integer;
        Tot_Stock_Inc_Others: Decimal;
        Alt_Items: Record "Alternate Items";
        ProdOrdr: Record "Production Order";
        ProdGrpsList: Text;
        Include_Alt_Items_Qty: Boolean;
        Prev_ProdGrp: Code[30];
        Alt_Items_Page: Page "Alternate Items";
        Alt_Items_List: Text;
        Prev_Alt_Itm: Code[30];
        First_Date1: Date;
        Last_Date1: Date;
        GrecProdOrderShrtg1: Record "Production Order Shortage Item";
        FiristShrtgFind: Boolean;
        Color_Critical_Items: Text;
        ColorText_1: Label 'Critical Items';
        Show_Only_Crital_Items: Boolean;
        Excel: Boolean;
        TempExcelbuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        ExcelBuffer: Record "Excel Buffer";
        CriticalItem: Boolean;
        ShortageItem: Boolean;
        ItemType: Option " ",Shortage,Critical;
        Include_Alt_Items_MCH_QTY: Boolean;
        Include_Alt_Items_STR_QTY: Boolean;
        vendor: Record Vendor;
        NoOfRecords: Integer;
        Last_Direct_Unit_Cost: Decimal;


    procedure getStockValues(Item: Code[50]);
    begin
        // Added by Rakesh to get the stock in stores, RD, CS and MCH on 15-Sep-14
        IF ITEM1.GET(Item) THEN BEGIN
            ITEM1.CALCFIELDS(ITEM1."Inventory at Stores");
            ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection");
            ITEM1.CALCFIELDS(ITEM1."Quantity Rejected");
            ITEM1.CALCFIELDS(ITEM1."Stock At MCH Location");
            ITEM1.CALCFIELDS(ITEM1."Stock at CS Stores");
            ITEM1.CALCFIELDS(ITEM1."Stock at RD Stores");

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

        END;
        // end by Rakesh

        // added by Vishnu Priya on 02-02-2019
        ITEM1.RESET;
        ITEM1.SETCURRENTKEY("No.", Description);
        ITEM1.SETFILTER("No.", Item);
        IF ITEM1.FINDFIRST THEN
            Last_Direct_Unit_Cost := ITEM1."Last Direct Cost";
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

        // SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
        EmailMessage.Create()
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

        // SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
        EmailMessage.Create(Recipients, Subject, Body, true);
        //SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added ('')
        EmailMessage.AddAttachment(Attachment, '', '');
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        MaterialIssueHeader.Status := MaterialIssueHeader.Status::"Sent for Authorization";
        Rec.MODIFY;

        MESSAGE('Material Request ' + MaterialIssueHeader."No." + ' is created. Mail is Sent to Store Manager');
        //end by rakesh
    end;


    procedure FieldsVisible();
    var
        GrecProdOrderShrtg: Record "Production Order Shortage Item";
    begin
        GrecProdOrderShrtg.RESET;
        GrecProdOrderShrtg.SETCURRENTKEY("Prod. Start Date");
        GrecProdOrderShrtg.SETFILTER(GrecProdOrderShrtg."Prod. Start Date", '<>%1', 0D);
        IF GrecProdOrderShrtg.FINDFIRST THEN
            FirstDate := GrecProdOrderShrtg."Prod. Start Date";
        IF FirstDate <> 0D THEN BEGIN
            FOR i := 1 TO 60 DO BEGIN
                ColumnCaptions[i] := FORMAT(CALCDATE(FORMAT(i - 1) + 'D', FirstDate));
                MATRIX_CellData[i] := 0;
            END;
            GrecProdOrderShrtg.RESET;
            GrecProdOrderShrtg.SETCURRENTKEY("Prod. Start Date");
            IF GrecProdOrderShrtg.FINDLAST THEN
                LastDate := GrecProdOrderShrtg."Prod. Start Date";
            IF NoOfDays = 0 THEN
                SetValues(0);
            LastDate := CALCDATE(FORMAT(NoOfDays - 1) + 'D', FirstDate);
            FOR i := 60 DOWNTO 1 DO BEGIN
                tempdate := 0D;
                EVALUATE(tempdate, ColumnCaptions[i]);
                IF LastDate < tempdate THEN
                    ColumnCaptions[i] := ''
                ELSE
                    i := 1;
            END;
            Field60Visible := ColumnCaptions[60] <> '';
            Field59Visible := ColumnCaptions[59] <> '';
            Field58Visible := ColumnCaptions[58] <> '';
            Field57Visible := ColumnCaptions[57] <> '';
            Field56Visible := ColumnCaptions[56] <> '';
            Field55Visible := ColumnCaptions[55] <> '';
            Field54Visible := ColumnCaptions[54] <> '';
            Field53Visible := ColumnCaptions[53] <> '';
            Field52Visible := ColumnCaptions[52] <> '';
            Field51Visible := ColumnCaptions[51] <> '';
            Field50Visible := ColumnCaptions[50] <> '';
            Field49Visible := ColumnCaptions[49] <> '';
            Field48Visible := ColumnCaptions[48] <> '';
            Field47Visible := ColumnCaptions[47] <> '';
            Field46Visible := ColumnCaptions[46] <> '';
            Field45Visible := ColumnCaptions[45] <> '';
            Field44Visible := ColumnCaptions[44] <> '';
            Field43Visible := ColumnCaptions[41] <> '';
            Field42Visible := ColumnCaptions[42] <> '';
            Field41Visible := ColumnCaptions[41] <> '';
            Field40Visible := ColumnCaptions[40] <> '';
            Field39Visible := ColumnCaptions[39] <> '';
            Field38Visible := ColumnCaptions[38] <> '';
            Field37Visible := ColumnCaptions[37] <> '';
            Field36Visible := ColumnCaptions[36] <> '';
            Field35Visible := ColumnCaptions[35] <> '';
            Field34Visible := ColumnCaptions[34] <> '';
            Field33Visible := ColumnCaptions[33] <> '';
            Field32Visible := ColumnCaptions[32] <> '';
            Field31Visible := ColumnCaptions[31] <> '';
            Field30Visible := ColumnCaptions[30] <> '';
            Field29Visible := ColumnCaptions[29] <> '';
            Field28Visible := ColumnCaptions[28] <> '';
            Field27Visible := ColumnCaptions[27] <> '';
            Field26Visible := ColumnCaptions[26] <> '';
            Field25Visible := ColumnCaptions[25] <> '';
            Field24Visible := ColumnCaptions[24] <> '';
            Field23Visible := ColumnCaptions[23] <> '';
            Field22Visible := ColumnCaptions[22] <> '';
            Field21Visible := ColumnCaptions[21] <> '';
            Field20Visible := ColumnCaptions[20] <> '';
            Field19Visible := ColumnCaptions[19] <> '';
            Field18Visible := ColumnCaptions[18] <> '';
            Field17Visible := ColumnCaptions[17] <> '';
            Field16Visible := ColumnCaptions[16] <> '';
            Field15Visible := ColumnCaptions[15] <> '';
            Field14Visible := ColumnCaptions[14] <> '';
            Field13Visible := ColumnCaptions[13] <> '';
            Field12Visible := ColumnCaptions[12] <> '';
            Field11Visible := ColumnCaptions[11] <> '';
            Field10Visible := ColumnCaptions[10] <> '';
            Field9Visible := ColumnCaptions[9] <> '';
            Field8Visible := ColumnCaptions[8] <> '';
            Field7Visible := ColumnCaptions[7] <> '';
            Field6Visible := ColumnCaptions[6] <> '';
            Field5Visible := ColumnCaptions[5] <> '';
            Field4Visible := ColumnCaptions[4] <> '';
            Field3Visible := ColumnCaptions[3] <> '';
            Field2Visible := ColumnCaptions[2] <> '';
            Field1Visible := ColumnCaptions[1] <> '';
        END;
    end;

    procedure SetValues(DayCount: Integer);
    begin
        IF DayCount = 0 THEN
            NoOfDays := (LastDate - FirstDate) + 1
        ELSE
            NoOfDays := DayCount;
    end;


    procedure Include_Stock();
    begin
        Rec.RESET;
        IF Rec.FINDSET THEN
            REPEAT
                getStockValues(Rec.Item);
                Tot_Stock_Inc_Others := 0;
                tempStock := 0;
                IF Include_Purch_Qty = TRUE THEN
                    tempStock += Rec."Qty. in Purchase Orders";
                IF Include_QC_Stock = TRUE THEN
                    tempStock += Rec."Qty. Under Inspection";
                IF Include_CS_Stock THEN
                    tempStock += "Stock at CS Stores";
                IF Include_RD_Stock = TRUE THEN
                    tempStock += "Stock at RD Stores";
                IF Rec."Shortage At" = 'STR' THEN
                    IF Include_MCH_Stock = TRUE THEN
                        tempStock += "Stock at MCH";
                IF Rec."Shortage At" = 'MCH' THEN
                    IF Include_STR_Stock = TRUE THEN
                        tempStock += "Stock at Stores";
                IF Include_Alt_Items_Qty = TRUE THEN
                    tempStock += Rec."Alt Item Qty. in Purch Orders";
                /*
                IF "Shortage At"  = 'STR' THEN
                  IF Include_Alt_Items_MCH_QTY = TRUE THEN
                    tempStock+="Alt Item Qty. in Purch Orders";
                IF "Shortage At"  = 'MCH' THEN
                  IF Include_Alt_Items_STR_QTY = TRUE THEN
                    tempStock+="Alt Item Qty. in Purch Orders";
                */
                Tot_Stock_Inc_Others := tempStock;
                Rec."Total Shortage Inc Purch Qty" := Rec."Total Shortage" - tempStock;
                Rec.MODIFY;
            UNTIL Rec.NEXT = 0;
        Calc_Shortage_items_Count;
        CurrPage.UPDATE(FALSE);

    end;


    procedure Calc_Shortage_items_Count();
    begin
        // Added by Pranavi on 16=Jan-2016 for
        Rec.RESET;
        Rec.SETFILTER("Total Shortage Inc Purch Qty", '>%1', 0);
        IF Rec.FINDSET THEN
            Tot_Shortg_Items_Cnt := Rec.COUNT;
        Rec.RESET;
        CurrPage.UPDATE(FALSE);
        // End by Pranavi
    end;


    procedure Show_Only_Shortg_Itms();
    begin
        // Added by Pranavi on 16=Jan-2016 for
        Calc_Shortage_items_Count;
        Rec.RESET;
        IF Show_Only_Shortage_Items = TRUE THEN BEGIN
            IF Rec.FINDSET THEN
                REPEAT
                    IF Rec."Total Shortage Inc Purch Qty" > 0 THEN
                        Rec.MARK(TRUE);
                UNTIL Rec.NEXT = 0;
            Rec.MARKEDONLY(TRUE);
        END
        ELSE BEGIN
            IF Show_Only_Crital_Items = TRUE THEN
                Show_Only_Critical_Itms;
        END;
        CurrPage.UPDATE(FALSE);
        // End by Pranavi
    end;


    procedure Include_Stock_For_Record(Item_No: Code[50]);
    begin
        getStockValues(Rec.Item);
        Tot_Stock_Inc_Others := 0;
        tempStock := 0;
        IF Include_Purch_Qty = TRUE THEN
            tempStock += Rec."Qty. in Purchase Orders";
        IF Include_QC_Stock = TRUE THEN
            tempStock += Rec."Qty. Under Inspection";
        IF Include_CS_Stock THEN
            tempStock += "Stock at CS Stores";
        IF Include_RD_Stock = TRUE THEN
            tempStock += "Stock at RD Stores";
        IF Rec."Shortage At" = 'STR' THEN
            IF Include_MCH_Stock = TRUE THEN
                tempStock += "Stock at MCH";
        IF Rec."Shortage At" = 'MCH' THEN
            IF Include_STR_Stock = TRUE THEN
                tempStock += "Stock at Stores";
        IF Include_Alt_Items_Qty = TRUE THEN
            tempStock += Rec."Alt Item Qty. in Purch Orders";
        Tot_Stock_Inc_Others := tempStock;
        Rec."Total Shortage Inc Purch Qty" := Rec."Total Shortage" - tempStock;
        Rec.MODIFY;
    end;


    procedure Show_Only_Critical_Itms();
    begin
        // Added by Pranavi on 16=Jan-2016 for
        Calc_Shortage_items_Count;
        Rec.RESET;
        IF Show_Only_Crital_Items = TRUE THEN BEGIN
            IF Rec.FINDSET THEN
                REPEAT
                    IF (Rec."Earliest Material Shortage Qty" > 0) THEN BEGIN
                        IF (Rec."Earliest Material Arrival Date" = 0D) THEN
                            Rec.MARK(TRUE)
                        ELSE BEGIN
                            IF (Rec."Earliest Material Arrival Date" < Rec."Earliest Material Shortage Dat") THEN BEGIN
                                IF (Rec."Earliest Material Shortage Qty" > Rec."Earliest Material Arrival Qty") THEN
                                    Rec.MARK(TRUE);
                            END ELSE
                                Rec.MARK(TRUE);
                        END;
                    END;
                UNTIL Rec.NEXT = 0;
            Rec.MARKEDONLY(TRUE);
        END ELSE BEGIN
            IF Show_Only_Shortage_Items = TRUE THEN
                Show_Only_Shortg_Itms;
        END;
        CurrPage.UPDATE(FALSE);
        // End by Pranavi
    end;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean; CellType: Option; FontColor: Integer);
    begin

        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := CellValue;
        TempExcelbuffer.Bold := bold;
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer."Using Custom Format" := TRUE;
        TempExcelbuffer."Font Color" := FontColor;
        TempExcelbuffer.INSERT;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean; CellType: Option);
    begin
        TempExcelbuffer.INIT;
        TempExcelbuffer.VALIDATE("Row No.", RowNo);
        TempExcelbuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelbuffer."Cell Value as Text" := FORMAT(CellValue);
        TempExcelbuffer.Bold := Bold;
        TempExcelbuffer."Cell Type" := CellType;
        TempExcelbuffer.Formula := '';
        TempExcelbuffer."Using Custom Format" := TRUE;
        TempExcelbuffer.INSERT;
    end;


    procedure Get_Alt_Stock(Item: Code[30]);
    begin
        IF ITEM1.GET(Item) THEN BEGIN
            ITEM1.CALCFIELDS(ITEM1."Inventory at Stores");
            //ITEM1.CALCFIELDS(ITEM1."Quantity Under Inspection");
            //ITEM1.CALCFIELDS(ITEM1."Quantity Rejected");
            ITEM1.CALCFIELDS(ITEM1."Stock At MCH Location");
            //ITEM1.CALCFIELDS(ITEM1."Stock at CS Stores");
            //ITEM1.CALCFIELDS(ITEM1."Stock at RD Stores");

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


    local procedure ExporttoExcel();
    begin
        CLEAR(NoOfRecords);
        ProdOrdShortageRec.RESET;
        ProdOrdShortageRec.SETCURRENTKEY("Prod. Start Date");
        IF ProdOrdShortageRec.FINDFIRST THEN;
        FirstDate := ProdOrdShortageRec."Prod. Start Date";
        PO_SHORTAGEITEMS.RESET;
        PO_SHORTAGEITEMS.SETCURRENTKEY("Prod. Start Date");
        IF PO_SHORTAGEITEMS.FINDLAST THEN;
        NoOfRecords := ABS(PO_SHORTAGEITEMS."Prod. Start Date" - ProdOrdShortageRec."Prod. Start Date");
        Excel := TRUE;
        IF Excel THEN BEGIN
            TempExcelbuffer.DELETEALL;
            CLEAR(TempExcelbuffer);

            Row := 0;

            Row += 1;
            Entercell(Row, 1, 'Shortage Items', TRUE, TempExcelbuffer."Cell Type"::Text, 5);
            Entercell(Row, 2, 'Critical Items', TRUE, TempExcelbuffer."Cell Type"::Text, 4);
            Row += 1;
            EnterHeadings(Row, 1, 'Include QC Stock', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 3, 'Include CS Stock', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 5, 'Include RD Stock', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 7, 'Include Purch Qty.', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 9, 'Include MCH_Stock(For STR Shortage)', TRUE, TempExcelbuffer."Cell Type"::Text);

            IF Include_QC_Stock = TRUE THEN
                Entercell(Row, 2, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 2, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Include_CS_Stock THEN
                Entercell(Row, 4, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 4, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Include_RD_Stock = TRUE THEN
                Entercell(Row, 6, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 6, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Include_Purch_Qty = TRUE THEN
                Entercell(Row, 8, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 8, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Include_MCH_Stock = TRUE THEN
                Entercell(Row, 10, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 10, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            Row += 1;
            EnterHeadings(Row, 1, 'Include STR Stock(For MCH Shortage)', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 3, 'Innclude Alt Items Purch Qty', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 5, 'Show Only Shortage Items', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 7, 'Show Only Critical Items', TRUE, TempExcelbuffer."Cell Type"::Text);

            IF Include_STR_Stock = TRUE THEN
                Entercell(Row, 2, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 2, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Include_Alt_Items_Qty = TRUE THEN
                Entercell(Row, 4, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 4, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Show_Only_Shortage_Items = TRUE THEN
                Entercell(Row, 6, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 6, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);

            IF Show_Only_Crital_Items = TRUE THEN
                Entercell(Row, 8, 'Yes', TRUE, TempExcelbuffer."Cell Type"::Text, 3)
            ELSE
                Entercell(Row, 8, 'No', TRUE, TempExcelbuffer."Cell Type"::Text, 3);


            Row += 2;

            EnterHeadings(Row, 1, 'Type', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 2, 'Item', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 3, 'Description', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 4, 'Shortage At', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 5, 'Lead Time', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 6, 'Total Shortage', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 7, 'Qty. in Purch. Orders', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 8, 'Total Shortage Inc Stock Considerations', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 9, 'Stock At Stores', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 10, 'Alt Item Qty. in Purch Orders', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 11, 'Qty. Under Inspection', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 12, 'Stock At CS Stores', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 13, 'Stock At RD Stores', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 14, 'Stock At MCH', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 15, 'Earliest Material Arrival Date', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 16, 'Earliest Material Arrival Qty.', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 17, 'Earliest Material Shortage Date', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 18, 'Earliest Material Shortage Qty.', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 19, 'Remarks', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 20, 'Alt Item PO No', TRUE, TempExcelbuffer."Cell Type"::Text); // added by sujani on 12Oct18
            EnterHeadings(Row, 21, 'Alt Item Vendor Name', TRUE, TempExcelbuffer."Cell Type"::Text);
            EnterHeadings(Row, 22, 'Direct Unit Cost', TRUE, TempExcelbuffer."Cell Type"::Text); // added by Vishnu Priya on 02-02-2019
            FOR i := 1 TO NoOfRecords + 1 DO BEGIN
                ColumnCaptions[i] := FORMAT(CALCDATE(FORMAT(i - 1) + 'D', FirstDate));
                EnterHeadings(Row, i + 22, FORMAT(ColumnCaptions[i]), TRUE, TempExcelbuffer."Cell Type"::Text);
            END;
            /*
            ExcelBuffer.NewRow;
            ExcelBuffer.AddColumnWithFonts('Item',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Description',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Shortage At',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Lead Time',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Total Shortage',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Qty. in Purch. Orders',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Total Shortage Inc Stock Considerations',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Stock At Stores',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Alt Item Qty. in Purch Orders',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Qty. Under Inspection',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Stock At CS Stores',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Stock At RD Stores',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Stock At MCH',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Earliest Material Arrival Date',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Earliest Material Arrival Qty.',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Earliest Material Shortage Date',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Earliest Material Shortage Qty.',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            ExcelBuffer.AddColumnWithFonts('Remarks',FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            FOR i:=1 TO 60 DO
            BEGIN
              ExcelBuffer.AddColumnWithFonts(FORMAT(ColumnCaptions[i]),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
            END;
            */

            IF Rec.FINDSET THEN
                REPEAT

                    Row += 1;

                    CriticalItem := FALSE;
                    ShortageItem := FALSE;
                    ItemType := ItemType::" ";
                    IF Rec."Total Shortage Inc Purch Qty" > 0 THEN BEGIN
                        ShortageItem := TRUE;
                        ItemType := ItemType::Shortage;
                    END;

                    IF (Rec."Earliest Material Shortage Qty" > 0) THEN BEGIN
                        IF (Rec."Earliest Material Arrival Date" = 0D) THEN BEGIN
                            CriticalItem := TRUE;
                            ItemType := ItemType::Critical;
                        END
                        ELSE BEGIN
                            IF (Rec."Earliest Material Arrival Date" < Rec."Earliest Material Shortage Dat") THEN BEGIN
                                IF (Rec."Earliest Material Shortage Qty" > Rec."Earliest Material Arrival Qty") THEN BEGIN
                                    CriticalItem := TRUE;
                                    ItemType := ItemType::Critical;
                                END;
                            END ELSE BEGIN
                                CriticalItem := TRUE;
                                ItemType := ItemType::Critical;
                            END;
                        END;
                    END;

                    IF ShortageItem = TRUE THEN BEGIN
                        Entercell(Row, 2, FORMAT(Rec.Item), FALSE, TempExcelbuffer."Cell Type"::Text, 5);
                        Entercell(Row, 3, FORMAT(Rec.Description), FALSE, TempExcelbuffer."Cell Type"::Text, 5);
                        Entercell(Row, 4, FORMAT(Rec."Shortage At"), FALSE, TempExcelbuffer."Cell Type"::Text, 5);
                        Entercell(Row, 5, FORMAT(Rec."Lead Time"), FALSE, TempExcelbuffer."Cell Type"::Text, 5);
                        Entercell(Row, 6, FORMAT(Rec."Total Shortage"), FALSE, TempExcelbuffer."Cell Type"::Number, 5);
                    END ELSE BEGIN
                        Entercell(Row, 2, FORMAT(Rec.Item), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                        Entercell(Row, 3, FORMAT(Rec.Description), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                        Entercell(Row, 4, FORMAT(Rec."Shortage At"), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                        Entercell(Row, 5, FORMAT(Rec."Lead Time"), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                        Entercell(Row, 6, FORMAT(Rec."Total Shortage"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    END;


                    IF CriticalItem = TRUE THEN BEGIN
                        Entercell(Row, 7, FORMAT(Rec."Qty. in Purchase Orders"), FALSE, TempExcelbuffer."Cell Type"::Number, 4);
                        Entercell(Row, 8, FORMAT(Rec."Total Shortage Inc Purch Qty"), FALSE, TempExcelbuffer."Cell Type"::Number, 4);
                    END ELSE BEGIN
                        Entercell(Row, 7, FORMAT(Rec."Qty. in Purchase Orders"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                        Entercell(Row, 8, FORMAT(Rec."Total Shortage Inc Purch Qty"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    END;

                    CASE ItemType OF
                        ItemType::" ":
                            Entercell(Row, 1, FORMAT(ItemType), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                        ItemType::Shortage:
                            Entercell(Row, 1, FORMAT(ItemType), FALSE, TempExcelbuffer."Cell Type"::Text, 5);
                        ItemType::Critical:
                            Entercell(Row, 1, FORMAT(ItemType), FALSE, TempExcelbuffer."Cell Type"::Text, 4);
                    END;

                    getStockValues(Rec.Item);
                    Include_Stock_For_Record(Rec.Item);

                    Entercell(Row, 9, FORMAT("Stock at Stores"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 10, FORMAT(Rec."Alt Item Qty. in Purch Orders"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 11, FORMAT(Rec."Qty. Under Inspection"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 12, FORMAT("Stock at CS Stores"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 13, FORMAT("Stock at RD Stores"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 14, FORMAT("Stock at MCH"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 15, FORMAT(Rec."Earliest Material Arrival Date"), FALSE, TempExcelbuffer."Cell Type"::Date, 0);
                    Entercell(Row, 16, FORMAT(Rec."Earliest Material Arrival Qty"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 17, FORMAT(Rec."Earliest Material Shortage Dat"), FALSE, TempExcelbuffer."Cell Type"::Date, 0);
                    Entercell(Row, 18, FORMAT(Rec."Earliest Material Shortage Qty"), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    Entercell(Row, 19, FORMAT(Rec.Remarks), FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                    Entercell(Row, 20, Rec."Alt Item PO No", FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                    Entercell(Row, 21, Rec."Alt Item Vendor No", FALSE, TempExcelbuffer."Cell Type"::Text, 0);
                    Entercell(Row, 22, FORMAT(Last_Direct_Unit_Cost), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                    /*
                    ExcelBuffer.NewRow;
                    ExcelBuffer.AddColumnWithFonts(FORMAT(Item),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT(Description),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,0,0,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Shortage At"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Lead Time"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Total Shortage"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Qty. in Purchase Orders"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Total Shortage Inc Purch Qty"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    getStockValues(Item);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Stock at Stores"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Alt Item Qty. in Purch Orders"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Qty. Under Inspection"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Stock at CS Stores"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Stock at RD Stores"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Stock at MCH"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Earliest Material Arrival Date"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Earliest Material Arrival Qty"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Earliest Material Shortage Dat"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT("Earliest Material Shortage Qty"),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    ExcelBuffer.AddColumnWithFonts(FORMAT(Remarks),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                    */

                    FOR i := 1 TO NoOfRecords + 1 DO BEGIN
                        MATRIX_CellData[i] := 0;
                    END;
                    ProdOrdShortageRec.RESET;
                    ProdOrdShortageRec.SETCURRENTKEY(Item, "Prod. Start Date");
                    ProdOrdShortageRec.SETFILTER(ProdOrdShortageRec.Item, Rec.Item);
                    ProdOrdShortageRec.SETRANGE(ProdOrdShortageRec."Shortage At", Rec."Shortage At");
                    IF ProdOrdShortageRec.FINDSET THEN
                        REPEAT
                            FOR i := 1 TO NoOfRecords + 1 DO BEGIN
                                tempdate := 0D;
                                EVALUATE(tempdate, ColumnCaptions[i]);
                                IF ProdOrdShortageRec."Prod. Start Date" = tempdate THEN BEGIN
                                    IF Tot_Stock_Inc_Others > 0 THEN BEGIN
                                        IF ProdOrdShortageRec.Shortage > Tot_Stock_Inc_Others THEN BEGIN
                                            MATRIX_CellData[i] += (ProdOrdShortageRec.Shortage - Tot_Stock_Inc_Others);
                                            Tot_Stock_Inc_Others := 0;
                                        END ELSE BEGIN
                                            Tot_Stock_Inc_Others -= ProdOrdShortageRec.Shortage;
                                        END;
                                    END ELSE BEGIN
                                        MATRIX_CellData[i] += (ProdOrdShortageRec.Shortage - Tot_Stock_Inc_Others);
                                    END;
                                    i := NoOfRecords + 1;
                                END;
                            END;
                        UNTIL ProdOrdShortageRec.NEXT = 0;

                    FOR i := 1 TO NoOfRecords + 1 DO BEGIN
                        tempdate := 0D;
                        EVALUATE(tempdate, ColumnCaptions[i]);
                        IF MATRIX_CellData[i] > 0 THEN BEGIN
                            Entercell(Row, i + 22, FORMAT(MATRIX_CellData[i]), FALSE, TempExcelbuffer."Cell Type"::Number, 0);
                        END;
                    END;
                /*
                FOR i:=1 TO 60 DO
                BEGIN
                  tempdate := 0D;
                  EVALUATE(tempdate,ColumnCaptions[i]);
                  IF  MATRIX_CellData[i] > 0 THEN
                  BEGIN
                    ExcelBuffer.AddColumnWithFonts(FORMAT(MATRIX_CellData[i]),FALSE,'',TRUE,FALSE,FALSE,'',TempExcelbuffer."Cell Type"::Text,'',0,1,2,TRUE);
                  END;
                END;
                */
                UNTIL Rec.NEXT = 0;

            /*
            //TempExcelbuffer.CreateBook('Shortage Report-'+FORMAT(TODAY)); //EFFUPG
            TempExcelbuffer.CreateBook('Shortage Report-'+FORMAT(TODAY),'');
            TempExcelbuffer.WriteSheet('Shortage Report-'+FORMAT(TODAY),COMPANYNAME,USERID);
            TempExcelbuffer.CloseBook;
            TempExcelbuffer.OpenExcel;
            TempExcelbuffer.GiveUserControl;
            */
            TempExcelbuffer.CreateBookAndOpenExcel('', 'Shortage Report' + FORMAT(TODAY), 'Shortage Report' + FORMAT(TODAY), COMPANYNAME, USERID); //EFFUPG
        END;

    end;
}

