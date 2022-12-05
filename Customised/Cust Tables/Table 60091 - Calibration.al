table 60091 Calibration
{
    // version Cal1.0

    DrillDownPageID = "Calibration List Form";
    LookupPageID = "Calibration List Form";
    PasteIsValid = false;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Equipment No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Equipment Type"; Option)
        {
            OptionCaption = ',DMM,Tepm.Meter,Lux Meter,Vernier,Screw Guage,Torque Meter,Potting Machine,CHAMBER,Power Meter,Burst-Generator,Surge-Generator,Voltage Interruption Simulator,Weighing Machine,RF Analyzer,Mixer,ESD ,Stacker,Air Compressor,Packing Machine,Clamp Meter,DC SUPPLY,FUNCTION GENERATOR,HV TESTER,IR Tester,LCR METER,MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,Sound Meter,De-Soldering System,Soldering System,Soldering Station,Hot Air Gun,Screw Driver,Hammer Machine,Drilling Machine,Cutting Tool,Thickness Gauge,Pick & Place,Wire Harnessing,Engraving Machine';
            OptionMembers = ,DMM,"Tepm.Meter","Lux Meter",Vernier,"Screw Guage","Torque Meter","Potting Machine",CHAMBER,"Power Meter","Burst-Generator","Surge-Generator","Voltage Interruption Simulator","Weighing Machine","RF Analyzer",Mixer,"ESD ",Stacker,"Air Compressor","Packing Machine","Clamp Meter","DC SUPPLY","FUNCTION GENERATOR","HV TESTER","IR Tester","LCR METER",MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,"Sound Meter","De-Soldering System","Soldering System","Soldering Station","Hot Air Gun","Screw Driver","Hammer Machine","Drilling Machine","Cutting Tool","Thickness Gauge","Pick & Place","Wire Harnessing","Engraving Machine";
            DataClassification = CustomerContent;
        }
        field(4; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(5; "Least Count"; Integer)
        {
            // FieldClass = FlowField;
            // CalcFormula = Count("Calibration Ledger Entries" WHERE(Description = FIELD(Description), "Eqpt.Serial No." = FIELD("Eqpt.Serial No.")));
            //DataClassification = CustomerContent;
        }
        field(6; "Measuring Range"; Text[30])
        {
        }
        field(7; "Model No."; Text[30])
        {
        }
        field(8; "Eqpt. Serial No."; Text[30])
        {
        }
        field(9; Status; Option)
        {
            OptionMembers = "Working in Good Condition"," Reffered To Service"," Usage Subjective",Scrapped;
        }
        field(10; Location; Code[10])
        {
            TableRelation = Location;
        }
        field(11; Department; Code[20])
        {
        }
        field(12; Resource; Code[20])
        {
            TableRelation = Resource;
        }
        field(13; "Std. Reference"; Code[20])
        {
            TableRelation = IF ("Usage Type" = FILTER(<> Master)) Calibration WHERE("Usage Type" = CONST(Master));
        }
        field(14; "Usage Type"; Option)
        {
            OptionMembers = Instrument,Master;
        }
        field(15; "Warranty Starting Date"; Date)
        {
        }
        field(16; "Warranty Ending Date"; Date)
        {
        }
        field(17; "Contract Starting Date"; Date)
        {
        }
        field(18; "Contract Ending Date"; Date)
        {
        }
        field(19; "Last Calibration Date"; Date)
        {

            trigger OnValidate();
            begin
                "Next Calibration Due On" := CALCDATE("Calibration Period", "Last Calibration Date");
                IF ((TODAY - "Next Calibration Due On") > 0) THEN
                    "Delay Days" := TODAY - "Next Calibration Due On"
                ELSE
                    "Delay Days" := 0;
            end;
        }
        field(20; "Calibration Period"; DateFormula)
        {

            trigger OnValidate();
            begin
                IF "Last Calibration Date" <> 0D THEN BEGIN
                    "Next Calibration Due On" := CALCDATE("Calibration Period", "Last Calibration Date");
                    IF ((TODAY - "Next Calibration Due On") > 0) THEN
                        "Delay Days" := TODAY - "Next Calibration Due On"
                    ELSE
                        "Delay Days" := 0
                END;
            end;
        }
        field(21; "Next Calibration Due On"; Date)
        {
        }
        field(22; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnLookup();
            begin
                IF Vendor.GET("Vendor No.") THEN;
                IF PAGE.RUNMODAL(27, Vendor) = ACTION::LookupOK THEN BEGIN
                    "Vendor No." := Vendor."No.";
                    "Vendor Name" := Vendor.Name;
                    Address1 := Vendor.Address;
                    Address2 := Vendor."Address 2";
                    City := Vendor.City;
                    "Contact Person" := Vendor.Contact;
                    "Contact Phone No." := Vendor."Phone No."
                END;
            end;
        }
        field(23; "Vendor Name"; Text[30])
        {
        }
        field(24; Address1; Text[30])
        {
        }
        field(25; Address2; Text[30])
        {
        }
        field(26; City; Text[30])
        {
        }
        field(27; "Contact Person"; Text[30])
        {
        }
        field(28; "Contact Phone No."; Text[30])
        {
        }
        field(29; Manufacturer; Text[30])
        {
        }
        field(30; "MFG. Serial No."; Text[30])
        {
        }
        field(31; "Purchase Date"; Date)
        {
        }
        field(32; "Service Agent"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnLookup();
            begin
                IF Vendor.GET("Vendor No.") THEN;
                IF PAGE.RUNMODAL(27, Vendor) = ACTION::LookupOK THEN BEGIN
                    "Service Agent" := Vendor."No.";
                    Name := Vendor.Name;
                    "S Address1" := Vendor.Address;
                    "S Address2" := Vendor."Address 2";
                    "S City" := Vendor.City;
                    "S Contact Person" := Vendor.Contact;
                    "S Contact Phone No." := Vendor."Phone No."
                END;
            end;
        }
        field(33; Name; Text[30])
        {
        }
        field(34; "E-Mail Address"; Text[30])
        {
        }
        field(35; "Calibration Party"; Option)
        {
            OptionMembers = "External Calibration",Calibrated,"Not Applicable","Periodical Verification","Partial Calibration",Damage,Missing;
        }
        field(36; "Calibration Cert No./ IR No"; Code[20])
        {

            trigger OnLookup();
            begin
                IF "Calibration Party" = "Calibration Party"::"External Calibration" THEN BEGIN
                    IRHeader.SETRANGE("Source Type", IRHeader."Source Type"::Calibration);
                    IF IRHeader.FIND('-') THEN
                        PAGE.RUN(60166, IRHeader);
                END;
            end;
        }
        field(37; Results; Text[30])
        {
        }
        field(38; Recommendations; Text[30])
        {
        }
        field(39; "Response Time"; DateFormula)
        {
        }
        field(40; "Expected Return Date"; Date)
        {
        }
        field(41; Priority; Option)
        {
            OptionMembers = Low,Medium,High;
        }
        field(42; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
        }
        field(43; "QC Enabled"; Boolean)
        {

            trigger OnValidate();
            begin
                IF "QC Enabled" THEN
                    TESTFIELD("Spec Id");
            end;
        }
        field(44; "S Address1"; Text[30])
        {
        }
        field(45; "S Address2"; Text[30])
        {
        }
        field(46; "S City"; Text[30])
        {
        }
        field(47; "S Contact Person"; Text[30])
        {
        }
        field(48; "S Contact Phone No."; Text[30])
        {
        }
        field(49; "Created Date"; Date)
        {
        }
        field(50; "Last Modified Date"; Date)
        {
        }
        field(51; "No. Series"; Code[10])
        {
        }
        field(52; "Current Status"; Option)
        {
            OptionMembers = " ","Under Calibration",Calibrated;
        }
        field(53; Process; Boolean)
        {
        }
        field(54; Check; Boolean)
        {
        }
        field(55; "RGP Status"; Boolean)
        {
        }
        field(56; "Calib. Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
        }
        field(57; "IR No"; Code[15])
        {
            Editable = true;
            TableRelation = "Inspection Receipt Header"."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                /*Calibration.RESET;
                Calibration.SETFILTER("IR No",Rec."IR No");
                IF Calibration.FINDSET THEN
                  BEGIN
                    IF ((Calibration.COUNT) > 0 ) THEN
                      ERROR('This Item is already there in Calibration with Item Desc ' + Calibration."Item Desc");
                  END;*/ // commented in order to have multiple IR

                PIRH.RESET;
                PIRH.SETFILTER("No.", Rec."IR No");
                IF PIRH.FINDSET THEN BEGIN
                    Rec."Item Desc" := PIRH."Item Description";
                    Rec."Item No" := PIRH."Item No.";
                    Rec.Manufacturer := PIRH.Make;
                    Rec."MFG. Serial No." := PIRH."Lot No.";
                    PRL.RESET;
                    PRL.SETFILTER("Document No.", PIRH."Receipt No.");
                    PRL.SETFILTER("Order Line No.", FORMAT(PIRH."Purch Line No"));
                    PRL.SETFILTER("No.", PIRH."Item No.");
                    IF PRL.FINDSET THEN BEGIN
                        PRH.RESET;
                        PRH.SETFILTER("No.", PRL."Document No.");
                        IF PRH.FINDSET THEN BEGIN
                            Rec."Purchase Date" := PRH."Posting Date";
                            Rec."Unit cost(LCY)" := PRL."Unit Cost (LCY)";
                            days := (TODAY - "Purchase Date");
                            days := ROUND(days / 365, 2);
                            "Life time in Yrs" := days;

                        END;
                    END;
                END;

            end;
        }
        field(58; "Item Desc"; Code[200])
        {
            Editable = false;
        }
        field(59; "Item No"; Code[20])
        {
        }
        field(60; "Created By"; Code[50])
        {
        }
        field(61; "Modified By"; Code[50])
        {
        }
        field(62; Transfered_from; Option)
        {
            OptionMembers = ,IR,CalibrationModule;
        }
        field(63; "Unit cost(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(64; "Owner of the Equpmnt"; Code[50])
        {

            trigger OnLookup();
            var
                UserSetup2: Record "User Setup";//EFFUPG
            begin
                UserGrec.RESET;
                IF PAGE.RUNMODAL(9800, UserGrec) = ACTION::LookupOK THEN BEGIN
                    UserSetup2.get(UserGrec."User Name");
                    "Owner of the Equpmnt" := UserGrec."User Name";
                    "Owner of the Equpmnt_empid" := UserGrec."Full Name";
                    "Owner of the Equpmnt_Dept" := UserSetup2."Tams_Dept";//UserGrec."Tams_Dept";//EFFUPG
                    VALIDATE("Owner of the Equpmnt");
                END;
            end;
        }
        field(65; "Owner of the Equpmnt_empid"; Code[70])
        {
        }
        field(66; "Owner of the Equpmnt_Dept"; Code[10])
        {
        }
        field(67; Remarks; Text[250])
        {
        }
        field(68; Classification; Option)
        {
            OptionCaption = ',Blue,Green,Red,Yellow,Missing';
            OptionMembers = ,Blue,Green,Red,Yellow,Missing;
        }
        field(69; "Reason for Delay"; Text[250])
        {
        }
        field(70; "Delay Days"; Integer)
        {
            Editable = false;
        }
        field(71; "Entry No"; Code[20])
        {
            Editable = false;
        }
        field(72; "Not an ERP Integrated"; Boolean)
        {
        }
        field(73; "Master Item"; Boolean)
        {
        }
        field(74; "Life Time"; Date)
        {
        }
        field(75; "Previously Calibrated Times"; Integer)
        {

            trigger OnValidate();
            begin
                "Least Count" := "Least Count" + "Previously Calibrated Times";
            end;
        }
        field(76; "Life time in Yrs"; Integer)
        {
        }
        field(77; mailsent; Boolean)
        {
            Description = 'added by vishnu for alertsing system';

            trigger OnValidate();
            begin
                Rec.MailSentDate := TODAY;
            end;
        }
        field(78; MailSentDate; Date)
        {
            Description = 'added by vishnu for alertsing system';
        }
    }

    keys
    {
        key(Key1; "Equipment No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI']) THEN
            ERROR('You are not authorized to delete');
    end;

    trigger OnInsert();
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\DINEEL', 'EFFTRONICS\VISHNUPRIYA']) THEN
            ERROR('You are not authorized to insert calibration record');

        "Created Date" := TODAY;
        "Created By" := USERID;

        //IF "Equipment No" = '' THEN
        BEGIN
            QCSetup.GET;
            QCSetup.TESTFIELD(QCSetup."Equipment No.");
            NoSeriesMgt.InitSeries(QCSetup."Equipment No.", xRec."No. Series", 0D, "Equipment No", "No. Series");
            Calibration.Transfered_from := Calibration.Transfered_from::CalibrationModule;
        END;
        // TO GET THE INWARDS DATE
        IF "Next Calibration Due On" <> 0D THEN BEGIN
            IF ((TODAY - "Next Calibration Due On") > 0) THEN
                "Delay Days" := TODAY - "Next Calibration Due On"
            ELSE
                "Delay Days" := 0
        END;
    end;

    trigger OnModify();
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\KRISHNAD', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\DINEEL']) THEN
            ERROR('You are not authorized to modify calibration record');

        "Last Modified Date" := TODAY;
        "Modified By" := USERID;
    end;

    var
        NoSeriesMgt: Codeunit 396;
        Vendor: Record Vendor;
        QCSetup: Record "Quality Control Setup";
        Text000: Label 'Inspection Datasheet already created';
        Calibration: Record Calibration;
        Text001: Label 'You can''t create Inspection Datasheet Bcoz status is Scrapped';
        Text002: Label 'Inspection Receipt not yet posted';
        IRHeader: Record "Inspection Receipt Header";
        RGPOut: Record "RGP Out Header";
        RGPIn: Record "RGP In Header";
        Text003: Label 'RGP Out exists , So you can''t create Inspection Datasheet';
        Text004: Label 'RGP In  exists , So you can''t create Inspection Datasheet';
        PIRH: Record "Inspection Receipt Header";
        PRH: Record "Purch. Rcpt. Header";
        PRL: Record "Purch. Rcpt. Line";
        UserGrec: Record User;
        "IR Flag": Boolean;
        CLE: Record "Calibration Ledger Entries";
        days: Integer;
        cperiod_edt_flg: Boolean;


    procedure AssistEdit(OldCalibration: Record Calibration): Boolean;
    var
        Calibration: Record Calibration;
    begin
        Calibration := Rec;
        QCSetup.GET;
        QCSetup.TESTFIELD(QCSetup."Equipment No.");
        IF NoSeriesMgt.SelectSeries(QCSetup."Equipment No.", OldCalibration."No. Series", Calibration."No. Series") THEN BEGIN
            QCSetup.GET;
            QCSetup.TESTFIELD(QCSetup."Equipment No.");
            NoSeriesMgt.SetSeries(Calibration."Equipment No");
            Rec := Calibration;
            EXIT(TRUE);
        END;
    end;


    procedure TenderAttachments();
    var
        Attachments: Record Attachments;
    begin
        Attachments.RESET;
        Attachments.SETRANGE("Table ID", DATABASE::Calibration);
        Attachments.SETRANGE("Document No.", "Equipment No");
        PAGE.RUN(PAGE::"ESPL Attachments", Attachments);
    end;


    procedure CreateInspectionDataSheets();
    var
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
        IDSHeader: Record "Inspection Datasheet Header";
        IRHeader: Record "Inspection Receipt Header";
    begin
        /*IDSHeader.SETRANGE("Source Type",IDSHeader."Source Type" :: Calibration);
        IDSHeader.SETRANGE("Item No.","Equipment No");
        IF IDSHeader.FIND('-') THEN
          ERROR(Text000);
        
        IRHeader.SETRANGE("Source Type",IRHeader."Source Type" ::Calibration);
        IRHeader.SETRANGE("Item No.","Equipment No");
        IRHeader.SETRANGE(Status,FALSE);
        IF IRHeader.FIND('-') THEN
          ERROR(Text002);
        
        RGPOut.SETRANGE(Status,RGPOut.Status :: "Not Posted");
        RGPOut.SETRANGE("Equipment No","Equipment No");
        IF RGPOut.FIND('-') THEN
          ERROR(Text003);
        
        RGPIn.SETRANGE(Status,RGPIn.Status :: "Not Posted");
        RGPIn.SETRANGE("Equipment No","Equipment No");
        IF RGPIn.FIND('-') THEN
          ERROR(Text004);
        */

        IF Status <> Status::Scrapped THEN BEGIN
            InspectDataSheets.CreateCalibrationIDS(Rec);
            "Current Status" := "Current Status"::"Under Calibration";
            "Expected Return Date" := CALCDATE("Response Time", WORKDATE);
            MODIFY;
        END ELSE
            MESSAGE(Text001);

    end;


    procedure ShowDataSheets();
    var
        InspectDataSheet: Record "Inspection Datasheet Header";
    begin
        InspectDataSheet.SETRANGE("Item No.", "Equipment No");
        InspectDataSheet.SETRANGE("Source Type", InspectDataSheet."Source Type"::Calibration);
        PAGE.RUN(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    end;


    procedure ShowPostDataSheets();
    var
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    begin
        PostInspectDataSheet.SETRANGE("Item No.", "Equipment No");
        PostInspectDataSheet.SETRANGE("Source Type", PostInspectDataSheet."Source Type"::Calibration);
        PAGE.RUN(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    end;


    procedure ShowInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        InspectionReceipt.SETRANGE("Item No.", "Equipment No");
        InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::Calibration);
        InspectionReceipt.SETRANGE(Status, FALSE);
        PAGE.RUN(PAGE::"Calib Inspection Receipt List", InspectionReceipt);
    end;


    procedure ShowPostInspectReceipt();
    var
        InspectionReceipt: Record "Inspection Receipt Header";
    begin
        InspectionReceipt.SETRANGE("Item No.", "Equipment No");
        InspectionReceipt.SETRANGE("Source Type", InspectionReceipt."Source Type"::Calibration);
        InspectionReceipt.SETRANGE(Status, TRUE);
        PAGE.RUN(PAGE::"Calib Inspection Receipt List", InspectionReceipt);
    end;


    procedure CancelInspection(var QualityStatus: Text[50]);
    var
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        QILE: Record "Quality Item Ledger Entry";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
    begin
        IDS.SETRANGE("Item No.", "Equipment No");
        IF NOT IDS.FIND('-') THEN
            ERROR('Inspection Datasheets Does not exist')
        ELSE BEGIN
            PIDS.TRANSFERFIELDS(IDS);
            PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
            PIDS.INSERT;
            IDS.DELETE;
            IDSL.SETRANGE("Document No.", IDS."No.");
            IF IDSL.FIND('-') THEN BEGIN
                REPEAT
                    PIDSL.TRANSFERFIELDS(IDSL);
                    PIDSL.INSERT;
                UNTIL IDSL.NEXT = 0;
                IDSL.DELETEALL;
            END;
            QILE.SETRANGE("Document No.", IDS."Receipt No.");
            IF QILE.FIND('-') THEN
                QILE.DELETE;
            "Current Status" := "Current Status"::Calibrated;
            "Expected Return Date" := 0D;
            MODIFY;
        END;
    end;


    procedure "Cal ledger attachements"();
    var
        Attachments: Record Attachments;
    begin
        Attachments.RESET;
        Attachments.SETRANGE("Table ID", 33000929);
        Attachments.SETRANGE("Document No.", "Equipment No");
        PAGE.RUN(PAGE::"ESPL Attachments", Attachments);
    end;
}

