page 33000251 Characteristics
{
    // version QC1.0,Rev01

    PageType = Worksheet;
    SourceTable = Characteristic;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Qualitative; Rec.Qualitative)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure Code"; Rec."Unit Of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Attachment60098.HASVALUE"; Attachment60098.HASVALUE)
                {
                    AssistEdit = true;
                    Caption = 'Attachment';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Attachment60098.HASVALUE THEN
                            Rec.OpenAttachment;
                    end;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Attachment")
            {
                Caption = '&Attachment';
                Image = Attach;
                action(Open)
                {
                    Caption = 'Open';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.OpenAttachment;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ImportAttchment;
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ExportAttachment('');
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RemoveAttachment(TRUE);
                        CurrPage.SAVERECORD;
                        //Instead of above statement we can use modify. Both are working in the same wauy;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF Rec.Code <> '' THEN
            Rec.CALCFIELDS(Attachment60098);
    end;
}

