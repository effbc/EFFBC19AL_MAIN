report 33000890 "Mat-req-report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Mat-req-report.rdl';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Mat-req-report';

    dataset
    {
        dataitem("Material Issues Header"; "Material Issues Header")
        {
            RequestFilterFields = "No.";
            column(Header; Header)
            {
            }
            column(Material_Issues_Header__No__; "No.")
            {
            }
            column(Material_Issues_Header__User_ID_; "User ID")
            {
            }
            column(Material_Issues_Header__Proj_Description_; "Proj Description")
            {
            }
            column(Material_Issues_Header__Resource_Name_; "Resource Name")
            {
            }
            column(Material_Issues_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Material_Issues_Header__User_ID_Caption; FIELDCAPTION("User ID"))
            {
            }
            column(Material_Issues_Header__Proj_Description_Caption; FIELDCAPTION("Proj Description"))
            {
            }
            column(Material_Issues_Header__Resource_Name_Caption; FIELDCAPTION("Resource Name"))
            {
            }
            column(Requested_Item_DetailsCaption; Requested_Item_DetailsCaptionLbl)
            {
            }
            dataitem("Material Issues Line"; "Material Issues Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(Material_Issues_Line__Item_No__; "Item No.")
                {
                }
                column(Material_Issues_Line_Quantity; Quantity)
                {
                }
                column(Material_Issues_Line_Description; Description)
                {
                }
                column(Material_Issues_Line__Item_No___Control1102154009; "Item No.")
                {
                }
                column(Material_Issues_Line_Description_Control1102154013; Description)
                {
                }
                column(Material_Issues_Line_Inventory; Inventory)
                {
                }
                column(Material_Issues_Line__Transfer_from_Code_; "Transfer-from Code")
                {
                }
                column(Material_Issues_Line__Unit_Cost_; "Material Issues Line"."Unit Cost")
                {
                }
                column(Material_Issues_Line_Quantity_Control1102154021; Quantity)
                {
                }
                column(Material_Issues_Line__Qty__to_Receive_; "Qty. to Receive")
                {
                }
                column(Material_Issues_Line__Item_No__Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Material_Issues_Line_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Material_Issues_Line_QuantityCaption; FIELDCAPTION(Quantity))
                {
                }
                column(Material_Issues_Line__Item_No___Control1102154009Caption; FIELDCAPTION("Item No."))
                {
                }
                column(Material_Issues_Line_Description_Control1102154013Caption; FIELDCAPTION(Description))
                {
                }
                column(Material_Issues_Line_InventoryCaption; FIELDCAPTION(Inventory))
                {
                }
                column(Material_Issues_Line__Transfer_from_Code_Caption; FIELDCAPTION("Transfer-from Code"))
                {
                }
                column(Material_Issues_Line__Unit_Cost_Caption; FIELDCAPTION("Unit Cost"))
                {
                }
                column(Material_Issues_Line_Quantity_Control1102154021Caption; FIELDCAPTION(Quantity))
                {
                }
                column(Material_Issues_Line__Qty__to_Receive_Caption; FIELDCAPTION("Qty. to Receive"))
                {
                }
                column(Material_Issues_Line_Document_No_; "Document No.")
                {
                }
                column(Material_Issues_Line_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    MIL.RESET;
                    MIL.SETRANGE("Document No.", "Material Issues Header"."No.");
                    MIL.SETFILTER(Quantity, '>%1', 0);
                    IF MIL.FINDSET THEN BEGIN
                        REPEAT
                        BEGIN
                            Itm.RESET;
                            Itm.SETRANGE("No.", MIL."Item No.");
                            IF Itm.FINDSET THEN
                                ITEM_COST := ITEM_COST + (MIL.Quantity * Itm."Last Direct Cost");
                        END;
                        // MESSAGE('ITM:'+Itm."No." +'---'+FORMAT(ITEM_COST));
                        UNTIL MIL.NEXT = 0;
                    END;
                end;
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
        Header: Text[75];
        Vendor: Record 23;
        Requested_Item_DetailsCaptionLbl: Label 'Requested Item Details';
        MIL: Record 50002;
        Itm: Record 27;
        MR: Char;
        ITEM_COST: Decimal;
}

