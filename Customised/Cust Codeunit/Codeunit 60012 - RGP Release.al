codeunit 60012 "RGP Release"
{
    // version B2B1.0,Cal1.0


    trigger OnRun();
    begin
    end;

    var
        Text001: Label 'Do You Want to Release?';
        Text002: Label 'Do You Want to Reopen?';
        RGPOutHeaderRelease: Record "RGP Out Header";
        RGPInHeaderRelease: Record "RGP In Header";


    procedure RGPOutRelease(Rec: Record "RGP Out Header");
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;

        RGPOutHeaderRelease.SETRANGE("RGP Out No.", Rec."RGP Out No.");
        IF RGPOutHeaderRelease.FINDFIRST THEN
            RGPOutHeaderRelease.TESTFIELD("Release Status", Rec."Release Status"::Open);

        Rec.LOCKTABLE;
        RGPOutHeaderRelease.SETRANGE("RGP Out No.", Rec."RGP Out No.");
        IF RGPOutHeaderRelease.FINDFIRST THEN
            RGPOutHeaderRelease."Release Status" := RGPOutHeaderRelease."Release Status"::Release;
        RGPOutHeaderRelease."Released By" := USERID;
        RGPOutHeaderRelease.MODIFY;
    end;


    procedure RGPOutReopen(Rec: Record "RGP Out Header");
    begin
        IF NOT CONFIRM(Text002, FALSE) THEN
            EXIT;

        RGPOutHeaderRelease.SETRANGE("RGP Out No.", Rec."RGP Out No.");
        IF RGPOutHeaderRelease.FINDFIRST THEN
            RGPOutHeaderRelease.TESTFIELD("Release Status", Rec."Release Status"::Release);


        RGPOutHeaderRelease.SETRANGE("RGP Out No.", Rec."RGP Out No.");
        IF RGPOutHeaderRelease.FINDFIRST THEN
            RGPOutHeaderRelease."Release Status" := RGPOutHeaderRelease."Release Status"::Open;
        RGPOutHeaderRelease.MODIFY;
    end;


    procedure RGPInRelease(Rec: Record "RGP In Header");
    begin
        IF NOT CONFIRM(Text001, FALSE) THEN
            EXIT;

        RGPInHeaderRelease.SETRANGE("RGP In No.", Rec."RGP In No.");
        IF RGPInHeaderRelease.FINDFIRST THEN
            RGPInHeaderRelease.TESTFIELD("Release Status", Rec."Release Status"::Open);

        Rec.LOCKTABLE;
        RGPInHeaderRelease.SETRANGE("RGP In No.", Rec."RGP In No.");
        IF RGPInHeaderRelease.FINDFIRST THEN
            RGPInHeaderRelease."Release Status" := RGPInHeaderRelease."Release Status"::Release;
        RGPInHeaderRelease."Released By" := USERID;
        RGPInHeaderRelease.MODIFY;
    end;


    procedure RGPInReopen(Rec: Record "RGP In Header");
    begin
        IF NOT CONFIRM(Text002, FALSE) THEN
            EXIT;

        RGPInHeaderRelease.SETRANGE("RGP In No.", Rec."RGP In No.");
        IF RGPInHeaderRelease.FINDFIRST THEN
            RGPInHeaderRelease.TESTFIELD("Release Status", Rec."Release Status"::Release);


        RGPInHeaderRelease.SETRANGE("RGP In No.", Rec."RGP In No.");
        IF RGPInHeaderRelease.FINDFIRST THEN
            RGPInHeaderRelease."Release Status" := RGPInHeaderRelease."Release Status"::Open;
        RGPInHeaderRelease.MODIFY;
    end;
}

