xmlport 50082 "Upd GLEntry Dimension"
{
    Direction = Import;
    Format = VariableText;
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Sales Invoice Line" = rm;

    schema
    {
        textelement(Root)
        {
            tableelement(Integer; Integer)
            {
                AutoSave = false;
                XmlName = 'Integer';
                SourceTableView = WHERE(Number = FILTER(1 ..));
                UseTemporary = true;
                textelement(InvNum)
                {
                }
                textelement(PostingdateText)
                {
                }
                textelement(OrderNum)
                {
                }
                textelement(SelltoCustNum)
                {
                }
                textelement(HeaderDim)
                {
                }
                textelement(GLDim)
                {
                }

                trigger OnBeforeInsertRecord();
                begin
                    if HeaderDim = '' then
                        exit;



                    if I = 0 then begin
                        I += 1;
                        currXMLport.Skip;
                    end;

                    //MESSAGE('%1--%2',InvNum,HeaderDim);
                    SL.Reset;
                    SL.SetCurrentKey("Document No.");
                    SL.SetFilter("Document No.", InvNum);
                    SL.SetFilter(Quantity, '>0');
                    if SL.FindSet then
                        repeat
                            SL."Dimension Set ID" := DimensionSetIDGen(SL."Dimension Set ID");
                            SL."Shortcut Dimension 1 Code" := HeaderDim;
                            SL.Modify;
                        until SL.Next = 0;
                    GLEntry.Reset;
                    GLEntry.SetCurrentKey("Document No.");
                    GLEntry.SetRange("Document No.", InvNum);
                    if GLEntry.FindSet then
                        repeat
                            //WindowDia.OPEN('Updating..');
                            //WindowDia.UPDATE(1,GLEntry."Entry No.");
                            GLEntry."Global Dimension 1 Code" := HeaderDim;
                            GLEntry."Dimension Set ID" := DimensionSetIDGen(GLEntry."Dimension Set ID");
                            GLEntry.Modify;
                            Modified := true;
                        until GLEntry.Next = 0;
                    Message('Completed');


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
        GLEntry: Record "G/L Entry";
        WindowDia: Dialog;
        GeneralLedgerSetup: Record "General Ledger Setup";
        I: Integer;
        Modified: Boolean;
        SL: Record "Sales Invoice Line";
        Text0000: Label 'Process Completed';
        Text0001: Label 'Updating Dimension Values Entry No. #1########';
        Text0002: Label 'Do you want process to update ?';


    local procedure DimensionSetIDGen(PrevDimSetID: Integer): Integer;
    var
        DimensionMgt: Codeunit DimensionManagement;
        DimensionValue: Record "Dimension Value";
        TempDimensionSetEntry: Record "Dimension Set Entry" temporary;
        DimensionSetEntry: Record "Dimension Set Entry";
    begin
        //Dimension Set ID Updation >>
        Clear(DimensionMgt);
        Clear(DimensionValue);
        TempDimensionSetEntry.DeleteAll;

        DimensionSetEntry.Reset;
        DimensionSetEntry.SetRange("Dimension Set ID", PrevDimSetID);
        DimensionSetEntry.SetFilter("Dimension Code", '<>%1', GeneralLedgerSetup."Global Dimension 1 Code");
        if DimensionSetEntry.FindSet then begin
            repeat
                Clear(DimensionValue);
                if DimensionValue.Get(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code") then begin
                    TempDimensionSetEntry.Init;
                    TempDimensionSetEntry."Dimension Code" := DimensionValue."Dimension Code";
                    TempDimensionSetEntry."Dimension Value Code" := DimensionValue.Code;
                    TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
                    TempDimensionSetEntry.Insert;
                end;
            until DimensionSetEntry.Next = 0;
        end;

        Clear(DimensionValue);

        if DimensionValue.Get(GeneralLedgerSetup."Global Dimension 1 Code", HeaderDim) then begin
            TempDimensionSetEntry.Init;
            TempDimensionSetEntry."Dimension Code" := DimensionValue."Dimension Code";
            TempDimensionSetEntry."Dimension Value Code" := DimensionValue.Code;
            TempDimensionSetEntry."Dimension Value ID" := DimensionValue."Dimension Value ID";
            TempDimensionSetEntry.Insert;
        end;

        //Dimension Set ID Updation <<
        exit(DimensionMgt.GetDimensionSetID(TempDimensionSetEntry));

    end;
}

