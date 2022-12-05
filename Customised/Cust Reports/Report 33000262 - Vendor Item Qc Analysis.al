report 33000262 "Vendor Item Qc Analysis"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Vendor Item Qc Analysis.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("Vendor No.", "Item No.") WHERE(Status = FILTER(<> false));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "Item No.", "Vendor No.";
            column(Inspection_Receipt_Header__No__; "No.")
            {
            }
            column(VendorInfo_3_; VendorInfo[3])
            {
            }
            column(VendorInfo_2_; VendorInfo[2])
            {
            }
            column(VendorInfo_1_; VendorInfo[1])
            {
            }
            column(Rej; Rej)
            {
            }
            column(Accpt; Accpt)
            {
            }
            column(RejQty; RejQty)
            {
            }
            column(AccptQty; AccptQty)
            {
            }
            column(TotalQty; TotalQty)
            {
            }
            column(Inspection_Receipt_Header__Item_Description_; "Item Description")
            {
            }
            column(Inspection_Receipt_Header__Item_No__; "Item No.")
            {
            }
            column(Inspection_Receipt_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Vendor___Item_Quality_AnalysisCaption; Vendor___Item_Quality_AnalysisCaptionLbl)
            {
            }
            column(Rej__Caption; Rej__CaptionLbl)
            {
            }
            column(Accepted__Caption; Accepted__CaptionLbl)
            {
            }
            column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
            {
            }
            column(Qty_AcceptedCaption; Qty_AcceptedCaptionLbl)
            {
            }
            column(Total_QtyCaption; Total_QtyCaptionLbl)
            {
            }
            column(Inspection_Receipt_Header__Item_Description_Caption; FIELDCAPTION("Item Description"))
            {
            }
            column(Inspection_Receipt_Header__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(AddressCaption; AddressCaptionLbl)
            {
            }
            column(Vendor_NameCaption; Vendor_NameCaptionLbl)
            {
            }
            column(Vendor_No_Caption; Vendor_No_CaptionLbl)
            {
            }
            column(Inspection_Receipt_Header_Vendor_No_; "Vendor No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                VendorInfo[1] := "Vendor No.";
                VendorInfo[2] := "Vendor Name";
                VendorInfo[3] := Address;
                VendorInfo[4] := "Address 2";
                COMPRESSARRAY(VendorInfo);

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
        VendorInfo: array[4] of Text[50];
        TotalQty: Integer;
        AccptQty: Integer;
        RejQty: Integer;
        UnderProgs: Integer;
        Accpt: Decimal;
        Rej: Decimal;
        Vendor___Item_Quality_AnalysisCaptionLbl: Label 'Vendor - Item Quality Analysis';
        Rej__CaptionLbl: Label 'Rej %';
        Accepted__CaptionLbl: Label 'Accepted %';
        Qty_RejectedCaptionLbl: Label 'Qty Rejected';
        Qty_AcceptedCaptionLbl: Label 'Qty Accepted';
        Total_QtyCaptionLbl: Label 'Total Qty';
        AddressCaptionLbl: Label 'Address';
        Vendor_NameCaptionLbl: Label 'Vendor Name';
        Vendor_No_CaptionLbl: Label 'Vendor No.';
}

