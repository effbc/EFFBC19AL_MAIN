report 50113 "Item Wise LAR"
{
    // version NAVW17.00,Rev01,Eff02

    DefaultLayout = RDLC;
    RDLCLayout = './Item Wise LAR.rdl';
    Caption = 'Inventory Order Details';
    PreviewMode = Normal;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Mat.Issue Track. Specification"; "Mat.Issue Track. Specification")
        {
            DataItemTableView = SORTING("Item No.", "Location Code", "Lot No.", "Serial No.", "Appl.-to Item Entry")
                                ORDER(Ascending)
                                WHERE(Quantity = FILTER(> 0),
                                      "Location Code" = CONST('STR'));
            column(Mat_Issue_Track__Specification__Item_No__; "Item No.")
            {
            }
            column(ITEM_TB_Description; ITEM_TB.Description)
            {
            }
            column(Mat_Issue_Track__Specification__Prod__Order_No__; "Prod. Order No.")
            {
            }
            column(Mat_Issue_Track__Specification__Item_No___Control1102154006; "Item No.")
            {
            }
            column(ITEM_TB_Description_Control1102154008; ITEM_TB.Description)
            {
            }
            column(Mat_Issue_Track__Specification_Quantity; Quantity)
            {
            }
            column(RESERVED_MATERIAL_Caption; RESERVED_MATERIAL_CaptionLbl)
            {
            }
            column(ITEM_NO_Caption; ITEM_NO_CaptionLbl)
            {
            }
            column(QUANTITYCaption; QUANTITYCaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(PRODUCTIO_ORDERSCaption; PRODUCTIO_ORDERSCaptionLbl)
            {
            }
            column(Mat_Issue_Track__Specification_Order_No_; "Order No.")
            {
            }
            column(Mat_Issue_Track__Specification_Order_Line_No_; "Order Line No.")
            {
            }
            column(Mat_Issue_Track__Specification_Location_Code; "Location Code")
            {
            }
            column(Mat_Issue_Track__Specification_Lot_No_; "Lot No.")
            {
            }
            column(Mat_Issue_Track__Specification_Serial_No_; "Serial No.")
            {
            }
            column(Mat_Issue_Track__Specification_Appl__to_Item_Entry; "Appl.-to Item Entry")
            {
            }
            column(Choice; Choice)
            {
            }
            column(Report_Choice; Report_Choice)
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF PrevItem1 <> "Mat.Issue Track. Specification"."Item No." THEN BEGIN
                    PrevItem1 := "Mat.Issue Track. Specification"."Item No.";
                    // Copy code from // Mat.Issue Track. Specification, GroupHea - OnPostSection() >>
                    ITEM_TB.GET("Mat.Issue Track. Specification"."Item No.");
                    // Copy code from // Mat.Issue Track. Specification, GroupHea - OnPostSection() <<
                END;
            end;

            trigger OnPreDataItem();
            begin
                IF Report_Choice <> Report_Choice::Reserver THEN
                    CurrReport.BREAK;

                IF "Mat.Issue Track. Specification".GETFILTER("Mat.Issue Track. Specification"."Item No.") <> '' THEN
                    Choice := Choice::Item;


                IF Reserve_Item <> '' THEN
                    "Mat.Issue Track. Specification".SETRANGE("Mat.Issue Track. Specification"."Item No.", Reserve_Item);
                PrevItem1 := '';
            end;
        }
        dataitem("Production Order Shortage Item"; "Production Order Shortage Item")
        {
            DataItemTableView = SORTING(Item, "Shortage At")
                                ORDER(Ascending);
            column(TODAY; TODAY)
            {
            }
            column(Production_Order_Shortage_Item_Item; Item)
            {
            }
            column(Production_Order_Shortage_Item_Description; Description)
            {
            }
            column(Production_Order_Shortage_Item_Shortage; Shortage)
            {
            }
            column(Production_Order_Shortage_Item__Qty__in_Purchase_Orders_; "Qty. in Purchase Orders")
            {
            }
            column(Production_Order_Shortage_Item__Qty__Under_Inspection_; "Qty. Under Inspection")
            {
            }
            column(Production_Order_Shortage_Item__Shortage_At_; "Shortage At")
            {
            }
            column(AUTHORIZATION__REQUEST_FOR__PRODUCTION_SHORTAGE_MATERIALCaption; AUTHORIZATION__REQUEST_FOR__PRODUCTION_SHORTAGE_MATERIALCaptionLbl)
            {
            }
            column(ITEM_NO_Caption_Control1102154005; ITEM_NO_Caption_Control1102154005Lbl)
            {
            }
            column(SHORTAGECaption; SHORTAGECaptionLbl)
            {
            }
            column(DESCRIPTIONCaption_Control1102154009; DESCRIPTIONCaption_Control1102154009Lbl)
            {
            }
            column(Qty__in_Purchase_OrdersCaption; Qty__in_Purchase_OrdersCaptionLbl)
            {
            }
            column(Qty__Under_InspectionCaption; Qty__Under_InspectionCaptionLbl)
            {
            }
            column(SHORTAGE_ATCaption; SHORTAGE_ATCaptionLbl)
            {
            }
            column(Production_Order_Shortage_Item_Production_Order; "Production Order")
            {
            }
            column(EarliestExpectedDate; EarliestExpectedDate)
            {
            }
            column(Leadtime; Leadtime)
            {
            }

            trigger OnAfterGetRecord();
            begin
                // copy code from // Production Order Shortage Item, GroupFoo - OnPreSection() >>


                //Added by pranavi on 08-dec-2015 for not considering exp orders material to report
                PO1.RESET;
                PO1.SETFILTER(PO1."No.", "Production Order Shortage Item"."Production Order");
                IF PO1.FINDFIRST THEN
                    IF (COPYSTR(PO1."Sales Order No.", 5, 3) = 'EXP') THEN
                        CurrReport.SKIP;
                //end by pranavi


                IF ((InsertPrevShortageAt <> '') AND (InsertPrevShortageAt <> "Production Order Shortage Item"."Shortage At")) OR
                                     ((InsertPrevItem <> '') AND (InsertPrevItem <> "Production Order Shortage Item".Item)) THEN BEGIN
                    /*
                    "Qty. in Purchase Orders":=0;
                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type",'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.","Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETRANGE("Purchase Line"."No.",InsertPrevItem);
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code",'STR');
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive",'>%1',0);
                    IF "Purchase Line".FINDSET THEN
                    REPEAT
                      "Qty. in Purchase Orders" += "Purchase Line"."Qty. to Receive";
                    UNTIL "Purchase Line".NEXT=0;
                
                    "Qty. Under Inspection":=0;
                    QILE.RESET;
                    QILE.SETCURRENTKEY(QILE."Posting Date",QILE."Item No.");
                    QILE.SETRANGE(QILE."Item No.",InsertPrevItem);
                    QILE.SETRANGE(QILE."Inspection Status",QILE."Inspection Status"::"Under Inspection");
                    QILE.SETRANGE(QILE."Sent for Rework",FALSE);
                    QILE.SETFILTER(QILE."Remaining Quantity",'>%1',0);
                    QILE.SETRANGE(QILE."Location Code",'STR');
                    QILE.SETRANGE(QILE.Accept,TRUE);
                    IF QILE.FINDSET THEN
                    REPEAT
                      "Qty. Under Inspection"+=QILE."Remaining Quantity";
                    UNTIL QILE.NEXT=0;
                    */
                    IF (Create_MCH_REQ) AND (InsertPrevShortageAt = 'MCH') THEN BEGIN
                        ITEM_TB.GET(InsertPrevItem);
                        MATERIAL_ISSUES_LINE.INIT;
                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", InsertPrevItem);
                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", ITEM_TB."Base Unit of Measure");
                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE."Prod. Order No." := 'EFF08MCH01';
                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := 10000;

                        LineNo := LineNo + 10000;
                        IF MATERIAL_ISSUES_LINE.INSERT THEN
                            ShortageGroupTotal := 0;
                    END;

                    IF (Create_PRD_REQ) AND ("Production Order Shortage Item"."Shortage At" = 'PRODSTR') THEN       //SUNDAR
                    BEGIN
                        ITEM_TB.GET(InsertPrevItem);
                        MATERIAL_ISSUES_LINE.INIT;
                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", InsertPrevItem);
                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", ITEM_TB."Base Unit of Measure");
                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE."Prod. Order No." := 'EFF10STR01';
                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := 10000;

                        LineNo := LineNo + 10000;
                        IF MATERIAL_ISSUES_LINE.INSERT THEN
                            ShortageGroupTotal := 0;
                    END;                //SUNDAR

                    AUTH_SHORT_ITEMS.INIT;
                    AUTH_SHORT_ITEMS."Item No." := InsertPrevItem;
                    AUTH_SHORT_ITEMS.Description := InsertPrevItemDesc;
                    AUTH_SHORT_ITEMS."Production Date" := TODAY;
                    AUTH_SHORT_ITEMS."Location Code" := InsertPrevShortageAt;
                    AUTH_SHORT_ITEMS.Shortage := "Production Order Shortage Item".Shortage;
                    AUTH_SHORT_ITEMS.INSERT;
                END;
                //Insert Hack
                // copy code from // Production Order Shortage Item, GroupFoo - OnPreSection() <<

                IF PrevShortageAt <> "Production Order Shortage Item"."Shortage At" THEN BEGIN
                    PrevShortageAt := "Production Order Shortage Item"."Shortage At";
                    ShortageGroupTotal := 0;
                END;

                ShortageGroupTotal += "Production Order Shortage Item".Shortage;

                InsertPrevShortageAt := '';
                InsertPrevItem := '';
                InsertPrevItemDesc := '';

                InsertPrevShortageAt := "Production Order Shortage Item"."Shortage At";
                InsertPrevItem := "Production Order Shortage Item".Item;
                InsertPrevItemDesc := "Production Order Shortage Item".Description;

                "Qty. in Purchase Orders" := 0;
                "Purchase Line".RESET;
                "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                "Purchase Line".SETRANGE("Purchase Line"."No.", InsertPrevItem);
                "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                IF "Purchase Line".FINDSET THEN BEGIN
                    EarliestExpectedDate := "Purchase Line"."Deviated Receipt Date";
                    REPEAT
                        "Qty. in Purchase Orders" += "Purchase Line"."Qty. to Receive";
                    UNTIL "Purchase Line".NEXT = 0;
                END;
                "Qty. Under Inspection" := 0;
                QILE.RESET;
                QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                QILE.SETRANGE(QILE."Item No.", InsertPrevItem);
                QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                QILE.SETRANGE(QILE."Location Code", 'STR');
                QILE.SETRANGE(QILE.Accept, TRUE);
                IF QILE.FINDSET THEN
                    REPEAT
                        "Qty. Under Inspection" += QILE."Remaining Quantity";
                    UNTIL QILE.NEXT = 0;
                ItemGrec.RESET;
                IF ItemGrec.GET(InsertPrevItem) THEN BEGIN
                    // Leadtime:=0;
                    EVALUATE(Leadtime, COPYSTR(FORMAT(ItemGrec."Safety Lead Time"), 1, STRLEN(FORMAT(ItemGrec."Safety Lead Time")) - 1));
                END;

            end;

            trigger OnPostDataItem();
            begin
                IF (InsertPrevShortageAt <> '') OR (InsertPrevItem <> '') THEN BEGIN
                    "Qty. in Purchase Orders" := 0;
                    "Purchase Line".RESET;
                    "Purchase Line".SETFILTER("Purchase Line"."Document Type", 'Order');
                    "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                    "Purchase Line".SETRANGE("Purchase Line"."No.", InsertPrevItem);
                    "Purchase Line".SETFILTER("Purchase Line"."Location Code", 'STR');
                    "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                    IF "Purchase Line".FINDSET THEN BEGIN
                        EarliestExpectedDate := "Purchase Line"."Deviated Receipt Date";
                        REPEAT
                            "Qty. in Purchase Orders" += "Purchase Line"."Qty. to Receive";
                        UNTIL "Purchase Line".NEXT = 0;
                    END;
                    "Qty. Under Inspection" := 0;
                    QILE.RESET;
                    QILE.SETCURRENTKEY(QILE."Posting Date", QILE."Item No.");
                    QILE.SETRANGE(QILE."Item No.", InsertPrevItem);
                    QILE.SETRANGE(QILE."Inspection Status", QILE."Inspection Status"::"Under Inspection");
                    QILE.SETRANGE(QILE."Sent for Rework", FALSE);
                    QILE.SETFILTER(QILE."Remaining Quantity", '>%1', 0);
                    QILE.SETRANGE(QILE."Location Code", 'STR');
                    QILE.SETRANGE(QILE.Accept, TRUE);
                    IF QILE.FINDSET THEN
                        REPEAT
                            "Qty. Under Inspection" += QILE."Remaining Quantity";
                        UNTIL QILE.NEXT = 0;

                    IF (Create_MCH_REQ) AND (InsertPrevShortageAt = 'MCH') THEN BEGIN
                        ITEM_TB.GET(InsertPrevItem);
                        MATERIAL_ISSUES_LINE.INIT;
                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", InsertPrevItem);
                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", ITEM_TB."Base Unit of Measure");
                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE."Prod. Order No." := 'EFF08MCH01';
                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := 10000;

                        LineNo := LineNo + 10000;
                        MATERIAL_ISSUES_LINE.INSERT;
                    END;

                    IF (Create_PRD_REQ) AND ("Production Order Shortage Item"."Shortage At" = 'PRODSTR') THEN       //SUNDAR
                    BEGIN
                        ITEM_TB.GET(InsertPrevItem);
                        MATERIAL_ISSUES_LINE.INIT;
                        MATERIAL_ISSUES_LINE."Document No." := MATERIAL_ISSUES_HEADER."No.";
                        MATERIAL_ISSUES_LINE.VALIDATE("Item No.", InsertPrevItem);
                        MATERIAL_ISSUES_LINE."Line No." := LineNo;
                        MATERIAL_ISSUES_LINE.VALIDATE("Unit of Measure Code", ITEM_TB."Base Unit of Measure");
                        MATERIAL_ISSUES_LINE.VALIDATE(Quantity, ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Qty. to Receive", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE.VALIDATE("Outstanding Quantity", ShortageGroupTotal);
                        MATERIAL_ISSUES_LINE."Prod. Order No." := 'EFF10STR01';
                        MATERIAL_ISSUES_LINE."Prod. Order Line No." := 10000;

                        LineNo := LineNo + 10000;
                        MATERIAL_ISSUES_LINE.INSERT;
                    END;                //SUNDAR

                    AUTH_SHORT_ITEMS.INIT;
                    AUTH_SHORT_ITEMS."Item No." := InsertPrevItem;
                    AUTH_SHORT_ITEMS.Description := InsertPrevItemDesc;
                    AUTH_SHORT_ITEMS."Production Date" := TODAY;
                    AUTH_SHORT_ITEMS."Location Code" := InsertPrevShortageAt;
                    AUTH_SHORT_ITEMS.Shortage := "Production Order Shortage Item".Shortage;
                    AUTH_SHORT_ITEMS.INSERT;
                END;
                //Insert Hack
            end;

            trigger OnPreDataItem();
            begin
                GL.GET;
                IF FORMAT(GL."Production_ Shortage_Status") <> 'nothing' THEN
                    ERROR(' THERE IS NO PROVISION TO RUN THE SHORTAGE ITEMS REPORT AFTER REQUESTING TO MANAGEMENT');
                IF Report_Choice <> Report_Choice::Shortage THEN
                    CurrReport.BREAK;
                IF Create_MCH_REQ THEN BEGIN
                    MATERIAL_ISSUES_HEADER.INIT;
                    MATERIAL_ISSUES_HEADER."No." := PO_FORM.GetNextNo;
                    MATERIAL_ISSUES_HEADER.INSERT;
                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'STR');
                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'MCH');
                    MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", 'EFF08MCH01');
                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", 10000);
                    MATERIAL_ISSUES_HEADER."User ID" := USERID;
                    USER.GET(USERSECURITYID);
                    MATERIAL_ISSUES_HEADER."Resource Name" := USER."User Name";
                    MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                    MATERIAL_ISSUES_HEADER.MODIFY;
                    LineNo := 10000;
                END;

                IF Create_PRD_REQ THEN    //SUNDAR
                BEGIN
                    MATERIAL_ISSUES_HEADER.INIT;
                    MATERIAL_ISSUES_HEADER."No." := PO_FORM.GetNextNo;
                    MATERIAL_ISSUES_HEADER.INSERT;
                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-from Code", 'PRODSTR');
                    MATERIAL_ISSUES_HEADER.VALIDATE("Transfer-to Code", 'STR');
                    MATERIAL_ISSUES_HEADER."Receipt Date" := TODAY;
                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order No.", 'EFF08MCH01');
                    MATERIAL_ISSUES_HEADER.VALIDATE("Prod. Order Line No.", 10000);
                    MATERIAL_ISSUES_HEADER."User ID" := USERID;
                    USER.GET(USERSECURITYID);
                    MATERIAL_ISSUES_HEADER."Resource Name" := USER."User Name";
                    MATERIAL_ISSUES_HEADER."Creation DateTime" := CURRENTDATETIME;
                    MATERIAL_ISSUES_HEADER.MODIFY;
                    LineNo := 10000;

                END;//SUNDAR


                AUTH_SHORT_ITEMS.RESET;
                AUTH_SHORT_ITEMS.SETRANGE(AUTH_SHORT_ITEMS."Production Date", TODAY);
                AUTH_SHORT_ITEMS.DELETEALL;
            end;
        }
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING("Sales Order No.", "Source No.", "Prod Start date") ORDER(Ascending) WHERE(Status = CONST(Released), "Prod Start date" = FILTER(<> ''), "Suppose to Plan" = CONST(true));

            column(Production_Order__Source_No__; "Source No.")
            {
            }
            column(Production_Order_Quantity; Quantity)
            {
            }
            column(CUSTOMER_NAME; CUSTOMER_NAME)
            {
            }
            column(Production_Order__Production_Order___Item_Sub_Group_Code_; "Production Order"."Item Sub Group Code")
            {
            }
            column(PROJECTS_PLANNEDCaption; PROJECTS_PLANNEDCaptionLbl)
            {
            }
            column(CUSTOMER_NAMECaption; CUSTOMER_NAMECaptionLbl)
            {
            }
            column(PRODUCTCaption; PRODUCTCaptionLbl)
            {
            }
            column(CONFIGURATIONCaption; CONFIGURATIONCaptionLbl)
            {
            }
            column(QUANTITYCaption_Control1102154036; QUANTITYCaption_Control1102154036Lbl)
            {
            }
            column(Production_Order_Status; Status)
            {
            }
            column(Production_Order_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                // Copy code from  //Production Order, GroupFooter (4) - OnPostSection() >>
                IF ("Source No." <> SourceNoGroup) OR (PrevSaleorderNo <> "Production Order"."Sales Order No.") THEN BEGIN
                    SourceNoGroup := "Source No.";
                    PrevSaleorderNo := "Production Order"."Sales Order No.";
                    SALES_HEADER.RESET;
                    SALES_HEADER.SETRANGE(SALES_HEADER."No.", PrevSaleorderNo);
                    IF SALES_HEADER.FINDFIRST THEN BEGIN
                        IF CUSTOMER_REC.GET(SALES_HEADER."Bill-to Customer No.") THEN
                            CUSTOMER_NAME := CUSTOMER_REC.Name;
                        IF CUSTOMER_NAME = '' THEN
                            CUSTOMER_NAME := SALES_HEADER."Sell-to Customer Name";
                    END;
                END;
                // Copy code from  //Production Order, GroupFooter (4) - OnPostSection() <<
            end;

            trigger OnPreDataItem();
            begin
                // "Production Order".SETRANGE("Production Order"."Prod Start date",TODAY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    grid(Control1102152006)
                    {
                        GridLayout = Rows;
                        ShowCaption = false;
                        group(Control1102152007)
                        {
                            ShowCaption = false;
                            field(Choice1; '')
                            {
                                Caption = 'Choice';
                                ShowCaption = false;
                            }
                            field(Report_Choice; Report_Choice)
                            {
                                Caption = 'Choice';
                                //ShowCaption = false;
                            }
                            field("Reserve Item1"; '')
                            {
                                Caption = 'Reserve Item';
                                ShowCaption = false;
                            }
                            field(Reserve_Item; Reserve_Item)
                            {
                                Caption = 'Reserve Item';
                                //ShowCaption = false;
                                TableRelation = Item;
                            }
                        }
                    }
                    field(Create_MCH_REQ; Create_MCH_REQ)
                    {
                        Caption = 'Create MCH REQ';
                    }
                    field(Create_PRD_REQ; Create_PRD_REQ)
                    {
                        Caption = 'Create PRD REQ';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Text000: Label 'Sales Order Line: %1';
        Choice: Option Summary,Item;
        ITEM_TB: Record 27;
        Report_Choice: Option Shortage,Reserver;
        "Qty. in Purchase Orders": Decimal;
        "Qty. Under Inspection": Decimal;
        "Purchase Line": Record 39;
        QILE: Record 33000262;
        CUSTOMER_NAME: Text[50];
        SALES_HEADER: Record 36;
        CUSTOMER_REC: Record 18;
        Create_MCH_REQ: Boolean;
        MATERIAL_ISSUES_HEADER: Record 50001;
        PO_FORM: Page 99000831;
        USER: Record 2000000120;
        LineNo: Integer;
        MATERIAL_ISSUES_LINE: Record 50002;
        Reserve_Item: Code[20];
        AUTH_SHORT_ITEMS: Record 33000895;
        GL: Record 98;
        Create_PRD_REQ: Boolean;
        RESERVED_MATERIAL_CaptionLbl: Label '"RESERVED MATERIAL "';
        ITEM_NO_CaptionLbl: Label 'ITEM NO.';
        QUANTITYCaptionLbl: Label 'QUANTITY';
        DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
        PRODUCTIO_ORDERSCaptionLbl: Label 'PRODUCTIO ORDERS';
        AUTHORIZATION__REQUEST_FOR__PRODUCTION_SHORTAGE_MATERIALCaptionLbl: Label 'AUTHORIZATION  REQUEST FOR  PRODUCTION SHORTAGE MATERIAL';
        ITEM_NO_Caption_Control1102154005Lbl: Label 'ITEM NO.';
        SHORTAGECaptionLbl: Label 'SHORTAGE';
        DESCRIPTIONCaption_Control1102154009Lbl: Label 'DESCRIPTION';
        Qty__in_Purchase_OrdersCaptionLbl: Label 'Qty. in Purchase Orders';
        Qty__Under_InspectionCaptionLbl: Label 'Qty. Under Inspection';
        SHORTAGE_ATCaptionLbl: Label 'SHORTAGE AT';
        PROJECTS_PLANNEDCaptionLbl: Label 'PROJECTS PLANNED';
        CUSTOMER_NAMECaptionLbl: Label 'CUSTOMER NAME';
        PRODUCTCaptionLbl: Label 'PRODUCT';
        CONFIGURATIONCaptionLbl: Label 'CONFIGURATION';
        QUANTITYCaption_Control1102154036Lbl: Label 'QUANTITY';
        SourceNoGroup: Code[20];
        "--Rev01": Integer;
        PrevItem1: Code[20];
        PrevShortageAt: Code[10];
        PrevShortageITEM: Code[20];
        ShortageGroupTotal: Decimal;
        InsertPrevShortageAt: Code[10];
        InsertPrevItem: Code[20];
        InsertPrevItemDesc: Text[120];
        PrevSaleorderNo: Code[20];
        EarliestExpectedDate: Date;
        Leadtime: Decimal;
        ItemGrec: Record 27;
        PO1: Record 5405;
}

