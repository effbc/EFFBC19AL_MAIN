table 60039 "RGP Out Line"
{
    DataClassification = CustomerContent;
    // version B2B1.0,Cal1.0


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionCaption = '" ,Item,Fixed Asset,,Calibration"';
            OptionMembers = " ",Item,"Fixed Asset",,Calibration;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                if xRec.Type <> Type then begin
                    "No." := '';
                    Description := '';
                    Quantity := 0;
                    UOM := '';
                    "Expected Return Date" := 0D;

                    "Vendor Shipment No." := '';
                    "Inspection Receipt No." := '';
                end;
            end;
        }
        field(6; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) Item."No."
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Item: Record Item;
                FixedAsset: Record "Fixed Asset";
            begin
                TestStatusOpen;
                if Type = Type::Item then begin
                    if Item.Get("No.") then begin
                        ;
                        Description := Item.Description;
                        UOM := Item."Base Unit of Measure";
                    end;
                end;
                if Type = Type::"Fixed Asset" then begin
                    if FixedAsset.Get("No.") then begin
                        ;
                        Description := FixedAsset.Description;
                    end;
                end;
            end;
        }
        field(7; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(9; UOM; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(10; "Expected Return Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Op No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(14; Remarks; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Production Order Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(21; "Production Order"; Code[20])
        {
            Editable = false;
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(22; "Drawing No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(23; "Operation No."; Code[20])
        {
            Editable = false;
            TableRelation = "Prod. Order Routing Line"."Operation No." WHERE("Prod. Order No." = FIELD("Production Order"),
                                                                              "Routing Reference No." = FIELD("Production Order Line No."),
                                                                              "Routing No." = FIELD("Routing No."));
            DataClassification = CustomerContent;
        }
        field(24; "Routing No."; Code[20])
        {
            Editable = false;
            TableRelation = "Routing Line"."Routing No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(25; "Sub Contracting Work"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Vendor Shipment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Inspection Receipt No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Inspection Receipt Header"."No." WHERE(Status = CONST(true),
                                                                                           "Item No." = FIELD("No."),
                                                                                           "Order No." = FIELD("Inspection Receipt No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                if InspectRcpt.Get("Inspection Receipt No.") then
                    "Inspection Receipt PO." := InspectRcpt."Order No.";
            end;
        }
        field(28; "Inspection Receipt PO."; Code[20])
        {
            Editable = true;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(29; "RET/NRET"; Option)
        {
            OptionMembers = Returnable,"Non-Returnable";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(30; "Material Group"; Code[20])
        {
            TableRelation = "Product Group Cust";//EFFUPG
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(31; "S.L.No."; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(32; Purpose; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(33; "DC No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Mode of Transport"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(35; "Sent-to-Person"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Exp.Incurred"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Inform-to-Person"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(38; "Inform-to-Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(39; Status; Option)
        {
            Description = 'Calibration';
            OptionCaption = 'Not Posted,Posted';
            OptionMembers = "Not Posted",Posted;
            DataClassification = CustomerContent;
        }
        field(40; "RGP In Document No."; Code[20])
        {
            Description = 'B2B(For Reverse Functionality)';
            DataClassification = CustomerContent;
        }
        field(41; "RGP In Line No."; Integer)
        {
            Description = 'B2B(For Reverse Functionality)';
            DataClassification = CustomerContent;
        }
        field(42; "Quantity to Recieve"; Decimal)
        {
            Description = 'B2B(For Reverse Functionality)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    var
        RGPHeader: Record "RGP Out Header";
    begin
    end;

    trigger OnModify();
    begin
        TestStatusOpen;
    end;

    var
        RGPOutHeader: Record "RGP Out Header";
        InspectRcpt: Record "Inspection Receipt Header";
        RGPOutHeaderRelease: Record "RGP Out Header";


    local procedure TestStatusOpen();
    begin
        RGPOutHeaderRelease.SetRange("RGP Out No.", "Document No.");
        if RGPOutHeaderRelease.Find('-') then
            RGPOutHeaderRelease.TestField("Release Status", RGPOutHeaderRelease."Release Status"::Open);
    end;
}

