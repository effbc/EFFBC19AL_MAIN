tableextension 70123 RoutingHeaderExt extends "Routing Header"
{
    fields
    {

        modify(Status)
        {
            trigger OnAfterValidate()
            begin
                RoutingLine.SetRange("Routing No.", "No.");
                if RoutingLine.Find('-') then begin
                    "Bench Mark Time(In Hours)" := 0;
                    repeat
                        "Bench Mark Time(In Hours)" := "Bench Mark Time(In Hours)" + Round((RoutingLine."Run Time" / 60), 0.01);
                    until RoutingLine.Next = 0;
                end;

                //Cost1.0 b2b
                CalcFields("Man Cost");
                RoutingLine.Reset;
                RoutingLine.SetRange("Routing No.", "No.");
                TotMin := 0;
                if RoutingLine.Find('-') then
                    repeat
                        TotMin += RoutingLine."Run Time";
                    until RoutingLine.Next = 0;
                TotHours := TotMin / 60;
                //"Tot Man Cost/Hour":="Man Cost"*TotHours;
                "Tot Man Cost/Hour" := ("Man Cost" / 60) * TotHours;
                //Cost1.0 b2b

                Modify(true);
                Commit;
            end;
        }
        field(60001; "Bench Mark Time(In Hours)"; Decimal)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60002; "Man Cost"; Decimal)
        {
            CalcFormula = Sum("Routing Line"."Man Cost" WHERE("Routing No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60003; "Tot Man Cost/Hour"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90080; "User Id"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90081; "Modifef User ID"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    var
        RoutingLine: Record "Routing Line";
        TotMin: Decimal;
        TotHours: Decimal;
        CheckRouting: Codeunit "Check Routing Lines";
        Text001: Label 'ENU=All versions attached to the routing will be closed. Close routing?;ENN=All versions attached to the routing will be closed. Close routing?';
        RtngVersion: Record "Routing Version";

    PROCEDURE statusValidate(Status: Enum "Routing Status");
    BEGIN

        if (Status = Status::Certified) then begin
            CheckRouting.Calculate(Rec, '');

        end;

        if Status = Status::Closed then begin
            if Confirm(
                 Text001, false)
            then begin
                RtngVersion.SetRange("Routing No.", "No.");
                RtngVersion.ModifyAll(Status, RtngVersion.Status::Closed);
            end else
                Status := xRec.Status;
        end;
        //ERROR(''+FORMAT("No."));
        RoutingLine.SetRange("Routing No.", "No.");
        if RoutingLine.Find('-') then begin
            "Bench Mark Time(In Hours)" := 0;
            repeat
                "Bench Mark Time(In Hours)" := "Bench Mark Time(In Hours)" + Round((RoutingLine."Run Time" / 60), 0.01);
            until RoutingLine.Next = 0;
        end;

        //Cost1.0 b2b
        CalcFields("Man Cost");
        RoutingLine.Reset;
        RoutingLine.SetRange("Routing No.", "No.");
        TotMin := 0;
        if RoutingLine.Find('-') then
            repeat
                TotMin += RoutingLine."Run Time";
            until RoutingLine.Next = 0;
        TotHours := TotMin / 60;
        //"Tot Man Cost/Hour":="Man Cost"*TotHours;
        "Tot Man Cost/Hour" := ("Man Cost" / 60) * TotHours;
        //Cost1.0 b2b

        Modify(true);
        Commit;
    END;
}

