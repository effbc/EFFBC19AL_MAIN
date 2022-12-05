tableextension 70012 SalesLineExt extends "Sales Line"
{
    fields
    {

        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                /*  { //commented by pranavi
                                                                       rpoQty := 0;
                       PrdOrder.RESET;
                       PrdOrder.SETFILTER(PrdOrder."Sales Order No.", "Document No.");
                       PrdOrder.SETFILTER(PrdOrder."Sales Order Line No.", '%1', "Line No.");
                       PrdOrder.SETFILTER(PrdOrder."Schedule Line No.", '%1', 0);
                       IF PrdOrder.FINDSET THEN
                           REPEAT
                               rpoQty := rpoQty + PrdOrder.Quantity;
                           UNTIL PrdOrder.NEXT = 0;

                       IF rpoQty > 0 THEN BEGIN

                           IF xRec."No." <> '' THEN BEGIN

                               IF xRec."No." <> "No." THEN
                                   ERROR('Already ' + FORMAT(rpoQty) + ' Production Orders was released for the item ' + xRec."No." + ' in line no: ' + FORMAT("Line No.") + '. Please contact Production Manager for further actions');


                               IF rpoQty > Quantity THEN
                                   ERROR('Already Production Orders was released for the quantity  ' + FORMAT(rpoQty) + ' on line No: ' + FORMAT("Line No.") + '. Present Quantity ' + FORMAT(Quantity) + '. Please contact Production Manager for further actions');
                           END;
                       END;

                                                                       }*/
                /*{SalesHeader.RESET;
                SalesHeader.SETRANGE(SalesHeader."No.","Document No.");
                IF SalesHeader.FINDFIRST THEN
                BEGIN
                   "Bill-to Customer No.":= SalesHeader."Bill-to Customer No.";
                END;
                }*/

            end;

            trigger OnAfterValidate()
            var

            begin
                //B2B-KNR
                SalesHeaderRDSO.SETRANGE("Document Type", "Document Type");
                SalesHeaderRDSO.SETRANGE("No.", "Document No.");
                IF SalesHeaderRDSO.FIND('-') THEN BEGIN
                    //"RDSO Unit Charges" :=
                    "RDSO Charges Paid By" := SalesHeaderRDSO."RDSO Charges Paid By";
                    "RDSO Inspection Required" := SalesHeaderRDSO."RDSO Inspection Required";
                    "RDSO Inspection By" := SalesHeaderRDSO."RDSO Inspection By";

                    ////ANIL13/10/09
                    "Line Amount(LOA)" := "Unitcost(LOA)" * Quantity;
                    // "OutStanding(LOA)":="Unitcost(LOA)"*"Qty. to Invoice (Base)";
                    "OutStanding(LOA)" := "Unitcost(LOA)" * (Quantity - "Quantity Invoiced");
                    SaleDocType := SalesHeaderRDSO.SaleDocType;//EFFUPG1.5
                    ////ANIL13/10/09

                    //"RDSO Charges"
                END;
                //B2B-KNR
            end;
        }


        field(50002; "Packet No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Amount to Customer"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Production BOM No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production BOM Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60002; "Production Bom Version No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Production BOM Version"."Version Code" WHERE("Production BOM No." = FIELD("Production BOM No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60003; "Estimated Unit Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Design Worksheet Header"."Total Cost" WHERE("Document No." = FIELD("Document No."),
                                                                            "Document Type" = CONST(Order),
                                                                            "Document Line No." = FIELD("Line No.")));
            Description = 'B2B';
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60004; "Estimated Total Unit Cost"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60005; "RDSO Unit Charges"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60006; "Prod Start Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //TestStatusOpen;
            end;
        }
        field(60007; "LD Amount"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60008; "RDSO Charges Paid By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By Customer","By Railways";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60009; "RDSO Inspection Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60010; "RDSO Inspection By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By RDSO"," By Consignee";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
            end;
        }
        field(60011; "RDSO Charges"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("RDSO Inspection Required", true);
                TestStatusOpen;
            end;
        }
        field(60012; "Schedule Type"; Enum "Sales Shipment Line Enum3")
        {

            DataClassification = CustomerContent;
        }
        field(60013; "Prod. Order Quantity"; Decimal)
        {
            CalcFormula = Sum("Production Order".Quantity WHERE("Sales Order No." = FIELD("Document No."),
                                                                 "Sales Order Line No." = FIELD("Line No."),
                                                                 "Source No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60014; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60015; "Tender Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60016; "Prod. Qty"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                CalcFields("Prod. Order Quantity");
                if "Prod. Order Quantity" + "Prod. Qty" > Quantity then
                    Error(text112);
            end;
        }
        field(60017; "Prod. Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Item Sub Group Code"; Code[20])
        {
            CalcFormula = Lookup(Item."Item Sub Group Code" WHERE("No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60019; "To Be Shipped Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60020; "Material Reuired Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60021; "Dummy Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60022; "Plan Shifting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60023; "Change to Specified Plan Date"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "CL_CNSGN  rcvd Qty"; Integer)
        {
            Description = 'added  by sujani for renucha mam';
            DataClassification = CustomerContent;
        }
        field(60025; "CL_CNSGN  rcvd Date1"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60090; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60110; "Supply Portion"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Added by Pranavi on 16-Sep-2016
                if "Retention Portion" + "Supply Portion" > 100 then
                    Error('TOTAL SUPPLY+RETENTION Portion should not be > 100 %!');
            end;
        }
        field(60111; "Retention Portion"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Added by Pranavi on 16-Sep-2016
                if "Retention Portion" + "Supply Portion" > 100 then
                    Error('TOTAL SUPPLY+RETENTION Portion should not be > 100 %!');
            end;
        }
        field(60112; "Type of Item"; Option)
        {
            OptionMembers = " ","Only Supply","Supply & Inst","Supply & Laying","Only Inst";
            DataClassification = CustomerContent;
        }
        field(60113; "Schedule No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60114; "Unitcost(LOA)"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                SalesHeader.SetRange("Document Type", "Document Type");
                SalesHeader.SetRange("No.", "Document No.");
                if SalesHeader.Find('-') then begin
                    "Line Amount(LOA)" := "Unitcost(LOA)" * Quantity;
                    "OutStanding(LOA)" := "Unitcost(LOA)" * (Quantity - "Quantity Invoiced");
                end;
                //ANIL13/10/09
                // "OutStanding(LOA)":="Unitcost(LOA)"*(Quantity-"Quantity Invoiced");
            end;
        }
        field(60115; "Line Amount(LOA)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60116; "OutStanding(LOA)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60117; "BOI Status"; Option)
        {
            OptionCaption = '" ,To be Ordered,To be Received,Received,To be Dispatched,Confirmation Pending,Material Supplied,Cancelled"';
            OptionMembers = " ","To be Ordered","To be Received",Received,"To be Dispatched","Confirmation Pending","Material Supplied",Cancelled;
            DataClassification = CustomerContent;
        }
        field(60118; MainCategory; Option)
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            OptionMembers = "  ",Sales,"No Issue","R&D","Need to Specify",CS,MKT,LMD,"Temp-Closed";
            DataClassification = CustomerContent;
        }
        field(60119; SubCategory; Option)
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            OptionMembers = "  ","Yet to Start","Under Inspection","Ready for Inspection","Under Production","Inspection Completed","Ready For Dispatch","BOM Pending","PO Pending","BOI Pending","Docs Pending","RDSO renewal Pending","S/W Pending","Call Letter Pending","Customer side Pending","Material Issue","Site not ready","R&D Pending","Installation Inprogress",Commisioned,"Completion letter taken","Yet to dispatch",Received,"To Be Received","Under Design","Dispatched on DC","Hold by SAL","Hold by MAR";
            DataClassification = CustomerContent;
        }
        field(60120; Reason; Text[100])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60121; Remarks; Text[100])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60122; ProductGroup; Code[20])
        {
            Description = 'added by sujani on 2-11-2018 for analysis purpose';
            TableRelation = "Item Sub Group".Code;
            DataClassification = CustomerContent;
        }
        field(60123; Main_CATEGORY; Option)
        {
            OptionMembers = "  ",Sales,"No Issue","R&D","Need to Specify",CS,MKT;
            DataClassification = CustomerContent;
        }
        field(60124; "Call Letter Status"; Option)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            OptionMembers = " ",Received,Pending,NA,"Cust.Pending";
            DataClassification = CustomerContent;
        }
        field(60125; "RDSO Number"; Code[15])
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60126; Vertical; Option)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IOT,other;
            DataClassification = CustomerContent;
        }
        field(60127; "Deviated Dispatch Date"; DateTime)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60128; "Dispatch Date"; DateTime)
        {
            Description = 'added by sujani on 30-11-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60129; "Call Letter Exp Date"; Date)
        {
            Description = 'added by sujani on 07-12-2018 for pending orders analysis purpose';
            DataClassification = CustomerContent;
        }
        field(60130; "Sell-to Customer Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to Customer Name',
                        ENN = 'Sell-to Customer Name';
            DataClassification = CustomerContent;
        }
        field(60131; "Tentative RDSO Date"; Date)
        {
            Description = 'Added by Vishnu Priya on 14-12-2018';
            DataClassification = CustomerContent;
        }
        field(60132; "Production Confirmed Status"; Boolean)
        {
            Description = 'Added by Vishnu Priya on 26-05-2020 for Sales Process Tracking';
            DataClassification = CustomerContent;
        }
        field(60133; "Dispatch Confirm Date"; Date)
        {
            Description = 'Added by Vishnu Priya on 26-05-2020 for Sales Process Tracking';
            DataClassification = CustomerContent;
        }
        field(60134; "Production Stage"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya on 04-11-2020 for Sales Process Tracking';
            OptionCaption = '" ,Soldering ,Testing,Product Integration,Call letter Registration,Inspection Completed,Final Testing,QA Completed,Offer to QA,IP QA,Ready For Inspection"';
            OptionMembers = " ","Soldering ",Testing,"Product Integration","Call letter Registration","Inspection Completed","Final Testing","QA Completed","Offer to QA","IP QA","Ready For Inspection";
        }
        field(60135; "Product ready Date Committed"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya on 04-11-2020 for Sales Process Tracking';
        }
        field(60136; "Product ready Date (Revised)"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu Priya on 04-11-2020 for Sales Process Tracking';
        }
        field(80000; "VAT Business Posting Group 2"; Code[10])
        {
            TableRelation = "VAT Business Posting Group".Code;
            DataClassification = CustomerContent;
        }
        field(80001; "VAT Product Posting Group 2"; Code[10])
        {
            TableRelation = "VAT Business Posting Group".Code;
            DataClassification = CustomerContent;
        }
        field(80002; "VAT %age 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(80003; "VAT Base 2"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80004; "VAT Amount 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(80005; "Service Tax % 2"; Decimal)
        {
            BlankZero = true;
            Caption = 'Service Tax %';
            DataClassification = CustomerContent;
        }
        field(80006; "Pending By"; Option)
        {
            OptionMembers = " ","R&D",Sales,LMD,Customer,Purchase,CUS;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                // Added by Pranavi on 20-Feb-2016 for the tracking of pending by removed date
                if (xRec."Pending By" in [1, 2, 3, 4, 5, 6]) and ("Pending By" = 0) then
                    "Pending By Removed Date" := Today()
                else
                    "Pending By Removed Date" := 0D;
                // end by pranavi
            end;
        }
        field(80007; "Pending By Removed Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(80008; "Purchase Remarks"; Option)
        {
            OptionCaption = '" ,Sales Configuration Pending,Purchase order placed Mat Exp,Call letters Pending,Purchase Prices under negotiations,Material Received,Material Supplied-Invoice Pending,PO will place before Mfg items Ready,Will supply at site"';
            OptionMembers = " ","Sales Conformation Pending","Purchase order placed Mat Exp","Call letters Pending","Purchase Prices under negotiations","Material Received","Material Supplied-Invoice Pending","PO will place before Mfg items Ready","Will supply at site";
            DataClassification = CustomerContent;
        }
        field(80009; "Planned Dispatch Date"; Date)
        {
            Description = 'Pranavi-for BOI Planning';
            DataClassification = CustomerContent;
        }
        field(95401; "Description1"; Code[200])
        {
            DataClassification = CustomerContent;
        }
        field(95402; "Description 21"; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Transport Method1"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(95404; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }

        field(33000250; "Spec ID"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Sales Line No" = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000252; "Quantity Rework"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Quality Ledger Entry"."Remaining Quantity" WHERE("Order No." = FIELD("Document No."),
                                                                                 "Sales Line No" = FIELD("Line No."),
                                                                                 "Entry Type" = FILTER(Rework)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                TestField(Type, Type::Item);
                if "QC Enabled" then
                    TestField("Spec ID");
                if not "QC Enabled" then
                    if "Quality Before Receipt" then
                        Validate("Quality Before Receipt", false);
            end;
        }
        field(33000254; "Quantity Rejected"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Sales Line No" = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Reject)));
            Description = 'QC1.0';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000255; "Quality Before Receipt"; Boolean)
        {
            Description = 'QC1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestStatusOpen;
                TestField(Type, Type::Item);
                if "Qty. to Ship" <> 0 then
                    FieldError("Qty. to Ship", 'should be 0');
                if "Qty. Sent To Quality" <> 0 then
                    FieldError("Qty. Sent To Quality", 'should be 0');
                "Qty. Sending To Quality" := 0;
                if "Quality Before Receipt" then begin
                    GetQCSetup;
                    QualityCtrlSetup.TestField("Quality Before Receipt", true);
                    TestField("QC Enabled", true);
                end;
            end;
        }
        field(33000256; "Qty. Sending To Quality"; Decimal)
        {
            BlankZero = true;
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000257; "Qty. Sent To Quality"; Decimal)
        {
            BlankZero = true;
            Description = 'QC1.0';
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000258; "Qty. Sending To Quality(R)"; Decimal)
        {
            BlankZero = true;
            Description = 'QC1.0';
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            Description = 'QC1.0';
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
        field(33000260; "Reg/Non reg Product"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'added by durga for expected orders form';
            OptionMembers = " ",Issue,"No-Issue";
        }
        field(33000261; Priority; Option)
        {
            DataClassification = CustomerContent;
            Description = 'added by priyanka on 24-02-2022';
            OptionMembers = " ","1","2","3";
        }
        field(33000262; "M Stage"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'added by priyanka on 02-03-2022';
            OptionMembers = " ",Machine,Man,Method,Material;
        }
        field(33000263; "Non Regular Stages"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'added by priyanka on 03-03-2022';
            OptionMembers = " ","Sample PCB Evaluation","Hardware-Temp BOM","Final BOM","Inst BOM",Firmware,Software,"Production DOC","UPG BOM","Design In-Progress","Design to be Start","BOM Pending";
        }
        field(33000264; "Responsible Dept"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'added by priyanka on 03-03-2022';
            OptionMembers = " ","R&D",DQA,CS,PROD,PUR,SAL,CRROOM,"R&D-PUR",MKT,QA;
        }

        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
        field(50010; "Service Tax Amount Cust"; Integer)
        {
            DataClassification = CustomerContent;
            Description = 'added by durga on 13-09-2022';

        }
        field(50020; "Service Tax Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'added by durga on 13-09-2022';

        }
        //EFFUPG1.5>>
        Field(70055; SaleDocType; Enum SalesDocTypeCust)
        {
            DataClassification = CustomerContent;
        }
        //EFFUPG1.5<<

        Field(70060; "GST Amount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        Field(33000265; "Reviewed/Not"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'added by priyanka on 18-04-2022';

        }
        Field(33000266; "Site Details"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Received,Pending;
            Description = 'added by priyanka on 18-04-2022';

        }

        Field(33000267; "Review Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,"Review Done","Review Inprogress","Review Not Required";
        }

        Field(33000268; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Completed,Pending,Inprogress,"N/A";
        }
        Field(33000269; "Completion Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        Field(33000270; Stages; Option)
        {

            DataClassification = CustomerContent;
            OptionMembers = ,"Design&Schematic","Tentative BOM","Material Exp Date","PCB's Garbers","Procurement PCB Receving Date","H/W Clearence","Final PCB BOM","Sample Housing","Final Housing Clearence","Mechanical BOM","Wiring BOM","Final Product BOM","Installation BOM","Prod Plan Release Date","Test Code","Test Zigs","Final F/W","Prod Ready Date","Dispatch Date","Installation Date";
        }

        Field(33000271; "Reg Stages"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = ,Planned,"Under Procurement","PRD Plan Released Date",UnderProduction,"Registered for Insp","RDSO Inprogress","RDSO Completed","Exp Product Ready Date","Ready For Dispatch","Material Send on DC(Bill Pending)";
        }


        Field(33000272; "Stage Wise Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        Field(33000273; "Date_Confirm"; Boolean)
        {
            DataClassification = ToBeClassified;
        }




    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
        SalesHeader: Record "Sales Header";

    begin

        //B2B-KNR
        SalesHeader.SetRange("Document Type", "Document Type");
        SalesHeader.SetRange("No.", "Document No.");
        if SalesHeader.Find('-') then begin
            //"RDSO Unit Charges" :=
            "RDSO Charges Paid By" := SalesHeader."RDSO Charges Paid By";
            "RDSO Inspection Required" := SalesHeader."RDSO Inspection Required";
            "RDSO Inspection By" := SalesHeader."RDSO Inspection By";
            "Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
            "Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
            SaleDocType := SalesHeader.SaleDocType;
            //"RDSO Charges"
        end;
        "Location Code" := 'PROD';
        //B2B-KNR
        // added by pranavi on 01-sep-2016 for payment terms
        if "Document Type" = "Document Type"::Order then begin
            SalesHeader.Reset;
            SalesHeader.SetRange(SalesHeader."No.", "Document No.");
            if SalesHeader.FindFirst then
                if SalesHeader."Customer Posting Group" in ['PRIVATE', 'OTHERS'] then
                    if Type = Type::Item then begin
                        "Supply Portion" := 100;
                        "Retention Portion" := 0;
                    end else begin
                        "Supply Portion" := 0;
                        "Retention Portion" := 100;
                    end;
        end;
        // end by pranavi

        // Added by Pranavi on 13-Dec-2016

        if ("Document Type" = "Document Type"::Order) and (SaleDocType <> SaleDocType::Amc) then begin
            SalesHeader.Reset;
            SalesHeader.SetRange(SalesHeader."Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SetRange(SalesHeader."No.", "Document No.");
            if SalesHeader.FindFirst then begin
                SO.Reset;
                SO.SetRange(SO."Document Type", SO."Document Type"::Order);
                SO.SetRange(SO."No.", SalesHeader."No.");
                if not SO.FindFirst then begin
                    SO.Init;
                    if CopyStr(SalesHeader."No.", 1, 7) = 'EFF/SAL' then
                        SO."Document Type" := SO."Document Type"::Order
                    else
                        if CopyStr(SalesHeader."No.", 1, 7) = 'EFF/AMC' then
                            SO."Document Type" := SO."Document Type"::"Blanket Order";
                    SO."No." := SalesHeader."No.";
                    SO."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                    SO."Customer OrderNo." := SalesHeader."Customer OrderNo.";
                    SO."Bill-to Name" := SalesHeader."Bill-to Name";
                    SO."Bill-to Customer No." := SalesHeader."Bill-to Customer No.";
                    SO."Customer Posting Group" := SalesHeader."Customer Posting Group";
                    // Pranavi
                    SO."Security Deposit Amount" := SalesHeader."Security Deposit Amount";
                    SO."SD Status" := SalesHeader."SD Status";
                    SO."Sale Order Total Amount" := SalesHeader."Sale Order Total Amount";
                    SO."EMD Amount" := SalesHeader."EMD Amount";
                    SO."Security Deposit Status" := SalesHeader."Security Deposit Status";
                    SO."SD Requested Date" := SalesHeader."SD Requested Date";
                    SO."SD Required Date" := SalesHeader."SD Required Date";
                    SO."Warranty Period" := SalesHeader."Warranty Period";
                    SO.Product := SalesHeader.Product;
                    SO."Security Deposit" := SalesHeader."Security Deposit";
                    // Pranavi
                    SO.Insert;
                end;
            end;

        end;
        // End--Pranavi  

    end;


    trigger OnModify()
    var
        myInt: Integer;
        PrdOrder: Record "Production Order";
        rpoQty: Integer;

    begin




        /*{
        rpoQty:=0;
        PrdOrder.RESET;
        PrdOrder.SETFILTER(PrdOrder."Sales Order No.","Document No.");
        PrdOrder.SETFILTER(PrdOrder."Sales Order Line No.",'%1',"Line No.");
        PrdOrder.SETFILTER(PrdOrder."Schedule Line No.",'%1',0);
        IF PrdOrder.FINDSET THEN
        REPEAT
          rpoQty:=rpoQty+PrdOrder.Quantity;
        UNTIL PrdOrder.NEXT=0;

        IF rpoQty>0 THEN
        BEGIN
          IF xRec."No."<>"No." THEN
            ERROR('Already Production Orders was released for the item '+xRec."No."+' in line no: '+FORMAT("Line No.")+'. Please contact Production Manager for further actions');

          IF rpoQty>Quantity THEN
            ERROR('Already Production Orders was released for the quantity  '+FORMAT(rpoQty)+' on line No: '+FORMAT("Line No.")+'. Please contact Production Manager for further actions');
        END;
         }*/


        GetSalesHeader;
        //  IF(("Prod. Qty"=xRec."Prod. Qty")) THEN
        // SalesHeader.TESTFIELD(SalesHeader.Status,SalesHeader.Status::Open);//anil
        //EFFUPG>>
        /*
        if SalesHeader."Free Supply" then
            TestField("Price Inclusive of Tax", false);
        if "Price Inclusive of Tax" then begin
            SalesHeader.TestField("VAT Exempted", false);
            SalesHeader.TestField("Export or Deemed Export", false);
        end;
        *///EFFUPG<<
        if ("Document Type" = "Document Type"::"Blanket Order") and
           ((Type <> xRec.Type) or ("No." <> xRec."No."))
        then begin
            SalesLine2.Reset;
            SalesLine2.SetCurrentKey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
            SalesLine2.SetRange("Blanket Order No.", "Document No.");
            SalesLine2.SetRange("Blanket Order Line No.", "Line No.");
            if SalesLine2.FindSet then
                repeat
                    SalesLine2.TestField(Type, Type);
                    SalesLine2.TestField("No.", "No.");
                until SalesLine2.Next = 0;
        end;
    end;

    trigger OnAfterModify()
    var
        myInt: Integer;
    begin
        SalesHeader.SetRange("Document Type", "Document Type");
        SalesHeader.SetRange("No.", "Document No.");
        if SalesHeader.Find('-') then begin
            "Line Amount(LOA)" := "Unitcost(LOA)" * Quantity;
            "OutStanding(LOA)" := "Unitcost(LOA)" * (Quantity - "Quantity Invoiced");
        end;
        //ANIL13/10/09
        // "OutStanding(LOA)":="Unitcost(LOA)"*(Quantity-"Quantity Invoiced");
    end;

    trigger OnBeforeDelete()
    var
        DesignworksheetHeader: Record "Design Worksheet Header";
        Schedule: Record Schedule2;
        PrdOrder: Record "Production Order";
        rpoQty: Integer;
    begin
        testOrderVerification('You do not have permision to delete Item when Order Verified');

        rpoQty := 0;
        PrdOrder.Reset;
        PrdOrder.SetFilter(PrdOrder."Sales Order No.", "Document No.");
        PrdOrder.SetFilter(PrdOrder."Sales Order Line No.", '%1', "Line No.");
        PrdOrder.SetFilter(PrdOrder."Schedule Line No.", '%1', 0);
        if PrdOrder.FindSet then
            repeat
                rpoQty := rpoQty + PrdOrder.Quantity;
            until PrdOrder.Next = 0;
        /*{
        IF rpoQty>0 THEN
          ERROR('Already '+FORMAT(rpoQty)+' Production Orders was released on line no : '+FORMAT("Line No.")+'. Please contact Production manager for further actions');
        }*///pranavi



        if not StatusCheckSuspended and (SalesHeader.Status = SalesHeader.Status::Released) and
           (Type in [Type::"G/L Account", Type::"Charge (Item)", Type::Resource])
        then
            Validate(Quantity, 0);
    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        //b2b Cost1.0
        DesignworksheetHeader.Reset;
        DesignworksheetHeader.SetRange("Document No.", "Document No.");
        if "Document Type" = "Document Type"::Quote then
            DesignworksheetHeader.SetRange("Document Type", DesignworksheetHeader."Document Type"::Quote)
        else
            if "Document Type" = "Document Type"::Order then
                DesignworksheetHeader.SetRange("Document Type", DesignworksheetHeader."Document Type"::Order)
            else
                if "Document Type" = "Document Type"::"Blanket Order" then
                    DesignworksheetHeader.SetRange("Document Type", DesignworksheetHeader."Document Type"::"Blanket Order");
        DesignworksheetHeader.SetRange("Document Line No.", "Line No.");
        DesignworksheetHeader.DeleteAll(true);
        //Cost1.0
        //sh1.0
        /*{Schedule.RESET;
Schedule.SETRANGE("Document No.", "Document No.");
IF "Document Type" = "Document Type"::Quote THEN
    Schedule.SETRANGE("Document Type", Schedule."Document Type"::Quote)
ELSE
    IF "Document Type" = "Document Type"::Order THEN
        Schedule.SETRANGE("Document Type", Schedule."Document Type"::Order)
    ELSE
        IF "Document Type" = "Document Type"::"Blanket Order" THEN
            Schedule.SETRANGE("Document Type", Schedule."Document Type"::"Blanket Order");
Schedule.SETRANGE("Document Line No.", "Line No.");
Schedule.DELETEALL(TRUE);} */// commente dbny sujani in order to carry fwd the schedule if customer is changed

        //sh1.0
    end;


    PROCEDURE GetQCSetup();
    BEGIN
        if not QCSetupRead then
            QualityCtrlSetup.Get;
        QCSetupRead := true;
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetRange("Order No.", "Document No.");
        InspectDataSheet.SetRange("Sales Line No", "Line No.");
        InspectDataSheet.SetRange("Source Type", InspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetRange("Order No.", "Document No.");
        PostInspectDataSheet.SetRange("Sales Line No", "Line No.");
        PostInspectDataSheet.SetRange("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Document No.");
        InspectionReceipt.SetRange("Sales Line No", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Document No.");
        InspectionReceipt.SetRange("Sales Line No", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE CreateInspectionDataSheets();
    VAR
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        SalesHeader: Record "Sales Header";
    BEGIN
        SalesHeader.Get(SalesHeader."Document Type"::"Credit Memo", "Document No.");
        SalesHeader.TestField(Status, SalesHeader.Status::Released);
        TestField("Quality Before Receipt", true);
        TestField("Qty. Sending To Quality");

        /*{
              WhseRcptLine.SETRANGE("Source Type",39);
              WhseRcptLine.SETRANGE("Source Subtype",1);
              WhseRcptLine.SETRANGE("Source Document",WhseRcptLine."Source Document" :: "Purchase Order");
              WhseRcptLine.SETRANGE("Source No.","Document No.");
              WhseRcptLine.SETRANGE("Source Line No.","Line No.");
              IF WhseRcptLine.FIND('-') THEN
                ERROR('You can not create Inspection Data Sheets when Warehouse Receipt lines exists');
              }*/
        InspectDataSheets.CreateSalesCrMemoIDS1(SalesHeader, Rec);
    END;


    PROCEDURE CancelInspection(VAR QualityStatus: Text[50]);
    VAR
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        QILE: Record "Quality Item Ledger Entry";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
    BEGIN
        if "Quality Before Receipt" = true then begin
            IDS.SetRange("Sales Order No.", "Document No.");
            IDS.SetRange("Sales Line No", "Line No.");
            if not IDS.Find('-') then
                Error('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
            else begin
                PIDS.TransferFields(IDS);
                PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                PIDS.Insert;
                IDS.Delete;
                IDSL.SetRange("Document No.", IDS."No.");
                if IDSL.Find('-') then begin
                    repeat
                        PIDSL.TransferFields(IDSL);
                        PIDSL.Insert;
                    until IDSL.Next = 0;
                    IDSL.DeleteAll;
                end;
                if QualityStatus = 'Cancel' then begin
                    //"Quality Status" := "Quality Status" :: Cancel;
                    "Quality Before Receipt" := false;
                    "Qty. Sending To Quality" := 0;
                    "Qty. Sent To Quality" := 0;
                    Modify;
                end;
            end;
        end else begin
            IDS.SetRange("Sales Order No.", "Document No.");
            IDS.SetRange("Sales Line No", "Line No.");
            if not IDS.Find('-') then
                Error('You Can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
            else begin
                PIDS.TransferFields(IDS);
                PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                PIDS.Insert;
                IDS.Delete;
                IDSL.SetRange("Document No.", IDS."No.");
                if IDSL.Find('-') then begin
                    repeat
                        PIDSL.TransferFields(IDSL);
                        PIDSL.Insert;
                    until IDSL.Next = 0;
                    IDSL.DeleteAll;
                end;
                QILE.SetRange("Document No.", IDS."Receipt No.");
                if QILE.Find('-') then
                    QILE.Delete;
                if QualityStatus = 'Cancel' then begin
                    //"Quality Status" := "Quality Status" :: Cancel;
                    "Qty. Sending To Quality" := 0;
                    "Qty. Sent To Quality" := 0;
                    Modify;
                end;
            end;
        end;
    END;


    PROCEDURE CloseInspection(VAR QualityStatus: Text[50]);
    VAR
        IR: Record "Inspection Receipt Header";
        IRL: Record "Inspection Receipt Line";
        QILE: Record "Quality Item Ledger Entry";
    BEGIN
        IR.SetRange(IR."Sales Order No.", "Document No.");
        IR.SetRange(IR."Sales Line No", "Line No.");
        IR.SetFilter(Status, 'NO');
        if not IR.Find('-') then
            Error('Inspection Receipt not find')
        else begin
            IR.Status := true;
            IR."Quality Status" := IR."Quality Status"::Close;
            IR.Modify;
        end;
        QILE.SetRange("Document No.", IR."Receipt No.");
        if QILE.Find('-') then
            QILE.Delete;
        if QualityStatus = 'Cancel' then begin
            //"Quality Status" := "Quality Status" :: "Short Close";
            "Qty. Sending To Quality" := 0;
            "Qty. Sent To Quality" := 0;
            Modify;
        end;
    END;


    PROCEDURE testOrderVerification(ERROR_MSG: Text);
    BEGIN
        //>>UPG1.3 19Feb2019
        if SkipOrderVerification then
            exit;
        //<<UPG1.3 19Feb2019
        GetSalesHeader;
        /* {IF NOT (COPYSTR(SalesHeader."No.", 14, 2) IN ['/L', '/T']) THEN BEGIN}
             if SalesHeader."Order Verified" = true then
             begin
                 Error(ERROR_MSG);
             end;
         //END;*/
    END;

    /* 
    //EFFUPG>>
        PROCEDURE UpdateUnitPriceBasedOnMRP(SalesHeader: Record "Sales Header");
        VAR
            Itm: Record Item;
            ExcAmt: Decimal;
            MDP: Decimal;
            ExcPostingSetup: Record "Excise Posting Setup";
            SL: Record "Sales Line";
            TaxDetails: Record "Tax Detail";
            Discnt_Perntg: Decimal;
        BEGIN
            // Added by Pranavi on 18-Oct-2016 for Unit Price update based on MRP Price
            if CopyStr(SalesHeader."No.", 14, 2) in ['/L', '/T'] then begin
                ExcAmt := 0;
                MDP := 0;
                SL.Reset;
                SL.SetRange(SL."Document No.", SalesHeader."No.");
                SL.SetFilter(SL."No.", '<>%1', '');
                SL.SetRange(SL.Type, SL.Type::Item);
                SL.SetFilter(SL.Quantity, '>%1', 0);
                if SL.FindSet then
                        repeat
                            ExcAmt := 0;
                            MDP := 0;
                            Discnt_Perntg := 0;
                            Discnt_Perntg := (100 - SL."Line Discount %") / 100;
                            if SL.MRP then begin
                                ExcPostingSetup.Reset;
                                ExcPostingSetup.SetCurrentKey("Excise Bus. Posting Group", "Excise Prod. Posting Group", "From Date", SSI);
                                ExcPostingSetup.SetRange(ExcPostingSetup."Excise Bus. Posting Group", SL."Excise Bus. Posting Group");
                                ExcPostingSetup.SetRange(ExcPostingSetup."Excise Prod. Posting Group", SL."Excise Prod. Posting Group");
                                ExcPostingSetup.SetFilter(ExcPostingSetup."From Date", '<=%1', Today());
                                if ExcPostingSetup.FindLast then
                                    ExcPostingSetup.ExcAmt := (SL."MRP Price" * (100 - SL."Abatement %") / 100) * ExcPostingSetup."BED %" / 100
                                else
                                    ExcAmt := (SL."MRP Price" * (100 - SL."Abatement %") / 100) * 12.5 / 100;
                                MDP := SL."MRP Price" * Discnt_Perntg;
                                TaxDetails.Reset;
                                TaxDetails.SetRange(TaxDetails."Tax Group Code", SL."Tax Group Code");
                                if TaxDetails.FindFirst then
                                    SL."Unit Price" := Round((((SL."MRP Price" * Discnt_Perntg) / (1 + TaxDetails."Tax Below Maximum" / 100)) - ExcAmt) / Discnt_Perntg);
                                SL.Validate("Unit Price");
                                SL.Modify;
                                // MESSAGE(FORMAT(SL."No.")+';MRP: '+FORMAT(SL."MRP Price")+'MDP: '+FORMAT(MDP)+'Discnt: '+FORMAT(Discnt_Perntg)+'Tax Before Val:'+FORMAT((SL."MRP Price"*Discnt_Perntg)/(1+TaxDetails."Tax Below Maximum"/100))+'-Ex: '+
                                // FORMAT((((SL."MRP Price"*Discnt_Perntg)/(1+TaxDetails."Tax Below Maximum"/100))-ExcAmt))+'final up: '+FORMAT(ROUND((((SL."MRP Price"*Discnt_Perntg)/(1+TaxDetails."Tax Below Maximum"/100))-ExcAmt)/Discnt_Perntg)));
                            end;
                        until SL.Next = 0;
                Commit;
            end;
            // End by Pranavi
        END;
        */
    //EFFUPG<<

    PROCEDURE SetSkipOrderVerification();
    BEGIN
        //UPG1.3 19Feb2019 //New function
        SkipOrderVerification := true;
    END;


    var
        SalesHeader: Record "Sales Header";
        ProductionBOMHeader: Record "Production BOM Header";
        VersionMgt: Codeunit 99000756;
        SalesHeaderRDSO: Record "Sales Header";
        PrdOrder: Record "Production Order";
        rpoQty: Integer;
        uom: Record "Item Unit of Measure";
        "--Qc--": Integer;
        QualityCtrlSetup: Record "Quality Control Setup";
        QCSetupRead: Boolean;
        text112: Label 'You can''t create more porduction order''s than Qty';
        Schedule: Record Schedule2;
        SO: Record "Sales Invoice-Dummy";
        SkipOrderVerification: Boolean;
        SalesLine2: Record "Sales Line";
        DesignworksheetHeader: Record "Design Worksheet Header";
}

