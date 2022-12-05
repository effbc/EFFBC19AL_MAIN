tableextension 70121 MachineCenterExt extends "Machine Center"
{
    fields
    {
        field(60090; "User Id"; Code[20])
        {
            Description = 'b2b';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}

