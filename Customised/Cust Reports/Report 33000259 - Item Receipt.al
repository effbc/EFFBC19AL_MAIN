report 33000259 "Item Receipt"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Item Receipt.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("Receipt No.", "Item No.");
            RequestFilterFields = "Receipt No.";
            column(Inspection_Receipt_Header__Receipt_No__; "Receipt No.")
            {
            }
            column(Inspection_Receipt_Header__Vendor_No__; "Vendor No.")
            {
            }
            column(Inspection_Receipt_Header__Vendor_Name_; "Vendor Name")
            {
            }
            column(Inspection_Receipt_Header_Address; Address)
            {
            }
            column(Inspection_Receipt_Header__Item_No__; "Item No.")
            {
            }
            column(Inspection_Receipt_Header__Item_Description_; "Item Description")
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
            column(UnderProgQty; UnderProgQty)
            {
            }
            column(Receipt_Wise_QC_AnalysisCaption; Receipt_Wise_QC_AnalysisCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Inspection_Receipt_Header__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            column(Inspection_Receipt_Header__Vendor_Name_Caption; FIELDCAPTION("Vendor Name"))
            {
            }
            column(Inspection_Receipt_Header_AddressCaption; FIELDCAPTION(Address))
            {
            }
            column(Inspection_Receipt_Header__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Inspection_Receipt_Header__Item_Description_Caption; FIELDCAPTION("Item Description"))
            {
            }
            column(Total_QtyCaption; Total_QtyCaptionLbl)
            {
            }
            column(Qty_AcceptedCaption; Qty_AcceptedCaptionLbl)
            {
            }
            column(Qty_Rej_Caption; Qty_Rej_CaptionLbl)
            {
            }
            column(Accept__Caption; Accept__CaptionLbl)
            {
            }
            column(Rej__Caption; Rej__CaptionLbl)
            {
            }
            column(Qty_Under_ProgressCaption; Qty_Under_ProgressCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header_No_; "No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                IF Status = false THEN
                    AccptQty := Quantity
                ELSE
                    IF Status = true THEN
                        RejQty := Quantity;
                IF (Status = false) OR (Status = true) THEN BEGIN
                    UnderProgQty := 0;
                    TotalQty := AccptQty + RejQty;
                END;
                IF TotalQty = 0 THEN;
                IF Status = false THEN BEGIN
                    UnderProgQty := Quantity;
                    AccptQty := 0;
                    RejQty := 0;
                    TotalQty := UnderProgQty + AccptQty + RejQty;
                END;
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
        AccptQty: Integer;
        RejQty: Integer;
        TotalQty: Integer;
        Accpt: Decimal;
        Rej: Decimal;
        UnderProgQty: Integer;
        Receipt_Wise_QC_AnalysisCaptionLbl: Label 'Receipt Wise QC Analysis';
        Total_QtyCaptionLbl: Label 'Total Qty';
        Qty_AcceptedCaptionLbl: Label 'Qty Accepted';
        Qty_Rej_CaptionLbl: Label 'Qty Rej.';
        Accept__CaptionLbl: Label 'Accept %';
        Rej__CaptionLbl: Label 'Rej %';
        Qty_Under_ProgressCaptionLbl: Label 'Qty Under Progress';
}

