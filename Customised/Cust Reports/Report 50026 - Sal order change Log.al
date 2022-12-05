report 50026 "Sal order change Log"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Sal order change Log.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Sal Order change Log';

    dataset
    {
        dataitem("Change Log Entry"; "Change Log Entry")
        {
            DataItemTableView = SORTING("Table No.", "Primary Key Field 1 Value")
                                ORDER(Ascending)
                                WHERE("Table No." = FILTER(37 | 60025),
                                      "Type of Change" = FILTER(<> Insertion),
                                      "Primary Key Field 1 Value" = FILTER(1 | 4),
                                      "Field No." = FILTER(5 | 6 | 7 | 11 | 15 | 18 | 153));
            RequestFilterFields = "Date and Time";
            column(Title; Title)
            {
            }
            column(Change_Log_Entry___Primary_Key_Field_2_Value_; "Primary Key Field 2 Value")
            {
            }
            column(Sale_Order_No_Caption; Sale_Order_No_CaptionLbl)
            {
            }
            column(ItemCaption; ItemCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(QuantityCaption; QuantityCaptionLbl)
            {
            }
            column(Line_NoCaption; Line_NoCaptionLbl)
            {
            }
            column(Sale_Order_No_Caption_Control1102152018; Sale_Order_No_Caption_Control1102152018Lbl)
            {
            }
            column(ItemCaption_Control1102152020; ItemCaption_Control1102152020Lbl)
            {
            }
            column(DescriptionCaption_Control1102152032; DescriptionCaption_Control1102152032Lbl)
            {
            }
            column(QuantityCaption_Control1102152033; QuantityCaption_Control1102152033Lbl)
            {
            }
            column(Line_NoCaption_Control1102152034; Line_NoCaption_Control1102152034Lbl)
            {
            }
            column(Change_Log_Entry__Entry_No_; "Entry No.")
            {
            }
            dataitem("Change Log Entry1"; "Change Log Entry")
            {
                DataItemLink = "Primary Key Field 2 Value" = FIELD("Primary Key Field 2 Value");
                DataItemTableView = SORTING("Table No.", "Primary Key Field 1 Value")
                                    ORDER(Ascending)
                                    WHERE("Table No." = FILTER(37),
                                          "Field No." = FILTER(6 | 11 | 15));
                column(Change_Log_Entry1___Table_Name_; "Table Caption")
                {
                }
                column(FORMAT_Item_old_; FORMAT(Item_old))
                {
                }
                column(Desc_new; Desc_new)
                {
                }
                column(Qty_old; Qty_old)
                {
                }
                column(FORMAT_Item_new_; FORMAT(Item_new))
                {
                }
                column(Desc_old; Desc_old)
                {
                }
                column(Qty_new; Qty_new)
                {
                }
                column(Change_Log_Entry1___Primary_Key_Field_3_Value_; "Primary Key Field 3 Value")
                {
                }
                column(Change_Log_Entry1___Primary_Key_Field_3_Value__Control1102152019; "Primary Key Field 3 Value")
                {
                }
                column(Old_RecordCaption; Old_RecordCaptionLbl)
                {
                }
                column(New_RecordCaption; New_RecordCaptionLbl)
                {
                }
                column(Change_Log_Entry1__Entry_No_; "Entry No.")
                {
                }
                column(Change_Log_Entry1__Primary_Key_Field_2_Value; "Primary Key Field 2 Value")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    B1 := "Change Log Entry1"."Primary Key Field 3 Value";
                    IF B1 = B2 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        B2 := B1;
                        Item_old := '';
                        Item_new := '';
                        Desc_old := '';
                        Desc_new := '';
                        Qty_old := '';
                        Qty_new := '';
                        Qtytoshp_old := '';
                        Qtytoshp_new := '';
                        CLE.SETFILTER(CLE."Table No.", '=%1', 37);
                        CLE.SETFILTER(CLE."Primary Key Field 2 Value", "Change Log Entry1"."Primary Key Field 2 Value");
                        CLE.SETFILTER(CLE."Primary Key Field 3 Value", "Change Log Entry1"."Primary Key Field 3 Value");
                        CLE.SETFILTER(CLE."Date and Time", date);
                        CLE.SETFILTER(CLE."Type of Change", '<>%1', 0);
                        CLE.SETFILTER(CLE."Field No.", '%1|%2|%3', 6, 11, 15);
                        IF CLE.FIND('-') THEN
                            REPEAT
                                IF CLE."Field No." = 6 THEN BEGIN
                                    Item_old := CLE."Old Value";
                                    Item_new := CLE."New Value";
                                END
                                ELSE
                                    IF CLE."Field No." = 11 THEN BEGIN
                                        Desc_old := CLE."Old Value";
                                        Desc_new := CLE."New Value";
                                    END
                                    ELSE
                                        IF CLE."Field No." = 15 THEN BEGIN
                                            Qty_old := CLE."Old Value";
                                            Qty_new := CLE."New Value";
                                        END
                                        ELSE
                                            IF CLE."Field No." = 18 THEN BEGIN
                                                Qtytoshp_old := CLE."Old Value";
                                                Qtytoshp_new := CLE."New Value";
                                            END;
                            UNTIL CLE.NEXT = 0;
                        IF (Item_old = '') AND (Item_new = '') AND (Desc_old = '') AND (Desc_new = '') AND (Qty_old = '') AND (Qty_new = '') AND
                           (Qtytoshp_old = '') AND (Qtytoshp_new = '') THEN
                            CurrReport.SKIP
                        ELSE BEGIN
                            SL.RESET;
                            SL.SETFILTER(SL."Document No.", "Change Log Entry1"."Primary Key Field 2 Value");
                            SL.SETFILTER(SL."Line No.", "Change Log Entry1"."Primary Key Field 3 Value");
                            IF SL.FINDFIRST THEN BEGIN
                                IF (Item_old = '') AND (Item_new = '') THEN BEGIN
                                    Item_old := SL."No.";
                                    Item_new := SL."No."
                                END;
                                IF (Desc_old = '') AND (Desc_new = '') THEN BEGIN
                                    Desc_old := SL.Description;
                                    Desc_new := SL.Description;
                                END;

                                IF (Qty_old = '') AND (Qty_new = '') THEN BEGIN
                                    Qty_old := FORMAT(SL.Quantity);
                                    Qty_new := FORMAT(SL.Quantity);
                                END;
                                IF (Qtytoshp_old = '') AND (Qtytoshp_new = '') THEN BEGIN
                                    Qtytoshp_old := FORMAT(SL."Qty. to Ship");
                                    Qtytoshp_new := FORMAT(SL."Qty. to Ship");
                                END;
                            END;
                        END;
                    END;
                end;
            }
            dataitem("<Change Log Entry2>"; "Change Log Entry")
            {
                DataItemLink = "Primary Key Field 2 Value" = FIELD("Primary Key Field 2 Value");
                DataItemTableView = SORTING("Table No.", "Primary Key Field 1 Value")
                                    ORDER(Ascending)
                                    WHERE("Table No." = FILTER(60095),
                                          "Field No." = FILTER(5 | 6 | 7 | 153));
                column(Change_Log_Entry2___Table_Name_; "Table Caption")
                {
                }
                column(Change_Log_Entry2___Primary_Key_Field_3_Value_; "Primary Key Field 3 Value")
                {
                }
                column(Item_old; Item_old)
                {
                }
                column(Item_new; Item_new)
                {
                }
                column(Desc_old_Control1102152027; Desc_old)
                {
                }
                column(Desc_new_Control1102152028; Desc_new)
                {
                }
                column(Qty_old_Control1102152029; Qty_old)
                {
                }
                column(Qty_new_Control1102152030; Qty_new)
                {
                }
                column(Change_Log_Entry2___Primary_Key_Field_3_Value__Control1102152031; "Primary Key Field 3 Value")
                {
                }
                column(Old_RecordCaption_Control1102152022; Old_RecordCaption_Control1102152022Lbl)
                {
                }
                column(New_RecordCaption_Control1102152023; New_RecordCaption_Control1102152023Lbl)
                {
                }
                column(Change_Log_Entry2__Entry_No_; "Entry No.")
                {
                }
                column(Change_Log_Entry2__Primary_Key_Field_2_Value; "Primary Key Field 2 Value")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    C1 := "<Change Log Entry2>"."Primary Key Field 3 Value";
                    IF C1 = C2 THEN
                        CurrReport.SKIP
                    ELSE BEGIN
                        C2 := C1;
                        Item_old := '';
                        Item_new := '';
                        Desc_old := '';
                        Desc_new := '';
                        Qty_old := '';
                        Qty_new := '';
                        Qtytoshp_old := '';
                        Qtytoshp_new := '';
                        CLE.SETFILTER(CLE."Table No.", '=%1', 60095);
                        CLE.SETFILTER(CLE."Primary Key Field 2 Value", "Change Log Entry"."Primary Key Field 2 Value");
                        CLE.SETFILTER(CLE."Primary Key Field 3 Value", "Change Log Entry"."Primary Key Field 3 Value");
                        CLE.SETFILTER(CLE."Date and Time", date);
                        CLE.SETFILTER(CLE."Type of Change", '<>%1', 0);
                        CLE.SETFILTER(CLE."Field No.", '%1|%2|%3', 5, 6, 7);
                        IF CLE.FIND('-') THEN
                            REPEAT
                                IF CLE."Field No." = 5 THEN BEGIN
                                    Item_old := CLE."Old Value";
                                    Item_new := CLE."New Value";
                                END
                                ELSE
                                    IF CLE."Field No." = 6 THEN BEGIN
                                        Desc_old := CLE."Old Value";
                                        Desc_new := CLE."New Value";
                                    END
                                    ELSE
                                        IF CLE."Field No." = 7 THEN BEGIN
                                            Qty_old := CLE."Old Value";
                                            Qty_new := CLE."New Value";
                                        END;
                            UNTIL CLE.NEXT = 0;
                        Schedule.RESET;
                        Schedule.SETFILTER(Schedule."Document No.", "Change Log Entry1"."Primary Key Field 2 Value");
                        Schedule.SETFILTER(Schedule."Line No.", "Change Log Entry1"."Primary Key Field 3 Value");
                        IF Schedule.FINDFIRST THEN BEGIN
                            IF (Item_old = '') AND (Item_new = '') THEN BEGIN
                                Item_old := Schedule."No.";
                                Item_new := Schedule."No."
                            END;
                            IF (Desc_old = '') AND (Desc_new = '') THEN BEGIN
                                Desc_old := Schedule.Description;
                                Desc_new := Schedule.Description;
                            END;

                            IF (Qty_old = '') AND (Qty_new = '') THEN BEGIN
                                Qty_old := FORMAT(Schedule.Quantity);
                                Qty_new := FORMAT(Schedule.Quantity);
                            END;

                        END;

                    END;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //MESSAGE('S1');
                A1 := "Change Log Entry"."Primary Key Field 2 Value";
                IF A1 = A2 THEN
                    CurrReport.SKIP
                ELSE
                    A2 := A1;
                date := "Change Log Entry".GETFILTER("Change Log Entry"."Date and Time");
            end;

            trigger OnPreDataItem();
            begin
                // MESSAGE('S');
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
        A1: Code[30];
        A2: Code[30];
        B1: Text[30];
        B2: Text[30];
        C1: Text[30];
        C2: Text[30];
        Item_old: Code[20];
        Desc_old: Text[250];
        Qty_old: Text[30];
        Qtytoshp_old: Text[30];
        Item_new: Code[20];
        Desc_new: Text[250];
        Qty_new: Text[30];
        Qtytoshp_new: Text[30];
        CLE: Record "Change Log Entry";
        SL: Record "Sales Line";
        Schedule: Record Schedule2;
        date: Text[30];
        Title: Text[100];
        Sale_Order_No_CaptionLbl: Label '"Sale Order No "';
        ItemCaptionLbl: Label 'Item';
        DescriptionCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        Line_NoCaptionLbl: Label 'Line No';
        Sale_Order_No_Caption_Control1102152018Lbl: Label '"Sale Order No "';
        ItemCaption_Control1102152020Lbl: Label 'Item';
        DescriptionCaption_Control1102152032Lbl: Label 'Description';
        QuantityCaption_Control1102152033Lbl: Label 'Quantity';
        Line_NoCaption_Control1102152034Lbl: Label 'Line No';
        Old_RecordCaptionLbl: Label 'Old Record';
        New_RecordCaptionLbl: Label 'New Record';
        Old_RecordCaption_Control1102152022Lbl: Label 'Old Record';
        New_RecordCaption_Control1102152023Lbl: Label 'New Record';
}

