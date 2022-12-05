report 50098 "Sale invoice-Details2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sale invoice-Details2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(DataItem6640; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(Sales_Header__No__; "No.")
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_; "Sell-to Customer Name")
            {
            }
            column(Order_DetailsCaption; Order_DetailsCaptionLbl)
            {
            }
            column(Sale_Order_No_Caption; Sale_Order_No_CaptionLbl)
            {
            }
            column(Sales_Header__Sell_to_Customer_Name_Caption; FIELDCAPTION("Sell-to Customer Name"))
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Quantity = FILTER(> 0));
                column(Sales_Line_Description; Description)
                {
                }
                column(Sales_Line_Quantity; Quantity)
                {
                }
                column(Sales_Line__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Sales_Line__Qty__to_Ship_; "Qty. to Ship")
                {
                }
                column(Sales_Line__Quantity_Shipped_; "Quantity Shipped")
                {
                }
                column(Quantity__Quantity_Shipped___Qty__to_Ship_; Quantity - "Quantity Shipped" - "Qty. to Ship")
                {
                }
                column(ROUND___Sales_Line___Amount_To_Customer___Sales_Line___Qty__to_Ship____Sales_Line__Quantity_1_; ROUND(("Sales Line"."Amount To Customer" * "Sales Line"."Qty. to Ship") / "Sales Line".Quantity, 1))
                {
                }

                column(Item_DescriptionCaption; Item_DescriptionCaptionLbl)
                {
                }
                column(Total_QuantityCaption; Total_QuantityCaptionLbl)
                {
                }
                column(Sales_Line__Unit_of_Measure_Caption; FIELDCAPTION("Unit of Measure"))
                {
                }
                column(Shipping_QtyCaption; Shipping_QtyCaptionLbl)
                {
                }
                column(Shipped_QuantityCaption; Shipped_QuantityCaptionLbl)
                {
                }
                column(PriceCaption; PriceCaptionLbl)
                {
                }
                column(Remaining_QuantityCaption; Remaining_QuantityCaptionLbl)
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
        Order_DetailsCaptionLbl: Label 'Order Details';
        Sale_Order_No_CaptionLbl: Label 'Sale Order No.';
        Item_DescriptionCaptionLbl: Label 'Item Description';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
        Shipping_QtyCaptionLbl: Label 'Shipping Qty';
        Shipped_QuantityCaptionLbl: Label 'Shipped Quantity';
        PriceCaptionLbl: Label 'Price';
        Remaining_QuantityCaptionLbl: Label 'Remaining Quantity';
}

