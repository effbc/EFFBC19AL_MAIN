table 60017 "Service Invoice Line Archive"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Service Item Line No."; Integer)
        {
            Caption = 'Service Item Line No.';
            TableRelation = "Service Item Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."));
            DataClassification = CustomerContent;
        }
        field(4; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";
            DataClassification = CustomerContent;
        }
        field(5; "Service Item Serial No."; Code[20])
        {
            Caption = 'Service Item Serial No.';
            DataClassification = CustomerContent;
        }
        field(6; "Service Item Description"; Text[100])
        {
            CalcFormula = Lookup("Service Item Line".Description WHERE("Document Type" = FIELD("Document Type"),
                                                                        "Document No." = FIELD("Document No."),
                                                                        "Line No." = FIELD("Service Item Line No.")));
            Caption = 'Service Item Description';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Confirmation: Boolean;
            begin
            end;
        }
        field(8; "Order Date"; Date)
        {
            Caption = 'Order Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '" ,Item,Resource,Cost"';
            OptionMembers = " ",Item,Resource,Cost;
            DataClassification = CustomerContent;
        }
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST(Cost)) "Service Cost";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ShowLocMessage: Boolean;
            begin
            end;
        }
        field(11; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(12; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
            DataClassification = CustomerContent;
        }
        field(13; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(14; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            DataClassification = CustomerContent;
        }
        field(15; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
            DataClassification = CustomerContent;
        }
        field(17; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(18; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(19; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(20; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                UnitOfMeasureTranslation: Record "Unit of Measure Translation";
            begin
            end;
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(23; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group";
            DataClassification = CustomerContent;
        }
        field(24; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(25; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            DataClassification = CustomerContent;
        }
        field(26; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;
            InitValue = false;
            DataClassification = CustomerContent;
        }
        field(28; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";
            DataClassification = CustomerContent;
        }
        field(29; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";
            DataClassification = CustomerContent;
        }
        field(30; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";
            DataClassification = CustomerContent;
        }
        field(31; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
            DataClassification = CustomerContent;
        }
        field(32; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
            DataClassification = CustomerContent;
        }
        field(33; "Exclude Warranty"; Boolean)
        {
            Caption = 'Exclude Warranty';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(34; Warranty; Boolean)
        {
            Caption = 'Warranty';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(35; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job."No." WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(36; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            Editable = false;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
            DataClassification = CustomerContent;
        }
        field(38; "Contract Disc. %"; Decimal)
        {
            Caption = 'Contract Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(39; "Warranty Disc. %"; Decimal)
        {
            Caption = 'Warranty Disc. %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(43; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(44; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(45; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            DataClassification = CustomerContent;
        }
        field(46; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(47; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(48; "VAT Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(49; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Including VAT';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(52; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(53; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(54; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
            DataClassification = CustomerContent;
        }
        field(55; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            Editable = false;
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(56; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(57; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(58; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(59; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(60; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)';
            DataClassification = CustomerContent;
        }
        field(61; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(62; "Total Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(63; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(65; "Component Line No."; Integer)
        {
            Caption = 'Component Line No.';
            DataClassification = CustomerContent;
        }
        field(66; "Spare Part Action"; Option)
        {
            Caption = 'Spare Part Action';
            OptionCaption = '" ,Permanent,Temporary,Component Replaced,Component Installed"';
            OptionMembers = " ",Permanent,"Temporary","Component Replaced","Component Installed";
            DataClassification = CustomerContent;
        }
        field(67; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";
            DataClassification = CustomerContent;
        }
        field(68; "Replaced Item No."; Code[20])
        {
            Caption = 'Replaced Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(69; "Exclude Contract Discount"; Boolean)
        {
            Caption = 'Exclude Contract Discount';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(71; "Document Type"; Enum "Service Document Type")
        {
           
            Editable = false;

        }
        field(73; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code';
            TableRelation = "Work Type";
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
        field(76; Chargeable; Boolean)
        {
            Caption = 'Chargeable';
            DataClassification = CustomerContent;
        }
        field(78; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(79; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(81; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.';
            Editable = false;
            //TableRelation = "Service Line"."Customer No." WHERE(Field71 = FIELD("Document Type"),"Document Type" = FIELD("Document No."));// Issue in nav 2016 itself
            DataClassification = CustomerContent;
        }
        field(82; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category".Code;
            DataClassification = CustomerContent;
        }
        field(83; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(84; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
            DataClassification = CustomerContent;
        }
        field(85; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(86; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(87; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            DataClassification = CustomerContent;
        }
        field(88; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(89; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry"."Quantity (Base)" WHERE("Source Type" = CONST(5902),
                                                                            "Source Subtype" = FIELD("Document Type"),
                                                                            "Source ID" = FIELD("Document No."),
                                                                            "Source Ref. No." = FIELD("Line No."),
                                                                            "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Reserved Quantity"; Decimal)
        {
            CalcFormula = - Sum("Reservation Entry".Quantity WHERE("Source Type" = CONST(5902),
                                                                   "Source Subtype" = FIELD("Document Type"),
                                                                   "Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
        }
        field(92; "Apply to Service Entry"; Integer)
        {
            Caption = 'Apply to Service Entry';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(93; "Substitution Available"; Boolean)
        {
            Caption = 'Substitution Available';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(94; "Price Adjmt. Status"; Option)
        {
            Caption = 'Price Adjmt. Status';
            Editable = false;
            OptionCaption = '" ,Adjusted,Modified"';
            OptionMembers = " ",Adjusted,Modified;
            DataClassification = CustomerContent;
        }
        field(97; "Line Discount Type"; Option)
        {
            Caption = 'Line Discount Type';
            Editable = false;
            OptionCaption = '" ,Warranty Disc.,Contract Disc.,Line Disc.,Manual"';
            OptionMembers = " ","Warranty Disc.","Contract Disc.","Line Disc.",Manual;
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            DataClassification = CustomerContent;
        }
        field(7002; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(60001; "Version No."; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(60002; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(60003; "Resolution Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60004; "Fault Code Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60005; "Fault Area Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
        field(60006; "Symptom Description"; Text[50])
        {
            Description = 'Editable=No';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

