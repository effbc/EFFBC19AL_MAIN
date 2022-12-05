report 33000263 "Item Vendor Qc Analysis1"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Item Vendor Qc Analysis1.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            DataItemTableView = SORTING("Item No.", "Vendor No.") WHERE(Status = FILTER(false));
            RequestFilterFields = "Item No.", "Vendor No.";
            column(Inspection_Receipt_Header__No__; "No.")
            {
            }
            column(CompAddr_4_; CompAddr[4])
            {
            }
            column(CompAddr_1_; CompAddr[1])
            {
            }
            column(CompAddr_2_; CompAddr[2])
            {
            }
            column(CompAddr_3_; CompAddr[3])
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
            column(Company_Name__Caption; Company_Name__CaptionLbl)
            {
            }
            column(Compnay_Address__Caption; Compnay_Address__CaptionLbl)
            {
            }
            column(Compnay_Address2__Caption; Compnay_Address2__CaptionLbl)
            {
            }
            column(City__Caption; City__CaptionLbl)
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

            trigger OnPreDataItem();
            begin
                CompInfo.GET;
                CompAddr[1] := CompInfo.Name;
                CompAddr[2] := CompInfo.Address;
                CompAddr[3] := CompInfo."Address 2";
                CompAddr[4] := CompInfo.City;
                COMPRESSARRAY(CompAddr);
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
        CompInfo: Record "Company Information";
        CompAddr: array[4] of Text[60];
        No_CaptionLbl: Label 'No.';
        Item___Vendor_QC_AnalysisCaptionLbl: Label 'Item - Vendor QC Analysis';
        Company_Name__CaptionLbl: Label 'Company Name :';
        Compnay_Address__CaptionLbl: Label 'Compnay Address :';
        Compnay_Address2__CaptionLbl: Label 'Compnay Address2 :';
        City__CaptionLbl: Label 'City :';
        Rejected__CaptionLbl: Label 'Rejected %';
        Accept__CaptionLbl: Label 'Accept %';
        Rej__QtyCaptionLbl: Label 'Rej. Qty';
        Accept_QtyCaptionLbl: Label 'Accept Qty';
        Total_QtyCaptionLbl: Label 'Total Qty';
}

