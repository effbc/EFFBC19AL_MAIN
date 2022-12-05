tableextension 70127 ProductionBOMLineExt extends "Production BOM Line"
{
    fields
    {
        field(60033; Position1; Code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60034; "Position 21"; code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60035; "Position 31"; code[250])
        {
            DataClassification = CustomerContent;
        }
        field(60032; "Variant Code1"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        modify(Position)
        {
            trigger OnBeforeValidate()
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "No.");
                if Item.FindFirst then begin
                    if not (Item."Item Category Code" = 'MECH') then begin
                        CODE := '';
                        single_pos := false; //indicates if only single postion is used(Ex:R1)
                        range_pos := false;
                        is_slash := false; //defines a range(Ex:R1-R5)
                        first_val := ''; //stores the first char(say R)alphabet
                        sec_val := ''; //stores the second char(say 1)numeric
                        multi_first_val := '';
                        multi_sec_val := '';
                        First_Num := 0;
                        Second_Num := 0;
                        IS_SKIPPED := false;
                        CODE := Position;
                        Curr_Pos := 1;
                        if StrLen(CODE) > 2 then begin
                            if IS_SKIPPED = false then
                                repeat
                                    char := CopyStr(CODE, Curr_Pos, 1);
                                    if char = '-' then begin
                                        is_slash := true;
                                        if single_pos = false then
                                            Error('no comments/space inside range value')
                                        else
                                            single_pos := false;

                                    end
                                    else
                                        if char = ' ' then begin
                                            if Curr_Pos = StrLen(CODE) then
                                                Error('Un-necessary space at the ending');
                                            char1 := ' ';
                                            if Curr_Pos - 2 > 0 then
                                                char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                            if (first_val = '') and (char1 <> ')') then
                                                Error('Un necessary space detected');

                                            if range_pos then begin
                                                if first_val <> sec_val then
                                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                                if multi_first_val <> multi_sec_val then
                                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                                if Second_Num <= First_Num then
                                                    Error('ERROR IN RANGE');
                                            end
                                            else
                                                if is_slash then
                                                    Error('Un necessary1 "-"');
                                            single_pos := false;
                                            range_pos := false;
                                            is_slash := false;
                                            first_val := '';
                                            sec_val := '';
                                            multi_first_val := '';
                                            multi_sec_val := '';
                                            First_Num := 0;
                                            Second_Num := 0;
                                        end
                                        else
                                            if char = '(' then begin
                                                if Curr_Pos > 1 then begin
                                                    char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                                    if (char1 <> ' ') and (char1 <> ')') then
                                                        Error('No space between comment and position-1');
                                                end
                                                else
                                                    first_val := '@';
                                                Curr_Pos_inner := Curr_Pos + 1;
                                                No_times_Rep := 1;
                                                repeat
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if char = ')' then
                                                        No_times_Rep := No_times_Rep - 1;
                                                    if char = '(' then
                                                        No_times_Rep := No_times_Rep + 1;

                                                    Curr_Pos_inner := Curr_Pos_inner + 1;

                                                until (No_times_Rep = 0) or (Curr_Pos_inner > StrLen(CODE));

                                                if No_times_Rep > 0 then
                                                    Error('COMMENT NOT PROPERLY ENDED');
                                                Curr_Pos := Curr_Pos_inner - 1;
                                                if Curr_Pos_inner < StrLen(CODE) then begin
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if (char <> ' ') and (char <> '(') then
                                                        Error('No space between comment and position-2');
                                                end;
                                            end
                                            else
                                                if (char in ['A' .. 'Z']) or (char = '/') then begin
                                                    if single_pos then begin
                                                        multi_first_val := multi_first_val + char;
                                                    end else
                                                        if range_pos then begin
                                                            multi_sec_val := multi_sec_val + char;
                                                        end else
                                                            if is_slash then begin
                                                                sec_val := sec_val + char;
                                                            end else
                                                                first_val := first_val + char;
                                                end
                                                else
                                                    if (char in ['0' .. '9']) or (char = '.') then begin
                                                        if first_val = '' then
                                                            Error('1');
                                                        //IF multi_first_val <>'' THEN
                                                        //ERROR('No Numeric in Multi Value');
                                                        if is_slash then begin
                                                            range_pos := true;
                                                            if Evaluate(test_int, char) then begin
                                                                if Second_Num = 0 then
                                                                    Second_Num := Second_Num + test_int
                                                                else
                                                                    Second_Num := Second_Num * 10 + test_int;

                                                            end;
                                                        end
                                                        else begin
                                                            if Evaluate(test_int, char) then begin
                                                                if First_Num = 0 then
                                                                    First_Num := First_Num + test_int
                                                                else
                                                                    First_Num := First_Num * 10 + test_int;

                                                            end;
                                                            single_pos := true;
                                                            if First_Num = 0 then
                                                                Error('0 IS NOT A VALID POSITION');
                                                        end;
                                                    end
                                                    else
                                                        Error('Unknown character');
                                    Curr_Pos := Curr_Pos + 1;
                                until Curr_Pos > StrLen(CODE);
                            if range_pos then begin
                                if first_val <> sec_val then
                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                if multi_first_val <> multi_sec_val then
                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                if Second_Num <= First_Num then
                                    Error('ERROR IN RANGE');

                                range_pos := false;
                                is_slash := false;
                            end;
                            if is_slash then
                                Error('UN NECESSARY "-"');
                        end;
                    end;
                end;
            END;
        }
        modify("Position 2")
        {
            trigger OnBeforeValidate()
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "No.");
                if Item.FindFirst then begin
                    if not (Item."Item Category Code" = 'MECH') then begin

                        CODE := '';
                        single_pos := false; //indicates if only single postion is used(Ex:R1)
                        range_pos := false;
                        is_slash := false; //defines a range(Ex:R1-R5)
                        first_val := ''; //stores the first char(say R)alphabet
                        sec_val := ''; //stores the second char(say 1)numeric
                        multi_first_val := '';
                        multi_sec_val := '';
                        First_Num := 0;
                        Second_Num := 0;
                        IS_SKIPPED := false;
                        CODE := "Position 2";
                        Curr_Pos := 1;
                        if StrLen(CODE) > 2 then begin
                            if IS_SKIPPED = false then
                                repeat
                                    char := CopyStr(CODE, Curr_Pos, 1);
                                    if char = '-' then begin
                                        is_slash := true;
                                        if single_pos = false then
                                            Error('no comments/space inside range value')
                                        else
                                            single_pos := false;

                                    end
                                    else
                                        if char = ' ' then begin
                                            if Curr_Pos = StrLen(CODE) then
                                                Error('Un-necessary space at the ending');
                                            char1 := ' ';
                                            if Curr_Pos - 2 > 0 then
                                                char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                            if (first_val = '') and (char1 <> ')') then
                                                Error('Un necessary space detected');

                                            if range_pos then begin
                                                if first_val <> sec_val then
                                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                                if multi_first_val <> multi_sec_val then
                                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                                if Second_Num <= First_Num then
                                                    Error('ERROR IN RANGE');
                                            end
                                            else
                                                if is_slash then
                                                    Error('Un necessary1 "-"');
                                            single_pos := false;
                                            range_pos := false;
                                            is_slash := false;
                                            first_val := '';
                                            sec_val := '';
                                            multi_first_val := '';
                                            multi_sec_val := '';
                                            First_Num := 0;
                                            Second_Num := 0;
                                        end
                                        else
                                            if char = '(' then begin
                                                if Curr_Pos > 1 then begin
                                                    char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                                    if (char1 <> ' ') and (char1 <> ')') then
                                                        Error('No space between comment and position-1');
                                                end
                                                else
                                                    first_val := '@';
                                                Curr_Pos_inner := Curr_Pos + 1;
                                                No_times_Rep := 1;
                                                repeat
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if char = ')' then
                                                        No_times_Rep := No_times_Rep - 1;
                                                    if char = '(' then
                                                        No_times_Rep := No_times_Rep + 1;

                                                    Curr_Pos_inner := Curr_Pos_inner + 1;

                                                until (No_times_Rep = 0) or (Curr_Pos_inner > StrLen(CODE));

                                                if No_times_Rep > 0 then
                                                    Error('COMMENT NOT PROPERLY ENDED');
                                                Curr_Pos := Curr_Pos_inner - 1;
                                                if Curr_Pos_inner < StrLen(CODE) then begin
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if (char <> ' ') and (char <> '(') then
                                                        Error('No space between comment and position-2');
                                                end;
                                            end
                                            else
                                                if (char in ['A' .. 'Z']) or (char = '/') then begin
                                                    if single_pos then begin
                                                        multi_first_val := multi_first_val + char;
                                                    end else
                                                        if range_pos then begin
                                                            multi_sec_val := multi_sec_val + char;
                                                        end else
                                                            if is_slash then begin
                                                                sec_val := sec_val + char;
                                                            end else
                                                                first_val := first_val + char;
                                                end
                                                else
                                                    if (char in ['0' .. '9']) or (char = '.') then begin
                                                        if first_val = '' then
                                                            Error('1');
                                                        //IF multi_first_val <>'' THEN
                                                        //ERROR('No Numeric in Multi Value');
                                                        if is_slash then begin
                                                            range_pos := true;
                                                            if Evaluate(test_int, char) then begin
                                                                if Second_Num = 0 then
                                                                    Second_Num := Second_Num + test_int
                                                                else
                                                                    Second_Num := Second_Num * 10 + test_int;

                                                            end;
                                                        end
                                                        else begin
                                                            if Evaluate(test_int, char) then begin
                                                                if First_Num = 0 then
                                                                    First_Num := First_Num + test_int
                                                                else
                                                                    First_Num := First_Num * 10 + test_int;

                                                            end;
                                                            single_pos := true;
                                                            if First_Num = 0 then
                                                                Error('0 IS NOT A VALID POSITION');
                                                        end;
                                                    end
                                                    else
                                                        Error('Unknown character');
                                    Curr_Pos := Curr_Pos + 1;
                                until Curr_Pos > StrLen(CODE);
                            if range_pos then begin
                                if first_val <> sec_val then
                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                if multi_first_val <> multi_sec_val then
                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                if Second_Num <= First_Num then
                                    Error('ERROR IN RANGE');

                                range_pos := false;
                                is_slash := false;
                            end;
                            if is_slash then
                                Error('UN NECESSARY "-"');
                        end;
                    end;
                end;
            end;
        }
        modify("Position 3")
        {
            trigger OnBeforeValidate()
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "No.");
                if Item.FindFirst then begin
                    if not (Item."Item Category Code" = 'MECH') then begin

                        CODE := '';
                        single_pos := false; //indicates if only single postion is used(Ex:R1)
                        range_pos := false;
                        is_slash := false; //defines a range(Ex:R1-R5)
                        first_val := ''; //stores the first char(say R)alphabet
                        sec_val := ''; //stores the second char(say 1)numeric
                        multi_first_val := '';
                        multi_sec_val := '';
                        First_Num := 0;
                        Second_Num := 0;
                        IS_SKIPPED := false;
                        CODE := "Position 3";
                        Curr_Pos := 1;
                        if StrLen(CODE) > 2 then begin
                            if IS_SKIPPED = false then
                                repeat
                                    char := CopyStr(CODE, Curr_Pos, 1);
                                    if char = '-' then begin
                                        is_slash := true;
                                        if single_pos = false then
                                            Error('no comments/space inside range value')
                                        else
                                            single_pos := false;

                                    end
                                    else
                                        if char = ' ' then begin
                                            if Curr_Pos = StrLen(CODE) then
                                                Error('Un-necessary space at the ending');
                                            char1 := ' ';
                                            if Curr_Pos - 2 > 0 then
                                                char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                            if (first_val = '') and (char1 <> ')') then
                                                Error('Un necessary space detected');

                                            if range_pos then begin
                                                if first_val <> sec_val then
                                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                                if multi_first_val <> multi_sec_val then
                                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                                if Second_Num <= First_Num then
                                                    Error('ERROR IN RANGE');
                                            end
                                            else
                                                if is_slash then
                                                    Error('Un necessary1 "-"');
                                            single_pos := false;
                                            range_pos := false;
                                            is_slash := false;
                                            first_val := '';
                                            sec_val := '';
                                            multi_first_val := '';
                                            multi_sec_val := '';
                                            First_Num := 0;
                                            Second_Num := 0;
                                        end
                                        else
                                            if char = '(' then begin
                                                if Curr_Pos > 1 then begin
                                                    char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                                    if (char1 <> ' ') and (char1 <> ')') then
                                                        Error('No space between comment and position-1');
                                                end
                                                else
                                                    first_val := '@';
                                                Curr_Pos_inner := Curr_Pos + 1;
                                                No_times_Rep := 1;
                                                repeat
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if char = ')' then
                                                        No_times_Rep := No_times_Rep - 1;
                                                    if char = '(' then
                                                        No_times_Rep := No_times_Rep + 1;

                                                    Curr_Pos_inner := Curr_Pos_inner + 1;

                                                until (No_times_Rep = 0) or (Curr_Pos_inner > StrLen(CODE));

                                                if No_times_Rep > 0 then
                                                    Error('COMMENT NOT PROPERLY ENDED');
                                                Curr_Pos := Curr_Pos_inner - 1;
                                                if Curr_Pos_inner < StrLen(CODE) then begin
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if (char <> ' ') and (char <> '(') then
                                                        Error('No space between comment and position-2');
                                                end;
                                            end
                                            else
                                                if (char in ['A' .. 'Z']) or (char = '/') then begin
                                                    if single_pos then begin
                                                        multi_first_val := multi_first_val + char;
                                                    end else
                                                        if range_pos then begin
                                                            multi_sec_val := multi_sec_val + char;
                                                        end else
                                                            if is_slash then begin
                                                                sec_val := sec_val + char;
                                                            end else
                                                                first_val := first_val + char;
                                                end
                                                else
                                                    if (char in ['0' .. '9']) or (char = '.') then begin
                                                        if first_val = '' then
                                                            Error('1');
                                                        //IF multi_first_val <>'' THEN
                                                        //ERROR('No Numeric in Multi Value');
                                                        if is_slash then begin
                                                            range_pos := true;
                                                            if Evaluate(test_int, char) then begin
                                                                if Second_Num = 0 then
                                                                    Second_Num := Second_Num + test_int
                                                                else
                                                                    Second_Num := Second_Num * 10 + test_int;

                                                            end;
                                                        end
                                                        else begin
                                                            if Evaluate(test_int, char) then begin
                                                                if First_Num = 0 then
                                                                    First_Num := First_Num + test_int
                                                                else
                                                                    First_Num := First_Num * 10 + test_int;

                                                            end;
                                                            single_pos := true;
                                                            if First_Num = 0 then
                                                                Error('0 IS NOT A VALID POSITION');
                                                        end;
                                                    end
                                                    else
                                                        Error('Unknown character');
                                    Curr_Pos := Curr_Pos + 1;
                                until Curr_Pos > StrLen(CODE);
                            if range_pos then begin
                                if first_val <> sec_val then
                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                if multi_first_val <> multi_sec_val then
                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                if Second_Num <= First_Num then
                                    Error('ERROR IN RANGE');

                                range_pos := false;
                                is_slash := false;
                            end;
                            if is_slash then
                                Error('UN NECESSARY "-"');
                        end;
                    end;
                end;
            end;
        }

        modify("No.")
        {
            trigger OnBeforeValidate()
            begin
                TestType;
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnBeforeValidate()
            begin
                if Type = Type::Item then begin
                    TestField("No.");
                end;
            end;
        }
        modify("Quantity per")
        {
            trigger OnBeforeValidate()
            var
                TOTSolderingPoints: Integer;
                TOTFixingPoints: Integer;
            begin
                if Type = Type::Item then
                    Validate("Calculation Formula");
            end;

            trigger OnAfterValidate()
            begin
                /* Commented on 110907  NSS
                   Item.RESET;
                   IF Type = Type::Item THEN BEGIN
                       Item.GET("No.");
                       MESSAGE('%1', Item."No. of Soldering Points");
                       "No. of Soldering Points" := ROUND("Quantity per" * Item."No. of Soldering Points", 1, '=');
                       "No. of Pins" := ROUND("Quantity per" * Item."No. of Pins", 1, '=');
                       "No. of Opportunities" := ROUND("Quantity per" * Item."No. of Opportunities", 1, '=');
                       "No. of Fixing Holes" := ROUND("Quantity per" * Item."No.of Fixing Holes", 1, '=');
                   END; */


                //NSS 110907
                Item.Reset;
                if Type = Type::Item then begin
                    Item.Get("No.");
                    Updateparameters(Item);
                    if ProdBOMHeader.Get("No.") then begin
                        Validate("No. of Soldering Points", ProdBOMHeader."Total Soldering Points" * "Quantity per");
                        "No. of SMD Points" := ProdBOMHeader."Total Soldering Points SMD" * "Quantity per";
                        "No. of DIP Point" := ProdBOMHeader."Total Soldering Points DIP" * "Quantity per";

                    end else begin
                        Validate("No. of Pins", ("Quantity per" * Item."No. of Pins"));
                        Validate("No. of Soldering Points", (("Quantity per" - "Scrap Quantity") * Item."No. of Soldering Points"));
                        Validate("No. of Opportunities", ("Quantity per" * Item."No. of Opportunities"));
                        Validate("No. of Fixing Holes", ("Quantity per" * "No. of Fixing Holes"));
                    end;

                end;
                Quantity := "Quantity per";
                //NSS 110907
                //cost1.0
                "Tot Avg Cost" := "Avg Cost" * "Quantity per";
                //cost1.0
            end;
        }
        field(60001; "Substitute Item"; Code[20])
        {
            Description = 'B2B';
            TableRelation = "Item Substitution"."Substitute No." WHERE("No." = FIELD("No."));
            DataClassification = CustomerContent;
        }
        field(60002; "Allow Excess Qty."; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60003; "No. of Pins"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60004; "No. of Soldering Points"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60005; "No. of Opportunities"; Decimal)
        {
            BlankZero = true;
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60006; "Type of Solder"; Enum TypeofSolder)
        {
            Description = 'B2B';
            Editable = true;
            DataClassification = CustomerContent;
        }
        field(60007; "Shelf No."; Code[20])
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60008; "Change Type"; Enum "Change Type")
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60009; "No. of Fixing Holes"; Integer)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60010; "Position 4"; Code[250])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                Item.Reset;
                Item.SetFilter(Item."No.", "No.");
                if Item.FindFirst then begin
                    if not (Item."Item Category Code" = 'MECH') then begin

                        CODE := '';
                        single_pos := false; //indicates if only single postion is used(Ex:R1)
                        range_pos := false;
                        is_slash := false; //defines a range(Ex:R1-R5)
                        first_val := ''; //stores the first char(say R)alphabet
                        sec_val := ''; //stores the second char(say 1)numeric
                        multi_first_val := '';
                        multi_sec_val := '';
                        First_Num := 0;
                        Second_Num := 0;
                        IS_SKIPPED := false;
                        CODE := "Position 4";
                        Curr_Pos := 1;
                        if StrLen(CODE) > 2 then begin
                            if IS_SKIPPED = false then
                                repeat
                                    char := CopyStr(CODE, Curr_Pos, 1);
                                    if char = '-' then begin
                                        is_slash := true;
                                        if single_pos = false then
                                            Error('no comments/space inside range value')
                                        else
                                            single_pos := false;

                                    end
                                    else
                                        if char = ' ' then begin
                                            if Curr_Pos = StrLen(CODE) then
                                                Error('Un-necessary space at the ending');
                                            char1 := ' ';
                                            if Curr_Pos - 2 > 0 then
                                                char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                            if (first_val = '') and (char1 <> ')') then
                                                Error('Un necessary space detected');

                                            if range_pos then begin
                                                if first_val <> sec_val then
                                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                                if multi_first_val <> multi_sec_val then
                                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                                if Second_Num <= First_Num then
                                                    Error('ERROR IN RANGE');
                                            end
                                            else
                                                if is_slash then
                                                    Error('Un necessary1 "-"');
                                            single_pos := false;
                                            range_pos := false;
                                            is_slash := false;
                                            first_val := '';
                                            sec_val := '';
                                            multi_first_val := '';
                                            multi_sec_val := '';
                                            First_Num := 0;
                                            Second_Num := 0;
                                        end
                                        else
                                            if char = '(' then begin
                                                if Curr_Pos > 1 then begin
                                                    char1 := CopyStr(CODE, Curr_Pos - 1, 1);
                                                    if (char1 <> ' ') and (char1 <> ')') then
                                                        Error('No space between comment and position-1');
                                                end
                                                else
                                                    first_val := '@';
                                                Curr_Pos_inner := Curr_Pos + 1;
                                                No_times_Rep := 1;
                                                repeat
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if char = ')' then
                                                        No_times_Rep := No_times_Rep - 1;
                                                    if char = '(' then
                                                        No_times_Rep := No_times_Rep + 1;

                                                    Curr_Pos_inner := Curr_Pos_inner + 1;

                                                until (No_times_Rep = 0) or (Curr_Pos_inner > StrLen(CODE));

                                                if No_times_Rep > 0 then
                                                    Error('COMMENT NOT PROPERLY ENDED');
                                                Curr_Pos := Curr_Pos_inner - 1;
                                                if Curr_Pos_inner < StrLen(CODE) then begin
                                                    char := CopyStr(CODE, Curr_Pos_inner, 1);
                                                    if (char <> ' ') and (char <> '(') then
                                                        Error('No space between comment and position-2');
                                                end;
                                            end
                                            else
                                                if (char in ['A' .. 'Z']) or (char = '/') then begin
                                                    if single_pos then begin
                                                        multi_first_val := multi_first_val + char;
                                                    end else
                                                        if range_pos then begin
                                                            multi_sec_val := multi_sec_val + char;
                                                        end else
                                                            if is_slash then begin
                                                                sec_val := sec_val + char;
                                                            end else
                                                                first_val := first_val + char;
                                                end
                                                else
                                                    if (char in ['0' .. '9']) or (char = '.') then begin
                                                        if first_val = '' then
                                                            Error('1');
                                                        //IF multi_first_val <>'' THEN
                                                        //ERROR('No Numeric in Multi Value');
                                                        if is_slash then begin
                                                            range_pos := true;
                                                            if Evaluate(test_int, char) then begin
                                                                if Second_Num = 0 then
                                                                    Second_Num := Second_Num + test_int
                                                                else
                                                                    Second_Num := Second_Num * 10 + test_int;

                                                            end;
                                                        end
                                                        else begin
                                                            if Evaluate(test_int, char) then begin
                                                                if First_Num = 0 then
                                                                    First_Num := First_Num + test_int
                                                                else
                                                                    First_Num := First_Num * 10 + test_int;

                                                            end;
                                                            single_pos := true;
                                                            if First_Num = 0 then
                                                                Error('0 IS NOT A VALID POSITION');
                                                        end;
                                                    end
                                                    else
                                                        Error('Unknown character');
                                    Curr_Pos := Curr_Pos + 1;
                                until Curr_Pos > StrLen(CODE);
                            if range_pos then begin
                                if first_val <> sec_val then
                                    Error('ERROR AT 1ST CHAR IN RANGE');
                                if multi_first_val <> multi_sec_val then
                                    Error('ERROR AT 3RD CHAR IN RANGE');
                                if Second_Num <= First_Num then
                                    Error('ERROR IN RANGE');

                                range_pos := false;
                                is_slash := false;
                            end;
                            if is_slash then
                                Error('UN NECESSARY "-"');
                        end;
                    end;
                end;
            end;
        }

        field(60011; "Description 2"; Text[50])
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60012; PCB; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60013; "Product group code"; Code[10])
        {
            Description = 'renuka';
            DataClassification = CustomerContent;
        }
        field(60014; "Include in SO Schedule"; Boolean)
        {
            Description = 'B2B';
            DataClassification = CustomerContent;
        }
        field(60015; "BOM Type"; Enum BOMType)
        {
            Description = 'B2B';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(60016; "Avg Cost"; Decimal)
        {
            Description = 'Cost1.0';
            DataClassification = CustomerContent;
        }
        field(60017; "Manufacturing Cost"; Decimal)
        {
            Description = 'Cost1.0';
            DataClassification = CustomerContent;
        }
        field(60018; "Tot Avg Cost"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60019; "Material Reqired Day"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60020; Status; Enum Status2)
        {
            CalcFormula = Lookup("Production BOM Header".Status WHERE("No." = FIELD("Production BOM No.")));
            FieldClass = FlowField;
        }
        field(60021; "Scrap Quantity"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get("No.") then
                    "No. of Soldering Points" := Item."No. of Soldering Points" * ("Quantity per" - "Scrap Quantity");
            end;
        }
        field(60022; "No. of SMD Points"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60023; "No. of DIP Point"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(60024; "Part number"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60025; "Storage Temperature"; Text[30])
        {
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if Item.Get("No.") then
                    "Storage Temperature" := Item."Storage Temperature";
            end;
        }
        field(60026; Make; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(60027; Package; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60028; Certify; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60029; Dept; Code[10])
        {
            Description = 'pranavi';
            DataClassification = CustomerContent;
        }
        field(60030; "Operation No."; Code[10])
        {
            Description = 'pranavi';
            TableRelation = "Routing Line"."Operation No." WHERE("Routing No." = FIELD("Production BOM No."));
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                //added by pranavi on 09-05-2015 for updating dept code to prod. bom lines
                routingline.Reset;
                if "Operation No." = '' then
                    Dept := ''
                else begin
                    routingline.SetFilter(routingline."Routing No.", "Production BOM No.");
                    routingline.SetFilter(routingline."Operation No.", "Operation No.");
                    if routingline.FindFirst then
                        Dept := routingline."No.";
                end;
                //end--pranavi
            end;
        }
        field(60031; "operating temp"; Text[30])
        {
            CalcFormula = Lookup(Item."Operating Temperature" WHERE("No." = FIELD("No.")));
            Description = 'sujani';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key4; "Tot Avg Cost")
        {

        }
    }

    trigger OnBeforeInsert()
    begin
        //Added by Rakesh on 12-Jul-14 to stop modification when BOM is under certification
        /* IF NOT (UPPERCASE(USERID) IN ['ERPSERVER\ADMINISTRATOR','EFFTRONICS\MNRAJU']) THEN
        BEGIN
          ProdBOMHeader.SETRANGE(ProdBOMHeader."No.","Production BOM No.");
          IF ProdBOMHeader.FINDFIRST THEN
          BEGIN
              IF ProdBOMHeader.Certify > 0 THEN
                ERROR('BOM('+"Production BOM No."+') is under Approval, modifications are not allowed.');
            END;
        END; */

        //end by Rakesh
    end;

    trigger OnBeforeModify()
    begin
        //Added by Rakesh on 12-Jul-14 to stop modification when BOM is under certification
        /* IF NOT (UPPERCASE(USERID) IN ['ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\MNRAJU']) THEN BEGIN
     ProdBOMHeader.SETRANGE(ProdBOMHeader."No.", "Production BOM No.");
     IF ProdBOMHeader.FINDFIRST THEN BEGIN
         IF ProdBOMHeader.Certify > 0 THEN
             ERROR('BOM(' + "Production BOM No." + ') is under Approval, modifications are not allowed.');
     END;
 END; */
        //end by Rakesh
        ProdBOMHeader.Reset;
        ProdBOMHeader.SetRange(ProdBOMHeader."No.", "Production BOM No.");
        if ProdBOMHeader.FindFirst then
            ProdBOMHeader."Modified User ID" := UserId;
    end;

    trigger OnAfterModify()
    begin
        // vishnu for bom alerts

        /* BEGIN
        Subject := 'BOM -' + Rec."Production BOM No." + ' -Done';
        SMTP_MAIL.CreateMessage('ERP', 'erp@efftronics.com', 'vishnupriya@efftronics.com', Subject, '', TRUE);
        SMTP_MAIL.AppendBody('<html><body><table>');
        SMTP_MAIL.AppendBody('<th>BOM  Details</th>');
        ProdBOMHeader.RESET;
        ProdBOMHeader.SETFILTER("No.", Rec."Production BOM No.");
        ProdBOMHeader.FINDFIRST;
        SMTP_MAIL.AppendBody('<tr><td>BOM No</td><td>' + FORMAT(ProdBOMHeader."No.") + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>User Id</td><td>' + ProdBOMHeader."User Id" + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Last Modified Date</td><td>' + FORMAT(ProdBOMHeader."Last Date Modified") + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Today</td><td>' + FORMAT(TODAY) + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Item No</td><td>' + Rec."No." + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Desc</td><td>' + Rec.Description + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Qty</td><td>' + FORMAT(Rec.Quantity) + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Postition</td>' + Rec.Position + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Position2</td><td>' + Rec."Position 2" + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Position3</td><td>' + Rec."Position 3" + '</td></tr>');
        SMTP_MAIL.AppendBody('<tr><td>Position4</td><td>' + Rec."Position 4" + '</td></tr>');
        //MESSAGE(DELCHR(FORMAT(Rec.Quantity),'<=>',','));
        LastdateM := ProdBOMHeader."Last Date Modified";


        SMTP_MAIL.AppendBody('</table>');
        //SMTP_MAIL.AppendBody('<br/><br/>*********** This is auto generated mail from ERP ************</body></html>');
        SMTP_MAIL.Send;
    END; */

        // commented by vishnu Priya on 02-05-2020

        /* IF ISCLEAR(SQLConnection) THEN
          CREATE(SQLConnection,FALSE,TRUE);

        IF ISCLEAR(RecordSet) THEN
          CREATE(RecordSet,FALSE,TRUE);

        IF ConnectionOpen <> 1 THEN
        BEGIN
          SQLConnection.ConnectionString:='DSN=erpserver;UID=report;PASSWORD=Efftronics@eff;SERVER=erpserver;';
          SQLConnection.Open;
          SQLConnection.BeginTrans;
          ConnectionOpen:=1;
        END;
            ProdBOMHeader.RESET;
            ProdBOMHeader.SETFILTER("No.",Rec."Production BOM No.");
            ProdBOMHeader.FINDFIRST;
            Day := DATE2DMY(ProdBOMHeader."Last Date Modified",1);
            Month := DATE2DMY(ProdBOMHeader."Last Date Modified",2);
            Year := DATE2DMY(ProdBOMHeader."Last Date Modified",3);
            Datecon := FORMAT(Year)+'-'+FORMAT(Month)+'-'+FORMAT(Day);
            //MESSAGE(FORMAT(Datecon));
           //MESSAGE(COPYSTR(ProdBOMHeader."User Id",11,STRLEN(ProdBOMHeader."Modified User ID")));
        SQLQuery := 'insert into [BOM alerts purpose custom] ([Bom Num], [BOM Desc], Status, [Last Modified Date],[Current time],'+
                '[Component Number], [Component Desc], [Component Qty], [Position1], [Postion2],'+
                '[Postion3], [User Id],Postion4,LineBOM_type1,[BOM Type],currentusername1'+
                ') values('''+FORMAT(Rec."Production BOM No.")+''','''+FORMAT(ProdBOMHeader.Description)+''','''+FORMAT(ProdBOMHeader.Status)+''',convert(date,'''+FORMAT(Datecon)+'''),getdate(),'''+FORMAT(Rec."No.")+''','''+FORMAT(Rec.Description)+''','+
                DELCHR(FORMAT(Rec.Quantity),'<=>',',')+','''+FORMAT(Rec.Position)+''','''+
                FORMAT(Rec."Position 2")+''','''+FORMAT(Rec."Position 3")+''','''+FORMAT(COPYSTR(ProdBOMHeader."User Id",12,STRLEN(ProdBOMHeader."Modified User ID")))+''','''+FORMAT(Rec."Position 4")+''','''+
                FORMAT(Rec."BOM Type")+''','''+
                FORMAT(ProdBOMHeader."BOM Type")+''','''+FORMAT(DELSTR(USERID,1,11))+''')';
               // MESSAGE(SQLQuery);
                IF SQLQuery <>'' THEN
                SQLConnection.Execute(SQLQuery);
                SQLConnection.CommitTrans;
                //SQLConnection.BeginTrans; */

        // commented by vishnu Priya on 02-05-2020
    end;

    trigger OnBeforeDelete()
    begin
        //Added by Rakesh on 12-Jul-14 to stop modification when BOM is under certification
        /* IF NOT (UPPERCASE(USERID) IN ['ERPSERVER\ADMINISTRATOR', 'EFFTRONICS\MNRAJU']) THEN BEGIN
     ProdBOMHeader.SETRANGE(ProdBOMHeader."No.", "Production BOM No.");
     IF ProdBOMHeader.FINDFIRST THEN BEGIN
         IF ProdBOMHeader.Certify > 0 THEN
             ERROR('BOM(' + "Production BOM No." + ') is under Approval, modifications are not allowed.');
     END;
 END; */
        //end by Rakesh

        /* IF NOT((USERID='SUPER') OR (USERID='10RD010')) THEN
        BEGIN */
    end;

    var
        Item: Record Item;
        ProdBOMLine: Record "Production BOM Line";
        ProdBOMHeaderRec: Record "Production BOM Header";
        ProdBOMHeader: Record "Production BOM Header";
        IS_SKIPPED: Boolean;
        char: Text[30];
        char1: Text[30];
        single_pos: Boolean;
        range_pos: Boolean;
        multi_single_pos: Boolean;
        multi_range_pos: Boolean;
        is_slash: Boolean;
        first_val: Text[30];
        sec_val: Text[30];
        multi_first_val: Text[30];
        multi_sec_val: Text[30];
        Curr_Pos: Integer;
        First_Num: Integer;
        Second_Num: Integer;
        test_int: Integer;
        Curr_Pos_inner: Integer;
        No_times_Rep: Integer;
        "CODE": Code[250];
        routingline: Record "Routing Line";
        Subject: Text[300];
        //SMTP_MAIL: Codeunit "SMTP Mail";
        SQLQuery: Text[1000];
        RowCount: Integer;
        SQLQuery1: Text;
        ConnectionOpen: Integer;
        LastdateM: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Datecon: Text;
        BOMLineUOMErr: Label 'The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4, Line No. = %5.';


    PROCEDURE GetBOMLineQtyPerUOM(Item: Record Item): Decimal;
    VAR
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        UOMMgt: Codeunit "Unit of Measure Management";
    BEGIN
        if "No." = '' then
            exit(1);

        if not ItemUnitOfMeasure.Get(Item."No.", "Unit of Measure Code") then
            Error(BOMLineUOMErr, "Unit of Measure Code", Item."No.", "Production BOM No.", "Version Code", "Line No.");
        exit(UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"));
    END;


    PROCEDURE Updateparameters(VAR Item: Record Item);
    VAR
        ProductionBomLine: Record "Production BOM Line";
    BEGIN
        "No. of Pins" := 0;
        "No. of Soldering Points" := 0;
        "No. of Opportunities" := 0;
        "No. of Fixing Holes" := 0;

        ProductionBomLine.SetRange("Production BOM No.", Item."Production BOM No.");
        if ProductionBomLine.Find('-') then
            repeat
                if ProductionBomLine.Type = ProductionBomLine.Type::Item then begin
                    "No. of Pins" := "No. of Pins" + ProductionBomLine."No. of Pins";
                    "No. of Soldering Points" := "No. of Soldering Points" + ProductionBomLine."No. of Soldering Points";
                    "No. of Opportunities" := "No. of Opportunities" + ProductionBomLine."No. of Opportunities";
                    "No. of Fixing Holes" := "No. of Fixing Holes" + ProductionBomLine."No. of Fixing Holes";
                end;
            until ProductionBomLine.Next = 0
        else begin
            Item.Get("No.");
            "No. of Pins" := Item."No. of Pins";
            "No. of Opportunities" := Item."No. of Opportunities";
            "No. of Fixing Holes" := Item."No.of Fixing Holes";
            "No. of Soldering Points" := Item."No. of Soldering Points";
        end;
    END;


    PROCEDURE UpdateparametersQty(VAR Item: Record Item; Qty: Decimal);
    VAR
        ProductionBomLine: Record "Production BOM Line";
    BEGIN
        "No. of Pins" := 0;
        "No. of Soldering Points" := 0;
        "No. of Opportunities" := 0;
        "No. of Fixing Holes" := 0;
        ProductionBomLine.SetRange("Production BOM No.", Item."Production BOM No.");
        if ProductionBomLine.Find('-') then
            repeat
                "No. of Pins" := "No. of Pins" + ProductionBomLine."No. of Pins";
                "No. of Soldering Points" := "No. of Soldering Points" + ProductionBomLine."No. of Soldering Points";
                "No. of Opportunities" := "No. of Opportunities" + ProductionBomLine."No. of Opportunities";
                "No. of Fixing Holes" := "No. of Fixing Holes" + ProductionBomLine."No. of Fixing Holes";
                if ProductionBomLine.Type = ProductionBomLine.Type::Item then begin
                end;
            until ProductionBomLine.Next = 0;
    END;


    LOCAL PROCEDURE TestType();
    BEGIN
        if Item.Get("No.") then begin
            if Type = Type::"Production BOM" then
                Error('Item Should be Picked as Type');
        end;
    END;
}

