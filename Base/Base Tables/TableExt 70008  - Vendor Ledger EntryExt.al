tableextension 70008 VendorLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(60073; "DD/FDR No."; Code[20])
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60074; "Payment Through"; Enum "VendorLedg Payment")
        {
            Description = 'Rev01';
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

            trigger OnLookup();
            begin
                ShowDimensionsOLD;
            end;
        }
        field(60092; "Document No.1"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(60039; "Description1"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "Vendor Invoice Date"; date)
        {
            Caption = 'Vendor Invoice Date';
            DataClassification = CustomerContent;
        }
    }
    trigger OnModify()
    var
        myInt: Integer;
    begin
        /*{IF UserSetupGRec.GET(USERID) THEN
          BEGIN
            IF NOT UserSetupGRec."Edit Posted Ledger Entries" THEN
              ERROR('You Dont have Permissions');
          END ELSE
            ERROR('User Setup not found. contact ERP Team');
          }*/
        // Commented by Vishnu Priya on 31-10-2020

        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            //IF NOT (USER.Tams_Dept IN ['CRROOM', 'ERP']) THEN//B2BJKOn18Jun2022
            IF (NOT (USER.Tams_Dept IN ['ERP']) AND NOT (USER."User ID" IN ['EFFTRONICS\VHARIPRASAD', 'EFFTRONICS\PARDHU', 'EFFTRONICS\BLAVANYA', 'EFFTRONICS\SUJITH', 'EFFTRONICS\ASWINI'])) THEN//modified by durga on 09-08-2021
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    END;


    trigger OnDelete()
    var
        myInt: Integer;
    begin
        //modified by durga on 09-08-2021
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            IF NOT (USER.Tams_Dept IN ['ERP']) THEN//modified by durga on 09-08-2021
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
        /* {     Body:='****  Auto Mail Generated From ERP  ****';
                   Mail_From:='erp@efftronics.net';
                  Mail_To:='anilkumar@efftronics.net,santhoshk@efftronics.net,swarupa@efftronics.net,sreenu@efftronics.net,phani@efftronics.net';
              
                  // Mail_To:='santhoshk@efftronics.net';
                   USER.SETRANGE(USER."User Security ID",USERID);//Changed User."User Id" to User."User Security ID" B2B
                   IF USER.FIND('-') THEN
                   Subject:=USER."User Name"+'  is trying to Delete Vendor Ledger Entry Records';//Changed User.Name to User."User Name" B2B
                   Mail.NewCDOMessage(Mail_From,Mail_To,Subject,Body,'');  }*/
        ERROR('U Dont Have Permissions to Delete');
    end;

    LOCAL PROCEDURE ShowDimensionsOLD();
    VAR
        DimensionSetEntryBackup: Record "Dimension Set Entry Backup2";
        DimeSetEntryOld: Page "dimension set entry page old";
    BEGIN
        DimensionSetEntryBackup.RESET;
        DimensionSetEntryBackup.FILTERGROUP(2);
        DimensionSetEntryBackup.SETRANGE("Dimension Set ID", "OLD Dim Set ID");
        DimensionSetEntryBackup.FILTERGROUP(0);
        DimeSetEntryOld.SETTABLEVIEW(DimensionSetEntryBackup);
        DimeSetEntryOld.RUNMODAL;
    END;

    procedure CalcAppliedTDSBase(AppliedAmount: Decimal; TDSNatureofDeduction: Code[10]): Decimal;
    VAR
        TDSEntry: Record "TDS Entry";
        ApplicationRatio: Decimal;
        TDSBaseAmount: Decimal;
    BEGIN
        /*
         CALCFIELDS(Amount);
         IF Amount = 0 THEN
             EXIT(0);
         TDSEntry.SETRANGE("Transaction No.", "Transaction No.");
         TDSEntry.SETRANGE("TDS Nature of Deduction", TDSNatureofDeduction);
         IF TDSEntry.FINDSET THEN
             REPEAT
                 IF TDSEntry."TDS Base Amount" = 0 THEN
                     TDSBaseAmount += TDSEntry."Work Tax Base Amount"
                 ELSE BEGIN  // >>ALLE.TDS-REGEF START
                     IF TDSEntry."Calc. Over & Above Threshold" THEN BEGIN
                         IF TDSEntry."TDS Base Amount" < TDSEntry."Invoice Amount" THEN
                             TDSBaseAmount += TDSEntry."Invoice Amount"
                         ELSE
                             TDSBaseAmount += TDSEntry."TDS Base Amount";
                     END ELSE // <<ALLE.TDS-REGEF STOP
                         TDSBaseAmount += TDSEntry."TDS Base Amount";
                 END;
             UNTIL TDSEntry.NEXT = 0;

         IF TDSEntry."TDS Line Amount" > TDSBaseAmount THEN
             IF ABS(AppliedAmount) >= TDSBaseAmount THEN
                 ApplicationRatio := 1
             ELSE
                 ApplicationRatio := ABS(TDSBaseAmount - AppliedAmount) / TDSBaseAmount
         ELSE
             IF ABS(AppliedAmount) >= TDSBaseAmount THEN
                 ApplicationRatio := 1
             ELSE
                 ApplicationRatio := ABS(AppliedAmount) / TDSBaseAmount;

         EXIT(ROUND(TDSBaseAmount * ApplicationRatio));
         */
    END;


    var
        USER: Record "User Setup";
    /* Body: Text[250];
    Mail_From: Text[250];
    Mail_To: Text[250];
    Mail: Codeunit 8901;
    Subject: Text[250]; */
    //  UserSetupGRec: Record "User Setup";

}

