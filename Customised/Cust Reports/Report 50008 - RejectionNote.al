report 50008 "Rejection Note"
{
    DefaultLayout = RDLC;
    RDLCLayout = './RejectionNote.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "No.", "Order No.";
            column(text; text)
            {
            }
            column(ssss; TEXT1)
            {
            }
            column(Text2; Text2)
            {
            }
            column(Inspection_Receipt_Header___Nature_Of_Rejection_; "Inspection Receipt Header"."Nature Of Rejection")
            {
            }
            column(Person; Person)
            {
            }
            column(Inspection_Receipt_Header___Posting_Date_; "Inspection Receipt Header"."Posting Date")
            {
            }
            column(QC_Confirmation__Rejection_NoteCaption; QC_Confirmation__Rejection_NoteCaptionLbl)
            {
            }
            column(EfftronicsCaption; EfftronicsCaptionLbl)
            {
            }
            column(Clearance_Rejection_Service_ReportCaption; Clearance_Rejection_Service_ReportCaptionLbl)
            {
            }
            column(QMS__Std__Ref__7_4Caption; QMS__Std__Ref__7_4CaptionLbl)
            {
            }
            column(EFF_QAS_R_038Caption; EFF_QAS_R_038CaptionLbl)
            {
            }
            column(REVISION__1_Caption; REVISION__1_CaptionLbl)
            {
            }
            column(V_BharatCaption; V_BharatCaptionLbl)
            {
            }
            column(INCHARGE___QC_Caption; INCHARGE___QC_CaptionLbl)
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Prepared_ByCaption; Prepared_ByCaptionLbl)
            {
            }
            column(Approved_ByCaption; Approved_ByCaptionLbl)
            {
            }
            column(QAS_ManagerCaption; QAS_ManagerCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(PAGE_NO__1_of_1Caption; PAGE_NO__1_of_1CaptionLbl)
            {
            }
            column(Purch__Rcpt__Header_No_; "No.")
            {
            }
            column(Purch__Rcpt__Header_Order_No_; "Order No.")
            {
            }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Quantity Rejected" = FILTER(> 0));
                column(Purch__Rcpt__Header___Vendor_Order_No__; "Purch. Rcpt. Header"."Vendor Order No.")
                {
                }
                column(Purch__Rcpt__Header___Vendor_Shipment_No__; "Purch. Rcpt. Header"."Vendor Shipment No.")
                {
                }
                column(Purch__Rcpt__Line__Purch__Rcpt__Line__Description; "Purch. Rcpt. Line".Description)
                {
                }
                column(Purch__Rcpt__Header___Buy_from_Vendor_Name_; "Purch. Rcpt. Header"."Buy-from Vendor Name")
                {
                }
                column(Purch__Rcpt__Header___Order_No__; "Purch. Rcpt. Header"."Order No.")
                {
                }
                column("Code"; Code)
                {
                }
                column(Purch__Rcpt__Line__Purch__Rcpt__Line__Make; "Purch. Rcpt. Line".Make)
                {
                }
                column(Purch__Rcpt__Header___Order_No___Control1000000061; "Purch. Rcpt. Header"."Order No.")
                {
                }
                column(Purch__Rcpt__Header___Vendor_Order_No___Control1000000064; "Purch. Rcpt. Header"."Vendor Order No.")
                {
                }
                column(Purch__Rcpt__Header___Vendor_Shipment_No___Control1000000066; "Purch. Rcpt. Header"."Vendor Shipment No.")
                {
                }
                column(Purch__Rcpt__Header___Buy_from_Vendor_Name__Control1000000067; "Purch. Rcpt. Header"."Buy-from Vendor Name")
                {
                }
                column(Code_Control1000000012; Code)
                {
                }
                column(Purch__Rcpt__Line__Purch__Rcpt__Line__Make_Control1102154016; "Purch. Rcpt. Line".Make)
                {
                }
                column(EmptyStringCaption; EmptyStringCaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102154027; EmptyStringCaption_Control1102154027Lbl)
                {
                }
                column(EmptyStringCaption_Control1102154028; EmptyStringCaption_Control1102154028Lbl)
                {
                }
                column(EmptyStringCaption_Control1102154029; EmptyStringCaption_Control1102154029Lbl)
                {
                }
                column(Supplier_NameCaption; Supplier_NameCaptionLbl)
                {
                }
                column(DC_No_Caption; DC_No_CaptionLbl)
                {
                }
                column(Invoice_No_Caption; Invoice_No_CaptionLbl)
                {
                }
                column(Material_DescriptionCaption; Material_DescriptionCaptionLbl)
                {
                }
                column(Order_No_Caption; Order_No_CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102154035; EmptyStringCaption_Control1102154035Lbl)
                {
                }
                column(NO___Caption; NO___CaptionLbl)
                {
                }
                column(QAS_COR_Caption; QAS_COR_CaptionLbl)
                {
                }
                column(EmptyStringCaption_Control1102154044; EmptyStringCaption_Control1102154044Lbl)
                {
                }
                column(MakeCaption; MakeCaptionLbl)
                {
                }
                column(Clearance_______RejectionCaption; Clearance_______RejectionCaptionLbl)
                {
                }
                column(Order_No_Caption_Control1000000024; Order_No_Caption_Control1000000024Lbl)
                {
                }
                column(Supplier_NameCaption_Control1000000025; Supplier_NameCaption_Control1000000025Lbl)
                {
                }
                column(DC_No_Caption_Control1000000046; DC_No_Caption_Control1000000046Lbl)
                {
                }
                column(Invoice_No_Caption_Control1000000047; Invoice_No_Caption_Control1000000047Lbl)
                {
                }
                column(EmptyStringCaption_Control1000000057; EmptyStringCaption_Control1000000057Lbl)
                {
                }
                column(EmptyStringCaption_Control1000000058; EmptyStringCaption_Control1000000058Lbl)
                {
                }
                column(EmptyStringCaption_Control1000000059; EmptyStringCaption_Control1000000059Lbl)
                {
                }
                column(EmptyStringCaption_Control1000000060; EmptyStringCaption_Control1000000060Lbl)
                {
                }
                column(NO___Caption_Control1000000068; NO___Caption_Control1000000068Lbl)
                {
                }
                column(QAS_COR_Caption_Control1000000010; QAS_COR_Caption_Control1000000010Lbl)
                {
                }
                column(MakeCaption_Control1102154015; MakeCaption_Control1102154015Lbl)
                {
                }
                column(EmptyStringCaption_Control1102154017; EmptyStringCaption_Control1102154017Lbl)
                {
                }
                column(Clearance_______RejectionCaption_Control1102154050; Clearance_______RejectionCaption_Control1102154050Lbl)
                {
                }
                column(Purch__Rcpt__Line_Document_No_; "Document No.")
                {
                }
                column(Purch__Rcpt__Line_Line_No_; "Line No.")
                {
                }
            }
            dataitem("Inspection Receipt Header"; "Inspection Receipt Header")
            {
                DataItemLink = "Receipt No." = FIELD("No."), "Order No." = FIELD("Order No.");
                DataItemTableView = SORTING("Receipt No.", "Item No.") ORDER(Ascending);
                column(Inspection_Receipt_Header__Inspection_Receipt_Header___Lot_No__; "Inspection Receipt Header"."Lot No.")
                {
                }
                column(Inspection_Receipt_Header__Inspection_Receipt_Header___Item_Description_; "Inspection Receipt Header"."Item Description")
                {
                }
                column(Inspection_Receipt_Header__Inspection_Receipt_Header__Quantity; "Inspection Receipt Header".Quantity)
                {
                }
                column(Inspection_Receipt_Header__Inspection_Receipt_Header___Qty__Accepted_; "Inspection Receipt Header"."Qty. Accepted")
                {
                }
                column(Inspection_Receipt_Header__Inspection_Receipt_Header___Qty__Rejected_; "Inspection Receipt Header"."Qty. Rejected")
                {
                }
                column(Qty_RejectedCaption; Qty_RejectedCaptionLbl)
                {
                }
                column(Qty_AcceptedCaption; Qty_AcceptedCaptionLbl)
                {
                }
                column(Total_QuantityCaption; Total_QuantityCaptionLbl)
                {
                }
                column(Batch_No_Caption; Batch_No_CaptionLbl)
                {
                }
                column(Material_Description_Caption; Material_Description_CaptionLbl)
                {
                }
                column(Inspection_Receipt_Header_No_; "No.")
                {
                }
                column(Inspection_Receipt_Header_Receipt_No_; "Receipt No.")
                {
                }
                column(Inspection_Receipt_Header_Order_No_; "Order No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    // "Purchase Line".SETRANGE("Purchase Line"."Document No.","Inspection Receipt Header"."Order No.");
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
        check: Boolean;
        x: Integer;
        y: Integer;
        text: Label 'The above mentioned Material is referred to be ';
        Person: Text[30];
        IRL: Record "Inspection Receipt Line";
        MC: Record "Machine Center";
        "Code": Text[30];
        Text2: Label ' according to the QA testing specification.';
        Choice: Option Rejection,Clearance;
        TEXT1: Text[30];
        QC_Confirmation__Rejection_NoteCaptionLbl: Label 'QC Confirmation /Rejection Note';
        EfftronicsCaptionLbl: Label 'Efftronics';
        Clearance_Rejection_Service_ReportCaptionLbl: Label 'Clearance/Rejection/Service Report';
        QMS__Std__Ref__7_4CaptionLbl: Label 'QMS. Std. Ref: 7.4';
        EFF_QAS_R_038CaptionLbl: Label 'EFF/QAS/R/038';
        REVISION__1_CaptionLbl: Label 'REVISION: 1 ';
        V_BharatCaptionLbl: Label 'V.Bharat';
        INCHARGE___QC_CaptionLbl: Label '(INCHARGE - QC)';
        RemarksCaptionLbl: Label 'Remarks';
        Prepared_ByCaptionLbl: Label 'Prepared By';
        Approved_ByCaptionLbl: Label 'Approved By';
        QAS_ManagerCaptionLbl: Label 'QAS Manager';
        DateCaptionLbl: Label 'Date';
        PAGE_NO__1_of_1CaptionLbl: Label 'PAGE NO: 1 of 1';
        EmptyStringCaptionLbl: Label ':';
        EmptyStringCaption_Control1102154027Lbl: Label ':';
        EmptyStringCaption_Control1102154028Lbl: Label ':';
        EmptyStringCaption_Control1102154029Lbl: Label ':';
        Supplier_NameCaptionLbl: Label 'Supplier Name';
        DC_No_CaptionLbl: Label 'DC No.';
        Invoice_No_CaptionLbl: Label 'Invoice No.';
        Material_DescriptionCaptionLbl: Label 'Material Description';
        Order_No_CaptionLbl: Label 'Order No.';
        EmptyStringCaption_Control1102154035Lbl: Label ':';
        NO___CaptionLbl: Label 'NO : ';
        QAS_COR_CaptionLbl: Label '/QAS/COR/';
        EmptyStringCaption_Control1102154044Lbl: Label ':';
        MakeCaptionLbl: Label 'Make';
        Clearance_______RejectionCaptionLbl: Label 'Clearance    /  Rejection';
        Order_No_Caption_Control1000000024Lbl: Label 'Order No.';
        Supplier_NameCaption_Control1000000025Lbl: Label 'Supplier Name';
        DC_No_Caption_Control1000000046Lbl: Label 'DC No.';
        Invoice_No_Caption_Control1000000047Lbl: Label 'Invoice No.';
        EmptyStringCaption_Control1000000057Lbl: Label ':';
        EmptyStringCaption_Control1000000058Lbl: Label ':';
        EmptyStringCaption_Control1000000059Lbl: Label ':';
        EmptyStringCaption_Control1000000060Lbl: Label ':';
        NO___Caption_Control1000000068Lbl: Label 'NO : ';
        QAS_COR_Caption_Control1000000010Lbl: Label '/QAS/COR/';
        MakeCaption_Control1102154015Lbl: Label 'Make';
        EmptyStringCaption_Control1102154017Lbl: Label ':';
        Clearance_______RejectionCaption_Control1102154050Lbl: Label 'Clearance    /  Rejection';
        Qty_RejectedCaptionLbl: Label 'Qty Rejected';
        Qty_AcceptedCaptionLbl: Label 'Qty Accepted';
        Total_QuantityCaptionLbl: Label 'Total Quantity';
        Batch_No_CaptionLbl: Label 'Batch No.';
        Material_Description_CaptionLbl: Label 'Material Description ';
}

