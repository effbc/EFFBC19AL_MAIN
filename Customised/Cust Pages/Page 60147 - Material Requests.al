page 60147 "Material Requests"
{
    // version MI1.0,Rev01,SQL

    PageType = Document;
    SourceTable = "Material Issues Header";
    SourceTableView = SORTING("No.") ORDER(Ascending);

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                Enabled = true;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        /*IF  "Transfer-to Code"='CST' THEN
                        CurrPage."Shortcut Dimension 2 Code".ENABLED:=FALSE
                        ELSE
                        CurrPage."Shortcut Dimension 2 Code".ENABLED:=TRUE;
                                                                              */
                        IF Rec."Transfer-to Code" = 'DC' THEN
                            ERROR('DC process has been changed.If any doubts Contact ERP Team');

                        // Added by vishnu Priya on 26-06-2020 for restricting the  stock transfer requests
                        IF (Rec."Transfer-from Code" = 'STR') AND (Rec."Transfer-to Code" = 'MAGSTR') THEN BEGIN
                            IF NOT (USERID IN ['EFFTRONICS\GRAVI', 'EFFTRONICS\TULASI']) THEN
                                ERROR('You can not Raise a Stock Transfer Request!');
                        END;

                    end;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    var
                        PMIH: Record "Posted Material Issues Header";
                        PO: Record "Production Order";
                    begin
                        /*IF ("Transfer-to Code" IN ['RD1','RD2','RD3','RD4','RD5','RD6','RHW'])  OR
                           ("Transfer-From Code" IN ['RD1','RD2','RD3','RD4','RD5','RD6','RHW'])
                        BEGIN
                        */



                        "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", Rec."No.");
                        IF "Material Issues Line".FINDSET THEN
                            REPEAT
                                "Material Issues Line"."Prod. Order No." := Rec."Prod. Order No.";
                                "Material Issues Line".MODIFY(TRUE);
                            UNTIL "Material Issues Line".NEXT = 0;
                        // Added by sundar
                        IF (Rec."Transfer-from Code" = 'STR') AND (Rec."Transfer-to Code" = 'PROD') THEN BEGIN
                            PO.SETFILTER(PO."No.", Rec."Prod. Order No.");
                            IF PO.FINDFIRST THEN
                                Rec."Sales Order No." := PO."Sales Order No.";
                            Rec.MODIFY;
                        END;
                        IF Rec."Prod. Order No." = '' THEN BEGIN
                            Rec."Prod. Order Line No." := 0;
                            Rec."Proj Description" := '';
                            Rec.MODIFY;
                        END;
                        IF (NOT (UPPERCASE(USERID) IN ['EFFTRONICS\SARDHAR', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VIJAYA'])) THEN BEGIN
                            PO.RESET;
                            PO.SETFILTER("No.", Rec."Prod. Order No.");
                            PO.SETFILTER("Sales Order No.", '<> %1', '');
                            IF PO.FINDFIRST THEN BEGIN
                                PMIH.RESET;
                                PMIH.SETFILTER(PMIH."Prod. Order No.", Rec."Prod. Order No.");
                                IF NOT PMIH.FINDFIRST THEN BEGIN
                                    ERROR('Auto Postings not Completed with This RPO');
                                END;

                                //Added by Suvarchala on 20/7/2021 for allowing only return materials on blocked code EFF08GEN01
                                IF (Rec."Prod. Order No." = 'EFF08GEN01') AND (Rec."Reason Code" <> 'RETURN') AND (Rec."Transfer-to Code" = 'STR') THEN
                                    ERROR('Prod. Order No. %1 is available only for RETURN Materials, Please Select Reason Code as RETURN', "Prod. Order No.");

                                //Ended by Suvarchala
                            END;
                        END;
                    END;


                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Proj Description"; Rec."Proj Description")
                {
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = All;
                }
                field("BOM Type"; Rec."BOM Type")
                {
                    OptionCaption = '" ,Mechanical,Wiring,Testing,Packing"';
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        IF Rec."Transfer-from Code" = 'CS STR' THEN BEGIN
                            IF PAGE.RUNMODAL(60219, SO) = ACTION::LookupOK THEN BEGIN
                                Rec."Sales Order No." := SO."No.";
                                Rec.MODIFY;
                            END;
                        END
                        ELSE BEGIN
                            // SH.SETFILTER(SH.Status,'Released'); commented on 24-03-18 in order to have all sale orderss visibility in material reqst
                            IF PAGE.RUNMODAL(45, SH) = ACTION::LookupOK THEN BEGIN
                                Rec."Sales Order No." := SH."No.";
                                Rec.MODIFY;
                            END;
                        END;
                    end;
                }
                field("Type of Solder"; Rec."Type of Solder")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Person Code"; Rec."Person Code")
                {
                    ApplicationArea = All;
                }
                field("Released Date"; Rec."Released Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Authorized Person"; Rec."Request for Authorization")
                {
                    Caption = 'Authorized Person';
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Visible = "Vendor No.Visible";
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Released By"; Rec."Released By")
                {
                    Caption = 'Released by';
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Required Date"; Rec."Required Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Caption = 'Req.User ID';
                    // Editable = UserIdEditable;
                    ApplicationArea = All;
                    LookupPageID = "User Lookup";

                    trigger OnValidate();
                    begin

                        /*User_rec.RESET;
                        User_rec.SETFILTER("User Name",Rec."User ID");
                        IF User_rec.FINDFIRST THEN
                          IF User_rec.Blocked = TRUE THEN
                            Dialog.CONFIRM('You have selected a blocked user. Do u Want to Continue?',TRUE)
                          */

                    end;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    Caption = 'Req. Person';
                    ApplicationArea = All;
                }
                field("Released Time"; Rec."Released Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        "Material Issues Line".RESET;
                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", Rec."No.");
                        "Material Issues Line".SETFILTER("Material Issues Line"."Reason Code", ' ');
                        IF "Material Issues Line".FINDFIRST THEN BEGIN
                            "Material Issues Line".MODIFYALL("Material Issues Line"."Reason Code", Rec."Reason Code");
                        END;
                    end;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    ApplicationArea = All;
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    Editable = false;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                }
                field("Service Item"; Rec."Service Item")
                {
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        //  MESSAGE(FORMAT("Service Order No."));
                        "Service Item Line".RESET;
                        "Service Item Line".SETRANGE("Service Item Line"."Document No.", Rec."Service Order No.");
                        "Service Item Line".SETFILTER("Service Item Line"."Finishing Date", '>=%1|%2', TODAY - 6, 0D);
                        IF "Service Item Line".FINDFIRST THEN BEGIN
                            IF PAGE.RUNMODAL(0, "Service Item Line") = ACTION::LookupOK THEN BEGIN
                                Rec."Service Item" := "Service Item Line"."Service Item No.";
                                Rec."Service Item Serial No." := "Service Item Line"."Serial No.";
                                Rec."Service Item Description" := "Service Item Line".Description;
                                Rec.MODIFY;
                            END;
                        END;
                    end;

                    trigger OnValidate();
                    begin
                        // >>Added by Pranavi on 02-06-2017 for validating service item
                        IF Rec."Service Item" <> '' THEN BEGIN
                            "Service Item Line".RESET;
                            "Service Item Line".SETRANGE("Service Item Line"."Document No.", Rec."Service Order No.");
                            "Service Item Line".SETRANGE("Service Item No.", Rec."Service Item");
                            IF NOT "Service Item Line".FINDFIRST THEN
                                ERROR('Service Item does not exist in Service Order : %1', Rec."Service Order No.");
                        END ELSE BEGIN
                            Rec."Service Item Serial No." := '';
                            Rec."Service Item Description" := '';
                        END;
                        // <<Added by Pranavi on 02-06-2017 for validating service item
                    end;
                }
                field("Service Item Description"; Rec."Service Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Item Serial No."; Rec."Service Item Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Multiple; Rec.Multiple)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    Caption = 'Priority';
                    ApplicationArea = All;
                }
                field("Transaction ID"; Rec."Transaction ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = true;
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

            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("A&uthorize")
                {
                    Caption = 'A&uthorize';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
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
                        // added by vishnu Priya on 23-06-2020
                        IF (Rec."Transfer-from Code" = 'STR') AND (Rec."Transfer-to Code" = 'MAGSTR') THEN BEGIN
                            IF NOT (USERID IN ['EFFTRONICS\VISHHUPRIYA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\TULASI']) THEN
                                ERROR('You can not raise a stock transfer request from Store to Mangalagiri Store!');
                        END;
                        // end by vishnu Priya on 23-06-2020

                        IF NOT ((USERID = 'EFFTRONICS\CHOWDARY')) THEN BEGIN
                            IF WORKDATE < DT2DATE("Creation DateTime") THEN
                                ERROR('Release Date Must be Greater than Or Equal to Work Date');
                        END;
                        IF Rec."Transfer-to Code" = 'SITE' THEN
                            checking_LocationsCode;

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
                        IF ("Transfer-from Code" = 'SITE') OR ("Transfer-to Code" = 'SITE') THEN
                            IF ("Shortcut Dimension 2 Code" = 'LED-GEN') AND (STRLEN("Customer No") <= 2) THEN
                                ERROR('Please enter Customer No.!');

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

                                        IF NOT (("Material Issues Line"."Reason Code" = 'PROD DOWN')
                                               OR ("Material Issues Line"."Reason Code" = 'N/W DOWN')
                                               OR ("Material Issues Line"."Reason Code" = 'INSTALLA')
                                               OR ("Material Issues Line"."Reason Code" = 'MONITERS')
                                               OR ("Material Issues Line"."Reason Code" = 'SPARE')
                                               OR ("Material Issues Line"."Reason Code" = 'REPLACE')
                                               OR ("Material Issues Line"."Reason Code" = 'TCA')
                                               OR ("Material Issues Line"."Reason Code" = 'ANG DOWN')
                                               OR ("Material Issues Line"."Reason Code" = 'INSTA DOWN')
                                               OR ("Material Issues Line"."Reason Code" = 'N/W ENHANC')
                                               OR ("Material Issues Line"."Reason Code" = 'CAL')) THEN
                                            ERROR('ENTER A VALID REASON CODE');



                                        IF (("Material Issues Line"."Item No." = 'BOIMODE00014') OR ("Material Issues Line"."Item No." = 'BOIMODE00006') OR
                                           ("Material Issues Line"."Item No." = 'BOIMODE00001')) AND ("Material Issues Line".Remarks = '') THEN
                                            ERROR('Please Enter the Remarks for Modems');




                                        //Customer cards transactions.   added by MNRaju on 10Sep14
                                        "Material Issues Line".RESET;              //added by Pranavi on 09-07-2015 for repeating all items in request
                                        "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                                        IF "Material Issues Line".FINDSET THEN
                                            REPEAT
                                                TrackingSpecification.RESET;
                                                TrackingSpecification.SETFILTER(TrackingSpecification."Order No.", "No.");
                                                TrackingSpecification.SETFILTER(TrackingSpecification."Order Line No.", '%1', "Material Issues Line"."Line No.");
                                                TrackingSpecification.SETFILTER(TrackingSpecification."Item No.", "Material Issues Line"."Item No.");
                                                IF TrackingSpecification.FINDFIRST THEN BEGIN
                                                    itemledgerentry.RESET;
                                                    itemledgerentry.SETFILTER(itemledgerentry."Item No.", "Material Issues Line"."Item No.");
                                                    itemledgerentry.SETFILTER(itemledgerentry."Entry Type", '%1', itemledgerentry."Entry Type"::Transfer);
                                                    itemledgerentry.SETFILTER(itemledgerentry."Serial No.", TrackingSpecification."Serial No.");
                                                    itemledgerentry.SETFILTER(itemledgerentry."Lot No.", TrackingSpecification."Lot No.");
                                                    //        itemledgerentry.SETFILTER(itemledgerentry."Location Code",'CS');
                                                    IF itemledgerentry.FINDLAST THEN BEGIN
                                                        IF itemledgerentry."Location Code" = 'CS' THEN BEGIN
                                                            "Posted Material Issues Lines".RESET;
                                                            "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Document No.", itemledgerentry."Document No.");
                                                            "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Item No.", "Material Issues Line"."Item No.");
                                                            "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Non-Returnable", '%1', TRUE);
                                                            IF "Posted Material Issues Lines".FINDFIRST THEN BEGIN
                                                                "Posted Material Issues Header".GET("Posted Material Issues Lines"."Document No.");
                                                                IF "Posted Material Issues Header"."Shortcut Dimension 2 Code" = "Shortcut Dimension 2 Code" THEN BEGIN
                                                                    "Material Issues Line"."Non-Returnable" := TRUE;
                                                                    "Material Issues Line".MODIFY;
                                                                    "Transaction ID" := "Posted Material Issues Header"."Transaction ID";    //added by pranavi on 06-07-2015
                                                                    IF "Customer No" = '' THEN
                                                                        "Customer No" := "Posted Material Issues Header"."Customer No";     // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                                                    MODIFY;
                                                                END;
                                                                /* ELSE
                                                                 BEGIN
                                                                   ERROR('Dont send customer cards to another locations. '+"Posted Material Issues Lines"."Item No."+' received from '+"Posted Material Issues Header"."Shortcut Dimension 2 Code");
                                                                 END; */  //Commented By Pranavi
                                                            END;
                                                        END;
                                                        IF "Posted Material Issues Header".GET(itemledgerentry."Document No.") THEN // Added by Pranavi on 27-Jan-2016
                                                        BEGIN
                                                            "Transaction ID" := "Posted Material Issues Header"."Transaction ID";
                                                            IF "Customer No" = '' THEN
                                                                "Customer No" := "Posted Material Issues Header"."Customer No";     // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                                            MODIFY;
                                                        END;
                                                    END;
                                                END;
                                            UNTIL "Material Issues Line".NEXT = 0;
                                        //Customer cards transactions.   added by MNRaju on 10Sep14




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
                        StationaryMaterialTesting();
                        CODEUNIT.RUN(60010, Rec);
                        //END;
                        IF "Prod. Order No." = 'EFF14STA01' THEN BEGIN
                            Rec."Posting Date" := TODAY;
                            Rec.MODIFY;
                            AssingBatchManual.AssignBatchManual(Rec);
                            Mat_Issue_sLine.RESET;
                            Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                            Mat_Issue_sLine.SETRANGE("Qty. to Receive", 0);
                            IF Mat_Issue_sLine.FINDFIRST THEN BEGIN
                                MESSAGE('There is no Sufficient Material at Stores. Request Postings done by Stores Dept');
                            END ELSE BEGIN
                                CODEUNIT.RUN(60011, Rec);
                            END;
                            Mat_Issue_sLine.RESET;
                            Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                            IF Mat_Issue_sLine.FINDSET THEN
                                REPEAT
                                    Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                    Mat_Issue_sLine.MODIFY;
                                UNTIL Mat_Issue_sLine.NEXT = 0;
                        END;

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
                    Image = CopyFixedAssets;
                    Promoted = true;
                    PromotedCategory = Process;
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
                    Promoted = true;
                    PromotedCategory = Process;
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
                separator(Action1000000126)
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        AssingBatchManual.AssignBatchManual(Rec);
                    end;
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
                separator(Action1000000022)
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
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Body := '';

                        // ADDED BY VISHNU PRIYA ON 27-12-2019 TO RESTRICT THE DIFFERENT SITE LOCATIONS IN NATERIAL LINES AND HEADERS

                        MATlINE.RESET;
                        MATlINE.SETRANGE("Document No.", Rec."No.");
                        IF Rec."Transfer-to Code" = 'SITE' THEN BEGIN
                            MATlINE.SETFILTER("Shortcut Dimension 2 Code", '<>%1', Rec."Shortcut Dimension 2 Code");
                            IF MATlINE.FINDSET THEN
                                ERROR('Please enter the Same Site Location in Header and Lines.');
                        END;
                        //END BY ViSHNU PRIYA ON 27-12-2019

                        /*
                          IF (((("Transfer-to Code"='RD1') OR ("Transfer-to Code"='RD2') OR("Transfer-to Code"='RD3') OR("Transfer-to Code"='RD4') OR
                          ("Transfer-to Code"='RD5') OR("Transfer-to Code"='RD6') OR("Transfer-to Code"='RHW'))AND(("Transfer-from Code"='R&D STR')))
                          OR(("Transfer-to Code"='R&D STR') AND (
                          ("Transfer-from Code"='RD1') OR ("Transfer-from Code"='RD2') OR("Transfer-from Code"='RD3') OR("Transfer-from Code"='RD4') OR
                          ("Transfer-from Code"='RD5') OR("Transfer-from Code"='RD6')OR("Transfer-from Code"='RHW')OR("Transfer-from Code"='R&D')))
                          OR(("Transfer-to Code"='DAMAGE') AND (
                          ("Transfer-from Code"='RD1') OR ("Transfer-from Code"='RD2') OR("Transfer-from Code"='RD3') OR("Transfer-from Code"='RD4') OR
                          ("Transfer-from Code"='RD5') OR("Transfer-from Code"='RD6')OR("Transfer-from Code"='RHW')))) OR ("Transfer-to Code"='DC')  THEN
                          BEGIN
                        */
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

                        "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID); //Rev01



                        ERROR('You do not Have Mail id in ERP & Please inform the ERP Administrator to Create your Mail id!');

                        //Mail_From:='anilkumar@efftronics.com';
                        "Mail-Id".RESET;
                        "Mail-Id".SETRANGE("Mail-Id"."User ID", "Request for Authorization");
                        IF "Mail-Id".FINDFIRST THEN BEGIN
                            IF "Mail-Id".levels = TRUE THEN BEGIN
                                IF "Mail-Id".MailID <> '' THEN begin
                                    //Mail_To := "Mail-Id".MailID //B2B UPG
                                    Recipients.Add("Mail-Id".MailID);
                                end
                                ELSE
                                    ERROR('Authorized person do not have Mail id In ERP & Please inform the ERP Administrtor to create mail id!');
                            END
                            ELSE
                                ERROR('You are Specified UnAuthorized person & If any Modification Please Contact ERP Administrtor!');
                        END;

                        IF ("Transfer-to Code" = 'DC') THEN BEGIN
                            IF Remarks = '' THEN
                                ERROR('Please specify the DC purpose in Remarks Column');
                            IF ("Shortcut Dimension 2 Code" = '') AND ("Vendor No." = '') THEN
                                ERROR('Please specify the Location code');
                            IF FORMAT("Mode of Transport") = '' THEN
                                ERROR('Please enter the Mode of Transport');

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
                        END
                        ELSE
                            IF "Transfer-to Code" = 'STR' THEN
                                Subject := 'ERP- Return item Request for Authorisation ' + FORMAT("No.")
                            ELSE
                                IF "Transfer-to Code" = 'DAMAGE' THEN
                                    Subject := 'ERP- Damaged item Request for Authorisation ' + FORMAT("No.")
                                ELSE
                                    IF "Transfer-to Code" = 'DC' THEN
                                        Subject := 'ERP- DC items Request for Authorisation ' + FORMAT("No.")
                                    ELSE
                                        Subject := 'ERP- Material Request for Authorisation ' + FORMAT("No.");
                        //Mail_From:='sreenu@efftronics.com';
                        //Mail_To:='sreenu@efftronics.com';
                        //Item Cost Initialized to 0  by Vishnu Priya on 15-11-2018
                        ITEM_COST := 0;
                        MIL.RESET;
                        MIL.SETRANGE("Document No.", "No.");
                        MIL.SETFILTER(Quantity, '>%1', 0);
                        IF MIL.FINDSET THEN BEGIN
                            REPEAT
                            BEGIN
                                Itm.RESET;
                                Itm.SETRANGE("No.", MIL."Item No.");
                                IF Itm.FINDSET THEN
                                    ITEM_COST := ITEM_COST + (MIL.Quantity * Itm."Last Direct Cost");
                            END;
                            // MESSAGE('ITM:'+Itm."No." +'---'+FORMAT(ITEM_COST));
                            UNTIL MIL.NEXT = 0;
                        END;

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
                        Body += '<tr><td>Total Items Cost</td><td> Rs. ' + FORMAT(ROUND(ITEM_COST)) + '</td></tr>';
                        //Body+='<tr><td>Sal.Person</td><td>'++'</td></tr>';
                        //Body+='<tr><td>Req.Comments</td><td>'+''+'</td></tr>';
                        Body += '<tr><td bgcolor="green">'; //#009900
                                                            //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                                                            //Body+='<a Href="http://efffax/erpmatauth/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");
                                                            //Body+='<a Href="http://Intranet:8080/ERP%20MAT-AUH/webform1.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT("User ID");

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", USERID);
                        IF UserSetup.FINDFIRST THEN BEGIN
                            CurrentUserID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        //IF "User ID" <> 'EFFTRONICS\RAKESHT'  THEN       // Added by Rakesh for mail authorization on 01-04-14
                        // Body+='<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT(CurrentUserID);
                        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT("No.") + '&val2=' + FORMAT(CurrentUserID); // above line commented and added by pranavi on 11-feb-2016
                                                                                                                                                                 //ELSE
                                                                                                                                                                 //Body+='<a Href="http://eff-cpu-315/TestService/ERP_MatAuth.aspx?val1='+FORMAT("No.")+'&val2='+FORMAT(CurrentUserID); //Added by Rakesh for mail authorization on 01-04-14
                                                                                                                                                                 //Body+='&val2=';
                                                                                                                                                                 //Body+='<a Href="http://intranet:8080/erp_mat_auh/Mat_Auth.aspx?val1='+FORMAT("No.");
                                                                                                                                                                 //Body+='<a Href="http://eff-cpu-315:5556/erp_reports/Mat_Auth.aspx?val1='+FORMAT("No.");
                                                                                                                                                                 //Body+='&val2='+FORMAT("User ID");

                        //mnraju
                        UserSetup.RESET;
                        UserSetup.SETRANGE("User ID", "Request for Authorization");
                        IF UserSetup.FINDFIRST THEN BEGIN
                            AuthorizedID := UserSetup."Current UserId";
                        END;
                        //mnraju

                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=1';
                        Body += '&val5=' + Mail_To;
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Accepted"target="_blank">';
                        //Calibri,#ffffff white
                        Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                        Body += '</td><td bgcolor="red">';
                        //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.");
                        //Body+='<a Href="http://intranet:8080/erp_mat_auh/Mat_Auth.aspx?val1='+FORMAT("No.");

                        //IF USERID <> 'EFFTRONICS\RAKESHT'  THEN       // Added by Rakesh for mail authorization on 01-04-14
                        // Body+='<a Href="http://192.168.0.155:5556/erp_reports/ERP_MatAuth.aspx?val1='+FORMAT("No.");
                        Body += '<a Href="http://app.efftronics.org:8567/erp_reports/ERP_MatAuth.aspx?val1=' + FORMAT("No.");  // above line commented and added by pranavi on 11-feb-2016
                                                                                                                               //ELSE
                                                                                                                               //Body+='<a Href="http://eff-cpu-315/TestService/ERP_MatAuth.aspx?val1='+FORMAT("No.");  // Added by Rakesh for mail authorization on 01-04-14

                        Body += '&val2=' + FORMAT(CurrentUserID);
                        Body += '&val3=' + FORMAT(AuthorizedID);
                        Body += '&val4=0';
                        Body += '&val5=' + Mail_To;
                        Body += '&val6=' + "from Mail";
                        Body += '&val7=Rejected';
                        Body += '"target="_blank">';
                        Body += '<font face="arial" color="#ffffff">REJECT</font></a></td></tr>';
                        Body += '</table></form></font></strong></body>';
                        MR.SETRANGE(MR."No.", "No.");
                        IF MR.FINDFIRST THEN
                            REPORT.RUN(33000890, FALSE, FALSE, MR);
                        //REPORT.SAVEASHTML(50182,'\\Eff-cpu-211\srinivas\Mat-req-report.htm',FALSE,MR);
                        //REPORT.SAVEASHTML(50182,'\\eff-cpu-211\ERP\Mat-req-report.htm',FALSE,MR);
                        //REPORT.SAVEASHTML(50182,'\\erpserver\ERPAttachments\Mat-req-report.htm',FALSE,MR);
                        //REPORT.SAVEASHTML(50182,'\\erpserver\ErpAttachments\ErpAttachments1\Mat-req-report2.htm',FALSE,MR);  // changed by mohan
                        REPORT.SAVEASPDF(33000890, '\\erpserver\ErpAttachments\ErpAttachments1\' + "No." + '.pdf', MR);
                        //Attachment:='\\eff-cpu-211\srinivas\Mat-req-report.htm';
                        //Attachment:='\\eff-cpu-211\ERP\Mat-req-report.htm';
                        //Attachment:='\\erpserver\ErpAttachments\ErpAttachments1\Mat-req-report2.htm';
                        Attachment := '\\erpserver\ErpAttachments\ErpAttachments1\' + "No." + '.pdf';

                        //B2B UPG >>>
                        /* SMTP_MAIL.CreateMessage("Mail-Id"."User Name", 'erp@efftronics.com', Mail_To, Subject, Body, TRUE);
                        SMTP_MAIL.AddBCC('erp@efftronics.com');
                        SMTP_MAIL.AddAttachment(Attachment, '');//EFFUPG Added('')
                        SMTP_MAIL.Send; */  //B2B UPG <<<

                        Recipients.Add('erp@efftronics.com');
                        EmailMessage.Create(Recipients, Subject, Body, true);
                        EmailMessage.AddAttachment(Attachment, '', '');
                        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                        //NewCDOMessage("from Mail",Mail_To,Subject,Body,Attachment);
                        // CODE COMMENTED FOR NAVISION  UPGRADATION

                        // Added by Rakesh for setting status for Material status on 4-Mar-14
                        //IF "User ID" = 'EFFTRONICS\RAKESHT' THEN
                        Status := Status::"Sent for Authorization";
                        MODIFY;
                        //end by rakesh

                        MESSAGE('Mail Has been Sent');
                        //ITEM_COST:=0;
                        /*
                          END ELSE
                          ERROR('This Request is only for R&D Stores Only');
                        */

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
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                            /* IF "Mail-Id".FINDFIRST THEN
                                 "from Mail" := "Mail-Id".MailID*/

                            ERROR('You do not Have Mail id in ERP & Please Tell the ERP Administrator to Create your Mail id');
                            //Mail_From:='anilkumar@efftronics.com';
                            "Mail-Id".RESET;
                            "Mail-Id".SETRANGE("Mail-Id"."User ID", "Request for Authorization");
                            IF "Mail-Id".FINDFIRST THEN BEGIN
                                IF "Mail-Id".levels = TRUE THEN begin
                                    //Mail_To := "Mail-Id".MailID //B2B UPG
                                    Recipients.Add("Mail-Id".MailID);
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

                            //mnraju
                            UserSetup.RESET;
                            UserSetup.SETRANGE("User ID", USERID);
                            IF UserSetup.FINDFIRST THEN BEGIN
                                CurrentUserID := UserSetup."Current UserId";
                            END;
                            //mnraju


                            Body += '<a Href="http://efffax/erpmatauth/webform1.aspx?val1=' + FORMAT("No.") + '&val2=' + FORMAT(CurrentUserID);
                            //Body+='&val2=';

                            //mnraju
                            UserSetup.RESET;
                            UserSetup.SETRANGE("User ID", "Request for Authorization");
                            IF UserSetup.FINDFIRST THEN BEGIN
                                AuthorizedID := UserSetup."Current UserId";
                            END;
                            //mnraju


                            Body += '&val3=' + FORMAT(AuthorizedID);
                            Body += '&val4=1';
                            Body += '&val5=' + Mail_To;
                            Body += '&val6=' + "from Mail";
                            Body += '&val7=Accepted"target="_blank">';
                            //Calibri,#ffffff white
                            Body += '<font face="arial" color="#ffffff">ACCEPT</font></a>';
                            Body += '</td><td bgcolor="red">';
                            //Body+='<a Href="http://eff-cpu-178/materialauthorize/webform1.aspx?val1='+FORMAT("No.");
                            Body += '<a Href="http://efffax/erpmatauth/webform1.aspx?val1=' + FORMAT("No.");
                            Body += '&val2=' + FORMAT(CurrentUserID);
                            Body += '&val3=' + FORMAT(AuthorizedID);
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
                action("Total Indent")
                {
                    Caption = 'Total Indent';
                    Image = Totals;
                    Promoted = true;
                    PromotedCategory = Process;
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
                        /*NoSeriesMgt.InitSeries('P-IND1112','P-IND1112',TODAY,
                                                                      Indent_No,"Indent Header"."No. Series");*/
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
                        "Indent Header"."Sale Order No." := "Sales Order No.";

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
                            "Indent Line".Remarks := "Material Issues Line".Remarks; //added by Vishnu Priya
                            "Indent Line".INSERT;
                            "Material Issues Line"."Make Indent" := TRUE;
                            "Material Issues Line"."Indent No" := Indent_No;
                            "Material Issues Line".MODIFY;  // uncommented by Vishnu Priya on 09-08-2019
                        UNTIL "Material Issues Line".NEXT = 0;
                        "No. Series Line".RESET;
                        //"No. Series Line".SETRANGE("No. Series Line"."Series Code",'P-INDENT');
                        "No. Series Line".SETRANGE("No. Series Line"."Series Code", 'P-IND1112');
                        "No. Series Line".SETRANGE("No. Series Line".Open, TRUE);
                        IF "No. Series Line".FINDFIRST THEN BEGIN
                            "No. Series Line"."Last No. Used" := Indent_No;
                            "No. Series Line"."Last Date Used" := TODAY;
                            "No. Series Line".MODIFY;
                        END;
                        Rec.Remarks := 'Indent Number: ' + Indent_No; //added by Vishnu Priya on 09-08-2019 for the Indent Number auto filled in Material Request Remarks.

                        MESSAGE('INDENT CREATION COMPLETED ' + Indent_No);
                        "Indent Header".RESET;

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
                    var
                        TempMIL: Record "Material Issues Line";
                        PostingBoolean: Boolean;
                        RequistionNo: Text[50];
                    begin
                        /* FileDirectory := '\\erpserver\ErpAttachments\Store Prints\';
                         filname:="No."+ '.pdf';
                         RequistionNo := "No.";
                         Rec.SETRANGE("No.","No.");
                         REPORT.RUN(50010,FALSE,FALSE,Rec);
                         REPORT.SAVEASPDF(50010,FileDirectory+filname,Rec);
                        
                         USER.RESET;
                              USER.SETRANGE(USER."User Name",USERID);
                              IF USER.FINDFIRST THEN
                                username:= USER."Full Name";
                        
                        */

                        // added by vishnu Priya on 23-06-2020
                        IF (Rec."Transfer-from Code" = 'STR') AND (Rec."Transfer-to Code" = 'MAGSTR') THEN BEGIN
                            IF NOT (USERID IN ['EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\TULASI']) THEN
                                ERROR('You can not raise a stock transfer request from Store to Mangalagiri Store!');
                        END;
                        // end by vishnu Priya on 23-06-2020

                        // Added by Vishnu Priya on 03-02-2020
                        IF (("Transfer-to Code" = 'STR') AND ("Transfer-from Code" <> 'MCH')) THEN
                            IF NOT SMTP_MAIL.Permission_Checking(USERID, 'STR-REURN-MAT-POST') THEN
                                ERROR('You do not have rights to post the return requests');
                        // Added by Vishnu Priya on 03-02-2020

                        //commented by Vishnu priya on 03-02-2020

                        //Added by Suvarchala on 25-06-2021 for Damage posting rights to QC only
                        IF (Rec."Transfer-to Code" = 'DAMAGE') THEN
                            IF NOT SMTP_MAIL.Permission_Checking(USERID, 'QC-RETURNS') THEN
                                ERROR('You do not have rights for posting damage materials');



                        //Ended by Suvarchala on 25-06-2021
                        /*
                        IF (("Transfer-to Code" ='STR') AND ("Transfer-from Code" <>'MCH')) THEN
                          BEGIN
                          IF NOT(USERID IN ['EFFTRONICS\VIJAYALAKSHMIB','EFFTRONICS\TULASI','EFFTRONICS\VISHNUPRIYA']) THEN
                            ERROR('You do not have rights to post the return requests');
                          END;
                        
                        */
                        //commented by Vishnu priya on 03-02-2020

                        //Added by Suvarchala on 25-06-2021 for Damage posting rights to QC only
                        IF (Rec."Transfer-to Code" = 'DAMAGE') THEN
                            IF NOT SMTP_MAIL.Permission_Checking(USERID, 'QC-RETURNS') THEN
                                ERROR('You do not have rights for posting damage materials');

                        IF ("Transfer-to Code" = 'SITE') AND ("Shortcut Dimension 2 Code" = '') THEN
                            ERROR('Enter Locations Code');
                        IF ("Transfer-from Code" = 'SITE') OR ("Transfer-to Code" = 'SITE') THEN
                            IF ("Shortcut Dimension 2 Code" = 'LED-GEN') AND (STRLEN("Customer No") <= 2) THEN
                                ERROR('Please enter Customer No.!');

                        IF ("Transfer-to Code" = 'SITE') THEN BEGIN
                            MIL.RESET;
                            MIL.SETFILTER(MIL."Document No.", "No.");
                            IF MIL.FINDSET THEN                         //added by pranavi
                                REPEAT
                                    IF MIL."Shortcut Dimension 2 Code" = '' THEN
                                        ERROR('Enter Locations Code in Lines of Item: ' + MIL."Item No.");
                                UNTIL MIL.NEXT = 0;
                        END;

                        //>>Added by Pranavi on 20-05-2017 for MSL Process
                        IF "Transfer-from Code" IN ['CS STR', 'R&D STR', 'PRODSTR', 'STR', 'MCH'] THEN BEGIN
                            MIL.RESET;
                            MIL.SETFILTER(MIL."Document No.", "No.");
                            MIL.SETFILTER(MIL."Item No.", '<>%1', '');
                            MIL.SETFILTER(MIL.Quantity, '>%1', 0);
                            MIL.SETFILTER(MIL."Qty. to Receive", '>%1', 0);
                            IF MIL.FINDSET THEN                         //added by pranavi
                                REPEAT
                                    IF Itm.GET(MIL."Item No.") THEN BEGIN
                                        IF (Itm.MSL <> 0) AND (Itm."Floor Life at 25 C 40% RH" IN ['', ' ']) THEN BEGIN
                                            TEMC_MSLMail(Itm."No.");
                                            ERROR('Floor Life not defined for the MSL Component! Please contact TEMC!');
                                        END;
                                        IF (Itm.MSL <> 0) AND NOT (Itm."Floor Life at 25 C 40% RH" IN ['INFINITE']) THEN BEGIN
                                            IF MIL."MBB Packet Open DateTime" = 0DT THEN
                                                ERROR('Please Enter MBB Open DateTime in Line No.: %1 !', MIL."Line No.");
                                            IF MIL."MBB Packet Close DateTime" = 0DT THEN
                                                ERROR('Please Enter MBB Closed DateTime in Line No.: %1 !', MIL."Line No.");
                                        END;
                                    END;
                                UNTIL MIL.NEXT = 0;
                        END;
                        //<<Added by Pranavi on 20-05-2017 for MSL Process

                        IF ("Transfer-from Code" = 'CS') AND ("Transfer-to Code" = 'SITE') THEN BEGIN
                            IF ("Shortcut Dimension 2 Code" = 'LED-GEN') AND ("Customer No" = '') THEN
                                ERROR('Please enter Customer No.!');
                            "Material Issues Line".RESET;              //added by Pranavi on 09-07-2015 for repeating all items in request
                            "Material Issues Line".SETFILTER("Material Issues Line"."Document No.", "No.");
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    //Customer cards transactions.   added by MNRaju on 10Sep14
                                    TrackingSpecification.RESET;
                                    TrackingSpecification.SETFILTER(TrackingSpecification."Order No.", "No.");
                                    TrackingSpecification.SETFILTER(TrackingSpecification."Order Line No.", '%1', "Material Issues Line"."Line No.");
                                    TrackingSpecification.SETFILTER(TrackingSpecification."Item No.", "Material Issues Line"."Item No.");
                                    IF TrackingSpecification.FINDFIRST THEN BEGIN
                                        itemledgerentry.RESET;
                                        itemledgerentry.SETFILTER(itemledgerentry."Item No.", "Material Issues Line"."Item No.");
                                        itemledgerentry.SETFILTER(itemledgerentry."Entry Type", '%1', itemledgerentry."Entry Type"::Transfer);
                                        itemledgerentry.SETFILTER(itemledgerentry."Serial No.", TrackingSpecification."Serial No.");
                                        itemledgerentry.SETFILTER(itemledgerentry."Lot No.", TrackingSpecification."Lot No.");
                                        //        itemledgerentry.SETFILTER(itemledgerentry."Location Code",'CS');
                                        IF itemledgerentry.FINDLAST THEN BEGIN
                                            IF itemledgerentry."Location Code" = 'CS' THEN BEGIN
                                                "Posted Material Issues Lines".RESET;
                                                "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Document No.", itemledgerentry."Document No.");
                                                "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Item No.", "Material Issues Line"."Item No.");
                                                "Posted Material Issues Lines".SETFILTER("Posted Material Issues Lines"."Non-Returnable", '%1', TRUE);
                                                IF "Posted Material Issues Lines".FINDFIRST THEN BEGIN
                                                    "Posted Material Issues Header".GET("Posted Material Issues Lines"."Document No.");
                                                    IF "Posted Material Issues Header"."Shortcut Dimension 2 Code" = "Shortcut Dimension 2 Code" THEN BEGIN
                                                        "Material Issues Line"."Non-Returnable" := TRUE;
                                                        "Material Issues Line".MODIFY;
                                                        "Transaction ID" := "Posted Material Issues Header"."Transaction ID";    //added by pranavi on 06-07-2015
                                                        IF "Customer No" = '' THEN
                                                            "Customer No" := "Posted Material Issues Header"."Customer No";     // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                                        MODIFY;
                                                    END;
                                                    /* ELSE
                                                     BEGIN
                                                       ERROR('Dont send customer cards to another locations. '+"Posted Material Issues Lines"."Item No."+' received from '+"Posted Material Issues Header"."Shortcut Dimension 2 Code");
                                                     END; */  //Commented By pranavi on 10-08-2015
                                                END;
                                                IF "Posted Material Issues Header".GET(itemledgerentry."Document No.") THEN // Added by Pranavi on 27-Jan-2016
                                                BEGIN
                                                    "Transaction ID" := "Posted Material Issues Header"."Transaction ID";
                                                    IF "Customer No" = '' THEN
                                                        "Customer No" := "Posted Material Issues Header"."Customer No";     // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                                    MODIFY;
                                                END;
                                            END;
                                        END;
                                    END
                                    ELSE
                                        ERROR('Please Give Serial No. Tracking for: ' + "Material Issues Line"."Item No.");
                                UNTIL "Material Issues Line".NEXT = 0;

                            //Customer cards transactions.   added by MNRaju on 10Sep14


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
                        IF (("Transfer-from Code" = 'SITE') AND ("Transfer-to Code" = 'CS')) OR ("Transfer-to Code" = 'SERVICE') THEN BEGIN
                            SMSetup.GET;
                            "Material Issues Line".RESET;
                            "Material Issues Line".SETRANGE("Material Issues Line"."Document No.", "No.");
                            "Material Issues Line".SETFILTER("Material Issues Line"."Qty. to Receive", '>%1', 0);
                            IF "Material Issues Line".FINDSET THEN
                                REPEAT
                                    IF "Material Issues Line"."Shortcut Dimension 2 Code" <> 'SERVICE' THEN
                                        ERROR('Please enter Location code in lines');
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
                                            // Added by Pranavi on 27-Jan-2016 for CS LED Cards Transfer Process
                                            IF "Customer No" <> '' THEN BEGIN
                                                "Service Header"."Customer No." := "Customer No";
                                                "Service Header"."Bill-to Customer No." := "Customer No";
                                                "Service Header".VALIDATE("Service Header"."Customer No.", "Customer No");
                                            END   // end by Pranavi on 27-Jan-2016 for CS LED Cards Transfer Process
                                            ELSE BEGIN
                                                "Service Header"."Customer No." := 'CS INT';
                                                "Service Header"."Bill-to Customer No." := 'CS INT';
                                                "Service Header".VALIDATE("Service Header"."Customer No.", 'CS INT');
                                            END;
                                            "Service Header"."Order Time" := TIME;
                                            "Service Header"."Order Date" := WORKDATE;
                                            "Service Header"."Service Order Type" := 'CUS';
                                            "Service Header".VALIDATE("Service Header"."Shipping No. Series", 'PSH');
                                            "Service Header"."Posting No. Series" := SMSetup."Posted Service Invoice Nos.";

                                            IF "Material Issues Line"."Non-Returnable" = TRUE THEN BEGIN
                                                "Service Header"."Customer Cards" := TRUE;
                                            END;

                                            "Service Header".VALIDATE("Service Header"."Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");  // Added by Pranavi on 25-Apr-2017 for Tracking division & station

                                            "Dimension Value".RESET;
                                            "Dimension Value".SETRANGE("Dimension Value"."Dimension Code", 'LOCATIONS');
                                            "Dimension Value".SETRANGE("Dimension Value".Code, "Shortcut Dimension 2 Code");
                                            IF "Dimension Value".FINDFIRST THEN
                                                "Service Header".Description := "Dimension Value".Name;

                                            "Service Header"."Material Issue no." := "No.";
                                            "Service Header"."Transation ID" := "Transaction ID";   //added by pranavi for transation id tracking on 18-06-2015
                                            "Service Header".INSERT;
                                            Order_Line_No := 0;
                                        END ELSE BEGIN
                                            Service_Order_No_ := "Service Header"."No.";
                                            // >>Added by Pranavi on 05-06-2017
                                            "Service Item Line".RESET;
                                            "Service Item Line".SETRANGE("Service Item Line"."Document No.", Service_Order_No_);
                                            IF "Service Item Line".FINDLAST THEN
                                                Order_Line_No := "Service Item Line"."Line No.";
                                            // <<Added by Pranavi on 05-06-2017
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
                                                        "Service Item Line".Station := "Material Issues Line".Station;  // Added by Pranavi on 25-Apr-2017 for tracking station
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
                                                        "Service Item Line".Station := "Material Issues Line".Station;  // Added by Pranavi on 25-Apr-2017 for tracking station
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

                        // Code for posting data into Multimeter Tracking System.
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
                                            //Code added by Bharati K on 22Dec2014
                                            IF "Transfer-to Code" = 'CS STR' THEN
                                                MTS."Responsible Person" := 'CS STR'
                                            ELSE
                                                IF "Transfer-to Code" = 'STR' THEN
                                                    MTS."Responsible Person" := 'STR'
                                                ELSE
                                                    IF "Transfer-to Code" = 'QC' THEN
                                                        MTS."Responsible Person" := 'QC'
                                                    ELSE
                                                        IF "Transfer-to Code" = 'CS' THEN
                                                            MTS."Responsible Person" := 'CS'
                                                        ELSE
                                                            MTS."Responsible Person" := "User ID";

                                            IF "Transfer-from Code" IN ['QAS', 'QC'] THEN
                                                MTS."Next Calibration Date" := "Posting Date" + 180;
                                            //Code end
                                            MTS.INSERT;
                                        END
                                        ELSE BEGIN
                                            MTS."Global Dimension 1 Code" := "Transfer-to Code";
                                            MTS."Global Dimension 2 Code" := "Shortcut Dimension 2 Code";
                                            IF "Transfer-to Code" = 'CS STR' THEN
                                                MTS."Responsible Person" := 'CS STR'
                                            ELSE
                                                IF "Transfer-to Code" = 'STR' THEN
                                                    MTS."Responsible Person" := 'STR'
                                                ELSE
                                                    IF "Transfer-to Code" = 'QC' THEN
                                                        MTS."Responsible Person" := 'QC'
                                                    ELSE
                                                        IF "Transfer-to Code" = 'CS' THEN
                                                            MTS."Responsible Person" := 'CS'
                                                        ELSE
                                                            MTS."Responsible Person" := "User ID";

                                            IF "Transfer-from Code" IN ['QAS', 'QC'] THEN
                                                //Calibration due was changed by Bharati K on 22Dec2014
                                                MTS."Next Calibration Date" := "Posting Date" + 180;//60
                                            MTS.MODIFY;
                                        END;
                                    UNTIL "Tracking Specification".NEXT = 0;
                            UNTIL "Material Issues Line".NEXT = 0;
                        // end of code for Multimeter Tracking System.

                        PostingBoolean := FALSE;
                        IF "Transfer-to Code" <> 'DC' THEN
                            CODEUNIT.RUN(60011, Rec);
                        PostingBoolean := TRUE;
                        Mat_Issue_sLine.RESET;
                        Mat_Issue_sLine.SETRANGE(Mat_Issue_sLine."Document No.", "No.");
                        IF Mat_Issue_sLine.FINDSET THEN
                            REPEAT
                                Mat_Issue_sLine."Qty. to Receive" := Mat_Issue_sLine.Quantity - Mat_Issue_sLine."Quantity Received";
                                Mat_Issue_sLine.MODIFY;
                            UNTIL Mat_Issue_sLine.NEXT = 0;

                        /*IF PostingBoolean THEN
                        BEGIN
                          Mail_To := 'store@efftronics.com';
                         Subject:='Material Request Posted With Requisition No:'+RequistionNo;
                         Body:='Dear Sir/Madam,';
                         Body+='<br><br>';
                         Body+='Material is Posted at Control Room by '+username+' Kindly Find the Attachement and Transfer the Material';
                         Body+='<br/><br><br/>';
                         Body+='<b>Regards,<br>'+username+'</b><BR>';
                         Body+='<br><br/>        Note: This is System generated Automail.</b><br>';
                         Attachment:=FileDirectory+filname;
                         SMTP_MAIL.CreateMessage('ERP','erp@efftronics.com',Mail_To,Subject,Body,TRUE);
                         SMTP_MAIL.AddBCC('erp@efftronics.com');
                         SMTP_MAIL.AddAttachment(Attachment,''); //EFFUPG
                         SMTP_MAIL.Send;
                         MESSAGE('Mail Has Been Sent to '+Mail_To);
                        END;*/

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
                                                        "Service Item Line".Station := "Material Issues Line".Station;  // Added by Pranavi on 25-Apr-2017 for tracking station
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
                                                        "Service Item Line".Station := "Material Issues Line".Station;  // Added by Pranavi on 25-Apr-2017 for tracking station
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
            action("No Series")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    MESSAGE('%1', NoSeriesMgt.GetNextNo(
                                         'PMI NEW', TODAY, TRUE));
                end;
            }
            action("P&rint New")
            {
                Caption = 'P&rint New';
                Image = PrintCover;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    MaterialIssuesHeader.RESET;
                    MaterialIssuesHeader.SETRANGE("No.", "No.");
                    REPORT.RUN(50010, TRUE, FALSE, MaterialIssuesHeader);
                end;
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
                    MaterialIssuesHeader.RESET;
                    MaterialIssuesHeader.SETRANGE("No.", "No.");
                    REPORT.RUN(50010, TRUE, FALSE, MaterialIssuesHeader);
                end;
            }
            action(Refresh)
            {
                Caption = 'Refresh';
                Image = RefreshLines;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CURefresh.Refresh(Rec);
                    //Commented by sundar foe centralizing all refresh in CU 60010
                    /*
                    IF Status<>Status::Released THEN
                    BEGIN
                    IF USERID IN ['EFFTRONICS\MNRAJU','EFFTRONICS\MARY','EFFTRONICS\SUNDAR','EFFTRONICS\RATNA','EFFTRONICS\DMADHAVI',
                                  'EFFTRONICS\SHEKHAR','EFFTRONICS\SIRISHA']  THEN
                    BEGIN
                    IF ISCLEAR(SQLConnection) THEN
                      CREATE(SQLConnection,FALSE,TRUE);
                    
                    IF ISCLEAR(RecordSet) THEN
                      CREATE(RecordSet,FALSE,TRUE);
                    
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
                          "Posting Date":=WORKDATE;
                          IF "Authorized Date"=0D THEN
                            "Authorized Date":=WORKDATE;
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
                    */

                end;
            }
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

    trigger OnInit();
    begin
        "Vendor No.Visible" := FALSE;
        IF (UPPERCASE(USERID) IN ['EFFTRONICS\DMADHAVI', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\PARDHU', 'EFFTRONICS\PRANAVI']) THEN
            "Vendor No.Visible" := TRUE;

        UserIdEditable := FALSE;
        IF (UPPERCASE(USERID) IN ['EFFTRONICS\DMADHAVI', 'EFFTRONICS\RATNA', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\NAYOMI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) AND
            (("Transfer-from Code" IN ['SITE', 'OLDSTOCK']) OR ("Transfer-to Code" IN ['SITE', 'OLDSTOCK'])) THEN
            IF UPPERCASE(USERID) IN ['EFFTRONICS\PRANAVI'] THEN
                UserIdEditable := TRUE;
    end;

    var
        MaterialIssuesHeader: Record "Material Issues Header";
        "Service Item Line": Record "Service Item Line";
        "Material Issues Line": Record "Material Issues Line";
        "Posted Material Issues Header": Record "Posted Material Issues Header";
        "Posted Material Issues Lines": Record "Posted Material Issues Line";
        itemledgerentry: Record "Item Ledger Entry";
        Dmg_Qty: Decimal;
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        USER: Record User;
        Body: Text[1024];
        Mail_From: Text[250];
        Mail_To: Text[250];
        Mail: Codeunit Mail;
        Subject: Text[250];
        "Item Wise Min. Req. Qty at Loc": Record "Item Wise Min. Req. Qty at Loc";
        "Service_ Item": Record "Service Item";
        "Tracking Specification": Record "Mat.Issue Track. Specification";
        "Service Header": Record "Service Header";
        SMSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Service_Order_No_: Code[20];
        Order_Line_No: Integer;
        SMTP_MAIL: Codeunit 60027;
        "Dimension Value": Record "Dimension Value";
        Mat_Issue_sLine: Record "Material Issues Line";
        Attachment: Text[1000];
        SMTPSETUP: Record "SMTP SETUP";
        //>> ORACLE UPG
        /*  objEmailConf: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000002-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Configuration";
         objEmail: Automation "'{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0:'{CD000001-8B95-11D1-82DB-00C04FB1625D}':''{CD000000-8B95-11D1-82DB-00C04FB1625D}' 1.0'.Message";
         flds: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000564-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Fields";
         fld: Automation "'{00000205-0000-0010-8000-00AA006D2EA4}' 2.5:'{00000569-0000-0010-8000-00AA006D2EA4}':''{00000205-0000-0010-8000-00AA006D2EA4}' 2.5'.Field"; */
        //<< ORACLE UPG
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
        UserSetup: Record "User Setup";
        CurrentUserID: Text[50];
        AuthorizedID: Text[50];
        //>> ORACLE UPG
        /* SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
        RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        UserIdEditable: Boolean;
        Indent_No: Code[20];
        "Indent Header": Record "Indent Header";
        "Indent Line": Record "Indent Line";
        Dat: Code[10];
        Mon: Code[10];
        Yer: Code[10];
        "Production Order": Record "Production Order";
        Line_No: Integer;
        Prev_Indent: Code[20];
        Prev_Indent_Series: Code[20];
        "No. Series": Record "No. Series";
        "No. Series Line": Record "No. Series Line";
        CURefresh: Codeunit "Release MaterialIssue Document";
        AssingBatchManual: Codeunit "Assign Batch No's";
        Itm: Record Item;
        FileDirectory: Text;
        filname: Text;
        username: Text;
        ITEM_COST: Decimal;
        MATlINE: Record "Material Issues Line";
        User_rec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];


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


    procedure TEMC_MSLMail(ItemNo: Code[30]);
    var
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Itm: Record Item;
        User: Record User;
    begin
        //B2B UPG >>>
        /* IF Itm.GET(ItemNo) THEN BEGIN
            IF User.GET(USERSECURITYID) THEN BEGIN
                IF User.MailID <> '' THEN
                    Mail_From := User.MailID
                ELSE
                    Mail_From := 'erp@efftronics.com';
            END ELSE
                Mail_From := 'erp@efftronics.com';
            Mail_To := 'erp@efftronics.com,temc@efftronics.com';
            Subject := 'Reg: Floor Life not defined for ' + Itm."No." + ' - ' + Itm.Description;
            Body := '';
            SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            //SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
            SMTP_MAIL.AppendBody('<h>Dear Sir/Madam,</h><br><br>');
            SMTP_MAIL.AppendBody('<p align ="left">Please define Floor life for the component!</p>');
            SMTP_MAIL.AppendBody('<p align ="left">Item No.: ' + Itm."No." + '</p>');
            SMTP_MAIL.AppendBody('<p align ="left">Item Description : ' + Itm.Description + '</p>');
            SMTP_MAIL.AppendBody('<p align ="left"> Regards,<br>ERP Team </p>');
            SMTP_MAIL.AppendBody('<p align = "left">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
            //SMTP_MAIL.AddAttachment(Attachment1);
            SMTP_MAIL.Send;
        END; */     //B2B UPG

        IF Itm.GET(ItemNo) THEN BEGIN
            /* IF User.GET(USERSECURITYID) THEN BEGIN
                IF User.MailID <> '' THEN
                    Mail_From := User.MailID
                ELSE
                    Mail_From := 'erp@efftronics.com';
            END ELSE
                Mail_From := 'erp@efftronics.com'; */
            //Mail_To := 'erp@efftronics.com,temc@efftronics.com';
            Recipients.Add('erp@efftronics.com');
            Recipients.Add('temc@efftronics.com');
            Subject := 'Reg: Floor Life not defined for ' + Itm."No." + ' - ' + Itm.Description;
            Body := '';
            //SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            EmailMessage.Create(Recipients, Subject, Body, true);
            //SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
            Body += ('<h>Dear Sir/Madam,</h><br><br>');
            Body += ('<p align ="left">Please define Floor life for the component!</p>');
            Body += ('<p align ="left">Item No.: ' + Itm."No." + '</p>');
            Body += ('<p align ="left">Item Description : ' + Itm.Description + '</p>');
            Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<p align = "left">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
    end;


    procedure StationaryMaterialTesting(): Boolean;
    var
        MIL: Record "Material Issues Line";
        LinesCount: Integer;
        StationaryCount: Integer;
        NonStationary: Text[250];
        user: Record User;
    begin
        user.RESET;
        user.SETRANGE(user."User Name", USERID);
        user.FINDSET;
        IF (Rec."Prod. Order No." = 'EFF14STA01') THEN BEGIN
            LinesCount := 0;
            StationaryCount := 0;
            MIL.RESET;
            MIL.SETFILTER("Document No.", Rec."No.");
            MIL.FINDSET;
            LinesCount := MIL.COUNT;
            MIL.RESET;
            MIL.SETFILTER("Document No.", Rec."No.");
            MIL.SETFILTER("Product Group Code", '%1|%2|%3', 'STATIONARY', 'GEN', 'GENERAL');
            MIL.FINDSET;
            StationaryCount := MIL.COUNT;
            IF StationaryCount <> LinesCount THEN BEGIN
                NonStationary := '';
                MIL.RESET;
                MIL.SETFILTER("Document No.", Rec."No.");
                MIL.SETFILTER("Product Group Code", '<>%1&<>%2&<>%3', 'STATIONARY', 'GEN', 'GENERAL');
                IF MIL.FINDSET THEN
                    REPEAT
                        NonStationary := NonStationary + MIL."Item No." + ', ';
                    UNTIL MIL.NEXT = 0;
                //usMESSAGE('There are Non-Stationary Items  '+ NonStationary);
                ERROR('There are Non-Stationary Items  ' + NonStationary);
            END;
        END;
    end;


    local procedure checking_LocationsCode();
    begin
        //Written by Vishnu Priya on 03-30-2020
        MATlINE.RESET;
        MATlINE.SETFILTER("Document No.", Rec."No.");
        IF MATlINE.FINDSET THEN
            REPEAT
                IF MATlINE."Shortcut Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code" THEN
                    ERROR('Both Locations should be same in header and Lines');
            UNTIL MATlINE.NEXT = 0;
        //Written by Vishnu Priya on 03-30-2020
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

