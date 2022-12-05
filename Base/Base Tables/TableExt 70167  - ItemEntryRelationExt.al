tableextension 70167 ItemEntryRelationExt extends "Item Entry Relation"
{

    fields
    {

    }

    PROCEDURE "--B2B--"();
    BEGIN
    END;


    PROCEDURE "TransferFieldsMat.IssueLine"(VAR PostedMaterialIssueLine: Record "Posted Material Issues Line");
    BEGIN
        "Source Type" := DATABASE::"Posted Material Issues Line";
        "Source Subtype" := 0;
        "Source ID" := PostedMaterialIssueLine."Document No.";
        "Source Batch Name" := '';
        "Source Prod. Order Line" := 0;
        "Source Ref. No." := PostedMaterialIssueLine."Line No.";
        "Order No." := PostedMaterialIssueLine."Material Issue No.";
        "Order Line No." := PostedMaterialIssueLine."Material Issue Line No.";
    END;


    PROCEDURE "--B2BSP--"();
    BEGIN
    END;


    PROCEDURE TransferFieldsPostedMTLine(VAR ScheduleComp: Record Schedule2);
    BEGIN
        "Source Type" := DATABASE::Schedule2;
        "Source Subtype" := 0;
        "Source ID" := ScheduleComp."Document No.";
        "Source Batch Name" := '';
        "Source Prod. Order Line" := ScheduleComp."Document Line No.";
        "Source Ref. No." := ScheduleComp."Line No.";

        "Order No." := ScheduleComp."Document No.";
        "Order Line No." := ScheduleComp."Document Line No.";
    END;



}

