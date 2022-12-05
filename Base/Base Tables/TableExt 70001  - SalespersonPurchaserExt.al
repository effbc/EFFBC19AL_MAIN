tableextension 70001 SalespersonPurchaserExt extends "Salesperson/Purchaser"
{
    fields
    {
        field(60000; "Salesperson/Purchaser"; Option)
        {
            Description = 'B2B';
            OptionMembers = Sale,Purchase,CS;
            DataClassification = CustomerContent;
        }
        field(60001; PastEmp; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60002; "Sales Person Signature"; BLOB)
        {
            DataClassification = CustomerContent;
            SubType = Bitmap;
        }
    }



}

