table 33000892 "Item Variant Cust"
{
    Caption = 'Item Variant';
    DataCaptionFields = "Item No.", Make, "Part No";
    LookupPageID = "Item Variants Cust";

    fields
    {
        field(1; Make; Code[30])
        {
            Caption = 'Make';
            NotBlank = true;
            TableRelation = Make.Make;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item."No.";
        }
        field(3; "Part No"; Code[30])
        {
            Caption = 'Part no';
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50000; "Product type"; Code[10])
        {
            TableRelation = "Item Sub Group".Code WHERE("Product Group Code" = CONST('FPRODUCT'));
        }
        field(50001; Package; Code[20])
        {
        }
        field(50002; "No. of Pins"; Integer)
        {
        }
        field(50003; "No. of Soldering Points"; Integer)
        {
        }
        field(50004; "Operating Temperature"; Text[20])
        {
        }
        field(50005; "Storage Temperature"; Text[20])
        {
        }
        field(50006; Humidity; Text[10])
        {
        }
        field(50007; "ESD Sensitive"; Boolean)
        {
        }
        field(50008; ESD; Code[20])
        {
        }
        field(50009; "Work area Temp &  Humadity"; Code[25])
        {
        }
        field(50010; "Soldering Time (Sec)"; Code[20])
        {
        }
        field(50011; "Soldering Temp."; Code[15])
        {
        }
        field(50012; Priority; Integer)
        {
        }
        field(50013; "Item Status"; Option)
        {
            OptionCaption = ' ,Active,NRND,Obsolete';
            OptionMembers = " ",Active,NRND,Obsolute;
        }
    }

    keys
    {
        key(Key1; "Item No.", Priority, Make)
        {
            Clustered = true;
        }
        key(Key2; Make)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ItemTranslation: Record "Item Translation";
        SKU: Record "Stockkeeping Unit";
        ItemIdent: Record "Item Identifier";
        ItemCrossReference: Record "Item Cross Reference";
       SalesPrice: Record "Sales Price";
        SalesLineDiscount: Record "Sales Line Discount";
        PurchasePrice: Record "Purchase Price";
        PurchaseLineDiscount: Record "Purchase Line Discount";
        BOMComp: Record "BOM Component";
        ItemJnlLine: Record "Item Journal Line";
        RequisitionLine: Record "Requisition Line";
        PurchOrderLine: Record "Purchase Line";
        SalesOrderLine: Record "Sales Line";
        ProdOrderComp: Record "Prod. Order Component";
        TransLine: Record "Transfer Line";
        ServiceLine: Record "Service Line";
        ProdBOMLine: Record "Production BOM Line";
        ServiceContractLine: Record "Service Contract Line";
        ServiceItem: Record "Service Item";
        AssemblyHeader: Record "Assembly Header";
        ItemSubstitution: Record "Item Substitution";
        ItemVend: Record "Item Vendor";
        PlanningAssignment: Record "Planning Assignment";
        ServiceItemComponent: Record "Service Item Component";
        BinContent: Record "Bin Content";
        ItemLedgerEntry: Record "Item Ledger Entry";
        ValueEntry: Record "Value Entry";
        AssemblyLine: Record "Assembly Line";
    begin

        BOMComp.RESET;
        BOMComp.SETCURRENTKEY(Type, "No.");
        BOMComp.SETRANGE(Type, BOMComp.Type::Item);
        BOMComp.SETRANGE("No.", "Item No.");
        BOMComp.SETRANGE("Variant Code", Make);
        IF NOT BOMComp.ISEMPTY THEN
            ERROR(Text001, Make, BOMComp.TABLECAPTION);

        ProdBOMLine.RESET;
        ProdBOMLine.SETCURRENTKEY(Type, "No.");
        ProdBOMLine.SETRANGE(Type, ProdBOMLine.Type::Item);
        ProdBOMLine.SETRANGE("No.", "Item No.");
        ProdBOMLine.SETRANGE("Variant Code", Make);
        IF NOT ProdBOMLine.ISEMPTY THEN
            ERROR(Text001, Make, ProdBOMLine.TABLECAPTION);

        ProdOrderComp.RESET;
        ProdOrderComp.SETCURRENTKEY(Status, "Item No.");
        ProdOrderComp.SETRANGE("Item No.", "Item No.");
        ProdOrderComp.SETRANGE("Variant Code", Make);
        IF NOT ProdOrderComp.ISEMPTY THEN
            ERROR(Text001, Make, ProdOrderComp.TABLECAPTION);

        IF ProdOrderExist THEN
            ERROR(Text002, "Item No.");

        AssemblyHeader.RESET;
        AssemblyHeader.SETCURRENTKEY("Document Type", "Item No.");
        AssemblyHeader.SETRANGE("Item No.", "Item No.");
        AssemblyHeader.SETRANGE("Variant Code", Make);
        IF NOT AssemblyHeader.ISEMPTY THEN
            ERROR(Text001, Make, AssemblyHeader.TABLECAPTION);

        AssemblyLine.RESET;
        AssemblyLine.SETCURRENTKEY("Document Type", Type, "No.");
        AssemblyLine.SETRANGE("No.", "Item No.");
        AssemblyLine.SETRANGE("Variant Code", Make);
        IF NOT AssemblyLine.ISEMPTY THEN
            ERROR(Text001, Make, AssemblyLine.TABLECAPTION);

        BinContent.RESET;
        BinContent.SETCURRENTKEY("Item No.");
        BinContent.SETRANGE("Item No.", "Item No.");
        BinContent.SETRANGE("Variant Code", Make);
        IF NOT BinContent.ISEMPTY THEN
            ERROR(Text001, Make, BinContent.TABLECAPTION);

        TransLine.RESET;
        TransLine.SETCURRENTKEY("Item No.");
        TransLine.SETRANGE("Item No.", "Item No.");
        TransLine.SETRANGE("Variant Code", Make);
        IF NOT TransLine.ISEMPTY THEN
            ERROR(Text001, Make, TransLine.TABLECAPTION);

        RequisitionLine.RESET;
        RequisitionLine.SETCURRENTKEY(Type, "No.");
        RequisitionLine.SETRANGE(Type, RequisitionLine.Type::Item);
        RequisitionLine.SETRANGE("No.", "Item No.");
        RequisitionLine.SETRANGE("Variant Code", Make);
        IF NOT RequisitionLine.ISEMPTY THEN
            ERROR(Text001, Make, RequisitionLine.TABLECAPTION);

        PurchOrderLine.RESET;
        PurchOrderLine.SETCURRENTKEY(Type, "No.");
        PurchOrderLine.SETRANGE(Type, PurchOrderLine.Type::Item);
        PurchOrderLine.SETRANGE("No.", "Item No.");
        PurchOrderLine.SETRANGE("Variant Code", Make);
        IF NOT PurchOrderLine.ISEMPTY THEN
            ERROR(Text001, Make, PurchOrderLine.TABLECAPTION);

        SalesOrderLine.RESET;
        SalesOrderLine.SETCURRENTKEY(Type, "No.");
        SalesOrderLine.SETRANGE(Type, SalesOrderLine.Type::Item);
        SalesOrderLine.SETRANGE("No.", "Item No.");
        SalesOrderLine.SETRANGE("Variant Code", Make);
        IF NOT SalesOrderLine.ISEMPTY THEN
            ERROR(Text001, Make, SalesOrderLine.TABLECAPTION);

        ServiceItem.RESET;
        ServiceItem.SETCURRENTKEY("Item No.", "Serial No.");
        ServiceItem.SETRANGE("Item No.", "Item No.");
        ServiceItem.SETRANGE("Variant Code", Make);
        IF NOT ServiceItem.ISEMPTY THEN
            ERROR(Text001, Make, ServiceItem.TABLECAPTION);

        ServiceLine.RESET;
        ServiceLine.SETCURRENTKEY(Type, "No.");
        ServiceLine.SETRANGE(Type, ServiceLine.Type::Item);
        ServiceLine.SETRANGE("No.", "Item No.");
        ServiceLine.SETRANGE("Variant Code", Make);
        IF NOT ServiceLine.ISEMPTY THEN
            ERROR(Text001, Make, ServiceLine.TABLECAPTION);

        ServiceContractLine.RESET;
        ServiceContractLine.SETRANGE("Item No.", "Item No.");
        ServiceContractLine.SETRANGE("Variant Code", Make);
        IF NOT ServiceContractLine.ISEMPTY THEN
            ERROR(Text001, Make, ServiceContractLine.TABLECAPTION);

        ServiceItemComponent.RESET;
        ServiceItemComponent.SETRANGE(Type, ServiceItemComponent.Type::Item);
        ServiceItemComponent.SETRANGE("No.", "Item No.");
        ServiceItemComponent.SETRANGE("Variant Code", Make);
        ServiceItemComponent.MODIFYALL("Variant Code", '');

        ItemJnlLine.RESET;
        ItemJnlLine.SETCURRENTKEY("Item No.");
        ItemJnlLine.SETRANGE("Item No.", "Item No.");
        ItemJnlLine.SETRANGE("Variant Code", Make);
        IF NOT ItemJnlLine.ISEMPTY THEN
            ERROR(Text001, Make, ItemJnlLine.TABLECAPTION);

        ItemLedgerEntry.RESET;
        ItemLedgerEntry.SETCURRENTKEY("Item No.");
        ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
        ItemLedgerEntry.SETRANGE("Variant Code", Make);
        IF NOT ItemLedgerEntry.ISEMPTY THEN
            ERROR(Text001, Make, ItemLedgerEntry.TABLECAPTION);

        ValueEntry.RESET;
        ValueEntry.SETCURRENTKEY("Item No.");
        ValueEntry.SETRANGE("Item No.", "Item No.");
        ValueEntry.SETRANGE("Variant Code", Make);
        IF NOT ValueEntry.ISEMPTY THEN
            ERROR(Text001, Make, ValueEntry.TABLECAPTION);

        /*ItemTranslation.SETRANGE("Item No.","Item No.");
        ItemTranslation.SETRANGE("Variant Code",Make);
        ItemTranslation.DELETEALL;
        
        ItemIdent.RESET;
        ItemIdent.SETCURRENTKEY("Item No.");
        ItemIdent.SETRANGE("Item No.","Item No.");
        ItemIdent.SETRANGE("Variant Code",Make);
        ItemIdent.DELETEALL;
         */

        ItemCrossReference.SETRANGE("Item No.", "Item No.");
        ItemCrossReference.SETRANGE("Variant Code", Make);
        ItemCrossReference.DELETEALL;

        ItemSubstitution.RESET;
        ItemSubstitution.SETRANGE(Type, ItemSubstitution.Type::Item);
        ItemSubstitution.SETRANGE("No.", "Item No.");
        ItemSubstitution.SETRANGE("Substitute Type", ItemSubstitution."Substitute Type"::Item);
        ItemSubstitution.SETRANGE("Variant Code", Make);
        ItemSubstitution.DELETEALL;

        ItemVend.RESET;
        ItemVend.SETCURRENTKEY("Item No.");
        ItemVend.SETRANGE("Item No.", "Item No.");
        ItemVend.SETRANGE("Variant Code", Make);
        ItemVend.DELETEALL;

        SalesPrice.RESET;
        SalesPrice.SETRANGE("Item No.", "Item No.");
        SalesPrice.SETRANGE("Variant Code", Make);
        SalesPrice.DELETEALL;

        SalesLineDiscount.RESET;
        SalesLineDiscount.SETRANGE(Code, "Item No.");
        SalesLineDiscount.SETRANGE("Variant Code", Make);
        SalesLineDiscount.DELETEALL;

        PurchasePrice.RESET;
        PurchasePrice.SETRANGE("Item No.", "Item No.");
        PurchasePrice.SETRANGE("Variant Code", Make);
        PurchasePrice.DELETEALL;

        PurchaseLineDiscount.RESET;
        PurchaseLineDiscount.SETRANGE("Item No.", "Item No.");
        PurchaseLineDiscount.SETRANGE("Variant Code", Make);
        PurchaseLineDiscount.DELETEALL;

        SKU.SETRANGE("Item No.", "Item No.");
        SKU.SETRANGE("Variant Code", Make);
        SKU.DELETEALL(TRUE);

        PlanningAssignment.RESET;
        PlanningAssignment.SETRANGE("Item No.", "Item No.");
        PlanningAssignment.SETRANGE("Variant Code", Make);
        PlanningAssignment.DELETEALL;

    end;

    var
        Text001: Label 'You cannot delete item variant %1 because there is at least one %2 that includes this Variant Code.';
        Text002: Label 'You cannot delete item variant %1 because there are one or more outstanding production orders that include this item.';

    local procedure ProdOrderExist(): Boolean
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.SETCURRENTKEY(Status, "Item No.");
        ProdOrderLine.SETRANGE("Item No.", "Item No.");
        ProdOrderLine.SETRANGE("Variant Code", Make);
        IF NOT ProdOrderLine.ISEMPTY THEN
            EXIT(TRUE);

        EXIT(FALSE);
    end;
}

