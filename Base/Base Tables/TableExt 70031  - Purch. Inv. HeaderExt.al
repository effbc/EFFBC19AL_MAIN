tableextension 70031 PurchInvHeaderExt extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "MSPT Date"; Date)
        {
            Description = 'MSPT1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "MSPT Code"; Code[20])
        {
            Description = 'MSPT1.0';
            Editable = false;
            TableRelation = "MSPT Header".Code WHERE(Status = CONST(Released));
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                MSPTHeader: Record "MSPT Header";
                "MSPT Details": Record "MSPT Line";
            begin
            end;
        }
        field(50002; "MSPT Applicable at Line Level"; Boolean)
        {
            Description = 'MSPT1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6000; "Amount to Vendor"; Decimal)
        {

            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = Sum("Purch. Inv. Line"."Amount To Vendor" WHERE("Document No." = FIELD("No.")));
        }
        field(60001; "Vendor Excise Invoice No."; Code[30])
        {
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60002; "Vend. Excise Inv. Date"; Date)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60003; "Cancel Short Close"; Enum "Csut Cancel Short Close")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "RFQ No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Service Invoice Line Archive"."Document No.";
            DataClassification = CustomerContent;
        }
        field(60005; Make; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60006; "Packint Type"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; Verification; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60008; "Invoiced Amount"; Decimal)
        {
            CalcFormula = Sum("Purch. Inv. Line".Amount WHERE("Document No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(60019; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60079; "Order (Digits)"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60091; "OLD Dim Set ID"; Integer)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            TableRelation = "Dimension Set Entry Backup2"."Dimension Set ID" WHERE("Dimension Set ID" = FIELD("OLD Dim Set ID"));
            DataClassification = CustomerContent;


        }
        field(60092; "Dimension Corrected"; Boolean)
        {
            Description = 'added  by sujani for Dimension issue clearance (B2B Assistance)';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60095; "Actual Invoiced Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60096; "Additional Duty Value"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60097; "Type of Supplier"; Option)
        {
            OptionCaption = '" ,Manufacturer,First Stage Dealer,Second Stage Dealer,Importer,Trader,Authorized distributor"';
            OptionMembers = " ",Manufacturer,"First Stage Dealer","Second Stage Dealer",Importer,Trader,"Authorized distributor";
            DataClassification = CustomerContent;
        }
        field(60098; "Excise Not to Consider"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60099; "C Status"; Enum "Cust Purch Line Enum8")
        {
            DataClassification = CustomerContent;
        }
        field(60100; "Vehicle Number"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60101; "Transporter Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(60102; "C-Form Number"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60103; "C-Form Issue Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60104; "Excise Claimed Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60105; ExciseRemarks; Enum "Cust Purch Line Enum4")
        {
            DataClassification = CustomerContent;
        }
        field(60122; "Tarrif Heading No"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(60127; RCM_Paid_Date; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70001; "% of input for Claimed Month"; Enum "Cust Purch Line1")
        {
            Description = 'added by vishnu Priya for the GST Claiming  Purpose';

        }
        //B2BPGOn15Nov2022>>>
        field(70002; "Vendor Invoice No.1"; Code[98])
        {
            DataClassification = CustomerContent;
        }//B2BPGOn15Nov2022>>>
    }


    var
        USER: Record User;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit 397;
        Subject: Text[250];
}

