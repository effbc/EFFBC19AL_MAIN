tableextension 70009 ItemExt extends Item
{

    fields
    {
        field(60001; "No. of Pins"; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "No. of Soldering Points"; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "No. of Opportunities"; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; Sample; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Item Sub Group Code"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = FIELD("Product Group Code Cust"));

            trigger OnValidate();
            var
                ItemSubSubGroup: Record "Item Sub Sub Group";
            begin
                if not ItemSubSubGroup.Get("Item Sub Group Code", "Item Sub Sub Group Code") then
                    Validate("Item Sub Sub Group Code", '')
                else
                    Validate("Item Sub Sub Group Code");
            end;
        }
        field(60006; "Item Sub Sub Group Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Item Sub Sub Group".Code WHERE("Item Sub Group Code" = FIELD("Item Sub Group Code"));
            DataClassification = CustomerContent;
        }
        field(60007; "Purchaser Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Salesperson/Purchaser".Code WHERE("Salesperson/Purchaser" = CONST(Purchase));
            DataClassification = CustomerContent;
        }
        field(60008; "Type of Solder"; Enum TypeofSolder)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(60009; "Item Stock Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60010; "Stock At MCH Location"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('MCH'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60015; "No.of Fixing Holes"; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60016; "Used In DL"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60017; DL_Consumption; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Used In MFEP"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60019; MFEP_Consumption; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60020; "Used In RTU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60021; RTU_Consumption; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60022; "Used In PMU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60023; PMU_Consumption; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "Standard Packing Quantity"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60025; "Bom Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60026; "Cs Stock Verified"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60027; "Inspection Bench Mark(In Min)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60028; "Sampling Count"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Inspection Bench Mark(In Min)");
                if "Sampling %" > 0 then
                    Error('ONLY ONE PARAMETER (SAMPLING COUNT,SAMPLING %) WILL ALLOWED PLEASE CLEAR THE OTHER PARAMETER (')
            end;
        }
        field(60029; "Sampling %"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Inspection Bench Mark(In Min)");
                if "Sampling Count" > 0 then
                    Error('ONLY ONE PARAMETER (SAMPLING COUNT,SAMPLING %) WILL ALLOWED')
            end;
        }
        field(60030; Qc_Item; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60031; "Service Tax Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Service Tax Groups".Code;
        }
        field(60032; "Used In BMU"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60033; "Used In IPIS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60035; "Used In PC"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60036; "Used In RLY.LMP"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60037; "Used In Bus Displays"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60038; "Soldering Temp."; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(60039; "Soldering Time (Sec)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60040; "Work area Temp &  Humadity"; Code[25])
        {
            DataClassification = CustomerContent;
        }
        field(60041; ESD; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60042; "Dispatch Material"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not (UserId in ['EFFTRONICS\JHANSI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
                    Error('You have no rights to modify');
            end;
        }
        field(60043; Package; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60044; "Part Number"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60099; "Inventory at Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('STR'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                "Item Stock Value" := "Inventory at Stores" * "Avg Unit Cost";
            end;
        }
        field(60100; "Insp. Time Inbound(In Min.)"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60101; "Insp. Time WIP(In Min.)"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60102; InventoryDim; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  Open = CONST(true),
                                                                  "Remaining Quantity" = FILTER(> 0)));
            Caption = 'InventoryDim';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(60103; "Total Inventory"; Decimal)
        {
            Description = 'B2B (For Shortage List Report)';
            DataClassification = CustomerContent;
        }
        field(60105; PCB; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60200; "Avg Unit Cost"; Decimal)
        {
            Description = 'Cost1.0';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CalcFields("Inventory at Stores");
                "Item Stock Value" := "Inventory at Stores" * "Avg Unit Cost";
            end;
        }
        field(60201; "Manufacturing Cost"; Decimal)
        {
            Description = 'Cost1.0';
            DataClassification = CustomerContent;
        }
        field(60202; "User ID"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60203; Item_verified; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item_verified = true then
                    "Item Grp Verified Date" := CurrentDateTime;
            end;
        }
        field(60204; "Item Location"; Code[10])
        {
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(60205; "Qty. on Mat.Req"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60206; "Stock at Stores"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CalcFields("Quantity Under Inspection", "Quantity Rejected", "Quantity Rework", "Quantity Sent for Rework");
                if "QC Enabled" = true then begin
                    if ("Quantity Under Inspection" = 0) and ("Quantity Rejected" = 0) and ("Quantity Rework" = 0) and ("Quantity Sent for Rework" = 0) then begin
                        ItemLedgEntry.Reset;
                        ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                        "Expiration Date", "Lot No.", "Serial No.");
                        ItemLedgEntry.SetRange("Item No.", "No.");
                        ItemLedgEntry.SetRange(Open, true);
                        ItemLedgEntry.SetRange("Location Code", 'STR');
                        PAGE.RunModal(38, ItemLedgEntry);
                    end else begin
                        ItemLedgEntry.Reset;
                        ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                        "Expiration Date", "Lot No.", "Serial No.");

                        ItemLedgEntry.SetRange("Item No.", "No.");
                        ItemLedgEntry.SetRange(Open, true);
                        ItemLedgEntry.SetRange("Location Code", 'STR');
                        if ItemLedgEntry.Find('-') then
                            repeat
                                ItemLedgEntry.Mark(true);
                                if QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.") and (QualityItemLedgEntry."Inspection Status" =
                                QualityItemLedgEntry."Inspection Status"::"Under Inspection") then
                                    ItemLedgEntry.Mark(false);
                            until ItemLedgEntry.Next = 0;
                        ItemLedgEntry.MarkedOnly(true);
                        PAGE.RunModal(38, ItemLedgEntry);
                    end;
                end;
            end;
        }
        field(60207; "Stock at CS Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FILTER('CS STR'),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60208; "Stock at RD Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FILTER('R&D STR'),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60209; PROD_USED; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60210; "Safety Stock Qty (CS)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60211; "Safety Stock Qty (R&D)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(60212; ProductType; Option)
        {
            OptionMembers = " ",DL,RlyLamp,RoadLamp,DIS,SYS,Others;
            DataClassification = CustomerContent;
        }
        field(60213; Dum_Avg_Cot; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60215; "No.of Units"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                ProdOrders.Reset;
                ProdOrders.SetRange(Status, ProdOrders.Status::Released);
                ProdOrders.SetRange("Source No.", "No.");
                if ProdOrders.FindSet then begin
                    ProdOrders.Itm_card_No_of_Units := "No.of Units";
                    ProdOrders.Itm_Card_ttl_units := ProdOrders.Quantity * "No.of Units";
                    ProdOrders.Modify;
                end
            end;
        }
        field(60216; ItemlastTransDate; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /* ItemLedgEntry.SETFILTER(ItemLedgEntry."Location Code",'STR');
                 ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity",'>%1',0);
                  IF ItemLedgEntry.FIND('-') THEN
                  ItemlastTransDate:=ItemLedgEntry."Posting Date";*/

            end;
        }
        field(60217; "Operating Temperature"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(60218; "Storage Temperature"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(60219; Humidity; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(60220; "ESD Sensitive"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60221; "Item Status"; Enum "Item Status")
        {
            DataClassification = CustomerContent;

        }
        field(60222; Make; Code[30])
        {
            TableRelation = Make;
            DataClassification = CustomerContent;
        }
        field(60223; "Item Final Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60224; "Safety Stock Qty (MCH)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60225; "PCB thickness"; Decimal)
        {
            Caption = 'PCB thickness(In mm)';
            DataClassification = CustomerContent;
        }
        field(60226; "Copper Clad Thickness"; Decimal)
        {
            Caption = 'Copper Clad Thickness(In Microns)';
            DataClassification = CustomerContent;
        }
        field(60227; "PCB Area"; Decimal)
        {
            Caption = 'PCB Area(In Sq cm)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "PCB Shape" = "PCB Shape"::Circular then
                    "PCB Area" := (22 * Length * Length) / (7 * 4 * 100)
                else
                    "PCB Area" := Length * Width / (100);
            end;
        }
        field(60228; Length; Decimal)
        {
            Caption = 'Length(In mm)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "PCB Shape" <> "PCB Shape"::Rectangle then
                    "PCB Area" := (22 * Length * Length) / (7 * 4 * 100)
                else
                    "PCB Area" := Length * Width / (100);
            end;
        }
        field(60229; Width; Decimal)
        {
            Caption = 'Width(In mm)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "PCB Shape" <> "PCB Shape"::Rectangle then
                    "PCB Area" := (22 * Length * Length) / (7 * 4 * 100)
                else
                    "PCB Area" := Length * Width / (100);
            end;
        }
        field(60230; "PCB Shape"; Enum "Item Pcb")
        {
            DataClassification = CustomerContent;


            trigger OnValidate();
            begin
                if "Product Group Code Cust" <> 'PCB' then
                    "PCB Shape" := "Item Pcb".FromInteger(0);

                if "PCB Shape" <> "PCB Shape"::Rectangle then
                    "PCB Area" := (22 * Length * Length) / (7 * 4 * 100)
                else
                    "PCB Area" := Length * Width / (100);
            end;
        }
        field(60231; "On C-Side"; Enum "Item Cside")
        {
            DataClassification = CustomerContent;

        }
        field(60232; "On D-Side"; Enum "Item Cside")
        {
            DataClassification = CustomerContent;

        }
        field(60233; "On S-Side"; Enum "Item Cside")
        {
            DataClassification = CustomerContent;

        }
        field(60234; "Stock at PROD Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FILTER('PRODSTR'),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60235; "Semi Mounted"; Enum "Item semi")
        {
            DataClassification = CustomerContent;

        }
        field(60236; "Surface Finish"; Enum "Item Surface")
        {
            DataClassification = CustomerContent;

        }
        field(60237; "Used in LED Lamps"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60238; "Used in LC GATE"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60239; "USED in MLRI"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60240; "Used in BI"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60241; "Used in Road lamp WTLC"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60242; "Invert Solder type"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //UPGREV2.0>>
                /*
                ProdOrderComp.RESET;
                ProdOrderComp.SETFILTER(ProdOrderComp.Status,'RELEASED');
                ProdOrderComp.SETFILTER(ProdOrderComp."Item No.","No.");
                IF ProdOrderComp.FINDFIRST THEN
                REPEAT
                
                UNTIL ProdOrderComp.NEXT=0;
                */
                //UPGREV2.0>>

            end;
        }
        field(60243; EFF_MOQ; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60244; ROHS; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60245; REACH; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60246; "CS IGC"; Code[50])
        {
            Description = 'cs item sub group code';
            DataClassification = CustomerContent;
        }
        field(60248; "Need to be returned"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60249; "Lead Time Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60250; Verified_Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60251; "PO Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60252; "BIN Address"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60253; Remarks; Text[250])
        {
            Description = 'For TEMC Remarks';
            DataClassification = CustomerContent;
        }
        field(60254; "Stock Address"; Code[10])
        {
            Description = 'For Store Stock Address';
            DataClassification = CustomerContent;
        }
        field(60255; "Thickness of Package"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60256; MSL; Enum "Item Msl")
        {
            DataClassification = CustomerContent;

        }
        field(60257; "ESD Class"; Enum ItemESD)
        {
            DataClassification = CustomerContent;
        }
        field(60258; "Floor Life at 25 C 40% RH"; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(60259; "Bake Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60260; "Component Shelf Life(Years)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60261; "Panel Length"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60262; "Panel Width"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60263; "Item End of Date in Market"; Date)
        {
            Description = 'Added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(60264; "Effe Cost"; Decimal)
        {
            Description = 'Added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(60265; "Effe Status"; Enum "Item Effe")
        {
            DataClassification = CustomerContent;

        }
        field(60266; "Packing Type"; Enum "Item Packing")
        {
            Description = 'Added by Vishnu Priya';
            DataClassification = CustomerContent;

        }
        field(60267; "Packing Dimension"; Text[30])
        {
            Description = 'Added by Vishnu Priya';
            DataClassification = CustomerContent;
        }
        field(60268; "PROD Soldering Time(in Min)"; Decimal)
        {
            Description = 'Added by Suvarchala';
            DataClassification = CustomerContent;
        }
        field(60278; "Stock at Mag Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FILTER('MAGSTR'),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60279; "Stock at Mag MCH1"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FILTER('JMCH1'),
                                                                              "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Lot No." = FIELD("Lot No. Filter"),
                                                                              "Serial No." = FIELD("Serial No. Filter")));
            FieldClass = FlowField;
        }
        field(60280; "Revised Sampling Count"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60281; "Revised Sampling Percentage"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60282; "Revised Sampling Time Mins"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60283; "Visual Sampling Count"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60284; "Visual Sampling Percentage"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60285; "Visual Sampling Time Mins"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60286; "Dimensions Sampling Count"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60287; "Dimensions Sampling Percentage"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60288; "Dimensions Sampling Time Mins"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60289; "Basic Functional Sampling Cnt"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60290; "Basic Functional Sampling Per"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60291; "Basic Func Sampling Time -Mins"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60292; "Documentation Time"; Decimal)
        {
            Description = 'Added by Vishnu for Inwards Planning';
            DataClassification = CustomerContent;
        }
        field(60293; "Item Grp Verified Date"; DateTime)
        {
            Description = 'Added by Vishnu for Item Grps Validation';
            DataClassification = CustomerContent;
        }
        field(60294; "Feeder Packing Type"; Enum "Item Feeder")
        {
            Description = 'Added by Vishnu for Machine Feeders Logging';
            DataClassification = CustomerContent;


        }
        field(60295; "Feeder Packing Width(mm)"; Decimal)
        {
            Description = 'Added by Vishnu for Machine Feeders Logging';
            DataClassification = CustomerContent;
        }
        field(60296; "Shop floor Units"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchaladevi for Production';

            trigger OnValidate();
            begin
                if not (UserId in ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) then
                    Error('You donot have rights to modify.Contact ERP Team');
            end;
        }
        field(60297; "Wiring Units"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchaladevi for Production';

            trigger OnValidate();
            begin
                if not (UserId in ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) then
                    Error('You donot have rights to modify.Contact ERP Team');
            end;
        }
        field(60298; "Testing Units"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchaladevi for Production';

            trigger OnValidate();
            begin
                if not (UserId in ['EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\PADMAJA']) then
                    Error('You donot have rights to modify.Contact ERP Team');
            end;
        }
        field(60299; "Benchmarks(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Suvarchaladevi for Production Plan';

            trigger OnValidate();
            var
                ProdLine: Record "Prod. Order Line";
            begin
                ProdLine.RESET;
                ProdLine.SETRANGE(Status, ProdLine.Status::Released);
                ProdLine.SETRANGE("Item No.", "No.");
                IF ProdLine.FINDSET THEN BEGIN
                    ProdLine."Benchmark(in Min)" := "Benchmarks(in Min)";
                    ProdLine."Total Benchmarks(in Min)" := ProdLine.Quantity * "Benchmarks(in Min)";
                    ProdLine.MODIFY;
                end;
            end;
        }
        field(60300; "Quote Item"; Boolean)
        {
            Description = 'B2BQTO';
            DataClassification = CustomerContent;
        }
        field(60301; "Shelf No.1"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33000250; "Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header"."Spec ID" WHERE(Status = CONST(Certified));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("QC Enabled");
                //B2B
                if SpecificationHeader.Get("Spec ID") then begin
                    SpecificationHeader.CalcFields(SpecificationHeader."Inspection Time(In Hours)");
                    Validate("Insp. Time Inbound(In Min.)", SpecificationHeader."Inspection Time(In Hours)");
                end else
                    Validate("Insp. Time Inbound(In Min.)", 0);
                //B2B
            end;
        }
        field(33000251; "QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "QC Enabled" then
                    TestField("Spec ID");

                //QCB2B1.2 Deleted Start
                //TestNoEntriesExist(FIELDCAPTION("QC Enabled"));
                //QCB2B1.2 Deleted End
            end;
        }
        field(33000252; "Lots Accept"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;
        }
        field(33000253; "Quantity Under Inspection"; Decimal)
        {
            CalcFormula = Sum("Quality Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                                      "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                      "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                      "Location Code" = FIELD("Location Filter"),
                                                                                      "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                                      "Variant Code" = FIELD("Variant Filter"),
                                                                                      "Lot No." = FIELD("Lot No. Filter"),
                                                                                      "Serial No." = FIELD("Serial No. Filter"),
                                                                                      "Inspection Status" = CONST("Under Inspection"),
                                                                                      "Sent for Rework" = CONST(false),
                                                                                      Accept = CONST(true)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000254; "Quantity Rejected"; Decimal)
        {
            CalcFormula = Sum("Quality Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                                      "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                      "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                      "Location Code" = FIELD("Location Filter"),
                                                                                      "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                                      "Variant Code" = FIELD("Variant Filter"),
                                                                                      "Lot No." = FIELD("Lot No. Filter"),
                                                                                      "Serial No." = FIELD("Serial No. Filter"),
                                                                                      "Inspection Status" = CONST(Rejected)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000255; "WIP Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header"."Spec ID";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("WIP QC Enabled");
                //B2B
                if SpecificationHeader.Get("WIP Spec ID") then begin
                    SpecificationHeader.CalcFields(SpecificationHeader."Inspection Time(In Hours)");
                    Validate("Insp. Time WIP(In Min.)", SpecificationHeader."Inspection Time(In Hours)")
                end else
                    Validate("Insp. Time WIP(In Min.)", 0);
                //B2B
            end;
        }
        field(33000256; "WIP QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "WIP QC Enabled" then
                    TestField("WIP Spec ID");
            end;
        }
        field(33000257; "Quantity Accepted"; Decimal)
        {
            Description = 'QC1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33000258; "Quantity Rework"; Decimal)
        {
            CalcFormula = Sum("Quality Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                                      "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                      "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                      "Location Code" = FIELD("Location Filter"),
                                                                                      "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                                      "Variant Code" = FIELD("Variant Filter"),
                                                                                      "Lot No." = FIELD("Lot No. Filter"),
                                                                                      "Serial No." = FIELD("Serial No. Filter"),
                                                                                      "Inspection Status" = CONST("Under Inspection"),
                                                                                      Rework = CONST(true),
                                                                                      "Sent for Rework" = CONST(false)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000259; "Quantity Sent for Rework"; Decimal)
        {
            CalcFormula = Sum("Quality Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                                      "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                                      "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                                      "Location Code" = FIELD("Location Filter"),
                                                                                      "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                                      "Variant Code" = FIELD("Variant Filter"),
                                                                                      "Lot No." = FIELD("Lot No. Filter"),
                                                                                      "Serial No." = FIELD("Serial No. Filter"),
                                                                                      "Inspection Status" = CONST("Under Inspection"),
                                                                                      "Sent for Rework" = CONST(true)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(99008501; Stock_Threshold_Value; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(99008502; SMD_But_mchine_cant_do; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(99008503; "No of Panels"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Group Cust".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }

        field(99008504; "Item Segrigation Type"; Enum ItemSegrigationType)
        {
            DataClassification = CustomerContent;
        }
        field(99008505; "Hazardous Item"; Boolean)
        {
            DataClassification = CustomerContent;
        }


    }


    PROCEDURE CreateInspectionDataSheets();
    VAR
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
    BEGIN
        //InspectDataSheets.CreateInprecessInspectionIDS(Rec);
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetFilter("Receipt No.", '%1', '');
        InspectDataSheet.SetFilter("Prod. Order No.", '%1', '');
        InspectDataSheet.SetFilter("Order No.", '%1', '');
        InspectDataSheet.SetFilter("Trans. Order No.", '%1', '');
        InspectDataSheet.SetFilter("Posted Sales Order No.", '%1', '');
        InspectDataSheet.SetRange("Item No.", "No.");
        InspectDataSheet.SetRange("Source Type", InspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetFilter("Receipt No.", '%1', '');
        PostInspectDataSheet.SetFilter("Prod. Order No.", '%1', '');
        PostInspectDataSheet.SetFilter("Order No.", '%1', '');
        PostInspectDataSheet.SetFilter("Trans. Order No.", '%1', '');
        PostInspectDataSheet.SetFilter("Posted Sales Order No.", '%1', '');
        PostInspectDataSheet.SetRange("Item No.", "No.");
        PostInspectDataSheet.SetRange("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetFilter("Receipt No.", '%1', '');
        InspectionReceipt.SetFilter("Prod. Order No.", '%1', '');
        InspectionReceipt.SetFilter("Order No.", '%1', '');
        InspectionReceipt.SetFilter("Trans. Order No.", '%1', '');
        InspectionReceipt.SetFilter("Posted Sales Order No.", '%1', '');
        InspectionReceipt.SetRange("Item No.", "No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetFilter("Receipt No.", '%1', '');
        InspectionReceipt.SetFilter("Prod. Order No.", '%1', '');
        InspectionReceipt.SetFilter("Order No.", '%1', '');
        InspectionReceipt.SetFilter("Trans. Order No.", '%1', '');
        InspectionReceipt.SetFilter("Posted Sales Order No.", '%1', '');
        InspectionReceipt.SetRange("Item No.", "No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE CancelInspection(VAR QualityStatus: Text[50]);
    VAR
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        QILE: Record "Quality Item Ledger Entry";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
    BEGIN
        /*{
        IF "Quality Before Receipt" = TRUE THEN BEGIN
          IDS.SETRANGE("Order No.","Document No.");
          IDS.SETRANGE("Purch Line No","Line No.");
          IF NOT IDS.FIND('-') THEN
            ERROR('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
          ELSE BEGIN
            PIDS.TRANSFERFIELDS(IDS);
            PIDS."Quality Status" := PIDS."Quality Status" :: Cancel;
            PIDS.INSERT;
            IDS.DELETE;
            IDSL.SETRANGE("Document No.",IDS."No.");
            IF IDSL.FIND('-') THEN BEGIN
              REPEAT
                PIDSL.TRANSFERFIELDS(IDSL);
                PIDSL.INSERT;
              UNTIL IDSL.NEXT = 0;
              IDSL.DELETEALL;
            END;
            IF QualityStatus = 'Cancel' THEN BEGIN
              //"Quality Status" := "Quality Status" :: Cancel;
              "Quality Before Receipt" := FALSE;
              "Qty. Sending To Quality" := 0;
              "Qty. Sent To Quality" := 0;
              MODIFY;
            END;
          END;
        END ELSE BEGIN
          IDS.SETRANGE("Order No.","Document No.");
          IDS.SETRANGE("Purch Line No","Line No.");
          IF NOT IDS.FIND('-') THEN
            ERROR('You Can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
          ELSE BEGIN
            PIDS.TRANSFERFIELDS(IDS);
            PIDS."Quality Status" := PIDS."Quality Status" :: Cancel;
            PIDS.INSERT;
            IDS.DELETE;
            IDSL.SETRANGE("Document No.",IDS."No.");
            IF IDSL.FIND('-') THEN BEGIN
              REPEAT
                PIDSL.TRANSFERFIELDS(IDSL);
                PIDSL.INSERT;
              UNTIL IDSL.NEXT = 0;
              IDSL.DELETEALL;
            END;
            QILE.SETRANGE("Document No.",IDS."Receipt No.");
            IF QILE.FIND('-') THEN
              QILE.DELETE;
            IF QualityStatus = 'Cancel' THEN BEGIN
              //"Quality Status" := "Quality Status" :: Cancel;
              "Qty. Sending To Quality" := 0;
              "Qty. Sent To Quality" := 0;
              MODIFY;
            END;
          END;
        END;
        }*/
    END;


    PROCEDURE CloseInspection(VAR QualityStatus: Text[50]);
    VAR
        IR: Record "Inspection Receipt Header";
        IRL: Record "Inspection Receipt Line";
        QILE: Record "Quality Item Ledger Entry";
    BEGIN
        /* {
         IR.SETRANGE("Order No.","Document No.");
         IR.SETRANGE("Purch Line No","Line No.");
         IR.SETFILTER(Status,'NO');
         IF NOT IR.FIND('-')THEN
           ERROR('Inspection Receipt not find')
         ELSE BEGIN
           IR.Status := TRUE;
           IR."Quality Status" := IR."Quality Status" :: Close;
           IR.MODIFY;
         END;
         QILE.SETRANGE("Document No.",IR."Receipt No.");
         IF QILE.FIND('-') THEN
           QILE.DELETE;
         IF QualityStatus = 'Cancel' THEN BEGIN
           //"Quality Status" := "Quality Status" :: "Short Close";
           "Qty. Sending To Quality" := 0;
           "Qty. Sent To Quality" := 0;
           MODIFY;
         END;
         }*/
    END;

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        //B2B
        "User ID" := UserId;
        //B2B
    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        //B2B
        "User ID" := UserId;
        //B2B
    end;

    var
        "--B2B--": Integer;
        SpecificationHeader: Record "Specification Header";
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        ProdOrders: Record "Production Order";
        ItemSubGroup: Record "Item Sub Group";


}

