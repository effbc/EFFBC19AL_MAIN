pageextension 70122 PostedSalesShipmentExt extends "Posted Sales Shipment"
{
    layout
    {
        modify("Sell-to Post Code")
        {
            Caption = 'Sell-to Post Code/City';
        }
        modify("Bill-to Post Code")
        {
            Caption = 'Bill-to Post Code/City';
        }
        modify("Ship-to Post Code")
        {
            Caption = 'Ship-to Post Code/City';
        }
        addbefore("Posting Date")
        {
            /*field("Form Code"; "Form Code")
            {
                ApplicationArea = All;
            }
            field("Form No."; "Form No.")
            {
                ApplicationArea = All;
            }*/
        }
        addafter("Responsibility Center")
        {
            field("Order Date"; Rec."Order Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Bill-to Contact")
        {
            field("Customer OrderNo."; Rec."Customer OrderNo.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
        addafter("Shipment Date")
        {
            group(Others)
            {
                Caption = 'Others';
                field("RDSO Charges"; Rec."RDSO Charges")
                {
                    ApplicationArea = All;
                }
                field("RDSO Charges Paid By."; Rec."RDSO Charges Paid By.")
                {
                    ApplicationArea = All;
                }
                field("<Customer OrderNo.2>"; Rec."Customer OrderNo.")
                {
                    ApplicationArea = All;
                }
                field("Customer Order Date"; Rec."Customer Order Date")
                {
                    ApplicationArea = All;
                }
                field("Tender No."; Rec."Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Security Deposit Amount"; Rec."Security Deposit Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("LD Amount"; Rec."LD Amount")
                {
                    ApplicationArea = All;
                }
                field("Document Position"; Rec."Document Position")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection Required"; Rec."RDSO Inspection Required")
                {
                    ApplicationArea = All;
                }
                field("RDSO Inspection By"; Rec."RDSO Inspection By")
                {
                    ApplicationArea = All;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                }
            }
            group("Security Deposit")
            {
                Caption = 'Security Deposit';
                field(Control1102152030; Rec."Security Deposit")
                {
                    ApplicationArea = All;
                }
                field("SD Status"; Rec."SD Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("CA Number"; Rec."CA Number")
                {
                    ApplicationArea = All;
                }
                field("SD Required Date"; Rec."SD Required Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SD Requested Date"; Rec."SD Requested Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Security Deposit Status"; Rec."Security Deposit Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deposit Payment Due Date"; Rec."Deposit Payment Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Final Bill Date"; Rec."Final Bill Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Warranty Period"; Rec."Warranty Period")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Deposit Payment Date"; Rec."Deposit Payment Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("SecurityDeposit Exp. Rcpt Date"; Rec."SecurityDeposit Exp. Rcpt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        modify(Statistics)
        {
            Promoted = true;
        }
        modify(PrintCertificateofSupply)
        {
            Promoted = false;
        }
        modify("&Print")
        {
            Promoted = true;
        }
        modify("&Navigate")
        {
            Promoted = true;
        }
        addafter("&Track Package")
        {
            action(Attachments)
            {
                Caption = 'Attachments';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    CustAttach.RESET;
                    CustAttach.SETRANGE("Table ID", DATABASE::"Sales Header");
                    CustAttach.SETRANGE("Document No.", Rec."Order No.");
                    //CustAttach.SETRANGE("Document Type","Document Type");

                    PAGE.RUN(PAGE::"ESPL Attachments", CustAttach);
                end;
            }
        }
        addafter("&Navigate")
        {
            action("Adjust for CS")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    // Added by Rakesh on 24-May-14
                    /*
                    IF ((TODAY-"Posting Date") > 5) THEN
                      ERROR('Items are not allowed to move for previous posting dates');
                    */
                    IF ("Sell-to Customer No." = 'CUST02293') OR ("Sell-to Customer No." = 'CUST00536') THEN
                                 BEGIN
                        SSH.RESET;
                        SSH.SETRANGE(SSH."Sell-to Customer No.", Rec."Sell-to Customer No.");
                        SSH.SETRANGE(SSH."Posting Date", Rec."Posting Date");
                        SSH.SETRANGE(SSH."Order No.", Rec."Order No.");
                        SSH.SETRANGE(SSH."External Document No.", Rec."External Document No.");
                        IF SSH.FINDFIRST THEN BEGIN
                            SSL.RESET;
                            SSL.SETRANGE(SSL."Document No.", SSH."No.");
                            SSL.SETFILTER(SSL.Quantity, '>%1', 0);
                            IF SSL.FINDSET THEN
                                    REPEAT
                                        SerialNos := '';
                                        ILE.RESET;
                                        ILE.SETFILTER(ILE."Document No.", SSL."Document No.");
                                        ILE.SETFILTER(ILE."Item No.", SSL."No.");
                                        IF ILE.FINDFIRST THEN
                                            REPEAT
                                                    ILE2.RESET;
                                                ILE2.SETFILTER(ILE2."Item No.", ILE."Item No.");
                                                ILE2.SETFILTER(ILE2."Serial No.", ILE."Serial No.");
                                                ILE2.SETFILTER(ILE2."Lot No.", ILE."Lot No.");
                                                ILE2.SETRANGE(ILE2."Posting Date", ILE."Posting Date");
                                                ILE2.SETRANGE(ILE2."Entry Type", ILE2."Entry Type"::"Positive Adjmt.");
                                                ILE2.SETRANGE(ILE2."Location Code", 'CS');
                                                ILE2.SETRANGE(ILE2."Global Dimension 2 Code", 'H-OFF');
                                                // IF NOT (ILE2.COUNT=2) THEN
                                                IF ILE2.FINDFIRST THEN BEGIN
                                                    //MESSAGE('The Item '+ILE."Item No."+' are already moved to CS location')
                                                END
                                                ELSE BEGIN
                                                    IF SerialNos = '' THEN
                                                        SerialNos := ILE."Serial No."
                                                    ELSE
                                                        SerialNos := SerialNos + '|' + ILE."Serial No.";
                                                END;
                                            UNTIL ILE.NEXT = 0;
                                        IF SerialNos <> '' THEN
                                            Item_Positive_Adjustment1(ILE."Item No.", SerialNos, 'H-OFF', SSL."Document No.", SSL.Quantity);
                                    UNTIL SSL.NEXT = 0;
                        END
                    END
                    ELSE
                        ERROR('This action is applicable only for Internal sale orders');
                    // end by Rakesh

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Added by Vishnu Priya
        IF MAIL.Permission_Checking(USERID, 'ERP-ADMIN') THEN
            CurrPage.EDITABLE(TRUE)
        ELSE
            CurrPage.EDITABLE(FALSE);
        // ended by Vishnu Priya on 04-June-18.
    end;

    var
        CustAttach: Record Attachments;
        ILE21: Record "Item Ledger Entry";
        ILE1: Record "Item Ledger Entry";
        SSH: Record "Sales Shipment Header";
        SSL: Record "Sales Shipment Line";
        SerialNos: Text;
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        MAIL: Codeunit "Custom Events";





    //trigger OnOpenPage();
    //>>>> ORIGINAL CODE:
    //begin
    /*
    SetSecurityFilterOnRespCenter;
    */
    //end;
    //>>>> MODIFIED CODE:
    //begin
    /*
    //SetSecurityFilterOnRespCenter;

    //Added by Vishnu Priya
    IF SMTP_MAIL.Permission_Checking(USERID,'ERP-ADMIN') THEN
      CurrPage.EDITABLE(TRUE)
    ELSE CurrPage.EDITABLE(FALSE);
    // ended by Vishnu Priya on 04-June-18.
    */
    //end;


    procedure Item_Positive_Adjustment("Item No.": Code[20]; "Serial No.": Code[20]; "Location Code": Code[10]);
    var
        "Item Journal Line": Record "Item Journal Line";
        "Reservation Entry": Record "Reservation Entry";
        "Reservation Entry1": Record "Reservation Entry";
        NoSeriesMgt: Codeunit 396;
        "Item Ledger Entry": Record "Item Ledger Entry";
    begin
        //Deleted Var (Journal Line DimensionRecordTable356) B2B
        "Item Ledger Entry".RESET;
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF NOT "Item Ledger Entry".FIND('-') THEN BEGIN
            // INSERTING RECORD IN ITEM JOURNAL LINE
            "Item Journal Line".INIT;
            "Item Journal Line"."Journal Template Name" := 'ITEM';
            "Item Journal Line"."Journal Batch Name" := 'POS-CS-SIG';
            "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";
            "Item Journal Line"."Line No." := 10000;
            "Item Journal Line"."Source Code" := 'ITEMJNL';
            //"Item Journal Line"."Serial No.":="Serial No.";
            //"Item Journal Line"."Lot No.":=ICNNO(TODAY)+'SA01';
            "Item Journal Line"."Document No." := NoSeriesMgt.GetNextNo('POS-ADJ-CS', TODAY, FALSE);
            "Item Journal Line".VALIDATE("Item Journal Line"."Item No.", "Item No.");
            "Item Journal Line".VALIDATE(Quantity, 1);
            "Item Journal Line".VALIDATE("Location Code", 'CS');
            "Item Journal Line".VALIDATE("Shortcut Dimension 2 Code", "Location Code");
            "Item Journal Line"."User ID" := USERID;
            "Item Journal Line"."Document Date" := TODAY;
            "Item Journal Line".INSERT;


            // INSERTING RECORD IN RESERVATION ENTRY
            "Reservation Entry".INIT;
            IF "Reservation Entry1".FIND('+') THEN
                "Reservation Entry"."Entry No." := "Reservation Entry1"."Entry No." + 1;
            "Reservation Entry".VALIDATE("Item No.", "Item No.");
            "Reservation Entry".VALIDATE("Location Code", 'CS');
            "Reservation Entry".VALIDATE("Quantity (Base)", 1);
            "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
            "Reservation Entry"."Creation Date" := TODAY;
            "Reservation Entry"."Source Type" := 83;
            "Reservation Entry"."Source Subtype" := 2;
            "Reservation Entry"."Source ID" := 'ITEM';
            "Reservation Entry"."Source Batch Name" := 'POS-CS-SIG';
            "Reservation Entry"."Source Ref. No." := 10000;
            "Reservation Entry"."Created By" := 'SUPER';
            "Reservation Entry".Positive := TRUE;
            "Reservation Entry"."Expected Receipt Date" := TODAY;
            "Reservation Entry".VALIDATE("Serial No.", "Serial No.");
            "Reservation Entry"."Lot No." := ICNNO(TODAY) + 'SA01';
            //"Reservation Entry".Quantity:=1;
            "Reservation Entry".INSERT;


            /*  // INSERTING JOURNAL LINE DIMENSION
              "Journal Line Dimension".INIT;
              "Journal Line Dimension"."Table ID":=83;
              "Journal Line Dimension"."Journal Template Name":='ITEM';
              "Journal Line Dimension"."Journal Batch Name":='POS-CS-SIG';
              "Journal Line Dimension"."Journal Line No.":=10000;
              "Journal Line Dimension"."Dimension Code":='LOCATIONS';
              "Journal Line Dimension"."Dimension Value Code":="Location Code";
              "Journal Line Dimension".INSERT;*/
        END ELSE
            ERROR(' ITEM WAS ALLREADY AVAILABLE IN INVENTORY');


        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", "Item Journal Line");

    end;

    procedure ICNNO(DT: Date) ICN: Code[10];
    var
        Dat: Text[30];
        Mon: Text[30];
        Year: Text[30];
    begin
        IF DATE2DMY(DT, 1) < 10 THEN
            Dat := '0' + FORMAT(DATE2DMY(DT, 1))
        ELSE
            Dat := FORMAT(DATE2DMY(DT, 1));

        IF DATE2DMY(DT, 2) < 10 THEN
            Mon := '0' + FORMAT(DATE2DMY(DT, 2))
        ELSE
            Mon := FORMAT(DATE2DMY(DT, 2));

        //IF DATE2DMY(DT,2) < 10 THEN
        Year := COPYSTR(FORMAT(DATE2DMY(DT, 3)), 3, 2);
        ICN := Dat + Mon + Year;
        EXIT(ICN);
    end;

    procedure Item_Positive_Adjustment1("Item No.": Code[20]; "Serial No.": Text; "Location Code": Code[10]; DocumentNo: Code[30]; ItmQty: Decimal);
    var
        "Item Journal Line": Record "Item Journal Line";
        "Reservation Entry": Record "Reservation Entry";
        "Reservation Entry1": Record "Reservation Entry";
        NoSeriesMgt: Codeunit 396;
        "Item Ledger Entry": Record "Item Ledger Entry";
    begin
        //Deleted Var (Journal Line DimensionRecordTable356) B2B
        "Item Ledger Entry".RESET;
        "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Item No.",
                                          "Item Ledger Entry"."Lot No.",
                                          "Item Ledger Entry"."Serial No.");
        "Item Ledger Entry".SETRANGE("Item Ledger Entry"."Item No.", "Item No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Serial No.", "Serial No.");
        "Item Ledger Entry".SETFILTER("Item Ledger Entry"."Remaining Quantity", '>%1', 0);
        IF NOT "Item Ledger Entry".FIND('-') THEN BEGIN
            // INSERTING RECORD IN ITEM JOURNAL LINE
            "Item Journal Line".INIT;
            "Item Journal Line"."Journal Template Name" := 'ITEM';
            "Item Journal Line"."Journal Batch Name" := 'POS-CS-SIG';
            "Item Journal Line"."Entry Type" := "Item Journal Line"."Entry Type"::"Positive Adjmt.";
            "Item Journal Line"."Line No." := 10000;
            "Item Journal Line"."Source Code" := 'ITEMJNL';
            //"Item Journal Line"."Serial No.":="Serial No.";
            //"Item Journal Line"."Lot No.":=ICNNO(TODAY)+'SA01';
            "Item Journal Line"."Document No." := NoSeriesMgt.GetNextNo('POS-ADJ-CS', TODAY, FALSE);
            "Item Journal Line".VALIDATE("Item Journal Line"."Item No.", "Item No.");
            "Item Journal Line".VALIDATE(Quantity, ItmQty);
            "Item Journal Line".VALIDATE("Location Code", 'CS');
            "Item Journal Line".VALIDATE("Shortcut Dimension 2 Code", "Location Code");
            "Item Journal Line"."User ID" := USERID;
            "Item Journal Line"."Document Date" := TODAY;
            "Item Journal Line".INSERT;


            // INSERTING RECORD IN RESERVATION ENTRY
            ILE1.RESET;
            ILE1.SETFILTER(ILE1."Document No.", DocumentNo);
            ILE1.SETFILTER(ILE1."Item No.", "Item No.");
            IF ILE1.FINDFIRST THEN
                REPEAT
                        ILE21.RESET;
                    ILE21.SETFILTER(ILE21."Item No.", ILE1."Item No.");
                    ILE21.SETFILTER(ILE21."Serial No.", ILE1."Serial No.");
                    ILE21.SETFILTER(ILE21."Lot No.", ILE1."Lot No.");
                    ILE21.SETRANGE(ILE21."Posting Date", ILE1."Posting Date");
                    ILE21.SETRANGE(ILE21."Entry Type", ILE21."Entry Type"::"Positive Adjmt.");
                    ILE21.SETRANGE(ILE21."Location Code", 'CS');
                    ILE21.SETRANGE(ILE21."Global Dimension 2 Code", 'H-OFF');
                    // IF NOT (ILE2.COUNT=2) THEN
                    IF ILE21.FINDFIRST THEN
                        MESSAGE('The Item ' + ILE1."Item No." + ' are already moved to CS location')
                    ELSE BEGIN
                        "Reservation Entry".INIT;
                        IF "Reservation Entry1".FIND('+') THEN
                            "Reservation Entry"."Entry No." := "Reservation Entry1"."Entry No." + 1;
                        "Reservation Entry".VALIDATE("Item No.", "Item No.");
                        "Reservation Entry".VALIDATE("Location Code", 'CS');
                        "Reservation Entry".VALIDATE("Quantity (Base)", 1);
                        "Reservation Entry"."Reservation Status" := "Reservation Entry"."Reservation Status"::Prospect;
                        "Reservation Entry"."Creation Date" := TODAY;
                        "Reservation Entry"."Source Type" := 83;
                        "Reservation Entry"."Source Subtype" := 2;
                        "Reservation Entry"."Source ID" := 'ITEM';
                        "Reservation Entry"."Source Batch Name" := 'POS-CS-SIG';
                        "Reservation Entry"."Source Ref. No." := 10000;
                        "Reservation Entry"."Created By" := 'SUPER';
                        "Reservation Entry".Positive := TRUE;
                        "Reservation Entry"."Expected Receipt Date" := TODAY;
                        "Reservation Entry".VALIDATE("Serial No.", ILE1."Serial No.");
                        "Reservation Entry"."Lot No." := ICNNO(TODAY) + 'SA01';
                        //"Reservation Entry".Quantity:=1;
                        "Reservation Entry".INSERT;
                    END;
                UNTIL ILE1.NEXT = 0;


            /*  // INSERTING JOURNAL LINE DIMENSION
            "Journal Line Dimension".INIT;
            "Journal Line Dimension"."Table ID":=83;
            "Journal Line Dimension"."Journal Template Name":='ITEM';
            "Journal Line Dimension"."Journal Batch Name":='POS-CS-SIG';
            "Journal Line Dimension"."Journal Line No.":=10000;
            "Journal Line Dimension"."Dimension Code":='LOCATIONS';
            "Journal Line Dimension"."Dimension Value Code":="Location Code";
            "Journal Line Dimension".INSERT;
            */
        END;
        //ELSE
        //ERROR(' ITEM WAS ALLREADY AVAILABLE IN INVENTORY');

        CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", "Item Journal Line");

    end;
}

