tableextension 70053 SalesReceivablesSetupExt extends "Sales & Receivables Setup"
{

    fields
    {
        field(60001; "Tender Nos."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60002; "Tender Posting Nos."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

        field(60003; SingleQuoteValue; Text[1])
        {
            DataClassification = CustomerContent;
        }

        field(60992; "Third Party Nos."; Code[20])
        {

            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }

    }

}

