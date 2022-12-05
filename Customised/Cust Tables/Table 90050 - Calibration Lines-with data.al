table 90050 "Calibration Lines-with data"
{
    // version B2B1.0,Rev01

    Caption = 'Material Issues';
    LookupPageID = "RD Material Returns";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
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
                //TESTFIELD("Production Bom No.","Production Bom No."::"0");
                if ("Transfer-from Code" = "Transfer-to Code") and
                   ("Transfer-from Code" <> '')
                then
                    Error(
                      Text001,
                      FieldCaption("Transfer-from Code"), FieldCaption("Transfer-to Code"),
                      TableCaption, "No.");
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
                /*
                TESTFIELD("Production Bom No.","Production Bom No."::"0");
                IF ("Transfer-from Code" = "Transfer-to Code") AND
                   ("Transfer-to Code" <> '')
                THEN
                  ERROR(
                    Text001,
                    FIELDCAPTION("Transfer-from Code"),FIELDCAPTION("Transfer-to Code"),
                    TABLECAPTION,"No.");
                */

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

            trigger OnValidate();
            begin
                //TESTFIELD("Production Bom No.","Production Bom No."::"0");
            end;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                TESTFIELD("Production Bom No.","Production Bom No."::"0");
                "Prod.OrderLine".SETRANGE("Prod.OrderLine"."Prod. Order No.","Prod. Order No.");
                "Prod.OrderLine".SETRANGE("Prod.OrderLine"."Line No.","Prod. Order Line No.");
                IF "Prod.OrderLine".FIND('-') THEN BEGIN
                  "Due Date" := "Prod.OrderLine"."Starting Date";
                END;
                */

            end;
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

            trigger OnValidate();
            begin
                //TESTFIELD("Production Bom No.","Production Bom No."::"0");
            end;
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

            trigger OnValidate();
            begin
                //TESTFIELD("Production Bom No.","Production Bom No."::"0");
            end;
        }
        field(60014; "Service Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Header"."Document Type";
            DataClassification = CustomerContent;
        }
        field(60016; "Released Time"; Time)
        {
            Description = 'B2B';
            Editable = false;
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

    trigger OnDelete();
    var
        TransLine: Record "Transfer Line";
        InvtCommentLine: Record "Inventory Comment Line";
    begin
        /*
        TESTFIELD("Production Bom No.","Production Bom No."::"0");
        TOMaterialIssueLine.SETRANGE("Document No.","No.");
        IF TOMaterialIssueLine.FIND('-') THEN
          TOMaterialIssueLine.DELETEALL;
        
        ItemJnlLine.SETRANGE("Journal Template Name",'TRANSFER');
        ItemJnlLine.SETRANGE("Journal Batch Name",'DEFAULT');
        ItemJnlLine.SETRANGE("Document No.","No.");
        ItemJnlLine.DELETEALL;
        */

    end;

    trigger OnInsert();
    begin
        InvSetup.Get;
        if "No." = '' then begin
            InvSetup.TestField(InvSetup."Material Issues No.");
            NoSeriesMgt.InitSeries(InvSetup."Material Issues No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "User ID" := UserId;
        if User.Get("User ID") then
            "Resource Name" := User."User Name";//B2B
    end;

    trigger OnModify();
    begin
        //TESTFIELD(Status,Status::Open);
    end;

    var
        Text000: Label 'You cannot rename a %1.';
        Text001: Label '%1 and %2 cannot be the same in %3 %4.';
        Text002: Label 'Do you want to change %1?';
        Text003: Label 'The transfer order %1 has been deleted.';

        Text13000: Label 'Structure code cannot be changed';
        InvSetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit 396;
        User: Record User;
        TOMaterialIssueLine: Record "TO Material Issue Line";
        ItemJnlLine: Record "Item Journal Line";
        "Prod.Order": Record "Production Order";
        "Prod.OrderLine": Record "Prod. Order Line";


    procedure AssistEdit(OLDMIH: Record "Item Design Worksheet Header"): Boolean;
    var
        ToMaterialIssueHeader: Record "Item Design Worksheet Header";
    begin
        /*
        WITH ToMaterialIssueHeader DO BEGIN
          //ToMaterialIssueHeader := Rec;
          InvSetup.GET;
          InvSetup.TESTFIELD(InvSetup."Material Issues No.");
          IF NoSeriesMgt.SelectSeries(InvSetup."Material Issues No.",OLDMIH."No. Series","No. Series") THEN BEGIN
            InvSetup.GET;
            InvSetup.TESTFIELD(InvSetup."Material Issues No.");
            NoSeriesMgt.SetSeries("No.");
            Rec := ToMaterialIssueHeader;
            EXIT(TRUE);
          END;
        END;
        */

    end;


    procedure "CopyProd.OrderComponents"();
    var
        ProdOrderLines: Record "Prod. Order Line";
        ToTransferLine: Record "Item Journal Line";
        "TransferLineNo.": Integer;
        ProdOrderLineComp: Record "Prod. Order Component";
        Item: Record Item;
        BOMHeader: Record "Production BOM Header";
        BOMLine: Record "Production BOM Line";
        ProdOrderLine1: Record "Prod. Order Line";
    begin
        TestField("No.");
        TestField("Prod. Order No.");
        TestField("Prod. Order Line No.");
        //TESTFIELD("Production Bom No.","Production Bom No.":: "0");
        ToTransferLine.SetRange("Journal Template Name", 'TRANSFER');
        ToTransferLine.SetRange("Journal Batch Name", 'DEFAULT');
        ToTransferLine.SetCurrentKey("Line No.");
        if ToTransferLine.Find('+') then
            "TransferLineNo." := ToTransferLine."Line No."
        else
            "TransferLineNo." := 0;
        ProdOrderLineComp.Reset;
        ProdOrderLineComp.SetRange(Status, ProdOrderLineComp.Status::Released);
        ProdOrderLineComp.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderLineComp.SetRange("Prod. Order Line No.", "Prod. Order Line No.");
        ProdOrderLineComp.SetFilter("Remaining Quantity", '<>0');
        if ProdOrderLineComp.Find('-') then
            repeat
                if Item.Get(ProdOrderLineComp."Item No.") then;
                ToTransferLine.Init;
                "TransferLineNo." := "TransferLineNo." + 10000;
                ToTransferLine."Journal Template Name" := 'TRANSFER';
                ToTransferLine."Journal Batch Name" := 'DEFAULT';
                ToTransferLine."Entry Type" := ToTransferLine."Entry Type"::Transfer;
                ToTransferLine."Transfer Type" := ToTransferLine."Transfer Type"::"Material Issue";
                ToTransferLine."Document No." := "No.";
                ToTransferLine."Item No." := ProdOrderLineComp."Item No.";
                ToTransferLine.Validate(ToTransferLine."Item No.");
                ToTransferLine."Line No." := "TransferLineNo.";
                ToTransferLine."Unit of Measure Code" := ProdOrderLineComp."Unit of Measure Code";
                ToTransferLine."Location Code" := "Transfer-from Code";
                ToTransferLine."New Location Code" := "Transfer-to Code";
                //ToTransferLine."Posting Date" := "Installation Cost";
                ProdOrderLineComp.CalcFields(ProdOrderLineComp."Qty Copied", ProdOrderLineComp."Qty Posted");
                //KNR
                ToTransferLine."Quantity." := ProdOrderLineComp."Expected Quantity" -
                            (ProdOrderLineComp."Qty Copied" + ProdOrderLineComp."Qty Posted");

                ToTransferLine.Quantity := ProdOrderLineComp."Expected Quantity" -
                            (ProdOrderLineComp."Qty Copied" + ProdOrderLineComp."Qty Posted");

                ToTransferLine.Validate(Quantity);

                ToTransferLine."ITL Doc No." := ProdOrderLineComp."Prod. Order No.";
                ToTransferLine."ITL Doc Line No." := ProdOrderLineComp."Prod. Order Line No.";
                ToTransferLine."ITL Doc Ref Line No." := ProdOrderLineComp."Line No.";
                if ToTransferLine.Quantity > 0 then
                    ToTransferLine.Insert;
            until ProdOrderLineComp.Next = 0;
    end;
}

