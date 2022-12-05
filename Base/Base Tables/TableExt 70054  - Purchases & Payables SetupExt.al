tableextension 70054 PurchasesPayablesSetupExt extends "Purchases & Payables Setup"
{
    fields
    {
        field(60001; "Purchase Indent Nos."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60002; "RFQ Nos."; Code[10])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60003; "ICN Nos."; Code[10])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60004; "Enquiry Nos."; Code[10])
        {
            Description = 'POAU';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60005; "Price Required"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Price Weightage", 0);
            end;
        }
        field(60006; "Price Weightage"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Price Required");
            end;
        }
        field(60007; "Quality Required"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Quality Weightage", 0);
            end;
        }
        field(60008; "Quality Weightage"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Quality Required");
            end;
        }
        field(60009; "Delivery Required"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Delivery Weightage", 0);
            end;
        }
        field(60010; "Delivery Weightage"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Delivery Required");
            end;
        }
        field(60011; "Payment Terms Required"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Payment Terms Weightage", 0);
            end;
        }
        field(60012; "Payment Terms Weightage"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                TestField("Payment Terms Required");
            end;
        }
        field(60013; "Default Quality Rating"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
        field(60014; "Default Delivery Rating"; Decimal)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
    }
}

