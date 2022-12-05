tableextension 70040 JobJournalLineExt extends "Job Journal Line"
{
    fields
    {
        field(60001; "End Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60002; "Start Date"; Date)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; Description1; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(60004; "Transport Method1"; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }
}

