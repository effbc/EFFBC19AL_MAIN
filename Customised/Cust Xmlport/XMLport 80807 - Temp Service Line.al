xmlport 80807 "Temp Service Line"
{
    Format = VariableText;

    schema
    {
        textelement(TempServiceLines)
        {
            tableelement("<tempserviceline>"; "Temp Service Line")
            {
                XmlName = 'TempServiceLine';
                fieldelement(DocumentNo; "<TempServiceLine>"."Document No.")
                {
                }
                fieldelement(LineNo; "<TempServiceLine>"."Line No.")
                {
                }
                fieldelement(ServiceItemLineNo; "<TempServiceLine>"."Service Item Line No.")
                {
                }
                fieldelement(ServiceItemNo; "<TempServiceLine>"."Service Item No.")
                {
                }
                fieldelement(ServiceItemSerialNo; "<TempServiceLine>"."Service Item Serial No.")
                {
                }
                fieldelement(ServiceItemDescription; "<TempServiceLine>"."Service Item Description")
                {
                }
                fieldelement(PostingDate; "<TempServiceLine>"."Posting Date")
                {
                }
                fieldelement(OrderDate; "<TempServiceLine>"."Order Date")
                {
                }
                fieldelement(Type; "<TempServiceLine>".Type)
                {
                }
                fieldelement(No; "<TempServiceLine>"."No.")
                {
                }
                fieldelement(UnitofMeasure; "<TempServiceLine>"."Unit of Measure")
                {
                }
                fieldelement(QtyperUnitofMeasure; "<TempServiceLine>"."Qty. per Unit of Measure")
                {
                }
                fieldelement(CustomerNo; "<TempServiceLine>"."Customer No.")
                {
                }
                fieldelement(BiltoCustomerNo; "<TempServiceLine>"."Bill-to Customer No.")
                {
                }
                fieldelement(Description; "<TempServiceLine>".Description)
                {
                }
                fieldelement(Description2; "<TempServiceLine>"."Description 2")
                {
                }
                fieldelement(UnitofMeasureCode; "<TempServiceLine>"."Unit of Measure Code")
                {
                }
                fieldelement(PostingGroup; "<TempServiceLine>"."Posting Group")
                {
                }
                fieldelement(VATCalculationType; "<TempServiceLine>"."VAT Calculation Type")
                {
                }
                fieldelement(TaxLiable; "<TempServiceLine>"."Tax Liable")
                {
                }
                fieldelement(TaxGroupCode; "<TempServiceLine>"."Tax Group Code")
                {
                }
                fieldelement(Quantity; "<TempServiceLine>".Quantity)
                {
                }
                fieldelement(QtytoInvoice; "<TempServiceLine>"."Qty. to Invoice")
                {
                }
                fieldelement(UnitPrice; "<TempServiceLine>"."Unit Price")
                {
                }
                fieldelement(UnitCost; "<TempServiceLine>"."Unit Cost")
                {
                }
                fieldelement(UnitCostLCY; "<TempServiceLine>"."Unit Cost (LCY)")
                {
                }
                fieldelement(CostAmount; "<TempServiceLine>"."Cost Amount")
                {
                }
                fieldelement(ExcludeContractDiscount; "<TempServiceLine>"."Exclude Contract Discount")
                {
                }
                fieldelement(DocumentType; "<TempServiceLine>"."Document Type")
                {
                }
                fieldelement(GenBusPostingGroup; "<TempServiceLine>"."Gen. Bus. Posting Group")
                {
                }
                fieldelement(GenProdPostingGroup; "<TempServiceLine>"."Gen. Prod. Posting Group")
                {
                }
                fieldelement(Chargeable; "<TempServiceLine>".Chargeable)
                {
                }
                fieldelement(LocationCode; "<TempServiceLine>"."Location Code")
                {
                }
                fieldelement(ItemCategoryCode; "<TempServiceLine>"."Item Category Code")
                {
                }
                fieldelement(ProductGroupCode; "<TempServiceLine>"."Product Group Code")
                {
                }
                fieldelement(QuantityBase; "<TempServiceLine>"."Quantity (Base)")
                {
                }
                fieldelement(QtytoInvoiceBase; "<TempServiceLine>"."Qty. to Invoice (Base)")
                {
                }
                fieldelement(OutstandingQtyBase; "<TempServiceLine>"."Outstanding Qty. (Base)")
                {
                }
                fieldelement(Reserve; "<TempServiceLine>".Reserve)
                {
                }
                fieldelement(SubstitutionAvailable; "<TempServiceLine>"."Substitution Available")
                {
                }
                fieldelement(LineDiscountType; "<TempServiceLine>"."Line Discount Type")
                {
                }
                fieldelement(AllowLineDisc; "<TempServiceLine>"."Allow Line Disc.")
                {
                }
                fieldelement(ServiceitemLotNo; "<TempServiceLine>"."Service item Lot No")
                {
                }
                fieldelement(Levels; "<TempServiceLine>".Levels)
                {
                }
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
}

