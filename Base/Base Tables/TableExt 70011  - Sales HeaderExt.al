tableextension 70011 SalesHeaderExt extends "Sales Header"
{
    fields
    {
        field(50000; "MSPT Date"; Date)
        {
            Description = 'MSPT1.0';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Status, Status::Open);

                MSPTOrderDetails.SetRange(Type, MSPTOrderDetails.Type::Sale);
                MSPTOrderDetails.SetRange("Document Type", "Document Type");
                MSPTOrderDetails.SetRange("Document No.", "No.");
                if MSPTOrderDetails.Find('-') then begin
                    repeat
                        MSPTOrderDetails."Due Date" := CalcDate(MSPTOrderDetails."Calculation Period", Rec."MSPT Date");
                        MSPTOrderDetails.Modify;
                    until MSPTOrderDetails.Next = 0;
                end;
            end;
        }
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT1.0';
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField(Status, Status::Open);

                MSPTOrderDetails.SetRange(Type, MSPTOrderDetails.Type::Sale);
                MSPTOrderDetails.SetRange("Document Type", "Document Type");
                MSPTOrderDetails.SetRange("Document No.", "No.");
                if MSPTOrderDetails.Find('-') then begin
                    MSPTOrderDetails.DeleteAll;
                end;

                MSPTHeader.SetRange(MSPTHeader.Code, "MSPT Code");
                if MSPTHeader.Find('-') then begin
                    "MSPT Details".SetRange("MSPT Details"."MSPT Header Code", "MSPT Code");
                    if "MSPT Details".Find('-') then begin
                        repeat
                            MSPTOrderDetails.Type := MSPTOrderDetails.Type::Sale;
                            MSPTOrderDetails."Document Type" := "Document Type";
                            MSPTOrderDetails."Document No." := "No.";
                            MSPTOrderDetails."Party Type" := MSPTOrderDetails."Party Type"::Customer;
                            MSPTOrderDetails."Party No." := "Sell-to Customer No.";
                            MSPTOrderDetails."MSPT Header Code" := "MSPT Code";
                            //MSPTOrderDetails."Calculation Type" := MSPTHeader.Type;
                            MSPTOrderDetails."MSPT Code" := "MSPT Details".Code;
                            MSPTOrderDetails."MSPT Line No." := "MSPT Details"."Line No.";
                            MSPTOrderDetails.Percentage := "MSPT Details".Percentage;
                            //MSPTOrderDetails.Amount:="MSPT Details".Amount;
                            MSPTOrderDetails.Description := "MSPT Details".Description;
                            MSPTOrderDetails."Calculation Period" := "MSPT Details"."Calculation Period";
                            MSPTOrderDetails.Remarks := "MSPT Details".Remarks;
                            SalesHeader.Get(MSPTOrderDetails."Document Type", MSPTOrderDetails."Document No.");
                            MSPTOrderDetails."Due Date" := CalcDate(MSPTOrderDetails."Calculation Period", "MSPT Date");
                            MSPTOrderDetails.Insert;
                        until "MSPT Details".Next = 0;
                    end;
                end;
            end;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT1.0';
            DataClassification = CustomerContent;
        }
        field(50003; WayBillNo; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "posting time"; Time)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(50005; userid1; Code[50])
        {
            Description = 'Rev01';
            Enabled = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(50006; "Work Order Number"; Text[30])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60000; "Amount to Customer"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount To Customer" WHERE("Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.")));
        }
        field(60001; "RDSO Charges Paid By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By Customer","By Railways";
            DataClassification = CustomerContent;
        }
        field(60002; "CA Number"; Code[20])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                CANumber.SetFilter("Customer No.", '=%1 | %2', '', "Sell-to Customer No.");
                if PAGE.RunModal(60008, CANumber) = ACTION::LookupOK then begin
                    "CA Number" := CANumber.Code;
                    CANumber."Customer No." := "Sell-to Customer No.";
                    CANumber.Modify;
                end;
            end;
        }
        field(60003; "CA Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Type of Enquiry"; Option)
        {
            Description = 'B2B';
            OptionMembers = Direct,Indirect;
            DataClassification = CustomerContent;
        }
        field(60005; "Type of Product"; Option)
        {
            Description = 'B2B';
            OptionMembers = Standard,Customized;
            DataClassification = CustomerContent;
        }
        field(60006; "Document Position"; Option)
        {
            Description = 'B2B';
            Editable = false;
            OptionMembers = Sales,Design,CRM;
            DataClassification = CustomerContent;
        }
        field(60007; "Cancel Short Close"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Cancelled,Short Closed"';
            OptionMembers = " ",Cancelled,"Short Closed";
            DataClassification = CustomerContent;
        }
        field(60008; "RDSO Inspection Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60009; "RDSO Inspection By"; Option)
        {
            Description = 'B2B';
            OptionMembers = " ","By RDSO","By Consignee";
            DataClassification = CustomerContent;
        }
        field(60010; "BG Required"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60011; "BG No."; Code[20])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60012; Territory; Code[20])
        {
            Description = 'B2B';
            TableRelation = Territory;
            DataClassification = CustomerContent;
        }
        field(60013; "Security Status"; Code[20])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60014; "LD Amount"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60015; "RDSO Charges"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60016; "Customer OrderNo."; Code[65])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60017; "Customer Order Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60018; "Security Deposit"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,BG,FDR,DD,Running Bills"';
            OptionMembers = " ",BG,FDR,DD,"Running Bills";
            DataClassification = CustomerContent;
        }
        field(60019; "RDSO Call Letter"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Customer,RDSO"';
            OptionMembers = " ",Customer,RDSO;
            DataClassification = CustomerContent;
        }
        field(60020; "Enquiry Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Open,Closed,Order Received';
            OptionMembers = Open,Closed,"Order Received";
            DataClassification = CustomerContent;
        }
        field(60021; "Project Completion Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Document Type" = "Document Type"::Order then begin
                    if "Project Completion Date" < "Promised Delivery Date" then
                        Error('Project Completion Date must be Greater than Promised Delivery Date');
                end;
            end;
        }
        field(60022; "Extended Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60023; "Bktord Des Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "SalOrd Des Approval"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60030; "Type of Customer"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Existing,New';
            OptionMembers = Existing,New;
            DataClassification = CustomerContent;
        }
        field(60031; "Nature of Enquiry"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Single,Multiple';
            OptionMembers = Single,Multiple;
            DataClassification = CustomerContent;
        }
        field(60032; Product; Code[10])
        {
            Description = 'B2B';
            TableRelation = "Service Item Group";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //ADDED BY PRANAVI ON 01-01-2016
                if (Product = 'SPARES') and ("Sell-to Customer No." = 'CUST00536') then begin
                    "Order Completion Period" := 45;
                    Validate("Shortcut Dimension 1 Code", 'CUS-005');
                    "Customer OrderNo." := 'NILL';
                    if "Order Date" <> 0D then
                        "Customer Order Date" := "Order Date"
                    else
                        "Customer Order Date" := Today();
                    "RDSO Inspection Req" := "RDSO Inspection Req"::NA;
                    "Call letters Status" := "Call letters Status"::NA;
                    "BG Status" := "BG Status"::NA;
                    Validate("Payment Terms Code", '100-I');
                end;
                //end by pranavi
            end;
        }
        field(60033; "Quote Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document Type" = CONST(Quote),
                                                                "Document No." = FIELD("No.")));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60034; "Installation Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "No." = FILTER('47300')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60035; "Bought out Items Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "Gen. Prod. Posting Group" = FILTER('BOI' | 'RAW-MAT')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60036; "Software Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "No." = FILTER('46400' | '18100' | '47505')));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60037; "Total Order Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount" WHERE("Document No." = FIELD("No.")));
            Description = 'B2B';
            FieldClass = FlowField;
        }
        field(60038; "Total Order Amount(With Taxes)"; Decimal)
        {
            //CalcFormula = Sum("Sales Line"."Amount Including Tax" WHERE("Document No." = FIELD("No.")));
            Description = 'EFF';
            //FieldClass = FlowField;
        }
        field(60041; "Security Deposit Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60042; "Deposit Payment Due Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60043; "Deposit Payment Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60044; "Security Deposit Status"; Code[20])
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60045; "SD Requested Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60046; "SD Required Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60047; "SecurityDeposit Exp. Rcpt Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60048; "Adjusted from EMD"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    "Transaction Type" = CONST(Adjustment),
                                                                    "Mode of Receipt / Payment" = FILTER(<> Customer)));
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60049; "Adjusted from Running Bills"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    "Transaction Type" = FILTER(Adjustment),
                                                                    "Mode of Receipt / Payment" = FILTER(Customer)));
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60050; "Tender No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Tender Header";
            DataClassification = CustomerContent;
        }
        field(60051; "SD Paid Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(SD),
                                                                    "Transaction Type" = CONST(Payment)));
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60052; "SD Received Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(SD),
                                                                    "Transaction Type" = CONST(Receipt)));
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(60053; "Final Bill Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Due Date" := CalcDate("Warranty Period", "Final Bill Date");
            end;
        }
        field(60054; "Warranty Period"; DateFormula)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Final Bill Date" <> 0D then
                    "Due Date" := CalcDate("Warranty Period", "Final Bill Date");
            end;
        }
        field(60055; "SD Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Not Received,Received,NA';
            OptionMembers = "Not Received",Received,NA;
            DataClassification = CustomerContent;
        }
        field(60056; "Released to Sales User ID"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            Enabled = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60057; "Released to Sales Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60058; "Released to Design User ID"; Code[40])
        {
            Description = 'Rev01';
            Editable = false;
            Enabled = false;
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(60059; "Released to Design Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60060; "Quote No 2."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60061; "Sale Order Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60062; "Reason For Pending"; Text[230])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60063; "Order Status"; Option)
        {
            OptionMembers = ,Dispatched,Inprogress,"Ready For Dispatch","Ready For RDSO","Under RDSO Inspection","Yet to Start","Order Pending","   ","Temporary Close";
            DataClassification = CustomerContent;
        }
        field(60064; Inspection; Code[50])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60065; CallLetterExpireDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60066; CallLetterRecivedDate; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalesLine.Reset;
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetFilter(Quantity, '>%1', 0);
                if SalesLine.FindSet then
                    repeat
                        SalesLine."Material Reuired Date" := Rec.CallLetterRecivedDate;
                        SalesLine.Modify;
                    until SalesLine.Next = 0;
            end;
        }
        field(60067; "Payments Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60068; Installation; Option)
        {
            OptionMembers = " ",RlyInstallation,EffInstallation,"RLY&EFF";
            DataClassification = CustomerContent;
        }
        field(60069; "Inst.Status"; Option)
        {
            OptionMembers = ," Raliway Pending","Railway Inprogress",Inprogress,Planned,"To Be Planned",Completed," ";
            DataClassification = CustomerContent;
        }
        field(60070; "Base PLan Comp. Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60071; "Revised Target Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60072; "Sales Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60073; Remarks; Text[230])
        {
            DataClassification = CustomerContent;
        }
        field(60074; "Call letters Status"; Option)
        {
            OptionMembers = " ",Received,Pending,NA,"Cust.Pending";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalesLine.Reset;
                SalesLine.SetRange("Document No.", Rec."No.");
                SalesLine.SetFilter(Quantity, '>%1', 0);
                if SalesLine.FindSet then
                    repeat
                        SalesLine."Call Letter Status" := Rec."Call letters Status";
                        SalesLine.Modify;
                    until SalesLine.Next = 0;
            end;
        }
        field(60075; "Call Letter Exp.Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //Commented by Vishnu Priya on 18-07-2020  as per the Mail from Sales Dept.
                /*SalesLine.RESET;
                SalesLine.SETRANGE("Document No.",Rec."No.");
                SalesLine.SETFILTER(Quantity,'>%1',0);
                IF SalesLine.FINDSET THEN
                  REPEAT
                    SalesLine."Call Letter Exp Date" := Rec."Call Letter Exp.Date";
                    SalesLine.MODIFY;
                  UNTIL SalesLine.NEXT =0;
                  */
                //Commented by Vishnu Priya on 18-07-2020

            end;
        }
        field(60076; "BG Status"; Option)
        {
            OptionMembers = " ",Submitted,Pending,NA;
            DataClassification = CustomerContent;
        }
        field(60077; "Inst.Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60078; "Exp.Payment"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60080; "Revised Comp.Date"; Date)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60081; "Assured Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60082; "Deviated Days"; Code[10])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60083; "Product 1"; Text[30])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60084; "Product 2"; Text[30])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60085; "Product 3"; Text[30])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60086; "Product 4"; Text[30])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60087; Consignee; Text[50])
        {
            Description = 'modified from station name to consignee by sujani';
            DataClassification = CustomerContent;
        }
        field(60088; "Shortage Calculation"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60089; "Sale Order No."; Code[20])
        {
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(60090; "RDSO Inspection Req"; Option)
        {
            OptionMembers = " ",YES,NA;
            DataClassification = CustomerContent;
        }
        field(60095; "Order Assurance"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60096; "Expected Order Month"; Option)
        {
            OptionMembers = "  ",APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC,JAN,FEB,MAR,"     ";
            DataClassification = CustomerContent;
        }
        field(60097; "Sale Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60098; "Purchase Value"; Decimal)
        {
            CalcFormula = Sum("Item Lot Numbers".Total WHERE("Sales Order No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60099; "Request for Authorisation"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60110; "Shipment Type"; Option)
        {
            Description = 'added by sujani';
            OptionMembers = "  ","Partially Allowed","Partially Not Allowed","No issue in Shipment";
            DataClassification = CustomerContent;
        }
        field(60115; "SD Running Bill Percent"; Decimal)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60116; "Order Completion Period"; Integer)
        {
            MaxValue = 360;
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(60117; "Expecting Week"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "Total Order(LOA)Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."Line Amount(LOA)" WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60120; "Pending(LOA)Value"; Decimal)
        {
            CalcFormula = Sum("Sales Line"."OutStanding(LOA)" WHERE("Document No." = FIELD("No."),
                                                                     "Document Type" = FILTER(Quote | Order)));
            FieldClass = FlowField;
        }
        field(60121; "Blanket Order No"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Installation Amount(CS)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60139; "First Released Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(80000; "Order Released Date"; Date)
        {
            Caption = 'Order Released Date';
            DataClassification = CustomerContent;
        }
        field(80001; "Payment Received"; Boolean)
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //Added by pranavi on 18-Jun-2015
                SHA.Reset;
                SHA.SetFilter(SHA."No.", "No.");
                if "Payment Received" = true then begin
                    if "Customer Posting Group" <> 'PRIVATE' then
                        Error('Allowed Only for PRIVATE Customers!')
                    else begin
                        if Order_After_CF_Integration = true then
                            Error('Not Allowed for Orders after Cashflow Payment Terms Integration!');
                    end;
                    if not SHA.FindFirst then
                        Error('Order Must be released at least one time!');
                end;
                //end by pranavi
            end;
        }
        field(80002; "Order Verified"; Boolean)
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;
        }
        field(80003; "Calculate Tax Structure"; Boolean)
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;
        }
        field(80004; "RDSO No"; Option)
        {
            Description = 'Added by Vijaya';
            OptionMembers = ,Pending,"RDSO 01","RDSO 02","RDSO 03","RDSO 04","RDSO 05","RDSO 06","RDSO 07","RDSO 08","RDSO 09","RDSO 10";
            DataClassification = CustomerContent;
        }
        field(80005; "EMD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(80006; "Verfication Req MailID"; Text[30])
        {
            Description = 'Added by Vijaya';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(80007; "Verification Status"; Option)
        {
            Description = 'Added by Vijaya';
            OptionMembers = " ",Accept,Reject,Request;
            DataClassification = CustomerContent;
        }
        field(80008; SecDepStatus; Enum "Sales invoice Header Enum9")
        {
            Description = 'Added by Pranavi for sd tracking';

            DataClassification = CustomerContent;
        }
        field(80009; "Remarks for Sales Status"; Text[20])
        {
            Enabled = false;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if (UserId in ['EFFTRONICS\VIJAYA', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SPURTHI', 'EFFTRONICS\BSATISH', 'EFFTRONICS\SARDHAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then begin
                    Modify;
                    FlagValue := true;
                end;
            end;
        }
        field(80010; "PT Release Auth Stutus"; Option)
        {
            Description = 'Added by Pranavi for PT Authorizations';
            OptionMembers = " ","Sent For Auth",Authorized,Rejected;
            DataClassification = CustomerContent;
        }
        field(80011; "PT Post Auth Stutus"; Option)
        {
            Description = 'Added by Pranavi for PT Authorizations';
            OptionMembers = " ","Sent For Auth",Authorized,Rejected;
            DataClassification = CustomerContent;
        }
        field(80012; Order_After_CF_Integration; Boolean)
        {
            Description = 'Added by Pranavi for PT Authorizations';
            DataClassification = CustomerContent;
        }
        field(80013; "Order Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(80014; "SD Fin Verification"; Enum "Sales invoice Header Enum11")
        {

            DataClassification = CustomerContent;
        }
        field(80017; Vertical; Option)
        {
            Description = 'Added by Vijaya for Vertical information';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IOT,other;
            DataClassification = CustomerContent;
        }
        field(80022; "Tender Published Date"; Date)
        {
            Description = 'added by sujani for Pre Expected orderes';
            DataClassification = CustomerContent;
        }
        field(80023; "Tender Due Date"; Date)
        {
            Description = 'added by sujani for Pre Expected orderes';
            DataClassification = CustomerContent;
        }
        field(80024; "Railway Division"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employee Statistics Group".Code;
        }
        field(80025; "BG Fin Status"; Enum "Sales invoice Header Enum12")
        {
            Description = 'Added By Vishnu for BG Status Confirmation';

            DataClassification = CustomerContent;
        }
        field(80100; "Insurance Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(80101; Customer_PAN_No; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(80102; Location_PAN_No; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95401; "No.1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(95402; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95403; "Form Code1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95404; "Form No.1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        //EFFUPG1.5>>



        Field(70055; SaleDocType; Enum SalesDocTypeCust)
        {
            DataClassification = CustomerContent;
        }
        //EFFUPG1.5<<





    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        //"User ID" :=userid1; //EFF
        //B2B-MSPT1.0
        IF "Document Type" = "Document Type"::Order THEN
            "MSPT Date" := "Posting Date"
        ELSE
            IF "Document Type" = "Document Type"::Quote THEN
                "MSPT Date" := "Document Date"
            ELSE
                IF "Document Type" = "Document Type"::Invoice THEN
                    "MSPT Date" := "Posting Date";
        //B2B-MSPT1.0
        IF "Document Type" = "Document Type"::Order THEN
            Order_After_CF_Integration := TRUE;

    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin
        //sreenivas -eff
        /*  {
          IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]) AND (Status=Status::Released) THEN
            ERROR('You Cannot Modify This Document Which Was Already Released');
          }*/
        //IF ("Document Type" IN ["Document Type"::Order]) AND("No. of Archived Versions">0) THEN
        //ERROR('You Cannot Modify This Document Which Was Already Released');
        //sreenivas -eff

    end;

    trigger OnAfterDelete()
    var
        myInt: Integer;
    begin
        //sreenivas -eff
        //sreenivas -eff
        //IF ("Document Type" IN ["Document Type"::Quote,"Document Type"::"Blanket Order"]) AND
        //(Status=Status::Released) THEN
        //ERROR('You Cannot Delete This Document Which Was Already Released');

        IF ("Document Type" IN ["Document Type"::Order]) AND ("No. of Archived Versions" > 0) THEN
            ERROR('You Cannot Delete This Document Which Was Already Released');

        //sreenivas -eff
    end;



    PROCEDURE CancelCloseOrder(VAR OrderStatus: Text[50]; VAR SalesHeader: Record "Sales Header");
    VAR
        CancelShortClose: Text[50];
        SalesLine: Record "Sales Line";
        SalesShipLine: Record "Sales Shipment Line";
        Text050: Label 'ENU=You cannot Canel/Short Close the order,Invoice is pending for Line No. %1 and Item No. %2';
    BEGIN

        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesLine.INIT;
                SalesShipLine.SETCURRENTKEY("Order No.", "Order Line No."); //anil added 30-07-12
                SalesShipLine.SETRANGE(SalesShipLine."Order No.", SalesLine."Document No.");
                SalesShipLine.SETRANGE(SalesShipLine."Order Line No.", SalesLine."Line No.");
                IF SalesShipLine.FIND('-') THEN BEGIN
                    IF (SalesShipLine."Qty. Shipped Not Invoiced" <> 0) AND (Rec.Product <> 'SPARES') THEN
                        ERROR(Text050, SalesShipLine."Order Line No.", SalesShipLine."No.");
                END;
            UNTIL SalesLine.NEXT = 0;  //anil added this line
                                       // UNTIL SalesShipLine.NEXT=0;
        END;

        IF OrderStatus = 'Close' THEN BEGIN
            "Cancel Short Close" := "Cancel Short Close"::"Short Closed";
            MODIFY;
        END;
        IF OrderStatus = 'Cancel' THEN BEGIN
            "Cancel Short Close" := "Cancel Short Close"::Cancelled;
            MODIFY;
        END;
        ArchiveManagement.ArchiveSalesDocument(SalesHeader);

        ShortCloseInCashFlow(SalesHeader);

        SalesLine.SETRANGE(SalesLine."Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(SalesLine."Document Type", SalesHeader."Document Type");
        IF SalesLine.FIND('-') THEN BEGIN
            REPEAT
                SalesLine.DELETE;
            UNTIL SalesLine.NEXT = 0;
        END;
        SalesHeader.DELETE;
    END;


    PROCEDURE ExtenalDocNo(InvoiceNos: Option " ",ExciseInv,ServiceInv; PostingDate: Date); // removed by durga on 03-09-2022 --,TradingInv,InstInv
    VAR
        temp: Integer;
        SalesHeadLRec: Record "Sales Header";
        Fyear: Integer;
        POSTEDINVOICE: Record "Sales Invoice Header";
        y: Text;
    BEGIN

        temp := 0;
        temp1 := 0;
        SalesHeadLRec.RESET;
        SalesHeadLRec.SETFILTER(SalesHeadLRec."External Document No.", '<>%1', ' ');
        SalesHeadLRec.SETFILTER("No.", '<>%1', "No.");//EFF02NOV22
        IF SalesHeadLRec.FINDSET THEN
            REPEAT
                SalesHeadLRec."External Document No." := '';
                SalesHeadLRec.MODIFY;
            UNTIL SalesHeadLRec.NEXT = 0;
        "External Document No." := ''; //EFF02NOV22

        IF DATE2DMY(PostingDate, 2) <= 3 THEN
            Fyear := DATE2DMY(PostingDate, 3) - 1
        ELSE
            Fyear := DATE2DMY(PostingDate, 3);


        SalesHeadLRec.SETFILTER(SalesHeadLRec."Document Type", 'Order');
        SalesHeadLRec.SETFILTER(SalesHeadLRec."External Document No.", '<>%1', '');
        IF SalesHeadLRec.COUNT > 0 THEN
            IF SalesHeadLRec.FINDSET THEN
                REPEAT
                    ERROR(SalesHeadLRec."No." + '  Sale Have the Invoice Number');
                UNTIL SalesHeadLRec.NEXT = 0;


        CASE InvoiceNos OF

            0:
                begin
                    "External Document No." := '';
                    // MODIFY;//EFF02NOV22
                end;
            1:
                BEGIN
                    POSTEDINVOICE.RESET;
                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                    POSTEDINVOICE.ASCENDING;
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));  // Added by Rakesh
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", '0..99999');
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;

                    // Added by Rakesh for considering the Ext.Doc no in the Transfer Order on 6-Mar-15
                    TransShptHeader.RESET;
                    TransShptHeader.SETCURRENTKEY(TransShptHeader."External Document No.");
                    TransShptHeader.ASCENDING;
                    TransShptHeader.SETRANGE(TransShptHeader."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));
                    TransShptHeader.SETFILTER(TransShptHeader."External Document No.", '0..99999');
                    IF TransShptHeader.FINDLAST THEN BEGIN
                        TO_doc := '0';
                        TO_doc := TransShptHeader."External Document No.";
                        temp1 := 1;
                    END;

                    IF (temp = 0) AND (temp1 = 0) THEN
                        "External Document No." := '0001'
                    ELSE
                        IF y > TO_doc THEN
                            "External Document No." := INCSTR(y)
                        ELSE
                            "External Document No." := INCSTR(TO_doc);
                    //MODIFY;//EFF02NOV22

                    // End by Rakesh on 6-Mar-15
                END;

            2:
                BEGIN
                    POSTEDINVOICE.RESET;
                    POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                    POSTEDINVOICE.ASCENDING;
                    POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));       // Added by Rakesh
                    POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'SI*');
                    IF POSTEDINVOICE.FINDLAST THEN BEGIN
                        y := '0';
                        y := POSTEDINVOICE."External Document No.";
                        temp := 1;
                    END;
                    IF temp = 0 THEN
                        "External Document No." := 'SI-001'
                    ELSE
                        "External Document No." := INCSTR(y);
                    // MODIFY;//EFF02NOV22
                END;

        /*3:
            BEGIN
                POSTEDINVOICE.RESET;
                POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                POSTEDINVOICE.ASCENDING;
                POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));      // Added by Rakesh
                POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'CI-*');
                IF POSTEDINVOICE.FINDLAST THEN BEGIN
                    y := '0';
                    y := POSTEDINVOICE."External Document No.";
                    temp := 1;
                END;
                IF temp = 0 THEN
                    "External Document No." := 'CI-001'
                ELSE
                    "External Document No." := INCSTR(y);
                MODIFY;
            END;

        4:
            BEGIN
                POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                POSTEDINVOICE.ASCENDING;
                POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));     // Added by Rakesh
                POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'IN*');
                IF POSTEDINVOICE.FINDLAST THEN BEGIN
                    y := '0';
                    y := POSTEDINVOICE."External Document No.";
                    temp := 1;
                END;
                IF temp = 0 THEN
                    "External Document No." := 'IN-001'
                ELSE
                    "External Document No." := INCSTR(y);

                MODIFY;

            END;

        //Added by Rakesh for EffeHyd No. series on 1-Oct-14
        5:
            BEGIN
                POSTEDINVOICE.RESET;
                POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                POSTEDINVOICE.ASCENDING;
                POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));      // Added by Rakesh
                POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'CIT*');
                IF POSTEDINVOICE.FINDLAST THEN BEGIN
                    y := '0';
                    y := POSTEDINVOICE."External Document No.";
                    temp := 1;
                END;
                IF temp = 0 THEN
                    "External Document No." := 'CIT-00001'
                ELSE
                    "External Document No." := INCSTR(y);
                MODIFY;

            END;
        // end by Rakesh

        //Added by Pranavi for EffeVij No. series on 12-May-16
        6:
            BEGIN
                POSTEDINVOICE.RESET;
                POSTEDINVOICE.SETCURRENTKEY(POSTEDINVOICE."External Document No.");
                POSTEDINVOICE.ASCENDING;
                POSTEDINVOICE.SETRANGE(POSTEDINVOICE."Posting Date", DMY2DATE(1, 4, Fyear), DMY2DATE(1, 4, Fyear + 1));      // Added by Pranavi
                POSTEDINVOICE.SETFILTER(POSTEDINVOICE."External Document No.", 'CIV*');
                IF POSTEDINVOICE.FINDLAST THEN BEGIN
                    y := '0';
                    y := POSTEDINVOICE."External Document No.";
                    temp := 1;
                END;
                IF temp = 0 THEN
                    "External Document No." := 'CIV-00001'
                ELSE
                    "External Document No." := INCSTR(y);
                MODIFY;

            END;*/
        // end by Pranavi

        END;
    END;


    PROCEDURE CompareTwoRecords(): Boolean;
    BEGIN
        IF FlagValue = TRUE THEN BEGIN
            FlagValue := FALSE;
            EXIT(TRUE);
        END
        ELSE
            EXIT(FALSE);
    END;


    PROCEDURE ShortCloseInCashFlow(VAR SalesHeader: Record "Sales Header");
    VAR
        SaleOrderId: Integer;
        RowCount: Integer;
        SQLQuery: Text;
        ConnectionOpen: Integer;
        /*  SQLConnection: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000514-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Connection";
         RecordSet: Automation "'{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8:'{00000535-0000-0010-8000-00AA006D2EA4}':''{2A75196C-D9EB-4129-B803-931327F72D5C}' 2.8'.Recordset"; */
        AMCOrderID: Integer;
        Dummy_SaleOrderId: Integer;
        Updated: Boolean;
        UserGRec: Record "User Setup";
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: Text[1000];
        Mail_To: Text;
        Recipients: List of [Text];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Subject: Text;
        Body: Text;
    //ROMail: Codeunit "SMTP Mail";
    BEGIN
        // Code added by Pranavi on 04-Jul-2016 for short closing sale/amc order in CashFlow when Short Closed in ERP
        IF FORMAT(SalesHeader."Document Type") IN ['Order', 'Amc'] THEN BEGIN
            //Initialization start
            RowCount := 0;
            SQLQuery := '';
            SaleOrderId := 0;
            AMCOrderID := 0;
            Dummy_SaleOrderId := 0;
            Updated := FALSE;
            //Initializations end

            /*IF ISCLEAR(SQLConnection) THEN
                CREATE(SQLConnection, FALSE, TRUE);

            IF ISCLEAR(RecordSet) THEN
                CREATE(RecordSet, FALSE, TRUE);*/  // efB2BUPG
                                                   /*//>> ORACLE UPG
                                                               IF ConnectionOpen <> 1 THEN BEGIN
                                                                   // SQLConnection.ConnectionString:='DSN=CASHFLOW_TEST;UID=cashflow;PASSWORD=cashflow;SERVER=oracle_test;';
                                                                   SQLConnection.ConnectionString := 'DSN=CASHFLOW;UID=cashflowuser;PASSWORD=firewall123;SERVER=oracle_80;';
                                                                   SQLConnection.Open;
                                                                   SQLConnection.BeginTrans;
                                                                   ConnectionOpen := 1;
                                                               END;
                                                               IF FORMAT(SalesHeader."Document Type") = 'Order' THEN BEGIN
                                                                   SQLQuery := 'SELECT * FROM MRP_SALE_ORDER WHERE INT_SAL_ORD_NO = ''' + SalesHeader."No." + ''' AND STATUS = ''N''';
                                                                   RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                                                                   IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                                                       RecordSet.MoveFirst;
                                                                   WHILE NOT RecordSet.EOF DO BEGIN
                                                                       SaleOrderId := RecordSet.Fields.Item('SALE_ORDER_ID').Value;
                                                                       RowCount := RowCount + 1;
                                                                       RecordSet.MoveNext;
                                                                   END;
                                                                   IF SaleOrderId <> 0 THEN   // check if sale order created in sale order main table in c/f
                                                                   BEGIN
                                                                       SQLQuery := 'UPDATE MRP_SALE_ORDER SET STATUS = ''Y'', REMARKS = ''Short Closed'' WHERE INT_SAL_ORD_NO = ''' + SalesHeader."No." + '''';
                                                                       SQLConnection.Execute(SQLQuery);
                                                                       Updated := TRUE;
                                                                       MESSAGE('Sale Order ' + SalesHeader."No." + ' Short Closed in CashFlow!');
                                                                   END
                                                                   ELSE BEGIN
                                                                       RowCount := 0;
                                                                       SQLQuery := 'SELECT * FROM MRP_SALE_ORDER_DUMMY WHERE INT_SAL_ORD_NO = ''' + SalesHeader."No." + ''' AND STATUS = ''N''';
                                                                       RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                                                                       IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                                                           RecordSet.MoveFirst;
                                                                       WHILE NOT RecordSet.EOF DO BEGIN
                                                                           Dummy_SaleOrderId := RecordSet.Fields.Item('SALE_ORDER_ID').Value;
                                                                           RowCount := RowCount + 1;
                                                                           RecordSet.MoveNext;
                                                                       END;
                                                                       IF Dummy_SaleOrderId <> 0 THEN   // check if sale order created in sale order dummy table in c/f
                                                                       BEGIN
                                                                           SQLQuery := 'UPDATE MRP_SALE_ORDER_DUMMY SET STATUS = ''Y'', REMARKS = ''Short Closed'' WHERE INT_SAL_ORD_NO = ''' + SalesHeader."No." + '''';
                                                                           SQLConnection.Execute(SQLQuery);
                                                                       END;
                                                                   END;
                                                               END
                                                               ELSE
                                                                   IF FORMAT(SalesHeader."Document Type") = 'Amc' THEN BEGIN
                                                                       RowCount := 0;
                                                                       SQLQuery := 'SELECT * FROM MRP_AMC_ORDER1 WHERE INTERNAL_AMC_NO = ''' + SalesHeader."No." + '''';
                                                                       RecordSet := SQLConnection.Execute(SQLQuery, RowCount);
                                                                       IF NOT ((RecordSet.BOF) OR (RecordSet.EOF)) THEN
                                                                           RecordSet.MoveFirst;
                                                                       WHILE NOT RecordSet.EOF DO BEGIN
                                                                           AMCOrderID := RecordSet.Fields.Item('AMC_ORDER_ID').Value;
                                                                           RowCount := RowCount + 1;
                                                                           RecordSet.MoveNext;
                                                                       END;
                                                                       IF AMCOrderID <> 0 THEN BEGIN
                                                                           SQLQuery := 'UPDATE MRP_AMC_ORDER1 SET STATUS = ''Y'', REMARKS = ''Short Closed'' WHERE INTERNAL_AMC_NO = ''' + SalesHeader."No." + '''';
                                                                           SQLConnection.Execute(SQLQuery);
                                                                           Updated := TRUE;
                                                                           MESSAGE('AMC Order ' + SalesHeader."No." + ' Short Closed in CashFlow!');
                                                                       END;
                                                                   END;
                                                               SQLConnection.CommitTrans;
                                                               RecordSet.Close;
                                                               SQLConnection.Close;
                                                               ConnectionOpen := 0;
                                                               */ //<< ORACLE UPG

            /* IF Updated = TRUE THEN BEGIN
                 Mail_To := 'sms@efftronics.com,erp@efftronics.com';
                 Mail_Body := '';
                 IF SalesHeader."Document Type" = SalesHeader."Document Type"::Order THEN
                     Mail_Subject := 'Sale Order : ' + SalesHeader."No." + '--' + SalesHeader."Sell-to Customer Name" + ' is Short Closed in ERP'
                 ELSE
                      IF SalesHeader."Document Type" = SalesHeader."Document Type"::Amc THEN
                         Mail_Subject := 'AMC Order : ' + SalesHeader."No." + '--' + SalesHeader."Sell-to Customer Name" + ' is Short Closed in ERP';
                 ROMail.CreateMessage('erp', 'erp@efftronics.com', Mail_To, 'ERP - ' + Mail_Subject, Mail_Body, TRUE);
                 Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                 Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                 Body += ('<label><font size="6"> Order Information</font></label>');
                 Body += ('<hr style=solid; color= #3333CC>');
                 Body += ('<h>Dear Sir/Madam,</h><br><br>');
                 Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                 Body += ('<tr><td><b>Order Type</b></td><td>' + FORMAT(SalesHeader."Document Type") + '</td></tr>');
                 Body += ('<tr><td><b>Order No  </b></td><td>' + SalesHeader."No." + '</td></tr>');
                 Body += ('<tr><td><b>Customer No.  </b></td><td>' + SalesHeader."Sell-to Customer No." + '</td></tr>');
                 Body += ('<tr><td><b>Customer Name  </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                 Body += ('<tr><td><b>Customer Posting Group </b></td><td>' + SalesHeader."Customer Posting Group" + '</td></tr>');
                 Body += ('<tr><td><b>Remarks   </b></td><td>' + SalesHeader.Remarks + '</td></tr>');
                 UserGRec.RESET;
                 UserGRec.SETRANGE(UserGRec.EmployeeID, "Salesperson Code");//B2B
                 IF UserGRec.FINDFIRST THEN
                     Body += ('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT(UserGRec."Full Name") + '</td></tr>');
                 Body += ('</Table>');
                 Body += ('<BR><p align ="left"> <b>Note::</b> Order Status is updated to Y in CashFLow.Please check any other to be closed invoice entries still exist if so please close</p>');
                 Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                 Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                 IF (Mail_To <> '') THEN
                     ROMail.Send; */     //UPG

            IF Updated = TRUE THEN BEGIN
                Recipients.Add('');
                Recipients.Add('sms@efftronics.com');
                Recipients.Add('erp@efftronics.com');
                Body := '';
                Subject := (Mail_Subject);
                IF SalesHeader.SaleDocType = SalesHeader.SaleDocType::Order THEN
                    Mail_Subject := 'Sale Order : ' + SalesHeader."No." + '--' + SalesHeader."Sell-to Customer Name" + ' is Short Closed in ERP'
                ELSE
                    IF SalesHeader.SaleDocType = SalesHeader.SaleDocType::Amc THEN
                        Mail_Subject := 'AMC Order : ' + SalesHeader."No." + '--' + SalesHeader."Sell-to Customer Name" + ' is Short Closed in ERP';

                Body += ('<html><head><style> divone{background-color: white; width: 700px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
                Body += ('<body><div style="border-color:#025E4D;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 600px;">');
                Body += ('<label><font size="6"> Order Information</font></label>');
                Body += ('<hr style=solid; color= #3333CC>');
                Body += ('<h>Dear Sir/Madam,</h><br><br>');
                Body += ('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;">');
                Body += ('<tr><td><b>Order Type</b></td><td>' + FORMAT(SalesHeader."Document Type") + '</td></tr>');
                Body += ('<tr><td><b>Order No  </b></td><td>' + SalesHeader."No." + '</td></tr>');
                Body += ('<tr><td><b>Customer No.  </b></td><td>' + SalesHeader."Sell-to Customer No." + '</td></tr>');
                Body += ('<tr><td><b>Customer Name  </b></td><td>' + SalesHeader."Sell-to Customer Name" + '</td></tr>');
                Body += ('<tr><td><b>Customer Posting Group </b></td><td>' + SalesHeader."Customer Posting Group" + '</td></tr>');
                Body += ('<tr><td><b>Remarks   </b></td><td>' + SalesHeader.Remarks + '</td></tr>');
                UserGRec.RESET;
                UserGRec.SETRANGE(UserGRec.EmployeeID, "Salesperson Code");//B2B
                IF UserGRec.FINDFIRST THEN
                    Body += ('<tr><td><b>Sales Executive  </b></td><td>' + FORMAT(UserGRec."User ID") + '</td></tr>');
                Body += ('</Table>');
                Body += ('<BR><p align ="left"> <b>Note::</b> Order Status is updated to Y in CashFLow.Please check any other to be closed invoice entries still exist if so please close</p>');
                Body += ('<BR><p align ="left"> Regards,<br>ERP Team </p>');
                Body += ('<br><p align = "center">::::Note: Auto Generated mail from ERP:::: </b></P></div></body></html>');
                IF (Mail_To <> '') THEN
                    EmailMessage.Create(Recipients, Subject, Body, true);
                Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
            END;
            // End by Pranavi
        END;
    END;


    PROCEDURE RemoveSpecialChar(TextLPar: Text) ReturnText: Text;
    BEGIN
        ReturnText := DELCHR(TextLPar, '=', '|\?/<>,.@#$%^&*()!-=_+');
    END;

    /*
     LOCAL PROCEDURE InitSellToCustFromCustomer(VAR SalesHeader: Record 36; Cust: Record 18);
     BEGIN
         WITH SalesHeader DO BEGIN
             Cust.CheckBlockedCustOnDocs(Cust, "Document Type", FALSE, FALSE);
             Cust.TESTFIELD("Gen. Bus. Posting Group");
             "Sell-to Customer Template Code" := '';
             "Sell-to Customer Name" := Cust.Name;
             "Sell-to Customer Name 2" := Cust."Name 2";
             "Sell-to Address" := Cust.Address;
             "Sell-to Address 2" := Cust."Address 2";
             "Sell-to City" := Cust.City;
             "Sell-to Post Code" := Cust."Post Code";
             "Sell-to County" := Cust.County;
             "Sell-to Country/Region Code" := Cust."Country/Region Code";
             // "Nature of Services" := Cust."Nature of Services";
             Customer_PAN_No := Cust."P.A.N. No.";
             IF NOT SkipSellToContact THEN
                 "Sell-to Contact" := Cust.Contact;
             "Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
             "VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
             "Tax Liable" := Cust."Tax Liable";
             "VAT Registration No." := Cust."VAT Registration No.";
             "VAT Country/Region Code" := Cust."Country/Region Code";
             "Shipping Advice" := Cust."Shipping Advice";
             IF "GST Customer Type" IN ["GST Customer Type"::"Deemed Export", "GST Customer Type"::Export,
               "GST Customer Type"::"SEZ Development", "GST Customer Type"::"SEZ Unit"] THEN
                 State := ''
             ELSE
                 State := Cust."State Code";
             //CALCFIELDS("Price Inclusive of Taxes");
             // IF NOT "Price Inclusive of Taxes" THEN
             //    "VAT Exempted" := Cust."VAT Exempted";
             // Structure := Cust.Structure;
             //  "Excise Bus. Posting Group" := Cust."Excise Bus. Posting Group";
             CheckShipToCustomer;
             CheckShipToCode;
         END;
     END;
 */
    var
        CANumber: Record "CA Number";
        "--MSPT---": Integer;
        MSPTOrderDetails: Record "MSPT Order Details";
        MSPTHeader: Record "MSPT Header";
        "MSPT Details": Record "MSPT Line";
        "No. of Days": Integer;
        TransShptHeader: Record "Transfer Shipment Header";
        TO_doc: Text;
        temp1: Integer;
        SHA: Record "Sales Header Archive";
        SalesPersonOrPurchsr: Record "Salesperson/Purchaser";
        FlagValue: Boolean;
        ArchiveManagement: Codeunit 5063;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";

}

