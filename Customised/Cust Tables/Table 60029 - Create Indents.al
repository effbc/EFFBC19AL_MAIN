table 60029 "Create Indents"
{
    DataClassification = CustomerContent;
    // version POAU

    // Project : B2B Pharma
    // Sign    : NSS - N.S.S.V.PRASAD
    // 
    // S.L.No.  Date      Sign  Description
    // ------------------------------------------
    // 1.0      13/12/06  NSS    New Field "Manufacturer Code"(12) is Added


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Indent No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Indent Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Indent Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Indent,Enquiry,Offer,Order,Cancel,Closed';
            OptionMembers = Indent,Enquiry,Offer,"Order",Cancel,Closed;
            DataClassification = CustomerContent;
        }
        field(7; "Accept Action Message"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Release Status"; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,Cancel,Closed;
            DataClassification = CustomerContent;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Release date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(11; "ICN No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Manufacturer Code"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(15; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(16; Remarks; Text[50])
        {
            CalcFormula = Lookup("Indent Line".Remarks WHERE("Document No." = FIELD("Indent No."),
                                                              "Line No." = FIELD("Indent Line No."),
                                                              "No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(17; "Last Modified date"; Date)
        {
            CalcFormula = Lookup("Indent Header"."Last Modified Date" WHERE("No." = FIELD("Indent No.")));
            FieldClass = FlowField;
        }
        field(38; Department; Code[20])
        {
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(60100; "Project Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60101; "Production Order Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60102; "Production Start date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60103; "Suitable Vendor"; Code[20])
        {
            TableRelation = Vendor WHERE(Blocked = FILTER(<> All));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Vendor.Get("Suitable Vendor") then
                    "Suitable Vendor Name" := Vendor.Name;
            end;
        }
        field(60104; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60105; "Suitable Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60106; Make; Code[30])
        {
            TableRelation = "Indent Line".Make WHERE("Document No." = FIELD("Indent No."),
                                                      "Line No." = FIELD("Indent Line No."));
            DataClassification = CustomerContent;
        }
        field(60107; "Purchase Remarks"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60108; "Stock At Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(60109; "Stock At CS Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('CS STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'CS STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(60110; "Stock At RD Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('R&D STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'R&D STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(60111; "Stock At MCH Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('MCH')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "Item No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'MCH');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(60112; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Item,Miscellaneous,Description, ,G/L Account,Fixed Asset';
            OptionMembers = Item,Miscellaneous,Description," ","G/L Account","Fixed Asset";
        }
        field(60113; "Part Number"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.", "Indent No.", "Indent Line No.")
        {
        }
        key(Key2; "Suitable Vendor", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Vendor: Record Vendor;
        ItemLedgEntry: Record "Item Ledger Entry";
        QualityItemLedgEntry: Record "Quality Item Ledger Entry";
}

