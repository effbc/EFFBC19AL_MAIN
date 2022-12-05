tableextension 70007 CustVendorExt extends Vendor
{
    fields
    {
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT 1.0';
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT 1.0';
            DataClassification = CustomerContent;
        }
        field(50003; "MSPT Balance Due"; Decimal)
        {
            CalcFormula = - Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Amount" WHERE("Vendor No." = FIELD("No."),
                                                                                    "MSPT Due Date" = FIELD("Date Filter"),
                                                                                    "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                    "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                    "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                    "Currency Code" = FIELD("Currency Filter")));
            Description = 'MSPT1.0';
            FieldClass = FlowField;
        }
        field(50004; "Tally Reference"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60001; "Address 3"; Text[70])
        {
            DataClassification = CustomerContent;
        }
        field(60085; Type; Enum "Vendor Enum")
        {
            DataClassification = CustomerContent;

        }
        field(60086; "Updated in Cashflow"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60087; "Standard Insurnece %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60088; "Consider Vendor Invoice Date"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60089; "Standard Packing %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60090; "User Id"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60091; "First Order Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60101; "Personal Account"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60102; "Vendor Balance Verified"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60103; "Prod Vendor Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FILTER('PRD-0000' .. 'PRD-0999')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60104; "CS Vendor Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FILTER('CUS-002' .. 'CUS-005')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60105; "RD Vendor Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FILTER('RD-000' .. 'RD-010')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60106; category; Enum "Vendor category")
        {
            DataClassification = CustomerContent;

        }
        field(60107; "Mobile No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60108; "Name of Bank"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60109; "Branch Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60110; "RTGS Code"; Code[15])
        {
            DataClassification = CustomerContent;
        }
        field(60111; "Phone No2"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60112; "Phone No3"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60113; "Phone No4"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60114; "C-Form"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60115; "Admin Vendor Balance"; Decimal)
        {
            CalcFormula = - Sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" WHERE("Vendor No." = FIELD("No."),
                                                                                   "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                   "Currency Code" = FIELD("Currency Filter"),
                                                                                   "Posting Date" = FIELD("Date Filter"),
                                                                                   "Initial Entry Global Dim. 1" = FILTER('ADMIN-0002')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70001; "Vendor Opening Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Durga maheswari';
        }
        field(70002; "Vendor Closing Balance"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Durgamaheswari';
        }
        field(80000; "Excise Registration No.2"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(80001; "VAT Business Posting Group 2"; Code[10])
        {
            TableRelation = "VAT Business Posting Group".Code;
            DataClassification = CustomerContent;
        }
        field(80002; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(80003; "TAN Number"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(80005; "TDS Alert"; Boolean)
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(80006; "Telex No.1"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(80007; "E-Mail1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(33000250; "Rework Location"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(33000251; "Need to send Mail"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000252; "Way bill Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000253; "Mail Required"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000254; "Send Mail"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000255; "T.I.N Status"; Enum "Vendor TIN Status")
        {
            DataClassification = CustomerContent;

        }
        field(33000256; "Vendor Category"; Enum "Vendor Category1")
        {
            DataClassification = CustomerContent;

        }
        field(33000257; "Vendor Status"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000258; "Transportation Days"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000259; "Online Vendor"; Boolean)
        {
            Description = 'Added on 19-12-2017 Inorder to have Online/Offline vendor Segregation';
            DataClassification = CustomerContent;
        }
        field(33000260; "GST Verification"; Boolean)
        {
            Description = 'Added on 23-05-2018 for GST Verification';
            DataClassification = CustomerContent;
        }
        field(33000261; Created_Date_time; Date)
        {
            Description = 'added on 10-jul-18 by sujani';
            DataClassification = CustomerContent;
        }
        field(33000262; "Minimum Order Value"; Decimal)
        {
            Description = 'added on 14-dec-18 by sujani';
            DataClassification = CustomerContent;
        }
        field(33000263; "No Of POs"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE("Buy-from Vendor No." = FIELD("No."),
                                                         "Document Type" = CONST(Order)));
            Description = 'Added by Vishnu on 10-06-2019';
            FieldClass = FlowField;
        }
        field(33000264; Maintenacecommonmail; Boolean)
        {
            Description = 'Added by Vishnu on 03-07-2019';
            DataClassification = CustomerContent;
        }
        field(33000265; "Maanager Approved"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu on 12-11-2020';
        }
        field(33000266; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Description = 'Added by Vishnu on 12-11-2020';
        }
        field(33000267; Purchase_Finance; Enum "Purchase_Finance Enum")
        {
            DataClassification = CustomerContent;

        }
        field(58005; Vendor_Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ',Manufacturer,Trader,Authorized distributor,Online Supplier,Survice Provider';
            OptionMembers = " ",Manufacturer,Trader,"Authorized distributor","Online Supplier","Survice Provider";
        }

        field(33000268; "swift Code"; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(33000269; "Bank Address"; Text[50])
        {
            DataClassification = CustomerContent;

        }


    }
    trigger OnAfterInsert()
    var
        myInt: Integer;
    begin
        Rec.Created_Date_time := Today;
        /*
         begin
             Subject := 'New Vendor -' + Rec."No." + ' -Added ';
             Recipients.Add('erp@efftronics.com');
             Recipients.Add('sitarajyam@efftronics.com');


             Body += ('<html><body><table>');
             Body += ('<th>Vendor Details</th>');
             Body += ('<tr><td>Vendor No</td><td>' + Rec."No." + '</td></tr>');
             Body += ('<tr><td>Vendor Name</td><td>' + Rec.Name + '</td></tr>');
             Body += ('<tr><td>Created Date</td><td>' + Format(Rec.Created_Date_time) + '</td></tr>');
             Body += ('<tr><td>Created By </td<td>' + UserId + '</td></tr>');
             Body += ('</table>');
             Body += ('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
             EmailMessage.Create(Recipients, Subject, Body, true);
             Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

         end; */
    end;


    trigger OnBeforeInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";

    begin
        IF NOT (USERID IN ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\RAJANI', 'EFFTRONICS\ASWINI', 'EFFTRONICS\SUJITH', 'EFFTRONICS\BLAVANYA', 'EFFTRONICS\ANANDA', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\SUVARCHALADEVI']) THEN
            Error('You have no rights to create new Vendor');                                  //Added by Pranavi for Rights for mss.Sitarajyam,rajani on 30-07-2015

        if "No." = '' then begin
            PurchSetup.Get;
            PurchSetup.TestField("Vendor Nos.");
        end;
    end;

    trigger OnBeforeDelete()
    var
        myInt: Integer;
    begin
        if not (UserId in ['EFFTRONICS\ANILKUMAR', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) then
            Error('You have no rights to delete Vendor');

    end;

    procedure DrillDownProdVendorBalance()
    var
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    begin
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.RESET;
        VendLedgEntryLRec.SETCURRENTKEY("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SETRANGE("Vendor No.", "No.");
        VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 1", 'PRD-0000', 'PRD-0999');
        IF "Global Dimension 2 Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        IF "Currency Filter" <> '' THEN
            VendLedgEntryLRec.SETRANGE("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SETRANGE("Posting Date", StartDateLVar, EndDateLVar);
        IF VendLedgEntryLRec.FINDFIRST THEN BEGIN
            CLEAR(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SETTABLEVIEW(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RUNMODAL;
        END;
    end;

    var
        Subject: Text[100];

        Body: Text;
        Recipients: List of [Text];
    //  EmailMessage: Codeunit "Email Message";
    // Email: Codeunit Email;
}

