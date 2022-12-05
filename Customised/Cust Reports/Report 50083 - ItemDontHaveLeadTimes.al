report 50083 "Item Don't Have Lead Times"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ItemDontHaveLeadTimes.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending) WHERE("Safety Lead Time" = FILTER(''),
            "Product Group Code cust" = FILTER(<> 'FPRODUCT' & <> 'CPCB'));//B2BUpg
            RequestFilterFields = "No.";
            column(Item__No__; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            column(Pord_Order; Pord_Order)
            {
            }
            column(Item_s_Don_t_Have_Lead_TimesCaption; Item_s_Don_t_Have_Lead_TimesCaptionLbl)
            {
            }
            column(Item__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Item_DescriptionCaption; FIELDCAPTION(Description))
            {
            }
            column(Production_OrderCaption; Production_OrderCaptionLbl)
            {
            }
            dataitem("Alternate Items"; "Alternate Items")
            {
                DataItemLink = "Alternative Item No." = FIELD("No.");

                DataItemTableView = SORTING("Item No.") ORDER(Ascending) WHERE("Alternative Item No." = FILTER(<> ''), "Item No." = FILTER(<> ''));
            }

            trigger OnAfterGetRecord()
            begin
                Pord_Order := '';
                "Prod. Order Component".RESET;
                "Prod. Order Component".SETCURRENTKEY("Prod. Order Component"."Item No.");
                "Prod. Order Component".SETRANGE("Prod. Order Component"."Item No.", Item."No.");
                "Prod. Order Component".SETFILTER("Prod. Order Component"."Production Plan Date", '>%1', WORKDATE);
                IF NOT "Prod. Order Component".FIND('-') THEN BEGIN
                    sale_Line.RESET;
                    sale_Line.SETCURRENTKEY(sale_Line."Material Reuired Date", sale_Line."No.");
                    sale_Line.SETFILTER(sale_Line."Material Reuired Date", '>%1', WORKDATE);
                    sale_Line.SETFILTER(sale_Line."To Be Shipped Qty", '>%1', 0);
                    sale_Line.SETRANGE(sale_Line."No.", Item."No.");
                    IF sale_Line.FIND('-') THEN
                        Pord_Order += sale_Line."Document No."
                    ELSE BEGIN
                        schedule.RESET;
                        schedule.SETCURRENTKEY(schedule."Material Required Date", schedule."No.");
                        schedule.SETFILTER(schedule."Material Required Date", '>%1', WORKDATE);
                        schedule.SETFILTER(schedule."To be Shipped Qty", '>%1', 0);
                        schedule.SETRANGE(schedule."No.", Item."No.");
                        IF NOT schedule.FIND('-') THEN
                            CurrReport.SKIP
                        ELSE
                            Pord_Order += schedule."Document No.";
                    END;
                END ELSE
                    Pord_Order += "Prod. Order Component"."Prod. Order No.";
            end;

            trigger OnPreDataItem()
            begin
                //CurrReport.BREAK;
            end;
        }
        dataitem("PRODUCTION ORDER"; "Production Order")
        {
            DataItemTableView = SORTING("Prod Start date") ORDER(Ascending) WHERE("Prod Start date" = FILTER(<> ''), "Sales Order No." = FILTER(<> ''));
            column(PRODUCTION_ORDER__No__; "No.")
            {
            }
            column(PRODUCTION_ORDER__Sales_Order_No__; "Sales Order No.")
            {
            }
            column(PRODUCTION_ORDER__Prod_Start_date_; "Prod Start date")
            {
            }
            column(EXPECTED_______CONFIREMED_PO_SCaption; EXPECTED_______CONFIREMED_PO_SCaptionLbl)
            {
            }
            column(PRODUCTION_ORDERCaption_Control1102154013; PRODUCTION_ORDERCaption_Control1102154013Lbl)
            {
            }
            column(SALES_ORDER_NO_Caption; SALES_ORDER_NO_CaptionLbl)
            {
            }
            column(PROD_START_DATECaption; PROD_START_DATECaptionLbl)
            {
            }
            column(PRODUCTION_ORDER_Status; Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF COPYSTR("Sales Order No.", 1, 7) = 'EFF/EXP' THEN BEGIN
                    SALES_HEADER.SETRANGE(SALES_HEADER."No.", "Sales Order No.");
                    IF SALES_HEADER.FINDFIRST THEN BEGIN
                        IF NOT SALES_HEADER."Sale Order Created" THEN
                            CurrReport.SKIP;
                        //ERROR('PLEASE CHANGE "EXPECTED ORDER" TO "SALE ORDER"');
                    END ELSE
                        CurrReport.SKIP;
                END ELSE
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                "PRODUCTION ORDER".SETFILTER("PRODUCTION ORDER"."Prod Start date", '>%1', TODAY);
            end;
        }
        dataitem("PRODUCTION ORDER2"; "Production Order")
        {
            DataItemTableView = SORTING("Prod Start date") ORDER(Ascending) WHERE("Prod Start date" = FILTER(<> ''), "Sales Order No." = FILTER(<> ''));
            column(PRODUCTION_ORDER2__No__; "No.")
            {
            }
            column(PRODUCTION_ORDER2__Sales_Order_No__; "Sales Order No.")
            {
            }
            column(PRODUCTION_ORDER2__Prod_Start_date_; "Prod Start date")
            {
            }
            column(DATE_NOT_UPDATED_PO_SCaption; DATE_NOT_UPDATED_PO_SCaptionLbl)
            {
            }
            column(PRODUCTION_ORDERCaption_Control1102154019; PRODUCTION_ORDERCaption_Control1102154019Lbl)
            {
            }
            column(SALES_ORDER_NO_Caption_Control1102154020; SALES_ORDER_NO_Caption_Control1102154020Lbl)
            {
            }
            column(PROD_START_DATECaption_Control1102154021; PROD_START_DATECaption_Control1102154021Lbl)
            {
            }
            column(PRODUCTION_ORDER2_Status; Status)
            {
            }

            trigger OnAfterGetRecord()
            begin
                POCOMPONENT.RESET;
                POCOMPONENT.SETRANGE(Status, "PRODUCTION ORDER2".Status);
                POCOMPONENT.SETRANGE("Prod. Order No.", "PRODUCTION ORDER2"."No.");
                POCOMPONENT.SETFILTER("Product Group Code", '<>%1&<>%2', 'FPRODUCT', 'CPCB');
                POCOMPONENT.SETRANGE("Production Plan Date", 0D);
                IF NOT POCOMPONENT.FINDSET THEN
                    CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin
                "PRODUCTION ORDER2".SETFILTER("Prod Start date", '>%1', TODAY);
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
        "Prod. Order Component": Record "Prod. Order Component";
        Pord_Order: Text[100];
        schedule: Record Schedule2;
        sale_Line: Record "Sales Line";
        Purchase_Line: Record "Purchase Line";
        QILE: Record "Quality Item Ledger Entry";
        Item1: Record Item;
        SALES_HEADER: Record "Sales Header";
        POCOMPONENT: Record "Prod. Order Component";
        Item_s_Don_t_Have_Lead_TimesCaptionLbl: Label 'Item''s Don''t Have Lead Times';
        Production_OrderCaptionLbl: Label 'Production Order';
        EXPECTED_______CONFIREMED_PO_SCaptionLbl: Label 'EXPECTED  -->  CONFIREMED PO''S';
        PRODUCTION_ORDERCaption_Control1102154013Lbl: Label 'PRODUCTION ORDER';
        SALES_ORDER_NO_CaptionLbl: Label 'SALES ORDER NO.';
        PROD_START_DATECaptionLbl: Label 'PROD START DATE';
        DATE_NOT_UPDATED_PO_SCaptionLbl: Label 'DATE NOT UPDATED PO''S';
        PRODUCTION_ORDERCaption_Control1102154019Lbl: Label 'PRODUCTION ORDER';
        SALES_ORDER_NO_Caption_Control1102154020Lbl: Label 'SALES ORDER NO.';
        PROD_START_DATECaption_Control1102154021Lbl: Label 'PROD START DATE';
}

