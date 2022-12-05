table 60063 "Tender Line"
{
    // version B2B1.0,DWS1.0,SH1.0

    DrillDownPageID = "Tender Subform";
    LookupPageID = "Tender Subform";
    DataClassification = CustomerContent;

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
        field(3; Type; Option)
        {
            OptionMembers = " ",Item,Resource,"G/L Account";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                // Added by Pranavi on 21-Jun-2016
                if Type <> Type::"G/L Account" then begin
                    TH.Reset;
                    TH.SetRange(TH."Tender No.", "Document No.");
                    if TH.FindFirst then begin
                        if TH.TenderType = TH.TenderType::AMC then
                            Error('You can select only G/L Account when Tender Type is AMC!');
                    end;
                end;
                // End by Pranavi
            end;
        }
        field(4; "No."; Code[20])
        {
            Description = 'Look up';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                ProductionBOMHeader: Record "Production BOM Header";
                VersionMgt: Codeunit VersionManagement;
            begin
                TestStatusOpen;
                case Type of
                    Type::" ":
                        begin
                            StdTxt.Get("No.");
                            Description := StdTxt.Description;
                        end;
                    Type::"G/L Account":
                        begin
                            // Added by Pranavi on 21-Jun-2016
                            if "No." <> '47503' then begin
                                TH.Reset;
                                TH.SetRange(TH."Tender No.", "Document No.");
                                if TH.FindFirst then begin
                                    if TH.TenderType = TH.TenderType::AMC then
                                        Error('You can select only G/L Account 47503-Servicing charges received when Tender Type is AMC!');
                                end;
                            end;
                            // End by Pranavi
                            GLAcc.Get("No.");
                            Description := GLAcc.Name;
                        end;
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Item.TestField(Blocked, false);
                            Description := Item.Description;
                            "Description 2" := Item."Description 2";
                            "Tax Group Code" := Item."Tax Group Code";
                            UOM := Item."Sales Unit of Measure";
                            if Item."Last Direct Cost" <> 0 then
                                "Unit Cost" := Item."Last Direct Cost"
                            else
                                "Unit Cost" := Item."Unit Cost";
                            "Production Bom No." := Item."Production BOM No.";
                            "Production Bom No." := Item."Production BOM No.";
                            ProductionBOMHeader.SetRange("No.", "Production Bom No.");
                            if ProductionBOMHeader.Find('-') then
                                "Production Bom Version No." := VersionMgt.GetBOMVersion(ProductionBOMHeader."No.", WorkDate, true);
                            //SH1.0
                            Schedule.Reset;
                            Schedule.SetRange("Document Type", Schedule."Document Type"::Tender);
                            Schedule.SetRange("Document No.", "Document No.");
                            Schedule.SetRange("Document Line No.", "Line No.");
                            Schedule.SetRange(Schedule."No.", xRec."No.");
                            if Schedule.Find('-') then begin
                                Schedule.Validate("No.", "No.");
                                Schedule.Modify;
                            end;
                            //SH1.0

                        end;
                    Type::Resource:
                        begin
                            Res.Get("No.");
                            Res.TestField(Blocked, false);
                            Res.TestField("Gen. Prod. Posting Group");
                            Description := Res.Name;
                            UOM := Res."Base Unit of Measure";
                            "Unit Cost" := Res."Unit Cost";
                        end;
                end;
            end;
        }
        field(5; Description; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(6; UOM; Code[10])
        {
            Description = 'Look up';
            Editable = true;
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Schedule: Record Schedule2;
            begin
                TestStatusOpen;
                "Total Amount" := Quantity * "Unit Cost";

                /*Schedule.RESET;
                Schedule.SETRANGE("Document Type",Schedule."Document Type" :: Tender);
                Schedule.SETRANGE("Document No.","Document No.");
                Schedule.SETRANGE("Document Line No.","Line No.");
                IF Schedule.FIND('-') THEN
                  ERROR('Scheduling is already done,delete the schedule lines if you want to modify qty');
                */

            end;
        }
        field(8; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Total Amount" := "Unit Cost" * Quantity;
                TestStatusOpen;
            end;
        }
        field(9; "Design Cost"; Decimal)
        {
            Description = 'Flow fields';
            DataClassification = CustomerContent;
        }
        field(10; "CRM Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Estimated Unit Cost"; Decimal)
        {
            CalcFormula = Sum("Design Worksheet Header"."Total Cost" WHERE("Document No." = FIELD("Document No."),
                                                                            "Document Type" = CONST(Tender),
                                                                            "Document Line No." = FIELD("Line No.")));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Estimated Total Unit Cost"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(23; "Cust. Estimated Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Cust.Estimated Total Cost" := "Cust. Estimated Unit Cost" * Quantity;
            end;
        }
        field(24; "Cust.Estimated Total Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Production Bom No."; Code[20])
        {
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;
        }
        field(26; "Production Bom Version No."; Code[20])
        {
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production Bom No."));
            DataClassification = CustomerContent;
        }
        field(201; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(202; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            Editable = false;
            TableRelation = "Tax Group";
            DataClassification = CustomerContent;
        }
        field(50001; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60112; "Type of Item"; Option)
        {
            OptionMembers = " ","Only Supply","Supply & Inst","Supply & Laying","Only Inst";
            DataClassification = CustomerContent;
        }
        field(60113; "Schedule No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "L1 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60115; "L2 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60116; "L3 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60117; "L4 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60118; "L5 Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "Schedule Type"; Option)
        {
            OptionCaption = '" ,A,B,C"';
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            SumIndexFields = "Total Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    var
        DesignworksheetHeader: Record "Design Worksheet Header";
        Schedule: Record Schedule2;
    begin
        TestStatusOpen;
        ArchieveTenderLine.Reset;
        ArchieveTenderLine.SetRange(ArchieveTenderLine."Document No.", "Document No.");
        //IF ArchieveTenderLine.FIND('-') THEN
        //ERROR('You Cannot Modify The Document Which Was Already Released');
        //b2b Cost1.0
        DesignworksheetHeader.Reset;
        DesignworksheetHeader.SetRange(DesignworksheetHeader."Document No.", "Document No.");
        DesignworksheetHeader.SetRange(DesignworksheetHeader."Document Type", DesignworksheetHeader."Document Type"::Tender);
        DesignworksheetHeader.SetRange(DesignworksheetHeader."Document Line No.", "Line No.");
        DesignworksheetHeader.DeleteAll(true);
        ArchieveTenderLine.Reset;
        ArchieveTenderLine.SetRange("Document No.", "Document No.");
        ArchieveTenderLine.SetRange("Line No.", "Line No.");
        if not ArchieveTenderLine.Find('-') then begin
            Schedule.Reset;
            Schedule.SetRange("Document No.", "Document No.");
            Schedule.SetRange("Document Line No.", "Line No.");
            Schedule.DeleteAll(true);
        end;
        //B2B Sgs
    end;

    trigger OnInsert();
    begin
        TestStatusOpen;
    end;

    trigger OnModify();
    begin
        TestStatusOpen;
        /*ArchieveTenderLine.RESET;
        ArchieveTenderLine.SETRANGE(ArchieveTenderLine."Document No.","Document No.");
        IF ArchieveTenderLine.FIND('-') THEN
        ERROR('You Cannot Modify The Document Which Was Already Released');
         */

    end;

    var
        GLAcc: Record "G/L Account";
        Item: Record Item;
        Res: Record Resource;
        StdTxt: Record "Standard Text";
        Schedule: Record Schedule2;
        ArchieveTenderLine: Record "Tender Line Archive";
        TH: Record "Tender Header";


    procedure TestStatusOpen();
    var
        TenderHeader: Record "Tender Header";
    begin
        TenderHeader.SetRange("Tender No.", "Document No.");
        if TenderHeader.Find('-') then
            TenderHeader.TestField(Status, TenderHeader.Status::Open);
    end;
}

