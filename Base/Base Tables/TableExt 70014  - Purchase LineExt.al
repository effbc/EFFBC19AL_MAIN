tableextension 70014 PurchaselineExt extends "Purchase Line"
{

    fields
    {




        modify("Buy-from Vendor No.")
        {
            CaptionML = ENU = 'Vendor No.', ENN = 'Vendor No.';
        }
        modify("Document No.")
        {
            CaptionML = ENU = 'Purchase Order No.', ENN = 'Purchase Order No.';
        }


        field(60000; "Amount To Vendor"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Indent No."; Code[20])
        {
            Description = 'B2B';
            Editable = true;
            TableRelation = IF (Type = FILTER(<> " ")) "Indent Line" WHERE("Indent Status" = FILTER(Indent | Enquiry | Offer | Order));
            DataClassification = CustomerContent;
        }
        field(60002; "Indent Line No."; Integer)
        {
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60003; Remarks; Text[80])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "ICN No."; Code[20])
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
        field(60005; "Document Date"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Order Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60006; "Deviated Receipt Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if not (UpperCase(UserId) in ['EFFTRONICS\PADMASRI', 'EFFTRONICS\CHOWDARY', 'EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\PARDHU', 'SUPER', 'EFFTRONICS\ANANDA', 'EFFTRONICS\PKOTESWARARAO', 'EFFTRONICS\GRAVI',
                                               'EFFTRONICS\RENUKACH', 'EFFTRONICS\RAVIKIRAN', 'EFFTRONICS\ANVESH', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\NSUDHEER', 'EFFTRONICS\RATNA',
                                               'EFFTRONICS\19TE308', 'EFFTRONICS\LAKSHMIKANTH', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\SUVARCHALADEVI']) then
                    Error('YOU DONT HAVE SUFFICIENT RIGHTS');
            end;
        }
        field(60010; Period; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60011; "Vendor Name"; Text[100])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Buy-from Vendor No.")));
            FieldClass = FlowField;
        }
        field(60012; "Deviated By"; Option)
        {
            OptionMembers = Vendor,Organisation;
            DataClassification = CustomerContent;
        }
        field(60013; Sample; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60014; Make; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60015; "Account No."; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60016; "Purchase Orders"; Integer)
        {
            CalcFormula = Count("Purchase Line" WHERE(Type = CONST(Item),
                                                       "No." = FILTER(<> ''),
                                                       "No." = FIELD("No."),
                                                       "Document Type" = CONST(Order)));
            FieldClass = FlowField;
        }
        field(60017; "Customs Duty Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60018; "Customs Duty Paid to"; Code[10])
        {
            TableRelation = Vendor WHERE(Blocked = CONST(" "));
            DataClassification = CustomerContent;
        }
        field(60019; "Customs To be Paid on"; Date)
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
        field(60093; "AMC Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60094; "Frieght Charges"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //B2BUPG >>  
                /* STRUCTURE_ORDER_DETAILS.SetRange(STRUCTURE_ORDER_DETAILS."Document No.", "Document No.");
                STRUCTURE_ORDER_DETAILS.SetRange(STRUCTURE_ORDER_DETAILS."Tax/Charge Group", 'FREIGHT');
                STRUCTURE_ORDER_DETAILS.SetFilter(STRUCTURE_ORDER_DETAILS."Calculation Value", '>%1', 0);
                if STRUCTURE_ORDER_DETAILS.FindFirst then
                    Error(' PLEASE REMOVE THE FRIEGHT CHARGES IN STRUTURE DETAILS'); */
                //B2BUPG <<
            end;
        }
        field(60095; "Purchase_Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60096; "No. Of Deviations"; Integer)
        {
            CalcFormula = Count("Excepted Rcpt.Date Tracking" WHERE("Document Type" = FIELD("Document Type"),
                                                                     "Document No." = FIELD("Document No."),
                                                                     "Document Line No." = FIELD("Line No.")));
            FieldClass = FlowField;
        }
        field(60097; "Taxes Value"; Decimal)
        {
            //B2BUPG>>
            /*  FieldClass = FlowField;
             CalcFormula = Sum("Structure Order Line Details"."Amount (LCY)" WHERE(Type = CONST(Purchase),
                                                                                    "Document Type" = CONST(Order),
                                                                                    "Document No." = FIELD("Document No."),
                                                                                    "Line No." = FIELD("Line No.")));
  */
            //B2BUPG<<
        }
        field(60099; "Material Received at Site"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70000; "VAT %age 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(70001; "VAT Base 2"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70002; "VAT Amount 2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(70003; "Vendor Commitment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(70004; Package; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(70005; "Part Number"; Code[40])
        {
            DataClassification = CustomerContent;
            Description = 'modified by durga from 30to 40';
        }
        field(70006; MailSent; Date)
        {
            DataClassification = CustomerContent;
        }
        field(70007; "Courier Agency"; Option)
        {
            OptionMembers = " ",DHL,DTDC,FEDEX,UPS,TNT,"GATI-KWE",VRL,Komitla,BlueDart,"First-Flight",SreeMarutiCourier,Trackon,Sindu,SafExpress,Kesineni,SRMT,SriNandan,MoringStar,Kaveri,Spoton,TCIXPS,Tirupati,Jabbar,SreeKaleswari,ByVehicle,"Professional-Couriers",PatelRoadWays;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin

                "Courier Agency Name" := Format("Courier Agency");  // Added by Pranavi on 23-may-2016
            end;
        }
        field(70008; "Docket No"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Docket No" = '' then begin
                    "Tracking Status Last Updated" := 0DT;
                    "Tracking Status" := '';
                    "Tracking URL" := '';
                    "Courier Dispatch Started On" := '';
                end;
            end;
        }
        field(70009; "Tracking Status"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(70010; "Tracking Status Last Updated"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(70011; "Tracking URL"; Text[250])
        {
            ExtendedDatatype = URL;
            DataClassification = CustomerContent;
        }
        field(70012; "Courier Agency Name"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(70013; "Courier Dispatch Started On"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(70014; "PCB Mode"; Option)
        {
            OptionCaption = 'Normal,Fast,Super Fast';
            OptionMembers = Normal,Fast,"Super Fast";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //PCB_Cost_Calc;
            end;
        }
        field(70015; Itemremarks; Option)
        {
            OptionCaption = ', ,Sampling for NewVendor,Onhold as Stock Available';
            OptionMembers = ," ","Sampling for NewVendor","Onhold as Stock Available";
            DataClassification = CustomerContent;
        }
        field(70016; "Stock At Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                QualityItemLedgEntry: Record "Quality Item Ledger Entry";
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(70017; "Stock At CS Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('CS STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                QualityItemLedgEntry: Record "Quality Item Ledger Entry";
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'CS STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(70018; "Stock At RD Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('R&D STR')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                QualityItemLedgEntry: Record "Quality Item Ledger Entry";
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'R&D STR');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(70019; "Stock At MCH Stores"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No."),
                                                                              Open = CONST(true),
                                                                              "Remaining Quantity" = FILTER(> 0),
                                                                              "Location Code" = CONST('MCH')));
            Editable = false;
            FieldClass = FlowField;

            trigger OnLookup();
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                QualityItemLedgEntry: Record "Quality Item Ledger Entry";
            begin
                ItemLedgEntry.Reset;
                ItemLedgEntry.SetCurrentKey("Item No.", "Variant Code", Open, Positive, "Location Code", "Posting Date",
                "Expiration Date", "Lot No.", "Serial No.");

                ItemLedgEntry.SetRange("Item No.", "No.");
                ItemLedgEntry.SetRange(Open, true);
                ItemLedgEntry.SetRange("Location Code", 'MCH');
                ItemLedgEntry.SetFilter(ItemLedgEntry."Remaining Quantity", '>%1', 0);
                if ItemLedgEntry.FindSet then
                    repeat
                        if not (QualityItemLedgEntry.Get(ItemLedgEntry."Entry No.")) then
                            ItemLedgEntry.Mark(true);
                    until ItemLedgEntry.Next = 0;
                ItemLedgEntry.MarkedOnly;
                PAGE.RunModal(0, ItemLedgEntry);
            end;
        }
        field(70020; "Vendor Mat. Dispatch Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                Vendor: Record Vendor;
            begin
                // Added by Pranavi on 07-Mar-2017 For updating Vendor Mat.Disp Date
                if "Mat. Dispatched" then
                    Error('You cannot change the Vendor Mat. Dispatch date when material is dispatched!');

                if "Vendor Mat. Dispatch Date" <> 0D then begin
                    if Vendor.Get("Buy-from Vendor No.") then begin
                        "Deviated Receipt Date" := CalcDate('+' + Format(Vendor."Transportation Days") + 'D', "Vendor Mat. Dispatch Date");
                    end else
                        "Deviated Receipt Date" := "Vendor Mat. Dispatch Date";
                end;
                //<<Added by Pranavi on 07-Mar-2017 For updating Vendor Mat. Disp Date
            end;
        }
        field(70021; "Mat. Dispatched"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70022; "Order Confimed"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (not (UserId in ['EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\RENUKACH'])) and (xRec."Order Confimed" = true) then begin
                    Error('You do not have rights to change status for already confirmed item');
                end;
            end;
        }
        field(70023; "Scheduled Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (not (UserId in ['EFFTRONICS\VIJAYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\RENUKACH'])) and (xRec."Scheduled Date" <> 0D) then begin
                    Error('You do not have rights to change Scheduled Date for already confirmed item');
                end;
            end;
        }
        field(70024; Earliest_Mat_Req_Date; Date)
        {
            DataClassification = CustomerContent;
        }
        field(70025; "Requested Rcpt Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(70026; gst_group_code_reverse_charge; Boolean)
        {
            CalcFormula = Lookup("GST Group"."Reverse Charge" WHERE(Code = FIELD("GST Group Code")));
            FieldClass = FlowField;
        }

        field(33000250; "Spec ID"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000252; "Quantity Rework"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry"."Remaining Quantity" WHERE("Order No." = FIELD("Document No."),
                                                                                 "Order Line No." = FIELD("Line No."),
                                                                                 "Entry Type" = FILTER(Rework),
                                                                                 Open = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
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
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Order No." = FIELD("Document No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Reject)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000255; "Quality Before Receipt"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                QualityCtrlSetup: Record "Quality Control Setup";
            begin
                TestStatusOpen;
                TestField(Type, Type::Item);
                if "Quantity Received" <> 0 then
                    FieldError("Quantity Received", 'should be 0');
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
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000257; "Qty. Sent To Quality"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000258; "Qty. Sending To Quality(R)"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
        field(33000260; "Sample Lot Inspection"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50054; "Product Group Code Cust"; Code[20])
        {

            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }
        field(50064; "Production Plan Date Filter"; Date)
        {

            Caption = 'Production Plan Date Filter';

            FieldClass = FlowFilter;
        }



        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
                IRH: Record "Inspection Receipt Header";
            begin
                // ----------------------- Old Code ------------------------- Commented by Vishnu Priya on 30-06-2020

                /*{IF "No." <> '' THEN BEGIN
                      IRH.RESET;
                      IRH.SETFILTER(IRH.Flag, '%1', TRUE);
                      IRH.SETFILTER(IRH."Item No.", "No.");
                      IRH.SETFILTER(IRH.Status, '%1', TRUE);
                      IF IRH.FINDFIRST THEN BEGIN
                          ERROR('Please Clear Rejection Flag From QC Department for Item No: %1', "No.");
                      END;
                  END;
                   }*/   // ----------------------- Old Code ----------------------------Commented by Vishnu Priya on 30-06-2020

                // ----------------------- New Code -------------------------Written By Vishnu Priya on 30-06-2020
                if "No." <> '' then begin
                    IRH.Reset;
                    IRH.SetCurrentKey(Flag, "Item No.", "Vendor No.");
                    IRH.SetFilter(Flag, '%1', true);
                    IRH.SetFilter("Item No.", "No.");
                    IRH.SetFilter("Vendor No.", "Buy-from Vendor No.");
                    IRH.SetFilter(Status, '%1', true);
                    if IRH.FindFirst then Error('QC Flag defined for this Item - ' + "No." + ' to Purchase from the ' + Rec."Buy-from Vendor No." + ' Vendor!');
                end;
                // ----------------------- New Code -------------------------Written By Vishnu Priya on 30-06-2020
            end;
        }
        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95402; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Description1"; Text[100])
        {
            DataClassification = CustomerContent;
        }


        field(99000760; "Qty on Prod order Components"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Component"."Remaining Qty. (Base)" WHERE(Status = FILTER(Planned .. Released),
                                                                                                                          "Item No." = FIELD("No."),
                                                                                                                          "Production Plan Date" = FILTER('>06/08/19')));
            Description = 'added by vishnu for to be received purchase items';
            Editable = false;
        }
        field(99000761; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(99000762; Quote; Code[10])
        {
            TableRelation = "Purchase Price" WHERE("Item No." = FIELD("No."));
            Description = 'Added by durga for Quotations';
        }





    }
    trigger OnBeforeModify()
    var
        myInt: Integer;
        PurchLine2: Record "Purchase Line";
    begin
        //Cashflow_Modification; comentted by vijaya on 02-07-2018 for need to editable for item to be recieved status
        if ("Document Type" = "Document Type"::"Blanket Order") and
           ((Type <> xRec.Type) or ("No." <> xRec."No."))
        then begin
            PurchLine2.Reset;
            PurchLine2.SetCurrentKey("Document Type", "Blanket Order No.", "Blanket Order Line No.");
            PurchLine2.SetRange("Blanket Order No.", "Document No.");
            PurchLine2.SetRange("Blanket Order Line No.", "Line No.");
            if PurchLine2.FindSet then
                repeat
                    PurchLine2.TestField(Type, Type);
                    PurchLine2.TestField("No.", "No.");
                until PurchLine2.Next = 0;
        end;
    end;

    trigger OnBeforeDelete()
    var
        myInt: Integer;
        //DefermentBuffer: Record "Deferment Buffer";
        //DetailTaxEntryBuffer: Record "Detailed Tax Entry Buffer";
        PurchHeader: Record "Purchase Header";
        IndentLine: Record "Indent Line";

    begin
        // added by vishnu Priya on 31-10-2020
        if Rec."Quantity Received" > 0 then
            Error('Inwards done for this line. So you can''t delete this');

        // added by vishnu Priya on 31-10-2020
        Cashflow_Modification;
        if not StatusCheckSuspended and (PurchHeader.Status = PurchHeader.Status::Released) and
           (Type in [Type::"G/L Account", Type::"Charge (Item)"])
        then
            Validate(Quantity, 0);
        //EFFUPG1.10>>
        IF "Document Type" = "Document Type"::Order THEN BEGIN
            IF Type = Type::Item THEN BEGIN
                IF ("ICN No." <> '') AND ("No." <> '') THEN BEGIN
                    IndentLine.SETRANGE(IndentLine."ICN No.", "ICN No.");
                    IndentLine.SETRANGE(IndentLine."No.", "No.");
                    IndentLine.SETRANGE(IndentLine."Delivery Location", "Location Code");
                    IndentLine.SETRANGE(IndentLine."Indent Status", IndentLine."Indent Status"::Order);
                    IF IndentLine.FINDFIRST THEN
                        REPEAT
                            IndentLine."Indent Status" := IndentLine."Indent Status"::Indent;
                            IndentLine."Order Mail" := FALSE;
                            IndentLine.MODIFY;
                        UNTIL IndentLine.NEXT = 0;
                END;
            END ELSE BEGIN
                IF ("Indent No." <> '') AND ("Indent Line No." > 0) THEN BEGIN
                    IndentLine.RESET;
                    IndentLine.SETRANGE(IndentLine."Document No.", "Indent No.");
                    IndentLine.SETRANGE(IndentLine."Line No.", "Indent Line No.");
                    IF IndentLine.FINDFIRST THEN BEGIN
                        IndentLine."Indent Status" := IndentLine."Indent Status"::Indent;
                        IndentLine.MODIFY;
                    END;
                END;
            END;
        END;

        //EFFUPG1.10<<


    end;





    PROCEDURE UpdateQualityPurchLines();
    VAR
        SpecHeader: Record "Specification Header";
        ActiveVersionCode: Code[20];
        Item: Record Item;
    BEGIN
        "Spec ID" := VendorQualityApprovalSpecId;
        //Hot Fix 1.0
        if "Spec ID" = '' then begin
            "Spec ID" := Item."Spec ID";
            if "Spec ID" <> '' then
                "Spec Version" := SpecHeader.GetSpecVersion("Spec ID", WorkDate, true);
        end;
        //Hot Fix 1.0

        "QC Enabled" := Item."QC Enabled";
        GetQCSetup;
        if (QualityCtrlSetup."Quality Before Receipt") and (Item."QC Enabled") then
            "Quality Before Receipt" := true;
    END;


    PROCEDURE CreateInspectionDataSheets();
    VAR
        InspectDataSheets: Codeunit "Inspection Data Sheets";
        PurchHeader: Record "Purchase Header";
        WhseRcptLine: Record "Warehouse Receipt Line";
    BEGIN
        PurchHeader.Get(PurchHeader."Document Type"::Order, "Document No.");
        PurchHeader.TestField(Status, PurchHeader.Status::Released);
        TestField("Quality Before Receipt", true);
        TestField("Qty. Sending To Quality");

        WhseRcptLine.SetRange("Source Type", 39);
        WhseRcptLine.SetRange("Source Subtype", 1);
        WhseRcptLine.SetRange("Source Document", WhseRcptLine."Source Document"::"Purchase Order");
        WhseRcptLine.SetRange("Source No.", "Document No.");
        WhseRcptLine.SetRange("Source Line No.", "Line No.");
        if WhseRcptLine.Find('-') then
            Error('You can not create Inspection Data Sheets when Warehouse Receipt lines exists');

        InspectDataSheets.CreatePurLineInspectDataSheet(PurchHeader, Rec);
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetRange("Order No.", "Document No.");
        InspectDataSheet.SetRange("Purch Line No", "Line No.");
        InspectDataSheet.SetRange("Source Type", InspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetRange("Order No.", "Document No.");
        PostInspectDataSheet.SetRange("Purch Line No", "Line No.");
        PostInspectDataSheet.SetRange("Source Type", PostInspectDataSheet."Source Type"::"In Bound");
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Document No.");
        InspectionReceipt.SetRange("Purch Line No", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Order No.", "Document No.");
        InspectionReceipt.SetRange("Purch Line No", "Line No.");
        InspectionReceipt.SetRange("Source Type", InspectionReceipt."Source Type"::"In Bound");
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE GetQCSetup();
    BEGIN
        if not QCSetupRead then
            QualityCtrlSetup.Get;
        QCSetupRead := true;
    END;


    PROCEDURE VendorQualityApprovalSpecId(): Code[20];
    VAR
        VendorItemQA: Record "Vendor Item Quality Approval";
        PurchHeader: Record "Purchase Header";
        PostingDate: Date;
    BEGIN
        VendorItemQA.SetRange("Vendor No.", "Buy-from Vendor No.");
        VendorItemQA.SetRange("Item No.", "No.");
        if VendorItemQA.Find('-') then begin
            PurchHeader.Get(PurchHeader."Document Type"::Order, "Document No.");
            PostingDate := PurchHeader."Posting Date";
            repeat
                if (PostingDate > VendorItemQA."Starting Date") and (PostingDate < VendorItemQA."Ending Date") then
                    exit(VendorItemQA."Spec Id");
            until VendorItemQA.Next = 0;
        end;
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
            IDS.SetRange("Order No.", "Document No.");
            IDS.SetRange("Purch Line No", "Line No.");
            if not IDS.FindFirst then
                Error('You can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
            else begin
                PIDS.TransferFields(IDS);
                PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                PIDS.Insert;
                IDS.Delete;
                IDSL.SetRange("Document No.", IDS."No.");
                if IDSL.FindFirst then begin
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
            IDS.SetRange("Order No.", "Document No.");
            IDS.SetRange("Purch Line No", "Line No.");
            if not IDS.FindFirst then
                Error('You Can not Cancel the Quality Bcoz the IDS is Alreadey Posted')
            else begin
                PIDS.TransferFields(IDS);
                PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                PIDS.Insert;
                IDS.Delete;
                IDSL.SetRange("Document No.", IDS."No.");
                if IDSL.FindFirst then begin
                    repeat
                        PIDSL.TransferFields(IDSL);
                        PIDSL.Insert;
                    until IDSL.Next = 0;
                    IDSL.DeleteAll;
                end;
                QILE.SetRange("Document No.", IDS."Receipt No.");
                if QILE.FindFirst then
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
        IR.SetRange("Order No.", "Document No.");
        IR.SetRange("Purch Line No", "Line No.");
        IR.SetFilter(Status, 'NO');
        if not IR.FindFirst then
            Error('Inspection Receipt not find')
        else begin
            IR.Status := true;
            IR."Quality Status" := IR."Quality Status"::Close;
            IR.Modify;
        end;
        QILE.SetRange("Document No.", IR."Receipt No.");
        if QILE.FindFirst then
            QILE.Delete;
        if QualityStatus = 'Cancel' then begin
            //"Quality Status" := "Quality Status" :: "Short Close";
            "Qty. Sending To Quality" := 0;
            "Qty. Sent To Quality" := 0;
            Modify;
        end;
    END;

    PROCEDURE QCOverride();
    BEGIN
        if UserId = 'SUPER' then
            if "QC Enabled" = true then begin
                "QC Enabled" := false;
                Modify;
            end
            else
                Message('You Do not have permissions to run this functions');
    END;


    PROCEDURE Cashflow_Modification();
    var
        GLSetup: Record "General Ledger Setup";

    BEGIN

        GLSetup.Get;
        if GLSetup."Active ERP-CF Connection" then begin
            /*if IsClear(SQLConnection) then
                Create(SQLConnection, false, true); //Rev01

            if IsClear(RecordSet) then
                Create(RecordSet, false, true); //Rev01*/

            WebRecStatus := Quotes + Text50001 + Quotes;
            OldWebStatus := Quotes + Text50002 + Quotes;
            //>> ORACLE UPG
            /*
                        SQLConnection.ConnectionString := GLSetup."Sql Connection String";
                        SQLConnection.Open;

                        SQLQuery := 'select orderno from PURCHASE_ORDER_STATUS where orderno=''' + "Document No." + ''' and ORDER_LINE_NO=''' + Format("Line No.")
                        +
                                  ''' and (authorisation=1 or status=''Y'')';
                        //anil   MESSAGE(SQLQuery);
                        RecordSet := SQLConnection.Execute(SQLQuery);
                        if not (RecordSet.EOF or RecordSet.BOF) then begin
                            SQLConnection.Close;
                            if not (UserId in ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS']) then
                                Error('PAYMENT COMPLETED, SO YOU MUST NOT CHANGE VALUE RELATED FIELDS');

                        end else
                            SQLConnection.Close;
                            */
            //<< ORACLE UPG
        end;
    END;

    PROCEDURE StructureBaseValue(Purchase_Order: Code[20]; Calculation_Order: Integer; Standard_Packing: Decimal) "Base value": Decimal;
    VAR
        Order_Value: Decimal;
        // StrOrderDetails: Record "Structure Order Line Details";
        GLSetup: Record "General Ledger Setup";
        PurchLine2: Record "Purchase Line";
    //  StrOrderDetails: Record stro

    BEGIN
        Order_Value := 0;
        PurchLine2.SetRange("Document Type", "Document Type"::Order);
        PurchLine2.SetRange("Document No.", Purchase_Order);
        if PurchLine2.FindSet then
            repeat
                if PurchLine2."Currency Code" = '' then
                    Order_Value += (PurchLine2.Quantity * PurchLine2."Direct Unit Cost")
                else
                    Order_Value += (PurchLine2.Quantity * PurchLine2."Unit Cost (LCY)");
            until PurchLine2.Next = 0;
        /* StrOrderDetails.Reset;
         StrOrderDetails.SetRange(Type, StrOrderDetails.Type::Purchase);
         StrOrderDetails.SetRange("Document Type", "Document Type"::Order);
         StrOrderDetails.SetRange("Document No.", Purchase_Order);

         StrOrderDetails.SetFilter("Calculation Order", '<%1', Calculation_Order);
         if StrOrderDetails.FindSet then
             repeat
                 Order_Value += StrOrderDetails."Amount (LCY)";
             until StrOrderDetails.Next = 0;*/
        "Base value" := Order_Value * (Standard_Packing / 100);
        exit("Base value");
    END;

    PROCEDURE PCB_Cost_Calc();
    VAR
        RecCount: Integer;
        Item: Record Item;
    BEGIN
        //sundar<--
        // Added by Pranvi on 28-Jul-2016 for PCB Cost Auto Calculation
        if (Quantity > 0) then begin
            PCB_Cost := 0;
            if (CopyStr("No.", 1, 5) = 'ECPCB') then begin
                Item.Reset;
                Item.SetFilter(Item."No.", "No.");
                if Item.FindFirst then begin
                    if Item."Item Sub Sub Group Code" <> 'STENCIL' then begin
                        PCB.SetFilter(PCB."Vendor No.", "Buy-from Vendor No.");
                        PCB.SetRange(PCB."PCB Thickness", Item."PCB thickness");
                        PCB.SetRange(PCB."Copper Clad Thickness", Item."Copper Clad Thickness");
                        PCB.SetFilter(PCB."No. of Sides", Item."Item Sub Group Code");
                        PCB.SetFilter(PCB.Type, Item."Item Sub Sub Group Code");
                        PCB.SetFilter(PCB."Min PCB Qty", '<=%1', Quantity);
                        PCB.SetFilter(PCB."Max PCB Qty", '>=%1', Quantity);
                        if PCB.FindLast then begin
                            PCB_Last_Quote_Date := 0D;
                            RecCount := 0;
                            PCB.Reset;
                            PCB.SetRange(PCB."Vendor No.", "Buy-from Vendor No.");
                            PCB.SetRange(PCB."PCB Thickness", Item."PCB thickness");
                            PCB.SetRange(PCB."Copper Clad Thickness", Item."Copper Clad Thickness");
                            PCB.SetFilter(PCB."No. of Sides", Item."Item Sub Group Code");
                            PCB.SetFilter(PCB.Type, Item."Item Sub Sub Group Code");
                            PCB.SetFilter(PCB."Min PCB Qty", '<=%1', Quantity);
                            PCB.SetFilter(PCB."Max PCB Qty", '>=%1', Quantity);
                            PCB.SetFilter(PCB."Min PCB Area", '<=%1', (Item."PCB Area" * Quantity) / 10000);
                            PCB.SetFilter(PCB."Max PCB Area", '>=%1', (Item."PCB Area" * Quantity) / 10000);
                            if PCB.FindSet then
                                repeat
                                    RecCount := RecCount + 1;
                                    if (PCB_Last_Quote_Date = 0D) or (PCB_Last_Quote_Date < PCB."Quotation Date") then
                                        PCB_Last_Quote_Date := PCB."Quotation Date";
                                until PCB.Next = 0;
                            PCB.Reset;
                            PCB.SetRange(PCB."Vendor No.", "Buy-from Vendor No.");
                            PCB.SetRange(PCB."PCB Thickness", Item."PCB thickness");
                            PCB.SetRange(PCB."Copper Clad Thickness", Item."Copper Clad Thickness");
                            PCB.SetFilter(PCB."No. of Sides", Item."Item Sub Group Code");
                            PCB.SetFilter(PCB.Type, Item."Item Sub Sub Group Code");
                            PCB.SetFilter(PCB."Min PCB Qty", '<=%1', Quantity);
                            PCB.SetFilter(PCB."Max PCB Qty", '>=%1', Quantity);
                            PCB.SetFilter(PCB."Min PCB Area", '<=%1', (Item."PCB Area" * Quantity) / 10000);
                            PCB.SetFilter(PCB."Max PCB Area", '>=%1', (Item."PCB Area" * Quantity) / 10000);
                            PCB.SetRange(PCB."Quotation Date", PCB_Last_Quote_Date);
                            if PCB.FindLast then begin
                                if "PCB Mode" = "PCB Mode"::Normal then
                                    PCB_Cost := PCB."Price per Sq.m"
                                else
                                    if "PCB Mode" = "PCB Mode"::Fast then begin
                                        if PCB."Fast Price" > 0 then
                                            PCB_Cost := PCB."Fast Price"
                                        else
                                            PCB_Cost := PCB."Price per Sq.m";
                                    end
                                    else
                                        if "PCB Mode" = "PCB Mode"::"Super Fast" then begin
                                            if PCB."Super Fast Price" > 0 then
                                                PCB_Cost := PCB."Super Fast Price"
                                            else
                                                PCB_Cost := PCB."Price per Sq.m";
                                        end;
                                case Item."On C-Side" of
                                    item."On C-Side"::Green:
                                        PCB_Cost := PCB_Cost + PCB.Green;
                                    Item."On C-Side"::White:
                                        PCB_Cost := PCB_Cost + PCB.White;
                                    Item."On C-Side"::Black:
                                        PCB_Cost := PCB_Cost + PCB.Black;
                                    Item."On C-Side"::Blue:
                                        PCB_Cost := PCB_Cost + PCB.Blue;
                                end;
                                case Item."On S-Side" of
                                    Item."On S-Side"::Green:
                                        PCB_Cost := PCB_Cost + PCB.Green;
                                    Item."On S-Side"::White:
                                        PCB_Cost := PCB_Cost + PCB.White;
                                    Item."On S-Side"::Black:
                                        PCB_Cost := PCB_Cost + PCB.Black;
                                    Item."On S-Side"::Blue:
                                        PCB_Cost := PCB_Cost + PCB.Blue;
                                end;
                                case Item."On D-Side" of
                                    Item."On D-Side"::Green:
                                        PCB_Cost := PCB_Cost + PCB.Green;
                                    Item."On D-Side"::White:
                                        PCB_Cost := PCB_Cost + PCB.White;
                                    Item."On D-Side"::Black:
                                        PCB_Cost := PCB_Cost + PCB.Black;
                                    Item."On D-Side"::Blue:
                                        PCB_Cost := PCB_Cost + PCB.Blue;
                                end;
                                "Direct Unit Cost" := Round(Item."PCB Area" * (PCB_Cost), 0.01);
                            end
                            //B2BJKOn18Jun2022++ Commented 
                            /*
                                                        ELSE BEGIN
                                                            IF Quantity <> 0 THEN BEGIN
                                                                IF NOT CONFIRM(Text50003, FALSE, "No.", "Buy-from Vendor No.", Item."PCB Area" * Quantity / 10000) THEN
                                                                    ERROR('THE UNIT COST FOR THE PCB %1 NEED TO BE CALCULATED MANUALLY', "No.");
                                                                PCB.RESET;
                                                                PCB.SETRANGE(PCB."Vendor No.", "Buy-from Vendor No.");
                                                                PCB.SETRANGE(PCB."PCB Thickness", Item."PCB thickness");
                                                                PCB.SETRANGE(PCB."Copper Clad Thickness", Item."Copper Clad Thickness");
                                                                PCB."PCB TYPE" := Item."Item Sub Group Code";
                                                                PCB.SETFILTER(PCB."Min.Area", '=%1', 0.0);
                                                                PCB.SETFILTER(PCB."Max.Area", '=%1', 0.0);
                                                                PCB.SETFILTER(PCB.Area, 'yes');
                                                                IF NOT PCB.FINDFIRST THEN BEGIN
                                                                    PCB.INIT;
                                                                    PCB."Vendor No." := "Buy-from Vendor No.";
                                                                    PCB.Name := PurchHeader."Buy-from Vendor Name";
                                                                    PCB."PCB Thickness" := Item."PCB thickness";
                                                                    PCB."Copper Clad Thickness" := Item."Copper Clad Thickness";
                                                                    PCB.Area := TRUE;
                                                                    PCB."PCB TYPE" := Item."Item Sub Group Code";
                                                                    PCB."Min.Area" := 0.0;
                                                                    PCB."Max.Area" := 0.0;
                                                                    PCB.Date := TODAY;
                                                                    PCB.INSERT;
                                                                    COMMIT;
                                                                END;
                                                                FORM.RUNMODAL(60215, PCB);
                                                                VALIDATE(Quantity);
                                                            END;
                                                        END;
                            *///B2BJKOn18Jun2022-- Commented 
                        end;
                        //B2BJKOn18Jun2022++ Commented 

                        /*

                                                IF Quantity <> 0 THEN BEGIN
                                                    IF NOT CONFIRM(Text50004, FALSE, "No.", "Buy-from Vendor No.", Quantity) THEN
                                                        ERROR('THE UNIT COST FOR THE PCB %1 NEED TO BE CALCULATED MANUALLY', "No.");
                                                    PCB.RESET;
                                                    PCB.SETFILTER(PCB."Vendor No.", "Buy-from Vendor No.");
                                                    PCB.SETFILTER(PCB."PCB Thickness", Item."PCB thickness");
                                                    PCB.SETFILTER(PCB."Copper Clad Thickness", Item."Copper Clad Thickness");
                                                    PCB."PCB TYPE" := Item."Item Sub Group Code";
                                                    PCB.SETFILTER(PCB."Min.Quantity", '=%1', 0.0);
                                                    PCB.SETFILTER(PCB."Max.Quantity", '=%1', 0.0);
                                                    IF NOT PCB.FINDFIRST THEN BEGIN
                                                        PCB.INIT;
                                                        PCB."Vendor No." := "Buy-from Vendor No.";
                                                        PCB.Name := PurchHeader."Buy-from Vendor Name";
                                                        PCB."PCB Thickness" := Item."PCB thickness";
                                                        PCB."Copper Clad Thickness" := Item."Copper Clad Thickness";
                                                        PCB."PCB TYPE" := Item."Item Sub Group Code";
                                                        PCB.Date := TODAY;
                                                        PCB."Min.Quantity" := 0.0;
                                                        PCB."Max.Quantity" := 0.0;
                                                        PCB.INSERT;
                                                        COMMIT;
                                                    END;
                                                    FORM.RUNMODAL(60215, PCB);
                                                    VALIDATE(Quantity);
                                                END;
                                                */
                        //B2BJKOn18Jun2022-- Commented 
                    END;


                end;
            end;
        end;
        // End by Pranavi

    end;

    var
        "--QC": Integer;
        QualityCtrlSetup: Record "Quality Control Setup";
        QCSetupRead: Boolean;
        GPS: Record "General Posting Setup";
        "Packing Value": Decimal;
        Insurence_Value: Decimal;
        //>> ORACLE UPG
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        //<< ORACLE UPG
        SQLQuery: Text[1000];
        //LRecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset";
        LineSQLQuery: Text[250];
        HeadID: Text[30];
        UpdateWebHead: Text[250];
        WebRecStatus: Text[30];
        OldWebStatus: Text[30];
        RCNT: Integer;
        Quotes: Label '''';
        Text50001: Label 'NEW';
        Text50002: Label 'OLD';
        // STRUCTURE_ORDER_DETAILS: Record "Structure Order Details";
        Vendor: Record Vendor;
        PCB: Record "PCB Vendors";
        Text50003: Label 'Do you Want to insert the record with itemno %1,vendor %2 and  area %3 in PCB Cost Details table';
        Text50004: Label 'Do you Want to insert the record with itemno %1,vendor %2 and  Quantity %3 in PCB Cost Details table';
        IRH: Record "Inspection Receipt Header";
        PCB_Cost: Decimal;
        PCB_Last_Quote_Date: Date;
        ItemLedgEntry: Record "Item Ledger Entry";
        //NODHeader: Record "NOD/NOC Header";
        PANErr: Label 'PAN No must be updated on Customer/Vendor/Party Master %1, currently its blank.';
}
