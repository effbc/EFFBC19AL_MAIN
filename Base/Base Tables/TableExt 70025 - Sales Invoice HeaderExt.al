tableextension 70025 SalesInvoiceHeaderExt extends "Sales Invoice Header"
{

    fields
    {
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT1.0';
            Editable = false;
            TableRelation = "MSPT Header".Code;
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50003; WayBillNo; Text[30])
        {
            Editable = true;
            Enabled = true;
            DataClassification = CustomerContent;
        }
        field(50004; "posting time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(60000; "Amount to Customer"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line"."Amount To Customer" WHERE("Document No." = FIELD("No.")));
        }
        field(60001; "RDSO Charges Paid By."; Enum "Sales invoice Header Enum1")
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(60002; "CA Number"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            TableRelation = "CA Number";
            DataClassification = CustomerContent;
        }
        field(60003; "CA Date"; Date)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60004; "Type of Enquiry"; Enum "Sales invoice Header Enum2")
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;

        }
        field(60005; "Type of Product"; Enum "Sales invoice Header Enum3")
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(60006; "Document Position"; Enum "Sales invoice Header Enum4")
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;

        }
        field(60007; "Cancel Short Close"; Enum "Sales invoice Header Enum5")
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(60008; "RDSO Inspection Required"; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60009; "RDSO Inspection By"; Enum "Sales invoice Header Enum6")
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(60010; "BG Required"; Boolean)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60011; "BG No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60012; Territory; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            TableRelation = Territory;
            DataClassification = CustomerContent;
        }
        field(60013; "Security Status"; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60014; "LD Amount"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60015; "RDSO Charges"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            Enabled = false;
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
            OptionCaption = '" ,BG,FDR,DD,Running Bills"';
            OptionMembers = " ",BG,FDR,DD,"Running Bills";
            DataClassification = CustomerContent;
        }
        field(60019; "RDSO Call Letter"; Option)
        {
            OptionCaption = '" ,Customer,RDSO"';
            OptionMembers = " ",Customer,RDSO;
            DataClassification = CustomerContent;
        }
        field(60020; "Enquiry Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Open,Closed,Order Received"';
            OptionMembers = " ",Open,Closed,"Order Received";
            DataClassification = CustomerContent;
        }
        field(60021; "Project Completion Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60022; "Extended Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60032; Product; Code[10])
        {
            Description = 'B2B';
            TableRelation = "Service Item Group";
            DataClassification = CustomerContent;
        }
        field(60034; "Manufacturing Item Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60035; "Bought out Items Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60036; "Software Amount"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60037; "Total Order Amount"; Decimal)
        {
            Description = 'B2B';
            Enabled = false;
            DataClassification = CustomerContent;
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
            Editable = false;
            TableRelation = "Tender Header";
            DataClassification = CustomerContent;
        }
        field(60051; "SD Paid Amount"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = CONST('25700'),
                                                        "Sale Order No." = FIELD("Order No."),
                                                        Amount = FILTER(> 0)));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60052; "SD Received Amount"; Decimal)
        {
            CalcFormula = - Sum("G/L Entry".Amount WHERE("G/L Account No." = CONST('25700'),
                                                         "Sale Order No." = FIELD("Order No."),
                                                         Amount = FILTER(< 0)));
            Description = 'B2B';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60053; "Final Bill Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60054; "Warranty Period"; DateFormula)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalesInvHeader.Reset;
                SalesInvHeader.SetRange(SalesInvHeader."Order No.", "Order No.");
                SalesInvHeader.SetFilter(SalesInvHeader."No.", '<>%1', "No.");
                if SalesInvHeader.FindSet then
                    repeat
                        SalesInvHeader."Warranty Period" := "Warranty Period";
                        SalesInvHeader.Modify;
                    until SalesInvHeader.Next = 0
            end;
        }
        field(60055; "SD Status"; Option)
        {
            Description = 'B2B';
            OptionCaption = 'Not Received,Received,NA';
            OptionMembers = "Not Received",Received,NA;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalesInvHeader.Reset;
                SalesInvHeader.SetRange(SalesInvHeader."Order No.", "Order No.");
                SalesInvHeader.SetFilter(SalesInvHeader."No.", '<>%1', "No.");
                if SalesInvHeader.FindSet then
                    repeat
                        SalesInvHeader."SD Status" := "SD Status";
                        SalesInvHeader.Modify;
                    until SalesInvHeader.Next = 0
            end;
        }
        field(60061; "Sale Order Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60065; CallLetterExpireDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60066; CallLetterRecivedDate; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60074; "Call letters Status"; Option)
        {
            OptionMembers = " ",Received,Pending,NA,"Cust.Pending";
            DataClassification = CustomerContent;
        }
        field(60075; "Call Letter Exp.Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60079; "C-form Status"; Enum "Sales invoice Header Enum7")
        {
            DataClassification = CustomerContent;

        }
        field(60081; "Total Invoiced Amount"; Decimal)
        {
            CalcFormula = Sum("Sales Invoice Line"."Amount to Customer" WHERE("Document No." = FIELD("No.")));
            Editable = true;
            FieldClass = FlowField;
        }
        field(60087; Consignee; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60100; "Hand Overed Person"; Code[10])
        {
            TableRelation = Resource;
            DataClassification = CustomerContent;
        }
        field(60101; "Hand Overed Person(Others)"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60102; "Dispatched Location"; Code[10])
        {
            //TableRelation = Division;
            TableRelation = "Employee Statistics Group";
            DataClassification = CustomerContent;
        }
        field(60103; "Reason For Deviation"; Enum "Sales invoice Header Enum8")
        {
            DataClassification = CustomerContent;

        }
        field(60104; "Expected Reached Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60105; "Contact Info"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                if PAGE.RunModal(77, Resource) = ACTION::LookupOK then
                    "Contact Info" := Resource."Contract Class";
            end;
        }
        field(60106; "Contact Info(Others)"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60107; "Customer Remarks"; Text[50])
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60108; "Edit Text"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60115; "SD Running Bills Percent"; Decimal)
        {
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60118; "Cancel Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60119; "Total Excise Amount"; Decimal)
        {
            // CalcFormula = Sum("Sales Invoice Line".Field31410340 WHERE("Document No." = FIELD("No.")));
            //FieldClass = FlowField;
        }
        field(60120; "Consignee Name"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60121; "Blanket Order No"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Installation Amount(CS)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60123; "Date Sent"; Date)
        {
            Caption = 'Date Sent';
            DataClassification = CustomerContent;
        }
        field(60124; "Time Sent"; Time)
        {
            Caption = 'Time Sent';
            DataClassification = CustomerContent;
        }
        field(60125; "BizTalk Sales Invoice"; Boolean)
        {
            Caption = 'BizTalk Sales Invoice';
            DataClassification = CustomerContent;
        }
        field(60126; "Customer Order No."; Code[30])
        {
            Caption = 'Customer Order No.';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(60127; "BizTalk Document Sent"; Boolean)
        {
            Caption = 'BizTalk Document Sent';
            DataClassification = CustomerContent;
        }
        field(60128; "Dispatched Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60129; "LR No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60130; "Dispatch Assurance Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60131; "Exempted Vide Notification No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60132; SecDepStatus; Enum "Sales invoice Header Enum9")
        {
            Description = 'Added by Pranavi for sd status tracking';
            DataClassification = CustomerContent;


            trigger OnValidate();
            begin
                SalesInvHeader.Reset;
                SalesInvHeader.SetRange(SalesInvHeader."Order No.", "Order No.");
                SalesInvHeader.SetFilter(SalesInvHeader."No.", '<>%1', "No.");
                if SalesInvHeader.FindSet then
                    repeat
                        SalesInvHeader.SecDepStatus := SecDepStatus;
                        SalesInvHeader.Modify;
                    until SalesInvHeader.Next = 0
            end;
        }
        field(60133; "Final Railway Bill Date"; Date)
        {
            Description = 'Added by Pranavi for sd status tracking';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                SalesInvHeader.Reset;
                SalesInvHeader.SetRange(SalesInvHeader."Order No.", "Order No.");
                SalesInvHeader.SetFilter(SalesInvHeader."No.", '<>%1', "No.");
                if SalesInvHeader.FindSet then
                    repeat
                        SalesInvHeader."Final Railway Bill Date" := "Final Railway Bill Date";
                        SalesInvHeader.Modify;
                    until SalesInvHeader.Next = 0
            end;
        }
        field(60134; Remarks; Text[200])
        {
            Description = 'Added by Pranavi for sd status tracking';
            Enabled = false;
            DataClassification = CustomerContent;
        }
        field(80000; "Order Released Date"; Date)
        {
            Caption = 'Order Released Date';
            Description = 'Added by Vishnu Priya for Sales Register Purpose';
            DataClassification = CustomerContent;
        }
        field(80005; "EMD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(80010; "PT Release Auth Stutus"; Enum "Sales invoice Header Enum10")
        {
            Description = 'Added by Pranavi for PT Authorizations';
            DataClassification = CustomerContent;

        }
        field(80011; "PT Post Auth Stutus"; Enum "Sales invoice Header Enum10")
        {
            Description = 'Added by Pranavi for PT Authorizations';
            DataClassification = CustomerContent;

        }
        field(80012; Order_After_CF_Integration; Boolean)
        {
            Description = 'Added by Pranavi for PT Authorizations';
            DataClassification = CustomerContent;
        }
        field(80014; "SD Fin Verification"; Enum "Sales invoice Header Enum11")
        {
            Description = 'Added by Vijaya for Finance Verification';
            DataClassification = CustomerContent;

        }
        field(80015; "Special Condition"; Boolean)
        {
            Description = 'Added by vijaya for Payment details Purpose';
            DataClassification = CustomerContent;
        }
        field(80016; Dispatched_packets_Qunatity; Integer)
        {
            Description = 'Added by Sujani For Dispatched Quantity in dispatch info Entry';
            DataClassification = CustomerContent;
        }
        field(80017; Vertical; Option)
        {
            Description = 'Added by Vijaya for Vertical information';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IOT,other;
            DataClassification = CustomerContent;
        }
        field(80018; "Port Code"; Text[6])
        {
            Description = 'Added by sujani for Export Bills';
            DataClassification = CustomerContent;
        }
        field(80019; "Dispatched Location name"; Code[50])
        {
            CalcFormula = Lookup("Employee Statistics Group"."Division Name" WHERE("Code" = FIELD("Dispatched Location")));
            Description = 'Added by sujani for location names in dispatch info entry';
            FieldClass = FlowField;
        }
        field(80020; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(80021; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
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
            // TableRelation = Division."Division Code";
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
        field(95402; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(95405; "Sell-to Address1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(95406; "Sell-to Address 21"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(95407; "Sell-to City1"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(95404; "Form No.1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {


    }

    var
        TempDocumentSendingProfile: Record "Document Sending Profile" temporary;
        ReportDistributionManagement: Codeunit "Report Distribution Management";
        Resource: Record Resource;
        "--ALE--": Integer;
        SalesInvHeader: Record "Sales Invoice Header";
        DuplicateIRNErr: Label 'Duplicate IRN.';
        NoActiveIRNErr: Label 'No active IRN found.';
        GetIRNFailedTxt: Label 'Unable to Get IRN, please try after some time.';
        IrnConfm: Label 'I have checked all GST values.';

    /* PROCEDURE GenerateEInvoice();
    VAR
        UnRegErr: Label 'ENU="You cannot generate e-Invoice for un-registered customer. "';
        ValidateEInvoiceRequest: Codeunit "Validate E-Invoice Request";
        EInvoiceMgmt: Codeunit "E-Invoice Mgmt.";
        EInvoiceEntry: Record "E-Invoice Entry";
    BEGIN
        //>>E-INV
        IF CONFIRM(IrnConfm, TRUE) THEN BEGIN
            IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "] THEN
                ERROR(UnRegErr);
            EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Invoice", "No.");
            IF EInvoiceEntry."IRN No." <> '' THEN
                ERROR(DuplicateIRNErr);
            ValidateEInvoiceRequest.CheckValidations(Rec);
            EInvoiceMgmt.SetSalesInvHeader(Rec);
            EInvoiceMgmt.RUN;
        END;
        //<<E-INV
    END;


    PROCEDURE CancelEInvoice();
    VAR
        ValidateEInvoiceRequest: Codeunit "Validate E-Invoice Request";
        EInvoiceMgmt: Codeunit "E-Invoice Mgmt.";
        UnRegErr: Label 'ENU="You cannot generate e-Invoice for un-registered customer. "';
        EInvoiceEntry: Record "E-Invoice Entry";
    BEGIN
        //>>E-INV
        IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "] THEN
            ERROR(UnRegErr);
        EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Invoice", "No.");
        IF EInvoiceEntry."IRN No." = '' THEN
            ERROR(NoActiveIRNErr);
        ValidateEInvoiceRequest.CheckCancelIRNValidaitons(Rec);
        EInvoiceMgmt.CancelIRN(Rec);
        //<<E-INV
    END;


    PROCEDURE GetEInvoiceByIRN();
    VAR
        UnRegErr: Label 'ENU="You cannot get e-Invoice for un-registered customer. "';
        EInvoiceMgmt: Codeunit "E-Invoice Mgmt.";
        EInvoiceEntry: Record "E-Invoice Entry";
    BEGIN
        //>>E-INV
        IF "GST Customer Type" IN ["GST Customer Type"::Unregistered, "GST Customer Type"::" "] THEN
            ERROR(UnRegErr);
        EInvoiceEntry.GET(EInvoiceEntry."Document Type"::"Sales Invoice", "No.");
        IF EInvoiceEntry."IRN No." = '' THEN
            ERROR(NoActiveIRNErr);
        IF EInvoiceEntry."Ack No." <> '' THEN
            EXIT;
        EInvoiceMgmt.SetSalesInvHeader(Rec);
        IF NOT EInvoiceMgmt.TriggerGetEInvoiceByIRNAdequare THEN
            MESSAGE(GetIRNFailedTxt);
        //<<E-INV
    END; */

}

