report 14125500 "Dispatch Note Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DispatchNoteReport.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Dispatch Details Logging"; "Dispatch Details Logging")
        {
            column(DocumentNo_DispatchDetailsLogging; "Dispatch Details Logging"."Document No.")
            {
            }
            column(LineNumber_DispatchDetailsLogging; "Dispatch Details Logging"."Line  Number")
            {
            }
            column(ScheduleLineNumber_DispatchDetailsLogging; "Dispatch Details Logging"."Schedule Line Number")
            {
            }
            column(Description_DispatchDetailsLogging; "Dispatch Details Logging".Description)
            {
            }
            column(Quantity_DispatchDetailsLogging; "Dispatch Details Logging".Quantity)
            {
            }
            column(OutstandingQuantity_DispatchDetailsLogging; "Dispatch Details Logging"."Outstanding Quantity")
            {
            }
            column(QuantitytoShip_DispatchDetailsLogging; "Dispatch Details Logging"."Quantity to Ship")
            {
            }
            column(Type_DispatchDetailsLogging; "Dispatch Details Logging".Type)
            {
            }
            column(Make_DispatchDetailsLogging; "Dispatch Details Logging".Make)
            {
            }
            column(SerialNo_DispatchDetailsLogging; "Dispatch Details Logging"."Serial No.")
            {
            }
            column(LotNo_DispatchDetailsLogging; "Dispatch Details Logging"."Lot No.")
            {
            }
            column(customername; CUSTOMERNAME)
            {
            }
            column(customerordernumber; "customer order number")
            {
            }
            column(consigneeaddress; consigneeaddress)
            {
            }
            column(TenderSchedule; tender)
            {
            }
            column(Packet_No; "Dispatch Details Logging".Packet)
            {
            }
            column(SerialNo; SerialNoGVar)
            {
            }
            column(LotNo; ScheSerialNoGvar)
            {
            }
            column(Date1; "Dispatch Details Logging".Date)
            {
            }
            column(UOM; "Dispatch Details Logging".UOM)
            {
            }

            trigger OnAfterGetRecord()
            begin
                SHREC.RESET;
                SHREC.SETFILTER("No.", "Dispatch Details Logging"."Document No.");
                IF SHREC.FINDFIRST THEN BEGIN
                    CUSTOMERNAME := SHREC."Sell-to Customer Name";
                    "customer order number" := FORMAT(SHREC."Customer OrderNo.") + FORMAT(SHREC."Customer Order Date");
                    consigneeaddress := SHREC."Ship-to Name";
                END;
                SLREC.RESET;
                SLREC.SETFILTER("Document No.", "Dispatch Details Logging"."Document No.");
                SLREC.SETRANGE("Line No.", "Dispatch Details Logging"."Line  Number");
                IF SLREC.FINDFIRST THEN BEGIN
                    tender := SLREC."Schedule No";
                END;
                CLEAR(SerialNoGVar);
                CLEAR(ScheSerialNoGvar);
                IF "Schedule Line Number" = 0 THEN BEGIN
                    ReservationEntry.RESET;
                    ReservationEntry.SETRANGE("Source ID", "Document No.");
                    ReservationEntry.SETRANGE("Source Ref. No.", "Line  Number");
                    ReservationEntry.SETRANGE("Source Type", 37);
                    ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"1");
                    ReservationEntry.SETRANGE("Item No.", "Item Number");
                    IF ReservationEntry.FINDSET THEN BEGIN
                        REPEAT
                            IF ReservationEntry."Serial No." <> '' THEN
                                SerialNoGVar += ReservationEntry."Serial No." + ',';
                            IF ReservationEntry."Lot No." <> '' THEN
                                ScheSerialNoGvar += ReservationEntry."Lot No." + ',';
                        UNTIL ReservationEntry.NEXT = 0;
                    END

                    ELSE
                        TrackingSpecification.RESET;
                    TrackingSpecification.SETRANGE("Source ID", "Document No.");
                    TrackingSpecification.SETRANGE("Source Ref. No.", "Line  Number");
                    TrackingSpecification.SETRANGE("Source Type", 37);
                    TrackingSpecification.SETRANGE("Source Subtype", TrackingSpecification."Source Subtype"::"1");
                    TrackingSpecification.SETRANGE("Item No.", "Item Number");
                    IF TrackingSpecification.FINDSET THEN BEGIN
                        REPEAT
                            IF TrackingSpecification."Serial No." <> '' THEN
                                SerialNoGVar += TrackingSpecification."Serial No." + ',';
                            IF TrackingSpecification."Lot No." <> '' THEN
                                ScheSerialNoGvar += TrackingSpecification."Lot No." + ',';
                        UNTIL TrackingSpecification.NEXT = 0;
                    END

                END;

                //CLEAR(ScheSerialNoGvar);
                IF "Schedule Line Number" > 0 THEN BEGIN
                    Schedule2GRec.RESET;
                    Schedule2GRec.SETRANGE("Document No.", "Document No.");
                    Schedule2GRec.SETRANGE("Document Line No.", "Line  Number");
                    Schedule2GRec.SETRANGE("Line No.", "Schedule Line Number");
                    IF Schedule2GRec.FINDFIRST THEN BEGIN
                        ReservationEntry.RESET;
                        ReservationEntry.SETRANGE("Source ID", "Document No.");
                        ReservationEntry.SETRANGE("Source Type", 60095);
                        ReservationEntry.SETRANGE("Source Prod. Order Line", Schedule2GRec."Document Line No.");
                        ReservationEntry.SETRANGE("Source Ref. No.", Schedule2GRec."Line No.");
                        ReservationEntry.SETRANGE("Source Subtype", ReservationEntry."Source Subtype"::"0");
                        ReservationEntry.SETRANGE("Item No.", Schedule2GRec."No.");
                        IF ReservationEntry.FINDSET THEN
                            REPEAT
                                IF ReservationEntry."Serial No." <> '' THEN
                                    SerialNoGVar += ReservationEntry."Serial No." + ',';
                                IF ReservationEntry."Lot No." <> '' THEN
                                    ScheSerialNoGvar += ReservationEntry."Lot No." + ',';
                            UNTIL ReservationEntry.NEXT = 0;
                    END;
                END;

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
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        //Date := DT2DATE("Dispatch Details Logging".Date);
    end;

    trigger OnPreReport()
    begin
        SHREC.RESET;
        SHREC.SETFILTER("No.", "Dispatch Details Logging"."Document No.");
        IF SHREC.FINDFIRST THEN BEGIN
            CUSTOMERNAME := SHREC."Sell-to Customer Name";
            "customer order number" := FORMAT(SHREC."Customer OrderNo.") + FORMAT(SHREC."Customer Order Date");
            consigneeaddress := SHREC."Ship-to Name";
        END;
    end;

    var
        CUSTOMERNAME: Text;
        "customer order number": Text;
        consigneeaddress: Text;
        SHREC: Record "Sales Header";
        SLREC: Record "Sales Line";
        tender: Integer;
        ReservationEntry: Record "Reservation Entry";
        TrackingSpecification: Record "Tracking Specification";
        SerialNoGVar: Text[1024];
        ScheSerialNoGvar: Text[1024];
        Schedule2GRec: Record Schedule2;
        Date: Text;
}

