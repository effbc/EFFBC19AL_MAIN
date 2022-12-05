report 33000264 "Item Vendor Qc Analysis"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Item Vendor Qc Analysis.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("Item No.", "Vendor No.") WHERE(Status = FILTER(<> 'No'));
            RequestFilterFields = "Item No.", "Vendor No.";
            column(Inspection_Receipt_Header__No__; "No.")
            {
            }
            column(Inspection_Receipt_Header__Item_Description_; "Item Description")
            {
            }
            column(Inspection_Receipt_Header__Item_No__; "Item No.")
            {
            }
            column(Inspection_Receipt_Header__Vendor_No__; "Vendor No.")
            {
            }
            column(Inspection_Receipt_Header__Vendor_Name_; "Vendor Name")
            {
            }
            column(TotalQty; TotalQty)
            {
            }
            column(AccptQty; AccptQty)
            {
            }
            column(RejQty; RejQty)
            {
            }
            column(Accpt; Accpt)
            {
            }
            column(Rej; Rej)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(Item___Vendor_QC_AnalysisCaption; Item___Vendor_QC_AnalysisCaptionLbl)
            {
            }
            column(Rejected__Caption; Rejected__CaptionLbl)
            {
            }
            column(Accept__Caption; Accept__CaptionLbl)
            {
            }
            column(Rej__QtyCaption; Rej__QtyCaptionLbl)
            {
            }
            column(Accept_QtyCaption; Accept_QtyCaptionLbl)
            {
            }
            column(Total_QtyCaption; Total_QtyCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header__Vendor_Name_Caption; FIELDCAPTION("Vendor Name"))
            {
            }
            column(Inspection_Receipt_Header__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            column(Inspection_Receipt_Header__Item_Description_Caption; FIELDCAPTION("Item Description"))
            {
            }
            column(Inspection_Receipt_Header__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF Status = false THEN
                    AccptQty := Quantity
                ELSE
                    IF Status = true THEN
                        RejQty := Quantity;
                TotalQty := AccptQty + RejQty;
                IF TotalQty = 0 THEN
                    EXIT;
                Accpt := (AccptQty / TotalQty) * 100;
                Rej := (RejQty / TotalQty) * 100;
            end;
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

    labels
    {
    }

    var
        VendorInfo: array[4] of Text[30];
        AccptQty: Decimal;
        TotalQty: Decimal;
        RejQty: Decimal;
        Accpt: Decimal;
        Rej: Decimal;
        UnderProg: Decimal;
        No_CaptionLbl: Label 'No.';
        Item___Vendor_QC_AnalysisCaptionLbl: Label 'Item - Vendor QC Analysis';
        Rejected__CaptionLbl: Label 'Rejected %';
        Accept__CaptionLbl: Label 'Accept %';
        Rej__QtyCaptionLbl: Label 'Rej. Qty';
        Accept_QtyCaptionLbl: Label 'Accept Qty';
        Total_QtyCaptionLbl: Label 'Total Qty';
}

