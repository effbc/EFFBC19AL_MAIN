table 90000 "VAT Applicable Entries"
{
    // version B2B1.0,Rev01

    // LookupPageID = 90000;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(3; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = '" ,Purchase,Sale,Settlement"';
            OptionMembers = " ",Purchase,Sale,Settlement;
            DataClassification = CustomerContent;
        }
        field(8; Base; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Base';
            DataClassification = CustomerContent;
        }
        field(9; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(12; "Sell-to/Buy-from No."; Code[20])
        {
            Caption = 'Sell-to/Buy-from No.';
            TableRelation = IF (Type = CONST(Purchase)) Vendor
            ELSE
            IF (Type = CONST(Sale)) Customer;
            DataClassification = CustomerContent;
        }
        field(13; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade';
            DataClassification = CustomerContent;
        }
        field(14; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(15; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            TableRelation = "Source Code";
            DataClassification = CustomerContent;
        }
        field(16; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(17; "Closed by Entry No."; Integer)
        {
            Caption = 'Closed by Entry No.';
            TableRelation = "VAT Entry";
            DataClassification = CustomerContent;
        }
        field(18; Closed; Boolean)
        {
            Caption = 'Closed';
            DataClassification = CustomerContent;
        }
        field(19; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(20; "Internal Ref. No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Transaction No."; Integer)
        {
            Caption = 'Transaction No.';
            DataClassification = CustomerContent;
        }
        field(26; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
            DataClassification = CustomerContent;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(29; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
            DataClassification = CustomerContent;
        }
        field(30; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
            DataClassification = CustomerContent;
        }
        field(31; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(32; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax';
            DataClassification = CustomerContent;
        }
        field(33; "Tax Jurisdiction Code"; Code[10])
        {
            Caption = 'Tax Jurisdiction Code';
            TableRelation = "Tax Jurisdiction";
            DataClassification = CustomerContent;
        }
        field(34; "Tax Group Used"; Code[10])
        {
            Caption = 'Tax Group Used';
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(37; "Sales Tax Connection No."; Integer)
        {
            Caption = 'Sales Tax Connection No.';
            DataClassification = CustomerContent;
        }
        field(38; "Unrealized TAX Entry No."; Integer)
        {
            Caption = 'Unrealized TAX Entry No.';
            TableRelation = "VAT Entry";
            DataClassification = CustomerContent;
        }
        field(43; "Additional-Currency Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Additional-Currency Amount';
            DataClassification = CustomerContent;
        }
        field(44; "Additional-Currency Base"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Additional-Currency Base';
            DataClassification = CustomerContent;
        }
        field(54; Paid; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55; "Applied To"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(56; "VAT Type"; Option)
        {
            OptionCaption = '" ,Item,Capital Item"';
            OptionMembers = " ",Item,"Capital Item";
            DataClassification = CustomerContent;
        }
        field(57; "VAT Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(58; "T.I.N. No."; Text[11])
        {
            //  TableRelation = "T.I.N. Nos.";
            DataClassification = CustomerContent;
        }
        field(59; "Vendor/Customer T.I.N. No."; Text[11])
        {
            // TableRelation = "T.I.N. Nos.";
            DataClassification = CustomerContent;
        }
        field(60; "VAT Exempted Goods"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13700; "Sub Area Type"; Option)
        {
            OptionCaption = 'None,Full Tax,Concessional Tax';
            OptionMembers = "None","Full Tax","Concessional Tax";
            DataClassification = CustomerContent;
        }
        field(13701; "Form Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13702; "Form No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13703; "Account No."; Code[20])
        {
            TableRelation = "G/L Account";
            DataClassification = CustomerContent;
        }
        field(13704; "Pay Tax Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60001; Status; Option)
        {
            Description = 'B2B';
            OptionMembers = Open,Closed;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

