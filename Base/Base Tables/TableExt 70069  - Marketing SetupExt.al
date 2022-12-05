tableextension 70069 MarketingSetupExt extends "Marketing Setup"
{
    fields
    {

        field(60001; "Product ID"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60002; "Product Competetors"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

}

