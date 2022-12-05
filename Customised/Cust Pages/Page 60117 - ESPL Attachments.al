page 60117 "ESPL Attachments"
{
    // version B2B1.0,Rev01

    DataCaptionFields = "Document Type", "Document No.";
    PageType = Worksheet;
    SourceTable = Attachments;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    NotBlank = false;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec.Description := UPPERCASE(Rec.Description);
                    end;
                }
                field("Attachment Status"; Rec."Attachment Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
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
            group("&Attachment")
            {
                Caption = '&Attachment';
                Image = Attachments;
                action(Open)
                {
                    // Caption = 'Open';//EFFUPG1.6
                    Caption = 'Export';//EFFUPG1.6
                    Ellipsis = true;
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        Attachment: Record Attachments;
                    begin
                        Rec.TESTFIELD(Description);

                        IF Rec."No." = 0 THEN
                            EXIT;
                        Attachment.GET(Rec."No.", Rec."Table ID", Rec."Document Type", Rec."Document No.");
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
                    var
                        WordManagement: Codeunit WordManagementESPL;
                        NewAttachmentNo: Integer;
                    begin
                        Rec.ModifiyDocument;
                        NewAttachmentNo := WordManagement.CreateWordAttachment(Rec."Document No." + ' ' + FORMAT(Rec."Document Type"));
                        IF NewAttachmentNo = 0 THEN BEGIN
                            ERROR(Text000);
                        END;
                        //Rev1 chaitanyha commented old Code
                        /*
                        TESTFIELD(Description);
                        CreateAttachment;
                        *///Rev1 chaitanyha commented old Code

                    end;
                }
                action(Import)
                {

                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        FileName: Text[260];
                        AttachVoith: Record Attachments;
                    begin
                        Rec.ModifiyDocument;
                        IF ((Rec."Table ID" = 33000929) AND (Rec."Attachment Status" = TRUE) AND (Rec."Document No." <> '')) THEN
                            ERROR('You can not upload the file in posted data')
                        //added by vishnu Priya on 27-09-2019
                        ELSE
                            IF Rec."Table ID" = 36 THEN BEGIN
                                SH.RESET;
                                SH.SETFILTER("No.", Rec."Document No.");
                                IF SH.FINDFIRST THEN BEGIN
                                    IF SH."Order Verified" = TRUE THEN
                                        ERROR('You can''t change the attachment as the order was verified')
                                    ELSE BEGIN
                                        Rec.TESTFIELD(Description);
                                        Rec.ImportAttachment(FileName, FALSE, FALSE); //Rev01
                                    END;
                                END
                            END
                            //end by Vishnu Priya on 27-09-2019
                            ELSE BEGIN
                                Rec.TESTFIELD(Description);
                                Rec.ImportAttachment(FileName, FALSE, FALSE); //Rev01
                            END;

                        /*
                        //added by vishnu Priya on 27-09-2019
                        IF Rec."Table ID"=36 THEN
                          BEGIN
                            SH.RESET;
                            SH.SETFILTER("No.",Rec."Document No.");
                            IF SH.FINDFIRST THEN
                              BEGIN
                                IF SH."Verification Status" = 1 THEN
                                    ERROR('You can''t change the attachment as the order was verified');
                              END
                          END;
                        
                        //end by Vishnu Priya on 27-09-2019
                        */

                    end;
                }
                action(Export)
                {
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false;//EFFUPG1.6

                    trigger OnAction();
                    var
                        FileName: Text[1024];
                    begin
                        Rec.TESTFIELD(Description);
                        Rec.ModifiyDocument;
                        Rec.ExportAttachment(FileName);//Rev01
                    end;
                }
                action(Remove)
                {
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    begin
                        Rec.ModifiyDocument;
                        IF ((Rec."Table ID" = 33000929) AND (Rec."Attachment Status" = TRUE) AND (Rec."Document No." <> '')) THEN
                            ERROR('You can not remove the file in posted data')
                        ELSE BEGIN
                            Rec.RemoveAttachment(TRUE);
                        END;
                    end;
                }
            }
        }
    }

    var
        CustAttachments: Record Attachments;
        AttachNo: Integer;
        Text000: TextConst ENU = 'You have canceled the create process.', ENN = 'You have canceled the create process.';
        Text001: TextConst ENU = 'Replace existing attachment?', ENN = 'Replace existing attachment?';
        SH: Record "Sales Header";
}

