xmlport 50001 "PAD Software Data Integration1"
{
    // version B2B1.0

    Format = VariableText;

    schema
    {
        textelement(ProdBOMLines)
        {
            tableelement("<prodbomline>"; "Production BOM Line")
            {
                AutoSave = false;
                XmlName = 'ProdBOMLine';
                SourceTableView = SORTING("Production BOM No.", "Version Code", "Line No.");
                fieldelement(No; "<ProdBOMLine>"."No.")
                {
                    FieldValidate = no;
                }
                fieldelement(Quantityper; "<ProdBOMLine>"."Quantity per")
                {
                }
                fieldelement(Position; "<ProdBOMLine>".Position)
                {
                    FieldValidate = no;
                }
                fieldelement(Position2; "<ProdBOMLine>"."Position 2")
                {
                    FieldValidate = no;
                }
                fieldelement(Position3; "<ProdBOMLine>"."Position 3")
                {
                    FieldValidate = no;
                }

                trigger OnBeforeInsertRecord();
                begin
                    ProductionBOMLineRec.Reset;
                    ProductionBOMLineRec.SetRange("Production BOM No.", ProductionBomNo);
                    if ProductionBOMLineRec.FindLast then
                        LineNo := ProductionBOMLineRec."Line No."
                    else
                        LineNo := 0;

                    TmpProductionBOMLine.Init;
                    TmpProductionBOMLine.Validate("Production BOM No.", ProductionBomNo);
                    TmpProductionBOMLine."Line No." := LineNo + 10000;

                    BOMLine.Reset;
                    BOMLine.SetFilter(BOMLine."Production BOM No.", ProductionBomNo);
                    BOMLine.SetFilter(BOMLine."No.", "<ProdBOMLine>"."No.");
                    BOMLine.SetFilter(BOMLine."Version Code", '');
                    BOMLine.SetFilter(BOMLine."Line No.", '<>%1', LineNo + 10000);
                    if BOMLine.FindFirst then begin
                        Error('BOM having Duplicate Item :: ' + Format(BOMLine."No."));
                    end;


                    TmpProductionBOMLine.Validate(Type, TmpProductionBOMLine.Type::Item);
                    TmpProductionBOMLine.Validate("No.", "<ProdBOMLine>"."No.");
                    TmpProductionBOMLine.Validate("Quantity per", "<ProdBOMLine>"."Quantity per");
                    TmpProductionBOMLine.Validate(Position, "<ProdBOMLine>".Position);
                    Clear("<ProdBOMLine>".Position);
                    TmpProductionBOMLine.Validate("Position 2", "<ProdBOMLine>"."Position 2");
                    TmpProductionBOMLine.Validate("Position 3", "<ProdBOMLine>"."Position 3");
                    TmpProductionBOMLine.Insert;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control1102152001)
                {
                    ShowCaption = false;
                    field("For Importing the Production BOM Line Details"; '')
                    {
                        Caption = 'For Importing the Production BOM Line Details';
                        ApplicationArea = All;
                    }
                    field("File format should be Comma Delimited (*.csv)"; '')
                    {
                        Caption = 'File format should be Comma Delimited (*.csv)';
                        ApplicationArea = All;
                    }
                    field("Fields to be importted"; '')
                    {
                        Caption = 'Fields to be importted';
                        ApplicationArea = All;
                    }
                    field("Item No."; '')
                    {
                        Caption = 'Item No.';
                        ApplicationArea = All;
                    }
                    field(Quantity; '')
                    {
                        Caption = 'Quantity';
                        ApplicationArea = All;
                    }
                    field(Position; '')
                    {
                        Caption = 'Position';
                        ApplicationArea = All;
                    }
                    field("Position 2"; '')
                    {
                        Caption = 'Position 2';
                        ApplicationArea = All;
                    }
                    field("Position 3"; '')
                    {
                        Caption = 'Position 3';
                        ApplicationArea = All;
                    }
                    field("Please choose a file name to import/export"; '')
                    {
                        Caption = 'Please choose a file name to import/export';
                        ApplicationArea = All;
                    }
                    field(FileName; FileName)
                    {
                        Caption = 'File Name';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPreXmlPort();
    begin
        //IF FileName = '' THEN
        // ERROR('You should choose the FileName');
        currXMLport.Filename(FileName);

        TmpProductionBOMLine.SetRange("Production BOM No.", ProductionBomNo);
        if TmpProductionBOMLine.Find('-') then
            TmpProductionBOMLine.DeleteAll;

        Direction := Direction::Import;
    end;

    var
        Text000: Label 'For Importing the Production BOM Line Details';
        FileName: Text[250];
        Direction: Option Import,Export;
        ProductionBomNo: Code[20];
        TmpProductionBOMLine: Record "Production BOM Line";
        ProductionBOMLineRec: Record "Production BOM Line";
        LineNo: Integer;
        BOMLine: Record "Production BOM Line";

    procedure Initilize(var BOMNo: Code[20]);
    begin
        ProductionBomNo := BOMNo;
    end;
}

