table 60057 "TO Material Issue Line"
{
    Caption = 'Transfer Line';
    DrillDownPageID = "Transfer Lines";
    LookupPageID = "Transfer Lines";
    PasteIsValid = false;
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
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TempTransferLine: Record "Transfer Line" temporary;
                Location: Record Location;
            begin
                //GetTransHeader;
                Item.Get("Item No.");
                Item.TestField(Blocked, false);
                Validate(Description, Item.Description);
                Validate("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
                Validate("Inventory Posting Group", Item."Inventory Posting Group");
                Validate("Unit of Measure Code", Item."Base Unit of Measure");
                Validate("Gross Weight", Item."Gross Weight");
                Validate("Net Weight", Item."Net Weight");
                Validate("Unit Volume", Item."Unit Volume");
                Validate("Units per Parcel", Item."Units per Parcel");
                Validate("Description 2", Item."Description 2");
                Validate("Shelf No.", Item."Shelf No.");
            end;
        }
        field(4; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 5 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TransferHeader: Record "Transfer Header";
                Location: Record Location;
            begin
            end;
        }
        field(5; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
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
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(14; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(15; "Inventory Posting Group"; Code[10])
        {
            Caption = 'Inventory Posting Group';
            TableRelation = "Inventory Posting Group";
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
            end;
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
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(37; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Editable = false;
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(38; "Posting Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(40; "Derived From Line No."; Integer)
        {
            Caption = 'Derived From Line No.';
            TableRelation = "Transfer Line"."Line No." WHERE("Document No." = FIELD("Document No."));
            DataClassification = CustomerContent;
        }
        field(60000; "Position Reference No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60003; "Allow Excess Qty."; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "Shelf No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Production BOM No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;
        }
        field(60006; "Type of Material"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ",Good,Damaged;
            DataClassification = CustomerContent;
        }
        field(60007; "Reason Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60008; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
            Description = 'B2B';
            Editable = false;
            TableRelation = "Prod. Order Component"."Line No." WHERE(Status = CONST(Released),
                                                                      "Prod. Order No." = FIELD("Prod. Order No."),
                                                                      "Prod. Order Line No." = FIELD("Prod. Order Line No."));
            DataClassification = CustomerContent;
        }
        field(60009; Inventory; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No."),
                                                                  Open = CONST(true),
                                                                  "Location Code" = FIELD("Transfer-from Code")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60100; Copy; Boolean)
        {
            Description = 'B2B-Internal field used for Allow excess Qty. field Validations';
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
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
    end;

    trigger OnInsert();
    var
        TransLine2: Record "Transfer Line";
    begin
    end;

    var
        Item: Record Item;
        TransHeader: Record "Transfer Header";


    local procedure GetTransHeader();
    begin
        TestField("Document No.");
        if ("Document No." <> TransHeader."No.") then
            TransHeader.Get("Document No.");
        TransHeader.TestField("Transfer-from Code");
        TransHeader.TestField("Transfer-to Code");
        "Transfer-from Code" := TransHeader."Transfer-from Code";
        "Transfer-to Code" := TransHeader."Transfer-to Code";
        Status := TransHeader.Status;
    end;
}

