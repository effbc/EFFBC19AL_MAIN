page 33000257 "Inspection Data Sheet"
{
    // version QC1.1,Cal1.0,RQC1.0,Rev01
    Editable = true;
    DeleteAllowed = false;
    PageType = Document;
    RefreshOnActivate = true;
    SourceTable = "Inspection Datasheet Header";
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Makeedit;
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
                    Editable = Makeedit;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    DecimalPlaces = 0 : 2;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = Makeedit;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    Editable = Makeedit;
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inspection Group Code"; Rec."Inspection Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inspection Receipt No."; Rec."Inspection Receipt No.")
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Time"; Rec."Actual Time")
                {
                    Caption = 'Bench Mark Time';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Taken"; Rec."Time Taken")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creation DateTime"; Rec."Creation DateTime")
                {
                    ApplicationArea = All;
                }
                field(MSL; MSL)
                {
                    Caption = 'MSL';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ESD Class"; "ESD Class")
                {
                    Caption = 'ESD Class';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Floor Life at 25 C 40% RH"; "Floor Life at 25 C 40% RH")
                {
                    Caption = 'Floor Life at 25 C 40% RH';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Years)"; "Component Shelf Life(Years)")
                {
                    Caption = 'Component Shelf Life(Years)';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Bake Hours"; "Bake Hours")
                {
                    Caption = 'Component Bake Hours';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            part(subform; "Inspection Data Sheet Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group(Receipt)
            {
                Caption = 'Receipt';
                Editable = Makeedit;
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
                field("Vendor Address"; Rec."Vendor Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendot Address 2"; Rec."Vendot Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PurchHeaderGrec.RESET;
                        PurchHeaderGrec.SETFILTER(PurchHeaderGrec."No.", Rec."Order No.");
                        IF PurchHeaderGrec.FINDFIRST THEN
                            PAGE.RUNMODAL(50, PurchHeaderGrec)
                    end;
                }
                field("Purch Line No"; Rec."Purch Line No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purchase Consignment No."; Rec."Purchase Consignment No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Tracking Exists"; Rec."Item Tracking Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quality Before Receipt"; Rec."Quality Before Receipt")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Indented_Person; Indented_Person)
                {
                    Caption = 'Indented_Person';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        PurchLineGrec.RESET;
                        PurchLineGrec.SETFILTER(PurchLineGrec."Document No.", Rec."Order No.");
                        PurchLineGrec.SETFILTER(PurchLineGrec."Line No.", '%1', Rec."Purch Line No");
                        IF PurchLineGrec.FINDFIRST THEN BEGIN
                            IF PurchLineGrec."Indent No." <> '' THEN BEGIN
                                Indent_header.RESET;
                                IF Indent_header.GET(PurchLineGrec."Indent No.") THEN
                                    PAGE.RUNMODAL(60042, Indent_header)
                            END;
                        END;
                    end;
                }
            }
            group(Production)
            {
                Caption = 'Production';
                Editable = true;
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
                field("Prod. Description"; Rec."Prod. Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Production Batch No."; Rec."Production Batch No.")
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
                field("Operation Description"; Rec."Operation Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reason for Pending"; Rec."Reason for Pending")
                {
                    ApplicationArea = All;
                    Editable = true;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("OutPut Jr Serial No."; Rec."OutPut Jr Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Issues For Pending"; Rec."Issues For Pending")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Finished Product Sr No"; Rec."Finished Product Sr No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Rework User"; Rec."Rework User")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Sales Returns")
            {
                Caption = 'Sales Returns';
                editable = Makeedit;
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
                editable = Makeedit;
                field("Trans. Order No."; Rec."Trans. Order No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Trans. Order Line"; Rec."Trans. Order Line")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Trans. Description"; Rec."Trans. Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-from Code"; Rec."Transfer-from Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer-to Code"; Rec."Transfer-to Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Calibration)
            {
                Caption = 'Calibration';
                Editable = Makeedit;
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
                field("<Vendor Address2>"; Rec."Vendor Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Vendot Address 22>"; Rec."Vendot Address 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Contact Person2>"; Rec."Contact Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calibration Party"; Rec."Calibration Party")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Resource2>"; Rec.Resource)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Least Count"; Rec."Least Count")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Std. Reference"; Rec."Std. Reference")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Measuring Range"; Rec."Measuring Range")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Model No."; Rec."Model No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Others)
            {
                Caption = 'Others';
                editable = Makeedit;
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
                field("Reclass Entry"; Rec."Reclass Entry")
                {
                    ApplicationArea = All;
                }
                field("Parent IDS No"; Rec."Parent IDS No")
                {
                    ApplicationArea = All;
                }
                field("Partial Inspection"; Rec."Partial Inspection")
                {
                    Editable = PartInspec_Edit;
                    ApplicationArea = All;
                }
                field("<Quantity2>"; Rec.Quantity)
                {
                    DecimalPlaces = 0 : 0;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty in IDS"; Rec."Qty in IDS")
                {
                    Editable = "Qty in IDSEditable";
                    ApplicationArea = All;
                }
                field("Total Qty in IDS"; Rec."Total Qty in IDS")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Qty in IR"; Rec."Total Qty in IR")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Qty in PIR"; Rec."Total Qty in PIR")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("LED Details")
            {
                Caption = 'LED Details';
                editable = Makeedit;
                field("LED Part No."; Rec."LED Part No.")
                {
                    Caption = 'Part Number';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("LED Make"; Rec."LED Make")
                {
                    Caption = 'Make';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Color; Rec.Color)
                {
                    Caption = 'Color';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("LED Type"; Rec."LED Type")
                {
                    Caption = 'Type';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Intensity Code"; Rec."Intensity Code")
                {
                    ApplicationArea = All;
                }
                field("Intensity Value"; Rec."Intensity Value")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Color Value"; Rec."Color Value")
                {
                    ApplicationArea = All;
                }
                field("Voltage Code"; Rec."Voltage Code")
                {
                    ApplicationArea = All;
                }
                field("Voltage Value"; Rec."Voltage Value")
                {
                    ApplicationArea = All;
                }
                field("Ext Batch No"; Rec."Ext Batch No")
                {
                    ApplicationArea = All;
                }
                field("Ext Lot No"; Rec."Ext Lot No")
                {
                    ApplicationArea = All;
                }
                field("Date Code"; Rec."Date Code")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
            group(Inspection)
            {
                Caption = 'Inspection';
                Editable = Makeedit;
                field("MBB Status"; Rec."MBB Status")
                {
                    ApplicationArea = All;
                }
                field("HIC 60%"; Rec."HIC 60%")
                {
                    ApplicationArea = All;
                }
                field("HIC 10%"; Rec."HIC 10%")
                {
                    ApplicationArea = All;
                }
                field("HIC 5%"; Rec."HIC 5%")
                {
                    ApplicationArea = All;
                }
                field("MBB Packet Open DateTime"; Rec."MBB Packet Open DateTime")
                {
                    ApplicationArea = All;
                }
                field("MBB Packet Close DateTime"; Rec."MBB Packet Close DateTime")
                {
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
                    ApplicationArea = All;
                }
                field("MFD Date"; Rec."MFD Date")
                {
                    ApplicationArea = All;
                }
                field("Packed Date"; Rec."Packed Date")
                {
                    Caption = 'Manf. Packed Date';
                    ApplicationArea = All;
                }
                field("MBB Packed Date"; Rec."MBB Packed Date")
                {
                    Caption = 'MBB Packed Date after Baking';
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
                separator(Action1000000049)
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
                    RunObject = Page 60139;
                    //  RunPageLink ="Document Type"= field("Item No.");
                    RunPageLink = "No." = field("Item No.");
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
                action(SalesDocument)
                {
                    Caption = 'SalesDocument';
                    Image = Document;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        PurchHeaderGrec.RESET;
                        PurchHeaderGrec.SETFILTER(PurchHeaderGrec."No.", "Order No.");
                        PurchHeaderGrec.SETFILTER(PurchHeaderGrec."Sale Order No", '<>%1', '');
                        IF PurchHeaderGrec.FINDFIRST THEN BEGIN
                            attachment.RESET;
                            attachment.SETRANGE("Table ID", DATABASE::"Sales Header");
                            attachment.SETRANGE("Document No.", PurchHeaderGrec."Sale Order No");
                            PAGE.RUN(PAGE::"ESPL Attachments", attachment);
                        END
                        ELSE
                            ERROR('There is no sale order for this item');
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
                separator(Action1102154004)
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
                        Selection := STRMENU(Text007, 1);
                        IF Selection = 0 THEN
                            EXIT;

                        IDS_Qty := 0;
                        QualityILE.RESET;
                        QualityILE.SETRANGE("Document No.", "Receipt No.");
                        QualityILE.SETRANGE("Item No.", "Item No.");
                        QualityILE.SETRANGE(Select, FALSE);
                        IF Selection = 2 THEN
                            PAGE.RUN(33000274, QualityILE)
                        ELSE BEGIN
                            REPEAT
                                QualityILE.Select := TRUE;
                                QualityILE.MODIFY;
                                IDS_Qty += 1;
                                QualityILE.NEXT;
                                MESSAGE(QualityILE."Serial No.");

                            UNTIL IDS_Qty <= "Qty in IDS";
                            MESSAGE(FORMAT(IDS_Qty) + ' items are selected');
                        END;
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
                                        Selection := STRMENU(Text007, 1);
                                        IF Selection = 0 THEN
                                            EXIT;
                                        IF Selection = 2 THEN BEGIN
                                            PAGE.RUNMODAL(33000274, QualityILE);
                                            Selected_Qty := 0;
                                            QualityILE2.RESET;
                                            QualityILE2.SETRANGE("Document No.", "Receipt No.");
                                            QualityILE2.SETRANGE("Item No.", "Item No.");
                                            QualityILE2.SETRANGE(Select, TRUE);
                                            QualityILE2.SETFILTER(QualityILE2."Child Ids", '%1', '');
                                            QualityILE2.SETRANGE(QualityILE2."Lot No.", "Lot No.");
                                            IF QualityILE2.FINDFIRST THEN
                                                REPEAT
                                                    Selected_Qty += QualityILE2."Remaining Quantity";
                                                UNTIL QualityILE2.NEXT = 0;
                                            IF Selected_Qty <> "Qty in IDS" THEN BEGIN
                                                QualityILE2.RESET;
                                                QualityILE2.SETRANGE("Document No.", "Receipt No.");
                                                QualityILE2.SETRANGE("Item No.", "Item No.");
                                                QualityILE2.SETRANGE(Select, TRUE);
                                                QualityILE2.SETFILTER(QualityILE2."Child Ids", '%1', '');
                                                QualityILE2.SETRANGE(QualityILE2."Lot No.", "Lot No.");
                                                IF QualityILE2.FINDFIRST THEN
                                                    REPEAT
                                                        QualityILE2.Select := FALSE;
                                                        QualityILE2.MODIFY;
                                                        COMMIT;
                                                    UNTIL QualityILE2.NEXT = 0;
                                                ERROR('You Did not select the specified quantity in IDS ');
                                            END;
                                        END
                                        ELSE BEGIN
                                            REPEAT
                                                QualityILE.Select := TRUE;
                                                QualityILE.MODIFY;
                                                Partial_Qty := Partial_Qty - 1;
                                            UNTIL (QualityILE.NEXT = 0) OR (Partial_Qty = 0)
                                        END;
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
                separator(Action1102154010)
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

                        IF "Issues For Pending" = "Issues For Pending"::"  " THEN
                            ERROR('Please Select Issues For Pending. If No Issues - Select No Issue Option');

                        // >>Added by Pranavi on 19-05-2017 for MSL process
                        IF Item.GET("Item No.") THEN BEGIN
                            IF Item.MSL <> 0 THEN BEGIN
                                IF "MFD Date" = 0D THEN
                                    ERROR('Please enter MFD Date!');
                                IF Rec."MBB Status" = 0 THEN
                                    ERROR('Please enter MBB Status!');
                                IF ("HIC 5%" = 0) OR ("HIC 10%" = 0) OR ("HIC 60%" = 0) THEN
                                    ERROR('Please enter HIC Color status!');
                                IF "MBB Packet Open DateTime" = 0DT THEN
                                    ERROR('Please enter MBB Packet Open DateTime!');
                                IF "MBB Packet Close DateTime" = 0DT THEN
                                    ERROR('Please enter MBB Packet Close DateTime!');
                                IF "MBB Packet Close DateTime" - "MBB Packet Open DateTime" <= 0 THEN
                                    ERROR('MBB Packet Close Time must be >= MBB packet Open Time!');
                                IF (Rec."MBB Status" = "MBB Status"::Damage) AND ("MBB Packed Date" = 0D) THEN
                                    ERROR('Please enter MBB packed date as MBB is damaged!');
                                IF Item."Floor Life at 25 C 40% RH" IN ['', ' '] THEN
                                    ERROR('Floor Life in Item card is not defined! Please contact TEMC!');
                                IF (Item.MSL IN [Item.MSL::"1", Item.MSL::"2"]) AND ("HIC 60%" <> "HIC 60%"::Blue) AND (Item."Floor Life at 25 C 40% RH" <> 'INFINITE') THEN BEGIN
                                    IF ("Baked Hours" <= 0) THEN
                                        ERROR('Please enter baking hours!');
                                    IF ("Baked Hours" <> "Bake Hours") AND ("Bake Hours" <> 0) THEN
                                        ERROR('Baked Hours must equal to Bake hours defined in Item card : %1!', Item."Bake Hours");
                                    IF "MBB Packed Date" = 0D THEN
                                        ERROR('Please enter New MBB Packed Date!');
                                END;
                                IF (Item.MSL IN [Item.MSL::"2A", Item.MSL::"3", Item.MSL::"4", Item.MSL::"5", Item.MSL::"5A"]) AND (Item."Floor Life at 25 C 40% RH" <> 'INFINITE')
                                  AND ("HIC 10%" <> "HIC 10%"::Blue) AND ("HIC 5%" <> "HIC 5%"::Pink) THEN BEGIN
                                    IF ("Baked Hours" <= 0) THEN
                                        ERROR('Please enter baking hours!');
                                    IF ("Baked Hours" <> "Bake Hours") AND ("Bake Hours" <> 0) THEN
                                        ERROR('Baked Hours must equal to Bake hours defined in Item card : %1!', Item."Bake Hours");
                                    IF "MBB Packed Date" = 0D THEN
                                        ERROR('Please enter New MBB Packed Date!');
                                END;
                            END;
                        END;
                        // <<Added by Pranavi on 19-05-2017 for MSL process

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

    trigger OnAfterGetRecord();
    begin
        _OnAfterGetCurrRecord;
        //>>Added by Pranavi on 17-05-2017 for MSL Process
        IF Item.GET("Item No.") THEN BEGIN
            MSL := Item.MSL;
            "ESD Class" := Item."ESD Class";
            "Floor Life at 25 C 40% RH" := Item."Floor Life at 25 C 40% RH";
            "Bake Hours" := Item."Bake Hours";
            "Component Shelf Life(Years)" := Item."Component Shelf Life(Years)";
        END;
        //<<Added by Pranavi on 17-05-2017 for MSL Process
    end;

    trigger OnInit();
    begin
        "Qty in IDSEditable" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        _OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage();
    begin
        CALCFIELDS("Total Qty in IDS");
        IF "Parent IDS No" <> '' THEN
            "Qty in IDSEditable" := FALSE
        ELSE
            "Qty in IDSEditable" := TRUE;
        IF USERID IN ['EFFTRONICS\SUJANI','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\B2BOTS','EFFTRONICS\SUVARCHALADEVI'] THEN begin
            PartInspec_Edit := TRUE;
            Makeedit := TRUE;
        END
        ELSE BEGIN
            PartInspec_Edit := FALSE;
            Makeedit := FALSE;
        END;
    end;

    var
        TEXT000: Label 'Actual values are not entered for %1 lines.\Do You want to release the Document?';
        DataSheetLine: Record "Inspection Datasheet Line";
        PostInspectData: Codeunit "Post-Inspection Data Sheet";
        check: Boolean;
        TEXT001: Label 'Do You want to release the Document?';
        InspectDataSheet: Record "Inspection Datasheet Header";
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
        attachment: Record Attachments;
        CalProHeader: Record "Calibration Procedure Header";
        Text002: Label 'Partial Inspection Data sheet can not be posted.';
        Text003: Label 'Qty in IDS should not be zero.';
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        Text004: Label 'Partial IDS can be created only for Lot specific tracking.';
        Text005: Label 'Make  Reclassification before the Partial IDS creation.';
        Text006: Label '"Create Partial IDS for previous reclassification. "';
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
        PurchHeaderGrec: Record "Purchase Header";
        Selection: Integer;
        Text007: Label '&Automatic,&Manual';
        SalesHeadGrec: Record "Sales Header";
        QualityILE2: Record "Quality Item Ledger Entry";
        Selected_Qty: Decimal;
        Indented_Person: Code[20];
        Indent_header: Record "Indent Header";
        PurchLineGrec: Record "Purchase Line";
        PartInspec_Edit: Boolean;
        MSL: Option " ","1","2","2A","3","4","5","5A","6";
        "ESD Class": Option " ","0","1A","1B","1C","2","3A","3B";
        "Floor Life at 25 C 40% RH": Code[15];
        "Bake Hours": Decimal;
        "Component Shelf Life(Years)": Decimal;
        "MBB Shelf Life": Decimal;
        Visible_Bool: Boolean;
        DateAndTime: DotNet DateAndTimeD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.DateAndTime";
        DayofWeekInput: DotNet DayofWeekInputD;
        //"'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstDayOfWeek";
        WeekofYearInput: DotNet WeekofYearInputD;
        // "'Microsoft.VisualBasic, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'.Microsoft.VisualBasic.FirstWeekOfYear";
        Makeedit: Boolean;


    local procedure _OnAfterGetCurrRecord();
    begin
        xRec := Rec;
        SETRANGE("No.");

        IF "Parent IDS No" <> '' THEN
            "Qty in IDSEditable" := FALSE
        ELSE
            "Qty in IDSEditable" := TRUE;
        "Remaining Quantity" := Quantity - ("Total Qty in IDS" + "Total Qty in IR" + "Total Qty in PIR");

        Indented_Person := '';
        PurchLineGrec.RESET;
        PurchLineGrec.SETFILTER(PurchLineGrec."Document No.", "Order No.");
        PurchLineGrec.SETFILTER(PurchLineGrec."Line No.", '%1', "Purch Line No");
        IF PurchLineGrec.FINDFIRST THEN BEGIN
            IF PurchLineGrec."Indent No." <> '' THEN BEGIN
                Indented_Person := PurchLineGrec."Indent No.";
            END;
        END;
    end;
}

