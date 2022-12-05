report 33000256 "Vendor Acceptance Rating"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Vendor Acceptance Rating.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Vendor Rating"; "Vendor Rating")
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Item No.", "Vendor No.";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(Rating; Rating)
            {
            }
            column(Vendor_Rating__Vendor_Rating__Reject; "Vendor Rating".Reject)
            {
            }
            column(Vendor_Rating__Vendor_Rating__Rework; "Vendor Rating".Rework)
            {
            }
            column(Vendor_Rating__Vendor_Rating___Accepted_UD_; "Vendor Rating"."Accepted UD")
            {
            }
            column(Vendor_Rating__Vendor_Rating__Accepted; "Vendor Rating".Accepted)
            {
            }
            column(Vendor_Rating__Vendor_Rating__Inspected; "Vendor Rating".Inspected)
            {
            }
            column(Vendor_Rating__Item_No__; "Item No.")
            {
            }
            column(Vendor_Rating__Vendor_No__; "Vendor No.")
            {
            }
            column(Vendor_Rating__Item_No___Control1000000000; "Item No.")
            {
            }
            column(Vendor_Rating__Vendor_No___Control1000000002; "Vendor No.")
            {
            }
            column(Rating_PointsCaption; Rating_PointsCaptionLbl)
            {
            }
            column(Vendor_Rating__Vendor_Rating__RejectCaption; FIELDCAPTION(Reject))
            {
            }
            column(Vendor_Rating__Vendor_Rating__ReworkCaption; FIELDCAPTION(Rework))
            {
            }
            column(Vendor_Rating__Vendor_Rating___Accepted_UD_Caption; FIELDCAPTION("Accepted UD"))
            {
            }
            column(Vendor_Rating__Vendor_Rating__AcceptedCaption; FIELDCAPTION(Accepted))
            {
            }
            column(InspectedCaption; InspectedCaptionLbl)
            {
            }
            column(Vendor_Rating__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Vendor_Rating__Vendor_No___Control1000000002Caption; FIELDCAPTION("Vendor No."))
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
            column(Vendor_Rating__Item_No___Control1000000000Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Vendor_Rating__Vendor_No___Control1000000002Caption_Control1000000003; FIELDCAPTION("Vendor No."))
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
                IF FixedRating THEN BEGIN
                    CALCFIELDS(Inspected, Accepted, Reject, Rework, "Accepted UD");
                    ReceivedItems := "Vendor Rating".Inspected;
                    AcceptedItems := 0;
                    "Acc.UDItems" := 0;
                    ReworkItems := 0;
                    RejectedItems := 0;

                    IF Inspected <> 0 THEN BEGIN
                        AcceptedItems := (100 / ReceivedItems) * "Vendor Rating".Accepted;
                        "Acc.UDItems" := (100 / ReceivedItems) * "Vendor Rating"."Accepted UD";
                        RejectedItems := (100 / ReceivedItems) * "Vendor Rating".Reject;
                        ReworkItems := (100 / ReceivedItems) * "Vendor Rating".Rework;
                        Rating := AcceptedItems * RatingForAccepted + "Acc.UDItems" * RatingForAccUD +
                          ReworkItems * RatingForRework + RejectedItems * RatingForRejected;
                    END;
                END;
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
        ReceivedItems: Decimal;
        AcceptedItems: Decimal;
        RejectedItems: Decimal;
        "Acc.UDItems": Decimal;
        ReworkItems: Decimal;
        Rating: Decimal;
        RatingForAccepted: Decimal;
        RatingForAccUD: Decimal;
        RatingForRework: Decimal;
        RatingForRejected: Decimal;
        FixedRating: Boolean;
        Rating_PointsCaptionLbl: Label 'Rating Points';
        InspectedCaptionLbl: Label 'Inspected';
        Vendor_RatingCaptionLbl: Label 'Vendor Rating';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
}

