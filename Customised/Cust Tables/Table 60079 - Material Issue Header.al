table 60079 "Material Issue Header"
{
    // version ,Rev01

    DrillDownPageID = "Material Issue List-1";
    LookupPageID = "Material Issue List-1";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    InventroySetup.Get;
                    NoSeriesMgt.TestManual(InventroySetup."Posted Issue No.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Transfer-from Code"; Code[10])
        {
            Caption = 'Transfer-from Code';
            Description = 'Where Subcontracting = No';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Subcontracting Location" = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
            end;
        }
        field(3; "Transfer-from Name"; Text[50])
        {
            Caption = 'Transfer-from Name';
            DataClassification = CustomerContent;
        }
        field(4; "Transfer-from Name 2"; Text[50])
        {
            Caption = 'Transfer-from Name 2';
            DataClassification = CustomerContent;
        }
        field(5; "Transfer-from Address"; Text[50])
        {
            Caption = 'Transfer-from Address';
            DataClassification = CustomerContent;
        }
        field(6; "Transfer-from Address 2"; Text[50])
        {
            Caption = 'Transfer-from Address 2';
            DataClassification = CustomerContent;
        }
        field(7; "Transfer-from Post Code"; Code[20])
        {
            Caption = 'Transfer-from Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(8; "Transfer-from City"; Text[30])
        {
            Caption = 'Transfer-from City';
            DataClassification = CustomerContent;
        }
        field(9; "Transfer-from County"; Text[30])
        {
            Caption = 'Transfer-from County';
            DataClassification = CustomerContent;
        }
        field(10; "Transfer-from Country Code"; Code[10])
        {
            Caption = 'Transfer-from Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(11; "Transfer-to Code"; Code[10])
        {
            Caption = 'Transfer-to Code';
            Description = 'Where Subcontracting = No';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false),
                                            "Subcontracting Location" = CONST(false));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Location: Record Location;
                Confirmed: Boolean;
            begin
            end;
        }
        field(12; "Transfer-to Name"; Text[50])
        {
            Caption = 'Transfer-to Name';
            DataClassification = CustomerContent;
        }
        field(13; "Transfer-to Name 2"; Text[50])
        {
            Caption = 'Transfer-to Name 2';
            DataClassification = CustomerContent;
        }
        field(14; "Transfer-to Address"; Text[50])
        {
            Caption = 'Transfer-to Address';
            DataClassification = CustomerContent;
        }
        field(15; "Transfer-to Address 2"; Text[50])
        {
            Caption = 'Transfer-to Address 2';
            DataClassification = CustomerContent;
        }
        field(16; "Transfer-to Post Code"; Code[20])
        {
            Caption = 'Transfer-to Post Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(17; "Transfer-to City"; Text[30])
        {
            Caption = 'Transfer-to City';
            DataClassification = CustomerContent;
        }
        field(18; "Transfer-to County"; Text[30])
        {
            Caption = 'Transfer-to County';
            DataClassification = CustomerContent;
        }
        field(19; "Transfer-to Country Code"; Code[10])
        {
            Caption = 'Transfer-to Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(23; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            DataClassification = CustomerContent;
        }
        field(24; Comment; Boolean)
        {
            CalcFormula = Exist("Inventory Comment Line" WHERE("Document Type" = CONST("Transfer Order"),
                                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(26; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(28; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60001; "Prod. Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Service Item No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Item"."No.";
            DataClassification = CustomerContent;
        }
        field(60004; "Customer No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(60005; "Prod. BOM No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
                ProductionBOMHeader: Record "Production BOM Header";
            begin
            end;
        }
        field(60006; "Resource Name"; Text[50])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60007; "User ID"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60008; "Required Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "Operation No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                ProductionOrderLine: Record "Prod. Order Line";
            begin
            end;
        }
        field(60010; "Due Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60011; "Released Date"; Date)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60012; "Released By"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60013; "Sales Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order),
                                                        Status = FILTER(Released));
            DataClassification = CustomerContent;
        }
        field(60014; "Service Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Header"."Document Type";
            DataClassification = CustomerContent;
        }
        field(60015; "Material Issue No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60016; "Released Time"; Time)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60017; "Reason Code"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60018; "Proj Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "No." = '' then begin
            InventroySetup.Get;
            InventroySetup.TestField("Posted Issue No.");
            NoSeriesMgt.InitSeries(InventroySetup."Posted Issue No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        InventroySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
}

