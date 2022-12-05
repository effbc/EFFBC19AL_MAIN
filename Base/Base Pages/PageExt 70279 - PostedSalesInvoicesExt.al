pageextension 70279 PostedSalesInvoicesExt extends 143
{
    layout
    {
        addfirst(Control1)
        {
            field("xRec.COUNT"; xRec.COUNT)
            {
                ApplicationArea = All;

            }
        }
        modify("Ship-to Post Code")
        {
            Editable = true;
            ApplicationArea = All;
            Visible = true;

        }
        addafter("Sell-to Customer Name")
        {
            field("Sell-to City"; Rec."Sell-to City")
            {
                ApplicationArea = All;

            }
            field(Product; Rec.Product)
            {
                ApplicationArea = All;

            }
            field(Territory; Rec.Territory)
            {
                ApplicationArea = All;

            }

            field("Customer Posting Group"; Rec."Customer Posting Group")
            {
                ApplicationArea = All;

            }
            field("Total Excise Amount"; Rec."Total Excise Amount")
            {
                ApplicationArea = All;

            }
            field("Extended Date"; Rec."Extended Date")
            {
                ApplicationArea = All;

            }
            field("C-form Status"; Rec."C-form Status")
            {
                ApplicationArea = All;

            }
            /* field("Form Code"; "Form Code")
              {
                  ApplicationArea = All;

              }*/

            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;

            }
            field(WayBillNo; Rec.WayBillNo)
            {
                ApplicationArea = All;

            }
            field("Sale Order Total Amount"; Rec."Sale Order Total Amount")
            {
                ApplicationArea = All;

            }
            field("Total Invoiced Amount"; Rec."Total Invoiced Amount")
            {
                ApplicationArea = All;

            }
            field("Ship-to Address"; Rec."Ship-to Address")
            {
                ApplicationArea = All;

            }

            /* field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;

            } */
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                ApplicationArea = All;

            }
            field("Customer Order Date"; Rec."Customer Order Date")
            {
                ApplicationArea = All;

            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;

            }
        }
        addafter("Shipment Date")
        {
            field("Date Sent"; Rec."Date Sent")
            {
                ApplicationArea = All;

            }
            field("Consignee Name"; Rec."Consignee Name")
            {
                ApplicationArea = All;

            }
            field("Send for Assurance"; Rec."BizTalk Document Sent")
            {
                Caption = 'Send for Assurance';
                ApplicationArea = All;
            }
            field("Security Deposit Amount"; Rec."Security Deposit Amount")
            {
                ApplicationArea = All;

            }
            field("SD Status"; Rec."SD Status")
            {
                ApplicationArea = All;

            }
            field(SecDepStatus; Rec.SecDepStatus)
            {
                ApplicationArea = All;

            }
            field("Final Railway Bill Date"; Rec."Final Railway Bill Date")
            {
                ApplicationArea = All;

            }
            field("Warranty Period"; Rec."Warranty Period")
            {
                ApplicationArea = All;

            }
            field("EMD Amount"; Rec."EMD Amount")
            {
                ApplicationArea = All;

            }
            field("Tender No."; Rec."Tender No.")
            {
                ApplicationArea = All;

            }
            field(Order_After_CF_Integration; Rec.Order_After_CF_Integration)
            {
                ApplicationArea = All;

            }
        }
        addafter("Document Exchange Status")
        {
            field("Customer GST Reg. No."; Rec."Customer GST Reg. No.")
            {
                ApplicationArea = All;

            }
            field("Blanket Order No"; Rec."Blanket Order No")
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        modify(Print)
        {
            trigger OnAfterAction()
            begin
                /* REPORT.RUNMODAL(REPORT::"Sales - Invoice_GST_Test", TRUE, TRUE, SalesInvHeader);


                IF USERID = 'EFFTRONICS\PRANAVI' THEN
                    REPORT.RUNMODAL(REPORT::"Sales - Invoice_GST_Test", TRUE, TRUE, SalesInvHeader)
                ELSE */
            end;
        }
    }

    var
        myInt: Integer;
}