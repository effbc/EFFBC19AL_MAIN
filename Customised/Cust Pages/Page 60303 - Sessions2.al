page 60303 Sessions2
{
    // version SESSIONW13.10.01

    Editable = false;
    PageType = List;
    SourceTable = "Session Information";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("My Session"; Rec."My Session")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Connection ID"; Rec."Connection ID")
                {
                    ApplicationArea = All;
                }
                field("Records Scanned"; Rec."Records Scanned")
                {
                    ApplicationArea = All;
                }
                field("""Found/Scanned Ratio %"" * 100"; Rec."Found/Scanned Ratio %" * 100)
                {
                    Caption = 'Found/Scanned Ratio %';
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
                field("Disk Reads"; Rec."Disk Reads")
                {
                    ApplicationArea = All;
                }
                field("Disk Writes"; Rec."Disk Writes")
                {
                    ApplicationArea = All;
                }
                field(username; Rec.username)
                {
                    ApplicationArea = All;
                }
                field("""Cache Hit Ratio %"" * 100"; Rec."Cache Hit Ratio %" * 100)
                {
                    Caption = 'Cache Hit Ratio %';
                    ExtendedDatatype = Ratio;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }


    procedure RefreshSessions();
    begin
        CurrPage.UPDATE(FALSE);
    end;
}

