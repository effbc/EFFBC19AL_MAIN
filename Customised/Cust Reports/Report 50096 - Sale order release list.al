report 50096 "Sale order release list"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sale order release list.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Sales_Header__Sales_Header___No__; "Sales Header"."No.")
            {
            }
            column(Sales_Header__Sales_Header___Sell_to_Customer_Name_; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
            {
            }
            column(Unit_of_MeasureCaption; Unit_of_MeasureCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Item_DetailsCaption; Item_DetailsCaptionLbl)
            {
            }
            column(Order_No___Caption; Order_No___CaptionLbl)
            {
            }
            column(Customer_NameCaption; Customer_NameCaptionLbl)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Quantity = FILTER(<> 0));
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Sales_Line_Document_Type; "Document Type")
                {
                }
                column(Sales_Line_Document_No_; "Document No.")
                {
                }
                column(Sales_Line_Line_No_; "Line No.")
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

    labels
    {
    }

    var
        tot: Decimal;
        totalprice: Decimal;
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Unit_of_MeasureCaptionLbl: Label 'Unit of Measure';
        QuantityCaptionLbl: Label 'Quantity';
        Item_DetailsCaptionLbl: Label 'Item Details';
        Order_No___CaptionLbl: Label 'Order No. :';
        Customer_NameCaptionLbl: Label 'Customer Name';
}

