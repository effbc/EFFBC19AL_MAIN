report 50009 TestSalUpd
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    trigger OnpostReport()
    var
        myInt: Integer;
    begin
        /*
        SalesHeader.Reset;
        SalesHeader.setrange(SaleDocType, SalesHeader.SaleDoctype::Amc);
        if SalesHeader.findset then begin
            repeat
                SalesHeaderUpd.Reset;
                SalesHeaderUpd.Setrange("No.", SalesHeader."No.");
                if SalesHeaderUpd.findfirst then begin
                    SalesHeaderUpd.Rename(SalesHeaderUpd."Document Type"::Order, SalesHeaderUpd."No.");
                end;

            until SalesHeader.next = 0;
        end;
        */

        /*
        SalesHeader.Reset;
        SalesHeader.setrange(SaleDocType, SalesHeader.SaleDoctype::Amc);
        if SalesHeader.findset then begin
            repeat
                SalesLine.Reset;
                SalesLine.Setrange("Document No.", SalesHeader."No.");
                if SalesLine.findfirst then begin
                    repeat
                        SalesLineUpd.Reset;
                        SalesLineupd.Setrange("Document No.", SalesHeader."No.");
                        SalesLineupd.Setrange("Line No.", SalesLine."Line No.");
                        if SalesLineUpd.findfirst then begin
                            SalesLineUpd.Rename(SalesLineUpd."Document Type"::Order, SalesLineUpd."Document No.", SalesLineUpd."Line No.");
                        end;

                    until SalesLine.next = 0;
                end;

            until SalesHeader.next = 0;
        end;
*/

        Message('Done');
    end;



    var
        myInt: Integer;
        SalesHeader: REcord "Sales header";
        SalesHeaderUpd: REcord "Sales header";
        SalesLine: Record "Sales Line";
        SalesLineUpd: Record "Sales Line";

}
