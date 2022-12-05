page 33000273 "Vendor Item Quality Approval"
{
    // version QC1.0,Rev01

    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Vendor Item Quality Approval";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Spec Id"; Rec."Spec Id")
                {
                    ApplicationArea = All;
                }
                field("Ending Date"; Rec."Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Certified Agency"; Rec."Certified Agency")
                {
                    ApplicationArea = All;
                }
                field("Attachment.HASVALUE"; Attachment.HASVALUE)
                {
                    AssistEdit = true;
                    Caption = 'Attachment';
                    ApplicationArea = All;

                    trigger OnAssistEdit();
                    begin
                        IF Attachment.HASVALUE THEN BEGIN
                            QualityAttachmentMgt.SetVendorItemApproval(Rec);
                            QualityAttachmentMgt.OpenAttachment;
                        END;
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
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        QualityAttachmentMgt.SetVendorItemApproval(Rec);
                        QualityAttachmentMgt.OpenAttachment;
                    end;
                }
                action(Import)
                {
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        QualityAttachmentMgt.SetVendorItemApproval(Rec);
                        QualityAttachmentMgt.ImportAttchment;
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
                        QualityAttachmentMgt.SetVendorItemApproval(Rec);
                        QualityAttachmentMgt.ExportAttachment('');
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Image = Delete;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        QualityAttachmentMgt.SetVendorItemApproval(Rec);
                        QualityAttachmentMgt.RemoveAttachment(TRUE);
                        CurrPage.SAVERECORD;
                        //Instead of above statement we can use modify. Both are working in the same wauy;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF Rec."Item No." <> '' THEN
            Rec.CALCFIELDS(Attachment);
    end;

    var
        QualityAttachmentMgt: Codeunit QualityAttachmentManagement;
}

