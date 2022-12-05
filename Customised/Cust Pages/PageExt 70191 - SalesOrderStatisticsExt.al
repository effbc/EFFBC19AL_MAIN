pageextension 70191 SalesOrderStatisticsExt extends "Sales Order Statistics"
{
    layout
    {
        addafter("TotalSalesLineLCY[3].Amount")
        {
            field(ShippingAmtGst; ShippingAmtGst)
            {
                Caption = 'GST Amount';
                Editable = false;
                ApplicationArea = all;
            }
            field(ShippingAmtTcs; ShippingAmtTcs)
            {
                Caption = 'TCS Amount';
                Editable = false;
                ApplicationArea = all;
            }
            field(ShippingAmtNetTotal; ShippingAmtNetTotal)
            {
                Caption = 'Net Total';
                Editable = false;
                ApplicationArea = all;
            }

        }

        addafter("TotalSalesLineLCY[2].Amount")
        {
            field(InvoiceingAmtGst; InvoiceingAmtGst)
            {
                Caption = 'GST Amount';
                Editable = false;
                ApplicationArea = all;
            }
            field(InvoiceingAmtTcs; InvoiceingAmtTcs)
            {
                Caption = 'TCS Amount';
                Editable = false;
                ApplicationArea = all;
            }
            field(InvoiceAmtNetTotal; InvoiceAmtNetTotal)
            {
                Caption = 'Net Total';
                Editable = false;
                ApplicationArea = all;
            }
        }

    }

    trigger OnAfterGetRecord()
    var

    begin

        GSTAmountCust();

    end;

    local procedure GSTAmountCust()
    var

        SalesLine: record "Sales Line";


    begin
        clear(ShippingAmtGst);
        clear(InvoiceingAmtGst);
        clear(ShippingAmtTcs);
        clear(InvoiceingAmtTcs);

        Clear(InvoiceAmtNetTotal);
        Clear(ShippingAmtNetTotal);
        SalesLine.Reset;
        SalesLine.SETRANGE("Document Type", Rec."Document Type");
        SalesLine.SETRANGE("Document No.", Rec."No.");
        SalesLine.SETFILTER(Type, '<>%1', SalesLine.Type::" ");
        SalesLine.SETFILTER(Quantity, '<>%1', 0);
        IF SalesLine.FINDSET THEN
            REPEAT
                clear(LineGstAmt);
                Clear(LineTotalAmt);
                Clear(LineTcsAmt);

                LineGstAmt := GetGSTAmount(SalesLine.RecordId());
                LineTcsAmt := GetTCSAmount(SalesLine);


                if (SalesLine."Qty. to Ship" <> 0) and (LineGstAmt <> 0) then
                    ShippingAmtGst += ((SalesLine."Qty. to Ship" / SalesLine.Quantity) * LineGSTAmt);

                if (SalesLine."Qty. to Invoice" <> 0) and (LineGstAmt <> 0) then
                    InvoiceingAmtGst += ((SalesLine."Qty. to Invoice" / SalesLine.Quantity) * LineGSTAmt);

                if (SalesLine."Qty. to Ship" <> 0) and (LineTcsAmt <> 0) then
                    ShippingAmtTCS += ((SalesLine."Qty. to Ship" / SalesLine.Quantity) * LineTcsAmt);

                if (SalesLine."Qty. to Invoice" <> 0) and (LineTcsAmt <> 0) then
                    InvoiceingAmtTcs += ((SalesLine."Qty. to Invoice" / SalesLine.Quantity) * LineTcsAmt);

                LineTotalAmt := LineTcsAmt + LineGSTAmt + SalesLine.Amount;
                if LineTotalAmt <> 0 then begin

                    if (SalesLine."Qty. to Ship" <> 0) then
                        ShippingAmtNetTotal += ((SalesLine."Qty. to Ship" / SalesLine.Quantity) * LineTotalAmt);

                    if (SalesLine."Qty. to Invoice" <> 0) then
                        InvoiceAmtNetTotal += ((SalesLine."Qty. to Invoice" / SalesLine.Quantity) * LineTotalAmt);

                end;


            UNTIL SalesLine.NEXT = 0;

    end;

    local procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    local procedure GetTCSAmount(SalesLine: Record "Sales Line"): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";

        TCSGSTCompAmount: Decimal;
    begin

        clear(TCSGSTCompAmount);
        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", 'TCS');
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    TCSGSTCompAmount += TaxTransactionValue.Amount;
                until TaxTransactionValue.Next() = 0;
        end;
        exit(TCSGSTCompAmount);

    end;

    var
        ShippingAmtGst: Decimal;
        InvoiceingAmtGst: Decimal;
        LineGSTAmt: Decimal;
        ShippingAmtTcs: Decimal;
        InvoiceingAmtTcs: Decimal;
        LineTcsAmt: Decimal;
        InvoiceAmtNetTotal: Decimal;
        ShippingAmtNetTotal: Decimal;
        LineTotalAmt: Decimal;
}

