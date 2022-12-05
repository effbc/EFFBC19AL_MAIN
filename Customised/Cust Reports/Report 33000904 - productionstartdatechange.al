report 33000904 productionstartdatechange
{
    DefaultLayout = RDLC;
    RDLCLayout = './productionstartdatechange.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            RequestFilterFields = Status, "Prod Start date";
            column(Production_order_NoCaption; Production_order_NoCaptionLbl)
            {
            }
            column(Production_start_dateCaption; Production_start_dateCaptionLbl)
            {
            }
            column(Sale_Order_NoCaption; Sale_Order_NoCaptionLbl)
            {
            }
            column(Production_Order_Status; Status)
            {
            }
            column(Production_Order_No_; "No.")
            {
            }
            dataitem("Prod. Order Component"; "Prod. Order Component")
            {
                DataItemLink = "Prod. Order No." = FIELD("No."), Status = FIELD(Status);
                column(Production_Order___No__; "Production Order"."No.")
                {
                }
                column(Production_Order___Prod_Start_date_; "Production Order"."Prod Start date")
                {
                }
                column(Production_Order___Sales_Order_No__; "Production Order"."Sales Order No.")
                {
                }
                column(Prod__Order_Component_Status; Status)
                {
                }
                column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
                {
                }
                column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
                {
                }
                column(Prod__Order_Component_Line_No_; "Line No.")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    //Rev01 Code Copied from //Prod. Order Component, Body (1) - OnPreSection()

                    "Prod. Order Component"."Production Plan Date" := "Production Order"."Prod Start date";
                    "Prod. Order Component".MODIFY;

                    //Rev01 Code Copied from //Prod. Order Component, Body (1) - OnPreSection()
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
        refreshdate: Date;
        Production_order_NoCaptionLbl: Label 'Production order No';
        Production_start_dateCaptionLbl: Label 'Production start date';
        Sale_Order_NoCaptionLbl: Label 'Sale Order No';
}

