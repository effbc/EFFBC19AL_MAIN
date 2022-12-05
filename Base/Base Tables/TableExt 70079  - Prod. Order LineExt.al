tableextension 70079 ProdOrderLineExt extends "Prod. Order Line"
{
    fields
    {
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            begin
                if not (UserId in ['EFFTRONICS\SUJANI', 'EFFTRONICS\VISHNUPRIYA', 'EFFTRONICS\VSNGEETHA', 'EFFTRONICS\GRAVI', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\DURGAMAHESWARI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\SUVARCHALADEVI']) then
                    Error('Dont have rights to Modify');
            end;
        }

        field(60001; Resource; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Machine Center"."No.";
            DataClassification = CustomerContent;
        }
        field(60002; "Sales Order No"; Code[20])
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
        field(33000250; "WIP QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000251; "WIP Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000252; "Quantity Sent To Quality"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(33000253; "Quantity Sending To Quality"; Decimal)
        {
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(33000254; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Source Type" = FILTER(WIP),
                                                                     "Order No." = FIELD("Prod. Order No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Accepted),
                                                                     "Operation No." = FILTER(= '')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000255; "Quantity Rejected"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Source Type" = FILTER(WIP),
                                                                     "Order No." = FIELD("Prod. Order No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Reject),
                                                                     "Operation No." = FILTER('')));
            FieldClass = FlowField;
        }
        field(33000256; "Quantity Rework"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Source Type" = FILTER(WIP),
                                                                     "Order No." = FIELD("Prod. Order No."),
                                                                     "Order Line No." = FIELD("Line No."),
                                                                     "Entry Type" = FILTER(Rework),
                                                                     "Operation No." = FILTER('')));
            FieldClass = FlowField;
        }
        field(33000257; "Spec Version Code"; Code[20])
        {
            TableRelation = "Specification Version"."Version Code" WHERE("Specification No." = FIELD("WIP Spec Id"));
            DataClassification = CustomerContent;
        }
        field(70093; "Prod. Order No.1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(70094; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }

        field(60003; "Tot Benchmarks"; Decimal)

        {
            DataClassification = CustomerContent;
            Description = 'added by suvarchala for production plan';
        }
        field(60004; "Soldering Time(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'added by suvarchala for production plan';
        }

        Field(60093; "Benchmark(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'added by suvarchala for production plan';
        }
        Field(60094; "Total Benchmarks(in Min)"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'added by suvarchala for production plan';
        }



    }



    var
        PurchaseList: Record "Purchase Header";
        Text16322: Label 'No Subcontracting Orders exist for the selected line.';
        "--QC--": Integer;
        InspectDataSheets: Codeunit "Inspection Data Sheets";


    PROCEDURE "--WIP---"();
    BEGIN
    END;


    PROCEDURE CreateInspectionDataSheets();
    BEGIN
        InspectDataSheets.CreateProdLineInspectDataSheet(Rec);
    END;


    PROCEDURE ShowDataSheets();
    VAR
        InspectDataSheet: Record "Inspection Datasheet Header";
    BEGIN
        InspectDataSheet.SetRange("Prod. Order No.", "Prod. Order No.");
        InspectDataSheet.SetRange("Prod. Order Line", "Line No.");
        InspectDataSheet.SetRange("Item No.", "Item No.");
        PAGE.Run(PAGE::"Inspection Data Sheet List", InspectDataSheet);
    END;


    PROCEDURE ShowPostDataSheets();
    VAR
        PostInspectDataSheet: Record "Posted Inspect DatasheetHeader";
    BEGIN
        PostInspectDataSheet.SetRange("Prod. Order No.", "Prod. Order No.");
        PostInspectDataSheet.SetRange("Prod. Order Line", "Line No.");
        PostInspectDataSheet.SetRange("Item No.", "Item No.");
        PAGE.Run(PAGE::"Posted Inspect Data Sheet List", PostInspectDataSheet);
    END;


    PROCEDURE ShowInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Prod. Order No.", "Prod. Order No.");
        InspectionReceipt.SetRange("Prod. Order Line", "Line No.");
        InspectionReceipt.SetRange("Item No.", "Item No.");
        InspectionReceipt.SetRange(Status, false);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE ShowPostInspectReceipt();
    VAR
        InspectionReceipt: Record "Inspection Receipt Header";
    BEGIN
        InspectionReceipt.SetRange("Prod. Order No.", "Prod. Order No.");
        InspectionReceipt.SetRange("Prod. Order Line", "Line No.");
        InspectionReceipt.SetRange("Item No.", "Item No.");
        InspectionReceipt.SetRange(Status, true);
        PAGE.Run(PAGE::"Inspection Receipt List", InspectionReceipt);
    END;


    PROCEDURE GetSpecVersion(): Code[20];
    VAR
        SpecHeader: Record "Specification Header";
    BEGIN
        exit(SpecHeader.GetSpecVersion("WIP Spec Id", WorkDate, true));
    END;
}

