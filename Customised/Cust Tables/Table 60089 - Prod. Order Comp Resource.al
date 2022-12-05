table 60089 "Prod. Order Comp Resource"
{
    // version PCB

    DrillDownPageID = "Sales AMC1";
    LookupPageID = "Sales AMC1";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';


        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            TableRelation = "Production Order"."No." WHERE(Status = FIELD(Status));
            DataClassification = CustomerContent;
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            TableRelation = "Prod. Order Line"."Line No." WHERE(Status = FIELD(Status),
                                                                 "Prod. Order No." = FIELD("Prod. Order No."));
            DataClassification = CustomerContent;
        }
        field(5; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(10; "Serial No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("IDS Generated", false);
            end;
        }
        field(11; "Lot No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; Resource; Code[20])
        {
            TableRelation = "Machine Center";
            DataClassification = CustomerContent;
        }
        field(13; "ILE No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(14; "IDS Generated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Prod. Order Line No.", "Serial No.")
        {
        }
    }

    fieldgroups
    {
    }
}

