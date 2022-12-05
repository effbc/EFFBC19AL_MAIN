report 50193 "Refresh Production Order New"
{
    Caption = 'Refresh Production Order';
    ProcessingOnly = true;
    TransactionType = Update;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            RequestFilterFields = Status, "No.";

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                ProdOrderLine: Record "Prod. Order Line";
                ProdOrderRtngLine: Record "Prod. Order Routing Line";
                ProdOrderComp: Record "Prod. Order Component";
                Family: Record Family;
                ProdOrder: Record "Production Order";
                ProdOrderStatusMgt: Codeunit "Prod. Order Status Management";
                RoutingNo: Code[20];
                ErrorOccured: Boolean;
            begin
                IF USERID <> 'EFFTRONICS\VIJAYA' THEN BEGIN
                    //added by pranavi on 15-04-2015
                    PostedMatIssHdr.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                    PostedMatIssHdr.SETFILTER(PostedMatIssHdr."Prod. Order No.", "No.");
                    IF PostedMatIssHdr.FINDFIRST THEN BEGIN
                        //CurrReport.SKIP;
                        ERROR('Material Requests already created for the Prod. Order: ' + "No.");
                    END
                    ELSE BEGIN
                        MatIssHdr.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.");
                        MatIssHdr.SETFILTER(MatIssHdr."Prod. Order No.", "No.");
                        IF MatIssHdr.FINDFIRST THEN BEGIN
                            ERROR('Material Requests already created for the Prod. Order!' + "No.");
                            //  CurrReport.SKIP;
                        END;
                    END;
                    //end by pranavi
                END;
                IF Status = Status::Finished THEN
                    CurrReport.SKIP;
                IF Direction = Direction::Backward THEN
                    TESTFIELD("Due Date");

                IF CalcLines AND IsComponentPicked("Production Order") THEN
                    IF NOT CONFIRM(STRSUBSTNO(DeletePickedLinesQst, "No.")) THEN
                        CurrReport.SKIP;

                Window.UPDATE(1, Status);
                Window.UPDATE(2, "No.");

                RoutingNo := "Routing No.";
                CASE "Source Type" OF
                    "Source Type"::Item:
                        IF Item.GET("Source No.") THEN
                            RoutingNo := Item."Routing No.";
                    "Source Type"::Family:
                        IF Family.GET("Source No.") THEN
                            RoutingNo := Family."Routing No.";
                END;
                IF RoutingNo <> "Routing No." THEN BEGIN
                    "Routing No." := RoutingNo;
                    MODIFY;
                END;

                ProdOrderLine.LOCKTABLE;

                CheckReservationExist;

                //AlternatePCBReplace := FALSE;
                //added by vijaya 21-08-2018 for Alternate PCB Replacement

                IF CalcLines THEN BEGIN
                    IF NOT CreateProdOrderLines.Copy("Production Order", Direction, '', AlternatePCBReplace) THEN
                        ErrorOccured := TRUE;
                END ELSE BEGIN
                    ProdOrderLine.SETRANGE(Status, Status);
                    ProdOrderLine.SETRANGE("Prod. Order No.", "No.");
                    IF CalcRoutings OR CalcComponents THEN BEGIN
                        IF ProdOrderLine.FIND('-') THEN
                            REPEAT
                                IF CalcRoutings THEN BEGIN
                                    ProdOrderRtngLine.SETRANGE(Status, Status);
                                    ProdOrderRtngLine.SETRANGE("Prod. Order No.", "No.");
                                    ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                                    ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
                                    IF ProdOrderRtngLine.FINDSET(TRUE) THEN
                                        REPEAT
                                            ProdOrderRtngLine.SetSkipUpdateOfCompBinCodes(TRUE);
                                            ProdOrderRtngLine.DELETE(TRUE);
                                        UNTIL ProdOrderRtngLine.NEXT = 0;
                                END;
                                IF CalcComponents THEN BEGIN
                                    ProdOrderComp.SETRANGE(Status, Status);
                                    ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
                                    ProdOrderComp.SETRANGE("Prod. Order Line No.", ProdOrderLine."Line No.");
                                    ProdOrderComp.DELETEALL(TRUE);
                                END;
                            UNTIL ProdOrderLine.NEXT = 0;
                        IF ProdOrderLine.FIND('-') THEN
                            REPEAT
                                IF CalcComponents THEN
                                    CheckProductionBOMStatus(ProdOrderLine."Production BOM No.", ProdOrderLine."Production BOM Version Code");
                                IF CalcRoutings THEN
                                    CheckRoutingStatus(ProdOrderLine."Routing No.", ProdOrderLine."Routing Version Code");
                                ProdOrderLine."Due Date" := "Due Date";
                                IF NOT CalcProdOrder.Calculate(ProdOrderLine, Direction, CalcRoutings, CalcComponents, FALSE, FALSE) THEN
                                    ErrorOccured := TRUE;
                            UNTIL ProdOrderLine.NEXT = 0;
                    END;
                END;
                IF (Direction = Direction::Backward) AND
                   ("Source Type" = "Source Type"::Family)
                THEN BEGIN
                    SetUpdateEndDate;
                    VALIDATE("Due Date", "Due Date");
                END;

                IF Status = Status::Released THEN BEGIN
                    ProdOrderStatusMgt.FlushProdOrder("Production Order", Status, WORKDATE);
                    WhseProdRelease.Release("Production Order");
                    IF CreateInbRqst THEN
                        WhseOutputProdRelease.Release("Production Order");
                    IF "Location Code" = 'PROD' THEN
                        PRMintegrate.ProdOrdRefresh("No.");

                END;
                ProdOrderComp.RESET;
                ProdOrderComp.SETRANGE(Status, Status);
                ProdOrderComp.SETRANGE("Prod. Order No.", "No.");
                IF ProdOrderComp.FINDFIRST THEN
                    REPEAT
                        IF Item.GET(ProdOrderComp."Item No.") THEN BEGIN
                            IF Item."Invert Solder type" = TRUE THEN BEGIN
                                IF Item."Type of Solder" = Item."Type of Solder"::DIP THEN
                                    ProdOrderComp."Type of Solder2" := 'SMD'
                                ELSE
                                    IF (Item."Type of Solder" = Item."Type of Solder"::SMD) THEN
                                        ProdOrderComp."Type of Solder2" := 'DIP';
                            END
                            ELSE
                                ProdOrderComp."Type of Solder2" := FORMAT(Item."Type of Solder");
                            ProdOrderComp.MODIFY(TRUE);
                        END;
                        //added by pranavi on 07-04-2015 for updating Prod order comp with dept
                        IF ProdOrderComp."BOM Type" = ProdOrderComp."BOM Type"::Mechanical THEN BEGIN
                            ProdOrderComp.Dept := 'SHF';
                            ProdOrderComp.MODIFY;
                        END
                        ELSE
                            IF ProdOrderComp."BOM Type" = ProdOrderComp."BOM Type"::Wiring THEN BEGIN
                                ProdOrderComp.Dept := 'P1';
                                ProdOrderComp.MODIFY;
                            END
                            ELSE BEGIN
                                ProdBomLine.RESET;
                                ProdBomLine.SETCURRENTKEY("Production BOM No.", "Version Code", "No.");
                                ProdOrderLine.RESET;
                                ProdOrderLine.SETCURRENTKEY(Status, "Prod. Order No.", "Line No.");
                                //ProdOrderLine.SETFILTER(ProdOrderLine.Status,'%1',Status);
                                ProdOrderLine.SETFILTER(ProdOrderLine."Prod. Order No.", "No.");
                                ProdOrderLine.SETFILTER(ProdOrderLine."Line No.", '%1', ProdOrderComp."Prod. Order Line No.");
                                IF ProdOrderLine.FINDFIRST THEN
                                    ProdBomLine.SETFILTER(ProdBomLine."Production BOM No.", ProdOrderLine."Item No.");
                                ProdBomLine.SETFILTER(ProdBomLine."No.", ProdOrderComp."Item No.");
                                IF ProdBomLine.FINDFIRST THEN BEGIN
                                    ProdOrderComp."Operation No." := ProdBomLine."Operation No.";
                                    ProdOrderComp.Dept := ProdBomLine.Dept;
                                    ProdOrderComp.MODIFY;
                                END;
                            END;    //end by pranavi
                                    // Added by Pranavi on 25_Dec_2015 for updating Material Req Date
                        ProdOrder.RESET;
                        ProdOrder.SETRANGE(ProdOrder.Status, ProdOrder.Status::Released);
                        ProdOrder.SETRANGE(ProdOrder."No.", ProdOrderComp."Prod. Order No.");
                        IF ProdOrder.FINDFIRST THEN BEGIN
                            IF ProdOrder."Prod Start date" <> 0D THEN BEGIN
                                ProdOrderComp."Production Plan Date" := ProdOrder."Prod Start date";
                                IF ProdOrderComp."Material Required Day" = 0 THEN
                                    ProdOrderComp."Material Requisition Date" := 0D
                                ELSE
                                    IF ProdOrderComp."Material Required Day" = 1 THEN
                                        ProdOrderComp."Material Requisition Date" := ProdOrderComp."Production Plan Date"
                                    ELSE BEGIN
                                        //"Prod. Order Component"."Material Requisition Date" := CALCDATE(FORMAT("Prod. Order Component"."Material Required Day" - 1) +'D',"Prod. Order Component"."Production Plan Date");
                                        // ProdOrderComp."Material Requisition Date" := CalMngmt.CalcDateBOC('+' + FORMAT(ProdOrderComp."Material Required Day" - 1) + 'D', ProdOrderComp."Production Plan Date", 3, 'PROD', '', 3, 'PROD', '', FALSE);  //pranavi
                                        ProdOrderComp."Material Requisition Date" := CalMngmt.CalcDateBOC('+' + FORMAT(ProdOrderComp."Material Required Day" - 1) + 'D', ProdOrderComp."Production Plan Date", CustCal, FALSE);  //pranavi
                                    END;
                                ProdOrderComp.MODIFY;
                            END;
                        END;
                    // End by Pranavi
                    UNTIL ProdOrderComp.NEXT = 0;

                IF ErrorOccured THEN
                    MESSAGE(Text005, ProdOrder.TABLECAPTION, ProdOrderLine.FIELDCAPTION("Bin Code"));
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(
                  Text000 +
                  Text001 +
                  Text002);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Direction; Direction)
                    {
                        Caption = 'Scheduling direction';
                        OptionCaption = 'Forward,Back';
                        ApplicationArea = All;
                    }
                    group(Calculate)
                    {
                        Caption = 'Calculate';
                        field(CalcLines; CalcLines)
                        {
                            Caption = 'Lines';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF CalcLines THEN BEGIN
                                    CalcRoutings := TRUE;
                                    CalcComponents := TRUE;
                                END;
                            end;
                        }
                        field(CalcRoutings; CalcRoutings)
                        {
                            Caption = 'Routings';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT CalcRoutings THEN
                                    IF CalcLines THEN
                                        ERROR(Text003);
                            end;
                        }
                        field(CalcComponents; CalcComponents)
                        {
                            Caption = 'Component Need';
                            ApplicationArea = All;

                            trigger OnValidate()
                            begin
                                IF NOT CalcComponents THEN
                                    IF CalcLines THEN
                                        ERROR(Text004);
                            end;
                        }
                    }
                    group(Warehouse)
                    {
                        Caption = 'Warehouse';
                        field(CreateInbRqst; CreateInbRqst)
                        {
                            Caption = 'Create Inbound Request';
                            ApplicationArea = All;
                        }
                    }
                    group("Alternate PCB")
                    {
                        Caption = 'Alternate PCB';
                        field(AlternatePCBReplace; AlternatePCBReplace)
                        {
                            Caption = 'AlternatePCBReplace';
                            ApplicationArea = All;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalcLines := TRUE;
            CalcRoutings := TRUE;
            CalcComponents := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Direction := Direction::Forward;
    end;

    var
        CustCal: array[2] of Record "Customized Calendar Change";
        Text000: Label 'Refreshing Production Orders...\\';
        Text001: Label 'Status         #1##########\';
        Text002: Label 'No.            #2##########';
        Text003: Label 'Routings must be calculated, when lines are calculated.';
        Text004: Label 'Component Need must be calculated, when lines are calculated.';
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        CreateProdOrderLines: Codeunit "Create Prod. Order Lines";
        WhseProdRelease: Codeunit "Whse.-Production Release";
        WhseOutputProdRelease: Codeunit "Whse.-Output Prod. Release";
        Window: Dialog;
        Direction: Option Forward,Backward;
        CalcLines: Boolean;
        CalcRoutings: Boolean;
        CalcComponents: Boolean;
        CreateInbRqst: Boolean;
        Text005: Label 'One or more of the lines on this %1 require special warehouse handling. The %2 for these lines has been set to blank.';
        DeletePickedLinesQst: Label 'Components for production order %1 have already been picked. Do you want to continue?', Comment = 'Production order no.: Components for production order 101001 have already been picked. Do you want to continue?';
        PRMintegrate: Codeunit SQLIntegration;
        PostedMatIssHdr: Record "Posted Material Issues Header";
        MatIssHdr: Record "Material Issues Header";
        ProdBomLine: Record "Production BOM Line";
        prodOrdLines: Record "Prod. Order Line";
        ProdOrder: Record "Production Order";
        CalMngmt: Codeunit "Calendar Management";
        AlternatePCBReplace: Boolean;

    local procedure CheckReservationExist()
    var
        ProdOrderLine2: Record "Prod. Order Line";
        ProdOrderComp2: Record "Prod. Order Component";
    begin
        // Not allowed to refresh if reservations exist
        IF NOT (CalcLines OR CalcComponents) THEN
            EXIT;

        ProdOrderLine2.SETRANGE(Status, "Production Order".Status);
        ProdOrderLine2.SETRANGE("Prod. Order No.", "Production Order"."No.");
        IF ProdOrderLine2.FIND('-') THEN
            REPEAT
                IF CalcLines THEN BEGIN
                    ProdOrderLine2.CALCFIELDS("Reserved Qty. (Base)");
                    IF ProdOrderLine2."Reserved Qty. (Base)" <> 0 THEN
                        IF ShouldCheckReservedQty(
                             ProdOrderLine2."Prod. Order No.", 0, DATABASE::"Prod. Order Line",
                             ProdOrderLine2.Status, ProdOrderLine2."Line No.", DATABASE::"Prod. Order Component")
                        THEN
                            ProdOrderLine2.TESTFIELD("Reserved Qty. (Base)", 0);
                END;

                IF CalcComponents THEN BEGIN
                    ProdOrderComp2.SETRANGE(Status, ProdOrderLine2.Status);
                    ProdOrderComp2.SETRANGE("Prod. Order No.", ProdOrderLine2."Prod. Order No.");
                    ProdOrderComp2.SETRANGE("Prod. Order Line No.", ProdOrderLine2."Line No.");
                    ProdOrderComp2.SETAUTOCALCFIELDS("Reserved Qty. (Base)");
                    IF ProdOrderComp2.FIND('-') THEN BEGIN
                        REPEAT
                            IF ProdOrderComp2."Reserved Qty. (Base)" <> 0 THEN
                                IF ShouldCheckReservedQty(
                                     ProdOrderComp2."Prod. Order No.", ProdOrderComp2."Line No.",
                                     DATABASE::"Prod. Order Component", ProdOrderComp2.Status,
                                     ProdOrderComp2."Prod. Order Line No.", DATABASE::"Prod. Order Line")
                                THEN
                                    ProdOrderComp2.TESTFIELD("Reserved Qty. (Base)", 0);
                        UNTIL ProdOrderComp2.NEXT = 0;
                    END;
                END;
            UNTIL ProdOrderLine2.NEXT = 0;
    end;

    local procedure ShouldCheckReservedQty(ProdOrderNo: Code[20]; LineNo: Integer; SourceType: Integer; Status: Option; ProdOrderLineNo: Integer; SourceType2: Integer): Boolean
    var
        ReservEntry: Record "Reservation Entry";
    begin
        ReservEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name");
        ReservEntry.SETRANGE("Source Batch Name", '');
        ReservEntry.SETRANGE("Reservation Status", ReservEntry."Reservation Status"::Reservation);
        ReservEntry.SETRANGE("Source ID", ProdOrderNo);
        ReservEntry.SETRANGE("Source Ref. No.", LineNo);
        ReservEntry.SETRANGE("Source Type", SourceType);
        ReservEntry.SETRANGE("Source Subtype", Status);
        ReservEntry.SETRANGE("Source Prod. Order Line", ProdOrderLineNo);

        IF ReservEntry.FINDFIRST THEN BEGIN
            ReservEntry.GET(ReservEntry."Entry No.", NOT ReservEntry.Positive);
            EXIT(
              NOT ((ReservEntry."Source Type" = SourceType2) AND
                   (ReservEntry."Source ID" = ProdOrderNo) AND (ReservEntry."Source Subtype" = Status)));
        END;

        EXIT(FALSE);
    end;

    local procedure CheckProductionBOMStatus(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20])
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        IF ProdBOMNo = '' THEN
            EXIT;

        IF ProdBOMVersionNo = '' THEN BEGIN
            ProductionBOMHeader.GET(ProdBOMNo);
            ProductionBOMHeader.TESTFIELD(Status, ProductionBOMHeader.Status::Certified);
        END ELSE BEGIN
            ProductionBOMVersion.GET(ProdBOMNo, ProdBOMVersionNo);
            ProductionBOMVersion.TESTFIELD(Status, ProductionBOMVersion.Status::Certified);
        END;
    end;

    local procedure CheckRoutingStatus(RoutingNo: Code[20]; RoutingVersionNo: Code[20])
    var
        RoutingHeader: Record "Routing Header";
        RoutingVersion: Record "Routing Version";
    begin
        IF RoutingNo = '' THEN
            EXIT;

        IF RoutingVersionNo = '' THEN BEGIN
            RoutingHeader.GET(RoutingNo);
            RoutingHeader.TESTFIELD(Status, RoutingHeader.Status::Certified);
        END ELSE BEGIN
            RoutingVersion.GET(RoutingNo, RoutingVersionNo);
            RoutingVersion.TESTFIELD(Status, RoutingVersion.Status::Certified);
        END;
    end;


    procedure InitializeRequest(Direction2: Option Forward,Backward; CalcLines2: Boolean; CalcRoutings2: Boolean; CalcComponents2: Boolean; CreateInbRqst2: Boolean)
    begin
        Direction := Direction2;
        CalcLines := CalcLines2;
        CalcRoutings := CalcRoutings2;
        CalcComponents := CalcComponents2;
        CreateInbRqst := CreateInbRqst2;
    end;

    local procedure IsComponentPicked(ProdOrder: Record "Production Order"): Boolean
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SETFILTER("Qty. Picked", '<>0');
        EXIT(NOT ProdOrderComp.ISEMPTY);
    end;
}

