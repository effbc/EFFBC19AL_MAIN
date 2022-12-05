tableextension 70005 CustCustomerExt extends Customer
{

    fields
    {
        modify(Balance)
        {
            CaptionML = ENU = 'Balance';
        }
        modify("Balance (LCY)")
        {
            CaptionML = ENU = 'Balance (LCY)';
        }
        field(50001; "MSPT Code"; Code[20])
        {
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "MSPT Balance Due"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Cust. Ledg. Entry"."MSPT Amount" WHERE("Customer No." = FIELD("No."),
                                                                                  "MSPT Due Date" = FIELD("Date Filter"),
                                                                                  "Posting Date" = FIELD(UPPERLIMIT("Date Filter")),
                                                                                  "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(50010; "Make A Quote"; Boolean)
        {
            Description = 'B2BQTO';
            DataClassification = CustomerContent;
        }
        field(60090; "User Id"; Code[50])
        {
            Description = 'Rev01';
            Editable = false;
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(60091; "Customer Type"; Option)
        {
            OptionMembers = " ",Railway,Private;
            DataClassification = CustomerContent;
        }
        field(60093; CSBalance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("CSBalance Filter"),
                                                                                 "Initial Entry Global Dim. 1" = FILTER('CUS*'),
                                                                                 "Entry Type" = CONST("Initial Entry")));
            FieldClass = FlowField;
        }
        field(60094; SalBalance; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter"),
                                                                                 "Posting Date" = FIELD("SalBalance Filter"),
                                                                                 "Initial Entry Global Dim. 1" = FILTER('PRD-001' .. 'PRD-999'),
                                                                                 "Entry Type" = CONST("Initial Entry")));
            FieldClass = FlowField;
        }
        field(60095; "Tally Ref"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60096; "TAN Number"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60097; "Payment Realization Period"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(60098; "Payment Term Auth"; Option)
        {
            Description = 'added for credit PT Auth Status';
            OptionMembers = " ","Sent For Authorization",Authorized,Rejected;
            DataClassification = CustomerContent;
        }
        field(60099; Created_Date_Time; Date)
        {
            Description = 'added by sujani on 10-jul-18';
            DataClassification = CustomerContent;
        }
        field(60100; "GST TDS Number"; Code[40])
        {
            Description = 'Added By Vishnu Priya for TDS Claiming Process';
            DataClassification = CustomerContent;
        }
        field(60101; "E-Mail1"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(55064; "CSBalance Filter"; Date)  //EFFUPG1.2
        {

            Caption = 'CSBalance Filter';

            FieldClass = FlowFilter;
        }
        field(55065; "SalBalance Filter"; Date)  //EFFUPG1.2
        {

            Caption = 'SalBalance Filter';

            FieldClass = FlowFilter;
        }

    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        /* Rec.Created_Date_Time := Today;
        begin
            Subject := 'New Customer-' + Rec."No." + ' Created';
            Recipients.Add('erp@efftronics.com');
            Recipients.Add('sitarajyam@efftronics.com');

            Body += ('<html><body><table>');
            Body += ('<th>Customer Details</th>');
            Body += ('<tr><td> Customer No: </td><td>' + Rec."No." + '</td></tr>');
            Body += ('<tr><td>Name: </td><td>' + Rec.Name + '</td></tr>');
            Body += ('<tr><td>Created Date: </td><td>' + Format(Rec.Created_Date_Time) + '</td></tr>');
            Body += ('<tr><td>Created By: </td><td>' + UserId + '</td></tr>');
            Body += ('</table>');
            Body += ('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
            //Email.Send(EmailMessage);
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        end; */
    end;




    PROCEDURE DrillDownVendorBalance();
    VAR
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.Reset;
        VendLedgEntryLRec.SetCurrentKey("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SetRange("Vendor No.", "No.");
        if "Global Dimension 1 Filter" <> '' then
            VendLedgEntryLRec.SetFilter("Initial Entry Global Dim. 1", "Global Dimension 1 Filter");
        if "Global Dimension 2 Filter" <> '' then
            VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        if "Currency Filter" <> '' then
            VendLedgEntryLRec.SetRange("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if VendLedgEntryLRec.FindFirst then begin
            Clear(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SetTableView(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RunModal;
        end;
    END;


    PROCEDURE DrillDownVendorBalanceLCY();
    VAR
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.Reset;
        VendLedgEntryLRec.SetCurrentKey("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SetRange("Vendor No.", "No.");
        if "Global Dimension 1 Filter" <> '' then
            VendLedgEntryLRec.SetFilter("Initial Entry Global Dim. 1", "Global Dimension 1 Filter");
        if "Global Dimension 2 Filter" <> '' then
            VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        if "Currency Filter" <> '' then
            VendLedgEntryLRec.SetRange("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if VendLedgEntryLRec.FindFirst then begin
            Clear(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SetTableView(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RunModal;
        end;
    END;


    PROCEDURE DrillDownCSVendorBalance();
    VAR
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.Reset;
        VendLedgEntryLRec.SetCurrentKey("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SetRange("Vendor No.", "No.");
        VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 1", 'CUS-002', 'CUS-005');
        if "Global Dimension 2 Filter" <> '' then
            VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        if "Currency Filter" <> '' then
            VendLedgEntryLRec.SetRange("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if VendLedgEntryLRec.FindFirst then begin
            Clear(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SetTableView(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RunModal;
        end;
    END;


    PROCEDURE DrillDownRDVendorBalance();
    VAR
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.Reset;
        VendLedgEntryLRec.SetCurrentKey("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SetRange("Vendor No.", "No.");
        VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 1", 'RD-000', 'RD-010');
        if "Global Dimension 2 Filter" <> '' then
            VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        if "Currency Filter" <> '' then
            VendLedgEntryLRec.SetRange("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if VendLedgEntryLRec.FindFirst then begin
            Clear(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SetTableView(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RunModal;
        end;
    END;


    PROCEDURE DrillDownProdVendorBalance();
    VAR
        VendLedgEntriesFormLVar: Page "Detailed Vendor Ledg. Entries";
        VendLedgEntryLRec: Record "Detailed Vendor Ledg. Entry";
        StartDateLVar: Date;
        EndDateLVar: Date;
    BEGIN
        StartDateLVar := 20100401D;
        EndDateLVar := 20350331D;

        VendLedgEntryLRec.Reset;
        VendLedgEntryLRec.SetCurrentKey("Vendor No.", "Posting Date", "Initial Entry Global Dim. 1", "Initial Entry Global Dim. 2", "Currency Code");
        VendLedgEntryLRec.SetRange("Vendor No.", "No.");
        VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 1", 'PRD-0000', 'PRD-0999');
        if "Global Dimension 2 Filter" <> '' then
            VendLedgEntryLRec.SetRange("Initial Entry Global Dim. 2", "Global Dimension 2 Filter");
        if "Currency Filter" <> '' then
            VendLedgEntryLRec.SetRange("Currency Code", "Currency Filter");
        VendLedgEntryLRec.SetRange("Posting Date", StartDateLVar, EndDateLVar);
        if VendLedgEntryLRec.FindFirst then begin
            Clear(VendLedgEntriesFormLVar);
            VendLedgEntriesFormLVar.SetTableView(VendLedgEntryLRec);
            VendLedgEntriesFormLVar.RunModal;
        end;
    end;

    var
        Subject: Text[100];
        // Email: Codeunit Email;
        Body: Text;
        // EmailMessage: Codeunit "Email Message";
        Recipients: List of [Text];
}

