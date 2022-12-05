page 33000259 "Inspection Data Sheet List"
{
    // version QC1.0,Rev01

    CardPageID = "Inspection Data Sheet";
    Editable = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Inspection Datasheet Header";
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Order Value"; Rec."Order Value")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                field("Parent IDS No"; Rec."Parent IDS No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Item Bench Mark"; Rec."Item Bench Mark")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Prod. Description"; Rec."Prod. Description")
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(Resource; Rec.Resource)
                {
                    ApplicationArea = All;
                }
                field("Operation Description"; Rec."Operation Description")
                {
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
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
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Rework Level"; Rec."Rework Level")
                {
                    ApplicationArea = All;
                }
                field("Rework Reference No."; Rec."Rework Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
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
            group("&Data Sheet")
            {
                Caption = '&Data Sheet';
                separator(Action1102152020)
                {
                }
                action("Purch. Receipt")
                {
                    Caption = 'Purch. Receipt';
                    Image = Receipt;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 136;
                    ApplicationArea = All;
                    RunPageLink = "No." = FIELD("Receipt No.");
                }
                action("Calibration  &Procedure")
                {
                    Caption = 'Calibration  &Procedure';
                    Image = OpportunityList;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CalProHeader.ShowCalProcForIDs(Rec);
                    end;
                }
                action(Specifications)
                {
                    Caption = 'Specifications';
                    Image = ItemVariant;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Sales Amc Subform1";
                    RunPageLink = "No." = FIELD("Item No.");
                    ApplicationArea = All;
                }
            }
            group(Item)
            {
                Caption = 'Item';
                action("Item &Tracking")
                {
                    Caption = 'Item &Tracking';
                    Image = ItemTracking;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF "Parent IDS No" = '' THEN BEGIN
                            QualityILE.RESET;
                            QualityILE.SETRANGE("Document No.", "Receipt No.");
                            QualityILE.SETRANGE("Item No.", "Item No.");
                            QualityILE.SETRANGE(QualityILE."Purch.Rcpt Line", "Purch Line No");
                            QualityILE.SETRANGE(QualityILE."Child Ids", '');
                            QualityILE.SETRANGE(QualityILE.Select, FALSE);
                            QualityILE.SETRANGE(QualityILE."Lot No.", "Lot No.");
                            PAGE.RUN(PAGE::"Quality Item Ledger Entries", QualityILE)
                        END ELSE BEGIN
                            QualityILE.RESET;
                            QualityILE.SETRANGE("Document No.", "Receipt No.");
                            QualityILE.SETRANGE("Item No.", "Item No.");
                            QualityILE.SETRANGE(QualityILE."Purch.Rcpt Line", "Purch Line No");
                            QualityILE.SETRANGE(QualityILE.Select, TRUE);
                            QualityILE.SETRANGE(QualityILE."Child Ids", "No.");
                            QualityILE.SETRANGE(QualityILE."Lot No.", "Lot No.");
                            PAGE.RUN(PAGE::"Partial  IDS QLE", QualityILE);
                        END;
                    end;
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
                        DataSheetLine.SETFILTER(DataSheetLine."Document No.", "No.");
                        DataSheetLine.SETFILTER(DataSheetLine."Character Code", '<>'' ''');
                        IF DataSheetLine.FINDSET THEN
                            REPEAT
                                DataSheetLine.Accept := TRUE;
                                DataSheetLine.MODIFY;
                            UNTIL DataSheetLine.NEXT = 0;
                        MESSAGE(FORMAT(DataSheetLine.COUNT));
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Re&lease")
                {
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F11';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        "Count": Integer;
                    begin
                        Count := 0;
                        DataSheetLine.SETRANGE("Document No.", "No.");
                        IF DataSheetLine.FINDSET THEN
                            REPEAT
                                check := FALSE;
                                IF (DataSheetLine."Normal Value (Text)" <> '') OR (DataSheetLine."Min. Value (Text)" <> '')
                                  OR (DataSheetLine."Max. Value (Text)" <> '') THEN
                                    IF DataSheetLine."Actual  Value (Text)" = '' THEN BEGIN
                                        Count := Count + 1;
                                        check := TRUE;
                                    END;
                                IF (check = FALSE) AND ((DataSheetLine."Normal Value (Num)" <> 0) OR (DataSheetLine."Min. Value (Num)" <> 0)
                                  OR (DataSheetLine."Max. Value (Num)" <> 0)) THEN
                                    IF DataSheetLine."Actual Value (Num)" = 0 THEN
                                        Count := Count + 1;
                            UNTIL DataSheetLine.NEXT = 0;


                        IF Count = 0 THEN BEGIN
                            IF CONFIRM(TEXT001, FALSE, Count) THEN
                                Status := Status::Released;
                        END ELSE
                            IF CONFIRM(TEXT000, FALSE, Count) THEN
                                Status := Status::Released;
                        CurrPage.UPDATE;
                    end;
                }
                action("Re&open")
                {
                    Caption = 'Re&open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Status := Status::Open;
                        CurrPage.UPDATE;
                    end;
                }
                action("&Attachments")
                {
                    Caption = '&Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        attachment.RESET;
                        attachment.SETRANGE("Table ID", DATABASE::"Inspection Datasheet Header");
                        //attachment.SETRANGE(attachment."Ids Reference No.",);
                        attachment.SETRANGE("Document No.", "No.");
                        PAGE.RUN(PAGE::"ESPL Attachments", attachment);
                    end;
                }
                separator(Action1102152008)
                {
                }
                action("Select Ids Qty")
                {
                    Caption = 'Select Ids Qty';
                    Image = SelectEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin

                        IDS_Qty := 0;
                        QualityILE.RESET;
                        QualityILE.SETRANGE("Document No.", "Receipt No.");
                        QualityILE.SETRANGE("Item No.", "Item No.");
                        QualityILE.SETRANGE(Select, FALSE);
                        REPEAT
                            QualityILE.Select := TRUE;
                            QualityILE.MODIFY;
                            IDS_Qty += 1;
                            QualityILE.NEXT;
                            MESSAGE(QualityILE."Serial No.");

                        UNTIL IDS_Qty < "Qty in IDS";
                        MESSAGE(FORMAT(IDS_Qty) + ' items are selected');
                    end;
                }
                action("Create &Reclassification")
                {
                    Caption = 'Create &Reclassification';
                    Image = CreateRating;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF "Reclass Entry" THEN
                            ERROR(Text006);
                        IF ("Parent IDS No" <> '') THEN
                            ERROR('You cannot reclass')
                        ELSE BEGIN
                            Item.GET("Item No.");
                            ItemTrackingCode.GET(Item."Item Tracking Code");
                            IF (ItemTrackingCode."Lot Specific Tracking") AND (ItemTrackingCode."SN Specific Tracking" = FALSE) THEN
                                CreateReclass
                            ELSE BEGIN
                                //ERROR(Text004);
                                IF "Parent IDS No" <> '' THEN BEGIN
                                    QualityILE.RESET;
                                    QualityILE.SETRANGE("Document No.", "Receipt No.");
                                    QualityILE.SETRANGE("Item No.", "Item No.");
                                    QualityILE.SETRANGE(Select, TRUE);
                                    QualityILE.SETRANGE(QualityILE."Lot No.", "Lot No.");
                                    PAGE.RUN(PAGE::"Partial  IDS QLE", QualityILE);
                                    "Reclass Entry" := TRUE;
                                    "Partial Inspection" := TRUE;
                                    MODIFY;
                                END ELSE BEGIN
                                    Partial_Qty := "Qty in IDS";
                                    QualityILE.RESET;
                                    QualityILE.SETRANGE("Document No.", "Receipt No.");
                                    QualityILE.SETRANGE("Item No.", "Item No.");
                                    QualityILE.SETRANGE(Select, FALSE);
                                    QualityILE.SETRANGE(QualityILE."Lot No.", "Lot No.");
                                    IF QualityILE.FINDFIRST THEN  //Added by sundar on 09-JAN-13 to reduce Automize the selection of Serial no
                                    BEGIN                         //while creating Partial IDS
                                                                  // IF (QualityILE.COUNT<>"Qty in IDS")THEN
                                                                  //BEGIN
                                        REPEAT
                                            QualityILE.Select := TRUE;
                                            QualityILE.MODIFY;
                                            Partial_Qty := Partial_Qty - 1;
                                        UNTIL (QualityILE.NEXT = 0) OR (Partial_Qty = 0)
                                        //END;
                                    END;// Added by sundar
                                        //Page.RUN(FORM::"Partial  IDS QLE",QualityILE);
                                    "Reclass Entry" := TRUE;
                                    "Partial Inspection" := TRUE;
                                    MODIFY;
                                END;
                            END;
                        END;
                    end;
                }
                separator(Action1102152005)
                {
                }
                action("Create &Partial IDS")
                {
                    Caption = 'Create &Partial IDS';
                    Image = CreateInteraction;
                    Promoted = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        QualityILE.SETRANGE(QualityILE."Document No.", "Receipt No.");
                        QualityILE.SETRANGE(QualityILE."Item No.", "Item No.");
                        QualityILE.SETRANGE(QualityILE."Child Ids", '');
                        QualityILE.SETRANGE(QualityILE.Select, TRUE);
                        QualityILE.SETRANGE(QualityILE."Lot No.", "Lot No.");
                        IF QualityILE.FINDFIRST THEN BEGIN
                            IF (QualityILE.COUNT <> "Qty in IDS") THEN
                                ERROR('Mismatch in qty');
                        END;

                        IF "Qty in IDS" = 0 THEN
                            ERROR(Text003);
                        IF NOT "Reclass Entry" THEN
                            ERROR(Text005);
                        Item.GET("Item No.");
                        //ItemTrackingCode.GET(Item."Item Tracking Code");
                        //IF ItemTrackingCode."Lot Specific Tracking" THEN
                        CreatePartialIDS
                        /*ELSE
                          ERROR(Text004);*/

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
                    begin
                        TESTFIELD(Status, Status::Released);
                        IF "Source Type" = "Source Type"::"In Bound" THEN BEGIN                                                      //modified by Swarupa on 12-01-09)
                            attachment.SETFILTER(attachment."Document No.", "No.");
                            IF attachment.FINDFIRST THEN BEGIN
                                //IF (attachment."Attachment Status"=attachment."Attachment Status"::"0") THEN
                                //ERROR('Please Attach a Document to post IDS');
                            END ELSE
                                MESSAGE('Please Attach a Document to post IDS');

                        END;

                        IF NOT "Partial Inspection" THEN BEGIN
                            IF CONFIRM('Do you want to post the Inspection Data Sheets?') THEN BEGIN
                                IF ("Trans. Order No." <> '') THEN
                                    PostInspectData.TransferOrderPostIDS(Rec)
                                ELSE
                                    PostInspectData.RUN(Rec);
                                CurrPage.UPDATE;
                            END;
                        END ELSE BEGIN
                            TotalQtyinIds := 0;
                            TotalQtyinPostedIds := 0;
                            InspectDataSheet2.SETRANGE("Parent IDS No", "No.");
                            InspectDataSheet2.SETRANGE("Partial Inspection", FALSE);
                            IF InspectDataSheet2.FINDSET THEN BEGIN
                                REPEAT
                                    TotalQtyinIds += InspectDataSheet2.Quantity;
                                UNTIL InspectDataSheet2.NEXT = 0;
                            END;
                            PostInspectDataSheet2.SETRANGE("Parent IDS No", "No.");
                            PostInspectDataSheet2.SETRANGE("Partial Inspection", FALSE);
                            IF PostInspectDataSheet2.FINDSET THEN BEGIN
                                REPEAT
                                    TotalQtyinPostedIds += PostInspectDataSheet2.Quantity;
                                UNTIL PostInspectDataSheet2.NEXT = 0;
                            END;
                            IF ((TotalQtyinIds + TotalQtyinPostedIds) <> Quantity) THEN
                                ERROR(Text002)


                            ELSE
                                IF CONFIRM('Do you want to post the Inspection Data Sheets?') THEN BEGIN
                                    IF ("Trans. Order No." <> '') THEN
                                        PostInspectData.TransferOrderPostIDS(Rec)
                                    ELSE
                                        PostInspectData.RUN(Rec);
                                    CurrPage.UPDATE;
                                END;
                        END;
                    end;
                }
                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        InspectDataSheet.SETRANGE("No.", "No.");
                        REPORT.RUN(33000250, TRUE, FALSE, InspectDataSheet);
                    end;
                }
            }
        }
    }

    var
        DataSheetLine: Record "Inspection Datasheet Line";
        PostInspectData: Codeunit "Post-Inspection Data Sheet";
        check: Boolean;
        InspectDataSheet: Record "Inspection Datasheet Header";
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
        attachment: Record Attachments;
        CalProHeader: Record "Calibration Procedure Header";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        TotalQtyinIds: Decimal;
        TotalQtyinPostedIds: Decimal;
        InspectDataSheet2: Record "Inspection Datasheet Header";
        PostInspectDataSheet2: Record "Posted Inspect DatasheetHeader";
        ItemTracking: Record "Item Tracking Code";
        QualityILE: Record "Quality Item Ledger Entry";
        IDS_Qty: Integer;
        "Remaining Quantity": Decimal;
        Partial_Qty: Integer;

        "Qty in IDSEditable": Boolean;
        TEXT000: Label 'Actual values are not entered for %1 lines.\Do You want to release the Document?';
        TEXT001: Label 'Do You want to release the Document?';
        Text002: Label 'Partial Inspection Data sheet can not be posted.';
        Text003: Label 'Qty in IDS should not be zero.';
        Text004: Label 'Partial IDS can be created only for Lot specific tracking.';
        Text005: Label 'Make  Reclassification before the Partial IDS creation.';
        Text006: Label '"Create Partial IDS for previous reclassification. "';
}

