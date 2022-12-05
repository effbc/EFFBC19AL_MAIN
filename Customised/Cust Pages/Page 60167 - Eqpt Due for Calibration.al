page 60167 "Eqpt Due for Calibration"
{
    // version Cal1.0,Rev01

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Calibration;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Equipment No"; Rec."Equipment No")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Equipment Type"; Rec."Equipment Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Eqpt. Serial No."; Rec."Eqpt. Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Resource; Rec.Resource)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Service Agent"; Rec."Service Agent")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Usage Type"; Rec."Usage Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Calibration Party"; Rec."Calibration Party")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Next Calibration Due On"; Rec."Next Calibration Due On")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Create RGP &Out")
                {
                    Caption = 'Create RGP &Out';
                    Image = CreateMovement;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        calibration: Record Calibration;
                    begin
                        calibration.SETRANGE(Check, FALSE);
                        IF calibration.FINDSET THEN
                            REPEAT
                                CreateRGPOUT(calibration);
                            UNTIL calibration.NEXT = 0;

                        calibration.RESET;
                        IF calibration.FINDSET THEN
                            REPEAT
                                calibration.Check := FALSE;
                                calibration.MODIFY;
                            UNTIL calibration.NEXT = 0;
                    end;
                }
                action("Create RGP &In")
                {
                    Caption = 'Create RGP &In';
                    Image = CreateBins;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        RGPIN(Rec);
                        MESSAGE(Text001);
                    end;
                }
                action("Create Inspection Data &Sheets")
                {
                    Caption = 'Create Inspection Data &Sheets';
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Calibration: Record Calibration;
                    begin
                        Calibration.SETRANGE(Process, TRUE);
                        IF Calibration.FINDSET THEN BEGIN
                            REPEAT
                                CreateIDS(Calibration);
                            UNTIL Calibration.NEXT = 0;
                            MESSAGE(Text004);
                        END;
                    end;
                }
            }
        }
    }

    var
        Text000: Label 'RGP OUT  is Created';
        Text001: Label 'RGP IN is Created';
        Text002: Label 'RGP Out doesn''t exist';
        Text003: Label 'Cannot create RGP OUT / IN for the equipment, Which is under inspection.';
        RGPOutHeader: Record "RGP Out Header";
        RGPInHeader: Record "RGP In Header";
        RGPOutLine: Record "RGP Out Line";
        RGPInLine: Record "RGP In Line";
        RGPOutLine1: Record "RGP Out Line";
        RGPOutHeader1: Record "RGP Out Header";
        RGPInHeader1: Record "RGP In Header";
        CalProHeader: Record "Calibration Procedure Header";
        IDS: Record "Inspection Datasheet Header";
        IR: Record "Inspection Receipt Header";
        NoSeriesMgt: Codeunit 396;
        Text004: Label 'Inspection Data Sheets Created Successfully.';


    procedure RGPIN(Calibration: Record Calibration);
    begin
        IDS.SETRANGE("Source Type", IDS."Source Type"::Calibration);
        IDS.SETRANGE("Item No.", Rec."Equipment No");
        IF IDS.FINDFIRST THEN
            ERROR(Text003);

        IR.SETRANGE("Source Type", IR."Source Type"::Calibration);
        IR.SETRANGE(Status, FALSE);
        IR.SETRANGE("Item No.", Rec."Equipment No");
        IF IR.FINDFIRST THEN
            ERROR(Text003);

        Calibration.SETFILTER(Status, '<>%1', Calibration.Status::Scrapped);
        Calibration.SETFILTER(Process, 'YES');
        IF Calibration.FINDFIRST THEN
            RGPOutHeader.SETRANGE("Equipment No", Calibration."Equipment No");
        RGPOutHeader.SETFILTER(Open, 'Yes');
        IF RGPOutHeader.FINDFIRST THEN BEGIN
            RGPInHeader1.SETRANGE("Equipment No", Calibration."Equipment No");
            RGPInHeader1.SETRANGE(Status, RGPInHeader1.Status::"Not Posted");
            IF NOT RGPInHeader1.FINDFIRST THEN BEGIN
                RGPInHeader.INIT;
                RGPInHeader."RGP In No." := NoSeriesMgt.GetNextNo('RGP-IN', WORKDATE, TRUE);
                RGPInHeader.Consignee := RGPInHeader.Consignee::Vendor;
                RGPInHeader."Consignee No." := Calibration."Vendor No.";
                RGPInHeader."Consignee Name" := Calibration."Vendor Name";
                RGPInHeader.Address := Calibration.Address1;
                RGPInHeader."Consignee City" := Calibration.City;
                RGPInHeader."Consignee Contact" := Calibration."Contact Person";
                RGPInHeader."Phone No." := Calibration."Contact Phone No.";
                RGPInHeader."RGP In Date" := WORKDATE;
                RGPInHeader."Calibration Status" := Calibration.Status;
                RGPInHeader.Results := Calibration.Results;
                RGPInHeader.Recommendations := Calibration.Recommendations;
                RGPInHeader."Equipment No" := Calibration."Equipment No";
                RGPInHeader.INSERT;
                RGPOutHeader.RESET;
                RGPOutHeader.SETRANGE("Equipment No", RGPInHeader."Equipment No");
                RGPOutHeader.SETRANGE(Status, RGPOutHeader.Status::Posted);
                IF RGPOutHeader.FINDLAST THEN BEGIN
                    RGPInHeader."RGP Out No." := RGPOutHeader."RGP Out No.";
                    RGPInHeader."RGP Out Date" := RGPOutHeader."RGP Date";
                    RGPInHeader."RGP Out Posting Date" := RGPOutHeader."RGP Posting Date";
                    RGPInHeader.MODIFY;
                END;
                RGPInLine.INIT;
                RGPInLine."Document No." := RGPInHeader."RGP In No.";
                RGPInLine.Type := RGPInLine.Type::"Fixed Asset";
                RGPInLine."No." := Rec."Equipment No";
                RGPInLine."Line No." := RGPInLine."Line No." + 10000;
                RGPOutHeader.SETRANGE(Status, RGPOutHeader.Status::Posted);
                RGPOutHeader.SETRANGE("Equipment No", Calibration."Equipment No");
                IF RGPOutHeader.FINDFIRST THEN BEGIN
                    RGPInLine."RGP Out Document No." := RGPOutHeader."RGP Out No.";
                    RGPOutLine.SETRANGE(RGPOutLine.Type, RGPOutLine.Type::Item);
                    RGPOutLine.SETRANGE("No.", RGPOutHeader."Equipment No");
                    IF RGPOutLine.FINDFIRST THEN
                        RGPInLine."RGP Out Line No." := RGPOutLine."Line No.";
                END;
                RGPInLine.Quantity := 1;
                RGPInLine."Quantity to Recieve" := 1;
                RGPInLine.Description := Calibration.Description;
                RGPInLine.UOM := Calibration."Unit Of Measure";
                RGPInLine.INSERT;
                Rec."Expected Return Date" := 0D;
                Rec.MODIFY;
            END;
        END ELSE
            ERROR(Text002);
    end;


    procedure CreateIDS(CalibrationLocal: Record Calibration);
    var
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
        IDSHeader: Record "Inspection Datasheet Header";
        IRHeader: Record "Inspection Receipt Header";
        Text000: Label 'Inspection Datasheet already created for %1';
        Text001: Label 'You can''t create Inspection Datasheet Bcoz status is Scrapped for the Equipment %1';
        Text002: Label 'Inspection Receipt not yet posted for the Equipment %1';
        Text003: Label 'RGP Out exists for the Equipment %1, So you can''t create Inspection Datasheet';
        Text004: Label 'RGP In  exists for the Equipment %1, So you can''t create Inspection Datasheet';
    begin
        /*IDSHeader.SETRANGE("Source Type",IDSHeader."Source Type" :: Calibration);
        IDSHeader.SETRANGE("Item No.",CalibrationLocal."Equipment No");
        IF IDSHeader.FINDFIRST THEN
          ERROR(Text000,CalibrationLocal."Equipment No");
        
        IRHeader.SETRANGE("Source Type",IRHeader."Source Type" ::Calibration);
        IRHeader.SETRANGE("Item No.",CalibrationLocal."Equipment No");
        IRHeader.SETRANGE(Status,FALSE);
        IF IRHeader.FINDFIRST THEN
          ERROR(Text002,CalibrationLocal."Equipment No");
        
        RGPOutHeader.SETRANGE(Status,RGPOutHeader.Status :: "Not Posted");
        RGPOutHeader.SETRANGE("Equipment No",CalibrationLocal."Equipment No");
        IF RGPOutHeader.FINDFIRST THEN
          ERROR(Text003,CalibrationLocal."Equipment No");
        
        RGPInHeader.SETRANGE(Status,RGPInHeader.Status :: "Not Posted");
        RGPInHeader.SETRANGE("Equipment No",CalibrationLocal."Equipment No");
        IF RGPInHeader.FINDFIRST THEN
          ERROR(Text004,CalibrationLocal."Equipment No");
        */
        IF CalibrationLocal.Status <> CalibrationLocal.Status::Scrapped THEN BEGIN
            InspectDataSheets.CreateCalibrationIDS2(CalibrationLocal);
            CalibrationLocal."Current Status" := CalibrationLocal."Current Status"::"Under Calibration";
            CalibrationLocal."Expected Return Date" := CALCDATE(Rec."Response Time", WORKDATE);
            CalibrationLocal.Process := FALSE;
            CalibrationLocal.MODIFY;
        END ELSE
            MESSAGE(Text001, CalibrationLocal."Equipment No");

    end;


    procedure CreateRGPOUT(Calibration: Record Calibration);
    var
        Calibration2: Record Calibration;
    begin
        Calibration2.SETRANGE(Process, TRUE);
        Calibration2.SETFILTER(Status, '<>%1', Calibration.Status::Scrapped);
        Calibration2.SETRANGE("Service Agent", Calibration."Service Agent");
        IF Calibration2.FINDFIRST THEN BEGIN
            RGPOutHeader.INIT;
            RGPOutHeader."RGP Out No." := NoSeriesMgt.GetNextNo('RGP-OUT', WORKDATE, TRUE);
            RGPOutHeader.Consignee := RGPOutHeader.Consignee::Vendor;
            RGPOutHeader."Consignee No." := Calibration2."Vendor No.";
            RGPOutHeader."Consignee Name" := Calibration2."Vendor Name";
            RGPOutHeader.Address := Calibration2.Address1;
            RGPOutHeader."Consignee City" := Calibration2.City;
            RGPOutHeader."Consignee Contact" := Calibration2."Contact Person";
            RGPOutHeader."Phone No." := Calibration2."Contact Phone No.";
            RGPOutHeader."RGP Date" := WORKDATE;
            //RGPOutHeader."Equipment No" := Calibration2."Equipment No";
            RGPOutHeader.INSERT;

            REPEAT
                RGPOutLine.INIT;
                RGPOutLine."Document No." := RGPOutHeader."RGP Out No.";
                RGPOutLine.Type := RGPOutLine.Type::Calibration;
                RGPOutLine."No." := Calibration2."Equipment No";
                RGPOutLine."Line No." := RGPOutLine."Line No." + 10000;
                RGPOutLine.Description := Calibration2.Description;
                RGPOutLine.UOM := Calibration2."Unit Of Measure";
                RGPOutLine.Quantity := 1;
                //RGPOutLine."Expected Return Date" := Calibration2."Expected Return Date";
                RGPOutLine."Expected Return Date" := CALCDATE(Calibration2."Response Time", WORKDATE);
                RGPOutLine.INSERT;

                Calibration2.Check := TRUE;
                Calibration2."Expected Return Date" := CALCDATE(Calibration2."Response Time", WORKDATE);
                Calibration2."Current Status" := Calibration2."Current Status"::"Under Calibration";
                Calibration2."RGP Status" := TRUE;
                Calibration2.Process := FALSE;
                Calibration2.MODIFY;
            UNTIL Calibration2.NEXT = 0;
        END;
    end;
}

