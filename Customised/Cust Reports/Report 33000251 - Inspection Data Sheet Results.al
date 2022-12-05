report 33000251 "Inspection Data Sheet Results"
{
    // version QC1.0

    DefaultLayout = RDLC;
    RDLCLayout = './Inspection Data Sheet Results.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Datasheet Header"; "Inspection Datasheet Header")
        {
            column(Inspection_Datasheet_Header__No__; "No.")
            {
            }
            column(Inspection_Datasheet_Header_Description; Description)
            {
            }
            column(Inspection_Datasheet_Header__Receipt_No__; "Receipt No.")
            {
            }
            column(Inspection_Datasheet_Header__Vendor_No__; "Vendor No.")
            {
            }
            column(Inspection_Datasheet_Header__Item_No__; "Item No.")
            {
            }
            column(Inspection_Datasheet_Header_Quantity; Quantity)
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Group_Code_; "Inspection Group Code")
            {
            }
            column(Inspection_Datasheet_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Inspection_Datasheet_Header_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Inspection_Datasheet_Header__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(Inspection_Datasheet_Header__Vendor_No__Caption; FIELDCAPTION("Vendor No."))
            {
            }
            column(Inspection_Datasheet_Header__Item_No__Caption; FIELDCAPTION("Item No."))
            {
            }
            column(Inspection_Datasheet_Header_QuantityCaption; FIELDCAPTION(Quantity))
            {
            }
            column(Inspection_Datasheet_Header__Inspection_Group_Code_Caption; FIELDCAPTION("Inspection Group Code"))
            {
            }
            dataitem("Inspection Datasheet Line"; "Inspection Datasheet Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Character Code", "Character Group No.");
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
        TotalQty: Integer;
        AcceptQty: Integer;
        TotalCharTypes: Integer;
        TotalAceptTypes: Integer;
}

