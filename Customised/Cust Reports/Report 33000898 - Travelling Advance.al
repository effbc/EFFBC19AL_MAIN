report 33000898 "Travelling Advance"
{
    // version Rev01,Eff02

    DefaultLayout = RDLC;
    RDLCLayout = './Travelling Advance.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem("Analysis View Entry"; "Analysis View Entry")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending)
                                WHERE("Analysis View Code" = FILTER('TA'),
                                      "Account No." = FILTER(24000));
            RequestFilterFields = "Dimension 2 Value Code";
            column(totadeb; totadeb)
            {
            }
            column(totacre; totacre)
            {
            }
            column(DateVar; DateVar)
            {
            }
            column(NAME; NAME)
            {
            }
            column(FORMAT_mindate_0___Day___Month_Text_3___Year4________; FORMAT(mindate, 0, '<Day>-<Month Text,3>-<Year4>') + ' :')
            {
            }
            column(Opening_Balance_; "Opening Balance")
            {
            }
            column(FORMAT_mindate_0___Day___Month_Text_3___Year4___; FORMAT(mindate, 0, '<Day>-<Month Text,3>-<Year4>'))
            {
            }
            column(appliedAmt__Analysis_View_Entry___Debit_Amount_; appliedAmt + "Analysis View Entry"."Debit Amount")
            {
            }
            column(Analysis_View_Entry__Analysis_View_Entry___Posting_Date_; "Analysis View Entry"."Posting Date")
            {
            }
            column(Analysis_View_Entry__Analysis_View_Entry___Credit_Amount_; "Analysis View Entry"."Credit Amount")
            {
            }
            column(desc; desc)
            {
            }
            column(formataddress_ChangeCurrency_totadeb_; formataddress.ChangeCurrency(totadeb))
            {
            }
            column(formataddress_ChangeCurrency_totacre_; formataddress.ChangeCurrency(totacre))
            {
            }
            column(Closing_Balance_; "Closing Balance")
            {
            }
            column(TRAVELLING_ADVANCE_DETAILSCaption; TRAVELLING_ADVANCE_DETAILSCaptionLbl)
            {
            }
            column(EMPLOYEE_NAME__Caption; EMPLOYEE_NAME__CaptionLbl)
            {
            }
            column(Opening_Balance_as_onCaption; Opening_Balance_as_onCaptionLbl)
            {
            }
            column(Transaction_DateCaption; Transaction_DateCaptionLbl)
            {
            }
            column(Amount_Taken_from_OrganizationCaption; Amount_Taken_from_OrganizationCaptionLbl)
            {
            }
            column(Bills__SubmittedCaption; Bills__SubmittedCaptionLbl)
            {
            }
            column(PurposeCaption; PurposeCaptionLbl)
            {
            }
            column(Transactions_FromCaption; Transactions_FromCaptionLbl)
            {
            }
            column(PurposeCaption_Control1102154005; PurposeCaption_Control1102154005Lbl)
            {
            }
            column(Bills__SubmittedCaption_Control1102154003; Bills__SubmittedCaption_Control1102154003Lbl)
            {
            }
            column(Amount_Taken_from_OrganizationCaption_Control1102152013; Amount_Taken_from_OrganizationCaption_Control1102152013Lbl)
            {
            }
            column(Transaction_DateCaption_Control1102154002; Transaction_DateCaption_Control1102154002Lbl)
            {
            }
            column(Closing_Balance___Caption; Closing_Balance___CaptionLbl)
            {
            }
            column(TOTALCaption; TOTALCaptionLbl)
            {
            }
            column(For_any_Queries_Please_Contact_Caption; For_any_Queries_Please_Contact_CaptionLbl)
            {
            }
            column(Note________Auto_Report_Generated_from_ERP____Caption; Note________Auto_Report_Generated_from_ERP____CaptionLbl)
            {
            }
            column(Rajani_Efftronics_comCaption; Rajani_Efftronics_comCaptionLbl)
            {
            }
            column(Analysis_View_Entry_Analysis_View_Code; "Analysis View Code")
            {
            }
            column(Analysis_View_Entry_Account_No_; "Account No.")
            {
            }
            column(Analysis_View_Entry_Account_Source; "Account Source")
            {
            }
            column(Analysis_View_Entry_Dimension_1_Value_Code; "Dimension 1 Value Code")
            {
            }
            column(Analysis_View_Entry_Dimension_2_Value_Code; "Dimension 2 Value Code")
            {
            }
            column(Analysis_View_Entry_Dimension_3_Value_Code; "Dimension 3 Value Code")
            {
            }
            column(Analysis_View_Entry_Dimension_4_Value_Code; "Dimension 4 Value Code")
            {
            }
            column(Analysis_View_Entry_Business_Unit_Code; "Business Unit Code")
            {
            }
            column(Analysis_View_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Analysis_View_Entry_Cash_Flow_Forecast_No_; "Cash Flow Forecast No.")
            {
            }
            column(Analysis_View_Entry_Amount; Amount)
            {
            }
            column(mindate; mindate)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //Rev01 Copied from
                appliedAmt := 0;
                totadeb += "Analysis View Entry"."Debit Amount";
                totacre += "Analysis View Entry"."Credit Amount";

                glentry.RESET;//Rev01
                glentry.SETRANGE(glentry."Entry No.", "Analysis View Entry"."Entry No.");
                IF glentry.FINDFIRST THEN BEGIN
                    desc := glentry.Description;
                    GL.RESET;
                    //GL.SETCURRENTKEY(GL."Entry No.");
                    GL.SETRANGE(GL."Entry No.", glentry."Apply Entry No");
                    IF GL.FINDFIRST THEN
                        appliedAmt := GL.Amount;
                END;
                totalbal1 += "Analysis View Entry"."Debit Amount" - "Analysis View Entry"."Credit Amount";

                DateVar := TRUE;

                IF "Analysis View Entry"."Posting Date" >= mindate THEN
                    DateVar := TRUE
                ELSE
                    DateVar := FALSE;

                //Rev01 Copied From
            end;

            trigger OnPostDataItem();
            begin
                IF totalbal1 < 0 THEN
                    "Closing Balance" := 'Organization Need to Pay: RS.' + formataddress.ChangeCurrency(-1 * totalbal1)
                ELSE
                    "Closing Balance" := 'Bills need to Submit by Employee: RS.' + formataddress.ChangeCurrency(totalbal1);
            end;

            trigger OnPreDataItem();
            begin
                IF DATE2DMY(TODAY, 2) < 5 THEN
                    mindate := DMY2DATE(1, 4, DATE2DMY(TODAY, 3) - 1)
                ELSE
                    mindate := DMY2DATE(1, 4, DATE2DMY(TODAY, 3));
                //mindate:=010408D;
                maxdate := TODAY;
                IF GETFILTER("Analysis View Entry"."Posting Date") = '' THEN
                    "Analysis View Entry".SETRANGE("Analysis View Entry"."Posting Date", DMY2Date(01, 04, 08), maxdate);
                /*IF (COPYSTR(user.Dept,1,2)='RD') THEN
                "Analysis View Entry".SETFILTER("Analysis View Entry"."Dimension 1 Value Code",'rd*');*/


                //Rev01 Copied From //Analysis View Entry, Header (1) - OnPreSection()
                ave.RESET;
                ave.SETFILTER(ave."Analysis View Code", 'TA');
                ave.SETFILTER(ave."Dimension 2 Value Code", "Analysis View Entry".GETFILTER("Analysis View Entry"."Dimension 2 Value Code"));
                ave.SETRANGE(ave."Posting Date", DMY2Date(01, 04, 08), mindate - 1);
                IF ave.FINDFIRST THEN
                    REPEAT
                        /*
                         totadeb+=ave."Debit Amount";
                         totacre+=ave."Credit Amount";
                        */
                        totalbal += ave.Amount;
                    UNTIL ave.NEXT = 0;

                IF totalbal < 0 THEN
                    "Opening Balance" := '  Organization Need to Pay: RS.' + formataddress.ChangeCurrency(-1 * totalbal)
                ELSE
                    "Opening Balance" := '  Bills need to Submit by Employee: RS.' + formataddress.ChangeCurrency(totalbal);
                //Rev01 Copied From //Analysis View Entry, Header (1) - OnPreSection()

            end;
        }
        dataitem(DataItem1102152008; Integer)
        {
            DataItemTableView = WHERE(Number = CONST(1));
            column(closing; closebal)
            {
            }

            trigger OnAfterGetRecord();
            begin
                MESSAGE(FORMAT(totalbal1));
            end;

            trigger OnPreDataItem();
            begin
                IF totalbal1 < 0 THEN
                    closebal := -1 * totalbal1
                ELSE
                    closebal := totalbal1;
                MESSAGE('HI');
                MESSAGE(FORMAT(totalbal1));
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

    trigger OnPreReport();
    begin
        userid1 := "Analysis View Entry".GETFILTER("Analysis View Entry"."Dimension 2 Value Code");
        EMP.SETFILTER(EMP."No.", userid1);
        IF EMP.FINDFIRST THEN BEGIN
            NAME := EMP."First Name";
            IF EMP."Department Code" <> '' THEN
                NAME := NAME + ' (' + EMP."Department Code" + ')';
        END;
    end;

    var
        glentry: Record "G/L Entry";
        desc: Text[250];
        totadeb: Decimal;
        totacre: Decimal;
        user: Record User;
        userid1: Text[200];
        NAME: Text[50];
        totalbal: Decimal;
        mindate: Date;
        maxdate: Date;
        dep: Text[30];
        GL: Record "G/L Entry";
        appliedAmt: Decimal;
        ave: Record 365;
        formataddress: Codeunit 50000;
        "Opening Balance": Text[250];
        "Closing Balance": Text[250];
        totalbal1: Decimal;
        EMP: Record 5200;
        TRAVELLING_ADVANCE_DETAILSCaptionLbl: Label 'TRAVELLING ADVANCE DETAILS';
        EMPLOYEE_NAME__CaptionLbl: Label 'EMPLOYEE NAME :';
        Opening_Balance_as_onCaptionLbl: Label 'Opening Balance as on';
        Transaction_DateCaptionLbl: Label 'Transaction Date';
        Amount_Taken_from_OrganizationCaptionLbl: Label 'Amount Taken from Organization';
        Bills__SubmittedCaptionLbl: Label 'Bills  Submitted';
        PurposeCaptionLbl: Label 'Purpose';
        Transactions_FromCaptionLbl: Label 'Transactions From';
        PurposeCaption_Control1102154005Lbl: Label 'Purpose';
        Bills__SubmittedCaption_Control1102154003Lbl: Label 'Bills  Submitted';
        Amount_Taken_from_OrganizationCaption_Control1102152013Lbl: Label 'Amount Taken from Organization';
        Transaction_DateCaption_Control1102154002Lbl: Label 'Transaction Date';
        Closing_Balance___CaptionLbl: Label 'Closing Balance  :';
        TOTALCaptionLbl: Label 'TOTAL';
        For_any_Queries_Please_Contact_CaptionLbl: Label '"For any Queries Please Contact "';
        Note________Auto_Report_Generated_from_ERP____CaptionLbl: Label 'Note : ***  Auto Report Generated from ERP ***';
        Rajani_Efftronics_comCaptionLbl: Label 'Rajani@Efftronics.com';
        DateVar: Boolean;
        closebal: Decimal;
}

