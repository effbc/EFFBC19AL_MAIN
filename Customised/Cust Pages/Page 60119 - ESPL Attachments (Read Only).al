page 60119 "ESPL Attachments (Read Only)"
{
    // version B2B1.0,Rev01

    DataCaptionFields = "Document Type", "Document No.";
    Editable = false;
    PageType = List;
    SourceTable = Attachments;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field(Description; Rec.Description)
                {
                    NotBlank = false;
                    ApplicationArea = All;
                }
                field("Attachment Status"; Rec."Attachment Status")
                {
                    Editable = false;
                    ApplicationArea = All;
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
                action(Open)
                {
                    Caption = 'Open';
                    Image = Open;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Attachment: Record Attachments;
                    begin
                        Rec.TESTFIELD(Description);
                        IF Rec."No." = 0 THEN
                            EXIT;
                        Attachment.GET(Rec."No.", Rec."Table ID", Rec."Document Type", Rec."Document No.", Rec."Document Line No.");
                        Attachment.OpenAttachment(Rec.Description, FALSE);
                    end;
                }
                action(Create)
                {
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = CreateForm;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TESTFIELD(Description);
                        Rec.CreateAttachment;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        FileName: Text[260];
                        AttachVoith: Record Attachments;
                    begin
                        Rec.TESTFIELD(Description);
                        AttachVoith.ImportAttachment(FileName, FALSE, TRUE);//EFFUPG Deleted Rec
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        FileName: Text[260];
                    begin
                        Rec.TESTFIELD(Description);
                        Rec.ExportAttachment(FileName);//EFFUPG Added FileName
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveLine;
                    Visible = false;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.RemoveAttachment(TRUE);
                    end;
                }
            }
        }
    }

    var
        CustAttachments: Record Attachments;
        AttachNo: Integer;
}

