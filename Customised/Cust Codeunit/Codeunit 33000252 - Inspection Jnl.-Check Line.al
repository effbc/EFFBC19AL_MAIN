codeunit 33000252 "Inspection Jnl.-Check Line"
{
    // version QC1.1,WIP1.1,QCB2B1.2,DIM1.0

    // Project : EFFTRONICS
    // *************************************************************************************************************************
    // SIGN Name
    // ************************************************************************************************************************
    // DIM : Resolution of Dimension Issues after Upgarding.
    // ***********************************************************************************************************************
    // Version  sign     Date       USERID    Description
    // *************************************************************************************************************************
    // 1.0      DIM      28-May-13  SAIRAM    New Code has been added for the dimensions updation after upgarding.


    trigger OnRun();
    begin
    end;

    var
        Text000: Label 'Total Quantity should be equal to Quantity Received';
        Text001: Label 'All Inspection Data sheets for posted receipt No. %1 and Line No. %2 are not posted.';
        Text002: Label 'There is nothing to post';
        Text003: Label '%1  is not equal to the quantities in the inspection acceptance levels';
        Item: Record Item;
        QLE: Record "Quality Item Ledger Entry";
        accqty: Integer;
        rejqty: Integer;
        "Service Header": Record "Service Header";
        "Service Line": Record "Service Item Line";
        "Service Item": Record "Service Item";
        ILE: Record "Item Ledger Entry";
        LOCATION: Code[20];
        NoSeriesMgt: Codeunit 396;


    procedure RunCheck(var InspectReceipt: Record "Inspection Receipt Header");
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        IF InspectReceipt."No." = '' THEN
            ERROR(Text002);
        InspectReceipt.TESTFIELD(Status, FALSE);
        InspectReceipt.TESTFIELD("Posting Date");
        IF InspectReceipt."Rework Level" = 0 THEN BEGIN
            QLE.RESET;
            QLE.SETRANGE(QLE."Item No.", InspectReceipt."Item No.");
            QLE.SETRANGE(QLE."Document No.", InspectReceipt."Receipt No.");
            QLE.SETRANGE(QLE."Purch.Rcpt Line", InspectReceipt."Purch Line No");
            QLE.SETRANGE(QLE."Child Ids", InspectReceipt."Ids Reference No.");
            QLE.SETRANGE(QLE."Lot No.", InspectReceipt."Lot No.");
            QLE.SETFILTER(QLE."Serial No.", '<>%1', '');
            IF QLE.FINDFIRST THEN BEGIN
                IF QLE.FINDFIRST THEN BEGIN
                    QLE.SETRANGE(QLE.Accept, TRUE);
                    //  MESSAGE(FORMAT(QLE.COUNT)+'-'+FORMAT(InspectReceipt."Qty. Accepted"));

                    IF (QLE.COUNT <> InspectReceipt."Qty. Accepted") THEN BEGIN
                        ERROR('Qty Mismatch with selected lines');
                    END;
                END;
                QLE.RESET;
                QLE.SETRANGE(QLE."Item No.", InspectReceipt."Item No.");
                QLE.SETRANGE(QLE."Document No.", InspectReceipt."Receipt No.");
                QLE.SETRANGE(QLE."Purch.Rcpt Line", InspectReceipt."Purch Line No");
                QLE.SETRANGE(QLE."Child Ids", InspectReceipt."Ids Reference No.");
                IF QLE.FINDFIRST THEN BEGIN
                    QLE.SETRANGE(QLE.Reject, TRUE);
                    // MESSAGE(FORMAT(rejqty));
                    IF (QLE.COUNT <> InspectReceipt."Qty. Rejected") THEN BEGIN
                        ERROR('Qty Mismatch with selected lines');
                    END;

                END;
            END
            ELSE BEGIN
                QLE.RESET;
                QLE.SETRANGE(QLE."Item No.", InspectReceipt."Item No.");
                QLE.SETRANGE(QLE."Document No.", InspectReceipt."Receipt No.");
                QLE.SETRANGE(QLE."Purch.Rcpt Line", InspectReceipt."Purch Line No");
                QLE.SETRANGE(QLE."Lot No.", InspectReceipt."Lot No.");
                //QLE.SETRANGE(
                QLE.SETRANGE(QLE."Child Ids", '');
                QLE.SETFILTER(QLE."Serial No.", '<>%1', '');
                IF QLE.FINDFIRST THEN BEGIN
                    QLE.SETRANGE(QLE.Accept, TRUE);

                    // MESSAGE(FORMAT(QLE.COUNT));
                    //MESSAGE(FORMAT(InspectReceipt."Qty. Accepted"));
                    IF (QLE.COUNT <> InspectReceipt."Qty. Accepted") THEN BEGIN
                        ERROR('Qty Mismatch with selected lines');
                    END;
                    QLE.RESET;
                    QLE.SETRANGE(QLE."Item No.", InspectReceipt."Item No.");
                    QLE.SETRANGE(QLE."Document No.", InspectReceipt."Receipt No.");
                    QLE.SETRANGE(QLE."Purch.Rcpt Line", InspectReceipt."Purch Line No");
                    QLE.SETRANGE(QLE."Child Ids", '');
                    QLE.SETRANGE(QLE.Reject, TRUE);
                    IF (QLE.COUNT <> InspectReceipt."Qty. Rejected") THEN BEGIN
                        ERROR('Qty Mismatch with selected lines');
                    END;

                END
            END;
        END;

        //B2B commented
        //IF (Item.GET(InspectReceipt."Item No.")) AND (Item."Item Tracking Code" <> '') THEN
        //B2B
        IF InspectReceipt."Source Type" = InspectReceipt."Source Type"::"In Bound" THEN BEGIN
            IF InspectDataSheet."Quality Before Receipt" THEN
                InspectDataSheet.SETRANGE("Order No.", InspectReceipt."Order No.")
            ELSE
                InspectDataSheet.SETRANGE("Receipt No.", InspectReceipt."Receipt No.");
            InspectDataSheet.SETRANGE("Purch Line No", InspectReceipt."Purch Line No");
            InspectDataSheet.SETRANGE("Purchase Consignment No.", InspectReceipt."Purchase Consignment");
            InspectDataSheet.SETRANGE("Lot No.", InspectReceipt."Lot No.");
        END ELSE BEGIN
            InspectDataSheet.SETRANGE("Prod. Order No.", InspectReceipt."Prod. Order No.");
            InspectDataSheet.SETRANGE("Prod. Order Line", InspectReceipt."Prod. Order Line");
            InspectDataSheet.SETRANGE("Production Batch No.", InspectReceipt."Production Batch No.");
        END;
        IF InspectDataSheet.FINDFIRST THEN BEGIN
            IF (InspectDataSheet."Parent IDS No" <> '') AND (NOT InspectDataSheet."Partial Inspection") THEN //30/07/08 PIDSQC1.0
                ERROR(Text001, InspectReceipt."Receipt No.", InspectReceipt."Purch Line No")
            ELSE
                ;
        END;
        CheckQualityAcceptanceLevels(InspectReceipt);
        IF InspectReceipt.Quantity <> InspectReceipt."Qty. Accepted" + InspectReceipt."Qty. Rejected" +
          InspectReceipt."Qty. Rework" + InspectReceipt."Qty. Accepted Under Deviation" THEN
            ERROR(Text000);
        IF InspectReceipt."Qty. Accepted Under Deviation" <> 0 THEN
            InspectReceipt.TESTFIELD(InspectReceipt."Qty. Accepted UD Reason");
    end;


    procedure CheckQualityAcceptanceLevels(InspectRcpt: Record "Inspection Receipt Header");
    var
        InspectAcptLevel: Record "Inspect. Recpt. Accept Level";
    begin
        InspectAcptLevel.SETRANGE(InspectAcptLevel."Inspection Receipt No.", InspectRcpt."No.");
        InspectAcptLevel.SETCURRENTKEY("Quality Type", Quantity);

        InspectAcptLevel.SETRANGE("Quality Type", InspectAcptLevel."Quality Type"::Accepted);
        InspectAcptLevel.CALCSUMS(Quantity);
        IF InspectRcpt."Qty. Accepted" <> InspectAcptLevel.Quantity THEN
            ERROR(Text003, InspectRcpt.FIELDCAPTION("Qty. Accepted"));

        InspectAcptLevel.SETRANGE("Quality Type", InspectAcptLevel."Quality Type"::"Accepted Under Deviation");
        InspectAcptLevel.CALCSUMS(Quantity);
        IF InspectRcpt."Qty. Accepted Under Deviation" <> InspectAcptLevel.Quantity THEN
            ERROR(Text003, InspectRcpt.FIELDCAPTION("Qty. Accepted Under Deviation"));

        InspectAcptLevel.SETRANGE("Quality Type", InspectAcptLevel."Quality Type"::Rework);
        InspectAcptLevel.CALCSUMS(Quantity);
        IF InspectRcpt."Qty. Rework" <> InspectAcptLevel.Quantity THEN
            ERROR(Text003, InspectRcpt.FIELDCAPTION("Qty. Rework"));

        InspectAcptLevel.SETRANGE("Quality Type", InspectAcptLevel."Quality Type"::Rejected);
        InspectAcptLevel.CALCSUMS(Quantity);
        IF InspectRcpt."Qty. Rejected" <> InspectAcptLevel.Quantity THEN
            ERROR(Text003, InspectRcpt.FIELDCAPTION("Qty. Rejected"));
    end;


    procedure "--B2B-ESPL--"();
    begin
    end;


    procedure TransferOrderRunCheck(var InspectReceipt: Record "Inspection Receipt Header");
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        IF InspectReceipt."No." = '' THEN
            ERROR(Text002);

        InspectReceipt.TESTFIELD(Status, FALSE);

        InspectReceipt.TESTFIELD("Posting Date");
        IF InspectReceipt."Source Type" = InspectReceipt."Source Type"::Transfer THEN BEGIN
            InspectDataSheet.SETRANGE("Trans. Order No.", InspectReceipt."Trans. Order No.");
            InspectDataSheet.SETRANGE("Trans. Order Line", InspectReceipt."Trans. Order Line");
        END;
        IF InspectDataSheet.FINDFIRST THEN
            ERROR(Text001, InspectReceipt."Receipt No.", InspectReceipt."Purch Line No");

        CheckQualityAcceptanceLevels(InspectReceipt);

        IF InspectReceipt.Quantity <> InspectReceipt."Qty. Accepted" + InspectReceipt."Qty. Rejected" +
          InspectReceipt."Qty. Rework" + InspectReceipt."Qty. Accepted Under Deviation" THEN
            ERROR(Text000);

        IF InspectReceipt."Qty. Accepted Under Deviation" <> 0 THEN
            InspectReceipt.TESTFIELD(InspectReceipt."Qty. Accepted UD Reason");
    end;


    procedure Item_Positive_Adjustment("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]);
    var
        "Item Journal Line": Record "Item Journal Line";
        "Reservation Entry": Record "Reservation Entry";
        "Reservation Entry1": Record "Reservation Entry";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        "Item Ledger Entry": Record "Item Ledger Entry";
    begin
        //Dleted Local Var(*Journal Line DimensionRecordTable356)
        "Item Ledger Entry".RESET;
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF NOT "Item Ledger Entry".FINDFIRST THEN BEGIN
            // INSERTING RECORD IN ITEM JOURNAL LINE
            "Item Journal Line".INIT;
            "Item Journal Line"."Journal Template Name" := 'ITEM';
            "Item Journal Line"."Journal Batch Name" := 'POS-CS-SIG';
            "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";
            "Item Journal Line"."Line No." := 10000;
            "Item Journal Line"."Source Code" := 'ITEMJNL';
            "Item Journal Line"."Serial No." := "Serial No.";
            "Item Journal Line"."Lot No." := ICNNO(TODAY) + 'SA01';
            "Item Journal Line"."Document No." := NoSeriesMgt.GetNextNo('POS-ADJ-CS', TODAY, FALSE);
            "Item Journal Line".Quantity := 1;
            "Item Journal Line"."Quantity (Base)" := 1;
            "Item Journal Line"."Item No." := "Item No.";
            "Item Journal Line".VALIDATE("Item Journal Line"."Item No.", "Item No.");
            "Item Journal Line"."Location Code" := 'CS';
            "Item Journal Line"."Shortcut Dimension 2 Code" := "Location Code";
            "Item Journal Line"."User ID" := USERID;
            "Item Journal Line"."Document Date" := TODAY;
            "Item Journal Line".INSERT;


            // INSERTING RECORD IN RESERVATION ENTRY
            "Reservation Entry".INIT;
            IF "Reservation Entry1".FINDLAST THEN
                "Reservation Entry"."Entry No." := "Reservation Entry1"."Entry No." + 1;
            "Reservation Entry"."Item No." := "Item No.";
            "Reservation Entry"."Location Code" := 'CS';
            "Reservation Entry"."Quantity (Base)" := 1;
            "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
            "Reservation Entry"."Creation Date" := TODAY;
            "Reservation Entry"."Source Type" := 83;
            "Reservation Entry"."Source Subtype" := 2;
            "Reservation Entry"."Source ID" := 'ITEM';
            "Reservation Entry"."Source Batch Name" := 'POS-CS-SIG';
            "Reservation Entry"."Source Ref. No." := 10000;
            "Reservation Entry"."Created By" := 'SUPER';
            "Reservation Entry".Positive := TRUE;
            "Reservation Entry"."Expected Receipt Date" := TODAY;
            "Reservation Entry"."Serial No." := "Serial No.";
            "Reservation Entry"."Lot No." := ICNNO(TODAY) + 'SA01';
            "Reservation Entry".Quantity := 1;
            "Reservation Entry".INSERT;


            //DIm1.0 Start
            //Code Commented
            /*
              // INSERTING JOURNAL LINE DIMENSION
              "Journal Line Dimension".INIT;
              "Journal Line Dimension"."Table ID":=83;
              "Journal Line Dimension"."Journal Template Name":='ITEM';
              "Journal Line Dimension"."Journal Batch Name":='POS-CS-SIG';
              "Journal Line Dimension"."Journal Line No.":=10000;
              "Journal Line Dimension"."Dimension Code":='LOCATIONS';
              "Journal Line Dimension"."Dimension Value Code":="Location Code";
              "Journal Line Dimension".INSERT;
            */
            //DIm1.0 End

        END ELSE
            ERROR(' ITEM WAS ALLREADY AVAILABLE IN INVENTORY');


        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", "Item Journal Line");

    end;


    procedure ICNNO(DT: Date) ICN: Code[10];
    var
        Dat: Text[30];
        Mon: Text[30];
        Yer: Text[30];
    begin
        IF DATE2DMY(DT, 1) < 10 THEN
            Dat := '0' + FORMAT(DATE2DMY(DT, 1))
        ELSE
            Dat := FORMAT(DATE2DMY(DT, 1));

        IF DATE2DMY(DT, 2) < 10 THEN
            Mon := '0' + FORMAT(DATE2DMY(DT, 2))
        ELSE
            Mon := FORMAT(DATE2DMY(DT, 2));

        //IF DATE2DMY(DT,2) < 10 THEN
        Yer := COPYSTR(FORMAT(DATE2DMY(DT, 3)), 3, 2);
        ICN := Dat + Mon + Yer;
        EXIT(ICN);
    end;
}

