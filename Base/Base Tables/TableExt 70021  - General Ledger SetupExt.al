tableextension 70021 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        field(50000; "ESPL Attachment Storage Type"; Enum "GeneralLedger Enum")
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

        }
        field(50001; "ESPL Attmt. Storage Location"; Text[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(50002; "MSPT Cust. Balances Due"; Decimal)
        {
            CalcFormula = Sum("MSPT Dtld. Cust. Ledg. Entry"."MSPT Amount" WHERE("Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                  "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                  "MSPT Due Date" = FIELD("Date Filter")));
            Description = 'MSPT1.0';
            FieldClass = FlowField;
        }
        field(50003; "MSPT Vendor Balances Due"; Decimal)
        {
            CalcFormula = - Sum("MSPT Dtld. Vendor Ledg. Entry"."MSPT Amount" WHERE("Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                    "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                    "MSPT Due Date" = FIELD("Date Filter")));
            Description = 'MSPT1.0';
            FieldClass = FlowField;
        }
        field(50004; "Shortage. Calc. Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Data Confirmation"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50006; "Sql Connection String"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50007; "Active ERP-CF Connection"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50008; "Expected Orders Data Dump"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50009; "Allow Posting to(15)"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Daily Entrires Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Session Killer Time Setup"; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(50012; "Restrict Store Material Issues"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Production_ Shortage_Status"; Enum "Item Journal Line Enum1")
        {
            DataClassification = CustomerContent;

        }
        field(50014; "Production Shortage Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Day Wise Issues Status"; Enum "Item Journal Line Enum1")
        {
            Description = 'Pranavi';
            DataClassification = CustomerContent;

        }
    }
    keys
    {

    }

    var
        Body: Text[250];
        Mail_From: Text[250];
        Mail_To: Text[250];
        //Mail: Codeunit 397;
        Subject: Text[250];
        User: Record User;
}
