page 60264 "Inwards Planning Form"
{
    // created by vishnu Priya on 20-06-2020 for the inwards planning
    // Inputs are given by the Inwards supervisor.

    CardPageID = "Inspection Data Sheet";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Inspection Datasheet Header";
    SourceTableView = SORTING("No.") ORDER(Ascending) WHERE("Source Type" = CONST("In Bound"));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Data Entered By"; Rec."Data Entered By")
                {
                    Caption = 'Work Started By';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Lot No."; Rec."Lot No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Estimated Time"; Rec."Estimated Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Assigned User"; Rec."Assigned User")
                {
                    Caption = 'Plan to Employee';
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
                field("Planning Date"; Rec."Planning Date")
                {
                    Caption = 'Plan on:';
                    Editable = Page_Edit;
                    ApplicationArea = All;
                }
            }
            field("xRec.COUNT"; xRec.COUNT)
            {
                Caption = 'Total Inwards';
                Editable = false;
                Style = StrongAccent;
                StyleExpr = TRUE;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        //Written AND commented by Vishnu Priya on 24-06-2020
        Rec.CALCFIELDS("Revised Sampling Count", "Revised Sampling Percentage", "Revised Sampling Time Mins", "Visual Sampling Count", "Visual Sampling Percentage", "Visual Sampling Time Mins", "Dimensions Sampling Count", "Dimensions Sampling Percentage");
        Rec.CALCFIELDS("Dimensions Sampling Time Mins", "Basic Func Sampling Time -Mins", "Basic Functional Sampling Cnt", "Basic Functional Sampling Per");
        Rec.CALCFIELDS("Sample Cnt", "Sample Percent", Benchmark, "Documentation Time");
        Estimated_time := 0;

        //Rec.SETFILTER("Item Description",'887 VER1.1 PCB');
        IF (Rec."Revised Sampling Count" > 0) AND (Rec."Revised Sampling Percentage" = 0) THEN
            Estimated_time := Rec."Revised Sampling Time Mins" * Rec."Revised Sampling Count"
        ELSE
            IF (Rec."Revised Sampling Percentage" > 0) AND (Rec."Revised Sampling Count" = 0) THEN
                Estimated_time := (Rec."Revised Sampling Time Mins") * (ROUND(Rec."Revised Sampling Percentage" * 0.01 * Rec.Quantity));

        IF (Rec."Visual Sampling Count" > 0) AND (Rec."Visual Sampling Percentage" = 0) THEN
            Estimated_time := Estimated_time + (Rec."Visual Sampling Time Mins" * Rec."Visual Sampling Count")
        ELSE
            IF (Rec."Visual Sampling Count" = 0) AND (Rec."Visual Sampling Percentage" > 0) THEN
                Estimated_time := Estimated_time + (ROUND(Rec."Visual Sampling Percentage" * 0.01 * Rec.Quantity) * Rec."Visual Sampling Time Mins");

        IF (Rec."Dimensions Sampling Count" > 0) AND (Rec."Dimensions Sampling Percentage" = 0) THEN
            Estimated_time := Estimated_time + (Rec."Dimensions Sampling Time Mins" * Rec."Dimensions Sampling Count")
        ELSE
            IF (Rec."Dimensions Sampling Count" = 0) AND (Rec."Dimensions Sampling Percentage" > 0) THEN
                Estimated_time := Estimated_time + (ROUND(Rec."Dimensions Sampling Percentage" * 0.01 * Rec.Quantity) * (Rec."Dimensions Sampling Time Mins"));

        IF (Rec."Basic Functional Sampling Cnt" > 0) AND (Rec."Basic Functional Sampling Per" = 0) THEN
            Estimated_time := Estimated_time + (Rec."Basic Func Sampling Time -Mins" * Rec."Basic Functional Sampling Cnt")
        ELSE
            IF (Rec."Basic Functional Sampling Cnt" = 0) AND (Rec."Basic Functional Sampling Per" > 0) THEN
                Estimated_time := Estimated_time + (ROUND(Rec."Basic Functional Sampling Per" * 0.01 * Rec.Quantity) * (Rec."Basic Func Sampling Time -Mins"));

        IF (Rec."Sample Cnt" > 0) AND (Rec."Sample Percent" = 0) THEN
            Estimated_time := Estimated_time + (Rec.Benchmark * Rec."Sample Cnt")
        ELSE
            IF (Rec."Sample Cnt" = 0) AND (Rec."Sample Percent" > 0) THEN
                Estimated_time := Estimated_time + (ROUND(Rec."Sample Percent" * 0.01 * Rec.Quantity) * Rec.Benchmark);


        Rec."Estimated Time" := Estimated_time + Rec."Documentation Time";
        // Priorities Setting
        // Priority 1 starts
        MIL.RESET;
        MIL.SETFILTER("Transfer-from Code", '%1|%2', 'STR', 'MCH');
        MIL.SETRANGE("Transfer-to Code", 'PROD');
        MIL.SETRANGE("Item No.", Rec."Item No.");
        MIL.SETFILTER("Outstanding Quantity", '>%1', 0);
        IF MIL.FINDFIRST THEN
            Rec.Priority := 'Shortage'
        ELSE BEGIN
            POC.RESET;
            POC.SETCURRENTKEY("Item No.");
            POC.SETFILTER("Production Plan Date", '>=%1 & <=%2', TODAY, TODAY + 1);
            POC.SETFILTER("Item No.", Rec."Item No.");
            IF POC.FINDFIRST THEN
                Rec.Priority := 'Today and Tomorrow plan'
            ELSE BEGIN
                IDH.RESET;
                IDH.SETCURRENTKEY("Created Date", "Item No.", "Source Type");
                IDH.SETFILTER("Source Type", FORMAT(0));
                IDH.SETFILTER("Created Date", '<=%1', TODAY - 10);
                IDH.SETFILTER("Item No.", Rec."Item No.");
                IF IDH.FINDFIRST THEN
                    Rec.Priority := 'More than 10 Days'
                ELSE BEGIN
                    IDH.RESET;
                    IDH.SETCURRENTKEY("Created Date", "Item No.", "Source Type");
                    IDH.SETFILTER("Source Type", FORMAT(0));
                    IDH.SETFILTER("Created Date", '>%1', TODAY - 10);
                    IDH.SETFILTER("Item No.", Rec."Item No.");
                    IF IDH.FINDFIRST THEN
                        Rec.Priority := 'less than 10 Days'
                    ELSE
                        Rec.Priority := 'Others';
                END;
            END;
        END;

        Rec.MODIFY;


    end;

    trigger OnOpenPage();
    begin
        // Restricting the users for modifications
        IF SMTP_MAIL.Permission_Checking(USERID, 'INWARDS-PLANNING') THEN
            Page_Edit := TRUE
        ELSE
            Page_Edit := FALSE;
    end;

    var
        Itemmaster: Record Item;
        samplecnt: Integer;
        sample_percent: Decimal;
        Estimated_time: Decimal;
        MIL: Record "Material Issues Line";
        POC: Record "Prod. Order Component";
        Todate: Date;
        MIH: Record "Material Issues Header";
        MIL1: Record "Material Issues Line";
        IDH: Record "Inspection Datasheet Header";
        Page_Edit: Boolean;
        SMTP_MAIL: Codeunit "Custom Events";
}

