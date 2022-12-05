table 33000258 "Sampling Plan Line"
{
    // version QC1.0

    LookupPageID = "Sampling Plan List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Sampling Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Sampling Plan Header";
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Lot Size - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(4; "Lot Size - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(5; "Sampling Size"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(6; "Allowable Defects - Min"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(7; "Allowable Defects - Max"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Sampling Code", "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestStatus;
        CheckNextRec := false;
        CheckPrevRec := false;
        CheckRec := false;
        SamplePlanline.Reset;
        SamplePlanline.SetRange("Sampling Code", "Sampling Code");
        if SamplePlanline.Find('-') then
            repeat
                if not CheckRec then
                    if SamplePlanline."Line No." = "Line No." then begin
                        CheckRec := true;
                        if SamplePlanline.Next(-1) <> 0 then begin
                            TempSamplePlanline1 := SamplePlanline;
                            SamplePlanline.Next(1);
                            CheckPrevRec := true;
                        end;
                        if SamplePlanline.Next(1) <> 0 then begin
                            TempSamplePlanline2 := SamplePlanline;
                            CheckNextRec := true;
                        end;
                    end;
            until SamplePlanline.Next = 0;

        if CheckPrevRec and CheckNextRec then begin
            SamplePlanline := TempSamplePlanline2;
            SamplePlanline."Lot Size - Min" := TempSamplePlanline1."Lot Size - Max" + 1;
            SamplePlanline.Modify;
        end;
        if not CheckPrevRec and CheckNextRec then begin
            SamplePlanline := TempSamplePlanline2;
            SamplePlanline."Lot Size - Min" := 0;
            SamplePlanline.Modify;
        end;
    end;

    trigger OnInsert();
    begin
        TestStatus;
        CheckNextRec := false;
        CheckPrevRec := false;
        CheckRec := false;
        SamplePlanline.Reset;
        SamplePlanline.SetRange("Sampling Code", "Sampling Code");
        if SamplePlanline.Find('-') then
            repeat
                if SamplePlanline."Line No." < "Line No." then begin
                    TempSamplePlanline1 := SamplePlanline;
                    CheckRec := true;
                    CheckPrevRec := true;
                end else
                    CheckRec := false;
                if not CheckRec and not CheckNextRec then begin
                    TempSamplePlanline2 := SamplePlanline;
                    CheckNextRec := true;
                end;
            until SamplePlanline.Next = 0;

        if CheckPrevRec then
            if "Lot Size - Max" <= TempSamplePlanline1."Lot Size - Max" then
                Error(Text000);
        if CheckNextRec then
            if "Lot Size - Max" >= TempSamplePlanline2."Lot Size - Max" then
                Error(Text001)
            else begin
                SamplePlanline := TempSamplePlanline2;
                SamplePlanline."Lot Size - Min" := "Lot Size - Max" + 1;
                SamplePlanline.Modify;
            end;

        "Lot Size - Min" := TempSamplePlanline1."Lot Size - Max" + 1;
    end;

    trigger OnModify();
    begin
        TestStatus;
        CheckNextRec := false;
        CheckPrevRec := false;
        CheckRec := false;
        SamplePlanline.Reset;
        SamplePlanline.SetRange("Sampling Code", "Sampling Code");
        if SamplePlanline.Find('-') then
            repeat
                if not CheckRec then
                    if SamplePlanline."Line No." = "Line No." then begin
                        CheckRec := true;
                        if SamplePlanline.Next(-1) <> 0 then begin
                            TempSamplePlanline1 := SamplePlanline;
                            SamplePlanline.Next(1);
                            CheckPrevRec := true;
                        end;
                        if SamplePlanline.Next(1) <> 0 then begin
                            TempSamplePlanline2 := SamplePlanline;
                            CheckNextRec := true;
                        end;
                    end;
            until SamplePlanline.Next = 0;

        if CheckPrevRec then
            if "Lot Size - Max" <= TempSamplePlanline1."Lot Size - Max" then
                Error(Text000);
        if CheckNextRec then
            if "Lot Size - Max" >= TempSamplePlanline2."Lot Size - Max" then
                Error(Text001)
            else begin
                SamplePlanline := TempSamplePlanline2;
                SamplePlanline."Lot Size - Min" := "Lot Size - Max" + 1;
                SamplePlanline.Modify;
            end;
    end;

    var
        SamplePlanline: Record "Sampling Plan Line";
        TempSamplePlanline1: Record "Sampling Plan Line" temporary;
        TempSamplePlanline2: Record "Sampling Plan Line" temporary;
        CheckPrevRec: Boolean;
        CheckNextRec: Boolean;
        CheckRec: Boolean;
        Text000: Label 'Lot Max size should not be less than Previous Line Max size';
        Text001: Label 'Lot Max size is should not be greater than next Line Max size';


    procedure check();
    begin
        CheckNextRec := false;
        CheckPrevRec := false;
        CheckRec := false;
        SamplePlanline.Reset;
        SamplePlanline.SetRange("Sampling Code", "Sampling Code");
        if SamplePlanline.Find('-') then
            repeat
                if SamplePlanline."Line No." < "Line No." then begin
                    TempSamplePlanline1 := SamplePlanline;
                    CheckRec := true;
                    CheckPrevRec := true;
                end else
                    CheckRec := false;
                if not CheckRec and not CheckNextRec then begin
                    TempSamplePlanline2 := SamplePlanline;
                    CheckNextRec := true;
                end;
            until SamplePlanline.Next = 0;

        if CheckPrevRec then
            if "Lot Size - Max" <= TempSamplePlanline1."Lot Size - Max" then
                Error(Text000);
        if CheckNextRec then
            if "Lot Size - Max" >= TempSamplePlanline2."Lot Size - Max" then
                Error(Text001)
            else begin
                SamplePlanline := TempSamplePlanline2;
                SamplePlanline."Lot Size - Min" := "Lot Size - Max" + 1;
                SamplePlanline.Modify;
            end;

        "Lot Size - Min" := TempSamplePlanline1."Lot Size - Max" + 1;
    end;


    procedure TestStatus();
    var
        SamplePlanHeader: Record "Sampling Plan Header";
    begin
        SamplePlanHeader.Get("Sampling Code");
        SamplePlanHeader.TestField("Sampling Type", SamplePlanHeader."Sampling Type"::"Variable Quantity");
        if SamplePlanHeader.Status = SamplePlanHeader.Status::Certified then
            SamplePlanHeader.FieldError(Status);
    end;
}

