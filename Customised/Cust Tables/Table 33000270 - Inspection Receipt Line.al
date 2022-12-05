table 33000270 "Inspection Receipt Line"
{
    DataClassification = CustomerContent;
    // version QC1.0,Cal1.0

    // B2B 10sep2007
    // added a field "Rework Reason Code"


    fields
    {
        field(1; "Document No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Inspection Receipt Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Character Code"; Code[20])
        {
            TableRelation = Characteristic.Code;
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Sampling Plan Code"; Code[20])
        {
            TableRelation = "Sampling Plan Header".Code;
            DataClassification = CustomerContent;
        }
        field(6; "Normal Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; "Min. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(8; "Max. Value (Num)"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(10; "Normal Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Min. Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Max. Value (Text)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Unit Of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(15; "Character Group No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Lot Size - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(18; "Lot Size - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(19; "Sampling Size"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(20; "Allowable Defects - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(21; "Allowable Defects - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(22; "Receipt No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header";
            DataClassification = CustomerContent;
        }
        field(23; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Accepted Qty"; Integer)
        {
            CalcFormula = Count("Posted Inspect Datasheet Line" WHERE("Document No." = FIELD("Posted Inspect Doc. No."),
                                                                       "Character Code" = FIELD("Character Code"),
                                                                       "Character Group No." = FIELD("Character Group No."),
                                                                       Accept = CONST(true)));
            FieldClass = FlowField;
        }
        field(26; "Rejected Qty"; Integer)
        {
            CalcFormula = Count("Posted Inspect Datasheet Line" WHERE("Document No." = FIELD("Posted Inspect Doc. No."),
                                                                       "Character Code" = FIELD("Character Code"),
                                                                       "Character Group No." = FIELD("Character Group No."),
                                                                       Accept = CONST(false)));
            FieldClass = FlowField;
        }
        field(27; "Total Qty"; Integer)
        {
            CalcFormula = Count("Posted Inspect Datasheet Line" WHERE("Document No." = FIELD("Posted Inspect Doc. No."),
                                                                       "Character Code" = FIELD("Character Code"),
                                                                       "Character Group No." = FIELD("Character Group No.")));
            FieldClass = FlowField;
        }
        field(28; "Purch Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Reason Code"; Code[20])
        {
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(30; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Inspection Persons"; Code[20])
        {
            TableRelation = "Machine Center"."No.";
            DataClassification = CustomerContent;
        }
        field(32; Accept; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Posted Inspect Doc. No."; Code[20])
        {
            TableRelation = "Posted Inspect DatasheetHeader";
            DataClassification = CustomerContent;
        }
        field(35; "Character Type"; Option)
        {
            OptionCaption = 'Standard,Heading,Begin,End';
            OptionMembers = Standard,Heading,"Begin","End";
            DataClassification = CustomerContent;
        }
        field(36; Indentation; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(37; Qualitative; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60003; "Rework Reason Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(60100; "IDS No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60101; "IDS Line No."; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Character Code", "Character Group No.")
        {
        }
        key(Key3; "Vendor No.", "Item No.", "Character Code")
        {
        }
        key(Key4; "Receipt No.", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify();
    begin
        InspectReceiptHeader.SetRange("No.", "Document No.");
        InspectReceiptHeader."Data Entered By" := UserId;
    end;

    var
        InspectReceiptHeader: Record "Inspection Receipt Header";
}

