table 33000928 "Sale/ Schedule Item Change Log"
{
    DataClassification = CustomerContent;
    // version UPG1.3

    // No. sign   Description
    // ---------------------------------------------------
    // 1.3 UPG    BOM Replacement process created this object.


    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            Editable = false;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(3; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            Editable = false;
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                           "Document No." = FIELD("Sales Order No."));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(8; "Schedule Line No."; Integer)
        {
            Caption = 'Schedule Line No.';
            Editable = false;
            TableRelation = Schedule2."Line No." WHERE("Document No." = FIELD("Sales Order No."),
                                                        "Document Line No." = FIELD("Sales Order Line No."),
                                                        "Document Type" = CONST(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(10; "RPO No."; Code[20])
        {
            Caption = 'RPO No.';
            Editable = false;
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(15; "Old Item No."; Code[20])
        {
            Caption = 'Old Item No.';
            Editable = false;
            TableRelation = Item WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(16; "New Item No."; Code[20])
        {
            Caption = 'New Item No.';
            Editable = false;
            TableRelation = Item WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(20; "Modified Datetime"; DateTime)
        {
            Caption = 'Modified Datetime';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(21; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            Editable = false;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
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

    trigger OnInsert();
    var
        SaleScheduleItemChangeLog: Record "Sale/ Schedule Item Change Log";
    begin
        if SaleScheduleItemChangeLog.FindLast then;
        "Entry No." := SaleScheduleItemChangeLog."Entry No." + 1;
        "Modified Datetime" := CurrentDateTime;
        "Modified By" := UserId;
    end;
}

