table 60024 "Indent Header"
{
    // version B2B1.0,POAU,Rev01

    LookupPageID = "Indent List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; Make; Code[50])
        {
            //This property is currently not supported
            //TestTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(7; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(8; "Delivery Location"; Code[20])
        {
            TableRelation = IF ("Delivery Place" = CONST(Store)) Location //WHERE(Code = FILTER(<> 'CS STR' & <> 'R&D STR'))//EFFUPG1.2
            ELSE                                                          // This code handled in page level onlookup trigger 
            IF ("Delivery Place" = CONST(Customer)) Customer;
            DataClassification = CustomerContent;
        }
        field(9; Equipment; Code[50])
        {
        }
        field(10; "Drawing No."; Code[50])
        {
        }
        field(11; "Last Date Modified"; Date)
        {
        }
        field(13; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Creation Date"; Date)
        {
        }
        field(15; "Contact Person"; Text[50])
        {
        }
        field(16; Comment; Boolean)
        {
        }
        field(17; "Enquiry No Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18; "Enquiry No."; Code[20])
        {
            Editable = false;
        }
        field(19; "Delivery Place"; Option)
        {
            OptionMembers = Store,Customer;
        }
        field(20; "Equipment No."; Code[20])
        {
        }
        field(21; "Indent Status"; Option)
        {
            OptionCaption = 'Indent,Enquiry,Offer,Order,Cancel,Closed';
            OptionMembers = Indent,Enquiry,Offer,"Order",Cancel,Closed;
        }
        field(22; Status; Boolean)
        {
            Editable = true;
            Enabled = true;
        }
        field(23; "User Id"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(24; "Released Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Cancel,Closed;
        }
        field(25; "Last Modified Date"; Date)
        {
            Editable = false;
        }
        field(26; "Released By"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(27; "Indent Type"; Option)
        {
            Editable = false;
            OptionMembers = Manual,"System Created(New)","System Created (Old)";
        }
        field(28; "Requisition Template Name"; Code[20])
        {
            Editable = false;
        }
        field(29; "Requisition Batch"; Code[20])
        {
            Editable = false;
        }
        field(30; "Fresh Indent"; Boolean)
        {
            Editable = false;
            InitValue = true;
        }
        field(31; "Indent Reference"; Text[50])
        {
        }
        field(32; Department1; Code[20])
        {
        }
        field(34; "Cancelled By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
        }
        field(35; "Cancelled Date"; Date)
        {
        }
        field(36; "Closed By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
        }
        field(37; "Closed Date"; Date)
        {
        }
        field(38; Department; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(39; "Modify Indent"; Boolean)
        {
        }
        field(40; "Released Date"; Date)
        {
        }
        field(41; "ICN No."; Code[10])
        {
            TableRelation = "ICN Numbers";

            trigger OnValidate();
            begin
                TestStatusOpen;
                IndentLine.SETRANGE("Document No.", "No.");
                IF IndentLine.FIND('-') THEN
                    REPEAT
                        IndentLine."ICN No." := "ICN No.";
                        IndentLine.MODIFY;
                    UNTIL IndentLine.NEXT = 0;
            end;
        }
        field(42; "Production BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header"."No." WHERE(Status = FILTER(Certified));
        }
        field(43; "Production Bom Version No."; Code[20])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));
        }
        field(44; "Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(45; Quantity; Decimal)
        {
        }
        field(46; "Project Code"; Code[15])
        {
            TableRelation = "Reason Code".Code;
        }
        field(47; "Person Code"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = Employee."No.";
        }
        field(50; "Release Date Time"; DateTime)
        {
        }
        field(51; "Sale Order No."; Code[30])
        {
            TableRelation = IF ("Type of Indent" = CONST("Sale Order")) "Sales Header"."No." WHERE("Document Type" = FILTER(Order | "Blanket Order")) ELSE
            IF ("Type of Indent" = CONST("AMC Order")) "Sales Header"."No." WHERE(SaleDocType = CONST(Amc)); //EFFUPG1.5

            trigger OnValidate();
            begin
                "Sales Header".SETRANGE("Sales Header"."No.", "Sale Order No.");
                IF "Sales Header".FIND('-') THEN
                    "Sales Order Description" := "Sales Header"."Bill-to Name";
            end;
        }
        field(52; "System date"; Date)
        {
        }
        field(60100; "Project Description"; Text[50])
        {
        }
        field(60101; "Production Order Description"; Text[50])
        {
        }
        field(60102; "Production Start date"; Date)
        {
        }
        field(60103; "Sales Order Description"; Text[50])
        {
        }
        field(60104; "Tender No."; Code[30])
        {
            TableRelation = "Tender Header";

            trigger OnValidate();
            begin
                "Tender Header".SETRANGE("Tender Header"."Tender No.", "Tender No.");
                IF "Tender Header".FIND('-') THEN
                    "Tener Description" := "Tender Header"."Tender Description";
            end;
        }
        field(60105; "Tener Description"; Text[100])
        {
        }
        field(60107; "Material Request No."; Code[20])
        {
        }
        field(60108; "Type of Indent"; Option)
        {
            OptionMembers = "Sale Order",MinmumStock,"AMC Order","R&D",ADMIN;
        }
        field(60109; "IR Number"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Department)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin

        IF NOT (USERID IN ['EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\RRAHUL']) THEN begin
            UserGRec.RESET;
            //UserGRec.SETRANGE("User Name", USERID);
            UserGRec.SETRANGE("User ID", USERID);
            IF UserGRec.FINDFIRST THEN BEGIN
                IF UserGRec.Dept = 'STR' THEN BEGIN
                    IndentLine.RESET;
                    IndentLine.SETRANGE("Document No.", "No.");
                    IF IndentLine.FINDFIRST THEN
                        ERROR('You Do Not Have Right to delete Indent!');
                END ELSE
                    ERROR('You Do Not Have Right to delete Indent!');
            END ELSE
                ERROR('You Do Not Have Right to delete Indent!');
        END;


        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "No.");
        IndentLine.DELETEALL;

    end;

    trigger OnInsert();
    begin
        PurchaseSetup.GET;
        IF "No." = '' THEN BEGIN
            PurchaseSetup.TESTFIELD("Purchase Indent Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."Purchase Indent Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Creation Date" := TODAY;
        "User Id" := USERID;
        "ICN No." := ICN();
    end;

    trigger OnModify();
    begin
        "Last Date Modified" := TODAY;
        //TESTFIELD("Released Status","Released Status"::Open);
    end;

    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit 396;
        PIndent: Record "Indent Header";
        Cust: Record Customer;
        loc: Record Location;
        IndentLine: Record "Indent Line";
        Purchaser: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
        Item: Record Item;
        Text000: Label 'The %1 cannot be copied to itself.';
        Text0001: Label 'Do you want to close the Material Indent?';
        Text002: Label 'Do you want to release the Indent?';
        Text003: Label 'Do you want to cancel the Indent?';
        Text004: Label 'Indent can not be cancel as it is in process';
        Text005: Label 'Do you want to close the Indent?';
        Text006: Label 'Do you want to reopen the Indent?';
        "Sales Header": Record "Sales Header";
        "Tender Header": Record "Tender Header";
        UserGRec: Record "User Setup";


    procedure AssistEdit(OldIndent: Record "Indent Header"): Boolean;
    begin
        PIndent := Rec;
        PurchaseSetup.GET;
        PurchaseSetup.TESTFIELD("Purchase Indent Nos.");
        IF NoSeriesMgt.SelectSeries(PurchaseSetup."Purchase Indent Nos.", OldIndent."No.", PIndent."No.") THEN BEGIN
            NoSeriesMgt.SetSeries(PIndent."No.");
            Rec := PIndent;
            EXIT(TRUE);
        END;
    end;


    procedure ReleaseIndent();
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
    begin
        IF NOT CONFIRM(Text002, FALSE) THEN
            EXIT;
        //TESTFIELD("Production Order No.");
        TESTFIELD("Released Status", "Released Status"::Open);
        TESTFIELD("Contact Person");
        TESTFIELD("Indent Reference");
        LOCKTABLE;
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "No.");
        IF IndentLine.FIND('-') THEN
            REPEAT
                IF /*(IndentLine.Type = IndentLine.Type :: Description) AND*/ (IndentLine.Type = IndentLine.Type::Item) THEN BEGIN
                    IndentLine.TESTFIELD(IndentLine."No.");
                    IndentLine.TESTFIELD(IndentLine.Quantity);
                    IndentLine.TESTFIELD(IndentLine."ICN No."); //added By santhosh Kumar.korada
                END;
                IF IndentLine.Type = IndentLine.Type::Miscellaneous THEN
                    IndentLine.TESTFIELD("G/L Account");
                Item.RESET;                                     //Added by Pranavi on 27-07-2015 to restrict the item with PO blocked
                Item.SETFILTER(Item."No.", IndentLine."No.");
                IF Item.FINDFIRST THEN BEGIN
                    IF Item."PO Blocked" = TRUE THEN
                        ERROR('Indent Cannot be released beacause of Item: ' + Item."No." + ' is blocked for PO!');
                END;                                        //End by Pranavi
            UNTIL IndentLine.NEXT = 0;
        IF IndentLine.FIND('-') THEN;
        BEGIN
            IndentLine.MODIFYALL("Release Status", IndentLine."Release Status"::Released);
            //MESSAGE('INDENT RELEASED');
            IndentLine.MODIFYALL(IndentLine."Due Date", TODAY);
        END;
        "Released Status" := "Released Status"::Released;
        "Last Modified Date" := WORKDATE;
        "System date" := TODAY;
        "Released By" := USERID;
        "Modify Indent" := TRUE;
        //B2B
        "Release Date Time" := CURRENTDATETIME;
        //B2B

    end;


    procedure CancelIndent();
    var
        PurchLine: Record "Purchase Line";
    begin
        IF NOT CONFIRM(Text003, FALSE) THEN
            EXIT;

        IndentLine.SETRANGE("Document No.", "No.");
        IndentLine.SETFILTER("Indent Status", '%1|%2', IndentLine."Indent Status"::Offer, IndentLine."Indent Status"::Order);
        IF IndentLine.FIND('-') THEN
            ERROR(Text004);
        LOCKTABLE;
        IndentLine.SETRANGE("Indent Status");
        IndentLine.MODIFYALL("Indent Status", IndentLine."Indent Status"::Closed);
        IndentLine.MODIFYALL("Release Status", IndentLine."Release Status"::Cancel);
        "Released Status" := "Released Status"::Cancel;
        "Indent Status" := "Indent Status"::Cancel;
        "Cancelled By" := USERID;
        "Cancelled Date" := WORKDATE;
        "Modify Indent" := TRUE;
    end;


    procedure CloseIndent();
    var
        PurchLine: Record "Purchase Line";
    begin
        IF NOT CONFIRM(Text005, FALSE) THEN
            EXIT;
        LOCKTABLE;
        IndentLine.SETRANGE("Document No.", "No.");
        IndentLine.MODIFYALL("Indent Status", IndentLine."Indent Status"::Closed);
        IndentLine.MODIFYALL("Release Status", IndentLine."Release Status"::Closed);

        "Closed By" := USERID;
        "Released Status" := "Released Status"::Closed;
        "Indent Status" := "Indent Status"::Closed;
        "Closed Date" := WORKDATE;
        "Modify Indent" := TRUE;
    end;


    procedure CopyIndent();
    var
        FromIndentLine: Record "Indent Line";
        ToIndentLine: Record "Indent Line";
        IndentHeader: Record "Indent Header";
    begin
        TESTFIELD("No.");
        TESTFIELD("Released Status", "Released Status"::Open);
        IF PAGE.RUNMODAL(0, IndentHeader) = ACTION::LookupOK THEN BEGIN
            IF "No." = IndentHeader."No." THEN
                ERROR(Text000, TABLECAPTION);

            ToIndentLine.SETRANGE("Document No.", "No.");
            ToIndentLine.DELETEALL;

            FromIndentLine.SETRANGE("Document No.", IndentHeader."No.");
            IF FromIndentLine.FIND('-') THEN
                REPEAT
                    ToIndentLine := FromIndentLine;
                    ToIndentLine."ICN No." := "ICN No.";//po1.0
                    ToIndentLine."Document No." := "No.";
                    ToIndentLine."Indent Status" := ToIndentLine."Indent Status"::Indent;
                    ToIndentLine."Due Date" := WORKDATE;
                    ToIndentLine."Production Order Description" := "Production Order Description";
                    ToIndentLine.INSERT;
                UNTIL FromIndentLine.NEXT = 0;
        END;
    end;


    procedure CopyProdComponents();
    var
        ToIndentLine: Record "Indent Line";
        ProdOrderLines: Record "Prod. Order Line";
        IndentLineNo: Integer;
        ProdOrderLineComp: Record "Prod. Order Component";
    begin
        //29-sep-06

        TESTFIELD("Production Order No.");
        TESTFIELD(Quantity);
        TESTFIELD("ICN No.");
        ProdOrderLineComp.RESET;
        ProdOrderLineComp.SETRANGE(Status, ProdOrderLineComp.Status::Released);
        ProdOrderLineComp.SETRANGE("Prod. Order No.", "Production Order No.");
        //ProdOrderLineComp.SETFILTER("Remaining Quantity",'<>0');
        IF ProdOrderLineComp.FIND('-') THEN
            REPEAT
                ToIndentLine.INIT;
                IndentLineNo := IndentLineNo + 10000;
                ToIndentLine."Document No." := "No.";
                ToIndentLine."ICN No." := "ICN No.";//po1.0
                ToIndentLine."Line No." := IndentLineNo;
                ToIndentLine.Type := ToIndentLine.Type::Item;
                ToIndentLine.VALIDATE("No.", ProdOrderLineComp."Item No.");
                ToIndentLine."Unit of Measure" := ProdOrderLineComp."Unit of Measure Code";
                IF Quantity <> 0 THEN
                    ToIndentLine.VALIDATE(Quantity, (ProdOrderLineComp.Quantity * Quantity));
                ToIndentLine."Indent Status" := ToIndentLine."Indent Status"::Indent;
                ToIndentLine."Due Date" := ProdOrderLineComp."Due Date";
                ToIndentLine."Variant Code" := ProdOrderLineComp."Variant Code";
                ToIndentLine.Contact := 'PPC';
                ToIndentLine."Indent Reference" := "Indent Reference";
                ToIndentLine."Production Order" := "Production Order No.";
                ToIndentLine."Production Order Line No." := ProdOrderLineComp."Prod. Order Line No.";
                ToIndentLine."Drawing No." := ProdOrderLines."Item No.";
                ToIndentLine."Routing No." := ProdOrderLines."Routing No.";
                ToIndentLine.INSERT;
            UNTIL ProdOrderLineComp.NEXT = 0;
        /*
        TESTFIELD("No.");
        TESTFIELD("Released Status","Released Status" :: Open);
        ProdOrderLines.SETRANGE(Status,ProdOrderLines.Status :: Released);
        
        IF PAGE.RUNMODAL(0,ProdOrderLines) = ACTION::LookupOK THEN BEGIN
          ToIndentLine.SETRANGE("Document No.","No.");
          IF ToIndentLine.FIND('+') THEN
            IndentLineNo := ToIndentLine."Line No."
          ELSE
            IndentLineNo := 0;
          ProdOrderLineComp.RESET;
          ProdOrderLineComp.SETRANGE(Status,ProdOrderLineComp.Status :: Released);
          ProdOrderLineComp.SETRANGE("Prod. Order No.",ProdOrderLines."Prod. Order No.");
          ProdOrderLineComp.SETRANGE("Prod. Order Line No.",ProdOrderLines."Line No.");
          ProdOrderLineComp.SETFILTER("Remaining Quantity",'<>0');
        
          IF ProdOrderLineComp.FIND('-') THEN
            REPEAT
              IF Item.GET(ProdOrderLineComp."Item No.") THEN;
              IF (Item."Replenishment System" = Item."Replenishment System" :: Purchase) AND
              (Item."Manufacturing Policy" = Item."Manufacturing Policy" :: "Make-to-Order") THEN BEGIN
                ToIndentLine.INIT;
                IndentLineNo := IndentLineNo + 10000;
                ToIndentLine."Document No." := "No.";
                ToIndentLine."Line No." := IndentLineNo;
                ToIndentLine.Type := ToIndentLine.Type :: Item;
                ToIndentLine.VALIDATE("No.",ProdOrderLineComp."Item No.");
                ToIndentLine."Unit of Measure" := ProdOrderLineComp."Unit of Measure Code";
                ToIndentLine.VALIDATE(Quantity,ProdOrderLineComp."Remaining Quantity");
                ToIndentLine."Indent Status" := ToIndentLine."Indent Status" :: Indent;
                ToIndentLine."Due Date" := ProdOrderLineComp."Due Date";
                ToIndentLine."Variant Code" := ProdOrderLineComp."Variant Code";
                ToIndentLine.Contact := 'PPC';
                ToIndentLine."Indent Reference" := "Indent Reference";
                ToIndentLine."Production Order" := ProdOrderLines."Prod. Order No.";
                ToIndentLine."Production Order Line No." := ProdOrderLines."Line No.";
                ToIndentLine."Drawing No." := ProdOrderLines."Item No.";
                ToIndentLine."Routing No." := ProdOrderLines."Routing No.";
                ToIndentLine.INSERT;
              END;
            UNTIL ProdOrderLineComp.NEXT = 0;
        END;
        */

    end;


    procedure CopySaleOrderLines();
    var
        ToIndentLine: Record "Indent Line";
        ProdOrderLines: Record "Prod. Order Line";
        IndentLineNo: Integer;
        ProdOrderLineComp: Record "Prod. Order Component";
        Item: Record Item;
        SaleHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        TESTFIELD("No.");
        TESTFIELD("Released Status", "Released Status"::Open);
        SaleHeader.SETRANGE("Document Type", SaleHeader."Document Type"::Order);

        IF PAGE.RUNMODAL(0, SaleHeader) = ACTION::LookupOK THEN BEGIN
            ToIndentLine.SETRANGE("Document No.", "No.");
            IF ToIndentLine.FIND('+') THEN
                IndentLineNo := ToIndentLine."Line No."
            ELSE
                IndentLineNo := 0;
            SalesLine.RESET;
            SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
            SalesLine.SETRANGE("Document No.", SaleHeader."No.");
            SalesLine.SETRANGE(Type, SalesLine.Type::Item);
            IF SalesLine.FIND('-') THEN
                REPEAT
                    ToIndentLine.INIT;
                    IndentLineNo := IndentLineNo + 10000;
                    ToIndentLine."Document No." := "No.";
                    ToIndentLine."ICN No." := "ICN No.";//po1.0
                    ToIndentLine."Line No." := IndentLineNo;
                    ToIndentLine."Indent Status" := ToIndentLine."Indent Status"::Indent;
                    ToIndentLine.Contact := 'PPC';
                    ToIndentLine."Indent Reference" := "Indent Reference";
                    ToIndentLine."Sale Order No." := SalesLine."Document No.";
                    ToIndentLine.Description := SalesLine.Description;
                    IF (SalesLine.Type = SalesLine.Type::Item) AND (SalesLine."Qty. to Ship" > 0) THEN BEGIN
                        ToIndentLine.Type := ToIndentLine.Type::Item;
                        ToIndentLine.VALIDATE("No.", SalesLine."No.");
                        ToIndentLine."Unit of Measure" := SalesLine."Unit of Measure Code";
                        ToIndentLine.VALIDATE(Quantity, SalesLine."Qty. to Ship");
                        ToIndentLine."Due Date" := SalesLine."Shipment Date" - 1;
                        ToIndentLine."Variant Code" := SalesLine."Variant Code";
                        IF (Item.GET(SalesLine."No.")) AND (Item."Replenishment System" = Item."Replenishment System"::Purchase) AND
                          (Item."Manufacturing Policy" = Item."Manufacturing Policy"::"Make-to-Order") THEN
                            ToIndentLine.INSERT;
                    END;
                UNTIL SalesLine.NEXT = 0;
        END;
    end;


    procedure ReopenIndent();
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
    begin
        IF NOT CONFIRM(Text006, FALSE) THEN
            EXIT;

        TESTFIELD("Released Status", "Released Status"::Released);
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "No.");
        IF IndentLine.FIND('-') THEN
            REPEAT
                IF IndentLine.Type <> IndentLine.Type::Description THEN BEGIN
                    //   IF  IndentLine.Type <> IndentLine.Type :: " " THEN
                    //     IndentLine.TESTFIELD(IndentLine."No.");
                    // IndentLine.TESTFIELD(IndentLine.Quantity);
                END;
            /* IF IndentLine.Type = IndentLine.Type :: Miscellaneous THEN
               IndentLine.TESTFIELD("G/L Account");  */
            UNTIL IndentLine.NEXT = 0;
        IF IndentLine.FIND('-') THEN;
        IndentLine.MODIFYALL("Release Status", IndentLine."Release Status"::Open);
        MODIFY(TRUE);

        "Released Status" := "Released Status"::Open;
        "Last Modified Date" := TODAY;
        "Released By" := USERID;
        "Modify Indent" := TRUE;

    end;


    procedure ConsolidateIndents();
    var
        IndentHeader: Record "Indent Header";
        IndentConsolidation: Record "Indent Consolidation";
        IndentLine: Record "Indent Line";
    begin
        /*
        IndentHeader.SETRANGE("ICN No.","ICN No.");
        IF IndentHeader.FIND('-') THEN
        REPEAT
          IndentLine.SETRANGE("Document No.",IndentHeader."No.");
          IF IndentLine.FIND('-') THEN
              REPEAT
                IndentConsolidation."ICN No." := "ICN No.";
                IndentConsolidation."Indent No." := IndentLine."Document No.";
                IndentConsolidation."Item No." := IndentLine."No.";
                IndentConsolidation.Describtion := IndentLine.Description;
                IndentConsolidation.Quantity := IndentLine.Quantity;
              UNTIL IndentLine.NEXT = 0;
        UNTIL IndentHeader.NEXT = 0;
        */

    end;

    procedure CopyBomComponents();
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        ProductionBOMLine: Record "Production BOM Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
    begin
        IF "Production Bom Version No." = '' THEN BEGIN
            TESTFIELD("Production BOM No.");
            ProductionBOMLine.RESET;
            ProductionBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
            ProductionBOMLine.SETFILTER("Version Code", '=%1', '');
            IF ProductionBOMLine.FIND('-') THEN
                REPEAT
                    CheckType(ProductionBOMLine);
                UNTIL ProductionBOMLine.NEXT = 0;
        END ELSE BEGIN
            TESTFIELD("Production BOM No.");
            TESTFIELD("Production Bom Version No.");
            ProductionBOMLine.RESET;
            ProductionBOMLine.SETRANGE("Production BOM No.", "Production BOM No.");
            ProductionBOMLine.SETRANGE("Version Code", "Production Bom Version No.");
            IF ProductionBOMLine.FIND('-') THEN
                REPEAT
                    CheckType(ProductionBOMLine);
                UNTIL ProductionBOMLine.NEXT = 0;
        END;
    end;


    procedure CheckType(var ProductionBOMLine: Record "Production BOM Line");
    var
        ProductionBOMLine1: Record "Production BOM Line";
    begin
        CASE ProductionBOMLine.Type OF
            ProductionBOMLine.Type::"Production BOM":
                BEGIN
                    ProductionBOMLine1.RESET;
                    ProductionBOMLine1.SETRANGE("Production BOM No.", ProductionBOMLine."No.");
                    ProductionBOMLine1.SETFILTER("Version Code", '=%1', '');
                    IF ProductionBOMLine1.FIND('-') THEN
                        REPEAT
                            CheckType(ProductionBOMLine1);
                        UNTIL ProductionBOMLine1.NEXT = 0;
                END;
            ProductionBOMLine.Type::Item:
                BEGIN
                    InsertItems(ProductionBOMLine);
                END;
        END;
    end;


    procedure InsertItems(var ProductionBOMLine: Record "Production BOM Line");
    var
        IndentLine: Record "Indent Line";
        IndentLine1: Record "Indent Line";
    begin
        IndentLine.INIT;
        IndentLine1.SETRANGE("Document No.", "No.");
        IF IndentLine1.FIND('+') THEN
            IndentLine."Line No." := IndentLine1."Line No." + 10000
        ELSE
            IndentLine."Line No." := 10000;
        IndentLine."Document No." := "No.";
        IndentLine."ICN No." := "ICN No.";//po1.0
        IndentLine.Type := IndentLine.Type::Item;
        IndentLine."No." := ProductionBOMLine."No.";
        IndentLine.Description := ProductionBOMLine.Description;
        IndentLine."Unit of Measure" := ProductionBOMLine."Unit of Measure Code";
        IndentLine.Quantity := ProductionBOMLine."Quantity per";
        //b2b EFF
        IF Item.GET(IndentLine."No.") THEN BEGIN
            Item.CALCFIELDS("Inventory at Stores");
            IndentLine."Store Qty" := Item."Inventory at Stores";
        END;
        //b2b EFF
        IndentLine.INSERT
    end;


    procedure TestStatusOpen();
    begin
        TESTFIELD("Released Status", "Released Status"::Open);
    end;


    procedure ReleaseIndent1("IndentNo.": Code[20]);
    var
        IndentHeader: Record "Indent Header";
        IndentLine: Record "Indent Line";
    begin
        //IF NOT CONFIRM(Text002,FALSE) THEN
        //  EXIT;
        //TESTFIELD("Production Order No.");
        TESTFIELD("Released Status", "Released Status"::Open);
        TESTFIELD("Contact Person");
        TESTFIELD("Indent Reference");
        LOCKTABLE;
        IndentLine.RESET;
        IndentLine.SETRANGE("Document No.", "IndentNo.");
        IF IndentLine.FIND('-') THEN
            REPEAT
                IF /*(IndentLine.Type = IndentLine.Type :: Description) OR*/ (IndentLine.Type = IndentLine.Type::Item) THEN BEGIN
                    IndentLine.TESTFIELD(IndentLine."No.");
                    IndentLine.TESTFIELD(IndentLine.Quantity);
                    IndentLine.TESTFIELD(IndentLine."ICN No."); //added By santhosh Kumar.korada
                END;
                Item.RESET;                                     //Added by Pranavi on 27-07-2015 to restrict the item with PO blocked
                Item.SETFILTER(Item."No.", IndentLine."No.");
                IF Item.FINDFIRST THEN BEGIN
                    IF Item."PO Blocked" = TRUE THEN
                        ERROR('Indent Cannot be released beacause of Item: ' + Item."No." + ' is blocked for PO!');
                END;                                        //End by Pranavi
                IF IndentLine.Type = IndentLine.Type::Miscellaneous THEN
                    IndentLine.TESTFIELD("G/L Account");
            UNTIL IndentLine.NEXT = 0;
        IF IndentLine.FIND('-') THEN;
        BEGIN
            IndentLine.MODIFYALL("Release Status", IndentLine."Release Status"::Released);
            IndentLine.MODIFYALL(IndentLine."Due Date", TODAY);
            IF IndentHeader.GET(IndentLine."Document No.") THEN // Added by Pranavi on 09-08-17
                IndentLine.MODIFYALL("Production Start date", IndentHeader."Production Start date");
        END;
        "Released Status" := "Released Status"::Released;
        "Last Modified Date" := WORKDATE;
        "System date" := TODAY;
        "Released By" := USERID;
        "Modify Indent" := TRUE;
        MODIFY;   //Added by Pranavi on 28-Dec-2015 for clearing auto indent not releasing issue
        //B2B
        //"Release Date Time":=;
        //B2B

    end;


    procedure ICN() ICNNO: Text[10];
    begin
        IF STRLEN(FORMAT(DATE2DMY(TODAY, 1))) = 2 THEN
            ICNNO := FORMAT(DATE2DMY(TODAY, 1))
        ELSE
            ICNNO += '0' + FORMAT(DATE2DMY(TODAY, 1));

        IF STRLEN(FORMAT(DATE2DMY(TODAY, 2))) = 2 THEN
            ICNNO += FORMAT(DATE2DMY(TODAY, 2))
        ELSE
            ICNNO += '0' + FORMAT(DATE2DMY(TODAY, 2));

        IF STRLEN(COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2)) = 2 THEN
            ICNNO += COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2)
        ELSE
            ICNNO += '0' + COPYSTR(FORMAT(DATE2DMY(TODAY, 3)), 3, 2);
    end;
}

