table 33000257 "Quality Control Setup"
{
    DataClassification = CustomerContent;
    // version QC1.1,WIP1.1,Cal1.0


    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Specification Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(3; "Inspection Datasheet Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(4; "Posted Inspect. Datasheet Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(5; "Inspection Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(6; "Sampling Plan Warning"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Invoice After Inspection Only"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Sampling Rounding"; Option)
        {
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
        }
        field(9; "Production Batch No."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(10; "Sub Assembly Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(11; "Rating Per Accepted Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Rating Per Accepted UD Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Rating Per Rework Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Rating Per Rejected Qty."; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Quality Before Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Purchase Consignment No."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(17; "Assay Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(25; "Posted IDS. No. Is IDS No."; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Equipment No."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(27; "Calibration Procedure No."; Code[20])
        {
            TableRelation = "No. Series".Code;
            DataClassification = CustomerContent;
        }
        field(60001; "Rejected IR No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

