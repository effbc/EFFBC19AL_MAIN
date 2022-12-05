page 60181 "Item Card (manu)"
{
    // version NAVW13.70,NAVIN3.70.01.11,QC1.0,QCB2B1.2,B2B1.0,QC1.2,DWS1.0,Rev01

    Caption = 'Item Card';
    Editable = true;
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

                    trigger OnValidate();
                    begin
                        IF USERID IN ['EFFTRONICS\PADMASRI', 'EFFTRONICS\MARY'] THEN BEGIN
                            IF COPYSTR(Rec."No.", 1, 7) <> 'OFCMAIN' THEN
                                ERROR('YOU DO NOT HAVE RIGHTS');
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT ((USERID IN ['EFFTRONICS\JHANSI','EFFTRONICS\RATNARAVALI','EFFTRONICS\RSILPARANI','EFFTRONICS\VANIDEVI','EFFTRONICS\ANANDA',
                                               'EFFTRONICS\PARVATHIRAJULAPATI','EFFTRONICS\AVINASH','EFFTRONICS\UBEDULLA','EFFTRONICS\SUJANI','EFFTRONICS\PKOTESWARARAO',
                                                'SUPER','EFFTRONICS\ANILKUMAR','EFFTRONICS\SUVARCHALADEVI',
                                                'EFFTRONICS\RISHMITHA','EFFTRONICS\KSIRISHA','EFFTRONICS\RAMALAKSHMI','EFFTRONICS\NVSIVAKUMARI','EFFTRONICS\PAVANGIRI','EFFTRONICS\SATYANARAYANA','EFFTRONICS\APPARAO','EFFTRONICS\VENKANNA','EFFTRONICS\KRAMARAO','EFFTRONICS\YSAIPAVAN',
                                                'EFFTRONICS\VEERABHADRA','EFFTRONICS\CHANDRASEKHARK','EFFTRONICS\THIRUPATIRAO','EFFTRONICS\RAVEENDRAP','EFFTRONICS\SAIVENKAT','EFFTRONICS\IMRAN','EFFTRONICS\NAGUL','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\VASUDEVARAO','EFFTRONICS\VANIDEVI'])
                                               OR ((USERID IN ['EFFTRONICS\PADMASRI','EFFTRONICS\MARY','EFFTRONICS\GRAVI']) AND ("Item Category Code" IN ['OFFICE MAI','','STA'])))
                                                THEN
                            ERROR('You have No Rights!');

                        // Item Description Modification restriction when already a saleorder or purchase order
                        IF CheckinPurchaseOrders_and_SaleOrders(Rec."No.") THEN
                            ERROR('You Can not change the description because it is already in purchase orders or sale orders');
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

                    trigger OnValidate();
                    begin
                        IF Rec."User ID" IN ['EFFTRONICS\PADMASRI', 'EFFTRONICS\MARY'] THEN BEGIN
                            IF NOT (Rec."Item Category Code" IN ['OFFICE MAI', 'STA']) THEN //ADDED BY SUJANI FOR THE STATIONARY ITEMS ADDITION ON 22-12-2017
                                ERROR('YOU DO NOT HAVE RIGHTS');
                        END;
                    end;
                }
                field("Product Group Code"; Rec."Product Group Code Cust")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Item Category Code" = 'OFFICE MAI' THEN BEGIN
                            IF Rec."Product Group Code Cust" = 'CANTEEN' THEN BEGIN
                                Rec."Tax Group Code" := 'FOOD &BEV';
                                Rec."Spec ID" := 'I-STA-0001';
                            END
                            ELSE
                                IF (Rec."Product Group Code Cust" IN ['ELE', 'HKE', 'MISC', 'STATIONARY']) THEN BEGIN
                                    Rec."Tax Group Code" := 'OFFICE MAI';
                                    Rec."Spec ID" := 'SPEC-05-0002';
                                END;
                        END;
                        Rec.MODIFY;


                        IF "Product Group Code Cust" IN ['CPCB', 'FPRODUCT'] THEN begin
                            "Replenishment System" := Rec."Replenishment System"::"Prod. Order";
                             "Manufacturing Policy" := Rec."Manufacturing Policy"::"Make-to-Order";
                        end;
                    END;

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
                        IF NOT (USERID IN ['EFFTRONICS\TULASI', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUVARCHALADEVI']) THEN BEGIN
                            Rec.MODIFY(FALSE);
                            ERROR('Only Super User has Permissions to modify');
                        END;
                        Rec.Verified_Date := TODAY;
                    end;
                }
                field("Item Grp Verified Date"; Rec."Item Grp Verified Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Verified_Date; Rec.Verified_Date)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\TULASI', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\SUVARCHALADEVI']) THEN BEGIN
                            Rec.MODIFY(FALSE);
                            ERROR('Only Super User has Permissions to modify');
                        END;
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
                    Editable = UnitPriceCustmEdit;
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

                        IF Rec.Blocked THEN BEGIN
                            // Verification in Production BOM Header & Line
                            IF (Rec."Production BOM No." <> '') AND (Rec."Product Group Code Cust" <> 'FPRODUCT') THEN BEGIN
                                ERROR('PRODUCTION BOM WAS LINKED TO THIS ITEM , PLESE VERIFY & CLOSE IT');
                                PROBLEM := TRUE;
                            END;
                            //Added by Pranavi on 21-10-2015 for checking item is defined as alternate
                            "Alternate Item".SETFILTER("Alternate Item"."Alternative Item No.", Rec."No.");
                            IF "Alternate Item".FINDFIRST THEN
                                ERROR('Item is defined as alternate item for one or more items!');
                            //End by Pranavi

                            // added by Vishnu Priya on 21-11-2020 to avoid the restriction to block the item is not running BOM

                            PBML.SETRANGE(PBML."No.", Rec."No.");
                            IF PBML.FINDSET THEN
                                REPEAT
                                BEGIN
                                    PBML.CALCFIELDS(Status);
                                    PBH1.RESET;
                                    PBH1.SETFILTER("No.", PBML."Production BOM No.");
                                    PBH1.SETRANGE("BOM Running Status", PBH1."BOM Running Status"::Running);
                                    IF PBH1.FINDFIRST THEN BEGIN
                                        IF PBML.Status <> PBML.Status::Closed THEN
                                            IF (Rec."Product Group Code Cust" <> 'FPRODUCT') THEN
                                                ERROR('ITEM IS IN PRODUCTION BOMS PLEASE VERIFY "WHERE USED LIST" ONCE');
                                        IF FPO_ITEM.GET(PBML."Production BOM No.") THEN
                                            FPO_ITEM.TESTFIELD(FPO_ITEM.Blocked);
                                        PROBLEM := TRUE;
                                    END;
                                END
                                UNTIL PBML.NEXT = 0;


                            // VERIFUCATION IN MATERIAL ISSUES LINE
                            "Material Issues Line".SETCURRENTKEY("Material Issues Line"."Item No.", "Material Issues Line"."Prod. Order No.");
                            "Material Issues Line".SETRANGE("Material Issues Line"."Item No.", Rec."No.");
                            IF "Material Issues Line".FINDFIRST THEN BEGIN
                                ERROR(' ITEM IS IN MATERIAL REQUESTS ');
                                PROBLEM := TRUE;
                            END;


                            // VERIFICATION IN PURCHASE ORDER
                            "Purchase Line".SETCURRENTKEY("Purchase Line"."No.", "Purchase Line"."Buy-from Vendor No.");
                            "Purchase Line".SETRANGE("Purchase Line"."No.", Rec."No.");
                            "Purchase Line".SETFILTER("Purchase Line"."Qty. to Receive", '>%1', 0);
                            IF "Purchase Line".FINDFIRST THEN BEGIN
                                ERROR('ITEM IS IN PENDING PURCHASE ORDERS');
                                PROBLEM := TRUE;
                            END;


                            // VERIFICATION IN SALE ORDER & SCHEDULE
                            SH.RESET;
                            SH.SETFILTER(SH."Document Type", '<>%1', SH."Document Type"::Quote);
                            SH.SETFILTER(SH."Order Status", '<>%1', SH."Order Status"::"Temporary Close");
                            IF SH.FINDFIRST THEN
                                REPEAT
                                    "Sales Line".SETCURRENTKEY("Sales Line".Type, "Sales Line"."No.",
                                                             "Sales Line"."Variant Code", "Sales Line"."Drop Shipment",
                                                             "Sales Line"."Location Code",
                                                             "Sales Line"."Document Type",
                                                             "Sales Line"."Shipment Date");
                                    "Sales Line".SETRANGE("Sales Line"."No.", Rec."No.");
                                    "Sales Line".SETFILTER("Sales Line"."Document No.", SH."No.");
                                    "Sales Line".SETFILTER("Sales Line"."Qty. to Ship", '>%1', 0);
                                    IF "Sales Line".FINDFIRST THEN BEGIN
                                        IF (("Sales Line"."Document Type" = "Sales Line"."Document Type"::"Blanket Order") AND (SH."Sale Order Created" = FALSE))
                                            OR ("Sales Line"."Document Type" = "Sales Line"."Document Type"::Order) THEN
                                            ERROR(' ITEM IS IN PENDING SALE ORDER');
                                    END;
                                    Schedule.SETCURRENTKEY(Schedule."Material Required Date", Schedule."No.");
                                    Schedule.SETFILTER(Schedule."Material Required Date", '>%1', TODAY);
                                    Schedule.SETFILTER(Schedule."Document No.", SH."No.");
                                    Schedule.SETRANGE(Schedule."No.", Rec."No.");
                                    IF Schedule.FINDFIRST THEN BEGIN
                                        ERROR('ITEM IS IN SCHEDULE (PENDING)');
                                        PROBLEM := TRUE;
                                    END;
                                UNTIL SH.NEXT = 0;


                            // VERIFICATION IN "PROD ORDER COMPONENT"
                            "Prod. Order Component".SETCURRENTKEY("Prod. Order Component"."Item No.");
                            "Prod. Order Component".SETRANGE("Prod. Order Component"."Item No.", Rec."No.");
                            "Prod. Order Component".SETFILTER("Prod. Order Component"."Remaining Quantity", '>%1', 0);
                            "Prod. Order Component".SETRANGE("Prod. Order Component".Status, "Prod. Order Component".Status::Released);
                            IF "Prod. Order Component".FINDFIRST THEN BEGIN
                                ERROR(' ITEM IS IN PRODUCTION ORDERS SO PLEASE REFRESH THOSE PRODUCTION ORDERS');
                                PROBLEM := TRUE;
                            END;
                        END;
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
                        IF NOT (USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You donot have rights to modify.Contact ERP Team');
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Quote Item"; Rec."Quote Item")
                {
                    ApplicationArea = All;
                }
                field(Stock_Threshold_Value; Rec.Stock_Threshold_Value)
                {
                    Caption = 'Stock_Alert_Threshold_Value';
                    Editable = stock_threshold_value_editable_flag;
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
                    Editable = UnitPriceCustmEdit;
                    ApplicationArea = All;
                }
                field("Manufacturing Cost"; Rec."Manufacturing Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Control1000000026; Rec.PCB)
                {
                    ApplicationArea = All;
                }
                /* field("Capital Item"; "Capital Item")
                {
                    Editable = false;
                    ApplicationArea = All;
                }  */ //B2BUPG
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
                    CaptionML = ENU = 'Gen. Prod. Posting Group *',
                                ENN = 'Gen. Prod. Posting Group';
                    Editable = true;
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF (Rec."Item Sub Sub Group Code" = 'X-RAY VIEWER') AND (Rec."Gen. Prod. Posting Group" <> 'X-RAY VIEW') THEN   // Added by Pranavi on 3Aug206
                            ERROR('For ' + Rec."Item Sub Sub Group Code" + 's Excise Prod. Posting Group must be X-RAY VIEW');
                    end;
                }
                /* field("Excise Prod. Posting Group"; "Excise Prod. Posting Group")
                 {
                     CaptionML = ENU = 'Excise Prod. Posting Group *',
                                 ENN = 'Excise Prod. Posting Group';
                     Editable = true;
                     ApplicationArea = All;

                     trigger OnValidate();
                     begin
                         IF (Rec."Item Sub Sub Group Code" = 'X-RAY VIEWER') AND ("Excise Prod. Posting Group" <> '90221900') THEN   // Added by Pranavi on 3Aug206
                             ERROR('For ' + Rec."Item Sub Sub Group Code" + 's Excise Prod. Posting Group must be 90221900');
                     end;
                 }*/
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    CaptionML = ENU = 'Inventory Posting Group *',
                                ENN = 'Inventory Posting Group';
                    Editable = true;
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    CaptionML = ENU = 'VAT Prod. Posting Group *',
                                ENN = 'VAT Prod. Posting Group';
                    ApplicationArea = All;
                }
                field("GST Group Code"; Rec."GST Group Code")
                {
                    CaptionML = ENU = 'GST Group Code *',
                                ENN = 'GST Group Code';
                    ApplicationArea = All;
                }
                field("GST Credit"; Rec."GST Credit")
                {
                    CaptionML = ENU = 'GST Credit',
                                ENN = 'GST Credit';
                    ApplicationArea = All;
                }
                field("HSN/SAC Code"; Rec."HSN/SAC Code")
                {
                    CaptionML = ENU = 'HSN/SAC Code *',
                                ENN = 'HSN/SAC Code';
                    ApplicationArea = All;
                }
                field(Exempted; Rec.Exempted)
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
                 }
                 field("Assessable Value"; "Assessable Value")
                 {
                     Editable = true;
                     ApplicationArea = All;
                 }*/
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
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

                        trigger OnValidate();
                        begin
                            //Added By Pranavi on 09-11-2015
                            IF Rec."Production BOM No." <> '' THEN BEGIN
                                Rec."Replenishment System" := Rec."Replenishment System"::"Prod. Order";
                                Rec."Manufacturing Policy" := Rec."Manufacturing Policy"::"Make-to-Order";
                            END;
                            //End by Pranavi
                        end;
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
                field("Benchmarks(in Min)"; Rec."Benchmarks(in Min)")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ProdOrders.RESET;
                        ProdOrders.SETRANGE(Status, ProdOrders.Status::Released);
                        ProdOrders.SETRANGE("Source No.", "No.");
                        IF ProdOrders.FINDSET THEN BEGIN
                            REPEAT
                                ProdOrders."Benchmarks(in Min)" := "Benchmarks(in Min)";
                                ProdOrders."Total Time" := ProdOrders.Quantity * "Benchmarks(in Min)";
                                ProdOrders.MODIFY;
                            UNTIL ProdOrders.NEXT = 0;
                        END;
                    end;
                }
                field("No.of Units"; Rec."No.of Units")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ProdOrders.RESET;
                        ProdOrders.SETRANGE(Status, ProdOrders.Status::Released);
                        ProdOrders.SETRANGE("Source No.", Rec."No.");
                        IF ProdOrders.FINDSET THEN BEGIN
                            REPEAT
                                ProdOrders.Itm_card_No_of_Units := Rec."No.of Units";
                                ProdOrders.Itm_Card_ttl_units := ProdOrders.Quantity * Rec."No.of Units";
                                ProdOrders.MODIFY;
                            UNTIL ProdOrders.NEXT = 0;
                        END;
                    end;
                }
                field("Shop floor Units"; Rec."Shop floor Units")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) THEN
                            ERROR('You donot have rights to modify.Contact ERP Team');
                    end;
                }
                field("Wiring Units"; Rec."Wiring Units")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) THEN
                            ERROR('You donot have rights to modify.Contact ERP Team');
                    end;
                }
                field("Testing Units"; Rec."Testing Units")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) THEN
                            ERROR('You donot have rights to modify.Contact ERP Team');
                    end;
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
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PAVANGIRI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\MANOJA',
                              'EFFTRONICS\NSURESH', 'EFFTRONICS\RISHMITHA', 'EFFTRONICS\PARVATHIRAJULAPATI', 'EFFTRONICS\KSIRISHA', 'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\NVSIVAKUMARI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\SATYANARAYANA', 'EFFTRONICS\VENKANNA', 'EFFTRONICS\YSAIPAVAN', 'EFFTRONICS\VEERABHADRA', 'EFFTRONICS\CHANDRASEKHARK']) THEN
                            ERROR('You donot have rights to modify.Contact ERP Team');
                    end;
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
                field("PO Blocked"; Rec."PO Blocked")
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
                field("Identifier Code"; Rec."Identifier Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Next Counting Start Date"; Rec."Next Counting Start Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Next Counting End Date"; Rec."Next Counting End Date")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Use Cross-Docking"; Rec."Use Cross-Docking")
                {
                    Editable = false;
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
                    Editable = qc_flag_editable;
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
            group(Control1900582501)
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
                field("Item End of Date in Market"; Rec."Item End of Date in Market")
                {
                    ApplicationArea = All;
                }
                field("Effe Status"; Rec."Effe Status")
                {
                    ApplicationArea = All;
                }
                field("Effe Cost"; Rec."Effe Cost")
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
                field("Packing Type"; Rec."Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Packing Dimension"; Rec."Packing Dimension")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        // added by vishnu Priya on 13-03-2020 for the data validation ourpose
                        // Must enter the 3 dimensions like length/radius, width and radius for the components
                        xcnt := 0;
                        Body := Rec."Packing Dimension";
                        //singlequotesremoval(item1.Description);
                        FOR i := 1 TO STRLEN(Body) DO BEGIN
                            IF COPYSTR(Body, i, 1) = 'X' THEN
                                xcnt += 1;
                        END;
                        IF xcnt = 2 THEN BEGIN
                            Subject := Body;
                            XPOS1 := STRPOS(Subject, 'X');
                            t1 := COPYSTR(Subject, 1, XPOS1 - 1);
                            MESSAGE('FIRST NUMBER PART:' + FORMAT(t1));
                            FOR i := 1 TO STRLEN(t1) DO BEGIN
                                IF NOT (FORMAT(t1[i]) IN ['0' .. '9']) THEN ERROR('USE NUMBERS AND X FOR THE SEPARATOR LIKE 10X200X25.AVOID SPACES IN PART1' + t1)
                            END;
                            Subject := COPYSTR(Subject, XPOS1 + 1, STRLEN(Subject));
                            XPOS2 := STRPOS(Subject, 'X');
                            t2 := COPYSTR(Body, XPOS1 + 1, XPOS2 - 1);
                            FOR i := 1 TO STRLEN(t2) DO BEGIN
                                IF NOT (FORMAT(t2[i]) IN ['0' .. '9']) THEN ERROR('USE NUMBERS AND X FOR THE SEPARATOR LIKE 10X200X25.AVOID SPACES IN PART2' + t2)
                            END;
                            MESSAGE('2ND NUMBER PART: ' + FORMAT(t2));
                            t3 := COPYSTR(Body, XPOS2 + XPOS1 + 1, STRLEN(Body));
                            MESSAGE(FORMAT('3RD PART: ' + t3));
                            FOR i := 1 TO STRLEN(t3) DO BEGIN
                                IF NOT (FORMAT(t3[i]) IN ['0' .. '9']) THEN ERROR('USE NUMBERS AND X FOR THE SEPARATOR LIKE 10X200X25.AVOID SPACES IN PART3' + t3)
                            END;

                        END
                        ELSE
                            IF STRLEN(Body) > 0 THEN
                                ERROR('PLEASE ENTER THE DIMENSION IN 10X20X30  FORMAT');
                    end;
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
                        IF NOT (USERID IN ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUJANI']) THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    Caption = 'Base Copper Clad Thickness(In Microns)';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUJANI']) THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("PCB Shape"; Rec."PCB Shape")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\SUJANI']) THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUJANI']) THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\SWATHI', 'EFFTRONICS\SUJANI']) THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    DecimalPlaces = 1 : 5;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (USERID <> 'SUPER') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("Semi Mounted"; Rec."Semi Mounted")
                {
                    ApplicationArea = All;
                }
                field("Panel Length"; Rec."Panel Length")
                {
                    Caption = 'Panel Length(In mm)';
                    ApplicationArea = All;
                }
                field("Panel Width"; Rec."Panel Width")
                {
                    Caption = 'Panel Width(In mm)';
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
                    ApplicationArea = All;
                }
                field("ESD Class"; Rec."ESD Class")
                {
                    ApplicationArea = All;
                }
                field("Floor Life at 25 C 40% RH"; Rec."Floor Life at 25 C 40% RH")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        //added by Vishnu Priya on 30-07-2019 to restrict the othertahn Values
                        IF Rec."Floor Life at 25 C 40% RH" <> '' THEN
                            IF Rec."Floor Life at 25 C 40% RH" <> 'INFINITE' THEN
                                IF EVALUATE(FLOORLIFEINT, Rec."Floor Life at 25 C 40% RH") THEN
                                    EXIT
                                ELSE
                                    ERROR('You Entered other than balnk,INFINITE and Some Temperature');
                    end;
                }
                field("Bake Hours"; Rec."Bake Hours")
                {
                    ApplicationArea = All;
                }
                field("Component Shelf Life(Years)"; Rec."Component Shelf Life(Years)")
                {
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
                field("Thickness of Package"; Rec."Thickness of Package")
                {
                    ApplicationArea = All;
                }
                field("Feeder Packing Type"; Rec."Feeder Packing Type")
                {
                    ApplicationArea = All;
                }
                field("Feeder Packing Width(mm)"; Rec."Feeder Packing Width(mm)")
                {
                    Caption = 'Feeder Packing Width(mm)';
                    ToolTip = 'If it  was Above 32 mm, Manual Arrangement will be done at Re-flow stage';
                    ApplicationArea = All;
                }
            }
            group("Tax Information")
            {
                Caption = 'Tax Information';
                /* field("MRP Value"; "MRP Value")
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
                 }*/
                /*field("Price Inclusive of Tax"; "Price Inclusive of Tax")
                {
                    ApplicationArea = All;
                }
                field("PIT Structure";"PIT Structure")
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
                      }*/
                }
                group(VAT)
                {
                    Caption = 'VAT';
                    /* field("Fixed Asset"; "Fixed Asset")
                     {
                         ApplicationArea = All;
                     }*/
                }
            }
            group(Machine)
            {
                field("No of Panels"; Rec."No of Panels")
                {
                    Editable = mch_tag_editable;
                    ApplicationArea = All;
                }
                field(SMD_But_mchine_cant_do; Rec.SMD_But_mchine_cant_do)
                {
                    Caption = 'Machine Can''t Do';
                    Editable = mch_tag_editable;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
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
                Image = Item;
                action("Stockkeepin&g Units")
                {
                    Caption = 'Stockkeepin&g Units';
                    Image = SKU;
                    RunObject = Page "Stockkeeping Unit List";
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
                        Image = TaskQualityMeasure;
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
                        RunObject = Page "Item Variants Cust";
                        RunPageLink = "Item No." = FIELD("No.");//, "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"), "Location Filter" = FIELD("Location Filter"), "Drop Shipment Filter" = FIELD("Drop Shipment Filter"), "Variant Filter" = FIELD("Variant Filter");
                        ApplicationArea = all;
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
                        IF pcb1.FINDFIRST THEN
                            PAGE.RUN(60240, pcb1)
                        ELSE BEGIN
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
                            pcb1.Multiples_Per_Stencil := 1;
                            pcb1.INSERT;
                            pcb1.RESET;
                            pcb1.SETRANGE(pcb1."PCB No.", "No.");
                            IF pcb1.FINDFIRST THEN
                                PAGE.RUN(60240, pcb1);
                        END;
                    end;
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
                    RunObject = Page "Item Variants Cust";
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
                action("Alternative Items")
                {
                    Caption = 'Alternative Items';
                    Image = ItemSubstitution;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        "Alternate Item".SETRANGE("Alternate Item"."Item No.", "No.");
                        PAGE.RUN(60070, "Alternate Item");
                    end;
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
                        Image = BOM;
                        RunObject = Page "Assembly BOM";
                        RunPageLink = "Parent Item No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action("Where-Used List")
                    {
                        Caption = 'Where-Used List';
                        Image = Track;
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
                        Image = DebugNext;
                        RunObject = Page "Troubleshooting Setup";
                        RunPageLink = Type = CONST(Item), "No." = FIELD("No.");
                        ApplicationArea = All;
                    }
                    action(Action186)
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
                            //SkilledResourceList.RUNMODAL;
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
                    RunPageLink = "Item No." = FIELD("No. 2"), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                    ApplicationArea = All;
                }
                action(Attachments)
                {
                    Caption = 'Attachments';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "ESPL Attachments";
                    RunPageLink = "Table ID" = CONST(27), "Document No." = FIELD("No.");
                    ApplicationArea = All;
                }
                separator(Action1000000016)
                {
                }
                action("Design Work Sheet")
                {
                    Caption = 'Design Work Sheet';
                    Image = Worksheet;
                    RunObject = Page "Item Design WorkSheet Header";
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
                        PAGE.RUN(595, Changelog);
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
            group(Purchase)
            {
                Caption = 'Purchase';
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
            //Caption = '<Action1900000004>';
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
                    Image = BOMLevel;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        ItemCostUpdation.UpdateBOM;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin

        //swathi for visiblity condition of pcb card
        visible1 := FALSE;
        item.RESET;
        item.SETRANGE(item."No.", "No.");
        IF item.FINDFIRST THEN BEGIN
            IF item."Product Group Code Cust" IN ['PCB', 'MPCB', 'CPCB'] THEN BEGIN
                visible1 := TRUE;
            END;
        END;    //swathi

        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
        EnablePlanningControls;
        //B2B
        IF ("QC Enabled" = TRUE) AND (Inventory >= 0) THEN
            "Quantity Accepted" := Inventory - ("Quantity Rejected" + "Quantity Under Inspection" + "Quantity Rework" +
                                                "Quantity Sent for Rework");
        //B2B
        /*atta:=FALSE;
        attachments.RESET;
        attachments.SETRANGE("Table ID",DATABASE::Item);
        attachments.SETRANGE("Document No.","No.");
        IF attachments.COUNT>0 THEN
        atta:=TRUE;
           */
        NoOnFormat;
        DescriptionOnFormat;

    end;

    trigger OnInit();
    begin
        "Include InventoryEnable" := TRUE;
        "Maximum Order QuantityEnable" := TRUE;
        "Maximum InventoryEnable" := TRUE;
        "Reorder QuantityEnable" := TRUE;
        "Reorder PointEnable" := TRUE;
        "Reorder CycleEnable" := TRUE;
        qc_flag_editable := FALSE;
        stock_threshold_value_editable_flag := FALSE;
        mch_tag_editable := FALSE;
    end;

    trigger OnOpenPage();
    begin
        // anil  OnActivateForm;
        //Added By pranavi on 28-09-2015
        IF USERID IN ['EFFTRONICS\ANILKUMAR',
                             'EFFTRONICS\BHARAT',
                             'EFFTRONICS\BALA','EFFTRONICS\UBEDULLA',
                             'EFFTRONICS\PKOTESWARARAO','EFFTRONICS\GRAVI','EFFTRONICS\PARVATHIRAJULAPATI','EFFTRONICS\VSNGEETHA',
                             'EFFTRONICS\PADMAJA','EFFTRONICS\SUVARCHALADEVI','EFFTRONICS\PAVANGIRI','EFFTRONICS\TPRIYANKA','EFFTRONICS\DURGAMAHESWARI','EFFTRONICS\RENUKACH','EFFTRONICS\RAMALAKSHMI','EFFTRONICS\NVSIVAKUMARI',
                             'EFFTRONICS\RISHMITHA','EFFTRONICS\KSIRISHA','EFFTRONICS\YSAIPAVAN','EFFTRONICS\SATYANARAYANA','EFFTRONICS\VENKANNA','EFFTRONICS\VEERABHADRA','EFFTRONICS\CHANDRASEKHARK','EFFTRONICS\KRAMARAO',
                             'EFFTRONICS\APPARAO','EFFTRONICS\THIRUPATIRAO','EFFTRONICS\RAVEENDRAP','EFFTRONICS\SAIVENKAT','EFFTRONICS\IMRAN','EFFTRONICS\NAGUL','EFFTRONICS\VASUDEVARAO','EFFTRONICS\VANIDEVI'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
        //End by Pranvai
        //'EFFTRONICS\GRAVI','EFFTRONICS\ANVKUMARI','EFFTRONICS\NAGAGAYATRI',
        //added by Pranavi on 23-06-2015 for Unit Price editing rights to ERP team
        IF /*{("Product Group Code" = 'FPRODUCT') AND}*/ (USERID IN ['EFFTRONICS\ANILKUMAR','EFFTRONICS\GRAVI']) THEN
            UnitPriceCustmEdit := TRUE
        ELSE
            UnitPriceCustmEdit := FALSE;
        //End by Pranavi

        IF (USERID IN ['EFFTRONICS\MARY']) AND ("Item Category Code" IN ['OFFICE MAI', '', 'STA']) THEN BEGIN
            CurrPage.EDITABLE := TRUE;
        END;

        IF NOT (SMTP_MAIL.Permission_Checking(USERID, 'QC FLAG'))
            THEN
            qc_flag_editable := FALSE
        ELSE
            qc_flag_editable := TRUE;


        IF NOT (SMTP_MAIL.Permission_Checking(USERID, 'STOCK_THERSHOLD_FLAG'))
            THEN
            stock_threshold_value_editable_flag := FALSE
        ELSE
            stock_threshold_value_editable_flag := TRUE;
        IF (USERID IN ['EFFTRONICS\UBEDULLA','EFFTRONICS\SUJANI','EFFTRONICS\VANIDEVI','EFFTRONICS\RISHMITHA','EFFTRONICS\KSIRISHA','EFFTRONICS\RAMALAKSHMI','EFFTRONICS\NVSIVAKUMARI']) THEN
            mch_tag_editable := TRUE
        ELSE
            mch_tag_editable := FALSE;
        "VAT Prod. Posting Group" := 'NO VAT';

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        //Added By Pranavi on 07-09-2015
        /*
        IF "Item Tracking Code" = '' THEN
          ERROR('Please Select Item Tracking Code!');
        */
        //End By Pranavi

        //added by Vishnu Priya on 03-02-2020
        IF ("Item Status" = Rec."Item Status"::EOL) AND (Rec."Item End of Date in Market" = 0D) THEN
            ERROR('Please Fill the End of Life For the Item' + Rec."No.");
        //added by Vishnu Priya on 03-02-2020

    end;

    var
        TroubleshHeader: Record "Troubleshooting Header";
        ItemCostMgt: Codeunit ItemCostManagement;
        CalculateStdCost: Codeunit "Calculate Standard Cost";
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
        ItemCostUpdation: Codeunit "Item Cost Updation";
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
        Text19026065: Label 'Attachments';
        SkilledResourceList: Page "Skilled Resource List";
        pcb1: Record PCB;
        visible1: Boolean;
        item: Record Item;
        Changelog: Record "Change Log Entry";
        UnitPriceCustmEdit: Boolean;
        SMTP_MAIL: Codeunit "Custom Events";
        qc_flag_editable: Boolean;
        stock_threshold_value_editable_flag: Boolean;
        mch_tag_editable: Boolean;
        ProdOrders: Record "Production Order";
        FLOORLIFEINT: Integer;
        xcnt: Integer;
        XPOS1: Integer;
        XPOS2: Integer;
        i: Integer;
        Body: Text;
        Subject: Text;
        t1: Text;
        t2: Text;
        t3: Text;
        PBH1: Record "Production BOM Header";


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
        IF NOT (UPPERCASE(USERID) IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUJANI']) THEN
            ERROR('You dont have Permissions');
    end;


    local procedure AverageCostLCYOnActivate();
    begin
        ItemCostMgt.CalculateAverageCost(Rec, AverageCostLCY, AverageCostACY);
    end;


    local procedure OnActivateForm();
    begin
        //Rev01 As directed by anil
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            CurrPage.EDITABLE := FALSE
        ELSE
            CurrPage.EDITABLE := TRUE;

        //Rev01 As directed by anil
    end;


    local procedure ProductGroupCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\RAMALAKSHMI',
                           'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemCategoryCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI', 'EFFTRONICS\RAMALAKSHMI',
                             'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemSubGroupCodeOnBeforeInput();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
            ERROR('You have No Rights to Change the Item Groups');
    end;


    local procedure ItemSubSubGroupCodeOnBeforeInp();
    begin
        IF NOT (USERID IN ['SUPER', 'EFFTRONICS\JHANSI', 'EFFTRONICS\PARVATHI', 'EFFTRONICS\VANIDEVI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RATNARAVALI', 'EFFTRONICS\RSILPARANI',
                           'EFFTRONICS\RAMALAKSHMI', 'EFFTRONICS\UBEDULLA', 'EFFTRONICS\PADMAJA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\MEENA', 'EFFTRONICS\GRAVI',
                           'EFFTRONICS\ANUSHAG', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
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


    local procedure CheckinPurchaseOrders_and_SaleOrders(ItemNumber: Code[20]) Existedornot: Boolean;
    var
        SL: Record "Sales Line";
        PL: Record "Purchase Line";
        SIL: Record "Sales Invoice Line";
    begin
        IF USERID = 'EFFTRONICS\SUVARCHALADEVI' THEN
            EXIT(FALSE);

        PL.RESET;
        PL.SETCURRENTKEY(PL."No.", PL."Unit Cost (LCY)");
        PL.SETRANGE(PL."Document Type", PL."Document Type"::Order);
        PL.SETFILTER(PL.Type, '<>%1', PL.Type::"G/L Account");
        PL.SETFILTER(PL."No.", ItemNumber);
        IF PL.FINDFIRST THEN
            Existedornot := TRUE
        ELSE BEGIN
            SL.RESET;
            SL.SETCURRENTKEY(SL.Type, SL."No.", SL."Variant Code", SL."Drop Shipment", SL."Location Code", SL."Document Type", SL."Shipment Date");
            SL.SETRANGE(SL.Type, SL.Type::Item);
            SL.SETFILTER(SL."No.", ItemNumber);
            // SL.SETFILTER("Product Group Code",'<>%1','<>%2','FPRODUCT','CPCB');
            IF SL.FINDFIRST THEN
                IF NOT (SL."Product Group Code Cust" IN ['FPRODUCT', 'CPCB']) THEN
                    Existedornot := TRUE
                ELSE BEGIN
                    SIL.RESET;
                    SIL.SETCURRENTKEY(SIL."Document No.", SIL."No.");
                    SIL.SETRANGE(SIL.Type, SIL.Type::Item);
                    SIL.SETFILTER(SIL."No.", ItemNumber);
                    //SIL.SETFILTER("Product Group Code",'<>%1','<>%2','FPRODUCT','CPCB');
                    IF SIL.FINDFIRST THEN
                        IF NOT (SIL."Produc Group Code Cust" IN ['FPRODUCT', 'CPCB']) THEN
                            Existedornot := TRUE
                        ELSE
                            Existedornot := FALSE;
                END
        END;
    end;
}

