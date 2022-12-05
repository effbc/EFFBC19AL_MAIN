table 60067 "Tender Competitor's Details"
{
    DataClassification = CustomerContent;
    // version B2B1.0


    fields
    {
        field(1; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Competitor's Code"; Code[20])
        {
            TableRelation = "Competitor's Master".Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Compettitors.Get("Competitor's Code");
                "Competitor's Name" := Compettitors."Competitor's Name";
            end;
        }
        field(3; "Competitor's Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Technical Details"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Other Details"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(23; Price; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(24; "BID Status"; Option)
        {
            OptionMembers = ,L1,L2,L3,L4,L5;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TCD.Reset;
                TCD.SetFilter(TCD."Tender No.", "Tender No.");
                TCD.SetFilter(TCD."BID Status", '%1', "BID Status");
                if TCD.FindSet then begin
                    // IF TCD.COUNT>1 THEN
                    Error('BID Status already exists');
                end;

                TH.Reset;
                TH.SetFilter(TH."Tender No.", "Tender No.");
                TH.SetFilter(TH."Tender Position", '%1', "BID Status");
                if TH.FindSet then begin
                    Error('BID Status already exists');
                end;
            end;
        }
        field(27; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(28; "Item Description"; Text[130])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(31; structure; Code[10])
        {
            //TableRelation = "Structure Header".Code;
            DataClassification = CustomerContent;
        }
        field(32; Percentage; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Schedule A Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Schedule B Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Schedule C Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Tender No.", "Competitor's Code", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Compettitors: Record "Competitor's Master";
        TCD: Record "Tender Competitor's Details";
        TH: Record "Tender Header";
}

