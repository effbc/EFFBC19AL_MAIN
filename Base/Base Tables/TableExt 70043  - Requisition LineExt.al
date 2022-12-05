tableextension 70043 RequisitionLineExt extends "Requisition Line"
{
    fields
    {
        field(60001; "Enquiry Created"; Boolean)
        {
            Description = 'POAU';
            DataClassification = CustomerContent;
        }
        field(60002; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }

}

