table 50009 "Item Design Worksheet Line"
{
    // version DWS1.0

    DrillDownPageID = "Item Design Worksheet List";
    LookupPageID = "Item Design Worksheet List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Item,JOB,Resource,"Production BOM";
            DataClassification = CustomerContent;
        }
        field(5; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(JOB)) Job
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Production BOM")) "Production BOM Header";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                JobCost: Decimal;
            begin
                case Type of
                    Type::" ":
                        begin
                            if StdTxt.Get("No.") then;
                            Description := StdTxt.Description;
                        end;
                    Type::Item:
                        begin
                            if Item.Get("No.") then;
                            Item.TestField(Blocked, false);
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            "Unit of Measure" := Item."Base Unit of Measure";
                            /*
                            IF Item."Last Direct Cost" <> 0 THEN
                              "Unit Cost" := Item."Last Direct Cost"
                            ELSE
                              "Unit Cost" := Item."Unit Cost";
                             */
                            //dws1.0
                            "Unit Cost" := Item."Avg Unit Cost";//dws1.0
                            if RoutingHeader.Get(Item."Routing No.") then begin
                                RoutingHeader.CalcFields(RoutingHeader."Man Cost");
                                "Manufacturing Cost" := RoutingHeader."Man Cost";
                                "Total Manufacturing Cost" := Quantity * RoutingHeader."Man Cost";
                            end;
                            //dws1.0
                            if Item."Type of Solder" = Item."Type of Solder"::SMD then
                                "No.of SMD Points" := Item."No. of Soldering Points"
                            else
                                if Item."Type of Solder" = Item."Type of Solder"::DIP then
                                    "No.of DIP Points" := Item."No. of Soldering Points";
                        end;
                    Type::Resource:
                        begin
                            if Resource.Get("No.") then;
                            Resource.TestField(Blocked, false);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Unit of Measure" := Resource."Base Unit of Measure";
                            "Unit Cost" := Resource."Unit Cost";
                        end;
                    Type::"Production BOM":
                        begin
                            if ProductionBOM.Get("No.") then;
                            Description := ProductionBOM.Description;
                            ProductionBOM.CalcFields(ProductionBOM."BOM Cost");
                            "Unit of Measure" := ProductionBOM."Unit of Measure Code";
                            "Unit Cost" := ProductionBOM."BOM Cost";
                            Quantity := 1;
                        end;
                /*
                Type::JOB:
                  BEGIN
                  IF Job.GET("No.") THEN;
                  Description := Job.Description;
                  "Description 2" := Job."Description 2";
                  JobBudgetLine.SETRANGE("Job No.",Job."No.");
                  IF JobBudgetLine.FIND('-') THEN BEGIN
                    REPEAT
                      JobBudgetLine.CALCFIELDS(JobBudgetLine."Total Cost");
                      JobCost := JobCost + JobBudgetLine."Total Cost";
                    UNTIL JobBudgetLine.NEXT = 0;
                  Amount := JobCost;
                  Quantity := 1;
                  "Unit Cost" := JobCost;
                  END;
                END;
                *///DM commented due to table does not exist
                end;

            end;
        }
        field(6; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "No.of SMD Points"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "No.of DIP Points"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Unit of Measure"; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; Quantity; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Type = Type::JOB then
                    Error('You Can not Modify the quantity when the type is JOB');

                if Type = Type::Item then
                    if Item.Get("No.") then;
                if Item."Type of Solder" = Item."Type of Solder"::SMD then
                    "No.of SMD Points" := Item."No. of Soldering Points"
                else
                    if Item."Type of Solder" = Item."Type of Solder"::DIP then
                        "No.of DIP Points" := Item."No. of Soldering Points";

                ManufacturingSetup.Get;
                "No.of SMD Points" := "No.of SMD Points" * Quantity;
                "No.of DIP Points" := "No.of DIP Points" * Quantity;
                Amount := "Unit Cost" * Quantity;

                "Total time in Hours" := ("No.of SMD Points" *
                        ManufacturingSetup."Soldering Time Req.for BID") + ("No.of DIP Points"
                        * ManufacturingSetup."Soldering Time Req.for DIP");
                /*
                "Manufacturing Cost" := ("Total time in Hours" / 60) *
                     ManufacturingSetup."Soldering Cost per Hour";
                */

            end;
        }
        field(12; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Amount := "Unit Cost" * Quantity;
            end;
        }
        field(13; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Total time in Hours"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Manufacturing Cost"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Total Manufacturing Cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No", "Line No.")
        {
            SumIndexFields = Amount;
        }
        key(Key2; Type, "Item No")
        {
            SumIndexFields = Amount, "Total Manufacturing Cost";
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        Resource: Record Resource;
        StdTxt: Record "Standard Text";
        Job: Record Job;
        ProductionBOM: Record "Production BOM Header";
        ManufacturingSetup: Record "Manufacturing Setup";
        RoutingHeader: Record "Routing Header";


    procedure CopyBomComponents2();
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        ProductionBOMLine: Record "Production BOM Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
    begin
        if Item.Get("Item No") and (Item."Production BOM No." <> '') then begin
            ProductionBOMLine.Reset;
            ProductionBOMLine.SetRange("Production BOM No.", Item."Production BOM No.");
            ProductionBOMLine.SetFilter("Version Code", '=%1', '');
            if ProductionBOMLine.Find('-') then
                repeat
                    //CheckType(ProductionBOMLine);
                    InsertItems2(ProductionBOMLine);
                until ProductionBOMLine.Next = 0;
        end;
    end;

    procedure CheckType2(var ProductionBOMLine: Record "Production BOM Line");
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
                            CheckType2(ProductionBOMLine1);
                        until ProductionBOMLine1.Next = 0;
                end;
            ProductionBOMLine.Type::Item:
                begin
                    InsertItems2(ProductionBOMLine);
                end;
        end;
    end;


    procedure InsertItems2(var ProductionBOMLine: Record "Production BOM Line");
    var
        DesignWorksheet: Record "Item Design Worksheet Line";
        DesignWorksheet1: Record "Item Design Worksheet Line";
        SMDSolder: Decimal;
        DIPSolder: Decimal;
        Cost: Decimal;
        ProductionBomLineCost: Record "Production BOM Line";
        BomItem: Record Item;
        Cost1: Decimal;
        Cost2: Decimal;
        ProductionBomLineSolder: Record "Production BOM Line";
        ProdBOmHeader: Record "Production BOM Header";
    begin
        ManufacturingSetup.Get;
        DesignWorksheet.Init;
        DesignWorksheet."Item No" := "Item No";
        DesignWorksheet."Line No." := ProductionBOMLine."Line No.";
        if ProductionBOMLine.Type = ProductionBOMLine.Type::Item then
            DesignWorksheet.Type := DesignWorksheet.Type::Item
        else
            if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then
                DesignWorksheet.Type := DesignWorksheet.Type::"Production BOM";
        DesignWorksheet."No." := ProductionBOMLine."No.";
        DesignWorksheet.Description := ProductionBOMLine.Description;
        DesignWorksheet."Unit of Measure" := ProductionBOMLine."Unit of Measure Code";
        DesignWorksheet.Quantity := ProductionBOMLine."Quantity per";

        if Item.Get(DesignWorksheet."No.") then;
        if Item."Production BOM No." = '' then begin
            if ProductionBOMLine."Type of Solder" = ProductionBOMLine."Type of Solder"::SMD then
                DesignWorksheet."No.of SMD Points" := ProductionBOMLine."No. of Soldering Points"
            else
                DesignWorksheet."No.of DIP Points" := ProductionBOMLine."No. of Soldering Points";
        end else begin
            ProductionBomLineSolder.SetRange("Production BOM No.", Item."Production BOM No.");
            if ProductionBomLineSolder.Find('-') then
                repeat
                    if BomItem.Get(ProductionBomLineSolder."No.") then
                        if BomItem."Type of Solder" = BomItem."Type of Solder"::SMD then
                            SMDSolder := SMDSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                    if BomItem."Type of Solder" = BomItem."Type of Solder"::DIP then
                        DIPSolder := DIPSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                until ProductionBomLineSolder.Next = 0;
            DesignWorksheet."No.of SMD Points" := SMDSolder;
            DesignWorksheet."No.of DIP Points" := DIPSolder;
        end;


        if Item.Get(DesignWorksheet."No.") then;
        if Item."Production BOM No." = '' then begin
            /*
            IF Item."Last Direct Cost" = 0 THEN
              DesignWorksheet."Unit Cost" := Item."Unit Cost"
            ELSE
              DesignWorksheet."Unit Cost" := Item."Last Direct Cost";
            */
            //DWS1.0
            DesignWorksheet."Unit Cost" := Item."Avg Unit Cost";
            "Manufacturing Cost" := Item."Manufacturing Cost";
            //DWS1.0
            /*
            END ELSE BEGIN
              ProductionBomLineCost.SETRANGE("Production BOM No.",Item."Production BOM No.");
              IF ProductionBomLineCost.FIND('-') THEN
                REPEAT
                  //Item.SETRANGE("Production BOM No.",ProductionBomLineCost."No.");
                    IF BomItem.GET(ProductionBomLineCost."No.") THEN
                    //IF BOMItem.FIND('-') THEN
                    {
                    IF BomItem."Last Direct Cost" = 0 THEN
                      Cost := Cost + BomItem."Unit Cost"
                    ELSE
                      Cost1 := Cost1 + BomItem."avg unit Cost";
                     }
                     Cost+= BomItem."Avg Unit Cost";
                     Cost1+=BomItem."Manufacturing Cost";
                UNTIL ProductionBomLineCost.NEXT = 0;
                Cost2 := Cost;
                DesignWorksheet."Unit Cost" := Cost2;
            */
        end;
        DesignWorksheet.Amount := DesignWorksheet."Unit Cost" * DesignWorksheet.Quantity;
        if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then begin
            if ProdBOmHeader.Get(DesignWorksheet."No.") then
                ProdBOmHeader.CalcFields(ProdBOmHeader."BOM Cost", ProdBOmHeader."BOM Manufacturing Cost");
            DesignWorksheet."Unit Cost" := ProdBOmHeader."BOM Cost";
            DesignWorksheet."Manufacturing Cost" := ProdBOmHeader."BOM Manufacturing Cost";
            DesignWorksheet.Amount := ProdBOmHeader."BOM Cost";
        end;

        DesignWorksheet."Total time in Hours" := (DesignWorksheet."No.of SMD Points" *
           ManufacturingSetup."Soldering Time Req.for BID") + (DesignWorksheet."No.of DIP Points"
           * ManufacturingSetup."Soldering Time Req.for DIP");
        DesignWorksheet."Manufacturing Cost" := Cost1;
        DesignWorksheet.Insert;

    end;


    procedure CopyBomComponents();
    var
        DesignWorksheetLine: Record "Design Worksheet Line";
        ProductionBOMLine: Record "Production BOM Line";
        DesignWorksheetLine1: Record "Design Worksheet Line";
    begin
        if Item.Get("Item No") and (Item."Production BOM No." <> '') then begin
            ProductionBOMLine.Reset;
            ProductionBOMLine.SetRange("Production BOM No.", Item."Production BOM No.");
            ProductionBOMLine.SetFilter("Version Code", '=%1', '');
            if ProductionBOMLine.Find('-') then
                repeat
                    //CheckType(ProductionBOMLine);
                    InsertItems2(ProductionBOMLine);
                until ProductionBOMLine.Next = 0;
        end;
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
                            CheckType2(ProductionBOMLine1);
                        until ProductionBOMLine1.Next = 0;
                end;
            ProductionBOMLine.Type::Item:
                begin
                    InsertItems2(ProductionBOMLine);
                end;
        end;
    end;


    procedure InsertItems(var ProductionBOMLine: Record "Production BOM Line");
    var
        DesignWorksheet: Record "Item Design Worksheet Line";
        DesignWorksheet1: Record "Item Design Worksheet Line";
        SMDSolder: Decimal;
        DIPSolder: Decimal;
        Cost: Decimal;
        ProductionBomLineCost: Record "Production BOM Line";
        BomItem: Record Item;
        Cost1: Decimal;
        Cost2: Decimal;
        ProductionBomLineSolder: Record "Production BOM Line";
        ProdBOMHeader: Record "Production BOM Header";
        RoutingHeader: Record "Routing Header";
    begin
        ManufacturingSetup.Get;
        DesignWorksheet.Init;
        DesignWorksheet."Item No" := "Item No";
        DesignWorksheet."Line No." := ProductionBOMLine."Line No.";
        if ProductionBOMLine.Type = ProductionBOMLine.Type::Item then
            DesignWorksheet.Type := DesignWorksheet.Type::Item
        else
            if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then
                DesignWorksheet.Type := DesignWorksheet.Type::"Production BOM";
        DesignWorksheet."No." := ProductionBOMLine."No.";
        DesignWorksheet.Description := ProductionBOMLine.Description;
        DesignWorksheet."Unit of Measure" := ProductionBOMLine."Unit of Measure Code";
        DesignWorksheet.Quantity := ProductionBOMLine."Quantity per";

        if Item.Get(DesignWorksheet."No.") then;
        if Item."Production BOM No." = '' then begin
            DesignWorksheet."Unit Cost" := Item."Avg Unit Cost";
            if ProductionBOMLine."Type of Solder" = ProductionBOMLine."Type of Solder"::SMD then
                DesignWorksheet."No.of SMD Points" := ProductionBOMLine."No. of Soldering Points"
            else
                DesignWorksheet."No.of DIP Points" := ProductionBOMLine."No. of Soldering Points";
        end else begin
            ProdBOMHeader.Reset;
            if ProdBOMHeader.Get(Item."Production BOM No.") then;
            ProdBOMHeader.CalcFields(ProdBOMHeader."BOM Cost");
            DesignWorksheet."Unit Cost" := ProdBOMHeader."BOM Cost";
            ProductionBomLineSolder.SetRange("Production BOM No.", Item."Production BOM No.");
            if ProductionBomLineSolder.Find('-') then
                repeat
                    if BomItem.Get(ProductionBomLineSolder."No.") then
                        if BomItem."Type of Solder" = BomItem."Type of Solder"::SMD then
                            SMDSolder := SMDSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                    if BomItem."Type of Solder" = BomItem."Type of Solder"::DIP then
                        DIPSolder := DIPSolder + (BomItem."No. of Soldering Points" * ProductionBomLineSolder."Quantity per");
                until ProductionBomLineSolder.Next = 0;
            DesignWorksheet."No.of SMD Points" := SMDSolder;
            DesignWorksheet."No.of DIP Points" := DIPSolder;
        end;
        if Item."Routing No." <> '' then begin
            RoutingHeader.Reset;
            if RoutingHeader.Get(Item."Routing No.") then;
            RoutingHeader.CalcFields(RoutingHeader."Man Cost");
            DesignWorksheet."Manufacturing Cost" := RoutingHeader."Man Cost";
        end;
        DesignWorksheet.Amount := DesignWorksheet."Unit Cost" * DesignWorksheet.Quantity;
        DesignWorksheet."Total Manufacturing Cost" := DesignWorksheet."Manufacturing Cost" * DesignWorksheet.Quantity;
        if ProductionBOMLine.Type = ProductionBOMLine.Type::"Production BOM" then begin
            if ProdBOMHeader.Get(DesignWorksheet."No.") then
                ProdBOMHeader.CalcFields(ProdBOMHeader."BOM Cost", ProdBOMHeader."BOM Manufacturing Cost");
            DesignWorksheet."Unit Cost" := ProdBOMHeader."BOM Cost";
            DesignWorksheet."Manufacturing Cost" := ProdBOMHeader."BOM Manufacturing Cost";
            DesignWorksheet."Total Manufacturing Cost" := DesignWorksheet."Manufacturing Cost" * DesignWorksheet.Quantity;
            DesignWorksheet.Amount := ProdBOMHeader."BOM Cost";
        end;

        DesignWorksheet."Total time in Hours" := (DesignWorksheet."No.of SMD Points" *
           ManufacturingSetup."Soldering Time Req.for BID") + (DesignWorksheet."No.of DIP Points"
           * ManufacturingSetup."Soldering Time Req.for DIP");
        DesignWorksheet.Insert;
    end;
}

