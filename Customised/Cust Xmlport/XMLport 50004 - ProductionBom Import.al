xmlport 50004 "ProductionBom Import"
{
    Format = VariableText;

    schema
    {
        textelement(ProdBomImports)
        {
            tableelement("<prodbomheader>"; "Production BOM Header")
            {
                XmlName = 'ProdBomHeader';
                fieldelement(No; "<ProdBomHeader>"."No.")
                {
                }
                fieldelement(Description; "<ProdBomHeader>".Description)
                {
                }
                fieldelement(SearchName; "<ProdBomHeader>"."Search Name")
                {
                }
                fieldelement(UnitofMeasureCode; "<ProdBomHeader>"."Unit of Measure Code")
                {
                }
                fieldelement(Status; "<ProdBomHeader>".Status)
                {
                }
            }
            tableelement("<prodbomline>"; "Production BOM Line")
            {
                XmlName = 'ProdBomLine';
                fieldelement(ProductionBOMNo; "<ProdBomLine>"."Production BOM No.")
                {
                }
                fieldelement(LineNo; "<ProdBomLine>"."Line No.")
                {
                }
                fieldelement(Type; "<ProdBomLine>".Type)
                {
                }
                fieldelement(No; "<ProdBomLine>"."No.")
                {
                }
                fieldelement(Description; "<ProdBomLine>".Description)
                {
                }
                fieldelement(UnitofMeasureCode; "<ProdBomLine>"."Unit of Measure Code")
                {
                }
                fieldelement(Position; "<ProdBomLine>".Position)
                {
                }
                fieldelement(Position2; "<ProdBomLine>"."Position 2")
                {
                }
                fieldelement(Position2; "<ProdBomLine>"."Position 3")
                {
                }
                fieldelement(RoutingLinkCode; "<ProdBomLine>"."Routing Link Code")
                {
                }
                fieldelement(Quantityper; "<ProdBomLine>"."Quantity per")
                {
                }

                trigger OnAfterInsertRecord();
                begin

                    Window.Open('FIle Name #1#####################################\' + 'Record    #2#####################################'
                                , FIleName, RecordNo);


                    //ProductionBOMHeader validate
                    ProductionBOMHeader.SetRange(ProductionBOMHeader."No.", "<ProdBomLine>"."No.");
                    if ProductionBOMHeader.Find('-') then begin
                        FIleName := 'Production BOM Header';
                        repeat
                            RecordNo := ProductionBOMHeader."No.";
                            Window.Update();
                            ProductionBOMHeader.Validate(ProductionBOMHeader.Status, ProductionBOMHeader.Status::New);
                            ProductionBOMHeader.Validate(ProductionBOMHeader."Low-Level Code");
                            ProductionBOMHeader.Validate(ProductionBOMHeader."No. Series");
                            ProductionBOMHeader.Modify(true);
                        until ProductionBOMHeader.Next = 0;
                    end;

                    Window.Close();

                    Window.Open('FIle Name #1#####################################\' + 'Record    #2#####################################'
                                , FIleName, RecordNo);


                    //ProductionBOMLine validate
                    ProductionBOMLine.SetRange(ProductionBOMLine."Production BOM No.", ProductionBOMHeader."No.");
                    if ProductionBOMLine.Find('-') then begin
                        FIleName := 'Production BOM Line';
                        repeat
                            RecordNo := ProductionBOMLine."Production BOM No.";
                            Window.Update();
                            ProductionBOMLine.Validate(ProductionBOMLine."Production BOM No.");
                            ProductionBOMLine.Validate(ProductionBOMLine.Type);
                            ProductionBOMLine.Validate(ProductionBOMLine."No.");
                            ProductionBOMLine.Validate(ProductionBOMLine."Line No.");
                            ProductionBOMLine.Validate(ProductionBOMLine."Unit of Measure Code");
                            //ProductionBOMLine.VALIDATE(ProductionBOMLine."Production Lead Time"); //B2b1.0
                            ProductionBOMLine.Validate(ProductionBOMLine."Routing Link Code");
                            ProductionBOMLine.Validate(ProductionBOMLine."Quantity per");
                            ProductionBOMLine.Modify(true);
                        until ProductionBOMLine.Next = 0;
                    end;

                    if ProductionBOMHeader.Find('-') then
                        repeat
                            ProductionBOMHeader.Validate(ProductionBOMHeader.Status, ProductionBOMHeader.Status::Certified);
                            ProductionBOMHeader.Modify(true);
                        until ProductionBOMHeader.Next = 0;

                    Window.Close();
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        Window: Dialog;
        FIleName: Text[30];
        RecordNo: Code[30];
}

