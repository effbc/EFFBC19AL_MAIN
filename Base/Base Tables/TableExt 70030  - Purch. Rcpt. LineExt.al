tableextension 70030 PurchRcptLineExt extends "Purch. Rcpt. Line"
{
    fields
    {

        field(60001; "Indent No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60002; "Indent Line No."; Integer)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60003; Remarks; Text[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60007; "Delivery Rating"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
        field(60008; "Document date"; Date)
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Posting Date" WHERE("No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(60009; "Store Remarks"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60013; Sample; Boolean)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60014; Make; Code[30])
        {
            TableRelation = Make;
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
        field(60092; "QC Passed"; Boolean)
        {
            Description = 'added  by sujani for QC Passed confirmation to Bill Transfer';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70005; "Part Number"; Code[40])
        {
            DataClassification = CustomerContent;
        }
        field(33000250; "Spec ID"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000251; "Quantity Accepted"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if ("Quantity Accepted" + "Quantity Rework") > Quantity then
                    Error('Sum of the Quantity accepted and rejected should not be more than Receipt Quantity');
            end;
        }
        field(33000252; "Quantity Rework"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Validate("Quantity Accepted");
            end;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000254; "Quantity Rejected"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000255; "Quality Before Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000259; "Spec Version"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("Spec ID"));
            DataClassification = CustomerContent;
        }
        field(95403; Description1; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(95401; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    trigger OnModify()
    begin
        IF NOT (USERID IN ['EFFTRONICS\TPRIYANKA', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\GRAVI']) THEN
            ERROR('You donot have rights to delete.Contact ERP Team');
    end;

    PROCEDURE UndoReceiptLine();
    VAR
        PurchRcptLine: Record "Purch. Rcpt. Line";
        IDS: Record "Inspection Datasheet Header";
        IDSL: Record "Inspection Datasheet Line";
        QILE: Record "Quality Item Ledger Entry";
        PIDS: Record "Posted Inspect DatasheetHeader";
        PIDSL: Record "Posted Inspect Datasheet Line";
        IR: Record "Inspection Receipt Header";
    BEGIN
        IF Rec."QC Enabled" = TRUE THEN BEGIN
            IDS.SETRANGE("Receipt No.", Rec."Document No.");
            IDS.SETRANGE("Purch Line No", Rec."Line No.");
            IF IDS.FINDSET THEN BEGIN
                REPEAT
                    PIDS.TRANSFERFIELDS(IDS);
                    PIDS."Quality Status" := PIDS."Quality Status"::Cancel;
                    PIDS.INSERT;
                    IDS.DELETE;
                    IDSL.SETRANGE("Document No.", IDS."No.");
                    IF IDSL.FINDSET THEN BEGIN
                        REPEAT
                            PIDSL.TRANSFERFIELDS(IDSL);
                            PIDSL.INSERT;
                        UNTIL IDSL.NEXT = 0;
                        IDSL.DELETEALL;
                    END;
                UNTIL IDS.NEXT = 0;
                QILE.SETRANGE("Document No.", IDS."Receipt No.");
                QILE.SETRANGE(QILE."Purch.Rcpt Line", Rec."Line No.");
                IF QILE.FINDSET THEN
                    REPEAT
                        QILE.DELETE;
                    UNTIL QILE.NEXT = 0;
            END;
        END;

        /* IR.SETRANGE("Receipt No.", "Document No.");
        IR.SETRANGE("Purch Line No", "Line No.");
        IR.SETFILTER(Status, 'NO');
        IF IR.FINDSET THEN BEGIN
            REPEAT
                IR.Status := TRUE;
                //IR."Quality Status" := IR."Quality Status" :: Close;
                IR.MODIFY;
            UNTIL IR.NEXT = 0;
        END;
        QILE.SETRANGE("Document No.", IR."Receipt No.");
        QILE.SETRANGE(QILE."Purch.Rcpt Line", "Line No.");
        IF QILE.FINDSET THEN
            REPEAT
                QILE.DELETE;
            UNTIL QILE.NEXT = 0;
    END; */

    end;


    var
        USER: Record User;
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit 397;
        Subject: Text[250];
    //TDSNatureofDeduction: Record "TDS Nature of Deduction";
}

