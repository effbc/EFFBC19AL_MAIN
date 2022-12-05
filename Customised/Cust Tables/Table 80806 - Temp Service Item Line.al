table 80806 "Temp Service Item Line"
{
    DataClassification = CustomerContent;
    // version B2Bupg


    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
            TableRelation = "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            TableRelation = "Service Item"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Cust: Record Customer;
                ServContractList: Page "Serv. Contr. List (Serv. Item)";
            begin
            end;
        }
        field(4; "Service Item Group Code"; Code[10])
        {
            Caption = 'Service Item Group Code';
            TableRelation = "Service Item Group".Code;
            DataClassification = CustomerContent;
        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
            DataClassification = CustomerContent;
        }
        field(6; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(8; "Description 2"; Text[30])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
        }
        field(9; "Repair Status Code"; Code[10])
        {
            Caption = 'Repair Status Code';
            TableRelation = "Repair Status";
            DataClassification = CustomerContent;
        }
        field(10; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
        }
        field(11; "Response Time (Hours)"; Decimal)
        {
            Caption = 'Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(12; "Response Date"; Date)
        {
            Caption = 'Response Date';
            DataClassification = CustomerContent;
        }
        field(13; "Response Time"; Time)
        {
            Caption = 'Response Time';
            DataClassification = CustomerContent;
        }
        field(14; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(15; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(16; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';
            DataClassification = CustomerContent;
        }
        field(17; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';
            DataClassification = CustomerContent;
        }
        field(18; "Service Shelf No."; Code[10])
        {
            Caption = 'Service Shelf No.';
            TableRelation = "Service Shelf";
            DataClassification = CustomerContent;
        }
        field(19; "Warranty Starting Date (Parts)"; Date)
        {
            Caption = 'Warranty Starting Date (Parts)';
            DataClassification = CustomerContent;
        }
        field(20; "Warranty Ending Date (Parts)"; Date)
        {
            Caption = 'Warranty Ending Date (Parts)';
            DataClassification = CustomerContent;
        }
        field(21; Warranty; Boolean)
        {
            Caption = 'Warranty';
            DataClassification = CustomerContent;
        }
        field(22; "Warranty % (Parts)"; Decimal)
        {
            Caption = 'Warranty % (Parts)';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(23; "Warranty % (Labor)"; Decimal)
        {
            Caption = 'Warranty % (Labor)';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(24; "Warranty Starting Date (Labor)"; Date)
        {
            Caption = 'Warranty Starting Date (Labor)';
            DataClassification = CustomerContent;
        }
        field(25; "Warranty Ending Date (Labor)"; Date)
        {
            Caption = 'Warranty Ending Date (Labor)';
            DataClassification = CustomerContent;
        }
        field(26; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ServHeader: Record "Service Header";
                ServContractLine: Record "Service Contract Line";
                ServContractList: Page "Serv. Contr. List (Serv. Item)";
            begin
            end;
        }
        field(27; "Location of Service Item"; Text[30])
        {
            CalcFormula = Lookup("Service Item"."Location of Service Item" WHERE("No." = FIELD("Service Item No.")));
            Caption = 'Location of Service Item';
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; "Loaner No."; Code[20])
        {
            Caption = 'Loaner No.';
            TableRelation = Loaner."No.";
            DataClassification = CustomerContent;
        }
        field(29; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(30; "Vendor Item No."; Text[20])
        {
            Caption = 'Vendor Item No.';
            DataClassification = CustomerContent;
        }
        field(31; "Fault Reason Code"; Code[10])
        {
            Caption = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";
            DataClassification = CustomerContent;
        }
        field(32; "Service Price Group Code"; Code[10])
        {
            Caption = 'Service Price Group Code';
            TableRelation = "Service Price Group";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ServPriceGrSetup: Record "Serv. Price Group Setup";
                ServPriceMgmt: Codeunit "Service Price Management";
            begin
            end;
        }
        field(33; "Fault Area Code"; Code[10])
        {
            Caption = 'Fault Area Code';
            TableRelation = "Fault Area";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ServPriceMgmt: Codeunit "Service Price Management";
                FaultArea: Record "Fault Area";
            begin
            end;
        }
        field(34; "Symptom Code"; Code[10])
        {
            Caption = 'Symptom Code';
            TableRelation = "Symptom Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                SymptomCode: Record "Symptom Code";
            begin
            end;
        }
        field(35; "Fault Code"; Code[10])
        {
            Caption = 'Fault Code';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                FaultCode: Record "Fault Code";
            begin
            end;
        }
        field(36; "Resolution Code"; Code[10])
        {
            Caption = 'Resolution Code';
            TableRelation = "Resolution Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ResolutionCode: Record "Resolution Code";
            begin
            end;
        }
        field(37; "Fault Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST(Fault),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Fault Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Resolution Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST(Resolution),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Resolution Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
            DataClassification = CustomerContent;
        }
        field(41; "Service Item Loaner Comment"; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("Document No."),
                                                              Type = CONST("Service Item Loaner"),
                                                              "Table Line No." = FIELD("Line No.")));
            Caption = 'Service Item Loaner Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(43; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            Editable = false;

            DataClassification = CustomerContent;
        }
        field(44; "Serv. Price Adjmt. Gr. Code"; Code[10])
        {
            Caption = 'Serv. Price Adjmt. Gr. Code';
            Editable = false;
            TableRelation = "Service Price Adjustment Group";
            DataClassification = CustomerContent;
        }
        field(45; "Adjustment Type"; Option)
        {
            Caption = 'Adjustment Type';
            Editable = false;
            OptionCaption = 'Fixed,Maximum,Minimum';
            OptionMembers = "Fixed",Maximum,Minimum;
            DataClassification = CustomerContent;
        }
        field(46; "Base Amount to Adjust"; Decimal)
        {
            Caption = 'Base Amount to Adjust';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60; "No. of Active/Finished Allocs"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."),
                                                                  "Service Item Line No." = FIELD("Line No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Allocation Date" = FIELD("Allocation Date Filter"),
                                                                  Status = FILTER(Active | Finished)));
            Caption = 'No. of Active/Finished Allocs';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "No. of Allocations"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE(Status = FIELD("Allocation Status Filter"),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("Document No."),
                                                                  "Service Item Line No." = FIELD("Line No.")));
            Caption = 'No. of Allocations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "No. of Previous Services"; Integer)
        {
            Caption = 'No. of Previous Services';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(63; "Contract line No."; Integer)
        {
            Caption = 'Contract line No.';
            TableRelation = "Service Contract Line"."Line No." WHERE("Contract Type" = CONST(Contract),
                                                                      "Contract No." = FIELD("Contract No."));
            DataClassification = CustomerContent;
        }
        field(64; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code;
            DataClassification = CustomerContent;
        }
        field(65; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            Editable = false;
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(91; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(92; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(93; "Allocation Date Filter"; Date)
        {
            Caption = 'Allocation Date Filter';
            FieldClass = FlowFilter;
        }
        field(94; "Repair Status Code Filter"; Code[10])
        {
            Caption = 'Repair Status Code Filter';
            FieldClass = FlowFilter;
            TableRelation = "Repair Status".Code;
        }
        field(96; "Allocation Status Filter"; Option)
        {
            Caption = 'Allocation Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Nonactive,Active,Finished,Canceled,Reallocation Needed';
            OptionMembers = Nonactive,Active,Finished,Canceled,"Reallocation Needed";
        }
        field(97; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(98; "Service Order Filter"; Code[20])
        {
            Caption = 'Service Order Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Header"."No.";
        }
        field(99; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
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
        field(60010; "From Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'));
            DataClassification = CustomerContent;
        }
        field(60011; "To Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'));
            DataClassification = CustomerContent;
        }
        field(60012; Account; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60030; "Countrol Section"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60031; "N/W Stand Alone"; Option)
        {
            OptionMembers = " ","Stand Alone","Network  ";
            DataClassification = CustomerContent;
        }
        field(60032; IDNO; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60033; "F/W Version"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60034; "S/W Version"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60035; "H/W Process Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60036; "Operating Voltage"; Option)
        {
            OptionMembers = " ","24 VDC","12 VDC";
            DataClassification = CustomerContent;
        }
        field(60037; "Supply Giving From"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60038; "Earth Status"; Option)
        {
            OptionMembers = " ",Connected,"Not connected";
            DataClassification = CustomerContent;
        }
        field(60039; "Communication Media"; Option)
        {
            OptionMembers = " ",OFC,MICROWAVE,QUAD;
            DataClassification = CustomerContent;
        }
        field(60040; "Warr/AMC/None"; Option)
        {
            OptionMembers = " ",WARRANTY,AMC,"NONE";
            DataClassification = CustomerContent;
        }
        field(60041; Zone; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60042; Division; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60043; Station; Code[10])
        {
            Editable = true;
            TableRelation = Station;
            DataClassification = CustomerContent;
        }
        field(60044; "Order Date"; Date)
        {
            CalcFormula = Lookup("Service Header"."Order Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60045; "Sent date time"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60046; "Unit cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60047; "AMC Order No"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60048; Tested; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60049; "Accounted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

