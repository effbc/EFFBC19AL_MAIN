table 33000269 "Inspection Receipt Header"
{
    // version QC1.1,WIP1.1,QCB2B1.2,QC1.2,Cal1.0,QCP1.0,RQC1.0,Rev01

    // QCP1.0  commented for QC partial acceptance

    DrillDownPageID = "Posted Inspect. Receipt List";
    LookupPageID = "Posted Inspect. Receipt List";
    Permissions = TableData "Item Ledger Entry" = m;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            TableRelation = "Purch. Rcpt. Header"."No.";
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Vendor No."; Code[20])
        {
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
        }
        field(7; "Vendor Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Vendor Name 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; Address; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Contact Person"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(14; "Item Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(15; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(16; "Spec ID"; Code[20])
        {
            TableRelation = "Specification Header"."Spec ID";
            DataClassification = CustomerContent;
        }
        field(20; "Purch Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Return Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; Status; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Lot No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Qty. Accepted"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                TestField(Status, false);
                if Quantity < "Qty. Accepted" + "Qty. Rejected" + "Qty. Rework" + "Qty. Accepted Under Deviation" then
                    Error(Text000);
                if ("Item Tracking Exists") and ("Source Type" = "Source Type"::"In Bound") then
                    Error('Item Tracking lines exists');
            end;
        }
        field(25; "Qty. Rejected"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Qty. Accepted");
            end;
        }
        field(26; "Data Entered By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(27; "Posted By"; Code[50])
        {
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(28; "Posted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(29; "Posted Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Location Code"; Code[20])
        {
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
        }
        field(31; "New Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Quality Before Receipt", false);
            end;
        }
        field(32; "Qty. Rework"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Qty. Accepted");
            end;
        }
        field(33; "Qty. Accepted Under Deviation"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Qty. Accepted");
            end;
        }
        field(34; "Qty. Accepted UD Reason"; Code[150])
        {
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //ReasonCode.SETFILTER(Type,'Qc');
                //ReasonCode.FINDSET;
                if ReasonCode.Get("Qty. Accepted UD Reason") then
                    // "Reason Description" := ReasonCode.Description;   commented by vishnu on 25-03-2019
                    "Qty. Accepted UD Reason" := ReasonCode.Description;
            end;
        }
        field(35; "Reason Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Rework Level"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Rework Reference No."; Code[20])
        {
            TableRelation = "Inspection Receipt Header"."No.";
            DataClassification = CustomerContent;
        }
        field(38; "Rework Inspect DS Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(39; "Last Rework Level"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Item Ledger Entry No."; Integer)
        {
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(41; "Item Tracking Exists"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(42; "Source Type"; Option)
        {
            OptionMembers = "In Bound",WIP,Transfer,"Sales Returns","Periodic Inspection",Calibration;
            DataClassification = CustomerContent;
        }
        field(43; "Quality Before Receipt"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(44; "Purchase Consignment"; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(45; "External Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(46; comment; Boolean)
        {
            CalcFormula = Exist("Quality Comment Line" WHERE(Type = CONST("Inspection Receipt"),
                                                              "No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(47; "Unit Of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(48; "Spec Version"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
        field(49; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." WHERE(Status = FILTER(Released));
            DataClassification = CustomerContent;
        }
        field(51; "Prod. Order Line"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(52; "Routing No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Routing Reference No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(54; "Operation No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(55; "Prod. Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Operation Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(57; "Production Batch No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(58; "Sub Assembly Code"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;
        }
        field(59; "Sub Assembly Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60; "In Process"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(61; "Rework Completed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(62; "Sample Inspection Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(70; "Nature Of Rejection"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(71; "Qty. To Vendor (Rejected)"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Source Type" = "Source Type"::"In Bound") and (not "Quality Before Receipt") then
                    TestField("Quality Before Receipt", true);

                if ("Qty. Sent To Vendor (Rejected)" + "Qty. To Vendor (Rejected)") > "Qty. Rejected" then
                    Error('Rejected Quantity Returns should not be more than Quantity Rejected');
            end;
        }
        field(72; "Qty. Sent To Vendor (Rejected)"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(73; "Qty. To Vendor (Rework)"; Decimal)
        {
            Editable = true;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Qty. Sent To Vendor (Rework)" + "Qty. To Vendor (Rework)") > "Qty. Rework" then
                    Error('Quantity sending to Rework should not be more than Quantity Rework');
            end;
        }
        field(74; "Qty. Sent To Vendor (Rework)"; Decimal)
        {
            Editable = true;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(75; "Qty. To Receive(Rework)"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Qty. To Receive(Rework)" + "Qty. Received(Rework)") > "Qty. Sent To Vendor (Rework)" then
                    Error('Quantity To receive should not be more than Quantity Sent for Rework');
            end;
        }
        field(76; "Qty. Received(Rework)"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(77; "Base Unit Of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = CustomerContent;
        }
        field(78; "Quantity(Base)"; Decimal)
        {
            DecimalPlaces = 0 : 9;
            DataClassification = CustomerContent;
        }
        field(81; "Customer No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(82; "Customer Name"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(83; "Customer Name 2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(84; "Customer Address"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85; "Customer Address2"; Text[30])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(86; "Sales Line No"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(87; "Sales Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(88; "Posted Sales Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90; "Created Date"; Date)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(91; "Rework Reference Document No."; Integer)
        {
            Description = 'QCB2B1.2';
            TableRelation = "Delivery/Receipt Entry"."Entry No." WHERE("Document No." = FIELD("No."),
                                                                        Open = CONST(true));
            DataClassification = CustomerContent;
        }
        field(92; "Serial No."; Code[20])
        {
            Description = 'QCB2B1.2';
            DataClassification = CustomerContent;
        }
        field(93; "DC Inbound Ledger Entry."; Integer)
        {
            Description = 'QCB2B1.2';
            DataClassification = CustomerContent;
        }
        field(100; "Quality Status"; Option)
        {
            Description = 'QCB2B1.2';
            Editable = false;
            OptionMembers = Open,Cancel,Close;
            DataClassification = CustomerContent;
        }
        field(201; "Trans. Order No."; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(202; "Trans. Order Line"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(203; "Trans. Description"; Text[50])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(204; "Transfer-from Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(205; "Transfer-to Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(206; "Ids Reference No."; Code[20])
        {
            Description = 'B2B for attachments';
            DataClassification = CustomerContent;
        }
        field(60002; "Created time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(60003; "Document Type"; Option)
        {
            Description = 'B2B1.0-ESPLQC';
            OptionMembers = Receipt,Production,Transfer,"Item Inspection","Return Orders",Rework,"Sample Lot";
            DataClassification = CustomerContent;
        }
        field(60004; Resource; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            TableRelation = "Machine Center"."No.";
            DataClassification = CustomerContent;
        }
        field(60005; "Rework Time( In Minutes)"; Decimal)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60006; "Sample Inspection"; Boolean)
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60007; "IDS Posted By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60008; "IR Posted By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60009; "Model No."; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60010; "Eqpt. Serial No."; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60011; Department; Code[20])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60013; "Std. Reference"; Code[20])
        {
            Description = 'B2B-Cal';
            TableRelation = IF ("Usage Type" = FILTER(<> Master)) Calibration WHERE("Usage Type" = CONST(Master));
            DataClassification = CustomerContent;
        }
        field(60014; "Calibration Party"; Option)
        {
            OptionMembers = Internal,External;
            DataClassification = CustomerContent;
        }
        field(60015; "Usage Type"; Option)
        {
            Description = 'B2B-Cal';
            OptionMembers = Instrument,Master;
            DataClassification = CustomerContent;
        }
        field(60016; Manufacturer; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60017; "MFG. Serial No."; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60018; Results; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60019; Recommendations; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60020; "Calibration Status"; Option)
        {
            Description = 'B2B-Cal';
            OptionMembers = "Working in Good Condition"," Reffered To Service"," Usage Subjective",Scrapped;
            DataClassification = CustomerContent;
        }
        field(60021; "Least Count"; Decimal)
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60022; "Measuring Range"; Text[30])
        {
            Description = 'B2B-Cal';
            DataClassification = CustomerContent;
        }
        field(60026; "Item Category Code"; Code[10])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60027; "Product Group Code"; Code[10])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60028; "Item Sub Group Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60029; "Item Sub Sub Group Code"; Code[20])
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60030; "No. of Soldering Points"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60031; "No. of Pins"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60032; "No. of Opportunities"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60033; "No.of Fixing Holes"; Integer)
        {
            Description = 'B2B1.0-ESPLQC';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60034; "Reason for Pending"; Text[50])
        {
            Description = 'B2B1.0-ESPLQC';
            DataClassification = CustomerContent;
        }
        field(60036; "QAS/MPR"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,QAS,MPR"';
            OptionMembers = " ",QAS,MPR;
            DataClassification = CustomerContent;
        }
        field(60037; "Inprocess Serial No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60038; "OutPut Jr Serial No."; Code[20])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60039; "Rework Posted"; Boolean)
        {
            Description = 'RQC1.0';
            DataClassification = CustomerContent;
        }
        field(60040; "Rework User"; Code[20])
        {
            Description = 'RQC1.0';
            DataClassification = CustomerContent;
        }
        field(60041; "Finished Product Sr No"; Code[20])
        {
            Description = 'RQC1.0';
            DataClassification = CustomerContent;
        }
        field(60060; "OLD IDS"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60061; "Reason code"; Code[20])
        {
            TableRelation = "Reason Code".Code;
            DataClassification = CustomerContent;
        }
        field(60062; "IDS creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60063; "Parent IDS"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60101; Make; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60102; Sample; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60103; "Stock Rcvd from QC"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60104; "Rejection Category"; Option)
        {
            OptionMembers = ,Functional,"Item Wrong","Manufacturer Defect","Physical Damage","Non-Preferable Item","Quality Problem";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Rejection Reason" := '';
            end;
        }
        field(60105; "Rejection Reason"; Text[100])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                rejection.Reset;
                rejection.SetRange(rejection."Rejection Category", "Rejection Category");
                if PAGE.RunModal(60218, rejection) = ACTION::LookupOK then
                    "Rejection Reason" := rejection."Rejection Reason";
            end;
        }
        field(60106; Flag; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*IF (UPPERCASE(USERID)<>'89FD003') THEN
                    ERROR('U Dont have Sufficient Rights');
                IF xRec.Flag= FALSE THEN
                BEGIN
                  Attach.RESET;
                  Attach.SETRANGE("Table ID",DATABASE::"Inspection Receipt Header");
                  Attach.SETRANGE("Document No.","No.");
                  PAGE.RUNMODAL(PAGE::"ESPL Attachments",Attach);
                  IF Flag= TRUE THEN
                  BEGIN
                    Attach.RESET;
                    Attach.SETFILTER(Attach."Document No.","No.");
                    Attach.SETFILTER(Attach.Description,'FLAG');
                    Attach.SETFILTER(Attach."Attachment Status",'%1',TRUE);
                    IF NOT Attach.FINDFIRST THEN
                    BEGIN
                      Flag:=FALSE;
                      MODIFY;
                    END;
                  END;
                  {ELSE
                  BEGIN
                    Mail_From:='ERP@efftronics.com';
                    Mail_To:='Purchase@efftronics.com,Padmaja@Efftronics.com,anilkumar@efftronics.com,Store@efftronics.com,sundar@efftronics.com';
                    Subject:=' QC Suspected Item ';
                    Fname:='\\erpserver\ErpAttachments\'+FORMAT(Attach."No.")+'.'+Attach."File Extension";
                    Attach.ExportAttachment(Fname);
                    Attachment:=Fname;
                    SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,TRUE);
                    SMTP_MAIL.AddAttachment(Attachment);
                    SMTP_MAIL.Send;
                  END; }
                END;
                */

                if not (SMTP_MAIL.Permission_Checking(UserId, 'IR-QCFLAG'))
                   then
                    Error('You do not rights to change QC Flag');
                // commented by vishnu priya on 22-08-2019 to eliminate the manual rights
                /*
                IF (NOT (USERID IN ['EFFTRONICS\KRISHNAD','EFFTRONICS\VISHNUPRIYA','EFFTRONICS\DINEEL', 'EFFTRONICS\SUJANI'])) THEN
                BEGIN
                  ERROR('You do not rights to change QC Flag');
                END;
                */
                // commented by vishnu priya on 22-08-2019 to eliminate the manual rights

            end;
        }
        field(60107; "Reject/Rework Note No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60108; "Purchase Status"; Option)
        {
            OptionCaption = '" ,Purchase - Pending,Sent to Supplier - Replacement,Sent to Supplier - Servicing,Sent to Supplier - Rework,Sent to Supplier - Debit Note,Scrapped"';
            OptionMembers = " ","Purchase - Pending","Sent to Supplier - Replacement","Sent to Supplier - Servicing","Sent to Supplier - Rework","Sent to Supplier - Debit Note",Scrapped;
            DataClassification = CustomerContent;
        }
        field(60109; "Rework Sent Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "Rework Status"; Option)
        {
            OptionCaption = 'Inprogress,Completed';
            OptionMembers = Inprogress,Completed;
            DataClassification = CustomerContent;
        }
        field(60111; "Expected Recv Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60112; "Received Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60113; "Debit Note No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60114; "MBB Status"; Option)
        {
            OptionCaption = '" ,Normal,Damage"';
            OptionMembers = " ",Normal,Damage;
            DataClassification = CustomerContent;
        }
        field(60115; "HIC 60%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
            DataClassification = CustomerContent;
        }
        field(60116; "HIC 10%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
            DataClassification = CustomerContent;
        }
        field(60117; "HIC 5%"; Option)
        {
            OptionCaption = '" ,Blue,Not Blue,Pink"';
            OptionMembers = " ",Blue,"Not Blue",Pink;
            DataClassification = CustomerContent;
        }
        field(60118; "MBB Packet Open DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "MBB Packet Close DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60120; "Baked Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60121; "MFD Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Packed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60123; "MBB Packed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60129; "Issues For Pending"; Option)
        {
            Description = 'added by vishnu priya';
            OptionCaption = '"  ,TEMC-Part No Variations,TEMC-Vendor/Make Variation,TEMC-Samples,TEMC-Shelf-Life,TEMC-Device Marking,TEMC-Expiry Date,TEMC-MSL Level,TEMC-Datasheets,TEMC-Standardisation,Layouts-Samples,Layouts-Layouts Updation,Mechanical-Samples,Mechanical-Vendor/make Variation,Mechanical-Dimension Variations,Mechanical- Specification/Requirements,Mechanical-Stnadardisation,Indent Person Confirmation,Vendor/Make-Partial Material,Vendor/Make-Replacement,Vendor/Make-Specification,Vendor/Make-Packing,Vendor/Make-Checklist,Vendor/Make-Test Report,Vendor/Make-Rework,Stores-Wrong Inward,Stores-Material Not Available,Benchmark,Test Setup,Non Priority,Manpower,No Issue,Vendor/Make-Quality Problem,Vendor/Make-Functionality,Sys Admin Confirmation,Site - Confirmation,Controlroom - Confirmation,R&D - Confirmation,PCBs - Numbering"';
            OptionMembers = "  ","TEMC-Part No Variations","TEMC-Vendor/Make Variation","TEMC-Samples","TEMC-Shelf-Life","TEMC-Device Marking","TEMC-Expiry Date","TEMC-MSL Level","TEMC-Datasheets","TEMC-Standardisation","Layouts-Samples","Layouts-Layouts Updation","Mechanical-Samples","Mechanical-Vendor/make Variation","Mechanical-Dimension Variations","Mechanical- Specification/Requirements","Mechanical-Stnadardisation","Indent Person Confirmation","Vendor/Make-Partial Material","Vendor/Make-Replacement","Vendor/Make-Specification","Vendor/Make-Packing","Vendor/Make-Checklist","Vendor/Make-Test Report","Vendor/Make-Rework","Stores-Wrong Inward","Stores-Material Not Available",Benchmark,"Test Setup","Non Priority",Manpower,"No Issue","Vendor/Make-Quality Problem","Vendor/Make-Functionality","Sys Admin Confirmation","Site - Confirmation","Controlroom - Confirmation","R&D - Confirmation","PCBs - Numbering";
            DataClassification = CustomerContent;
        }
        field(60130; "Equp Type"; Option)
        {
            Description = 'added by sujani for calibration on 16-feb-19';
            OptionCaption = ',DMM,Tepm.Meter,Lux Meter,Vernier,Screw Guage,Torque Meter,Potting Machine,CHAMBER,Power Meter,Burst-Generator,Surge-Generator,Voltage Interruption Simulator,Weighing Machine,RF Analyzer,Mixer,ESD ,Stacker,Air Compressor,Packing Machine,Clamp Meter,DC SUPPLY,FUNCTION GENERATOR,HV TESTER,IR Tester,LCR METER,MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,Sound Meter,De-Soldering System,Soldering System,Soldering Station,Hot Air Gun,Screw Driver,Hammer Machine,Drilling Machine,Cutting Tool';
            OptionMembers = ,DMM,"Tepm.Meter","Lux Meter",Vernier,"Screw Guage","Torque Meter","Potting Machine",CHAMBER,"Power Meter","Burst-Generator","Surge-Generator","Voltage Interruption Simulator","Weighing Machine","RF Analyzer",Mixer,"ESD ",Stacker,"Air Compressor","Packing Machine","Clamp Meter","DC SUPPLY","FUNCTION GENERATOR","HV TESTER","IR Tester","LCR METER",MYDATA,Oscilloscope,DPM,Rheostat,VARIAC,CVT,Scale,Microscope,"Sound Meter","De-Soldering System","Soldering System","Soldering Station","Hot Air Gun","Screw Driver","Hammer Machine","Drilling Machine","Cutting Tool";
            DataClassification = CustomerContent;
        }
        field(60131; "Equp Desc"; Code[100])
        {
            Description = 'added by sujani for calibration on 16-feb-19';
            DataClassification = CustomerContent;
        }
        field(60132; "Equp Model"; Code[30])
        {
            Description = 'added by sujani for calibration on 16-feb-19';
            DataClassification = CustomerContent;
        }
        field(60133; "Calibration frequency"; DateFormula)
        {
            Description = 'added by sujani for calibration on 16-feb-19';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Calibration Date" <> 0D then
                    "Next calib date" := CalcDate("Calibration frequency", "Calibration Date");
            end;
        }
        field(60134; "Calibration Date"; Date)
        {
            Description = 'added by sujani for calibration on 16-feb-19';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Next calib date" := CalcDate("Calibration frequency", "Calibration Date");
            end;
        }
        field(60135; "Next calib date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60136; "Action Required"; Boolean)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            DataClassification = CustomerContent;
        }
        field(60137; "Action To Be Taken"; Option)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            OptionMembers = " ","BOM Modification","As Per PM instruction Flagged","Capacitor pitch change is mandatory","Design Issue","Dimensional issue","Internal Machine Printing",Obselete,"Item standardization","Need clarity about stock","Need drawing updation","Need to change the Heat sink FIXING Hole Drill Size","Planned to Product Ver change","Powder coating issue (Need to change version if possible)","Redesign Planned","Transistor Failure observed",Other;
            DataClassification = CustomerContent;
        }
        field(60138; "Tentative Clearance Date"; Date)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            DataClassification = CustomerContent;
        }
        field(60139; "Flag Cleared Date"; Date)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            DataClassification = CustomerContent;
        }
        field(60140; "Concerned Dept"; Option)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IoT,TEMC,Layouts,Purchase,QA,STR,Mechanical;
            DataClassification = CustomerContent;
        }
        field(60141; "Action Completed time"; DateTime)
        {
            Description = 'Added by Vishnu Priya for QC FLAG  Purpose';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Vendor No.")
        {
        }
        key(Key4; "Receipt No.", "Item No.")
        {
        }
        key(Key5; "Vendor No.", "Item No.")
        {
        }
        key(Key6; "Item No.", "Vendor No.")
        {
        }
        key(Key7; "Order No.", "Purch Line No", "Qty. Accepted", "Qty. Rejected")
        {
            SumIndexFields = "Qty. Accepted", "Qty. Rejected", "Qty. Accepted Under Deviation", "Qty. Rework";
        }
        key(Key8; "Rework Level")
        {
        }
        key(Key9; "Vendor No.", "Item No.", "Rework Level", Status, "Posting Date")
        {
            SumIndexFields = Quantity, "Qty. Accepted", "Qty. Rejected", "Qty. Accepted Under Deviation", "Qty. Rework";
        }
        key(Key10; "Document Date", "Source Type", "Vendor No.", "Prod. Order No.")
        {
        }
        key(Key11; "IDS creation Date")
        {
        }
        key(Key12; "Parent IDS", Status)
        {
            SumIndexFields = Quantity;
        }
        key(Key13; "Posted Date")
        {
        }
        key(Key14; "Item No.", Status, Flag)
        {
        }
        key(Key15; Flag, "Item No.", "Vendor No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'Total Quantity should not be more than Quantity Received';
        ReasonCode: Record "Reason Code";
        rejection: Record "QC Rejection Master";
        Attach: Record Attachments;
        SMTP_MAIL: Codeunit "Custom Events";
        Body: Text[1024];
        Subject: Text[1000];
        Mail_To: Text[1000];
        Mail_From: Text[1000];
        Attachment: Text[1000];
        Fname: Text[1000];


    procedure ShowItemTrackingLines();
    var
        PurchLine: Record "Purchase Line";
        ProdOrderLine: Record "Prod. Order Line";
        InspectJnlLine: Codeunit "Inspection Jnl.-Post Line";
        PostedInspDataHeader: Record "Posted Inspect DatasheetHeader";
    begin
        //Hot Fix 1.0
        //InspectJnlLine.CallPostedItemTrackingForm(DATABASE::"Purch. Rcpt. Line",0,"Receipt No.",'',0,"Purch Line No",Rec);

        if "Source Type" = "Source Type"::"In Bound" then begin
            if not "Quality Before Receipt" then begin
                //300708 PIDSQC1.0>>
                PostedInspDataHeader.SetRange("No.", "Ids Reference No.");
                PostedInspDataHeader.SetRange("Partial Inspection", false);
                if PostedInspDataHeader.Find('-') then begin //300708 PIDSQC1.0 <<
                    if PostedInspDataHeader."Parent IDS No" <> '' then
                        InspectJnlLine.CallPostedItemTrackingForm2(DATABASE::"Purch. Rcpt. Line", 0, "Receipt No.", '', 0, "Purch Line No", Rec,
                      "Ids Reference No.")
                    //300708 PIDSQC1.0>>
                    else
                        InspectJnlLine.CallPostedItemTrackingForm(DATABASE::"Purch. Rcpt. Line", 0, "Receipt No.", '', 0, "Purch Line No", Rec)
                end;
                //300708 PIDSQC1.0<<
            end else begin
                PurchLine.Get(PurchLine."Document Type"::Order, "Order No.", "Purch Line No");
                PurchLine.OpenItemTrackingLines;
            end;
        end else begin
            TestField("In Process", false);
            ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
            ProdOrderLine.SetRange("Line No.", "Prod. Order Line");
            ProdOrderLine.SetRange("Item No.", "Item No.");
            if ProdOrderLine.Find('-') then
                ProdOrderLine.OpenItemTrackingLines;
        end;

        //Hot Fix 1.0
    end;


    procedure QualityAcceptanceLevels(QualityType: Option Accepted,"Accepted Under Deviation",Rework,Rejected);
    var
        InspectRcptAcptLevels: Record "Inspect. Recpt. Accept Level";
    begin
        InspectRcptAcptLevels.SetRange("Inspection Receipt No.", "No.");
        InspectRcptAcptLevels.SetRange("Quality Type", QualityType);
        PAGE.RunModal(PAGE::"Inspect. Rcpt. Accept Levels", InspectRcptAcptLevels);
        //QCP1.0IF NOT "Item Tracking Exists" THEN BEGIN
        case QualityType of
            QualityType::Accepted:
                begin
                    "Qty. Accepted" := 0;
                    if InspectRcptAcptLevels.Find('-') then
                        repeat
                                "Qty. Accepted" := "Qty. Accepted" + InspectRcptAcptLevels.Quantity;
                        until InspectRcptAcptLevels.Next = 0;
                end;
            QualityType::"Accepted Under Deviation":
                begin
                    "Qty. Accepted Under Deviation" := 0;
                    if InspectRcptAcptLevels.Find('-') then
                        repeat
                                "Qty. Accepted Under Deviation" := "Qty. Accepted Under Deviation" + InspectRcptAcptLevels.Quantity;
                        until InspectRcptAcptLevels.Next = 0;
                end;
            QualityType::Rework:
                begin
                    "Qty. Rework" := 0;
                    if InspectRcptAcptLevels.Find('-') then
                        repeat
                                "Qty. Rework" := "Qty. Rework" + InspectRcptAcptLevels.Quantity;
                        until InspectRcptAcptLevels.Next = 0;
                end;
            QualityType::Rejected:
                begin
                    "Qty. Rejected" := 0;
                    if InspectRcptAcptLevels.Find('-') then
                        repeat
                                "Qty. Rejected" := "Qty. Rejected" + InspectRcptAcptLevels.Quantity;
                        until InspectRcptAcptLevels.Next = 0;
                end;
        end;
        //QCP1.0END;
    end;
}

