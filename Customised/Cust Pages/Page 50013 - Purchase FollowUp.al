page 50013 "Purchase FollowUp"
{
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableTemporary = true;
    SourceTableView = WHERE("Document Type" = CONST(Order));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    CaptionML = ENU = 'Shortage',
                                ENN = 'Outstanding Quantity';
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("PCB Mode"; Rec."PCB Mode")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Deviated Receipt Date"; Rec."Deviated Receipt Date")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Visible = Shortage_Boolean;
                    ApplicationArea = All;
                }
                field("Sample Lot Inspection"; Rec."Sample Lot Inspection")
                {
                    Caption = 'Check';
                    Editable = true;
                    Visible = Release_Boolean;
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        PO: Text;
                    begin

                        Modify_boolean := Rec."Sample Lot Inspection";
                        PO := Rec."Document No.";
                        Rec.RESET;
                        Rec.SETFILTER("Document No.", PO);
                        IF Rec.FINDSET THEN
                            REPEAT
                                IF Modify_boolean = TRUE THEN BEGIN
                                    Rec."Sample Lot Inspection" := TRUE;
                                END
                                ELSE
                                    Rec."Sample Lot Inspection" := FALSE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        Rec.RESET;


                        /*    RESET;
                            SETFILTER("Document No.",PO);
                            IF FINDSET THEN
                            REPEAT
                                //MODIFYALL("Sample Lot Inspection",TRUE);
                        
                                MODIFY;
                            UNTIL NEXT = 0;
                            RESET;
                        END;*/
                        PO := '';

                    end;
                }
                field("<Document No.1>"; Rec."Document No.")
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    Caption = 'Structure';
                    StyleExpr = Color_Shotg_Inc_Purch;
                    ApplicationArea = All;
                }
                field("<Buy-from Vendor No.1>"; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("<Vendor Name1>"; Rec."Vendor Name")
                {
                    CaptionML = ENU = 'Vendor Name',
                                ENN = 'Description 2';
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("<No.1>"; Rec."No.")
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("<Description1>"; Rec.Description)
                {
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("<Quantity1>"; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("<Direct Unit Cost1>"; Rec."Direct Unit Cost")
                {
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    CaptionML = ENU = 'Prev Cost',
                                ENN = 'Outstanding Amount';
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Prev Vendor';
                    Editable = false;
                    StyleExpr = Color_Shotg_Inc_Purch;
                    Visible = Release_Boolean;
                    ApplicationArea = All;
                }
                /*field("Excise Amount"; "Excise Amount")
                {
                    ApplicationArea = All;
                }
                field("Tax Amount"; "Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Amount To Vendor"; "Amount To Vendor")
                {
                    ApplicationArea = All;
                }*/
            }
            group(Control1102152029)
            {
                Editable = false;
                ShowCaption = false;
                grid(Control1102152028)
                {
                    ShowCaption = false;
                    group(Control1102152027)
                    {
                        ShowCaption = false;
                        field("TotalItemsCount+FORMAT(xRec.COUNT)"; TotalItemsCount + FORMAT(xRec.COUNT))
                        {
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152025)
                    {
                        ShowCaption = false;
                        field(ColorText; ColorText)
                        {
                            Editable = false;
                            ShowCaption = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            Visible = Shortage_Boolean;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152044)
                    {
                        ShowCaption = false;
                        field(ColorText_Shortage; ColorText_Shortage)
                        {
                            ShowCaption = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            Visible = Release_Boolean;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102152022; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Control1102152020; Notes)
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
            action("Release ")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    Prev_Order: Text;
                    PurchaseOrder: Page 50;
                    PurchHeader: Record "Purchase Header";
                    Orders: Text;
                    Filemngmt: Codeunit "File Management";
                begin
                    Orders := '';
                    Rec.RESET;
                    Rec.SETFILTER("Sample Lot Inspection", '%1', TRUE);
                    Rec.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    Prev_Order := '';
                    Error_Msg := '';
                    Orders := '';
                    IF Rec.FINDSET THEN
                        REPEAT
                            IF Prev_Order <> Rec."Document No." THEN BEGIN
                                Prev_Order := Rec."Document No.";
                                PurchHeader.RESET;
                                PurchHeader.SETFILTER(PurchHeader."No.", Rec."Document No.");
                                IF PurchHeader.FINDFIRST THEN BEGIN
                                    IF Releasing_Conditions(PurchHeader) THEN BEGIN
                                        PurchaseOrder.Releasing(PurchHeader);
                                        Orders := Orders + Prev_Order + '|';
                                    END;
                                END;
                            END;
                        UNTIL Rec.NEXT = 0;
                    Rec.RESET;
                    Rec.SETFILTER("Document No.", COPYSTR(Orders, 1, (STRLEN(Orders) - 1)));
                    Rec.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    IF Rec.FINDSET THEN
                        Rec.DELETEALL;
                    Rec.RESET;
                    MESSAGE('Released Orders :: \' + Orders);
                    MESSAGE('Not Released Orders :: \' + Error_Msg);
                end;
            }
            action(TaxCalculation)
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    Prev_Order: Text;
                    PurchHeader: Record "Purchase Header";
                    PurchaseOrder: Page 50;
                begin
                    Rec.RESET;
                    Rec.SETFILTER("Sample Lot Inspection", '%1', TRUE);
                    Rec.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    Prev_Order := '';
                    IF Rec.FINDSET THEN
                        REPEAT
                            IF Prev_Order <> Rec."Document No." THEN BEGIN
                                Prev_Order := Rec."Document No.";
                                PurchHeader.RESET;
                                PurchHeader.SETFILTER(PurchHeader."No.", Rec."Document No.");
                                /*IF PurchHeader.FINDFIRST THEN BEGIN
                                    IF PurchHeader.Structure <> '' THEN BEGIN
                                        PurchaseOrder.StructureDetails(PurchHeader, FALSE);
                                    END;
                                END;*///B2BUpg
                            END;
                        UNTIL Rec.NEXT = 0;
                    Rec.RESET;
                    Rec.SETFILTER("Sample Lot Inspection", '%1', TRUE);
                    IF Rec.FINDSET THEN
                        REPEAT
                            PurchLine.RESET;
                            PurchLine.SETFILTER(PurchLine."Document No.", Rec."Document No.");
                            PurchLine.SETFILTER(PurchLine."Line No.", FORMAT(Rec."Line No."));
                            IF PurchLine.FINDFIRST THEN BEGIN
                                /* "Excise Amount" := PurchLine."Excise Amount";
                                 "Tax Amount" := PurchLine."Tax Amount";
                                 "Amount To Vendor" := PurchLine."Amount To Vendor";*/
                            END;
                        UNTIL Rec.NEXT = 0;
                    MESSAGE('TAX Calculation Completed');
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF Page_Purpose = 'Shortage' THEN BEGIN
            Shortage := 0;
            ShortageRec.RESET;
            ShortageRec.SETFILTER(ShortageRec.Item, Rec."No.");
            IF ShortageRec.FINDSET THEN
                REPEAT
                    Shortage += ShortageRec.Shortage;
                UNTIL ShortageRec.NEXT = 0;
            Rec."Outstanding Quantity" := Shortage;
            Rec.MODIFY;
            Color_Shotg_Inc_Purch := '';
            IF Rec.Quantity = 0 THEN
                Color_Shotg_Inc_Purch := 'Ambiguous';
        END
        ELSE
            IF Page_Purpose = 'Release' THEN BEGIN
                Color_Shotg_Inc_Purch := '';
                IF (Rec."Direct Unit Cost" - Rec."Outstanding Amount") >= 1 THEN
                    Color_Shotg_Inc_Purch := 'Ambiguous';
            END;
    end;

    trigger OnModifyRecord(): Boolean;
    var
        po: Text;
    begin
        /*
        po := "Document No.";
        IF "Sample Lot Inspection" = TRUE THEN
        BEGIN
            RESET;
            SETFILTER("Document No.",po);
            IF FINDSET THEN
            REPEAT
                //MODIFYALL("Sample Lot Inspection",FALSE);
                "Sample Lot Inspection" := FALSE;
                MODIFY;
            UNTIL NEXT = 0;
            RESET;
        END
        ELSE
        BEGIN
            RESET;
            SETFILTER("Document No.",po);
            IF FINDSET THEN
            REPEAT
                //MODIFYALL("Sample Lot Inspection",TRUE);
                "Sample Lot Inspection" := TRUE;
                MODIFY;
            UNTIL NEXT = 0;
            RESET;
        END;
        po := '';
        */

    end;

    trigger OnOpenPage();
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PH: Record "Purchase Header";
        PL: Record "Purchase Line";
        Flag_Value: Boolean;
    begin
        IF Page_Purpose = 'Shortage' THEN BEGIN
            Rec.DELETEALL;
            Rec.RESET;
            GrecProdOrderShrtg.RESET;
            GrecProdOrderShrtg.SETCURRENTKEY("Prod. Start Date");
            IF GrecProdOrderShrtg.FINDLAST THEN
                LastDate := GrecProdOrderShrtg."Prod. Start Date";
            PurchLine.RESET;
            PurchLine.SETFILTER(PurchLine."Document Type", 'Order');
            PurchLine.SETCURRENTKEY(PurchLine."No.", PurchLine."Buy-from Vendor No.");
            PurchLine.SETFILTER(PurchLine.Type, '%1', PurchLine.Type::Item);
            PurchLine.SETFILTER(PurchLine."Location Code", 'STR');
            PurchLine.SETFILTER(PurchLine."Qty. to Receive", '>%1', 0);
            //PurchLine.SETFILTER(PurchLine."Deviated Receipt Date",'<=%1',LastDate);
            IF PurchLine.FINDSET THEN
                REPEAT
                    Rec.RESET;
                    Rec.SETFILTER("No.", PurchLine."No.");
                    Rec.SETFILTER("Line No.", '%1', PurchLine."Line No.");
                    Rec.SETFILTER("Document No.", PurchLine."Document No.");
                    IF NOT Rec.FINDFIRST THEN BEGIN
                        Rec := PurchLine;
                        Rec.INSERT;
                    END;
                UNTIL PurchLine.NEXT = 0;
            LineNO := 10000;
            ShortageRec.RESET;
            ShortageRec.SETCURRENTKEY(Item, "Shortage At");
            IF ShortageRec.FINDSET THEN
                REPEAT
                    IF (PrevItm <> ShortageRec.Item) AND (PrevItm <> '') THEN BEGIN
                        Rec.RESET;
                        Rec.SETFILTER("No.", PrevItm);
                        IF NOT Rec.FINDFIRST THEN BEGIN
                            Rec."Document Type" := Rec."Document Type"::Order;
                            Rec."Document No." := '';
                            Rec."Line No." := LineNO;
                            Rec."No." := PrevItm;
                            Rec.Description := PrevDesc;
                            Rec.Quantity := 0;
                            Rec."Qty. to Receive" := 0;
                            Rec."Buy-from Vendor No." := '';
                            Rec."Expected Receipt Date" := 0D;
                            Rec."Document Date" := 0D;
                            Rec."Deviated Receipt Date" := 0D;
                            Rec."Quantity Invoiced" := 0;
                            Rec.Amount := 0;
                            Rec."Line Discount %" := 0;
                            Rec."Vendor Name" := '';
                            Rec.INSERT;
                            LineNO += 10000;
                        END;
                    END;
                    PrevItm := ShortageRec.Item;
                    PrevDesc := ShortageRec.Description;
                UNTIL ShortageRec.NEXT = 0;
            Rec.RESET;
            Rec.SETFILTER("No.", PrevItm);
            IF NOT Rec.FINDFIRST THEN BEGIN
                Rec."Document Type" := Rec."Document Type"::Order;
                Rec."Document No." := '';
                Rec."Line No." := LineNO;
                Rec."No." := PrevItm;
                Rec.Description := PrevDesc;
                Rec.Quantity := 0;
                Rec."Qty. to Receive" := 0;
                Rec."Buy-from Vendor No." := '';
                Rec."Expected Receipt Date" := 0D;
                Rec."Document Date" := 0D;
                Rec."Deviated Receipt Date" := 0D;
                Rec."Quantity Invoiced" := 0;
                Rec.Amount := 0;
                Rec."Line Discount %" := 0;
                Rec."Vendor Name" := '';
                Rec.INSERT;
                LineNO += 10000;
            END;
            Rec.RESET;
        END
        ELSE
            IF Page_Purpose = 'Release' THEN BEGIN
                Rec.DELETEALL;
                Rec.RESET;
                PurchaseHeader.RESET;
                PurchaseHeader.SETFILTER(PurchaseHeader."Document Type", '%1', PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SETFILTER(PurchaseHeader.Status, '<> %1', PurchaseHeader.Status::Released);
                PurchaseHeader.SETFILTER(PurchaseHeader."Release Date Time", '%1', 0DT);
                IF PurchaseHeader.FINDSET THEN
                    REPEAT
                        PurchaseLine.RESET;
                        PurchaseLine.SETFILTER(PurchaseLine."Document No.", PurchaseHeader."No.");
                        IF PurchaseLine.FINDSET THEN
                            REPEAT
                                Rec := PurchaseLine;
                                Rec."Sample Lot Inspection" := FALSE;
                                Rec."Vendor Name" := PurchaseHeader."Buy-from Vendor Name";
                                //Rec."Account No." := PurchaseHeader.Structure;//B2BUpg
                                IF PurchaseLine."No." <> '' THEN BEGIN
                                    PL.RESET;
                                    PL.SETFILTER(PL."No.", PurchaseLine."No.");
                                    PL.SETFILTER(PL."Document No.", '<>%1', PurchaseLine."Document No.");
                                    PL.SETFILTER(PL."Document Type", '%1', PL."Document Type"::Order);
                                    PL.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                                    PL.ASCENDING(FALSE);
                                    Flag_Value := TRUE;
                                    /*IF PL.FINDFIRST THEN
                                    BEGIN
                                        "Outstanding Amount" := PL.COUNT;
                                        "Description 2" := PL."Document No.";
                                    END;*/
                                    IF PL.FINDSET THEN
                                        REPEAT
                                            PH.RESET;
                                            PH.SETFILTER(PH."No.", PL."Document No.");
                                            PH.SETFILTER(PH.Status, FORMAT(PH.Status::Released));
                                            PH.SETCURRENTKEY("No.", "Document Type");
                                            //PH.ASCENDING(FALSE);
                                            IF PH.FINDFIRST THEN BEGIN
                                                Flag_Value := FALSE;
                                                Rec."Description 2" := PH."Buy-from Vendor Name";
                                                Rec."Outstanding Amount" := PL."Direct Unit Cost";
                                            END;
                                        UNTIL (PL.NEXT = 0) OR (Flag_Value = FALSE);
                                END;
                                Rec.INSERT;
                                Modify_boolean := TRUE;
                            UNTIL PurchaseLine.NEXT = 0;
                    UNTIL PurchaseHeader.NEXT = 0;
            END;

    end;

    var
        PurchLine: Record "Purchase Line";
        ShortageRec: Record "Production Order Shortage Item";
        PrevItm: Code[20];
        LineNO: Integer;
        PrevDesc: Text;
        Shortage: Decimal;
        GrecProdOrderShrtg: Record "Production Order Shortage Item";
        LastDate: Date;
        ColorText: Label 'Shortage Items Without PO';
        TotalItemsCount: Label '"Total Items: "';
        Color_Shotg_Inc_Purch: Text;
        Page_Purpose: Text;
        Shortage_Boolean: Boolean;
        Release_Boolean: Boolean;
        Error_Msg: Text;
        Modify_boolean: Boolean;
        ColorText_Shortage: Label 'Having More Cost w.r.t Last Purchase';


    procedure PagePurpose(Purpose: Text);
    begin
        Page_Purpose := Purpose;
        IF Purpose = 'Shortage' THEN BEGIN
            Shortage_Boolean := TRUE;
            Release_Boolean := FALSE;
        END
        ELSE
            IF Page_Purpose = 'Release' THEN BEGIN
                Shortage_Boolean := FALSE;
                Release_Boolean := TRUE;
            END;
    end;


    procedure Releasing_Conditions(PurchaseHeader: Record "Purchase Header"): Boolean;
    var
        ReleasePurchDoc: Codeunit 415;
        vendorRec: Record Vendor;
        item: Record Item;
        "G\L": Record "General Ledger Setup";
        "Payment Terms": Record "Payment Terms";
        Text001: Label 'Cashflow connection does not exist. Do you want to Continue?';
        "Excepted Rcpt.Date Tracking": Record "Excepted Rcpt.Date Tracking";
    begin

        PurchLine.RESET;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
        PurchLine.SETRANGE(PurchLine.Type, PurchLine.Type::Item);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF (PurchLine."Unit Cost (LCY)" = 0) AND (PurchLine.Sample = FALSE) THEN BEGIN
                    Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Enter the unit cost for ' + PurchLine."No.";
                    EXIT(FALSE);
                END;
                //ERROR('Enter the unit cost for '+PurchLine."No.");
                IF PurchLine."Gen. Prod. Posting Group" = '' THEN BEGIN
                    Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please Enter General Prod. Posting Group for ' + PurchLine."No.";
                    EXIT(FALSE);
                END;
                //    ERROR('Please Enter General Prod. Posting Group for '+PurchLine."No.");
                item.RESET;
                item.SETFILTER(item."No.", PurchLine."No.");
                IF item.FINDFIRST THEN BEGIN
                    IF item."PO Blocked" = TRUE THEN BEGIN
                        Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Purch Order Cannot be released beacause of Item: ' + item."No." + ' is blocked for PO!';
                        EXIT(FALSE);
                    END;
                    //ERROR('Purch Order Cannot be released beacause of Item: '+item."No."+' is blocked for PO!');
                END;
            UNTIL PurchLine.NEXT = 0;
        vendorRec.RESET;
        vendorRec.SETFILTER(vendorRec."No.", PurchaseHeader."Buy-from Vendor No.");
        vendorRec.SETFILTER(vendorRec."Way bill Required", '%1', TRUE);
        IF vendorRec.FINDFIRST THEN BEGIN
            IF PurchaseHeader."Way bill" = '' THEN BEGIN
                Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please enter way bill No.';
                EXIT(FALSE);
            END;
            //ERROR('Please enter way bill No.');
        END;
        "G\L".GET;
        IF "G\L"."Active ERP-CF Connection" THEN BEGIN
            PurchaseHeader.TESTFIELD(Status, Rec.Status::Open);
            //PurchaseHeader.TESTFIELD(Structure);//B2BUpg
            PurchaseHeader.TESTFIELD("Payment Terms Code");
            IF "Payment Terms".GET(PurchaseHeader."Payment Terms Code") THEN BEGIN
                IF NOT "Payment Terms"."Update In Cashflow" THEN BEGIN
                    Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'PAYMENT TERMS CODE MUST BE UPDATED IN CASH FLOW';
                    EXIT(FALSE);
                END;
                //      ERROR('PAYMENT TERMS CODE MUST BE UPDATED IN CASH FLOW');

            END;
            IF (NOT PurchaseHeader."Calculate Tax Structure") THEN BEGIN
                Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'PLEASE CALCULATE THE TAX STRUCTURE';
                EXIT(FALSE);
            END;

            //     ERROR('PLEASE CALCULATE THE TAX STRUCTURE');
        END
        ELSE BEGIN
            IF UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN BEGIN
                IF NOT CONFIRM(Text001, FALSE, PurchaseHeader."No.") THEN
                    EXIT;
                /*END
                ELSE
                BEGIN
                    Error_Msg := Error_Msg + '\'+ PurchaseHeader."No." + ' :: '+ ;
                    EXIT(FALSE);*/
            END;

            //    ERROR('Cash Flow connection is not active Contact ERP Team');
        END;
        IF (PurchaseHeader."Order Date" = 0D) OR (PurchaseHeader."Order Date" > "G\L"."Allow Posting To") THEN
            MESSAGE('PLEASE ENTER THE ORDER DATE ');

        IF (NOT PurchaseHeader."Inclusive of All Taxes") AND (PurchaseHeader."Order Date" > DMY2Date(12, 17, 09)) THEN //Rev01
          BEGIN
            Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'PLEASE ENTER THE TAX STRUCTRE & CALCULATE THE TAX STRUCTURE';
            EXIT(FALSE);
        END;

        //          ERROR('PLEASE ENTER THE TAX STRUCTRE & CALCULATE THE TAX STRUCTURE');

        IF NOT ((PurchaseHeader."Location Code" = 'R&D STR') OR (PurchaseHeader."Location Code" = 'CS STR') OR (PurchaseHeader."Location Code" = 'STR') OR (PurchaseHeader."Location Code" = 'SITE')) THEN BEGIN
            Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Location Code Must be In R&D STR,CS STR,STR,SITE';
            EXIT(FALSE);
        END;
        //ERROR('Location Code Must be In R&D STR,CS STR,STR,SITE');//sundar

        IF PurchaseHeader."Location Code" = 'R&D STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 2) <> 'RD') THEN BEGIN
                Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please Pick R&D Dimension Code';
                EXIT(FALSE);
            END;
            //ERROR('Please Pick R&D Dimension Code')
        END;
        IF PurchaseHeader."Location Code" = 'CS STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 3) <> 'CUS') THEN BEGIN
                Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please Pick CS Dimension Code';
                EXIT(FALSE);
            END;
            //ERROR('Please Pick CS Dimension Code')
        END;
        IF PurchaseHeader."Location Code" = 'STR' THEN BEGIN
            IF (COPYSTR(PurchaseHeader."Shortcut Dimension 1 Code", 1, 3) <> 'PRD') THEN BEGIN
                Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please Pick PRD Dimension Code';
                EXIT(FALSE);
            END;
            //ERROR('Please Pick PRD Dimension Code')
        END;
        PurchLine.SETRANGE(PurchLine."Document No.", PurchaseHeader."No.");
        PurchLine.SETFILTER(PurchLine.Quantity, '>%1', 0);
        IF PurchLine.FINDSET THEN
            REPEAT
                IF PurchLine."Buy-from Vendor No." <> PurchaseHeader."Buy-from Vendor No." THEN BEGIN
                    Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'VENDOR MUST BE SAME IN PURCHASE LINES & HEADER';
                    EXIT(FALSE);
                END;
                //    ERROR('VENDOR MUST BE SAME IN PURCHASE LINES & HEADER');
                IF (PurchLine.Type = PurchLine.Type::Item) OR (PurchLine.Type = PurchLine.Type::"G/L Account") THEN BEGIN
                    IF (PurchLine.Type = PurchLine.Type::Item) AND (PurchLine.Make = '') THEN BEGIN
                        Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Enter Make for Item ' + PurchLine.Description;
                        EXIT(FALSE);
                    END;
                    //      ERROR('Enter Make for Item '+ PurchLine.Description);
                    IF PurchLine."Gen. Prod. Posting Group" = '' THEN BEGIN
                        Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + ' THERE IS NO "Gen. Prod. Posting Group" FOR ' + PurchLine.Description;
                        EXIT(FALSE);
                    END;
                    //    ERROR(' THERE IS NO "Gen. Prod. Posting Group" FOR '+PurchLine.Description);
                    IF (PurchLine."Location Code" = 'SITE') AND (PurchaseHeader."Order Date" > DMY2Date(08, 11, 09)) THEN BEGIN
                        IF PurchLine."Shortcut Dimension 2 Code" = '' THEN BEGIN
                            Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'Please Enter the Site Information';
                            EXIT(FALSE);
                        END;
                        //       ERROR('Please Enter the Site Information');
                    END;
                    IF (PurchLine."Direct Unit Cost" = 0) AND NOT (PurchLine.Sample) THEN BEGIN
                        Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'THERE IS NO COST FOR THE ITEM  ' + PurchLine.Description;
                        EXIT(FALSE);
                    END;
                    //  ERROR('THERE IS NO COST FOR THE ITEM  '+PurchLine.Description);
                    "Excepted Rcpt.Date Tracking".RESET;
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document No.", PurchLine."Document No.");
                    "Excepted Rcpt.Date Tracking".SETRANGE("Excepted Rcpt.Date Tracking"."Document Line No.", PurchLine."Line No.");
                    IF (PurchLine.Type <> PurchLine.Type::"G/L Account") THEN
                        PurchLine.TESTFIELD(PurchLine."QC Enabled");
                    IF PurchaseHeader."Location Code" <> PurchLine."Location Code" THEN BEGIN
                        Error_Msg := Error_Msg + '\' + PurchaseHeader."No." + ' :: ' + 'location code not matching in both line and header';
                        EXIT(FALSE);
                    END;
                    //  ERROR('location code not matching in both line and header');
                END;
            UNTIL PurchLine.NEXT = 0;
        EXIT(TRUE);

    end;
}

