report 33000260 "Qc Report"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Qc Report.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Line"; "Inspection Receipt Line")
        {
            DataItemTableView = SORTING("Receipt No.", "Item No.");
            RequestFilterFields = "Receipt No.";
            column(CompAddr_1_; CompAddr[1])
            {
            }
            column(CompAddr_2_; CompAddr[2])
            {
            }
            column(CompAddr_4_; CompAddr[4])
            {
            }
            column(CompAddr_3_; CompAddr[3])
            {
            }
            column(InsRepHead__Vendor_No__; InsRepHead."Vendor No.")
            {
            }
            column(InsRepHead__Vendor_Name_; InsRepHead."Vendor Name")
            {
            }
            column(InsRepHead_Address; InsRepHead.Address)
            {
            }
            column(Inspection_Receipt_Line__Receipt_No__; "Receipt No.")
            {
            }
            column(Inspection_Receipt_Line__Document_No__; "Document No.")
            {
            }
            column(Inspection_Receipt_Line_Description; Description)
            {
            }
            column(Inspection_Receipt_Line__Item_No__; "Item No.")
            {
            }
            column(Inspection_Receipt_Line__Character_Code_; "Character Code")
            {
            }
            column(Inspection_Receipt_Line__Total_Qty_; "Total Qty")
            {
            }
            column(Inspection_Receipt_Line__Accepted_Qty_; "Accepted Qty")
            {
            }
            column(Inspection_Receipt_Line__Rejected_Qty_; "Rejected Qty")
            {
            }
            column(QC_Inspection_ReportCaption; QC_Inspection_ReportCaptionLbl)
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
            column(Vendor_No___Caption; Vendor_No___CaptionLbl)
            {
            }
            column(Vendor_Name__Caption; Vendor_Name__CaptionLbl)
            {
            }
            column(Address__Caption; Address__CaptionLbl)
            {
            }
            column(Inspection_Receipt_Line__Receipt_No__Caption; Inspection_Receipt_Line__Receipt_No__CaptionLbl)
            {
            }
            column(IR__No_Caption; IR__No_CaptionLbl)
            {
            }
            column(Description__Caption; Description__CaptionLbl)
            {
            }
            column(Item_No___Caption; Item_No___CaptionLbl)
            {
            }
            column(Inspection_Receipt_Line__Character_Code_Caption; FIELDCAPTION("Character Code"))
            {
            }
            column(Inspection_Receipt_Line__Total_Qty_Caption; FIELDCAPTION("Total Qty"))
            {
            }
            column(Inspection_Receipt_Line__Accepted_Qty_Caption; FIELDCAPTION("Accepted Qty"))
            {
            }
            column(Inspection_Receipt_Line__Rejected_Qty_Caption; FIELDCAPTION("Rejected Qty"))
            {
            }
            column(Continued_on_the_next_Page___Caption; Continued_on_the_next_Page___CaptionLbl)
            {
            }
            column(Inspection_Receipt_Line_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord();
            begin
                InsRepHead.SETRANGE("Purch Line No", "Purch Line No.");
                InsRepHead.FIND('-');
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
        InsRepHead: Record "Inspection Receipt Header";
        CompInfo: Record "Company Information";
        CompAddr: array[4] of Text[60];
        QC_Inspection_ReportCaptionLbl: Label 'QC Inspection Report';
        Company_Name__CaptionLbl: Label 'Company Name :';
        Compnay_Address__CaptionLbl: Label 'Compnay Address :';
        Compnay_Address2__CaptionLbl: Label 'Compnay Address2 :';
        City__CaptionLbl: Label 'City :';
        Vendor_No___CaptionLbl: Label 'Vendor No. :';
        Vendor_Name__CaptionLbl: Label 'Vendor Name :';
        Address__CaptionLbl: Label 'Address :';
        Inspection_Receipt_Line__Receipt_No__CaptionLbl: Label 'Receipt No. :';
        IR__No_CaptionLbl: Label 'IR- No.';
        Description__CaptionLbl: Label 'Description :';
        Item_No___CaptionLbl: Label 'Item No. :';
        Continued_on_the_next_Page___CaptionLbl: Label 'Continued on the next Page...';
}

