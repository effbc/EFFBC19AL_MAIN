table 60068 "Tender Header Archive"
{
    // version B2B1.0,Rev01

    DrillDownPageID = "Archived Tender list";
    LookupPageID = "Archived Tender list";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Tender No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Tender Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(4; "Customer Name"; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; "Customer Name 2"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Customer Address"; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Customer Address 2"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; City; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Customer Contact"; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Post Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(11; Country; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(12; "Country Code"; Code[10])
        {
            Editable = false;
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(13; Territory; Code[10])
        {
            TableRelation = Territory;
            DataClassification = CustomerContent;
        }
        field(14; State; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(15; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16; "Telex No."; Text[20])
        {
            Caption = 'Telex No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(17; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(18; "E-Mail"; Text[80])
        {
            Caption = 'E-Mail';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(20; "Salesperson Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" WHERE("Salesperson/Purchaser" = CONST(Sale));
            DataClassification = CustomerContent;
        }
        field(21; "Minimum Bid Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(37; "Document Position"; Option)
        {
            OptionMembers = CRM,Sales,Design;
            DataClassification = CustomerContent;
        }
        field(51; "Customer Tender No."; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(52; "Tender Dated"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(53; "Tender doc Issue From"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(54; "Tender doc Issue To"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(55; "Submission Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(56; "Submission Due Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(57; "Tech. Bid Opening Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(58; "Tech. Bid Opening Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(59; "Commercial Bid Opening Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Commercial Bid Opening Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(61; "Tender Status"; Option)
        {
            OptionCaption = '" ,Open,Postponed,Received,Cancelled,Lost,Expected"';
            OptionMembers = " ",Open,Postponed,Received,Cancelled,Lost,Expected;
            DataClassification = CustomerContent;
        }
        field(62; "Tender Submitted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(63; "Not Participated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(64; "Supporting Tender"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(65; "Tender Dispatch Details"; Option)
        {
            OptionMembers = Courier,Postal,"Other Sources";
            DataClassification = CustomerContent;
        }
        field(66; "Tender Source"; Option)
        {
            OptionMembers = "News Paper","Web portal",Others;
            DataClassification = CustomerContent;
        }
        field(67; "Tender Source Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(68; "Tender Source Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(69; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Release;
            DataClassification = CustomerContent;
        }
        field(70; "Tender Realized/Not Realized"; Option)
        {
            OptionMembers = Realized,"Not Realized";
            DataClassification = CustomerContent;
        }
        field(71; "Standard/Customize"; Option)
        {
            OptionMembers = Standard,Customize;
            DataClassification = CustomerContent;
        }
        field(72; "Tender Quote Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(73; "Tender Application Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(74; "Tender Application No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(81; "Tender Posting Group"; Code[20])
        {
            TableRelation = "Tender Posting Groups".Code;
            DataClassification = CustomerContent;
        }
        field(101; "EMD Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(102; "EMD Mode of Payment"; Option)
        {
            OptionMembers = Cash,FDR,DD,Cheque,Others;
            DataClassification = CustomerContent;
        }
        field(104; "EMD Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(105; "EMD Received Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(106; "EMD Status"; Option)
        {
            Editable = false;
            OptionMembers = " ",Received,"Not Received","Partially Received","Adjusted against Security Deposited";
            DataClassification = CustomerContent;
        }
        field(107; "EMD Requested Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(108; "EMD Required Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(109; "EMD DD No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(110; "EMD Paid Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    "Transaction Type" = CONST(Payment),
                                                                    Type = CONST(EMD)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(111; "EMD Received Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    "Transaction Type" = CONST(Receipt),
                                                                    Type = CONST(EMD)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(112; "EMD Adjusted Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(EMD),
                                                                    "Transaction Type" = CONST(Adjustment)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(113; "EMD Write off Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(EMD),
                                                                    "Transaction Type" = CONST("Write off")));
            FieldClass = FlowField;
        }
        field(131; "Security Mode of Payment"; Option)
        {
            OptionMembers = Cash,BG,FDR,DD,Cheque,Others;
            DataClassification = CustomerContent;
        }
        field(132; "Security Deposit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(133; "Deposit Payment Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(134; "Deposit Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(135; "Security Deposit Status"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(136; "SD Requested Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(137; "SD Required Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(138; "SecurityDeposit Exp. Rcpt Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(139; "SD Net Pay"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(140; "Mode of Receipt"; Option)
        {
            OptionMembers = Cash,Cheque,DD,FDR;
            DataClassification = CustomerContent;
        }
        field(142; "Received Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(144; "Balance Receivable"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(148; "Adjusted from EMD"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    "Transaction Type" = CONST(Adjustment)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(149; "Adjusted from Running Bills"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(150; "SD Paid Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(SD),
                                                                    "Transaction Type" = CONST(Payment)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(151; "SD Received Amount"; Decimal)
        {
            CalcFormula = Sum("Tender Ledger Entries".Amount WHERE("Tender No." = FIELD("Tender No."),
                                                                    Type = CONST(SD),
                                                                    "Transaction Type" = CONST(Receipt)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(201; "Doc. No. Occurrence"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(202; "Version No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(203; "No. of Archived Versions"; Integer)
        {
            Caption = 'No. of Archived Versions';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(204; "Product Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(205; "No. of Sales Order"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Tender No." = FIELD("Tender No.")));
            FieldClass = FlowField;
        }
        field(206; "No. of Posted Sales Order"; Integer)
        {
            CalcFormula = Count("Sales Shipment Header" WHERE("Tender No." = FIELD("Tender No.")));
            FieldClass = FlowField;
        }
        field(301; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(501; "Application Cost Post"; Boolean)
        {
            Description = 'for checking the Application cost posting';
            DataClassification = CustomerContent;
        }
        field(502; "EMD Amount Post"; Boolean)
        {
            Description = 'for checking the EMD Amount posting';
            DataClassification = CustomerContent;
        }
        field(503; "SD Amount Post"; Boolean)
        {
            Description = 'for checking the SD Amount posting';
            DataClassification = CustomerContent;
        }
        field(5044; "Time Archived"; Time)
        {
            Caption = 'Time Archived';
            DataClassification = CustomerContent;
        }
        field(5045; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
            DataClassification = CustomerContent;
        }
        field(5046; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            Description = 'Rev01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60000; "Tender Position"; Option)
        {
            Description = 'B2B EFF';
            OptionCaption = '" ,L1,L2,L3,L4"';
            OptionMembers = " ",L1,L2,L3,L4;
            DataClassification = CustomerContent;
        }
        field(60123; "Sent For Auth"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60124; TenderType; Option)
        {
            Description = 'Added by Pranavi';
            OptionCaption = 'Sale,AMC,LMD,EffeHyd';
            OptionMembers = Sale,AMC,LMD,EffeHyd;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Version No.", "Tender No.")
        {
        }
    }

    fieldgroups
    {
    }
}

