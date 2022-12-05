tableextension 70057 TrackingSpecificationExt extends "Tracking Specification"
{

    fields
    {

        modify("Item Ledger Entry No.")
        {
            trigger OnBeforeValidate()
            var
                ReservationEntry: Record "Reservation Entry";
            begin
                ReservationEntry.SetRange("Item No.", "Item No.");
                ReservationEntry.SetRange("Location Code", "Location Code");
                ReservationEntry.SetRange("Source Type", "Source Type");
                ReservationEntry.SetRange("Source Subtype", "Source Subtype");
                ReservationEntry.SetRange("Source ID", "Source ID");
                ReservationEntry.SetRange("Source Batch Name", "Source Batch Name");
                ReservationEntry.SetRange("Lot No.", "Lot No.");
                ReservationEntry.SetRange("Serial No.", "Serial No.");
                if ReservationEntry.Find('-') then
                    repeat
                        ReservationEntry."Appl.-to Item Entry" := "Appl.-to Item Entry";
                        ReservationEntry.Modify;
                    until ReservationEntry.Next = 0;
            end;
        }

        field(60002; "Item Entry No."; Integer)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; Description1; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key5; "Source ID")
        {

        }
        key(Key6; "Source Type")
        {

        }
        key(Key7; "Item No.", "Lot No.", "Serial No.")
        {

        }
        key(Key8; "Source ID", "Item No.")
        {

        }
    }

    trigger OnInsert()
    begin
        Message('Inserting');
    end;
}

