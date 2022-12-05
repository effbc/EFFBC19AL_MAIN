pageextension 70277 PostedPurchaseReceiptExt extends 136
{
    layout
    {
        modify("Pay-to Vendor No.")
        {
            trigger OnBeforeValidate()
            begin
                IF (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA']) THEN
                    VEND.RESET;
                VEND.SETFILTER("No.", Rec."Pay-to Vendor No.");
                IF VEND.FINDFIRST THEN BEGIN
                    Rec."Pay-to Contact no." := VEND.Contact;
                    Rec."Pay-to Name" := VEND.Name;
                    Rec."Pay-to Address" := VEND.Address;
                    Rec."Pay-to Post Code" := VEND."Post Code";
                    Rec."Pay-to City" := VEND.City;

                END;
            end;
        }
        modify("Pay-to Post Code")
        {
            Caption = 'Pay-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code/City';
        }
        addafter("Buy-from Contact")
        {
            field("Bill Received"; Rec."Bill Received")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    IF NOT (USERID IN ['EFFTRONICS\MARY', 'EFFTRONICS\VARALAKSHMI', 'EFFTRONICS\PADMASRI', 'EFFTRONICS\PARDHU', 'EFFTRONICS\VISHNUPRIYA',
                            'EFFTRONICS\ANANDA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\PSUNITHA', 'EFFTRONICS\20TE061',
                            'EFFTRONICS\GRAVI', 'EFFTRONICS\NSUDHEER']) THEN
                        ERROR('You Do not have permission!');
                    IF Rec."Bill Received" = True THEN
                        "Bill ReceivedEditable" := FALSE
                    ELSE
                        "Bill ReceivedEditable" := TRUE;


                end;
            }
            field("Created Date Time"; Rec."Created Date Time")
            {
                Caption = 'Created Date Time';
                Editable = false;
                ApplicationArea = All;
            }
        }
        addbefore(PurchReceiptLines)
        {
            field("User ID"; Rec."User ID")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Pay-to Contact")
        {
            field("Vend. Excise Inv. Date"; Rec."Vend. Excise Inv. Date")
            {
                ApplicationArea = All;

            }
            field("Vendor Excise Invoice No."; Rec."Vendor Excise Invoice No.")
            {
                ApplicationArea = All;

            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Bill Transfered"; Rec."Bill Transfered")
            {
                Editable = "Bill TransferedEditable";
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    // TESTFIELD(USERID,93fd001);
                    IF NOT (USERID IN ['EFFTRONICS\RATNA', 'EFFTRONICS\MARY', 'EFFTRONICS\ASWINI', 'EFFTRONICS\PARDHU', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\MBNAGAMANI', 'EFFTRONICS\SUJITH', 'EFFTRONICS\RAJANI', 'EFFTRONICS\BLAVANYA',
                      'EFFTRONICS\CHRAJYALAKSHMI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\20TE061', 'EFFTRONICS\GRAVI', 'EFFTRONICS\NSUDHEER', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                        ERROR('You Do not have permission!');

                    IF Rec."Bill Received" = false THEN
                        ERROR('Please chek on Bill Receive to Transfer');
                    /* charline := 10;
                   body := '';
                   PRL.SETRANGE(PRL."Document No.", "No.");
                   PRL.SETFILTER(PRL.Quantity, '<>%1', 0);
                   IF PRL.FINDSET THEN
                       Mail_Subject := 'Bill Transfered For Receipt ' + "No.";
                   bodies := 1;
                   body += 'Auto Mail Generated from ERP ';
                   body += FORMAT(charline);
                   body += 'DETAILS  ';
                   body += FORMAT(charline);
                   body += FORMAT(charline);
                   body += 'Receipt No.      : ' + "No.";
                   body += FORMAT(charline);
                   body += FORMAT(charline);
                   REPEAT
                       IF (STRLEN(body) > 800) THEN BEGIN
                           Mail_Body[bodies] := body;
                           bodies += 1;
                           body := '';
                       END;

                       body += 'Item Name        : ' + PRL.Description;
                       body += FORMAT(charline);
                       body += 'Quantity         : ' + FORMAT(PRL.Quantity);
                       body += FORMAT(charline);
                       body += 'Unit Of Measure  : ' + PRL."Unit of Measure";
                       body += FORMAT(charline);
                       body += 'Unit Price       : ' + FORMAT(PRL."Unit Cost");
                       body += FORMAT(charline);
                       body += FORMAT(charline);
                       IF (STRLEN(body) > 800) THEN BEGIN
                           Mail_Body[bodies] := body;
                           bodies += 1;
                           body := '';
                       END;

                   UNTIL PRL.NEXT = 0;

                   user.SETRANGE(user."User ID", USERID);
                   IF user.FINDFIRST THEN
                       "from Mail" := user.MailID;
                   "to mail" := 'dmadhavi@efftronics.com,anilkumar@efftronics.com';
                   IF ("from Mail" <> '') AND ("to mail" <> '') THEN  */
                    //  mail.NewCDOMessage("from Mail","to mail",Mail_Subject,body,'');
                    IF Rec."Bill Transfered" = true THEN
                        "Bill TransferedEditable" := FALSE
                    ELSE
                        "Bill TransferedEditable" := TRUE;
                end;
            }
            field("Bill Transfered Date"; Rec."Bill Transfered Date")
            {
                ApplicationArea = All;

            }
            field(Pending; Rec.Pending)
            {
                ApplicationArea = All;

            }
            field("<Vendor Order No.2>"; Rec."Vendor Order No.")
            {
                ApplicationArea = All;

            }
            field("Currency Factor"; Rec."Currency Factor")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("Currency Code"; Rec."Currency Code")
            {
                ApplicationArea = All;

            }
        }
        addafter("Ship-to Contact")
        {
            field("Packint Type"; Rec."Packint Type")
            {
                ApplicationArea = All;

            }
            field("<Created Date Time2>"; Rec."Created Date Time")
            {
                ApplicationArea = All;

            }
        }
        addafter("Expected Receipt Date")
        {
            field(Remarks; Rec.Remarks)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        addbefore("&Print")
        {
            group("I&nspection")
            {
                Caption = 'I&nspection';
                action("Inspection Data Sheets")
                {
                    Caption = 'Inspection Data Sheets';
                    RunObject = Page "Inspection Data Sheet List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Order No." = FIELD("Order No.");
                    ApplicationArea = All;
                }
                action("Posted Inspection Data Sheets")
                {
                    Caption = 'Posted Inspection Data Sheets';
                    RunObject = Page "Posted Inspect Data Sheet List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Order No." = FIELD("Order No.");
                    ApplicationArea = All;
                }
                action("I&nspection Receipts")
                {
                    Caption = 'I&nspection Receipts';
                    //RunObject = Page "Inspection Receipt List";
                    Runobject = Page 33000271;
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Order No." = FIELD("Order No."), Status = FILTER(false);
                    ApplicationArea = All;
                }
                action("Posted I&nspection Receipts")
                {
                    Caption = 'Posted I&nspection Receipts';
                    RunObject = Page "Inspection Receipt List";
                    RunPageView = SORTING("Rework Level");
                    RunPageLink = "Order No." = FIELD("Order No."), Status = FILTER(<> false);
                    ApplicationArea = All;
                }
                separator(Action1102152012)
                {

                }
                action("QC Override")
                {
                    Caption = 'QC Override';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        QcOverrideCheck := TRUE;
                        CurrPage.PurchReceiptLines.PAGE.QcOverRide;
                    end;
                }
            }
        }
        addafter("&Navigate")
        {
            action(FwdToCashFlow)
            {
                Caption = 'Forward To CashFlow';
                ApplicationArea = All;
                trigger OnAction()
                var
                    Dept: Code[10];
                    Vend: Record Vendor;
                begin
                    IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI'] THEN
                        SQLInt.Purch_Receipt_in_CF(Rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS']) THEN BEGIN
            IF Rec."Bill Transfered" = True then//"Bill Transfered"::"1" THEN
                "Bill TransferedEditable" := FALSE
            ELSE
                "Bill TransferedEditable" := TRUE;

            IF Rec."Bill Received" = True THEN
                "Bill ReceivedEditable" := FALSE
            ELSE
                "Bill ReceivedEditable" := TRUE;
        END ELSE
            "Bill ReceivedEditable" := TRUE;
        //RESET;

        //edit resrtictins
        IF USERID IN ['EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\SUJANI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\B2BOTS', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            EditControlling := TRUE
        ELSE
            EditControlling := FALSE;
    end;

    trigger OnAfterGetRecord()
    begin
        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS']) THEN BEGIN
            IF Rec."Bill Transfered" = true THEN
                "Bill TransferedEditable" := FALSE
            ELSE
                "Bill TransferedEditable" := TRUE;

            IF Rec."Bill Received" = true THEN
                "Bill ReceivedEditable" := FALSE
            ELSE
                "Bill ReceivedEditable" := TRUE;
        END;
    end;

    var
        "--QC--": Integer;
        InspectReportHeader: Record "Inspection Receipt Header";
        QcOverrideCheck: Boolean;
        t1: Label 'not possible';
        PRL: Record "Purch. Rcpt. Line";
        user: Record User;
        "from Mail": Text[500];
        "to mail": Text[1000];
        Mail_Subject: Text[1000];
        Mail_Body: ARRAY[5] OF Text[1000];
        //   mail: Codeunit 397;
        charline: Char;
        bodies: Integer;
        body: Text[1000];
        SMTPSETUP: Record "SMTP SETUP";
        AttachFileName: Text[30];

        "Bill TransferedEditable": Boolean;
        "Bill ReceivedEditable": Boolean;

        "G|l": Record "General Ledger Setup";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        SQLQuery: Text;
        SQLInt: Codeunit SQLIntegration;
        VEND: Record Vendor;
        EditControlling: Boolean;

}