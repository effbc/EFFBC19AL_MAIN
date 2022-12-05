report 50007 "inwards&rejections"
{
    DefaultLayout = RDLC;
    RDLCLayout = './inwardsrejections.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "Posting Date";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME_Control1000000011; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4__Control1000000012; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID_Control1000000013; USERID)
            {
            }
            column(Item_NameCaption; Item_NameCaptionLbl)
            {
            }
            column(vendor_NameCaption; vendor_NameCaptionLbl)
            {
            }
            column(Qty_ReceivedCaption; Qty_ReceivedCaptionLbl)
            {
            }
            column(Inward_DateCaption; Inward_DateCaptionLbl)
            {
            }
            column(Cost_AmountCaption; Cost_AmountCaptionLbl)
            {
            }
            column(Inward_detailsCaption; Inward_detailsCaptionLbl)
            {
            }
            column(Unit_CostCaption; Unit_CostCaptionLbl)
            {
            }
            column(Item_NameCaption_Control1000000003; Item_NameCaption_Control1000000003Lbl)
            {
            }
            column(vendor_NameCaption_Control1000000008; vendor_NameCaption_Control1000000008Lbl)
            {
            }
            column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
            {
            }
            column(Qty_ReceivedCaption_Control1000000005; Qty_ReceivedCaption_Control1000000005Lbl)
            {
            }
            column(Inward_DateCaption_Control1000000014; Inward_DateCaption_Control1000000014Lbl)
            {
            }
            column(Rejection__Caption; Rejection__CaptionLbl)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.") ORDER(Ascending);
                column(Purchase_Header___Buy_from_Vendor_Name_; "Purchase Header"."Buy-from Vendor Name")
                {
                }
                column(Purchase_Line__Purchase_Line__Quantity; "Purchase Line".Quantity)
                {
                }
                column(Purchase_Header___Posting_Date_; "Purchase Header"."Posting Date")
                {
                }
                column(Purchase_Line_Description; Description)
                {
                }
                column(costamt; costamt)
                {
                }
                column(Item__Avg_Unit_Cost_; Item."Avg Unit Cost")
                {
                }
                column(Purchase_Line_Description_Control1000000002; Description)
                {
                }
                column(Purchase_Header___Buy_from_Vendor_Name__Control1000000006; "Purchase Header"."Buy-from Vendor Name")
                {
                }
                column(Purchase_Line__Purchase_Line___Quantity_Rejected_; "Purchase Line"."Quantity Rejected")
                {
                }
                column(Purchase_Line__Quantity_Received_; "Quantity Received")
                {
                }
                column(rej; rej)
                {
                }
                column(Purchase_Header___Posting_Date__Control1000000015; "Purchase Header"."Posting Date")
                {
                }
                column(Purchase_Line_Document_Type; "Document Type")
                {
                }
                column(Purchase_Line_Document_No_; "Document No.")
                {
                }
                column(Purchase_Line_Line_No_; "Line No.")
                {
                }
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = FIELD("No.");
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

    labels
    {
    }

    var
        rej: Decimal;
        opt: Option inw,rej;
        costamt: Decimal;
        Item_NameCaptionLbl: Label 'Item Name';
        vendor_NameCaptionLbl: Label 'vendor Name';
        Qty_ReceivedCaptionLbl: Label 'Qty Received';
        Inward_DateCaptionLbl: Label 'Inward Date';
        Cost_AmountCaptionLbl: Label 'Cost Amount';
        Inward_detailsCaptionLbl: Label 'Inward details';
        Unit_CostCaptionLbl: Label 'Unit Cost';
        Item_NameCaption_Control1000000003Lbl: Label 'Item Name';
        vendor_NameCaption_Control1000000008Lbl: Label 'vendor Name';
        Qty_RejectedCaptionLbl: Label 'Qty Rejected';
        Qty_ReceivedCaption_Control1000000005Lbl: Label 'Qty Received';
        Inward_DateCaption_Control1000000014Lbl: Label 'Inward Date';
        Rejection__CaptionLbl: Label 'Rejection %';
}

