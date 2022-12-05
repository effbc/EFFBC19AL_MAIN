table 60050 "Shortage Temp"
{
    DataCaptionFields = "Item No.", Description;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            NotBlank = false;
            TableRelation = Item WHERE("No." = FIELD("Item No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get(Item."No.") then begin
                    "Lead Time" := Item."Safety Lead Time";
                    Description := Item.Description;
                    "Unit of Measure" := Item."Base Unit of Measure";
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Shortage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Lead Time"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Suitable Vendor"; Code[20])
        {
            TableRelation = Vendor WHERE (Blocked=FILTER(<>All));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Vendor.Get("Suitable Vendor") then
                    "Vendor Name" := Vendor.Name;
            end;
        }
        field(6; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(7; "Production  Orders"; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(8; "Purchase Orders"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Planned Purchase Date (WOB)"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Planned Purchase Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Minimum Order Qty."; Decimal)
        {
            CalcFormula = Lookup(Item."Minimum Order Quantity" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(12; "Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Minimum Order Quanity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; Authorisation; Option)
        {
            OptionMembers = Open,WFA,Authorised;
            DataClassification = CustomerContent;
        }
        field(15; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Earliest Required Day"; Date)
        {
            CalcFormula = Min("Item Lot Numbers"."Material Required Date" WHERE("Item No" = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(17; "Present Week"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Overall Requirement"; Decimal)
        {
            Caption = 'Overall Shoratge';
            DataClassification = CustomerContent;
        }
        field(20; "Next 15 Days"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; "In One Month"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Below Present Week"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Next Week"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "This Week"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Product Group Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Product Group Code Cust" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(27; "Required  Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; "Qty. In Material Issues"; Decimal)
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(29; "Earliest Mat. Req. Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Qty. In Stores"; Decimal)
        {
            CalcFormula = Lookup(Item."Stock at Stores" WHERE("No." = FIELD("Item No.")));
            FieldClass = FlowField;
        }
        field(31; "Qty. In MCH"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Qty. In R&D"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = CONST('R&D STR')));
            FieldClass = FlowField;
        }
        field(33; "Qty. In CS"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("Item No."),
                                                                              "Location Code" = CONST('CS STR')));
            FieldClass = FlowField;
        }
        field(34; "Get From R&D"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Get From CS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Purchase Time Slot"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Qty Under Inspection"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(38; "Final Mat. Req. Date"; Date)
        {
            CalcFormula = Max("Prod. Order Component"."Production Plan Date" WHERE("Item No." = FIELD("Item No."),
                                                                                    "Production Plan Date" = FILTER(<> 0D)));
            FieldClass = FlowField;
        }
        field(39; "Complicarted Item"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Type Of Item"; Option)
        {
            OptionMembers = Normal,Ordered,Alternate,MOQ,Problematic;
            DataClassification = CustomerContent;
        }
        field(41; "Alternate Item"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(42; Difference; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(43; "Accepted By Purchase"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(44; "Not Needed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(45; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(47; "Alternated Item"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(48; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(49; "Possible Procurement Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50; "Possible Procured Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Change Plan"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52; "Don't Repeat"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(53; Reason; Option)
        {
            OptionMembers = Null,"Ordered in Other Store","Within Buffer","Unit of Measure Mismatch","Plan Shifted","As Per Process not Effecteed to Production";
            DataClassification = CustomerContent;
        }
        field(54; "Tax Structure"; Text[30])
        {
            //TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(55; Neditemsqty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(56; "Total PO Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(57; "Qty. In PROD"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(58; "Req Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
        }
        key(Key2; "Total Cost", "Lead Time", "Item No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        TestField("Item No.", '');
    end;

    var
        Vendor: Record Vendor;
        Item: Record Item;
}

