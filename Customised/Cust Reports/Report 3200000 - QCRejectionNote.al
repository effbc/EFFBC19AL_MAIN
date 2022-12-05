report 32000006 "QC Rejection Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './QCRejectionNote.rdl';
    //EnableExternalAssemblies = 'true';
    EnableExternalImages = true;
    EnableHyperlinks = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
        {
            RequestFilterFields = "No.";
            RequestFilterHeading = 'QC Rejection Note';
            column(IR_NO; "Inspection Receipt Header"."No.")
            {
            }
            column(ItemNo; "Inspection Receipt Header"."Item No.")
            {
            }
            column(Item_Desc; "Inspection Receipt Header"."Item Description")
            {
            }
            column(Po_No; "Inspection Receipt Header"."Order No.")
            {
            }
            column(Vendor_Name; "Inspection Receipt Header"."Vendor Name")
            {
            }
            column(Make; "Inspection Receipt Header".Make)
            {
            }
            column(Lot; "Inspection Receipt Header"."Lot No.")
            {
            }
            column(Total_Qty; "Inspection Receipt Header".Quantity)
            {
            }
            column(Acceptd_Qty; "Inspection Receipt Header"."Qty. Accepted")
            {
            }
            column(Rejected_Qty; "Inspection Receipt Header"."Qty. Rejected")
            {
            }
            column(Rejection_Category; "Inspection Receipt Header"."Nature Of Rejection")
            {
            }
            column(Rejection_Desc; "Inspection Receipt Header"."Reason Description")
            {
            }
            column(Inward_date; "Inspection Receipt Header"."IDS creation Date")
            {
            }
            column(Location_Code; "Inspection Receipt Header"."Location Code")
            {
            }
            column(Posting_Date; "Inspection Receipt Header"."Posted Date")
            {
            }
            column(uom; "Inspection Receipt Header"."Unit Of Measure Code")
            {
            }
            column(Supplier_dc_no; Supplied_Dc_no)
            {
            }
            column(attc; attachments.FileAttachment)
            {
            }
            column(fiepath; filepath)
            {
            }
            column(invoice_no; invoice_no)
            {
            }

            trigger OnAfterGetRecord()
            begin
                prh.RESET;
                prh.SETFILTER("No.", "Inspection Receipt Header"."Receipt No.");
                IF prh.FINDSET THEN BEGIN
                    Supplied_Dc_no := prh."Vendor Shipment No.";
                    invoice_no := prh."Vendor Order No.";
                END;
                filepath := 'file:\\erpserver\ErpAttachments\' + "Inspection Receipt Header"."No." + '.jpg';
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

        trigger OnOpenPage()
        begin
            //"Inspection Receipt Header".SETFILTER("No.",'<>%1','');
        end;
    }

    labels
    {
    }

    var
        filepath: Text;
        prh: Record "Purch. Rcpt. Header";
        Supplied_Dc_no: Code[40];
        attachments: Record Attachments;
        Fname: Text[250];
        invoice_no: Code[40];
        test: Code[30];
        IR: Code[30];

    procedure SetValues(MyVariable: Code[30])
    begin
        test := MyVariable;
    end;
}

