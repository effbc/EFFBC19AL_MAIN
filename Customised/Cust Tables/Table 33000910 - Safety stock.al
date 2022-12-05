table 33000910 "Safety stock"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Product; Code[20])
        {
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Item.Reset;
                if Item.Get(Product) then begin
                    Validate(Description, Item.Description);
                    Validate("Product type", Item."Item Sub Group Code");
                end;
            end;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Product type"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Product)
        {
        }
    }

    fieldgroups
    {
    }

    var
        PROD_QTY: Integer;
        PBMH: Record "Production BOM Header";
        PBMV: Record "Production BOM Version";
        pbml: Record "Production BOM Line";
        PBML2: Record "Production BOM Line";
        PBML3: Record "Production BOM Line";
        PBML4: Record "Production BOM Line";
        PBML5: Record "Production BOM Line";
        PBML6: Record "Production BOM Line";
        Version1: Code[30];
        Version2: Code[30];
        Version3: Code[30];
        Version4: Code[30];
        Version5: Code[30];
        Version6: Code[30];
        Item: Record Item;
        Dum: Record Item temporary;
        ItemNumber: Text[30];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        Row: Integer;
        SheetName: Text[250];


    procedure "Calc Safety Stock"();
    var
        SS: Record "Safety stock";
    begin
        Dum.DeleteAll;
        SS.Reset;
        SS.SetFilter(SS.Quantity, '>%1', 0);
        if SS.FindFirst then
            repeat

                PROD_QTY := SS.Quantity;

                PBMV.SetRange(PBMV."Production BOM No.", SS.Product);
                PBMV.SetRange(PBMV.Status, PBMV.Status::Certified);
                if PBMV.Find('+') then begin
                    Version1 := PBMV."Version Code";
                end;

                pbml.SetRange(pbml."Production BOM No.", SS.Product);
                pbml.SetRange(pbml."Version Code", Version1);
                if pbml.Find('-') then
                    repeat
                        PBMH.Reset;
                        if PBMH.Get(pbml."No.") then
                            Version2 := PBMH."Version Nos.";

                        PBML2.SetRange(PBML2."Production BOM No.", pbml."No.");
                        PBML2.SetRange(PBML2."Version Code", Version2);
                        if PBML2.Find('-') then begin
                            repeat
                                PBMH.Reset;
                                if PBMH.Get(PBML2."No.") then
                                    Version3 := PBMH."Version Nos.";

                                PBML3.SetRange(PBML3."Production BOM No.", PBML2."No.");
                                PBML3.SetRange(PBML3."Version Code", Version3);
                                if PBML3.Find('-') then begin
                                    repeat
                                        PBMH.Reset;
                                        if PBMH.Get(PBML3."No.") then
                                            Version4 := PBMH."Version Nos.";
                                        PBML4.SetRange(PBML4."Production BOM No.", PBML3."No.");
                                        PBML4.SetRange(PBML4."Version Code", Version4);
                                        if PBML4.Find('-') then begin
                                            repeat
                                                PBMH.Reset;
                                                if PBMH.Get(PBML4."No.") then
                                                    Version5 := PBMH."Version Nos.";
                                                PBML5.SetRange(PBML5."Production BOM No.", PBML4."No.");
                                                PBML5.SetRange(PBML5."Version Code", Version5);
                                                if PBML5.Find('-') then begin
                                                    repeat
                                                        PBMH.Reset;
                                                        if PBMH.Get(PBML5."No.") then
                                                            Version6 := PBMH."Version Nos.";
                                                        PBML6.SetRange(PBML6."Production BOM No.", PBML5."No.");
                                                        PBML6.SetRange(PBML6."Version Code", Version6);
                                                        if PBML6.Find('-') then begin
                                                            repeat
                                                                Overall_Requirement(PBML6."No.", PROD_QTY, pbml.Quantity, PBML2.Quantity, PBML3.Quantity,
                                                                                     PBML4.Quantity, PBML5.Quantity, PBML6.Quantity);
                                                            until PBML6.Next = 0;
                                                        end else
                                                            Overall_Requirement(PBML5."No.", PROD_QTY, pbml.Quantity, PBML2.Quantity, PBML3.Quantity,
                                                                                     PBML4.Quantity, PBML5.Quantity, 1);

                                                    until PBML5.Next = 0;
                                                end else
                                                    Overall_Requirement(PBML4."No.", PROD_QTY, pbml.Quantity, PBML2.Quantity, PBML3.Quantity,
                                                                              PBML4.Quantity, 1, 1);

                                            until PBML4.Next = 0;
                                        end else
                                            Overall_Requirement(PBML3."No.", PROD_QTY, pbml.Quantity, PBML2.Quantity, PBML3.Quantity, 1, 1, 1);
                                    until PBML3.Next = 0;
                                end else begin
                                    Overall_Requirement(PBML2."No.", PROD_QTY, pbml.Quantity, PBML2.Quantity, 1, 1, 1, 1);
                                end;
                            until PBML2.Next = 0;
                        end else begin
                            Overall_Requirement(pbml."No.", PROD_QTY, pbml.Quantity, 1, 1, 1, 1, 1);
                        end;
                    until pbml.Next = 0;
            until SS.Next = 0;

        //Dum.RESET;
        Item.Reset;
        Item.SetFilter(Item."Product Group Code Cust", '<>%1', 'CONSUME');
        Item.SetFilter(Item."Safety Stock Quantity", '>%1', 0);
        if Item.FindFirst then
            repeat
                Item."Safety Stock Quantity" := 0;
                Item.Modify;
            until Item.Next = 0;
        Dum.SetFilter(Dum."Budget Quantity", '>%1', 0);
        Dum.SetFilter(Dum."Product Group Code Cust", '<>%1', 'CONSUME');
        if Dum.FindFirst then begin
            TempExcelBuffer.DeleteAll;
            Clear(TempExcelBuffer);
            repeat
                Row += 1;
                Entercell(Row, 1, Format(Dum."No."), false);
                Entercell(Row, 2, Format(Dum."Budget Quantity"), false);
                Item.Reset;
                if Item.Get(Dum."No.") then begin
                    Item."Safety Stock Quantity" := Dum."Budget Quantity";
                    Item.Modify;
                end;
            until Dum.Next = 0;
        end;
        /*
        //TempExcelBuffer.CreateBook;
        TempExcelBuffer.CreateBook(SheetName);//B2B
        //TempExcelBuffer.CreateSheet('SS','',COMPANYNAME,'');
        
        //B2B
        TempExcelBuffer.GiveUserControl;
        */
        Message('Safety stock Updated');

    end;


    procedure Overall_Requirement("Item_No.": Code[50]; Prod_QTY: Integer; "BOM_QTY(1st Level)": Decimal; "BOM_QTY(2nd Level)": Decimal; "BOM_QTY(3rd Level)": Decimal; "BOM_QTY(4th Level)": Decimal; "BOM_QTY(5th Level)": Decimal; "BOM_QTY(6th Level)": Decimal);
    var
        TOT: Decimal;
    begin
        TOT := Prod_QTY * "BOM_QTY(1st Level)" * "BOM_QTY(2nd Level)" * "BOM_QTY(3rd Level)" * "BOM_QTY(4th Level)" * "BOM_QTY(5th Level)" *
              "BOM_QTY(6th Level)";
        Item.Reset;
        if not (Dum.Get("Item_No.")) then begin
            ItemNumber := "Item_No.";
            Item.SetRange(Item."No.", ItemNumber);
            if Item.Find('-') then begin
                Dum.Init;
                Dum."No." := Item."No.";
                Dum.Description := Item.Description;
                Dum."Product Group Code Cust" := Item."Product Group Code Cust";
                Dum."Budget Quantity" := TOT;
                Dum.Insert;
            end;
        end else begin
            if Dum.Get("Item_No.") then begin
                Dum."Budget Quantity" += TOT;
                Dum.Modify;
            end;
        end;
    end;


    procedure Entercell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[1000]; bold: Boolean);
    begin

        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Bold := bold;

        TempExcelBuffer.Insert;
    end;


    procedure EnterHeadings(RowNo: Integer; ColumnNo: Integer; CellValue: Text[100]; Bold: Boolean);
    begin
        TempExcelBuffer.Init;
        TempExcelBuffer.Validate("Row No.", RowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := Format(CellValue);
        TempExcelBuffer.Bold := Bold;

        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Insert;
    end;
}

