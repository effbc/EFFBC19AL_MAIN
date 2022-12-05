table 33000255 "Inspection Datasheet Header"
{
    // version QC1.1,WIP1.1,QCB2B1.2,QC1.2,Cal1.0,RQC1.0,Rev01

    LookupPageID = "Inspection Data Sheet List";
    DataClassification = CustomerContent;
    Permissions = TableData 33000255 = rimd;

    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Receipt No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";
            DataClassification = CustomerContent;
        }
        field(4; "Order No."; Code[20])
        {
        }
        field(5; "Posting Date"; Date)
        {
        }
        field(6; "Document Date"; Date)
        {
        }
        field(7; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";
        }
        field(8; "Vendor Name"; Text[50])
        {
        }
        field(9; "Vendor Name 2"; Text[50])
        {
        }
        field(10; "Vendor Address"; Text[50])
        {
        }
        field(11; "Vendot Address 2"; Text[50])
        {
        }
        field(12; "Contact Person"; Text[50])
        {
        }
        field(13; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(14; "Item Description"; Text[50])
        {
        }
        field(15; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(16; "Spec ID"; Code[20])
        {
            TableRelation = "Specification Header"."Spec ID";
        }
        field(17; "No. Series"; Code[20])
        {
        }
        field(18; "Inspection Group Code"; Code[20])
        {
            TableRelation = "Inspection Group";
        }
        field(19; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(20; "Purch Line No"; Integer)
        {
        }
        field(21; "Lot No."; Code[20])
        {
        }
        field(22; "Created By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
        }
        field(23; "Created Date"; Date)
        {
        }
        field(24; "Created Time"; Time)
        {
        }
        field(25; "Posted Date"; Date)
        {
        }
        field(26; "Posted Time"; Time)
        {
        }
        field(27; "Posted By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
        }
        field(28; "Data Entered By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
        }
        field(29; "Inspection Receipt No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
        }
        field(30; Location; Code[20])
        {
            TableRelation = Location.Code;
        }
        field(31; "New Location"; Code[20])
        {
            TableRelation = Location;
        }
        field(32; "Rework Level"; Integer)
        {
        }
        field(33; "Rework Reference No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
        }
        field(34; "Item Ledger Entry No."; Integer)
        {
            TableRelation = "Item Ledger Entry";
        }
        field(35; "Item Tracking Exists"; Boolean)
        {
        }
        field(36; "Source Type"; Option)
        {
            OptionMembers = "In Bound",WIP,Transfer,"Sales Returns","Periodic Inspection",Calibration;
        }
        field(37; "Quality Before Receipt"; Boolean)
        {
            Editable = false;
        }
        field(38; "Purchase Consignment No."; Code[20])
        {
            Editable = false;
        }
        field(39; "External Document No."; Code[20])
        {
        }
        field(40; comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Quality Comment Line" WHERE(Type = CONST("Inspection Data Sheets"), "No." = FIELD("No.")));

        }
        field(41; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(42; "Spec Version"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
        }
        field(43; "Qty. per Unit of Measure"; Decimal)
        {
        }
        field(50; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
        }
        field(51; "Prod. Order Line"; Integer)
        {
        }
        field(52; "Routing No."; Code[20])
        {
        }
        field(53; "Routing Reference No."; Integer)
        {
        }
        field(54; "Operation No."; Code[20])
        {
        }
        field(55; "Prod. Description"; Text[50])
        {
        }
        field(56; "Operation Description"; Text[50])
        {
        }
        field(57; "Production Batch No."; Code[20])
        {
        }
        field(58; "Sub Assembly Code"; Code[20])
        {
            TableRelation = "Sub Assembly";
        }
        field(59; "Sub Assembly Description"; Text[30])
        {
        }
        field(60; "In Process"; Boolean)
        {
        }
        field(61; "Base Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(62; "Quantity(Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(63; "Serial No."; Code[20])
        {
            Description = 'QCB2B1.2';
        }
        field(64; "DC Inbound Ledger Entry"; Integer)
        {
            Description = 'QCB2B1.2';
        }
        field(81; "Customer No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(82; "Customer Name"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(83; "Customer Name 2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(84; "Customer Address"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(85; "Customer Address2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(86; "Sales Line No"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(87; "Sales Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(88; "Posted Sales Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(89; "Sample Inspection Line No."; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(100; "Quality Status"; Option)
        {
            Description = 'QCB2B1.2';
            Editable = false;
            OptionMembers = Open,Cancel;
        }
        field(201; "Trans. Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(202; "Trans. Order Line"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(203; "Trans. Description"; Text[50])
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(204; "Transfer-from Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(205; "Transfer-to Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(60001; "Actual Time"; Decimal)
        {
            CalcFormula = Sum("Inspection Datasheet Line"."Bench Mark Time(In Min.)" WHERE("Document No." = FIELD("No.")));
            Description = 'B2B1.0-ESPLQC';
            FieldClass = FlowField;
        }
        field(60002; "Time Taken"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Inspection Datasheet Line"."Time Taken(In Min.)" WHERE("Document No." = FIELD("No.")));
            Description = 'B2B1.0-ESPLQC';

        }
        field(60003; "Document Type"; Option)
        {
            Description = 'B2B1.0-ESPLQC';
            OptionMembers = Receipt,Production,Transfer,"Item Inspection","Return Orders",Rework,"Sample Lot";
        }
        field(60004; Resource; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            TableRelation = "Machine Center"."No.";
        }
        field(60005; "Sample Inspection"; Boolean)
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(60007; "Measuring Range"; Text[30])
        {
            Description = 'B2B-Cal';
        }
        field(60008; "Model No."; Text[30])
        {
            Description = 'B2B-Cal';
        }
        field(60009; "Eqpt. Serial No."; Text[30])
        {
            Description = 'B2B-Cal';
        }
        field(60011; Department; Code[20])
        {
            Description = 'B2B-Cal';
        }
        field(60013; "Std. Reference"; Code[20])
        {
            Description = 'B2B-Cal';
            TableRelation = IF ("Usage Type" = FILTER(<> Master)) Calibration WHERE("Usage Type" = CONST(Master));
        }
        field(60014; "Calibration Party"; Option)
        {
            Description = 'B2B-Cal';
            OptionMembers = Internal,External;
        }
        field(60015; "Usage Type"; Option)
        {
            Description = 'B2B-Cal';
            OptionCaption = 'Instrument,Master';
            OptionMembers = Instrument,Master;
        }
        field(60016; Manufacturer; Text[30])
        {
            Description = 'B2B-Cal';
        }
        field(60017; "MFG. Serial No."; Text[30])
        {
            Description = 'B2B-Cal';
        }
        field(60020; "Least Count"; Decimal)
        {
            Description = 'B2B-Cal';
        }
        field(60026; "Item Category Code"; Code[10])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60027; "Product Group Code"; Code[10])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60028; "Item Sub Group Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60029; "Item Sub Sub Group Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60030; "No. of Soldering Points"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60031; "No. of Pins"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60032; "No. of Opportunities"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60033; "No.of Fixing Holes"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
        }
        field(60034; "Reason for Pending"; Text[50])
        {
            Description = 'B2B1.0-ESPLQC';
        }
        field(60036; "QAS/MPR"; Enum "QAS MPR")
        {
            Description = 'B2B';

        }
        field(60037; "Inprocess Serial No."; Code[20])
        {
        }
        field(60038; "OutPut Jr Serial No."; Code[20])
        {
            Editable = true;
        }
        field(60039; "Rework Posted"; Boolean)
        {
            Description = 'RQC1.0';
        }
        field(60040; "Rework User"; Code[20])
        {
            Description = 'RQC1.0';
        }
        field(60041; "Finished Product Sr No"; Code[20])
        {
            Description = 'RQC1.0';
        }
        field(60042; "Item Bench Mark"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Inspection Bench Mark(In Min)" WHERE("No." = FIELD("Item No.")));

        }
        field(60060; "OLD IDS"; Boolean)
        {
        }
        field(60061; "Creation DateTime"; DateTime)
        {
            Editable = false;
        }
        field(60065; "Parent IDS No"; Code[20])
        {
            Description = 'PIDSQC1.0';
            Editable = false;
        }
        field(60066; "Partial Inspection"; Boolean)
        {
            Description = 'PIDSQC1.0';
        }
        field(60067; "Qty in IDS"; Decimal)
        {
            Description = 'PIDSQC1.0';
            Editable = true;
        }
        field(60068; "Reclass Entry"; Boolean)
        {
            Description = 'PIDSQC1.0';
        }
        field(60069; "Total Qty in IDS"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Inspection Datasheet Header".Quantity WHERE("Parent IDS No" = FIELD("No."), "Partial Inspection" = FILTER(false)));
            Description = 'PIDSQC1.0';

        }
        field(60070; "Total Qty in IR"; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header".Quantity WHERE("Parent IDS" = FIELD("No."), Status = FILTER(false)));
            FieldClass = FlowField;
        }
        field(60071; "Total Qty in PIR"; Decimal)
        {
            CalcFormula = Sum("Inspection Receipt Header".Quantity WHERE("Parent IDS" = FIELD("No."), Status = FILTER(true)));
            FieldClass = FlowField;
        }
        field(60101; Make; Code[30])
        {
        }
        field(60102; Sample; Boolean)
        {
        }
        field(60103; "LED Part No."; Code[30])
        {
        }
        field(60104; Color; Code[20])
        {
        }
        field(60106; "Intensity Code"; Code[10])
        {
        }
        field(60107; "Intensity Value"; Code[120])
        {
        }
        field(60108; "Color Code"; Code[10])
        {
        }
        field(60109; "Color Value"; Code[120])
        {
        }
        field(60110; "Voltage Code"; Code[10])
        {
        }
        field(60111; "Voltage Value"; Code[120])
        {
        }
        field(60112; "Ext Batch No"; Code[30])
        {
        }
        field(60113; "Ext Lot No"; Code[30])
        {
        }
        field(60115; "Date Code"; Code[10])
        {
        }
        field(60116; Date; Code[50])
        {
        }
        field(60117; "LED Make"; Code[30])
        {
        }
        field(60118; "LED Type"; Code[10])
        {
        }
        field(60119; "MBB Status"; Option)
        {
            OptionCaption = '" ,Normal,Damage"';
            OptionMembers = " ",Normal,Damage;
        }
        field(60120; "HIC 60%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
        }
        field(60121; "HIC 10%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
        }
        field(60122; "HIC 5%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
        }
        field(60123; "MBB Packet Open DateTime"; DateTime)
        {
        }
        field(60124; "MBB Packet Close DateTime"; DateTime)
        {
        }
        field(60125; "Baked Hours"; Decimal)
        {
        }
        field(60126; "MFD Date"; Date)
        {
        }
        field(60127; "Packed Date"; Date)
        {
        }
        field(60128; "MBB Packed Date"; Date)
        {
        }
        field(60129; "Issues For Pending"; Option)
        {
            Description = 'added by vishnu';
            OptionCaption = '"  ,TEMC-Part No Variations,TEMC-Vendor/Make Variation,TEMC-Samples,TEMC-Shelf-Life,TEMC-Device Marking,TEMC-Expiry Date,TEMC-MSL Level,TEMC-Datasheets,TEMC-Standardisation,Layouts-Samples,Layouts-Layouts Updation,Mechanical-Samples,Mechanical-Vendor/make Variation,Mechanical-Dimension Variations,Mechanical- Specification/Requirements,Mechanical-Stnadardisation,Indent Person Confirmation,Vendor/Make-Partial Material,Vendor/Make-Replacement,Vendor/Make-Specification,Vendor/Make-Packing,Vendor/Make-Checklist,Vendor/Make-Test Report,Vendor/Make-Rework,Stores-Wrong Inward,Stores-Material Not Available,Benchmark,Test Setup,Non Priority,Manpower,No Issue,Vendor/Make-Quality Problem,Vendor/Make-Functionality,Sys Admin Confirmation,Site - Confirmation,Controlroom - Confirmation,R&D - Confirmation,PCBs - Numbering"';
            OptionMembers = "  ","TEMC-Part No Variations","TEMC-Vendor/Make Variation","TEMC-Samples","TEMC-Shelf-Life","TEMC-Device Marking","TEMC-Expiry Date","TEMC-MSL Level","TEMC-Datasheets","TEMC-Standardisation","Layouts-Samples","Layouts-Layouts Updation","Mechanical-Samples","Mechanical-Vendor/make Variation","Mechanical-Dimension Variations","Mechanical- Specification/Requirements","Mechanical-Stnadardisation","Indent Person Confirmation","Vendor/Make-Partial Material","Vendor/Make-Replacement","Vendor/Make-Specification","Vendor/Make-Packing","Vendor/Make-Checklist","Vendor/Make-Test Report","Vendor/Make-Rework","Stores-Wrong Inward","Stores-Material Not Available",Benchmark,"Test Setup","Non Priority",Manpower,"No Issue","Vendor/Make-Quality Problem","Vendor/Make-Functionality","Sys Admin Confirmation","Site - Confirmation","Controlroom - Confirmation","R&D - Confirmation","PCBs - Numbering";
        }
        field(60130; "Order Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Amount To Vendor" WHERE("Document No." = FIELD("Order No."), "Line No." = FIELD("Purch Line No"), "No." = FIELD("Item No.")));

        }
        field(60131; "Assigned User"; Code[50])
        {
            Description = 'Added by vishnu for the inwards planning Purpose';
            //TableRelation = User."User Name" WHERE(Field60106 = CONST(QAS), Field60103 = CONST(No));//EFFUPG
            TableRelation = "User Setup"."User ID" WHERE(Tams_Dept = CONST('QAS'), Blocked = CONST(false));//EFFUPG
            ValidateTableRelation = false;
        }
        field(60132; "Planning Date"; Date)
        {
            Description = 'Added by vishnu for the inwards planning Purpose';
        }
        field(60133; "Estimated Time"; Decimal)
        {
            Description = 'Added by vishnu for the inwards planning Purpose';
        }
        field(60134; "Sample Cnt"; Decimal)
        {
            CalcFormula = Min(Item."Sampling Count" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60135; "Sample Percent"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Min(Item."Sampling %" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';

        }
        field(60136; Benchmark; Decimal)
        {
            CalcFormula = Min(Item."Inspection Bench Mark(In Min)" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60137; "Revised Sampling Count"; Decimal)
        {
            CalcFormula = Min(Item."Revised Sampling Count" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60138; "Revised Sampling Percentage"; Decimal)
        {
            CalcFormula = Min(Item."Revised Sampling Percentage" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60139; "Revised Sampling Time Mins"; Decimal)
        {
            CalcFormula = Min(Item."Revised Sampling Time Mins" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60140; "Visual Sampling Count"; Decimal)
        {
            CalcFormula = Min(Item."Visual Sampling Count" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60141; "Visual Sampling Percentage"; Decimal)
        {
            CalcFormula = Min(Item."Visual Sampling Percentage" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60142; "Visual Sampling Time Mins"; Decimal)
        {
            CalcFormula = Min(Item."Visual Sampling Time Mins" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60143; "Dimensions Sampling Count"; Decimal)
        {
            CalcFormula = Min(Item."Dimensions Sampling Count" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60144; "Dimensions Sampling Percentage"; Decimal)
        {
            CalcFormula = Min(Item."Dimensions Sampling Percentage" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60145; "Dimensions Sampling Time Mins"; Decimal)
        {
            CalcFormula = Min(Item."Dimensions Sampling Time Mins" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60146; "Basic Functional Sampling Cnt"; Decimal)
        {
            CalcFormula = Min(Item."Basic Functional Sampling Cnt" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60147; "Basic Functional Sampling Per"; Decimal)
        {
            CalcFormula = Min(Item."Basic Functional Sampling Per" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60148; "Basic Func Sampling Time -Mins"; Decimal)
        {
            CalcFormula = Min(Item."Basic Func Sampling Time -Mins" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
        field(60149; Priority; Text[30])
        {
            Description = 'Added by vishnu for the inwards planning Purpose';
        }
        field(60150; "Documentation Time"; Decimal)
        {
            CalcFormula = Min(Item."Documentation Time" WHERE("No." = FIELD("Item No.")));
            Description = 'Added by vishnu for the inwards planning Purpose';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key2; "Rework Level")
        {
        }
        key(Key3; "Purchase Consignment No.")
        {
        }
        key(Key4; "Parent IDS No", "Partial Inspection")
        {
            SumIndexFields = Quantity;
        }
        key(Key5; "Created Date")
        {
        }
        key(Key6; "Created Date", "Item No.", "Source Type")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        InspectDataLine.LOCKTABLE;
        //InspectDataLine.RESET;
        InspectDataLine.SETRANGE("Document No.", "No.");
        IF InspectDataLine.FIND('-') THEN
            REPEAT
                InspectDataLine.DELETE;
            UNTIL InspectDataLine.NEXT = 0;

        //InspectDataLine.DELETEALL;
    end;

    trigger OnInsert();
    begin
        /*QualitySetup.GET;
        QualitySetup.TESTFIELD("Inspection Datasheet Nos.");
        IF "No." = '' THEN BEGIN
          NoSeriesMgt.InitSeries(QualitySetup."Inspection Datasheet Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
         */

    end;

    trigger OnModify();
    begin
        "Data Entered By" := USERID;
    end;

    var
        // NoSeriesMgt : Codeunit 396;
        QualitySetup: Record "Quality Control Setup";
        InspectDataLine: Record "Inspection Datasheet Line";
        Item: Record Item;
        InspDataSheet: Codeunit "Inspection Data Sheets";


    procedure CreatePartialIDS();
    begin
        InspDataSheet.InsertPartInspectionDataHeader(Rec);
    end;


    procedure CreateReclass();
    begin
        InspDataSheet.InsertPartInspectionDataHead2(Rec);
    end;
}

