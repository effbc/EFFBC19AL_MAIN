codeunit 60013 "Material Issue Line-Reserve"
{
    // version MI1.0

    Permissions = TableData "Reservation Entry" = rimd;

    trigger OnRun();
    begin
    end;

    var
        Text000: Label 'Codeunit is not initialized correctly.';
        Text001: Label 'Reserved quantity cannot be greater than %1';
        Text002: Label 'must be filled in when a quantity is reserved';
        Text003: Label 'must not be changed when a quantity is reserved';
        Text004: Label 'Counting records...';
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        ActualQty: Decimal;
        ActualQtytoRecevie: Decimal;
        "Material Issues Header": Record "Material Issues Header";
        QLE: Record "Quality Item Ledger Entry";
        Item: Record Item;


    procedure AssistEditLotSerialNo(var TrackingSpecification: Record "Mat.Issue Track. Specification"; LookupMode: Option "Serial No.","Lot No."; MaxQuantity: Decimal; "IssueNo.": Code[20]): Boolean;
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempEntrySummary: Record "Mat.Issue Entry Summary";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        ItemTrackingSummaryForm: Page "MaterialIssues Entry Summary";
        LastEntryNo: Integer;
        Window: Dialog;
        InsertRec: Boolean;
        TempTrackingSpecification: Record "Mat.Issue Track. Specification";
        MaterialIssueLine: Record "Material Issues Line";
        PMI: Record "Posted Material Issues Header";
        UsrId: Code[50];
        MIH: Record "Material Issues Header";
        IsExp: Boolean;
        AssignBatch: Codeunit "Assign Batch No's";
    begin
        IF TempEntrySummary.FINDFIRST THEN
            TempEntrySummary.DELETEALL;
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ItemLedgEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        ItemLedgEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");

        // added by sundar to decrease time in material returns
        IF NOT (TrackingSpecification."Location Code" IN ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR', 'MCH', 'CST']) THEN //CST Dept Added by vishnu on 22-10-2019
        BEGIN
            IF TrackingSpecification."Prod. Order No." = 'EFF08TOL01' THEN
                ItemLedgEntry.SETFILTER(ItemLedgEntry."ITL Doc No.", '%1|%2|%3', 'EFF08TOL01', 'EFF06TOL01', 'EFF06MPR01')
            ELSE
                IF TrackingSpecification."Prod. Order No." = 'EFF12TRC01' THEN
                    ItemLedgEntry.SETFILTER(ItemLedgEntry."ITL Doc No.", '%1|%2', 'EFF12TRC01', 'EFF08GEN001')
                ELSE
                    IF TrackingSpecification."Prod. Order No." IN ['RDL07WSC01', 'WSC09IST01'] THEN
                        ItemLedgEntry.SETFILTER(ItemLedgEntry."ITL Doc No.", '%1|%2|%3', 'RDL07WSC01', 'RDL07WSC03', 'WSC09IST01')

                    ELSE
                        ItemLedgEntry.SETRANGE(ItemLedgEntry."ITL Doc No.", TrackingSpecification."Prod. Order No.");
        END;

        // added by sundar to decrease time in material returns

        ItemLedgEntry.SETRANGE(Open, TRUE);


        // PHANI CS TRACKING
        /*
     IF (TrackingSpecification."Location Code"='SITE') OR (TrackingSpecification."Location Code"='OLD STOCK') THEN
     BEGIN
       "Material Issues Header".SETRANGE("Material Issues Header"."No.",TrackingSpecification."Order No.");
       IF "Material Issues Header".FINDFIRST THEN
       BEGIN
          ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code","Material Issues Header"."Shortcut Dimension 2 Code");
       END;
     END ELSE IF TrackingSpecification."Location Code"='CS' THEN
     BEGIN
       ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code",'H-OFF');

     END;
     // PHANI CS TRACKING
     */
        ItemLedgEntry.SETFILTER(ItemLedgEntry."Remaining Quantity", '>%1', 0);
        Item.GET(TrackingSpecification."Item No.");
        ItemTrackingCode.GET(Item."Item Tracking Code");
        CASE LookupMode OF
            LookupMode::"Serial No.":
                ItemLedgEntry.SETFILTER("Serial No.", '<>%1', '');
            LookupMode::"Lot No.":
                ItemLedgEntry.SETFILTER("Lot No.", '<>%1', '');
        END;
        IF ItemLedgEntry.FINDSET THEN
            REPEAT
                //>>Added by Pranavi on 20-05-2017 for MSL Process
                IsExp := FALSE;
                IF USERID IN ['EFFTRONICS\PRANAVI'] THEN BEGIN
                    IF (ItemLedgEntry."Location Code" IN ['CS STR', 'R&D STR', 'PRODSTR', 'STR', 'MCH']) THEN BEGIN
                        IF AssignBatch.MSLItemExpiryDate(ItemLedgEntry) THEN
                            IsExp := TRUE;
                    END;
                END;
                //<<Added by Pranavi on 20-05-2017 for MSL Process
                IF IsExp = FALSE THEN BEGIN
                    CASE LookupMode OF
                        LookupMode::"Serial No.":
                            TempEntrySummary.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");
                        LookupMode::"Lot No.":
                            TempEntrySummary.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");
                    END;
                    /* TempEntrySummary.INIT;
                      TempEntrySummary."Entry No." := ItemLedgEntry."Entry No.";
                      TempEntrySummary."Table ID" := DATABASE :: "Material Issues Line";
                      TempEntrySummary."Lot No." := ItemLedgEntry."Lot No.";
                      TempEntrySummary."Serial No." := ItemLedgEntry."Serial No.";
                      TempEntrySummary."Item No." := ItemLedgEntry."Item No.";
                      TempEntrySummary."Location Code" := ItemLedgEntry."Location Code";
                      TempEntrySummary."Total Quantity" := ItemLedgEntry."Remaining Quantity";
                      TempEntrySummary.INSERT;
                      IF ItemLedgEntry.Positive THEN BEGIN
                        TempEntrySummary."Warranty Date" := ItemLedgEntry."Warranty Date";
                        TempEntrySummary."Expiration Date" := ItemLedgEntry."Expiration Date";
                        TempEntrySummary."Posting Date" := ItemLedgEntry."Posting Date";
                        TempEntrySummary.CALCFIELDS("Total Reserved Quantity");
                        TempEntrySummary."Total Available Quantity" := TempEntrySummary."Total Quantity" - TempEntrySummary."Total Reserved Quantity";
                      END;
                      TempEntrySummary.MODIFY;   // Old Code
                      */
                    // Added by Pranavi on 26-Nov-2016 for Restrincting Return Material to only select req. person material only
                    UsrId := '';
                    IF ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Transfer THEN BEGIN
                        PMI.RESET;
                        PMI.SETRANGE(PMI."No.", ItemLedgEntry."Document No.");
                        IF PMI.FINDFIRST THEN
                            UsrId := PMI."User ID"
                        ELSE
                            UsrId := ItemLedgEntry."User ID";
                    END ELSE
                        UsrId := ItemLedgEntry."User ID";
                    // End--Pranavi
                    QLE.SETRANGE(QLE."Entry No.", ItemLedgEntry."Entry No.");
                    IF NOT (QLE.FINDFIRST) THEN BEGIN
                        TempEntrySummary.INIT;
                        TempEntrySummary."Entry No." := ItemLedgEntry."Entry No.";
                        TempEntrySummary."Table ID" := DATABASE::"Material Issues Line";
                        TempEntrySummary."Lot No." := ItemLedgEntry."Lot No.";
                        TempEntrySummary."Serial No." := ItemLedgEntry."Serial No.";
                        TempEntrySummary."Item No." := ItemLedgEntry."Item No.";
                        TempEntrySummary."Location Code" := ItemLedgEntry."Location Code";
                        TempEntrySummary."Total Quantity" := ItemLedgEntry."Remaining Quantity";
                        TempEntrySummary.USERID := UsrId;    // Pranavi
                        TempEntrySummary.INSERT;
                        IF ItemLedgEntry.Positive THEN BEGIN
                            TempEntrySummary."Warranty Date" := ItemLedgEntry."Warranty Date";
                            TempEntrySummary."Expiration Date" := ItemLedgEntry."Expiration Date";
                            TempEntrySummary."Posting Date" := ItemLedgEntry."Posting Date";
                            TempEntrySummary.CALCFIELDS("Total Reserved Quantity");
                            TempEntrySummary."Total Available Quantity" :=
                              TempEntrySummary."Total Quantity" - TempEntrySummary."Total Reserved Quantity";
                        END;
                        TempEntrySummary.MODIFY;
                    END ELSE BEGIN
                        IF (ItemLedgEntry.Quantity - QLE."Remaining Quantity") > 0 THEN BEGIN
                            TempEntrySummary.INIT;
                            TempEntrySummary."Entry No." := ItemLedgEntry."Entry No.";
                            TempEntrySummary."Table ID" := DATABASE::"Material Issues Line";
                            TempEntrySummary."Lot No." := ItemLedgEntry."Lot No.";
                            TempEntrySummary."Serial No." := ItemLedgEntry."Serial No.";
                            TempEntrySummary."Item No." := ItemLedgEntry."Item No.";
                            TempEntrySummary."Location Code" := ItemLedgEntry."Location Code";
                            TempEntrySummary."Total Quantity" := (ItemLedgEntry."Remaining Quantity" - QLE."Remaining Quantity");
                            TempEntrySummary.USERID := UsrId;      // Pranavi
                            IF NOT (TempEntrySummary."Total Quantity" = 0) THEN BEGIN
                                TempEntrySummary.INSERT;
                                IF ItemLedgEntry.Positive THEN BEGIN
                                    TempEntrySummary."Warranty Date" := ItemLedgEntry."Warranty Date";
                                    TempEntrySummary."Expiration Date" := ItemLedgEntry."Expiration Date";
                                    TempEntrySummary."Posting Date" := ItemLedgEntry."Posting Date";
                                    TempEntrySummary.CALCFIELDS("Total Reserved Quantity");
                                    TempEntrySummary."Total Available Quantity" :=
                                    TempEntrySummary."Total Quantity" - TempEntrySummary."Total Reserved Quantity";
                                END;
                                TempEntrySummary.MODIFY;
                            END;
                        END;
                    END;
                END;
            UNTIL ItemLedgEntry.NEXT = 0;
        COMMIT;
        TempEntrySummary.RESET;
        ItemTrackingSummaryForm.LOOKUPMODE(TRUE);
        TempEntrySummary.SETRANGE("Serial No.", TrackingSpecification."Serial No.");
        TempEntrySummary.SETRANGE("Lot No.", TrackingSpecification."Lot No.");
        IF TempEntrySummary.FINDFIRST THEN
            ItemTrackingSummaryForm.SETRECORD(TempEntrySummary);
        TempEntrySummary.RESET;

        TempEntrySummary.SETCURRENTKEY("Item No.", "Location Code", "Posting Date");
        ItemTrackingSummaryForm.SETTABLEVIEW(TempEntrySummary);
        IF ItemTrackingSummaryForm.RUNMODAL = ACTION::LookupOK THEN BEGIN
            ItemTrackingSummaryForm.GETRECORD(TempEntrySummary);
            // Added by Pranavi on 26-Nov-2016 for Restrincting Return Material to only select req. person material only
            IF NOT (TrackingSpecification."Location Code" IN ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR', 'MCH', 'PROD', 'STR INT']) THEN BEGIN
                MIH.RESET;
                MIH.SETRANGE(MIH."No.", TrackingSpecification."Order No.");
                IF MIH.FINDFIRST THEN BEGIN
                    IF MIH."User ID" <> TempEntrySummary.USERID THEN
                        ERROR('You cannot select this lot/serial no. as it is not issued to the req. user:' + MIH."Resource Name");
                END;
            END;
            // End--Pranavi
            TrackingSpecification."Serial No." := TempEntrySummary."Serial No.";
            TrackingSpecification."Lot No." := TempEntrySummary."Lot No.";
            TrackingSpecification."Expiration Date" := TempEntrySummary."Expiration Date";
            TrackingSpecification."Actual Quantity" := ActualQty;
            TrackingSpecification."Actual Qty to Receive" := ActualQtytoRecevie;
            IF Item.GET(TrackingSpecification."Item No.") THEN
                TrackingSpecification."Product Group Code" := Item."Product Group Code Cust";
            IF "Material Issues Header".GET("IssueNo.") THEN BEGIN
                TrackingSpecification."Prod. Order No." := "Material Issues Header"."Prod. Order No.";
                TrackingSpecification."Prod. Order Line No." := "Material Issues Header"."Prod. Order Line No.";       // Added By Santhosh Kumar

            END;
            IF MaxQuantity < TempEntrySummary."Total Available Quantity" THEN BEGIN
                TrackingSpecification.Quantity := MaxQuantity;
            END ELSE BEGIN
                TrackingSpecification.Quantity := TempEntrySummary."Total Available Quantity";
            END;
            TrackingSpecification."Appl.-to Item Entry" := TempEntrySummary."Entry No.";
        END;
        //EFFMatIssue>>
        TempEntrySummary.RESET;
        IF TempEntrySummary.FindSet() THEN
            TempEntrySummary.DELETEALL
        //EFFMatIssue<<

    end;
}

