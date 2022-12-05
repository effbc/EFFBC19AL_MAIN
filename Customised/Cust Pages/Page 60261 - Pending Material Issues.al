page 60261 "Pending Material Issues"
{
    // version MI1.0,Rev01

    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    Permissions = TableData "Material Issues Line" = rm;
    SaveValues = true;
    SourceTable = "Material Issues Line";
    SourceTableView = SORTING("Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.") ORDER(Ascending) WHERE("Outstanding Quantity" = FILTER(> 0), "Transfer-from Code" = FILTER(<> 'CS' & <> 'SITE'), "Transfer-to Code" = FILTER(<> 'CS' & <> 'SITE' & <> 'DAMAGE' & <> 'CS STR' & <> 'R&D STR' & <> 'STR'), Status = FILTER(Released));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Status; Status)
                {
                    OptionCaption = 'Open,Released,Sent for Authorization,Rejected';
                    ApplicationArea = All;
                }
                field(AutoPost; AutoPost)
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; "Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; "Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; "Line No.")
                {
                    StyleExpr = ColorCode;
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; "Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; "Transfer-to Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    StyleExpr = ColorCode;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        MaterialIssuesHeader.SETRANGE("No.", "Document No.");
                        IF MaterialIssuesHeader.FINDFIRST THEN BEGIN
                            "Prod. Order No." := MaterialIssuesHeader."Prod. Order No.";
                            "Prod. Order Line No." := MaterialIssuesHeader."Prod. Order Line No.";
                            "Reason Code" := MaterialIssuesHeader."Reason Code";
                            /*IF MaterialIssuesHeader."Transfer-to Code"='SITE' THEN
                            BEGIN
                              ItemFilter:='';
                              ItemGRec.RESET;
                              IF ItemGRec.GET("Item No.") THEN
                                IGCFilter:=ItemGRec."CS IGC";
                              IF IGCFilter <>'' THEN
                              BEGIN
                                ItemGRec.RESET;
                                ItemGRec.SETRANGE(ItemGRec."CS IGC",IGCFilter);
                                IF ItemGRec.FINDFIRST THEN
                                REPEAT
                                  ItemFilter+=ItemGRec."No."+'|';
                                UNTIL ItemGRec.NEXT=0;
                                ItemFilter:=COPYSTR(ItemFilter,1,STRLEN(ItemFilter)-1);
                              END;
                              IF ItemFilter='' THEN
                                ItemFilter:="Item No.";
                              DivisionGRec.RESET;
                              DivisionGRec.SETFILTER(DivisionGRec."Division Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
                              IF DivisionGRec.FINDFIRST THEN
                                ManagerFilter:=DivisionGRec."Project Manager";

                              DivisionGRec.RESET;
                              DivisionGRec.SETFILTER(DivisionGRec."Project Manager",ManagerFilter);
                              IF DivisionGRec.FINDFIRST THEN
                              REPEAT
                                DivFilter+=DivisionGRec."Division Code"+'|';
                              UNTIL DivisionGRec.NEXT=0;
                                DivFilter:=COPYSTR(DivFilter,1,STRLEN(DivFilter)-1);

                              ItemLedgerEntryGRec.RESET;
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Item No.",ItemFilter);
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Location Code",'SITE');
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",MaterialIssuesHeader."Shortcut Dimension 2 Code");
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Remaining Quantity",'>%1',0);
                              IF ItemLedgerEntryGRec.FINDSET THEN
                                StockAtSite:=ItemLedgerEntryGRec.COUNT;
                              ItemLedgerEntryGRec.SETFILTER(ItemLedgerEntryGRec."Global Dimension 2 Code",DivFilter);
                              IF ItemLedgerEntryGRec.FINDSET THEN
                                StockAtManager:=ItemLedgerEntryGRec.COUNT;
                            END;*/
                        END;
                        /* MatIssuesLine.SETCURRENTKEY(Item No.,Prod. Order No.);
                         MatIssuesLine.SETRANGE(MatIssuesLine."Item No.","Item No.");
                         MatIssuesLine.SETRANGE(MatIssuesLine."Prod. Order No.","Prod. Order No.");
                         IF MatIssuesLine.COUNT>0 THEN
                         ERROR('Not possible to draw item on this project code');
                          postedmaterialissuesline.SETRANGE(postedmaterialissuesline."Item No.","Item No.");
                         postedmaterialissuesline.SETFILTER(postedmaterialissuesline."Prod. Order No.","Prod. Order No.");
                        IF  postedmaterialissuesline.COUNT >0 THEN
                          ERROR('Posted material issue present for this item');  */
                        /*
                        // Added by Pranavi on 29-11-2016 for restricting items selection in sta code
                          MaterialIssuesHeader.RESET;
                          MaterialIssuesHeader.SETRANGE(MaterialIssuesHeader."No.","Document No.");
                          IF MaterialIssuesHeader.FINDFIRST THEN
                          BEGIN
                            IF MaterialIssuesHeader."Prod. Order No." IN ['EFF14STA01','EFF08STA01'] THEN
                            BEGIN
                              ItemGRec.RESET;
                              ItemGRec.SETRANGE(ItemGRec."No.","Item No.");
                              IF ItemGRec.FINDFIRST THEN
                              BEGIN
                                IF ItemGRec."Product Group Code" <> 'STATIONARY' THEN
                                  ERROR('You cannot select other than stationary items in the project code: '+MaterialIssuesHeader."Prod. Order No.");
                              END;
                            END;
                          END;
                        // End--Pranavi
                        */

                    end;
                }
                field(Description; Description)
                {
                    Editable = false;
                    StyleExpr = StockStatus;
                    ApplicationArea = All;
                }
                field("MBB Packet Open DateTime"; "MBB Packet Open DateTime")
                {
                    ApplicationArea = All;
                }
                field("MBB Packet Close DateTime"; "MBB Packet Close DateTime")
                {
                    ApplicationArea = All;
                }
                field("BOM Quantity"; "BOM Quantity")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Non-Returnable"; "Non-Returnable")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; "Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; "Quantity Received")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        "PostedMat.RcptLine": Record "Posted Material Issues Line";
                    begin
                        TESTFIELD("Document No.");
                        TESTFIELD("Item No.");
                        "PostedMat.RcptLine".SETRANGE("Material Issue No.", "Document No.");
                        "PostedMat.RcptLine".SETRANGE("PostedMat.RcptLine"."Material Issue Line No.");
                        PAGE.RUNMODAL(0, "PostedMat.RcptLine");
                    end;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
                field(Station; Station)
                {
                    Editable = true;
                    Enabled = true;
                    ApplicationArea = All;
                }
                field("Station Name"; "Station Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Target Date"; "Target Date")
                {
                    ApplicationArea = All;
                }
                field(Rejected; Rejected)
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Comp. Line No."; "Prod. Order Comp. Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Monitor Problem"; "Monitor Problem")
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Stock at Site"; StockAtSite)
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field(StockAtManager; StockAtManager)
                {
                    Caption = 'Stock at Manager';
                    ApplicationArea = All;
                }
                field("Operation No."; "Operation No.")
                {
                    ApplicationArea = All;
                }
                field(Dept; Dept)
                {
                    ApplicationArea = All;
                }
                field("Material Requisition Date"; "Material Requisition Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152033)
            {
                ShowCaption = false;
                grid(Control1102152032)
                {
                    ShowCaption = false;
                    group(Control1102152031)
                    {
                        ShowCaption = false;
                        field("COUNT"; COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152029)
                    {
                        ShowCaption = false;
                        field(MSLColor; MSLColor)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152009)
                    {
                        ShowCaption = false;
                        field(StockAvailability; StockAvailability)
                        {
                            Editable = false;
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                group(Action1102152016)
                {
                }
                action(BatchAssignment)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        AssingBatchManual: Codeunit "Assign Batch No's";
                        BatchndSerialNos: Record "Batch and Serial No's";
                        "Count": Integer;
                    begin
                        //AssingBatchManual.b
                        Count := 0;
                        IF Rec.FINDSET THEN
                            REPEAT
                                AssingBatchManual.BulckAssignmnet(Rec);
                                IF Rec."Qty. to Receive" <> 0 THEN BEGIN
                                    Rec.MARK(TRUE);
                                    Count := Count + 1;
                                END;
                            UNTIL Rec.NEXT = 0;
                        MESSAGE('Batch Assignment Items Count :: ' + FORMAT(Count));
                    end;
                }
                action(RestAll)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.CLEARMARKS;
                        Rec.RESET;
                        Rec.RESET;
                        Rec.COPYFILTERS(MatIssuesLine);
                        IF Rec.FINDSET THEN
                            REPEAT
                                Rec."Qty. to Receive" := Rec."Outstanding Quantity";
                                VALIDATE(Rec."Qty. to Receive", Rec."Outstanding Quantity");
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                    end;
                }
                action(Post)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ReqNo: Text[50];
                        MIH: Record "Material Issues Header";
                        MIL: Record "Material Issues Line";
                        Itm: Record Item;
                        Material_Post: Codeunit "MaterialIssueOrde-Post Receipt";
                    begin
                        Rec.MARKEDONLY(TRUE);
                        MESSAGE(FORMAT(Rec.COUNT));
                        Rec.SETCURRENTKEY("Document No.", "Line No.");
                        ReqNo := '';
                        IF Rec.FINDFIRST THEN
                            REPEAT
                                IF ReqNo <> Rec."Document No." THEN BEGIN
                                    IF "Transfer-from Code" IN ['CS STR', 'R&D STR', 'PRODSTR', 'STR', 'MCH'] THEN BEGIN
                                        /*MIL.RESET;
                                        MIL.SETFILTER(MIL."Document No.",Rec."Document No.");
                                        MIL.SETFILTER(MIL."Item No.",'<>%1','');
                                        MIL.SETFILTER(MIL.Quantity,'>%1',0);
                                        MIL.SETFILTER(MIL."Qty. to Receive",'>%1',0);
                                        IF MIL.FINDSET THEN                         //added by pranavi
                                        REPEAT
                                          IF Itm.GET(MIL."Item No.") THEN
                                          BEGIN
                                            IF (Itm.MSL <> 0) AND (Itm."Floor Life at 25 C 40% RH" IN['',' ']) THEN
                                            BEGIN
                                              TEMC_MSLMail(Itm."No.");
                                              ERROR('Floor Life not defined for the MSL Component! Please contact TEMC!');
                                            END;
                                            IF (Itm.MSL <> 0) AND NOT (Itm."Floor Life at 25 C 40% RH" IN['INFINITE']) THEN
                                            BEGIN
                                              IF MIL."MBB Packet Open DateTime" = 0DT THEN
                                                ERROR('Please Enter MBB Open DateTime in Line No.: %1 !',MIL."Line No.");
                                              IF MIL."MBB Packet Close DateTime" = 0DT THEN
                                                ERROR('Please Enter MBB Closed DateTime in Line No.: %1 !',MIL."Line No.");
                                            END;
                                          END;
                                        UNTIL MIL.NEXT = 0;*/
                                        IF Itm.GET(MIL."Item No.") THEN BEGIN
                                            IF (Itm.MSL <> 0) AND (Itm."Floor Life at 25 C 40% RH" IN ['', ' ']) THEN BEGIN
                                                TEMC_MSLMail(Itm."No.");
                                                ERROR('Floor Life not defined for the MSL Component! Please contact TEMC!');
                                            END;
                                            IF (Itm.MSL <> 0) AND NOT (Itm."Floor Life at 25 C 40% RH" IN ['INFINITE']) THEN BEGIN
                                                IF Rec."MBB Packet Open DateTime" = 0DT THEN
                                                    ERROR('Please Enter MBB Open DateTime in Line No.: %1 !', MIL."Line No.");
                                                IF Rec."MBB Packet Close DateTime" = 0DT THEN
                                                    ERROR('Please Enter MBB Closed DateTime in Line No.: %1 !', MIL."Line No.");
                                            END;
                                        END;
                                    END;
                                    MIH.RESET;
                                    MIH.SETFILTER("No.", "Document No.");
                                    IF MIH.FINDSET THEN BEGIN
                                        MIH."Posting Date" := TODAY;
                                        MIH.MODIFY;
                                        //CODEUNIT.RUN(60011,MIH);
                                        Material_Post.BulkPostingStatusUpdate;
                                        Material_Post.RUN(MIH);
                                        ReqNo := MIH."No.";
                                    END;
                                END;
                            UNTIL Rec.NEXT = 0;
                        Rec.CLEARMARKS;
                        /*Rec.RESET;
                        Rec.SETRANGE(Status,Rec.Status::Released);
                        Rec.SETFILTER("Outstanding Quantity",'>%1',0);
                        Rec.SETFILTER("Transfer-from Code",'<>%1&<>%2','CS','SITE');
                        Rec.SETFILTER("Transfer-to Code",'<>%1&<>%2&<>%3&<>%4&<>%5&<>%6','CS','SITE','DAMAGE','CS STR','R&D STR','STR');
                        Rec.FINDSET;*/
                        //CLEAR(Rec);
                        Rec.RESET;
                        Rec.COPYFILTERS(MatIssuesLine);
                        Rec.FINDSET;

                    end;
                }
            }
            group(Action1907935204)
            {
                Caption = '&Line';
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        BatchndSerialNos: Record "Batch and Serial No's";
                    begin
                        //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                        /*CurrPage.MaterialIssueLine.FORM.*/
                        _ShowDimensions;

                    end;
                }
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        //This functionality was copied from page #60140. Unsupported part was commented. Please check it.
                        /*CurrPage.MaterialIssueLine.FORM.*/
                        OpenItemTrackingLinesPage;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        MaterialIssuesHeader.RESET;
        MaterialIssuesHeader.SETFILTER("No.", Rec."Document No.");
        IF MaterialIssuesHeader.FINDFIRST THEN BEGIN
            AutoPost := MaterialIssuesHeader."Auto Post";
        END;
        ColorCode := '';
        /*StockStatus:= '';
        IF ItemGRec.GET("Item No.") AND (ItemGRec.MSL <> 0) AND NOT (ItemGRec."Floor Life at 25 C 40% RH" IN['INFINITE']) THEN
          ColorCode:='StrongAccent';
        IF ItemGRec.GET("Item No.") THEN
        BEGIN
          IF "Transfer-from Code" = 'STR' THEN
          BEGIN
             IF ItemGRec."Stock at Stores" >= Rec."Outstanding Quantity" THEN
              BEGIN      //
                  StockStatus := 'Favorable';
              END;
          END;
          IF "Transfer-from Code" = 'CS STR' THEN
          BEGIN
             IF ItemGRec."Stock at CS Stores" >= Rec."Outstanding Quantity" THEN
              BEGIN      //
                  StockStatus := 'Favorable';
              END;
          END;
          IF "Transfer-from Code" = 'R&D STR' THEN
          BEGIN
             IF ItemGRec."Stock at RD Stores" >= Rec."Outstanding Quantity" THEN
              BEGIN      //
                  StockStatus := 'Favorable';
              END;
          END;
          IF "Transfer-from Code" = 'MCH' THEN
          BEGIN
             IF ItemGRec."Stock At MCH Location" >= Rec."Outstanding Quantity" THEN
              BEGIN      //
                  StockStatus := 'Favorable';
              END;
          END;
        END;
        */// Commented by Vijaya on 30-01-2018 for Item Behaviou testing

    end;

    trigger OnOpenPage();
    begin
        StockAvailability := 'Stock Available at From Code';
        MatIssuesLine.RESET;
        MatIssuesLine.COPYFILTERS(Rec);
        if MatIssuesLine.FINDSET then;//RFFUPG1.3
    end;

    var
        MatIssuesLine: Record "Material Issues Line";
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        MaterialIssuesHeader: Record "Material Issues Header";
        postedmaterialissuesline: Record "Posted Material Issues Line";
        Mail_From: Text[1000];
        EmailMessage: Codeunit "Email Message";
        Recipient: List of [Text];
        Email: Codeunit Email;
        Mail_to: Text[1000];
        Mail_Subject: Text[1000];
        Body: Text[500];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        User: Record "User Setup";
        Subject: Text[500];
        StockAtSite: Decimal;
        ItemLedgerEntryGRec: Record "Item Ledger Entry";
        ItemGRec: Record Item;
        ItemFilter: Code[1000];
        IGCFilter: Code[1000];
        StockAtManager: Decimal;
        DivisionGRec: Record "Employee Statistics Group";
        ManagerFilter: Code[250];
        DivFilter: Code[250];
        StationGRec: Record Station;
        ColorCode: Code[30];
        MSLColor: Label 'MSL Component';
        Status: Option Open,Released,"Sent for Authorization",Rejected;
        AutoPost: Boolean;
        StockStatus: Code[30];
        StockAvailability: Text;


    procedure _ItemAvailability(AvailabilityType: Option Date,Variant,Location);
    begin
        ItemAvailability(AvailabilityType);
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location);
    begin
        ItemAvailability(AvailabilityType);
    end;


    procedure _ShowDimensions();
    var
        AssingBatchManual: Codeunit "Assign Batch No's";
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowDimensions();
    begin
        Rec.ShowDimensions;
    end;


    procedure OpenItemTrackingLinesPage();
    var
        Item: Record Item;
        Text001: TextConst ENU = 'You must specify Item Tracking Code in Item No. =''%1''.';
    begin
        Item.GET("Item No.");  //Rev01 Changed Function Name
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            TrackingSpecification.SETRANGE("Order No.", "Document No.");
            TrackingSpecification.SETRANGE("Order Line No.", "Line No.");
            TrackingSpecification.SETRANGE("Item No.", "Item No.");
            TrackingSpecification.SETRANGE("Location Code", "Transfer-from Code");
            PAGE.RUN(PAGE::"Mat.Issues Track.Specification", TrackingSpecification);
        END ELSE
            MESSAGE(Text001, "Item No.");
    end;


    local procedure RemarksOnInputChange(var Text: Text[1024]);
    begin
        TESTFIELD(Status, Status::Open);
    end;


    procedure TEMC_MSLMail(ItemNo: Code[30]);
    var
        Body: Text;
        Subject: Text;
        Mail_To: Text;
        Mail_From: Text;
        // SMTP_MAIL: Codeunit "SMTP Mail";
        Itm: Record Item;
        User: Record "User Setup";
    begin
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
            Body+=('<h>Dear Sir/Madam,</h><br><br>');
            Body+=('<p align ="left">Please define Floor life for the component!</p>');
            Body+=('<p align ="left">Item No.: ' + Itm."No." + '</p>');
            Body+=('<p align ="left">Item Description : ' + Itm.Description + '</p>');
            Body+=('<p align ="left"> Regards,<br>ERP Team </p>');
            Body+=('<p align = "left">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
             //SMTP_MAIL.AddAttachment(Attachment1);
             SMTP_MAIL.Send;*/  //B2B UPG

        IF Itm.GET(ItemNo) THEN BEGIN
            IF User.GET(USERSECURITYID) THEN BEGIN
                IF User.MailID <> '' THEN
                    Mail_From := User.MailID
                ELSE
                    Mail_From := 'erp@efftronics.com';
            END ELSE
                Mail_From := 'erp@efftronics.com';
            // Mail_To := 'erp@efftronics.com,temc@efftronics.com';
            Recipient.add('erp@efftronics');
            Recipient.Add('temc@efftronics.com');
            Subject := 'Reg: Floor Life not defined for ' + Itm."No." + ' - ' + Itm.Description;
            Body := '';
            //  SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Body, TRUE);
            //SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
            Body += ('<h>Dear Sir/Madam,</h><br><br>');
            Body += ('<p align ="left">Please define Floor life for the component!</p>');
            Body += ('<p align ="left">Item No.: ' + Itm."No." + '</p>');
            Body += ('<p align ="left">Item Description : ' + Itm.Description + '</p>');
            Body += ('<p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<p align = "left">:: Note: Auto Generated mail from ERP :: </b></P></div></body></html>');
            //SMTP_MAIL.AddAttachment(Attachment1);
            EmailMessage.Create(recipient, Subject, Body, TRUE);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
    end;
}

