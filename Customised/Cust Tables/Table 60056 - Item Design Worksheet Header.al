table 60056 "Item Design Worksheet Header"
{
    // version DWS1.0

    DrillDownPageID = "Item DesignWorkSheet HeadeList";
    LookupPageID = "Item DesignWorkSheet HeadeList";
    DataClassification = CustomerContent;

    fields
    {
        field(4; "Item No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get("Item No.") then begin
                    Description := Item.Description;
                    "Unit of Measure" := Item."Base Unit of Measure";
                    if RoutingHeader.Get(Item."Routing No.") then begin
                        RoutingHeader.CalcFields(RoutingHeader."Man Cost");
                        "Main Item Manu Cost" := RoutingHeader."Man Cost";
                    end;

                end;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; "Components Cost"; Decimal)
        {
            CalcFormula = Sum("Item Design Worksheet Line".Amount WHERE("Item No" = FIELD("Item No."),
                                                                         Type = FILTER(Item | "Production BOM")));
            Description = 'Editable=No';
            FieldClass = FlowField;
        }
        field(9; "Manufacturing Cost"; Decimal)
        {
            CalcFormula = Sum("Item Design Worksheet Line"."Total Manufacturing Cost" WHERE("Item No" = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Soldering Time for SMD"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Soldering time for DIP"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "Total time in Hours"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Soldering Cost Perhour"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Resource Cost"; Decimal)
        {
            CalcFormula = Sum("Item Design Worksheet Line".Amount WHERE(Type = CONST(Resource),
                                                                         "Item No" = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Development Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Development Time in hours"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Development Cost" := "Development Time in hours" * "Development Cost per hour";
            end;
        }
        field(19; "Development Cost per hour"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Development Cost" := "Development Time in hours" * "Development Cost per hour";
            end;
        }
        field(20; "Installation Cost"; Decimal)
        {
            CalcFormula = Sum("Item Design Worksheet Line".Amount WHERE(Type = CONST(JOB),
                                                                         "Item No" = FIELD("Item No.")));
            Description = 'Editable=No';
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Additional Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Total Cost (From Line)"; Decimal)
        {
            CalcFormula = Sum("Item Design Worksheet Line".Amount WHERE("Item No" = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Production Bom No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(24; "Production Bom Version No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(100; "Total Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(101; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Release;
            DataClassification = CustomerContent;
        }
        field(201; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(202; "No. of Archived Versions"; Integer)
        {
            Caption = 'No. of Archived Versions';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(203; "Main Item Manu Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(204; "Total Manu Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            SumIndexFields = "Total Cost";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        ItemDesignWorkSheetLine.Reset;
        ItemDesignWorkSheetLine.SetRange("Item No", "Item No.");
        ItemDesignWorkSheetLine.DeleteAll;
    end;

    trigger OnInsert();
    var
        Item: Record Item;
    begin
    end;

    var
        ManufacturingSetup: Record "Manufacturing Setup";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        ItemDesignWorkSheetLine: Record "Item Design Worksheet Line";
        RoutingHeader: Record "Routing Header";


    procedure CopyBomComponents();
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        ProductionBOMLine: Record "Production BOM Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
    begin
        if "Production Bom Version No." = '' then begin
            TestField("Production Bom No.");
            ProductionBOMLine.Reset;
            ProductionBOMLine.SetRange("Production BOM No.", "Production Bom No.");
            ProductionBOMLine.SetFilter("Version Code", '=%1', '');
            if ProductionBOMLine.Find('-') then
                repeat
                    CheckType(ProductionBOMLine);
                until ProductionBOMLine.Next = 0;
        end else begin
            TestField("Production Bom No.");
            TestField("Production Bom Version No.");
            ProductionBOMLine.Reset;
            ProductionBOMLine.SetRange("Production BOM No.", "Production Bom No.");
            ProductionBOMLine.SetRange("Version Code", "Production Bom Version No.");
            if ProductionBOMLine.Find('-') then
                repeat
                    CheckType(ProductionBOMLine);
                until ProductionBOMLine.Next = 0;
        end;
    end;


    procedure DesignWorkSheetAttachments();
    var
        Attachments: Record Attachments;
    begin
        Attachments.Reset;
        Attachments.SetRange("Table ID", DATABASE::"Design Worksheet Header");
        Attachments.SetRange("Document No.", "Item No.");
        PAGE.Run(PAGE::"ESPL Attachments", Attachments);
    end;


    procedure CheckType(var ProductionBOMLine: Record "Production BOM Line");
    var
        ProductionBOMLine1: Record "Production BOM Line";
    begin
        case ProductionBOMLine.Type of
            ProductionBOMLine.Type::"Production BOM":
                begin
                    ProductionBOMLine1.Reset;
                    ProductionBOMLine1.SetRange("Production BOM No.", ProductionBOMLine."No.");
                    ProductionBOMLine1.SetFilter("Version Code", '=%1', '');
                    if ProductionBOMLine1.Find('-') then
                        repeat
                            CheckType(ProductionBOMLine1);
                        until ProductionBOMLine1.Next = 0;
                end;
            ProductionBOMLine.Type::Item:
                begin
                    InsertItems(ProductionBOMLine);
                end;
        end;
    end;


    procedure InsertItems(var ProductionBOMLine: Record "Production BOM Line");
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
        SMDSolder: Decimal;
        DIPSolder: Decimal;
        Cost: Decimal;
        ProductionBomLineCost: Record "Production BOM Line";
        BomItem: Record Item;
        Cost1: Decimal;
        Cost2: Decimal;
        ProductionBomLineSolder: Record "Production BOM Line";
    begin
        /*
        ManufacturingSetup.GET;
        DesignWorksheetLine.INIT;
        DesignWorksheetLine1.SETRANGE("Document No.","Document No.");
        DesignWorksheetLine1.SETRANGE("Document Type","Document Type");
        DesignWorksheetLine1.SETRANGE("Document Line No.","Document Line No.");
        IF DesignWorksheetLine1.FIND('+') THEN
          DesignWorksheetLine."Line No." := DesignWorksheetLine1."Line No." + 10000
        ELSE
          ProductionBOMLine."Line No." := 10000;
        DesignWorksheetLine."Document No." := "Document No.";
        DesignWorksheetLine."Document Type" := "Document Type";
        DesignWorksheetLine."Document Line No." := "Document Line No.";
        DesignWorksheetLine.Type := DesignWorksheetLine.Type :: Item;
        DesignWorksheetLine."No." := ProductionBOMLine."No.";
        DesignWorksheetLine.Description := ProductionBOMLine.Description;
        {
        IF ProductionBOMLine."Type of Solder" = ProductionBOMLine."Type of Solder" :: SMD THEN
          DesignWorksheetLine."No.of SMD Points" := ProductionBOMLine."No. of Soldering Points"
        ELSE
          DesignWorksheetLine."No.of DIP Points" := ProductionBOMLine."No. of Soldering Points";
        }
        DesignWorksheetLine."Unit of Measure" := ProductionBOMLine."Unit of Measure Code";
        DesignWorksheetLine.Quantity := ProductionBOMLine."Quantity per";
        
        Item.GET(DesignWorksheetLine."No.");
        IF Item."Production BOM No." = '' THEN BEGIN
          IF ProductionBOMLine."Type of Solder" = ProductionBOMLine."Type of Solder" :: SMD THEN
            DesignWorksheetLine."No.of SMD Points" := ProductionBOMLine."No. of Soldering Points"
          ELSE
            DesignWorksheetLine."No.of DIP Points" := ProductionBOMLine."No. of Soldering Points";
        END ELSE BEGIN
          ProductionBomLineSolder.SETRANGE("Production BOM No.",Item."Production BOM No.");
          IF ProductionBomLineSolder.FIND('-') THEN
            REPEAT
              IF BomItem.GET(ProductionBomLineSolder."No.") THEN
                IF BomItem."Type of Solder" = BomItem."Type of Solder" :: SMD THEN
                 SMDSolder := SMDSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                IF BomItem."Type of Solder" = BomItem."Type of Solder" :: DIP THEN
                 DIPSolder := DIPSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
            UNTIL ProductionBomLineSolder.NEXT = 0;
            DesignWorksheetLine."No.of SMD Points" := SMDSolder;
            DesignWorksheetLine."No.of DIP Points" := DIPSolder;
            END;
        
        
        Item.GET(DesignWorksheetLine."No.");
        IF Item."Production BOM No." = '' THEN BEGIN
          IF Item."Last Direct Cost" = 0 THEN
            DesignWorksheetLine."Unit Cost" := Item."Unit Cost"
          ELSE
            DesignWorksheetLine."Unit Cost" := Item."Last Direct Cost";
        END ELSE BEGIN
          ProductionBomLineCost.SETRANGE("Production BOM No.",Item."Production BOM No.");
          IF ProductionBomLineCost.FIND('-') THEN
            REPEAT
              //Item.SETRANGE("Production BOM No.",ProductionBomLineCost."No.");
                IF BomItem.GET(ProductionBomLineCost."No.") THEN
                //IF BOMItem.FIND('-') THEN
                IF BomItem."Last Direct Cost" = 0 THEN
                  Cost := Cost + BomItem."Unit Cost"
                ELSE
                  Cost1 := Cost1 + BomItem."Last Direct Cost";
        
            UNTIL ProductionBomLineCost.NEXT = 0;
            Cost2 := Cost+Cost1;
            DesignWorksheetLine."Unit Cost" := Cost2;
        END;
        
        DesignWorksheetLine.Amount := DesignWorksheetLine."Unit Cost" * DesignWorksheetLine.Quantity;
        DesignWorksheetLine."Total time in Hours" := (DesignWorksheetLine."No.of SMD Points" *
           ManufacturingSetup."Soldering Time Req.for BID") + (DesignWorksheetLine."No.of DIP Points"
           * ManufacturingSetup."Soldering Time Req.for DIP");
        DesignWorksheetLine."Manufacturing Cost" := (DesignWorksheetLine."Total time in Hours" / 60) *
          ManufacturingSetup."Soldering Cost per Hour";
        
        DesignWorksheetLine.INSERT
         */

    end;


    procedure CopyItemDesignWorkSheet();
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
        ProductionBomLineSolder: Record "Production BOM Line";
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBomLineCost: Record "Production BOM Line";
        BomItem: Record Item;
        SMDSolder: Integer;
        DIPSolder: Integer;
        Cost: Decimal;
        Cost1: Decimal;
        Cost2: Decimal;
        Designworksheet: Record "Item Design Worksheet Line";
    begin
        /*
        Designworksheet.RESET;
        Designworksheet.SETRANGE("Item No","Item No.");
        IF Designworksheet.FIND('-') THEN
          REPEAT
            DesignWorksheetLine.INIT;
            DesignWorksheetLine1.SETRANGE("Document No.","Document No.");
            DesignWorksheetLine1.SETRANGE("Document Type","Document Type");
            DesignWorksheetLine1.SETRANGE("Document Line No.","Document Line No.");
            IF DesignWorksheetLine1.FIND('+') THEN
              DesignWorksheetLine."Line No." := DesignWorksheetLine1."Line No." + 10000
            ELSE
              DesignWorksheetLine."Line No." := 10000;//modified
            DesignWorksheetLine."Document No." := "Document No.";
            DesignWorksheetLine."Document Type" := "Document Type";
            DesignWorksheetLine."Document Line No." := "Document Line No.";
            DesignWorksheetLine.Type := DesignWorksheetLine.Type :: Item;
            DesignWorksheetLine."No." := Designworksheet."No.";
            DesignWorksheetLine.Description := Designworksheet.Description;
            DesignWorksheetLine."Unit of Measure" := Designworksheet."Unit of Measure";
            DesignWorksheetLine.Quantity := Designworksheet.Quantity;
            Item.GET(DesignWorksheetLine."No.");
            IF Item."Production BOM No." <> '' THEN BEGIN
              ProductionBomLineSolder.RESET;
              ProductionBomLineSolder.SETRANGE("Production BOM No.",Item."Production BOM No.");
              IF ProductionBomLineSolder.FIND('-') THEN
                REPEAT
                  IF BomItem.GET(ProductionBomLineSolder."No.") THEN
                    IF BomItem."Type of Solder" = BomItem."Type of Solder" :: SMD THEN
                      SMDSolder := SMDSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                    IF BomItem."Type of Solder" = BomItem."Type of Solder" :: DIP THEN
                      DIPSolder := DIPSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                UNTIL ProductionBomLineSolder.NEXT = 0;
              DesignWorksheetLine."No.of SMD Points" := SMDSolder;
              DesignWorksheetLine."No.of DIP Points" := DIPSolder;
            END;
            Item.GET(DesignWorksheetLine."No.");
            IF Item."Production BOM No." = '' THEN BEGIN
              IF Item."Last Direct Cost" = 0 THEN
                DesignWorksheetLine."Unit Cost" := Item."Unit Cost"
              ELSE
               DesignWorksheetLine."Unit Cost" := Item."Last Direct Cost";
            END ELSE BEGIN
              ProductionBomLineCost.RESET;
              ProductionBomLineCost.SETRANGE("Production BOM No.",Item."Production BOM No.");
              IF ProductionBomLineCost.FIND('-') THEN
                REPEAT
                  //Item.SETRANGE("Production BOM No.",ProductionBomLineCost."No.");
                  IF BomItem.GET(ProductionBomLineCost."No.") THEN
                  //IF BOMItem.FIND('-') THEN
                  IF BomItem."Last Direct Cost" = 0 THEN
                    Cost := Cost + BomItem."Unit Cost"
                  ELSE
                    Cost1 := Cost1 + BomItem."Last Direct Cost";
                UNTIL ProductionBomLineCost.NEXT = 0;
                Cost2 := Cost+Cost1;
                DesignWorksheetLine."Unit Cost" := Cost2;
            END;
              DesignWorksheetLine.Amount := DesignWorksheetLine."Unit Cost" * DesignWorksheetLine.Quantity;
              DesignWorksheetLine."Total time in Hours" := (DesignWorksheetLine."No.of SMD Points" *
              ManufacturingSetup."Soldering Time Req.for BID") + (DesignWorksheetLine."No.of DIP Points"
              * ManufacturingSetup."Soldering Time Req.for DIP");
              DesignWorksheetLine."Manufacturing Cost" := (DesignWorksheetLine."Total time in Hours" / 60) *
              ManufacturingSetup."Soldering Cost per Hour";
              DesignWorksheetLine.INSERT
          UNTIL Designworksheet.NEXT=0;
         */

    end;
}

