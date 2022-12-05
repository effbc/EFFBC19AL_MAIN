table 33000929 "Calibration Ledger Entries"
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
            OptionCaption = ',DMM,Tepm.Meter,Lux Meter,Vernier,Screw Guage,Torque Meter,Potting Machine,CHAMBER,Power Meter,Burst-Generator,Surge-Generator,Voltage Interruption Simulator,Weighing Machine,RF Analyzer,Mixer,ESD ,Stacker,Air Compressor,Packing Machine,Clamp Meter,DC SUPPLY,FUNCTION GENERATOR,HV TESTER,IR Tester,LCR METER,MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,Sound Meter,De-Soldering System,Soldering System,Soldering Station,Hot Air Gun,Screw Driver,Hammer Machine,Drilling Machine,Cutting Tool,Thickness Gauge';
            OptionMembers = ,DMM,"Tepm.Meter","Lux Meter",Vernier,"Screw Guage","Torque Meter","Potting Machine",CHAMBER,"Power Meter","Burst-Generator","Surge-Generator","Voltage Interruption Simulator","Weighing Machine","RF Analyzer",Mixer,"ESD ",Stacker,"Air Compressor","Packing Machine","Clamp Meter","DC SUPPLY","FUNCTION GENERATOR","HV TESTER","IR Tester","LCR METER",MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,"Sound Meter","De-Soldering System","Soldering System","Soldering Station","Hot Air Gun","Screw Driver","Hammer Machine","Drilling Machine","Cutting Tool","Thickness Gauge";
            DataClassification = CustomerContent;
        }
        field(4; "Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(5; "Least Count"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Measuring Range"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Model No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Eqpt. Serial No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(9; Status; Option)
        {
            OptionMembers = "Working in Good Condition"," Reffered To Service"," Usage Subjective",Scrapped;
            DataClassification = CustomerContent;
        }
        field(10; Location; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(11; Department; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; Resource; Code[20])
        {
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(13; "Std. Reference"; Code[20])
        {
            TableRelation = IF ("Usage Type" = FILTER(<> Master)) Calibration WHERE("Usage Type" = CONST(Master));
            DataClassification = CustomerContent;
        }
        field(14; "Usage Type"; Option)
        {
            OptionMembers = Instrument,Master;
            DataClassification = CustomerContent;
        }
        field(15; "Warranty Starting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Warranty Ending Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Contract Starting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Contract Ending Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Last Calibration Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Calibration Period"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Next Calibration Due On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Vendor No."; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(23; "Vendor Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(24; Address1; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(25; Address2; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(26; City; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Contact Person"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(28; "Contact Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(29; Manufacturer; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(30; "MFG. Serial No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Purchase Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(32; "Service Agent"; Code[20])
        {
            TableRelation = Vendor;
            DataClassification = CustomerContent;
        }
        field(33; Name; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(34; "E-Mail Address"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Calibration Party"; Option)
        {
            OptionMembers = Internal,External;
            DataClassification = CustomerContent;
        }
        field(36; "Calibration Cert No./ IR No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(37; Results; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(38; Recommendations; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Response Time"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Expected Return Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(41; Priority; Option)
        {
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
        }
        field(42; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(43; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(44; "S Address1"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(45; "S Address2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(46; "S City"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(47; "S Contact Person"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(48; "S Contact Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(49; "Created Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50; "Last Modified Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(51; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(52; "Current Status"; Option)
        {
            OptionMembers = " ","Under Calibration",Calibrated;
            DataClassification = CustomerContent;
        }
        field(53; Process; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(54; Check; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55; "RGP Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(56; "Calib. Resource Name"; Text[100])
        {
            Caption = 'Resource Name';
            DataClassification = CustomerContent;
        }
        field(57; "IR No"; Code[15])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(58; "Item Desc"; Code[200])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(59; "Item No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(61; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(62; Transfered_from; Option)
        {
            OptionMembers = ,IR,CalibrationModule;
            DataClassification = CustomerContent;
        }
        field(63; "Unit cost(LCY)"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(64; "Owner of the Equpmnt"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(65; "Owner of the Equpmnt_empid"; Code[70])
        {
            DataClassification = CustomerContent;
        }
        field(66; "Owner of the Equpmnt_Dept"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(67; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(68; Classification; Option)
        {
            OptionCaption = ',Blue,Green,Red,Yellow';
            OptionMembers = ,Blue,Green,Red,Yellow;
            DataClassification = CustomerContent;
        }
        field(69; "Reason for Delay"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(70; "Delay Days"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(71; "Entry No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(72; "Not an ERP Integrated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(73; "Master Item"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(74; "Life Time"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(75; "Previously Calibrated Times"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(76; "Life time in Yrs"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(77; mailsent; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
        key(Key2; "Std. Reference")
        {
        }
        key(Key3; "Owner of the Equpmnt")
        {
        }
        key(Key4; "Owner of the Equpmnt_empid")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "Created Date" := Today;
        "Created By" := UserId;
    end;

    trigger OnModify();
    begin
        "Last Modified Date" := Today;
        "Modified By" := UserId;
    end;

    var
        // NoSeriesMgt: Codeunit 396;
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
}

