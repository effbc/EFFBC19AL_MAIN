tableextension 70086 TransferHeaderExt extends "Transfer Header"
{
    fields
    {

        field(60001; "Prod. Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production Order"."No." WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(60002; "Prod. Order Line No."; Integer)
        {
            Description = 'B2B';
            TableRelation = "Prod. Order Line"."Line No." WHERE("Prod. Order No." = FIELD("Prod. Order No."),
                                                                 Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
                ProdOrderLine.SetRange("Line No.", "Prod. Order Line No.");
                if ProdOrderLine.Find('-') then begin
                    "Due Date" := ProdOrderLine."Due Date";
                    "Prod. BOM No." := ProdOrderLine."Production BOM No.";
                end;
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
                ProductionOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
                ProductionOrderLine.SetRange("Line No.", "Prod. Order Line No.");
                if ProductionOrderLine.Find('-') then begin
                    ProductionBOMHeader.SetRange("No.", ProductionOrderLine."Production BOM No.");
                    if ProductionBOMHeader.Find('-') then begin
                        if PAGE.RunModal(0, ProductionBOMHeader) = ACTION::LookupOK then begin
                            "Prod. BOM No." := ProductionBOMHeader."No.";
                        end;
                    end;
                end;
            end;
        }
        field(60006; "Resource Name"; Text[50])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                IF PAGE.RUNMODAL(5201,Employee) = ACTION::LookupOK THEN
                  "Resource Name" := Employee."First Name";
                */

            end;
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
                ProductionOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
                ProductionOrderLine.SetRange("Line No.", "Prod. Order Line No.");
                if ProductionOrderLine.Find('-') then
                    ProdOrderRoutingLine.SetRange(Status, ProductionOrderLine.Status);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", ProductionOrderLine."Prod. Order No.");
                ProdOrderRoutingLine.SetRange("Routing Reference No.", ProductionOrderLine."Line No.");
                if ProdOrderRoutingLine.Find('-') then
                    if PAGE.RunModal(0, ProdOrderRoutingLine) = ACTION::LookupOK then begin
                        "Operation No." := ProdOrderRoutingLine."Operation No.";
                        "Due Date" := ProdOrderRoutingLine."Starting Date";
                    end;
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
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
            DataClassification = CustomerContent;
        }
        field(60014; "Service Order No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Header"."No.";
            DataClassification = CustomerContent;
        }
        field(60015; "Released Time"; Time)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60016; "Req Date Time"; DateTime)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TransHeader."Req Date Time" := CurrentDateTime;
            end;
        }
        field(60017; "CST Status"; Enum "CST Status")
        {
            DataClassification = CustomerContent;

        }
        field(60018; "Created Date Time"; DateTime)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60019; "Way Bill No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }


    trigger OnAfterInsert()
    begin
        "User ID" := UserId;
        "Created Date Time" := CurrentDateTime;
        /* IF User.GET("User ID") THEN
        "Resource Name" := User."User Name";// Changed User."Name" to User."User Name" B2B
        "Transfer-from Code" := 'PROD';
        "Transfer-to Code" := 'EFFE TEL';
        "In-Transit Code" := 'MIT-OUT'; */
    end;

    var
        "--b2B--": Integer;
        User: Record User;
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderLine: Record "Prod. Order Line";
        Employee: Record Employee;
        TransHeader: Record "Transfer Header";



    PROCEDURE "CopyProd.OrderComponents"();
    VAR
        ProdOrderLines: Record "Prod. Order Line";
        ToTransferLine: Record "Transfer Line";
        "TransferLineNo.": Integer;
        ProdOrderLineComp: Record "Prod. Order Component";
        Item: Record Item;
        BOMHeader: Record "Production BOM Header";
        BOMLine: Record "Production BOM Line";
        ProdOrderLine1: Record "Prod. Order Line";
    BEGIN
        TestField("No.");
        TestField("Prod. Order No.");
        TestField("Prod. Order Line No.");
        TestField(Status, Status::Open);
        ToTransferLine.SetRange("Document No.", "No.");
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
                ToTransferLine."Document No." := "No.";
                ToTransferLine."Item No." := ProdOrderLineComp."Item No.";
                ToTransferLine.Validate(ToTransferLine."Item No.");
                ToTransferLine."Line No." := "TransferLineNo.";
                ToTransferLine."Unit of Measure" := ProdOrderLineComp."Unit of Measure Code";
                ToTransferLine.Quantity := ProdOrderLineComp."Remaining Quantity";
                ToTransferLine.Validate(Quantity);
                ToTransferLine."Prod. Order No." := ProdOrderLineComp."Prod. Order No.";
                ToTransferLine."Prod. Order Line No." := ProdOrderLineComp."Prod. Order Line No.";
                ToTransferLine."Prod. Order Comp. Line No." := ProdOrderLineComp."Line No.";
                ToTransferLine.Copy := true;
                ProdOrderLine1.SetRange("Prod. Order No.", ToTransferLine."Prod. Order No.");
                ProdOrderLine1.SetRange(ProdOrderLine1."Line No.", ToTransferLine."Prod. Order Line No.");
                if ProdOrderLine1.Find('-') then begin
                    BOMLine.SetRange("Production BOM No.", ProdOrderLine1."Production BOM No.");
                    BOMLine.SetRange("No.", ToTransferLine."Item No.");
                    if BOMLine.Find('-') then begin
                        if (BOMLine."Allow Excess Qty.") then
                            ToTransferLine."Allow Excess Qty." := true;
                    end;
                end;
                ToTransferLine.Insert;
            until ProdOrderLineComp.Next = 0;
        Modify;
    END;


    PROCEDURE "CopyProd.OrdRoutingComponents"();
    VAR
        ProdOrderLines: Record "Prod. Order Line";
        ToTransferLine: Record "Transfer Line";
        "TransferLineNo.": Integer;
        ProdOrderLineComp: Record "Prod. Order Component";
        Item: Record Item;
        BOMHeader: Record "Production BOM Header";
        BOMLine: Record "Production BOM Line";
        ProdOrderLine1: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    BEGIN
        TestField("No.");
        TestField("Prod. Order No.");
        TestField("Prod. Order Line No.");
        TestField(Status, Status::Open);
        ToTransferLine.SetRange("Document No.", "No.");
        if ToTransferLine.Find('+') then
            "TransferLineNo." := ToTransferLine."Line No."
        else
            "TransferLineNo." := 0;


        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", "Prod. Order Line No.");
        ProdOrderRoutingLine.SetRange("Operation No.", "Operation No.");
        if ProdOrderRoutingLine.Find('-') then begin
            ProdOrderLineComp.Reset;
            ProdOrderLineComp.SetRange(Status, ProdOrderLineComp.Status::Released);
            ProdOrderLineComp.SetRange("Prod. Order No.", "Prod. Order No.");
            ProdOrderLineComp.SetRange("Prod. Order Line No.", "Prod. Order Line No.");
            ProdOrderLineComp.SetRange("Routing Link Code", ProdOrderRoutingLine."Routing Link Code");
            ProdOrderLineComp.SetFilter("Remaining Quantity", '<>0');
            if ProdOrderLineComp.Find('-') then
                repeat
                    if Item.Get(ProdOrderLineComp."Item No.") then;
                    ToTransferLine.Init;
                    "TransferLineNo." := "TransferLineNo." + 10000;
                    ToTransferLine."Document No." := "No.";
                    ToTransferLine."Item No." := ProdOrderLineComp."Item No.";
                    ToTransferLine.Validate(ToTransferLine."Item No.");
                    ToTransferLine."Line No." := "TransferLineNo.";
                    ToTransferLine."Unit of Measure" := ProdOrderLineComp."Unit of Measure Code";
                    ToTransferLine.Quantity := ProdOrderLineComp."Remaining Quantity";
                    ToTransferLine.Validate(Quantity);
                    ToTransferLine."Prod. Order No." := ProdOrderLineComp."Prod. Order No.";
                    ToTransferLine."Prod. Order Line No." := ProdOrderLineComp."Prod. Order Line No.";
                    ToTransferLine."Prod. Order Comp. Line No." := ProdOrderLineComp."Line No.";
                    ToTransferLine.Copy := true;
                    ProdOrderLine1.SetRange("Prod. Order No.", ToTransferLine."Prod. Order No.");
                    ProdOrderLine1.SetRange(ProdOrderLine1."Line No.", ToTransferLine."Prod. Order Line No.");
                    if ProdOrderLine1.Find('-') then begin
                        BOMLine.SetRange("Production BOM No.", ProdOrderLine1."Production BOM No.");
                        BOMLine.SetRange("No.", ToTransferLine."Item No.");
                        if BOMLine.Find('-') then begin
                            if (BOMLine."Allow Excess Qty.") then
                                ToTransferLine."Allow Excess Qty." := true;
                        end;
                    end;
                    ToTransferLine.Insert;
                until ProdOrderLineComp.Next = 0;
            Modify;
        end;
    END;


    PROCEDURE CheckOperationNo();
    BEGIN
        if "Operation No." <> '' then
            "CopyProd.OrdRoutingComponents"
        else
            "CopyProd.OrderComponents";
    END;


    PROCEDURE CopySalesOrderComponents();
    VAR
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ToTransferLine: Record "Transfer Line";
        "TransferLineNo.": Integer;
    BEGIN
        ToTransferLine.SetRange("Document No.", "No.");
        if ToTransferLine.Find('+') then
            "TransferLineNo." := ToTransferLine."Line No."
        else
            "TransferLineNo." := 0;

        SalesHeader.SetRange("No.", "Sales Order No.");
        if SalesHeader.Find('-') then
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.Find('-') then
            repeat
                ToTransferLine.Init;
                "TransferLineNo." := "TransferLineNo." + 10000;
                ToTransferLine."Document No." := "No.";
                ToTransferLine."Item No." := SalesLine."No.";
                ToTransferLine.Validate(ToTransferLine."Item No.");
                ToTransferLine."Line No." := "TransferLineNo.";
                ToTransferLine."Unit of Measure" := SalesLine."Unit of Measure";
                ToTransferLine.Quantity := SalesLine.Quantity;
                ToTransferLine.Validate(Quantity);
                ToTransferLine.Insert;
            until SalesLine.Next = 0;
    END;
}

