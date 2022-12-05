page 60174 "Material Requests List"
{
    // version Rev01

    CardPageID = "Material Requests";
    Editable = false;
    PageType = List;
    SourceTable = "Material Issues Header";
    SourceTableView = SORTING("No.") ORDER(Ascending);
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;
            }
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Name"; Rec."Transfer-from Name")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Name"; Rec."Transfer-to Name")
                {
                    ApplicationArea = All;
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Proj Description"; Rec."Proj Description")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. BOM No."; Rec."Prod. BOM No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = All;
                }
                field("Authorised By"; Rec."Authorised By")
                {
                    ApplicationArea = All;
                }
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
                    ApplicationArea = All;
                    ShortCutKey = 'F9';
                    Visible = false;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 5750;
                    RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Iss&ues")
                {
                    Caption = 'Iss&ues';
                    Image = ErrorLog;
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
                action("A&uthorize")
                {
                    Caption = 'A&uthorize';
                    Image = Approve;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        /*
                       IF ((("Transfer-to Code"='RD1') OR ("Transfer-to Code"='RD2') OR("Transfer-to Code"='RD3') OR("Transfer-to Code"='RD4') OR
                       ("Transfer-to Code"='RD5') OR("Transfer-to Code"='RD6') OR("Transfer-to Code"='RHW'))AND(("Transfer-from Code"='R&D STR')))
                       OR(("Transfer-to Code"='R&D STR') AND (
                       ("Transfer-from Code"='RD1') OR ("Transfer-from Code"='RD2') OR("Transfer-from Code"='RD3') OR("Transfer-from Code"='RD4') OR
                       ("Transfer-from Code"='RD5') OR("Transfer-from Code"='RD6')OR("Transfer-from Code"='RHW')))
                       OR(("Transfer-to Code"='DAMAGE') AND (
                       ("Transfer-from Code"='RD1') OR ("Transfer-from Code"='RD2') OR("Transfer-from Code"='RD3') OR("Transfer-from Code"='RD4') OR
                       ("Transfer-from Code"='RD5') OR("Transfer-from Code"='RD6')OR("Transfer-from Code"='RHW'))) THEN
                       ERROR('You Need to Authorize through Mails only')
                       ELSE
                       BEGIN */
                        IF NOT ((USERID = '89OF002')) THEN BEGIN
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
                            /*  IF ("Reason Code"<>'MAINTENANC') THEN
                              TESTFIELD("Sales Order No.");  anil*/

                        END;

                        IF ("Transfer-from Code" = 'CS STR') AND ("Transfer-to Code" = 'CST') THEN BEGIN
                            IF ("Reason Code" <> 'DEPT MNT') AND ("Reason Code" <> 'DISPATCH')
                               AND ("Reason Code" <> 'FIXINGS') AND ("Reason Code" <> 'STOCK PCB')
                               AND ("Reason Code" <> 'SITE') AND ("Reason Code" <> 'R&D') AND ("Reason Code" <> 'TOOLS') AND
                                 ("Reason Code" <> 'TES ZIG') AND ("Reason Code" <> 'SERVICING') THEN BEGIN
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
                            IF "Material Issues Line".FINDFIRST THEN
                                REPEAT
                                    IF "Reason Code" <> 'AMC' THEN;
                                    IF "Transfer-from Code" = 'SITE' THEN BEGIN
                                        IF NOT (("Material Issues Line"."Shortcut Dimension 2 Code" = 'H-OFF')
                                               OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'SERVICE')
                                               OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'DAMAGE')
                                               OR ("Material Issues Line"."Shortcut Dimension 2 Code" = 'NON MOVING')) THEN
                                            ERROR('YOU ARE SELECTING A WRONG DIMENSION');

                                    END;
                                    IF "Transfer-to Code" = 'SITE' THEN BEGIN
                                        IF ("Material Issues Line".Station = '') THEN
                                            ERROR('ENTER A STATION');

                                        IF (("Material Issues Line"."Item No." = 'BOIMODE00014') OR ("Material Issues Line"."Item No." = 'BOIMODE00006') OR
                                           ("Material Issues Line"."Item No." = 'BOIMODE00001')) AND ("Material Issues Line".Remarks = '') THEN
                                            ERROR('Please Enter the Remarks for Modems');

                                    END;

                                UNTIL "Material Issues Line".NEXT = 0;
                            IF "Transfer-to Code" = 'SITE' THEN BEGIN
                                MaterialIssuesHeader.SETRANGE(MaterialIssuesHeader."No.", "No.");
                                IF MaterialIssuesHeader.FINDFIRST THEN BEGIN
                                    IF NOT ((MaterialIssuesHeader."Reason Code" = 'PROD DOWN')
                                           OR (MaterialIssuesHeader."Reason Code" = 'N/W DOWN')
                                           OR (MaterialIssuesHeader."Reason Code" = 'INSTALLA')
                                           OR (MaterialIssuesHeader."Reason Code" = 'MONITERS')
                                           OR (MaterialIssuesHeader."Reason Code" = 'SPARE')
                                           OR (MaterialIssuesHeader."Reason Code" = 'REPLACE')
                                           OR (MaterialIssuesHeader."Reason Code" = 'TCA')
                                           OR (MaterialIssuesHeader."Reason Code" = 'ANG DOWN')
                                           OR (MaterialIssuesHeader."Reason Code" = 'INSTA DOWN')
                                           OR (MaterialIssuesHeader."Reason Code" = 'N/W ENHANC')
                                           OR (MaterialIssuesHeader."Reason Code" = 'CAL')) THEN
                                        ERROR('ENTER A VALID REASON CODE');

                                    IF NOT ((MaterialIssuesHeader."Mode of Transport" = 1)
                                           OR (MaterialIssuesHeader."Mode of Transport" = 2)
                                           OR (MaterialIssuesHeader."Mode of Transport" = 3)
                                           OR (MaterialIssuesHeader."Mode of Transport" = 4)
                                           OR (MaterialIssuesHeader."Mode of Transport" = 6)) THEN
                                        ERROR('ENTER A VALID MODE OF TRANSPORT');

                                    IF (MaterialIssuesHeader.Priority = 0) THEN
                                        ERROR('ENTER THE PRIORITY');

                                    IF (MaterialIssuesHeader."Reason Code" = 'INSTALLA') AND (MaterialIssuesHeader."Sales Order No." = '') THEN
                                        ERROR('You must select the Sales order no');


                                    "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                                    IF "Material Issues Line".FIND('-') THEN
                                        REPEAT
                                            IF ("Material Issues Line"."Item No." = 'ECICSDI00427') AND ("Material Issues Line"."Monitor Problem" = 0) THEN
                                                ERROR('PLEASE ENTER MONITER PROBLEM For Item No ECICSDI00427');
                                        UNTIL "Material Issues Line".NEXT = 0;
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
                        //END;

                    end;
                }
                action("Reo&pen")
                {
                    Caption = 'Reo&pen';
                    Image = ReOpen;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReleaseMaterialIssueDoc: Codeunit "Release MaterialIssue Document";
                    begin
                        ReleaseMaterialIssueDoc.Reopen(Rec);
                    end;
                }
                separator(Action1102152032)
                {
                }
                action("Copy &Production Order")
                {
                    Caption = 'Copy &Production Order';
                    Image = CopyFixedAssets;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Transfer-from Code");
                        TESTFIELD("Transfer-to Code");
                        TESTFIELD("Prod. Order No.");
                        TESTFIELD("Prod. Order Line No.");
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('Delete the Existing Material request Lines Before performing this Operation');

                        CopyProductionOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Sale Order")
                {
                    Caption = 'Copy &Sale Order';
                    Image = CopyDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Sales Order No.");
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('Delete the Existing Material request Lines Before performing this Operation');

                        CopySalesOrder;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy &Requisition")
                {
                    Caption = 'Copy &Requisition';
                    Image = Copy;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('Delete the Existing Material request Lines Before performing this Operation');

                        CopyRequisition;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                action("Copy Production &BOM")
                {
                    Caption = 'Copy Production &BOM';
                    Image = CopyBOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD("Production BOM No.");
                        TESTFIELD(Multiple);
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('Delete the Existing Material request Lines Before performing this Operation');

                        CopyProductionBOM;
                    end;
                }
                action("Copy From Schedule")
                {
                    Caption = 'Copy From Schedule';
                    Image = CopyFromTask;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDFIRST THEN
                            ERROR('Delete the Existing Material request Lines Before performing this Operation');

                        CopyFromSalesSchedule;
                    end;
                }
                separator(Action1102152026)
                {
                }
                action("Make All 0's")
                {
                    Caption = 'Make All 0''s';
                    Image = CopySerialNo;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        IF "Material Issues Line".FINDSET THEN
                            REPEAT
                                "Material Issues Line"."Qty. to Receive" := 0;
                                "Material Issues Line".MODIFY;
                            UNTIL "Material Issues Line".NEXT = 0;
                    end;
                }
                action("Assign Batch No's")
                {
                    Caption = 'Assign Batch No''s';
                    Image = ExecuteBatch;
                    RunObject = Codeunit "Assign Batch No's";
                    ApplicationArea = All;
                }
                action("Assgn Batches for Damage")
                {
                    Caption = 'Assgn Batches for Damage';
                    Image = ErrorFALedgerEntries;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF "Transfer-to Code" = 'DAMAGE' THEN BEGIN
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT

                                    Dmg_Qty := "Material Issues Line".Quantity;
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Service Item", "Service Item");
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code", "Transfer-from Code");
                                    IF "Posted Material Issues Header".FINDSET THEN
                                        REPEAT

                                            IF Dmg_Qty > 0 THEN BEGIN
                                                "Posted Material Issues Lines".SETRANGE("Posted Material Issues Lines"."Document No.",
                                                                                        "Posted Material Issues Header"."No.");
                                                "Posted Material Issues Lines".SETRANGE("Posted Material Issues Lines"."Item No.", "Material Issues Line"."Item No.");
                                                IF "Posted Material Issues Lines".FINDFIRST THEN BEGIN

                                                    itemledgerentry.RESET;
                                                    itemledgerentry.SETCURRENTKEY(itemledgerentry."Document No.", itemledgerentry."Item No.", itemledgerentry."Posting Date"
                                        );
                                                    itemledgerentry.SETRANGE(itemledgerentry."Document No.", "Posted Material Issues Lines"."Document No.");
                                                    itemledgerentry.SETRANGE(itemledgerentry."Item No.", "Material Issues Line"."Item No.");
                                                    itemledgerentry.SETFILTER(itemledgerentry."Remaining Quantity", '>%1', 0);
                                                    IF itemledgerentry.FINDFIRST THEN BEGIN

                                                        IF Dmg_Qty <= itemledgerentry."Remaining Quantity" THEN BEGIN
                                                            TrackingSpecification.INIT;
                                                            TrackingSpecification."Order No." := "Material Issues Line"."Document No.";
                                                            TrackingSpecification."Order Line No." := "Material Issues Line"."Line No.";
                                                            TrackingSpecification."Item No." := "Material Issues Line"."Item No.";
                                                            TrackingSpecification."Location Code" := itemledgerentry."Location Code";
                                                            TrackingSpecification."Lot No." := itemledgerentry."Lot No.";
                                                            TrackingSpecification."Serial No." := itemledgerentry."Serial No.";
                                                            TrackingSpecification."Actual Quantity" := "Material Issues Line".Quantity;
                                                            TrackingSpecification."Actual Qty to Receive" := "Material Issues Line"."Qty. to Receive";
                                                            TrackingSpecification.Description := "Material Issues Line".Description;
                                                            TrackingSpecification."Creation Date" := WORKDATE;
                                                            TrackingSpecification."Appl.-to Item Entry" := itemledgerentry."Entry No.";
                                                            TrackingSpecification."Warranty date" := itemledgerentry."Warranty Date";
                                                            TrackingSpecification."Expiration Date" := itemledgerentry."Expiration Date";
                                                            TrackingSpecification."Prod. Order No." := "Material Issues Line"."Prod. Order No.";
                                                            TrackingSpecification."Prod. Order Line No." := "Material Issues Line"."Prod. Order Line No.";
                                                            TrackingSpecification.Quantity := Dmg_Qty;
                                                            TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                                            Dmg_Qty := 0;
                                                            TrackingSpecification.INSERT;
                                                        END ELSE BEGIN

                                                            TrackingSpecification.INIT;
                                                            TrackingSpecification."Order No." := "Material Issues Line"."Document No.";
                                                            TrackingSpecification."Order Line No." := "Material Issues Line"."Line No.";
                                                            TrackingSpecification."Item No." := "Material Issues Line"."Item No.";
                                                            TrackingSpecification."Location Code" := itemledgerentry."Location Code";
                                                            TrackingSpecification."Lot No." := itemledgerentry."Lot No.";
                                                            TrackingSpecification."Serial No." := itemledgerentry."Serial No.";
                                                            TrackingSpecification."Actual Quantity" := "Material Issues Line".Quantity;
                                                            TrackingSpecification."Actual Qty to Receive" := "Material Issues Line"."Qty. to Receive";
                                                            TrackingSpecification.Description := "Material Issues Line".Description;
                                                            TrackingSpecification."Creation Date" := WORKDATE;
                                                            TrackingSpecification."Appl.-to Item Entry" := itemledgerentry."Entry No.";
                                                            TrackingSpecification."Warranty date" := itemledgerentry."Warranty Date";
                                                            TrackingSpecification."Expiration Date" := itemledgerentry."Expiration Date";
                                                            TrackingSpecification."Prod. Order No." := "Material Issues Line"."Prod. Order No.";
                                                            TrackingSpecification."Prod. Order Line No." := "Material Issues Line"."Prod. Order Line No.";
                                                            TrackingSpecification.Quantity := Dmg_Qty - itemledgerentry."Remaining Quantity";
                                                            TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                                            Dmg_Qty := Dmg_Qty - itemledgerentry."Remaining Quantity";
                                                            TrackingSpecification.INSERT;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        UNTIL "Posted Material Issues Header".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;
                    end;
                }
                action("Assign Batches From Prod -STR")
                {
                    Caption = 'Assign Batches From Prod -STR';
                    Image = ExecuteAndPostBatch;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        TESTFIELD(Status, Status::Released);
                        IF (("Transfer-to Code" = 'STR') OR ("Transfer-to Code" = 'MCH')) AND
                           (("Transfer-from Code" = 'PROD') OR ("Transfer-from Code" = 'MCH')) THEN BEGIN
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT

                                    Dmg_Qty := "Material Issues Line".Quantity;
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Prod. Order No.", "Prod. Order No.");
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Prod. Order Line No.", "Prod. Order Line No.");
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-to Code", "Transfer-from Code");
                                    "Posted Material Issues Header".SETRANGE("Posted Material Issues Header"."Transfer-from Code", "Transfer-to Code");
                                    IF "Posted Material Issues Header".FINDSET THEN
                                        REPEAT

                                            IF Dmg_Qty > 0 THEN BEGIN
                                                "Posted Material Issues Lines".SETRANGE("Posted Material Issues Lines"."Document No.",
                                                                                        "Posted Material Issues Header"."No.");
                                                "Posted Material Issues Lines".SETRANGE("Posted Material Issues Lines"."Item No.", "Material Issues Line"."Item No.");
                                                IF "Posted Material Issues Lines".FINDFIRST THEN BEGIN
                                                    ILE_QTY := 0;
                                                    itemledgerentry.RESET;
                                                    itemledgerentry.SETCURRENTKEY(itemledgerentry."Document No.", itemledgerentry."Item No.", itemledgerentry."Posting Date"
                                        );
                                                    itemledgerentry.SETRANGE(itemledgerentry."Document No.", "Posted Material Issues Lines"."Document No.");
                                                    itemledgerentry.SETRANGE(itemledgerentry."Location Code", "Transfer-from Code");
                                                    itemledgerentry.SETRANGE(itemledgerentry."Item No.", "Material Issues Line"."Item No.");
                                                    itemledgerentry.SETFILTER(itemledgerentry."Remaining Quantity", '>%1', 0);
                                                    IF itemledgerentry.FINDFIRST THEN BEGIN
                                                        REPEAT
                                                            ILE_QTY += itemledgerentry."Remaining Quantity";
                                                        UNTIL itemledgerentry.NEXT = 0;

                                                        IF Dmg_Qty <= ILE_QTY THEN BEGIN
                                                            TrackingSpecification.INIT;
                                                            TrackingSpecification."Order No." := "Material Issues Line"."Document No.";
                                                            TrackingSpecification."Order Line No." := "Material Issues Line"."Line No.";
                                                            TrackingSpecification."Item No." := "Material Issues Line"."Item No.";
                                                            TrackingSpecification."Location Code" := itemledgerentry."Location Code";
                                                            TrackingSpecification."Lot No." := itemledgerentry."Lot No.";
                                                            TrackingSpecification."Serial No." := itemledgerentry."Serial No.";
                                                            TrackingSpecification."Actual Quantity" := "Material Issues Line".Quantity;
                                                            TrackingSpecification."Actual Qty to Receive" := "Material Issues Line"."Qty. to Receive";
                                                            TrackingSpecification.Description := "Material Issues Line".Description;
                                                            TrackingSpecification."Creation Date" := WORKDATE;
                                                            TrackingSpecification."Appl.-to Item Entry" := itemledgerentry."Entry No.";
                                                            TrackingSpecification."Warranty date" := itemledgerentry."Warranty Date";
                                                            TrackingSpecification."Expiration Date" := itemledgerentry."Expiration Date";
                                                            TrackingSpecification."Prod. Order No." := "Material Issues Line"."Prod. Order No.";
                                                            TrackingSpecification."Prod. Order Line No." := "Material Issues Line"."Prod. Order Line No.";
                                                            TrackingSpecification.Quantity := Dmg_Qty;
                                                            TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                                            Dmg_Qty := 0;
                                                            TrackingSpecification.INSERT;
                                                        END ELSE BEGIN

                                                            TrackingSpecification.INIT;
                                                            TrackingSpecification."Order No." := "Material Issues Line"."Document No.";
                                                            TrackingSpecification."Order Line No." := "Material Issues Line"."Line No.";
                                                            TrackingSpecification."Item No." := "Material Issues Line"."Item No.";
                                                            TrackingSpecification."Location Code" := itemledgerentry."Location Code";
                                                            TrackingSpecification."Lot No." := itemledgerentry."Lot No.";
                                                            TrackingSpecification."Serial No." := itemledgerentry."Serial No.";
                                                            TrackingSpecification."Actual Quantity" := "Material Issues Line".Quantity;
                                                            TrackingSpecification."Actual Qty to Receive" := "Material Issues Line"."Qty. to Receive";
                                                            TrackingSpecification.Description := "Material Issues Line".Description;
                                                            TrackingSpecification."Creation Date" := WORKDATE;
                                                            TrackingSpecification."Appl.-to Item Entry" := itemledgerentry."Entry No.";
                                                            TrackingSpecification."Warranty date" := itemledgerentry."Warranty Date";
                                                            TrackingSpecification."Expiration Date" := itemledgerentry."Expiration Date";
                                                            TrackingSpecification."Prod. Order No." := "Material Issues Line"."Prod. Order No.";
                                                            TrackingSpecification."Prod. Order Line No." := "Material Issues Line"."Prod. Order Line No.";
                                                            TrackingSpecification.Quantity := Dmg_Qty - ILE_QTY;
                                                            TrackingSpecification.VALIDATE(TrackingSpecification.Quantity);
                                                            Dmg_Qty := Dmg_Qty - ILE_QTY;
                                                            TrackingSpecification.INSERT;
                                                        END;
                                                    END;
                                                END;
                                            END;
                                        UNTIL "Posted Material Issues Header".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;
                    end;
                }
                separator(Action1102152021)
                {
                }
                action("Calculate Quantity")
                {
                    Caption = 'Calculate Quantity';
                    Image = CalculateInventory;
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
                action("Request for Authorization")
                {
                    Caption = 'Request for Authorization';
                    Image = SendApprovalRequest;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Body := '';
                        IF (((("Transfer-to Code" = 'RD1') OR ("Transfer-to Code" = 'RD2') OR ("Transfer-to Code" = 'RD3') OR ("Transfer-to Code" = 'RD4') OR
                        ("Transfer-to Code" = 'RD5') OR ("Transfer-to Code" = 'RD6') OR ("Transfer-to Code" = 'RHW')) AND (("Transfer-from Code" = 'R&D STR')))
                        OR (("Transfer-to Code" = 'R&D STR') AND (
                        ("Transfer-from Code" = 'RD1') OR ("Transfer-from Code" = 'RD2') OR ("Transfer-from Code" = 'RD3') OR ("Transfer-from Code" = 'RD4') OR
                        ("Transfer-from Code" = 'RD5') OR ("Transfer-from Code" = 'RD6') OR ("Transfer-from Code" = 'RHW') OR ("Transfer-from Code" = 'R&D')))
                        OR (("Transfer-to Code" = 'DAMAGE') AND (
                        ("Transfer-from Code" = 'RD1') OR ("Transfer-from Code" = 'RD2') OR ("Transfer-from Code" = 'RD3') OR ("Transfer-from Code" = 'RD4') OR
                        ("Transfer-from Code" = 'RD5') OR ("Transfer-from Code" = 'RD6') OR ("Transfer-from Code" = 'RHW')))) OR ("Transfer-to Code" = 'DC') THEN BEGIN

                            IF "Prod. Order No." = '' THEN
                                ERROR('You must specify Production order no in Material Requests Header');

                            IF "Prod. Order Line No." = 0 THEN
                                ERROR('You must specify Production order line no in Material Requests Header');

                            IF "Request for Authorization" = '' THEN
                                ERROR('You must specify Authorised Person at Material Issues Header');

                            MIL.SETRANGE(MIL."Document No.", "No.");
                            IF MIL.FINDSET THEN
                                REPEAT
                                    IF MIL.Quantity = 0 THEN
                                        ERROR('You must specify the Quantity at Material Issues Line part');
                                UNTIL MIL.NEXT = 0;

                            //Rev01 Start
                            //Code Commented
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            //Rev01 End
                            IF "Mail-Id".FINDFIRST THEN
                                "from Mail" := "Mail-Id".MailID
                            ELSE
                                ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');
                            //Mail_From:='anilkumar@efftronics.com';
                            "Mail-Id".RESET;
                            //Rev01 Start
                            //Code Commented
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Request for Authorization");
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", "Request for Authorization");
                            //Rev01 End
                            IF "Mail-Id".FINDFIRST THEN BEGIN
                                IF "Mail-Id".levels = TRUE THEN begin
                                    //Mail_To := "Mail-Id".MailID  //B2B UPG
                                    Recipient.Add("Mail-Id".MailID);
                                end
                                ELSE
                                    ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                            END;
                            IF ("Transfer-to Code" = 'DC') THEN BEGIN
                                IF Remarks = '' THEN
                                    ERROR('Please specify the DC purpose in Remarks Column');
                                IF ("Shortcut Dimension 2 Code" = '') AND ("Vendor No." = '') THEN
                                    ERROR('Please specify the Location code');
                                IF FORMAT("Mode of Transport") = '' THEN
                                    ERROR('Please enter the Mode of Transport');

                            END;
                            IF ("Transfer-to Code" = 'R&D STR') AND ("Transfer-to Code" = 'DAMAGE') THEN BEGIN
                                IF "Reason Code" = '' THEN
                                    ERROR('You Need to Mention the Reason Code at Material Issues Header Part');
                                IF ("Transfer-to Code" = 'R&D STR') THEN
                                    Subject := 'Request for Authorisation of Return Material' + FORMAT("No.");
                                IF ("Transfer-to Code" = 'DAMAGE') THEN
                                    Subject := 'Request for Authorisation of Damage Items' + FORMAT("No.");
                                MIL.RESET;
                                MIL.SETRANGE(MIL."Document No.", "No.");
                                IF MIL.FINDSET THEN
                                    REPEAT
                                        MITS.SETRANGE(MITS."Order No.", MIL."Document No.");
                                        MITS.SETRANGE(MITS."Prod. Order Line No.", MIL."Line No.");
                                        MITS.SETRANGE(MITS."Item No.", MIL."Item No.");
                                        IF MITS.FINDFIRST THEN BEGIN
                                            IF (MITS."Serial No." = '') AND (MITS."Lot No." = '') THEN
                                                ERROR('You need to mention the Tracking for this Return Request');
                                        END;
                                    UNTIL MIL.NEXT = 0;
                            END ELSE
                                IF "Transfer-to Code" = 'DAMAGE' THEN
                                    Subject := 'Damaged item Request for Authorisation' + FORMAT("No.")
                                ELSE
                                    IF "Transfer-to Code" = 'DC' THEN
                                        Subject := 'DC items Request for Authorisation' + FORMAT("No.")
                                    ELSE
                                        Subject := 'Material Request for Authorisation' + FORMAT("No.");
                            //Mail_From:='sreenu@efftronics.com';
                            //Mail_To:='sreenu@efftronics.com';
                            Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                            //cellspacing="7"
                            //cellpadding="1"
                            //width="105"
                            Body += 'border="1" align="center">';
                            Body += '<tr><td>Requested No</td><td>' + "No." + '</td></tr><br>';
                            Body += '<tr><td>Requested User</td><td>' + "User ID" + ':  ' + "Resource Name" + '</td></tr><br>';
                            //Body+='<tr><td>Required Date</td><td>'+FORMAT("Required Date",0,'<Day>-<Month Text,3>-<Year4>')+'</td></tr>';
                            //Body+='<tr><td>Released Date</td><td>'+FORMAT("Released Date",0,'<Day>-<Month Text,3>-<Year4>')+'</td></tr><br>';
                            Body += '<tr><td>Project Name</td><td>' + "Proj Description" + '</td></tr>';
                            //Body+='<tr><td>Sal.Person</td><td>'++'</td></tr>';
                            //Body+='<tr><td>Req.Comments</td><td>'+''+'</td></tr>';
                            Body += '<tr><td bgcolor="green">'; //#009900
                                                                //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                                                                //Body+='<a Href="http://efffax/erpmatauth/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                                                                //Body+='<a Href="http://Intranet:8080/ERP%20MAT-AUH/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                            Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT("No.") + '&val2=' + FORMAT("User ID");
                            //Body+='&val2=';
                            //Body+='<a Href="http://intranet:8080/erp_mat_auh/Mat_Auth.aspx?val1='+FORMAT("No.");
                            //Body+='<a Href="http://eff-cpu-315:5556/erp_reports/Mat_Auth.aspx?val1='+FORMAT("No.");
                            //Body+='&val2='+FORMAT("User ID");
                            Body += '&val3=' + FORMAT("Request for Authorization");
                            Body += '&val4=1';
                            Body += '&val5=' + Mail_To;
                            Body += '&val6=' + "from Mail";
                            Body += '&val7=Accepted"target="_blank">';
                            //Calibri,#ffffff white
                            Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                            Body += '</td><td bgcolor="red">';
                            //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.");
                            //Body+='<a Href="http://intranet:8080/erp_mat_auh/Mat_Auth.aspx?val1='+FORMAT("No.");
                            Body += '<a Href="http://192.168.0.155:5556/erp_reports/Mat_Auth.aspx?val1=' + FORMAT("No.");
                            Body += '&val2=' + FORMAT("User ID");
                            Body += '&val3=' + FORMAT("Request for Authorization");
                            Body += '&val4=0';
                            Body += '&val5=' + Mail_To;
                            Body += '&val6=' + "from Mail";
                            Body += '&val7=Rejected';
                            Body += '"target="_blank">';
                            Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                            Body += '</table></form></font></strong></body>';
                            MR.SETRANGE(MR."No.", "No.");
                            IF MR.FINDFIRST THEN
                                REPORT.RUN(50182, FALSE, FALSE, MR);
                            //REPORT.SAVEASHTML(50182,'\\Eff-cpu-211\srinivas\Mat-req-report.htm',FALSE,MR);
                            //REPORT.SAVEASHTML(50182,'\\eff-cpu-211\ERP\Mat-req-report.htm',FALSE,MR);
                            //REPORT.SAVEASHTML(50182,'\\erpserver\ERPAttachments\Mat-req-report.htm',FALSE,MR);
                            //REPORT.SAVEASHTML(50182,'\\erpserver\ErpAttachments\ErpAttachments1\Mat-req-report2.htm',FALSE,MR);  // changed by mohan
                            REPORT.SAVEASHTML(50182, '\\erpserver\ErpAttachments\ErpAttachments1\' + "No." + '.htm', MR);
                            //Attachment:='\\eff-cpu-211\srinivas\Mat-req-report.htm';
                            //Attachment:='\\eff-cpu-211\ERP\Mat-req-report.htm';
                            //Attachment:='\\erpserver\ErpAttachments\ErpAttachments1\Mat-req-report2.htm';
                            Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + "No." + '.htm';

                            //B2B UPG >>>
                            /* SMTP_MAIL.CreateMessage("Mail-Id"."User Name", "from Mail", Mail_To, Subject, Body, TRUE);
                            SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added('')
                            SMTP_MAIL.Send; */ //B2B UPG <<<

                            EmailMessage.Create(Recipient, Subject, Body, true);
                            EmailMessage.AddAttachment(Attachment, '', '');
                            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                            //NewCDOMessage("from Mail",Mail_To,Subject,Body,Attachment);
                            // CODE COMMENTED FOR NAVISION  UPGRADATION

                            MESSAGE('Mail Has been Sent');
                        END ELSE
                            ERROR('This Request is only for R&D Stores Only');

                    end;
                }
                action("Request for Special Authorization")
                {
                    Caption = 'Request for Special Authorization';
                    Image = SendApprovalRequest;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Body := '';
                        IF ((("Transfer-to Code" = 'RD1') OR ("Transfer-to Code" = 'RD2') OR ("Transfer-to Code" = 'RD3') OR ("Transfer-to Code" = 'RD4') OR
                        ("Transfer-to Code" = 'RD5') OR ("Transfer-to Code" = 'RD6') OR ("Transfer-to Code" = 'RHW')) AND (("Transfer-from Code" = 'R&D STR')))
                        OR (("Transfer-to Code" = 'R&D STR') AND (
                        ("Transfer-from Code" = 'RD1') OR ("Transfer-from Code" = 'RD2') OR ("Transfer-from Code" = 'RD3') OR ("Transfer-from Code" = 'RD4') OR
                        ("Transfer-from Code" = 'RD5') OR ("Transfer-from Code" = 'RD6') OR ("Transfer-from Code" = 'RHW')))
                        OR (("Transfer-to Code" = 'DAMAGE') AND (
                        ("Transfer-from Code" = 'RD1') OR ("Transfer-from Code" = 'RD2') OR ("Transfer-from Code" = 'RD3') OR ("Transfer-from Code" = 'RD4') OR
                        ("Transfer-from Code" = 'RD5') OR ("Transfer-from Code" = 'RD6') OR ("Transfer-from Code" = 'RHW'))) THEN BEGIN

                            IF "Prod. Order No." = '' THEN
                                ERROR('You must specify Production order no in Material Requests Header');

                            IF "Prod. Order Line No." = 0 THEN
                                ERROR('You must specify Production order line no in Material Requests Header');

                            IF "Request for Authorization" = '' THEN
                                ERROR('You must specify Authorised Person at Material Issues Header');

                            MIL.SETRANGE(MIL."Document No.", "No.");
                            IF MIL.FINDSET THEN
                                REPEAT
                                    IF MIL.Quantity = 0 THEN
                                        ERROR('You must specify the Quantity at Material Issues Line part');
                                UNTIL MIL.NEXT = 0;
                            //Rev01 Start
                            //Code Commented
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID",USERID);
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            //Rev01 End
                            IF "Mail-Id".FINDFIRST THEN
                                "from Mail" := "Mail-Id".MailID
                            ELSE
                                ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');
                            //Mail_From:='anilkumar@efftronics.com';
                            "Mail-Id".RESET;
                            //Rev01 Start
                            //Code Commented
                            /*
                            "Mail-Id".SETRANGE("Mail-Id"."User Security ID","Request for Authorization");
                            */
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", "Request for Authorization");
                            //Rev01 End
                            IF "Mail-Id".FINDFIRST THEN BEGIN
                                IF "Mail-Id".levels = TRUE THEN begin
                                    //Mail_To := "Mail-Id".MailID //B2B UPG
                                    Recipient.Add("Mail-Id".MailID);
                                end
                                ELSE
                                    ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor');
                            END;
                            IF ("Transfer-to Code" = 'R&D STR') OR ("Transfer-to Code" = 'DAMAGE') THEN BEGIN
                                IF "Reason Code" = '' THEN
                                    ERROR('You Need to Mention the Reason Code at Material Issues Header Part');
                                IF ("Transfer-to Code" = 'R&D STR') THEN
                                    Subject := 'Request for Authorisation of Return Material' + FORMAT("No.");
                                IF ("Transfer-to Code" = 'DAMAGE') THEN
                                    Subject := 'Request for Authorisation of Damage Items' + FORMAT("No.");
                                MIL.RESET;
                                MIL.SETRANGE(MIL."Document No.", "No.");
                                IF MIL.FINDSET THEN
                                    REPEAT
                                        MITS.SETRANGE(MITS."Order No.", MIL."Document No.");
                                        MITS.SETRANGE(MITS."Prod. Order Line No.", MIL."Line No.");
                                        MITS.SETRANGE(MITS."Item No.", MIL."Item No.");
                                        IF MITS.FINDFIRST THEN BEGIN
                                            IF (MITS."Serial No." = '') AND (MITS."Lot No." = '') THEN
                                                ERROR('You need to mention the Tracking for this Return Request');
                                        END;
                                    UNTIL MIL.NEXT = 0;
                            END ELSE
                                IF "Transfer-to Code" = 'DAMAGE' THEN
                                    Subject := 'Damaged item Request for Authorisation' + FORMAT("No.")
                                ELSE
                                    Subject := 'Material Request for Authorisation' + FORMAT("No.");

                            Body += '<body><strong><form><table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"';
                            //cellspacing="7"
                            //cellpadding="1"
                            //width="105"
                            Body += 'border="1" align="center">';
                            Body += '<tr><td>Requested No</td><td>' + "No." + '</td></tr><br>';
                            Body += '<tr><td>Requested User</td><td>' + "User ID" + ':  ' + "Resource Name" + '</td></tr><br>';
                            //Body+='<tr><td>Required Date</td><td>'+FORMAT("Required Date",0,'<Day>-<Month Text,3>-<Year4>')+'</td></tr>';
                            //Body+='<tr><td>Released Date</td><td>'+FORMAT("Released Date",0,'<Day>-<Month Text,3>-<Year4>')+'</td></tr><br>';
                            Body += '<tr><td>Project Name</td><td>' + "Proj Description" + '</td></tr>';
                            //Body+='<tr><td>Sal.Person</td><td>'++'</td></tr>';
                            //Body+='<tr><td>Req.Comments</td><td>'+''+'</td></tr>';
                            Body += '<tr><td bgcolor="green">'; //#009900
                                                                //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                            Body += '<a Href="http://efffax/erpmatauth/webform1.aspx?val1=' + FORMAT("No.") + '&val2=' + FORMAT("User ID");
                            //Body+='&val2=';
                            Body += '&val3=' + FORMAT("Request for Authorization");
                            Body += '&val4=1';
                            Body += '&val5=' + Mail_To;
                            Body += '&val6=' + "from Mail";
                            Body += '&val7=Accepted"target="_blank">';
                            //Calibri,#ffffff white
                            Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                            Body += '</td><td bgcolor="red">';
                            //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.");
                            Body += '<a Href="http://efffax/erpmatauth/webform1.aspx?val1=' + FORMAT("No.");
                            Body += '&val2=' + FORMAT("User ID");
                            Body += '&val3=' + FORMAT("Request for Authorization");
                            Body += '&val4=0';
                            Body += '&val5=' + Mail_To;
                            Body += '&val6=' + "from Mail";
                            Body += '&val7=Rejected';
                            Body += '"target="_blank">';
                            Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                            Body += '</table></form></font></strong></body>';
                            MR.SETRANGE(MR."No.", "No.");
                            IF MR.FINDFIRST THEN
                                REPORT.RUN(50182, FALSE, FALSE, MR);
                            REPORT.SAVEASHTML(50182, '\\Eff-cpu-211\srinivas\Mat-req-report.htm', MR);
                            Attachment := '\\eff-cpu-211\srinivas\Mat-req-report.htm';
                            //NewCDOMessage("from Mail",Mail_To,Subject,Body,Attachment);
                            MESSAGE('Mail Has been Sent');
                        END ELSE
                            ERROR('This Request is only for R&D Stores Only');

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
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IF ("Transfer-from Code" = 'CS') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            SMSetup.GET;
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Item Wise Min. Req. Qty at Loc".RESET;
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                              "Shortcut Dimension 2 Code");
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
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
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                "Service_ Item".INSERT;
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";

                                                "Service_ Item".Description := Mat_Issue_sLine.Description;
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                "Service_ Item".MODIFY;
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
                        IF (("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'CS')) THEN BEGIN
                            SMSetup.GET;
                            "Material Issues Line".RESET;
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

                                    IF ("Material Issues Line"."Shortcut Dimension 2 Code" = 'SERVICE') THEN BEGIN
                                        SMSetup.GET();
                                        "Service Header".RESET;
                                        "Service Header".SETRANGE("Service Header"."Material Issue no.", "No.");
                                        IF NOT ("Service Header".FINDFIRST) THEN BEGIN
                                            "Service Header".INIT;

                                            "Service Header"."Document Type" := "Service Header"."Document Type"::Order;
                                            "Service Header"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Order Nos.", WORKDATE, TRUE);
                                            Service_Order_No_ := "Service Header"."No.";
                                            "Service Header"."Customer No." := 'CS INT';
                                            "Service Header"."Order Date" := WORKDATE;
                                            "Service Header"."Bill-to Customer No." := 'CS INT';
                                            "Service Header".VALIDATE("Service Header"."Shipping No. Series", 'PSH');
                                            "Service Header"."Order Time" := TIME;
                                            "Service Header"."Service Order Type" := 'CUS';
                                            "Service Header".VALIDATE("Service Header"."Customer No.", 'CS INT');
                                            "Service Header"."Posting No. Series" := SMSetup."Posted Service Invoice Nos.";
                                            "Dimension Value".RESET;
                                            "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                            "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                            IF "Dimension Value".FINDFIRST THEN
                                                "Service Header".Description := "Dimension Value".Name;


                                            "Service Header"."Material Issue no." := "No.";
                                            "Service Header".INSERT;
                                            Order_Line_No := 0;
                                        END ELSE
                                            Service_Order_No_ := "Service Header"."No.";
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
                                                    "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                    "Service_ Item".INSERT;
                                                    "Service_ Item"."Item No." := "Material Issues Line"."Item No.";

                                                    "Service_ Item".Description := "Material Issues Line".Description;

                                                    "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                    "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
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
                                                        "Service Item Line"."Item No." := "Service_ Item"."Item No.";
                                                        "Service Item Line".Description := "Material Issues Line".Description;
                                                        "Service Item Line"."Serial No." := "Service_ Item"."Serial No.";


                                                        "Service Item Line"."From Location" := 'Service';
                                                        "Service Item Line".INSERT;
                                                    END;
                                                END ELSE BEGIN
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::WORKING;
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
                                                        "Service Item Line"."Item No." := "Service_ Item"."Item No.";
                                                        "Service Item Line".Description := "Material Issues Line".Description;
                                                        "Service Item Line"."Serial No." := "Service_ Item"."Serial No.";
                                                        "Service Item Line"."From Location" := 'Service';
                                                        "Service Item Line".INSERT;
                                                    END;
                                                END;
                                            UNTIL "Tracking Specification".NEXT = 0;
                                    END ELSE BEGIN
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
                                                    "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                    "Service_ Item".INSERT;
                                                    "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                    "Service_ Item".Description := Mat_Issue_sLine.Description;

                                                    "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                    "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item".MODIFY;

                                                END ELSE BEGIN
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::WORKING;
                                                    "Service_ Item".MODIFY;
                                                END;
                                            UNTIL "Tracking Specification".NEXT = 0;
                                    END;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;





                        IF (("Transfer-to Code" = 'OLD STOCK') AND ("Transfer-from Code" = 'SITE')) THEN BEGIN
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
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                "Service_ Item".INSERT;
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".Description := "Material Issues Line".Description;

                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'PRODUCT');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".MODIFY;
                                            END ELSE BEGIN
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'PRODUCT');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;


                                                "Service_ Item".MODIFY;
                                            END;
                                        UNTIL "Tracking Specification".NEXT = 0;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;

                        //added by Sundar---
                        IF (("Transfer-from Code" = 'OLD STOCK') AND ("Transfer-to Code" = 'SITE')) THEN BEGIN
                            SMSetup.GET();
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    "Item Wise Min. Req. Qty at Loc".RESET;
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                              "Shortcut Dimension 2 Code");
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
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
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                "Service_ Item".INSERT;
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".Description := "Material Issues Line".Description;

                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::"NON-WORKING";
                                                "Service_ Item".MODIFY;
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
                        //---added by Sundar


                        IF ("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'DUMMY') THEN BEGIN
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
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                "Service_ Item".INSERT;
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".Description := "Material Issues Line".Description;
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".MODIFY;
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
                                    "Item Wise Min. Req. Qty at Loc".RESET;
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Location,
                                                                              "Material Issues Line"."Shortcut Dimension 2 Code");
                                    "Item Wise Min. Req. Qty at Loc".SETRANGE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
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
                                                "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                "Service_ Item".INSERT;
                                                "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                "Service_ Item".Description := "Material Issues Line".Description;
                                                "Service_ Item".VALIDATE("Service_ Item"."Item No.", "Material Issues Line"."Item No.");
                                                "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                "Dimension Value".RESET;
                                                "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", "Shortcut Dimension 2 Code");
                                                "Dimension Value".SETRANGE("Dimension Value".Code, 'DUMMY');
                                                IF "Dimension Value".FINDFIRST THEN
                                                    "Service_ Item"."Present Location" := "Dimension Value".Name;

                                                "Service_ Item".MODIFY;
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

                        "Material Issues Line".RESET;
                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                        "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", 'METOLGN00086');
                        "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                        IF "Material Issues Line".FINDSET THEN
                            REPEAT
                                "Tracking Specification".RESET;
                                "Tracking Specification".SETRANGE("Tracking Specification"."Order No.", "No.");
                                "Tracking Specification".SETRANGE("Tracking Specification"."Order Line No.", "Material Issues Line"."Line No.");
                                "Tracking Specification".SETRANGE("Tracking Specification"."Item No.", "Material Issues Line"."Item No.");
                                IF "Tracking Specification".FINDSET THEN
                                    REPEAT
                                        MTS.RESET;
                                        MTS.SETFILTER(MTS."Serial No.", TrackingSpecification."Serial No.");
                                        MTS.SETFILTER(MTS."Lot No.", TrackingSpecification."Lot No.");
                                        IF NOT MTS.FINDFIRST THEN BEGIN
                                            MTS.INIT;
                                            MTS."Multimeter No" := 'METOLGN00086';
                                            MTS."Serial No." := TrackingSpecification."Serial No.";
                                            MTS."Lot No." := TrackingSpecification."Lot No.";
                                            MTS."Global Dimension 1 Code" := "Transfer-to Code";
                                            MTS."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                            MTS."Responsible Person" := "User ID";
                                            MTS.RESET;
                                        END
                                        ELSE BEGIN
                                            MTS."Global Dimension 1 Code" := "Transfer-to Code";
                                            MTS."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                            IF "Transfer-to Code" = 'CS STR' THEN
                                                MTS."Responsible Person" := '20P2009';

                                            IF "Transfer-from Code" = 'QC' THEN
                                                MTS."Next Calibration Date" := "Posting Date" + 60;
                                            MTS.MODIFY;
                                        END;
                                    UNTIL "Tracking Specification".NEXT = 0;
                            UNTIL "Material Issues Line".NEXT = 0;

                        IF "Transfer-to Code" <> 'DC' THEN
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
                action("Service Order")
                {
                    Caption = 'Service Order';
                    Image = ServiceOrderSetup;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF (("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'CS')) THEN BEGIN
                            SMSetup.GET;
                            "Material Issues Line".RESET;
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
                                        "Item Wise Min. Req. Qty at Loc".Location := "Shortcut Dimension 2 Code";
                                        "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Location,
                                                                                  "Shortcut Dimension 2 Code");
                                        "Item Wise Min. Req. Qty at Loc".Item := "Material Issues Line"."Item No.";
                                        "Item Wise Min. Req. Qty at Loc".VALIDATE("Item Wise Min. Req. Qty at Loc".Item, "Material Issues Line"."Item No.");
                                        "Item Wise Min. Req. Qty at Loc"."Base Location" := 'SITE';
                                        "Item Wise Min. Req. Qty at Loc".INSERT;
                                    END;

                                    IF ("Material Issues Line"."Shortcut Dimension 2 Code" = 'SERVICE') THEN BEGIN
                                        SMSetup.GET();
                                        "Service Header".RESET;
                                        "Service Header".SETRANGE("Service Header"."Material Issue no.", "No.");
                                        IF NOT ("Service Header".FINDFIRST) THEN BEGIN
                                            "Service Header".INIT;

                                            "Service Header"."Document Type" := "Service Header"."Document Type"::Order;
                                            "Service Header"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Order Nos.", WORKDATE, TRUE);
                                            Service_Order_No_ := "Service Header"."No.";
                                            "Service Header"."Customer No." := 'CS INT';
                                            "Service Header"."Order Date" := WORKDATE;
                                            "Service Header"."Bill-to Customer No." := 'CS INT';
                                            "Service Header".VALIDATE("Service Header"."Shipping No. Series", 'PSH');
                                            "Service Header"."Order Time" := TIME;
                                            "Service Header"."Service Order Type" := 'CUS';
                                            "Service Header".VALIDATE("Service Header"."Customer No.", 'CS INT');
                                            "Service Header"."Posting No. Series" := SMSetup."Posted Service Invoice Nos.";
                                            "Dimension Value".RESET;
                                            "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                            "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                            IF "Dimension Value".FINDFIRST THEN
                                                "Service Header".Description := "Dimension Value".Name;


                                            "Service Header"."Material Issue no." := "No.";
                                            "Service Header".INSERT;
                                            Order_Line_No := 0;
                                        END ELSE
                                            Service_Order_No_ := "Service Header"."No.";
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
                                                    "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                    "Service_ Item".INSERT;
                                                    "Service_ Item"."Item No." := "Material Issues Line"."Item No.";

                                                    "Service_ Item".Description := "Material Issues Line".Description;

                                                    "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                    "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
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
                                                        "Service Item Line"."Item No." := "Service_ Item"."Item No.";
                                                        "Service Item Line".Description := "Material Issues Line".Description;
                                                        "Service Item Line"."Serial No." := "Service_ Item"."Serial No.";


                                                        "Service Item Line"."From Location" := 'Service';
                                                        "Service Item Line".INSERT;
                                                    END;
                                                END ELSE BEGIN
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::WORKING;
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
                                                        "Service Item Line"."Item No." := "Service_ Item"."Item No.";
                                                        "Service Item Line".Description := "Material Issues Line".Description;
                                                        "Service Item Line"."Serial No." := "Service_ Item"."Serial No.";
                                                        "Service Item Line"."From Location" := 'Service';
                                                        "Service Item Line".INSERT;
                                                    END;
                                                END;
                                            UNTIL "Tracking Specification".NEXT = 0;
                                    END ELSE BEGIN
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
                                                    "Service_ Item"."No." := NoSeriesMgt.GetNextNo(SMSetup."Service Item Nos.", WORKDATE, TRUE);
                                                    "Service_ Item".INSERT;
                                                    "Service_ Item"."Item No." := "Material Issues Line"."Item No.";
                                                    "Service_ Item".Description := Mat_Issue_sLine.Description;

                                                    "Service_ Item"."Serial No." := "Tracking Specification"."Serial No.";
                                                    "Service_ Item"."No. Series" := SMSetup."Service Item Nos.";
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item".MODIFY;

                                                END ELSE BEGIN
                                                    "Dimension Value".RESET;
                                                    "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                                    "Dimension Value".SETRANGE("Dimension Value".Code, "Material Issues Line"."Shortcut Dimension 2 Code");
                                                    IF "Dimension Value".FINDFIRST THEN
                                                        "Service_ Item"."Present Location" := "Dimension Value".Name;
                                                    "Service_ Item"."WORKING STATUS" := "Service_ Item"."WORKING STATUS"::WORKING;
                                                    "Service_ Item".MODIFY;
                                                END;
                                            UNTIL "Tracking Specification".NEXT = 0;
                                    END;
                                UNTIL "Material Issues Line".NEXT = 0;
                        END;
                    end;
                }
            }
            action("P&rint New")
            {
                Caption = 'P&rint New';
                Image = PrintCover;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Material Requisition Print";
                ApplicationArea = All;
            }
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DocPrint: Codeunit 229;
                begin
                    //DocPrint.PrintTransferHeader(Rec);
                    MaterialIssuesHeader.SETRANGE("No.", "No.");
                    REPORT.RUN(50010, TRUE, FALSE, MaterialIssuesHeader);
                end;
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = Refresh;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    /*IF Status<>Status::Released THEN
                    BEGIN
                    IF (USERID='SUPER') OR (USERID='05PD012') OR (USERID='99P2005') OR (USERID='10RD010') OR (USERID='07CS018') OR (USERID='07PD034')
                       OR (USERID='08QS005') OR (USERID='93FD001')  THEN
                    BEGIN
                    IF ISCLEAR(SQLConnection) THEN
                      CREATE(SQLConnection);
                    
                    IF ISCLEAR(RecordSet) THEN
                      CREATE(RecordSet);
                    
                    IF ConnectionOpen<>1 THEN
                    BEGIN
                      SQLConnection.ConnectionString :='DSN=salinvoiceuser;UID=salinvoiceuser;PASSWORD=salinvoiceuser;SERVER=oracle_80;';
                      SQLConnection.Open;
                      SQLConnection.BeginTrans;
                      ConnectionOpen:=1;
                    END;
                    SQLQuery := 'select requestid,status from materialauthor where (status=1) and materialauthor.requestid='''+FORMAT("No.")+'''';
                    //MESSAGE(SQLQuery);
                    RecordSet := SQLConnection.Execute(SQLQuery,RowCount);
                    //MESSAGE(FORMAT(RowCount));
                    IF RowCount < -1 THEN
                      ERROR('Request not yet authorized to Refresh the data')
                    ELSE
                    BEGIN
                    IF NOT((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                      RecordSet.MoveFirst;
                    
                    WHILE NOT RecordSet.EOF DO
                      BEGIN
                    
                        IF ("No."=FORMAT(RecordSet.Fields.Item('requestid').Value))  THEN
                        BEGIN
                          VALIDATE(Status,Status::Released);
                          VALIDATE("Released Date",WORKDATE);
                          VALIDATE("Released Time",TIME);
                          VALIDATE("Released By","Request for Authorization");
                          "Posting Date":=Workdate;
                          IF "Authorized Date"=0D THEN
                            "Authorized Date":=Workdate;
                          MODIFY;
                          MESSAGE('Data Refreshed');
                        END;
                    
                    
                        RecordSet.MoveNext;
                     END;
                    {IF ConnectionOpen=1 THEN
                    BEGIN
                      SQLConnection.Close;
                    END;}
                    END;
                    END ELSE
                    ERROR('You Do not Have Permission to Refresh');
                    END ELSE
                    ERROR('The Request has Already in the Released Mode');
                    *///B2b1.0

                end;
            }
            action(Comment)
            {
                Caption = 'Comment';
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Inventory Comment Sheet";
                RunPageLink = "Document Type" = CONST("Material Issues"), "No." = FIELD("No.");
                ToolTip = 'Comment';
                ApplicationArea = All;
            }
            action("Pending Requests AutoPosting")
            {
                Caption = 'Pending Requests AutoPosting';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    PAGE.RUN(50008);
                end;
            }
            action("Mail Alerts")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    "Mail alert": Query 50013;
                begin
                    //B2B UPG >>>
                    /* puserid := '';
                    IF CONFIRM('Do you want to send the mail alert?') THEN BEGIN
                        "from Mail" := 'erp@efftronics.com';
                        "to mail" := 'vsusmitha@efftronics.com';
                        Mail_Subject := 'Need to return items from the employee';
                        SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Body, TRUE);
                        SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                        SMTP_MAIL.AppendBody('<br>&nbsp  <br>');
                        SMTP_MAIL.AppendBody('These are the tools to be returned to QC for calibration.');
                        SMTP_MAIL.AppendBody('<html><head><style> divone{background-color: white; width: 2000px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                        SMTP_MAIL.AppendBody('<body><label><font size="5"><center>Need To Return Items</center></font></label>');
                        SMTP_MAIL.AppendBody('<br>&nbsp  <br>');
                        // SMTP_MAIL.AppendBody('<hr style=solid; color = #3333CC>');
                        SMTP_MAIL.AppendBody('</center></h3>');
                        SMTP_MAIL.AppendBody('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                        SMTP_MAIL.AppendBody('border="1" align="Center">');
                        SMTP_MAIL.AppendBody('<tr><td>Userid</td><td>Item No</td><td>Description</td><td>Lot no</td><td>Serial no</td><td>TransferFromCode</td><td>TransferToCode</td><td>ProductGroupCode</td></tr>');
                        //"Mail alert".SETFILTER(User_ID,'%1|%2','EFFTRONICS\PVIJAY', 'EFFTRONICS\GRAVI');
                        IF "Mail alert".OPEN THEN BEGIN


                            WHILE "Mail alert".READ DO BEGIN
                                IF (puserid <> '') AND (puserid <> "Mail alert".User_ID) AND (DateAndTime.DateDiff('N', TODAY, "Posted Material Issues Header"."Issued DateTime", DayofWeekInput, WeekofYearInput) > 3) THEN BEGIN


                                    SMTP_MAIL.Send;


                                    "from Mail" := 'erp@efftronics.com';
                                    "to mail" := 'vsusmitha@efftronics.com';
                                    Mail_Subject := 'Need to return items from the employee';
                                    SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Body, TRUE);
                                    SMTP_MAIL.AppendBody('Dear Sir/Madam,');
                                    SMTP_MAIL.AppendBody('<br>&nbsp  <br>');
                                    SMTP_MAIL.AppendBody('These are the tools to be returned to QC for calibration.');
                                    SMTP_MAIL.AppendBody('<html><head><style> divone{background-color: white; width: 2000px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                                    SMTP_MAIL.AppendBody('<body><label><font size="5"><center>Need To Return Items</center></font></label>');
                                    SMTP_MAIL.AppendBody('<br>&nbsp  <br>');
                                    // SMTP_MAIL.AppendBody('<hr style=solid; color = #3333CC>');
                                    SMTP_MAIL.AppendBody('</center></h3>');
                                    SMTP_MAIL.AppendBody('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                                    SMTP_MAIL.AppendBody('border="1" align="Center">');
                                    SMTP_MAIL.AppendBody('<tr><td>Userid</td><td>Item No</td><td>Description</td><td>Lot no</td><td>Serial no</td><td>TransferFromCode</td><td>TransferToCode</td><td>ProductGroupCode</td></tr>');
                                    // SMTP_MAIL.AppendBody('<tr><td>'+"Mail alert".User_ID+'</td><td>'+"Mail alert".Item_No+'</td><td>'+"Mail alert".Description+'</td><td>'+
                                    //"Mail alert".Lot_No+'</td><td>'+"Mail alert".Serial_No+'</td><td>'+"Mail alert".Transfer_from_Code+' </td><td>'+"Mail alert".Transfer_to_Code+'</td><td>'+"Mail alert".Product_Group_Code+'</td></tr>');
                                    puserid := "Mail alert".User_ID;
                                END ELSE BEGIN
                                    SMTP_MAIL.AppendBody('<tr><td>' + "Mail alert".User_ID + '</td><td>' + "Mail alert".Item_No + '</td><td>' + "Mail alert".Description + '</td><td>' +
                                      "Mail alert".Lot_No + '</td><td>' + "Mail alert".Serial_No + '</td><td>' + "Mail alert".Transfer_from_Code + ' </td><td>' + "Mail alert".Transfer_to_Code + '</td><td>' + "Mail alert".Product_Group_Code + '</td></tr>');
                                    puserid := "Mail alert".User_ID;
                                END;
                            END;


                        END;
                        SMTP_MAIL.Send;
                    END; */  //B2B UPG <<<

                    puserid := '';
                    IF CONFIRM('Do you want to send the mail alert?') THEN BEGIN
                        //"from Mail" := 'erp@efftronics.com';
                        //"to mail" := 'vsusmitha@efftronics.com';
                        Recipient.Add('vsusmitha@efftronics.com');
                        Mail_Subject := 'Need to return items from the employee';
                        EmailMessage.Create(Recipient, Mail_Subject, Body, true);
                        Body += ('Dear Sir/Madam,');
                        Body += ('<br>&nbsp  <br>');
                        Body += ('These are the tools to be returned to QC for calibration.');
                        Body += ('<html><head><style> divone{background-color: white; width: 2000px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                        Body += ('<body><label><font size="5"><center>Need To Return Items</center></font></label>');
                        Body += ('<br>&nbsp  <br>');
                        // SMTP_MAIL.AppendBody('<hr style=solid; color = #3333CC>');
                        Body += ('</center></h3>');
                        Body += ('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                        Body += ('border="1" align="Center">');
                        Body += ('<tr><td>Userid</td><td>Item No</td><td>Description</td><td>Lot no</td><td>Serial no</td><td>TransferFromCode</td><td>TransferToCode</td><td>ProductGroupCode</td></tr>');
                        //"Mail alert".SETFILTER(User_ID,'%1|%2','EFFTRONICS\PVIJAY', 'EFFTRONICS\GRAVI');
                        IF "Mail alert".OPEN THEN BEGIN


                            WHILE "Mail alert".READ DO BEGIN
                                IF (puserid <> '') AND (puserid <> "Mail alert".User_ID) AND (DateAndTime.DateDiff('N', TODAY, "Posted Material Issues Header"."Issued DateTime", DayofWeekInput, WeekofYearInput) > 3) THEN BEGIN


                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


                                    //"from Mail" := 'erp@efftronics.com';
                                    //"to mail" := 'vsusmitha@efftronics.com';
                                    Recipient.Add('vsusmitha@efftronics.com');
                                    Mail_Subject := 'Need to return items from the employee';
                                    EmailMessage.Create(Recipient, Mail_Subject, Body, true);
                                    Body += ('Dear Sir/Madam,');
                                    Body += ('<br>&nbsp  <br>');
                                    Body += ('These are the tools to be returned to QC for calibration.');
                                    Body += ('<html><head><style> divone{background-color: white; width: 2000px; padding: 20px; border-style:solid ; border-color:#8EB52B;  margin: 20px;} </style></head>');
                                    Body += ('<body><label><font size="5"><center>Need To Return Items</center></font></label>');
                                    Body += ('<br>&nbsp  <br>');
                                    // SMTP_MAIL.AppendBody('<hr style=solid; color = #3333CC>');
                                    Body += ('</center></h3>');
                                    Body += ('<table style="WIDTH:400px; HEIGHT: 20px; FONT-WEIGHT: bold"');
                                    Body += ('border="1" align="Center">');
                                    Body += ('<tr><td>Userid</td><td>Item No</td><td>Description</td><td>Lot no</td><td>Serial no</td><td>TransferFromCode</td><td>TransferToCode</td><td>ProductGroupCode</td></tr>');
                                    // SMTP_MAIL.AppendBody('<tr><td>'+"Mail alert".User_ID+'</td><td>'+"Mail alert".Item_No+'</td><td>'+"Mail alert".Description+'</td><td>'+
                                    //"Mail alert".Lot_No+'</td><td>'+"Mail alert".Serial_No+'</td><td>'+"Mail alert".Transfer_from_Code+' </td><td>'+"Mail alert".Transfer_to_Code+'</td><td>'+"Mail alert".Product_Group_Code+'</td></tr>');
                                    puserid := "Mail alert".User_ID;
                                END ELSE BEGIN
                                    Body += ('<tr><td>' + "Mail alert".User_ID + '</td><td>' + "Mail alert".Item_No + '</td><td>' + "Mail alert".Description + '</td><td>' +
                                      "Mail alert".Lot_No + '</td><td>' + "Mail alert".Serial_No + '</td><td>' + "Mail alert".Transfer_from_Code + ' </td><td>' + "Mail alert".Transfer_to_Code + '</td><td>' + "Mail alert".Product_Group_Code + '</td></tr>');
                                    puserid := "Mail alert".User_ID;
                                END;
                            END;


                        END;
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                    END;
                    RESET;
                end;
            }
            action("Production Pending Alert")
            {
                Caption = 'Production Pending Alert';
                ApplicationArea = All;

                trigger OnAction();
                var
                    "Count": Integer;
                    "Present Item": Text;
                    "Present BOM": Text;
                    Req_Qty: Decimal;
                    Days: Integer;
                begin
                end;
            }
        }
    }

    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipient: List of [Text];
        MaterialIssuesHeader: Record "Material Issues Header";
        "Service Item Line": Record "Service Item Line";
        "Material Issues Line": Record "Material Issues Line";
        "Posted Material Issues Header": Record "Posted Material Issues Header";
        "Posted Material Issues Lines": Record "Posted Material Issues Line";
        itemledgerentry: Record "Item Ledger Entry";
        Dmg_Qty: Decimal;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        USER: Record User;
        Body: Text[1000];
        Mail_From: Text[250];
        Mail_To: Text[250];
        Mail: Codeunit Mail;
        Subject: Text[250];
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
        Attachment: Text[1000];
        SMTPSETUP: Record "SMTP SETUP";
        /*  objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
         objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
         flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
         fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        bodies: Integer;
        Mail_Body: array[5] of Text[1000];
        body1: Text[1000];
        PIDS: Record "Posted Inspect DatasheetHeader";
        "Mail-Id": Record "User Setup";
        "from Mail": Text[1000];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        MR: Record "Material Issues Header";
        SQLQuery: Text[1000];
        ConnectionOpen: Integer;
        RowCount: Integer;
        MIL: Record "Material Issues Line";
        MITS: Record "Mat.Issue Track. Specification";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        choice: Boolean;
        PO: Record "Production Order";
        SO: Record "Sales Invoice-Dummy";
        SH: Record "Sales Header";
        ILE_QTY: Decimal;
        MTS: Record "Multimeter Tracking System";

        "Vendor No.Visible": Boolean;
        username: Text;
        // "Mail alert": Query "Mail Alert";
        puserid: Text;
        next: Text;
        DateAndTime: DotNet DateAndTimeD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        DayofWeekInput: DotNet DayofWeekInputD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        WeekofYearInput: DotNet WeekofYearInputD;
    //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";


    local procedure TransferfromCodeOnInputChange(var Text: Text[1024]);
    begin
        TESTFIELD(Status, Status::Open);
    end;


    local procedure TransfertoCodeOnInputChange(var Text: Text[1024]);
    begin
        TESTFIELD(Status, Status::Open);
        IF "Transfer-to Code" = 'DC' THEN
            ERROR('DC process has been changed.If any doubts Contact ERP Team');
    end;


    local procedure ProdOrderNoOnInputChange(var Text: Text[1024]);
    begin
        TESTFIELD(Status, Status::Open);
    end;


    local procedure ProdOrderLineNoOnInputChange(var Text: Text[1024]);
    begin
        TESTFIELD(Status, Status::Open);
    end;

    //event LRecordSet(cFields : Integer;"Fields" : Variant;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(cFields : Integer;"Fields" : Variant;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;cRecords : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;cRecords : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(adReason : Integer;pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(var fMoreData : Boolean;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(Progress : Integer;MaxProgress : Integer;adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;

    //event LRecordSet(pError : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000500-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Error";adStatus : Integer;pRecordset : Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000556-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'._Recordset");
    //begin
    /*
    */
    //end;
}

