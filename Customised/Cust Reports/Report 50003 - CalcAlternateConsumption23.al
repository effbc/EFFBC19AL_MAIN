report 50003 "Calc Alternate Consumption23"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Posted Material Issues Line"; "Posted Material Issues Line")
        {
            DataItemTableView = SORTING("Prod. Order No.", "Prod. Order Line No.", "Item No.") WHERE("Prod. Order Comp. Line No." = CONST(0));
            RequestFilterFields = "Prod. Order No.", "Prod. Order Line No.";

            trigger OnPreDataItem()
            begin
                IF "Posted Material Issues Line".GETFILTER("Prod. Order No.") <> '' THEN BEGIN
                    "ProdOrderNo." := "Posted Material Issues Line".GETFILTER("Prod. Order No.");
                    EVALUATE("ProdOrderLineNo.", "Posted Material Issues Line".GETFILTER("Prod. Order Line No."));
                END;
                PostedMatIssuesLine.RESET;
                PostedMatIssuesLine.SETCURRENTKEY("Prod. Order No.", "Prod. Order Line No.", "Prod. Order Comp. Line No.");
                PostedMatIssuesLine.SETRANGE("Prod. Order No.", "ProdOrderNo.");
                PostedMatIssuesLine.SETRANGE("Prod. Order Line No.", "ProdOrderLineNo.");
                PostedMatIssuesLine.SETFILTER(PostedMatIssuesLine."Prod. Order Comp. Line No.", '%1', 0);
                IF PostedMatIssuesLine.FIND('-') THEN BEGIN
                    REPEAT
                        ItemJournalLine.INIT;
                        /*
                          ItemJournalLine."Journal Template Name" := 'Consumptio';
                          ItemJournalLine."Journal Batch Name" := 'Default';
                        */
                        ItemJournalLine."Journal Template Name" := TemplateName;
                        ItemJournalLine."Journal Batch Name" := BatchName;

                        ItemJournalLine."Posting Date" := TODAY;
                        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::Consumption;

                        ItemJournalLine.SETRANGE("Journal Template Name", 'Consumptio');
                        ItemJournalLine.SETRANGE("Journal Batch Name", 'DEFAULT');
                        IF ItemJournalLine.FIND('+') THEN
                            NextConsumpJnlLineNo := ItemJournalLine."Line No.";

                        IF NextConsumpJnlLineNo <> 0 THEN
                            ItemJournalLine."Line No." := NextConsumpJnlLineNo + 10000
                        ELSE
                            ItemJournalLine."Line No." := ItemJournalLine."Line No." + 10000;
                        ItemJournalLine.VALIDATE("Order No.", PostedMatIssuesLine."Prod. Order No.");
                        ItemJournalLine.VALIDATE("Order Line No.", PostedMatIssuesLine."Prod. Order Line No.");
                        ItemJournalLine.VALIDATE("Item No.", PostedMatIssuesLine."Item No.");
                        //ItemJournalLine."Item No." := PostedMatIssuesLine."Item No.";
                        ItemJournalLine.VALIDATE(Quantity, PostedMatIssuesLine.Quantity);
                        ItemJournalLine.Quantity := PostedMatIssuesLine.Quantity;
                        ItemJournalLine."Location Code" := PostedMatIssuesLine."Transfer-to Code";
                        ItemJournalLine."Document No." := DocumentNo;
                        NextConsumpJnlLineNo := 0;
                        ItemJournalLine.INSERT(TRUE);

                    UNTIL PostedMatIssuesLine.NEXT = 0;
                END;
                CurrReport.BREAK;

            end;
        }
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

    var
        "ProdOrderNo.": Code[20];
        PostedMatIssuesHeader: Record "Posted Material Issues Header";
        PostedMatIssuesLine: Record "Posted Material Issues Line";
        "ProdOrderLineNo.": Integer;
        ItemJournalLine: Record "Item Journal Line";
        NextConsumpJnlLineNo: Integer;
        Consumptio: Text[30];
        Default: Text[30];
        TemplateName: Code[20];
        BatchName: Code[20];
        DocumentNo: Code[20];


    procedure SetTemplateAndBatchName(ProdOrderNum: Code[20]; ProdOrderLineNum: Integer; TemplateNameVar: Code[20]; BatchNameVar: Code[20]; DocumentNoVar: Code[20])
    begin
        "ProdOrderNo." := ProdOrderNum;
        "ProdOrderLineNo." := ProdOrderLineNum;
        TemplateName := TemplateNameVar;
        BatchName := BatchNameVar;
        DocumentNo := DocumentNoVar;
    end;
}

