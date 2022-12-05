page 60144 "CS Transaction Card"
{
    PageType = Document;
    SourceTable = "CS Transaction Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Transaction ID"; Rec."Transaction ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Editable = RecEditable;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Enable_test := TRUE;
                        IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN BEGIN
                            Enable_test := FALSE;
                        END;
                    end;
                }
                field("Transfer From Location"; Rec."Transfer From Location")
                {
                    Editable = RecEditable;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Transfer To Location" <> '') THEN
                            IF Rec."Transfer From Location" = Rec."Transfer To Location" THEN
                                ERROR('From and To Locations cannot be same');
                        IF Rec."Transfer From Location" = 'LED-GEN' THEN BEGIN
                            IF Rec."Transaction Status" <> Rec."Transaction Status"::"In-Transit" THEN
                                custEnable := TRUE
                            ELSE
                                custEnable := FALSE;
                        END ELSE
                            custEnable := FALSE;
                    end;
                }
                field("Transfer To Location"; Rec."Transfer To Location")
                {
                    Editable = RecEditable;
                    Enabled = Enable_test;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF (Rec."Transfer From Location" <> '') THEN
                            IF Rec."Transfer From Location" = Rec."Transfer To Location" THEN
                                ERROR('From and To Locations cannot be same');
                    end;
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    Enabled = Enable_test;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Mode of Transport" = Rec."Mode of Transport"::"By Hand" THEN BEGIN
                            Rec."Courier Details" := '';
                        END;
                    end;
                }
                field("Courier Details"; Rec."Courier Details")
                {
                    Caption = 'Transport Details';
                    Enabled = Enable_test;
                    ApplicationArea = All;

                    trigger OnLookup(Var Text: Text): Boolean;
                    begin
                        IF Rec."Mode of Transport" = Rec."Mode of Transport"::"By Hand" THEN BEGIN
                            Users.RESET;
                            IF PAGE.RUNMODAL(9800, Users) = ACTION::LookupOK THEN
                                Rec."Courier Details" := Users."User ID";
                        END;
                    end;
                }
                field("Transaction Status"; Rec."Transaction Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("<Status>"; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Customer No"; Rec."Customer No")
                {
                    Editable = custEnable;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Transfer From Location" <> 'LED-GEN' THEN
                            ERROR('Allowed only for Transfer From Location = LED-GEN!');
                    end;
                }
                /*   field("Customer Name"; "Customer Name")
                   {
                       Editable = false;
                       ApplicationArea = All;
                   }*/
                /*  field("Responsible Persion"; "Responsible Persion")
                  {
                      Caption = 'Responsible Person';
                      Editable = false;
                      ApplicationArea = All;
                  }*/
            }
            part(Control1102152013; "CS Transaction Lines list")
            {
                SubPageLink = "Transaction ID" = FIELD("Transaction ID");
                ApplicationArea = All;

            }
            group(Control1102152023)
            {
                ShowCaption = false;
                field(CusColor; CusColor)
                {
                    Editable = false;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Function")
            {
                Caption = 'Function';
                action(Release)
                {
                    Caption = 'Release';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF (Rec.Status = Rec.Status::Released) AND (Rec."Transaction Status" = Rec."Transaction Status"::"In-Transit") THEN
                            ERROR('This transaction was already posted');


                        IF Rec."Transaction Type" = 0 THEN
                            ERROR('Select Transaction type');

                        IF (Rec."Transfer From Location" = '') THEN
                            ERROR('Select From Location ');

                        IF (Rec."Transaction Type" <> Rec."Transaction Type"::"Change Status") AND (Rec."Transfer To Location" = '') THEN
                            ERROR('Select To Location');

                        IF (Rec."Transaction Type" <> Rec."Transaction Type"::"Change Status") AND (Rec."Mode of Transport" = 0) THEN
                            ERROR('Select Mode of Transport');

                        IF (Rec."Transaction Type" <> Rec."Transaction Type"::"Change Status") AND (Rec."Courier Details" = '') THEN
                            ERROR('Enter Transport Details');
                        IF (Rec."Transfer From Location" = 'LED-GEN') AND (Rec."Customer No" = '') THEN   //Added by Pranavi on 27-Jan-2016 for LED Cards process
                            ERROR('Please enter Customer No.!');

                        CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                        IF CsTransactionLine.FINDFIRST THEN
                            REPEAT
                                IF CsTransactionLine."Item No." = '' THEN
                                    ERROR('Select Item in line %1', CsTransactionLine."Line No.");
                                IF CsTransactionLine.Quantity <= 0 THEN
                                    ERROR('Quantity in line %1 must be greater than zero', CsTransactionLine."Line No.");
                                IF (Rec."Transfer To Location" = 'SERVICE') AND (CsTransactionLine.Status <> 2) THEN
                                    ERROR('Status must be Non Working in line %1 for SERVICE Location', CsTransactionLine."Line No.");
                                IF CsTransactionLine.Status = 0 THEN
                                    ERROR('Status must be specified in line %1', CsTransactionLine."Line No.");
                                IF CsTransactionLine.Reason = '' THEN
                                    ERROR('Reason must be specified in line %1', CsTransactionLine."Line No.");
                                IF (CsTransactionLine.Reason = 'Installa') AND (CsTransactionLine."Order No" = '') THEN
                                    ERROR('Order No. must be specified in line %1', CsTransactionLine."Line No.");

                                IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN BEGIN
                                    IF CsTransactionLine.Status = CsTransactionLine.Status::Working THEN
                                        Status_line := Status_line::"Non Working"
                                    ELSE
                                        Status_line := Status_line::Working;
                                END
                                ELSE
                                    Status_line := CsTransactionLine.Status;

                                qty := 0;
                                CsTransLine.SETFILTER(CsTransLine."Transaction ID", Rec."Transaction ID");
                                CsTransLine.SETFILTER(CsTransLine."Item No.", CsTransactionLine."Item No.");
                                CsTransLine.SETFILTER(CsTransLine.Status, FORMAT(CsTransactionLine.Status));
                                IF CsTransLine.FINDFIRST THEN
                                    REPEAT
                                        qty := qty + CsTransLine.Quantity;
                                    UNTIL CsTransLine.NEXT = 0;

                                IF Rec."Transaction Type" <> Rec."Transaction Type"::"Customer card Transfer" THEN BEGIN
                                    Cards_Calc(CsTransactionLine."Item No.", Status_line);
                                    IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VISHNUPRIYA']) THEN BEGIN
                                        IF totCards < qty THEN
                                            ERROR('Quantity for Item %1 Status %2 must be equal or less than %3', CsTransactionLine."Item No.", CsTransactionLine.Status, FORMAT(totCards));
                                    END;
                                END;
                            UNTIL CsTransactionLine.NEXT = 0
                        ELSE
                            ERROR('Enter atleast one item in lines');
                        Rec.Status := Rec.Status::Released;
                        Rec.MODIFY;
                    end;
                }
                action(Post)
                {
                    Caption = 'Post';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF (Rec.Status = Rec.Status::Released) AND (Rec."Transaction Status" = Rec."Transaction Status"::"In-Transit") THEN
                            ERROR('This transaction was already posted');

                        IF Rec.Status = Rec.Status::Open THEN
                            ERROR('Transaction must be in Released state');

                        IF (Rec."Transfer From Location" = 'LED-GEN') AND (Rec."Customer No" = '') THEN   //Added by Pranavi on 27-Jan-2016 for LED Cards process
                            ERROR('Please enter Customer No.!');

                        Rec."Posting Date" := TODAY;
                        //RAJU
                        CsTransactionLine.RESET;
                        CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                        IF CsTransactionLine.FINDFIRST THEN
                            REPEAT
                                IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN BEGIN
                                    IF CsTransactionLine.Status = CsTransactionLine.Status::Working THEN
                                        Status_line := Status_line::"Non Working"
                                    ELSE
                                        Status_line := Status_line::Working;
                                END
                                ELSE
                                    Status_line := CsTransactionLine.Status;

                                qty := 0;
                                CsTransLine.RESET;
                                CsTransLine.SETFILTER(CsTransLine."Transaction ID", Rec."Transaction ID");
                                CsTransLine.SETFILTER(CsTransLine."Item No.", CsTransactionLine."Item No.");
                                IF CsTransLine.FINDFIRST THEN
                                    REPEAT
                                        qty := qty + CsTransLine.Quantity;
                                    UNTIL CsTransLine.NEXT = 0;
                                IF Rec."Transaction Type" <> Rec."Transaction Type"::"Customer card Transfer" THEN BEGIN
                                    Cards_Calc(CsTransactionLine."Item No.", Status_line);
                                    IF NOT (UPPERCASE(USERID) IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\GRAVI', 'EFFTRONICS\VISHNUPRIYA']) THEN BEGIN
                                        IF totCards < qty THEN
                                            ERROR('Quantity for Item %1 must be equal or less than %2', CsTransactionLine."Item No.", FORMAT(totCards));
                                    END;
                                END;
                            UNTIL CsTransactionLine.NEXT = 0;

                        //RAJU
                        CsStockLedger.RESET;
                        IF CsStockLedger.FINDLAST THEN
                            entryNo := CsStockLedger."Entry No.";
                        CsStockLedger.RESET;
                        CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");

                        IF CsTransactionLine.FINDFIRST THEN
                            REPEAT
                                /*
                                 IF "Transaction Type"="Transaction Type"::"Change Status" THEN
                                   BEGIN
                                     IF CsTransactionLine.Status=CsTransactionLine.Status::Working THEN
                                        Status_line:=Status_line::"Non Working"
                                     ELSE
                                       Status_line:=Status_line::Working;
                                   END
                                   ELSE
                                     Status_line:=CsTransactionLine.Status;

                                   qty:=0;
                                   CsTransLine.RESET;
                                   CsTransLine.SETFILTER(CsTransLine."Transaction ID","Transaction ID");
                                   CsTransLine.SETFILTER(CsTransLine."Item No.",CsTransactionLine."Item No.");
                                   IF CsTransLine.FINDFIRST THEN
                                   REPEAT
                                     qty:=qty+CsTransLine.Quantity;
                                   UNTIL CsTransLine.NEXT=0;
                                   IF "Transaction Type"<>"Transaction Type"::"Customer card Transfer" THEN
                                   BEGIN
                                     Cards_Calc(CsTransactionLine."Item No.",Status_line);
                                     IF totCards< qty THEN
                                       ERROR('Quantity for Item %1 must be equal or less than %2',CsTransactionLine."Item No.",FORMAT(totCards));
                                   END;
                               */
                                //REC1
                                entryNo := entryNo + 1;
                                CsStockLedger.INIT;
                                CsStockLedger."Entry No." := entryNo;
                                CsStockLedger."Posted By" := USERID;
                                CsStockLedger."Posting Date" := Rec."Posting Date";
                                IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN BEGIN
                                    CsStockLedger.Received := TRUE;
                                    CsStockLedger.Quantity := CsTransactionLine.Quantity;
                                    // CsStockLedger."Remaining Qty":=CsTransactionLine.Quantity;
                                END
                                ELSE BEGIN
                                    CsStockLedger.Received := FALSE;
                                    CsStockLedger.Quantity := -CsTransactionLine.Quantity;
                                    // CsStockLedger."Remaining Qty":=0;
                                END;

                                CsStockLedger."Transaction ID" := Rec."Transaction ID";
                                CsStockLedger."Transaction Type" := Rec."Transaction Type";
                                CsStockLedger.Location := Rec."Transfer From Location";
                                CsStockLedger."User ID" := USERID;
                                CsStockLedger."Mode of Transport" := Rec."Mode of Transport";
                                CsStockLedger."Courier Details" := Rec."Courier Details";
                                CsStockLedger.Remarks := Rec.Remarks;
                                CsStockLedger."Line No." := CsTransactionLine."Line No.";
                                CsStockLedger."Item No" := CsTransactionLine."Item No.";
                                CsStockLedger.Reason := FORMAT(CsTransactionLine.Reason);
                                CsStockLedger."Card Status" := CsTransactionLine.Status;
                                CsStockLedger.Station := CsTransactionLine.Station;
                                CsStockLedger."Customer No" := Rec."Customer No";   // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                CsStockLedger."Responsible Persion" := "Responsible Persion";   // Added by Pranavi on 29-Jan-2016 for Resp persn tracking
                                CsStockLedger.INSERT;

                                //REC2
                                entryNo := entryNo + 1;
                                CsStockLedger.INIT;
                                CsStockLedger."Entry No." := entryNo;
                                CsStockLedger."Posted By" := USERID;
                                CsStockLedger."Posting Date" := Rec."Posting Date";
                                IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN BEGIN
                                    CsStockLedger.Received := TRUE;
                                    CsStockLedger.Location := Rec."Transfer From Location";
                                    CsStockLedger.Quantity := -CsTransactionLine.Quantity;
                                    //CsStockLedger."Remaining Qty":=-CsTransactionLine.Quantity;
                                    IF CsTransactionLine.Status = CsTransactionLine.Status::Working THEN
                                        CsStockLedger."Card Status" := CsTransactionLine.Status::"Non Working"
                                    ELSE
                                        CsStockLedger."Card Status" := CsTransactionLine.Status::Working;
                                END
                                ELSE BEGIN
                                    CsStockLedger.Received := FALSE;
                                    CsStockLedger.Location := Rec."Transfer To Location";
                                    CsStockLedger."Card Status" := CsTransactionLine.Status;
                                    CsStockLedger.Quantity := CsTransactionLine.Quantity;
                                    // CsStockLedger."Remaining Qty":=0;
                                END;
                                CsStockLedger."Transaction ID" := Rec."Transaction ID";
                                CsStockLedger."Transaction Type" := Rec."Transaction Type";
                                CsStockLedger."User ID" := USERID;
                                CsStockLedger."Mode of Transport" := Rec."Mode of Transport";
                                CsStockLedger."Courier Details" := Rec."Courier Details";
                                CsStockLedger.Remarks := Rec.Remarks;
                                CsStockLedger."Line No." := CsTransactionLine."Line No.";
                                CsStockLedger."Item No" := CsTransactionLine."Item No.";
                                CsStockLedger.Reason := FORMAT(CsTransactionLine.Reason);
                                CsStockLedger.Station := CsTransactionLine.Station;
                                CsStockLedger."Customer No" := Rec."Customer No";   // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                CsStockLedger."Responsible Persion" := "Responsible Persion";   // Added by Pranavi on 29-Jan-2016 for Resp persn tracking
                                CsStockLedger.INSERT;

                            UNTIL CsTransactionLine.NEXT = 0;

                        MESSAGE('Successfully posted the transaction');


                        IF Rec."Transaction Type" <> Rec."Transaction Type"::"Change Status" THEN BEGIN
                            Rec."Transaction Status" := Rec."Transaction Status"::"In-Transit";
                            Rec.MODIFY;
                        END
                        ELSE BEGIN
                            //  SendMail;
                            CsTransactionLine.RESET;
                            CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                            CsTransactionLine.DELETEALL;
                            Rec.DELETE;
                        END;

                    end;
                }
                action(Reopen)
                {
                    Caption = 'Re-open';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\NAGALAKSHMI']) THEN
                            IF (Rec.Status = Rec.Status::Released) AND (Rec."Transaction Status" = Rec."Transaction Status"::"In-Transit") THEN
                                ERROR('This transaction was already posted');

                        IF NOT (USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\NAGALAKSHMI']) THEN
                            IF Rec."User ID" <> USERID THEN
                                ERROR('You Dont have rights to open');

                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                }
                action(Received)
                {
                    Caption = 'Received';
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        MIH1: Record "Material Issues Header";
                    begin
                        IF Rec."Transaction Status" <> Rec."Transaction Status"::"In-Transit" THEN
                            ERROR('Transaction is not Posted.');

                        IF (Rec."Transfer To Location" = 'SERVICE') AND NOT (USERID IN ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\BHAVANIP', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You do not have rights to receive');
                        IF (Rec."Transfer To Location" <> 'SERVICE') AND (USERID IN ['EFFTRONICS\SRIVALLI', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\BHAVANIP', 'EFFTRONICS\SUJANI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI']) THEN
                            ERROR('You do not have rights to receive');


                        //new ver
                        found := FALSE;

                        CsStockLedger.RESET;
                        IF CsStockLedger.FINDLAST THEN
                            entryNo := CsStockLedger."Entry No.";

                        CsTransactionLine.RESET;
                        CsTransactionLine.SETFILTER(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                        CsTransactionLine.SETFILTER(CsTransactionLine."Qty to be Receive", '>%1', 0);
                        IF CsTransactionLine.FIND('-') THEN BEGIN
                            REPEAT

                                QtyRcvd := 0;
                                CsStockLedger.RESET;
                                CsStockLedger.SETFILTER(CsStockLedger."Transaction ID", Rec."Transaction ID");
                                CsStockLedger.SETFILTER(CsStockLedger.Location, Rec."Transfer To Location");
                                CsStockLedger.SETFILTER(CsStockLedger."Line No.", '%1', CsTransactionLine."Line No.");
                                CsStockLedger.SETFILTER(CsStockLedger.Received, '%1', TRUE);
                                IF CsStockLedger.FIND('-') THEN
                                    REPEAT
                                        QtyRcvd := QtyRcvd + CsStockLedger.Quantity;
                                    UNTIL CsStockLedger.NEXT = 0;

                                IF CsTransactionLine.Quantity < CsTransactionLine."Qty to be Receive" + QtyRcvd THEN BEGIN
                                    ERROR('Qty to recieve cannot be greater than Quantity');
                                END;

                                CsStockLedger.RESET;
                                CsStockLedger.SETFILTER(CsStockLedger."Transaction ID", Rec."Transaction ID");
                                CsStockLedger.SETFILTER(CsStockLedger.Location, Rec."Transfer To Location");
                                CsStockLedger.SETFILTER(CsStockLedger."Line No.", '%1', CsTransactionLine."Line No.");
                                CsStockLedger.SETFILTER(CsStockLedger.Received, '%1', FALSE);
                                IF CsStockLedger.FIND('-') THEN BEGIN

                                    CsStockLedger.Quantity := CsTransactionLine."Qty to be Receive";
                                    CsStockLedger.Received := TRUE;
                                    CsStockLedger."Received By" := USERID;
                                    CsStockLedger."Received Date" := TODAY;
                                    CsStockLedger.MODIFY;
                                END;

                                CsStockLedger.RESET;
                                CsStockLedger.SETFILTER(CsStockLedger."Transaction ID", Rec."Transaction ID");
                                CsStockLedger.SETFILTER(CsStockLedger.Location, Rec."Transfer From Location");
                                CsStockLedger.SETFILTER(CsStockLedger."Line No.", '%1', CsTransactionLine."Line No.");
                                CsStockLedger.SETFILTER(CsStockLedger.Received, '%1', FALSE);
                                IF CsStockLedger.FIND('-') THEN BEGIN

                                    CsStockLedger.Quantity := -CsTransactionLine."Qty to be Receive";
                                    CsStockLedger.Received := TRUE;
                                    CsStockLedger."Received By" := USERID;
                                    CsStockLedger."Received Date" := TODAY;
                                    CsStockLedger.MODIFY;
                                END;



                                IF CsTransactionLine.Quantity - QtyRcvd - CsTransactionLine."Qty to be Receive" > 0 THEN BEGIN
                                    entryNo := entryNo + 1;
                                    CsStockLedger.INIT;
                                    CsStockLedger."Entry No." := entryNo;
                                    CsStockLedger."Posted By" := USERID;
                                    CsStockLedger."Posting Date" := Rec."Created Date";
                                    CsStockLedger.Received := FALSE;
                                    CsStockLedger.Location := Rec."Transfer From Location";
                                    CsStockLedger."Card Status" := CsTransactionLine.Status;
                                    CsStockLedger.Quantity := -(CsTransactionLine.Quantity - QtyRcvd - CsTransactionLine."Qty to be Receive");
                                    CsStockLedger."Transaction ID" := Rec."Transaction ID";
                                    CsStockLedger."Transaction Type" := Rec."Transaction Type";
                                    CsStockLedger."User ID" := USERID;
                                    CsStockLedger."Mode of Transport" := Rec."Mode of Transport";
                                    CsStockLedger."Courier Details" := Rec."Courier Details";
                                    CsStockLedger.Remarks := Rec.Remarks;
                                    CsStockLedger."Line No." := CsTransactionLine."Line No.";
                                    CsStockLedger."Item No" := CsTransactionLine."Item No.";
                                    CsStockLedger.Reason := FORMAT(CsTransactionLine.Reason);
                                    CsStockLedger.Station := CsTransactionLine.Station;
                                    CsStockLedger."Customer No" := Rec."Customer No";   // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                    CsStockLedger."Responsible Persion" := "Responsible Persion";   // Added by Pranavi on 29-Jan-2016 for Resp persn tracking
                                    CsStockLedger.INSERT;

                                    entryNo := entryNo + 1;
                                    CsStockLedger.INIT;
                                    CsStockLedger."Entry No." := entryNo;
                                    CsStockLedger."Posted By" := USERID;
                                    CsStockLedger."Posting Date" := Rec."Created Date";
                                    CsStockLedger.Received := FALSE;
                                    CsStockLedger.Location := Rec."Transfer To Location";
                                    CsStockLedger."Card Status" := CsTransactionLine.Status;
                                    CsStockLedger.Quantity := CsTransactionLine.Quantity - QtyRcvd - CsTransactionLine."Qty to be Receive";
                                    CsStockLedger."Transaction ID" := Rec."Transaction ID";
                                    CsStockLedger."Transaction Type" := Rec."Transaction Type";
                                    CsStockLedger."User ID" := USERID;
                                    CsStockLedger."Mode of Transport" := Rec."Mode of Transport";
                                    CsStockLedger."Courier Details" := Rec."Courier Details";
                                    CsStockLedger.Remarks := Rec.Remarks;
                                    CsStockLedger."Line No." := CsTransactionLine."Line No.";
                                    CsStockLedger."Item No" := CsTransactionLine."Item No.";
                                    CsStockLedger.Reason := FORMAT(CsTransactionLine.Reason);
                                    CsStockLedger.Station := CsTransactionLine.Station;
                                    CsStockLedger."Customer No" := Rec."Customer No";   // Added by Pranavi on 27-Jan-2016 for LED Cards process
                                    CsStockLedger."Responsible Persion" := "Responsible Persion";   // Added by Pranavi on 29-Jan-2016 for Resp persn tracking
                                    CsStockLedger.INSERT;
                                END;

                                CsTransactionLine."Qty Received" := CsTransactionLine."Qty Received" + CsTransactionLine."Qty to be Receive";
                                CsTransactionLine.MODIFY;


                            UNTIL CsTransactionLine.NEXT = 0;
                        END
                        ELSE BEGIN
                            ERROR('Qty to Receive must be Specified');
                        END;
                        //end of new ver


                        IF (Rec."Transfer To Location" = 'SERVICE') THEN BEGIN
                            MIHGRec.RESET;
                            MIHGRec.INIT;
                            MIHNo := MIHGRec.GetNextNo;
                            MIHGRec."No." := MIHNo;
                            MIHGRec."Transfer-from Code" := 'SITE';
                            MIHGRec."Transfer-to Code" := 'CS';
                            MIHGRec."Prod. Order No." := 'EFF12CST01';
                            MIHGRec.VALIDATE("Prod. Order No.");
                            MIHGRec.VALIDATE("Prod. Order Line No.", 10000);
                            MIHGRec."Shortcut Dimension 2 Code" := Rec."Transfer From Location";
                            // MIHGRec.VALIDATE("Shortcut Dimension 2 Code");
                            MIHGRec.Status := MIHGRec.Status::Released;
                            MIHGRec."Creation DateTime" := CURRENTDATETIME;
                            MIHGRec."Released Date" := TODAY;
                            MIHGRec."Released By" := USERID;
                            MIHGRec."Released Time" := TIME;
                            MIHGRec."User ID" := USERID;
                            MIHGRec."Receipt Date" := TODAY;
                            MIHGRec."Transaction ID" := Rec."Transaction ID";
                            MIHGRec."Customer No" := Rec."Customer No";       // Added by Pranavi on 27-Jan-2016 for LED Cards process

                            MIHGRec."Creation DateTime" := CURRENTDATETIME;
                            MIHGRec.INSERT;

                            CsTransactionLine.RESET;
                            CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                            CsTransactionLine.SETFILTER(CsTransactionLine."Qty to be Receive", '>%1', 0);
                            lineNo := 0;
                            IF CsTransactionLine.FIND('-') THEN
                                REPEAT
                                    MILGRec.INIT;
                                    MILGRec."Document No." := MIHNo;
                                    MILGRec."Line No." := CsTransactionLine."Line No.";
                                    MILGRec."Item No." := CsTransactionLine."Item No.";
                                    // Added by Pranavi on 11-Jan-2016 for allowing blocked items also to be received
                                    IF Item.GET(MILGRec."Item No.") THEN BEGIN
                                        IF MIH1.GET(MIHNo) THEN BEGIN
                                            MILGRec."Transfer-from Code" := MIH1."Transfer-from Code";
                                            MILGRec."Transfer-to Code" := MIH1."Transfer-to Code";
                                            MILGRec."Receipt Date" := MIH1."Receipt Date";
                                            MILGRec."Sales Order No." := MIH1."Sales Order No.";
                                            MILGRec.Status := MIH1.Status;
                                            MILGRec."Dimension Set ID" := MIH1."Dimension Set ID";
                                            MILGRec.VALIDATE(Description, Item.Description);
                                            MILGRec.VALIDATE("Gross Weight", Item."Gross Weight");
                                            MILGRec.VALIDATE("Net Weight", Item."Net Weight");
                                            MILGRec.VALIDATE("Unit Volume", Item."Unit Volume");
                                            MILGRec.VALIDATE("Units per Parcel", Item."Units per Parcel");
                                            MILGRec.VALIDATE("Unit of Measure Code", Item."Base Unit of Measure");
                                            MILGRec.VALIDATE("Description 2", Item."Description 2");
                                            MILGRec."Unit Cost" := Item."Item Final Cost";
                                            IF MILGRec."Transfer-from Code" IN ['SITE', 'CS STR', 'R&D STR', 'CS', 'PRODSTR', 'STR'] THEN
                                                MILGRec.Inventory := MILGRec.Item_Stock(MILGRec."Item No.", MILGRec."Transfer-from Code");
                                            MILGRec."Item Category Code" := Item."Item Category Code";
                                            MILGRec."Product Group Code" := Item."Product Group Code Cust";
                                            MILGRec.CreateDim(DATABASE::Item, MILGRec."Item No.");
                                        END;
                                    END;
                                    // End by pranavi
                                    // MILGRec.VALIDATE(MILGRec."Item No.");    // Commented by Pranavi on 11-Jan-2016 for allowing blocked items also to be received
                                    MILGRec.VALIDATE(MILGRec.Quantity, CsTransactionLine."Qty to be Receive");
                                    MILGRec.VALIDATE("Qty. to Receive", CsTransactionLine."Qty to be Receive");
                                    MILGRec.VALIDATE("Outstanding Quantity", CsTransactionLine."Qty to be Receive");
                                    MILGRec.VALIDATE(Station, CsTransactionLine.Station);    // Added by Pranavi on 25-Apr-2017 for tracking station
                                    IF Rec."Transaction Type" = Rec."Transaction Type"::"Customer card Transfer" THEN
                                        MILGRec."Non-Returnable" := TRUE;
                                    MILGRec."Shortcut Dimension 2 Code" := 'SERVICE';
                                    MILGRec.INSERT;
                                    CsTransactionLine."Qty to be Receive" := 0;
                                    CsTransactionLine.MODIFY;
                                UNTIL CsTransactionLine.NEXT = 0;
                            MESSAGE('Material was received. Material request No: ' + FORMAT(MIHNo) + ' was automatically created');
                        END;

                        //SendMail;
                        /*
                         CsStockLedger.RESET;
                         CsStockLedger.SETFILTER(CsStockLedger."Transaction ID","Transaction ID");
                         CsStockLedger.MODIFYALL(Received,TRUE);
                         CsStockLedger.MODIFYALL(CsStockLedger."Received By",USERID);
                         CsStockLedger.MODIFYALL(CsStockLedger."Received Date",TODAY);
                        */

                        found := FALSE;
                        CsTransactionLine.RESET;
                        CsTransactionLine.SETFILTER(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                        IF CsTransactionLine.FIND('-') THEN
                            REPEAT
                                IF CsTransactionLine."Qty Received" <> CsTransactionLine.Quantity THEN
                                    found := TRUE;
                            UNTIL CsTransactionLine.NEXT = 0;

                        IF NOT found THEN BEGIN
                            CsStockLedger.RESET;
                            CsStockLedger.SETFILTER(CsStockLedger."Transaction ID", Rec."Transaction ID");
                            IF CsStockLedger.FINDSET THEN BEGIN
                                CsStockLedger.MODIFYALL(Received, TRUE);
                                CsStockLedger.MODIFYALL(CsStockLedger."Received By", USERID);
                                CsStockLedger.MODIFYALL(CsStockLedger."Received Date", TODAY);
                            END;

                            CsTransactionLine.RESET;
                            CsTransactionLine.SETRANGE(CsTransactionLine."Transaction ID", Rec."Transaction ID");
                            CsTransactionLine.DELETEALL;
                            Rec.DELETE;
                        END;

                    end;
                }
                action("Get Working Cards")
                {
                    Caption = 'Get Working Cards';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Transaction must be in Open State to Modify');
                        getLines(Status_line::Working);
                    end;
                }
                action("Get Non Working Cards")
                {
                    Caption = 'Get Non Working Cards';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        IF Rec.Status <> Rec.Status::Open THEN
                            ERROR('Transaction must be in Open State to Modify');

                        getLines(Status_line::"Non Working");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF Rec."Transaction Type" = Rec."Transaction Type"::"Change Status" THEN
            Enable_test := FALSE
        ELSE
            Enable_test := TRUE;

        IF Rec."Transaction Status" <> Rec."Transaction Status"::"In-Transit" THEN
            CLEAR(Rec."Posting Date")
        ELSE
            RecEditable := FALSE;  //pranavi
        IF Rec."Transfer From Location" = 'LED-GEN' THEN BEGIN
            IF Rec."Transaction Status" <> Rec."Transaction Status"::"In-Transit" THEN
                custEnable := TRUE
            ELSE
                custEnable := FALSE;
        END ELSE
            custEnable := FALSE;
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        IF Rec.Status = Rec.Status::Released THEN
            ERROR('Transaction must be in open state to Modify');
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin

        Rec."User ID" := USERID;
        Rec."Created Date" := TODAY;
    end;

    trigger OnOpenPage();
    begin
        CusColor := 'Customer Cards';
        RecEditable := TRUE;  //pranavi
        IF USERID IN ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA'] THEN BEGIN
            FieldVisible := TRUE;
            RecEditable := TRUE;
        END
        ELSE
            FieldVisible := FALSE;
    end;

    var
        CsStockLedger: Record "CS Stock Ledger";
        workingCards: Decimal;
        nonWorkingCards: Decimal;
        csSpareCards: Decimal;
        totCards: Decimal;
        CsTransactionLine: Record "CS Transaction Line";
        entryNo: Integer;
        qty: Integer;
        Status_line: Option ,Working,"Non Working";
        CsTransLine: Record "CS Transaction Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        code_Sample: Code[10];
        lineNo: Integer;
        LineGrec: Record "CS Transaction Line";
        Users: Record "User Setup";
        Mail_Body: Text[1024];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit "SMTP Mail";
        Subject: Text[250];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Enable_test: Boolean;
        MIHGRec: Record "Material Issues Header";
        MILGRec: Record "Material Issues Line";
        MIHNo: Code[20];
        QtyRcvd: Decimal;
        found: Boolean;
        prevQty: Decimal;
        CusColor: Text;
        RecEditable: Boolean;
        Item: Record Item;
        FieldVisible: Boolean;
        custEnable: Boolean;
        Salesperson: Record "Salesperson/Purchaser";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];


    procedure Cards_Calc(Item: Code[20]; Status: Option ,Working,"Non Working") res: Decimal;
    var
        CsLedgerLRec: Record "CS Stock Ledger";
    begin
        totCards := 0;
        CsLedgerLRec.RESET;
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Location, Rec."Transfer From Location");
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Received, '%1', TRUE);
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Card Status", '%1', Status);
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Transaction Type", '<>%1', CsLedgerLRec."Transaction Type"::"Custmer card Transfer");
        IF CsLedgerLRec.FINDFIRST THEN
            REPEAT
                totCards := totCards + CsLedgerLRec.Quantity;
            UNTIL CsLedgerLRec.NEXT = 0;

        CsLedgerLRec.RESET;
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Location, Rec."Transfer From Location");
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Received, '%1', FALSE);
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Card Status", '%1', Status);
        CsLedgerLRec.SETFILTER(CsLedgerLRec.Quantity, '<0');
        CsLedgerLRec.SETFILTER(CsLedgerLRec."Transaction Type", '<>%1', CsLedgerLRec."Transaction Type"::"Custmer card Transfer");
        IF CsLedgerLRec.FINDFIRST THEN
            REPEAT
                totCards := totCards + CsLedgerLRec.Quantity;
            UNTIL CsLedgerLRec.NEXT = 0;

        res := totCards;
    end;


    procedure getLines(StatusL: Option ,Working,"Non Working");
    var
        Header: Record "CS Transaction Header";
        CsStockLineLRec: Record "CS Transaction Line";
    begin
        IF (Rec."Transfer From Location" = '') THEN
            ERROR('Select From Location ');

        //Added by vishnu on 31-12-2019 for getting the to location as service for the CS Managers
        Salesperson.RESET;
        Users.RESET;
        Users.SETFILTER("User ID", Rec."User ID");
        IF Users.FINDFIRST THEN BEGIN
            Salesperson.RESET;
            Salesperson.SETFILTER(Code, Users.EmployeeID);
            Salesperson.SETFILTER("Salesperson/Purchaser", FORMAT(2));
            IF Salesperson.FINDFIRST THEN
                Rec."Transfer To Location" := 'SERVICE';
            Rec.VALIDATE("Transfer To Location");
        END;
        //ended by vishnu on 31-12-2019


        CsStockLedger.RESET;
        CsStockLedger.SETFILTER(CsStockLedger.Location, Rec."Transfer From Location");
        CsStockLedger.SETFILTER(CsStockLedger."Card Status", '%1', StatusL);
        lineNo := 0;
        IF CsStockLedger.FINDFIRST THEN
            REPEAT
                CsStockLineLRec.RESET;
                CsStockLineLRec.SETFILTER(CsStockLineLRec."Transaction ID", Rec."Transaction ID");
                IF CsStockLineLRec.FINDLAST THEN
                    lineNo := CsStockLineLRec."Line No.";

                CsStockLineLRec.RESET;
                CsStockLineLRec.SETFILTER(CsStockLineLRec."Transaction ID", Rec."Transaction ID");
                CsStockLineLRec.SETFILTER(CsStockLineLRec."Item No.", CsStockLedger."Item No");
                CsStockLineLRec.SETFILTER(CsStockLineLRec.Status, '%1', StatusL);
                IF NOT CsStockLineLRec.FINDFIRST THEN BEGIN
                    Cards_Calc(CsStockLedger."Item No", StatusL);
                    IF totCards > 0 THEN BEGIN
                        lineNo := lineNo + 10000;
                        LineGrec.INIT;
                        LineGrec."Transaction ID" := Rec."Transaction ID";
                        LineGrec.VALIDATE(LineGrec."Line No.", lineNo); //CsTransactionLine."Line No.";
                        LineGrec.VALIDATE("Item No.", CsStockLedger."Item No");
                        LineGrec.Quantity := totCards;
                        LineGrec.Status := CsStockLedger."Card Status";
                        LineGrec.Reason := CsStockLedger.Reason;
                        LineGrec.Station := CsStockLedger.Station;
                        LineGrec.INSERT;
                    END;
                END;
            UNTIL CsStockLedger.NEXT = 0;
    end;


    procedure SendMail();
    begin
        Mail_Body := '<html><body><b>Transaction ID: <b>' + FORMAT(Rec."Transaction ID") + '<br/>';
        Mail_Body := '<b>Transaction Type: <b>' + FORMAT(Rec."Transaction Type") + '<br/>';
        Mail_Body += '<b>From Location:</b>' + Rec."Transfer From Location" + '<br/>';
        Mail_Body += '<b>To Location:</b>' + Rec."Transfer To Location" + '<br/><br/>';
        Mail_Body += '<table><tr><td>No.</td><td>Description</td><td>Quantity)</td>';
        Mail_Body += '<td>Status</td><td>Reason</td></tr>';

        CsTransactionLine.RESET;
        CsTransactionLine.SETFILTER(CsTransactionLine."Transaction ID", Rec."Transaction ID");
        IF CsTransactionLine.FINDFIRST THEN
            REPEAT
                Mail_Body += '<tr><td>' + CsTransactionLine."Item No." + '</td><td>' + CsTransactionLine.Description + '</td><td>' + FORMAT(CsTransactionLine.Quantity) + '</td>';
                Mail_Body += '<td>' + FORMAT(CsTransactionLine.Status) + '</td><td>' + CsTransactionLine.Reason + '</td></tr>';
            UNTIL CsTransactionLine.NEXT = 0;

        Subject := 'Site Stock Transfer details';
        Mail_Body += '</table></body></html>';
        //B2B UPG >>>
        /* Mail_From := 'erp@efftronics.com';
        Mail_To := 'erp@efftronics.com';
        SMTP_MAIL.CreateMessage('ERP', Mail_From, Mail_To, Subject, Mail_Body, TRUE);
        SMTP_MAIL.Send; */  //B2B UPG
        Recipients.Add('erp@efftronics.com');

        EmailMessage.Create(Recipients, Subject, Mail_Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;
}

