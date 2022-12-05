table 60052 "Defect Tracking Details"
{
    // version B2B1.0

    DrillDownPageID = "Defect Tracking";
    LookupPageID = "Defect Tracking";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "IDS No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                InspectionDataSH.SetRange("No.", "IDS No.");
                if InspectionDataSH.Find('-') then
                    "Receipt No." := InspectionDataSH."Receipt No.";
            end;
        }
        field(2; "IDS Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Component No."; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                IDSHeader: Record "Inspection Datasheet Header";
                "Prod.OrderLine": Record "Prod. Order Line";
                "Prod.BOMLine": Record "Production BOM Line";
                "Prod.OrdComponent": Record "Prod. Order Component";
                "Insp.RcptLine": Record "Inspection Receipt Line";
                InspRcptHeader: Record "Inspection Receipt Header";
                PIDSHeader: Record "Posted Inspect DatasheetHeader";
            begin
                IDSHeader.SetRange("No.", "IDS No.");
                if IDSHeader.Find('-') then begin
                    "Prod.OrderLine".SetRange("Prod. Order No.", IDSHeader."Prod. Order No.");
                    "Prod.OrderLine".SetRange("Line No.", IDSHeader."Prod. Order Line");
                    if "Prod.OrderLine".Find('-') then begin
                        "Prod.OrdComponent".SetRange("Prod. Order No.", "Prod.OrderLine"."Prod. Order No.");
                        "Prod.OrdComponent".SetRange("Prod. Order Line No.", "Prod.OrderLine"."Line No.");
                        if "Prod.OrdComponent".Find('-') then
                            if PAGE.RunModal(0, "Prod.OrdComponent") = ACTION::LookupOK then begin
                                "Component No." := "Prod.OrdComponent"."Item No.";
                                Position := "Prod.OrdComponent".Position;
                                "Position 2" := "Prod.OrdComponent"."Position 2";
                                "Position 3" := "Prod.OrdComponent"."Position 3";
                            end;
                    end;
                end else begin
                    PIDSHeader.SetRange("No.", "IDS No.");
                    if PIDSHeader.Find('-') then begin
                        "Prod.OrderLine".SetRange("Prod. Order No.", PIDSHeader."Prod. Order No.");
                        "Prod.OrderLine".SetRange("Line No.", PIDSHeader."Prod. Order Line");
                        if "Prod.OrderLine".Find('-') then begin
                            "Prod.OrdComponent".SetRange("Prod. Order No.", "Prod.OrderLine"."Prod. Order No.");
                            "Prod.OrdComponent".SetRange("Prod. Order Line No.", "Prod.OrderLine"."Line No.");
                            if "Prod.OrdComponent".Find('-') then
                                if PAGE.RunModal(0, "Prod.OrdComponent") = ACTION::LookupOK then begin
                                    "Component No." := "Prod.OrdComponent"."Item No.";
                                    Position := "Prod.OrdComponent".Position;
                                    "Position 2" := "Prod.OrdComponent"."Position 2";
                                    "Position 3" := "Prod.OrdComponent"."Position 3";
                                end;
                        end;
                    end;
                end;
                /*
                //b2b EFF
                IDSHeader.RESET;
                IDSHeader.SETRANGE("No.","IDS No.");
                IDSHeader.SETFILTER("Source Type",'In Bound');
                IF IDSHeader.FIND('-') THEN BEGIN
                  IF FORM.RUNMODAL(0,Item) = ACTION::LookupOK THEN
                    "Component No." := Item."No.";
                    "Spcification Code":= '';
                    "Spcification Description" := '';
                END;
                    ItemSpecification.RESET;
                    ItemSpecification.SETRANGE("Item No.",Rec."Component No.");
                    IF ItemSpecification.FIND('-') THEN BEGIN
                      "Spcification Code" := ItemSpecification."Specification Code";
                      "Spcification Description" := ItemSpecification.Description;
                    END;
                //b2b EFF
                */
                //B2B RS >> BEGIN
                if ItemRec.Get("Component No.") then
                    "Item Description" := ItemRec.Description;
                //B2B RS << END

            end;

            trigger OnValidate();
            begin
                ItemSpecification.Reset;
                ItemSpecification.SetRange("Item No.", Rec."Component No.");
                if ItemSpecification.Find('-') then begin
                    "Spcification Code" := ItemSpecification."Specification Code";
                    "Spcification Description" := ItemSpecification.Description;
                end;
            end;
        }
        field(4; "Defect Code"; Code[20])
        {
            TableRelation = "Defect Master".Code;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                DefectMaster.Get("Defect Code");
                Description := DefectMaster.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; Position; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Position 2"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Position 3"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "Spcification Code"; Code[20])
        {
            Description = 'b2b EFF';
            DataClassification = CustomerContent;
        }
        field(12; "Spcification Description"; Text[50])
        {
            Description = 'b2b EFF';
            DataClassification = CustomerContent;
        }
        field(13; Qty; Decimal)
        {
            Description = 'b2b EFF';
            DataClassification = CustomerContent;
        }
        field(14; "Disposition Actions"; Text[250])
        {
            Description = 'b2b EFF';
            DataClassification = CustomerContent;
        }
        field(15; "Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(16; "IR No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Serial No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                QILE.Reset;
                QILE.SetCurrentKey("Document No.", "Posting Date", "Item No.");
                QILE.SetRange("Document No.", "Receipt No.");
                if QILE.Find('-') then
                    if PAGE.RunModal(0, QILE) = ACTION::LookupOK then //QILE.FIND('-') THEN
                        "Serial No." := QILE."Serial No.";
            end;
        }
    }

    keys
    {
        key(Key1; "IDS No.", "IDS Line No.", "Line No.")
        {
        }
        key(Key2; "Defect Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        DefectMaster: Record "Defect Master";
        ItemSpecification: Record "Item Specification";
        Item: Record Item;
        ItemRec: Record Item;
        InspectionDataSH: Record "Inspection Datasheet Header";
        QILE: Record "Quality Item Ledger Entry";
}

