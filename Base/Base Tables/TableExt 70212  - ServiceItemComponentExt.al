tableextension 70212 ServiceItemComponentExt extends "Service Item Component"
{
    fields
    {
        field(50000; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
    }
    PROCEDURE "--B2B--"();
    BEGIN
    END;


    PROCEDURE Attachments();
    VAR
        Attachments: Record Attachments;
    BEGIN
        Attachments.Reset;
        Attachments.SetRange("Table ID", DATABASE::"Service Item");
        Attachments.SetRange("Document No.", "No.");
        //Attachments.SETRANGE("Document Type","Document Type");

        PAGE.Run(PAGE::"ESPL Attachments", Attachments);
    END;
}

