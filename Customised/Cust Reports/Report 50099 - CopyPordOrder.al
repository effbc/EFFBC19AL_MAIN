report 50099 "Copy Pord. Order"
{
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        InsertJournals('TRANSFER', BatchName);
    end;

    var
        "Location Code": Code[20];
        "New Location Code": Code[20];
        "Prod. Order No.": Code[20];
        "Prod. Order Line No.": Integer;
        "Prod. Order Line": Record "Prod. Order Line";
        ItemJournalLine: Record "Item Journal Line";
        ProdOrderLineComp: Record "Prod. Order Component";
        Item: Record Item;
        NoSeriesMgt: Codeunit 396;
        ItemJnlBatch: Record "Item Journal Batch";
        "DocNo.": Code[20];
        TemplateName: Code[20];
        BatchName: Code[20];


    procedure InsertJournals(TemplateName: Code[20]; BatchName: Code[20])
    begin
        ItemJnlBatch.GET(TemplateName, BatchName);
        "DocNo." := NoSeriesMgt.TryGetNextNo(ItemJnlBatch."No. Series", WORKDATE);
        ProdOrderLineComp.RESET;
        ProdOrderLineComp.SETRANGE(Status, ProdOrderLineComp.Status::Released);
        ProdOrderLineComp.SETRANGE("Prod. Order No.", "Prod. Order No.");
        ProdOrderLineComp.SETRANGE("Prod. Order Line No.", "Prod. Order Line No.");
        ProdOrderLineComp.SETFILTER("Remaining Quantity", '<>0');
        IF ProdOrderLineComp.FIND('-') THEN
            REPEAT
                IF Item.GET(ProdOrderLineComp."Item No.") THEN;
                ItemJournalLine.INIT;
                ItemJournalLine."Journal Template Name" := TemplateName;
                ItemJournalLine."Journal Batch Name" := BatchName;
                ItemJournalLine."Line No." := ItemJournalLine."Line No." + 10000;
                ItemJournalLine."Item No." := ProdOrderLineComp."Item No.";
                ItemJournalLine."Document No." := "DocNo.";
                ItemJournalLine."Posting Date" := WORKDATE;
                ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Transfer;
                ItemJournalLine."Location Code" := "Location Code";
                ItemJournalLine.Quantity := ProdOrderLineComp."Remaining Quantity";
                ItemJournalLine."Source Code" := 'RECLASSJNL';
                ItemJournalLine."New Location Code" := "New Location Code";
                ItemJournalLine."Document Date" := WORKDATE;
                ItemJournalLine."Unit of Measure Code" := ProdOrderLineComp."Unit of Measure Code";
                ItemJournalLine."ITL Doc No." := "Prod. Order No.";
                ItemJournalLine."ITL Doc Line No." := "Prod. Order Line No.";
                ItemJournalLine."ITL Doc Ref Line No." := ProdOrderLineComp."Line No.";
                ItemJournalLine.VALIDATE("Item No.");
                ItemJournalLine.VALIDATE("Location Code");
                ItemJournalLine.VALIDATE(Quantity);
                ItemJournalLine.VALIDATE("New Location Code");
                ItemJournalLine.INSERT;
            UNTIL ProdOrderLineComp.NEXT = 0;
    end;
}

