table 80181 "Gen. Journal Line2"
{
    // version NAVW13.70,NAVIN3.70.01.13

    Caption = 'Gen. Journal Line2';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ClosingDates = true;
            DataClassification = CustomerContent;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            DataClassification = CustomerContent;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.';
            TableRelation = IF ("Bal. Account Type" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Bal. Account Type" = CONST("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount';
            DataClassification = CustomerContent;
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount';
            DataClassification = CustomerContent;
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales/Purch. (LCY)';
            DataClassification = CustomerContent;
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
            DataClassification = CustomerContent;
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
            DataClassification = CustomerContent;
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            Caption = 'Bill-to/Pay-to No.';
            TableRelation = IF ("Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) Customer
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) Vendor;
            DataClassification = CustomerContent;
        }
        field(23; "Posting Group"; Code[10])
        {
            Caption = 'Posting Group';
            Editable = false;
            TableRelation = IF ("Account Type" = CONST(Customer)) "Customer Posting Group"
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Vendor Posting Group"
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "FA Posting Group";
            DataClassification = CustomerContent;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(26; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            Editable = false;
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(30; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(34; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = CustomerContent;
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
            DataClassification = CustomerContent;
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
            begin
            end;
        }
        field(38; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(40; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            Editable = false;
            TableRelation = Job;
            DataClassification = CustomerContent;
        }
        field(43; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount';
            DataClassification = CustomerContent;
        }
        field(45; "VAT Posting"; Option)
        {
            Caption = 'VAT Posting';
            Editable = false;
            OptionCaption = 'Automatic VAT Entry,Manual VAT Entry';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
            DataClassification = CustomerContent;
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            DataClassification = CustomerContent;
        }
        field(48; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(50; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
            DataClassification = CustomerContent;
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            DataClassification = CustomerContent;
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method';
            OptionCaption = '" ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance"';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
            DataClassification = CustomerContent;
        }
        field(54; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = CustomerContent;
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency';
            DataClassification = CustomerContent;
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Gen. Jnl. Allocation".Amount WHERE("Journal Template Name" = FIELD("Journal Template Name"),
                                                                   "Journal Batch Name" = FIELD("Journal Batch Name"),
                                                                   "Journal Line No." = FIELD("Line No.")));
            Caption = 'Allocated Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = '" ,Purchase,Sale,Settlement"';
            OptionMembers = " ",Purchase,Sale,Settlement;
            DataClassification = CustomerContent;
        }
        field(58; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(59; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(60; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            DataClassification = CustomerContent;
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(62; "Allow Application"; Boolean)
        {
            Caption = 'Allow Application';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(63; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            Caption = 'Bal. Gen. Posting Type';
            OptionCaption = '" ,Purchase,Sale,Settlement"';
            OptionMembers = " ",Purchase,Sale,Settlement;
            DataClassification = CustomerContent;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            Caption = 'Bal. VAT Calculation Type';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
            DataClassification = CustomerContent;
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            Caption = 'Bal. VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount';
            DataClassification = CustomerContent;
        }
        field(70; "Bank Payment Type"; Option)
        {
            Caption = 'Bank Payment Type';
            OptionCaption = '" ,Computer Check,Manual Check"';
            OptionMembers = " ","Computer Check","Manual Check";
            DataClassification = CustomerContent;
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount';
            DataClassification = CustomerContent;
        }
        field(73; Correction; Boolean)
        {
            Caption = 'Correction';
            DataClassification = CustomerContent;
        }
        field(75; "Check Printed"; Boolean)
        {
            Caption = 'Check Printed';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(76; "Document Date"; Date)
        {
            Caption = 'Document Date';
            ClosingDates = true;
            DataClassification = CustomerContent;
        }
        field(77; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(78; "Source Type"; Option)
        {
            Caption = 'Source Type';
            OptionCaption = '" ,Customer,Vendor,Bank Account,Fixed Asset"';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(79; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE
            IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE
            IF ("Source Type" = CONST("Bank Account")) "Bank Account"
            ELSE
            IF ("Source Type" = CONST("Fixed Asset")) "Fixed Asset";
            DataClassification = CustomerContent;
        }
        field(80; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(82; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(83; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(84; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
            DataClassification = CustomerContent;
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            Caption = 'Bal. Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            Caption = 'Bal. Tax Liable';
            DataClassification = CustomerContent;
        }
        field(88; "Bal. Tax Group Code"; Code[10])
        {
            Caption = 'Bal. Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            Caption = 'Bal. Use Tax';
            DataClassification = CustomerContent;
        }
        field(90; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(91; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'Bal. VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            Caption = 'Additional-Currency Posting';
            Editable = false;
            OptionCaption = 'None,Amount Only,Additional-Currency Amount Only';
            OptionMembers = "None","Amount Only","Additional-Currency Amount Only";
            DataClassification = CustomerContent;
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            Caption = 'FA Add.-Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code';
            Editable = false;
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Currency Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount (LCY)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            Caption = 'Reversing Entry';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            Caption = 'Allow Zero-Amount Posting';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            Caption = 'Ship-to/Order Address Code';
            TableRelation = IF ("Account Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Account Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Bal. Account Type" = CONST(Customer)) "Ship-to Address".Code WHERE("Customer No." = FIELD("Bill-to/Pay-to No."))
            ELSE
            IF ("Bal. Account Type" = CONST(Vendor)) "Order Address".Code WHERE("Vendor No." = FIELD("Bill-to/Pay-to No."));
            DataClassification = CustomerContent;
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Difference';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.';
            TableRelation = Campaign;
            DataClassification = CustomerContent;
        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5600; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5601; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type';
            OptionCaption = '" ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance"';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
            DataClassification = CustomerContent;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code';
            TableRelation = "Depreciation Book";
            DataClassification = CustomerContent;
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value';
            DataClassification = CustomerContent;
        }
        field(5604; "No. of Depreciation Days"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Depreciation Days';
            DataClassification = CustomerContent;
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date';
            DataClassification = CustomerContent;
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost';
            DataClassification = CustomerContent;
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code';
            TableRelation = Maintenance;
            DataClassification = CustomerContent;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.';
            TableRelation = Insurance;
            DataClassification = CustomerContent;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.';
            TableRelation = "Fixed Asset";
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
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            Caption = 'FA Reclassification Entry';
            DataClassification = CustomerContent;
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.';
            TableRelation = "FA Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(5616; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry';
            DataClassification = CustomerContent;
        }
        field(5802; "Value Entry No."; Integer)
        {
            Caption = 'Value Entry No.';
            Editable = false;
            TableRelation = "Value Entry";
            DataClassification = CustomerContent;
        }
        field(13701; "Source Curr. Excise Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13702; "Source Curr. Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13703; "State Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13704; "Tax Exemption No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(13706; "Excise Bus. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13707; "Excise Prod. Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13708; "Excise Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13709; "Excise %"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13710; "Excise Calculation Type"; Option)
        {
            OptionCaption = 'Excise %,Amount/Unit,% of Accessable Value,Excise %+Amount/Unit';
            OptionMembers = "Excise %","Amount/Unit","% of Accessable Value","Excise %+Amount/Unit";
            DataClassification = CustomerContent;
        }
        field(13711; "Amount Including Excise"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13712; "Excise Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13715; "PLA Type"; Option)
        {
            OptionCaption = '" ,BED Amount,AED Amount,SED Amount,SAED Amount,CESS Amount,NCCD Amount,Duty4 Amount"';
            OptionMembers = " ","BED Amount","AED Amount","SED Amount","SAED Amount","CESS Amount","NCCD Amount","Duty4 Amount";
            DataClassification = CustomerContent;
        }
        field(13716; "TDS Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13717; "Service Tax"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13718; "Tax Amount"; Decimal)
        {
            DecimalPlaces = 0 : 4;
            DataClassification = CustomerContent;
        }
        field(13719; "Excise Accounting Type"; Option)
        {
            OptionCaption = 'With CENVAT,Without CENVAT';
            OptionMembers = "With CENVAT","Without CENVAT";
            DataClassification = CustomerContent;
        }
        field(13720; "Indirect Costs Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13721; "PLA eCess Amount"; Decimal)
        {
            Caption = 'PLA eCess Amount';
            DataClassification = CustomerContent;
        }
        field(13722; "RG 23 A PART II eCess Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II eCess Amount';
            DataClassification = CustomerContent;
        }
        field(13723; "RG 23 C PART II eCess Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II eCess Amount';
            DataClassification = CustomerContent;
        }
        field(13726; "PLA SAED Amount"; Decimal)
        {
            Caption = 'PLA SAED Amount';
            DataClassification = CustomerContent;
        }
        field(13727; "RG 23 A PART II SAED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II SAED Amount';
            DataClassification = CustomerContent;
        }
        field(13728; "RG 23 C PART II SAED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II SAED Amount';
            DataClassification = CustomerContent;
        }
        field(13729; "PLA CESS Amount"; Decimal)
        {
            Caption = 'PLA CESS Amount';
            DataClassification = CustomerContent;
        }
        field(13730; "RG 23 A PART II CESS Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II CESS Amount';
            DataClassification = CustomerContent;
        }
        field(13731; "RG 23 C PART II CESS Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II CESS Amount';
            DataClassification = CustomerContent;
        }
        field(13732; "PLA NCCD Amount"; Decimal)
        {
            Caption = 'PLA NCCD Amount';
            DataClassification = CustomerContent;
        }
        field(13733; "RG 23 A PART II NCCD Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II NCCD Amount';
            DataClassification = CustomerContent;
        }
        field(13734; "RG 23 C PART II NCCD Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II NCCD Amount';
            DataClassification = CustomerContent;
        }
        field(13736; PLA; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13737; "Tax %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13740; "Export Document"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13741; "Import Document"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13744; "Tax Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13746; Cenvat; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13747; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13750; "Source Curr. Tax Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13753; "Tax Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13754; "Tax Base Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13758; "TDS Nature of Deduction"; Code[10])
        {
            TableRelation = "TDS Section";
            DataClassification = CustomerContent;
        }
        field(13759; "TDS Assessee Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Assessee Code";
            DataClassification = CustomerContent;
        }
        field(13760; "TDS %"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13761; "TDS Amount Including Surcharge"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13763; "Bal. TDS Including eCESS"; Decimal)
        {
            Caption = 'Bal. TDS Including eCESS';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13764; "TDS Party Type"; Option)
        {
            BlankNumbers = DontBlank;
            InitValue = " ";
            OptionCaption = '" ,Party,Customer,Vendor"';
            OptionMembers = " ",Party,Customer,Vendor;
            DataClassification = CustomerContent;
        }
        field(13765; "TDS Party"; Code[20])
        {
            TableRelation = IF ("TDS Party Type" = CONST(Party)) Party
            ELSE
            IF ("TDS Party Type" = CONST(Customer)) Customer
            ELSE
            IF ("TDS Party Type" = CONST(Vendor)) Vendor;
            DataClassification = CustomerContent;
        }
        field(13766; "BED Amount"; Decimal)
        {
            Caption = 'BED Amount';
            DataClassification = CustomerContent;
        }
        field(13767; "AED(GSI) Amount"; Decimal)
        {
            Caption = 'AED(GSI) Amount';
            DataClassification = CustomerContent;
        }
        field(13768; "SED Amount"; Decimal)
        {
            Caption = 'SED Amount';
            DataClassification = CustomerContent;
        }
        field(13769; "SAED Amount"; Decimal)
        {
            Caption = 'SAED Amount';
            DataClassification = CustomerContent;
        }
        field(13770; "CESS Amount"; Decimal)
        {
            Caption = 'CESS Amount';
            DataClassification = CustomerContent;
        }
        field(13771; "NCCD Amount"; Decimal)
        {
            Caption = 'NCCD Amount';
            DataClassification = CustomerContent;
        }
        field(13772; "eCess Amount"; Decimal)
        {
            Caption = 'eCess Amount';
            DataClassification = CustomerContent;
        }
        field(13773; "Form Code"; Code[10])
        {
            //TableRelation = "Form Codes";
            DataClassification = CustomerContent;
        }
        field(13774; "Form No."; Code[10])
        {
            //ableRelation = "Tax Forms Details";
            DataClassification = CustomerContent;
        }
        field(13779; "LC No."; Code[20])
        {
            // TableRelation = "LC Detail"."No." WHERE(Closed = CONST(false),Released = CONST(true));
            DataClassification = CustomerContent;
        }
        field(13780; "Work Tax Base Amount"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(13781; "Work Tax %"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13782; "Work Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13786; "TDS Category"; Option)
        {
            OptionCaption = '" ,A,C,S"';
            OptionMembers = " ",A,C,S;
            DataClassification = CustomerContent;
        }
        field(13787; "Surcharge %"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13788; "Surcharge Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13789; "Concessional Code"; Code[10])
        {
            Editable = false;
            //TableRelation = "Concessional Codes";
            DataClassification = CustomerContent;
        }
        field(13790; "Work Tax Paid"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13791; "PLA AED(GSI) Amount"; Decimal)
        {
            Caption = 'PLA AED(GSI) Amount';
            DataClassification = CustomerContent;
        }
        field(13792; "RG 23A PART II AED(GSI) Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II AED Amount';
            DataClassification = CustomerContent;
        }
        field(13793; "RG 23C PART II AED(GSI) Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II AED Amount';
            DataClassification = CustomerContent;
        }
        field(13794; "PLA BED Amount"; Decimal)
        {
            Caption = 'PLA BED Amount';
            DataClassification = CustomerContent;
        }
        field(13795; "RG 23 A PART II BED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II BED Amount';
            DataClassification = CustomerContent;
        }
        field(13796; "RG 23 C PART II BED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II BED Amount';
            DataClassification = CustomerContent;
        }
        field(13797; "PLA SED Amount"; Decimal)
        {
            Caption = 'PLA SED Amount';
            DataClassification = CustomerContent;
        }
        field(13798; "RG 23 A PART II SED Amount"; Decimal)
        {
            Caption = 'RG 23 A PART II SED Amount';
            DataClassification = CustomerContent;
        }
        field(13799; "RG 23 C PART II SED Amount"; Decimal)
        {
            Caption = 'RG 23 C PART II SED Amount';
            DataClassification = CustomerContent;
        }
        field(16301; "Pay TDS"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16302; "Pay Work Tax"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16303; "TDS Entry"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16304; "Pay Excise"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16305; "TDS % Applied"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16306; "TDS Invoice No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16307; "TDS Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16308; "Challan No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16309; "Challan Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16310; Adjustment; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16311; "TDS Transaction No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16312; "Pay Sales Tax"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16313; "E.C.C. No."; Code[20])
        {
            //TableRelation = "E.C.C. Nos.";
            DataClassification = CustomerContent;
        }
        field(16340; "Balance Work Tax Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16350; "Pay VAT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16351; "VAT Claim Amount"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
            //  VATValidation: Codeunit "VAT Validations";
            begin
            end;
        }
        field(16352; "Refund VAT"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16353; "Balance Surcharge Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16354; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16355; "Issuing Bank"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(16357; "Surcharge % Applied"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                BalanceTDS: Decimal;
                BalanceTDSInclSurcharge: Decimal;
            begin
            end;
        }
        field(16358; "Surcharge Base Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16359; "TDS Group"; Option)
        {
            Editable = false;
            OptionCaption = '" ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others"';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
            DataClassification = CustomerContent;
        }
        field(16360; "Work Tax Nature Of Deduction"; Code[10])
        {
            TableRelation = "TDS Section";
            DataClassification = CustomerContent;
        }
        field(16361; "Work Tax Group"; Option)
        {
            Editable = false;
            OptionCaption = '" ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others"';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
            DataClassification = CustomerContent;
        }
        field(16362; "Balance TDS Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16363; "Temp TDS Base"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16364; "Excise Posting"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16365; "Product Type"; Option)
        {
            OptionCaption = ',Item,FA';
            OptionMembers = ,Item,FA;
            DataClassification = CustomerContent;
        }
        field(16366; "Excise Charge"; Boolean)
        {
            Caption = 'Excise Charge';
            DataClassification = CustomerContent;
        }
        field(16367; "Excise Charge Amount"; Decimal)
        {
            Caption = 'Excise Charge Amount';
            DataClassification = CustomerContent;
        }
        field(16368; "PLA Excise Charge Amount"; Decimal)
        {
            Caption = 'PLA Excise Charge Amount';
            DataClassification = CustomerContent;
        }
        field(16369; "Excise Record"; Option)
        {
            BlankZero = true;
            Caption = 'Excise Record';
            OptionCaption = '" ,RG23A,RG23C"';
            OptionMembers = " ",RG23A,RG23C;
            DataClassification = CustomerContent;
        }
        field(16370; "Deferred Claim FA Excise"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16371; JV; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16372; "Cheque No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(16373; "DDB No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16374; Deferred; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16375; "Service Tax Type"; Option)
        {
            Caption = 'Service Tax Type';
            OptionCaption = 'Sale,Purchase,Charge';
            OptionMembers = Sale,Purchase,Charge;
            DataClassification = CustomerContent;
        }
        field(16376; "Service Tax Group Code"; Code[20])
        {
            Caption = 'Service Tax Group Code';
            // TableRelation = "Service Tax Groups".Code;
            DataClassification = CustomerContent;
        }
        field(16377; "STN No."; Code[20])
        {
            Caption = 'Service Tax Reg. No.';
            // TableRelation = "Service Tax Registration Nos.".Code;
            DataClassification = CustomerContent;
        }
        field(16378; "Service Tax Base Amount"; Decimal)
        {
            Caption = 'Service Tax Base Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16379; "Service Tax Amount"; Decimal)
        {
            Caption = 'Service Tax Amount';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16380; "Service Tax %"; Decimal)
        {
            Caption = 'Service Tax %';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16381; "Service Tax Abetment"; Decimal)
        {
            Caption = 'Service Tax Abetment';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16382; "Service Tax Entry"; Boolean)
        {
            Caption = 'Service Tax Entry';
            DataClassification = CustomerContent;
        }
        field(16383; "eCESS %"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16384; "eCESS on TDS Amount"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16385; "Total TDS Including eCESS"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16386; "eCESS Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16387; "eCESS % Applied"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                BalanceTDS: Decimal;
                BalanceSurcharge: Decimal;
            begin
            end;
        }
        field(16388; "Balance eCESS on TDS Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16389; "Per Contract"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16390; "Capital Item"; Boolean)
        {
            Caption = 'Capital Item';
            DataClassification = CustomerContent;
        }
        field(16391; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(16405; "Service Tax eCess %"; Decimal)
        {
            Caption = 'Service Tax eCess %';
            DataClassification = CustomerContent;
        }
        field(16406; "Service Tax eCess Amount"; Decimal)
        {
            Caption = 'Service Tax eCess Amount';
            DataClassification = CustomerContent;
        }
        field(16452; "ADET Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADET Amount';
            DataClassification = CustomerContent;
        }
        field(16453; "PLA ADET Amount"; Decimal)
        {
            Caption = 'PLA ADET Amount';
            DataClassification = CustomerContent;
        }
        field(16454; "RG 23 A Part II ADET Amount"; Decimal)
        {
            Caption = 'RG 23 A Part II ADET Amount';
            DataClassification = CustomerContent;
        }
        field(16455; "RG 23 C Part II ADET Amount"; Decimal)
        {
            Caption = 'RG 23 C Part II ADET Amount';
            DataClassification = CustomerContent;
        }
        field(16456; "AED(TTA) Amount"; Decimal)
        {
            Caption = 'AED(TTA) Amount';
            DataClassification = CustomerContent;
        }
        field(16457; "PLA AED(TTA) Amount"; Decimal)
        {
            Caption = 'PLA AED(TTA) Amount';
            DataClassification = CustomerContent;
        }
        field(16458; "RG 23A PART II AED(TTA) Amount"; Decimal)
        {
            Caption = 'RG 23A PART II AED(TTA) Amount';
            DataClassification = CustomerContent;
        }
        field(16459; "RG 23C PART II AED(TTA) Amount"; Decimal)
        {
            Caption = 'RG 23C PART II AED(TTA) Amount';
            DataClassification = CustomerContent;
        }
        field(16460; "Goes to Excise Entry"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ErrText: Label 'The General Journal Line must have Service Tax Component';
                CompanyInfo: Record "Company Information";
            begin
            end;
        }
        field(16461; "From Excise"; Boolean)
        {
            Caption = 'From Excise';
            DataClassification = CustomerContent;
        }
        field(16462; "RG 23 A ST BED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16463; "RG 23 A ST AED(GSI) Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16464; "RG 23 A ST AED(TTA) Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16465; "RG 23 A ST SED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16466; "RG 23 A ST SAED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16467; "RG 23 A ST NCCD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16468; "RG 23 A ST eCESS Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16469; "RG 23 C ST BED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16470; "RG 23 C ST AED(GSI) Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16471; "RG 23 C ST AED(TTA) Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16472; "RG 23 C ST SED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16473; "RG 23 C ST SAED Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16474; "RG 23 C ST NCCD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16475; "RG 23 C ST eCESS Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16476; "RG 23 A ST ADET Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16477; "RG 23 C ST ADET Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16478; "T.A.N. No."; Code[10])
        {
            //TableRelation = "T.A.N. Nos.";
            DataClassification = CustomerContent;
        }
        field(16479; "ADE Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'ADE Amount';
            DataClassification = CustomerContent;
        }
        field(16480; "PLA ADE Amount"; Decimal)
        {
            Caption = 'PLA ADE Amount';
            DataClassification = CustomerContent;
        }
        field(16481; "RG 23 A Part II ADE Amount"; Decimal)
        {
            Caption = 'RG 23 A Part II ADE Amount';
            DataClassification = CustomerContent;
        }
        field(16482; "RG 23 C Part II ADE Amount"; Decimal)
        {
            Caption = 'RG 23 C Part II ADE Amount';
            DataClassification = CustomerContent;
        }
        field(16483; "RG 23 A ST ADE Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16484; "RG 23 C ST ADE Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16485; "Total TDS Incl. eCESS (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16486; "TDS Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16487; "Surcharge Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16488; "TDS Including Surcharge (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16489; "eCESS on TDS Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16491; "VAT Type"; Option)
        {
            OptionCaption = '" ,Item,Capital Goods"';
            OptionMembers = " ",Item,"Capital Goods";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            SumIndexFields = "Balance (LCY)";
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.")
        {
        }
        key(Key3; "Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.")
        {
        }
        key(Key4; "Journal Template Name", "Journal Batch Name", "Posting Date", "Cheque No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //Deleted Local Var(JnlLineDimRecordTable356) B2B
    end;

    trigger OnInsert();
    begin
        //Deleted Local Var(JnlLineDimRecordTable356) B2B
    end;

    var
        Text000: Label '%1 or %2 must be G/L Account or Bank Account.';
        Text001: Label 'You must not specify %1 when %2 is %3.';
        Text002: Label 'cannot be specified without %1';
        Text003: Label 'The %1 in the %2 will be changed from %3 to %4.\';
        Text004: Label 'Do you wish to continue?';
        Text005: Label 'The update has been interrupted to respect the warning.';
        Text006: Label 'The %1 option can only be used internally in the system.';
        Text007: Label '%1 or %2 must be a Bank Account.';
        Text008: Label '" must be 0 when %1 is %2."';
        Text009: Label 'LCY';
        Text010: Label '%1 must be %2 or %3.';
        Text011: Label '%1 must be negative.';
        Text012: Label '%1 must be positive.';
        Text013: Label 'The %1 must not be more than %2.';
        Text014: Label 'The %1 %2 has a %3 %4.\Do you still want to use %1 %2 in this journal line?';
        // "--NAVIN--": ;
        Text101: Label 'You are not allowed to select this Nature of Deduction.';
        Text102: Label 'You cannot claim more than the Excise Duty.';
        Text103: Label 'Please enter the total excise amount in PLA Amount Field.';
        Text104: Label 'Amount cannot be changed.';
        Text16350: Label 'You cannot Claim more than the VAT Payable Amount.';
        Text16351: Label 'Bal. Account Type must be G/L Account or Bank Account.';
        Text16352: Label '%1 Type must be G/L Account';


    procedure EmptyLine(): Boolean;
    begin
    end;


    procedure UpdateLineBalance();
    begin
    end;

    procedure SetUpNewLine(LastGenJnlLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean);
    begin
    end;


    local procedure CheckVATInAlloc();
    begin
    end;


    local procedure SetCurrencyCode(AccType2: Option "G/L Account",Customer,Vendor,"Bank Account"; AccNo2: Code[20]): Boolean;
    begin
    end;


    local procedure GetCurrency();
    begin
    end;


    procedure UpdateSource();
    var
        SourceExists1: Boolean;
        SourceExists2: Boolean;
    begin
    end;


    local procedure CheckGLAcc();
    begin
    end;


    procedure GetFAAddCurrExchRate();
    var
        DeprBook: Record "Depreciation Book";
        FANo: Code[20];
        UseFAAddCurrExchRate: Boolean;
    begin
    end;


    procedure GetShowCurrencyCode(CurrencyCode: Code[10]): Code[10];
    begin
    end;


    procedure ClearCustVendApplID();
    begin
    end;


    procedure CheckFixedCurrency(): Boolean;
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
    end;


    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]; Type4: Integer; No4: Code[20]; Type5: Integer; No5: Code[20]);
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    begin
    end;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20]);
    begin
    end;


    procedure GetFAVATSetup();
    var
        LocalGlAcc: Record "G/L Account";
        FAPostingGr: Record "FA Posting Group";
        FABalAcc: Boolean;
    begin
    end;


    procedure "---NAVIN---"();
    begin
    end;


    procedure CalculateTDS();
    var
        TDSEntry: Record "TDS Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        //  TDSGroup: Record "TDS Group";
        DateFilterCalc: Codeunit "DateFilter-Calc";
        AccountingPeriodFilter: Text[30];
        FiscalYear: Boolean;
        PreviousTDSAmt: Decimal;
        PreviousSurchargeAmt: Decimal;
        PreviousAmount: Decimal;
        AppliedAmount: Decimal;
        CurrentJnlTDSAmt: Decimal;
        CurrentJnlAmount: Decimal;
        CurrentJnlSurChargeamt: Decimal;
        CalculatedTDSAmt: Decimal;
        CalculatedSurchargeAmt: Decimal;
        CalculateSurcharge: Boolean;
        SurchargeBase: Decimal;
        PreviousContractAmount: Decimal;
        InvoiceAmount: Decimal;
        PaymentAmount: Decimal;
    begin
    end;


    procedure RoundTDSAmount(TDSAmount: Decimal): Decimal;
    var
        TDSRoundingDirection: Text[1];
        TDSRoundingPrecision: Decimal;
    begin
    end;


    procedure InsertTDSBuf(TDSEntry: Record "TDS Entry"; PostingDate: Date; CalculateSurcharge: Boolean; CalculateTDS: Boolean);
    begin
    end;


    procedure UpdTDSBuffer();
    begin
    end;

    procedure InsertGenTDSBuf(Applied: Boolean);
    begin
    end;


    procedure RemoveVATAssociation();
    begin
    end;

    /*     procedure CalculateServiceTax();
        var
            ServiceTaxSetup: Record "Service Tax Setup";
        begin
        end; */
}

