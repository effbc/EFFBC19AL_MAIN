page 60172 "Item List(Manu)"
{
    // version Rev01

    // <changelog>
    //     <change releaseversion="IN6.00"/>
    // </changelog>

    CaptionML = ENU = 'Item List',
                ENN = 'Item List';
    CardPageID = "Item Card (manu)";
    Editable = true;
    PageType = List;
    ShowFilter = true;
    SourceTable = Item;
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
                    StyleExpr = "No.Format";
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Style = Ambiguous;
                    StyleExpr = DescriptionEmphasize;
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field(Package; Rec.Package)
                {
                    ApplicationArea = All;
                }
                field(EFF_MOQ; Rec.EFF_MOQ)
                {
                    ApplicationArea = All;
                }
                field("Stock at RD Stores"; Rec."Stock at RD Stores")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Common Item No.";"Common Item No.")
                {
                    Caption = 'Description 3';
                    ApplicationArea = All;
                }
                field("Hazardous Item";"Hazardous Item")
                {
                    ApplicationArea = All;
                }
                field("Packing Dimension"; Rec."Packing Dimension")
                {
                    ApplicationArea = All;
                }
                field("Stock at CS Stores"; Rec."Stock at CS Stores")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stock at PROD Stores"; Rec."Stock at PROD Stores")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Final Cost"; Rec."Item Final Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Location"; Rec."Item Location")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Part Number"; Rec."Part Number")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quantity Rejected"; Rec."Quantity Rejected")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Operating Temperature"; Rec."Operating Temperature")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Storage Temperature"; Rec."Storage Temperature")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Humidity; Rec.Humidity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("ESD Sensitive"; Rec."ESD Sensitive")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Standard Packing Quantity"; Rec."Standard Packing Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Minimum Order Quantity"; Rec."Minimum Order Quantity")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Item Status"; Rec."Item Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ApplicationArea = All;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Safety Stock Qty (CS)"; Rec."Safety Stock Qty (CS)")
                {
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(ESD; Rec.ESD)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Soldering Time (Sec)"; Rec."Soldering Time (Sec)")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Work area Temp &  Humadity"; Rec."Work area Temp &  Humadity")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Soldering Temp."; Rec."Soldering Temp.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Stockkeeping Unit Exists"; Rec."Stockkeeping Unit Exists")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Substitutes Exist"; Rec."Substitutes Exist")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Costing Method"; Rec."Costing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Cost is Adjusted"; Rec."Cost is Adjusted")
                {
                    ApplicationArea = All;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Last Direct Cost"; Rec."Last Direct Cost")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Price/Profit Calculation"; Rec."Price/Profit Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Profit %"; Rec."Profit %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    Editable = false;
                    Visible = false;
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
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tariff No."; Rec."Tariff No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code Cust")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Purch. Unit of Measure"; Rec."Purch. Unit of Measure")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Manufacturing Policy"; Rec."Manufacturing Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Assembly Policy"; Rec."Assembly Policy")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("No.of Units"; Rec."No.of Units")
                {
                    ApplicationArea = All;
                }
                field(PROD_USED; Rec.PROD_USED)
                {
                    ApplicationArea = All;
                }
                field("Quantity Under Inspection"; Rec."Quantity Under Inspection")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Created From Nonstock Item"; Rec."Created From Nonstock Item")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Stock At MCH Location"; Rec."Stock At MCH Location")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Item_verified; Rec.Item_verified)
                {
                    ApplicationArea = All;
                }
                field(PCB; Rec.PCB)
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Avg Unit Cost"; Rec."Avg Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("No.of Fixing Holes"; Rec."No.of Fixing Holes")
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Inventory at Stores"; Rec."Inventory at Stores")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                /*field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                    ApplicationArea = All;
                }*/
                field("QC Enabled"; Rec."QC Enabled")
                {
                    ApplicationArea = All;
                }
                field("Spec ID"; Rec."Spec ID")
                {
                    ApplicationArea = All;
                }
                field("WIP QC Enabled"; Rec."WIP QC Enabled")
                {
                    ApplicationArea = All;
                }
                field("WIP Spec ID"; Rec."WIP Spec ID")
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
                field("No. of Pins"; Rec."No. of Pins")
                {
                    ApplicationArea = All;
                }
                field("No. of Soldering Points"; Rec."No. of Soldering Points")
                {
                    ApplicationArea = All;
                }
                field("Type of Solder"; Rec."Type of Solder")
                {
                    ApplicationArea = All;
                }
                field("PCB thickness"; Rec."PCB thickness")
                {
                    ApplicationArea = All;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    ApplicationArea = All;
                }
                field("PCB Shape"; Rec."PCB Shape")
                {
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    ApplicationArea = All;
                }
                field("Surface Finish"; Rec."Surface Finish")
                {
                    ApplicationArea = All;
                }
                field("Semi Mounted"; Rec."Semi Mounted")
                {
                    ApplicationArea = All;
                }
                field("No. of Opportunities"; Rec."No. of Opportunities")
                {
                    ApplicationArea = All;
                }
                /* field("Capital Item"; "Capital Item")
                 {
                     ApplicationArea = All;
                 }*/
                field("On C-Side"; Rec."On C-Side")
                {
                    Caption = 'C-side Solder Mask';
                    ApplicationArea = All;
                }
                field("On D-Side"; Rec."On D-Side")
                {
                    Caption = 'D-side Solder Mask';
                    ApplicationArea = All;
                }
                field("On S-Side"; Rec."On S-Side")
                {
                    Caption = 'S-side Solder Mask';
                    ApplicationArea = All;
                }
                field("Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
                {
                    ApplicationArea = All;
                }
                field(ROHS; Rec.ROHS)
                {
                    ApplicationArea = All;
                }
                field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
                {
                    ApplicationArea = All;
                }
                field("CS IGC"; Rec."CS IGC")
                {
                    ApplicationArea = All;
                }
                field("Item Grp Verified Date"; Rec."Item Grp Verified Date")
                {
                    ApplicationArea = All;
                }
                field(Sample; Rec.Sample)
                {
                    ApplicationArea = All;
                }
                field("BIN Address"; Rec."BIN Address")
                {
                    ApplicationArea = All;
                }
                field("Stock Address"; Rec."Stock Address")
                {
                    ApplicationArea = All;
                }
                field("Stock at Stores"; Rec."Stock at Stores")
                {
                    ApplicationArea = All;
                }
                field(MSL; Rec.MSL)
                {
                    ApplicationArea = All;
                }
                field("ESD Class"; Rec."ESD Class")
                {
                    ApplicationArea = All;
                }
                field("Feeder Packing Width(mm)"; Rec."Feeder Packing Width(mm)")
                {
                    ApplicationArea = All;
                }
                field("Feeder Packing Type"; Rec."Feeder Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Floor Life at 25 C 40% RH"; Rec."Floor Life at 25 C 40% RH")
                {
                    ApplicationArea = All;
                }
                field("Bake Hours"; Rec."Bake Hours")
                {
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Years)"; Rec."Component Shelf Life(Years)")
                {
                    ApplicationArea = All;
                }
                /* field("MRP Price"; "MRP Price")
                 {
                     ApplicationArea = All;
                 }*/
                field("Dispatch Material"; Rec."Dispatch Material")
                {
                    ApplicationArea = All;
                }
                field("Thickness of Package"; Rec."Thickness of Package")
                {
                    ApplicationArea = All;
                }
                field(Stock_Threshold_Value; Rec.Stock_Threshold_Value)
                {
                    ApplicationArea = All;
                }
                field("Quote Item"; Rec."Quote Item")
                {
                    ApplicationArea = All;
                }
                field("Next Counting Start Date"; Rec."Next Counting Start Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152011)
            {
                ShowCaption = false;
                grid(Control1102152010)
                {
                    ShowCaption = false;
                    group(Control1102152008)
                    {
                        ShowCaption = false;
                        field("Rec.COUNT"; Rec.COUNT)
                        {
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152007)
                    {
                        ShowCaption = false;
                        field(Color_QCflag; Color_QCflag)
                        {
                            Editable = false;
                            Style = Unfavorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152005)
                    {
                        ShowCaption = false;
                        field(Color_Attachment; Color_Attachment)
                        {
                            Editable = false;
                            Style = StrongAccent;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152002)
                    {
                        ShowCaption = false;
                        field(Color_obsolete; Color_obsolete)
                        {
                            Editable = false;
                            Style = Ambiguous;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152042)
                    {
                        ShowCaption = false;
                        field(bom_status_running; bom_status_running)
                        {
                            Style = Favorable;
                            StyleExpr = TRUE;
                            ApplicationArea = All;
                        }
                    }
                    group(Control1102152045)
                    {
                        ShowCaption = false;
                        field(bom_status_old; bom_status_old)
                        {
                            Style = Subordinate;
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
        area(navigation)
        {
            group(Availability)
            {
                CaptionML = ENU = 'Availability',
                            ENN = 'Availability';
                Image = Item;
                action("Items b&y Location")
                {
                    CaptionML = ENU = 'Items b&y Location',
                                ENN = 'Items b&y Location';
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
                    CaptionML = ENU = '&Item Availability by',
                                ENN = '&Item Availability by';
                    Image = ItemAvailability;
                    action("<Action5>")
                    {
                        CaptionML = ENU = 'Event',
                                    ENN = 'Event';
                        Image = "Event";
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        CaptionML = ENU = 'Period',
                                    ENN = 'Period';
                        Image = Period;
                        RunObject = Page "Item Availability by Periods";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Variant)
                    {
                        CaptionML = ENU = 'Variant',
                                    ENN = 'Variant';
                        Image = ItemVariant;
                        RunObject = Page "Item Availability by Variant";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Location)
                    {
                        CaptionML = ENU = 'Location',
                                    ENN = 'Location';
                        Image = Warehouse;
                        RunObject = Page "Item Availability by Location";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("BOM Level")
                    {
                        CaptionML = ENU = 'BOM Level',
                                    ENN = 'BOM Level';
                        Image = BOMLevel;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromItem(Rec, ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                    action(Timeline)
                    {
                        CaptionML = ENU = 'Timeline',
                                    ENN = 'Timeline';
                        Image = Timeline;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            ShowTimelineFromItem(Rec);
                        end;
                    }
                }
            }
            group("Master Data")
            {
                CaptionML = ENU = 'Master Data',
                            ENN = 'Master Data';
                Image = DataEntry;
                action("&Units of Measure")
                {
                    CaptionML = ENU = '&Units of Measure',
                                ENN = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = Page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Va&riants")
                {
                    CaptionML = ENU = 'Va&riants',
                                ENN = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = Page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                group(Dimensions)
                {
                    CaptionML = ENU = 'Dimensions',
                                ENN = 'Dimensions';
                    Image = Dimensions;
                    action("Dimensions-Single")
                    {
                        CaptionML = ENU = 'Dimensions-Single',
                                    ENN = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID" = CONST(27), "No." = FIELD("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                        ApplicationArea = All;
                    }
                    action("Dimensions-&Multiple")
                    {
                        CaptionML = ENU = 'Dimensions-&Multiple',
                                    ENN = 'Dimensions-&Multiple';
                        Image = DimensionSets;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            Item: Record Item;
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SETSELECTIONFILTER(Item);
                            DefaultDimMultiple.SetMultiRecord(Item, FieldNo("No."));//EFFUPG
                            DefaultDimMultiple.RunModal;

                        end;
                    }
                }
                action("Substituti&ons")
                {
                    CaptionML = ENU = 'Substituti&ons',
                                ENN = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = Page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Cross Re&ferences")
                {
                    CaptionML = ENU = 'Cross Re&ferences',
                                ENN = 'Cross Re&ferences';
                    Image = Change;
                    RunObject = Page "Item Cross Reference Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("E&xtended Texts")
                {
                    CaptionML = ENU = 'E&xtended Texts',
                                ENN = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ApplicationArea = All;


                }
                action(Translations)
                {
                    CaptionML = ENU = 'Translations',
                                ENN = 'Translations';
                    Image = Translations;
                    RunObject = Page "Item Translations";
                    RunPageLink = "Item No." = FIELD("No."), "Variant Code" = CONST();
                    ApplicationArea = All;
                }
                action("&Picture")
                {
                    CaptionML = ENU = '&Picture',
                                ENN = '&Picture';
                    Image = Picture;
                    RunObject = Page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    ApplicationArea = All;
                }
                action(Identifiers)
                {
                    CaptionML = ENU = 'Identifiers',
                                ENN = 'Identifiers';
                    Image = BarCode;
                    RunObject = Page "Item Identifiers";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
                action("ECC No./Item Categories")
                {
                    CaptionML = ENU = 'ECC No./Item Categories',
                                ENN = 'ECC No./Item Categories';
                    ApplicationArea = All;
                    /* RunObject = Page "ECC No./Item Categories";
                     RunPageLink = "Item No." = FIELD("No.");*/
                    //B2BUPG
                }
            }
            group("Assembly/Production")
            {
                CaptionML = ENU = 'Assembly/Production',
                            ENN = 'Assembly/Production';
                Image = Production;
                /*action(Structure)
                {
                    CaptionML = ENU = 'Structure',
                                ENN = 'Structure';
                    Image = Hierarchy;

                    trigger OnAction();
                    var
                        BOMStructure: Page "BOM Structure";
                    begin
                        BOMStructure.InitItem(Rec);
                        BOMStructure.RUN;
                    end;
                }*/
                action("Alternate Items")
                {
                    Caption = 'Alternate Items';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Alternate_items.SETRANGE(Alternate_items."Item No.", "No.");
                        PAGE.RUN(60070, Alternate_items);
                    end;
                }
                action("Cost Shares")
                {
                    CaptionML = ENU = 'Cost Shares',
                                ENN = 'Cost Shares';
                    Image = CostBudget;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        BOMCostShares: Page "BOM Cost Shares";
                    begin
                        BOMCostShares.InitItem(Rec);
                        BOMCostShares.RUN;
                    end;
                }
                group("Assemb&ly")
                {
                    CaptionML = ENU = 'Assemb&ly',
                                ENN = 'Assemb&ly';
                    Image = AssemblyBOM;
                    action("<Action32>")
                    {
                        CaptionML = ENU = 'Assembly BOM',
                                    ENN = 'Assembly BOM';
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used")
                    {
                        CaptionML = ENU = 'Where-Used',
                                    ENN = 'Where-Used';
                        Image = Track;
                        RunObject = Page "Where-Used List";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        RunPageView = SORTING(Type, "No.");
                        ApplicationArea = All;
                    }
                    action("Calc. Stan&dard Cost")
                    {
                        CaptionML = ENU = 'Calc. Stan&dard Cost',
                                    ENN = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem("No.", TRUE);
                        end;
                    }
                    action("Calc. Unit Price")
                    {
                        CaptionML = ENU = 'Calc. Unit Price',
                                    ENN = 'Calc. Unit Price';
                        Image = SuggestItemPrice;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcAssemblyItemPrice("No.");
                        end;
                    }
                }
                group(Production)
                {
                    CaptionML = ENU = 'Production',
                                ENN = 'Production';
                    Image = Production;
                    action("Production BOM")
                    {
                        CaptionML = ENU = 'Production BOM',
                                    ENN = 'Production BOM';
                        Image = BOM;
                        RunObject = Page "Production BOM";
                        RunPageLink = "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action29)
                    {
                        CaptionML = ENU = 'Where-Used',
                                    ENN = 'Where-Used';
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
                    action(Action24)
                    {
                        CaptionML = ENU = 'Calc. Stan&dard Cost',
                                    ENN = 'Calc. Stan&dard Cost';
                        Image = CalculateCost;
                        ApplicationArea = All;

                        trigger OnAction();
                        begin
                            CalculateStdCost.CalcItem("No.", FALSE);
                        end;
                    }
                }
            }
            group(History)
            {
                CaptionML = ENU = 'History',
                            ENN = 'History';
                Image = History;
                group("E&ntries")
                {
                    CaptionML = ENU = 'E&ntries',
                                ENN = 'E&ntries';
                    Image = Entries;
                    action("Ledger E&ntries")
                    {
                        CaptionML = ENU = 'Ledger E&ntries',
                                    ENN = 'Ledger E&ntries';
                        Image = ItemLedger;
                        Promoted = false;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = Process;
                        RunObject = Page 38;
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ShortCutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                    }
                    action("&Reservation Entries")
                    {
                        CaptionML = ENU = '&Reservation Entries',
                                    ENN = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = Page "Reservation Entries";
                        RunPageLink = "Reservation Status" = CONST(Reservation), "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Variant Code", "Location Code", "Reservation Status");
                        ApplicationArea = All;
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        CaptionML = ENU = '&Phys. Inventory Ledger Entries',
                                    ENN = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = Page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Value Entries")
                    {
                        CaptionML = ENU = '&Value Entries',
                                    ENN = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = Page "Value Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.");
                        ApplicationArea = All;
                    }
                    action("Item &Tracking Entries")
                    {
                        CaptionML = ENU = 'Item &Tracking Entries',
                                    ENN = 'Item &Tracking Entries';
                        Image = ItemTrackingLedger;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                        begin
                            ItemTrackingDocMgt.ShowItemTrackingForMasterData(3, '', "No.", '', '', '', '');
                        end;
                    }
                    action("&Warehouse Entries")
                    {
                        CaptionML = ENU = '&Warehouse Entries',
                                    ENN = '&Warehouse Entries';
                        Image = BinLedger;
                        RunObject = Page "Warehouse Entries";
                        RunPageLink = "Item No." = FIELD("No.");
                        RunPageView = SORTING("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated);
                        ApplicationArea = All;
                    }
                }
                group(Statistics)
                {
                    CaptionML = ENU = 'Statistics',
                                ENN = 'Statistics';
                    Image = Statistics;
                    action(Action16)
                    {
                        CaptionML = ENU = 'Statistics',
                                    ENN = 'Statistics';
                        Image = Statistics;
                        Promoted = true;
                        PromotedCategory = Process;
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
                        CaptionML = ENU = 'Entry Statistics',
                                    ENN = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = Page "Item Entry Statistics";
                        RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("T&urnover")
                    {
                        CaptionML = ENU = 'T&urnover',
                                    ENN = 'T&urnover';
                        Image = Turnover;
                        RunObject = Page "Item Turnover";
                        RunPageLink = "No." = FIELD("No."), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action("Co&mments")
                {
                    CaptionML = ENU = 'Co&mments',
                                ENN = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Item Specifications")
                {
                    Caption = 'Item Specifications';
                    RunObject = Page "Item Specification";
                    RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                    ApplicationArea = All;
                }
            }
            group("S&ales")
            {
                CaptionML = ENU = 'S&ales',
                            ENN = 'S&ales';
                Image = Sales;
                action(Prices)
                {
                    CaptionML = ENU = 'Prices',
                                ENN = 'Prices';
                    Image = Price;
                    RunObject = Page "Sales Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    CaptionML = ENU = 'Line Discounts',
                                ENN = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Sales Line Discounts";
                    RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    ApplicationArea = All;
                }
                action("Prepa&yment Percentages")
                {
                    CaptionML = ENU = 'Prepa&yment Percentages',
                                ENN = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Sales Prepayment Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Orders)
                {
                    CaptionML = ENU = 'Orders',
                                ENN = 'Orders';
                    Image = Document;
                    RunObject = Page "Sales Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Returns Orders")
                {
                    CaptionML = ENU = 'Returns Orders',
                                ENN = 'Returns Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Sales Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group("&Purchases")
            {
                CaptionML = ENU = '&Purchases',
                            ENN = '&Purchases';
                Image = Purchasing;
                action("Ven&dors")
                {
                    CaptionML = ENU = 'Ven&dors',
                                ENN = 'Ven&dors';
                    Image = Vendor;
                    RunObject = Page "Item Vendor Catalog";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action39)
                {
                    CaptionML = ENU = 'Prices',
                                ENN = 'Prices';
                    Image = Price;
                    RunObject = Page "Purchase Prices";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action42)
                {
                    CaptionML = ENU = 'Line Discounts',
                                ENN = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = Page "Purchase Line Discounts";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action125)
                {
                    CaptionML = ENU = 'Prepa&yment Percentages',
                                ENN = 'Prepa&yment Percentages';
                    Image = PrepaymentPercentages;
                    RunObject = Page "Purchase Prepmt. Percentages";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Action40)
                {
                    CaptionML = ENU = 'Orders',
                                ENN = 'Orders';
                    Image = Document;
                    RunObject = Page "Purchase Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    CaptionML = ENU = 'Return Orders',
                                ENN = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = Page "Purchase Return Orders";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    CaptionML = ENU = 'Nonstoc&k Items',
                                ENN = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    RunObject = Page 5726;
                    ApplicationArea = All;
                }
            }
            group(Warehouse)
            {
                CaptionML = ENU = 'Warehouse',
                            ENN = 'Warehouse';
                Image = Warehouse;
                action("&Bin Contents")
                {
                    CaptionML = ENU = '&Bin Contents',
                                ENN = '&Bin Contents';
                    Image = BinContent;
                    RunObject = Page "Item Bin Contents";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Stockkeepin&g Units")
                {
                    CaptionML = ENU = 'Stockkeepin&g Units',
                                ENN = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
            }
            group(Service)
            {
                CaptionML = ENU = 'Service',
                            ENN = 'Service';
                Image = ServiceItem;
                action("Ser&vice Items")
                {
                    CaptionML = ENU = 'Ser&vice Items',
                                ENN = 'Ser&vice Items';
                    Image = ServiceItem;
                    RunObject = Page "Service Items";
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Troubleshooting)
                {
                    CaptionML = ENU = 'Troubleshooting',
                                ENN = 'Troubleshooting';
                    Image = Troubleshoot;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        TroubleshootingHeader: Record "Troubleshooting Header";
                    begin
                        TroubleshootingHeader.ShowForItem(Rec);
                    end;
                }
                action("Troubleshooting Setup")
                {
                    CaptionML = ENU = 'Troubleshooting Setup',
                                ENN = 'Troubleshooting Setup';
                    Image = Troubleshoot;
                    RunObject = Page "Troubleshooting Setup";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
            group(Resources)
            {
                CaptionML = ENU = 'Resources',
                            ENN = 'Resources';
                Image = Resource;
                group("R&esource")
                {
                    CaptionML = ENU = 'R&esource',
                                ENN = 'R&esource';
                    Image = Resource;
                    action("Resource &Skills")
                    {
                        CaptionML = ENU = 'Resource &Skills',
                                    ENN = 'Resource &Skills';
                        Image = ResourceSkills;
                        RunObject = Page "Resource Skills";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Skilled R&esources")
                    {
                        CaptionML = ENU = 'Skilled R&esources',
                                    ENN = 'Skilled R&esources';
                        Image = ResourceSkills;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ResourceSkill: Record "Resource Skill";
                        begin
                            CLEAR(SkilledResourceList);
                            SkilledResourceList.Initialize(ResourceSkill.Type::Item, "No.", Description);
                            SkilledResourceList.RUNMODAL;
                        end;
                    }
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
                action("&Create Stockkeeping Unit")
                {
                    CaptionML = ENU = '&Create Stockkeeping Unit',
                                ENN = '&Create Stockkeeping Unit';
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
                    CaptionML = ENU = 'C&alculate Counting Period',
                                ENN = 'C&alculate Counting Period';
                    Image = CalculateCalendar;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PhysInvtCountMgt: Codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
                action("Show MCH Shortage Material")
                {
                    Caption = 'Show MCH Shortage Material';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RESET;
                        SETFILTER("Product Group Code Cust", '<>%1&%2', 'FPRODUCT', 'CPCB');
                        CALCFIELDS("Stock At MCH Location");
                        IF FINDSET THEN
                            REPEAT
                                IF "Stock At MCH Location" < "Safety Stock Qty (MCH)" THEN
                                    MARK := TRUE;
                            UNTIL NEXT = 0;
                        MARKEDONLY;
                    end;
                }
            }
            action("Sales Prices")
            {
                CaptionML = ENU = 'Sales Prices',
                            ENN = 'Sales Prices';
                Image = SalesPrices;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Sales Prices";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
                ApplicationArea = All;
            }
            action("Purchase Prices")
            {
                CaptionML = ENU = 'Purchase Prices',
                            ENN = 'Purchase Prices';
                Image = Price;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Purchase Prices";
                RunPageLink = "Item No." = FIELD("No.");
                RunPageView = SORTING("Item No.");
                ApplicationArea = All;
            }
            action("Sales Line Discounts")
            {
                CaptionML = ENU = 'Sales Line Discounts',
                            ENN = 'Sales Line Discounts';
                Image = SalesLineDisc;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Line Discounts";
                RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                RunPageView = SORTING(Type, Code);
                ApplicationArea = All;
            }
            action("Requisition Worksheet")
            {
                CaptionML = ENU = 'Requisition Worksheet',
                            ENN = 'Requisition Worksheet';
                Image = Worksheet;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Req. Worksheet";
                ApplicationArea = All;
            }
            action("Planning Worksheet")
            {
                CaptionML = ENU = 'Planning Worksheet',
                            ENN = 'Planning Worksheet';
                Image = PlanningWorksheet;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Planning Worksheet";
                ApplicationArea = All;
            }
            action("Item Journal")
            {
                CaptionML = ENU = 'Item Journal',
                            ENN = 'Item Journal';
                Image = Journals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Item Journal";
                ApplicationArea = All;
            }
            action("Item Reclassification Journal")
            {
                CaptionML = ENU = 'Item Reclassification Journal',
                            ENN = 'Item Reclassification Journal';
                Image = Journals;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Reclass. Journal";
                ApplicationArea = All;
            }
            action("Item Tracing")
            {
                CaptionML = ENU = 'Item Tracing',
                            ENN = 'Item Tracing';
                Image = ItemTracing;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Item Tracing";
                ApplicationArea = All;
            }
            action("Adjust Item Cost/Price")
            {
                CaptionML = ENU = 'Adjust Item Cost/Price',
                            ENN = 'Adjust Item Cost/Price';
                Image = AdjustItemCost;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Report "Adjust Item Costs/Prices";
                ApplicationArea = All;
            }
            action("Adjust Cost - Item Entries")
            {
                CaptionML = ENU = 'Adjust Cost - Item Entries',
                            ENN = 'Adjust Cost - Item Entries';
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Adjust Cost - Item Entries";
                ApplicationArea = All;
            }
        }
        area(reporting)
        {
            action("Inventory - List")
            {
                CaptionML = ENU = 'Inventory - List',
                            ENN = 'Inventory - List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - List";
                ApplicationArea = All;
            }
            action("Item Register - Quantity")
            {
                CaptionML = ENU = 'Item Register - Quantity',
                            ENN = 'Item Register - Quantity';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Register - Quantity";
                ApplicationArea = All;
            }
            action("Inventory - Transaction Detail")
            {
                CaptionML = ENU = 'Inventory - Transaction Detail',
                            ENN = 'Inventory - Transaction Detail';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Transaction Detail";
                ApplicationArea = All;
            }
            action("Inventory Availability")
            {
                CaptionML = ENU = 'Inventory Availability',
                            ENN = 'Inventory Availability';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory Availability";
                ApplicationArea = All;
            }
            action(Status)
            {
                CaptionML = ENU = 'Status',
                            ENN = 'Status';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report Status;
                ApplicationArea = All;
            }
            action("Inventory - Availability Plan")
            {
                CaptionML = ENU = 'Inventory - Availability Plan',
                            ENN = 'Inventory - Availability Plan';
                Image = ItemAvailability;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Availability Plan";
                ApplicationArea = All;
            }
            action("Inventory Order Details")
            {
                CaptionML = ENU = 'Inventory Order Details',
                            ENN = 'Inventory Order Details';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 708;
                ApplicationArea = All;
            }
            action("Inventory Purchase Orders")
            {
                CaptionML = ENU = 'Inventory Purchase Orders',
                            ENN = 'Inventory Purchase Orders';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory Purchase Orders";
                ApplicationArea = All;
            }
            action("Inventory - Top 10 List")
            {
                CaptionML = ENU = 'Inventory - Top 10 List',
                            ENN = 'Inventory - Top 10 List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Top 10 List";
                ApplicationArea = All;
            }
            action("Inventory - Sales Statistics")
            {
                CaptionML = ENU = 'Inventory - Sales Statistics',
                            ENN = 'Inventory - Sales Statistics';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Sales Statistics";
                ApplicationArea = All;
            }
            action("Assemble to Order - Sales")
            {
                CaptionML = ENU = 'Assemble to Order - Sales',
                            ENN = 'Assemble to Order - Sales';
                Image = "Report";
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Assemble to Order - Sales";
                ApplicationArea = All;
            }
            action("Inventory - Customer Sales")
            {
                CaptionML = ENU = 'Inventory - Customer Sales',
                            ENN = 'Inventory - Customer Sales';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Customer Sales";
                ApplicationArea = All;
            }
            action("Inventory - Vendor Purchases")
            {
                CaptionML = ENU = 'Inventory - Vendor Purchases',
                            ENN = 'Inventory - Vendor Purchases';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Vendor Purchases";
                ApplicationArea = All;
            }
            action("Price List")
            {
                CaptionML = ENU = 'Price List',
                            ENN = 'Price List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Price List";
                ApplicationArea = All;
            }
            action("Inventory Cost and Price List")
            {
                CaptionML = ENU = 'Inventory Cost and Price List',
                            ENN = 'Inventory Cost and Price List';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory Cost and Price List";
                ApplicationArea = All;
            }
            action("Inventory - Reorders")
            {
                CaptionML = ENU = 'Inventory - Reorders',
                            ENN = 'Inventory - Reorders';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Reorders";
                ApplicationArea = All;
            }
            action("Inventory - Sales Back Orders")
            {
                CaptionML = ENU = 'Inventory - Sales Back Orders',
                            ENN = 'Inventory - Sales Back Orders';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory - Sales Back Orders";
                ApplicationArea = All;
            }
            action("Item/Vendor Catalog")
            {
                CaptionML = ENU = 'Item/Vendor Catalog',
                            ENN = 'Item/Vendor Catalog';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item/Vendor Catalog";
                ApplicationArea = All;
            }
            action("Inventory - Cost Variance")
            {
                CaptionML = ENU = 'Inventory - Cost Variance',
                            ENN = 'Inventory - Cost Variance';
                Image = ItemCosts;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory - Cost Variance";
                ApplicationArea = All;
            }
            action("Phys. Inventory List")
            {
                CaptionML = ENU = 'Phys. Inventory List',
                            ENN = 'Phys. Inventory List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Phys. Inventory List";
                ApplicationArea = All;
            }
            action("Inventory Valuation")
            {
                CaptionML = ENU = 'Inventory Valuation',
                            ENN = 'Inventory Valuation';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Inventory Valuation";
                ApplicationArea = All;
            }
            action("Nonstock Item Sales")
            {
                CaptionML = ENU = 'Nonstock Item Sales',
                            ENN = 'Nonstock Item Sales';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5700;
                ApplicationArea = All;
            }
            action("Item Substitutions")
            {
                CaptionML = ENU = 'Item Substitutions',
                            ENN = 'Item Substitutions';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Substitutions";
                ApplicationArea = All;
            }
            action("Invt. Valuation - Cost Spec.")
            {
                CaptionML = ENU = 'Invt. Valuation - Cost Spec.',
                            ENN = 'Invt. Valuation - Cost Spec.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5801;
                ApplicationArea = All;
            }
            action("Inventory Valuation - WIP")
            {
                CaptionML = ENU = 'Inventory Valuation - WIP',
                            ENN = 'Inventory Valuation - WIP';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Inventory Valuation - WIP";
                ApplicationArea = All;
            }
            action("Item Register - Value")
            {
                CaptionML = ENU = 'Item Register - Value',
                            ENN = 'Item Register - Value';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Register - Value";
                ApplicationArea = All;
            }
            action("Item Charges - Specification")
            {
                CaptionML = ENU = 'Item Charges - Specification',
                            ENN = 'Item Charges - Specification';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Charges - Specification";
                ApplicationArea = All;
            }
            action("Item Age Composition - Qty.")
            {
                CaptionML = ENU = 'Item Age Composition - Qty.',
                            ENN = 'Item Age Composition - Qty.';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Age Composition - Qty.";
                ApplicationArea = All;
            }
            action("Item Age Composition - Value")
            {
                CaptionML = ENU = 'Item Age Composition - Value',
                            ENN = 'Item Age Composition - Value';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Age Composition - Value";
                ApplicationArea = All;
            }
            action("Item Expiration - Quantity")
            {
                CaptionML = ENU = 'Item Expiration - Quantity',
                            ENN = 'Item Expiration - Quantity';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Item Expiration - Quantity";
                ApplicationArea = All;
            }
            action("Cost Shares Breakdown")
            {
                CaptionML = ENU = 'Cost Shares Breakdown',
                            ENN = 'Cost Shares Breakdown';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Cost Shares Breakdown";
                ApplicationArea = All;
            }
            action("Detailed Calculation")
            {
                CaptionML = ENU = 'Detailed Calculation',
                            ENN = 'Detailed Calculation';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Detailed Calculation";
                ApplicationArea = All;
            }
            action("Rolled-up Cost Shares")
            {
                CaptionML = ENU = 'Rolled-up Cost Shares',
                            ENN = 'Rolled-up Cost Shares';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Rolled-up Cost Shares";
                ApplicationArea = All;
            }
            action("Single-Level Cost Shares")
            {
                CaptionML = ENU = 'Single-Level Cost Shares',
                            ENN = 'Single-Level Cost Shares';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Single-level Cost Shares";
                ApplicationArea = All;
            }
            action("Where Used (Top Level)")
            {
                CaptionML = ENU = 'Where Used (Top Level)',
                            ENN = 'Where Used (Top Level)';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Where-Used (Top Level)";
                ApplicationArea = All;
            }
            action("Quantity Explosion of BOM")
            {
                CaptionML = ENU = 'Quantity Explosion of BOM',
                            ENN = 'Quantity Explosion of BOM';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Quantity Explosion of BOM";
                ApplicationArea = All;
            }
            action("Compare List")
            {
                CaptionML = ENU = 'Compare List',
                            ENN = 'Compare List';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Compare List";
                ApplicationArea = All;
            }
        }
    }





    trigger OnAfterGetRecord();
    begin
        NoOnFormat;
        DescriptionOnFormat;
    end;

    trigger OnOpenPage();
    Var
        ItemCategoryRec: Record "Item Category";
    begin
        Color_QCflag := 'Has QC Flag';
        Color_Attachment := 'Has Attachment';
        Color_obsolete := 'Is Obsolete';
        bom_status_running := 'Running Bom';
        bom_status_old := 'Old Bom';
        //EFFUPG1.4>>
        ItemCategoryRec.Reset;
        ItemCategoryRec.Setrange("Parent Category", '<>%1', '');
        if ItemCategoryRec.findset then
            ItemCategoryRec.DeleteAll();
        //EFFUPG1.4<<
    end;

    var
        SkilledResourceList: Page "Skilled Resource List";
        CalculateStdCost: Codeunit "Calculate Standard Cost";
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
        user: Record User;
        Alternate_items: Record "Alternate Items";
        IRH: Record "Inspection Receipt Header";
        [InDataSet]

        "No.Emphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        "No.Format": Text;
        Attachment: Record Attachments;
        Color_QCflag: Text;
        Color_Attachment: Text;
        Color_obsolete: Text;
        bom_status_running: Text;
        bom_status_old: Text;
        PBH: Record "Production BOM Header";


    procedure GetSelectionFilter(): Text;
    var
        Item: Record Item;
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
    begin
        CurrPage.SETSELECTIONFILTER(Item);
        EXIT(SelectionFilterManagement.GetSelectionFilterForItem(Item));
    end;

    procedure SetSelection(var Item: Record Item);
    begin
        CurrPage.SETSELECTIONFILTER(Item);
    end;

    local procedure NoOnFormat();
    begin
        //Rev01 Begin
        IRH.RESET;
        IRH.SETCURRENTKEY("Item No.", Status, Flag);  //Rev01
        IRH.SETFILTER(IRH."Item No.", "No.");
        IRH.SETRANGE(IRH.Status, TRUE);
        IRH.SETRANGE(IRH.Flag, TRUE);
        IF IRH.FINDFIRST THEN
            "No.Format" := 'Unfavorable'
        ELSE BEGIN
            "No.Format" := 'None';
            //"No.Emphasize" := NOT (IRH.ISEMPTY)
            //Rev01 End
            Attachment.RESET;
            Attachment.SETRANGE("Table ID", DATABASE::Item);
            Attachment.SETRANGE("Document No.", "No.");
            Attachment.SETRANGE(Attachment."Attachment Status", TRUE);
            IF Attachment.FINDFIRST THEN BEGIN
                "No.Format" := 'StrongAccent';
                //"No.Emphasize" :='StrongAccent';
            END
            ELSE
                "No.Format" := 'None';
        END;
        PBH.RESET;
        PBH.SETFILTER("No.", Rec."No.");
        PBH.SETFILTER("BOM Running Status", 'Running');
        IF PBH.FINDSET THEN BEGIN
            IF PBH."BOM Running Status" = PBH."BOM Running Status"::Running THEN
                "No.Format" := 'Favorable'
            ELSE
                "No.Format" := 'None';
        END;
        PBH.RESET;
        PBH.SETFILTER("No.", Rec."No.");
        PBH.SETFILTER("BOM Running Status", 'Old');
        IF PBH.FINDSET THEN BEGIN
            IF PBH."BOM Running Status" = PBH."BOM Running Status"::Old THEN
                "No.Format" := 'Subordinate'
            ELSE
                "No.Format" := 'None';
        END;

    end;

    local procedure DescriptionOnFormat();
    begin
        IF FORMAT("Item Status") = 'Obsolete' THEN BEGIN
            DescriptionEmphasize := TRUE;
        END ELSE BEGIN
            DescriptionEmphasize := FALSE;
            //REV01
        END;
    end;
}

