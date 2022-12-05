page 60196 "Material Issue Statistics"
{
    // version MI1.0

    Caption = 'Material Issue Statistics';
    Editable = false;
    PageType = Card;
    SourceTable = "Material Issues Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(LineQty; LineQty)
                {
                    Caption = 'Quantity';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(TotalParcels; TotalParcels)
                {
                    Caption = 'Parcels';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(TotalNetWeight; TotalNetWeight)
                {
                    Caption = 'Net Weight';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(TotalGrossWeight; TotalGrossWeight)
                {
                    Caption = 'Gross Weight';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
                field(TotalVolume; TotalVolume)
                {
                    Caption = 'Volume';
                    DecimalPlaces = 0 : 5;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MaterialIssueLine: Record "Material Issues Line";
    begin
        CLEARALL;

        MaterialIssueLine.SETRANGE("Document No.", Rec."No.");
        IF MaterialIssueLine.FINDSET THEN
            REPEAT
                LineQty := LineQty + MaterialIssueLine.Quantity;
                TotalNetWeight := TotalNetWeight + (MaterialIssueLine.Quantity * MaterialIssueLine."Net Weight");
                TotalGrossWeight := TotalGrossWeight + (MaterialIssueLine.Quantity * MaterialIssueLine."Gross Weight");
                TotalVolume := TotalVolume + (MaterialIssueLine.Quantity * MaterialIssueLine."Unit Volume");
                IF MaterialIssueLine."Units per Parcel" > 0 THEN
                    TotalParcels := TotalParcels + ROUND(MaterialIssueLine.Quantity / MaterialIssueLine."Units per Parcel", 1, '>');
            UNTIL MaterialIssueLine.NEXT = 0;
    end;

    var
        LineQty: Decimal;
        TotalNetWeight: Decimal;
        TotalGrossWeight: Decimal;
        TotalVolume: Decimal;
        TotalParcels: Decimal;
}

