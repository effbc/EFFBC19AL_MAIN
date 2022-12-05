table 60084 "MSPT Vendor Ledger Entry"
{
    // version MSPT1.0,Rev01

    // B2B Software Technologies
    // ---------------------------------------------------
    // Project : Mile Stone Payment Terms
    // B2B
    // No. sign   Description
    // ---------------------------------------------------
    // 01  B2B    MSPT Vendor Ledger Entry

    DrillDownPageID = "MSPT Vendor Ledger Entries";
    LookupPageID = "MSPT Vendor Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Document Type';


        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(7; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Remaining Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Original Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Entry Type" = FILTER("Initial Entry"),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Remaining Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Remaining Amt. (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Entry Type" = FILTER("Initial Entry" | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Purchase (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Purchase (LCY)';
            DataClassification = CustomerContent;
        }
        field(20; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)';
            DataClassification = CustomerContent;
        }
        field(21; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(22; "Vendor Posting Group"; Code[10])
        {
            Caption = 'Vendor Posting Group';
            TableRelation = "Vendor Posting Group";
            DataClassification = CustomerContent;
        }
        field(23; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(24; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(25; "Purchaser Code"; Code[10])
        {
            Caption = 'Purchaser Code';
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
        }
        field(27; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup();
            var
                LoginMgt: Codeunit "User Management";
            begin
            end;
        }
        field(28; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(33; "On Hold"; Code[3])
        {
            Caption = 'On Hold';
            DataClassification = CustomerContent;
        }
        field(34; "Applies-to Doc. Type"; Enum "Gen. Journal Document Type")
        {
            Caption = 'Applies-to Doc. Type';


        }
        field(35; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.';
            DataClassification = CustomerContent;
        }
        field(36; Open; Boolean)
        {
            Caption = 'Open';
            DataClassification = CustomerContent;
        }
        field(37; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(38; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date';
            DataClassification = CustomerContent;
        }
        field(39; "Original Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Original Pmt. Disc. Possible';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(40; "Pmt. Disc. Rcd.(LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Disc. Rcd.(LCY)';
            DataClassification = CustomerContent;
        }
        field(43; Positive; Boolean)
        {
            Caption = 'Positive';
            DataClassification = CustomerContent;
        }
        field(44; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "Vendor Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(45; "Closed at Date"; Date)
        {
            Caption = 'Closed at Date';
            DataClassification = CustomerContent;
        }
        field(46; "Closed by Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount';
            DataClassification = CustomerContent;
        }
        field(47; "Applies-to ID"; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(49; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(51; "Bal. Account Type"; enum "Gen. Journal Account Type")
        {
            Caption = 'Bal. Account Type';

        }
        field(52; "Bal. Account No."; Code[20])
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
        }
        field(53; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
            DataClassification = CustomerContent;
        }
        field(54; "Closed by Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Amount (LCY)';
            DataClassification = CustomerContent;
        }
        field(58; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                  "Entry Type" = FILTER(<> Application),
                                                                                  "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                   "Entry Type" = FILTER(<> Application),
                                                                                   "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "Debit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Debit Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                        "Entry Type" = FILTER(<> Application),
                                                                                        "Posting Date" = FIELD("Date Filter")));
            Caption = 'Debit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Credit Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry"."Credit Amount (LCY)" WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                                         "Entry Type" = FILTER(<> Application),
                                                                                         "Posting Date" = FIELD("Date Filter")));
            Caption = 'Credit Amount (LCY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(63; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(65; "Closed by Currency Code"; Code[10])
        {
            Caption = 'Closed by Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(66; "Closed by Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Closed by Currency Amount';
            DataClassification = CustomerContent;
        }
        field(73; "Adjusted Currency Factor"; Decimal)
        {
            Caption = 'Adjusted Currency Factor';
            DecimalPlaces = 0 : 15;
            DataClassification = CustomerContent;
        }
        field(74; "Original Currency Factor"; Decimal)
        {
            Caption = 'Original Currency Factor';
            DecimalPlaces = 0 : 15;
            DataClassification = CustomerContent;
        }
        field(75; "Original Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Vendor Ledg. Entry".Amount WHERE("Vendor Ledger Entry No." = FIELD("Entry No."),
                                                                          "Entry Type" = FILTER("Initial Entry"),
                                                                          "Posting Date" = FIELD("Date Filter")));
            Caption = 'Original Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(76; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(77; "Remaining Pmt. Disc. Possible"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Remaining Pmt. Disc. Possible';
            DataClassification = CustomerContent;
        }
        field(78; "Pmt. Disc. Tolerance Date"; Date)
        {
            Caption = 'Pmt. Disc. Tolerance Date';
            DataClassification = CustomerContent;
        }
        field(79; "Max. Payment Tolerance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Max. Payment Tolerance';
            DataClassification = CustomerContent;
        }
        field(81; "Accepted Payment Tolerance"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Accepted Payment Tolerance';
            DataClassification = CustomerContent;
        }
        field(82; "Accepted Pmt. Disc. Tolerance"; Boolean)
        {
            Caption = 'Accepted Pmt. Disc. Tolerance';
            DataClassification = CustomerContent;
        }
        field(83; "Pmt. Tolerance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Pmt. Tolerance (LCY)';
            DataClassification = CustomerContent;
        }
        field(13700; "Import Document"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13702; "TDS Nature of Deduction"; Code[10])
        {
            NotBlank = true;
            TableRelation = "TDS Section";
            DataClassification = CustomerContent;
        }
        field(13703; "TDS Group"; Option)
        {
            Editable = false;
            OptionCaption = '" ,Contractor,Commission,Professional,Interest,Rent,Dividend,Interest on Securities,Lotteries,Insurance Commission,NSS,Mutual fund,Brokerage,Income from Units,Capital Assets,Horse Races,Sports Association,Payable to Non Residents,Income of Mutual Funds,Units,Foreign Currency Bonds,FII from Securities,Others"';
            OptionMembers = " ",Contractor,Commission,Professional,Interest,Rent,Dividend,"Interest on Securities",Lotteries,"Insurance Commission",NSS,"Mutual fund",Brokerage,"Income from Units","Capital Assets","Horse Races","Sports Association","Payable to Non Residents","Income of Mutual Funds",Units,"Foreign Currency Bonds","FII from Securities",Others;
            DataClassification = CustomerContent;
        }
        field(13704; "Total TDS Including eCESS"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "MSPT Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Header Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "MSPT Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "MSPT Amount"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Amount" WHERE("MSPT Vend. Led. Entry No." = FIELD("MSPT Entry No."),
                                                                                   "Entry Type" = FILTER("Initial Entry" | Application | "Unrealized Loss" | "Unrealized Gain" | "Realized Loss" | "Realized Gain" | "Payment Discount" | "Payment Discount (VAT Excl.)" | "Payment Discount (VAT Adjustment)" | "Appln. Rounding" | "Correction of Remaining Amount" | "Payment Tolerance" | "Payment Discount Tolerance" | "Payment Tolerance (VAT Excl.)" | "Payment Tolerance (VAT Adjustment)" | "Payment Discount Tolerance (VAT Excl.)" | "Payment Discount Tolerance (VAT Adjustment)"),
                                                                                   "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50005; "Calculation Type"; Option)
        {
            Enabled = false;
            OptionMembers = Percentage,"Fixed Value";
            DataClassification = CustomerContent;
        }
        field(50006; "MSPT Credit value"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Credit Value" WHERE("MSPT Vend. Led. Entry No." = FIELD("MSPT Entry No."),
                                                                                         "Entry Type" = FILTER(<> Application),
                                                                                         "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50007; "MSPT Debit Value"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Debit Value" WHERE("MSPT Vend. Led. Entry No." = FIELD("MSPT Entry No."),
                                                                                        "Entry Type" = FILTER(<> Application),
                                                                                        "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50008; "Calculation Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50009; "MSPT Due Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Open, true);
                MSPTDtldVendLedgEntry.SetRange("MSPT Vend. Led. Entry No.", "MSPT Entry No.");
                MSPTDtldVendLedgEntry.SetRange("Entry Type", MSPTDtldVendLedgEntry."Entry Type"::"Initial Entry");
                if MSPTDtldVendLedgEntry.Find('-') then begin
                    repeat
                        MSPTDtldVendLedgEntry."MSPT Due Date" := "MSPT Due Date";
                        MSPTDtldVendLedgEntry.Modify;
                    until MSPTDtldVendLedgEntry.Next = 0;
                end;
            end;
        }
        field(50010; "MSPT Remaining Amount"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Amount" WHERE("MSPT Vend. Led. Entry No." = FIELD("MSPT Entry No."),
                                                                                   "Posting Date" = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(50011; "MSPT Line Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50012; "MSPT Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "MSPT Entry No.")
        {
        }
        key(Key2; "Vendor No.", "Posting Date", "Currency Code")
        {
        }
        key(Key3; "Vendor No.", Open, Positive, "Currency Code", "MSPT Due Date")
        {
        }
        key(Key4; "Vendor No.", Open, Positive, "Due Date", "Currency Code")
        {
        }
        key(Key5; "Closed by Entry No.")
        {
        }
        key(Key6; Open, "MSPT Due Date")
        {
        }
        key(Key7; "Vendor No.", Open, "MSPT Due Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        MSPTVendLedgEntry: Record "MSPT Vendor Ledger Entry";
        MSPTDtldVendLedgEntry: Record "MSPT Dtld. Vendor Ledg. Entry";
}

