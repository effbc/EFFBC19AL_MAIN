page 60250 "_Items by Dimension"
{
    // version NAVW16.00

    Caption = 'Items by Location';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Card;
    SaveValues = true;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(ShowInTransit; ShowInTransit)
                {
                    Caption = 'Show Items in Transit';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShowInTransitOnAfterValidate;
                    end;
                }
                field(ShowColumnName; ShowColumnName)
                {
                    Caption = 'Show Column Name';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        ShowColumnNameOnAfterValidate;
                    end;
                }
            }
            group("Matrix Options")
            {
                Caption = 'Matrix Options';
                field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                {
                    Caption = 'Column Set';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Show Matrix")
            {
                Caption = 'Show Matrix';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    ItemsByDimensionMatrix: Page "Items by Dimension Matrix";
                begin
                    ItemsByDimensionMatrix.Load(MATRIX_CaptionSet, MatrixRecords, MatrixRecord);
                    ItemsByDimensionMatrix.RUNMODAL;
                end;
            }
            action("Next Set")
            {
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Next Set';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SetColumns(MATRIX_SetWanted::Next);
                end;
            }
            action("Previous Set")
            {
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Previous Set';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SetColumns(MATRIX_SetWanted::Previous);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;

    var
        MatrixRecord: Record "Dimension Value";
        MatrixRecords: array[32] of Record "Dimension Value";
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        ShowColumnName: Boolean;
        ShowInTransit: Boolean;
        MATRIX_CaptionSet: array[32] of Text[1024];
        MATRIX_CaptionRange: Text[100];
        MATRIX_PKFirstRecInCurrSet: Text[100];
        MATRIX_CurrSetLength: Integer;


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next);
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        //MatrixRecord.SETRANGE("Use As In-Transit",ShowInTransit);
        MatrixRecord.SETRANGE("Dimension Code", 'Locations');
        CLEAR(MATRIX_CaptionSet);
        CLEAR(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GETTABLE(MatrixRecord);
        MatrixRecordRef.SETTABLE(MatrixRecord);

        IF ShowColumnName THEN
            CaptionFieldNo := MatrixRecord.FIELDNO(Name)
        ELSE
            CaptionFieldNo := MatrixRecord.FIELDNO(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ARRAYLEN(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        IF MATRIX_CurrSetLength > 0 THEN BEGIN
            MatrixRecord.SETPOSITION(MATRIX_PKFirstRecInCurrSet);
            MatrixRecord.FIND;
            REPEAT
                MatrixRecords[CurrentMatrixRecordOrdinal].COPY(MatrixRecord);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            UNTIL (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) OR (MatrixRecord.NEXT <> 1);
        END;
    end;


    local procedure ShowColumnNameOnAfterValidate();
    begin
        SetColumns(MATRIX_SetWanted::Same);
    end;


    local procedure ShowInTransitOnAfterValidate();
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;
}

