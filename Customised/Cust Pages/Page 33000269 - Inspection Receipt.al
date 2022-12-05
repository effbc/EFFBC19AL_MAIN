page 33000269 "Inspection Receipt"
{
    // version QC1.1,Cal1.0,QCP1.0,RQC1.0,Rev01,EFFUPG

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData "Item Ledger Entry" = rimd;
    SourceTable = "Inspection Receipt Header";
    SourceTableView = SORTING("No.") WHERE(Status = FILTER(false), "Source Type" = CONST("In Bound"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("IDS Posted By"; Rec."IDS Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = editfields;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason code"; Rec."Reason code")
                {
                    ApplicationArea = All;
                }
                field(MSL; MSL)
                {
                    Caption = 'MSL';
                    Editable = false;
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("ESD Class"; "ESD Class")
                {
                    Caption = 'ESD Class';
                    Editable = false;
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("Floor Life at 25 C 40% RH"; "Floor Life at 25 C 40% RH")
                {
                    Caption = 'Floor Life at 25 C 40% RH';
                    Editable = false;
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Years)"; "Component Shelf Life(Years)")
                {
                    Caption = 'Component Shelf Life(Years)';
                    Editable = false;
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("Bake Hours"; "Bake Hours")
                {
                    Caption = 'Component Bake Hours';
                    Editable = false;
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
            }
            part(InpectionReceiptLine; "Inpection Receipt Line")
            {
                SubPageLink = "Document No." = FIELD("No.")
, "Purch Line No." = FIELD("Purch Line No");
                ApplicationArea = All;
            }
            group(Receipt)
            {
                Caption = 'Receipt';
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Name 2"; Rec."Vendor Name 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created time"; Rec."Created time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purch Line No"; Rec."Purch Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Consignment"; Rec."Purchase Consignment")
                {
                    ApplicationArea = All;
                }
                field("Item Tracking Exists"; Rec."Item Tracking Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quality Before Receipt"; Rec."Quality Before Receipt")
                {
                    ApplicationArea = All;
                }
            }
            group(Production)
            {
                Caption = 'Production';
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Order Line"; Rec."Prod. Order Line")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Prod. Description"; Rec."Prod. Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production Batch No."; Rec."Production Batch No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sub Assembly Code"; Rec."Sub Assembly Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Sub Assembly Description"; Rec."Sub Assembly Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("In Process"; Rec."In Process")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
                {
                    ApplicationArea = All;

                }
                field("Finished Product Sr No"; Rec."Finished Product Sr No")
                {
                    ApplicationArea = All;
                }
                field("Rework User"; Rec."Rework User")
                {
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
            }
            group("Sales Cr.Memo")
            {
                Caption = 'Sales Cr.Memo';
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Posted Sales Order No."; Rec."Posted Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Line No"; Rec."Sales Line No")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Name 2"; Rec."Customer Name 2")
                {
                    ApplicationArea = All;
                }
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;
                }
                field("Customer Address2"; Rec."Customer Address2")
                {
                    ApplicationArea = All;
                }
            }
            group(Transfer)
            {
                Caption = 'Transfer';
                field("Trans. Order No."; Rec."Trans. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Trans. Order Line"; Rec."Trans. Order Line")
                {
                    ApplicationArea = All;
                }
                field("Trans. Description"; Rec."Trans. Description")
                {
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    ApplicationArea = All;
                }
            }
            group(Inspection)
            {
                Caption = 'Inspection';
                field("<Quantity2>"; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(UndefinedQty; UndefinedQty)
                {
                    Caption = 'UndefinedQty';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Qty. Accepted"; Rec."Qty. Accepted")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        Rec.QualityAcceptanceLevels(QualityType::Accepted);
                        CalculateUndefinedQty;
                    end;
                }
                field("Qty. Accepted Under Deviation"; Rec."Qty. Accepted Under Deviation")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec."Trans. Order No." <> '' THEN
                            ERROR('You can not enter the rework quantity for sample inspection');
                        IF Rec."Sample Inspection" THEN
                            ERROR('You can not enter the rework quantity for sample inspection');

                        Rec.QualityAcceptanceLevels(QualityType::"Accepted Under Deviation");
                        CalculateUndefinedQty;
                    end;
                }
                field("Qty. Rework"; Rec."Qty. Rework")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec."Trans. Order No." <> '' THEN
                            ERROR('You can not enter the rework quantity for sample inspection');
                        IF Rec."Sample Inspection" THEN
                            ERROR('You can not enter the rework quantity for sample inspection');

                        Rec.QualityAcceptanceLevels(QualityType::Rework);
                        CalculateUndefinedQty;
                    end;
                }
                field("Qty. Rejected"; Rec."Qty. Rejected")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        Rec.QualityAcceptanceLevels(QualityType::Rejected);
                        CalculateUndefinedQty;
                    end;
                }
                field("Rejection Category"; Rec."Rejection Category")
                {
                    ApplicationArea = All;
                }
                field(Flag; Rec.Flag)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. Accepted UD Reason"; Rec."Qty. Accepted UD Reason")
                {
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                }
                field("Nature Of Rejection"; Rec."Nature Of Rejection")
                {
                    ApplicationArea = All;
                }
                field("Rework Time( In Minutes)"; Rec."Rework Time( In Minutes)")
                {
                    Editable = ReworkTimeInMinutesEditable;
                    ApplicationArea = All;
                }
                field("Rejection Reason"; Rec."Rejection Reason")
                {
                    ApplicationArea = All;
                }
                field("MBB Status"; Rec."MBB Status")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("HIC 60%"; Rec."HIC 60%")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("HIC 10%"; Rec."HIC 10%")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("HIC 5%"; Rec."HIC 5%")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("MBB Packet Open DateTime"; Rec."MBB Packet Open DateTime")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("MBB Packet Close DateTime"; Rec."MBB Packet Close DateTime")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."MBB Packet Close DateTime" <> 0DT THEN BEGIN
                            IF Rec."MBB Packet Open DateTime" = 0DT THEN
                                ERROR('Please enter MBB Packet Open DateTime first!');
                            IF Rec."MBB Packet Close DateTime" - Rec."MBB Packet Open DateTime" <= 0 THEN
                                ERROR('MBB Packet Close Time must be >= MBB packet Open Time!');
                        END;
                    end;
                }
                field("Baked Hours"; Rec."Baked Hours")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("MFD Date"; Rec."MFD Date")
                {
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("Packed Date"; Rec."Packed Date")
                {
                    Caption = 'Manf. Packed Date';
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("MBB Packed Date"; Rec."MBB Packed Date")
                {
                    Caption = 'MBB Packed Date after Baking';
                    Visible = Visible_Bool;
                    ApplicationArea = All;
                }
                field("<Vendor No.2>"; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Vendor Name2>"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Address2>"; Rec.Address)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Address 22>"; Rec."Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Contact Person2>"; Rec."Contact Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                }
                field(Recommendations; Rec.Recommendations)
                {
                    ApplicationArea = All;
                }
            }
            group(Calibration)
            {
                Caption = 'Calibration';
                field(Transfer_to_calibration; Transfer_to_calibration)
                {
                    ApplicationArea = All;
                }
                field("Equp Type"; Rec."Equp Type")
                {
                    Caption = 'Equipment Type';
                    ApplicationArea = All;
                }
                field("Equp Desc"; Rec."Equp Desc")
                {
                    Caption = '"Equipment Description';
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Equipment Make"; Rec.Make)
                {
                    Caption = 'Equipment Make';
                    ApplicationArea = All;
                }
                field("Equp Model"; Rec."Equp Model")
                {
                    Caption = 'Equipment Model';
                    ApplicationArea = All;
                }
                field("Calibration Type"; Rec."Calibration Party")
                {
                    ApplicationArea = All;
                }
                field("Frequency of Calibration"; Rec."Calibration frequency")
                {
                    Caption = 'Frequency of Calibration';
                    ApplicationArea = All;
                }
                field("Calibration Date"; Rec."Calibration Date")
                {
                    ApplicationArea = All;
                }
                field("Next Calibration Date"; Rec."Next calib date")
                {
                    ApplicationArea = All;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field("IDS creation Date"; Rec."IDS creation Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ApplicationArea = All;
                }
                field("No.of Fixing Holes"; Rec."No.of Fixing Holes")
                {
                    ApplicationArea = All;
                }
                field("No. of Soldering Points"; Rec."No. of Soldering Points")
                {
                    ApplicationArea = All;
                }
                field("No. of Pins"; Rec."No. of Pins")
                {
                    ApplicationArea = All;
                }
                field("OLD IDS"; Rec."OLD IDS")
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
            group("&Receipt")
            {
                Caption = '&Receipt';
                action("&Inspection Data Sheets")
                {
                    Caption = '&Inspection Data Sheets';
                    Image = Worksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Inspection Data Sheet List";
                    RunPageLink = "Receipt No." = FIELD("Receipt No."), "Order No." = FIELD("Order No."), "Purch Line No" = FIELD("Purch Line No"), "Lot No." = FIELD("Lot No.");
                    ApplicationArea = All;
                }
                action("P&osted Inspect. Data Sheets")
                {
                    Caption = 'P&osted Inspect. Data Sheets';
                    Image = PostedTimeSheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Inspect Data Sheet List";
                    RunPageLink = "Inspection Receipt No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator("-----")
                {
                    Caption = '-----';
                }
                action("&Purchase Receipt")
                {
                    Caption = '&Purchase Receipt';
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Purchase Receipt";
                    RunPageLink = "No." = FIELD("Receipt No.");
                    ApplicationArea = All;
                }
                separator(Action1102152062)
                {
                }
                action(Accept)
                {
                    Caption = 'Accept';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InspectionReceiptline.SETFILTER(InspectionReceiptline."Document No.", Rec."No.");
                        // InspectionReceiptline.SETFILTER(InspectionReceiptline."Character Code",'<>'' ''');
                        IF InspectionReceiptline.FINDSET THEN
                            REPEAT
                                InspectionReceiptline.Accept := TRUE;
                                InspectionReceiptline.MODIFY;
                            UNTIL InspectionReceiptline.NEXT = 0;
                        MESSAGE(FORMAT(InspectionReceiptline.COUNT));
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                action("Item &Tracking Lines")
                {
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT Rec."Quality Before Receipt" THEN
                            Rec.ShowItemTrackingLines;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Attachment.RESET;
                        Attachment.SETRANGE("Table ID", DATABASE::"Inspection Receipt Header");
                        //Attachment.SETRANGE("Ids Reference No.","Ids Reference No.");
                        Attachment.SETRANGE("Document No.", Rec."No.");
                        //Attachment.SETRANGE("Document Type","Document Type");

                        PAGE.RUN(PAGE::"ESPL Attachments", Attachment);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Image = Post;
                    Promoted = true;
                    ShortCutKey = 'F9';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        MIH: Record "Material Issues Line";
                    begin
                        IF NOT (SMTP_MAIL.Permission_Checking(USERID, 'IR-POSTING'))
                          THEN
                            ERROR('YOU DONT HAVE RIGHTS TO POST THE INSPECTION RECEIPT');

                        /*IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\ANILKUMAR','EFFTRONICS\BHARAT','EFFTRONICS\PRANAVI','EFFTRONICS\CHOWDARY','EFFTRONICS\DINEEL','EFFTRONICS\SHEKHAR']) THEN //Rev01
                          ERROR('YOU DONT HAVE RIGHTS TO POST THE INSPECTION RECEIPT');*/  //Rev01

                        IF (Rec."Qty. Rejected" > 0) AND (Rec."Rejection Reason" = '') THEN
                            ERROR('Enter The Rejection Category and Rejection Reason');


                        IF NOT CONFIRM('Do you want to Post the Inspection Receipt?') THEN
                            EXIT;

                        IF (Transfer_to_calibration = TRUE) THEN BEGIN
                            Trasfer_To_calibration_module();
                        END;
                        //ELSE
                        //  MESSAGE('You are posting this IR with out transfering to Calibration');
                        // >>Added by Pranavi on 19-05-2017 for MSL process
                        IF item.GET(Rec."Item No.") THEN BEGIN
                            IF (item.MSL <> 0) AND (item.MSL <> 1) THEN BEGIN
                                IF Rec."Qty. Accepted" <> 0 THEN BEGIN
                                    IF Rec."MFD Date" = 0D THEN
                                        ERROR('Please enter MFD Date!');
                                    IF Rec."MBB Status" = 0 THEN
                                        ERROR('Please enter MBB Status!');
                                    IF (Rec."HIC 5%" = 0) OR (Rec."HIC 10%" = 0) OR (Rec."HIC 60%" = 0) THEN
                                        ERROR('Please enter HIC Color status!');
                                    IF Rec."MBB Packet Open DateTime" = 0DT THEN
                                        ERROR('Please enter MBB Packet Open DateTime!');
                                    IF Rec."MBB Packet Close DateTime" = 0DT THEN
                                        ERROR('Please enter MBB Packet Close DateTime!');
                                    IF Rec."MBB Packet Close DateTime" - Rec."MBB Packet Open DateTime" <= 0 THEN
                                        ERROR('MBB Packet Close Time must be >= MBB packet Open Time!');
                                    IF (Rec."MBB Status" = Rec."MBB Status"::Damage) AND (Rec."MBB Packed Date" = 0D) THEN
                                        ERROR('Please enter MBB packed date as MBB is damaged!');
                                    IF (item.MSL <> 0) AND (item."Floor Life at 25 C 40% RH" IN ['', ' ']) THEN BEGIN
                                        TEMCMail.TEMC_MSLMail(item."No.");
                                        ERROR('Floor Life in Item card is not defined! Please contact TEMC!');
                                    END;
                                    IF (item.MSL IN [item.MSL::"2"]) AND (Rec."HIC 60%" <> Rec."HIC 60%"::Blue) AND (item."Floor Life at 25 C 40% RH" <> 'INFINITE') THEN BEGIN
                                        IF (Rec."Baked Hours" <= 0) THEN
                                            ERROR('Please enter baking hours!');
                                        IF (Rec."Baked Hours" <> "Bake Hours") AND ("Bake Hours" <> 0) THEN
                                            ERROR('Baked Hours must equal to Bake hours defined in Item card : %1!', item."Bake Hours");
                                        IF Rec."MBB Packed Date" = 0D THEN
                                            ERROR('Please enter New MBB Packed Date!');
                                    END;
                                    IF (item.MSL IN [item.MSL::"2A", item.MSL::"3", item.MSL::"4", item.MSL::"5", item.MSL::"5A"]) AND (item."Floor Life at 25 C 40% RH" <> 'INFINITE')
                                      AND (Rec."HIC 10%" <> Rec."HIC 10%"::Blue) AND (Rec."HIC 5%" <> Rec."HIC 5%"::Pink) THEN BEGIN
                                        IF (Rec."Baked Hours" <= 0) THEN
                                            ERROR('Please enter baking hours!');
                                        IF (Rec."Baked Hours" <> "Bake Hours") AND ("Bake Hours" <> 0) THEN
                                            ERROR('Baked Hours must equal to Bake hours defined in Item card : %1!', item."Bake Hours");
                                        IF Rec."MBB Packed Date" = 0D THEN
                                            ERROR('Please enter New MBB Packed Date!');
                                    END;
                                END;
                            END;
                        END;
                        // <<Added by Pranavi on 19-05-2017 for MSL process

                        IF Rec."Source Type" = Rec."Source Type"::Calibration THEN BEGIN
                            Calibration.SETRANGE("Equipment No", Rec."Item No.");
                            IF Calibration.FINDFIRST THEN BEGIN
                                Calibration."Current Status" := Calibration."Current Status"::Calibrated;
                                Calibration.Results := Rec.Results;
                                Calibration.Recommendations := Rec.Recommendations;
                                Calibration.Status := Rec."Calibration Status";
                                Calibration."Last Calibration Date" := WORKDATE;
                                IF Calibration."Calibration Party" = Calibration."Calibration Party"::"External Calibration" THEN
                                    Calibration."Calibration Cert No./ IR No" := Rec."No.";
                                Calibration.MODIFY;
                            END;
                            Rec.Status := TRUE;
                            CurrPage.SAVERECORD;
                            MESSAGE(Text001, Rec."No.");
                            CurrPage.UPDATE(TRUE);
                        END ELSE BEGIN   // begin of if source type is not calibration
                            IF Rec."Trans. Order No." <> '' THEN
                                InspectJnlLine.TransferOrderIRPost(Rec)
                            //   UpdateQCCheck(Rec)
                            ELSE BEGIN
                                CancelReservation(Rec);
                                InspectJnlLine.RUN(Rec);
                                UpdateQCCheck(Rec);
                            END;
                            Rec.Status := TRUE;
                            CurrPage.SAVERECORD;
                            Rec.Status := TRUE;
                            CurrPage.SAVERECORD;
                            //***********************Mail Code for Inwards Rejection****************(swarupa)
                            /*

                            nextline:=10;
                            Mail_Body:='';
                            "to mail":='';
                            "total price":=0;
                            "acc amt":=0;
                            "rej amt":=0;
                            IF "Qty. Rejected"<>0 THEN
                            BEGIN
                              Mail_Subject:='ERP- '+'Inward Rejected for Item : '+"Item Description";
                              ITEM_LEAD_TIME:='';
                              ITEM_STOCK:=0;
                              item.SETRANGE(item."No.","Item No.");
                              IF item.FINDFIRST THEN
                              BEGIN
                                ITEM_LEAD_TIME:=FORMAT(item."Safety Lead Time");
                                IF item."Avg Unit Cost"<>0 THEN
                                BEGIN
                                  "total price":=ROUND(item."Avg Unit Cost"*Quantity,1);
                                  "acc amt":=ROUND(item."Avg Unit Cost"*"Qty. Accepted",1);
                                  "rej amt":=ROUND(item."Avg Unit Cost"*"Qty. Rejected",1);
                                END;
                              END ELSE
                              BEGIN
                                PRL.SETRANGE(PRL."Document No.","Receipt No.");
                                PRL.SETRANGE(PRL."No.","Item No.");
                                IF PRL.FINDFIRST THEN
                                BEGIN
                                  "total price":=ROUND(PRL.Quantity*PRL."Unit Cost",1);
                                  "acc amt":=ROUND(PRL."Unit Cost"*"Qty. Accepted",1);
                                  "rej amt":=ROUND(PRL."Unit Cost"*"Qty. Rejected",1);
                                END;
                              END;

                              Mail_Body:='REJECTED ITEM DETAILS :';
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Vendor Name                  : '+"Vendor Name";
                              Mail_Body+=FORMAT(nextline);
                              vend.SETRANGE(vend."No.","Vendor No.");
                              IF vend.FINDFIRST THEN
                              Mail_Body+='Item No.                     : '+"Item No.";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Item Description             : '+"Item Description";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Location Code                : '+"Location Code";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Make                         : '+Make;
                              Mail_Body+=FORMAT(nextline);

                              Mail_Body+='Accepted Quantity            : '+FORMAT("Qty. Accepted");
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Rejected Quantity            : '+FORMAT("Qty. Rejected");
                              Mail_Body+=FORMAT(nextline);
                          //    Mail_Body+='Total Quantity          : '+FORMAT(Quantity);
                          //    Mail_Body+=FORMAT(nextline);
                              ids.SETRANGE(ids."No.","Parent IDS");
                              IF ids.FINDFIRST THEN   BEGIN
                                inwqty:=ids.Quantity;
                                IF Quantity < inwqty THEN BEGIN
                                  Mail_Body+='Total Quantity Checked at QC : '+FORMAT(Quantity);
                                  Mail_Body+=FORMAT(nextline);
                                END
                                ELSE BEGIN
                                  Mail_Body+='Total Quantity               : '+FORMAT(Quantity);
                                  Mail_Body+=FORMAT(nextline);
                                END;
                                Mail_Body+='Inward Quantity              : '+FORMAT(inwqty);
                                Mail_Body+=FORMAT(nextline);
                              END
                              ELSE IF inwqty=0 THEN
                              BEGIN
                                postedids.SETRANGE(postedids."No.","Parent IDS");
                                IF postedids.FINDFIRST THEN
                                BEGIN
                                  inwqty:=postedids.Quantity;
                                  IF Quantity < inwqty THEN BEGIN
                                    Mail_Body+='Total Quantity Checked at QC : '+FORMAT(Quantity);
                                    Mail_Body+=FORMAT(nextline);
                                  END
                                  ELSE BEGIN
                                    Mail_Body+='Total Quantity               : '+FORMAT(Quantity);
                                    Mail_Body+=FORMAT(nextline);
                                  END;
                                  Mail_Body+='Inward Quantity              : '+FORMAT(inwqty);
                                  Mail_Body+=FORMAT(nextline);
                                END;
                              END
                              ELSE BEGIN
                                Mail_Body+='Total Quantity               : '+FORMAT(Quantity);
                                Mail_Body+=FORMAT(nextline);
                                Mail_Body+='Inward Quantity              : '+FORMAT(Quantity);
                                Mail_Body+=FORMAT(nextline);
                              END;
                              accper:=ROUND((("Qty. Accepted"/Quantity)*100),0.01);
                              Mail_Body+='Accepted %                   : '+FORMAT(accper)+'%';
                              Mail_Body+=FORMAT(nextline);
                              rejper:=ROUND((("Qty. Rejected"/Quantity)*100),0.01);
                              Mail_Body+='Rejected %                   : '+FORMAT(rejper)+'%';
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Accepted Quantity price      : '+FORMAT("acc amt");
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Rejected Quantity Price      : '+FORMAT("rej amt");
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Total Quantity Price         : '+FORMAT("total price");
                              Mail_Body+=FORMAT(nextline);
                              IF "Nature Of Rejection"='' THEN
                                ERROR('Please update Nature of Rejection');
                              Mail_Body+='Rejected Category            : '+"Nature Of Rejection";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Reason Description           : '+"Reason Description";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Inward Date                  : '+FORMAT(("IDS creation Date"),0,4);
                              Mail_Body+=FORMAT(nextline);
                              user.SETRANGE(user."User Name",USERID);
                              IF user.FINDFIRST THEN
                                "user name":=user."User Name";
                              Mail_Body+='QC Passed By                 : '+"user name";
                              Mail_Body+=FORMAT(nextline);
                              "Mail-Id".SETRANGE("Mail-Id"."User Name",USERID);
                              IF "Mail-Id".FINDFIRST THEN
                                 "from Mail":="Mail-Id".MailID;
                              "from Mail":='erp@efftronics.com';
                              "to mail"+='purchase@efftronics.com,padmasri@efftronics.com,bharat@efftronics.com,erp@efftronics.com';
                              "to mail"+=',padmaja@efftronics.com';
                              "to mail"+=',qainward@efftronics.com';
                              item.SETRANGE(item."No.","Item No.");
                              IF item.FINDFIRST THEN
                              BEGIN
                                IF item."Item Category Code"='MECH' THEN
                                   "to mail"+=',ubedulla@efftronics.com';
                                IF item."Product Group Code"='B OUT' THEN
                                BEGIN
                                  PH.RESET;
                                  PH.SETFILTER(PH."No.","Order No.");
                                  PH.SETFILTER(PH."Sale Order No",'<>%1','');
                                  IF PH.FINDFIRST THEN
                                   "to mail"+=',pmsubhani@efftronics.com';
                                END;
                              END;
                            //    "to mail":='santhoshk@efftronics.com';
                              PL.SETRANGE(PL."Document No.","Order No.");
                              PL.SETRANGE(PL."No.","Item No.");
                              IF PL.FINDFIRST THEN
                              BEGIN
                                IH.SETRANGE(IH."No.",PL."Indent No.");
                                "Mail-Id".RESET;
                                IF IH.FINDFIRST THEN
                                BEGIN
                                  "Mail-Id".SETRANGE("Mail-Id"."User Name",IH."Person Code");
                                  IF "Mail-Id".FINDFIRST THEN
                                  BEGIN
                                    Mail_Body+='Indented By             : '+"Mail-Id"."User Name";
                                    Mail_Body+=FORMAT(nextline);
                                    "to mail"+=','+"Mail-Id".MailID;
                                  END;
                                 // IF IH."Delivery Location"='R&D STR' THEN
                                 //    "to mail"+=',mary@efftronics.com';
                                 // IF IH."Delivery Location"='CS STR' THEN
                                 //   "to mail"+=',nayomi@efftronics.com';
                                END;
                              END;
                              //Mail_Body+=FORMAT(nextline);
                              PRH.SETRANGE(PRH."No.","Receipt No.");
                              IF PRH.FINDFIRST THEN
                              Mail_Body+='Invoice No.                  : '+PRH."Vendor Order No.";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='DC No.                       : '+PRH."Vendor Shipment No.";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='Batch No                     : '+"Lot No.";
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+=FORMAT(nextline);
                              Mail_Body+='***** Auto Mail Generated from ERP *****';
                            //  MESSAGE("to mail"+'dir@efftronics.com,ceo@efftronics.com');
                              "to mail"+=',Temc@efftronics.com';
                              IF ("rej amt">10000)OR(rejper>10) THEN
                                 "to mail"+=',ceo@efftronics.com';

                              IF ("from Mail"<>'')AND("to mail"<>'') THEN
                              BEGIN
                                SMTP_MAIL.CreateMessage('QC INWARD',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
                                IF ("Location Code"='STR') AND ("Qty. Rejected">0) THEN
                                BEGIN
                                  PROD_ORDER_COMPONENT.RESET;
                                  PROD_ORDER_COMPONENT.SETCURRENTKEY("Production Plan Date",
                                                                     "Item No.",
                                                                     "Prod. Order No.");
                                  PROD_ORDER_COMPONENT.SETFILTER("Production Plan Date",'>%1',TODAY);
                                  PROD_ORDER_COMPONENT.SETRANGE(PROD_ORDER_COMPONENT."Item No.","Item No.");
                                  PROD_ORDER_COMPONENT.CALCSUMS(PROD_ORDER_COMPONENT."Expected Quantity");
                                  IF (PROD_ORDER_COMPONENT."Expected Quantity")>(ITEM_STOCK+"Qty. Accepted")  THEN
                                  BEGIN
                                    QC_SETUP.GET;
                                    QC_SETUP."Rejected IR No.":="No.";
                                    QC_SETUP.MODIFY;
                                    IF IRH.GET("No.") THEN
                                    BEGIN
                                   //ANIL
                                   {  REPORT.RUN(50043,FALSE,FALSE,IRH);
                                      //Rev01 Start
                                      //Code Commented
                                      {
                                      //REPORT.SAVEASHTML(50043,'\\Erpserver\ErpAttachments\QC_REJECTCION.HTML',FALSE,IRH);
                                      }
                                      REPORT.SAVEASPDF(50043,'\\Erpserver\ErpAttachments\QC_REJECTCION.PDF',IRH);
                                      //Rev01 End
                                      SMTP_MAIL.AddAttachment('\\Erpserver\ErpAttachments\QC_REJECTCION.PDF');      }
                                    END;
                                  END;
                                END;
                                IF "Rejection Category" IN [3,4,6] THEN
                                BEGIN
                                  Fname:='\\Erpserver\ErpAttachments\' +"No."+'.JPG';
                                  IF EXISTS(Fname) THEN
                                    SMTP_MAIL.AddAttachment(Fname)
                                  ELSE
                                    ERROR('Please attach Photo');
                                END;
                                SMTP_MAIL.Send;
                              // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                              END;
                            END;          */
                            //old code
                            nextline := 10;
                            // Mail_Body:='';
                            // "to mail":='';
                            "total price" := 0;
                            "acc amt" := 0;
                            "rej amt" := 0;
                            IF Rec."Qty. Rejected" <> 0 THEN BEGIN
                                Mail_Subject := 'ERP- ' + 'Inward Rejected for Item : ' + Rec."Item Description";
                                ITEM_LEAD_TIME := '';
                                ITEM_STOCK := 0;
                                item.SETRANGE(item."No.", Rec."Item No.");
                                IF item.FINDFIRST THEN BEGIN
                                    ITEM_LEAD_TIME := FORMAT(item."Safety Lead Time");
                                    IF item."Avg Unit Cost" <> 0 THEN BEGIN
                                        "total price" := ROUND(item."Avg Unit Cost" * Rec.Quantity, 1);
                                        "acc amt" := ROUND(item."Avg Unit Cost" * Rec."Qty. Accepted", 1);
                                        "rej amt" := ROUND(item."Avg Unit Cost" * Rec."Qty. Rejected", 1);
                                    END;
                                END ELSE BEGIN
                                    PRL.SETRANGE(PRL."Document No.", Rec."Receipt No.");
                                    PRL.SETRANGE(PRL."No.", Rec."Item No.");
                                    IF PRL.FINDFIRST THEN BEGIN
                                        "total price" := ROUND(PRL.Quantity * PRL."Unit Cost", 1);
                                        "acc amt" := ROUND(PRL."Unit Cost" * Rec."Qty. Accepted", 1);
                                        "rej amt" := ROUND(PRL."Unit Cost" * Rec."Qty. Rejected", 1);
                                    END;
                                END;
                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                IF "Mail-Id".FINDFIRST THEN
                                    "from Mail" := "Mail-Id".MailID;
                                /*"from Mail" := 'erp@efftronics.com'; //B2B UPG
                                "to mail" += 'purchase@efftronics.com,padmasri@efftronics.com,bharat@efftronics.com,dineel@efftronics.com,erp@efftronics.com,vijayalakshmib@efftronics.com';
                                "to mail" += ',padmaja@efftronics.com';
                                "to mail" += ',qainward@efftronics.com';
                                "to mail" += ',Temc@efftronics.com';
                                "to mail" += ',store@efftronics.com';
                                "to mail" += ',pardhu@efftronics.com';*/ //B2B UPG

                                /* Recipients.Add('purchase@efftronics.com');
                                  Recipients.Add('padmasri@efftronics.com');
                                  Recipients.Add('bharat@efftronics.com');
                                  Recipients.Add('dineel@efftronics.com');
                                  Recipients.Add('erp@efftronics.com');
                                  Recipients.Add('vijayalakshmib@efftronics.com');
                                  Recipients.Add('padmaja@efftronics.com');
                                  Recipients.Add('qainward@efftronics.com');
                                  Recipients.Add('Temc@efftronics.com');
                                  Recipients.Add('store@efftronics.com');
                                  Recipients.Add('pardhu@efftronics.com');*/
                                Recipients.Add('erp@efftronics.com');

                                item.SETRANGE(item."No.", Rec."Item No.");
                                IF item.FINDFIRST THEN BEGIN
                                    IF item."Item Category Code" = 'MECH' THEN
                                        // "to mail" += ',ubedulla@efftronics.com';
                                        "to mail" += ',erp@efftronics.com';
                                    IF item."Product Group Code Cust" = 'B OUT' THEN BEGIN
                                        PH.RESET;
                                        PH.SETFILTER(PH."No.", Rec."Order No.");
                                        PH.SETFILTER(PH."Sale Order No", '<>%1', '');
                                        IF PH.FINDFIRST THEN
                                            //"to mail" += ',pmsubhani@efftronics.com';//B2B UPG
                                            //Recipients.Add('pmsubhani@efftronics.com');
                                            Recipients.Add('erp@efftronics.com');
                                    END;
                                END;


                                accper := ROUND(((Rec."Qty. Accepted" / Rec.Quantity) * 100), 0.01);
                                rejper := ROUND(((Rec."Qty. Rejected" / Rec.Quantity) * 100), 0.01);
                                IF ("rej amt" > 10000) OR (rejper > 10) THEN
                                    // "to mail" += ',ceo@efftronics.com';//B2B UPG
                                    //Recipients.Add('ceo@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');

                                PL.SETRANGE(PL."Document No.", Rec."Order No.");
                                PL.SETRANGE(PL."No.", Rec."Item No.");
                                IF PL.FINDFIRST THEN BEGIN
                                    IH.SETRANGE(IH."No.", PL."Indent No.");
                                    "Mail-Id".RESET;
                                    IF IH.FINDFIRST THEN BEGIN
                                        "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                                        IF "Mail-Id".FINDFIRST THEN BEGIN
                                            // QCMail.AppendBody('<tr><td><b>Indented By</b></td><td> '+"Mail-Id"."User Name"+'</td></tr>');
                                            IF "Mail-Id".MailID <> '' THEN        //added by pranavi on 23-04-2015 to check user has mail ID
                                                //"to mail" += ',' + "Mail-Id".MailID;
                                                //Recipients.Add("Mail-Id".MailID);
                                                Recipients.Add('erp@efftronics.com');
                                        END;
                                    END;
                                END;


                                //************************************new format of mail*********************************************//
                                //QCMail.CreateMessage('EFF', "from Mail", "to mail", Mail_Subject, Mail_Body, TRUE);
                                Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                                Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6"> REJECTED ITEM DETAILS </font></label>');
                                Body += ('<hr style=solid; color= #3333CC>');
                                Body += ('<h>Dear Sir/Madam,</h><br>');
                                Body += ('<P>REJECTED ITEM DETAILS </P>');
                                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                                Body += ('<tr><td width= "40%"><b>Vendor Name  </b> </td><td>' + Rec."Vendor Name" + '</td></tr> ');
                                Body += ('<tr><td ><b>Item no. </b></td><td>' + Rec."Item No." + '</td></tr> ');
                                Body += ('<tr><td ><b>Item Description </b></td><td>' + Rec."Item Description" + '</td></tr> ');
                                Body += ('<tr><td ><b>Location Code </b></td><td>' + Rec."Location Code" + '</td></tr> ');
                                Body += ('<tr><td><b> Make</b></td><td>' + Rec.Make + '</td></tr>');
                                Body += ('<tr><td><b> Accepted Quantity </b></td><td>' + FORMAT(Rec."Qty. Accepted") + '</td></tr>');
                                Body += ('<tr><td><b> Rejected Quantity  </b></td><td>' + FORMAT(Rec."Qty. Rejected") + '</td></tr>');
                                EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, TRUE);
                                //added by sujani for the Rejection note
                                IRH1.RESET;
                                IRH1.SETFILTER("No.", Rec."No.");
                                IF IRH1.FINDSET THEN BEGIN

                                    FileDirectory := '\\erpserver\ErpAttachments\QC_Rejection_Note\';
                                    //FileName:=IRH."No.");
                                    //filesub:=COPYSTR("No.",5,5);
                                    FileName_rej := 'QC Rejection Note ' + IRH1."No." + '.pdf';
                                    REPORT.RUN(32000006, FALSE, FALSE, IRH1);
                                    REPORT.SAVEASPDF(32000006, FileDirectory + FileName_rej, IRH1);
                                    QC_ATCH := FileDirectory + FileName_rej;
                                    EmailMessage.AddAttachment(QC_ATCH, FileName_rej, '');
                                END;


                                ids.SETRANGE(ids."No.", Rec."Parent IDS");
                                IF ids.FINDFIRST THEN BEGIN
                                    inwqty := ids.Quantity;
                                    IF Rec.Quantity < inwqty THEN BEGIN
                                        Body += ('<tr><td><b>Total Quantity Checked at QC</b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                        //  Mail_Body+=FORMAT(nextline);
                                    END
                                    ELSE BEGIN
                                        Body += ('<tr><td><b>Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                        Mail_Body += FORMAT(nextline);
                                        Body += ('<tr><td><b>Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                                    END;
                                    // Mail_Body+=FORMAT(nextline);
                                END
                                ELSE
                                    IF inwqty = 0 THEN BEGIN
                                        postedids.SETRANGE(postedids."No.", Rec."Parent IDS");
                                        IF postedids.FINDFIRST THEN BEGIN
                                            inwqty := postedids.Quantity;
                                            IF Rec.Quantity < inwqty THEN BEGIN
                                                Body += ('<tr><td><b>Total Quantity Checked at QC</b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                                // Mail_Body+=FORMAT(nextline);
                                            END
                                            ELSE BEGIN
                                                Body += ('<tr><td><b>Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                                // Mail_Body+=FORMAT(nextline);
                                            END;
                                            Body += ('<tr><td><b>Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                                        END;
                                    END
                                    ELSE BEGIN
                                        Body += ('<tr><td><b> Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                                        Body += ('<tr><td><b> Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                                    END;
                                // ADDED BY VISHNU PRIYA ON 17-03-2020
                                PARENT_IDS_QTY := 0;
                                PIDSH.RESET;
                                IF Rec."Parent IDS" <> '' THEN BEGIN
                                    PIDSH.SETFILTER("No.", Rec."Parent IDS");
                                    IF PIDSH.FINDFIRST THEN
                                        PARENT_IDS_QTY := PIDSH."Quantity(Base)"
                                    //ADDED BY VISHNU PRIYA ON 27-08-2020
                                    ELSE BEGIN
                                        ids.RESET;
                                        ids.SETFILTER("No.", Rec."Parent IDS");
                                        IF ids.FINDFIRST THEN
                                            PARENT_IDS_QTY := ids.Quantity;
                                    END;
                                    //ADDED BY VISHNU PRIYA ON 27-08-2020
                                END
                                ELSE
                                    PARENT_IDS_QTY := Rec.Quantity;
                                accper := ROUND(((Rec."Qty. Accepted" / PARENT_IDS_QTY) * 100), 0.01);
                                rejper := ROUND(((Rec."Qty. Rejected" / PARENT_IDS_QTY) * 100), 0.01);
                                // ADDED BY VISHNU PRIYA ON 17-03-2020
                                // accper:=ROUND((("Qty. Accepted"/Quantity)*100),0.01); commented by vishnupriya on 17-03-2020
                                Body += ('<tr><td><b> Accepted % </b></td><td><div style="width:' + FORMAT(accper) + '; background: rgb(128, 177, 133); overflow:visible;">' + FORMAT(accper) + '%</div></td></tr>');
                                // rejper:=ROUND((("Qty. Rejected"/Quantity)*100),0.01); commented by vishnupriya on 17-03-2020
                                Body += ('<tr><td><b> Rejected % </b></td><td>' + FORMAT(rejper) + '%</td></tr>');
                                Body += ('<tr><td><b> Accepted Quantity price  </b></td><td>' + FORMAT("acc amt") + '</td></tr>');
                                Body += ('<tr><td><b> Rejected Quantity Price  </b></td><td>' + FORMAT("rej amt") + '</td></tr>');
                                Body += ('<tr><td><b> Total Quantity Price </b></td><td>' + FORMAT("total price") + '</td></tr>');
                                IF Rec."Nature Of Rejection" = '' THEN
                                    ERROR('Please update Nature of Rejection');
                                Body += ('<tr><td><b> Rejected Category    </b></td><td>' + Rec."Nature Of Rejection" + '</td></tr>');
                                Body += ('<tr><td><b>Reason Description </b></td><td>' + Rec."Reason Description" + '</td></tr>');
                                Body += ('<tr><td><b>Inward Date </b></td><td>' + FORMAT((Rec."IDS creation Date"), 0, 4) + '</td></tr>');
                                PRH.SETRANGE(PRH."No.", Rec."Receipt No.");
                                IF PRH.FINDFIRST THEN
                                    Body += ('<tr><td><b>Invoice No.  </b></td><td> ' + PRH."Vendor Order No." + '</td></tr>');

                                Mail_Body += FORMAT(nextline);
                                Body += ('<tr><td><b>DC No.</b></td><td>  ' + PRH."Vendor Shipment No." + '</td></tr>');
                                Mail_Body += FORMAT(nextline);
                                Body += ('<tr><td><b>Batch No</b></td><td>' + Rec."Lot No." + '</td></tr>');
                                // Mail_Body+='***** Auto Mail Generated from ERP *****';
                                //"to mail" += ',Temc@efftronics.com';
                                //Recipients.Add('Temc@efftronics.com');
                                Recipients.Add('erp@efftronics.com');
                                user.SETRANGE(user."User Name", USERID);
                                IF user.FINDFIRST THEN
                                    "user name" := user."User Name";
                                Body += ('<tr><td><b>QC Passed By    </b></td><td>' + "user name" + '</td></tr>');
                                Body += ('<tr><td><b>Purch Order No. </b></td><td>' + Rec."Order No." + '</td></tr>');

                                PL.SETRANGE(PL."Document No.", Rec."Order No.");
                                PL.SETRANGE(PL."No.", Rec."Item No.");
                                IF PL.FINDFIRST THEN BEGIN
                                    IH.SETRANGE(IH."No.", PL."Indent No.");
                                    "Mail-Id".RESET;
                                    IF IH.FINDFIRST THEN BEGIN
                                        "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                                        IF "Mail-Id".FINDFIRST THEN BEGIN
                                            Body += ('<tr><td><b>Indented By</b></td><td> ' + "Mail-Id"."User ID" + '</td></tr>');
                                            IF "Mail-Id".MailID <> '' THEN
                                                //"to mail" += ',' + "Mail-Id".MailID;
                                                //Recipients.Add("Mail-Id".MailID);
                                                Recipients.Add('erp@efftronics.com');
                                        END;
                                    END;
                                END;
                                Body += ('</table>');
                                Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                                Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');

                                IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                                    //QCMAIL.CreateMessage('QC INWARD',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
                                    IF (Rec."Location Code" = 'STR') AND (Rec."Qty. Rejected" > 0) THEN BEGIN
                                        PROD_ORDER_COMPONENT.RESET;
                                        PROD_ORDER_COMPONENT.SETCURRENTKEY("Production Plan Date",
                                                                           "Item No.",
                                                                           "Prod. Order No.");
                                        PROD_ORDER_COMPONENT.SETFILTER("Production Plan Date", '>%1', TODAY);
                                        PROD_ORDER_COMPONENT.SETRANGE(PROD_ORDER_COMPONENT."Item No.", Rec."Item No.");
                                        PROD_ORDER_COMPONENT.CALCSUMS(PROD_ORDER_COMPONENT."Expected Quantity");
                                        IF (PROD_ORDER_COMPONENT."Expected Quantity") > (ITEM_STOCK + Rec."Qty. Accepted") THEN BEGIN
                                            QC_SETUP.GET;
                                            QC_SETUP."Rejected IR No." := Rec."No.";
                                            QC_SETUP.MODIFY;
                                            IF IRH.GET(Rec."No.") THEN BEGIN
                                            END;
                                        END;
                                    END;
                                    IF Rec."Rejection Category" IN [3, 4, 6] THEN BEGIN
                                        Fname := '\\Erpserver\ErpAttachments\' + Rec."No." + '.JPG';
                                        TempFileName := '';//EFFUPG
                                        IF EXISTS(Fname) THEN
                                            // EmailMessage.Attachment(Fname, '', '')//EFFUPG
                                            EmailMessage.AddAttachment(Fname, TempFileName, '')

                                        ELSE
                                            ERROR('Please attach Photo');
                                    END;


                                    // To_Mail := "to mail"
                                    // QCMail.Send;
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                    //  mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                END;
                                CreateIndent;   // Added by Pranavi on 20-Aug-2016 for Auto Indent Creation for Rejected Qty
                            END;  // END OF Qty.Rejected <> 0

                            // mails for Qty Under Deviation added by vishnu on 30-03-2019

                            IF (Rec."Qty. Accepted Under Deviation" > 0) THEN
                                //UnderDeviationMails;


                                //Mail For Accepted Item

                                IF (Rec.Quantity = Rec."Qty. Accepted") THEN BEGIN   // QTY = QTY ACCPTED BEGIN
                                                                                     /*//***********new mail format *********** added by ahmed
                                                                                     Mail_Body+=FORMAT(nextline);
                                                                                     "Mail-Id".SETRANGE("Mail-Id"."User Name",USERID);
                                                                                     IF "Mail-Id".FINDFIRST THEN
                                                                                         "from Mail":="Mail-Id".MailID;
                                                                                          Mail_Subject:="Item Description"+' Item QC Passed';
                                                                                          QCMail.CreateMessage('QC INWARD',"from Mail","to mail",Mail_Subject,Mail_Body,FALSE);
                                                                                          QCMail.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                                                                                          QCMail.AppendBody('<tr><td width= "40%"><b>Vendor Name  </b> </td><td>'+"Vendor Name"+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Item no. </b></td><td>'+"Item No."+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Item Description </b></td><td>'+"Item Description"+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Location Code </b></td><td>'+"Location Code"+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Accepted Quantity </b></td><td>'+FORMAT("Qty. Accepted")+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Inward Date  </b></td><td>'+FORMAT(("IDS creation Date"),0,4)+'</td></tr> ');
                                                                                          QCMail.AppendBody('<tr><td ><b>Item Lead Time  </b></td><td></table>'+FORMAT(("IDS creation Date"),0,4)+'</td></tr></table><br><br>');
                                                                                          QCMail.AppendBody('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                                                                                          QCMail.AppendBody('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                                                                                     */
                                    Mail_Body := '';
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Vendor Name             : ' + Rec."Vendor Name";
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Item Description        : ' + Rec."Item Description";
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Location Code           : ' + Rec."Location Code";
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Accepted Quantity       : ' + FORMAT(Rec."Qty. Accepted");
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Inward Date             : ' + FORMAT((Rec."IDS creation Date"), 0, 4);
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += 'Item Lead Time          : ' + FORMAT((Rec."IDS creation Date"), 0, 4);

                                    Mail_Body += FORMAT(nextline);
                                    "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                    IF "Mail-Id".FINDFIRST THEN
                                        "from Mail" := "Mail-Id".MailID;
                                    Mail_Subject := Rec."Item Description" + ' Item QC Passed';
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += FORMAT(nextline);
                                    Mail_Body += '***** Auto Mail Generated from ERP *****';
                                    // "to mail":=',padmaja@efftronics.com';
                                    //Recipients.Add('padmaja@efftronics.com');
                                    Recipients.Add('erp@efftronics.com');
                                    IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                                        //  SMTP_MAIL.CreateMessage('QC INWARD', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                        EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                                        // SMTP_MAIL.Send;   anil assigned

                                        // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');  //cometed by anil
                                    END;

                                    // Mail For QC Passing For R&D Items
                                    IF (Rec."Location Code" = 'STR') THEN // commented by vijaya on 28-07-2018 for all memebers to provide status of the requested Item
                                    BEGIN   // LOCAION CODE R&D STR BEING
                                        "from Mail" := '';
                                        "to mail" := '';
                                        Mail_Subject := '';
                                        Mail_Body := '';

                                        PRL.RESET;
                                        PRL.SETRANGE(PRL."Document No.", Rec."Receipt No.");
                                        PRL.SETRANGE(PRL."Line No.", Rec."Purch Line No");
                                        IF PRL.FINDFIRST THEN BEGIN     // PRL BEIGN
                                            IH.RESET;
                                            IH.SETRANGE(IH."No.", PRL."Indent No.");
                                            IF IH.FINDFIRST THEN BEGIN     // IH BEGIN
                                                Mail_Subject := 'ERP- YOUR INDENTED ITEM (' + FORMAT(Rec."Item Description") + ') HAS BEEN QC PASSED';
                                                //Mail_Subject:='YOUR INDENTED ITEM  HAS BEEN QC PASSED ';
                                                //Mail_Subject:='YOUR INDENTED ITEM ('+FORMAT("Item Description")+') FOR "'+FORMAT(IH."Production Order Description") +'" HAS BEEN QC PASSED ';
                                                nextline := 10;
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += FORMAT(nextline);

                                                Mail_Body += 'QC PASSED DATE & TIME   : ' + FORMAT((TODAY), 0, 4) + FORMAT(TIME);
                                                Mail_Body += FORMAT(nextline);

                                                Mail_Body += 'Indent No.              : ' + IH."No.";
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += 'Purchase Order No.      : ' + Rec."Order No.";
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += 'Vendor Name             : ' + Rec."Vendor Name";
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += 'Inwarded Quantity       : ' + FORMAT(PRL.Quantity);
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += 'Inward Date             : ' + FORMAT((Rec."IDS creation Date"), 0, 4);
                                                Mail_Body += FORMAT(nextline);

                                                Mail_Body += 'Inspected Quantity      : ' + FORMAT(Rec.Quantity);
                                                Mail_Body += FORMAT(nextline);
                                                Mail_Body += 'Accepted Quantity       : ' + FORMAT(Rec."Qty. Accepted");
                                                Mail_Body += FORMAT(nextline);
                                                IF Rec."Qty. Rejected" > 0 THEN BEGIN
                                                    Mail_Body += 'Rejected Quantity       : ' + FORMAT(Rec."Qty. Rejected");
                                                    Mail_Body += FORMAT(nextline);
                                                    Mail_Body += 'Nature Of Rejection     : ' + FORMAT(Rec."Nature Of Rejection");
                                                    Mail_Body += FORMAT(nextline);
                                                    Mail_Body += 'Rejection Reason        : ' + FORMAT(Rec."Reason Description");
                                                    Mail_Body += FORMAT(nextline);
                                                END;

                                                IF Rec."Qty. Rework" > 0 THEN BEGIN
                                                    Mail_Body += 'Rework Quantity       : ' + FORMAT(Rec."Qty. Rework");
                                                    Mail_Body += FORMAT(nextline);
                                                END;

                                                "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
                                                IF "Mail-Id".FINDFIRST THEN
                                                    // "from Mail" := "Mail-Id".MailID;
                                                    //  "from Mail" := 'erp@efftronics.com';
                                                    Mail_Body += 'Inspeceted By           : ' + FORMAT("Mail-Id"."User ID");
                                                Mail_Body += FORMAT(nextline);

                                                "Mail-Id".RESET;
                                                "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                                                IF "Mail-Id".FINDFIRST THEN BEGIN
                                                    //"to mail" := "Mail-Id".MailID;
                                                    // Recipients.Add("Mail-Id".MailID);
                                                    Recipients.Add('erp@efftronics.com');
                                                    /*  IF (STRLEN( "to mail") > 0)THEN
                                                        "to mail"+=',anilkumar@efftronics.com'
                                                      ELSE
                                                         "to mail"+='anilkumar@efftronics.com';
                                                    */
                                                END;
                                                // ELSE
                                                // "to mail"+='anilkumar@efftronics.com';

                                                Mail_Body += '***** Auto Mail Generated from ERP *****';
                                                IF ("from Mail" <> '') AND ("to mail" <> '') THEN BEGIN
                                                    //SMTP_MAIL.CreateMessage('QC INWARD', "from Mail", "to mail", Mail_Subject, Mail_Body, FALSE);
                                                    EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, FALSE);
                                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
                                                    // mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');
                                                END;
                                            END;  // IH END
                                        END;  // PRL END
                                    END;  // LOCAION CODE R&D STR END
                                END;  // QTY = QTY ACCPTED END

                            IF Rec.Flag = TRUE THEN BEGIN
                                //"from Mail" := 'ERP@efftronics.com';
                                // "to mail" := 'Purchase@efftronics.com,Padmaja@Efftronics.com,erp@efftronics.com,temc@efftronics.com,jhansi@efftronics.com,';
                                /* Recipients.Add('Purchase@efftronics.com');
                                 Recipients.Add('Padmaja@Efftronics.com');
                                 Recipients.Add('erp@efftronics.com');
                                 Recipients.Add('temc@efftronics.com');
                                 Recipients.Add('jhansi@efftronics.com');
                                 Recipients.Add('bharat@efftronics.com');
                                 Recipients.Add('dineel@efftronics.com');
                                 Recipients.Add('vijayalakshmib@efftronics.com');*/
                                Recipients.Add('erp@efftronics.com');

                                Mail_Subject := ' QC Blocked Item ' + Rec."Item Description";
                                Mail_Body := '***** Auto Mail Generated from ERP *****';
                                Attach.RESET;
                                Attach.SETFILTER(Attach."Document No.", Rec."No.");
                                Attach.SETFILTER(Attach.Description, 'FLAG');
                                Attach.SETFILTER(Attach."Attachment Status", '%1', TRUE);
                                IF Attach.FINDFIRST THEN BEGIN
                                    Fname := '\\erpserver\ErpAttachments\' + FORMAT(Attach."No.") + '.' + Attach."File Extension";
                                    Attach.ExportAttachment(Fname);
                                    Attachment1 := Fname;
                                    TempFileName := '';//EFFUPG
                                    //SMTP_MAIL.CreateMessage('ERP', "from Mail", "to mail", Mail_Subject, Mail_Body, TRUE);
                                    EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, TRUE);
                                    EmailMessage.AddAttachment(Attachment1, TempFileName, '');//EFFUPG
                                                                                              // SMTP_MAIL.Send;
                                    Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

                                END
                                ELSE
                                    ERROR('There is no Attachment to Flag');
                            END;

                            MESSAGE(Text001, Rec."No.");
                            CurrPage.UPDATE(TRUE);

                            // >>Added by Pranavi on 19-05-2017 for MSL process
                            IF item.GET(Rec."Item No.") THEN BEGIN
                                IF (item.MSL <> 0) THEN BEGIN
                                    IF Rec."Qty. Accepted" <> 0 THEN BEGIN
                                        ItemLedgEntry.RESET;
                                        ItemLedgEntry.SETCURRENTKEY("Item No.", "Entry Type");
                                        ItemLedgEntry.SETRANGE("Item No.", Rec."Item No.");
                                        ItemLedgEntry.SETRANGE("Entry Type", ItemLedgEntry."Entry Type"::Purchase);
                                        ItemLedgEntry.SETRANGE("Document Type", ItemLedgEntry."Document Type"::"Purchase Receipt");
                                        ItemLedgEntry.SETRANGE("Lot No.", Rec."Lot No.");
                                        IF ItemLedgEntry.FINDFIRST THEN BEGIN
                                            ItemLedgEntry."MFD Date" := Rec."MFD Date";
                                            ItemLedgEntry."MBB Packed Date" := Rec."Packed Date";
                                            ItemLedgEntry."MBB Packet Open DateTime" := Rec."MBB Packet Open DateTime";
                                            ItemLedgEntry."MBB Packet Close DateTime" := Rec."MBB Packet Close DateTime";
                                            //EFFUPG>>
                                            /*
                                            IF (DateAndTimeCUst.DateDiff('N', Rec."MBB Packet Open DateTime", Rec."MBB Packet Close DateTime", DayofWeekInput, WeekofYearInput)) > 15 THEN BEGIN
                                                ItemLedgEntry."Floor Life" += ROUND((DateAndTimeCust.DateDiff('N', Rec."MBB Packet Open DateTime", Rec."MBB Packet Close DateTime", DayofWeekInput, WeekofYearInput)) / 60, 0.01);
                                            END;
                                            */
                                            V1 := Rec."MBB Packet Open DateTime";
                                            V2 := Rec."MBB Packet Close DateTime";
                                            D1 := V1;
                                            D2 := V2;

                                            IF (DateAndTimeCUst.DateDiff('N', D1, D2, DayofWeekInput, WeekofYearInput)) > 15 THEN BEGIN
                                                ItemLedgEntry."Floor Life" += ROUND((DateAndTimeCust.DateDiff('N', D1, D2, DayofWeekInput, WeekofYearInput)) / 60, 0.01);
                                            END;

                                            //EFFUPG<<
                                            IF (item.MSL IN [item.MSL::"1", item.MSL::"2"]) AND (Rec."HIC 60%" <> Rec."HIC 60%"::Blue) AND NOT (item."Floor Life at 25 C 40% RH" IN ['INFINITE', '']) THEN BEGIN
                                                ItemLedgEntry."Recharge Cycles" += 1;
                                                ItemLedgEntry."Floor Life" := 0;
                                                ItemLedgEntry."MBB Packed Date" := Rec."MBB Packed Date";
                                            END;
                                            IF (item.MSL IN [item.MSL::"2A", item.MSL::"3", item.MSL::"4", item.MSL::"5", item.MSL::"5A"]) AND NOT (item."Floor Life at 25 C 40% RH" IN ['INFINITE', ''])
                                              AND (Rec."HIC 10%" <> Rec."HIC 10%"::Blue) AND (Rec."HIC 5%" <> Rec."HIC 5%"::Pink) THEN BEGIN
                                                ItemLedgEntry."Recharge Cycles" += 1;
                                                ItemLedgEntry."Floor Life" := 0;
                                                ItemLedgEntry."MBB Packed Date" := Rec."MBB Packed Date";
                                            END;
                                            ItemLedgEntry.MODIFY;
                                        END;
                                    END;
                                END;
                            END;
                            // >>Added by Pranavi on 19-05-2017 for MSL process
                        END;  // end of if source type is not calibration

                    end;
                }
                action(Tranfer_to_callibration)
                {
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Trasfer_To_calibration_module();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        //B2B to get the value of Undefined Qty.
        UndefinedQty := Rec.Quantity;
        //B2B

        //>>Added by Pranavi on 17-05-2017 for MSL Process
        IF item.GET(Rec."Item No.") THEN BEGIN
            MSL := item.MSL;
            "ESD Class" := item."ESD Class";
            "Floor Life at 25 C 40% RH" := item."Floor Life at 25 C 40% RH";
            "Bake Hours" := item."Bake Hours";
            "Component Shelf Life(Years)" := item."Component Shelf Life(Years)";
        END;
        //<<Added by Pranavi on 17-05-2017 for MSL Process
    end;

    trigger OnInit();
    begin
        ReworkTimeInMinutesEditable := TRUE;
    end;

    trigger OnOpenPage();
    begin

        Visible_Bool := TRUE;

        IF USERID IN ['EFFTRONICS\VISHNNUPRIYA', 'EFFTRONICS\B2BOTS'] THEN
            editfields := TRUE;
    end;

    var
        DateAndTimeCUst: DotNet DateAndTimeD;
        DayofWeekInput: DotNet DayofWeekInputD;
        WeekofYearInput: DotNet WeekofYearInputD;
        V1: Variant;
        V2: Variant;
        D1: DotNet DateAndTime;
        D2: DotNet DateAndTime;


        Text001: Label 'Inspection receipt %1 posted successfully.';
        Body: Text;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: list of [Text];
        InspectJnlLine: Codeunit "Inspection Jnl.-Post Line";
        QualityType: Option Accepted,"Accepted Under Deviation",Rework,Rejected;
        UndefinedQty: Decimal;
        Attachment: Record Attachments;
        ItemLedgEntry: Record "Item Ledger Entry";
        Calibration: Record Calibration;
        "Mail-Id": Record "User Setup";
        "from Mail": Text[150];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1024];
        mail: Codeunit Mail;
        nextline: Char;
        rejper: Decimal;
        accper: Decimal;
        PL: Record "Purchase Line";
        IH: Record "Indent Header";
        PRL: Record "Purch. Rcpt. Line";
        "total price": Decimal;
        item: Record Item;
        "acc amt": Decimal;
        "rej amt": Decimal;
        user: Record User;
        "user name": Text[50];
        inwqty: Decimal;
        ids: Record "Inspection Datasheet Header";
        InspectionReceiptline: Record "Inspection Receipt Line";
        vend: Record Vendor;
        postedids: Record "Posted Inspect DatasheetHeader";
        PRH: Record "Purch. Rcpt. Header";
        SMTP_MAIL: Codeunit "Custom Events";
        ITEM_LEAD_TIME: Code[10];
        PROD_ORDER_COMPONENT: Record "Prod. Order Component";
        IRH: Record "Inspection Receipt Header";
        QC_SETUP: Record "Quality Control Setup";
        ITEM_STOCK: Decimal;
        Rejection: Record "QC Rejection Master";
        Fname: Text[250];
        Attach: Record Attachments;
        Attachment1: Text[1000];

        ReworkTimeInMinutesEditable: Boolean;
        PH: Record "Purchase Header";
        // QCMail: Codeunit "SMTP Mail";
        "---EFFUPG---": Integer;
        TempFileName: Text;
        MSL: Option " ","1","2","2A","3","4","5","5A","6";
        "ESD Class": Option " ","0","1A","1B","1C","2","3A","3B";
        "Floor Life at 25 C 40% RH": Code[15];
        "Bake Hours": Decimal;
        "Component Shelf Life(Years)": Decimal;
        "MBB Shelf Life": Decimal;
        Visible_Bool: Boolean;
        //  DateAndTime : DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        //                  DayofWeekInput : DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        //                WeekofYearInput : DotNet "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        TEMCMail: Page "Material Requests";
        REASON: Record "Reason Code";
        FileDirectory: Text[100];
        FileName_rej: Text[100];
        QC_ATCH: Text;
        attachments: Record Attachments;
        IRH1: Record "Inspection Receipt Header";
        QCSetup: Record "Quality Control Setup";
        NoSeriesMgt: Codeunit 396;
        Transfer_to_calibration: Boolean;
        editfields: Boolean;
        PIDSH: Record "Posted Inspect DatasheetHeader";
        PARENT_IDS_QTY: Decimal;


    procedure CalculateUndefinedQty();
    begin
        UndefinedQty := Rec.Quantity - Rec."Qty. Accepted" - Rec."Qty. Rejected" - Rec."Qty. Rework" - Rec."Qty. Accepted Under Deviation";
    end;


    procedure CancelReservation(var InspectionReceipt: Record "Inspection Receipt Header");
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ReservEngineMgt: Codeunit 99000831;
    begin
        ReservationEntry.SETRANGE("Item No.", InspectionReceipt."Item No."); //300708
        ReservationEntry.SETRANGE("Source Ref. No.", InspectionReceipt."Item Ledger Entry No.");
        IF ReservationEntry.FINDFIRST THEN BEGIN
            ReservationEntry2.SETRANGE("Entry No.", ReservationEntry."Entry No.");
            IF ReservationEntry2.FINDSET THEN
                REPEAT
                    ReservationEntry2.TESTFIELD("Reservation Status", ReservationEntry2."Reservation Status"::Reservation);
                    // ReservEngineMgt.CloseReservEntry2(ReservationEntry2,TRUE,FALSE);
                    // commented for navision upgradation
                    COMMIT;
                UNTIL ReservationEntry2.NEXT = 0;
        END;
    end;


    procedure UpdateQCCheck(InspecRcpt: Record "Inspection Receipt Header");
    begin
        IF InspecRcpt."Item Ledger Entry No." <> 0 THEN BEGIN
            IF InspecRcpt."Rework Level" <> 0 THEN BEGIN
                ItemLedgEntry.GET(InspecRcpt."DC Inbound Ledger Entry.");
                IF ItemLedgEntry."Remaining Quantity" = 0 THEN BEGIN
                    ItemLedgEntry."QC Check" := FALSE;
                    ItemLedgEntry.MODIFY;
                END;
            END ELSE BEGIN
                ItemLedgEntry.GET(InspecRcpt."Item Ledger Entry No.");
                IF ItemLedgEntry."Remaining Quantity" = 0 THEN BEGIN
                    ItemLedgEntry."QC Check" := FALSE;
                    ItemLedgEntry.MODIFY;
                END;
            END;
        END;
    end;


    local procedure ReworkTimeInMinutesOnBeforeInp();
    begin
        IF Rec."Rework Reference No." = '' THEN
            ReworkTimeInMinutesEditable := FALSE
        ELSE
            ReworkTimeInMinutesEditable := TRUE;
    end;


    procedure CreateIndent();
    var
        Indent_No: Code[20];
        "Indent Header": Record "Indent Header";
        "Indent Line": Record "Indent Line";
        Prev_Indent: Code[20];
        Prev_Indent_Series: Code[20];
        "No. Series": Record "No. Series";
        "No. Series Line": Record "No. Series Line";
        NoSeriesMgt: Codeunit 396;
        Line_No: Integer;
        User: Record User;
        UserName: Code[100];
        DimVal: Record "Dimension Value";
        PRL: Record "Purch. Rcpt. Line";
        IndntHdr: Record "Indent Header";
    begin
        // Added by Pranavi on 20-Aug-2016 auto indent creation for rejected qty

        Indent_No := '';
        UserName := '';

        User.RESET;
        User.SETRANGE(User."User Name", USERID);
        IF User.FINDFIRST THEN
            UserName := User."Full Name";

        // Indent Header Creating
        "Indent Header".RESET;
        "Indent Header".INIT;
        NoSeriesMgt.InitSeries('P-INDENT', 'P-INDENT', TODAY,
                                                      Indent_No, "Indent Header"."No. Series");
        "Indent Header"."No." := Indent_No;
        "Indent Header".Description := 'Created From QC Inward Item Rejection';

        PRL.RESET;
        PRL.SETRANGE(PRL."Document No.", Rec."Receipt No.");
        PRL.SETRANGE(PRL."No.", Rec."Item No.");
        IF PRL.FINDFIRST THEN BEGIN
            "Indent Header"."Delivery Location" := PRL."Location Code";
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'DEPARTMENTS');
            DimVal.SETRANGE(DimVal.Code, PRL."Shortcut Dimension 1 Code");
            IF DimVal.FINDFIRST THEN
                "Indent Header".Department := DimVal.Name
            ELSE
                "Indent Header".Department := 'PROD';
            IndntHdr.RESET;
            IndntHdr.SETRANGE(IndntHdr."No.", PRL."Indent No.");
            IF IndntHdr.FINDFIRST THEN BEGIN
                "Indent Header"."Indent Reference" := IndntHdr."Indent Reference";
                "Indent Header"."Person Code" := IndntHdr."Person Code";
                "Indent Header"."Contact Person" := IndntHdr."Contact Person";
            END ELSE BEGIN
                "Indent Header"."Contact Person" := UserName;
                "Indent Header"."Indent Reference" := UserName;
                "Indent Header"."Person Code" := USERID;
            END;
        END
        ELSE BEGIN
            "Indent Header"."Delivery Location" := 'STR';
            "Indent Header".Department := 'PROD';
            "Indent Header"."Contact Person" := UserName;
            "Indent Header"."Indent Reference" := UserName;
            "Indent Header"."Person Code" := USERID;
        END;
        "Indent Header"."Delivery Place" := "Indent Header"."Delivery Place"::Store;
        "Indent Header"."User Id" := USERID;
        "Indent Header"."ICN No." := ICNNO(TODAY);
        "Indent Header"."Creation Date" := TODAY;
        "Indent Header".VALIDATE("Indent Header"."Production Order No.", Rec."Prod. Order No.");
        "Indent Header"."IR Number" := Rec."No.";
        "Indent Header".INSERT;

        // Indent Line Creating
        Line_No := 0;
        "Indent Line".INIT;
        "Indent Line"."Document No." := Indent_No;
        Line_No := Line_No + 10000;
        "Indent Line"."Line No." := Line_No;
        "Indent Line"."No." := Rec."Item No.";
        "Indent Line".VALIDATE("Indent Line"."No.", Rec."Item No.");
        "Indent Line"."ICN No." := ICNNO(TODAY);
        "Indent Line".Description := Rec."Item Description";
        "Indent Line".Quantity := Rec."Qty. Rejected";
        "Indent Line".INSERT;

        "Indent Header".ReleaseIndent1("Indent Header"."No.");    // Release indent

        // Updating No.Series
        "No. Series Line".RESET;
        //"No. Series Line".SETRANGE("No. Series Line"."Series Code",'P-INDENT');
        "No. Series Line".SETRANGE("No. Series Line"."Series Code", 'P-IND1112');
        "No. Series Line".SETRANGE("No. Series Line".Open, TRUE);
        IF "No. Series Line".FINDFIRST THEN BEGIN
            "No. Series Line"."Last No. Used" := Indent_No;
            "No. Series Line"."Last Date Used" := TODAY;
            "No. Series Line".MODIFY;
        END;

        MESSAGE('INDENT CREATED FOR THE ITEM: ' + Rec."Item Description" + '\INDENT NO.: ' + Indent_No);
        "Indent Header".RESET;
        // End by pranavi
    end;


    procedure ICNNO(DT: Date) ICN: Code[10];
    var
        Dat: Code[10];
        Mon: Code[10];
        Yer: Code[10];
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

    local procedure "Rejection Note"();
    begin
    end;


    local procedure Trasfer_To_calibration_module();
    begin
        IF Rec."Equp Model" = '' THEN
            ERROR('Enter the Equipment Serial No Under Calibration tab');
        IF Rec."Eqpt. Serial No." = '' THEN
            ERROR('Enter the Equipment Serial No Under Calibration tab');
        IF Rec."Equp Desc" = '' THEN
            ERROR('Enter the Equipment Description Under Calibration tab');
        IF (FORMAT(Rec."Calibration frequency") = '') THEN
            ERROR('Enter the Freuency of Callibration Under Calibration tab');

        Calibration.RESET;
        Calibration.SETFILTER("IR No", Rec."No.");
        IF Calibration.FINDSET THEN
            ERROR('This Item has alredy there in calibration with Calibration id ' + Calibration."Equipment No")
        ELSE BEGIN
            QCSetup.GET;
            QCSetup.TESTFIELD(QCSetup."Equipment No.");
            NoSeriesMgt.InitSeries(QCSetup."Equipment No.", Calibration."No. Series", 0D, Calibration."Equipment No", Calibration."No. Series");
            Calibration."Eqpt. Serial No." := Rec."Eqpt. Serial No.";
            Calibration.Description := Rec."Equp Desc";
            Calibration.Manufacturer := Rec.Make;
            Calibration."Model No." := Rec."Equp Model";
            Calibration."Equipment Type" := Rec."Equp Type";
            Calibration."Calibration Party" := Rec."Calibration Party";
            Calibration."IR No" := Rec."No.";
            Calibration."Item No" := Rec."Item No.";
            Calibration."Item Desc" := Rec."Item Description";
            Calibration."Created By" := USERID;
            Calibration."Created Date" := TODAY;
            Calibration.Transfered_from := Calibration.Transfered_from::IR;
            Calibration."MFG. Serial No." := Rec."Lot No.";
            Calibration."Last Calibration Date" := Rec."Calibration Date";
            Calibration."Next Calibration Due On" := Rec."Next calib date";
            Calibration."Calibration Period" := Rec."Calibration frequency";
            PRL.RESET;
            PRL.SETFILTER("Document No.", Rec."Receipt No.");
            PRL.SETFILTER("Order Line No.", FORMAT(Rec."Purch Line No"));
            PRL.SETFILTER("No.", Rec."Item No.");
            IF PRL.FINDSET THEN BEGIN
                PRH.RESET;
                PRH.SETFILTER("No.", PRL."Document No.");
                IF PRH.FINDSET THEN BEGIN
                    Calibration."Purchase Date" := PRH."Posting Date";
                    Calibration."Unit cost(LCY)" := PRL."Unit Cost (LCY)";
                END;
            END;
            Calibration.INSERT;
            COMMIT;

            MESSAGE('Transfered for Calibration with Calibration ID' + Calibration."Equipment No");
        END;
    end;


    local procedure UnderDeviationMails();
    begin
        "total price" := 0;
        "acc amt" := 0;
        "rej amt" := 0;

        IF Rec."Qty. Accepted Under Deviation" <> 0 THEN BEGIN
            Mail_Subject := 'Inward - QA Accepted Under Deviation, Item: ' + Rec."Item Description";
            ITEM_LEAD_TIME := '';
            ITEM_STOCK := 0;
            item.SETRANGE(item."No.", Rec."Item No.");
            IF item.FINDFIRST THEN BEGIN
                ITEM_LEAD_TIME := FORMAT(item."Safety Lead Time");
                IF item."Avg Unit Cost" <> 0 THEN BEGIN
                    "total price" := ROUND(item."Avg Unit Cost" * Rec.Quantity, 1);
                    "acc amt" := ROUND(item."Avg Unit Cost" * Rec."Qty. Accepted", 1);
                    "rej amt" := ROUND(item."Avg Unit Cost" * Rec."Qty. Accepted Under Deviation", 1);
                END;
            END ELSE BEGIN
                PRL.SETRANGE(PRL."Document No.", Rec."Receipt No.");
                PRL.SETRANGE(PRL."No.", Rec."Item No.");
                IF PRL.FINDFIRST THEN BEGIN
                    "total price" := ROUND(PRL.Quantity * PRL."Unit Cost", 1);
                    "acc amt" := ROUND(PRL."Unit Cost" * Rec."Qty. Accepted", 1);
                    "rej amt" := ROUND(PRL."Unit Cost" * Rec."Qty. Accepted Under Deviation", 1);
                END;
            END;
            "Mail-Id".SETRANGE("Mail-Id"."User ID", USERID);
            IF "Mail-Id".FINDFIRST THEN
                /*  "from Mail" := "Mail-Id".MailID;
             "from Mail" := 'erp@efftronics.com';
             "to mail" += 'purchase@efftronics.com,padmasri@efftronics.com,bharat@efftronics.com,dineel@efftronics.com,erp@efftronics.com,vijayalakshmib@efftronics.com';
             "to mail" += ',padmaja@efftronics.com';
             "to mail" += ',qainward@efftronics.com';
             "to mail" += ',Temc@efftronics.com';
             "to mail" += ',store@efftronics.com';
             "to mail" += ',pardhu@efftronics.com'; */ //B2B UPG

                /*Recipients.Add('Purchase@efftronics.com');
            Recipients.Add('Padmaja@Efftronics.com');
            Recipients.Add('erp@efftronics.com');
            Recipients.Add('temc@efftronics.com');
            Recipients.Add('jhansi@efftronics.com');
            Recipients.Add('bharat@efftronics.com');
            Recipients.Add('dineel@efftronics.com');
            Recipients.Add('vijayalakshmib@efftronics.com');
            Recipients.Add('padmasri@efftronics.com');
            Recipients.Add('qainward@efftronics.com');
            Recipients.Add('Temc@efftronics.com');
            Recipients.Add('store@efftronics.com');*/
            Recipients.Add('erp@efftronics.com');

            item.SETRANGE(item."No.", Rec."Item No.");
            IF item.FINDFIRST THEN BEGIN
                IF item."Item Category Code" = 'MECH' THEN
                    //"to mail" += ',ubedulla@efftronics.com';
                    //Recipients.Add('ubedulla@efftronics.com');
                    Recipients.Add('erp@efftronics.com');
                IF item."Product Group Code Cust" = 'B OUT' THEN BEGIN
                    PH.RESET;
                    PH.SETFILTER(PH."No.", Rec."Order No.");
                    PH.SETFILTER(PH."Sale Order No", '<>%1', '');
                    IF PH.FINDFIRST THEN
                        // "to mail" += ',pmsubhani@efftronics.com';
                        //Recipients.Add('pmsubhani@efftronics.com');
                        Recipients.Add('erp@efftronics.com');
                END;
            END;
            accper := ROUND(((Rec."Qty. Accepted" / Rec.Quantity) * 100), 0.01);
            rejper := ROUND(((Rec."Qty. Accepted Under Deviation" / Rec.Quantity) * 100), 0.01);
            IF ("rej amt" > 10000) OR (rejper > 10) THEN
                //"to mail" += ',ceo@efftronics.com';
                //Recipients.Add('ceo@efftronics.com');
                Recipients.Add('erp@efftronics.com');

            PL.SETRANGE(PL."Document No.", Rec."Order No.");
            PL.SETRANGE(PL."No.", Rec."Item No.");
            IF PL.FINDFIRST THEN BEGIN
                IH.SETRANGE(IH."No.", PL."Indent No.");
                "Mail-Id".RESET;
                IF IH.FINDFIRST THEN BEGIN
                    "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                    IF "Mail-Id".FINDFIRST THEN BEGIN
                        // QCMail.AppendBody('<tr><td><b>Indented By</b></td><td> '+"Mail-Id"."User Name"+'</td></tr>');
                        IF "Mail-Id".MailID <> '' THEN        //added by pranavi on 23-04-2015 to check user has mail ID
                                                              //"to mail" += ',' + "Mail-Id".MailID;
                                                              //Recipients.Add("Mail-Id".MailID);
                            Recipients.Add('erp@efftronics.com');
                    END;
                END;
            END;


            //************************************new format of mail*********************************************//
            // QCMail.CreateMessage('EFF', 'erp@efftronics.com', "to mail", Mail_Subject, Mail_Body, TRUE);
            Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
            Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;"><label><font size="6"> Under Deviation Accepted ITEM DETAILS </font></label>');
            Body += ('<hr style=solid; color= #3333CC>');
            Body += ('<h>Dear Sir/Madam,</h><br>');
            Body += ('<P>Under deviation Accepted ITEM DETAILS </P>');
            Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
            Body += ('<tr><td width= "40%"><b>Vendor Name  </b> </td><td>' + Rec."Vendor Name" + '</td></tr> ');
            Body += ('<tr><td ><b>Item no. </b></td><td>' + Rec."Item No." + '</td></tr> ');
            Body += ('<tr><td ><b>Item Description </b></td><td>' + Rec."Item Description" + '</td></tr> ');
            Body += ('<tr><td ><b>Location Code </b></td><td>' + Rec."Location Code" + '</td></tr> ');
            Body += ('<tr><td><b> Make</b></td><td>' + Rec.Make + '</td></tr>');
            Body += ('<tr><td><b> Accepted Quantity </b></td><td>' + FORMAT(Rec."Qty. Accepted") + '</td></tr>');
            //QCMail.AppendBody('<tr><td><b> Rejected Quantity  </b></td><td>'+FORMAT("Qty. Rejected")+'</td></tr>');
            Body += ('<tr><td><b> Under Deviation Quantity  </b></td><td>' + FORMAT(Rec."Qty. Accepted Under Deviation") + '</td></tr>');
            EmailMessage.Create(Recipients, Mail_Subject, Mail_Body, TRUE);
            //added by sujani for the Rejection note
            /* IRH1.RESET;
             IRH1.SETFILTER("No.",Rec."No.");
             IF IRH1.FINDSET THEN
             BEGIN

             FileDirectory := '\\erpserver\ErpAttachments\QC_Rejection_Note\';
             //FileName:=IRH."No.");
             //filesub:=COPYSTR("No.",5,5);
             FileName_rej :='QC Rejection Note '+IRH1."No."+ '.pdf';
             REPORT.RUN(32000006,FALSE,FALSE,IRH1);
             REPORT.SAVEASPDF(32000006,FileDirectory+FileName_rej,IRH1);
             QC_ATCH:=FileDirectory+FileName_rej;
             QCMail.AddAttachment(QC_ATCH,FileName_rej);
             END;
             */


            ids.SETRANGE(ids."No.", Rec."Parent IDS");
            IF ids.FINDFIRST THEN BEGIN
                inwqty := ids.Quantity;
                IF Rec.Quantity < inwqty THEN BEGIN
                    Body += ('<tr><td><b>Total Quantity Checked at QC</b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                    //  Mail_Body+=FORMAT(nextline);
                END
                ELSE BEGIN
                    Body += ('<tr><td><b>Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                    Mail_Body += FORMAT(nextline);
                    Body += ('<tr><td><b>Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                END;
                // Mail_Body+=FORMAT(nextline);
            END
            ELSE
                IF inwqty = 0 THEN BEGIN
                    postedids.SETRANGE(postedids."No.", Rec."Parent IDS");
                    IF postedids.FINDFIRST THEN BEGIN
                        inwqty := postedids.Quantity;
                        IF Rec.Quantity < inwqty THEN BEGIN
                            Body += ('<tr><td><b>Total Quantity Checked at QC</b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                            // Mail_Body+=FORMAT(nextline);
                        END
                        ELSE BEGIN
                            Body += ('<tr><td><b>Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                            // Mail_Body+=FORMAT(nextline);
                        END;
                        Body += ('<tr><td><b>Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                    END;
                END
                ELSE BEGIN
                    Body += ('<tr><td><b> Total Quantity </b></td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
                    Body += ('<tr><td><b> Inward Quantity </b></td><td>' + FORMAT(inwqty) + '</td></tr>');
                END;
            accper := ROUND(((Rec."Qty. Accepted" / Rec.Quantity) * 100), 0.01);
            Body += ('<tr><td><b> Accepted % </b></td><td><div style="width:' + FORMAT(accper) + '; background: rgb(128, 177, 133); overflow:visible;">' + FORMAT(accper) + '%</div></td></tr>');
            rejper := ROUND(((Rec."Qty. Accepted Under Deviation" / Rec.Quantity) * 100), 0.01);
            Body += ('<tr><td><b> Under Deviation % </b></td><td>' + FORMAT(rejper) + '%</td></tr>');
            Body += ('<tr><td><b> Accepted Quantity price  </b></td><td>' + FORMAT("acc amt") + '</td></tr>');
            Body += ('<tr><td><b> Under Deviation Qty  Price  </b></td><td>' + FORMAT("rej amt") + '</td></tr>');
            Body += ('<tr><td><b> Total Quantity Price </b></td><td>' + FORMAT("total price") + '</td></tr>');
            IF Rec."Nature Of Rejection" = '' THEN
                ERROR('Please update Nature of Rejection');
            Body += ('<tr><td><b> Rejected Category    </b></td><td>' + Rec."Nature Of Rejection" + '</td></tr>');
            Body += ('<tr><td><b>Reason Description </b></td><td><b>' + Rec."Reason Description" + '</b></td></tr>');
            Body += ('<tr><td><b>Under Deviation Reason</b></td><td>' + Rec."Qty. Accepted UD Reason" + '</td></tr>');
            Body += ('<tr><td><b>Inward Date </b></td><td>' + FORMAT((Rec."IDS creation Date"), 0, 4) + '</td></tr>');
            PRH.SETRANGE(PRH."No.", Rec."Receipt No.");
            IF PRH.FINDFIRST THEN
                Body += ('<tr><td><b>Invoice No.  </b></td><td> ' + PRH."Vendor Order No." + '</td></tr>');
            ;
            Mail_Body += FORMAT(nextline);
            Body += ('<tr><td><b>DC No.</b></td><td>  ' + PRH."Vendor Shipment No." + '</td></tr>');
            Mail_Body += FORMAT(nextline);
            Body += ('<tr><td><b>Batch No</b></td><td>' + Rec."Lot No." + '</td></tr>');
            // Mail_Body+='***** Auto Mail Generated from ERP *****';
            "to mail" += ',Temc@efftronics.com';
            user.SETRANGE(user."User Name", USERID);
            IF user.FINDFIRST THEN
                "user name" := user."User Name";
            Body += ('<tr><td><b>QC Passed By    </b></td><td>' + "user name" + '</td></tr>');
            Body += ('<tr><td><b>Purch Order No. </b></td><td>' + Rec."Order No." + '</td></tr>');

            PL.SETRANGE(PL."Document No.", Rec."Order No.");
            PL.SETRANGE(PL."No.", Rec."Item No.");
            IF PL.FINDFIRST THEN BEGIN
                IH.SETRANGE(IH."No.", PL."Indent No.");
                "Mail-Id".RESET;
                IF IH.FINDFIRST THEN BEGIN
                    "Mail-Id".SETRANGE("Mail-Id"."User ID", IH."Person Code");
                    IF "Mail-Id".FINDFIRST THEN BEGIN
                        Body += ('<tr><td><b>Indented By</b></td><td> ' + "Mail-Id"."User ID" + '</td></tr>');
                        IF "Mail-Id".MailID <> '' THEN
                            "to mail" += ',' + "Mail-Id".MailID;
                    END;
                END;
            END;
            Body += ('</table>');
            Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
            Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        END;
        //  mail.NewCDOMessage("from Mail","to mail",Mail_Subject,Mail_Body,'');

    end;
}

