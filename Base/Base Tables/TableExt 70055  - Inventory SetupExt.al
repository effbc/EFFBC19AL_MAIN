tableextension 70055 InventorySetupExt extends "Inventory Setup"
{
    fields
    {
        field(50001; "Material Issue Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50002; "Posted Material Issue Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60000; "RGP Out No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60001; "RGP In No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60002; "DC Nos."; Code[10])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60003; "Packing Charge Group"; Code[20])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
            //TableRelation = "Tax/Charge Group";
        }
        field(60004; "Material Issues No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(60005; "Posted Issue No."; Code[20])
        {
            Description = 'B2B';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

}

