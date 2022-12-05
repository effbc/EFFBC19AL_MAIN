report 33000255 "Vendor Acceptance Rating2"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Vendor Acceptance Rating2.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;

    dataset
    {
        dataitem("Vendor Rating";
        "Vendor Rating")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Item No.", "Vendor No.";
            column(Vendor_Rating__Item_No__; "Item No.")
            {
            }
            column(Vendor_Rating__Vendor_No__; "Vendor No.")
            {
            }
            column(Vendor_RatingCaption; Vendor_RatingCaptionLbl)
            {
            }
            column(Inspect__Recpt__Accept_Level_QuantityCaption; "Inspect. Recpt. Accept Level".FIELDCAPTION(Quantity))
            {
            }
            column(Inspect__Recpt__Accept_Level__Reason_Code_Caption; "Inspect. Recpt. Accept Level".FIELDCAPTION("Reason Code"))
            {
            }
            column(Inspect__Recpt__Accept_Level__Acceptance_Code_Caption; "Inspect. Recpt. Accept Level".FIELDCAPTION("Acceptance Code"))
            {
            }
            column(Inspect__Recpt__Accept_Level__Quality_Type_Caption; "Inspect. Recpt. Accept Level".FIELDCAPTION("Quality Type"))
            {
            }
            column(Vendor_Rating__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Vendor_Rating__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            dataitem("Inspect. Recpt. Accept Level"; "Inspect. Recpt. Accept Level")
            {
                DataItemLink = "Item No." = FIELD("Item No."), "Vendor No." = FIELD("Vendor No.");
                DataItemTableView = SORTING("Item No.", "Vendor No.", "Acceptance Code") WHERE(Status = CONST(true));
                column(Inspect__Recpt__Accept_Level__Quality_Type_; "Quality Type")
                {
                }
                column(Inspect__Recpt__Accept_Level__Acceptance_Code_; "Acceptance Code")
                {
                }
                column(Inspect__Recpt__Accept_Level__Reason_Code_; "Reason Code")
                {
                }
                column(Inspect__Recpt__Accept_Level_Quantity; Quantity)
                {
                }
                column(Inspect__Recpt__Accept_Level_Quantity_Control1000000013; Quantity)
                {
                }
                column(VendorRating; VendorRating)
                {
                }
                column(Total_QuantityCaption; Total_QuantityCaptionLbl)
                {
                }
                column(Inspect__Recpt__Accept_Level_Inspection_Receipt_No_; "Inspection Receipt No.")
                {
                }
                column(Inspect__Recpt__Accept_Level_Line_No_; "Line No.")
                {
                }
                column(Inspect__Recpt__Accept_Level_Item_No_; "Item No.")
                {
                }
                column(Inspect__Recpt__Accept_Level_Vendor_No_; "Vendor No.")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                VendorRating := 0;
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
        AccptLevels: Record "Acceptance Level";
        QtyAccepted: Decimal;
        VendorRating: Decimal;
        Vendor_RatingCaptionLbl: Label 'Vendor Rating';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
}

