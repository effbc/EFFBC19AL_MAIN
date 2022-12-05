page 60276 "Vendor wise Avail.Makes List"
{
    // Page created by Vishnu Priya on 23-10-2020 .
    // All the rights are given for the specific user.

    Editable = true;
    PageType = List;
    SourceTable = "Vendor Wise Available Makes";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor Number"; Rec."Vendor Number")
                {
                    Editable = FieldEditable;
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    Editable = FieldEditable;
                    ApplicationArea = All;
                }
                field("Vendor Type"; Rec."Vendor Type")
                {
                    Editable = FieldEditable;
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    Editable = FieldEditable;
                    Visible = field_visible_make;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = FieldEditable;
                    Visible = field_visible_PGC;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        IF Rec."Product Group Code" <> '' THEN
                            IF Rec.Make <> '' THEN
                                ERROR('You can''t enter both Make and Product Group Codes');
                    end;
                }
                field("Last Updated Time"; Rec."Last Updated Time")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin

        IF SMTP_MAIL.Permission_Checking(USERID, 'VEND-MAKES-PGC-TEMC') THEN BEGIN
            field_visible_PGC := FALSE;
            field_visible_make := TRUE;
            FieldEditable := TRUE;
        END
        ELSE
            IF SMTP_MAIL.Permission_Checking(USERID, 'VEND-MAKES-PGC-MECH') THEN BEGIN
                field_visible_make := FALSE;
                field_visible_PGC := TRUE;
                FieldEditable := TRUE;
            END
            ELSE
                IF SMTP_MAIL.Permission_Checking(USERID, 'VEND-MAKES-PGC-ALL') THEN BEGIN
                    field_visible_PGC := TRUE;
                    field_visible_make := TRUE;
                    FieldEditable := FALSE;
                END
                ELSE
                    ERROR('You Don''t have permissions to open this page.');
    end;

    var
        SMTP_MAIL: Codeunit "Custom Events";
        field_visible_PGC: Boolean;
        field_visible_make: Boolean;
        justcheck: Boolean;
        FieldEditable: Boolean;
}

