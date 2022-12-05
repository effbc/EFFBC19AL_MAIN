codeunit 60003 "Specification-Copy"
{
    // version QC1.1

    TableNo = "Production BOM Header";

    trigger OnRun();
    begin
    end;

    var
        Text000: Label 'The %1 cannot be copied to itself.';
        Text001: Label '%1 on %2 %3 must not be %4';
        Text002: Label '%1 on %2 %3 %4 must not be %5';


    procedure CopySpec(SpecHeaderNo: Code[20]; FromVersionCode: Code[10]; CurrentSpecHeader: Record "Specification Header"; ToVersionCode: Code[10]);
    var
        FromSpecLine: Record "Specification Line";
        ToSpecLine: Record "Specification Line";
        SpecVersion: Record "Specification Version";
    begin
        IF (CurrentSpecHeader."Spec ID" = SpecHeaderNo) AND
          (FromVersionCode = ToVersionCode)
        THEN
            ERROR(Text000, CurrentSpecHeader.TABLECAPTION);

        IF ToVersionCode = '' THEN BEGIN
            IF CurrentSpecHeader.Status = CurrentSpecHeader.Status::Certified THEN
                ERROR(
                  Text001,
                  CurrentSpecHeader.FIELDCAPTION(Status),
                  CurrentSpecHeader.TABLECAPTION,
                  CurrentSpecHeader."Spec ID",
                  CurrentSpecHeader.Status);
        END ELSE BEGIN
            SpecVersion.GET(
              CurrentSpecHeader."Spec ID", ToVersionCode);
            IF SpecVersion.Status = SpecVersion.Status::Certified THEN
                ERROR(
                  Text002,
                  SpecVersion.FIELDCAPTION(Status),
                  SpecVersion.TABLECAPTION,
                  SpecVersion."Specification No.",
                  SpecVersion."Version Code",
                  SpecVersion.Status);
        END;

        ToSpecLine.SETRANGE("Spec ID", CurrentSpecHeader."Spec ID");
        ToSpecLine.SETRANGE("Version Code", ToVersionCode);
        ToSpecLine.DELETEALL;

        FromSpecLine.SETRANGE("Spec ID", SpecHeaderNo);
        FromSpecLine.SETRANGE("Version Code", FromVersionCode);

        IF FromSpecLine.FINDSET THEN
            REPEAT
                ToSpecLine := FromSpecLine;
                ToSpecLine."Spec ID" := CurrentSpecHeader."Spec ID";
                ToSpecLine."Version Code" := ToVersionCode;
                ToSpecLine.INSERT;
            UNTIL FromSpecLine.NEXT = 0;
    end;


    procedure CopyFromVersion(var SpecVersionList2: Record "Specification Version");
    var
        SpecHeader: Record "Specification Header";
        OldSpecVersionList: Record "Specification Version";
    begin
        OldSpecVersionList := SpecVersionList2;

        SpecHeader."Spec ID" := SpecVersionList2."Specification No.";
        IF PAGE.RUNMODAL(0, SpecVersionList2) = ACTION::LookupOK THEN BEGIN
            IF OldSpecVersionList.Status = OldSpecVersionList.Status::Certified THEN
                ERROR(
                  Text002,
                  OldSpecVersionList.FIELDCAPTION(Status),
                  OldSpecVersionList.TABLECAPTION,
                  OldSpecVersionList."Specification No.",
                  OldSpecVersionList."Version Code",
                  OldSpecVersionList.Status);
            CopySpec(SpecHeader."Spec ID", SpecVersionList2."Version Code", SpecHeader, OldSpecVersionList."Version Code");
        END;

        SpecVersionList2 := OldSpecVersionList;
    end;
}

