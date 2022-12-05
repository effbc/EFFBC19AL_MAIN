tableextension 70202 ReservationEntryExt extends "Reservation Entry"
{

    fields
    {

        field(50000; Description1; Text[150])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key11; "Item No.", "Variant Code", "Location Code", "Source Type", "Source Subtype", "Reservation Status", "Expected Receipt Date")
        {

        }
    }

}

