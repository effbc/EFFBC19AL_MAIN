table 33000903 "Sales Invoice-Dummy"
{
    DataClassification = CustomerContent;
    // version DIM1.0,Rev01

    // PROJECT : Efftronics
    // *****************************************************************************************************************************
    // SIGN
    // *****************************************************************************************************************************
    // B2B     : B2B Software Technologies
    // *****************************************************************************************************************************
    // VER      SIGN   USERID                 DATE                       DESCRIPTION
    // *****************************************************************************************************************************
    // 1.0       DIM   Jagadish      24-May-13                      -> Delete the Local variable (TempDocDimRecordTable357)


    fields
    {
        field(1; "Document Type"; Enum "Sales Comment Document Type")
        {
            Caption = 'Document Type';

            DataClassification = CustomerContent;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Opp: Record Opportunity;
            begin
            end;
        }
        field(3; "No."; Code[30])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(4; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            NotBlank = true;
            TableRelation = Customer;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //Deleted Local var(TempDocDimRecordTable357) DIM
            end;
        }
        field(5; "Bill-to Name"; Text[50])
        {
            Caption = 'Bill-to Name';
            DataClassification = CustomerContent;
        }
        field(6; "Bill-to Name 2"; Text[50])
        {
            Caption = 'Bill-to Name 2';
            DataClassification = CustomerContent;
        }
        field(7; "Bill-to Address"; Text[50])
        {
            Caption = 'Bill-to Address';
            DataClassification = CustomerContent;
        }
        field(8; "Bill-to Address 2"; Text[50])
        {
            Caption = 'Bill-to Address 2';
            DataClassification = CustomerContent;
        }
        field(9; "Bill-to City"; Text[30])
        {
            Caption = 'Bill-to City';
            DataClassification = CustomerContent;
        }
        field(10; "Bill-to Contact"; Text[50])
        {
            Caption = 'Bill-to Contact';
            DataClassification = CustomerContent;
        }
        field(11; "Your Reference"; Text[30])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(12; "Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
            DataClassification = CustomerContent;
        }
        field(13; "Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
        field(14; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            DataClassification = CustomerContent;
        }
        field(15; "Ship-to Address"; Text[50])
        {
            Caption = 'Ship-to Address';
            DataClassification = CustomerContent;
        }
        field(16; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            DataClassification = CustomerContent;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            DataClassification = CustomerContent;
        }
        field(18; "Ship-to Contact"; Text[50])
        {
            Caption = 'Ship-to Contact';
            DataClassification = CustomerContent;
        }
        field(19; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(21; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            DataClassification = CustomerContent;
        }
        field(22; "Posting Description"; Text[50])
        {
            Caption = 'Posting Description';
            DataClassification = CustomerContent;
        }
        field(23; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms" WHERE(Sales = CONST(true));
            DataClassification = CustomerContent;
        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(25; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(26; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(27; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
        field(28; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(29; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(30; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(31; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            Editable = true;
            TableRelation = "Customer Posting Group";
            DataClassification = CustomerContent;
        }
        field(32; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(34; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
            DataClassification = CustomerContent;
        }
        field(35; "Prices Including VAT"; Boolean)
        {
            Caption = 'Prices Including VAT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                SalesLine: Record "Sales Line";
                Currency: Record Currency;
                JobPostLine: Codeunit "Job Post-Line";
                RecalculatePrice: Boolean;
            begin
            end;
        }
        field(37; "Invoice Disc. Code"; Code[20])
        {
            Caption = 'Invoice Disc. Code';
            DataClassification = CustomerContent;
        }
        field(40; "Customer Disc. Group"; Code[10])
        {
            Caption = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
            DataClassification = CustomerContent;
        }
        field(41; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
        }
        field(43; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ApprovalEntry: Record "Approval Entry";
            begin
                //Deleted local Var(TempDocDimRecordTable357) DIM
            end;
        }
        field(45; "Order Class"; Code[10])
        {
            Caption = 'Order Class';
            DataClassification = CustomerContent;
        }
        field(46; Comment; Boolean)
        {
            CalcFormula = Exist("Sales Comment Line" WHERE("Document Type" = FIELD("Document Type"),
                                                            "No." = FIELD("No."),
                                                            "Document Line No." = CONST(0)));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = CustomerContent;
        }
        field(52; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            DataClassification = CustomerContent;
        }
        field(53; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
            //ServTaxEntry: Record "Service Tax Entry";
            begin
            end;

            trigger OnValidate();
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
            // ServTaxEntry: Record "Service Tax Entry";
            begin
            end;
        }
        field(55; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account";
            DataClassification = CustomerContent;
        }
        field(57; Ship; Boolean)
        {
            Caption = 'Ship';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(58; Invoice; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = CustomerContent;
        }
        field(60; Amount; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line".Amount WHERE("Document Type" = FIELD("Document Type"),
                                                         "Document No." = FIELD("No.")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount Including VAT" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "Document No." = FIELD("No.")));
            Caption = 'Amount Including VAT';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Shipping No."; Code[20])
        {
            Caption = 'Shipping No.';
            DataClassification = CustomerContent;
        }
        field(63; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = CustomerContent;
        }
        field(64; "Last Shipping No."; Code[20])
        {
            Caption = 'Last Shipping No.';
            Editable = false;
            TableRelation = "Sales Shipment Header";
            DataClassification = CustomerContent;
        }
        field(65; "Last Posting No."; Code[20])
        {
            Caption = 'Last Posting No.';
            Editable = false;
            TableRelation = "Sales Invoice Header";
            DataClassification = CustomerContent;
        }
        field(66; "Prepayment No."; Code[20])
        {
            Caption = 'Prepayment No.';
            DataClassification = CustomerContent;
        }
        field(67; "Last Prepayment No."; Code[20])
        {
            Caption = 'Last Prepayment No.';
            TableRelation = "Sales Invoice Header";
            DataClassification = CustomerContent;
        }
        field(68; "Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Prepmt. Cr. Memo No.';
            DataClassification = CustomerContent;
        }
        field(69; "Last Prepmt. Cr. Memo No."; Code[20])
        {
            Caption = 'Last Prepmt. Cr. Memo No.';
            TableRelation = "Sales Cr.Memo Header";
            DataClassification = CustomerContent;
        }
        field(70; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = CustomerContent;
        }
        field(71; "Combine Shipments"; Boolean)
        {
            Caption = 'Combine Shipments';
            DataClassification = CustomerContent;
        }
        field(73; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(75; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            DataClassification = CustomerContent;
        }
        field(76; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
            DataClassification = CustomerContent;
        }
        field(77; "Transport Method"; Code[20])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
            DataClassification = CustomerContent;
        }
        field(78; "VAT Country/Region Code"; Code[10])
        {
            Caption = 'VAT Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(79; "Sell-to Customer Name"; Text[50])
        {
            Caption = 'Sell-to Customer Name';
            DataClassification = CustomerContent;
        }
        field(80; "Sell-to Customer Name 2"; Text[50])
        {
            Caption = 'Sell-to Customer Name 2';
            DataClassification = CustomerContent;
        }
        field(81; "Sell-to Address"; Text[50])
        {
            Caption = 'Sell-to Address';
            DataClassification = CustomerContent;
        }
        field(82; "Sell-to Address 2"; Text[50])
        {
            Caption = 'Sell-to Address 2';
            DataClassification = CustomerContent;
        }
        field(83; "Sell-to City"; Text[30])
        {
            Caption = 'Sell-to City';
            DataClassification = CustomerContent;
        }
        field(84; "Sell-to Contact"; Text[50])
        {
            Caption = 'Sell-to Contact';
            DataClassification = CustomerContent;
        }
        field(85; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(86; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to County';
            DataClassification = CustomerContent;
        }
        field(87; "Bill-to Country/Region Code"; Code[10])
        {
            Caption = 'Bill-to Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(88; "Sell-to Post Code"; Code[20])
        {
            Caption = 'Sell-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(89; "Sell-to County"; Text[30])
        {
            Caption = 'Sell-to County';
            DataClassification = CustomerContent;
        }
        field(90; "Sell-to Country/Region Code"; Code[10])
        {
            Caption = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(91; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(92; "Ship-to County"; Text[30])
        {
            Caption = 'Ship-to County';
            DataClassification = CustomerContent;
        }
        field(93; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(94; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Bank Account';
            OptionMembers = "G/L Account","Bank Account";
            DataClassification = CustomerContent;
        }
        field(97; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point';
            TableRelation = "Entry/Exit Point";
            DataClassification = CustomerContent;
        }
        field(98; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(99; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(100; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(101; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
            DataClassification = CustomerContent;
        }
        field(102; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
            DataClassification = CustomerContent;
        }
        field(104; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(105; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
            DataClassification = CustomerContent;
        }
        field(106; "Package Tracking No."; Text[30])
        {
            Caption = 'Package Tracking No.';
            DataClassification = CustomerContent;
        }
        field(107; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(108; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(109; "Shipping No. Series"; Code[10])
        {
            Caption = 'Shipping No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(114; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(115; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(116; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(117; Reserve; Option)
        {
            Caption = 'Reserve';
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
        }
        field(118; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                TempCustLedgEntry: Record "Cust. Ledger Entry";
            begin
            end;
        }
        field(119; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(120; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
        }
        field(121; "Invoice Discount Calculation"; Option)
        {
            Caption = 'Invoice Discount Calculation';
            Editable = false;
            OptionCaption = 'None,%,Amount';
            OptionMembers = "None","%",Amount;
            DataClassification = CustomerContent;
        }
        field(122; "Invoice Discount Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoice Discount Value';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(123; "Send IC Document"; Boolean)
        {
            Caption = 'Send IC Document';
            DataClassification = CustomerContent;
        }
        field(124; "IC Status"; Option)
        {
            Caption = 'IC Status';
            OptionCaption = 'New,Pending,Sent';
            OptionMembers = New,Pending,Sent;
            DataClassification = CustomerContent;
        }
        field(125; "Sell-to IC Partner Code"; Code[20])
        {
            Caption = 'Sell-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(126; "Bill-to IC Partner Code"; Code[20])
        {
            Caption = 'Bill-to IC Partner Code';
            Editable = false;
            TableRelation = "IC Partner";
            DataClassification = CustomerContent;
        }
        field(129; "IC Direction"; Option)
        {
            Caption = 'IC Direction';
            OptionCaption = 'Outgoing,Incoming';
            OptionMembers = Outgoing,Incoming;
            DataClassification = CustomerContent;
        }
        field(130; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(131; "Prepayment No. Series"; Code[10])
        {
            Caption = 'Prepayment No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(132; "Compress Prepayment"; Boolean)
        {
            Caption = 'Compress Prepayment';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(133; "Prepayment Due Date"; Date)
        {
            Caption = 'Prepayment Due Date';
            DataClassification = CustomerContent;
        }
        field(134; "Prepmt. Cr. Memo No. Series"; Code[10])
        {
            Caption = 'Prepmt. Cr. Memo No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(135; "Prepmt. Posting Description"; Text[50])
        {
            Caption = 'Prepmt. Posting Description';
            DataClassification = CustomerContent;
        }
        field(138; "Prepmt. Pmt. Discount Date"; Date)
        {
            Caption = 'Prepmt. Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(139; "Prepmt. Payment Terms Code"; Code[10])
        {
            Caption = 'Prepmt. Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin
            end;
        }
        field(140; "Prepmt. Payment Discount %"; Decimal)
        {
            Caption = 'Prepmt. Payment Discount %';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(151; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5043; "No. of Archived Versions"; Integer)
        {
            CalcFormula = Max("Sales Header Archive"."Version No." WHERE("Document Type" = FIELD("Document Type"),
                                                                          "No." = FIELD("No."),
                                                                          "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            Editable = true;
            FieldClass = FlowField;
        }
        field(5048; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
                //Deleted Local var(TempDocDimRecordTable357) DIM
            end;
        }
        field(5051; "Sell-to Customer Template Code"; Code[10])
        {
            Caption = 'Sell-to Customer Template Code';
            TableRelation = "Customer Template";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                SellToCustTemplate: Record "Customer Template";
            begin
            end;
        }
        field(5052; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';
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
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
                Opportunity: Record Opportunity;
                ChangeLogMgt: Codeunit "Change Log Management";
                RecRef: RecordRef;
                xRecRef: RecordRef;
            begin
            end;
        }
        field(5053; "Bill-to Contact No."; Code[20])
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
                ContBusinessRelation: Record "Contact Business Relation";
                Cont: Record Contact;
            begin
            end;
        }
        field(5054; "Bill-to Customer Template Code"; Code[10])
        {
            Caption = 'Bill-to Customer Template Code';
            TableRelation = "Customer Template";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                BillToCustTemplate: Record "Customer Template";
            begin
                //Deleted Local var(TempDocDimRecordTable357) DIM
            end;
        }
        field(5055; "Opportunity No."; Code[20])
        {
            Caption = 'Opportunity No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Opportunity: Record Opportunity;
                SalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "Responsibility Center";
            DataClassification = CustomerContent;
        }
        field(5750; "Shipping Advice"; Option)
        {
            Caption = 'Shipping Advice';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
            DataClassification = CustomerContent;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            CalcFormula = Min("Sales Line"."Completely Shipped" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No."),
                                                                       Type = FILTER(<> " "),
                                                                       "Location Code" = FIELD("Location Filter")));
            Caption = 'Completely Shipped';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5753; "Posting from Whse. Ref."; Integer)
        {
            Caption = 'Posting from Whse. Ref.';
            DataClassification = CustomerContent;
        }
        field(5754; "Location Filter"; Code[10])
        {
            Caption = 'Location Filter';
            FieldClass = FlowFilter;
            TableRelation = Location;
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
        field(5794; "Shipping Agent Service Code"; Code[10])
        {
            Caption = 'Shipping Agent Service Code';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
            DataClassification = CustomerContent;
        }
        field(5795; "Late Order Shipping"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Sell-to Customer No." = FIELD("Sell-to Customer No."),
                                                    "Document No." = FIELD("No."),
                                                    "Shipment Date" = FIELD("Date Filter"),
                                                    "Outstanding Quantity" = FILTER(<> 0)));
            Caption = 'Late Order Shipping';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5796; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5800; Receive; Boolean)
        {
            Caption = 'Receive';
            DataClassification = CustomerContent;
        }
        field(5801; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.';
            DataClassification = CustomerContent;
        }
        field(5802; "Return Receipt No. Series"; Code[10])
        {
            Caption = 'Return Receipt No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(5803; "Last Return Receipt No."; Code[20])
        {
            Caption = 'Last Return Receipt No.';
            Editable = false;
            TableRelation = "Return Receipt Header";
            DataClassification = CustomerContent;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.';
            DataClassification = CustomerContent;
        }
        field(7200; "Get Shipment Used"; Boolean)
        {
            Caption = 'Get Shipment Used';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8725; Signature; BLOB)
        {
            Caption = 'Signature';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            Description = 'Rev01';
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }
        field(13701; "Assessee Code"; Code[10])
        {
            Caption = 'Assessee Code';
            TableRelation = "Assessee Code";
            DataClassification = CustomerContent;
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
            Caption = 'Excise Bus. Posting Group';
            //TableRelation = "Excise Bus. Posting Group";
            DataClassification = CustomerContent;
        }
        field(13731; "Amount to Customer"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE("Document Type" = FIELD("Document Type"),
                                                                       "Document No." = FIELD("No.")));
            Caption = 'Amount to Customer';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13736; "Bill to Customer State"; Code[10])
        {
            Caption = 'Bill to Customer State';
            TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(13737; "Form Code"; Code[10])
        {
            Caption = 'Form Code';
            // TableRelation = "State Forms"."Form Code" WHERE(State = FIELD(State),
            // "Transit Document" = CONST(false));
            DataClassification = CustomerContent;
        }
        field(13738; "Form No."; Code[10])
        {
            Caption = 'Form No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13751; "Transit Document"; Boolean)
        {
            Caption = 'Transit Document';
            DataClassification = CustomerContent;
        }
        field(13752; State; Code[10])
        {
            Caption = 'State';
            TableRelation = State;
            DataClassification = CustomerContent;
        }

        field(13753; "LC No."; Code[20])
        {
            Caption = 'LC No.';
            /*
               TableRelation = "LC Detail"."No." WHERE("Transaction Type" = CONST(Sale),
                                                        "Issued To/Received From" = FIELD("Bill-to Customer No."),
                                                        Closed = CONST(false),
                                                        Released = CONST(true));
                                                        */ //EFFUPG
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                //LCDetail: Record "LC Detail";//EFFUPG
                Text13700: Label 'The LC which you have selected is Foreign type you cannot utilise for this order.';
            begin
            end;
        }
        /* field(13790; Structure; Code[10])
         {
             Caption = 'Structure';
             //  TableRelation = "Structure Header";
             DataClassification = CustomerContent;

             trigger OnValidate();
             var
                 /*                 StrDetails: Record "Structure Details";
                                 StrOrderDetails: Record "Structure Order Details";
                                 StrOrderLines: Record "Structure Order Line Details"; 
                 SaleLines: Record "Sales Line";
             begin
             end;
         }*/
        field(16410; "Free Supply"; Boolean)
        {
            Caption = 'Free Supply';
            DataClassification = CustomerContent;
        }
        field(16411; "Export or Deemed Export"; Boolean)
        {
            Caption = 'Export or Deemed Export';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16412; "VAT Exempted"; Boolean)
        {
            Caption = 'VAT Exempted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16501; Trading; Boolean)
        {
            Caption = 'Trading';
            DataClassification = CustomerContent;
        }
        field(16502; "Transaction No. Serv. Tax"; Integer)
        {
            Caption = 'Transaction No. Serv. Tax';
            DataClassification = CustomerContent;
        }
        field(16503; "Re-Dispatch"; Boolean)
        {
            Caption = 'Re-Dispatch';
            DataClassification = CustomerContent;
        }
        field(16504; "Return Re-Dispatch Rcpt. No."; Code[20])
        {
            Caption = 'Return Re-Dispatch Rcpt. No.';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ReturnRcptLine: Record "Return Receipt Line";
            begin
            end;

            trigger OnValidate();
            var
                ReturnRcptLine: Record "Return Receipt Line";
                LineNo: Integer;
            begin
            end;
        }
        field(16505; "TDS Certificate Receivable"; Boolean)
        {
            Caption = 'TDS Certificate Receivable';
            DataClassification = CustomerContent;
        }
        field(16508; "Price Inclusive of Taxes"; Boolean)
        {
            CalcFormula = Exist("Sales Line" WHERE("Document Type" = FIELD("Document Type"),
                                                    "Document No." = FIELD("No."),
                                                    Type = FILTER(Item),
                                                    "Price Inclusive of Tax" = FILTER(true)));
            Caption = 'Price Inclusive of Taxes';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16509; "Calc. Inv. Discount (%)"; Boolean)
        {
            Caption = 'Calc. Inv. Discount (%)';
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                SalesLine2: Record "Sales Line";
            begin
            end;
        }
        field(16510; "Time of Removal"; Time)
        {
            Caption = 'Time of Removal';
            DataClassification = CustomerContent;
        }
        field(16511; "LR/RR No."; Code[20])
        {
            Caption = 'LR/RR No.';
            DataClassification = CustomerContent;
        }
        field(16512; "LR/RR Date"; Date)
        {
            Caption = 'LR/RR Date';
            DataClassification = CustomerContent;
        }
        field(16513; "Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
        }
        field(16514; "Mode of Transport"; Text[15])
        {
            Caption = 'Mode of Transport';
            DataClassification = CustomerContent;
        }
        field(16515; "ST Pure Agent"; Boolean)
        {
            Caption = 'ST Pure Agent';
            DataClassification = CustomerContent;
        }
        field(16516; "Nature of Services"; Option)
        {
            Caption = 'Nature of Services';
            OptionCaption = '" ,Exempted,Export"';
            OptionMembers = " ",Exempted,Export;
            DataClassification = CustomerContent;
        }
        field(16522; "Service Tax Rounding Precision"; Decimal)
        {
            Caption = 'Service Tax Rounding Precision';
            DataClassification = CustomerContent;
        }
        field(16523; "Service Tax Rounding Type"; Option)
        {
            Caption = 'Service Tax Rounding Type';
            OptionCaption = 'Nearest,Up,Down';
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
        }
        field(16524; "Sale Return Type"; Option)
        {
            Caption = 'Sale Return Type';
            OptionCaption = '" ,Sales Cancellation"';
            OptionMembers = " ","Sales Cancellation";
            DataClassification = CustomerContent;
        }
        field(50000; "MSPT Date"; Date)
        {
            Description = 'MSPT1.0';
            DataClassification = CustomerContent;
        }
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT1.0';
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT1.0';
            DataClassification = CustomerContent;
        }
        field(50003; WayBillNo; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "posting time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(50005; userid1; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(50006; "Work Order Number"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60001; "RDSO Charges Paid By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By Customer","By Railways";
            DataClassification = CustomerContent;
        }
        field(60002; "CA Number"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "CA Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Type of Enquiry"; Option)
        {
            Description = 'B2B';
            OptionMembers = Direct,Indirect;
            DataClassification = CustomerContent;
        }
        field(60005; "Type of Product"; Option)
        {
            Description = 'B2B';
            OptionMembers = Standard,Customized;
            DataClassification = CustomerContent;
        }
        field(60006; "Document Position"; Option)
        {
            Description = 'B2B';
            Editable = false;
            OptionMembers = Sales,Design,CRM;
            DataClassification = CustomerContent;
        }
        field(60007; "Cancel Short Close"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Cancelled,Short Closed"';
            OptionMembers = " ",Cancelled,"Short Closed";
            DataClassification = CustomerContent;
        }
        field(60008; "RDSO Inspection Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "RDSO Inspection By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By RDSO","By Consignee";
            DataClassification = CustomerContent;
        }
        field(60010; "BG Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60011; "BG No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60012; Territory; Code[20])
        {
            Description = 'B2B';
            TableRelation = Territory;
            DataClassification = CustomerContent;
        }
        field(60013; "Security Status"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60014; "LD Amount"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60015; "RDSO Charges"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60016; "Customer OrderNo."; Code[65])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60017; "Customer Order Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60018; "Security Deposit"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,BG,FDR,DD,Running Bills"';
            OptionMembers = " ",BG,FDR,DD,"Running Bills";
            DataClassification = CustomerContent;
        }
        field(60019; "RDSO Call Letter"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Customer,RDSO"';
            OptionMembers = " ",Customer,RDSO;
            DataClassification = CustomerContent;
        }
        field(60020; "Enquiry Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Open,Closed,Order Received"';
            OptionMembers = " ",Open,Closed,"Order Received";
            DataClassification = CustomerContent;
        }
        field(60021; "Project Completion Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60022; "Extended Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60023; "Bktord Des Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "SalOrd Des Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60030; "Type of Customer"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Existing,New';
            OptionMembers = Existing,New;
            DataClassification = CustomerContent;
        }
        field(60031; "Nature of Enquiry"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Single,Multiple';
            OptionMembers = Single,Multiple;
            DataClassification = CustomerContent;
        }
        field(60032; Product; Code[10])
        {
            Description = 'B2B';
            TableRelation = "Service Item Group";
            DataClassification = CustomerContent;
        }
        field(60033; "Quote Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = CONST(Quote),
                                                                "Document No." = FIELD("No.")));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60034; "Installation Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "No." = FILTER('47300')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60035; "Bought out Items Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "Gen. Prod. Posting Group" = FILTER('BOI' | 'RAW-MAT')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60036; "Software Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "No." = FILTER('46400' | '18100' | '47505')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60037; "Total Order Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60038; "Total Order Amount(With Taxes)"; Decimal)
        {
            // CalcFormula = Sum("Sales Line"."Amount Including Tax" WHERE("Document No." = FIELD("No.")));
            Description = 'EFF';
            //FieldClass = FlowField;
        }
        field(60041; "Security Deposit Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60042; "Deposit Payment Due Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60043; "Deposit Payment Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60044; "Security Deposit Status"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60045; "SD Requested Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60046; "SD Required Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60047; "SecurityDeposit Exp. Rcpt Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60050; "Tender No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Tender Header";
            DataClassification = CustomerContent;
        }
        field(60053; "Final Bill Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60054; "Warranty Period"; DateFormula)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60055; "SD Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Not Received,Received,NA';
            OptionMembers = "Not Received",Received,NA;
            DataClassification = CustomerContent;
        }
        field(60056; "Released to Sales User ID"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60057; "Released to Sales Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60058; "Released to Design User ID"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60059; "Released to Design Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60061; "Sale Order Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60063; "Order Status"; Option)
        {
            OptionMembers = ,Dispatched,Inprogress,"Ready For Dispatch","Ready For RDSO","RDSO Inspected","Yet to Start","Order Pending",Completed,Cancel;
            DataClassification = CustomerContent;
        }
        field(60064; Inspection; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60065; CallLetterExpireDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60066; CallLetterRecivedDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60068; Installation; Option)
        {
            OptionMembers = " ",RlyInstallation,EffInstallation,"RLY&EFF";
            DataClassification = CustomerContent;
        }
        field(60069; "Inst.Status"; Option)
        {
            OptionMembers = ," Raliway Pending","Railway Inprogress",Inprogress,Planned,"To Be Planned",Completed," ";
            DataClassification = CustomerContent;
        }
        field(60073; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60074; "Call letters Status"; Option)
        {
            OptionMembers = " ",Received,Pending,NA;
            DataClassification = CustomerContent;
        }
        field(60075; "Call Letter Exp.Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60076; "BG Status"; Option)
        {
            OptionMembers = " ",Submitted,Pending,NA;
            DataClassification = CustomerContent;
        }
        field(60077; "Inst.Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60078; "Exp.Payment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60081; "Assured Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60087; "Station Names"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60088; "Shortage Calculation"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60089; "Sale Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;

        }
        field(60090; "RDSO Inspection Req"; Option)
        {
            OptionMembers = " ",YES,NA;
            DataClassification = CustomerContent;
        }
        field(60095; "Order Assurance"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60096; "Expected Order Month"; Option)
        {
            OptionMembers = "  ",APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC,JAN,FEB,MAR,"     ";
            DataClassification = CustomerContent;
        }
        field(60097; "Sale Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60098; "Purchase Value"; Decimal)
        {
            CalcFormula = Sum("Item Lot Numbers".Total WHERE("Sales Order No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60099; "Request for Authorisation"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60116; "Order Completion Period"; Integer)
        {
            MaxValue = 360;
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(60117; "Expecting Week"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "Total Order(LOA)Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60120; "Pending(LOA)Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."OutStanding(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "Document Type" = FILTER(Order)));
            FieldClass = FlowField;
        }
        field(60121; "Blanket Order No"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(80000; "Order Released Date"; Date)
        {
            Caption = 'Order Released Date';
            DataClassification = CustomerContent;
        }
        field(99008500; "Date Received"; Date)
        {
            Caption = 'Date Received';
            DataClassification = CustomerContent;
        }
        field(99008501; "Time Received"; Time)
        {
            Caption = 'Time Received';
            DataClassification = CustomerContent;
        }
        field(99008502; "BizTalk Request for Sales Qte."; Boolean)
        {
            Caption = 'BizTalk Request for Sales Qte.';
            DataClassification = CustomerContent;
        }
        field(99008503; "BizTalk Sales Order"; Boolean)
        {
            Caption = 'BizTalk Sales Order';
            DataClassification = CustomerContent;
        }
        field(99008509; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = CustomerContent;
        }
        field(99008510; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = CustomerContent;
        }
        field(99008513; "BizTalk Sales Quote"; Boolean)
        {
            Caption = 'BizTalk Sales Quote';
            DataClassification = CustomerContent;
        }
        field(99008514; "BizTalk Sales Order Cnfmn."; Boolean)
        {
            Caption = 'BizTalk Sales Order Cnfmn.';
            DataClassification = CustomerContent;
        }
        field(99008518; "Customer Quote No."; Code[30])
        {
            Caption = 'Customer Quote No.';
            DataClassification = CustomerContent;
        }
        field(99008519; "Customer Order No."; Code[50])
        {
            Caption = 'Customer Order No.';
            DataClassification = CustomerContent;
        }
        field(99008521; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
            DataClassification = CustomerContent;
        }
        field(99008522; "EMD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(99008523; "EMD Status"; Option)
        {
            OptionCaption = 'Due,Received';
            OptionMembers = Due,Received;
            DataClassification = CustomerContent;
        }
        field(99008524; SecDepStatus; Option)
        {
            Description = 'Added by Pranavi for sd tracking';
            OptionCaption = 'Running,Warranty,Due,Received';
            OptionMembers = Running,Warranty,Due,Received;
            DataClassification = CustomerContent;
        }
        field(99008525; "Final Railway Bill Date"; Date)
        {
            Description = 'Added by Pranavi for sd status tracking';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

