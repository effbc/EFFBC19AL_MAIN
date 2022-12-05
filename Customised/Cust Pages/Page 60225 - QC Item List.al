page 60225 "QC Item List"
{
    // version NAVW13.70,NAVIN3.70.00.03,B2B1.0,Rev01

    Caption = 'Item List';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Item;
    SourceTableView = SORTING("Item Category Code", "Product Group Code Cust") ORDER(Ascending) WHERE("Product Group Code Cust" = FILTER(<> 'FPRODUCT & <> CPCB'), "Cs Stock Verified" = CONST(false), Blocked = CONST(false));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
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
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Sub Group Code"; Rec."Item Sub Group Code")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Product Group Code Cust"; "Product Group Code Cust")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Revised Sampling Count"; Rec."Revised Sampling Count")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Revised Sampling Count" > 0) AND (Rec."Revised Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Revised Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Revised Sampling Percentage"; Rec."Revised Sampling Percentage")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Revised Sampling Count" > 0) AND (Rec."Revised Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Revised Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Revised Sampling Time Mins"; Rec."Revised Sampling Time Mins")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Visual Sampling Count"; Rec."Visual Sampling Count")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Visual Sampling Count" > 0) AND (Rec."Visual Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Visual Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Visual Sampling Percentage"; Rec."Visual Sampling Percentage")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Visual Sampling Count" > 0) AND (Rec."Visual Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Visual Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Visual Sampling Time Mins"; Rec."Visual Sampling Time Mins")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Dimensions Sampling Count"; Rec."Dimensions Sampling Count")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Dimensions Sampling Count" > 0) AND (Rec."Dimensions Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Dimensions Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage');
                    end;
                }
                field("Dimensions Sampling Percentage"; Rec."Dimensions Sampling Percentage")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Dimensions Sampling Count" > 0) AND (Rec."Dimensions Sampling Percentage" > 0) THEN
                            ERROR('You can not enter both Dimensions Sampling Count and  Sampling Percentage. Either enter sampling Count or Sampling Percentage');
                    end;
                }
                field("Dimensions Sampling Time Mins"; Rec."Dimensions Sampling Time Mins")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Basic Functional Sampling Cnt"; Rec."Basic Functional Sampling Cnt")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Basic Functional Sampling Cnt" > 0) AND (Rec."Basic Functional Sampling Per" > 0) THEN
                            ERROR('You can not enter both Basic Functional Sampling Count and Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Basic Functional Sampling Per"; Rec."Basic Functional Sampling Per")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Basic Functional Sampling Cnt" > 0) AND (Rec."Basic Functional Sampling Per" > 0) THEN
                            ERROR('You can not enter both Basic Functional Sampling Count and Sampling Percentage. Either enter sampling Count or Sampling Percentage!');
                    end;
                }
                field("Basic Func Sampling Time -Mins"; Rec."Basic Func Sampling Time -Mins")
                {
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Sampling %"; Rec."Sampling %")
                {
                    Caption = 'Full  functional Sampling %';
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Sampling Count"; Rec."Sampling Count")
                {
                    Caption = 'Full  functional Sampling Cnt';
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Inspection Bench Mark(In Min)"; Rec."Inspection Bench Mark(In Min)")
                {
                    Caption = 'Full  functional Sampling Time';
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Documentation Time"; Rec."Documentation Time")
                {
                    ApplicationArea = All;
                }
            }
            field("xRec.COUNT"; xRec.COUNT)
            {
                Editable = false;
                ApplicationArea = All;
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
                        Image = OpenWorksheet;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowDataSheets;
                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = PostedTaxInvoice;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowPostDataSheets;
                        end;
                    }
                    action("Inspection &Receipts")
                    {
                        Caption = 'Inspection &Receipts';
                        Image = NewReceipt;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowInspectReceipt;
                        end;
                    }
                    action("Posted I&nspection Receipts")
                    {
                        Caption = 'Posted I&nspection Receipts';
                        Image = PostedReceipts;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            Rec.ShowPostInspectReceipt;
                        end;
                    }
                }
                separator(Action1102152074)
                {
                }
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = NewToDo;
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
                        RunObject = Page "Item Ledger Entries";
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
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(3, '', Rec."No.", '', '', '', '');
                        end;
                    }
                }
                group(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    action(Action1102152062)
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
                    Image = BinContent;
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
                separator(Action1102152050)
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
                    Image = Text;
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
                action("Alternative Items")
                {
                    Caption = 'Alternative Items';
                    Image = ItemVariant;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Alternate Item".SETRANGE("Alternate Item"."Item No.", Rec."No.");
                        PAGE.RUN(60070, "Alternate Item");
                    end;
                }
                separator(Action1102152042)
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
                separator(Action1102152039)
                {
                }
                group("Assembly List")
                {
                    Caption = 'Assembly List';
                    Image = Production;
                    action("Bill of Materials")
                    {
                        Caption = 'Bill of Materials';
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        Image = "Where-Used";
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem(Rec."No.", TRUE);
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
                            ProdBOMWhereUsed: Page "Prod. BOM Where-Used";
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action(Action1102152032)
                    {
                        Caption = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem(Rec."No.", FALSE);
                        end;
                    }
                }
                separator(Action1102152031)
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
                    Image = Troubleshoot;
                    action("Troubleshooting &Setup")
                    {
                        Caption = 'Troubleshooting &Setup';
                        Image = Troubleshoot;
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action1102152027)
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
                        RunObject = Page "Resource Skills";
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
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
                }
                separator(Action1102152023)
                {
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = BarCode;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
                action(Specifications)
                {
                    Caption = 'Specifications';
                    Image = Versions;
                    RunObject = Page "Item Specification";
                    RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                    ApplicationArea = All;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    RunObject = Page "ESPL Attachments";
                    RunPageLink = "Table ID" = CONST(27), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Design Work Sheet")
                {
                    Caption = 'Design Work Sheet';
                    Image = PlanningWorksheet;
                    RunObject = Page "Item Design WorkSheet Header";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
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
                separator(Action1102152015)
                {
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = "Order";
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
                action(Action1102152010)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action1102152009)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action1102152008)
                {
                }
                action(Action1102152007)
                {
                    Caption = 'Orders';
                    Image = "Order";
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action(Action1102152006)
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
                        Item.SETRANGE("No.", Rec."No.");
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
                action("Update BOM Cost")
                {
                    Caption = 'Update BOM Cost';
                    Image = UpdateUnitCost;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.UpdateBOMCost;
                    end;
                }
                action("Update Routing Cost")
                {
                    Caption = 'Update Routing Cost';
                    Image = UpdateUnitCost;
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
    end;

    trigger OnOpenPage();
    begin
        User.SETFILTER("User ID", USERID); //Rev01 //B2BUPG
        IF User.FINDFIRST THEN
            REPEAT
                IF ((User.Dept = 'PROD') OR (User.Dept = 'P1') OR (User.Dept = 'P2') OR
                (User.Dept = 'P3') OR (User.Dept = 'P4') OR (User.Dept = 'STR') OR
                (User.Dept = 'QC') OR (User.Dept = 'SHF')) THEN
                    Rec.SETFILTER("Item Location", 'PROD');
            UNTIL User.NEXT = 0;

        // Restricting the users for modifications
        IF SMTP_MAIL.Permission_Checking(USERID, 'INWARDS-PLANNING') THEN
            Page_Edit := TRUE
        ELSE
            Page_Edit := FALSE;
    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        ItemCostMgt: Codeunit ItemCostManagement;
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        "Inventory at STR": Decimal;
        "--B2B--": Integer;
        PurchaseInvLine: Record "Purch. Inv. Line";
        TotVendorAmt: Decimal;
        TotQty: Decimal;
        ItemCostUpdation: Codeunit "Item Cost Updation";
        atta: Boolean;
        attachments: Record Attachments;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        StockAtMCH: Decimal;
        "Alternate Item": Record "Alternate Items";
        SkilledResourceList: Page "Skilled Resource List";
        User: Record "User Setup";
        Page_Edit: Boolean;
        SMTP_MAIL: Codeunit "Custom Events";


    procedure GetSelectionFilter(): Code[80];
    var
        Item: Record Item;
        FirstItem: Code[30];
        LastItem: Code[30];
        SelectionFilter: Code[250];
        ItemCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        ItemCount := Item.COUNT;
        IF ItemCount > 0 THEN BEGIN
            Item.FINDFIRST;
            WHILE ItemCount > 0 DO BEGIN
                ItemCount := ItemCount - 1;
                Item.MARKEDONLY(FALSE);
                FirstItem := Item."No.";
                LastItem := FirstItem;
                More := (ItemCount > 0);
                WHILE More DO
                    IF Item.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT Item.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastItem := Item."No.";
                            ItemCount := ItemCount - 1;
                            IF ItemCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstItem = LastItem THEN
                    SelectionFilter := SelectionFilter + FirstItem
                ELSE
                    SelectionFilter := SelectionFilter + FirstItem + '..' + LastItem;
                IF ItemCount > 0 THEN BEGIN
                    Item.MARKEDONLY(TRUE);
                    Item.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;
}

