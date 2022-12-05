page 60278 "Item Ledger Entries Editable"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778

    CaptionML = ENU = 'Item Ledger Entries Editable',
                ENN = 'Item Ledger Entries Editable';
    DataCaptionExpression = GetCaption;
    DataCaptionFields = "Item No.";
    Editable = true;
    PageType = List;
    Permissions = TableData 32 = rmd;
    SourceTable = 32;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            field(count; Count)
            {
            }
            repeater(Control1)
            {
                Editable = true;
                field("Posting Date"; "Posting Date")
                {
                }
                field("Entry Type"; "Entry Type")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Serial No."; "Serial No.")
                {
                    Editable = true;
                    Enabled = true;
                }
                field("Lot No."; "Lot No.")
                {
                }
                field("ITL Doc No."; "ITL Doc No.")
                {
                    Importance = Standard;
                }
                field("ITL Doc Line No."; "ITL Doc Line No.")
                {
                }
                field(Positive; Positive)
                {
                }
                field("Document Line No."; "Document Line No.")
                {
                    Visible = false;
                }
                field("Item No."; "Item No.")
                {
                }
                field("Variant Code"; "Variant Code")
                {
                    Visible = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                }
                field(Description; Description)
                {
                }
                //B2BUpg>>
                /*
                field("Reason Code"; "Reason Code")
                {
                    Visible = false;
                }*/
                //B2BUpg<<
                field("Return Reason Code"; "Return Reason Code")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Expiration Date"; "Expiration Date")
                {
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = true;
                }
                field(Quantity; Quantity)
                {
                    Editable = true;
                }
                field("Invoiced Quantity"; "Invoiced Quantity")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Remaining Quantity"; "Remaining Quantity")
                {
                    Editable = true;
                    Visible = true;
                }
                field("Shipped Qty. Not Returned"; "Shipped Qty. Not Returned")
                {
                    Visible = false;
                }
                field("Reserved Quantity"; "Reserved Quantity")
                {
                    Visible = false;
                }
                field("Qty. per Unit of Measure"; "Qty. per Unit of Measure")
                {
                    Visible = false;
                }
                field("Sales Amount (Expected)"; "Sales Amount (Expected)")
                {
                    Visible = false;
                }
                field("Sales Amount (Actual)"; "Sales Amount (Actual)")
                {
                    Visible = false;
                }
                field("Cost Amount (Expected)"; "Cost Amount (Expected)")
                {
                    Visible = false;
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                    Visible = false;
                }
                field("Cost Amount (Non-Invtbl.)"; "Cost Amount (Non-Invtbl.)")
                {
                    Visible = false;
                }
                field("Cost Amount (Expected) (ACY)"; "Cost Amount (Expected) (ACY)")
                {
                    Visible = false;
                }
                field("Cost Amount (Actual) (ACY)"; "Cost Amount (Actual) (ACY)")
                {
                    Visible = false;
                }
                field("Cost Amount (Non-Invtbl.)(ACY)"; "Cost Amount (Non-Invtbl.)(ACY)")
                {
                    Visible = false;
                }
                field("Completely Invoiced"; "Completely Invoiced")
                {
                    Visible = false;
                }
                field(Open; Open)
                {
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                    Visible = false;
                }
                field("Assemble to Order"; "Assemble to Order")
                {
                    Visible = false;
                }
                field("Applied Entry to Adjust"; "Applied Entry to Adjust")
                {
                    Visible = false;
                }
                field("Order Type"; "Order Type")
                {
                }
                field("Order No."; "Order No.")
                {
                    Editable = true;
                    Visible = false;
                }
                field("Order Line No."; "Order Line No.")
                {
                    Visible = false;
                }
                field("Prod. Order Comp. Line No."; "Prod. Order Comp. Line No.")
                {
                    Visible = false;
                }
                field("Entry No."; "Entry No.")
                {
                }
                field("Job No."; "Job No.")
                {
                    Visible = false;
                }
                field("Job Task No."; "Job Task No.")
                {
                    Visible = false;
                }
                //B2BUpg>>
                /*
                field("Other Usage"; "Other Usage")
                {
                    Visible = false;
                }
                field("Nature of Disposal"; "Nature of Disposal")
                {
                    Visible = false;
                }
                field("Type of Disposal"; "Type of Disposal")
                {
                    Visible = false;
                }
                field("Laboratory Test"; "Laboratory Test")
                {
                    Visible = false;
                }*/
                //B2BUpg<<
                field("User ID"; "User ID")
                {
                    Editable = true;
                }
                field("DC Check"; "DC Check")
                {
                }
                field("Source Type"; "Source Type")
                {
                }
                field("MBB Packed Date"; "MBB Packed Date")
                {
                }
                field("MFD Date"; "MFD Date")
                {
                }
                field("Recharge Cycles"; "Recharge Cycles")
                {
                }
                field("Last Invoice Date"; "Last Invoice Date")
                {
                }
                field("Floor Life"; "Floor Life")
                {
                }
                field("ITL Doc Ref Line No."; "ITL Doc Ref Line No.")
                {
                }
                field("MBB Packet Open DateTime"; "MBB Packet Open DateTime")
                {
                }
                field("MBB Packet Close DateTime"; "MBB Packet Close DateTime")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                CaptionML = ENU = 'Ent&ry',
                            ENN = 'Ent&ry';
                Image = Entry;
                action(Dimensions)
                {
                    AccessByPermission = TableData 348 = R;
                    CaptionML = ENU = 'Dimensions',
                                ENN = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction();
                    begin
                        ShowDimensions;
                    end;
                }
                action("&Value Entries")
                {
                    CaptionML = ENU = '&Value Entries',
                                ENN = '&Value Entries';
                    Image = ValueLedger;
                    RunObject = Page 5802;
                    RunPageLink = "Item Ledger Entry No." = FIELD("Entry No.");
                    RunPageView = SORTING("Item Ledger Entry No.");
                    ShortCutKey = 'Ctrl+F7';
                }
            }
            group("&Application")
            {
                CaptionML = ENU = '&Application',
                            ENN = '&Application';
                Image = Apply;
                action("Applied E&ntries")
                {
                    CaptionML = ENU = 'Applied E&ntries',
                                ENN = 'Applied E&ntries';
                    Image = Approve;

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Show Applied Entries", Rec);
                    end;
                }
                action("Reservation Entries")
                {
                    AccessByPermission = TableData 27 = R;
                    CaptionML = ENU = 'Reservation Entries',
                                ENN = 'Reservation Entries';
                    Image = ReservationLedger;

                    trigger OnAction();
                    begin
                        ShowReservationEntries(TRUE);
                    end;
                }
                action("Application Worksheet")
                {
                    CaptionML = ENU = 'Application Worksheet',
                                ENN = 'Application Worksheet';
                    Image = ApplicationWorksheet;

                    trigger OnAction();
                    var
                        Worksheet: Page 521;
                    begin
                        CLEAR(Worksheet);
                        Worksheet.SetRecordToShow(Rec);
                        Worksheet.RUN;
                    end;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                CaptionML = ENU = 'F&unctions',
                            ENN = 'F&unctions';
                Image = "Action";
                action("Order &Tracking")
                {
                    CaptionML = ENU = 'Order &Tracking',
                                ENN = 'Order &Tracking';
                    Image = OrderTracking;

                    trigger OnAction();
                    var
                        TrackingForm: Page 99000822;
                    begin
                        TrackingForm.SetItemLedgEntry(Rec);
                        TrackingForm.RUNMODAL;
                    end;
                }
            }
            action("&Navigate")
            {
                CaptionML = ENU = '&Navigate',
                            ENN = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\GRAVI', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You dont have permission to open this Page');
    end;

    var
        Navigate: Page 344;
        Page_editable: Boolean;

    local procedure GetCaption(): Text;
    var
        GLSetup: Record 98;
        ObjTransl: Record 377;
        Item: Record 27;
        ProdOrder: Record 5405;
        Cust: Record 18;
        Vend: Record 23;
        Dimension: Record 348;
        DimValue: Record 349;
        SourceTableName: Text;
        SourceFilter: Text[200];
        Description: Text[100];
    begin
        Description := '';

        CASE TRUE OF
            GETFILTER("Item No.") <> '':
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 27);
                    SourceFilter := GETFILTER("Item No.");
                    IF MAXSTRLEN(Item."No.") >= STRLEN(SourceFilter) THEN
                        IF Item.GET(SourceFilter) THEN
                            Description := Item.Description;
                END;
            (GETFILTER("Order No.") <> '') AND ("Order Type" = "Order Type"::Production):
                BEGIN
                    SourceTableName := ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 5405);
                    SourceFilter := GETFILTER("Order No.");
                    IF MAXSTRLEN(ProdOrder."No.") >= STRLEN(SourceFilter) THEN
                        IF ProdOrder.GET(ProdOrder.Status::Released, SourceFilter) OR
                           ProdOrder.GET(ProdOrder.Status::Finished, SourceFilter)
                        THEN BEGIN
                            SourceTableName := STRSUBSTNO('%1 %2', ProdOrder.Status, SourceTableName);
                            Description := ProdOrder.Description;
                        END;
                END;
            GETFILTER("Source No.") <> '':
                CASE "Source Type" OF
                    "Source Type"::Customer:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 18);
                            SourceFilter := GETFILTER("Source No.");
                            IF MAXSTRLEN(Cust."No.") >= STRLEN(SourceFilter) THEN
                                IF Cust.GET(SourceFilter) THEN
                                    Description := Cust.Name;
                        END;
                    "Source Type"::Vendor:
                        BEGIN
                            SourceTableName :=
                              ObjTransl.TranslateObject(ObjTransl."Object Type"::Table, 23);
                            SourceFilter := GETFILTER("Source No.");
                            IF MAXSTRLEN(Vend."No.") >= STRLEN(SourceFilter) THEN
                                IF Vend.GET(SourceFilter) THEN
                                    Description := Vend.Name;
                        END;
                END;
            GETFILTER("Global Dimension 1 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 1 Code";
                    SourceFilter := GETFILTER("Global Dimension 1 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 1 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            GETFILTER("Global Dimension 2 Code") <> '':
                BEGIN
                    GLSetup.GET;
                    Dimension.Code := GLSetup."Global Dimension 2 Code";
                    SourceFilter := GETFILTER("Global Dimension 2 Code");
                    SourceTableName := Dimension.GetMLName(GLOBALLANGUAGE);
                    IF MAXSTRLEN(DimValue.Code) >= STRLEN(SourceFilter) THEN
                        IF DimValue.GET(GLSetup."Global Dimension 2 Code", SourceFilter) THEN
                            Description := DimValue.Name;
                END;
            GETFILTER("Document Type") <> '':
                BEGIN
                    SourceTableName := GETFILTER("Document Type");
                    SourceFilter := GETFILTER("Document No.");
                    Description := GETFILTER("Document Line No.");
                END;
        END;
        EXIT(STRSUBSTNO('%1 %2 %3', SourceTableName, SourceFilter, Description));
    end;
}

