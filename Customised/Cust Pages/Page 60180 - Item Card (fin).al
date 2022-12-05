page 60180 "Item Card (fin)"
{
    // version NAVW13.70,NAVIN3.70.01.11,QC1.0,QCB2B1.2,B2B1.0,QC1.2,Rev01

    Caption = 'Item Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;

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

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code Cust")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Sub Sub Group Code"; Rec."Item Sub Sub Group Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Under Inspection"; Rec."Quantity Under Inspection")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Sent for Rework"; Rec."Quantity Sent for Rework")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Rejected"; Rec."Quantity Rejected")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Accepted"; Rec."Quantity Accepted")
                {
                    DrillDown = true;
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    var
                        ItemLedgEntry: Record "Item Ledger Entry";
                        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
                    begin
                        //B2BQC 1.1

                        Rec.CALCFIELDS("Quantity Under Inspection", "Quantity Rejected", "Quantity Rework", "Quantity Sent for Rework");
                        IF Rec."QC Enabled" = TRUE THEN BEGIN
                            IF (Rec."Quantity Under Inspection" = 0) AND (Rec."Quantity Rejected" = 0) AND (Rec."Quantity Rework" = 0) AND (Rec."Quantity Sent for Rework" = 0) THEN BEGIN
                                ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                                ItemLedgEntry.SETRANGE(Open, TRUE);
                                PAGE.RUNMODAL(38, ItemLedgEntry);
                            END ELSE BEGIN
                                ItemLedgEntry.RESET;
                                ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                                ItemLedgEntry.SETRANGE(Open, TRUE);
                                IF ItemLedgEntry.FINDSET THEN
                                    REPEAT
                                        ItemLedgEntry.MARK(TRUE);
                                        IF QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") THEN
                                            ItemLedgEntry.MARK(FALSE);
                                    UNTIL ItemLedgEntry.NEXT = 0;
                                ItemLedgEntry.MARKEDONLY(TRUE);
                                PAGE.RUNMODAL(38, ItemLedgEntry);
                            END;
                        END;
                    end;
                }
                field("Quantity Rework"; Rec."Quantity Rework")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Qty. on Service Order"; Rec."Qty. on Service Order")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Item Group"; Rec."Service Item Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Sample; Rec.Sample)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Costing Method"; Rec."Costing Method")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(AverageCostLCY; AverageCostLCY)
                {
                    AutoFormatType = 2;
                    Caption = 'Average Cost (LCY)';
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        CODEUNIT.RUN(CODEUNIT::"Show Avg. Calc. - Item", Rec);
                    end;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                /* field("Capital Item"; "Capital Item")
                 {
                     Editable = false;
                     ApplicationArea = All;*/
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            /*Sfield("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
            {
                ApplicationArea = All;
            }*/
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = All;
            }
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
            }
            field("Net Invoiced Qty."; Rec."Net Invoiced Qty.")
            {
                ApplicationArea = All;
            }
            field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
            {
                ApplicationArea = All;
            }
            field("Item Disc. Group"; Rec."Item Disc. Group")
            {
                ApplicationArea = All;
            }
            field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
            {
                ApplicationArea = All;
            }
            /*field("Excise Accounting Type"; "Excise Accounting Type")
             {
                 ApplicationArea = All;
             }
             field("Assessable Value"; "Assessable Value")
             {
                 ApplicationArea = All;
             }*/
            field("Tax Group Code"; Rec."Tax Group Code")
            {
                ApplicationArea = All;
            }
            group(GST)
            {
                Caption = 'GST';
                field("GST Group Code"; Rec."GST Group Code")
                {
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
                {
                    ApplicationArea = All;
                }
            }

            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Editable = false;
                    OptionCaption = 'Purchase,Prod. Order';
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                group(Production)
                {
                    Caption = 'Production';
                    field("Manufacturing Policy"; Rec."Manufacturing Policy")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Routing No."; Rec."Routing No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Production BOM No."; Rec."Production BOM No.")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Rounding Precision"; Rec."Rounding Precision")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Flushing Method"; Rec."Flushing Method")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Scrap %"; Rec."Scrap %")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Lot Size"; Rec."Lot Size")
                    {
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
            }
            group(Planning)
            {
                Caption = 'Planning';
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        EnablePlanningControls
                    end;
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    Editable = false;
                    Enabled = "Include InventoryEnable";
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Critical; Rec.Critical)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Type of Solder"; Rec."Type of Solder")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. of Soldering Points"; Rec."No. of Soldering Points")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. of Pins"; Rec."No. of Pins")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No.of Fixing Holes"; Rec."No.of Fixing Holes")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    Editable = false;
                    Enabled = "Reorder CycleEnable";
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    Editable = false;
                    Enabled = "Safety Lead TimeEnable";
                    ApplicationArea = All;
                }
                field("Lead Time Modified Date"; Rec."Lead Time Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    Editable = false;
                    Enabled = "Safety Stock QuantityEnable";
                    ApplicationArea = All;
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    Editable = false;
                    Enabled = "Reorder PointEnable";
                    ApplicationArea = All;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    Editable = false;
                    Enabled = "Reorder QuantityEnable";
                    ApplicationArea = All;
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    Editable = false;
                    Enabled = "Maximum InventoryEnable";
                    ApplicationArea = All;
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    Editable = false;
                    Enabled = "Minimum Order QuantityEnable";
                    ApplicationArea = All;
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    Editable = false;
                    Enabled = "Maximum Order QuantityEnable";
                    ApplicationArea = All;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    Editable = false;
                    Enabled = "Order MultipleEnable";
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Tariff No."; Rec."Tariff No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Item Tracking';
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Serial Nos."; Rec."Serial Nos.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Expiration Calculation"; Rec."Expiration Calculation")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Commerce Portal")
            {
                Caption = 'Commerce Portal';
                /* field(ProdOrderExist; ProdOrderExist)
                 {
                     Editable = false;
                     ApplicationArea = All;
                 }*/
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Put-away Unit of Measure Code"; Rec."Put-away Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Phys. Invt. Date"; Rec."Last Phys. Invt. Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Counting Period Update"; Rec."Last Counting Period Update")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Identifier Code"; Rec."Identifier Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group(Quality)
            {
                Caption = 'Quality';
                field("Spec ID"; Rec."Spec ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("QC Enabled"; Rec."QC Enabled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Insp. Time Inbound(In Min.)"; Rec."Insp. Time Inbound(In Min.)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("WIP Spec ID"; Rec."WIP Spec ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("WIP QC Enabled"; Rec."WIP QC Enabled")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Insp. Time WIP(In Min.)"; Rec."Insp. Time WIP(In Min.)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Quality")
            {
                Caption = '&Quality';
                group(Inspection)
                {
                    Caption = 'Inspection';
                    Image = QualificationOverview;
                    action("Inspection Data Sheets")
                    {
                        Caption = 'Inspection Data Sheets';
                        Image = Worksheet;
                        ApplicationArea = All;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;

                        trigger OnAction();
                        begin
                            Rec.ShowDataSheets;
                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = PostedShipment;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowPostDataSheets;
                        end;
                    }
                    action("Inspection &Receipts")
                    {
                        Caption = 'Inspection &Receipts';
                        Image = Receipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowInspectReceipt;
                        end;
                    }
                    action("Posted I&nspection Receipts")
                    {
                        Caption = 'Posted I&nspection Receipts';
                        Image = PostedReceipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowPostInspectReceipt;
                        end;
                    }
                }
                separator(Action1102152054)
                {
                }
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = CreateDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TESTFIELD("Quantity Accepted");
                        Rec.CreateInspectionDataSheets;
                    end;
                }
            }
            group("&Item")
            {
                Caption = '&Item';
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = ItemLedger;
                        RunObject = Page 38;
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Reservation Status", "Item No.", "Variant Code", "Location Code");
                        ApplicationArea = All;
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Quality Ledger Entries")
                    {
                        Caption = '&Quality Ledger Entries';
                        RunObject = Page "Quality Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(3, '', "No.", '', '', '', '');
                        end;
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Action107)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        ShortCutKey = 'F7';
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("Items b&y Location")
                {
                    Caption = 'Items b&y Location';
                    Image = ItemAvailbyLoc;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ItemsByLocation: Page "Items by Location";
                    begin
                        ItemsByLocation.SETRECORD(Rec);
                        ItemsByLocation.RUN;
                    end;
                }
                group("&Item Availability by")
                {
                    Caption = '&Item Availability by';
                    Image = ItemAvailability;
                    action(Period)
                    {
                        Caption = 'Period';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BOMLevel;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No."), "Unit of Measure Code" = FIELD("Base Unit of Measure");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    ApplicationArea = All;
                }
                separator(Action113)
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    RunObject = Page "Item Cross Reference Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    RunObject = Page 5726;
                    ApplicationArea = All;
                }
                separator(Action115)
                {
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page "Extended Text";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ApplicationArea = All;
                }
                separator(Action120)
                {
                }
                group("Assembly List")
                {
                    Caption = 'Assembly List';
                    Image = AssemblyBOM;
                    action("Bill of Materials")
                    {
                        Caption = 'Bill of Materials';
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem("No.", TRUE);
                        end;
                    }
                }
                group("Manufa&cturing")
                {
                    Caption = 'Manufa&cturing';
                    Image = Production;
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        Image = "Where-Used";
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action(Action123)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem("No.", FALSE);
                        end;
                    }
                }
                separator(Action182)
                {
                    Caption = '""';
                }
                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                group("Troubles&hooting")
                {
                    Caption = 'Troubles&hooting';
                    Image = Debug;
                    action("Troubleshooting &Setup")
                    {
                        Caption = 'Troubleshooting &Setup';
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action186)
                    {
                        Caption = 'Troubles&hooting';
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            TroubleshHeader.ShowForItem(Rec);
                        end;
                    }
                }
                group("R&esource")
                {
                    Caption = 'R&esource';
                    Image = Resource;
                    action("Resource Skills")
                    {
                        Caption = 'Resource Skills';
                        Image = ResourceSkills;
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Skilled Resources")
                    {
                        Caption = 'Skilled Resources';
                        Image = ResourceGroup;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CLEAR(SkilledResourceList);
                            //SkilledResourceList.InitializeForItem(Rec);//B@B
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }
                separator(Action217)
                {
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = SerialNo;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
                action(Specifications)
                {
                    Caption = 'Specifications';
                    Image = ItemVariant;
                    RunObject = Page "Item Specification";
                    RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        ItemSpecification: Record "Item Specification";
                        DuplicateItems: Record "Alternate Items";
                    begin
                        /*DuplicateItems.DELETEALL;
                        DuplicateItems.INIT;
                        REPEAT
                          DuplicateItems."Proudct Type" := ItemSpecification."Item No.";
                         // DuplicateItems."Specification Code" := ItemSpecification."Specification Code";
                          DuplicateItems."Item No." := ItemSpecification.Value;
                          DuplicateItems."Item Description" := ItemSpecification."Product Group Code";
                          DuplicateItems."Alternative Item No." := ItemSpecification."Item Category Code";
                          DuplicateItems."Alternative Item Description" := ItemSpecification."Item Sub Group Code";
                          DuplicateItems.Make := ItemSpecification."Item Sub Sub Group Code";
                          DuplicateItems.INSERT;
                        UNTIL ItemSpecification.NEXT = 0;*/

                    end;
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                Image = Sales;
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    ApplicationArea = All;
                }
                separator(Action46)
                {
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                Image = Purchasing;
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action85)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action86)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action47)
                {
                }
                action(Action87)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action(Action191)
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
                action("&Create Stockkeeping Unit")
                {
                    Caption = '&Create Stockkeeping Unit';
                    Image = CreateSKU;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Item: Record Item;
                    begin
                        Item.SETRANGE("No.", "No.");
                        REPORT.RUNMODAL(REPORT::"Create Stockkeeping Unit", TRUE, FALSE, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
                action("Update BOM")
                {
                    Caption = 'Update BOM';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.UpdateBOM;
                    end;
                }
            }
            action("Item Lead time not modified")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF USERID IN ['EFFTRONICS\RENUKACH', 'EFFTRONICS\PARDHU', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\MNRAJU'] THEN BEGIN
                        "Lead Time Modified Date" := TODAY;
                        MESSAGE('Modified');
                    END
                    ELSE
                        MESSAGE('You donot have rights to modify');
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
        EnablePlanningControls;
        //B2B
        IF ("QC Enabled" = TRUE) AND (Inventory >= 0) THEN
            "Quantity Accepted" := Inventory - ("Quantity Rejected" + "Quantity Under Inspection" + "Quantity Rework" +
                                                "Quantity Sent for Rework");
        //B2B
    end;

    trigger OnInit();
    begin
        "Include InventoryEnable" := TRUE;
        "Order MultipleEnable" := TRUE;
        "Maximum Order QuantityEnable" := TRUE;
        "Minimum Order QuantityEnable" := TRUE;
        "Maximum InventoryEnable" := TRUE;
        "Reorder QuantityEnable" := TRUE;
        "Reorder PointEnable" := TRUE;
        "Safety Stock QuantityEnable" := TRUE;
        "Safety Lead TimeEnable" := TRUE;
        "Reorder CycleEnable" := TRUE;
    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        ItemCostMgt: Codeunit ItemCostManagement;
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        ItemCostUpdation: Codeunit "Item Cost Updation";

        "Reorder CycleEnable": Boolean;

        "Safety Lead TimeEnable": Boolean;

        "Safety Stock QuantityEnable": Boolean;

        "Reorder PointEnable": Boolean;

        "Reorder QuantityEnable": Boolean;

        "Maximum InventoryEnable": Boolean;

        "Minimum Order QuantityEnable": Boolean;

        "Maximum Order QuantityEnable": Boolean;

        "Order MultipleEnable": Boolean;

        "Include InventoryEnable": Boolean;
        SkilledResourceList: Page "Skilled Resource List";


    procedure EnablePlanningControls();
    var
        PlanningGetParam: Codeunit "Planning-Get Parameters";
        ReorderCycleEnabled: Boolean;
        SafetyLeadTimeEnabled: Boolean;
        SafetyStockQtyEnabled: Boolean;
        ReorderPointEnabled: Boolean;
        ReorderQuantityEnabled: Boolean;
        MaximumInventoryEnabled: Boolean;
        MinimumOrderQtyEnabled: Boolean;
        MaximumOrderQtyEnabled: Boolean;
        OrderMultipleEnabled: Boolean;
        IncludeInventoryEnabled: Boolean;
        ReschedulingPeriodEnabled: Boolean;
        LotAccumulationPeriodEnabled: Boolean;
        DampenerPeriodEnabled: Boolean;
        DampenerQuantityEnabled: Boolean;
        OverflowLevelEnabled: Boolean;
    begin
        //B2b1.0>>
        /*PlanningGetParam.SetUpPlanningControls("Reordering Policy","Include Inventory",
          ReorderCycleEnabled,SafetyLeadTimeEnabled,SafetyStockQtyEnabled,
          ReorderPointEnabled,ReorderQuantityEnabled,MaximumInventoryEnabled,
          MinimumOrderQtyEnabled,MaximumOrderQtyEnabled,OrderMultipleEnabled,IncludeInventoryEnabled);*/

        PlanningGetParam.SetUpPlanningControls("Reordering Policy", "Include Inventory",
          ReorderCycleEnabled, SafetyLeadTimeEnabled, SafetyStockQtyEnabled,
          ReorderPointEnabled, ReorderQuantityEnabled, MaximumInventoryEnabled,
          MinimumOrderQtyEnabled, MaximumOrderQtyEnabled, OrderMultipleEnabled, IncludeInventoryEnabled, ReschedulingPeriodEnabled,
          LotAccumulationPeriodEnabled, DampenerPeriodEnabled, DampenerQuantityEnabled, OverflowLevelEnabled);
        //B2b1.0<<

        "Reorder CycleEnable" := ReorderCycleEnabled;
        "Safety Lead TimeEnable" := SafetyLeadTimeEnabled;
        "Safety Stock QuantityEnable" := SafetyStockQtyEnabled;
        "Reorder PointEnable" := ReorderPointEnabled;
        "Reorder QuantityEnable" := ReorderQuantityEnabled;
        "Maximum InventoryEnable" := MaximumInventoryEnabled;
        "Minimum Order QuantityEnable" := MinimumOrderQtyEnabled;
        "Maximum Order QuantityEnable" := MaximumOrderQtyEnabled;
        "Order MultipleEnable" := OrderMultipleEnabled;
        "Include InventoryEnable" := IncludeInventoryEnabled;

    end;


    local procedure AverageCostLCYOnActivate();
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
    end;
}

