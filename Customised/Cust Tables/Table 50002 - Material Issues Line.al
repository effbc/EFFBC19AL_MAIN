table 50002 "Material Issues Line"
{
    // version MI1.0,DIM1.0

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13             -> Added New Field 480 ("Dimension Set ID") it Will assign the Dimension Set ID
    //                                                                 specific Combination of "Shorcut Dimension Code 1","Shorcut Dimension Code 2"
    //                                                                 These combinations are stored in the new Dimension Set Entry
    //                                                              -> Code has been Commented in the ShowDimensions() because Document Dimension Table does not exist in the
    //                                                                 NAV 2013 Instead of that code new Code is added for shows the data from the database against the Dimension Set ID.
    //                                                              -> Code has been Commented in the ValidateShortcutDimCode() and Added new code for the Each combination
    //                                                                 of Dimensions to get a Dimension Set ID.
    //                                                              -> Code has been Commented in Delete()Trigger because of Function does not exist in NAV 2013

    PasteIsValid = true;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item WHERE(Blocked = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TempMaterialIssueLine: Record "Material Issues Line" temporary;
            begin
                TestField("Quantity Received", 0);
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;

                TempMaterialIssueLine := Rec;
                Init;
                "Item No." := TempMaterialIssueLine."Item No.";
                if "Item No." = '' then
                    exit;

                GetMaterialIssueHeader;
                GetItem;

                //Item.TESTFIELD(Blocked,FALSE);  // COMMENTED BY PRANAVI

                if MIH.Get("Document No.") then begin
                    if not (((MIH."Transfer-from Code" = 'SITE') and (MIH."Transfer-to Code" = 'CS')) or ((MIH."Transfer-from Code" = 'CS') and (MIH."Transfer-to Code" = 'SITE'))) then
                        Item.TestField(Blocked, false);
                    if not (((MIH."Transfer-from Code" = 'SITE') or (MIH."Transfer-from Code" = 'CS') or
                             (MIH."Transfer-from Code" = 'OLD STOCK') or (MIH."Transfer-from Code" = 'DUMMY')
                              or (MIH."Transfer-from Code" = 'PROD') or (MIH."Transfer-from Code" = 'R&D STR')) and

                       ((MIH."Transfer-to Code" = 'SITE') or (MIH."Transfer-to Code" = 'CS') or
                         (MIH."Transfer-to Code" = 'OLD STOCK') or (MIH."Transfer-to Code" = 'DUMMY')
                          or (MIH."Transfer-from Code" = 'PROD') or (MIH."Transfer-from Code" = 'RD1'))) then begin
                        /*  IF (Item."Product Group Code"='FPRODUCT') OR (Item."Product Group Code"='CPCB') THEN
                            ERROR('Item must not be FPRODUCT (or) CPCB'); */
                    end;
                end;
                Validate(Description, Item.Description);
                Validate("Gross Weight", Item."Gross Weight");
                Validate("Net Weight", Item."Net Weight");
                Validate("Unit Volume", Item."Unit Volume");
                Validate("Units per Parcel", Item."Units per Parcel");
                Validate("Unit of Measure Code", Item."Base Unit of Measure");
                Validate("Description 2", Item."Description 2");
                Validate(Quantity, xRec.Quantity);
                //"Unit Cost":=Item."Item Final Cost";
                "Unit Cost" := Item."Last Direct Cost";
                if "Transfer-from Code" in ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR'] then
                    Inventory := Item_Stock("Item No.", "Transfer-from Code");

                "Item Category Code" := Item."Item Category Code";
                "Product Group Code" := Item."Product Group Code Cust";


                CreateDim(DATABASE::Item, "Item No.");
                if "Item No." <> '' then begin
                    TrackingSpecifications.Reset;
                    TrackingSpecifications.SetRange("Order No.", "Document No.");
                    TrackingSpecifications.SetRange("Order Line No.", "Line No.");
                    if TrackingSpecifications.FindSet then
                        repeat
                            if TempMaterialIssueLine."Item No." <> "Item No." then
                                TempMaterialIssueLine.Delete;
                        until TrackingSpecifications.Next = 0;
                end;

            end;
        }
        field(4; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TransferHeader: Record "Transfer Header";
                Location: Record Location;
            begin
                //B2B
                ProdOrderComp.SetRange("Prod. Order No.", "Prod. Order No.");
                ProdOrderComp.SetRange("Prod. Order Line No.", "Prod. Order Line No.");
                ProdOrderComp.SetRange("Item No.", "Item No.");
                if ProdOrderComp.FindFirst then
                    if Quantity > ProdOrderComp."Remaining Quantity" then
                        if (not ("Allow Excess Qty.")) and (Copy) then
                            TestField(Quantity, ProdOrderComp."Remaining Quantity");
                //B2B

                //"BOM Quantity":=Quantity;
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
                if Quantity <> 0 then
                    TestField("Item No.");
                "Quantity (Base)" := CalcBaseQty(Quantity);
                if ((Quantity * "Quantity Received") < 0) or
                   ((Abs(Quantity) < Abs("Quantity Received")))
                then
                    FieldError(Quantity, StrSubstNo(Text002, FieldCaption("Quantity Received")));
                if (("Quantity (Base)" * "Qty. Received (Base)") < 0) or
                   ((Abs("Quantity (Base)") < Abs("Qty. Received (Base)")))
                then
                    FieldError("Quantity (Base)", StrSubstNo(Text002, FieldCaption("Qty. Received (Base)")));
                InitOutstandingQty;
                InitQtyToReceive;
                CheckItemAvailable(FieldNo(Quantity));
            end;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
            end;
        }
        field(7; "Qty. to Receive"; Decimal)
        {
            Caption = 'Qty. to Receive';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                if ("Qty. to Receive" > "Outstanding Quantity") then
                    if Quantity > 0 then
                        Error(
                          Text008,
                          Quantity)
                    else
                        Error(Text009);
                "Qty. to Receive (Base)" := CalcBaseQty("Qty. to Receive");
            end;
        }
        field(9; "Quantity Received"; Decimal)
        {
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Qty. Received (Base)" := CalcBaseQty("Quantity Received");
                InitOutstandingQty;
                InitQtyToReceive;
            end;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(16; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
                TestField("Qty. per Unit of Measure", 1);
                Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(17; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(20; "Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Qty. to Receive", "Qty. to Receive (Base)");
            end;
        }
        field(21; "Qty. Received (Base)"; Decimal)
        {
            Caption = 'Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(23; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                UnitOfMeasure: Record "Unit of Measure";
                UOMMgt: Codeunit "Unit of Measure Management";
            begin
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
                TestField("Quantity Received", 0);
                TestField("Qty. Received (Base)", 0);
                if "Unit of Measure Code" = '' then
                    "Unit of Measure" := ''
                else begin
                    if not UnitOfMeasure.Get("Unit of Measure Code") then
                        UnitOfMeasure.Init;
                    "Unit of Measure" := UnitOfMeasure.Description;
                end;
                GetItem;
                Validate("Qty. per Unit of Measure", UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
                "Gross Weight" := Item."Gross Weight" * "Qty. per Unit of Measure";
                "Unit Cost" := Item."Unit Cost";
                "Avg. unit cost" := Item."Avg Unit Cost";
                "Net Weight" := Item."Net Weight" * "Qty. per Unit of Measure";
                "Unit Volume" := Item."Unit Volume" * "Qty. per Unit of Measure";
                //"Stock at Stores":=Item."Stock at Stores";
                "Units per Parcel" := Round(Item."Units per Parcel" / "Qty. per Unit of Measure", 0.00001);
                Validate(Quantity);
            end;
        }
        field(24; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(25; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(26; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(27; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(30; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ItemVariant: Record "Item Variant";
            begin
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;

                if "Variant Code" = '' then
                    exit;

                ItemVariant.Get("Item No.", "Variant Code");
                Description := ItemVariant.Description;
                "Description 2" := ItemVariant."Description 2";

                CheckItemAvailable(FieldNo("Variant Code"));
            end;
        }
        field(31; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(32; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(36; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            TableRelation = Location;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Quantity Received", 0);
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;

                CheckItemAvailable(FieldNo("Transfer-from Code"));
            end;
        }
        field(37; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            TableRelation = Location;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Quantity Received", 0);
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
            end;
        }
        field(39; "Receipt Date"; Date)
        {
            Caption = 'Receipt Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (CurrFieldNo <> 0) then
                    TestStatusOpen;
                CheckItemAvailable(FieldNo("Receipt Date"));
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Description = 'DIM1.0';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //DIM 1.0
                ShowDimensions;
                //DIM 1.0
            end;
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5705; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5753; "Completely Received"; Boolean)
        {
            Caption = 'Completely Received';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "Allow Excess Qty."; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; Copy; Boolean)
        {
            Description = 'B2B-Internal field used for Allow excess Qty. field Validations';
            DataClassification = CustomerContent;
        }
        field(50003; "Avg. unit cost"; Decimal)
        {
            Caption = 'Unit Cost.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No.";
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."));
            DataClassification = CustomerContent;
        }
        field(60007; "Production BOM No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;

            trigger OnValidate();
            begin
                /*
                ProductionOrderLine.SETRANGE("Prod. Order No.","Prod. Order No.");
                ProductionOrderLine.SETRANGE("Line No.","Prod. Order Line No.");
                IF ProductionOrderLine.findfirst THEN BEGIN
                  MESSAGE('%1',ProductionOrderLine.COUNT);
                  ProductionBOMHeader.SETRANGE("No.",ProductionOrderLine."Production BOM No.");
                  IF ProductionBOMHeader.findfirst THEN BEGIN
                    PAGE.RUN(99000787,ProductionBOMHeader);
                  END;
                END;
                */

            end;
        }
        field(60010; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
            DataClassification = CustomerContent;
        }
        field(60011; Inventory; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", "Transfer-from Code");
                if "Transfer-from Code" = 'CS' then
                    ItemLedgEntry.SetFilter(ItemLedgEntry."Global Dimension 2 Code", 'H-OFF');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(60012; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60013; "Sales Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(60014; Station; Code[10])
        {
            TableRelation = Station;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                // Added by Vijaya on 14-Feb-17
                MaterialIssueHeader.Reset;
                MaterialIssueHeader.Get("Document No.");
                //end by vijaya
                StationGRec.Reset;
                StationGRec.SetFilter(StationGRec."Division code", MaterialIssueHeader."Shortcut Dimension 2 Code");
                if PAGE.RunModal(60206, StationGRec) = ACTION::LookupOK then
                    Station := StationGRec."Station Code";
                Validate(Station);
            end;

            trigger OnValidate();
            begin
                // Added by Vijaya on 14-Feb-17
                MaterialIssueHeader.Reset;
                MaterialIssueHeader.Get("Document No.");
                //end by vijaya

                //  TestStatusOpen; commented by vijaya
                stat.Reset;
                stat.SetFilter(stat."Division code", MaterialIssueHeader."Shortcut Dimension 2 Code");
                stat.SetRange(stat."Station Code", Station);
                if stat.FindFirst then
                    "Station Name" := stat."Station Name";
            end;
        }
        field(60015; "Station Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60016; Rejected; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60017; "Target Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Make Indent"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Indent No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60020; "BOM Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60021; "Non-Returnable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60022; "Monitor Problem"; Option)
        {
            OptionMembers = ,"Port Enabling","Database Modification","Version Modification",Replacement,Spare;
            DataClassification = CustomerContent;
        }
        field(60023; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60024; "Material Requisition Date"; Date)
        {
            Description = 'pranavi';
            DataClassification = CustomerContent;
        }
        field(60025; "Operation No."; Code[10])
        {
            Description = 'pranavi';
            DataClassification = CustomerContent;
        }
        field(60026; Dept; Code[10])
        {
            Description = 'pranavi';
            DataClassification = CustomerContent;
        }
        field(60027; "MBB Packet Open DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60028; "MBB Packet Close DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.")
        {
            SumIndexFields = Quantity, "Qty. to Receive";
        }
        key(Key3; "Item No.", "Prod. Order No.", "Prod. Order Line No.")
        {
        }
        key(Key4; "Quantity (Base)")
        {
        }
        key(Key5; "Prod. Order No.", "Prod. Order Line No.", "Material Requisition Date", Dept)
        {
        }
        key(Key6; "Transfer-from Code", "Transfer-to Code", "Material Requisition Date", "Production BOM No.", Dept, "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatusOpen;
        /*
        TESTFIELD("Quantity Received");
        TESTFIELD("Qty. Received (Base)");
        */
        //B2b1.0>> Since Function doesn't exist in Nav 2013
        //DimMgt.DeleteDocDim(DATABASE::"Material Issues Line",DocDim."Document Type"::" ","Document No.","Line No.");
        //B2b1.0<<
        TrackingSpecifications.Reset;
        TrackingSpecifications.SetRange("Order No.", "Document No.");
        TrackingSpecifications.SetRange("Order Line No.", "Line No.");
        if TrackingSpecifications.FindSet then
            repeat
                TrackingSpecifications.Delete;
            until TrackingSpecifications.Next = 0;

    end;

    trigger OnInsert();
    var
        MaterialIssueLine2: Record "Material Issues Line";
    begin
        TestStatusOpen;
        MaterialIssueLine2.Reset;
        MaterialIssueLine2.SetFilter("Document No.", MaterialIssueHeader."No.");
        if MaterialIssueLine2.FindLast then
            "Line No." := MaterialIssueLine2."Line No." + 10000;
        //B2b1.0>> Since Function doesn't exist in Nav 2013
        /*DimMgt.InsertDocDim(
          DATABASE::"Material Issues Line",DocDim."Document Type"::" ","Document No.","Line No.",
          "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");*/
        //B2b1.0<<

    end;

    var
        MaterialIssueHeader: Record "Material Issues Header";
        Item: Record Item;
        DimMgt: Codeunit DimensionManagement;
        Text010: Label 'Change %1 from %2 to %3?';
        Text002: Label 'must not be less than %1';
        Text008: Label 'You cannot receive more than %1 units.';
        Text009: Label 'Quantity is Not defiened.';
        ReserveMaterialIssueLine: Codeunit "Material Issue Line-Reserve";
        MISITCform: Page "Mat.Issues Track.Specification";
        TrackingSpecifications: Record "Mat.Issue Track. Specification";
        "Qty.": Decimal;
        ProdOrderComp: Record "Prod. Order Component";
        stat: Record Station;
        MIH: Record "Material Issues Header";
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
        StationGRec: Record Station;


    local procedure TestStatusOpen();
    begin
        TestField("Document No.");
        if (MaterialIssueHeader."No." <> "Document No.") then
            MaterialIssueHeader.Get("Document No.");
        MaterialIssueHeader.TestField(Status, MaterialIssueHeader.Status::Open);  // anil
    end;


    local procedure GetMaterialIssueHeader();
    begin
        TestField("Document No.");
        if ("Document No." <> MaterialIssueHeader."No.") then
            MaterialIssueHeader.Get("Document No.");
        MaterialIssueHeader.TestField("Receipt Date");
        MaterialIssueHeader.TestField("Transfer-from Code");
        MaterialIssueHeader.TestField("Transfer-to Code");
        "Transfer-from Code" := MaterialIssueHeader."Transfer-from Code";
        "Transfer-to Code" := MaterialIssueHeader."Transfer-to Code";
        "Receipt Date" := MaterialIssueHeader."Receipt Date";
        "Sales Order No." := MaterialIssueHeader."Sales Order No.";
        Status := MaterialIssueHeader.Status;
        "Dimension Set ID" := MaterialIssueHeader."Dimension Set ID" //Hack
    end;


    local procedure GetItem();
    begin
        TestField("Item No.");
        if "Item No." <> Item."No." then
            Item.Get("Item No.");
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.Get;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        //B2b1.0>> Since Fucntion doesn't exist in Nav 2013
        /*DimMgt.GetPreviousDocDefaultDim(
          DATABASE::"Material Issues Header",DocDim."Document Type"::" ","Document No.",0,
          DATABASE::Item,"Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");*/
        //B2b1.0<<

        //B2b1.0>>
        MaterialIssueHeader.Get("Document No.");
        DimMgt.GetDefaultDimID(
          TableID, No, SourceCodeSetup.Transfer,
          "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", MaterialIssueHeader."Dimension Set ID", 0);//hack
                                                                                                               //B2b1.0<<

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");


        /*
        //B2b1.0>>
        IF "Line No." <> 0 THEN
          DimMgt.UpdateDefaultDim(
            DATABASE::"Material Issues Line","Document No.",
            "Shortcut Dimension 1 Code","Shortcut Dimension 2 Code");
        //B2b1.0<<
        */ //hack

    end;


    local procedure CheckItemAvailable(CalledByFieldNo: Integer);
    var
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin
        /*
        IF (CurrFieldNo <> 0) AND
           (CurrFieldNo = CalledByFieldNo) AND
           ("Item No." <> '')  AND
           ("Outstanding Quantity" > 0)
        THEN
          ItemCheckAvail.MaterialIssueLineCheck(Rec);
        */

    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location);
    var
        ItemAvailByDate: Page 157;
        ItemAvailByVar: Page 5414;
        ItemAvailByLoc: Page 492;
    begin
        TestField("Item No.");
        Item.Reset;
        Item.Get("Item No.");
        Item.SetRange("No.", "Item No.");
        Item.SetRange("Date Filter", 0D, "Receipt Date");

        case AvailabilityType of
            AvailabilityType::Date:
                begin
                    Item.SetRange("Variant Filter", "Variant Code");
                    Item.SetRange("Location Filter", "Transfer-from Code");
                    Clear(ItemAvailByDate);
                    ItemAvailByDate.LookupMode(false);
                    ItemAvailByDate.SetRecord(Item);
                    ItemAvailByDate.SetTableView(Item);
                    if ItemAvailByDate.RunModal = ACTION::LookupOK then
                        if "Receipt Date" <> ItemAvailByDate.GetLastDate then
                            if Confirm(
                                 Text010, true, FieldCaption("Receipt Date"), "Receipt Date",
                                 ItemAvailByDate.GetLastDate)
                            then
                                Validate("Receipt Date", ItemAvailByDate.GetLastDate);
                end;
            AvailabilityType::Variant:
                begin
                    Item.SetRange("Location Filter", "Transfer-from Code");
                    Clear(ItemAvailByVar);
                    ItemAvailByVar.LookupMode(false);
                    ItemAvailByVar.SetRecord(Item);
                    ItemAvailByVar.SetTableView(Item);
                    if ItemAvailByVar.RunModal = ACTION::LookupOK then
                        if "Variant Code" <> ItemAvailByVar.GetLastVariant then
                            if Confirm(
                                 Text010, true, FieldCaption("Variant Code"), "Variant Code",
                                 ItemAvailByVar.GetLastVariant)
                            then
                                Validate("Variant Code", ItemAvailByVar.GetLastVariant);
                end;
            AvailabilityType::Location:
                begin
                    Item.SetRange("Variant Filter", "Variant Code");
                    Clear(ItemAvailByLoc);
                    ItemAvailByLoc.LookupMode(false);
                    ItemAvailByLoc.SetRecord(Item);
                    ItemAvailByLoc.SetTableView(Item);
                    if ItemAvailByLoc.RunModal = ACTION::LookupOK then
                        if "Transfer-from Code" <> ItemAvailByLoc.GetLastLocation then
                            if Confirm(
                                 Text010, true, FieldCaption("Transfer-from Code"), "Transfer-from Code",
                                 ItemAvailByLoc.GetLastLocation)
                            then
                                Validate("Transfer-from Code", ItemAvailByLoc.GetLastLocation);
                end;
        end;
    end;


    local procedure CalcBaseQty(Qty: Decimal): Decimal;
    begin
        TestField("Qty. per Unit of Measure");
        exit(Round(Qty * "Qty. per Unit of Measure", 0.00001));
    end;


    local procedure InitOutstandingQty();
    begin
        "Outstanding Quantity" := Quantity - "Quantity Received";
        "Outstanding Qty. (Base)" := "Quantity (Base)" - "Qty. Received (Base)";
        "Completely Received" := (Quantity <> 0) and ("Outstanding Quantity" = 0);
    end;


    local procedure InitQtyToReceive();
    begin
        "Qty. to Receive" := Quantity - "Quantity Received";
        "Qty. to Receive (Base)" := "Quantity (Base)" - "Qty. Received (Base)";
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
        //DIM 1.0 Start
        //Code Comment
        /*
        //DimMgt.ValidateDimValueCode(FieldNumber,ShortcutDimCode);
        //B2b1.0>> Since Function doesn't exist in Nav 2013
        IF "Line No." <> 0 THEN BEGIN
          DimMgt.SaveDocDim(
            DATABASE::"Material Issues Line",DocDim."Document Type"::" ","Document No.",
            "Line No.",FieldNumber,ShortcutDimCode);
          MODIFY;
        END ELSE
          DimMgt.SaveTempDim(FieldNumber,ShortcutDimCode);
         */


        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        //DIM 1.0 End

    end;


    procedure ShowDimensions();
    begin
        //DIM1.0 Start
        /*
        //Deleted Localvar's
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        DocDim.SETRANGE("Table ID",DATABASE::"Material Issues Line");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::" ");
        DocDim.SETRANGE("Document No.","Document No.");
        DocDim.SETRANGE("Line No.","Line No.");
        DocDimensions.SETTABLEVIEW(DocDim);
        DocDimensions.RUNMODAL;
         */

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', "Document No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        //DIM 1.0 End;

    end;

    procedure OpenItemTrackingLines();
    var
        IsReclass: Boolean;
    begin
        TestField("Item No.");
        TestField("Quantity (Base)");
        //ReserveMaterialIssueLine.CallItemTracking(Rec);
        //MISITCform.CallItemTracking(Rec);
        //MISITCform.RUNMODAL;
    end;


    procedure Item_Stock("Item No.": Code[20]; "Location Code": Code[10]) Stokc: Decimal;
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
    begin
        ItemLedgEntry.Reset;
        ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
        "Expiration Date", "Lot No.", "Serial No.");

        ItemLedgEntry.SetRange("Item No.", "Item No.");
        ItemLedgEntry.SetRange(Open, true);
        ItemLedgEntry.SetRange("Location Code", "Location Code");
        if "Location Code" = 'CS' then
            ItemLedgEntry.SetFilter(ItemLedgEntry."Global Dimension 2 Code", 'H-OFF');
        ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
        if ItemLedgEntry.FindSet then
            repeat
                if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                    Stokc := Stokc + ItemLedgEntry."Remaining Quantity";
            until ItemLedgEntry.Next = 0;
        exit(Stokc);
    end;
}

