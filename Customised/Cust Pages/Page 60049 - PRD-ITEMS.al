page 60049 "PRD-ITEMS"
{
    // version NAVW13.70,NAVIN3.70.01.11,QC1.0,QCB2B1.2,B2B1.0,QC1.2,DWS1.0,Rev01

    Caption = 'Item Card';
    Editable = false;
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
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Common Item No."; Rec."Common Item No.")
                {
                    Caption = 'Description3(Physical)';
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code Cust")
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
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Inventory at Stores"; Rec."Inventory at Stores")
                {
                    ApplicationArea = All;
                }
                field("Quantity Under Inspection"; Rec."Quantity Under Inspection")
                {
                    ApplicationArea = All;
                }
                field("Quantity Sent for Rework"; Rec."Quantity Sent for Rework")
                {
                    ApplicationArea = All;
                }
                field("Quantity Rejected"; Rec."Quantity Rejected")
                {
                    ApplicationArea = All;
                }
                field("Quantity Accepted"; Rec."Quantity Accepted")
                {
                    DrillDown = true;
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
                                ItemLedgEntry.RESET;
                                ItemLedgEntry.SETCURRENTKEY("Location Code", Open, "Item No.");
                                ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                                ItemLedgEntry.SETRANGE(Open, TRUE);
                                PAGE.RUNMODAL(38, ItemLedgEntry);
                            END ELSE BEGIN
                                ItemLedgEntry.RESET;
                                //New line added on 140108
                                ItemLedgEntry.SETCURRENTKEY("Location Code", Open, "Item No.");
                                //New line added on 140108
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
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Component Lines"; Rec."Qty. on Component Lines")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Qty. on Service Order"; Rec."Qty. on Service Order")
                {
                    ApplicationArea = All;
                }
                field("Service Item Group"; Rec."Service Item Group")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field(Sample; Rec.Sample)
                {
                    ApplicationArea = All;
                }
            }
            group(Invoicing)
            {
                Caption = 'Invoicing';
                field("Costing Method"; Rec."Costing Method")
                {
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
                    ApplicationArea = All;
                }
                field("Avg Unit Cost"; Rec."Avg Unit Cost")
                {
                    Caption = 'Unit cost.';
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                 {
                     ApplicationArea = All;
                 }*/
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
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
                /* field("Excise Accounting Type"; "Excise Accounting Type")
                 {
                     ApplicationArea = All;
                 }*/
                /*  field("Assessable Value"; "Assessable Value")
                  {
                      ApplicationArea = All;
                  }*/ //B2BUPG
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                /*  field("Capital Item"; "Capital Item")
                  {
                      ApplicationArea = All;
                  }*/ //B2BUPG
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System"; Rec."Replenishment System")
                {
                    OptionCaption = 'Purchase,Prod. Order';
                    ApplicationArea = All;
                }
                group(Purchase)
                {
                    Caption = 'Purchase';
                    field("Vendor No."; Rec."Vendor No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Vendor Item No."; Rec."Vendor Item No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                    {
                        ApplicationArea = All;
                    }
                    field("Lead Time Calculation"; Rec."Lead Time Calculation")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Production)
                {
                    Caption = 'Production';
                    field("Manufacturing Policy"; Rec."Manufacturing Policy")
                    {
                        ApplicationArea = All;
                    }
                    field("Routing No."; Rec."Routing No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Production BOM No."; Rec."Production BOM No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Rounding Precision"; Rec."Rounding Precision")
                    {
                        ApplicationArea = All;
                    }
                    field("Flushing Method"; Rec."Flushing Method")
                    {
                        ApplicationArea = All;
                    }
                    field("Scrap %"; Rec."Scrap %")
                    {
                        ApplicationArea = All;
                    }
                    field("Lot Size"; Rec."Lot Size")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Planning)
            {
                Caption = 'Planning';
                field("Reordering Policy"; Rec."Reordering Policy")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        EnablePlanningControls
                    end;
                }
                field("Include Inventory"; Rec."Include Inventory")
                {
                    Enabled = "Include InventoryEnable";
                    ApplicationArea = All;
                }
                field(Reserve; Rec.Reserve)
                {
                    ApplicationArea = All;
                }
                field("Order Tracking Policy"; Rec."Order Tracking Policy")
                {
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    ApplicationArea = All;
                }
                field(Critical; Rec.Critical)
                {
                    ApplicationArea = All;
                }
                field("Type of Solder"; Rec."Type of Solder")
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
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ApplicationArea = All;
                }
                field("No.of Fixing Holes"; Rec."No.of Fixing Holes")
                {
                    ApplicationArea = All;
                }
                field("Time Bucket"; Rec."Time Bucket")
                {
                    Enabled = "Reorder CycleEnable";
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    Enabled = "Safety Lead TimeEnable";
                    ApplicationArea = All;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    Enabled = "Safety Stock QuantityEnable";
                    ApplicationArea = All;
                }
                field("Reorder Point"; Rec."Reorder Point")
                {
                    Enabled = "Reorder PointEnable";
                    ApplicationArea = All;
                }
                field("Reorder Quantity"; Rec."Reorder Quantity")
                {
                    Enabled = "Reorder QuantityEnable";
                    ApplicationArea = All;
                }
                field("Maximum Inventory"; Rec."Maximum Inventory")
                {
                    Enabled = "Maximum InventoryEnable";
                    ApplicationArea = All;
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    Enabled = "Minimum Order QuantityEnable";
                    ApplicationArea = All;
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    Enabled = "Maximum Order QuantityEnable";
                    ApplicationArea = All;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    Enabled = "Order MultipleEnable";
                    ApplicationArea = All;
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("Tariff No."; Rec."Tariff No.")
                {
                    ApplicationArea = All;
                }
                field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Item Tracking")
            {
                Caption = 'Item Tracking';
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    ApplicationArea = All;
                }
                field("Serial Nos."; Rec."Serial Nos.")
                {
                    ApplicationArea = All;
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    ApplicationArea = All;
                }
                field("Expiration Calculation"; Rec."Expiration Calculation")
                {
                    ApplicationArea = All;
                }
            }
            group("Commerce Portal")
            {
                Caption = 'Commerce Portal';
                /* field(ProdOrderExist; ProdOrderExist)
                 {
                     ApplicationArea = All;
                 }*/
            }
            group(Warehouse)
            {
                Caption = 'Warehouse';
                field("Special Equipment Code"; Rec."Special Equipment Code")
                {
                    ApplicationArea = All;
                }
                field("Put-away Template Code"; Rec."Put-away Template Code")
                {
                    ApplicationArea = All;
                }
                field("Put-away Unit of Measure Code"; Rec."Put-away Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Phys Invt Counting Period Code"; Rec."Phys Invt Counting Period Code")
                {
                    ApplicationArea = All;
                }
                field("Last Phys. Invt. Date"; Rec."Last Phys. Invt. Date")
                {
                    ApplicationArea = All;
                }
                field("Last Counting Period Update"; Rec."Last Counting Period Update")
                {
                    ApplicationArea = All;
                }
                field("Identifier Code"; Rec."Identifier Code")
                {
                    ApplicationArea = All;
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    ApplicationArea = All;
                }
            }
            group(Quality)
            {
                Caption = 'Quality';
                field("Spec ID"; Rec."Spec ID")
                {
                    ApplicationArea = All;
                }
                field("QC Enabled"; Rec."QC Enabled")
                {
                    ApplicationArea = All;
                }
                field("Insp. Time Inbound(In Min.)"; Rec."Insp. Time Inbound(In Min.)")
                {
                    ApplicationArea = All;
                }
                field("WIP Spec ID"; Rec."WIP Spec ID")
                {
                    ApplicationArea = All;
                }
                field("WIP QC Enabled"; Rec."WIP QC Enabled")
                {
                    ApplicationArea = All;
                }
                field("Insp. Time WIP(In Min.)"; Rec."Insp. Time WIP(In Min.)")
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
            group("&Quality")
            {
                Caption = '&Quality';
                group(Inspection)
                {
                    Caption = 'Inspection';
                    Image = InsertBalanceAccount;
                    action("Inspection Data Sheets")
                    {
                        Caption = 'Inspection Data Sheets';
                        Image = Worksheet;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowDataSheets;
                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = PostedTimeSheet;
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
                    Image = NewTimesheet;
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
                Image = Item;
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page 5701;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;

                    RunPageView = SORTING("Item No.");
                }
                group("E&ntries")
                {
                    Caption = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        Caption = 'Ledger E&ntries';
                        Image = LedgerEntries;
                        RunObject = Page 38;
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F5';
                        ApplicationArea = All;
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = GetEntries;
                        RunObject = Page 497;
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Reservation Status", "Item No.", "Variant Code", "Location Code");
                        ApplicationArea = All;
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = WIPEntries;
                        RunObject = Page 390;
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = LedgerEntries;
                        RunObject = Page 5802;
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Quality Ledger Entries")
                    {
                        Caption = '&Quality Ledger Entries';
                        Image = VATEntries;
                        RunObject = Page "Quality Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Item &Tracking Entries")
                    {
                        Caption = 'Item &Tracking Entries';
                        Image = ItemTrackingLines;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ItemTrackingDocMgt: Codeunit 6503;
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
                            ItemStatistics: Page 5827;
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RUNMODAL;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page 304;
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(TurnOver)
                    {
                        Caption = 'TurnOver';
                        Image = Turnover;
                        RunObject = Page 158;
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
                        ItemsByLocation: Page 491;
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
                        RunObject = Page 157;
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page 5414;
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = ItemAvailbyLoc;
                        RunObject = Page 492;
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page 7379;
                    RunPageLink = "Item No." = FIELD("No."), "Unit of Measure Code" = FIELD("Base Unit of Measure");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page 346;
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
                    RunObject = Page 5404;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = VariableList;
                    RunObject = Page 5401;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    Image = ContactReference;
                    RunObject = Page 5721;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page 5716;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    ApplicationArea = All;
                    //RunObject = Page "Nonstock Item List"; //Removed BC
                }
                separator(Action115)
                {
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = Page 35;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page 386;
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
                    Image = List;
                    action("Bill of Materials")
                    {
                        Caption = 'Bill of Materials';
                        Image = BOM;
                        RunObject = Page 36;
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        Image = "Where-Used";
                        RunObject = Page 37;
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = GetStandardJournal;
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
                    Image = SalesPerson;
                    action("Where-Used")
                    {
                        Caption = 'Where-Used';
                        Image = "Where-Used";
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ProdBOMWhereUsed: Page 99000811;
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action(Action123)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = GetStandardJournal;
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
                    Image = ServiceLines;
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                group("Troubles&hooting")
                {
                    Caption = 'Troubles&hooting';
                    Image = Troubleshoot;
                    action("Troubleshooting &Setup")
                    {
                        Caption = 'Troubleshooting &Setup';
                        Image = Troubleshoot;
                        RunObject = Page 5993;
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action186)
                    {
                        Caption = 'Troubles&hooting';
                        Image = Troubleshoot;
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
                        RunObject = Page 6019;
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Skilled Resources")
                    {
                        Caption = 'Skilled Resources';
                        Image = ResourceSkills;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CLEAR(SkilledResourceList);
                            //SkilledResourceList.InitializeForItem(Rec);
                            //SkilledResourceList.RUNMODAL;
                            // code was commented for Navision Upgradation
                        end;
                    }
                }
                separator(Action217)
                {
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = ItemLines;
                    RunObject = Page 7706;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
                action(Specifications)
                {
                    Caption = 'Specifications';
                    Image = ItemVariant;
                    RunObject = Page "Item Specification";
                    RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
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
                        //  DuplicateItems."Specification Code" := ItemSpecification."Specification Code";
                        // code was commented For Navision Upgradation
                          DuplicateItems."Item No." := ItemSpecification.Value;
                          DuplicateItems."Item Description" := ItemSpecification."Product Group Code";
                          DuplicateItems."Alternative Item No." := ItemSpecification."Item Category Code";
                          DuplicateItems."Alternative Item Description" := ItemSpecification."Item Sub Group Code";
                          DuplicateItems.Make := ItemSpecification."Item Sub Sub Group Code";
                          DuplicateItems.INSERT;
                        UNTIL ItemSpecification.NEXT = 0;*/

                    end;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    RunObject = Page 60117;
                    RunPageLink = "Table ID" = CONST(27), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Design Work Sheet")
                {
                    Caption = 'Design Work Sheet';
                    Image = Worksheet;
                    RunObject = Page "Item Design WorkSheet Header";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group("S&ales")
            {
                Caption = 'S&ales';
                action(Prices)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7002;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7004;
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
                    Image = "Order";
                    RunObject = Page 48;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page 6633;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group("&Purchases")
            {
                Caption = '&Purchases';
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page 114;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action85)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page 7012;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action86)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page 7014;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action47)
                {
                }
                action(Action87)
                {
                    Caption = 'Orders';
                    Image = "Order";
                    RunObject = Page 56;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action(Action191)
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page 6643;
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
                    Image = AccountingPeriods;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PhysInvtCountMgt: Codeunit 7380;
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
                action("Update BOM Cost")
                {
                    Caption = 'Update BOM Cost';
                    Image = BOM;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.UpdateBOMCost;
                    end;
                }
                action("Update Routing Cost")
                {
                    Caption = 'Update Routing Cost';
                    Image = ExplodeRouting;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.RoutingCostUpdation;
                    end;
                }
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
        /*
        PurchaseInvLine.RESET;
        PurchaseInvLine.SETCURRENTKEY(Type,"No.","Variant Code");
        PurchaseInvLine.SETRANGE(Type,PurchaseInvLine.Type::Item);
        PurchaseInvLine.SETRANGE("No.","No.");
        IF PurchaseInvLine.FINDSET THEN
          REPEAT
            TotQty+=PurchaseInvLine.Quantity;
            TotVendorAmt+=PurchaseInvLine."Amount To Vendor";
          UNTIL PurchaseInvLine.NEXT=0;
        IF TotVendorAmt<>0 THEN
          "Avg Unit Cost":=TotVendorAmt/TotQty;
        //B2B
         */
        //B2B
        CALCFIELDS("Inventory at Stores");
        CALCFIELDS("Quantity Rejected");
        "Inventory at STR" := "Inventory at Stores" - ("Quantity Under Inspection" + "Quantity Rejected");
        CALCFIELDS("Quantity Under Inspection");

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

    trigger OnOpenPage();
    begin
        CALCFIELDS("Inventory at Stores");
        CALCFIELDS("Quantity Under Inspection");
        CALCFIELDS("Quantity Rejected");
        "Inventory at STR" := "Inventory at Stores" - ("Quantity Under Inspection" + "Quantity Rejected");
    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        ItemCostMgt: Codeunit 5804;
        CalculateStdCost: Codeunit 5812;
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        "Inventory at STR": Decimal;
        "--B2B--": Integer;
        PurchaseInvLine: Record "Purch. Inv. Line";
        TotVendorAmt: Decimal;
        TotQty: Decimal;
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
        SkilledResourceList: Page 6023;


    procedure EnablePlanningControls();
    var
        PlanningGetParam: Codeunit 99000855;
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
        ItemCostUpdation.RUN;
    end;
}

