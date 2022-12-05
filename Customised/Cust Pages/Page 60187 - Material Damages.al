page 60187 "Material Damages"
{
    // version MI1.0,Rev01

    PageType = Document;
    SourceTable = "Material Issues Header";
    SourceTableView = SORTING("No.") WHERE("Transfer-to Code" = CONST('DAMAGE'), "Transfer-to Code" = FILTER('<>STR'), "Transfer-to Code" = FILTER('<>CS STR'));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; "No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; "Transfer-from Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; "Transfer-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; "Prod. Order Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production BOM No."; "Production BOM No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Person Code"; "Person Code")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Service Order No."; "Service Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field(Rejected; Rejected)
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; "Sales Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field("Released By"; "Released By")
                {
                    Caption = 'User id';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Required Date"; "Required Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Date"; "Released Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Caption = 'Released BY';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resource Name"; "Resource Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Mode of Transport"; "Mode of Transport")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Released Time"; "Released Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creation DateTime"; "Creation DateTime")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(MaterialIssueLine; "Material Issue Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("O&rder")
            {
                Caption = 'O&rder';
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    RunObject = Page "Material Issue Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F9';
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 5750;
                    RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Iss&ues")
                {
                    Caption = 'Iss&ues';
                    Image = TransferToLines;
                    RunObject = Page "Posted Material Issue List";
                    RunPageLink = "Material Issue No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            //Caption = '<Action1900000004>';
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT ((USERID = 'EFFTRONICS\CHOWDARY')) THEN BEGIN
                            IF WORKDATE < DT2DATE("Creation DateTime") THEN
                                ERROR('Release Date Must be Greater than Or Equal to Work Date');
                        END;
                        TESTFIELD("Prod. Order No.");
                        TESTFIELD("Prod. Order Line No.");
                        IF ("Transfer-from Code" = 'CST') AND ("Transfer-to Code" = 'CS STR') THEN BEGIN
                            TESTFIELD("Required Date");
                            // TESTFIELD("Shortcut Dimension 2 Code");
                        END;
                        IF (("Transfer-from Code" = 'CS STR') AND ("Transfer-to Code" = 'CS')) THEN
                            TESTFIELD("Shortcut Dimension 2 Code", 'H-OFF');


                        IF ("Transfer-from Code" = 'CS STR') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            TESTFIELD("Reason Code");
                            IF ("Reason Code" <> 'MAINTENANC') THEN
                                TESTFIELD("Sales Order No.");

                        END;

                        IF ("Transfer-from Code" = 'CS STR') AND ("Transfer-to Code" = 'CST') THEN BEGIN
                            IF ("Reason Code" <> 'DEPT MNT') AND ("Reason Code" <> 'DISPATCH')
                               AND ("Reason Code" <> 'FIXINGS') AND ("Reason Code" <> 'STOCK PCB')
                               AND ("Reason Code" <> 'SITE') AND ("Reason Code" <> 'R&D') AND ("Reason Code" <> 'TOOLS') THEN BEGIN
                                IF "Prod. Order No." = ' ' THEN
                                    ERROR('Please Select the production Order No.');
                                IF "Service Order No." = '' THEN BEGIN
                                    IF ("Prod. BOM No." = '') OR ("Shortcut Dimension 2 Code" = '') THEN BEGIN
                                        ERROR('Please Enter the Service Order No. ');
                                        EXIT;
                                    END;
                                END ELSE
                                    IF "Service Item" = '' THEN BEGIN
                                        ERROR('Please Enter the Service Item ');
                                        EXIT;
                                    END;
                            END ELSE
                                IF ("Reason Code" = 'STOCK PCB') THEN BEGIN
                                    IF ("Production BOM No." = '') THEN BEGIN
                                        ERROR('Please Enter the Production BOM No. ');
                                        EXIT;
                                    END;

                                END;
                        END;
                        IF (("Transfer-from Code" = 'CS') AND ("Transfer-to Code" = 'SITE')) OR
                           (("Transfer-to Code" = 'CS') AND ("Transfer-from Code" = 'SITE')) THEN BEGIN

                            IF "Shortcut Dimension 2 Code" = '' THEN
                                ERROR('PLEASE ENTER THE DIMENSION');
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            IF "Material Issues Line".FINDFIRST THEN BEGIN
                                IF "Reason Code" <> 'AMC' THEN;
                                IF "Transfer-from Code" = 'SITE' THEN BEGIN
                                    IF NOT (("Material Issues Line"."Shortcut Dimension 2 Code" = 'H-OFF')
                                           OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'SERVICE')
                                           OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'DAMAGE')
                                           OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'NON MOVING')) THEN
                                        ERROR('YOU ARE SELECTING A WRONG DIMENSION');
                                END;
                            END;
                        END;

                        IF (("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'PRODUCT')) THEN BEGIN
                            IF "Shortcut Dimension 2 Code" = '' THEN
                                ERROR('PLEASE ENTER THE DIMENSION')
                            ELSE
                                IF "Shortcut Dimension 2 Code" = 'PRODUCT' THEN
                                    ERROR('PLEASE ENTER THE CORRECT DIMENSION');
                        END;


                        IF (("Transfer-to Code" = 'SITE') AND ("Transfer-from Code" = 'PRODCUT')) THEN BEGIN
                            IF "Shortcut Dimension 2 Code" = '' THEN
                                ERROR('PLEASE ENTER THE DIMENSION');
                            //  ELSE IF "Shortcut Dimension 2 Code"<>'PRODUCT' THEN
                            //     ERROR('PLEASE ENTER THE CORRECT DIMENSION');
                        END;

                        CODEUNIT.RUN(60010, Rec);
                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleaseMaterialIssueDoc: Codeunit "Release MaterialIssue Document";
                    begin
                        ReleaseMaterialIssueDoc.Reopen(Rec);
                    end;
                }
                separator(Action1000000119)
                {
                }
                action("Copy &Production Order")
                {
                    Caption = 'Copy &Production Order';
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Transfer-from Code");
                        TESTFIELD("Transfer-to Code");
                        TESTFIELD("Prod. Order No.");
                        TESTFIELD("Prod. Order Line No.");
                        CopyProductionOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Sale Order")
                {
                    Caption = 'Copy &Sale Order';
                    Image = CopyFixedAssets;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Sales Order No.");
                        CopySalesOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Requisition")
                {
                    Caption = 'Copy &Requisition';
                    Image = CopyWorksheet;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CopyRequisition;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy Production &BOM")
                {
                    Caption = 'Copy Production &BOM';
                    Image = CopyFromBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Production BOM No.");
                        CopyProductionBOM;
                    end;
                }
                action("Total Indent")
                {
                    Caption = 'Total Indent';
                    Image = Totals;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Released);
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        "Material Issues Line".SETFILTER("Material Issues Line"."Indent No", '<>%1', '');
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('ALL READY SOME ITEMS ARE CONVERT INTO ORDER , PLEASE CHOOSE THE CORECT OPTION');

                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                        IF "Material Issues Line".FINDFIRST THEN
                            Indent_No := '';
                        "Indent Header".RESET;
                        "Indent Header".INIT;
                        NoSeriesMgt.InitSeries('P-INDENT', 'P-INDENT', TODAY,
                                                                      Indent_No, "Indent Header"."No. Series");
                        "Indent Header"."No." := Indent_No;
                        "Indent Header".Description := 'Created FROM MATERIAL REQUEST';
                        "Indent Header"."Contact Person" := "Resource Name";
                        "Indent Header"."Delivery Location" := "Transfer-from Code";
                        "Indent Header"."Delivery Place" := "Indent Header"."Delivery Place"::Store;
                        "Indent Header"."Indent Reference" := "Resource Name";
                        "Indent Header".Department := "Transfer-to Code";
                        "Indent Header"."Person Code" := "User ID";
                        "Indent Header"."User Id" := USERID;
                        "Indent Header"."ICN No." := ICNNO(TODAY);
                        "Indent Header"."Creation Date" := TODAY;
                        "Indent Header"."Material Request No." := "No.";
                        "Indent Header"."Production Order No." := "Prod. Order No.";
                        "Indent Header".VALIDATE("Indent Header"."Production Order No.", "Prod. Order No.");
                        "Production Order".SETRANGE("Production Order"."No.", "Prod. Order No.");
                        // "Production Order".SETFILTER("Production Order"."Sales Order No.",'<>%1','');
                        IF "Production Order".FINDFIRST THEN BEGIN
                            "Indent Header"."Sale Order No." := "Production Order"."Sales Order No.";
                            "Indent Header"."Production Order Description" := "Production Order".Description;
                        END;
                        IF "Required Date" >= TODAY THEN
                            "Indent Header"."Production Start date" := "Required Date";

                        "Indent Header".INSERT;
                        Line_No := 0;
                        REPEAT
                            "Indent Line".INIT;
                            "Indent Line"."Document No." := Indent_No;
                            Line_No := Line_No + 10000;
                            "Indent Line"."Line No." := Line_No;
                            "Indent Line"."No." := "Material Issues Line"."Item No.";
                            "Indent Line".VALIDATE("Indent Line"."No.", "Material Issues Line"."Item No.");
                            "Indent Line"."ICN No." := ICNNO(TODAY);
                            "Indent Line".Description := "Material Issues Line".Description;
                            "Indent Line".Quantity := "Material Issues Line"."Qty. to Receive";
                            "Indent Line".INSERT;
                            "Material Issues Line"."Make Indent" := TRUE;
                            "Material Issues Line"."Indent No" := Indent_No;
                        // "Material Issues Line".MODIFY;
                        UNTIL "Material Issues Line".NEXT = 0;
                        "No. Series Line".RESET;
                        "No. Series Line".SETRANGE("No. Series Line"."Series Code", 'P-INDENT');
                        "No. Series Line".SETRANGE("No. Series Line".Open, TRUE);
                        IF "No. Series Line".FINDFIRST THEN BEGIN
                            "No. Series Line"."Last No. Used" := Indent_No;
                            "No. Series Line"."Last Date Used" := TODAY;
                            "No. Series Line".MODIFY;
                        END;

                        MESSAGE('INDETN CREATION COMPLETED ' + Indent_No);
                        "Indent Header".RESET;
                    end;
                }
                action("Partial Indent")
                {
                    Caption = 'Partial Indent';
                    Image = Indent;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Released);
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        "Material Issues Line".SETFILTER("Material Issues Line"."Indent No", '%1', '');
                        "Material Issues Line".SETRANGE("Material Issues Line"."Make Indent", TRUE);
                        IF NOT ("Material Issues Line".FINDFIRST) THEN
                            ERROR('PLEASE CHOOSE THE ITEMS')
                        ELSE BEGIN
                            Indent_No := '';
                            Window.OPEN(Text001);
                            "Indent Header".RESET;
                            "Indent Header".INIT;
                            NoSeriesMgt.InitSeries('P-INDENT', 'P-INDENT', TODAY,
                                                                          Indent_No, "Indent Header"."No. Series");
                            //    MESSAGE(Indent_No);
                            "Indent Header"."No." := Indent_No;

                            "Indent Header".Description := 'Created FROM MATERIAL REQUEST';
                            "Indent Header"."Contact Person" := "Resource Name";
                            "Indent Header"."Delivery Location" := "Transfer-from Code";
                            "Indent Header"."Delivery Place" := "Indent Header"."Delivery Place"::Store;
                            "Indent Header"."Indent Reference" := "Resource Name";
                            "Indent Header".Department := "Transfer-to Code";
                            "Indent Header"."Person Code" := "User ID";
                            "Indent Header"."User Id" := USERID;
                            "Indent Header"."ICN No." := ICNNO(TODAY);
                            "Indent Header"."Creation Date" := TODAY;
                            "Indent Header"."Material Request No." := "No.";
                            "Indent Header"."Production Order No." := "Prod. Order No.";
                            "Indent Header"."No. Series" := 'P-INDENT';
                            "Indent Header".VALIDATE("Indent Header"."Production Order No.", "Prod. Order No.");
                            "Production Order".SETRANGE("Production Order"."No.", "Prod. Order No.");
                            // "Production Order".SETFILTER("Production Order"."Sales Order No.",'<>%1','');
                            IF "Production Order".FINDFIRST THEN BEGIN
                                "Indent Header"."Sale Order No." := "Production Order"."Sales Order No.";
                                "Indent Header"."Project Description" := "Production Order".Description;
                            END;
                            IF "Required Date" >= TODAY THEN
                                "Indent Header"."Production Start date" := "Required Date";

                            "Indent Header".INSERT;
                            Line_No := 0;
                            REPEAT
                                Window.UPDATE(1, "Material Issues Line".Description);
                                "Indent Line".INIT;
                                "Indent Line"."Document No." := Indent_No;
                                Line_No := Line_No + 10000;
                                "Indent Line"."Line No." := Line_No;
                                "Indent Line"."No." := "Material Issues Line"."Item No.";
                                "Indent Line".VALIDATE("Indent Line"."No.", "Material Issues Line"."Item No.");
                                "Indent Line"."ICN No." := ICNNO(TODAY);
                                "Indent Line".Description := "Material Issues Line".Description;
                                "Indent Line".Quantity := "Material Issues Line"."Qty. to Receive";
                                "Indent Line".INSERT;
                                "Material Issues Line"."Make Indent" := TRUE;
                                "Material Issues Line"."Indent No" := "Indent Header"."No.";
                                "Material Issues Line".MODIFY;
                            UNTIL "Material Issues Line".NEXT = 0;
                            Window.CLOSE;
                        END;
                        "No. Series Line".RESET;
                        "No. Series Line".SETRANGE("No. Series Line"."Series Code", 'P-INDENT');
                        "No. Series Line".SETRANGE("No. Series Line".Open, TRUE);
                        IF "No. Series Line".FINDFIRST THEN BEGIN
                            "No. Series Line"."Last No. Used" := Indent_No;
                            "No. Series Line"."Last Date Used" := TODAY;
                            "No. Series Line".MODIFY;
                        END;

                        MESSAGE('INDETN CREATION COMPLETED ' + Indent_No);
                    end;
                }
                action("Make All 0'S")
                {
                    Caption = 'Make All 0''S';
                    Image = MakeOrder;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDSET THEN
                            REPEAT
                                "Material Issues Line"."Qty. to Receive" := "Material Issues Line".Quantity - "Material Issues Line"."Quantity Received";
                                "Material Issues Line".MODIFY;
                            UNTIL "Material Issues Line".NEXT = 0;
                    end;
                }
                separator(Action1000000126)
                {
                }
                action("Assign Batch No's")
                {
                    Caption = 'Assign Batch No''s';
                    Image = Lot;
                    RunObject = Codeunit "Assign Batch No's";
                    ApplicationArea = All;
                }
                action("Assgin Quantity")
                {
                    Caption = 'Assgin Quantity';
                    Image = UntrackedQuantity;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Assigbtach No.s"."Assgin Qunatity"("No.");
                    end;
                }
                separator(Action1000000022)
                {
                }
                action("Calculate Quantity")
                {
                    Caption = 'Calculate Quantity';
                    Image = Calculate;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        MaterialIssueLine: Record "Material Issues Line";
                    begin
                        MaterialIssueLine.SETRANGE("Document No.", "No.");
                        IF MaterialIssueLine.FINDSET THEN
                            REPEAT
                                IF (MaterialIssueLine.Quantity > 1) AND ("Devide By Qty." <> 0) THEN BEGIN
                                    MaterialIssueLine.VALIDATE(MaterialIssueLine.Quantity, (MaterialIssueLine.Quantity / "Devide By Qty."));
                                    MaterialIssueLine.MODIFY;
                                END;
                            UNTIL MaterialIssueLine.NEXT = 0;
                        "Devide By Qty." := 0;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    Image = Post;
                    Promoted = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF ("Transfer-from Code" = 'CS') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            SMSetup.GET;
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Document No.", "Material Issues Line"."Line No.");
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Item Wise Min. Req. Qty at Loc".RESET;
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                              "Shortcut Dimension 2 Code");
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                "Material Issues Line"."Shortcut Dimension 2 Code");

                                    IF NOT ("Item Wise Min. Req. Qty at Loc".FINDFIRST) THEN BEGIN
                                        "Item Wise Min. Req. Qty at Loc".INIT;
                                        "Item Wise Min. Req. Qty at Loc".Location := "Shortcut Dimension 2 Code";
                                        "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Shortcut Dimension 2 Code");
                                        "Item Wise Min. Req. Qty at Loc".Item := "Material Issues Line"."Item No.";
                                        "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                        "Item Wise Min. Req. Qty at Loc"."Base Location" := 'SITE';
                                        "Item Wise Min. Req. Qty at Loc".INSERT;
                                    END;
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETCURRENTKEY("Tracking Specification"."Order No.",
                                                                           "Tracking Specification"."Order Line No.",
                                                                           "Tracking Specification"."Item No.",
                                                                           "Tracking Specification"."Location Code",
                                                                           "Tracking Specification"."Lot No.",
                                                                           "Tracking Specification"."Serial No.",
                                                                           "Tracking Specification"."Appl.-to Item Entry");
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT

                                            "Service_ Item".RESET;
                                            "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Tracking Specification"."Serial No.");
                                            IF NOT ("Service_ Item".FINDFIRST) THEN BEGIN
                                                "Service_ Item".INIT;
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", TODAY, TRUE);
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                "Service_ Item".INSERT;
                                            END ELSE BEGIN
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                "Service_ Item".MODIFY;
                                            END;
                                        UNTIL "Tracking Specification".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;

                        IF ("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'CS') THEN BEGIN
                            SMSetup.GET();
                            "Service Header".RESET;
                            "Service Header".SETRANGE("Service Header"."Material Issue no.", "Material Issues Line"."Document No.");
                            IF NOT ("Service Header".FINDFIRST) THEN BEGIN
                                "Service Header".INIT;
                                "Service Header"."Document Type" := "Service Header"."Document Type"::Order;

                                "Service Header"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Order Nos.", TODAY, TRUE);
                                Service_Order_No_ := "Service Header"."No.";
                                "Service Header"."Bill-to Address 2" := 'CS INT';
                                "Service Header"."Order Date" := TODAY;
                                "Service Header"."Order Time" := TIME;
                                "Service Header".VALIDATE("Service Header"."Bill-to Address 2", 'CS INT');
                                "Service Header"."Posting No." := SMSetup."Service Order Nos.";
                                "Service Header"."Customer No." := 'Created Automatically';
                                "Service Header"."Material Issue no." := "No.";
                                "Service Header".INSERT;
                                Order_Line_No := 0;

                                "Material Issues Line".RESET;
                                "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Document No.", "Material Issues Line"."Line No.");
                                "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                                "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                                IF "Material Issues Line".FINDSET THEN
                                    REPEAT
                                        "Item Wise Min. Req. Qty at Loc".RESET;
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Material Issues Line"."Shortcut Dimension 2 Code");
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Material Issues Line"."Shortcut Dimension 2 Code");
                                        IF NOT ("Item Wise Min. Req. Qty at Loc".FINDFIRST) THEN BEGIN
                                            "Item Wise Min. Req. Qty at Loc".INIT;
                                            "Item Wise Min. Req. Qty at Loc".Location := "Material Issues Line"."Shortcut Dimension 2 Code";
                                            "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                      "Material Issues Line"."Shortcut Dimension 2 Code");
                                            "Item Wise Min. Req. Qty at Loc".Item := "Material Issues Line"."Item No.";
                                            "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                            "Item Wise Min. Req. Qty at Loc"."Base Location" := 'CS';
                                            "Item Wise Min. Req. Qty at Loc".INSERT;
                                        END;
                                        "Item Wise Min. Req. Qty at Loc".RESET;
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Material Issues Line"."Shortcut Dimension 2 Code");
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                        "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Shortcut Dimension 2 Code");
                                        IF NOT ("Item Wise Min. Req. Qty at Loc".FINDFIRST) THEN BEGIN
                                            "Item Wise Min. Req. Qty at Loc".INIT;
                                            "Item Wise Min. Req. Qty at Loc".Location := "Material Issues Line"."Shortcut Dimension 2 Code";
                                            "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                      "Material Issues Line"."Shortcut Dimension 2 Code");
                                            "Item Wise Min. Req. Qty at Loc".Item := "Material Issues Line"."Item No.";
                                            "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                            "Item Wise Min. Req. Qty at Loc"."Base Location" := 'SITE';
                                            "Item Wise Min. Req. Qty at Loc".INSERT;
                                        END;

                                        IF "Material Issues Line"."Shortcut Dimension 2 Code" = 'SERVICE' THEN BEGIN
                                            "Tracking Specification".RESET;
                                            "Tracking Specification".SETCURRENTKEY("Tracking Specification"."Order No.",
                                                                                   "Tracking Specification"."Order Line No.",
                                                                                   "Tracking Specification"."Item No.",
                                                                                   "Tracking Specification"."Location Code",
                                                                                   "Tracking Specification"."Lot No.",
                                                                                   "Tracking Specification"."Serial No.",
                                                                                   "Tracking Specification"."Appl.-to Item Entry");
                                            "Tracking Specification".RESET;
                                            "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                            "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                            "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                            IF "Tracking Specification".FINDSET THEN
                                                REPEAT
                                                    Order_Line_No += 10000;
                                                    "Service_ Item".RESET;
                                                    "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
                                                    "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                    "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Tracking Specification"."Serial No.");
                                                    IF NOT ("Service_ Item".FINDFIRST) THEN BEGIN
                                                        "Service_ Item".INIT;
                                                        "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", TODAY, TRUE);
                                                        "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                        "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                        "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                        "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                        "Dimension Value".RESET;
                                                        "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                        "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                        IF "Dimension Value".FINDFIRST THEN
                                                            "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                        "Service_ Item".INSERT;

                                                        "Service Item Line".RESET;
                                                        "Service Item Line".SETRANGE("Service Item Line"."Document No.", Service_Order_No_);
                                                        "Service Item Line".SETRANGE("Service Item Line"."Service Item No.", "Service_ Item"."No.");
                                                        IF NOT ("Service Item Line".FINDFIRST) THEN BEGIN
                                                            "Service Item Line".INIT;
                                                            "Service Item Line"."Document Type" := "Service Item Line"."Document Type"::Order;
                                                            "Service Item Line"."Document No." := Service_Order_No_;
                                                            "Service Item Line"."Line No." := Order_Line_No;
                                                            "Service Item Line"."Service Item No." := "Service_ Item"."No.";
                                                            "Service Item Line".VALIDATE("Service Item Line"."Service Item No.", "Service_ Item"."No.");
                                                            "Service Item Line"."From Location" := 'Service';
                                                            "Service Item Line".INSERT;
                                                        END;
                                                    END ELSE BEGIN
                                                        "Dimension Value".RESET;
                                                        "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                        "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                        IF "Dimension Value".FINDFIRST THEN
                                                            "Service_ Item"."Present Location" := "Dimension Value".Name;


                                                        "Service_ Item".MODIFY;

                                                        "Service Item Line".RESET;
                                                        "Service Item Line".SETRANGE("Service Item Line"."Document No.", Service_Order_No_);
                                                        "Service Item Line".SETRANGE("Service Item Line"."Service Item No.", "Service_ Item"."No.");
                                                        IF NOT ("Service Item Line".FINDFIRST) THEN BEGIN
                                                            "Service Item Line".INIT;
                                                            "Service Item Line"."Document Type" := "Service Item Line"."Document Type"::Order;
                                                            "Service Item Line"."Document No." := Service_Order_No_;
                                                            "Service Item Line"."Line No." := Order_Line_No;
                                                            "Service Item Line"."Service Item No." := "Service_ Item"."No.";
                                                            "Service Item Line".VALIDATE("Service Item Line"."Service Item No.", "Service_ Item"."No.");
                                                            "Service Item Line"."From Location" := 'Service';
                                                            "Service Item Line".INSERT;
                                                        END;
                                                    END;
                                                UNTIL "Tracking Specification".NEXT = 0;
                                        END;
                                    UNTIL "Material Issues Line".NEXT = 0;
                            END;
                        END;

                        IF ("Transfer-from Code" = 'PRODUCT') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            SMSetup.GET();
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Document No.", "Material Issues Line"."Line No.");
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETCURRENTKEY("Tracking Specification"."Order No.",
                                                                           "Tracking Specification"."Order Line No.",
                                                                           "Tracking Specification"."Item No.",
                                                                           "Tracking Specification"."Location Code",
                                                                           "Tracking Specification"."Lot No.",
                                                                           "Tracking Specification"."Serial No.",
                                                                           "Tracking Specification"."Appl.-to Item Entry");
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT

                                            "Service_ Item".RESET;
                                            "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Tracking Specification"."Serial No.");
                                            IF NOT ("Service_ Item".FINDFIRST) THEN BEGIN
                                                "Service_ Item".INIT;
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", TODAY, TRUE);
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::"NON-WORKING";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".INSERT;
                                            END ELSE BEGIN
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::"NON-WORKING";
                                                "Service_ Item".MODIFY;
                                            END;
                                        UNTIL "Tracking Specification".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;

                        IF ("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'DUMMY') THEN BEGIN
                            SMSetup.GET();
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Document No.", "Material Issues Line"."Line No.");
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETCURRENTKEY("Tracking Specification"."Order No.",
                                                                           "Tracking Specification"."Order Line No.",
                                                                           "Tracking Specification"."Item No.",
                                                                           "Tracking Specification"."Location Code",
                                                                           "Tracking Specification"."Lot No.",
                                                                           "Tracking Specification"."Serial No.",
                                                                           "Tracking Specification"."Appl.-to Item Entry");
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT

                                            "Service_ Item".RESET;
                                            "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Tracking Specification"."Serial No.");
                                            IF NOT ("Service_ Item".FINDFIRST) THEN BEGIN
                                                "Service_ Item".INIT;
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", TODAY, TRUE);
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".INSERT;
                                            END ELSE BEGIN
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;


                                                "Service_ Item".MODIFY;
                                            END;
                                        UNTIL "Tracking Specification".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;

                        IF ("Transfer-from Code" = 'DUMMY') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            SMSetup.GET();
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETCURRENTKEY("Tracking Specification"."Order No.",
                                                                           "Tracking Specification"."Order Line No.",
                                                                           "Tracking Specification"."Item No.",
                                                                           "Tracking Specification"."Location Code",
                                                                           "Tracking Specification"."Lot No.",
                                                                           "Tracking Specification"."Serial No.",
                                                                           "Tracking Specification"."Appl.-to Item Entry");
                                    "Tracking Specification".RESET;
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT

                                            "Service_ Item".RESET;
                                            "Service_ Item".SETCURRENTKEY("Service_ Item"."Item No.", "Service_ Item"."Serial No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                            "Service_ Item".SETRANGE("Service_ Item"."Serial No.", "Tracking Specification"."Serial No.");
                                            IF NOT ("Service_ Item".FINDFIRST) THEN BEGIN
                                                "Service_ Item".INIT;
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", TODAY, TRUE);
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", "Shortcut Dimension 2 Code");
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".INSERT;
                                            END ELSE BEGIN
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", "Shortcut Dimension 2 Code");
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;


                                                "Service_ Item".MODIFY;
                                            END;
                                        UNTIL "Tracking Specification".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;

                        //B2B UPG >>>
                        /* charline := 10;
                        Mail_Body := '';
                        Subject := '';
                        Mail_From := 'erp@efftronics.com';
                        //Mail_To:='ramadevi@efftronics.net,nayomi@efftronics.net,Shilpa@efftronics.net,';
                        Mail_To := 'krishnad@efftronics.com';
                        //    Mail_To:='santhoshk@efftronics.com';
                        Subject := ' ISSUED MATERIAL FROM ' + "Transfer-from Code" + ' TO ' + "Transfer-to Code";
                        IF MaterialIssuesHeader."Transfer-to Code" = 'DAMAGE' THEN
                            Mail_Body += 'Damage By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                        ELSE
                            IF (MaterialIssuesHeader."Transfer-to Code" = 'STR') OR (MaterialIssuesHeader."Transfer-to Code" = 'R&D STR') OR
                             (MaterialIssuesHeader."Transfer-to Code" = 'CS STR') THEN
                                Mail_Body += 'Returned By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                            ELSE
                                Mail_Body += 'Issued To :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')';
                        Mail_Body += FORMAT(charline);
                        j := 0;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                        Mat_Issue_sLine.SETFILTER(Mat_Issue_sLine."Qty. to Receive", '>%1', 0);
                        IF Mat_Issue_sLine.FINDFIRST THEN
                            REPEAT
                                IF ((Mat_Issue_sLine."Item No." = 'METOLGN00017') OR (Mat_Issue_sLine."Item No." = 'METOLGN00035')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00036') OR (Mat_Issue_sLine."Item No." = 'METOLGN00075')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00038') OR (Mat_Issue_sLine."Item No." = 'METOLGN00076')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00084') OR (Mat_Issue_sLine."Item No." = 'METOLGN00111')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00141') OR (Mat_Issue_sLine."Item No." = 'METOLGN00159')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00216') OR (Mat_Issue_sLine."Item No." = 'METOLGN00223')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00233') OR (Mat_Issue_sLine."Item No." = 'METOLGN00234')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00034') OR (Mat_Issue_sLine."Item No." = 'METOLGN00086')) THEN BEGIN
                                    Mail_Body += 'Item           :' + Mat_Issue_sLine.Description + '(' + Mat_Issue_sLine."Item No." + ')';
                                    Mail_Body += FORMAT(charline);
                                    Mail_Body += 'Serial No.     :';

                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", Mat_Issue_sLine."Line No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT
                                            IF "Tracking Specification"."Serial No." <> '' THEN
                                                Mail_Body += "Tracking Specification"."Serial No." + ','
                                        UNTIL "Tracking Specification".NEXT = 0;

                                    Mail_Body += FORMAT(charline);
                                    j := 1;
                                END;
                            UNTIL Mat_Issue_sLine.NEXT = 0;
                        Mail_Body += '****** Auto Mail Generated From ERP ******';
                        IF j = 1 THEN BEGIN
                            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, FALSE);
                            SMTP_MAIL.Send; */  //B2B UPG <<<

                        charline := 10;
                        Mail_Body := '';
                        Subject := '';
                        //Mail_From := 'erp@efftronics.com';
                        //Mail_To:='ramadevi@efftronics.net,nayomi@efftronics.net,Shilpa@efftronics.net,';
                        //Mail_To := 'krishnad@efftronics.com';
                        //    Mail_To:='santhoshk@efftronics.com';
                        /*Recipients.Add('ramadevi@efftronics.net');
                        Recipients.Add('nayomi@efftronics.net');
                        Recipients.Add('Shilpa@efftronics.net');
                        Recipients.Add('santhoshk@efftronics.com'); */
                        Recipients.Add('krishnad@efftronics.com');

                        Subject := ' ISSUED MATERIAL FROM ' + "Transfer-from Code" + ' TO ' + "Transfer-to Code";
                        IF MaterialIssuesHeader."Transfer-to Code" = 'DAMAGE' THEN
                            Mail_Body += 'Damage By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                        ELSE
                            IF (MaterialIssuesHeader."Transfer-to Code" = 'STR') OR (MaterialIssuesHeader."Transfer-to Code" = 'R&D STR') OR
                             (MaterialIssuesHeader."Transfer-to Code" = 'CS STR') THEN
                                Mail_Body += 'Returned By   :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')'
                            ELSE
                                Mail_Body += 'Issued To :' + FORMAT("Resource Name") + '(' + FORMAT("User ID") + ')';
                        Mail_Body += FORMAT(charline);
                        j := 0;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                        Mat_Issue_sLine.SETFILTER(Mat_Issue_sLine."Qty. to Receive", '>%1', 0);
                        IF Mat_Issue_sLine.FINDFIRST THEN
                            REPEAT
                                IF ((Mat_Issue_sLine."Item No." = 'METOLGN00017') OR (Mat_Issue_sLine."Item No." = 'METOLGN00035')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00036') OR (Mat_Issue_sLine."Item No." = 'METOLGN00075')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00038') OR (Mat_Issue_sLine."Item No." = 'METOLGN00076')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00084') OR (Mat_Issue_sLine."Item No." = 'METOLGN00111')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00141') OR (Mat_Issue_sLine."Item No." = 'METOLGN00159')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00216') OR (Mat_Issue_sLine."Item No." = 'METOLGN00223')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00233') OR (Mat_Issue_sLine."Item No." = 'METOLGN00234')
                                OR (Mat_Issue_sLine."Item No." = 'METOLGN00034') OR (Mat_Issue_sLine."Item No." = 'METOLGN00086')) THEN BEGIN
                                    Mail_Body += 'Item           :' + Mat_Issue_sLine.Description + '(' + Mat_Issue_sLine."Item No." + ')';
                                    Mail_Body += FORMAT(charline);
                                    Mail_Body += 'Serial No.     :';

                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                    "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", Mat_Issue_sLine."Line No.");
                                    IF "Tracking Specification".FINDSET THEN
                                        REPEAT
                                            IF "Tracking Specification"."Serial No." <> '' THEN
                                                Mail_Body += "Tracking Specification"."Serial No." + ','
                                        UNTIL "Tracking Specification".NEXT = 0;

                                    Mail_Body += FORMAT(charline);
                                    j := 1;
                                END;
                            UNTIL Mat_Issue_sLine.NEXT = 0;
                        Mail_Body += '****** Auto Mail Generated From ERP ******';
                        IF j = 1 THEN BEGIN
                            /* SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, FALSE);
                            SMTP_MAIL.Send; */
                            EmailMessage.Create(Recipients, Subject, Mail_Body, FALSE);
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                        END;

                        CODEUNIT.RUN(60011, Rec);
                        Mat_Issue_sLine.RESET;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                        IF Mat_Issue_sLine.FINDSET THEN
                            REPEAT
                                Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                Mat_Issue_sLine.MODIFY;
                            UNTIL Mat_Issue_sLine.NEXT = 0;
                    end;
                }
            }
            action("&DC")
            {
                Caption = '&DC';
                Image = Delivery;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    REPORT.RUN(50065, TRUE, FALSE);

                    //MaterialIssuesHeader.SETRANGE(MaterialIssuesHeader."No.","No.");
                    //REPORT.RUN(50054,TRUE,FALSE,MaterialIssuesHeader);
                end;
            }
            action("Print &New")
            {
                Caption = 'Print &New';
                Image = PrintCover;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Material Requisition Print";
                ApplicationArea = All;

                trigger OnAction();
                begin
                    //REPORT.RUN(50010,TRUE,FALSE,MaterialIssuesHeader);
                    MaterialIssuesHeader.SETRANGE(MaterialIssuesHeader."No.", "No.");
                    REPORT.RUN(50010, TRUE, FALSE, MaterialIssuesHeader);
                end;

            }
            /*action("&Refresh")
             {
                 Caption = '&Refresh';
                 Image = RefreshLines;
                 Promoted = true;
                 PromotedCategory = Process;

                 trigger OnAction();
                 begin
                     IF (USERID = 'SUPER') OR (USERID = '05PD012') THEN BEGIN
                         IF ISCLEAR(SQLConnection) THEN
                             CREATE(SQLConnection, FALSE, TRUE);// Rev01

                         IF ISCLEAR(RecordSet) THEN
                             CREATE(RecordSet, FALSE, TRUE);// Rev01

                         IF ConnectionOpen <> 1 THEN BEGIN
                             SQLConnection.ConnectionString := 'DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                             SQLConnection.Open;
                             SQLConnection.BeginTrans;
                             ConnectionOpen := 1;
                         END;
                         SQLQuery := 'select requestid,status from materialauthor where (status=1) and materialauthor.requestid=''' + FORMAT("No.") + '''';
                         //MESSAGE(SQLQuery);
                         RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                         //MESSAGE(FORMAT(RowCount));
                         IF RowCount < -1 THEN
                             ERROR('Request not yet authorized to Refresh the data')
                         ELSE BEGIN
                             IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                 RecordSet.MoveFirst;

                             WHILE NOT RecordSet.EOF DO BEGIN

                                 IF ("No." = FORMAT(RecordSet.Fields.Item('requestid').Value)) THEN BEGIN
                                     IF "No." <> '' THEN BEGIN
                                         Status := Status::Released;
                                         MODIFY;
                                         //  CODEUNIT.RUN(60010,Rec);
                                     END;
                                 END;
                                 RecordSet.MoveNext;
                             END;
                             MESSAGE('Data Refreshed');
                         END;
                     END ELSE
                         ERROR('You Do not Have Permission to Refresh');
                 end;
        }*/
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 5750;
                RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        IF (USERID = 'SUPER') OR (USERID = 'EFFTRONICS\DMADHAVI') OR (USERID = '07TE024') THEN
            MODIFY
        ELSE BEGIN
            Body := '****  Auto Mail Generated From ERP  ****';
            Mail_From := 'erp@efftronics.net';
            Mail_To := 'erp@efftronics.net,padmaja@efftronics.net,dmadhavi@efftronics.net,sitarani@efftronics.net';

            //Rev01 Start
            //Code Commented
            /*
            USER.SETRANGE(USER."User Security ID",USERID);
            */
            USER.SETRANGE(USER."User Name", USERID);
            //Rev01 End

            IF USER.FINDFIRST THEN BEGIN
                Subject := USER."User Name" + '  is trying to Delete Request ' + "No.";
                EmailMessage.Create(Mail_To, Subject, Body, FALSE);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default)
            END;
            // Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');
            ERROR('U Dont Have Permissions to Delete');
        END;

    end;

    var
        MaterialIssuesHeader: Record "Material Issues Header";
        "Assigbtach No.s": Codeunit "Assign Batch No's";
        "Service Item Line": Record "Service Item Line";
        USER: Record User;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        Subject: Text[250];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit email;
        Recipients: List of [Text];
        "Material Issues Line": Record "Material Issues Line";
        "Item Wise Min. Req. Qty at Loc": Record "Item Wise Min. Req. Qty at Loc";
        "Service_ Item": Record "Service Item";
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "Service Header": Record "Service Header";
        SMSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit 396;
        Service_Order_No_: Code[20];
        Order_Line_No: Integer;
        "Dimension Value": Record "Dimension Value";
        Mat_Issue_sLine: Record "Material Issues Line";
        SMTPSETUP: Record "SMTP SETUP";
        "Mail-Id": Record User;
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        bodies: Integer;
        /* objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
         objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
         flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
         fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field";*/ //B2BUPG
        charline: Char;
        charline2: Char;
        j: Integer;
        "Indent Header": Record "Indent Header";
        "Indent Line": Record "Indent Line";
        Line_No: Integer;
        Prev_Indent: Code[20];
        Prev_Indent_Series: Code[20];
        Window: Dialog;
        Indent_No: Code[20];
        Dat: Code[10];
        Mon: Code[10];
        Yer: Code[10];
        "Production Order": Record "Production Order";
        "No. Series": Record "No. Series";
        "No. Series Line": Record "No. Series Line";
        Text001: Label 'Updating Virtual Purchase Dates #1#########\';
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        // LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        "........Rev01...........": Integer;
    //  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
    //RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";


    procedure ICNNO(DT: Date) ICN: Code[10];
    begin
        IF DATE2DMY(DT, 1) < 10 THEN
            Dat := '0' + FORMAT(DATE2DMY(DT, 1))
        ELSE
            Dat := FORMAT(DATE2DMY(DT, 1));

        IF DATE2DMY(DT, 2) < 10 THEN
            Mon := '0' + FORMAT(DATE2DMY(DT, 2))
        ELSE
            Mon := FORMAT(DATE2DMY(DT, 2));

        //IF DATE2DMY(DT,2) < 10 THEN
        Yer := COPYSTR(FORMAT(DATE2DMY(DT, 3)), 3, 2);
        ICN := Dat + Mon + Yer;
        EXIT(ICN);
    end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event RecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(TransactionLevel : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var Source : Text;CursorType : Integer;LockType : Integer;var Options : Integer;adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(RecordsAffected : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pCommand : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{B08400BD-F9D1-4D02-B856-71D5DBA123E9}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Command";pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset";pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(var ConnectionString : Text;var UserID : Text;var Password : Text;var Options : Integer;adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;

    //event SQLConnection(adStatus : Integer;pConnection : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000550-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Connection");
    //begin
    /*
    */
    //end;
}

