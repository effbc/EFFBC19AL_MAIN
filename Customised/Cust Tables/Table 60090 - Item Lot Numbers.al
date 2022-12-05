table 60090 "Item Lot Numbers"
{
    // version DRK

    DrillDownPageID = "Shortage Details";
    LookupPageID = "Shortage Details";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if item.Get("Item No") then begin
                    Description := item.Description;
                    "Unit Of Measure" := item."Base Unit of Measure";
                    "Lead Time2" := Format(item."Safety Lead Time");
                end;
            end;
        }
        field(2; "Planned Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; Shortage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Planned Purchase Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Suitable Vendor"; Code[20])
        {
            TableRelation = "Item Vendor"."Vendor No." WHERE("Item No." = FIELD("Item No"),
                                                              "Total Qty. Supplied" = FILTER(> 0));
            DataClassification = CustomerContent;
        }
        field(6; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Total := "Unit Cost" * Shortage;
            end;
        }
        field(7; "Production Orders"; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released),
                                                            "Prod Start date" = FIELD("Planned Date"));
            DataClassification = CustomerContent;
        }
        field(8; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Planned Purchase Dare (WOB)"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; Authorisation; Option)
        {
            OptionMembers = Open,WAP,CBP,WFA,Authorised,indent;
            DataClassification = CustomerContent;
        }
        field(11; "Minimum Order. Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Unit Of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Indent No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Production Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Sales Order No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Customer Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Product Type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; Product; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Material Required Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Possible Procured Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Possible Production Plan Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Material Required Day"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Lead Time"; DateFormula)
        {
            CalcFormula = Lookup(Item."Safety Lead Time" WHERE("No." = FIELD("Item No")));
            FieldClass = FlowField;
        }
        field(26; "Accepted By Purchase"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Within Buffer"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Alternated Item"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(29; "Lead Time2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(30; Total; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Vitual Purchase Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Virtual Vendor"; Code[10])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(33; "Virtual Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Virtual Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Virtual Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Prod. Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Prod. Order Comp Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No", "Planned Purchase Date", "Production Order No.", "Sales Order No.")
        {
            SumIndexFields = Shortage;
        }
        key(Key2; "Item No", "Planned Date")
        {
        }
        key(Key3; "Sales Order No.", "Item No")
        {
        }
        key(Key4; "Planned Purchase Date")
        {
        }
        key(Key5; "Sales Order No.", "Production Order No.")
        {
        }
        key(Key6; "Production Order No.", "Possible Production Plan Date")
        {
        }
        key(Key7; "Item No", "Material Required Date")
        {
        }
        key(Key8; Product, "Production Order No.")
        {
        }
        key(Key9; "Sales Order No.", Product, Authorisation, "Lead Time2", "Item No", "Planned Date")
        {
            SumIndexFields = Total;
        }
        key(Key10; "Vitual Purchase Date", "Item No")
        {
        }
        key(Key11; "Sales Order No.", "Product Type", "Production Order No.", Authorisation, "Lead Time2")
        {
        }
        key(Key12; "Item No", "Product Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        item: Record Item;
}

