tableextension 70237 ZoneExt extends Zone
{
    fields
    {
        modify(Code)
        {
            Caption = 'Zone Code';
        }
        modify(Description)
        {
            Caption = 'Zone Name';
        }
        field(50000; Code1; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }

}

