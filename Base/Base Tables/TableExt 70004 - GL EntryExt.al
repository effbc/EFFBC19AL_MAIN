tableextension 70004 GLEntryExt extends "G/L Entry"
{

    fields
    {
        modify("Posting Date")
        {
            ClosingDates = true;
        }

        field(50000; "Cheque No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60063; "customer Ord No"; Code[65])
        {
            DataClassification = CustomerContent;
        }
        field(60064; "Payment Type"; Option)
        {
            OptionCaption = ',Supply Payment,AMC Amount,Final Payment,Inst.Payment,Advance,Receipt,Contra,payment,Journal,Excess';
            OptionMembers = ,"Supply Payment","AMC Amount","Final Payment","Inst.Payment",Advance,Receipt,Contra,payment,Journal,Excess;
            DataClassification = CustomerContent;
        }
        field(60069; "From Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60070; "To Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60071; "System Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60072; Attachment; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60073; "Apply Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60074; Check; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60075; "Sale Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60079; "DD/FDR No."; Code[20])
        {
            Description = 'Rev01';
            DataClassification = CustomerContent;
        }
        field(60080; "Payment Through"; Enum "Payment Through")
        {
            Description = 'Rev01';

            DataClassification = CustomerContent;
        }
        field(60081; "Tender No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60082; "Final Bill Payment"; Boolean)
        {
            Description = 'Added by Pranavi for SD Tracking';
            DataClassification = CustomerContent;
        }
        field(60083; "Currency Amount"; Decimal)
        {
            Description = 'Added by Pranavi for foreign currency tracking';
            DataClassification = CustomerContent;
        }
        field(60084; "Currency Rate"; Decimal)
        {
            Description = 'Added by Pranavi for foreign currency tracking';
            DataClassification = CustomerContent;
        }
        field(60085; "Currency Code"; Code[10])
        {
            Description = 'Added by Pranavi for foreign currency tracking';
            DataClassification = CustomerContent;
        }
        field(60086; "Old Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60087; Vertical; Option)
        {
            Description = 'Added by vijaya for vertical expenditure';
            OptionCaption = '" ,Smart Signalling,Smart Cities,Smart Building,IOT,other,AMC"';
            OptionMembers = " ","Smart Signalling","Smart Cities","Smart Building",IOT,other,AMC;
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


        }
        field(60092; "GST TDS Claimed Date"; Date)
        {
            Description = 'Added by Vishnu Priya for the TDS Claiming Process';
            DataClassification = CustomerContent;
        }
        field(60093; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }


    trigger OnDelete()
    begin
        USER.RESET;
        USER.SETFILTER("User ID", USERID);
        IF USER.FINDFIRST THEN BEGIN
            //IF (NOT( USER.Tams_Dept IN ['SAL','ERP','F&A'])) AND (NOT(USER."User Name" IN ['EFFTRONICS\YESU','EFFTRONICS\MBNAGAMANI','EFFTRONICS\SSIRISHA','EFFTRONICS\RISHIANVESH','EFFTRONICS\GANURADHA'])) THEN
            IF (NOT (USER.Tams_Dept IN ['ERP'])) THEN //modified by priyanka to remove edit permissions
                ERROR('You don''t have Permissions');
        END
        ELSE
            ERROR('User not found. Contact ERP');
    end;

    var
        USER: Record "User Setup";
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit 8901;
        Subject: Text[250];
        UserSetupGRec: Record "User Setup";
}

