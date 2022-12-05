page 60249 "Item Card Test1"
{
    Caption = 'Item Card Test1';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = Item;
    SourceTableView = sorting("No.") order(ascending);

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        if Rec.AssistEdit then
                            CurrPage.Update;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\JHANSI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\UBEDULLA',
                                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\KARUNA', 'SUPER', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
                            Error('You have No Rights');
                    end;
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
                field("Part Number"; Rec."Part Number")
                {
                    ApplicationArea = All;
                }
                field("Base Unit of Measure"; Rec."Base Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Assembly BOM"; Rec."Assembly BOM")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shelf No."; Rec."Shelf No.")
                {
                    ApplicationArea = All;
                }
                field("Automatic Ext. Texts"; Rec."Automatic Ext. Texts")
                {
                    Editable = true;
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
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Avg Unit Cost"; Rec."Avg Unit Cost")
                {
                    Caption = 'Unit Cost';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Item_verified; Rec.Item_verified)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if (UserId <> 'EFFTRONICS\ANANDA') then begin
                            Rec.Modify(false);
                            Error('Only Super User has Permissions to modify');
                        end;
                        Rec.Verified_Date := Today;
                    end;
                }
                field(Verified_Date; Rec.Verified_Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if (UserId <> 'EFFTRONICS\ANANDA') then begin
                            Rec.Modify(false);
                            Error('Only Super User has Permissions to modify');
                        end;
                    end;
                }
                field("Item Location"; Rec."Item Location")
                {
                    ApplicationArea = All;
                }
                field(ProductType; Rec.ProductType)
                {
                    ApplicationArea = All;
                }
                field(PROD_USED; Rec.PROD_USED)
                {
                    Caption = 'Prod_Used';
                    ApplicationArea = All;
                }
                field("Safety Stock Quantity"; Rec."Safety Stock Quantity")
                {
                    Caption = 'Safety Stock Quantity (PROD)';
                    ApplicationArea = All;
                }
                field("Safety Stock Qty (MCH)"; Rec."Safety Stock Qty (MCH)")
                {
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
                        Rec.CalcFields("Quantity Under Inspection", "Quantity Rejected", "Quantity Rework", "Quantity Sent for Rework");
                        if Rec."QC Enabled" = true then begin
                            if (Rec."Quantity Under Inspection" = 0) and (Rec."Quantity Rejected" = 0) and (Rec."Quantity Rework" = 0) and (Rec."Quantity Sent for Rework" = 0) then begin
                                ItemLedgEntry.SetRange("Item No.", Rec."No.");
                                ItemLedgEntry.SetRange(Open, true);
                                Page.RunModal(38, ItemLedgEntry);
                            end else begin
                                ItemLedgEntry.Reset;
                                ItemLedgEntry.SetRange("Item No.", Rec."No.");
                                ItemLedgEntry.SetRange(Open, true);
                                if ItemLedgEntry.FindSet then
                                    repeat
                                        ItemLedgEntry.Mark(true);
                                        if QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.") then
                                            ItemLedgEntry.Mark(false);
                                    until ItemLedgEntry.Next = 0;
                                ItemLedgEntry.MarkedOnly(true);
                                Page.RunModal(38, ItemLedgEntry);
                            end;
                        end;
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
                field("Service Item Group"; Rec."Service Item Group")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if Rec.Blocked then begin
                            // Verification in Production BOM Header & Line
                            if (Rec."Production BOM No." <> '') and (Rec."Product Group Code Cust" <> 'FPRODUCT') then begin
                                Error('PRODUCTION BOM WAS LINKED TO THIS ITEM , PLESE VERIFY & CLOSE IT');
                                PROBLEM := true;
                            end;


                            PBML.SETRANGE(PBML."No.", Rec."No.");
                            if PBML.FINDFIRST then begin
                                if (Rec."Product Group Code Cust" <> 'FPRODUCT') then
                                    Error(' ITEM IS IN PRODUCTION BOMS PLEASE VERIFY "WHERE USED LIST" ONCE');

                                if FPO_ITEM.GET(PBML."Production BOM No.") then
                                    FPO_ITEM.TESTFIELD(FPO_ITEM.Blocked);
                                PROBLEM := true;
                            end;


                            // VERIFUCATION IN MATERIAL ISSUES LINE
                            "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.", "Material Issues Line"."Prod. Order No.");
                            "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", Rec."No.");
                            if "Material Issues Line".FINDFIRST then begin
                                Error(' ITEM IS IN MATERIAL REQUESTS ');
                                PROBLEM := true;
                            end;


                            // VERIFICATION IN PURCHASE ORDER
                            "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                            "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."No.");
                            "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                            if "Purchase Line".FINDFIRST then begin
                                Error('ITEM IS IN PENDING PURCHASE ORDERS');
                                PROBLEM := true;
                            end;


                            // VERIFICATION IN SALE ORDER & SCHEDULE
                            SH.RESET;
                            SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Quote);
                            SH.SETFILTER(SH."Order Status", '<>%1', SH."Order Status"::"Temporary Close");
                            if SH.FINDFIRST then
                                repeat
                                    "Sales Line".SETCURRENTKEY("Sales Line".Type, "Sales Line"."No.",
                                                             "Sales Line"."Variant Code", "Sales Line"."Drop Shipment",
                                                             "Sales Line"."Location Code",
                                                             "Sales Line"."Document Type",
                                                             "Sales Line"."Shipment Date");
                                    "Sales Line".SETRANGE("Sales Line"."No.", Rec."No.");
                                    "Sales Line".SETFILTER("Sales Line"."Document No.", SH."No.");
                                    "Sales Line".SETFILTER("Sales Line"."Qty. to Ship", '>%1', 0);
                                    if "Sales Line".FINDFIRST then begin
                                        if (("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Blanket Order") and (SH."Sale Order Created" = false))
                                            or ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Order) then
                                            Error(' ITEM IS IN PENDING SALE ORDER');
                                    end;
                                    Schedule.SETCURRENTKEY(Schedule."Material Required Date", Schedule."No.");
                                    Schedule.SETFILTER(Schedule."Material Required Date", '>%1', Today);
                                    Schedule.SETFILTER(Schedule."Document No.", SH."No.");
                                    Schedule.SETRANGE(Schedule."No.", Rec."No.");
                                    if Schedule.FINDFIRST then begin
                                        Error('ITEM IS IN SCHEDULE (PENDING)');
                                        PROBLEM := true;
                                    end;
                                until SH.NEXT = 0;


                            // VERIFICATION IN "PROD ORDER COMPONENT"
                            "Prod. Order Component".SETCURRENTKEY("Prod. Order Component"."Item No.");
                            "Prod. Order Component".SETRANGE("Prod. Order Component"."Item No.", Rec."No.");
                            "Prod. Order Component".SETFILTER("Prod. Order Component"."Remaining Quantity", '>%1', 0);
                            "Prod. Order Component".SETRANGE("Prod. Order Component".Status, "Prod. Order Component".Status::Released);
                            if "Prod. Order Component".FINDFIRST then begin
                                Error(' ITEM IS IN PRODUCTION ORDERS SO PLEASE REFRESH THOSE PRODUCTION ORDERS');
                                PROBLEM := true;
                            end;
                        end;
                    end;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Sample; Rec.Sample)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost (LCY)';
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Safety Stock Qty (CS)"; Rec."Safety Stock Qty (CS)")
                {
                    ApplicationArea = All;
                }
                field("Need to be returned"; Rec."Need to be returned")
                {
                    ApplicationArea = All;
                }
                field("Dispatch Material"; Rec."Dispatch Material")
                {
                    ApplicationArea = All;
                }
                field("Stock at PROD Stores"; Rec."Stock at PROD Stores")
                {
                    ApplicationArea = All;
                }
                field("CS IGC"; Rec."CS IGC")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAKESHT', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
                            Error('You donot have rights to modify.Contact ERP Team');
                    end;
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
                        Codeunit.Run(Codeunit::"Show Avg. Calc. - Item", Rec);
                    end;
                }
                field("Standard Cost"; Rec."Standard Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Avg Unit Cost2>"; Rec."Avg Unit Cost")
                {
                    Caption = 'Unit cost.';
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
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control1102152149; Rec.PCB)
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cs Stock Verified"; Rec."Cs Stock Verified")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                /*field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                {
                    Editable = true;
                    ApplicationArea = All;
                }*/ //B2B
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Disc. Group"; Rec."Item Disc. Group")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Sales Unit of Measure"; Rec."Sales Unit of Measure")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                /* field("Excise Accounting Type"; "Excise Accounting Type")
                 {
                     Editable = true;
                     ApplicationArea = All;
                 }*/
                /* field("Assessable Value"; "Assessable Value")
                 {
                     Editable = true;
                     ApplicationArea = All;
                 }*/  //B2B
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                //EFFUPG<<
                /*
                field("Capital Item"; "Capital Item")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                */
                //EFFUPG>>
                field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                {
                    ApplicationArea = All;
                }
            }
            group(Replenishment)
            {
                Caption = 'Replenishment';
                field("Replenishment System"; Rec."Replenishment System")
                {

                    ApplicationArea = All;
                }
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
                field(Package; Rec.Package)
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
                field("No.of Units"; Rec."No.of Units")
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
                    ApplicationArea = All;
                }
                field("Standard Packing Quantity"; Rec."Standard Packing Quantity")
                {
                    ApplicationArea = All;
                }
                field("Maximum Order Quantity"; Rec."Maximum Order Quantity")
                {
                    Enabled = "Maximum Order QuantityEnable";
                    ApplicationArea = All;
                }
                field("Order Multiple"; Rec."Order Multiple")
                {
                    ApplicationArea = All;
                }
                field("Safety Stock Qty (R&D)"; Rec."Safety Stock Qty (R&D)")
                {
                    ApplicationArea = All;
                }
                field("Stock at CS Stores"; Rec."Stock at CS Stores")
                {
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
                field("Used In DL"; Rec."Used In DL")
                {
                    ApplicationArea = All;
                }
                field("Used In MFEP"; Rec."Used In MFEP")
                {
                    ApplicationArea = All;
                }
                field("Used In RTU"; Rec."Used In RTU")
                {
                    ApplicationArea = All;
                }
                field("Used In PMU"; Rec."Used In PMU")
                {
                    ApplicationArea = All;
                }
                field("Used In BMU"; Rec."Used In BMU")
                {
                    ApplicationArea = All;
                }
                field("Used In IPIS"; Rec."Used In IPIS")
                {
                    ApplicationArea = All;
                }
                field("Used In PC"; Rec."Used In PC")
                {
                    ApplicationArea = All;
                }
                field("Used In RLY.LMP"; Rec."Used In RLY.LMP")
                {
                    ApplicationArea = All;
                }
                field("Used In Bus Displays"; Rec."Used In Bus Displays")
                {
                    ApplicationArea = All;
                }
                field("Used in LED Lamps"; Rec."Used in LED Lamps")
                {
                    ApplicationArea = All;
                }
                field("Used in LC GATE"; Rec."Used in LC GATE")
                {
                    ApplicationArea = All;
                }
                field("USED in MLRI"; Rec."USED in MLRI")
                {
                    ApplicationArea = All;
                }
                field("Used in BI"; Rec."Used in BI")
                {
                    ApplicationArea = All;
                }
                field("Used in Road lamp WTLC"; Rec."Used in Road lamp WTLC")
                {
                    ApplicationArea = All;
                }
                field("<PROD_USED2>"; Rec.PROD_USED)
                {
                    ApplicationArea = All;
                }
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
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Operating Temperature"; Rec."Operating Temperature")
                {
                    ApplicationArea = All;
                }
                field("Storage Temperature"; Rec."Storage Temperature")
                {
                    ApplicationArea = All;
                }
                field(Humidity; Rec.Humidity)
                {
                    ApplicationArea = All;
                }
                field("ESD Sensitive"; Rec."ESD Sensitive")
                {
                    ApplicationArea = All;
                }
                field("Item Status"; Rec."Item Status")
                {
                    Caption = 'Item Status';
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
                field("Soldering Temp."; Rec."Soldering Temp.")
                {
                    ApplicationArea = All;
                }
                field("Soldering Time (Sec)"; Rec."Soldering Time (Sec)")
                {
                    ApplicationArea = All;
                }
                field("Work area Temp &  Humadity"; Rec."Work area Temp &  Humadity")
                {
                    ApplicationArea = All;
                }
                field(ESD; Rec.ESD)
                {
                    ApplicationArea = All;
                }
            }
            group(Control1102152045)
            {
                Caption = 'Specifications';
                field("<Part Number2>"; Rec."Part Number")
                {
                    ApplicationArea = All;
                }
                field("<Make2>"; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("<Operating Temperature2>"; Rec."Operating Temperature")
                {
                    ApplicationArea = All;
                }
                field("<Storage Temperature2>"; Rec."Storage Temperature")
                {
                    ApplicationArea = All;
                }
                field("<Humidity2>"; Rec.Humidity)
                {
                    ApplicationArea = All;
                }
                field("<ESD Sensitive2>"; Rec."ESD Sensitive")
                {
                    ApplicationArea = All;
                }
                field("<Item Status2>"; Rec."Item Status")
                {
                    ApplicationArea = All;
                }
                field("<Soldering Temp2.>"; Rec."Soldering Temp.")
                {
                    ApplicationArea = All;
                }
                field("<Soldering Time (Sec)2>"; Rec."Soldering Time (Sec)")
                {
                    ApplicationArea = All;
                }
                field("On C-Side"; Rec."On C-Side")
                {
                    Caption = 'C-Side Solder Mask';
                    ApplicationArea = All;
                }
                field("On D-Side"; Rec."On D-Side")
                {
                    Caption = 'D-Side Solder Mask';
                    ApplicationArea = All;
                }
                field("On S-Side"; Rec."On S-Side")
                {
                    Caption = 'S-Side Solder Mask';
                    ApplicationArea = All;
                }
                field("Surface Finish"; Rec."Surface Finish")
                {
                    ApplicationArea = All;
                }
                field("<Work area Temp &  Humadity2>"; Rec."Work area Temp &  Humadity")
                {
                    ApplicationArea = All;
                }
                field("<ESD2>"; Rec.ESD)
                {
                    ApplicationArea = All;
                }
                field("<Type of Solder2>"; Rec."Type of Solder")
                {
                    ApplicationArea = All;
                }
                field("<Package2>"; Rec.Package)
                {
                    ApplicationArea = All;
                }
                field("<No. of Soldering Points2>"; Rec."No. of Soldering Points")
                {
                    ApplicationArea = All;
                }
                field("<No. of Pins2>"; Rec."No. of Pins")
                {
                    ApplicationArea = All;
                }
                field("PCB thickness"; Rec."PCB thickness")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUNDAR']) then
                            Error('You Have No Rights');
                    end;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    Caption = 'Base Copper Clad Thickness(In Microns)';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUNDAR']) then
                            Error('You Have No Rights');
                    end;
                }
                field("PCB Shape"; Rec."PCB Shape")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\SWATHI']) then
                            Error('You Have No Rights');
                    end;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUNDAR']) then
                            Error('You Have No Rights');
                    end;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if not (UserId in ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\PRANAVI']) then
                            Error('You Have No Rights');
                    end;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    DecimalPlaces = 1 : 5;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if (UserId <> 'SUPER') then
                            Error('You Have No Rights');
                    end;
                }
                field("Semi Mounted"; Rec."Semi Mounted")
                {
                    ApplicationArea = All;
                }
                field(ROHS; Rec.ROHS)
                {
                    ApplicationArea = All;
                }
                field(REACH; Rec.REACH)
                {
                    ApplicationArea = All;
                }
                field(MSL; Rec.MSL)
                {
                    Caption = 'Moisture Sensitivity Level';
                    ApplicationArea = All;
                }
                field("Invert Solder type"; Rec."Invert Solder type")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                /*   field("MRP Value"; "MRP Value")
                   {
                       ApplicationArea = All;
                   }
                   field("MRP Price"; "MRP Price")
                   {
                       ApplicationArea = All;
                   }
                   field("Abatement %"; "Abatement %")
                   {
                       ApplicationArea = All;
                   }
                   field("Price Inclusive of Tax"; "Price Inclusive of Tax")
                   {
                       ApplicationArea = All;
                   }
                   field("PIT Structure"; "PIT Structure")
                   {
                       ApplicationArea = All;
                   }*/
                group("Sub Contracting")
                {
                    Caption = 'Sub Contracting';
                    field(Subcontracting; Rec.Subcontracting)
                    {
                        ApplicationArea = All;
                    }
                    field("Sub. Comp. Location"; Rec."Sub. Comp. Location")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Excise)
                {
                    Caption = 'Excise';
                    /*  field("Scrap Item"; "Scrap Item")
                      {
                          ApplicationArea = All;
                      }
                  }
                  group(VAT)
                  {
                      Caption = 'VAT';
                      field("Fixed Asset"; "Fixed Asset")
                      {
                          ApplicationArea = All;
                      }*/
                }
            }
        }
    }

    actions
    {
        area(Navigation)
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
                separator(Action1102152283)
                {
                }
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = CreateDocument;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TestField("Quantity Accepted");
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
                    RunObject = page "Stockkeeping Unit List";
                    RunPageLink = "Item No." = field("No.");
                    RunPageView = sorting("Item No.");
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
                        RunObject = page "Item Ledger Entries";
                        RunPageLink = "Item No." = field("No.");
                        RunPageView = sorting("Item No.");
                        ShortcutKey = 'Ctrl+F7';
                        ApplicationArea = All;
                    }
                    action("&Reservation Entries")
                    {
                        Caption = '&Reservation Entries';
                        Image = ReservationLedger;
                        RunObject = page "Reservation Entries";
                        RunPageLink = "Reservation Status" = const(Reservation), "Item No." = field("No.");
                        RunPageView = sorting("Reservation Status", "Item No.", "Variant Code", "Location Code");
                        ApplicationArea = All;
                    }
                    action("&Phys. Inventory Ledger Entries")
                    {
                        Caption = '&Phys. Inventory Ledger Entries';
                        Image = PhysicalInventoryLedger;
                        RunObject = page "Phys. Inventory Ledger Entries";
                        RunPageLink = "Item No." = field("No.");
                        RunPageView = sorting("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Value Entries")
                    {
                        Caption = '&Value Entries';
                        Image = ValueLedger;
                        RunObject = page "Value Entries";
                        RunPageLink = "Item No." = field("No.");
                        RunPageView = sorting("Item No.");
                        ApplicationArea = All;
                    }
                    action("&Quality Ledger Entries")
                    {
                        Caption = '&Quality Ledger Entries';
                        Image = TaskQualityMeasure;
                        RunObject = page "Quality Ledger Entries";
                        RunPageLink = "Item No." = field("No.");
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
                    action(Action1102152271)
                    {
                        Caption = 'Statistics';
                        Image = Statistics;
                        ShortcutKey = 'F7';
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ItemStatistics: Page "Item Statistics";
                        begin
                            ItemStatistics.SetItem(Rec);
                            ItemStatistics.RunModal;
                        end;
                    }
                    action("Entry Statistics")
                    {
                        Caption = 'Entry Statistics';
                        Image = EntryStatistics;
                        RunObject = page "Item Entry Statistics";
                        RunPageLink = "No." = field("No."), "Date Filter" = field("Date Filter"), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Location Filter" = field("Location Filter"), "Drop Shipment Filter" = field("Drop Shipment Filter"), "Variant Filter" = field("Variant Filter");
                        ApplicationArea = All;
                    }
                    action("T&urnover")
                    {
                        Caption = 'T&urnover';
                        Image = Turnover;
                        RunObject = page "Item Turnover";
                        RunPageLink = "No." = field("No."), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Location Filter" = field("Location Filter"), "Drop Shipment Filter" = field("Drop Shipment Filter"), "Variant Filter" = field("Variant Filter");
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
                        ItemsByLocation.SetRecord(Rec);
                        ItemsByLocation.Run;
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
                        RunObject = page "Item Availability by Periods";
                        RunPageLink = "No." = field("No."), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Location Filter" = field("Location Filter"), "Drop Shipment Filter" = field("Drop Shipment Filter"), "Variant Filter" = field("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Variant)
                    {
                        Caption = 'Variant';
                        Image = ItemVariant;
                        RunObject = page "Item Availability by Variant";
                        RunPageLink = "No." = field("No."), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Location Filter" = field("Location Filter"), "Drop Shipment Filter" = field("Drop Shipment Filter"), "Variant Filter" = field("Variant Filter");
                        ApplicationArea = All;
                    }
                    action(Location)
                    {
                        Caption = 'Location';
                        Image = Warehouse;
                        RunObject = page "Item Availability by Location";
                        RunPageLink = "No." = field("No."), "Global Dimension 1 Filter" = field("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = field("Global Dimension 2 Filter"), "Location Filter" = field("Location Filter"), "Drop Shipment Filter" = field("Drop Shipment Filter"), "Variant Filter" = field("Variant Filter");
                        ApplicationArea = All;
                    }
                }
                action(PCB)
                {
                    Caption = 'PCB';
                    Image = Card;
                    Visible = visible1;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        pcb1.RESET;
                        pcb1.SETRANGE(pcb1."PCB No.", "No.");
                        if pcb1.FINDFIRST then
                            Page.RUN(60240, pcb1)
                        else begin
                            pcb1.INIT;
                            pcb1."PCB No." := "No.";
                            pcb1.Description := Description;
                            pcb1."PCB Thickness" := "PCB thickness";
                            pcb1."Copper Clad Thinkness" := "Copper Clad Thickness";
                            pcb1."PCB Area" := "PCB Area";
                            pcb1.Length := Length;
                            pcb1.Width := Width;
                            pcb1."PCB Shape" := "PCB Shape";
                            pcb1."On C-side" := "On C-Side";
                            pcb1."On D-side" := "On D-Side";
                            pcb1."On S-side" := "On S-Side";
                            pcb1.INSERT;
                            pcb1.RESET;
                            pcb1.SETRANGE(pcb1."PCB No.", "No.");
                            if pcb1.FINDFIRST then
                                Page.RUN(60240, pcb1);
                        end;
                    end;
                }
                action("&Bin Contents")
                {
                    Caption = '&Bin Contents';
                    Image = BOMLevel;
                    RunObject = page "Item Bin Contents";
                    RunPageLink = "Item No." = field("No."), "Unit of Measure Code" = field("Base Unit of Measure");
                    RunPageView = sorting("Item No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = page "Comment Sheet";
                    RunPageLink = "Table Name" = const(Item), "No." = field("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = page "Default Dimensions";
                    RunPageLink = "Table ID" = const(27), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action("&Picture")
                {
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = page "Item Picture";
                    RunPageLink = "No." = FIELD("No."), "Date Filter" = FIELD("Date Filter"), "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                    ApplicationArea = All;
                }
                separator(Action1102152258)
                {
                }
                action("&Units of Measure")
                {
                    Caption = '&Units of Measure';
                    Image = UnitOfMeasure;
                    RunObject = page "Item Units of Measure";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Va&riants")
                {
                    Caption = 'Va&riants';
                    Image = ItemVariant;
                    RunObject = page "Item Variants";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Cross Re&ferences")
                {
                    Caption = 'Cross Re&ferences';
                    Image = Change;
                    RunObject = page "Item Cross Reference Entries";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Substituti&ons")
                {
                    Caption = 'Substituti&ons';
                    Image = ItemSubstitution;
                    RunObject = page "Item Substitution Entry";
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Nonstoc&k Items")
                {
                    Caption = 'Nonstoc&k Items';
                    Image = NonStockItem;
                    RunObject = page 5726;
                    ApplicationArea = All;
                }
                action("Alternative Items")
                {
                    Caption = 'Alternative Items';
                    Image = ItemSubstitution;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Alternate Item".SETRANGE("Alternate Item"."Item No.", "No.");
                        page.RUN(60070, "Alternate Item");
                    end;
                }
                separator(Action1102152251)
                {
                }
                action(Translations)
                {
                    Caption = 'Translations';
                    Image = Translations;
                    RunObject = page 35;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("E&xtended Texts")
                {
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = page 386;
                    RunPageLink = "Table Name" = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                    ApplicationArea = All;
                }
                separator(Action1102152248)
                {
                }
                group("Assembly List")
                {
                    Caption = 'Assembly List';
                    Image = AssemblyBOM;
                    action("Bill of Materials")
                    {
                        Caption = 'Bill of Materials';
                        Image = BOM;
                        RunObject = page 36;
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        Image = Track;
                        RunObject = page 37;
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
                        Image = Track;
                        ApplicationArea = All;

                        trigger OnAction();
                        var
                            ProdBOMWhereUsed: page 99000811;
                        begin
                            ProdBOMWhereUsed.SetItem(Rec, WORKDATE);
                            ProdBOMWhereUsed.RUNMODAL;
                        end;
                    }
                    action(Action1102152241)
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
                separator(Action1102152240)
                {
                    Caption = '""';
                }
                action("Ser&vice Items")
                {
                    Caption = 'Ser&vice Items';
                    Image = ServiceItem;
                    RunObject = page "Service Items";
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
                        Image = DebugNext;
                        RunObject = page 5993;
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action1102152236)
                    {
                        Caption = 'Troubles&hooting';
                        Image = Debug;
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
                        RunObject = page 6019;
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
                        end;
                    }
                }
                separator(Action1102152232)
                {
                }
                action(Identifiers)
                {
                    Caption = 'Identifiers';
                    Image = SerialNo;
                    RunObject = page 7706;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.", "Variant Code", "Unit of Measure Code");
                    ApplicationArea = All;
                }
                action(Specifications)
                {
                    Caption = 'Specifications';
                    Image = ItemVariant;
                    RunObject = page "Item Specification";
                    RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                    ApplicationArea = All;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    RunObject = page "ESPL Attachments";
                    RunPageLink = "Table ID" = CONST(27), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action1102152228)
                {
                }
                action("Design Work Sheet")
                {
                    Caption = 'Design Work Sheet';
                    Image = Worksheet;
                    RunObject = page "Item Design WorkSheet Header";
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Change log")
                {
                    Caption = 'Change log';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Changelog.RESET;
                        Changelog.SETFILTER(Changelog."Table No.", '%1', 27);
                        Changelog.SETFILTER(Changelog."Primary Key Field 1 Value", "No.");
                        page.RUN(595, Changelog);
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
                    RunObject = page 7002;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action("Line Discounts")
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = page 7004;
                    RunPageLink = Type = CONST(Item), Code = FIELD("No.");
                    RunPageView = SORTING(Type, Code);
                    ApplicationArea = All;
                }
                separator(Action1102152222)
                {
                }
                action(Orders)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = page 48;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action("Return Orders")
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = page 6633;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                Image = Purchasing;
                action("Ven&dors")
                {
                    Caption = 'Ven&dors';
                    Image = Vendor;
                    RunObject = page 114;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action1102152217)
                {
                    Caption = 'Prices';
                    Image = Price;
                    RunObject = page 7012;
                    RunPageLink = "Item No." = FIELD("No.");
                    RunPageView = SORTING("Item No.");
                    ApplicationArea = All;
                }
                action(Action1102152216)
                {
                    Caption = 'Line Discounts';
                    Image = LineDiscount;
                    RunObject = page 7014;
                    RunPageLink = "Item No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action1102152215)
                {
                }
                action(Action1102152214)
                {
                    Caption = 'Orders';
                    Image = Document;
                    RunObject = page 56;
                    RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                    RunPageView = SORTING("Document Type", Type, "No.");
                    ApplicationArea = All;
                }
                action(Action1102152213)
                {
                    Caption = 'Return Orders';
                    Image = ReturnOrder;
                    RunObject = page 6643;
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
                        report.RUNMODAL(report::"Create Stockkeeping Unit", TRUE, FALSE, Item);
                    end;
                }
                action("C&alculate Counting Period")
                {
                    Caption = 'C&alculate Counting Period';
                    Image = CalculateCalendar;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        PhysInvtCountMgt: codeunit "Phys. Invt. Count.-Management";
                    begin
                        PhysInvtCountMgt.UpdateItemPhysInvtCount(Rec);
                    end;
                }
                action("Update BOM")
                {
                    Caption = 'Update BOM';
                    Image = BOMLevel;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.UpdateBOM;
                    end;
                }
            }
            action(Action1102152207)
            {
                Caption = 'Attachments';
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    attachments.RESET;
                    attachments.SETRANGE("Table ID", DATABASE::Item);
                    attachments.SETRANGE("Document No.", "No.");
                    page.RUN(page::"ESPL Attachments", attachments);
                end;
            }
        }
    }

    var
        TroubleshHeader: Record "Troubleshooting Header";
        ItemCostMgt: codeunit ItemCostManagement;
        CalculateStdCost: codeunit "Calculate Standard Cost";
        AverageCostLCY: Decimal;
        AverageCostACY: Decimal;
        attachments: Record Attachments;
        atta: Boolean;
        "Alternate Item": Record "Alternate Items";
        PBML: Record "Production BOM Line";
        "Material Issues Line": Record "Material Issues Line";
        "Purchase Line": Record "Purchase Line";
        "Sales Line": Record "Sales Line";
        Schedule: Record Schedule2;
        "Prod. Order Component": Record "Prod. Order Component";
        PROBLEM: Boolean;
        FPO_ITEM: Record Item;
        ItemCostUpdation: codeunit "Item Cost Updation";
        User: Record User;
        SH: Record "Sales Header";

        "No.Emphasize": Boolean;

        DescriptionEmphasize: Boolean;

        "Reorder CycleEnable": Boolean;

        "Reorder PointEnable": Boolean;

        "Reorder QuantityEnable": Boolean;

        "Maximum InventoryEnable": Boolean;

        "Maximum Order QuantityEnable": Boolean;

        "Include InventoryEnable": Boolean;
        SkilledResourceList: page "Skilled Resource List";
        pcb1: Record PCB;
        visible1: Boolean;
        item: Record Item;
        Changelog: Record "Change Log Entry";
        Text19026065: Label 'Attachments';


    procedure EnablePlanningControls();
    var
        PlanningGetParam: codeunit "Planning-Get Parameters";
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

        //CurrForm."Safety Stock Quantity".ENABLED := SafetyStockQtyEnabled;
        "Reorder PointEnable" := ReorderPointEnabled;
        "Reorder QuantityEnable" := ReorderQuantityEnabled;
        "Maximum InventoryEnable" := MaximumInventoryEnabled;

        "Maximum Order QuantityEnable" := MaximumOrderQtyEnabled;

        "Include InventoryEnable" := IncludeInventoryEnabled;
        //CurrForm."Safety Lead Time".ENABLED := SafetyLeadTimeEnabled;
        //CurrForm."Order Multiple".ENABLED := OrderMultipleEnabled;
        //CurrForm."Minimum Order Quantity".ENABLED := MinimumOrderQtyEnabled;
        // code commented by santhosh due to enabling of Required fields

    end;


    local procedure DispatchMaterialOnActivate();
    begin
        IF NOT (UPPERCASE(USERID) IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\SUNDAR']) THEN
            ERROR('You dont have Permissions');
    end;


    local procedure AverageCostLCYOnActivate();
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
    end;


    local procedure OnActivateForm();
    begin
        //Rev01 As directed by anil
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUNDAR',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\KARUNA', 'EFFTRONICS\DMADHAVI', 'EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;

        //Rev01 As directed by anil
    end;


    local procedure ProductGroupCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUNDAR',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\KARUNA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemCategoryCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUNDAR',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\KARUNA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemSubGroupCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUNDAR',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\KARUNA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemSubSubGroupCodeOnBeforeInp();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUNDAR',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MNRAJU', 'EFFTRONICS\RAKESHT', 'EFFTRONICS\KARUNA', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure NoOnFormat();
    begin
        IF "Product Group Code Cust" = 'FPRODUCT' THEN BEGIN
            "No.Emphasize" := TRUE;
        END ELSE
            IF "Product Group Code Cust" = 'CPCB' THEN BEGIN
                "No.Emphasize" := TRUE;
            END ELSE
                IF FORMAT("Item Status") = 'Obsolute' THEN BEGIN
                    "No.Emphasize" := TRUE;
                END ELSE BEGIN
                    "No.Emphasize" := FALSE;
                END;
    end;


    local procedure DescriptionOnFormat();
    begin
        IF "Product Group Code Cust" = 'FPRODUCT' THEN BEGIN
            DescriptionEmphasize := TRUE;
        END ELSE
            IF "Product Group Code Cust" = 'CPCB' THEN BEGIN
                DescriptionEmphasize := TRUE;
            END ELSE
                IF FORMAT("Item Status") = 'Obsolute' THEN BEGIN
                    DescriptionEmphasize := TRUE;

                END ELSE BEGIN
                    DescriptionEmphasize := FALSE;
                END;
    end;
}

