pageextension 70109 PaymentTermsExt extends "Payment Terms"
{
    layout
    {
        addafter(Code)
        {
            field("Stage 1"; Rec."Stage 1")
            {
                ApplicationArea = All;
            }
            field("Percentage 1"; Rec."Percentage 1")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    Rec."Percentage 2" := 0;
                    Rec."Percentage 3" := 0;
                    Rec."Percentage 2" := 100 - Rec."Percentage 1";         //old
                    Rec."Percentage 3" := 100 - (Rec."Percentage 1" + Rec."Percentage 2");
                    IF Rec."Percentage 1" + Rec."Percentage 2" + Rec."Percentage 3" > 100 THEN BEGIN
                        Rec."Percentage 2" := xRec."Percentage 2";
                        Rec."Percentage 3" := xRec."Percentage 3";
                        ERROR('Total Sum of Percentage 1,Percentage 2,Percentage 3 should not be greater than 100!');
                    END;
                end;
            }
            field("Stage 2"; Rec."Stage 2")
            {
                ApplicationArea = All;
            }
            field("Percentage 2"; Rec."Percentage 2")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //"Percentage 1":=100-"Percentage 2"; //commented by Pranavi
                    //Added By Pranavi
                    Rec."Percentage 3" := 0;
                    IF Rec."Percentage 1" + Rec."Percentage 2" + Rec."Percentage 3" > 100 THEN BEGIN
                        Rec."Percentage 3" := xRec."Percentage 3";
                        ERROR('Total Sum of Percentage 1,Percentage 2,Percentage 3 should not be greater than 100!');
                    END;
                    Rec."Percentage 3" := 100 - (Rec."Percentage 1" + Rec."Percentage 2");
                    //End By Pranavi
                end;
            }
            field("Stage 3"; Rec."Stage 3")
            {
                ApplicationArea = All;
            }
            field("Percentage 3"; Rec."Percentage 3")
            {
                ApplicationArea = All;

                trigger OnValidate();
                begin
                    //Added By Pranavi
                    IF Rec."Percentage 1" + Rec."Percentage 2" + Rec."Percentage 3" > 100 THEN
                        ERROR('Total Sum of Percentage 1,Percentage 2,Percentage 3 should not be greater than 100!');
                    Rec."Percentage 2" := 100 - (Rec."Percentage 1" + Rec."Percentage 3");
                    //End By Pranavi
                end;
            }
        }
        addafter(Description)
        {
            field("Update In Cashflow"; Rec."Update In Cashflow")
            {
                ApplicationArea = All;
            }
            field(Sales; Rec.Sales)
            {
                ApplicationArea = All;
            }
            field(Purchase; Rec.Purchase)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {

        modify("T&ranslation")
        {
            Promoted = true;
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        //Added By Pranavi

        IF (Rec."Percentage 1" <> 0) AND (FORMAT(Rec."Stage 1") = ' ') THEN
            ERROR('Enter Stage1!');
        IF (Rec."Percentage 2" <> 0) AND (FORMAT(Rec."Stage 2") = ' ') THEN
            ERROR('Enter Stage2!');
        IF (Rec."Percentage 3" <> 0) AND (FORMAT(Rec."Stage 3") = ' ') THEN
            ERROR('Enter Stage3!');
        IF (Rec."Percentage 1" = 0) AND (FORMAT(Rec."Stage 1") <> ' ') THEN
            ERROR('Enter Percentage1!');
        IF (Rec."Percentage 2" = 0) AND (FORMAT(Rec."Stage 2") <> ' ') THEN
            ERROR('Enter Percentage2!');
        IF (Rec."Percentage 3" = 0) AND (FORMAT(Rec."Stage 3") <> ' ') THEN
            ERROR('Enter Percentage3!');

        IF (Rec."Stage 1" = Rec."Stage 1"::Credit) OR (Rec."Stage 2" = Rec."Stage 2"::Credit) OR (Rec."Stage 3" = Rec."Stage 3"::Credit) THEN BEGIN
            IF FORMAT(Rec."Due Date Calculation") = '' THEN
                ERROR('PLEASE ENTER THE CREDIT PERIOD');
        END;

        //End By Pranavi
    end;

    var
        "Purchase Header": Record "Purchase Header";
        purchpag: Page "Purchase Invoice";





}

