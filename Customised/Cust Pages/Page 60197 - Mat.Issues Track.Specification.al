page 60197 "Mat.Issues Track.Specification"
{
    // version MI1.0,Rev01

    Editable = true;
    PageType = ListPart;
    SourceTable = "Mat.Issue Track. Specification";

    layout
    {
        area(content)
        {
            group(Control1102152004)
            {
                ShowCaption = false;
                fixed(Quantity)
                {
                    group("Actual Qty.")
                    {
                        Caption = 'Actual Qty.';
                        field("FORMAT(SourceQuantityArray[1])"; FORMAT(SourceQuantityArray[1]))
                        {
                            //DecimalPlaces = 0 : 2;
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group("AssignedQty.")
                    {
                        Caption = 'AssignedQty.';
                        field("FORMAT(""AssignedQty."")"; FORMAT("AssignedQty."))
                        {
                            Caption = 'AssignedQty.';
                            //DecimalPlaces = 0 : 5;
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                    group("Undefined Quantity")
                    {
                        Caption = 'Undefined Quantity';
                        field(Quantity3; FORMAT("UndefinedQty."))
                        {
                            //BlankZero = true;
                            Caption = 'Undefined Quantity';
                            //DecimalPlaces = 0 : 5;
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
                fixed(Tracking)
                {
                    group("Item Tracking Code")
                    {
                        field("ItemTrackingCode.Code"; ItemTrackingCode.Code)
                        {
                            Caption = 'Item Tracking Code';
                            Editable = false;
                            Lookup = true;
                            ApplicationArea = All;

                            trigger OnLookup(Var Text: Text): Boolean;
                            begin
                                PAGE.RUNMODAL(0, ItemTrackingCode);
                            end;
                        }
                    }
                    group("Item Tracking Description")
                    {
                        field("ItemTrackingCode.Description"; ItemTrackingCode.Description)
                        {
                            Caption = 'Description';
                            Editable = false;
                            ApplicationArea = All;
                        }
                    }
                }
                field("COUNT"; Rec.COUNT)
                {
                    ApplicationArea = All;
                }
            }
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        MIEntrySummary.RESET;
                        IF MIEntrySummary.FINDFIRST THEN
                            ERROR('form has been locked by other user');

                        AssistedditLotSerialNo(Rec, 0, "UndefinedQty.", Rec."Order No.");
                        CurrPage.UPDATE;
                    end;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    var
                        MaxQuantity: Decimal;
                    begin
                        MIEntrySummary.RESET;
                        IF MIEntrySummary.FINDFIRST THEN
                            ERROR('form has been locked by other user');

                        IF "UndefinedQty." = 0 THEN
                            MaterialIssueLineReserve.AssistEditLotSerialNo(Rec, 1, Rec.Quantity, Rec."Order No.")
                        ELSE
                            MaterialIssueLineReserve.AssistEditLotSerialNo(Rec, 1, "UndefinedQty.", Rec."Order No.");
                        CurrPage.UPDATE;
                    end;
                }
                field(QuantityN; Rec.Quantity)
                {
                    Caption = 'Quantity';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF NOT CheckLine(Rec) THEN
                            EXIT;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    var
        MaterialIssueLine: Record "Material Issues Line";
        TempTrackSpecifications: Record "Mat.Issue Track. Specification";
        "RemQty.": Decimal;
    begin
        MaterialIssueLine.SETRANGE("Document No.", Rec."Order No.");
        MaterialIssueLine.SETRANGE("Line No.", Rec."Order Line No.");
        IF MaterialIssueLine.FINDFIRST THEN
            SourceQuantityArray[1] := MaterialIssueLine."Qty. to Receive"
        ELSE BEGIN
            DCL.SETRANGE("Document No.", Rec."Order No.");
            DCL.SETRANGE("Line No.", Rec."Order Line No.");
            IF DCL.FINDFIRST THEN
                SourceQuantityArray[1] := DCL.Quantity;
        END;

        UpdateUndefinedQty;
        if Rec."Item No." <> '' then //EFFUPG1.12
            GetItem(Rec."Item No.");
        UndefinedQtyOnFormat;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        CLEAR("AssignedQty.");
        "UndefinedQty." := SourceQuantityArray[1];
    end;

    trigger OnOpenPage();
    begin
        // Rev01 >>
        MaterialIssueLine.SETRANGE("Document No.", Rec.GETFILTER("Order No."));
        MaterialIssueLine.SETFILTER("Line No.", Rec.GETFILTER("Order Line No."));
        IF MaterialIssueLine.FINDFIRST THEN
            SourceQuantityArray[1] := MaterialIssueLine."Qty. to Receive"
        ELSE BEGIN
            DCL.SETRANGE("Document No.", Rec.GETFILTER("Order No."));
            DCL.SETFILTER("Line No.", Rec.GETFILTER("Order Line No."));
            IF DCL.FINDFIRST THEN
                SourceQuantityArray[1] := DCL.Quantity;
        END;

        UpdateUndefinedQty;
        GetItem(FORMAT(Rec.GETFILTER("Item No.")));
        UndefinedQtyOnFormat;


        // Rev01 <<
    end;

    var
        TotalItemTrackingLine: Record "Mat.Issue Track. Specification";
        ItemTrackingCode: Record "Item Tracking Code";
        Item: Record Item;
        MaterialIssueLineReserve: Codeunit "Material Issue Line-Reserve";
        TrackingSpecification: Record "Mat.Issue Track. Specification";
        TempTrackingSpec: Record "Mat.Issue Track. Specification";
        CurrentSteps: Integer;
        Text002: Label 'Quantity must be %1.';
        Text003: Label 'negative';
        Text004: Label 'positive';
        "AssignedQty.": Decimal;
        "UndefinedQty.": Decimal;
        SourceQuantityArray: array[9] of Decimal;
        ColorOfQuantityArray: Integer;
        AssignmentCompleted: Boolean;
        MaterialIssueLine: Record "Material Issues Line";
        MIEntrySummary: Record "Mat.Issue Entry Summary";
        QLE: Record "Quality Item Ledger Entry";
        ActualQty: Decimal;
        ActualQtytoRecevie: Decimal;
        "Material Issues Header": Record "Material Issues Header";
        DCL: Record "DC Line";
        [InDataSet]
        Quantity3Emphasize: Boolean;
        Text19075883: Label 'Assigned Qty.';
        Text19014083: Label 'Actual Qty.';
        Text19007887: Label 'Undefined';


    local procedure UpdateUndefinedQty() QtyIsValid: Boolean;
    var
        TrackingSpecification: Record "Mat.Issue Track. Specification";
    begin
        TrackingSpecification.SETRANGE("Order No.", Rec.GETFILTER("Order No."));
        TrackingSpecification.SETFILTER("Order Line No.", Rec.GETFILTER("Order Line No."));
        IF TrackingSpecification.FINDSET THEN BEGIN
            "AssignedQty." := 0;
            "UndefinedQty." := 0;
            REPEAT
                "AssignedQty." := "AssignedQty." + TrackingSpecification.Quantity;
            UNTIL TrackingSpecification.NEXT = 0;
        END;

        "UndefinedQty." := SourceQuantityArray[1] - "AssignedQty.";

        IF "UndefinedQty." < 0 THEN
            ColorOfQuantityArray := 255
        ELSE
            ColorOfQuantityArray := 0;
        /*
        TrackingSpecification.SETRANGE("Order No.","Order No.");
        TrackingSpecification.SETRANGE("Order Line No.","Order Line No.");
        IF TrackingSpecification.FINDSET THEN BEGIN
          "AssignedQty." := 0;
          "UndefinedQty." := 0;
          REPEAT
            "AssignedQty." := "AssignedQty." + TrackingSpecification.Quantity;
          UNTIL TrackingSpecification.NEXT = 0;
        END;
        
        "UndefinedQty." := SourceQuantityArray[1] - "AssignedQty.";
        
        IF "UndefinedQty." < 0 THEN
          ColorOfQuantityArray := 255
        ELSE
          ColorOfQuantityArray := 0;
        */

    end;


    local procedure GetItem(ItemNo: Code[20]);
    begin
        //MESSAGE('%1,%2',Item."No.",ItemNo);// ERROR
        IF Item."No." <> ItemNo THEN BEGIN
            //Item.GET(ItemNo);
            Item.RESET;
            Item.SETFILTER(Item."No.", ItemNo);
            IF Item.FINDFIRST THEN BEGIN

                Item.TESTFIELD("Item Tracking Code");
                IF ItemTrackingCode.Code <> Item."Item Tracking Code" THEN
                    ItemTrackingCode.GET(Item."Item Tracking Code");
            END;
            //MESSAGE(FORMAT(ItemTrackingCode.Code));// ERROR
        END;
    end;


    local procedure CheckLine(TrackingLine: Record "Mat.Issue Track. Specification"): Boolean;
    begin
        IF TrackingLine.Quantity * SourceQuantityArray[1] < 0 THEN
            IF SourceQuantityArray[1] < 0 THEN
                ERROR(Text002, Text003)
            ELSE
                ERROR(Text002, Text004);
    end;


    procedure AssistedditLotSerialNo(var TrackingSpecification: Record "Mat.Issue Track. Specification"; LookupMode: Option "Serial No.","Lot No."; MaxQuantity: Decimal; "IssueNo.": Code[20]): Boolean;
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        TempEntrySummary: Record "Mat.Issue Entry Summary";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        LastEntryNo: Integer;
        Window: Dialog;
        InsertRec: Boolean;
        TempTrackingSpecification: Record "Mat.Issue Track. Specification";
        MaterialIssueLine: Record "Material Issues Line";
        ItemTrackingSummaryForm: Page "MaterialIssues Entry Summary";
        PMI: Record "Posted Material Issues Header";
        UsrId: Code[30];
        MIH: Record "Material Issues Header";
        AssignBatch: Codeunit "Assign Batch No's";
        IsExp: Boolean;
    begin
        IF TempEntrySummary.FINDFIRST THEN
            TempEntrySummary.DELETEALL;
        ItemLedgEntry.RESET;
        ItemLedgEntry.SETCURRENTKEY("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date");
        ItemLedgEntry.SETRANGE("Item No.", TrackingSpecification."Item No.");
        ItemLedgEntry.SETRANGE("Variant Code", TrackingSpecification."Variant Code");
        ItemLedgEntry.SETRANGE("Location Code", TrackingSpecification."Location Code");
        ItemLedgEntry.SETRANGE(Open, TRUE);

        IF (TrackingSpecification."Location Code" = 'SITE') OR (TrackingSpecification."Location Code" = 'OLD STOCK') THEN BEGIN
            "Material Issues Header".SETRANGE("Material Issues Header"."No.", TrackingSpecification."Order No.");
            IF "Material Issues Header".FINDFIRST THEN BEGIN
                ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", "Material Issues Header"."Shortcut Dimension 2 Code");
            END;
        END ELSE
            IF TrackingSpecification."Location Code" = 'CS' THEN BEGIN
                ItemLedgEntry.SETRANGE(ItemLedgEntry."Global Dimension 2 Code", 'H-OFF');

            END;

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
                IF (ItemLedgEntry."Location Code" IN ['CS STR', 'R&D STR', 'PRODSTR', 'STR', 'MCH']) THEN BEGIN
                    IF AssignBatch.MSLItemExpiryDate(ItemLedgEntry) THEN
                        IsExp := TRUE;
                END;
                //<<Added by Pranavi on 20-05-2017 for MSL Process
                IF IsExp = FALSE THEN BEGIN
                    CASE LookupMode OF
                        LookupMode::"Serial No.":
                            TempEntrySummary.SETRANGE("Serial No.", ItemLedgEntry."Serial No.");
                        LookupMode::"Lot No.":
                            TempEntrySummary.SETRANGE("Lot No.", ItemLedgEntry."Lot No.");
                    END;
                    /*  TempEntrySummary.INIT;
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
                        TempEntrySummary.USERID := UsrId;   // Pranavi
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
                            TempEntrySummary.USERID := UsrId;    // Pranavi
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
            IF NOT (TrackingSpecification."Location Code" IN ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR', 'MCH', 'PROD']) THEN BEGIN
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

    end;


    local procedure UndefinedQtyOnFormat();
    begin
        Quantity3Emphasize := ColorOfQuantityArray > 0;
    end;
}

