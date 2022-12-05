tableextension 70029 PurchRcptHeaderExt extends "Purch. Rcpt. Header"
{
    fields
    {
        modify("No.")
        {
            CaptionML = ENU = 'Reciept No.', ENN = 'Reciept No.';
        }
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
        field(60001; "Vendor Excise Invoice No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Vend. Excise Inv. Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "Cancel Short Close"; Option)
        {
            Description = 'B2B';
            OptionCaption = '" ,Cancelled,Short Closed"';
            OptionMembers = " ",Cancelled,"Short Closed";
            DataClassification = CustomerContent;
        }
        field(60004; "RFQ No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Create Indents"."Item No.";
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
        field(60013; "Bill Received"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60014; "Bill Transfered"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Bill Received" = false then
                    Error('Bill received must be ticked')
                else begin
                    if UpperCase(UserId) in ['EFFTRONICS\PARDHU', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\ANANDA', 'EFFTRONICS\MARY', 'EFFTRONICS\PADMASRI',
                      'EFFTRONICS\B2BOTS', 'EFFTRONICS\20TE061', 'EFFTRONICS\GRAVI', 'EFFTRONICS\NSUDHEER', 'EFFTRONICS\ASWINI', 'EFFTRONICS\CHRAJYALAKSHMI', 'EFFTRONICS\MRAJYALAKSHMI', 'EFFTRONICS\SUJITH', 'EFFTRONICS\BLAVANYA', 'EFFTRONICS\SNANDINI'] then begin
                        "Bill Transfered Date" := Today;
                    end else begin
                        Error(t1);
                        "Bill Transfered Date" := 0D;
                    end;
                end;
            end;
        }
        field(60015; "Bill Transfered Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60016; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60017; "Created Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Vendor Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(60079; "Order (Digits)"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(60080; Pending; Boolean)
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
        field(60093; "QC Passed"; Boolean)
        {
            Description = 'added  by sujani for QC Passed confirmation to Bill Transfer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    var
        t1: Label 'u have no permissions';
    /* USER: Record User;
    Body: Text[250];
    Mail_From: Text[250];
    Mail_To: Text[250];
    Mail: Codeunit 397;
    Subject: Text[250]; */
}

