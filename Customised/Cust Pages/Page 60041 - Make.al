page 60041 Make
{
    // version B2B1.0

    Editable = true;
    PageType = List;
    SourceTable = Make;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Entry Date Time"; Rec."Entry Date Time")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Vendors Link"; Rec."Vendors Link")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        IF UPPERCASE(USERID) IN ['EFFTRONICS\BRAHMAIAH', 'EFFTRONICS\PARDHU', 'EFFTRONICS\ANILKUMAR', 'EFFTRONICS\RENUKACH', 'EFFTRONICS\CHOWDARY',
                             'EFFTRONICS\SUPRIYA', 'EFFTRONICS\AVINASH', 'EFFTRONICS\KAMESWARI', 'EFFTRONICS\SUVARCHALADEVI', 'EFFTRONICS\TPRIYANKA', 'EFFTRONICS\DURGAMAHESWARI'] THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}

