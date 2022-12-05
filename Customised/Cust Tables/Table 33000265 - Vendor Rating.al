table 33000265 "Vendor Rating"
{
    DataClassification = CustomerContent;
    // version QC1.0


    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(5; Inspected; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header".Quantity WHERE("Vendor No." = FIELD("Vendor No."),
                                                                          "Item No." = FIELD("Item No."),
                                                                          "Posting Date" = FIELD("Date Filter"),
                                                                          "Rework Level" = CONST(0),
                                                                          Status = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Accepted; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header"."Qty. Accepted" WHERE("Vendor No." = FIELD("Vendor No."),
                                                                                 "Item No." = FIELD("Item No."),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Rework Level" = CONST(0),
                                                                                 Status = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Accepted UD"; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header"."Qty. Accepted Under Deviation" WHERE("Vendor No." = FIELD("Vendor No."),
                                                                                                 "Item No." = FIELD("Item No."),
                                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                                 "Rework Level" = CONST(0),
                                                                                                 Status = FILTER(true)));
            Description = 'Accepted Under Deviation';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Rework; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header"."Qty. Rework" WHERE("Vendor No." = FIELD("Vendor No."),
                                                                               "Item No." = FIELD("Item No."),
                                                                               "Posting Date" = FIELD("Date Filter"),
                                                                               "Rework Level" = CONST(0),
                                                                               Status = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; Reject; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header"."Qty. Rejected" WHERE("Vendor No." = FIELD("Vendor No."),
                                                                                 "Item No." = FIELD("Item No."),
                                                                                 "Posting Date" = FIELD("Date Filter"),
                                                                                 "Rework Level" = CONST(0),
                                                                                 Status = FILTER(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; "Date Filter"; Date)
        {
            Description = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }
}

