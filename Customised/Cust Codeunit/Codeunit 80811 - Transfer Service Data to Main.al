codeunit 80811 "Transfer Service Data to Main"
{
    // version B2Bupg


    trigger OnRun();
    begin
        Window.OPEN('Table Name #1#############');
        UpdateServHeader;
        UpdateServItemLine;
        UpdateServLine;
        Window.CLOSE;
    end;

    var
        TempServiceHead: Record "Temp Service Header";
        TempServiceItemLine: Record "Temp Service Item Line";
        TempServiceLine: Record "Temp Service Line";
        ServiceHead: Record "Service Header";
        ServiceItemLine: Record "Service Item Line";
        ServiceLine: Record "Service Line";
        Window: Dialog;


    procedure UpdateServHeader();
    begin
        Window.UPDATE(1, 'Service Header');
        TempServiceHead.RESET;
        IF TempServiceHead.FINDSET THEN
            REPEAT
                ServiceHead."No." := TempServiceHead."No.";
                ServiceHead.Description := TempServiceHead.Description;
                ServiceHead."Document Type" := TempServiceHead."Document Type";
                ServiceHead."Service Order Type" := TempServiceHead."Service Order Type";
                ServiceHead."Link Service to Service Item" := TempServiceHead."Link Service to Service Item";
                ServiceHead.Status := TempServiceHead.Status;
                ServiceHead.Priority := TempServiceHead.Priority;
                ServiceHead."Customer No." := TempServiceHead."Customer No.";
                ServiceHead.Name := TempServiceHead.Name;
                ServiceHead."Name 2" := TempServiceHead."Name 2";
                ServiceHead.Address := TempServiceHead.Address;
                ServiceHead."Address 2" := TempServiceHead."Address 2";
                ServiceHead.City := TempServiceHead.City;
                ServiceHead."Post Code" := TempServiceHead."Post Code";
                ServiceHead."Phone No." := TempServiceHead."Phone No.";
                ServiceHead."E-Mail" := TempServiceHead."E-Mail";
                ServiceHead."Phone No. 2" := TempServiceHead."Phone No. 2";
                ServiceHead."Fax No." := TempServiceHead."Fax No.";
                ServiceHead."Your Reference" := TempServiceHead."Your Reference";
                ServiceHead."Posting Date" := TempServiceHead."Posting Date";
                ServiceHead."Document Date" := TempServiceHead."Document Date";
                ServiceHead."Order Date" := TempServiceHead."Order Date";
                ServiceHead."Order Time" := TempServiceHead."Order Time";
                ServiceHead."Default Response Time (Hours)" := TempServiceHead."Default Response Time (Hours)";
                ServiceHead."Actual Response Time (Hours)" := TempServiceHead."Actual Response Time (Hours)";
                ServiceHead."Service Time (Hours)" := TempServiceHead."Service Time (Hours)";
                ServiceHead."Response Date" := TempServiceHead."Response Date";
                ServiceHead."Response Time" := TempServiceHead."Response Time";
                ServiceHead."Starting Date" := TempServiceHead."Starting Date";
                ServiceHead."Starting Time" := TempServiceHead."Starting Time";
                ServiceHead."Finishing Date" := TempServiceHead."Finishing Date";
                ServiceHead."Finishing Time" := TempServiceHead."Finishing Time";
                ServiceHead."Shortcut Dimension 1 Code" := TempServiceHead."Shortcut Dimension 1 Code";
                ServiceHead."Shortcut Dimension 2 Code" := TempServiceHead."Shortcut Dimension 2 Code";
                ServiceHead."Notify Customer" := TempServiceHead."Notify Customer";
                ServiceHead."Max. Labor Unit Price" := TempServiceHead."Max. Labor Unit Price";
                ServiceHead."Warning Status" := TempServiceHead."Warning Status";
                ServiceHead."Salesperson Code" := TempServiceHead."Salesperson Code";
                ServiceHead."Contract No." := TempServiceHead."Contract No.";
                ServiceHead."Contact Name" := TempServiceHead."Contact Name";
                ServiceHead."Bill-to Customer No." := TempServiceHead."Bill-to Customer No.";
                ServiceHead."Bill-to Name" := TempServiceHead."Bill-to Name";
                ServiceHead."Bill-to Address" := TempServiceHead."Bill-to Address";
                ServiceHead."Bill-to Address 2" := TempServiceHead."Bill-to Address 2";
                ServiceHead."Bill-to Post Code" := TempServiceHead."Bill-to Post Code";
                ServiceHead."Bill-to City" := TempServiceHead."Bill-to City";
                ServiceHead."Bill-to Contact" := TempServiceHead."Bill-to Contact";
                ServiceHead."Ship-to Code" := TempServiceHead."Ship-to Code";
                ServiceHead."Ship-to Name" := TempServiceHead."Ship-to Name";
                ServiceHead."Ship-to Address" := TempServiceHead."Ship-to Address";
                ServiceHead."Ship-to Address 2" := TempServiceHead."Ship-to Address 2";
                ServiceHead."Ship-to Post Code" := TempServiceHead."Ship-to Post Code";
                ServiceHead."Ship-to City" := TempServiceHead."Ship-to City";
                ServiceHead."Ship-to Fax No." := TempServiceHead."Ship-to Fax No.";
                ServiceHead."Ship-to E-Mail" := TempServiceHead."Ship-to E-Mail";
                ServiceHead."Ship-to Contact" := TempServiceHead."Ship-to Contact";
                ServiceHead."Ship-to Phone" := TempServiceHead."Ship-to Phone";
                ServiceHead."Ship-to Phone 2" := TempServiceHead."Ship-to Phone 2";
                ServiceHead."Language Code" := TempServiceHead."Language Code";
                ServiceHead."No. Series" := TempServiceHead."No. Series";
                ServiceHead."Gen. Bus. Posting Group" := TempServiceHead."Gen. Bus. Posting Group";
                ServiceHead."Currency Code" := TempServiceHead."Currency Code";
                ServiceHead."Currency Factor" := TempServiceHead."Currency Factor";
                ServiceHead."Service Zone Code" := TempServiceHead."Service Zone Code";
                ServiceHead."Responsibility Center" := TempServiceHead."Responsibility Center";
                ServiceHead."Location Code" := TempServiceHead."Location Code";
                ServiceHead."Customer Price Group" := TempServiceHead."Customer Price Group";
                ServiceHead."VAT Bus. Posting Group" := TempServiceHead."VAT Bus. Posting Group";
                ServiceHead."VAT Registration No." := TempServiceHead."VAT Registration No.";
                ServiceHead."VAT Base Discount %" := TempServiceHead."VAT Base Discount %";
                ServiceHead."Tax Area Code" := TempServiceHead."Tax Area Code";
                ServiceHead."Tax Liable" := TempServiceHead."Tax Liable";
                ServiceHead."Customer Disc. Group" := TempServiceHead."Customer Disc. Group";
                ServiceHead."Expected Finishing Date" := TempServiceHead."Expected Finishing Date";
                ServiceHead.Reserve := TempServiceHead.Reserve;
                ServiceHead."Bill-to County" := TempServiceHead."Bill-to County";
                ServiceHead.County := TempServiceHead.County;
                ServiceHead."Ship-to County" := TempServiceHead."Ship-to County";
                ServiceHead."Country/Region Code" := TempServiceHead."Country Code";
                ServiceHead."Bill-to Name 2" := TempServiceHead."Bill-to Name 2";
                ServiceHead."Bill-to Country/Region Code" := TempServiceHead."Bill-to Country Code";
                ServiceHead."Ship-to Name 2" := TempServiceHead."Ship-to Name 2";
                ServiceHead."Ship-to Country/Region Code" := TempServiceHead."Ship-to Country Code";
                ServiceHead."Contact No." := TempServiceHead."Contact No.";
                ServiceHead."Bill-to Contact No." := TempServiceHead."Bill-to Contact No.";
                ServiceHead."Allow Line Disc." := TempServiceHead."Allow Line Disc.";
                ServiceHead."Doc. No. Occurrence" := TempServiceHead."Doc. No. Occurrence";
                ServiceHead."Version No." := TempServiceHead."Version No.";
                ServiceHead.Purpose := TempServiceHead.Purpose;
                ServiceHead."Material Issue no." := TempServiceHead."Material Issue no.";
                ServiceHead.INSERT;
            UNTIL TempServiceHead.NEXT = 0;
    end;


    procedure UpdateServItemLine();
    begin
        Window.UPDATE(1, 'Service Item Line');
        TempServiceItemLine.RESET;
        IF TempServiceItemLine.FINDSET THEN
            REPEAT
                ServiceItemLine.INIT;
                ServiceItemLine.TRANSFERFIELDS(TempServiceItemLine);
                ServiceItemLine.INSERT;
            UNTIL TempServiceItemLine.NEXT = 0;
    end;


    procedure UpdateServLine();
    begin
        Window.UPDATE(1, 'Service Line');
        TempServiceLine.RESET;
        IF TempServiceLine.FINDSET THEN
            REPEAT
                ServiceLine.INIT;
                ServiceLine."Document No." := TempServiceLine."Document No.";
                ServiceLine."Line No." := TempServiceLine."Line No.";
                ServiceLine."Service Item Line No." := TempServiceLine."Service Item Line No.";
                ServiceLine."Service Item No." := TempServiceLine."Service Item No.";
                ServiceLine."Service Item Serial No." := TempServiceLine."Service Item Serial No.";
                //"Service Item Line Description" := TempServiceLine."Service Item Description";
                ServiceLine."Posting Date" := TempServiceLine."Posting Date";
                ServiceLine."Order Date" := TempServiceLine."Order Date";
                ServiceLine.Type := TempServiceLine.Type;
                ServiceLine."No." := TempServiceLine."No.";
                ServiceLine."Unit of Measure" := TempServiceLine."Unit of Measure";
                ServiceLine."Qty. per Unit of Measure" := TempServiceLine."Qty. per Unit of Measure";
                ServiceLine."Variant Code" := TempServiceLine."Variant Code";
                ServiceLine."Bin Code" := TempServiceLine."Bin Code";
                ServiceLine."Customer No." := TempServiceLine."Customer No.";
                ServiceLine."Ship-to Code" := TempServiceLine."Ship-to Code";
                ServiceLine."Bill-to Customer No." := TempServiceLine."Bill-to Customer No.";
                ServiceLine.Description := TempServiceLine.Description;
                ServiceLine."Description 2" := TempServiceLine."Description 2";
                ServiceLine."Unit of Measure Code" := TempServiceLine."Unit of Measure Code";
                ServiceLine."Shortcut Dimension 1 Code" := TempServiceLine."Shortcut Dimension 1 Code";
                ServiceLine."Shortcut Dimension 2 Code" := TempServiceLine."Shortcut Dimension 2 Code";
                ServiceLine."Posting Group" := TempServiceLine."Posting Group";
                ServiceLine."Currency Code" := TempServiceLine."Currency Code";
                ServiceLine."Service Price Group Code" := TempServiceLine."Service Price Group Code";
                ServiceLine."Fault Area Code" := TempServiceLine."Fault Area Code";
                ServiceLine."Symptom Code" := TempServiceLine."Symptom Code";
                ServiceLine."Fault Code" := TempServiceLine."Fault Code";
                ServiceLine."Resolution Code" := TempServiceLine."Resolution Code";
                ServiceLine."Exclude Warranty" := TempServiceLine."Exclude Warranty";
                ServiceLine.Warranty := TempServiceLine.Warranty;
                ServiceLine."Job No." := TempServiceLine."Job No.";
                ServiceLine."Contract No." := TempServiceLine."Contract No.";
                ServiceLine."Contract Disc. %" := TempServiceLine."Contract Disc. %";
                ServiceLine."Warranty Disc. %" := TempServiceLine."Warranty Disc. %";
                ServiceLine."Line Discount %" := TempServiceLine."Line Discount %";
                ServiceLine."Line Discount Amount" := TempServiceLine."Line Discount Amount";
                ServiceLine."VAT Calculation Type" := TempServiceLine."VAT Calculation Type";
                ServiceLine."VAT Bus. Posting Group" := TempServiceLine."VAT Bus. Posting Group";
                ServiceLine."VAT Prod. Posting Group" := TempServiceLine."VAT Prod. Posting Group";
                ServiceLine."VAT Base Amount" := TempServiceLine."VAT Base Amount";
                ServiceLine."VAT %" := TempServiceLine."VAT %";
                ServiceLine."Amount Including VAT" := TempServiceLine."Amount Including VAT";
                ServiceLine."Tax Area Code" := TempServiceLine."Tax Area Code";
                ServiceLine."Tax Liable" := TempServiceLine."Tax Liable";
                ServiceLine."Tax Group Code" := TempServiceLine."Tax Group Code";
                ServiceLine."Serv. Price Adjmt. Gr. Code" := TempServiceLine."Serv. Price Adjmt. Gr. Code";
                ServiceLine."Customer Price Group" := TempServiceLine."Customer Price Group";
                ServiceLine.Quantity := TempServiceLine.Quantity;
                ServiceLine."Qty. to Invoice" := TempServiceLine."Qty. to Invoice";
                ServiceLine."Unit Price" := TempServiceLine."Unit Price";
                ServiceLine."Unit Cost" := TempServiceLine."Unit Cost";
                ServiceLine."Unit Cost (LCY)" := TempServiceLine."Unit Cost (LCY)";
                ServiceLine.Amount := TempServiceLine.Amount;
                ServiceLine."Component Line No." := TempServiceLine."Component Line No.";
                ServiceLine."Spare Part Action" := TempServiceLine."Spare Part Action";
                ServiceLine."Fault Reason Code" := TempServiceLine."Fault Reason Code";
                ServiceLine."Replaced Item No." := TempServiceLine."Replaced Item No.";
                ServiceLine."Exclude Contract Discount" := TempServiceLine."Exclude Contract Discount";
                ServiceLine."Document Type" := TempServiceLine."Document Type";
                ServiceLine."Work Type Code" := TempServiceLine."Work Type Code";
                ServiceLine."Gen. Bus. Posting Group" := TempServiceLine."Gen. Bus. Posting Group";
                ServiceLine."Gen. Prod. Posting Group" := TempServiceLine."Gen. Prod. Posting Group";
                ServiceLine."Responsibility Center" := TempServiceLine."Responsibility Center";
                ServiceLine."Location Code" := TempServiceLine."Location Code";
                ServiceLine."Attached to Line No." := TempServiceLine."Attached to Line No.";
                ServiceLine."Item Category Code" := TempServiceLine."Item Category Code";
                ServiceLine.Nonstock := TempServiceLine.Nonstock;
                ServiceLine."Product Group Code Cust" := TempServiceLine."Product Group Code";
                ServiceLine."Quantity (Base)" := TempServiceLine."Quantity (Base)";
                ServiceLine."Qty. to Invoice (Base)" := TempServiceLine."Qty. to Invoice (Base)";
                ServiceLine."Outstanding Qty. (Base)" := TempServiceLine."Outstanding Qty. (Base)";
                //"Reserved Qty. (Base)" := TempServiceLine."Reserved Qty. (Base)";
                //"Reserved Quantity" :=  TempServiceLine."Reserved Quantity";
                ServiceLine.Reserve := TempServiceLine.Reserve;
                ServiceLine."Appl.-to Item Entry" := TempServiceLine."Apply to Service Entry";
                ServiceLine."Substitution Available" := TempServiceLine."Substitution Available";
                ServiceLine."Price Adjmt. Status" := TempServiceLine."Price Adjmt. Status";
                ServiceLine."Line Discount Type" := TempServiceLine."Line Discount Type";
                ServiceLine."Allow Line Disc." := TempServiceLine."Allow Line Disc.";
                ServiceLine."Customer Disc. Group" := TempServiceLine."Customer Disc. Group";
                ServiceLine."Resolution Description" := TempServiceLine."Resolution Description";
                ServiceLine."Fault Code Description" := TempServiceLine."Fault Code Description";
                ServiceLine."Fault Area Description" := TempServiceLine."Fault Area Description";
                ServiceLine."Symptom Description" := TempServiceLine."Symptom Description";
                ServiceLine."To Location" := TempServiceLine."To Location";
                ServiceLine."From Location" := TempServiceLine."From Location";
                ServiceLine.Account := TempServiceLine.Account;
                ServiceLine."WK.ST.Date" := TempServiceLine."WK.ST.Date";
                ServiceLine."WK.FH.Date" := TempServiceLine."WK.FH.Date";
                ServiceLine.Levels := TempServiceLine.Levels;
                ServiceLine.Status := TempServiceLine.Status;
                ServiceLine."Sub Service Item No." := TempServiceLine."Sub Service Item No.";
                ServiceLine."Service item Lot No" := TempServiceLine."Service item Lot No";
                ServiceLine.Zone := TempServiceLine.Zone;
                ServiceLine.Division := TempServiceLine.Division;
                ServiceLine.Station := TempServiceLine.Station;
                ServiceLine."Sent date time" := TempServiceLine."Sent date time";
                ServiceLine.Unitcost := TempServiceLine.Unitcost;
                ServiceLine."Sub Service item serial No." := TempServiceLine."Sub Service item serial No.";
                ServiceLine.INSERT;
            UNTIL TempServiceLine.NEXT = 0;
    end;
}

