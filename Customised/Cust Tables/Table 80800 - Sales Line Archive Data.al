table 80800 "Sales Line Archive Data"
{
    // version NAVW16.00,NAVIN6.00,DIM1.0

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                              DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13           ->Code has been Commented in the ShowDimensions() because Dimension Tables does not exist in the
    //                                                              NAV 2013 Instead of that code new Code is added for shows the data from the database against the Dimension Set ID.

    Caption = 'Sales Line Archive';
    PasteIsValid = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';

            DataClassification = CustomerContent;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Header Archive"."No." WHERE("Document Type" = FIELD("Document Type"),
                                                                "Version No." = FIELD("Version No."));
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '" ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)"';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
            DataClassification = CustomerContent;
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge";
            DataClassification = CustomerContent;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(8; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
            DataClassification = CustomerContent;
        }
        field(9; "Quantity Disc. Code"; Code[20])
        {
            Caption = 'Quantity Disc. Code';
            DataClassification = CustomerContent;
        }
        field(10; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(11; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[250])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            Caption = 'Qty. to Ship';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FieldNo("Unit Price"));
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = CustomerContent;
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(26; "Quantity Disc. %"; Decimal)
        {
            Caption = 'Quantity Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            DataClassification = CustomerContent;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            DataClassification = CustomerContent;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
            DataClassification = CustomerContent;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(42; "Price Group Code"; Code[10])
        {
            Caption = 'Price Group Code';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(43; "Allow Quantity Disc."; Boolean)
        {
            Caption = 'Allow Quantity Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
            DataClassification = CustomerContent;
        }
        field(55; "Cust./Item Disc. %"; Decimal)
        {
            Caption = 'Cust./Item Disc. %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced';
            DataClassification = CustomerContent;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            Caption = 'Quantity Shipped';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            DataClassification = CustomerContent;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.';
            DataClassification = CustomerContent;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount';
            DataClassification = CustomerContent;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            Caption = 'Purch. Order Line No.';
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Purchase Order No."));
            DataClassification = CustomerContent;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            DataClassification = CustomerContent;
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            TableRelation = "Sales Line Archive"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                   "Document No." = FIELD("Document No."),
                                                                   "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                                                   "Version No." = FIELD("Version No."));
            DataClassification = CustomerContent;
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(87; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(89; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(90; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY)';
            DataClassification = CustomerContent;
        }
        field(96; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            Caption = 'Blanket Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            Caption = 'Blanket Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            DataClassification = CustomerContent;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            DataClassification = CustomerContent;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice';
            DataClassification = CustomerContent;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            Caption = 'IC Partner Ref. Type';
            OptionCaption = '" ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No."';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";
            DataClassification = CustomerContent;
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            Caption = 'IC Partner Reference';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ICGLAccount: Record "IC G/L Account";
                ItemCrossReference: Record "Item Cross Reference";
            begin
            end;
        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
            begin
            end;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Prepmt. Line Amount"));
            Caption = 'Prepmt. Line Amount';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Prepmt. Amt. Inv."));
            Caption = 'Prepmt. Amt. Inv.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            DataClassification = CustomerContent;
        }
        field(117; "Prepayment VAT Identifier"; Code[10])
        {
            Caption = 'Prepayment VAT Identifier';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable';
            DataClassification = CustomerContent;
        }
        field(120; "Prepayment Tax Group Code"; Code[10])
        {
            Caption = 'Prepayment Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt to Deduct"));
            Caption = 'Prepmt Amt to Deduct';
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
            // ApplMgt: Codeunit ApplicationManagement;
            begin
            end;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt Deducted"));
            Caption = 'Prepmt Amt Deducted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code';
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            CaptionML = ENU = 'Dimension Set ID',
                        ENN = 'Dimension Set ID';
            Description = 'DIM1.0';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                ShowDimensions;
            end;
        }
        field(5047; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            DataClassification = CustomerContent;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned';
            DataClassification = CustomerContent;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List';
            DataClassification = CustomerContent;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
            DataClassification = CustomerContent;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist("Item Substitution" WHERE(Type = CONST(Item),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST(Item)));
            Caption = 'Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = IF (Type = CONST(Item)) Item;
            DataClassification = CustomerContent;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
            DataClassification = CustomerContent;
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
            DataClassification = CustomerContent;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            Caption = 'Unit of Measure (Cross Ref.)';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type';
            OptionCaption = '" ,Customer,Vendor,Bar Code"';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
            DataClassification = CustomerContent;
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.';
            DataClassification = CustomerContent;
        }
        field(5709; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
            DataClassification = CustomerContent;
        }
        field(5710; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            DataClassification = CustomerContent;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
            DataClassification = CustomerContent;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(5713; "Special Order"; Boolean)
        {
            Caption = 'Special Order';
            DataClassification = CustomerContent;
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            Caption = 'Special Order Purchase No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            Caption = 'Special Order Purch. Line No.';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Special Order Purchase No."));
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped';
            DataClassification = CustomerContent;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            Caption = 'Promised Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            Caption = 'Shipping Time';
            DataClassification = CustomerContent;
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            Caption = 'Outbound Whse. Handling Time';
            DataClassification = CustomerContent;
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            Caption = 'Planned Delivery Date';
            DataClassification = CustomerContent;
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            Caption = 'Planned Shipment Date';
            DataClassification = CustomerContent;
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            Caption = 'Allow Item Charge Assignment';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            Caption = 'Return Qty. to Receive';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5807; "Return Amt. Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Amt. Rcd. Not Invd.';
            DataClassification = CustomerContent;
        }
        field(5808; "Ret. Amt. Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Ret. Amt. Rcd. Not Invd. (LCY)';
            DataClassification = CustomerContent;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            Caption = 'Return Qty. Received';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5900; "Service Contract No."; Code[20])
        {
            Caption = 'Service Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                            "Customer No." = FIELD("Sell-to Customer No."),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(5901; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
            DataClassification = CustomerContent;
        }
        field(5902; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No." WHERE("Customer No." = FIELD("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(5903; "Appl.-to Service Entry"; Integer)
        {
            Caption = 'Appl.-to Service Entry';
            DataClassification = CustomerContent;
        }
        field(5904; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            DataClassification = CustomerContent;
        }
        field(5907; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            TableRelation = "Service Price Adjustment Group";
            DataClassification = CustomerContent;
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            DataClassification = CustomerContent;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.';
            DataClassification = CustomerContent;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(13701; "Tax Amount"; Decimal)
        {
            Caption = 'Tax Amount';
            DecimalPlaces = 0 : 4;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13702; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            // TableRelation = "Excise Bus. Posting Group";
            DataClassification = CustomerContent;
        }
        field(13703; "Excise Prod. Posting Group"; Code[10])
        {
            Caption = 'Excise Prod. Posting Group';
            // TableRelation = "Excise Prod. Posting Group";
            DataClassification = CustomerContent;
        }
        field(13708; "Excise Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Excise';
            DataClassification = CustomerContent;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Excise Base Amount';
            DataClassification = CustomerContent;
        }
        field(13715; "Excise Accounting Type"; Option)
        {
            Caption = 'Excise Accounting Type';
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
            DataClassification = CustomerContent;
        }
        field(13719; "Excise Base Quantity"; Decimal)
        {
            Caption = 'Excise Base Quantity';
            DataClassification = CustomerContent;
        }
        field(13721; "Tax %"; Decimal)
        {
            Caption = 'Tax %';
            DecimalPlaces = 0 : 2;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13722; "Amount Including Tax"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including Tax';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13724; "Amount Added to Excise Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Excise Base';
            DataClassification = CustomerContent;
        }
        field(13725; "Amount Added to Tax Base"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Added to Tax Base';
            DataClassification = CustomerContent;
        }
        field(13727; "Tax Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Tax Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13734; "Surcharge %"; Decimal)
        {
            Caption = 'Surcharge %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13735; "Surcharge Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Surcharge Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13736; "Concessional Code"; Code[10])
        {
            Caption = 'Concessional Code';
            // TableRelation = "Concessional Codes";
            DataClassification = CustomerContent;
        }
        field(13742; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            Editable = false;
            TableRelation = "Assessee Code";
            DataClassification = CustomerContent;
        }
        field(13743; "TDS %"; Decimal)
        {
            Caption = 'TDS %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13746; "Bal. TDS Including SHE CESS"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. TDS Including SHE CESS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13749; "Claim Deferred Excise"; Boolean)
        {
            Caption = 'Claim Deferred Excise';
            DataClassification = CustomerContent;
        }
        field(13750; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13755; "BED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'BED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13758; "AED(GSI) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(GSI) Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13759; "SED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13769; "SAED Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SAED Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'CESS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'NCCD Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'eCess Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13796; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
            // StateForm: Record "State Forms";
            //  StateForms: Page "State Forms";
            begin
            end;
        }
        field(13797; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            DataClassification = CustomerContent;
        }
        field(13798; State; Code[10])
        {
            Caption = 'State';
            TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(13799; "TDS Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'TDS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16340; "Amount To Customer"; Decimal)
        {
            Caption = 'Amount To Customer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16342; "Charges To Customer"; Decimal)
        {
            Caption = 'Charges To Customer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16343; "TDS Base Amount"; Decimal)
        {
            Caption = 'TDS Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16363; "Surcharge Base Amount"; Decimal)
        {
            Caption = 'Surcharge Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16367; "Temp TDS Base"; Decimal)
        {
            Caption = 'Temp TDS Base';
            DataClassification = CustomerContent;
        }
        field(16377; "Service Tax Group"; Code[20])
        {
            Caption = 'Service Tax Group';
            //  TableRelation = "Service Tax Groups".Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16379; "Service Tax Base"; Decimal)
        {
            Caption = 'Service Tax Base';
            DataClassification = CustomerContent;
        }
        field(16380; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
            DataClassification = CustomerContent;
        }
        field(16381; "Service Tax Registration No."; Code[20])
        {
            Caption = 'Service Tax Registration No.';
            // TableRelation = "Service Tax Registration Nos.".Code;
            DataClassification = CustomerContent;
        }
        field(16383; "eCESS % on TDS"; Decimal)
        {
            Caption = 'eCESS % on TDS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16384; "eCESS on TDS Amount"; Decimal)
        {
            Caption = 'eCESS on TDS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16385; "Total TDS Including SHE CESS"; Decimal)
        {
            Caption = 'Total TDS Including SHE CESS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16386; "Per Contract"; Boolean)
        {
            Caption = 'Per Contract';
            DataClassification = CustomerContent;
        }
        field(16391; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
            DataClassification = CustomerContent;
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16455; "AED(TTA) Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'AED(TTA) Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16456; "Free Supply"; Boolean)
        {
            Caption = 'Free Supply';
            DataClassification = CustomerContent;
        }
        field(16459; "ADE Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16490; "Assessable Value"; Decimal)
        {
            Caption = 'Assessable Value';
            DataClassification = CustomerContent;
        }
        field(16494; "SHE Cess Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'SHE Cess Amount';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(16496; "Service Tax SHE Cess Amount"; Decimal)
        {
            Caption = 'Service Tax SHE Cess Amount';
            DataClassification = CustomerContent;
        }
        field(16500; "Direct Debit To PLA / RG"; Boolean)
        {
            Caption = 'Direct Debit To PLA / RG';
            DataClassification = CustomerContent;
        }
        field(16519; Supplementary; Boolean)
        {
            Caption = 'Supplementary';
            DataClassification = CustomerContent;
        }
        field(16520; "Source Document Type"; Option)
        {
            Caption = 'Source Document Type';
            OptionCaption = 'Posted Invoice,Posted Credit Memo';
            OptionMembers = "Posted Invoice","Posted Credit Memo";
            DataClassification = CustomerContent;
        }
        field(16521; "Source Document No."; Code[20])
        {
            Caption = 'Source Document No.';
            TableRelation = IF ("Source Document Type" = FILTER("Posted Invoice")) "Purch. Inv. Header"."No."
            ELSE
            IF ("Source Document Type" = FILTER("Posted Credit Memo")) "Purch. Cr. Memo Hdr."."No.";
            DataClassification = CustomerContent;
        }
        field(16528; "Process Carried Out"; Code[10])
        {
            Caption = 'Process Carried Out';
            //  TableRelation = "Process Carried Out".Code;
            DataClassification = CustomerContent;
        }
        field(16529; "Identification Mark"; Text[30])
        {
            Caption = 'Identification Mark';
            DataClassification = CustomerContent;
        }
        field(16530; "Re-Dispatch"; Boolean)
        {
            Caption = 'Re-Dispatch';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16531; "Return Rcpt line No."; Integer)
        {
            Caption = 'Return Rcpt line No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16532; "Qty. to be Re-Dispatched"; Decimal)
        {
            Caption = 'Qty. to be Re-Dispatched';
            DataClassification = CustomerContent;
        }
        field(16533; "Return Re-Dispatch Rcpt. No."; Code[20])
        {
            Caption = 'Return Re-Dispatch Rcpt. No.';
            DataClassification = CustomerContent;
        }
        field(16534; "SHE Cess % on TDS/TCS"; Decimal)
        {
            Caption = 'SHE Cess % on TDS/TCS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16535; "SHE Cess on TDS/TCS Amount"; Decimal)
        {
            Caption = 'SHE Cess on TDS/TCS Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16537; "MRP Price"; Decimal)
        {
            Caption = 'MRP Price';
            DataClassification = CustomerContent;
        }
        field(16538; MRP; Boolean)
        {
            Caption = 'MRP';
            DataClassification = CustomerContent;
        }
        field(16539; "Abatement %"; Decimal)
        {
            Caption = 'Abatement %';
            DataClassification = CustomerContent;
        }
        field(16540; "PIT Structure"; Code[10])
        {
            Caption = 'PIT Structure';
            //   TableRelation = "Structure Header";
            DataClassification = CustomerContent;
        }
        field(16541; "Price Inclusive of Tax"; Boolean)
        {
            Caption = 'Price Inclusive of Tax';
            DataClassification = CustomerContent;
        }
        field(16542; "Unit Price Incl. of Tax"; Decimal)
        {
            Caption = 'Unit Price Incl. of Tax';
            DataClassification = CustomerContent;
        }
        field(16545; "Amount To Customer UPIT"; Decimal)
        {
            Caption = 'Amount To Customer UPIT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16546; "UPIT Rounding Inserted"; Boolean)
        {
            Caption = 'UPIT Rounding Inserted';
            DataClassification = CustomerContent;
        }
        field(16552; "Excise Effective Rate"; Decimal)
        {
            Caption = 'Excise Effective Rate';
            DataClassification = CustomerContent;
        }
        field(60012; "Schedule Type"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,A,B"';
            OptionMembers = " ",A,B;
            DataClassification = CustomerContent;
        }
        field(80000; "% of Excise Applicable 2"; Decimal)
        {
            InitValue = 100;
            DataClassification = CustomerContent;
        }
        field(80001; "VAT Business Posting Group 2"; Code[10])
        {
            Editable = false;
            //TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(80003; "Service Tax % 2"; Decimal)
        {
            Caption = 'Service Tax %';
            DataClassification = CustomerContent;
        }
        field(80004; "Service Tax eCess % 2"; Decimal)
        {
            Caption = 'Service Tax eCess %';
            DataClassification = CustomerContent;
        }
        field(80005; "VAT Product Posting Group 2"; Code[10])
        {
            Editable = false;
            // TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(80006; "VAT %age 2"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80007; "VAT Base 2"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80008; "VAT Amount 2"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80009; "Excise % 2"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80010; "Excise Calculation Type 2"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(80011; "eCess % / Amount 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        }
        key(Key2; "Document Type", "Document No.", "Line No.", "Doc. No. Occurrence", "Version No.")
        {
        }
        key(Key3; "Sell-to Customer No.")
        {
        }
        key(Key4; "Bill-to Customer No.")
        {
        }
        key(Key5; Type, "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        SalesCommentLinearch: Record "Sales Comment Line Archive";
    begin
        SalesCommentLinearch.SetRange("Document Type", "Document Type");
        SalesCommentLinearch.SetRange("No.", "Document No.");
        SalesCommentLinearch.SetRange("Document Line No.", "Line No.");
        SalesCommentLinearch.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        SalesCommentLinearch.SetRange("Version No.", "Version No.");
        if not SalesCommentLinearch.IsEmpty then
            SalesCommentLinearch.DeleteAll;
    end;


    local procedure GetCaptionClass(FieldNumber: Integer): Text[80];
    var
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        if not SalesHeaderArchive.Get("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.") then begin
            SalesHeaderArchive."No." := '';
            SalesHeaderArchive.Init;
        end;
        if SalesHeaderArchive."Prices Including VAT" then
            exit('2,1,' + GetFieldCaption(FieldNumber))
        else
            exit('2,0,' + GetFieldCaption(FieldNumber));
    end;


    local procedure GetFieldCaption(FieldNumber: Integer): Text[100];
    var
        "Field": Record "Field";
    begin
        Field.Get(DATABASE::"Sales Line", FieldNumber);
        exit(Field."Field Caption");
    end;


    procedure ShowDimensions();
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        //DIM1.0 Start
        //Code Comment
        /*
        //Deleted Local Var(DocDimArchiveRecordTable5106), Commented Code B2b
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        DocDimArchive.SETRANGE("Table ID",DATABASE::"Sales Line Archive");
        DocDimArchive.SETRANGE("Document Type","Document Type");
        DocDimArchive.SETRANGE("Document No.","Document No.");
        DocDimArchive.SETRANGE("Line No.","Line No.");
        DocDimArchive.SETRANGE("Version No.","Version No.");
        DocDimensionsArchive.SETTABLEVIEW(DocDimArchive);
        DocDimensionsArchive.RUNMODAL;
        */

        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "Document Type", "Document No.", "Line No."));
        //DIM1.0 End

    end;


    procedure ShowLineComments();
    var
        SalesCommentLineArch: Record "Sales Comment Line Archive";
        SalesArchCommentSheet: Page "Sales Archive Comment Sheet";
    begin
        SalesCommentLineArch.SetRange("Document Type", "Document Type");
        SalesCommentLineArch.SetRange("No.", "Document No.");
        SalesCommentLineArch.SetRange("Document Line No.", "Line No.");
        SalesCommentLineArch.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        SalesCommentLineArch.SetRange("Version No.", "Version No.");
        SalesArchCommentSheet.SetTableView(SalesCommentLineArch);
        SalesArchCommentSheet.RunModal;
    end;
}

