tableextension 70095 ServiceItemLineExt extends "Service Item Line"
{
    fields
    {
        modify("Fault Area Code")
        {
            trigger OnAfterValidate()
            var
                FaultArea: Record "Fault Area";
            begin
                //b2b EFF
                if "Fault Area Code" <> '' then begin
                    FaultArea.Get("Fault Area Code");
                    "Fault Area Description" := FaultArea.Description;
                end;
                //b2b EFF
            end;
        }
        modify("Symptom Code")
        {
            trigger OnAfterValidate()
            var
                SymptomCode: Record "Symptom Code";
            begin
                //b2b EFF
                SymptomCode.Get("Symptom Code");
                "Symptom Description" := SymptomCode.Description;
                //b2b EFF
            end;
        }
        modify("Fault Code")
        {
            trigger OnBeforeValidate()
            var
                FaultCode: Record "Fault Code";
            BEGIN
                FaultCode.SetFilter(FaultCode.Code, "Fault Code");
                //MESSAGE("Fault Code");
                if FaultCode.Find('-') then
                        repeat
                            "Fault Code Description" := FaultCode.Description;
                        until FaultCode.Next = 0;
                //b2b EFF
            END;
        }
        modify("Resolution Code")
        {
            trigger OnBeforeValidate()
            var
                ResolutionCode: Record "Resolution Code";
            BEGIN
                //b2b EFF
                ResolutionCode.Get("Resolution Code");
                "Resolution Description" := ResolutionCode.Description;
                //b2b EFF
            END;
        }
        field(60003; "Resolution Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60004; "Fault Code Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60005; "Fault Area Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60006; "Symptom Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60010; "From Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Account = true then
                    "From Location" := xRec."From Location";
            end;
        }
        field(60011; "To Location"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('LOCATIONS'),
                                                          Code = FILTER(<> 'HAR'));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Account = true then
                    "To Location" := xRec."To Location";
                /*
                ServHeader.RESET;
                 ServHeader.SETFILTER(ServHeader."No.","Document No.");
                 ServHeader.SETRANGE(ServHeader."Customer Cards",TRUE);
                 IF ServHeader.FINDFIRST THEN
                 BEGIN
                   PMIH.RESET;
                   PMIH.SETFILTER(PMIH."Material Issue No.",ServHeader."Material Issue no.");
                   IF PMIH.FINDFIRST THEN
                   BEGIN
                     IF NOT(("To Location"=PMIH."Shortcut Dimension 2 Code") OR ("To Location"='DAMAGE')) THEN
                       ERROR('customer cards cannot be moved to other locations');
                   END;
                 END;
                */

            end;
        }
        field(60012; Account; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                /*
                  IF NOT (USERID IN ['EFFTRONICS\RAKESHT','EFFTRONICS\PRANAVI','EFFTRONICS\ANILKUMAR']) THEN
                    ERROR('Contact ERP Team');
                  ServItemLine."Sent date time":=CURRENTDATETIME;
                
                  IF "To Location"='' THEN
                    ERROR('PLEASE ENTER TO LOCATION');
                */
                if (Account = false) and (not (UserId in ['EFFTRONICS\PRANAVI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\B2BOTS'])) then              //added by pranavi on 17-04-2015
                    Error('You cannot uncheck!');
                if "Repair Status Code" = '' then
                    Error('Please enter Repair Status!');
                if "From Location" = '' then
                    Error('Please enter From Location!');
                if "To Location" = '' then
                    Error('Please enter To Location!');
                "ITEMLEDGER ENTRY".SetCurrentKey("Location Code", "Global Dimension 2 Code", "Item No.");
                "ITEMLEDGER ENTRY".SetFilter("ITEMLEDGER ENTRY"."Item No.", Rec."Item No.");
                "ITEMLEDGER ENTRY".SetFilter("ITEMLEDGER ENTRY"."Location Code", 'CS');
                "ITEMLEDGER ENTRY".SetFilter("ITEMLEDGER ENTRY"."Global Dimension 2 Code", Rec."From Location");
                "ITEMLEDGER ENTRY".SetFilter("ITEMLEDGER ENTRY"."Serial No.", Rec."Serial No.");
                if "ITEMLEDGER ENTRY".FindSet then begin
                                                       repeat
                                                           if Account = true then begin
                                                               /*     ServHeader.RESET;
                                                                     ServHeader.SETFILTER(ServHeader."No.","Document No.");
                                                                     ServHeader.SETRANGE(ServHeader."Customer Cards",TRUE);
                                                                     IF ServHeader.FINDFIRST THEN
                                                                     BEGIN
                                                                       PMIH.RESET;
                                                                       PMIH.SETFILTER(PMIH."Material Issue No.",ServHeader."Material Issue no.");
                                                                       IF PMIH.FINDFIRST THEN
                                                                       BEGIN
                                                                         {IF NOT(("To Location"=PMIH."Shortcut Dimension 2 Code") OR ("To Location"='DAMAGE')) THEN
                                                                           ERROR('customer cards cannot be moved to other locations')
                                                                         ELSE}
                                                                         BEGIN
                                                                           IF  "To Location"='DAMAGE' THEN
                                                                             Connection.Material_Transfer("Item No.","Serial No.",'CS','DAMAGE','')
                                                                           ELSE
                                                                             Connection.Material_Transfer("Item No.","Serial No.",'CS','SITE',"To Location");

                                                                         //  CSTransEntry(0);
                                                                         END;
                                                                       END;
                                                                     END
                                                                     ELSE BEGIN
                                                               */
                                                               "ITEMLEDGER ENTRY"."Global Dimension 2 Code" := Rec."To Location";
                                                               "ITEMLEDGER ENTRY"."Posting Date" := Today;              //added by pranavi on 19-04-2015
                                                               "ITEMLEDGER ENTRY".Modify;
                                                               //  CSTransEntry(1);
                                                               ServItem.SetRange(ServItem."No.", "Service Item No.");
                                                               if ServItem.Find('-') then begin
                                                                   "Dimension Value".SetRange("Dimension Value"."Dimension Code", 'Locations');
                                                                   "Dimension Value".SetRange("Dimension Value".Code, Rec."To Location");
                                                                   if "Dimension Value".Find('-') then begin
                                                                       ServItem."Present Location" := "Dimension Value".Name;
                                                                       if "To Location" = 'H-OFF' then
                                                                           ServItem."WORKING STATUS" := ServItem."WORKING STATUS"::WORKING;
                                                                       ServItem.Modify;
                                                                   end;
                                                               end;
                                                           end;
                                                       //END;
                                                       until "ITEMLEDGER ENTRY".Next = 0;
                    "Sent date time" := CurrentDateTime;
                end else begin
                    if Account = true then begin
                        // added by vishnu for alerting purpose on 08-07-2019
                        ServItemLine.Account := false;
                        Error('Service Item not in From Location');

                    end
                    else begin
                        ServItemLine.Account := true;
                        Error('Service Item not in From Location');
                    end;
                end;

            end;
        }
        field(60030; "Countrol Section"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60031; "N/W Stand Alone"; Enum "NetWork Stand Alone")
        {
            DataClassification = CustomerContent;

        }
        field(60032; IDNO; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60033; "F/W Version"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60034; "S/W Version"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60035; "H/W Process Type"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60036; "Operating Voltage"; Enum "Operating Voltage")
        {
            DataClassification = CustomerContent;

        }
        field(60037; "Supply Giving From"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60038; "Earth Status"; Enum "Earth Status")
        {
            DataClassification = CustomerContent;

        }
        field(60039; "Communication Media"; Enum "Communication Media")
        {
            DataClassification = CustomerContent;

        }
        field(60040; "Warr/AMC/None"; Enum "Warr AMC None")
        {
            DataClassification = CustomerContent;

        }
        field(60041; Zone; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60042; Division; Code[10])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60043; Station; Code[20])
        {
            Editable = true;
            TableRelation = Station;
            DataClassification = CustomerContent;

            trigger OnLookup();
            begin
                SH.Reset;
                if SH.Get("Document Type"::Order, "Document No.") then begin
                    stat.Reset;
                    buf2 := SH."Shortcut Dimension 2 Code";
                    //Divi.SetRange(stat."Division Code", buf2);  //B2B UPG
                    Divi.SetRange(Code, buf2);
                    Divi.FindFirst;
                    buf := Divi."Cumilative Division1";
                    stat.SetFilter(stat."Cumilative Division1", buf);
                    // stat.SETFILTER("SMS Mapped Status",FORMAT(TRUE));
                    //stat.SETFILTER(stat."Division code",SH."Shortcut Dimension 2 Code");
                    if PAGE.RunModal(60206, stat) = ACTION::LookupOK then
                        Rec.Station := stat."Station Code";
                    Validate(Rec.Station);
                end;
            end;

            trigger OnValidate();
            begin
                SH.Reset;
                if SH.Get("Document Type"::Order, "Document No.") then begin
                    stat.Reset;
                    Divi.SetRange(Code, SH."Shortcut Dimension 2 Code");

                    Divi.FindFirst;
                    //stat.SETFILTER(stat."Division code",SH."Shortcut Dimension 2 Code");
                    buf := Divi."Cumilative Division1";
                    stat.SetFilter(stat."Cumilative Division1", buf);
                    stat.SetRange(stat."Station Code", Rec.Station);
                    if stat.FindFirst then
                        "Station Name" := stat."Station Name";
                end;
            end;
        }
        field(60044; "Order Date"; Date)
        {
            CalcFormula = Lookup("Service Header"."Order Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60045; "Sent date time"; DateTime)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60046; "Unit cost"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60047; "AMC Order No"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60048; Tested; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60049; "Accounted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60050; "Sub Module Code"; Code[20])
        {
            TableRelation = "Troubleshooting Header"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Sub Module Code" = '' then
                    "Sub Module Descrption" := ''
                else begin
                    TSH.Get("Sub Module Code");
                    "Sub Module Descrption" := TSH.Description;
                end;
            end;
        }
        field(60051; "Sub Module Descrption"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(60052; "Problem from Site"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60053; "QC internal Remarks"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60054; "Site Feedback"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60055; "Site Problem Matched"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60056; "Service Level"; Enum "Service Level")
        {
            DataClassification = CustomerContent;

        }
        field(60057; "Station Name"; Text[30])
        {
            Description = 'added by vijaya';
            DataClassification = CustomerContent;
        }
        field(60058; "CS Product"; Code[50])
        {
            CalcFormula = Min("Product Model".Product WHERE(Active = CONST(true),
                                                             "Item Number" = FIELD("Item No.")));
            Description = 'added by Vishnu for analysis purpose';
            FieldClass = FlowField;
        }
        field(60059; "CS model"; Code[50])
        {
            CalcFormula = Min("Product Model".Model WHERE(Active = CONST(true),
                                                           "Item Number" = FIELD("Item No.")));
            Description = 'added by Vishnu for analysis purpose';
            FieldClass = FlowField;
        }
        field(60060; "CS Module"; Code[50])
        {
            CalcFormula = Min("Product Model".Module WHERE(Active = CONST(true),
                                                            "Item Number" = FIELD("Item No.")));
            Description = 'added by Vishnu for analysis purpose';
            FieldClass = FlowField;
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
    }
    keys
    {
        key(Key12; "Customer No.")
        {
        }
        key(Key13; Station)
        {
        }
        key(Key14; "Service Item Group Code")
        {
        }
    }

    trigger OnAfterModify()
    begin
        Message('Service Item No. "%1", item: "%2" with Serial No. "%3"  having Repair Status Code : "%5" moved to "%4" Location ', "Service Item No.", Description, "Serial No.", "To Location", "Repair Status Code");
    end;

    trigger OnBeforeDelete()
    begin
        if not ((UpperCase(UserId) in ['SUPER', 'EFFTRONICS\RAMADEVI', 'EFFTRONICS\NAGALAKSHMI', 'EFFTRONICS\PRANAVI', 'EFFTRONICS\BHAVANIP'])) then
            Error(' U Have No Rights to delete the Records ');
    end;



    var
        "ITEMLEDGER ENTRY": Record "Item Ledger Entry";
        "Dimension Value": Record "Dimension Value";
        TSH: Record "Troubleshooting Header";
        FaultArea: Record "Fault Area";
        PMIH: Record "Posted Material Issues Header";
        CTHGRec: Record "CS Transaction Header";
        CTLGRec: Record "CS Transaction Line";
        CTLedgGRec: Record "CS Stock Ledger";
        TransNoGVar: Text;
        StatusGVar: Option Working,"Non Working";
        totCardsGVar: Decimal;
        entryNoGVar: Integer;
        ItemGRec: Record Item;
        PMIL: Record "Posted Material Issues Line";
        reasonGvar: Code[20];
        StatGVar: Code[20];
        PMIHG: Record "Posted Material Issues Header";
        Station: Record Station;
        SH: Record "Service Header";
        stat: Record Station;
        Divi: Record "Employee Statistics Group";
        buf: Text;
        buf2: Text;
        ServHeader1: Record "Service Header";
        //SMTP_MAIL: Codeunit "SMTP Mail";
        Mail_From: Text;
        Mail_To: Text;
        Subject: Text;
        Body: Text;
        ServItem: Record "Service Item";
        ServItemLine: Record "Service Item Line";
        ServHeader1000: Record "Service Header";
        ServHeader: Record "Service Header";

    PROCEDURE Cards_Calc(Item: Code[20]; Status: Enum CardStatus) res: Decimal;
    VAR
        CsLedgerLRec: Record "CS Stock Ledger";
    BEGIN
        totCardsGVar := 0;
        CsLedgerLRec.Reset;
        CsLedgerLRec.SetFilter(CsLedgerLRec.Location, "From Location");
        CsLedgerLRec.SetFilter(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SetFilter(CsLedgerLRec.Received, '%1', true);
        CsLedgerLRec.SetFilter(CsLedgerLRec."Card Status", '%1', Status);
        if CsLedgerLRec.FindFirst then
                repeat
                    totCardsGVar := totCardsGVar + CsLedgerLRec.Quantity;
                until CsLedgerLRec.Next = 0;

        CsLedgerLRec.Reset;
        CsLedgerLRec.SetFilter(CsLedgerLRec.Location, "From Location");
        CsLedgerLRec.SetFilter(CsLedgerLRec."Item No", Item);
        CsLedgerLRec.SetFilter(CsLedgerLRec.Received, '%1', false);
        CsLedgerLRec.SetFilter(CsLedgerLRec."Card Status", '%1', Status);
        CsLedgerLRec.SetFilter(CsLedgerLRec.Quantity, '<0');
        if CsLedgerLRec.FindFirst then
            repeat
                    totCardsGVar := totCardsGVar + CsLedgerLRec.Quantity;
            until CsLedgerLRec.Next = 0;

        res := totCardsGVar;
    END;


    PROCEDURE CSTransEntry(card: Integer);
    BEGIN
        //site stock transaction entry. Added by mnraju on 20-Mar-2014
        ItemGRec.Reset;
        if ItemGRec.Get("Item No.") then begin
            //  IF ItemGRec."Product Group Code"='CPCB' THEN
            begin
                reasonGvar := '';
                StatGVar := '';
                PMIL.Reset;
                PMIL.SetFilter(PMIL."Material Issue No.", ServHeader."Material Issue no.");
                PMIL.SetFilter(PMIL."Item No.", "Item No.");

                if PMIL.FindFirst then begin
                    StatGVar := PMIL.Station;
                end;
                PMIHG.Reset;
                PMIHG.SetFilter(PMIHG."No.", ServHeader."Material Issue no.");
                if PMIHG.FindFirst then
                    reasonGvar := PMIHG."Reason Code";





                // totCardsGVar:=Cards_Calc("Item No.",StatusGVar::"Non Working");
                // IF totCardsGVar< 1 THEN
                //   ERROR('Quantity for Item %1 Status %2 must be equal or less than %3',"Item No.",StatusGVar::"Non Working",FORMAT(totCardsGVar));
                //   MESSAGE('line');

                //REC1
                // MESSAGE('ledger');
                //change status

                if not (("To Location" = 'SCRAP') or ("To Location" = 'DAMAGE') or ("To Location" = 'V-R-L')) then begin
                    CTLedgGRec.Reset;
                    CTLedgGRec.SetFilter(CTLedgGRec."Transaction ID", 'SER*');
                    if CTLedgGRec.FindLast then begin
                        TransNoGVar := IncStr(CTLedgGRec."Transaction ID");
                    end
                    else
                        TransNoGVar := 'SER0000001';
                    CTLedgGRec.Reset;
                    CTLedgGRec.SetCurrentKey(CTLedgGRec."Entry No.");
                    if CTLedgGRec.FindLast then begin
                        entryNoGVar := CTLedgGRec."Entry No.";
                    end;
                    // MESSAGE(FORMAT(entryNoGVar));

                    CTLedgGRec.Init;
                    CTLedgGRec."Entry No." := entryNoGVar + 1;
                    CTLedgGRec."Posted By" := UserId;
                    CTLedgGRec."Posting Date" := Today;
                    CTLedgGRec.Received := true;
                    CTLedgGRec.Quantity := -1;

                    CTLedgGRec."Transaction ID" := TransNoGVar;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Change Status";
                    CTLedgGRec.Location := "From Location";
                    CTLedgGRec."User ID" := UserId;
                    CTLedgGRec."Mode of Transport" := CTLedgGRec."Mode of Transport"::"By Hand";
                    CTLedgGRec."Courier Details" := '';
                    CTLedgGRec.Remarks := xRec."Document No.";
                    CTLedgGRec."Line No." := 10000;
                    CTLedgGRec."Item No" := "Item No.";
                    CTLedgGRec.Reason := reasonGvar;

                    //IF ("To Location" ='SCRAP') OR ("To Location" ='DAMAGE') OR ("To Location" ='V-R-L') THEN
                    //  CTLedgGRec."Card Status":=CTLGRec.Status::"Non Working"
                    // ELSE
                    CTLedgGRec."Card Status" := CTLGRec.Status::"Non Working";

                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."Received By" := UserId;
                    CTLedgGRec."Received Date" := Today;

                    CTLedgGRec.Insert;

                    //REC2
                    entryNoGVar := entryNoGVar + 2;
                    CTLedgGRec.Init;
                    CTLedgGRec."Entry No." := entryNoGVar;
                    CTLedgGRec."Posted By" := UserId;
                    CTLedgGRec."Posting Date" := Today;
                    CTLedgGRec.Received := true;
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Change Status";
                    CTLedgGRec.Location := "From Location";

                    //IF ("To Location" ='SCRAP') OR ("To Location" ='DAMAGE') OR ("To Location" ='VLOC') THEN
                    //  CTLedgGRec."Card Status":=CTLGRec.Status::"Non Working"
                    //ELSE
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;

                    CTLedgGRec.Quantity := 1;

                    CTLedgGRec."Transaction ID" := TransNoGVar;

                    CTLedgGRec."User ID" := UserId;
                    CTLedgGRec."Mode of Transport" := CTLedgGRec."Mode of Transport"::"By Hand";
                    CTLedgGRec."Courier Details" := '';
                    CTLedgGRec.Remarks := xRec."Document No.";
                    CTLedgGRec."Line No." := 10000;
                    CTLedgGRec."Item No" := "Item No.";
                    CTLedgGRec.Reason := reasonGvar;
                    CTLedgGRec.Station := StatGVar;
                    CTLedgGRec."Received By" := UserId;
                    CTLedgGRec."Received Date" := Today;

                    CTLedgGRec.Insert;
                end;



                //REC1
                // MESSAGE('ledger');
                //
                CTLedgGRec.Reset;
                CTLedgGRec.SetFilter(CTLedgGRec."Transaction ID", 'SER*');
                if CTLedgGRec.FindLast then begin
                    TransNoGVar := IncStr(CTLedgGRec."Transaction ID");
                end
                else
                    TransNoGVar := 'SER0000001';

                CTLedgGRec.Reset;
                CTLedgGRec.SetCurrentKey(CTLedgGRec."Entry No.");
                if CTLedgGRec.FindLast then begin
                    entryNoGVar := CTLedgGRec."Entry No.";
                end;
                // MESSAGE(FORMAT(entryNoGVar));

                CTLedgGRec.Init;
                CTLedgGRec."Entry No." := entryNoGVar + 1;
                CTLedgGRec."Posted By" := UserId;
                CTLedgGRec."Posting Date" := Today;
                CTLedgGRec.Received := true;
                CTLedgGRec.Quantity := -1;

                CTLedgGRec."Transaction ID" := TransNoGVar;
                if card = 0 then
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer"
                else
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";

                CTLedgGRec.Location := "From Location";
                CTLedgGRec."User ID" := UserId;
                CTLedgGRec."Mode of Transport" := CTLedgGRec."Mode of Transport"::"By Hand";
                CTLedgGRec."Courier Details" := '';
                CTLedgGRec.Remarks := xRec."Document No.";
                CTLedgGRec."Line No." := 10000;
                CTLedgGRec."Item No" := "Item No.";
                CTLedgGRec.Reason := reasonGvar;

                if ("To Location" = 'SCRAP') or ("To Location" = 'DAMAGE') or ("To Location" = 'V-R-L') then
                    CTLedgGRec."Card Status" := CTLGRec.Status::"Non Working"
                else
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;


                CTLedgGRec.Station := StatGVar;
                CTLedgGRec."Received By" := UserId;
                CTLedgGRec."Received Date" := Today;

                CTLedgGRec.Insert;

                //REC2
                entryNoGVar := entryNoGVar + 2;
                CTLedgGRec.Init;
                CTLedgGRec."Entry No." := entryNoGVar;
                CTLedgGRec."Posted By" := UserId;
                CTLedgGRec."Posting Date" := Today;
                CTLedgGRec.Received := true;
                CTLedgGRec.Location := "To Location";
                if ("To Location" = 'SCRAP') or ("To Location" = 'DAMAGE') or ("To Location" = 'V-R-L') then
                    CTLedgGRec."Card Status" := CTLGRec.Status::"Non Working"
                else
                    CTLedgGRec."Card Status" := CTLGRec.Status::Working;

                CTLedgGRec.Quantity := 1;

                CTLedgGRec."Transaction ID" := TransNoGVar;
                if card = 0 then
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Customer card Transfer"
                else
                    CTLedgGRec."Transaction Type" := CTHGRec."Transaction Type"::"Card Transfer";

                CTLedgGRec."User ID" := UserId;
                CTLedgGRec."Mode of Transport" := CTLedgGRec."Mode of Transport"::"By Hand";
                CTLedgGRec."Courier Details" := '';
                CTLedgGRec.Remarks := xRec."Document No.";
                CTLedgGRec."Line No." := 10000;
                CTLedgGRec."Item No" := "Item No.";
                CTLedgGRec.Reason := reasonGvar;
                CTLedgGRec.Station := StatGVar;
                CTLedgGRec."Received By" := UserId;
                CTLedgGRec."Received Date" := Today;

                CTLedgGRec.Insert;
            end;
        end;
        //end of mnraju
    END;


    LOCAL PROCEDURE mailsonaccountstatuschange();
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
    BEGIN
        /* Mail_From :='erp@efftronics.com';
        Mail_To := 'vishnupriya@efftronics.com';
        Subject := 'Reg: Service Card Account Change '+Rec."Document No.";
        Body:='';
        SMTP_MAIL.CreateMessage('ERP',Mail_From,Mail_To,Subject,Body,true);
        SMTP_MAIL.AppendBody('<html><head><style> divone{background-color: white; width: 900px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>');
        SMTP_MAIL.AppendBody('<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 800px;"><label><font size="6">Service Order Account Tick Mark</font></label>');
        SMTP_MAIL.AppendBody('<hr style=solid; color= #3333CC>');
        {
         SMTP_MAIL.AppendBody('<h>Dear Manufacturing Dept. ,</h><br><br>');
        SMTP_MAIL.AppendBody('<h><b>Responsible Dept: <font color=red>Manufacturing.</b></font></h><br>');
        SMTP_MAIL.AppendBody('<P> The below are details of RPO without Material Issues and have prod start date < today, </P>'); 
        }
        SMTP_MAIL.AppendBody('<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >User id</th><th >Service Order Number</th><th >service Item Number</th><th >Tickmark</th></tr>');
        //SMTP_MAIL.AppendBody('<th>Schedule Line No.</th><th>Quantity</th><th>Prod Start Date</th></tr>');
        SMTP_MAIL.AppendBody('<tr><td>'+UserId+'</td>');
        SMTP_MAIL.AppendBody('<td>'+Rec."Document No."+'</td>');
        SMTP_MAIL.AppendBody('<td>'+Rec."Service Item No."+'</td>');
        SMTP_MAIL.AppendBody('<td>'+Format(Rec.Account)+'</td></tr></table>');
        SMTP_MAIL.AppendBody('<td>'+Format(Rec."Repair Status Code")+'</td></tr></table>');
        SMTP_MAIL.Send;  */  //B2BUPG


        Recipients.Add('erp@efftronics.com');
        Recipients.Add('vishnupriya@efftronics.com');
        Subject := 'Reg: Service Card Account Change ' + Rec."Document No.";
        Body := '';

        Body := '<html><head><style> divone{background-color: white; width: 900px; padding: 20px; border-style:solid ; border-color:#666699;  margin: 20px;} </style></head>';
        Body := '<body><div style="border-color:#666699;  margin: 20px; border-width:15px;   border-style:solid; padding: 20px; width: 800px;"><label><font size="6">Service Order Account Tick Mark</font></label>';
        Body := '<hr style=solid; color= #3333CC>';

        /* Body:='<h>Dear Manufacturing Dept. ,</h><br><br>';
        Body:='<h><b>Responsible Dept: <font color=red>Manufacturing.</b></font></h><br>';
        Body:='<P> The below are details of RPO without Material Issues and have prod start date < today, </P>'; */

        Body := '<table border="1" style="border-collapse:collapse; width:100%; font-size:10pt;"><tr><th >User id</th><th >Service Order Number</th><th >service Item Number</th><th >Tickmark</th></tr>';
        //Body:='<th>Schedule Line No.</th><th>Quantity</th><th>Prod Start Date</th></tr>';
        Body := '<tr><td>' + UserId + '</td>';
        Body := '<td>' + Rec."Document No." + '</td>';
        Body := '<td>' + Rec."Service Item No." + '</td>';
        Body := '<td>' + Format(Rec.Account) + '</td></tr></table>';
        Body := '<td>' + Format(Rec."Repair Status Code") + '</td></tr></table>';
        EmailMessage.Create(Recipients, Subject, Body, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);

    END;
}

