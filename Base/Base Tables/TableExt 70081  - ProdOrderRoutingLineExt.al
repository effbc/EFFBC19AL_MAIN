tableextension 70081 ProdOrderRoutingLineExt extends "Prod. Order Routing Line"
{
    fields
    {
        field(60001; "Operation Description"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Item No."; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; Move; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60004; "Total Time"; Decimal)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60005; "Item Description"; Text[50])
        {
            Description = 'B2B,length changed from 30-50(sundar)';
            DataClassification = CustomerContent;
        }
        field(60100; "Allocated Qty.1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60101; "Person.2"; Code[20])
        {
            TableRelation = IF (Type = CONST("Work Center")) "Work Center" ELSE
            IF (Type = CONST("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;
        }
        field(60102; "Allocated Qty.2"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60103; "Person.3"; Code[20])
        {
            TableRelation = IF (Type = CONST("Work Center")) "Work Center" ELSE
            IF (Type = CONST("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;
        }
        field(60104; "Allocated Qty.3"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60105; "Person.4"; Code[20])
        {
            TableRelation = IF (Type = CONST("Work Center")) "Work Center" ELSE
            IF (Type = CONST("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;
        }
        field(60106; "Allocated Qty.4"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60107; "Person.5"; Code[20])
        {
            TableRelation = IF (Type = CONST("Work Center")) "Work Center" ELSE
            IF (Type = CONST("Machine Center")) "Machine Center";
            DataClassification = CustomerContent;
        }
        field(60108; "Allocated Qty.5"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60109; PlannedStartDate; Date)
        {
            Description = 'Added by sujani for Routing day wise activities calculation';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(33000250; "Sub Assembly"; Code[20])
        {
            TableRelation = "Sub Assembly";
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF "Sub Assembly" = '' THEN BEGIN
                    "Spec Id" := '';
                    "QC Enabled" := FALSE;
                END ELSE BEGIN
                    SubAssembly.GET("Sub Assembly");
                    "Spec Id" := SubAssembly."Spec Id";
                    //B2B
                    //Hot Fix 1.0
                    IF "Spec Id" <> '' THEN
                        "Spec Version Code" := GetSpecVersion;
                    //Hot Fix 1.0
                    //B2B
                    "QC Enabled" := SubAssembly."QC Enabled";
                    "Sub Assembly Description" := SubAssembly.Description;
                END;
            end;
        }
        field(33000251; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33000252; "Spec Id"; Code[20])
        {
            TableRelation = "Specification Header";
            DataClassification = CustomerContent;
        }
        field(33000253; "QC Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33000254; "Sub Assembly Unit Of Meas.Code"; Code[20])
        {
            TableRelation = "Sub Assembly Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(33000255; "Qty.To Produce"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF "Qty.To Produce" < 0 THEN
                    ERROR('Qty.To be  Produced should not be Negative');
                IF "Qty.To Produce" + "Quantity Produced" > Quantity THEN
                    MESSAGE('Quantity To Produce and Quantity Produced is more than Quantity');
            end;
        }
        field(33000256; "Quantity Produced"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Qty.To Produce" := Quantity - "Quantity Produced";
            end;
        }
        field(33000257; "Sub Assembly Description"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(33000258; "Spec Version Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33000259; "Quantity Sent To Quality"; Decimal)
        {
            Description = 'B2B 1.1';
            DataClassification = CustomerContent;
        }
        field(33000260; "Quantity Accepted"; Decimal)
        {
            CalcFormula = Sum("Quality Ledger Entry".Quantity WHERE("Source Type" = FILTER(WIP), "Order No." = FIELD("Prod. Order No."), "Order Line No." = FIELD("Routing Reference No."), "Entry Type" = FILTER(Accepted), "Operation No." = FIELD("Operation No.")));
            Description = 'B2B 1.1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33000261; "Quantity Rejected"; Decimal)
        {
            Description = 'B2B 1.1';
            DataClassification = CustomerContent;
        }
        field(33000262; "Quantity Rework"; Decimal)
        {
            Description = 'B2B 1.1';
            DataClassification = CustomerContent;
        }
        field(33000263; "Newly Added Opearation"; Boolean)
        {
            Description = 'B2B 1.1,QCB2B1.2';
            DataClassification = CustomerContent;
        }
        field(33000264; "Prev. Qty"; Decimal)
        {
            Description = 'B2B 1.1,QCB2B1.2';
            DataClassification = CustomerContent;
        }
        field(33000265; "QAS/MPR"; Enum "QAS MPR")
        {
            Description = 'B2B 1.1,QCB2B1.2';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key13; Status, "Prod. Order No.", "Routing Reference No.", "Starting Date")
        {
        }
        key(Key14; Status, "Starting Date", "Routing Reference No.", "Operation No.")
        {
        }
    }




    var
        "--QC1--": Integer;
        SubAssembly: Record "Sub Assembly";
        "------": Integer;
    //"Prod.OrderLine": Record "Prod. Order Line";

    PROCEDURE CreateInprocInspectSheet();
    VAR
        InspectDataSheet: Codeunit "Inspection Data Sheets";
    BEGIN
    END;


    PROCEDURE GetSpecVersion(): Code[20];
    VAR
        SpecHeader: Record "Specification Header";
    BEGIN
    END;
}

