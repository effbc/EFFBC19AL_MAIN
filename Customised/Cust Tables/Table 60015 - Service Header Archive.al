table 60015 "Service Header Archive"
{
    // version DIM1.0,Rev01

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Sivaramakrishna.A      24-May-13              -> Code has been Commented in Delete() because of Document Dimension Archive does not exist in NAV 2013

    LookupPageID = "Service List Archive";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Enum "Service Document Type")
        {
            Caption = 'Document Type';


        }
        field(4; "Service Order Type"; Code[10])
        {
            Caption = 'Service Order Type';
            TableRelation = "Service Order Type";
            DataClassification = CustomerContent;
        }
        field(5; "Link Service to Service Item"; Boolean)
        {
            Caption = 'Link Service to Service Item';
            DataClassification = CustomerContent;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending,In Process,Finished,On Hold';
            OptionMembers = Pending,"In Process",Finished,"On Hold";
            DataClassification = CustomerContent;
        }
        field(7; Priority; Option)
        {
            Caption = 'Priority';
            OptionCaption = 'Low,Medium,High';
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
        }
        field(8; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;
        }
        field(9; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(10; "Name 2"; Text[30])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(11; Address; Text[30])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(12; "Address 2"; Text[30])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(13; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpCity(City,"Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidateCity(City,"Post Code");
            end;
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpPostCode(City,"Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidatePostCode(City,"Post Code");
            end;
        }
        field(15; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            DataClassification = CustomerContent;
        }
        field(16; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            DataClassification = CustomerContent;
        }
        field(17; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            DataClassification = CustomerContent;
        }
        field(18; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = CustomerContent;
        }
        field(19; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(22; "Order Date"; Date)
        {
            Caption = 'Order Date';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(23; "Order Time"; Time)
        {
            Caption = 'Order Time';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(24; "Default Response Time (Hours)"; Decimal)
        {
            Caption = 'Default Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(25; "Actual Response Time (Hours)"; Decimal)
        {
            Caption = 'Actual Response Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(26; "Service Time (Hours)"; Decimal)
        {
            Caption = 'Service Time (Hours)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(27; "Response Date"; Date)
        {
            Caption = 'Response Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(28; "Response Time"; Time)
        {
            Caption = 'Response Time';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(29; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(30; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            DataClassification = CustomerContent;
        }
        field(31; "Finishing Date"; Date)
        {
            Caption = 'Finishing Date';
            DataClassification = CustomerContent;
        }
        field(32; "Finishing Time"; Time)
        {
            Caption = 'Finishing Time';
            DataClassification = CustomerContent;
        }
        field(33; "Contract Serv. Hours Exist"; Boolean)
        {
            CalcFormula = Exist("Service Hour" WHERE("Service Contract No." = FIELD("Contract No.")));
            Caption = 'Contract Serv. Hours Exist';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(36; "Notify Customer"; Option)
        {
            Caption = 'Notify Customer';
            OptionCaption = 'No,By Phone 1,By Phone 2,By Fax,By E-Mail';
            OptionMembers = No,"By Phone 1","By Phone 2","By Fax","By E-Mail";
            DataClassification = CustomerContent;
        }
        field(37; "Max. Labor Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            Caption = 'Max. Labor Unit Price';
            DataClassification = CustomerContent;
        }
        field(38; "Warning Status"; Option)
        {
            Caption = 'Warning Status';
            OptionCaption = '" ,First Warning,Second Warning,Third Warning"';
            OptionMembers = " ","First Warning","Second Warning","Third Warning";
            DataClassification = CustomerContent;
        }
        field(39; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //DIM1.0
                //Deleted Local Var(TempDocDimRecordTable357)
                //DIM1.0
            end;
        }
        field(40; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract),
                                                                            "Customer No." = FIELD("Customer No."),
                                                                            "Ship-to Code" = FIELD("Ship-to Code"),
                                                                            "Bill-to Customer No." = FIELD("Bill-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(41; "Contact Name"; Text[30])
        {
            Caption = 'Contact Name';
            DataClassification = CustomerContent;
        }
        field(42; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
            end;
        }
        field(43; "Bill-to Name"; Text[30])
        {
            Caption = 'Bill-to Name';
            DataClassification = CustomerContent;
        }
        field(44; "Bill-to Address"; Text[30])
        {
            Caption = 'Bill-to Address';
            DataClassification = CustomerContent;
        }
        field(45; "Bill-to Address 2"; Text[30])
        {
            Caption = 'Bill-to Address 2';
            DataClassification = CustomerContent;
        }
        field(46; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpPostCode("Bill-to City","Bill-to Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidatePostCode("Bill-to City","Bill-to Post Code");
            end;
        }
        field(47; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpCity("Bill-to City","Bill-to Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidateCity("Bill-to City","Bill-to Post Code");
            end;
        }
        field(48; "Bill-to Contact"; Text[30])
        {
            Caption = 'Bill-to Contact';
            DataClassification = CustomerContent;
        }
        field(49; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Customer No."));
            DataClassification = CustomerContent;
        }
        field(50; "Ship-to Name"; Text[30])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(51; "Ship-to Address"; Text[30])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(52; "Ship-to Address 2"; Text[30])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(53; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpPostCode("Ship-to City","Ship-to Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidatePostCode("Ship-to City","Ship-to Post Code");
            end;
        }
        field(54; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                //PostCode.LookUpCity("Ship-to City","Ship-to Post Code",TRUE);
            end;

            trigger OnValidate();
            begin
                //PostCode.ValidateCity("Ship-to City","Ship-to Post Code");
            end;
        }
        field(55; "Ship-to Fax No."; Text[30])
        {
            Caption = 'Ship-to Fax No.';
            DataClassification = CustomerContent;
        }
        field(56; "Ship-to E-Mail"; Text[80])
        {
            Caption = 'Ship-to E-Mail';
            DataClassification = CustomerContent;
        }
        field(57; "Ship-to Contact"; Text[30])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(58; "Ship-to Phone"; Text[30])
        {
            Caption = 'Ship-to Phone';
            DataClassification = CustomerContent;
        }
        field(59; "Ship-to Phone 2"; Text[30])
        {
            Caption = 'Ship-to Phone 2';
            DataClassification = CustomerContent;
        }
        field(60; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(61; Comment; Boolean)
        {
            CalcFormula = Exist("Service Comment Line" WHERE("Table Name" = CONST("Service Header"),
                                                              "Table Subtype" = FIELD("Document Type"),
                                                              "No." = FIELD("No."),
                                                              Type = CONST(General)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(64; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job WHERE("Bill-to Customer No." = FIELD("Bill-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(65; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(66; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(67; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(68; "Service Zone Code"; Code[10])
        {
            Caption = 'Service Zone Code';
            Editable = false;
            TableRelation = "Service Zone".Code;
            DataClassification = CustomerContent;
        }
        field(69; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                RespCenter: Record "Responsibility Center";
            begin
            end;
        }
        field(70; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(71; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(72; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(73; "Price Includes VAT"; Boolean)
        {
            Caption = 'Price Includes VAT';
            DataClassification = CustomerContent;
        }
        field(74; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = CustomerContent;
        }
        field(75; "VAT Country Code"; Code[10])
        {
            Caption = 'VAT Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(76; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(77; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(78; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(80; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(81; "Expected Finishing Date"; Date)
        {
            Caption = 'Expected Finishing Date';
            DataClassification = CustomerContent;
        }
        field(82; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
        }
        field(83; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
            DataClassification = CustomerContent;
        }
        field(84; County; Text[30])
        {
            Caption = 'County';
            DataClassification = CustomerContent;
        }
        field(85; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(86; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(87; "Bill-to Name 2"; Text[30])
        {
            Caption = 'Bill-to Name 2';
            DataClassification = CustomerContent;
        }
        field(88; "Bill-to Country Code"; Code[10])
        {
            Caption = 'Bill-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(89; "Ship-to Name 2"; Text[30])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(90; "Ship-to Country Code"; Code[10])
        {
            Caption = 'Ship-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(100; "Usage (Cost)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Service Ledger Entry"."Cost Amount" WHERE("Entry Type" = CONST(Usage),
                                                                          "Service Contract No." = FIELD("Contract Filter"),
                                                                          "Service Order No." = FIELD("No."),
                                                                          Type = FIELD("Type Filter"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Usage (Cost)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "Usage (Amount)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Service Ledger Entry"."Amount (LCY)" WHERE("Entry Type" = CONST(Usage),
                                                                           "Service Contract No." = FIELD("Contract Filter"),
                                                                           "Service Order No." = FIELD("No."),
                                                                           Type = FIELD("Type Filter"),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Usage (Amount)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Invoiced Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = - Sum("Service Ledger Entry"."Amount (LCY)" WHERE("Entry Type" = CONST(Sale),
                                                                            "Service Contract No." = FIELD("Contract Filter"),
                                                                            "Service Order No." = FIELD("No."),
                                                                            Type = FIELD("Type Filter"),
                                                                            "Posting Date" = FIELD("Date Filter")));
            Caption = 'Invoiced Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(103; "Total Quantity"; Decimal)
        {
            CalcFormula = Sum("Service Ledger Entry".Quantity WHERE("Entry Type" = CONST(Usage),
                                                                     "Service Contract No." = FIELD("Contract Filter"),
                                                                     "Service Order No." = FIELD("No."),
                                                                     Type = FIELD("Type Filter"),
                                                                     "Posting Date" = FIELD("Date Filter")));
            Caption = 'Total Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(104; "Total Qty. to Invoice"; Decimal)
        {
            CalcFormula = Sum("Service Ledger Entry"."Charged Qty." WHERE("Entry Type" = CONST(Usage),
                                                                           "Service Contract No." = FIELD("Contract Filter"),
                                                                           "Service Order No." = FIELD("No."),
                                                                           Type = FIELD("Type Filter"),
                                                                           "Posting Date" = FIELD("Date Filter")));
            Caption = 'Total Qty. to Invoice';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(105; "No. of Posted Invoices"; Integer)
        {
            CalcFormula = Count("Service Document Register" WHERE("Source Document Type" = CONST(Order),
                                                                   "Source Document No." = FIELD("No."),
                                                                   "Destination Document Type" = CONST("Posted Invoice")));
            Caption = 'No. of Posted Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(106; "No. of Unposted Invoices"; Integer)
        {
            CalcFormula = Count("Service Document Register" WHERE("Source Document Type" = CONST(Order),
                                                                   "Source Document No." = FIELD("No."),
                                                                   "Destination Document Type" = CONST(Invoice)));
            Caption = 'No. of Unposted Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
        field(107; "No. of Allocations"; Integer)
        {
            CalcFormula = Count("Service Order Allocation" WHERE("Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Resource Group No." = FIELD("Resource Group Filter"),
                                                                  "Allocation Date" = FIELD("Date Filter"),
                                                                  Status = FILTER(Active | Finished)));
            Caption = 'No. of Allocations';
            Editable = false;
            FieldClass = FlowField;
        }
        field(108; "No. of Unallocated Items"; Integer)
        {
            CalcFormula = Count("Service Item Line" WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("No."),
                                                           "No. of Active/Finished Allocs" = CONST(0)));
            Caption = 'No. of Unallocated Items';
            Editable = false;
            FieldClass = FlowField;
        }
        field(111; "Allocated Hours"; Decimal)
        {
            CalcFormula = Sum("Service Order Allocation"."Allocated Hours" WHERE("Document Type" = FIELD("Document Type"),
                                                                                  "Document No." = FIELD("No."),
                                                                                  "Allocation Date" = FIELD("Date Filter"),
                                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                                  Status = FILTER(Active | Finished),
                                                                                  "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Allocated Hours';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(112; "Reallocation Needed"; Boolean)
        {
            CalcFormula = Exist("Service Order Allocation" WHERE(Status = CONST("Reallocation Needed"),
                                                                  "Resource No." = FIELD("Resource Filter"),
                                                                  "Document Type" = FIELD("Document Type"),
                                                                  "Document No." = FIELD("No."),
                                                                  "Resource Group No." = FIELD("Resource Group Filter")));
            Caption = 'Reallocation Needed';
            Editable = false;
            FieldClass = FlowField;
        }
        field(151; "Type Filter"; Enum "Service Ledger Entry Type")
        {
            Caption = 'Type Filter';
            FieldClass = FlowFilter;

        }
        field(152; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(153; "Resource Filter"; Code[20])
        {
            Caption = 'Resource Filter';
            FieldClass = FlowFilter;
            TableRelation = Resource;
        }
        field(154; "Contract Filter"; Code[20])
        {
            Caption = 'Contract Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
        }
        field(155; "Customer Filter"; Code[20])
        {
            Caption = 'Customer Filter';
            FieldClass = FlowFilter;
            TableRelation = Customer."No.";
        }
        field(156; "Service Zone Filter"; Code[10])
        {
            Caption = 'Service Zone Filter';
            FieldClass = FlowFilter;
            TableRelation = "Service Zone".Code;
        }
        field(157; "Resource Group Filter"; Code[20])
        {
            Caption = 'Resource Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Resource Group";
        }
        field(5050; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            TableRelation = Contact;
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;
        }
        field(5051; "Bill-to Contact No."; Code[20])
        {
            Caption = 'Bill-to Contact No.';
            TableRelation = Contact;
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;

            trigger OnValidate();
            var
                Cont: Record Contact;
                ContBusinessRelation: Record "Contact Business Relation";
            begin
            end;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            DataClassification = CustomerContent;
        }
        field(60001; "Doc. No. Occurrence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60002; "Archived by"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60003; "Date Archived"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60004; "Time Archived"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(60005; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60006; "Interaction Exist"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Doc. No. Occurrence", "Version No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        ServiceItemLineArchive: Record "Service Item Line Archive";
        ServiceInvoiceLineArchive: Record "Service Invoice Line Archive";
    begin
        ServiceItemLineArchive.SetRange("Document Type", "Document Type");
        ServiceItemLineArchive.SetRange("Document No.", "No.");
        ServiceItemLineArchive.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        ServiceItemLineArchive.SetRange("Version No.", "Version No.");
        ServiceItemLineArchive.DeleteAll;

        ServiceInvoiceLineArchive.SetRange("Document Type", "Document Type");
        ServiceInvoiceLineArchive.SetRange("Document No.", "No.");
        ServiceInvoiceLineArchive.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        ServiceInvoiceLineArchive.SetRange("Version No.", "Version No.");
        ServiceInvoiceLineArchive.DeleteAll;
        //DIM1.0 Start
        //Code Comment
        /*
        DocDimensionArchive.SETRANGE("Table ID", DATABASE::"Service Header");
        DocDimensionArchive.SETRANGE("Document Type", "Document Type");
        DocDimensionArchive.SETRANGE("Document No.", "No.");
        DocDimensionArchive.SETRANGE("Doc. No. Occurrence", "Doc. No. Occurrence");
        DocDimensionArchive.SETRANGE("Version No.", "Version No.");
        DocDimensionArchive.DELETEALL;
        
        DocDimensionArchive.SETRANGE("Table ID", DATABASE::"Service Item Line");
        DocDimensionArchive.DELETEALL;
        
        DocDimensionArchive.SETRANGE("Table ID", DATABASE::"Service Line");
        DocDimensionArchive.DELETEALL;
        */
        //DIM1.0 End

    end;
}

