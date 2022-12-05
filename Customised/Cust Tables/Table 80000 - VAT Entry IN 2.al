table 80000 "VAT Entry IN 2"
{
    // version NAVIN3.70

    DrillDownPageID = "Service Entity Types";
    LookupPageID = "Service Entity Types";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(2; "Posting Date"; Date)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(3; "VAT Type"; Option)
        {
            Editable = true;
            OptionCaption = 'VAT,Sales Tax,Excise,Other';
            OptionMembers = VAT,"Sales Tax",Excise,Other;
            DataClassification = CustomerContent;
        }
        field(4; "Doc. Type"; Option)
        {
            Editable = true;
            OptionMembers = Sale,Purchase,Adjustment;
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(6; "VAT Bus. Posting Group"; Code[10])
        {
            Editable = true;

            /*  TableRelation = IF ("VAT Type" = FILTER(VAT)) Table16350.Field1
             ELSE
             IF ("VAT Type" = FILTER("Sales Tax")) "Tax Area".Code
             ELSE
             IF ("VAT Type" = FILTER(Excise)) "Excise Bus. Posting Group".Code
             ELSE
             IF ("VAT Type" = FILTER(Other)) "Tax/Charge Group".Code; */
            DataClassification = CustomerContent;
        }
        field(7; "VAT Prod. Posting Group"; Code[10])
        {
            Editable = true;

            /*  TableRelation = IF ("VAT Type" = FILTER(VAT)) Table16351.Field1
             ELSE
             IF ("VAT Type" = FILTER("Sales Tax")) "Tax Jurisdiction".Code
             ELSE
             IF ("VAT Type" = FILTER(Excise)) "Excise Prod. Posting Group".Code
             ELSE
             IF ("VAT Type" = FILTER(Other)) "Tax/Charge Group Details"."Tax/Charge Code"; */
            DataClassification = CustomerContent;
        }
        field(8; "VAT %"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(9; "VAT Base Amount"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(10; "VAT Amount"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(11; "G/L Account No."; Code[20])
        {
            Editable = true;
            TableRelation = "G/L Account"."No.";
            DataClassification = CustomerContent;
        }
        field(12; "Claim VAT"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(13; "Refund VAT"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(14; "Consume VAT"; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(15; "Remaining Amount"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(16; "Closed by Doc No."; Code[20])
        {
            Caption = 'Applies-to ID';
            DataClassification = CustomerContent;
        }
        field(17; Positive; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(18; Closed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Structure Code"; Code[10])
        {
            Editable = true;
            //TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(25; "Adjustment Amount"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Adjustment Amount" > "Remaining Amount" then Error(Text010);
            end;
        }
        field(26; "Changed Claim VAT"; Boolean)
        {
            Caption = 'New Claim VAT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Claim VAT" then Error(Text011);
                Changed := "Changed Claim VAT";
            end;
        }
        field(27; "Changed Refund VAT"; Boolean)
        {
            Caption = 'New Refund VAT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Refund VAT" then Error(Text011);
                Changed := "Changed Refund VAT";
            end;
        }
        field(28; "Changed Consume VAT"; Boolean)
        {
            Caption = 'New Consume VAT';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Consume VAT" then Error(Text011);
                Changed := "Changed Consume VAT";
            end;
        }
        field(29; Changed; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(30; Selected; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(35; ReturnSetOff; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            SumIndexFields = "VAT Amount", "Remaining Amount";
        }
        key(Key2; "Doc. Type", "G/L Account No.", "Claim VAT", Closed, "Closed by Doc No.")
        {
        }
        key(Key3; "Document No.", "Posting Date", "Doc. Type", "VAT Type", "Remaining Amount", Positive, Closed)
        {
        }
        key(Key4; "Claim VAT", "Remaining Amount", Closed, Positive, "VAT Type")
        {
            SumIndexFields = "Remaining Amount";
        }
        key(Key5; "Doc. Type", Positive, Closed, "G/L Account No.")
        {
            SumIndexFields = "Remaining Amount";
        }
        key(Key6; Changed)
        {
        }
        key(Key7; "Refund VAT", Positive, Closed, Selected)
        {
        }
        key(Key8; "Closed by Doc No.", Positive, Closed, "Refund VAT", Selected)
        {
            SumIndexFields = "VAT Amount", "Remaining Amount";
        }
    }

    fieldgroups
    {
    }

    var
        Text010: Label 'You cannot adjust more than the Remaining Amount';
        Text011: Label 'You cannot select same type for Adjustment.';
}

