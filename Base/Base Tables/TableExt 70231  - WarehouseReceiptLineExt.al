tableextension 70231 WarehouseReceiptLine extends "Warehouse Receipt Line"
{
    fields
    {
        field(33000250; "Quantity Accepted"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Rework"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000252; "Quantity Rejected"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000253; "Qty. Sending To Quality"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000254; "Qty. Sent To Quality"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }

    PROCEDURE GetWhseRcptLine(VAR WhseRcptLine: Record "Warehouse Receipt Line"; WhseRcptHeaderNo: Code[20]; SourceType: Integer; SourceSubType: Option; SourceNo: Code[20]; SourceLineNo: Integer);
    BEGIN
        WhseRcptLine.SetRange("No.", WhseRcptHeaderNo);
        WhseRcptLine.SetRange("Source Type", SourceType);
        WhseRcptLine.SetRange("Source Subtype", SourceSubType);
        WhseRcptLine.SetRange("Source No.", SourceNo);
        WhseRcptLine.SetRange("Source Line No.", SourceLineNo);
        WhseRcptLine.FindFirst;
    END;


    PROCEDURE "--QC--"();
    BEGIN
    END;


    PROCEDURE CreateInspectionDataSheets();
    VAR
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
    BEGIN
        TestField("Qty. Sending To Quality");
        PurchHeader.Get(PurchHeader."Document Type"::Order, "Source No.");
        PurchHeader.TestField(Status, PurchHeader.Status::Released);
        PurchLine.Get(PurchLine."Document Type"::Order, "Source No.", "Source Line No.");
        PurchLine.TestField("Quality Before Receipt", true);
        PurchLine."Qty. Sending To Quality" := "Qty. Sending To Quality";
        InspectDataSheets.CreatePurLineInspectDataSheet(PurchHeader, PurchLine);
        PurchLine.Modify;
        "Qty. Sent To Quality" := "Qty. Sent To Quality" + "Qty. Sending To Quality";
        "Qty. Sending To Quality" := 0;
        Modify;
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetRange(InspectDataSheet."Order No.", "Source No.");
        InspectDataSheet.SetRange("Purch Line No", "Source Line No.");
        InspectDataSheet.SetRange("Source Type", InspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetRange("Order No.", "Source No.");
        PostInspectDataSheet.SetRange("Purch Line No", "Source Line No.");
        PostInspectDataSheet.SetRange("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Source No.");
        InspectionReceipt.SetRange("Purch Line No", "Source Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Source No.");
        InspectionReceipt.SetRange("Purch Line No", "Source Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;
}

