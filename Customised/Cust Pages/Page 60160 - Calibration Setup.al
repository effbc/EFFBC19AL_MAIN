page 60160 "Calibration Setup"
{
    // version Cal1.0,Rev01

    PageType = Worksheet;
    SourceTable = "Calibration Setup";

    layout
    {
        area(content)
        {
            repeater(Control1102152000)
            {
                ShowCaption = false;
                field("Equipment No."; Rec."Equipment No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Procedure No."; Rec."Procedure No.")
                {
                    ApplicationArea = All;
                }
                field("Procedure Description"; Rec."Procedure Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("C&alProc")
            {
                Caption = 'C&alProc';
                Visible = false;
                action(Card)
                {
                    Caption = 'Card';
                    Image = Card;
                    ShortCutKey = 'Shift+F5';
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        CLEAR(CalPro);
                        IF CalProHeader.GET(CalProHeader."No.") THEN BEGIN
                            IF Rec."Procedure No." <> '' THEN BEGIN
                                CalPro.SETRECORD(CalProHeader);
                            END;
                        END;
                        CalPro.RUN;
                    end;
                }
            }
        }
    }

    var
        CalProHeader: Record "Calibration Procedure Header";
        CalPro: Page "Calibration Procedure";
}

