page 60118 "ESPL Attachments Archive"
{
    // version B2B1.0,Rev01

    DataCaptionFields = "Document Type", "Document No.";
    Editable = false;
    PageType = List;
    SourceTable = "Attachments Archive";

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
                        AttachmentArchive: Record "Attachments Archive";
                    begin
                        Rec.TESTFIELD(Description);
                        IF Rec."No." = 0 THEN
                            EXIT;
                        AttachmentArchive.GET(Rec."No.", Rec."Table ID", Rec."Document Type", Rec."Document No.", Rec."Document Line No.", Rec."Document Version No.");
                        AttachmentArchive.OpenAttachment(Rec.Description, FALSE);
                    end;
                }
                action("E&xport")
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.TESTFIELD(Description);
                        //Rec.ExportAttachment(''); //Same issue in NAV 2016 itself
                    end;
                }
            }
        }
    }

    var
        CustAttachments: Record Attachments;
        AttachNo: Integer;
}

