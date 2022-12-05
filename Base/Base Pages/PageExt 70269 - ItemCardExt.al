pageextension 70269 ItemCardExt extends 30
{
    Editable = true;
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;

            }
        }
        
        
      
        addafter("Item Category Code")
        {
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
            field("Avg Unit Cost"; Rec."Avg Unit Cost")
            {
                ApplicationArea = All;

            }
            field("Item Location"; Rec."Item Location")
            {
                ApplicationArea = All;

            }
            field("Item_verified"; Rec."Item_verified")
            {
                ApplicationArea = All;

            }
            field(atta; atta)
            {
                Caption = 'Attachments';
                ApplicationArea = All;
            }
            field(ItemlastTransDate; Rec.ItemlastTransDate)
            {
                ApplicationArea = All;

            }
            field("Item Final Cost"; Rec."Item Final Cost")
            {
                ApplicationArea = All;

            }
            field("<Picture2>"; Rec.Picture)
            {
                ApplicationArea = All;

            }
            field("Product Group Code Cust"; Rec."Product Group Code Cust")
            {
                ApplicationArea = All;
            }

        }
        addafter(Inventory)
        {
            field("Stock at Stores"; Rec."Stock at Stores")
            {
                DecimalPlaces = 0 : 5;
                ApplicationArea = All;
                trigger OnDrillDown()
                begin
                    Rec.CALCFIELDS("Quantity Under Inspection", "Quantity Rejected", "Quantity Rework", "Quantity Sent for Rework");
                    IF Rec."QC Enabled" = TRUE THEN BEGIN
                        IF (Rec."Quantity Under Inspection" = 0) AND (Rec."Quantity Rejected" = 0) AND (Rec."Quantity Rework" = 0) AND (Rec."Quantity Sent for Rework" = 0) THEN BEGIN
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                            "Expiration Date", "Lot No.", "Serial No.");
                            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            ItemLedgEntry.SETRANGE("Location Code", 'STR');
                            PAGE.RUNMODAL(38, ItemLedgEntry);
                        END ELSE BEGIN
                            ItemLedgEntry.RESET;
                            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                            "Expiration Date", "Lot No.", "Serial No.");

                            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            ItemLedgEntry.SETRANGE("Location Code", 'STR');
                            IF ItemLedgEntry.FINDSET THEN
                                REPEAT
                                    /* IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                                    QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                                    (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                    AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Reject")) THEN
                                           ItemLedgEntry.MARK(FALSE);
                                   UNTIL ItemLedgEntry.NEXT = 0; */

                                    ItemLedgEntry.MARK(TRUE);
                                    IF ((QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
                                    (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::"Under Inspection"))
                                     OR (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                                    AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected))) THEN
                                        ItemLedgEntry.MARK(FALSE);
                                //  "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
                                UNTIL ItemLedgEntry.NEXT = 0;
                            ItemLedgEntry.MARKEDONLY(TRUE);
                            PAGE.RUNMODAL(38, ItemLedgEntry);
                        END;
                    END;
                end;
            }
            field("Stock at CS Stores"; Rec."Stock at CS Stores")
            {
                ApplicationArea = All;

            }
            field("Stock at RD Stores"; Rec."Stock at RD Stores")
            {
                ApplicationArea = All;

            }
            field("Stock at PROD Stores"; Rec."Stock at PROD Stores")
            {
                ApplicationArea = All;

            }
            field("Stock at Mag Stores"; Rec."Stock at Mag Stores")
            {
                Caption = 'Stock at Mangalagiri Stores';
                ApplicationArea = All;
            }
            field("Stock at Mag MCH1"; Rec."Stock at Mag MCH1")
            {
                Caption = 'Stock at Mangalagir MCH1';
                ApplicationArea = All;
            }
            field("Total Stock"; "Item_Total_Stock")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Hazardous Item";Rec."Hazardous Item")
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
        }
        addafter("Qty. on Purch. Order")
        {
            field("Quantity Rejected"; Rec."Quantity Rejected")
            {
                ApplicationArea = All;

            }
        }
        addafter("Qty. on Prod. Order")
        {
            field("Quantity Accepted"; Rec."Quantity Accepted")
            {
                DrillDown = true;
                ApplicationArea = All;
                trigger OnDrillDown()
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
        }
        addafter("Qty. on Sales Order")
        {
            field("Qty. on Mat.Req"; Rec."Qty. on Mat.Req")
            {
                ApplicationArea = All;

            }
        }
        addafter(PreventNegInventoryDefaultNo)
        {
            field(Sample; Rec.Sample)
            {
                ApplicationArea = All;

            }
            field("No.of Units"; Rec."No.of Units")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    //Added by Vishnu Priya
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
                    //Added by Vishnu Priya
                end;
            }
            field("CS IGC"; Rec."CS IGC")
            {
                ApplicationArea = All;

            }
        }
        addafter("Sales Unit of Measure")
        {
            /* field("Service Item Group"; Rec."Service Item Group")
            {
                ApplicationArea = All;

            } */
        }
        addafter("Include Inventory")
        {
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
        }
        addafter("Order Multiple")
        {
            field("Safety Stock Qty (R&D)"; Rec."Safety Stock Qty (R&D)")
            {
                ApplicationArea = All;

            }
            field("Safety Stock Qty (CS)"; Rec."Safety Stock Qty (CS)")
            {
                ApplicationArea = All;

            }
            field("<Safety Stock Quantity2>"; Rec."Safety Stock Quantity")
            {
                ApplicationArea = All;

            }
        }
        addafter("Use Cross-Docking")
        {
            field("BIN Address"; Rec."BIN Address")
            {
                ApplicationArea = All;

            }
            field("Stock Address"; Rec."Stock Address")
            {
                ApplicationArea = All;

            }
            field("<Spec ID2>"; Rec."Spec ID")
            {
                Editable = true;
                ApplicationArea = All;
            }
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;

            }
        }
        addafter("Unit Price")
        {
            /* field(Quality; Quality)
             {
                 Caption = 'Quality';
                 ApplicationArea = All;
             }*/
            field("Spec ID"; Rec."Spec ID")
            {
                ApplicationArea = All;

            }
            field("Insp. Time Inbound(In Min.)"; Rec."Insp. Time Inbound(In Min.)")
            {
                ApplicationArea = All;

            }
            field("QC Enabled"; Rec."QC Enabled")
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
            group(Control1900582501)
            {
                Caption = 'Specifications';
                field("Part Number"; Rec."Part Number")
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
                field("On C-Side"; Rec."On C-Side")
                {
                    ApplicationArea = All;

                }
                field("On D-Side"; Rec."On D-Side")
                {
                    ApplicationArea = All;

                }
                field("On S-Side"; Rec."On S-Side")
                {
                    ApplicationArea = All;

                }
                field("Surface Finish"; Rec."Surface Finish")
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

                }
                field("Bake Hours"; Rec."Bake Hours")
                {
                    ApplicationArea = All;

                }
                field("Component Shelf Life(Years)"; Rec."Component Shelf Life(Years)")
                {
                    ApplicationArea = All;

                }
                field("<Type of Solder2>"; Rec."Type of Solder")
                {
                    ApplicationArea = All;

                }
                field(Package; Rec.Package)
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
                    DecimalPlaces = 1 : 5;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'EFFTRONICS\ANVKUMARI') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("Copper Clad Thickness"; Rec."Copper Clad Thickness")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'EFFTRONICS\ANVKUMARI') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("PCB Shape"; Rec."PCB Shape")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'EFFTRONICS\ANVKUMARI') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'EFFTRONICS\VIJAYA') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'EFFTRONICS\VIJAYA') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("PCB Area"; Rec."PCB Area")
                {
                    DecimalPlaces = 1 : 5;
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF (USERID <> 'SUPER') THEN
                            ERROR('You Have No Rights');
                    end;
                }
                field("Semi Mounted"; Rec."Semi Mounted")
                {
                    ApplicationArea = All;

                }
                field("Thickness of Package"; Rec."Thickness of Package")
                {
                    ApplicationArea = All;

                }
                group(Machine)
                {
                    field("No of Panels"; Rec."No of Panels")
                    {
                        Editable = mch_tag_editable;
                        ApplicationArea = All;
                    }
                    field("SMD_But_mchine_cant_do"; Rec."SMD_But_mchine_cant_do")
                    {
                        Editable = mch_tag_editable;
                        ApplicationArea = All;
                    }
                }
            }
        }

    }

    actions
    {
        addfirst(processing)
        {
            group("&Quality")
            {
                Caption = 'Quality';
                group(Inspection)
                {
                    Caption = 'Inspection';
                    Image = QualificationOverview;
                    action("Inspection Data Sheets")
                    {
                        Caption = 'Inspection Data Sheets';
                        Image = Worksheet;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Rec.ShowDataSheets;
                        end;
                    }
                    action("Posted Inspection Data Sheets")
                    {
                        Caption = 'Posted Inspection Data Sheets';
                        Image = PostedShipment;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Rec.ShowPostDataSheets;
                        end;
                    }
                    action("Inspection &Receipts")
                    {
                        Caption = 'Inspection &Receipts';
                        Image = Receipt;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Rec.ShowInspectReceipt;
                        end;
                    }
                    action("Posted I&nspection Receipts")
                    {
                        Caption = 'Posted I&nspection Receipts';
                        Image = PostedReceipt;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Rec.ShowPostInspectReceipt;
                        end;
                    }
                    action("Create Inspection Data &Sheets")
                    {
                        Caption = 'Create Inspection Data &Sheets';
                        Image = CreateDocument;
                        ApplicationArea = All;
                        trigger OnAction()
                        begin
                            Rec.TESTFIELD("Quantity Accepted");
                            Rec.CreateInspectionDataSheets;
                        end;
                    }
                }
            }

        }
        addfirst(ItemActionGroup)
        {
            action("Va&riants_Cust")
            {
                RunObject = Page "Item Variants Cust";
                RunPageLink = "Item No." = FIELD("No.");
                ApplicationArea = Planning;
                Caption = 'Va&riants';
                Image = ItemVariant;
            }

        }
        modify("Va&riants")
        {
            Visible = false;
        }
        

        addafter("&Value Entries")
        {
            action("&Quality Ledger Entries")
            {
                Caption = '&Quality Ledger Entries';
                RunObject = Page "Quality Ledger Entries";
                RunPageLink = "Item No." = FIELD("No.");
                Image = TaskQualityMeasure;
                ApplicationArea = All;
            }
        }
        addafter(BOMStructure)
        {
            action("Alternative Items")
            {
                Caption = 'Alternative Items';
                Image = ItemVariant;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    "Alternate Item".SETRANGE("Alternate Item"."Item No.", Rec."No.");
                    PAGE.RUN(60070, "Alternate Item");
                end;
            }
            action(PCB)
            {
                Caption = 'PCB';
                Visible = visible1;
                Image = Card;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    pcb1.RESET;
                    pcb1.SETRANGE(pcb1."PCB No.", Rec."No.");
                    IF pcb1.FINDFIRST THEN
                        PAGE.RUN(60240, pcb1)
                    ELSE BEGIN
                        pcb1.INIT;
                        pcb1."PCB No." := Rec."No.";
                        pcb1.Description := Rec.Description;
                        pcb1."PCB Thickness" := Rec."PCB thickness";
                        pcb1."Copper Clad Thinkness" := Rec."Copper Clad Thickness";
                        pcb1."PCB Area" := Rec."PCB Area";
                        pcb1.Length := Rec.Length;
                        pcb1.Width := Rec.Width;
                        pcb1."PCB Shape" := Rec."PCB Shape";
                        pcb1."On C-side" := Rec."On C-Side";
                        pcb1."On D-side" := Rec."On D-Side";
                        pcb1."On S-side" := Rec."On S-Side";
                        pcb1.INSERT;
                        pcb1.RESET;
                        pcb1.SETRANGE(pcb1."PCB No.", Rec."No.");
                        IF pcb1.FINDFIRST THEN
                            PAGE.RUN(60240, pcb1);
                    END;
                end;
            }
        }
        addafter("Skilled Resources")
        {
            action(Specifications)
            {
                Caption = 'Specifications';

                RunObject = Page "Item Specification";
                RunPageLink = "Item No." = FIELD("No."), "Product Group Code" = FIELD("Product Group Code Cust"), "Item Category Code" = FIELD("Item Category Code"), "Item Sub Group Code" = FIELD("Item Sub Group Code"), "Item Sub Sub Group Code" = FIELD("Item Sub Sub Group Code");
                Image = ItemVariant;
                ApplicationArea = All;
            }
            /* action(Attachments)
            {
                Caption = 'Attachments';
                RunObject = Page "ESPL Attachments";
                RunPageLink = "Table ID" = CONST(27), "Document No." = FIELD("No.");
                Image = Attachments;
                ApplicationArea = All;
            } */
            action("Design Work Sheet")
            {
                Caption = 'Design Work Sheet';
                RunObject = Page "Item Design WorkSheet Header";
                RunPageLink = "Item No." = FIELD("No.");
                Image = PlanningWorksheet;
                ApplicationArea = All;
            }
            action("Lot No/'s")
            {
                Caption = 'Lot No/ s';
                RunObject = Page "Deveation Master";
                RunPageLink = "Item No" = FIELD("No.");
                Image = Lot;
                ApplicationArea = All;
            }
        }
        addafter(ApplyTemplate)
        {
            action("Update BOM Cost")
            {
                Caption = 'Update BOM Cost';

                Image = UpdateUnitCost;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ItemCostUpdation.UpdateBOMCost;
                end;
            }
            action("Update Routing Cost")
            {
                Caption = 'Update Routing Cost';

                Image = UpdateUnitCost;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ItemCostUpdation.RoutingCostUpdation;
                end;
            }
            action(Action1000000036)
            {
                Caption = 'Attachments';
                Promoted = true;
                Image = Attachments;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    attachments.RESET;
                    attachments.SETRANGE("Table ID", DATABASE::Item);
                    attachments.SETRANGE("Document No.", Rec."No.");
                    PAGE.RUN(PAGE::"ESPL Attachments", attachments);
                end;
            }
        }
        addafter("Item Tracing")
        {
            action("Update CS IGC")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    Window: Dotnet WindowVB;
                    CSIGC_Code: Code[20];
                begin
                    // >>Added by Pranavi on 25-Apr-2017 for CS IGC Code updatation
                    CLEAR(CSIGC_Code);

                    /*  Window.OPEN('Please enter CS IGC code: ##############1##',CSIGC_Code);
                     Window.INPUT(1,CSIGC_Code);
                     MESSAGE(CSIGC_Code);
                     Window.CLOSE; */

                    IF USERID IN ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\PRANAVI'] THEN BEGIN
                        CSIGC_Code := Window.InputBox('Enter CS IGC Code:', 'INPUT', Rec."CS IGC", 100, 100);
                        IF (CSIGC_Code <> '') THEN BEGIN
                            IF (Rec."CS IGC" <> '') THEN BEGIN
                                IF (Rec."CS IGC" <> CSIGC_Code) THEN
                                    IF CONFIRM('Are You Sure to update the CS IGC code from ' + Rec."CS IGC" + ' to ' + CSIGC_Code + ' ?', FALSE) THEN BEGIN
                                        Rec."CS IGC" := CSIGC_Code;
                                        Rec.MODIFY;
                                    END;
                            END ELSE BEGIN
                                Rec."CS IGC" := CSIGC_Code;
                                Rec.MODIFY;
                            END;
                        END;
                    END ELSE
                        ERROR('You Do not have right to update CS IGC!');
                    // <<Added by Pranavi on 25-Apr-2017 for CS IGC Code updatation
                end;

            }
            action("Update BIN & Stock Address")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    //EFFUPG>>
                    /*
                    Prompt: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Form" RUNONCLIENT;
                    FormBorderStyle: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormBorderStyle" RUNONCLIENT;
                    FormStartPosition: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.FormStartPosition" RUNONCLIENT;
                    lblIBINAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Label" RUNONCLIENT;
                    lblStockAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Label" RUNONCLIENT;
                    txtBINAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.TextBox" RUNONCLIENT;
                    txtStockAddress: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.TextBox" RUNONCLIENT;
                    confirmation: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.Button" RUNONCLIENT;
                    DialogResult: DotNet "'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.Windows.Forms.DialogResult" RUNONCLIENT;
                    */


                    Prompt: DotNet PromptD;
                    FormBorderStyle: DotNet FormBorderStyleD;
                    FormStartPosition: DotNet FormStartPositionD;
                    lblIBINAddress: DotNet lblIBINAddressD;
                    lblStockAddress: DotNet lblStockAddressD;
                    txtBINAddress: DotNet txtBINAddressD;
                    txtStockAddress: DotNet txtStockAddressD;
                    confirmation: DotNet confirmationD;
                    DialogResult: DotNet DialogResultD;


                    //EFFUPG>>
                    BINAddress: Code[20];
                    StockAddress: Code[20];
                begin
                    //Creating the form
                    IF NOT (USERID IN ['EFFTRONICS\TULASI', 'EFFTRONICS\SUJANI', 'EFFTRONICS\MARI', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\PADMAJA']) THEN
                        ERROR('You Do not have rights to update BIN & Stock Address!');
                    Prompt := Prompt.Form();
                    Prompt.Width := 500;
                    Prompt.Height := 230;
                    Prompt.FormBorderStyle := FormBorderStyle.FixedDialog;

                    Prompt.Text := 'Enter BIN & Stock Address Details';
                    Prompt.StartPosition := FormStartPosition.CenterScreen;

                    //Creating the form
                    //Adding Labels

                    lblIBINAddress := lblIBINAddress.Label();
                    lblIBINAddress.Text('BIN Address :');
                    lblIBINAddress.Left(50);
                    lblIBINAddress.Top(20);
                    Prompt.Controls.Add(lblIBINAddress);

                    lblStockAddress := lblStockAddress.Label();
                    lblStockAddress.Text('Stock Address :');
                    lblStockAddress.Left(50);
                    lblStockAddress.Top(50);
                    Prompt.Controls.Add(lblStockAddress);

                    //Adding Labels
                    //adding text boxes, you can use other components like the dropdown list or a calendar, //or radio buttons

                    txtBINAddress := txtBINAddress.TextBox();
                    txtBINAddress.Left(180);
                    txtBINAddress.Top(20);
                    txtBINAddress.Width(150);
                    Prompt.Controls.Add(txtBINAddress);

                    txtStockAddress := txtStockAddress.TextBox();
                    txtStockAddress.Left(180);
                    txtStockAddress.Top(50);
                    txtStockAddress.Width(150);
                    Prompt.Controls.Add(txtStockAddress);

                    //adding text boxes
                    //adding submit button

                    confirmation := confirmation.Button();
                    confirmation.Text('OK');
                    confirmation.Left(180);
                    confirmation.Top(120);
                    confirmation.Width(150);
                    confirmation.DialogResult := DialogResult.OK;
                    Prompt.Controls.Add(confirmation);
                    Prompt.AcceptButton := confirmation;

                    //adding submit button

                    // Getting the Result
                    BINAddress := Rec."BIN Address";
                    StockAddress := Rec."Stock Address";
                    txtBINAddress.Text := Rec."BIN Address";
                    txtStockAddress.Text := Rec."Stock Address";
                    IF (Prompt.ShowDialog().ToString() = DialogResult.OK.ToString()) THEN BEGIN
                        IF (txtBINAddress.Text <> BINAddress) AND (BINAddress <> '') THEN BEGIN
                            IF CONFIRM('Are You Sure to update the BIN Address from ' + Rec."BIN Address" + ' to ' + txtBINAddress.Text + ' ?', FALSE) THEN BEGIN
                                Rec."BIN Address" := txtBINAddress.Text;
                                Rec.MODIFY;
                            END;
                        END ELSE
                            IF (txtBINAddress.Text <> BINAddress) AND (BINAddress = '') THEN BEGIN
                                Rec."BIN Address" := txtBINAddress.Text;
                                Rec.MODIFY;
                            END;
                        IF (txtStockAddress.Text <> StockAddress) AND (StockAddress <> '') THEN BEGIN
                            IF CONFIRM('Are You Sure to update the Stock Address from ' + Rec."Stock Address" + ' to ' + txtStockAddress.Text + ' ?', FALSE) THEN BEGIN
                                Rec."Stock Address" := txtStockAddress.Text;
                                Rec.MODIFY;
                            END;
                        END ELSE
                            IF (txtStockAddress.Text <> StockAddress) AND (StockAddress = '') THEN BEGIN
                                Rec."Stock Address" := txtStockAddress.Text;
                                Rec.MODIFY;
                            END;
                    END;

                    Prompt.Dispose();

                    // Getting the Result
                end;
            }
            action("Verify Item")
            {
                ApplicationArea = All;
                trigger OnAction()
                Var
                    TableCU: Codeunit "Custom Events";
                begin
                    // Added by sujani on 07-06-2018 for the item verification
                    //directly add permission ITEM_VERIFICATION for the rights
                    IF NOT (TableCU.Permission_Checking(USERID, 'ITEM_VERIFICATION'))
                     THEN
                        ERROR('You Don"t have Permissions')
                    ELSE BEGIN
                        IF Rec.Item_verified = TRUE THEN BEGIN
                            Itm_verification_confirm := DIALOG.CONFIRM('Item already Verified,would you like to Uncheck', TRUE, Rec.Description);
                            IF Itm_verification_confirm = TRUE THEN BEGIN
                                Rec.Item_verified := FALSE;
                                Rec.MODIFY;
                                CurrPage.UPDATE;
                            END;
                        END
                        ELSE BEGIN
                            Itm_verification_confirm := DIALOG.CONFIRM('Would you like to check the Item_Verified', TRUE, Rec.Description);
                            IF Itm_verification_confirm = TRUE THEN BEGIN
                                Rec.Item_verified := TRUE;
                                Rec.MODIFY;
                                CurrPage.UPDATE;
                            END;
                        END;
                    END;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.CALCFIELDS("Inventory at Stores");
        Rec.CALCFIELDS("Quantity Under Inspection");
        Rec.CALCFIELDS("Quantity Rejected");
        "Inventory at STR" := Rec."Inventory at Stores" - (Rec."Quantity Under Inspection" + Rec."Quantity Rejected");

        /* atta := FALSE;
        attachments.RESET;
        attachments.SETRANGE("Table ID", DATABASE::Item);
        attachments.SETRANGE("Document No.", "No.");
        IF attachments.COUNT > 0 THEN
        atta := TRUE; */

        Rec."Stock at Stores" := Rec."Inventory at Stores" - (Rec."Quantity Under Inspection" + Rec."Quantity Rejected");
        IF Rec."Stock at Stores" < 0 THEN
            Rec."Stock at Stores" := 0;

        // MODIFY;

        IF (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\ANVKUMARI']) THEN
            mch_tag_editable := TRUE
        ELSE
            mch_tag_editable := FALSE;
        "VAT Prod. Posting Group" := 'NO VAT';
    end;

    trigger OnAfterGetRecord()
    begin
        visible1 := FALSE;
        item.RESET;
        item.SETRANGE(item."No.", Rec."No.");
        IF item.FINDFIRST THEN BEGIN
            IF item."Product Group Code Cust" IN ['PCB', 'MPCB', 'CPCB'] THEN BEGIN
                visible1 := TRUE;
            END;
        END;    //swathi

        Rec."Stock at Stores" := 0;
        //ItemCostMgt.CalculateAverageCost(Rec,AverageCostLCY,AverageCostACY);

        //B2B
        IF (Rec."QC Enabled" = TRUE) AND (Rec.Inventory >= 0) THEN
            Rec."Quantity Accepted" := Rec.Inventory - (Rec."Quantity Rejected" + Rec."Quantity Under Inspection" + Rec."Quantity Rework" +
              Rec."Quantity Sent for Rework");

        /* PurchaseInvLine.RESET;
PurchaseInvLine.SETCURRENTKEY(Type, "No.", "Variant Code");
PurchaseInvLine.SETRANGE(Type, PurchaseInvLine.Type::Item);
PurchaseInvLine.SETRANGE("No.", "No.");
IF PurchaseInvLine.FINDSET THEN
REPEAT
 TotQty += PurchaseInvLine.Quantity;
 TotVendorAmt += PurchaseInvLine."Amount To Vendor";
UNTIL PurchaseInvLine.NEXT = 0;
IF TotVendorAmt <> 0 THEN
"Avg Unit Cost" := TotVendorAmt / TotQty; */
        //B2B


        //B2B
        Rec."Stock at Stores" := 0;
        Rec.CALCFIELDS("Inventory at Stores");
        Rec.CALCFIELDS("Quantity Rejected");
        Rec.CALCFIELDS("Quantity Under Inspection");
        //"Inventory at STR" := "Inventory at Stores" - ("Quantity Under Inspection"+"Quantity Rejected");
        //"Stock at Stores":= "Inventory at Stores"- ("Quantity Under Inspection"+"Quantity Rejected");
        IF Rec."Stock at Stores" < 0 THEN
            Rec."Stock at Stores" := 0;//a190808

        //anil

        Rec.CALCFIELDS("Quantity Under Inspection", "Quantity Rejected", "Quantity Rework", "Quantity Sent for Rework", "Stock At MCH Location", "Stock at CS Stores", "Stock at RD Stores", "Stock at PROD Stores");
        //IF "QC Enabled" = TRUE THEN BEGIN
        IF (Rec."Quantity Under Inspection" = 0) AND (Rec."Quantity Rejected" = 0) AND (Rec."Quantity Rework" = 0) AND (Rec."Quantity Sent for Rework" = 0) THEN BEGIN

            //  "Stock at Stores":=0 ;
            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
            "Expiration Date", "Lot No.", "Serial No.");
            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
            ItemLedgEntry.SETRANGE(Open, TRUE);
            ItemLedgEntry.SETRANGE("Location Code", 'STR');
            ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '<>%1', 0);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    ItemLedgEntry.MARK(TRUE);
                UNTIL ItemLedgEntry.NEXT = 0;
            // Page.RUNMODAL(38,ItemLedgEntry);
        END ELSE BEGIN


            ItemLedgEntry.RESET;
            ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
            "Expiration Date", "Lot No.", "Serial No.");

            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
            ItemLedgEntry.SETRANGE(Open, TRUE);
            ItemLedgEntry.SETRANGE("Location Code", 'STR');
            ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
            IF ItemLedgEntry.FINDSET THEN
                REPEAT
                    ItemLedgEntry.MARK(TRUE);
                    IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status" =
                    QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
                    (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
                    AND (QualityItemLedgEntry."Inspection Status" = QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
                        ItemLedgEntry.MARK(FALSE);
                //  "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
                UNTIL ItemLedgEntry.NEXT = 0;
            //Page.RUNMODAL(38,ItemLedgEntry);
        END;
        //END;


        ItemLedgEntry.MARKEDONLY(TRUE);
        IF ItemLedgEntry.FINDSET THEN
            REPEAT

                Rec."Stock at Stores" := Rec."Stock at Stores" + ItemLedgEntry."Remaining Quantity";
            UNTIL ItemLedgEntry.NEXT = 0;

        Item_Total_Stock := Rec."Stock At MCH Location" + Rec."Stock at CS Stores" + Rec."Stock at RD Stores" + Rec."Stock at PROD Stores" + Rec."Stock at Stores";
        //anil260808


        /* CALCFIELDS("Quantity Under Inspection","Quantity Rejected","Quantity Rework","Quantity Sent for Rework");
        IF "QC Enabled" = TRUE THEN BEGIN
         IF ("Quantity Under Inspection"=0)AND ("Quantity Rejected"=0) AND ("Quantity Rework"=0) AND ("Quantity Sent for Rework"=0) THEN
          BEGIN
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");
          ItemLedgEntry.SETRANGE("Item No.","No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'STR');
          IF ItemLedgEntry.FINDSET THEN
          REPEAT
            "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
          UNTIL ItemLedgEntry.NEXT=0;
         // Page.RUNMODAL(38,ItemLedgEntry);
         END ELSE BEGIN
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");

          ItemLedgEntry.SETRANGE("Item No.","No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'STR');
          IF ItemLedgEntry.FINDSET THEN
          REPEAT
           //IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status"=
           //QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
           //(QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
           //AND (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::"Reject")) THEN
            //ItemLedgEntry.MARK(FALSE);
          //UNTIL ItemLedgEntry.NEXT=0; 

           ItemLedgEntry.MARK(TRUE);
           IF( (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND
           (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::"Under Inspection"))
            OR (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
           AND (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::Rejected))) THEN
            ItemLedgEntry.MARK(FALSE);
            "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
          UNTIL ItemLedgEntry.NEXT=0;
          ItemLedgEntry.MARKEDONLY(TRUE);
        //  Page.RUNMODAL(38,ItemLedgEntry);
          END;
        END; */


        //******** Santhosh

        /* CALCFIELDS("Quantity Under Inspection","Quantity Rejected","Quantity Rework","Quantity Sent for Rework");
        IF "QC Enabled" = TRUE THEN BEGIN
         IF ("Quantity Under Inspection"=0)AND ("Quantity Rejected"=0) AND ("Quantity Rework"=0) AND ("Quantity Sent for Rework"=0) THEN
          BEGIN
          // "Stock at Stores":=0 ;
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");
          ItemLedgEntry.SETRANGE("Item No.","No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'MCH');
         // Page.RUNMODAL(38,ItemLedgEntry);
         END ELSE BEGIN
          "Stock at Stores":=0 ;
          ItemLedgEntry.RESET;
          ItemLedgEntry.SETCURRENTKEY("Item No.","Variant Code",Open,Positive,"Location Code","Posting Date",
          "Expiration Date","Lot No.","Serial No.");

          ItemLedgEntry.SETRANGE("Item No.","No.");
          ItemLedgEntry.SETRANGE(Open,TRUE);
          ItemLedgEntry.SETRANGE("Location Code",'MCH');
          IF ItemLedgEntry.FINDSET THEN
          REPEAT
           ItemLedgEntry.MARK(TRUE);
           IF (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") AND (QualityItemLedgEntry."Inspection Status"=
           QualityItemLedgEntry."Inspection Status"::"Under Inspection")) OR
           (QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.")
           AND (QualityItemLedgEntry."Inspection Status"=QualityItemLedgEntry."Inspection Status"::Rejected)) THEN
            ItemLedgEntry.MARK(FALSE);
          //  "Stock at Stores":="Stock at Stores"+ItemLedgEntry."Remaining Quantity";
          UNTIL ItemLedgEntry.NEXT=0;
          //Page.RUNMODAL(38,ItemLedgEntry);
          END;
        END;
          ItemLedgEntry.MARKEDONLY(TRUE);
          IF ItemLedgEntry.FINDSET THEN
          REPEAT
            StockAtMCH:=StockAtMCH+ItemLedgEntry."Remaining Quantity";
             UNTIL ItemLedgEntry.NEXT=0; */
        //***********santhosh


        /* atta:=FALSE;
        attachments.RESET;
        attachments.SETRANGE("Table ID",DATABASE::Item);
        attachments.SETRANGE("Document No.","No.");
        IF attachments.COUNT>0 THEN
        atta:=TRUE; */


        //MNRAJU change on 14-May-2014 for Item Verified date

        /* chglog.RESET;
        chglog.SETCURRENTKEY(chglog."Entry No.");
        chglog.SETFILTER(chglog."Table No.",'27');
        chglog.SETFILTER(chglog."Primary Key Field 1 Value","No.");
        chglog.SETFILTER(chglog."Field No.",'60203');
        //chglog.SETFILTER(chglog."New Value",'Yes');
        IF chglog.FINDLAST THEN
        BEGIN
          Ver_Date:=chglog."Date and Time";
        END; */

        //MNRAJU change on 14-May-2014 for Item Verified date
    end;

    var
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
        pcb1: Record PCB;
        visible1: Boolean;
        item: Record Item;
        Item_Total_Stock: Decimal;
        Ver_Date: DateTime;
        chglog: Record "Change Log Entry";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Itm_verification_confirm: Boolean;
        mch_tag_editable: Boolean;
        ProdOrders: Record "Production Order";
}