table 60041 "RGP In Line"
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
        field(3; "RGP Out Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "RGP Out Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; Type; Option)
        {
            OptionCaption = '" ,Item,Fixed Asset",';
            OptionMembers = " ",Item,"Fixed Asset";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;

                if xRec.Type <> Type then begin
                    "MRIR No." := '';
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
                ;
            end;
        }
        field(10; "Expected Return Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Quantity to Recieve"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Entry No."; Integer)
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
                ;
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
                ;
            end;
        }
        field(27; "MRIR No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Inspection Receipt Header"."No." WHERE(Status = CONST(false),
                                                                                           "Item No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(28; Status; Option)
        {
            Description = 'Calibration';
            OptionCaption = 'Not Posted,Posted';
            OptionMembers = "Not Posted",Posted;
            DataClassification = CustomerContent;
        }
        field(29; "RET/NRET"; Option)
        {
            OptionMembers = Returnable,"Non-Returnable";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                ;
            end;
        }
        field(30; "Material Group"; Code[20])
        {
            TableRelation = "Product Group Cust";//EFFUPG
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                ;
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
        field(33; "Submited TO (dept)"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Submition Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Exp. Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Exp.Incurred"; Decimal)
        {
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

    trigger OnDelete();
    begin
        TestStatusOpen;
    end;

    var
        RGPInHeaderRelease: Record "RGP In Header";


    local procedure TestStatusOpen();
    begin
        RGPInHeaderRelease.SetRange("RGP In No.", "Document No.");
        if RGPInHeaderRelease.Find('-') then
            RGPInHeaderRelease.TestField("Release Status", RGPInHeaderRelease."Release Status"::Open);
    end;
}

