report 33000268 "Items In Quality"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Items In Quality.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "QC Enabled", "Spec ID", "WIP QC Enabled", "WIP Spec ID";
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Un_Inspected_QtyCaption; Un_Inspected_QtyCaptionLbl)
            {
            }
            column(Pending_QtyCaption; Pending_QtyCaptionLbl)
            {
            }
            column(Rework_QtyCaption; Rework_QtyCaptionLbl)
            {
            }
            column(Rejected_QtyCaption; Rejected_QtyCaptionLbl)
            {
            }
            dataitem("Inspection Datasheet Header"; "Inspection Datasheet Header")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("Purchase Consignment No.") WHERE("Source Type" = CONST("In Bound"));
            }
            dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("No.") WHERE("Source Type" = CONST("In Bound"), Status = CONST(false));

                trigger OnAfterGetRecord();
                begin
                    PendingQty := PendingQty + "Inspection Datasheet Header".Quantity;
                end;
            }
            dataitem("Inspection Receipt Header2"; "Inspection Receipt Header")
            {
                DataItemLink = "Item No." = FIELD("No.");
                DataItemTableView = SORTING("No.") WHERE("Source Type" = CONST("In Bound"), Status = CONST(true));

                trigger OnAfterGetRecord();
                begin
                    RejectedQty := RejectedQty + "Inspection Receipt Header2"."Qty. Rejected" -
                      "Inspection Receipt Header2"."Qty. Sent To Vendor (Rejected)";
                    ReworkQty := ReworkQty + "Inspection Receipt Header2"."Qty. Rework"
                      - "Inspection Receipt Header2"."Qty. Sent To Vendor (Rework)";
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(UnInspectedQty; UnInspectedQty)
                {
                }
                column(PendingQty; PendingQty)
                {
                }
                column(ReworkQty; ReworkQty)
                {
                }
                column(RejectedQty; RejectedQty)
                {
                }
                column(Integer_Number; Number)
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                UnInspectedQty := 0;
                PendingQty := 0;
                RejectedQty := 0;
                ReworkQty := 0;
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
        InspectReceiptHeader: Record "Inspection Receipt Header";
        UnInspectedQty: Decimal;
        PendingQty: Decimal;
        RejectedQty: Decimal;
        ReworkQty: Decimal;
        Un_Inspected_QtyCaptionLbl: Label 'Un Inspected Qty';
        Pending_QtyCaptionLbl: Label 'Pending Qty';
        Rework_QtyCaptionLbl: Label 'Rework Qty';
        Rejected_QtyCaptionLbl: Label 'Rejected Qty';
}

