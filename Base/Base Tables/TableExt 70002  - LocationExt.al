tableextension 70002 CustLocationExt extends Location
{
    fields
    {

        field(60001; "QC Enabled Location"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; Stores; Option)
        {
            OptionMembers = STR,"CS STR","RD STR","PRD STR",SCRAP;
            DataClassification = CustomerContent;
        }

        field(60012; "T.I.N. No.1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
}

