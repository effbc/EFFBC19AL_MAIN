table 33000272 "Inspect. Recpt. Accept Level"
{
    DataClassification = CustomerContent;
    // version QC1.1


    fields
    {
        field(1; "Inspection Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Quality Type"; Option)
        {
            OptionMembers = Accepted,"Accepted Under Deviation",Rework,Rejected;
            DataClassification = CustomerContent;
        }
        field(4; "Acceptance Code"; Code[20])
        {
            TableRelation = "Acceptance Level".Code WHERE(Type = FIELD("Quality Type"));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                AcptLevel.Get("Acceptance Code");
                "Reason Code" := AcptLevel."Reason Code";
            end;
        }
        field(5; "Reason Code"; Code[20])
        {
            TableRelation = "Quality Reason Code";
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(7; Type; Option)
        {
            OptionCaption = 'Accepted,Accepted Under Deviation,Rework,Rejected';
            OptionMembers = Accepted,"Accepted Under Deviation",Rework,Rejected;
            DataClassification = CustomerContent;
        }
        field(8; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(9; "Source Type"; Option)
        {
            OptionMembers = "In Bound",WIP;
            DataClassification = CustomerContent;
        }
        field(10; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(11; "Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(12; "Rework Level"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; Status; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Inspection Receipt No.", "Quality Type", "Line No.")
        {
        }
        key(Key2; "Quality Type", Quantity)
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Item No.", "Vendor No.", "Acceptance Code", "Quality Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        //TestStatus;
    end;

    trigger OnInsert();
    begin
        TestStatus;
        TestField(Quantity);
        TestField("Acceptance Code");
        "Item No." := InspectRcpt."Item No.";
        "Vendor No." := InspectRcpt."Vendor No.";
        "Source Type" := InspectRcpt."Source Type";
        "Production Order No." := InspectRcpt."Prod. Order No.";
        "Rework Level" := InspectRcpt."Rework Level";
    end;

    trigger OnModify();
    begin
        TestStatus;
        TestField(Quantity);
        TestField("Acceptance Code");
    end;

    var
        InspectRcpt: Record "Inspection Receipt Header";
        AcptLevel: Record "Acceptance Level";


    procedure TestStatus();
    begin
        InspectRcpt.Get("Inspection Receipt No.");
        InspectRcpt.TestField(Status, false);
    end;
}

