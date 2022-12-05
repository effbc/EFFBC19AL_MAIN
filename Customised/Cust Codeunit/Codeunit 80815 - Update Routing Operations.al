codeunit 80815 "Update Routing Operations"
{

    trigger OnRun();
    begin
        RoutingOpeLength.RESET;
        //RoutingOpeLength.SETFILTER("Routing No.",'%1|%2','DBPRO00001','DBSMPS0001');
        RoutingOpeLength.SETRANGE("Version Code", '');
        RoutingOpeLength.SETRANGE(Diff, TRUE);
        IF RoutingOpeLength.FINDSET THEN
            REPEAT
                RoutingLine.RESET;
                RoutingLine.SETRANGE("Routing No.", RoutingOpeLength."Routing No.");
                RoutingLine.SETRANGE("Version Code", RoutingOpeLength."Version Code");
                IF RoutingLine.FINDSET THEN
                    REPEAT
                        TempRoutingLine.INIT;
                        TempRoutingLine.TRANSFERFIELDS(RoutingLine);
                        TempRoutingLine.INSERT;
                    UNTIL RoutingLine.NEXT = 0;
            UNTIL RoutingOpeLength.NEXT = 0;

        IF TempRoutingLine.FINDSET THEN
            REPEAT
                RoutingOpeLength.RESET;
                RoutingOpeLength.SETRANGE("Routing No.", TempRoutingLine."Routing No.");
                RoutingOpeLength.SETRANGE("Version Code", TempRoutingLine."Version Code");
                RoutingOpeLength.SETRANGE(Diff, TRUE);
                IF RoutingOpeLength.FINDFIRST THEN BEGIN
                    RoutingLine.GET(TempRoutingLine."Routing No.",
                        TempRoutingLine."Version Code", TempRoutingLine."Operation No.");
                    IF STRLEN(RoutingLine."Operation No.") < RoutingOpeLength."Operation No. Max" THEN BEGIN
                        Diff := ABS(STRLEN(RoutingLine."Operation No.") - RoutingOpeLength."Operation No. Max");
                        CLEAR(OpeNo);
                        CASE Diff OF
                            1:
                                OpeNo := '0' + RoutingLine."Operation No.";
                            2:
                                OpeNo := '00' + RoutingLine."Operation No.";
                            3:
                                OpeNo := '000' + RoutingLine."Operation No.";
                        END;
                        RoutingLine.RENAME(TempRoutingLine."Routing No.", TempRoutingLine."Version Code", OpeNo);//For Rename
                    END;
                    IF RoutingLine."Previous Operation No." <> '' THEN BEGIN
                        Diff := ABS(STRLEN(RoutingLine."Previous Operation No.") - RoutingOpeLength."Operation No. Max");
                        CLEAR(OpeNo);
                        IF Diff > 0 THEN BEGIN
                            CASE Diff OF
                                1:
                                    BEGIN
                                        OpeNo := '0' + RoutingLine."Previous Operation No.";
                                        RoutingLine."Previous Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                                2:
                                    BEGIN
                                        OpeNo := '00' + RoutingLine."Previous Operation No.";
                                        RoutingLine."Previous Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                                3:
                                    BEGIN
                                        OpeNo := '000' + RoutingLine."Previous Operation No.";
                                        RoutingLine."Previous Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                            END;
                        END;
                    END;
                    IF RoutingLine."Next Operation No." <> '' THEN BEGIN
                        Diff := ABS(STRLEN(RoutingLine."Next Operation No.") - RoutingOpeLength."Operation No. Max");
                        CLEAR(OpeNo);
                        IF Diff > 0 THEN BEGIN
                            CASE Diff OF
                                1:
                                    BEGIN
                                        OpeNo := '0' + RoutingLine."Next Operation No.";
                                        RoutingLine."Next Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                                2:
                                    BEGIN
                                        OpeNo := '00' + RoutingLine."Next Operation No.";
                                        RoutingLine."Next Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                                3:
                                    BEGIN
                                        OpeNo := '000' + RoutingLine."Next Operation No.";
                                        RoutingLine."Next Operation No." := OpeNo;
                                        RoutingLine.MODIFY;
                                    END;
                            END;
                        END;
                    END;
                END;
            UNTIL TempRoutingLine.NEXT = 0;
        MESSAGE('Finished');
    end;

    var
        TempRoutingLine: Record "Routing Line" temporary;
        RoutingOpeLength: Record "Routing Line operation Length";
        RoutingLine: Record "Routing Line";
        Diff: Integer;
        OpeNo: Code[10];
        I: Integer;
}

